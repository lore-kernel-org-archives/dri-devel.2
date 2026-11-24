Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61BD606A69D
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 14:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=BwDiQ3RH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19F4A10F5FD;
	Tue, 24 Nov 2026 14:03:41 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010071.outbound.protection.outlook.com
 [52.101.193.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B09BF10F5FD
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 14:03:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UMDi8S8ljuOH3tiTVT3I9EJi7SrHTA0o3KNwlpVlF2/14a+pdhC6DiFylWBZjqH1bPpEeh+WXMbRHSyoShk4lg+KDRrdbqejVe8dfg2W62WZUgHEv8tP22CazMvP1TENeZbEa9Y+mu5sfXJIkavxnFcEmIBrxkajCdsAxTyfSAxsABXElVNEzYrJRlRrXEyV/n4GRHv1E4Yyt7UdBpKbGoBaSiYkiEBgekhSvtjAW6twR4WOwkHP0JxaGUVhW3DG8uqWeLiJzr8cNDnmOFn+wCO3jfMTO154zDd5GeC/zroDNmae1xqKYxHu/p7728SSLSkEiuOgdpzxxBRYXxE9Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCFqY7w4b8qdX+ZlcF7pQ7dRjlQihAAdLPLQhXChz/A=;
 b=RC5C1QyVTCIFIJd18V2AuokFgO2RpcIIxGulwQOj6TkX5BymNrRtkWMKDLgxM8CQHdBSKBNusXfj/b+ZkrEAzFCLO4qv+NPjiDfsvG7382EnAA0UxTufIAQ7K6fI9/f3KrvxGcm9+Qe0tNH1Mf3ZD1Lhk7dMbTXN2pnnhmvqD52zXUW5hSjr+2VU6ElJrXUcmd9r2BinVkafZwXcY7ardxSWX+fM90s3514izLLtlTJorPCnCq3wgq7T8GU9xWJksahvlOkVF2T65gVcfacNi+VbWFv+p8IZDtwTHQg1tISD8jG/FFbCvD16VnXtoDXi0j6lywouhz+VLJqorgNakQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCFqY7w4b8qdX+ZlcF7pQ7dRjlQihAAdLPLQhXChz/A=;
 b=BwDiQ3RHKyB6Ul2XiZDy1Lz9dHQheKrlv0zZIs+RlwrCzEYS2DTOQgtVPj1GaU4t1t9kp6gOXZF8NmFZecgscVyJnI6AHLtvjfh7K/0BuKVE9Zu7d9XGK9UnNZVNr3D94b3jmFMm7rWxupnjqPUFAZ0dIP2Pd8LL50gpvLE29McBAHZmb2+rgs92PH5S8MSWK2IReJkZkXkk8fnyAp69M1+9qlmFwJ9kyQbJ7SOxyTBE/GYv8Ip2+0ZcIqz3GTWbNY93Yd4UpKjPeDtRCufPR0gXEivmFUwuXWTZOAxTrb1ULpEV2UL2ETpl8ftVC6F1S+LMYUg+T2LCMRPOlnTsSg==
Received: from BL1PR13CA0005.namprd13.prod.outlook.com (2603:10b6:208:256::10)
 by MW4PR12MB7440.namprd12.prod.outlook.com (2603:10b6:303:223::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 14:03:05 +0000
Received: from LV8PEPF00000066.namprd03.prod.outlook.com
 (2603:10b6:208:256:cafe::4b) by BL1PR13CA0005.outlook.office365.com
 (2603:10b6:208:256::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.5 via Frontend Transport; Tue, 24
 Nov 2026 14:03:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 LV8PEPF00000066.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 14:03:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 06:02:34 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 06:02:21 -0800
From: Alok Kumar <alkumar@nvidia.com>
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
Subject: [PATCH v5 11/35] gpu: nova-core: mm: borrow BarUser for temporary
 BAR1 access
Date: Tue, 24 Nov 2026 19:29:07 +0530
Message-ID: <20261124135937.18583-12-alkumar@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124135937.18583-1-alkumar@nvidia.com>
References: <20261124135937.18583-1-alkumar@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF00000066:EE_|MW4PR12MB7440:EE_
X-MS-Office365-Filtering-Correlation-Id: 022362a8-7f00-4e93-86e0-08df4a33a89b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|36860700016|82310400026|261028144727099003|10067099003|11063799006|56012099006|261021121427099003|261021123027099003|261022105027099003|261009223027099003|261026140227099003|261026121527099003|261102123227099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: RZHK2Elec1K4EPmts+6QhqtywmG7hcmP/7ktV+dv0pCbhOJdwSeiNugmuvHrE0aEbBhX6ytEfX/nzczF+C7s9UEgGkEZrQt1xlR//O9CeICaJnPAFuQSxHincrjxC8GnBrMwl2M6Lk2FKMDXGdVAeL90lvsJqpsdCpdw/Vnqpe+Q08ZPgNB4iwP/s+BB6p7fUvQyMX4u5QT19Rl7ZSSSYJZYOuvlVX9EZ8dGBXp83osFenKprEg1zexEhRovhxuLRYtxt23JJH+wGVnehdJ1NJkY1oge82i/dpkKeQO04KCXyQQw0ZT3UzYoSgrgHfqbb/AfSP6GsW8v1oXCWfMaH4Gc5RBt6ZMydSxWSDx1CyB1MoXqxhl2Gkje5F91WIkz2HCLDbjtj46e6IHvYtPbmpZAIXA7+vZCieewym8CYq50b6IbyBOvBqc0f+FfPbalEGRPFlik57ae5qq/+nEYRGhpPvQJBvjunZfPZ0C3JY1y4xDBcERhNblGTtfoLq0yKkfOm2194UoxjPh3DupibByncLbRH4cFqUnxeMc+52Zr1ZG6AH8LitrmwyZtLA8nYJC99QpGTKDQWWVBkfNO+OQ/mLV53aQTGcDr3qAxjNSK8K++/BOhq0hvcQFHHiHXnKngCGWNmJ3UKlOwaJRWWzCuQSlvFNi16CTwrEHVy2D3Gki/Gfq9BGKQyTvPKJL1sfUOnAtF0zkNUbXLpCNo6A==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(36860700016)(82310400026)(261028144727099003)(10067099003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261022105027099003)(261009223027099003)(261026140227099003)(261026121527099003)(261102123227099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Oh2260XsMx/LUOYNczFF7oiElpm22DY+mcfV5eexqXBZxSngIbDyeatZVEBazT3dKiInVaBhR7cBVuLnMxCiaCbGEhbSZGV2AS4Y6iM62oGrLswQPx7K4WMPxXpQNyZkpPZdmnKUth7asEGUOMnwrqrpkvHG5yyh1F0sNjAP40MjYClBg5/edJ099sq0hdrGvzoITblEPAHn8NNzRBvqtDPTfOzcK91GKJQTZLtQcncvBiBkt7vmopXjteXdCHXqHY6VnUdnqZ0H1WdvSpVER0qQu0/UvF80FBLb9bkvf8F3ogKby6ht6MYgA+bOQxPkneM7TNBawyurd4YSasS3jX/0wL27KLROOyXvujjU5HxG0qadWseuEjUY1crQt8B46Fad2djVn/Lst9YcEhHZCkTcFYghuhSosNWxJiVcA3gZbUvlnMwebzog6TG7Wq81
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 14:03:04.1047 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 022362a8-7f00-4e93-86e0-08df4a33a89b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF00000066.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7440
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

Temporary BAR1 access needs a borrow of the GPU-owned BarUser. Store
BarUser inline in Gpu and borrow it in BarUserAccess, avoiding a separate
allocation and reference counting for these accesses. Update the existing
self-test entry points to accept the borrowed interface.

No functional change is intended.

Cc: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs         |  2 +-
 drivers/gpu/nova-core/mm/bar_user.rs | 16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index cf7173b72a13..03d0411008c9 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -656,7 +656,7 @@ pub(crate) fn run_selftests(self: Pin<&mut Self>, pdev: &pci::Device<device::Bou
             dev,
             this.mm,
             &info.usable_fb_regions,
-            &this.bar_user,
+            this.bar_user.as_ref().get_ref(),
             info.bar1_pde_base,
             this.spec.chipset,
         ) {
diff --git a/drivers/gpu/nova-core/mm/bar_user.rs b/drivers/gpu/nova-core/mm/bar_user.rs
index 5a8770782d14..ff1d0e443281 100644
--- a/drivers/gpu/nova-core/mm/bar_user.rs
+++ b/drivers/gpu/nova-core/mm/bar_user.rs
@@ -63,12 +63,12 @@ pub(crate) fn new(
     }
 
     /// Map physical pages to a contiguous BAR1 virtual range.
-    pub(crate) fn map(
-        &self,
+    pub(crate) fn map<'access>(
+        &'access self,
         mm: &mut GpuMm<'_>,
         pfns: &[Pfn],
         writable: bool,
-    ) -> Result<BarUserAccess<'_>> {
+    ) -> Result<BarUserAccess<'access, 'a>> {
         if pfns.is_empty() {
             return Err(EINVAL);
         }
@@ -85,14 +85,14 @@ pub(crate) fn map(
 /// Access object for a mapped BAR1 region.
 ///
 /// Borrows the [`BarUser`] managing the mapping for the lifetime of the access object.
-pub(crate) struct BarUserAccess<'a> {
-    bar_user: &'a BarUser<'a>,
+pub(crate) struct BarUserAccess<'access, 'gpu> {
+    bar_user: &'access BarUser<'gpu>,
     /// Cleared only after PTE invalidation and its TLB flush succeed.
     mapped: Option<MappedRange>,
 }
 
 #[expect(dead_code)]
-impl BarUserAccess<'_> {
+impl BarUserAccess<'_, '_> {
     /// Tear down the BAR1 mapping.
     pub(crate) fn release(mut self, mm: &mut GpuMm<'_>) -> Result {
         self.unmap(mm)
@@ -159,7 +159,7 @@ pub(crate) fn view<T>(&self, offset: usize) -> Result<Mmio<'_, T>> {
     }
 }
 
-impl Drop for BarUserAccess<'_> {
+impl Drop for BarUserAccess<'_, '_> {
     fn drop(&mut self) {
         if self.mapped.is_some() {
             kernel::pr_warn!(
@@ -177,7 +177,7 @@ fn drop(&mut self) {
 /// address space. Uses the `GpuMm`'s buddy allocator to allocate page tables
 /// and test pages as needed.
 #[cfg(CONFIG_NOVA_CORE_SELFTESTS)]
-pub(crate) fn run_self_test(
+pub(super) fn run_self_test(
     dev: &device::Device<device::Bound>,
     mm: &mut GpuMm<'_>,
     bar_user: &BarUser<'_>,
-- 
2.53.0

