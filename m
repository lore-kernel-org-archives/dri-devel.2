Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D81606A329
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 05:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=X4An+9EW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 621F710E9D6;
	Fri,  6 Nov 2026 05:42:46 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012035.outbound.protection.outlook.com [52.101.43.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3A5E10E9D6
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 05:42:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YsTyN69SdrKdC0Iu3aSexJLCPodQNKJcY3c6Lp2/U8OL0savC4WF7TrofNFN6vCF47psouTKZ+o5LVTw327V5mkR68YmNwBxxDbIhnmwu/uvQN2B7hMTsgiEameEFeGHeh1YpbHlHgKbf7Vo1hK2HlgKLY1VOJOLv1ptDaL9XzrPbJaKkZ2jr/Ahlg0Z9+9hpODKaRaCdKQ78An3QyTDNSqS7Cx+AQ11zcyHnH+G6X2SQuaQ62g+Keslhj6HOsGQBKLLwbkYvkz7XWHd3DDWSGUqn2KbBBa4aSOOUAiZFVFEodXnXtvNrS3wyAbf6mVCU4/ppzmX5q1SqY256jeEFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEmLaklTbknYOPLWaoCTrQntCDIEe9lyVmvec1xaPa4=;
 b=CkQNQLpDiyslEYPIR/d8IL/AuLDC5hjD2nsER1oxs/16j5ShHRxhRJDKh6fM2Mkcg96D/9u0c4c8kjEcHOKopijcM7yO3KQ4d+NxI73dxueYoC2L7Fp42r12ODgd9ie881Xb5oKYMQOt8O3tIY5fwznsgf/gxVuH7H8ocNeabtSw+3TDrvJtpYO4mcsgAxU+uh2j6OV0g1XMPAoNHuNbgw/sUvd5PLgtr5fdKtwF1aIdl8VWu+glm772NEVuyrGwhU2dtekcGayIs6VNEQsJVZlCkQEpJF77FdOLau7cxOL3JEQdSlzoG1dZSHufS8Pgk+D35aoVPnBnMDE9oN8mMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEmLaklTbknYOPLWaoCTrQntCDIEe9lyVmvec1xaPa4=;
 b=X4An+9EWS6J2Nt6t5lZLnQqG8sJanGzydX2kqfroQmFzuGdUE+2nNoHya7tnrmIQ0e1MZCFdsQ+/O6fX09zNAVCyw08s3bXy46NPezy0NJfD2cgfPzUPo+slx29Ilxsa+dzvnT2cNalgbo5I2puHIf3939cpMZwrzylYNsg5p369UFTgn/zN91UkAu4FBZh/MuZVvSE149vABrBtVKQR8wHI2M7/i8qGC8pSQvEp060omwZmwB8k/3ra/6fIpj9B5ZYqPBYcl+qrdBo9iX0EG2/Kxt6Qg/YTGZndMad9y7dqIIzSEUh0kMMq1gc5hNP6e3hAK+m5SLtsflSaV8W4uA==
Received: from CY8PR22CA0019.namprd22.prod.outlook.com (2603:10b6:930:45::26)
 by IA1PR12MB8537.namprd12.prod.outlook.com (2603:10b6:208:453::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Fri, 6 Nov
 2026 05:42:35 +0000
Received: from CY4PEPF000392D8.namprd03.prod.outlook.com
 (2603:10b6:930:45:cafe::a) by CY8PR22CA0019.outlook.office365.com
 (2603:10b6:930:45::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 05:42:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF000392D8.mail.protection.outlook.com (10.167.247.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 05:42:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 21:42:17 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 21:42:04 -0800
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
Subject: [PATCH v4 05/32] gpu: nova-core: gpu: add a channel ID pool for vGPU
Date: Fri, 6 Nov 2026 11:09:38 +0530
Message-ID: <0d7b20e2a4c308bbd5e23a87584379b58d4524a8.1793906667.git.alkumar@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793906667.git.alkumar@nvidia.com>
References: <cover.1793906667.git.alkumar@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF000392D8:EE_|IA1PR12MB8537:EE_
X-MS-Office365-Filtering-Correlation-Id: 3beba717-9dbd-432a-44c6-08df3bc8c250
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|1800799024|36860700016|82310400026|261022105027099003|56012099006|261026121527099003|11063799006|261028144727099003|261102123227099003|261021121427099003|261009223027099003|261026140227099003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: Snyb14U7TRX4XS3tB0vZ1RaZ4SpV0IIMk80Gme+CadAqwIUV0K46sbj/3in+KnpmYm8Xmtp4+2adTATr5ouKAT+4frRgxxoWAt4SMWJrPdq1l5HzAwdcUJs/9PnKDF6FjUgDxzHKRhVG03XRRvNsV7lium3focdzSxRRvcCJtYdNIs/aBE7yvL+50grUgJYtvro36ZT0SXBS28rGJe1oT/P+ohP7QMYI/oBspmxB0KjlB/F7P/z1CZKF1dIY+oz4tc7K9gBYbm6ExetdGLKcg0G7GPihTbokpqA8ZYG6dala5XMC7I3XfctF+xDzwLRdkT8HbBud0RvCCyjvmyry2HqFrlXhlxS2pJwM2l4fp6PRUEKhv88Ybs5eCwa3v3KOBox79hPKXiEAID4/8Z78GS1KunXwJpmunVSJ/VnjyqVDYddJS6WS7c6khgY0f1CyGGlAzSdliay2+/CfkXlqioTXg4wDexNhUIczhSQuwREuliqReu58WkJjI4NPfriZAPnozE+njEHpJqHS2l8KiF7yK+YIFSTW6cFWEIeSJexXAiyOX/LJfS0ljTSLuAsZvliCPfjmWrQ2XvVjsgpHFDKVXRlmH9igyy1AfTpMX2KeCTJaj6m55yVvVkD2RQtBipKIU+PXqdAmTGQaRXb6trelaR99z1fqxMooNVbnVfgqiHhcwpZH2aP0TxNUnuHSHVq3H6zGSSRdmOhMqvs1Rw==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(36860700016)(82310400026)(261022105027099003)(56012099006)(261026121527099003)(11063799006)(261028144727099003)(261102123227099003)(261021121427099003)(261009223027099003)(261026140227099003)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +TQukv+0XlXhcaYClUTu4YNj70sZBqgFKCgAEX9iB6tGqfF8IeAUFPKADmqV9rI9RiokVHdD92rwJDpAk47qAvGtqjj2QmeRZSYhoDtDvcZIGOg6DosDUtc9X4AmMLNbJ1I1yiPOQuNzOssXtr7igoIs6aSMWPnaZkI8I024CMEUTfsOj3E7KRHOeDpWZE13EG5fI6igXIg2UQbpqOGeQ3nI07Y+wG2SGT2dmukGsfojonBpchoprP6k4+mYsNqJOl+dps1TSn3N9C5/26CFdr9Z++cVelpVvXpC/jxgz5RIhPW0knJVPPDPKrnpBCyoAmUO14fRX+JidxSM7A2LD9YsObSAJCKpPdkW2M2EwRYHr89UL1lPr5dGfkO/3V2YR0BuZMRsHrLK9LI2yAIZb44YDfkK3HPu5LyMKv8/lrZMYbGc0sqyqwnP8a9S542u
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:42:34.8798 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3beba717-9dbd-432a-44c6-08df3bc8c250
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF000392D8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8537
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

Channel ID reservations need a GPU-owned pool shared by vGPU instances.

The pool must remain at a stable address while its reservations exist.
Its storage also needs to remain available throughout GPU cleanup.

Create a private pinned ChannelIdPool with a single 2048-channel
capacity constant.

Cc: Alexandre Courbot <acourbot@nvidia.com>
Suggested-by: Eliot Courtney <ecourtney@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs         | 9 +++++++++
 drivers/gpu/nova-core/gpu/channel.rs | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index fd0442f9a40b..3f8bdbb9a5b2 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -52,6 +52,7 @@
         GpuMm,
         VramAddress, //
     },
+    num,
     vgpu::VgpuState, //
 };
 
@@ -60,6 +61,10 @@
 mod hal;
 mod regs;
 
+use self::channel::TOTAL_CHANNELS;
+
+pub(crate) use self::channel::ChannelIdPool;
+
 macro_rules! define_chipset {
     ({ $($variant:ident),* $(,)* }) =>
     {
@@ -410,6 +415,8 @@ pub(crate) struct Gpu<'gpu> {
     /// GSP and its resources.
     #[pin]
     gsp_resources: GspResources<'gpu>,
+    #[pin]
+    chid_pool: ChannelIdPool,
     /// System memory page required for flushing all pending GPU-side memory writes done through
     /// PCIE into system memory, via sysmembar (A GPU-initiated HW memory-barrier operation).
     ///
@@ -494,6 +501,8 @@ pub(crate) fn new<'a>(
             // Initialize this early because `gsp_resources` depends on it.
             sysmem_flush: SysmemFlush::register(dev, bar, spec.chipset)?,
 
+            chid_pool <- ChannelIdPool::new(cv!(num::u32_as_usize(TOTAL_CHANNELS))),
+
             gsp_resources <- try_pin_init!(GspResources {
                 device: pdev,
 
diff --git a/drivers/gpu/nova-core/gpu/channel.rs b/drivers/gpu/nova-core/gpu/channel.rs
index 485efaba059d..75666c6768e6 100644
--- a/drivers/gpu/nova-core/gpu/channel.rs
+++ b/drivers/gpu/nova-core/gpu/channel.rs
@@ -21,6 +21,10 @@
     }, //
 };
 
+// TODO: Query the channel capacity through GMCAPI once an equivalent of
+// NV2080_CTRL_CMD_INTERNAL_FIFO_GET_NUM_CHANNELS is available.
+pub(super) const TOTAL_CHANNELS: u32 = 2048;
+
 /// Pool for tracking reservations of channel IDs.
 #[pin_data]
 pub(crate) struct ChannelIdPool {
-- 
2.53.0

