Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E773CD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 18:04:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ED9010E0C4;
	Mon, 18 May 2026 18:04:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="nWK59l55";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012048.outbound.protection.outlook.com [40.107.209.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51E2410E8EC
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 18:04:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PNAUw/l/nw3wZcDij3L6V1ja0Q0HrkoJg96PYmFLOfVNYvEBJqRAbXdWHgMIxm/Skc471ZnZ/MKIaHz2eIl5WJ8hDNeRIdE5hMEwecOMEwDRbRr79c518Vd+IqEladhbeO4iFGSjpXwNWs8+9Fmi4+NaU7sHdyR3y04+Y/QAN4crxDhDjxxqKeUj/PlB6FvOOjtEHZliXPFLyhb5JgdmTjIkbRqgcaasETSRxGn41fD98+VGWYv2uAQ8nBRqrYOUsbF1Hf6IgcKrTsgh16boKY6YW+RhevybSVFf1EAyxreKuZ3tImbxnUS0/WT7yyyb2GzXkvZpCMHg50/+AsvGXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gqTTSQgAQpJwQtPOZfeAgCUPU1SY3H81VIAoRyqfBw=;
 b=cQdyWn3buihNdAdnfHwprvG/ptLlHceIQJNP6kzscb3lWGosyrvOiH/UD4ttj507vOX+l154GjZLHskms4WUdq+b6jx+n/GFsBjRcUScN9UbL07+UBWfsRHvoHkvIzftovuqR9K0mrDlL9aAQliS6abRuS+3QwxGiwQNkYgIgfQCrhCEVMq9cFcOK2YmrYMST+ecCZQ+muL1n97JWthWmUgBDIMO1HovE00u4qbEGVp27TFXKCmyoZOIb/AU6QeRd+0MiFzjmun4348V6D1skj4k9J7g4HjPd7MaZRRm/uydk8IB9TJIUBY/ZrF9qD9eT+cRPzZHl6rqgokXJuzU9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gqTTSQgAQpJwQtPOZfeAgCUPU1SY3H81VIAoRyqfBw=;
 b=nWK59l55TkTfjQZCITa9GEDpSQINodlohnRPOu5iW7YPsVqU2mOCGo9Fzr/VdYC80po+tx03IjUdAkUbFb4JtUg6DB3HrR3UZ28IAdQRBKAliulnTpC60ElsQumQhnqcegRoZ3x6vZ+rg2P6+AppvHlNoGZPFOkrbmAdlRAYn+s01DHKhDrnckunFuDat8WmBCZ9WNLb9Zr3ipLEllMM/ivsFRL65Z7R1x9kcf0VQFKvDhfXie06Opmzd1noFTcx4l551TtWJHCSoQYYKOJ1oVOdaEorxCQ+Xw5LJdskRz4HhKt1aWbssIXhytcK7fbJ6yXzv0u3gbe7UtEqT9FeWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 PH7PR12MB5620.namprd12.prod.outlook.com (2603:10b6:510:137::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.22; Mon, 18 May 2026 18:04:09 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0025.012; Mon, 18 May 2026
 18:04:09 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Dave Airlie <airlied@redhat.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 nova-gpu@lists.linux.dev, Nikola Djukic <ndjukic@nvidia.com>,
 David Airlie <airlied@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, Edwin Peer <epeer@nvidia.com>,
 Alexandre Courbot <acourbot@nvidia.com>, Andrea Righi <arighi@nvidia.com>,
 Andy Ritger <aritger@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 Balbir Singh <balbirs@nvidia.com>, Philipp Stanner <phasta@kernel.org>,
 alexeyi@nvidia.com, Eliot Courtney <ecourtney@nvidia.com>,
 joel@joelfernandes.org, linux-doc@vger.kernel.org,
 Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH v1 12/12] gpu: nova-core: mm: Add PRAMIN aperture self-tests
Date: Mon, 18 May 2026 14:03:42 -0400
Message-Id: <20260518180342.2387845-13-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518180342.2387845-1-joelagnelf@nvidia.com>
References: <20260518180342.2387845-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:208:52f::30) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|PH7PR12MB5620:EE_
X-MS-Office365-Filtering-Correlation-Id: 2227dd01-134c-4cd5-756d-08deb507dbed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|56012099003|22082099003|18002099003|11063799003|3023799003;
X-Microsoft-Antispam-Message-Info: FwFWCAvbNvVU4zi9cJ7J7H6DhY4iXC6Z+bTXaTBsSM+YZBD2hHD1rHJTVd97drsAaxttCthQC7JxW6ZDJiIvxgQfkHPyJfhjyHuyFTM/ePi1v/gAhPRtCfsKTYsPODN4i67hxXyc8gpqB+bn9/bRMtLoge9miyKLMx2orbMovaXFgAy0oDe7ElAf6QDFXEyxISbGk+EcIR+a48yEbLKhG5XEKeZRmt2BYFCPPqlqwJLWJt8wUuRKxCfKbo3e/aWE3NpcIegzIbdaj543bMbkESNmssAI5TKbkHSlJiciyt3CCpmUGqC8+CPrpnc5+vriDowRQal5401IIN8TZj4Q4EbFErhtjbF+Wmf98SKsc614b3fMz03eg7hPZBtPUneF3EGiCBjV1Tv2GJQfblGwQSVxuScpPfuN0fNWRS/7pwfTRMty0i5Ec1tQX/2KKon9t/jsOcgBA9vWGPH8EZD9sQy7EMFD+KuB17H6Yc4wnWv4kGUCJ+eTRlqb5FDitzVfAelqVxQd2Vze7ys/9Lv2yCqwlFoeYeLAqYjPVPOg/0cj9wS+w1qOWx1PbI+bALHiKo8qRqptGNe24F//OvGg9TNt5S0O2E/XQgYLXXp0HSnGKXblDs3OLZJX28ebdSnNhpQyUy639gTzK3CkN7ofa/tmFInoMGylw9vUokU7iC70N/vNk7LRGZFzeXSEzXRM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(11063799003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7ln9XB56kRlth7q66qgJtQQKX5ce4Z7epretePVoXnLmFSDlUj4xFIZ+dvbk?=
 =?us-ascii?Q?7GkiAPLzPDGRaG42k9u7N2omwr2Y3R7kQQEjr6vFX2Nfgk/6wbe2W/zWbWmZ?=
 =?us-ascii?Q?+2qUrfxlm2YhpEgHBmakgg4WBCagrusEXhc71ft8YgviwN1VqO4U4Ehhg5Mk?=
 =?us-ascii?Q?9D5tMXZskK3Vz81+FSD4PcNOzkWKKTtix27tY3HoxAwGLB+bOGHMGGhUqyDL?=
 =?us-ascii?Q?DF+FqMv8fGsaYrB4lbMTebv2NWI1TqlS6pF6krz2kdST6kBaLNRYYUonPiI/?=
 =?us-ascii?Q?JdBKplzr+7y9KEva22rA7cR9HbH/auYpTGshm+rwHpprPJ7ZUuKyHq9zRF7f?=
 =?us-ascii?Q?MbI4Q5+eLbWkrOQLzyVtie0pwjOg8AT+FJR+fsIOV5rCW0X/9PVctbLDUtYW?=
 =?us-ascii?Q?9qjPoD6r7RobwK9j2McpVm7I2x4LYtt0OIpDamXxB1plLpJ596awDtLoieU6?=
 =?us-ascii?Q?2y1rmH2tiQYU5F1YP9NunlBTqgwQhUB3dTo6/seIm+EPIrh7AgrpVcCYIRfW?=
 =?us-ascii?Q?1ocoqjLeS6Lg6TnibFkPyMEk9rl7IyHF5f20JsDOSburEodmrHSSk1zVALIA?=
 =?us-ascii?Q?vTSJMfRyxxLDwxhRNeC5az+ZJNXCtQSNOPvYvGact7jH3B4Gp79fVkux247W?=
 =?us-ascii?Q?5WI+YBuZkSagH57zA/UfvxIn222gEQw/B1ucbUfitX+Fpb3KoMsHxtNVcFmQ?=
 =?us-ascii?Q?RMJ25G/+KwP85xNvBvWb2J8ubCpNh2JYLtZ+9q6/HgroU5mKCZDr80Do3rKh?=
 =?us-ascii?Q?nCXjP080CYo8+CvTi3TJHicU08Z5C5g8zb3VhJukWIkw4mMSvi4TP5JQyFaV?=
 =?us-ascii?Q?QpAlTnRafijPdKZyW3MSL/2SgpiZV9gF9/6eWBcMt00aKcNLKpPzhVRLG4W4?=
 =?us-ascii?Q?9Igz46tpmfnvNx6u8Ciwm+ZAP0Zdhyza5MeqjR9NRa0SkHOMnAhgBTIYIG0j?=
 =?us-ascii?Q?9WbEdAq9xn3N+2IxdScVNeSYzsIASNB9wra55BVXikAgSzxuLAcmcww3Zo8z?=
 =?us-ascii?Q?ZlZWg7ZJIRS+EhkxLeAl/JZ6U44Id2dx2mNpACe6D+s4bzAzegJSOX7OOXNi?=
 =?us-ascii?Q?MvNrVAdff7eOG8fn27Bvlrz24hnTouIkjhDQFqbLBt/QAufU9oYbJF9ie2wb?=
 =?us-ascii?Q?DXwRnVS/fVTo5HYGR9BfN1go5dG+2ov4r6RC++5GBKYvF7Uy+Owr0CCUu8nY?=
 =?us-ascii?Q?XUKfg8Fd3al3f0MVRJVf1jkNugwPZCOFkIofvDxfOe6fx0BXSz6eMN8Ad7HX?=
 =?us-ascii?Q?lsncc473kGn7rVG56qOeynwH0RyDDTGQJEXo8kOCKN6B/bTg58kq0AdeRPtd?=
 =?us-ascii?Q?Od4PSkZf2A7u/hM4PejgJ8VCee9J/jZ31t1DGiwD4PqmtTBy6DhmbvJriyIW?=
 =?us-ascii?Q?0+kGaxxrmWCwXivJj0ARvjU4HY0aPcoLaYPuVn/A63KsHZmv3+hm6ER9GXAe?=
 =?us-ascii?Q?PXHHVA0hIeJVyqwo5BygJMX58pRB3PN1lsRnbYHLblbTTNglgiGiBgYU6vNS?=
 =?us-ascii?Q?1jL9v+qF93W+PDavYUxNhIVNyPwaPJlrNv3wxGZs81VPyUjJ/IaETDqp/axJ?=
 =?us-ascii?Q?Pfl0b62tnvLa17xxCCQCQCYl8hnbk0nZPGNm+cucltRYAUIqIVfBpsEL6S2K?=
 =?us-ascii?Q?IABNK+8AR22ePh6nI8DPX6AJEttqp0rBgYsagn+s/bkr/fNk4C9HUBGU0ojg?=
 =?us-ascii?Q?2Bfdz2asYhesK0IJPTQ7ClDQKhrb8h0pJ5UQKWZSm7VgAbpxpbTtUaVdyglb?=
 =?us-ascii?Q?l4Z4y12ogQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2227dd01-134c-4cd5-756d-08deb507dbed
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 18:04:09.4231 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IjErPxB0v3X8c3Y3lO3wbGdkJiMtGdbT6ErqEiRzZZM9NQkaOVzkwEZ6Iz22evqmZqbRIgOYriGqkk5evcPhDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5620
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Add self-tests for the PRAMIN aperture mechanism to verify correct
operation during GPU probe. The tests validate various alignment
requirements and corner cases.

