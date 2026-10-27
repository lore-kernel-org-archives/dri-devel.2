Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0904606AD8B
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 07:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=nl/AD/bv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3684C10F2B6;
	Tue, 27 Oct 2026 07:36:57 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010041.outbound.protection.outlook.com [52.101.85.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C646F10F2B5
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 07:36:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fuTrgEJvvtAmn1aheeWx8IMxX3OKlJ2IkejaLzy0CQOJG1deE2hSyvXj3FzrFV3APtFI8ovuEvfJjZPgbuNc1ChNp3JiYeFWcdHLnU36DxuiPheuTf2v7Wi3K/m0WTLCy0b9r7G6kMdmuqw1RUnZz8zIWS55uNU0KJQf/oAhDTfCzTO2lv/JrhsprCIc06IkYZOO5dKr83zsR/arkhrAhWK7cpWAZlsMw3uaRUHn0SeFO665gGTCGYUpr89Q847ibellner+na+6RBmjscXhdHPDjmW2g9CBivvw390WlMLa9at1+46aqtSOszroJo3uVNSL9rboqs2667saOrpqBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5qnArfsYkEPr9Oc7MS4hkZaCEaeK4LjfRwj4bb3Yw4=;
 b=oYjB6+sDe1B2kEQPdIJAq0sBXia9OS1/sc9g2v3rcHd2mwFT+1iWcYXpZhuOPuqmf45C6urT5I3aOyl/Ii5twFb4ypmSM+1fBA/le6NdCSFCNXcKm382iEpdFo4mdjj1V/aeJb7Apd8aSiRuw83tZBPccDAjionV9WOh5wss4i/0DoCPt8g8Buza2J8RIOScKCuHPaJj0nNl3l08wLbhV/3v1Gyo9tWmUq/p1yU3mK58yQLsB5h8VZzw/FX9L+8/Q7Dz19VLUtAlm3egFQQ68Ex8biBQONsBEI+ZQ5PMlgI78M2XYmAKlq52AbZq8cjGAxPcT17eaDR9M8Hx82vvBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5qnArfsYkEPr9Oc7MS4hkZaCEaeK4LjfRwj4bb3Yw4=;
 b=nl/AD/bv+ie59zgxgmUpZLAySJqr4zrJ9rroPVfLpx94PihZ1XForAl5jCSJ5YAQnJ14WqDStrFsHlmseDy1IdFTKBRompDtPNhgLVmxzTk8SVozSiii+WqC9OVzuhNhix54HmsdXfBlulNtf5tTqYS/TOQJJbLU1swQqV1wcX4JkfeTKtpApxZ7NOkz4sd5kMbgSyxjGc1VcY655eIkJIRmNlAET9vJgx4SvSuR7tbwxI55K0ki/jOl1k0krMnF9R31yViSkiruADDoaHb0L1CR6ijDKPrS5uDyuL1kFmMDbplKUezuMaFIdhjEXd39EeLic44oyzS2VGixbRKLhw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DM4PR12MB8451.namprd12.prod.outlook.com (2603:10b6:8:182::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 07:36:33 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 07:36:33 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 27 Oct 2026 16:35:57 +0900
Subject: [PATCH v6 14/15] gpu: nova-core: gsp: move the RPC commands into a
 sub-module
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-cmdq-rpc-v6-14-bed9669724ba@nvidia.com>
References: <20261027-cmdq-rpc-v6-0-bed9669724ba@nvidia.com>
In-Reply-To: <20261027-cmdq-rpc-v6-0-bed9669724ba@nvidia.com>
To: John Hubbard <jhubbard@nvidia.com>, Danilo Krummrich <dakr@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Benno Lossin <lossin@kernel.org>, 
 Gary Guo <gary@garyguo.net>
Cc: Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4P286CA0028.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::10) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DM4PR12MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: d07d3d6c-3a75-4491-8063-08df33fd05eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|10070799003|261026121527099003|261021123027099003|56012099006|11063799006|261022105027099003|261009223027099003|261022075727099003|261022113327099003|261021121427099003|10067099003|22082099003|18002099003|6133799003|261026140227099003|3023799007;
X-Microsoft-Antispam-Message-Info: ZeO8f2sa5hkEqGpwIPFGR2JmVfzNProlvQ1RlaSYuX1sUpeDhVHYkS3EvxotOu6RhMr8Iea5G/XoifqViBypkpRgE5kp0zOGSGISlFWMkC2oruhEvycCOAHWwJ5kjXVcpu7siNXjJvvzdITFqUUMTB0+FbggDvMAiJf3wPNPTeIpNlCAneVkB7VPkE2n82mTA6Gw269Ea/mDtnhg1pkhQLsd+1OpIcEN8ElsqY5yTp92weThk5r9z6KbkBzgmNBwDjjvjiVbW89SS6eRNbN+WUoazP2NRK8O1u8kJA5CJN4r3R3I8bQ4fyhj602z3Hcl4YYmwPQrZYGWwbHBAiTaRGN9lpZoloKf3h4FMzXrIGZWbfnJqWn95qTjhxpaMnTBczWNjxcKQuhmNgGJ2pMybxYUeyH3I1itnHuYEQRFZStd78q4TkOnrptDD1JG98s7UmOuks5W8P5DRKR9+3YcuQymDp/1lRd9YLVX/7FZhWJ0cyjpc2UrVklqK0UHVbcaILkS4lOw3ffqBsvzylniYn+wvBqfi59NxxCIQAvVIyGP3TH93IbaUx8+TNvshbQygUe7AFredqAza4HuqkE9xLzPeqzRuAjmWXN1t3A5ed4upl3oJnd79rqboe3o7GrO7E9T//BhlxkGLj2mxI8oLC+w2f904oyvxea+jVBaljc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(10070799003)(261026121527099003)(261021123027099003)(56012099006)(11063799006)(261022105027099003)(261009223027099003)(261022075727099003)(261022113327099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(6133799003)(261026140227099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTREVHdEU1RyVjB4c1I3bnlkN3hnc1FWUkJPWE1nR3pEdlZPL1l4VzIzdmZ5?=
 =?utf-8?B?aTFqVS9MV2ZCelI3bVQ4TEdGamVoMzUwYUFzOUx1c0lrSDltVGtaN2xMczhM?=
 =?utf-8?B?TWJDTVU2RVB6WThqWDJNOERzQlZFdnhJV3JXNHBEZnpKdEZQOUFiOVFvTjNJ?=
 =?utf-8?B?aldjb1IrYXFkd3VJUHZrcHVzTVhaekxPdDRXd3A3a0U0WmhJdlQ2em9aZUJj?=
 =?utf-8?B?MHM5MWFNWmJEQS9wNTAzK1h4YjhHVVJDdkJodzVHamxXT3NiSmxtK3dmTWtJ?=
 =?utf-8?B?MTg2NzlVQzZVYVlSeWNkcEpPenlLNDFpaVFvUHVmNTdEUFZpTDFNdUFzeVFs?=
 =?utf-8?B?emRienhmdXRRajF0MmxSOTFObHFIVWtFd3hJUGpwakIwOWhoVTdoRCtZcUVQ?=
 =?utf-8?B?R3p3ZE9HVUZvZzR6NGZoMlRsdWU1aWFNWVc1aUs5bm1QRkltbXBZbmIrcGl0?=
 =?utf-8?B?bUVqT0tPYmlOOTA4VFptb29zUzRCcE4yQ2hRUmxqVjdVMkRDallUd3NXVmJY?=
 =?utf-8?B?b3hOMDc5L0lMcUVPYnltSEl1THlpb1lYUFp1d0RRYXJjVTVQV3lHRWJKamUw?=
 =?utf-8?B?U21hbHZtQVhkMDdSTWdQcnM5Y2g2SkQwOEk3NlNTYXFPb3UzdTBQN21YbnlL?=
 =?utf-8?B?UHBnTy9oY09LV0lFbVQyYkorckZheG5pUTh3VlAwd1B2WlZhWWx2U2lybm91?=
 =?utf-8?B?R1J2enRCZG8xSS85cFFEVStGVHZrTUJuMk9FSVlCbEZBa3RPQjhhclU4cVBh?=
 =?utf-8?B?MHlSVVRqN1RicXRaV01KWkNucWtrbmZpWVpoa2c5TmFKNUN2eVhZL3BZeGZu?=
 =?utf-8?B?VlpTT2U5ckJPNHpiZ1JwM0hDc2FFeDBkTU0wcW91WWhmb2pGQzFPTmJNUFV1?=
 =?utf-8?B?R2tLby84SzQ4YjNwRXhXazRFbzhOVnF1Z3RmZk5mM3R1d2VaSkJyR2RrcWNT?=
 =?utf-8?B?bk92VEp1bXNQVlcyT2dmenp5MFlVZ3V3TU92QUcxbkFLMGVZeEh6WXZUc2xI?=
 =?utf-8?B?UzVsLzRVdm9iTUh4cElibitHYlhOT0thTlRSenIwTVg3eVQ2MjZRR0RMak5S?=
 =?utf-8?B?UVdYb2ZQUHNZK0cvM1BsZzkweW8xS0UxbE5kSVp4aXE4WFJOUFVDb1lOdnlS?=
 =?utf-8?B?SmJHMFhRd3VidXF4QjZVYnhyTGZidUx3Tk40cFBIYm9QWTYzOEJ5V1c3V0dU?=
 =?utf-8?B?M1YvNStZaTVvR3dicHBLbmZzTm03L1BOVndrSU84clV1TU8xNVduRit1VG9U?=
 =?utf-8?B?RDFRWjZmMDh3UnZvbWpvNEVldHQ3KzZHT2F1WmxhMzJNdzRQbnJuVFljWEdB?=
 =?utf-8?B?b2NmWTBsV1ZDWWpCaldHeXdqcXkwUmJzS21LNjJ4SFhiVHVnMWFsZC9KWEdH?=
 =?utf-8?B?cjd1clNrdUpwVHBmekFrYmJtVlU3ZVBvV2RSTllXVldrc1diTEF6YUhBVjkr?=
 =?utf-8?B?UmZpR2p6OGRuSXRqN2ZQVVl5T05JUkphKzFOdnhVTWpwbmNRakpjUWZKZE5N?=
 =?utf-8?B?cmR2aURJYWN4YzBWVkI5OExGa01tQTF5RkQraVQwSVVnc200empQM2MrWGVi?=
 =?utf-8?B?MHFQVlBGRkVVbkkweE5Hbk1XSGVEYU1oUEgwRCtDNFVWZDZWUDhLSTh3aDRD?=
 =?utf-8?B?M3MrQVhFTmFkRHhkYUpjZU80MTFGOHhGdVk4M2JOTG1NVk5LTDhJemJnYllV?=
 =?utf-8?B?SzNDelZSZWVEL2ZLZzdFdU1pNWtvQ0FlYTdsM0FSU1c0MittMW53L1NuY0dL?=
 =?utf-8?B?bVZ4MERpaXI5RXlPRHRvSWRZelV6SHNBNUVyTVVSTEJ2bE1UNmt3SnpTc2N3?=
 =?utf-8?B?dG56MWVpNG13Y0tKb25JM2taTzZQQk92T0dJM3FWb21nR1NOU0dhRzNYdGZT?=
 =?utf-8?B?eUdyY3U2RnMwNTJXcTFLYytwS05qNjB0NG16Z200ckhvSThhNXdGZFZqV3Mz?=
 =?utf-8?B?cFQ3STdoalNrK0x1NitKdDJXVkJPazFLU0pzQ0xHNitUZmJNN3NpNTJRd0Rl?=
 =?utf-8?B?aDNsQ2V6ekpPbVlYRm5zTEJOMUpTbkN0aTB2WEZ5Ym15MzJmWUpRWE9jc0gr?=
 =?utf-8?B?eHZ2Z2MxWk05V3d4ZjRZVVJ6aDNHMUF0b1JxdldMQjV0ZDV5ME5zUGZPdVp5?=
 =?utf-8?B?SVhVa3lUd0ZaUzkwMVNNbndOT1BFcjRNOXRDenQ3TjBiWjNkWXk1bjhQaFp2?=
 =?utf-8?B?UTQrcmhDaStLTm84MW9KSmhnTEF0aUNhV0JsWnQ4MjhOaE5zQ1Y4OFlZRHQ0?=
 =?utf-8?B?bXNZQjVHN1BJNk9leDhCTkJxaUFSeXkzMHZuTFdGekt5Rlpxd1dyVjNFYUVk?=
 =?utf-8?B?SUU4Um80aWpyZm9HYTRMVDF3dWpnY1g2OTE1RXV5cGhJV2N3RlhJZkxGZU0v?=
 =?utf-8?Q?w6plwcnjHScZpUKvJ0LCSAE99jh/Q7IPJtpSQ1NnlguMY?=
X-MS-Exchange-AntiSpam-MessageData-1: /ZpZJvqphOhIrQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d07d3d6c-3a75-4491-8063-08df33fd05eb
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 07:36:33.1348 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fSK4aEw8theoJ/CPtwijyUR83dYdmqomU95gNsaEXJ20oDaAvfgx6Hh5hdYj7OT+2XBa2eRQ/dWtsmLluQLTmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8451
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move the types and code related to RPC commands into the
`rpc` sub-module, and update their users to reference them from their
new location.

This is a pure move commit, with no functional change intended.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/api.rs              |   2 +-
 drivers/gpu/nova-core/gpu.rs              |   2 +-
 drivers/gpu/nova-core/gsp.rs              |   4 +-
 drivers/gpu/nova-core/gsp/boot.rs         |  12 +-
 drivers/gpu/nova-core/gsp/commands.rs     | 331 +----------------------------
 drivers/gpu/nova-core/gsp/commands/rpc.rs | 333 ++++++++++++++++++++++++++++++
 6 files changed, 344 insertions(+), 340 deletions(-)

diff --git a/drivers/gpu/nova-core/api.rs b/drivers/gpu/nova-core/api.rs
index 29207c4bb743..eec69aace3b2 100644
--- a/drivers/gpu/nova-core/api.rs
+++ b/drivers/gpu/nova-core/api.rs
@@ -18,7 +18,7 @@
 use crate::{
     driver,
     gpu::Gpu,
-    gsp::commands::GetGspStaticInfoReply, //
+    gsp::commands::rpc::GetGspStaticInfoReply, //
 };
 
 /// API handle for the auxiliary bus child drivers to interact with nova-core.
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 4e59072cab50..ac5305d7ff5e 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -35,7 +35,7 @@
     gsp::{
         self,
         cmdq::Cmdq,
-        commands::GetGspStaticInfoReply,
+        commands::rpc::GetGspStaticInfoReply,
         Gsp,
         GspBootContext, //
     },
diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index dda58095f40b..75a3ba7d50f4 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -220,8 +220,8 @@ pub(crate) fn new(
     }
 
     /// Query the GSP for the static GPU information.
-    pub(crate) fn get_static_info(&self) -> Result<commands::GetGspStaticInfoReply> {
-        self.cmdq.send_command(commands::GetGspStaticInfo)
+    pub(crate) fn get_static_info(&self) -> Result<commands::rpc::GetGspStaticInfoReply> {
+        self.cmdq.send_command(commands::rpc::GetGspStaticInfo)
     }
 }
 
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 4fb1b69ac9d5..8e446ad1eac2 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -43,9 +43,9 @@ pub(crate) fn boot(
         let gsp_fw = KBox::pin_init(GspFirmware::new(dev, chipset), GFP_KERNEL)?;
 
         self.cmdq
-            .send_command_no_wait(commands::SetSystemInfo::new(pdev, chipset))?;
+            .send_command_no_wait(commands::rpc::SetSystemInfo::new(pdev, chipset))?;
         self.cmdq
-            .send_command_no_wait(commands::SetRegistry::new(ctx.vgpu.state())?)?;
+            .send_command_no_wait(commands::rpc::SetRegistry::new(ctx.vgpu.state())?)?;
 
         // Perform the chipset-specific boot sequence, and retrieve the unload bundle.
         let unload_bundle = hal.boot(&self, &mut ctx, &gsp_fw)?.or_else(|| {
@@ -79,7 +79,7 @@ pub(crate) fn boot(
         hal.post_boot(&self, ctx, &gsp_fw)?;
 
         // Wait until GSP is fully initialized.
-        commands::wait_gsp_init_done(&self.cmdq)?;
+        commands::rpc::wait_gsp_init_done(&self.cmdq)?;
 
         Ok(unload_guard.dismiss().1)
     }
@@ -88,10 +88,10 @@ pub(crate) fn boot(
     fn shutdown_gsp(
         cmdq: &Cmdq<'_>,
         gsp_falcon: &Falcon<'_, Gsp>,
-        mode: commands::PowerStateLevel,
+        mode: commands::rpc::PowerStateLevel,
     ) -> Result {
         // Command to shut the GSP down.
-        cmdq.send_command(commands::UnloadingGuestDriver::new(mode))?;
+        cmdq.send_command(commands::rpc::UnloadingGuestDriver::new(mode))?;
 
         // Wait until GSP signals it is suspended.
         const LIBOS_INTERRUPT_PROCESSOR_SUSPENDED: u32 = bits::bit_u32(31);
@@ -118,7 +118,7 @@ pub(crate) fn unload(
         let mut res = Self::shutdown_gsp(
             &self.cmdq,
             ctx.gsp_falcon,
-            commands::PowerStateLevel::Level0,
+            commands::rpc::PowerStateLevel::Level0,
         )
         .inspect_err(|e| dev_err!(dev, "GSP shutdown failed: {:?}\n", e));
 
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index ceac0b0f9423..5f1c944678be 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -1,333 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
 // SPDX-FileCopyrightText: Copyright (c) 2025-2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
 
-use core::{
-    array,
-    convert::Infallible,
-    ffi::FromBytesUntilNulError,
-    ops::Range,
-    str::Utf8Error, //
-};
-
-use kernel::{
-    device,
-    pci,
-    prelude::*,
-    transmute::{
-        AsBytes,
-        FromBytes, //
-    }, //
-};
-
-use crate::{
-    gpu::Chipset,
-    gsp::{
-        cmdq::{
-            rpc::{
-                CommandToGsp,
-                MessageFromGsp, //
-            },
-            Cmdq,
-            NoReply, //
-        },
-        fw::{
-            self,
-            MsgFunction, //
-        },
-    },
-    sbuffer::SBufferIter,
-    vgpu::VgpuState, //
-};
-
-/// The `GspSetSystemInfo` command.
-pub(crate) struct SetSystemInfo<'a> {
-    pdev: &'a pci::Device<device::Bound>,
-    chipset: Chipset,
-}
-
-impl<'a> SetSystemInfo<'a> {
-    /// Creates a new `GspSetSystemInfo` command using the parameters of `pdev`.
-    pub(crate) fn new(pdev: &'a pci::Device<device::Bound>, chipset: Chipset) -> Self {
-        Self { pdev, chipset }
-    }
-}
-
-impl<'a> CommandToGsp for SetSystemInfo<'a> {
-    const FUNCTION: MsgFunction = MsgFunction::GspSetSystemInfo;
-    type Command = fw::commands::GspSetSystemInfo;
-    type Reply = NoReply;
-    type InitError = Error;
-
-    fn init(&self) -> impl Init<Self::Command, Self::InitError> {
-        Self::Command::init(self.pdev, self.chipset)
-    }
-}
-
-struct RegistryEntry {
-    key: &'static str,
-    value: u32,
-}
-
-/// The `SetRegistry` command.
-pub(crate) struct SetRegistry {
-    entries: KVec<RegistryEntry>,
-}
-
-impl SetRegistry {
-    /// Creates a new `SetRegistry` command, using a set of hardcoded entries.
-    pub(crate) fn new(vgpu_state: VgpuState) -> Result<Self> {
-        let mut entries = KVec::new();
-
-        // RMSecBusResetEnable - enables PCI secondary bus reset
-        entries.push(
-            RegistryEntry {
-                key: "RMSecBusResetEnable",
-                value: 1,
-            },
-            GFP_KERNEL,
-        )?;
-
-        // RMForcePcieConfigSave - forces GSP-RM to preserve PCI configuration registers on
-        // any PCI reset.
-        entries.push(
-            RegistryEntry {
-                key: "RMForcePcieConfigSave",
-                value: 1,
-            },
-            GFP_KERNEL,
-        )?;
-
-        // RMDevidCheckIgnore - allows GSP-RM to boot even if the PCI dev ID is not found
-        // in the internal product name database.
-        entries.push(
-            RegistryEntry {
-                key: "RMDevidCheckIgnore",
-                value: 1,
-            },
-            GFP_KERNEL,
-        )?;
-
-        if matches!(vgpu_state, VgpuState::Enabled { .. }) {
-            // RMSetSriovMode - required when vGPU is enabled.
-            entries.push(
-                RegistryEntry {
-                    key: "RMSetSriovMode",
-                    value: 1,
-                },
-                GFP_KERNEL,
-            )?;
-        }
-
-        Ok(Self { entries })
-    }
-}
-
-impl CommandToGsp for SetRegistry {
-    const FUNCTION: MsgFunction = MsgFunction::SetRegistry;
-    type Command = fw::commands::PackedRegistryTable;
-    type Reply = NoReply;
-    type InitError = Infallible;
-
-    fn init(&self) -> impl Init<Self::Command, Self::InitError> {
-        Self::Command::init(self.entries.len() as u32, self.size() as u32)
-    }
-
-    fn variable_payload_len(&self) -> usize {
-        let mut key_size = 0;
-        for entry in self.entries.iter() {
-            key_size += entry.key.len() + 1; // +1 for NULL terminator
-        }
-        self.entries.len() * size_of::<fw::commands::PackedRegistryEntry>() + key_size
-    }
-
-    fn init_variable_payload(
-        &self,
-        dst: &mut SBufferIter<core::array::IntoIter<&mut [u8], 2>>,
-    ) -> Result {
-        let string_data_start_offset = size_of::<Self::Command>()
-            + self.entries.len() * size_of::<fw::commands::PackedRegistryEntry>();
-
-        // Array for string data.
-        let mut string_data = KVec::new();
-
-        for entry in self.entries.iter() {
-            dst.write_all(
-                fw::commands::PackedRegistryEntry::new(
-                    (string_data_start_offset + string_data.len()) as u32,
-                    entry.value,
-                )
-                .as_bytes(),
-            )?;
-
-            let key_bytes = entry.key.as_bytes();
-            string_data.extend_from_slice(key_bytes, GFP_KERNEL)?;
-            string_data.push(0, GFP_KERNEL)?;
-        }
-
-        dst.write_all(string_data.as_slice())
-    }
-}
-
-/// Message type for GSP initialization done notification.
-struct GspInitDone;
-
-// SAFETY: `GspInitDone` is a zero-sized type with no bytes, therefore it
-// trivially has no uninitialized bytes.
-unsafe impl FromBytes for GspInitDone {}
-
-impl MessageFromGsp for GspInitDone {
-    const FUNCTION: MsgFunction = MsgFunction::GspInitDone;
-    type InitError = Infallible;
-    type Message = ();
-
-    fn read(
-        _msg: &Self::Message,
-        _sbuffer: &mut SBufferIter<array::IntoIter<&[u8], 2>>,
-    ) -> Result<Self, Self::InitError> {
-        Ok(GspInitDone)
-    }
-}
-
-/// Waits for GSP initialization to complete.
-pub(crate) fn wait_gsp_init_done(cmdq: &Cmdq<'_>) -> Result {
-    cmdq.await_msg::<GspInitDone>().map(|_| ())
-}
-
-/// The `GetGspStaticInfo` command.
-pub(crate) struct GetGspStaticInfo;
-
-impl CommandToGsp for GetGspStaticInfo {
-    const FUNCTION: MsgFunction = MsgFunction::GetGspStaticInfo;
-    type Command = fw::commands::GspStaticConfigInfo;
-    type Reply = GetGspStaticInfoReply;
-    type InitError = Infallible;
-
-    fn init(&self) -> impl Init<Self::Command, Self::InitError> {
-        Self::Command::init_zeroed()
-    }
-}
-
-/// The reply from the GSP to the [`GetGspStaticInfo`] command.
-pub struct GetGspStaticInfoReply {
-    gpu_name: [u8; 64],
-    gpu_short_name: [u8; 64],
-    /// The 16-byte SHA-1 based GPU identifier (GID) reported by GSP-RM.
-    pub gpu_gid: [u8; 16],
-    /// BAR1 Page Directory Entry base address.
-    pub(crate) bar1_pde_base: u64,
-    /// Usable FB (VRAM) regions for driver memory allocation.
-    pub(crate) usable_fb_regions: KVec<Range<u64>>,
-    /// Exclusive end of the FB physical address space.
-    pub(crate) total_fb_end: u64,
-}
-
-impl MessageFromGsp for GetGspStaticInfoReply {
-    const FUNCTION: MsgFunction = MsgFunction::GetGspStaticInfo;
-    type Message = fw::commands::GspStaticConfigInfo;
-    type InitError = Error;
-
-    fn read(
-        msg: &Self::Message,
-        _sbuffer: &mut SBufferIter<array::IntoIter<&[u8], 2>>,
-    ) -> Result<Self, Self::InitError> {
-        let mut usable_fb_regions = KVec::new();
-        for region in msg.usable_fb_regions() {
-            usable_fb_regions.push(region, GFP_KERNEL)?;
-        }
-        let total_fb_end = msg.total_fb_end().ok_or(EINVAL)?;
-
-        Ok(GetGspStaticInfoReply {
-            gpu_name: msg.gpu_name_str(),
-            gpu_short_name: msg.gpu_short_name_str(),
-            gpu_gid: msg.gpu_gid(),
-            bar1_pde_base: msg.bar1_pde_base(),
-            usable_fb_regions,
-            total_fb_end,
-        })
-    }
-}
-
-/// Error type for [`GetGspStaticInfoReply::gpu_name`].
-#[derive(Debug)]
-pub enum GpuNameError {
-    /// The GPU name string does not contain a null terminator.
-    NoNullTerminator(FromBytesUntilNulError),
-
-    /// The GPU name string contains invalid UTF-8.
-    InvalidUtf8(Utf8Error),
-}
-
-impl GetGspStaticInfoReply {
-    /// Returns the name of the GPU as a string.
-    ///
-    /// Returns an error if the string given by the GSP does not contain a null terminator or
-    /// contains invalid UTF-8.
-    pub fn gpu_name(&self) -> Result<&str, GpuNameError> {
-        CStr::from_bytes_until_nul(&self.gpu_name)
-            .map_err(GpuNameError::NoNullTerminator)?
-            .to_str()
-            .map_err(GpuNameError::InvalidUtf8)
-    }
-
-    /// Returns the short name of the GPU as a string.
-    ///
-    /// Returns an error if the string given by the GSP does not contain a null terminator or
-    /// contains invalid UTF-8.
-    pub fn gpu_short_name(&self) -> core::result::Result<&str, GpuNameError> {
-        CStr::from_bytes_until_nul(&self.gpu_short_name)
-            .map_err(GpuNameError::NoNullTerminator)?
-            .to_str()
-            .map_err(GpuNameError::InvalidUtf8)
-    }
-
-    /// Returns the total usable VRAM size in bytes, i.e. the summed lengths of all usable FB
-    /// regions.
-    pub fn vram_size(&self) -> u64 {
-        self.usable_fb_regions.iter().fold(0, |size, region| {
-            size.saturating_add(region.end - region.start)
-        })
-    }
-}
-
-pub(crate) use fw::commands::PowerStateLevel;
-
-/// The `UnloadingGuestDriver` command, used to shut down the GSP.
-///
-/// Only used within the `gsp` module.
-pub(super) struct UnloadingGuestDriver {
-    level: PowerStateLevel,
-}
-
-impl UnloadingGuestDriver {
-    /// Creates a new `UnloadingGuestDriver` command for the given [`PowerStateLevel`].
-    pub(super) fn new(level: PowerStateLevel) -> Self {
-        Self { level }
-    }
-}
-
-impl CommandToGsp for UnloadingGuestDriver {
-    const FUNCTION: MsgFunction = MsgFunction::UnloadingGuestDriver;
-    type Command = fw::commands::UnloadingGuestDriver;
-    type Reply = UnloadingGuestDriverReply;
-    type InitError = Infallible;
-
-    fn init(&self) -> impl Init<Self::Command, Self::InitError> {
-        fw::commands::UnloadingGuestDriver::new(self.level)
-    }
-}
-
-/// The reply from the GSP to the [`UnloadingGuestDriver`] command.
-pub(super) struct UnloadingGuestDriverReply;
-
-impl MessageFromGsp for UnloadingGuestDriverReply {
-    const FUNCTION: MsgFunction = MsgFunction::UnloadingGuestDriver;
-    type InitError = Infallible;
-    type Message = ();
-
-    fn read(
-        _msg: &Self::Message,
-        _sbuffer: &mut SBufferIter<array::IntoIter<&[u8], 2>>,
-    ) -> Result<Self, Self::InitError> {
-        Ok(UnloadingGuestDriverReply)
-    }
-}
+pub(crate) mod rpc;
diff --git a/drivers/gpu/nova-core/gsp/commands/rpc.rs b/drivers/gpu/nova-core/gsp/commands/rpc.rs
new file mode 100644
index 000000000000..54c40f29e367
--- /dev/null
+++ b/drivers/gpu/nova-core/gsp/commands/rpc.rs
@@ -0,0 +1,333 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2025-2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+use core::{
+    array,
+    convert::Infallible,
+    ffi::FromBytesUntilNulError,
+    ops::Range,
+    str::Utf8Error, //
+};
+
+use kernel::{
+    device,
+    pci,
+    prelude::*,
+    transmute::{
+        AsBytes,
+        FromBytes, //
+    }, //
+};
+
+use crate::{
+    gpu::Chipset,
+    gsp::{
+        cmdq::{
+            rpc::{
+                CommandToGsp,
+                MessageFromGsp, //
+            },
+            Cmdq,
+            NoReply, //
+        },
+        fw::{
+            self,
+            MsgFunction, //
+        },
+    },
+    sbuffer::SBufferIter,
+    vgpu::VgpuState, //
+};
+
+/// The `GspSetSystemInfo` command.
+pub(crate) struct SetSystemInfo<'a> {
+    pdev: &'a pci::Device<device::Bound>,
+    chipset: Chipset,
+}
+
+impl<'a> SetSystemInfo<'a> {
+    /// Creates a new `GspSetSystemInfo` command using the parameters of `pdev`.
+    pub(crate) fn new(pdev: &'a pci::Device<device::Bound>, chipset: Chipset) -> Self {
+        Self { pdev, chipset }
+    }
+}
+
+impl<'a> CommandToGsp for SetSystemInfo<'a> {
+    const FUNCTION: MsgFunction = MsgFunction::GspSetSystemInfo;
+    type Command = fw::commands::GspSetSystemInfo;
+    type Reply = NoReply;
+    type InitError = Error;
+
+    fn init(&self) -> impl Init<Self::Command, Self::InitError> {
+        Self::Command::init(self.pdev, self.chipset)
+    }
+}
+
+struct RegistryEntry {
+    key: &'static str,
+    value: u32,
+}
+
+/// The `SetRegistry` command.
+pub(crate) struct SetRegistry {
+    entries: KVec<RegistryEntry>,
+}
+
+impl SetRegistry {
+    /// Creates a new `SetRegistry` command, using a set of hardcoded entries.
+    pub(crate) fn new(vgpu_state: VgpuState) -> Result<Self> {
+        let mut entries = KVec::new();
+
+        // RMSecBusResetEnable - enables PCI secondary bus reset
+        entries.push(
+            RegistryEntry {
+                key: "RMSecBusResetEnable",
+                value: 1,
+            },
+            GFP_KERNEL,
+        )?;
+
+        // RMForcePcieConfigSave - forces GSP-RM to preserve PCI configuration registers on
+        // any PCI reset.
+        entries.push(
+            RegistryEntry {
+                key: "RMForcePcieConfigSave",
+                value: 1,
+            },
+            GFP_KERNEL,
+        )?;
+
+        // RMDevidCheckIgnore - allows GSP-RM to boot even if the PCI dev ID is not found
+        // in the internal product name database.
+        entries.push(
+            RegistryEntry {
+                key: "RMDevidCheckIgnore",
+                value: 1,
+            },
+            GFP_KERNEL,
+        )?;
+
+        if matches!(vgpu_state, VgpuState::Enabled { .. }) {
+            // RMSetSriovMode - required when vGPU is enabled.
+            entries.push(
+                RegistryEntry {
+                    key: "RMSetSriovMode",
+                    value: 1,
+                },
+                GFP_KERNEL,
+            )?;
+        }
+
+        Ok(Self { entries })
+    }
+}
+
+impl CommandToGsp for SetRegistry {
+    const FUNCTION: MsgFunction = MsgFunction::SetRegistry;
+    type Command = fw::commands::PackedRegistryTable;
+    type Reply = NoReply;
+    type InitError = Infallible;
+
+    fn init(&self) -> impl Init<Self::Command, Self::InitError> {
+        Self::Command::init(self.entries.len() as u32, self.size() as u32)
+    }
+
+    fn variable_payload_len(&self) -> usize {
+        let mut key_size = 0;
+        for entry in self.entries.iter() {
+            key_size += entry.key.len() + 1; // +1 for NULL terminator
+        }
+        self.entries.len() * size_of::<fw::commands::PackedRegistryEntry>() + key_size
+    }
+
+    fn init_variable_payload(
+        &self,
+        dst: &mut SBufferIter<core::array::IntoIter<&mut [u8], 2>>,
+    ) -> Result {
+        let string_data_start_offset = size_of::<Self::Command>()
+            + self.entries.len() * size_of::<fw::commands::PackedRegistryEntry>();
+
+        // Array for string data.
+        let mut string_data = KVec::new();
+
+        for entry in self.entries.iter() {
+            dst.write_all(
+                fw::commands::PackedRegistryEntry::new(
+                    (string_data_start_offset + string_data.len()) as u32,
+                    entry.value,
+                )
+                .as_bytes(),
+            )?;
+
+            let key_bytes = entry.key.as_bytes();
+            string_data.extend_from_slice(key_bytes, GFP_KERNEL)?;
+            string_data.push(0, GFP_KERNEL)?;
+        }
+
+        dst.write_all(string_data.as_slice())
+    }
+}
+
+/// Message type for GSP initialization done notification.
+struct GspInitDone;
+
+// SAFETY: `GspInitDone` is a zero-sized type with no bytes, therefore it
+// trivially has no uninitialized bytes.
+unsafe impl FromBytes for GspInitDone {}
+
+impl MessageFromGsp for GspInitDone {
+    const FUNCTION: MsgFunction = MsgFunction::GspInitDone;
+    type InitError = Infallible;
+    type Message = ();
+
+    fn read(
+        _msg: &Self::Message,
+        _sbuffer: &mut SBufferIter<array::IntoIter<&[u8], 2>>,
+    ) -> Result<Self, Self::InitError> {
+        Ok(GspInitDone)
+    }
+}
+
+/// Waits for GSP initialization to complete.
+pub(crate) fn wait_gsp_init_done(cmdq: &Cmdq<'_>) -> Result {
+    cmdq.await_msg::<GspInitDone>().map(|_| ())
+}
+
+/// The `GetGspStaticInfo` command.
+pub(crate) struct GetGspStaticInfo;
+
+impl CommandToGsp for GetGspStaticInfo {
+    const FUNCTION: MsgFunction = MsgFunction::GetGspStaticInfo;
+    type Command = fw::commands::GspStaticConfigInfo;
+    type Reply = GetGspStaticInfoReply;
+    type InitError = Infallible;
+
+    fn init(&self) -> impl Init<Self::Command, Self::InitError> {
+        Self::Command::init_zeroed()
+    }
+}
+
+/// The reply from the GSP to the [`GetGspStaticInfo`] command.
+pub struct GetGspStaticInfoReply {
+    gpu_name: [u8; 64],
+    gpu_short_name: [u8; 64],
+    /// The 16-byte SHA-1 based GPU identifier (GID) reported by GSP-RM.
+    pub gpu_gid: [u8; 16],
+    /// BAR1 Page Directory Entry base address.
+    pub(crate) bar1_pde_base: u64,
+    /// Usable FB (VRAM) regions for driver memory allocation.
+    pub(crate) usable_fb_regions: KVec<Range<u64>>,
+    /// Exclusive end of the FB physical address space.
+    pub(crate) total_fb_end: u64,
+}
+
+impl MessageFromGsp for GetGspStaticInfoReply {
+    const FUNCTION: MsgFunction = MsgFunction::GetGspStaticInfo;
+    type Message = fw::commands::GspStaticConfigInfo;
+    type InitError = Error;
+
+    fn read(
+        msg: &Self::Message,
+        _sbuffer: &mut SBufferIter<array::IntoIter<&[u8], 2>>,
+    ) -> Result<Self, Self::InitError> {
+        let mut usable_fb_regions = KVec::new();
+        for region in msg.usable_fb_regions() {
+            usable_fb_regions.push(region, GFP_KERNEL)?;
+        }
+        let total_fb_end = msg.total_fb_end().ok_or(EINVAL)?;
+
+        Ok(GetGspStaticInfoReply {
+            gpu_name: msg.gpu_name_str(),
+            gpu_short_name: msg.gpu_short_name_str(),
+            gpu_gid: msg.gpu_gid(),
+            bar1_pde_base: msg.bar1_pde_base(),
+            usable_fb_regions,
+            total_fb_end,
+        })
+    }
+}
+
+/// Error type for [`GetGspStaticInfoReply::gpu_name`].
+#[derive(Debug)]
+pub enum GpuNameError {
+    /// The GPU name string does not contain a null terminator.
+    NoNullTerminator(FromBytesUntilNulError),
+
+    /// The GPU name string contains invalid UTF-8.
+    InvalidUtf8(Utf8Error),
+}
+
+impl GetGspStaticInfoReply {
+    /// Returns the name of the GPU as a string.
+    ///
+    /// Returns an error if the string given by the GSP does not contain a null terminator or
+    /// contains invalid UTF-8.
+    pub fn gpu_name(&self) -> Result<&str, GpuNameError> {
+        CStr::from_bytes_until_nul(&self.gpu_name)
+            .map_err(GpuNameError::NoNullTerminator)?
+            .to_str()
+            .map_err(GpuNameError::InvalidUtf8)
+    }
+
+    /// Returns the short name of the GPU as a string.
+    ///
+    /// Returns an error if the string given by the GSP does not contain a null terminator or
+    /// contains invalid UTF-8.
+    pub fn gpu_short_name(&self) -> core::result::Result<&str, GpuNameError> {
+        CStr::from_bytes_until_nul(&self.gpu_short_name)
+            .map_err(GpuNameError::NoNullTerminator)?
+            .to_str()
+            .map_err(GpuNameError::InvalidUtf8)
+    }
+
+    /// Returns the total usable VRAM size in bytes, i.e. the summed lengths of all usable FB
+    /// regions.
+    pub fn vram_size(&self) -> u64 {
+        self.usable_fb_regions.iter().fold(0, |size, region| {
+            size.saturating_add(region.end - region.start)
+        })
+    }
+}
+
+pub(crate) use fw::commands::PowerStateLevel;
+
+/// The `UnloadingGuestDriver` command, used to shut down the GSP.
+///
+/// Only used within the `gsp` module.
+pub(crate) struct UnloadingGuestDriver {
+    level: PowerStateLevel,
+}
+
+impl UnloadingGuestDriver {
+    /// Creates a new `UnloadingGuestDriver` command for the given [`PowerStateLevel`].
+    pub(crate) fn new(level: PowerStateLevel) -> Self {
+        Self { level }
+    }
+}
+
+impl CommandToGsp for UnloadingGuestDriver {
+    const FUNCTION: MsgFunction = MsgFunction::UnloadingGuestDriver;
+    type Command = fw::commands::UnloadingGuestDriver;
+    type Reply = UnloadingGuestDriverReply;
+    type InitError = Infallible;
+
+    fn init(&self) -> impl Init<Self::Command, Self::InitError> {
+        fw::commands::UnloadingGuestDriver::new(self.level)
+    }
+}
+
+/// The reply from the GSP to the [`UnloadingGuestDriver`] command.
+pub(crate) struct UnloadingGuestDriverReply;
+
+impl MessageFromGsp for UnloadingGuestDriverReply {
+    const FUNCTION: MsgFunction = MsgFunction::UnloadingGuestDriver;
+    type InitError = Infallible;
+    type Message = ();
+
+    fn read(
+        _msg: &Self::Message,
+        _sbuffer: &mut SBufferIter<array::IntoIter<&[u8], 2>>,
+    ) -> Result<Self, Self::InitError> {
+        Ok(UnloadingGuestDriverReply)
+    }
+}

-- 
2.56.0

