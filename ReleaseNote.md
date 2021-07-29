# JXBanner release notes

## 0.3.4
* **日期**：2020-07-01
* **tag**: 0.3.4
* **commit**:  `f294d0ae68d7c`
* **主要更新**：
    * 修复：在系统版本低的设备上会触发闪退的情况。（断点分析为collectionView未刷新完成，调用scrollToItem导致。）

## 0.3.5
* **日期**：2020-07-29
* **tag**: 0.3.5
* **commit**:  `2fbe2b7d1a5bdc4c6`
* **主要更新**：
    * 修复：使用performBatchUpdates获取刷新结束方式出现崩溃。
