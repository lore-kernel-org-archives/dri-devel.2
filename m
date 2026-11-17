Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456A9606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 06:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=tHBa9/a9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A88BA10E1BE;
	Tue, 17 Nov 2026 06:13:09 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010040.outbound.protection.outlook.com
 [40.93.198.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ABF810E1BE
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 06:13:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l3J1BOqILyaQho/WARl+ZMQvCOP5MXVO08z4yBjz48xy+fcJt7sqfiDi7GgBLkjI8KKxK7RdKf+ICBpfgR/3HKGsFZPsV90nyHXusWzv30ASv/5PZNWt/0W0soXJ5g+ztU1dvkR4HvhFenOqbgAyymZ6ZsEjsEJA/CatNeX6UjCoZnj0D32RBu2YGxObpDpiqHVk0EmfE2nU06yriJ82TVJScKs0SmoP2SJPv0/8aBepe9gNaQCjIGfuGkPt1rnzhtpj5rENDqOXMIiO6MGJCrrAGl8yhvECtylzx100xv/X6Rxiy8a6p77nW+V9YfJykHgx3hEiAw8nkgM1hMm+SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oshRBGc50irQGUtCxuAmm5ga3T4vXJR1vl5q0c78OsQ=;
 b=pLnDic+0Fi4OOeG/s1pIJRiqcZwuCMMgIxJO3SO0Ij72MR6yrQmmzeiqHUdm2rE6CzDr9Jw67qwfTo8SIlsLns9H98ikDN8/MJdthjFHx5TmDfNTnUyh6cPt3sh3mUCNdiNxL1sqhdnzPrPQrxDSjBXtx7/9MvS5RkeZQ4KxiajAbuPOnqtMxr0ppuNTNCaYraB33q1pz4Xc+4lC72qOmZbRTBQ6TZqGvXaylHKewP9iED6xBjFBgoWFJ2V6roCh/mosRF6uuRscxc0rxHiHu5pf9NlbpR1v13hQLeXDcIyfetq4eKk0dYaEydL3VIOby6iLoZ66ZFSEr87YoQPPxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oshRBGc50irQGUtCxuAmm5ga3T4vXJR1vl5q0c78OsQ=;
 b=tHBa9/a9aYU6Ycpt+NoHpA/jcYlTHCDF3ypeZO4071kA/uIB9qs7mT4PqJBemmsJl9/lnP54FTcPmrP34kltZ7wZoWpUiI7/K2SEtKl2ikMDpULQkLniAyMGWzLGPXmFkUJEFjXdSvpWmYzZJBvwJQnM12pbwQJSIvVdJ0Mso1S3HDfzYgQ3JiThkRVlPncMfzJEtoZdqWDLBgz4wVENPhLWLFAqJaXOGnl9mWPXNLWnFtWnxS89BqYVXMW2CTiwZZky9DvuTmw2HLueHwb0bIqdGntkE4U/Ko9Csoctv5f/R5jo9xrJ4xHIm5+qA7CiyUiutDIfwR+2c/Nxt+EcLQ==
Received: from DM6PR02CA0116.namprd02.prod.outlook.com (2603:10b6:5:1b4::18)
 by DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 06:12:54 +0000
Received: from DS4PEPF000001C1.namprd21.prod.outlook.com
 (2603:10b6:5:1b4:cafe::26) by DM6PR02CA0116.outlook.office365.com
 (2603:10b6:5:1b4::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Tue,
 17 Nov 2026 06:12:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS4PEPF000001C1.mail.protection.outlook.com (10.167.23.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.0 via Frontend Transport; Tue, 17 Nov 2026 06:12:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 22:12:35 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 16 Nov 2026 22:12:21 -0800
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
Subject: [PATCH 1/1] gpu: nova-core: send GPU timeout defaults in GSP_INIT
Date: Tue, 17 Nov 2026 11:40:53 +0530
Message-ID: <20261117061053.915254-2-alkumar@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117061053.915254-1-alkumar@nvidia.com>
References: <20261117061053.915254-1-alkumar@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PEPF000001C1:EE_|DM6PR12MB4340:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e6fce42-5d26-4940-a35a-08df4471d113
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|7416014|261022105027099003|261102123227099003|261028144727099003|261021121427099003|261026121527099003|261026140227099003|11063799006|56012099006|10067099003|18002099003|22082099003|261009223027099003|3023799007;
X-Microsoft-Antispam-Message-Info: OF1W6w0wKfwvDf04qtwSLnrWWEOvQMMi0x5cP1qCV8k3QnImPnEkurEUiVOnwH8GJPBf3a+0HDKn3ABfuQPdIJpGrXxd4W3ZavoUT1wzFi9zSb8wMEINR5nvwJIyliDAmIuT7gfmeX7ZG29O3w+kJQLmKM0ebHl9IOEqaBYjmOsaa1K4fmMlkfuC483MoE52Cwb+Nfxmpd+kJLZroW2AVXh2fcqPFjPvrErQ+KxkpNQueuHkX6ebHzPKklP/ZfUmvxqDimDnnrJ3RguY6dpsnkm0XszndiTl5SSjjvFYQ9NJhC9iKLBsPggHz/Y8u1en4teW4PDUVRDmCWj3JT0RD72jYazKQaspFOtaaFu301LHEDBU/tcrNP5P4I9J/63jxMwploenOvT24sCq6BJAkKa3zBVHBkL56WXdwbwQgTyP5KjGcYZ2//Zx8TzYVWz6Mxf3T4NKPgMez+iJ6CoKDHZnPm1yqs6gc41yxj6Xw/Ajn46Mg0incm78sfqaBzVQylsUdzrPSFuWOhv0nsSxY7nBNxmThIXiNmnWOMgN9kyB1YhL8PUgbkQhzvvGWGOj
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(7416014)(261022105027099003)(261102123227099003)(261028144727099003)(261021121427099003)(261026121527099003)(261026140227099003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(261009223027099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WD4g8uYQrZgi7Uw5hbmFaVikTmbsZ+1SyVE9iNFtHiYlw7h3T5PkY40akJHodA1gv1vRk5KpMeT7Pe9PnmBCa0Fv+tSM+FVvM72Rlvc64mN2jCaPDlycQCOvN7ziLgJ2DN1z5XRCuUNz9/bPjBg7jhRSMr5vc70kciP+ixulCoLNIfqGvML18iJ6TNPL/KwlMgHgtoUomg7C0A4jqUiemrJoshdfASYneyufoyjMApZdxY/uWRj6T6vQvXCnxiOng/CNAO3W6NVk7+Eeq9eWblfF4HRr/m1XbJVd6vuDG0aie0iQ2N38PNOkOsfDtwH2UTAzMhE70+eQflSryPxH8K+G3V9hJke7r1AJjzrbYWTosxtoyFfq08M72BlfddEhR50BykuyrCkhG4I2vPWOTH3AVez/OIPyzo8xjn2jHA41GgXpCYKwdmtPEUnuO+Yu
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 06:12:53.8664 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e6fce42-5d26-4940-a35a-08df4471d113
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS4PEPF000001C1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4340
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

GSP firmware requires a nonzero vGPU timeout in GSP_INIT.

Populate the NVKV keys as u32 values:

  0xA0: vGPU timeout,          1,800,000 us
  0xA1: graphics-mode timeout, 4,000,000 us
  0xA2: compute-mode timeout,  30,000,000 us

Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 drivers/gpu/nova-core/gsp/fw/commands.rs | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index 08798f150ad7..adb0b1f29ceb 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -192,6 +192,9 @@ pub(crate) struct GspInitRequest {
         pci_config_mirror_base: Key<u32, 0x0010>,
         pci_config_mirror_size: Key<u32, 0x0011>,
         host_arch: Key<HostArch, 0x0070, u32>,
+        default_timeout_us_vgpu: Key<u32, 0x00a0>,
+        default_timeout_us_graphics_mode: Key<u32, 0x00a1>,
+        default_timeout_us_compute_mode: Key<u32, 0x00a2>,
         bus_device_func: Key<u64, 0x1020>,
         regkeys: KVVec<RegKey>,
         vf_info: Option<VfInfo>,
@@ -230,6 +233,11 @@ struct DomainBusDevice(u64) {
 ];
 
 impl GspInitRequest {
+    // GPU timeout defaults in microseconds. All three values must be nonzero in GSP_INIT.
+    const DEFAULT_TIMEOUT_US_VGPU: u32 = 1_800_000;
+    const DEFAULT_TIMEOUT_US_GRAPHICS_MODE: u32 = 4_000_000;
+    const DEFAULT_TIMEOUT_US_COMPUTE_MODE: u32 = 30_000_000;
+
     fn build_vf_info(ctx: &GspBootContext<'_, '_>) -> Result<Option<VfInfo>> {
         let total_vfs = match *ctx.vgpu_state {
             VgpuState::Disabled => return Ok(None),
@@ -300,6 +308,9 @@ pub(crate) fn new(ctx: &GspBootContext<'_, '_>) -> Result<Self> {
             pci_config_mirror_base: mirror.start.into(),
             pci_config_mirror_size: (mirror.end - mirror.start).into(),
             host_arch: HostArch::host().into(),
+            default_timeout_us_vgpu: Self::DEFAULT_TIMEOUT_US_VGPU.into(),
+            default_timeout_us_graphics_mode: Self::DEFAULT_TIMEOUT_US_GRAPHICS_MODE.into(),
+            default_timeout_us_compute_mode: Self::DEFAULT_TIMEOUT_US_COMPUTE_MODE.into(),
             bus_device_func: u64::from(bus_device_func).into(),
             regkeys,
             vf_info: Self::build_vf_info(ctx)?,
-- 
2.53.0

