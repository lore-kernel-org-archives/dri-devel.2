Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A3C60A6F72
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 22:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=f+DuzUMa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 231D010EAA6;
	Wed, 11 Nov 2026 22:34:51 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012001.outbound.protection.outlook.com [52.101.48.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E4C610EA82
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 22:34:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t3DP21hilawew5+tYjY+HRrFZflsgOoxJ9bbGux686JsSD6BIPkEOSGqDmrxJLIoE6OA6EwUyV/IcRhDM6ELXg/uxhO0J7Xfoqyf6KSuniSXfDxYvdk6VHZol0rAnQgjhzALJ6/0irZ+XI9cPp+AIKouz5HyYxBzwKTe+LswyopN/v+tEutdm8eqyZtvfpZKxTFyxFz6smqbzVQZEbQOXLRWzOg30aMHhoc7ckBBwLOv4L4SzLYQxcom93UVjcMELnyY4BkNjStXOXcxwAvIrsYf/moudo3JGTIuZATYk+dJWR6gxplNndEC2S085pkei5V0csjNMeIO//joz5KxQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOPmhk1Tgli8VpI1ixsAvFzFWFsD8+53GLvFcudWzcM=;
 b=P8VTjdOj4yL4vyUGQx749glxn9ounJxZsCalWc73ON4jxAVw6WuVRvBvzPTuSf7PxERG8URmWt4BvMmrzAp5GyCUDGzTX6LTtlsyAgnwdvYc1DaCoUDe/bTGaR5MQk1Zo6auKH4fDVFKPjHM+BNFz8EoucXViWSSWrhF1elwau1h56fVk+1EQmemwKqktTGPwHG51yC5bxTOLF0gJagmzkt4D3mon0uIdc+f+APbA8AxqoX4l+PkzEbk32yfCoYAS6LeW+cA5/4VSuxfxYIezy+vepbQ1+NfLXep7Q/xspI7bMpfHKNFLIQOp6+jA+il1AlgQ4lJ0Jyg44FR2XFxhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOPmhk1Tgli8VpI1ixsAvFzFWFsD8+53GLvFcudWzcM=;
 b=f+DuzUMaAxNRFGwSbP/N6ascn6x0Wy6lGhY9u3+9tr+06Vw9QqE0dSP7zKZg9wJxu9z+FagswrV2krCVDhNElnwjo392BHYGh93xZ/KxTwOE7313RUbvguPfiv8POIxhTznekLnJ0tHtOtBlR41r4wBF90uuPBi6fTjCe+0XDGhTy90bWWmFP/dYwjZH1rz1JP64770sDK11lqsFpV3DXtvIdyQphlD7ZdPwI698/TDL9C+UT7pBL8JEK3DwKHTNqGzVnARslK/Y2Q6uaZjjRzrzB1nl4FddO8uvSU00L1YZs5MytmBB3SckAF6uYhKiquSJVj/nm+OaJVfMbSQG0Q==
Received: from PH7PR17CA0011.namprd17.prod.outlook.com (2603:10b6:510:324::20)
 by CH4PR12MB489481.namprd12.prod.outlook.com (2603:10b6:610:509::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 22:34:33 +0000
Received: from BY1PEPF0001AE17.namprd04.prod.outlook.com
 (2603:10b6:510:324:cafe::7a) by PH7PR17CA0011.outlook.office365.com
 (2603:10b6:510:324::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 22:34:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF0001AE17.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 22:34:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 11 Nov
 2026 14:34:19 -0800
Received: from xinmengs-dev-vm-linux.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 14:34:16 -0800
From: Simon Song <xinmengs@nvidia.com>
To: <dakr@kernel.org>, <acourbot@nvidia.com>, <kvm@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <linux-pci@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@nvidia.com>, <yishaih@nvidia.com>,
 <skolothumtho@nvidia.com>, <kevin.tian@intel.com>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <markus.probst@posteo.de>, <jhubbard@nvidia.com>,
 <apopple@nvidia.com>, <joelagnelf@nvidia.com>, <ecourtney@nvidia.com>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <kjaju@nvidia.com>,
 <alkumar@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>,
 <boqun@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
 <work@onurozkan.dev>, <jgg@ziepe.ca>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <peter@colberg.org>, <xinmengs@nvidia.com>
Subject: [PATCH v6 08/11] rust: pci: add SR-IOV enable and disable tokens
Date: Wed, 11 Nov 2026 14:33:33 -0800
Message-ID: <20261111223337.508989-9-xinmengs@nvidia.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261111223337.508989-1-xinmengs@nvidia.com>
References: <20261111223337.508989-1-xinmengs@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE17:EE_|CH4PR12MB489481:EE_
X-MS-Office365-Filtering-Correlation-Id: 23c7355b-1989-4672-db41-08df4043f4f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|1800799024|82310400026|36860700016|10067099003|11063799006|56012099006|261022113327099003|261022105027099003|261022075727099003|261021121427099003|261026121527099003|261021123027099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: CKPWScZP5Aag3HFGg+O117/R9mmo1Kd3N2UrDaBCNa8Jy3Xmjqp9P24YeFAzKKU3t6yoaXc14jIstdhwicN+mjyth0/2cT8rF+KjurocBUXW/WqJ6Ix7TTlHec8m3T6L9ZYv8bfbgWcLnTtB36SyPkmf6HQyrVeWXXu90DOq7w2YMvwtM/jyQwhxBKgAJxd7FObT3VEgaCHxtmyJA1yggL2ZFRBSc35BDUlm6Nl3NqYErqpBsO/yzlzbZHDafPC0i5H8jqSSZDBRwMgH33S/Bm+X7pImYiLwaCHwY/GpLtpmIyZ87S+wtHvzCTAZkrDMeGaGLE9n98+kC/nCB4Henjwt/H+0Xmd+2pHRgOib4Ka2QaDVoH+UjG1vtKzUWe2PjKZxmE3WQmUkwzKhiTLPRoEDt3paOtURoChC3H1GFSgq+lg/HC4NVnpqTqZdHILo2J+VHu7nBFvwOw+0OzeylFbMDh+AsdA6yhFRaIZfY5yUr01mSauTt5zqURLn6Gn/ZHI6hNEFJHkSih+VlZwmcf16SN0QXhOBt9CEtNGHVrl3n5jai7RnQ/HVThvrIQ46C9GQq3vP0xeat2onZ49tmAguR8N4fy33NLaWzHYjgABHhT6dnl0CIX6y3IScYeF3QEJiuZPEr6Ctfb6LpkhE1891gekcNYYMmjGq9/d9OJIE0309ZZwRgmV7hirUkofkDDFVn4fLUGWWnAOVHNH9Lg==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(82310400026)(36860700016)(10067099003)(11063799006)(56012099006)(261022113327099003)(261022105027099003)(261022075727099003)(261021121427099003)(261026121527099003)(261021123027099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mN9TSq30namst30dVPv/pm435S+IB3hN62weU8oV33E0el2Bq5hjR0k5oZw66GF43Fcuz2YCqxQTXe+HAjiLaoDvnGhAKnN0aa+849pXITx7UzvqkN1uK/Ey8Eg/0ZB3FLioERu0aB/4Mm6mcWQD4DClpJZ2qxslRVgCiMIHlf18rp/isXlRUIosLYcRhixi3Hu5Ktsfi/jxn8FNaC7FivF9CVywQiiUlxNbrfeRHX1twctcb8R9tOqor8PNnLAb4H6xyQqPwEFhOkLpYn8pYJVpxDnLMUg+pPZA5sVQ+YnQDtE8raw3+6vqeVMjDBYZc3WrMwqCaT+dhkJjVNPru2x4cvFBznlU4B6ni4SIMl31hB33nLDoLEeMPpXITuKotDOnIknldT5Q2Ez3OQaeVbkj1CdkYY7yhDLyzPMVlwKAkQBpEf3+Oz3yNzLZz4Wm
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 22:34:32.6324 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c7355b-1989-4672-db41-08df4043f4f6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE17.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR12MB489481
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Zhi Wang <zhiw@nvidia.com>

Enabling VFs can succeed before the driver's remaining setup fails.
Use a callback-scoped token to return an enabled guard that disables
SR-IOV when dropped, rolling back those VFs on a later error.

Add SriovEnable, SriovEnabled and SriovDisable for the split callbacks
introduced later in this series. Tie each token to its PF and callback
lifetime, and limit the enabled count to the user's request. The PCI
adapter disarms the guard when accepting a successful enable callback.

Require a VfRegistration to own final VF teardown after that handoff.
Drivers that do not share data with VFs can register (). A disable
token permits explicit shutdown without forcing it on a rejected
request.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Simon Song <xinmengs@nvidia.com>
---
 rust/kernel/pci.rs     |   7 ++-
 rust/kernel/pci/iov.rs | 102 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 105 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 033c49363d1e..077fa80e7425 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -59,7 +59,12 @@
     Extended,
     Normal, //
 };
-pub use self::iov::VfRegistration;
+pub use self::iov::{
+    SriovDisable,
+    SriovEnable,
+    SriovEnabled,
+    VfRegistration, //
+};
 pub use self::irq::{
     IrqType,
     IrqTypes,
diff --git a/rust/kernel/pci/iov.rs b/rust/kernel/pci/iov.rs
index 3f4414aa7d36..bda2bffffcda 100644
--- a/rust/kernel/pci/iov.rs
+++ b/rust/kernel/pci/iov.rs
@@ -16,7 +16,9 @@
 };
 use core::{
     any::TypeId,
-    marker::PhantomPinned, //
+    marker::PhantomPinned,
+    mem::ManuallyDrop,
+    num::NonZero, //
 };
 
 /// Returns the PF's registration pointer, or null when `CONFIG_PCI_IOV` is disabled.
@@ -71,7 +73,6 @@ impl Device<device::CoreInternal<'_>> {
     /// Enable the Single Root I/O Virtualization (SR-IOV) capability for this device,
     /// where `nr_virtfn` is number of Virtual Functions (VF) to enable.
     #[inline]
-    #[expect(dead_code)]
     pub(crate) fn enable_sriov(&self, nr_virtfn: u16) -> Result {
         // SAFETY:
         // - `self.as_raw` returns a valid pointer to a `struct pci_dev`.
@@ -88,7 +89,6 @@ pub(crate) fn enable_sriov(&self, nr_virtfn: u16) -> Result {
 
     /// Disable the Single Root I/O Virtualization (SR-IOV) capability for this device.
     #[inline]
-    #[expect(dead_code)]
     pub(crate) fn disable_sriov(&self) {
         // SAFETY:
         // - `self.as_raw` returns a valid pointer to a `struct pci_dev`.
@@ -103,6 +103,102 @@ pub(crate) fn disable_sriov(&self) {
     }
 }
 
+/// Permission to enable VFs during a driver's `sriov_enable()` callback.
+///
+/// The PCI adapter creates this token for the PF being configured. It cannot be cloned or sent
+/// to another thread, and its lifetime is restricted to the callback. Enabling VFs consumes it.
+///
+/// The callback lifetime cannot be extended:
+///
+/// ```ignore,compile_fail
+/// use kernel::pci::SriovEnable;
+///
+/// fn escape(token: SriovEnable<'_>) -> SriovEnable<'static> {
+///     token
+/// }
+/// ```
+pub struct SriovEnable<'a> {
+    pdev: &'a Device<device::CoreInternal<'a>>,
+    num_vfs: NonZero<u16>,
+}
+
+impl<'a> SriovEnable<'a> {
+    /// Returns the number of VFs requested for this callback.
+    #[inline]
+    pub fn num_vfs(&self) -> NonZero<u16> {
+        self.num_vfs
+    }
+
+    /// Enables between one and the requested number of VFs.
+    ///
+    /// VF drivers can probe before this method returns, so the PF resources they access must
+    /// already be initialized. The returned guard disables the VFs if subsequent setup fails.
+    /// Return it from `sriov_enable()` to leave the VFs enabled on callback success.
+    ///
+    /// # Errors
+    ///
+    /// - [`EINVAL`]: `num_vfs` is greater than [`Self::num_vfs()`].
+    /// - [`ENODEV`]: the PF driver has not registered a [`VfRegistration`].
+    /// - Any error returned by `pci_enable_sriov()`.
+    pub fn enable(self, num_vfs: NonZero<u16>) -> Result<SriovEnabled<'a>> {
+        if num_vfs > self.num_vfs {
+            return Err(EINVAL);
+        }
+        let num_vfs = num_vfs.get();
+
+        // SAFETY: The PF's driver data and registration remain installed throughout this callback.
+        // The registration owns final VF teardown after the enable guard is disarmed.
+        if unsafe { vf_registration_data_ptr(self.pdev.as_raw()) }.is_null() {
+            return Err(ENODEV);
+        }
+
+        self.pdev.enable_sriov(num_vfs)?;
+        Ok(SriovEnabled {
+            pdev: self.pdev,
+            num_vfs,
+        })
+    }
+}
+
+/// Enabled VFs awaiting successful completion of `sriov_enable()`.
+pub struct SriovEnabled<'a> {
+    pdev: &'a Device<device::CoreInternal<'a>>,
+    num_vfs: u16,
+}
+
+impl SriovEnabled<'_> {
+    #[inline]
+    #[expect(dead_code)]
+    fn disarm(self) -> u16 {
+        ManuallyDrop::new(self).num_vfs
+    }
+}
+
+impl Drop for SriovEnabled<'_> {
+    fn drop(&mut self) {
+        self.pdev.disable_sriov();
+    }
+}
+
+/// Permission to disable VFs during a driver's `sriov_disable()` callback.
+///
+/// The PCI adapter creates this token for the PF being configured. It cannot be cloned or sent
+/// to another thread, and its lifetime is restricted to the callback. Dropping the token does
+/// not disable VFs, allowing the callback to reject a disable request.
+pub struct SriovDisable<'a> {
+    pdev: &'a Device<device::CoreInternal<'a>>,
+}
+
+impl SriovDisable<'_> {
+    /// Disables all VFs and waits for their drivers to unbind.
+    ///
+    /// The PF resources used by VF drivers must remain available until this method returns.
+    #[inline]
+    pub fn disable(self) {
+        self.pdev.disable_sriov();
+    }
+}
+
 /// Wrapper for VF registration data stored inside a [`VfRegistration`].
 ///
 /// Stores a [`TypeId`] header (derived from `F`) followed by the pinned data,
-- 
2.43.7