The tests are default disabled and behind CONFIG_NOVA_MM_SELFTESTS.
When enabled, tests run after GSP boot during probe.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/Kconfig      |  10 ++
 drivers/gpu/nova-core/driver.rs    |   2 +
 drivers/gpu/nova-core/gpu.rs       |   9 ++
 drivers/gpu/nova-core/mm.rs        |  16 +++
 drivers/gpu/nova-core/mm/pramin.rs | 214 +++++++++++++++++++++++++++++
 5 files changed, 251 insertions(+)

diff --git a/drivers/gpu/nova-core/Kconfig b/drivers/gpu/nova-core/Kconfig
index f918f69e0599..abf10e82647b 100644
--- a/drivers/gpu/nova-core/Kconfig
+++ b/drivers/gpu/nova-core/Kconfig
@@ -15,3 +15,13 @@ config NOVA_CORE
 	  This driver is work in progress and may not be functional.
 
 	  If M is selected, the module will be called nova-core.
+
+config NOVA_MM_SELFTESTS
+	bool "Memory management self-tests"
+	depends on NOVA_CORE
+	help
+	  Enable self-tests for the memory management subsystem. When enabled,
+	  tests are run during GPU probe to verify PRAMIN aperture access,
+	  page table walking, and BAR1 virtual memory mapping functionality.
+
+	  This is a testing option and is default-disabled.
diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 84b0e1703150..77746d6949d7 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -96,6 +96,8 @@ fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<Self, E
 
             Ok(try_pin_init!(Self {
                 gpu <- Gpu::new(pdev, bar.clone(), bar.access(pdev.as_ref())?),
+                // Run optional GPU selftests.
+                _: { gpu.run_selftests(pdev)? },
                 _reg <- auxiliary::Registration::new(
                     pdev.as_ref(),
                     c"nova-drm",
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 38544c38d660..aa047fe91054 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -342,4 +342,13 @@ pub(crate) fn unbind(&self, dev: &device::Device<device::Core>) {
             .inspect(|bar| self.sysmem_flush.unregister(bar))
             .is_err());
     }
+
+    /// Run selftests on the constructed [`Gpu`].
+    pub(crate) fn run_selftests(
+        self: Pin<&mut Self>,
+        pdev: &pci::Device<device::Bound>,
+    ) -> Result {
+        crate::mm::run_mm_selftests(pdev, &self.mm, self.spec.chipset)?;
+        Ok(())
+    }
 }
diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
index 5c1941d20d1b..08d74710f790 100644
--- a/drivers/gpu/nova-core/mm.rs
+++ b/drivers/gpu/nova-core/mm.rs
@@ -40,6 +40,7 @@ macro_rules! impl_pfn_bounded {
     device,
     devres::Devres,
     num::Bounded,
+    pci,
     prelude::*,
     sync::Arc, //
 };
@@ -83,6 +84,21 @@ pub(crate) fn pramin(&self) -> &pramin::Pramin {
     }
 }
 
+/// Run MM subsystem self-tests during probe.
+///
+/// No-op when `CONFIG_NOVA_MM_SELFTESTS` is not enabled.
+#[cfg_attr(not(CONFIG_NOVA_MM_SELFTESTS), allow(unused_variables))]
+pub(crate) fn run_mm_selftests(
+    pdev: &pci::Device<device::Bound>,
+    mm: &Arc<GpuMm>,
+    chipset: Chipset,
+) -> Result {
+    #[cfg(CONFIG_NOVA_MM_SELFTESTS)]
+    pramin::run_self_test(pdev.as_ref(), mm.pramin(), chipset)?;
+
+    Ok(())
+}
+
 bitfield! {
     /// Physical VRAM address in GPU video memory.
     pub(crate) struct VramAddress(u64) {
diff --git a/drivers/gpu/nova-core/mm/pramin.rs b/drivers/gpu/nova-core/mm/pramin.rs
index 38758ca971be..73d516c91c15 100644
--- a/drivers/gpu/nova-core/mm/pramin.rs
+++ b/drivers/gpu/nova-core/mm/pramin.rs
@@ -296,3 +296,217 @@ fn compute_window(
     define_pramin_write!(try_write32, u32);
     define_pramin_write!(try_write64, u64);
 }
+
+#[cfg(CONFIG_NOVA_MM_SELFTESTS)]
+mod selftest {
+    use super::*;
+    use crate::{
+        mm::VramAddress,
+        num::IntoSafeCast, //
+    };
+    use kernel::{
+        device,
+        prelude::*, //
+    };
+
+    /// Offset within the VRAM region to use as the self-test area.
+    const SELFTEST_REGION_OFFSET: u64 = 0x1000;
+
+    /// Test read/write at byte-aligned locations.
+    fn test_byte_readwrite(
+        dev: &kernel::device::Device,
+        win: &mut PraminWindow<'_>,
+        base: VramAddress,
+    ) -> Result {
+        for i in 0u8..4 {
+            let offset = base + 1 + u64::from(i);
+            let val = 0xA0 + i;
+            win.try_write8(offset, val)?;
+            let read_val = win.try_read8(offset)?;
+            if read_val != val {
+                dev_err!(
+                    dev,
+                    "PRAMIN: FAIL - offset {:#x}: wrote {:#x}, read {:#x}\n",
+                    offset,
+                    val,
+                    read_val
+                );
+                return Err(EIO);
+            }
+        }
+        Ok(())
+    }
+
+    /// Test writing a `u32` and reading back as individual `u8`s.
+    fn test_u32_as_bytes(
+        dev: &kernel::device::Device,
+        win: &mut PraminWindow<'_>,
+        base: VramAddress,
+    ) -> Result {
+        let offset = base + 0x10;
+        let val: u32 = 0xDEADBEEF;
+        win.try_write32(offset, val)?;
+
+        // Read back as individual bytes (little-endian: EF BE AD DE).
+        let expected_bytes: [u8; 4] = [0xEF, 0xBE, 0xAD, 0xDE];
+        for (i, &expected) in expected_bytes.iter().enumerate() {
+            let i_u64: u64 = i.into_safe_cast();
+            let read_val = win.try_read8(offset + i_u64)?;
+            if read_val != expected {
+                dev_err!(
+                    dev,
+                    "PRAMIN: FAIL - offset {:#x}: expected {:#x}, read {:#x}\n",
+                    offset + i_u64,
+                    expected,
+                    read_val
+                );
+                return Err(EIO);
+            }
+        }
+        Ok(())
+    }
+
+    /// Test window repositioning across 1MB boundaries.
+    fn test_window_reposition(
+        dev: &kernel::device::Device,
+        win: &mut PraminWindow<'_>,
+        base: VramAddress,
+    ) -> Result {
+        let offset_a = base;
+        let offset_b = base + 0x200000; // base + 2MB (different 1MB region).
+        let val_a: u32 = 0x11111111;
+        let val_b: u32 = 0x22222222;
+
+        win.try_write32(offset_a, val_a)?;
+        win.try_write32(offset_b, val_b)?;
+
+        let read_b = win.try_read32(offset_b)?;
+        if read_b != val_b {
+            dev_err!(
+                dev,
+                "PRAMIN: FAIL - offset {:#x}: expected {:#x}, read {:#x}\n",
+                offset_b,
+                val_b,
+                read_b
+            );
+            return Err(EIO);
+        }
+
+        let read_a = win.try_read32(offset_a)?;
+        if read_a != val_a {
+            dev_err!(
+                dev,
+                "PRAMIN: FAIL - offset {:#x}: expected {:#x}, read {:#x}\n",
+                offset_a,
+                val_a,
+                read_a
+            );
+            return Err(EIO);
+        }
+        Ok(())
+    }
+
+    /// Test that offsets outside the VRAM region are rejected.
+    fn test_invalid_offset(
+        dev: &kernel::device::Device,
+        win: &mut PraminWindow<'_>,
+        vram_end: VramAddress,
+    ) -> Result {
+        let result = win.try_read32(vram_end);
+        if result.is_ok() {
+            dev_err!(
+                dev,
+                "PRAMIN: FAIL - read at invalid offset {:#x} should have failed\n",
+                vram_end
+            );
+            return Err(EIO);
+        }
+        Ok(())
+    }
+
+    /// Test that misaligned multi-byte accesses are rejected.
+    fn test_misaligned_access(
+        dev: &kernel::device::Device,
+        win: &mut PraminWindow<'_>,
+        base: VramAddress,
+    ) -> Result {
+        // `u16` at odd offset (not 2-byte aligned).
+        let offset_u16 = base + 0x21;
+        if win.try_write16(offset_u16, 0xABCD).is_ok() {
+            dev_err!(
+                dev,
+                "PRAMIN: FAIL - misaligned u16 write at {:#x} should have failed\n",
+                offset_u16
+            );
+            return Err(EIO);
+        }
+
+        // `u32` at 2-byte-aligned (not 4-byte-aligned) offset.
+        let offset_u32 = base + 0x32;
+        if win.try_write32(offset_u32, 0x12345678).is_ok() {
+            dev_err!(
+                dev,
+                "PRAMIN: FAIL - misaligned u32 write at {:#x} should have failed\n",
+                offset_u32
+            );
+            return Err(EIO);
+        }
+
+        // `u64` read at 4-byte-aligned (not 8-byte-aligned) offset.
+        let offset_u64 = base + 0x44;
+        if win.try_read64(offset_u64).is_ok() {
+            dev_err!(
+                dev,
+                "PRAMIN: FAIL - misaligned u64 read at {:#x} should have failed\n",
+                offset_u64
+            );
+            return Err(EIO);
+        }
+        Ok(())
+    }
+
+    /// Run PRAMIN self-tests during boot if self-tests are enabled.
+    pub(crate) fn run_self_test(
+        pdev: &device::Device<device::Bound>,
+        pramin: &Pramin,
+        chipset: crate::gpu::Chipset,
+    ) -> Result {
+        use crate::gpu::Architecture;
+
+        let dev = pdev;
+
+        // PRAMIN uses NV_PBUS_BAR0_WINDOW which is only available on pre-Hopper GPUs.
+        // Hopper+ uses NV_XAL_EP_BAR0_WINDOW instead, requiring a separate HAL that
+        // has not been implemented yet.
+        if !matches!(
+            chipset.arch(),
+            Architecture::Turing | Architecture::Ampere | Architecture::Ada
+        ) {
+            dev_info!(
+                dev,
+                "PRAMIN: Skipping self-tests for {:?} (only pre-Hopper supported)\n",
+                chipset
+            );
+            return Ok(());
+        }
+
+        dev_info!(dev, "PRAMIN: Starting self-test...\n");
+
+        let vram_region = pramin.vram_region();
+        let base = vram_region.start + SELFTEST_REGION_OFFSET;
+        let vram_end = vram_region.end;
+        let mut win = pramin.get_window(pdev)?;
+
+        test_byte_readwrite(dev, &mut win, base)?;
+        test_u32_as_bytes(dev, &mut win, base)?;
+        test_window_reposition(dev, &mut win, base)?;
+        test_invalid_offset(dev, &mut win, vram_end)?;
+        test_misaligned_access(dev, &mut win, base)?;
+
+        dev_info!(dev, "PRAMIN: All self-tests PASSED\n");
+        Ok(())
+    }
+}
+
+#[cfg(CONFIG_NOVA_MM_SELFTESTS)]
+pub(crate) use selftest::run_self_test;
-- 
2.34.1

