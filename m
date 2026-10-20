Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBD6606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 10:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=PILFd0D9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9092510F492;
	Tue, 20 Oct 2026 10:09:39 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010005.outbound.protection.outlook.com [52.101.61.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7553610F49B
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 10:09:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GJba6r5HzzPq3aOcTnT4QWXvnoBou9uaF7+/4ZPeEbQlLPb+tQlKwQISnq45yQuAR3TEV5ORCv+4KmBmreCu2wN41FaL8h0b4wwr4QQQ41mBW6tHIcAN5Si3wVN05z3L0gDzcX1nJR+EcSMa4XdBw6guCQlEeitz5nS2C6ZMc34gdrlhJE5X3ltQEMU+3hIioGSPgHN4+CzUaSd92dJl/6YE7dZs1/4M19E2U737g9oT5/tqnHrNeKkTV7wbiYG+ng2E6EuZlK5qJKXIcQzX9ohXtZZDauvc6W7NA5RgT69KOZDy0iP9zIUj/CI/aiBeThPl1f3xO4NrzvfZfqU8Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5qnArfsYkEPr9Oc7MS4hkZaCEaeK4LjfRwj4bb3Yw4=;
 b=oUfewd236ir9mhHDdMyqtwBIS9j+Le78+CK7HAPdVPYFStkDvAg9aEpkQwd3ZnSzcizKXZ5pSj9bj3wXRFg2aNFFYh35aiOLIUummizKWyuq+agJvhwWhvr1VcV87+4XGetATldEPbMlVBiJsE6QYZmD+uFFJViZ+/af5fFO4lSeNHLDqcL+iw3SHI5vNHU6H0ULMlyCDMMGDfFkpabRYUPnhcEsd/Un+Ksvx8ipPKJTzWVlr2h9qNOLwKGLr9y+vloIJ6zckdscXuPMAoKh0HDKvUUGjYE56bVNxy/1gRqiv9HLsObWlgclTyTB25l9QvTOjdaNHfsXawE3KG7XbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5qnArfsYkEPr9Oc7MS4hkZaCEaeK4LjfRwj4bb3Yw4=;
 b=PILFd0D9DxpE5Wv1gOj8gJStsIh1xII+62QNgQIJgrWffflo8nuTM2WALTW5T/9eXAMnYKG8yN9zBawHpGFHvFdjzN1ObMZ+ofATcUQf3omONdGOsSRDYU/2EL+NyVfiOvHaKPDfwN27a2MQ1qk/7PgaRShLTIw+8qfv7BqNQ07x4N2s4wSi3IZJxokKolMD+TbuUSTHmBzOjaXtYERr/VNrf8mZ0LakxqhXmkBffT8JoC4eJPzev7NaX8CU2rICfwZDsXZ/phJC/vQ2iV6w+B/2FrjIuPnms8xvskfJVedVkdESgyfGneNc2VX/wWI+9nfGeErkzhad3XYvS0O4TQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SN7PR12MB6862.namprd12.prod.outlook.com (2603:10b6:806:265::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 10:09:09 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 10:09:09 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 20 Oct 2026 19:08:34 +0900
Subject: [PATCH v5 13/14] gpu: nova-core: gsp: move the RPC commands into a
 sub-module
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-cmdq-rpc-v5-13-dceeb8f360ec@nvidia.com>
References: <20261020-cmdq-rpc-v5-0-dceeb8f360ec@nvidia.com>
In-Reply-To: <20261020-cmdq-rpc-v5-0-dceeb8f360ec@nvidia.com>
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
X-ClientProxiedBy: TY4P286CA0100.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:380::18) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SN7PR12MB6862:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d409619-5fec-43cc-fe6a-08df2e922eaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|23010399003|376014|10070799003|1800799024|6133799003|18002099003|22082099003|10067099003|3023799007|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: KZHbCla0fpu1+P+ekGaBwZAoSEXiX+CSsiZAc16vfzQqYqh1YBx+AggYvzs76/4G7vrPFDeNkXy+ekbDKbRC15959K+cUPcYz28WnjxWIDCx4uwWmYZ9aXmE+i5kv+4cTmhEPX8aGXZRy3DbMopyQD/Hq7Lcz57gbt4V1CjHa4FlFJ3DnCMIeCNDeY+kUa2+cZUqw+ckvWeQLFEPMT27y29k/gkUzX0tDGThL0ZagVTRSTSZYmap9vJah0v3kzJmjWsL+MaeU6bXd8c0d38LMynP09YkTdEMR4aDP2uPsErA9tjr1eEy99pVDk9xtnyBPEQle1Ao+5Fh7q/xulwXvS6BxaSTATgmayMJYvtC4x2nyJvm3JFZaJ5KXzT2GgC4uyTalyEJWSAP4itFRMjPbyVMhnkQX0HCiK/uRo3afCblHowFV/+IvFD7bXrMqD6sHNBRc0RZSqENARn2oyptF2+Renxlka1+F63d8Wg7IDi685yvXvIvFqvvM2f8TYU9VF1B0XQygApvyAD4u2Q80sUswZtetjvB0pD8AEhMd0wHEiodOJX76ZFSZNhWHFbwMVzAogWUv0MboiVPplReLdc/aSFsqJ5NKq4EoAtELkjAy93LzKxqs7JId/4PgZeO3U0G6p99215HvIPeV242v8SeBilpJR7nXadJ0rA57hY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(23010399003)(376014)(10070799003)(1800799024)(6133799003)(18002099003)(22082099003)(10067099003)(3023799007)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVA4SWFnZVVZd3hlTk1oQjk2VXVQV1pQK1BoQW5RY21halZvNGMweHAwSTd4?=
 =?utf-8?B?U2ZyYTVJYUNiT2k2Z1crUzZoTWROaUIycXFmdlpDTEdsN3NQUU0xcjZicEpQ?=
 =?utf-8?B?Q3Q1MFc0L0xsV1kybzBIdThUOExpOEhUNTBSS2Y4TTloYTJrYlMzQnVRWncr?=
 =?utf-8?B?R2c4UG9sVTVlZFdYVTdWaU56K0MxT0tGZkNscVdIRHYrcGROREZWUzRjT1F0?=
 =?utf-8?B?NXFCREM5aktuZ1lKRnFzVExsQ0NNSXRrYkc0Y2thcmh3M1dYQkE1VGN6bGl2?=
 =?utf-8?B?VkIrQ2tTMmtUQ2l1em5Gc3A1U2NScDhhaFRBcDJ5TUhwMFcvS2ZKVzFoNU81?=
 =?utf-8?B?LzB3bGQrbnQ5RmlQVE1VVE9CVStrRlNOMWxmUVFrbVFvZ1Q1QTlkMjMrcGlS?=
 =?utf-8?B?cXdkVUFzN2U1MUFsMGxxUktvM2FaRlhRYWIxYldhck13WW9FUEQ2aTBTc3R4?=
 =?utf-8?B?UEhtS1N5ZUUvNVpZTzdnR0lzb1F6RVlaemo4bzZSUWtzaFErWnBjL3BrNlZ5?=
 =?utf-8?B?Z1dDaU9qR3UrZ2E2TUZKYXZZU0tDS2VHWXlTTmpmck8yZWZ0YW1tQkpOK05o?=
 =?utf-8?B?czZFQ0lGUk0vbjRiKy95dTdHSklmaEpOWWVjWno0cSs3aEN5YThaeGtabEZT?=
 =?utf-8?B?TkMyNWNGdWRSZFFGVVlzY0drRUNkd0VNdC9oMkRmSFFyVWlhcmRvZHFqN2Fx?=
 =?utf-8?B?OTZMUkQ5SXFTdktrWlIxL1AraWdEV0g5SHpKMXNqNFUrdUhOZkdwWDhmRXRG?=
 =?utf-8?B?OHRyNitrSnVDNFB4U21hTXI2T25JY1dOaFpNeEhYMjgwSlZHQitHWnhsMzQx?=
 =?utf-8?B?MzdKK1JVL0NEOEIvenFzT1hWVWZKSDNha0FRbCtEellvWnBJSDN4cU50YXYx?=
 =?utf-8?B?N1NBbEVxVDBlOEhEVFliNzViK0FjUCtxYkJWZUdqQS8vY0wvNUI4cHZXTXRI?=
 =?utf-8?B?Mm9mVFMyZjUxbkxWd2dnSkVFTUhUY05TaVZnRGtWc0x0M1l3ejBIcEpiUHZt?=
 =?utf-8?B?dDlRUDhUT1JhTUpXaTd2TW5VeU5KMVN1eU9ERzZsNUo3OXBqMk5CZEdOclpB?=
 =?utf-8?B?N3pkSW5aS3BMOGpQcjhPaElaaEJnb3laUDdZNnVzUDZLTXhLUEtEUnoyaWlH?=
 =?utf-8?B?aUJRT2NJYWkzMnZCUXViSkh5Z2lZVzlmZnpBRXdwTG95OEZEa0l1emkydkUr?=
 =?utf-8?B?VEZIbzhYakZVZkRTYkpyWHk1YW9KVjU4WXlaa2E4bXkzNTlqYTY0djVhNUtq?=
 =?utf-8?B?WDlpaC84cDB3cHB0K0YySmVzNkxtNldwZVlZeWJRMW50OUhDWjgwMVBDOHV2?=
 =?utf-8?B?Y1VWckp3QXFYNG5leEtlc0FMVDlGejFXL1ZhMXp2Z1VlaU11UGd2U2p2OVhQ?=
 =?utf-8?B?K0hxVjRZV2hzMG05S0ZkRVRraUpKcmJteUZlTitFSDRkM0kzNGl1d0ZIRjlG?=
 =?utf-8?B?SjJjMFkwdWNmaTgxSDYxWmhCZGNaT3hselVCQUxoVTVTaitzby9zZVVDNmZi?=
 =?utf-8?B?S3I4NURXUW1rZFBaYnJQMXRrUTgrZkxVUDdkYllPd1RjTzNxM3FMZGR5eWg2?=
 =?utf-8?B?OFhjalVnVjZVejQ2SFhHVEE2UE5XWlJ1R3BNT2NvWmc3V1lrWm5NNDZiL2Fj?=
 =?utf-8?B?a3hFa2w0Skk3aHZxU0ZlWkE5UXVrdm5LN0ZMV1E5V2lHc3I4VjhqZjRYQW44?=
 =?utf-8?B?Z0t0RVlhT3FTaHhiQ0JMR2FYOEhGY2NUaEVVc1I0bXBoSHh2U1RpUk9hdlBV?=
 =?utf-8?B?ck1mVzU1alpEbVpzcXZ2ZUVjQnI2b3QraGFkZjdCSGFjREtXTk9sVTdXeWI2?=
 =?utf-8?B?MnRDR3pzYzMzQldoNDZORkkwQ21tVU9ER205c2M0cldXNmt5a01YT0lXYWw2?=
 =?utf-8?B?N1NwY2xMbGFuZnh1NDFldk4wakZRNGZEeHdQK0RGeEtRcEJUTHFHRTVvUHZE?=
 =?utf-8?B?SXE2ZE1XNm4waEpROGdYMEVNK3ZDL1hyQ1hubEI2cWlYaTNsMzNWcVh3TGJG?=
 =?utf-8?B?R2ZCMlNBeWZkelJHTlNFRnZBTFpzU0RtaWZ5UUNmQzN2NjcveGZpQmg0TkRD?=
 =?utf-8?B?NmZ4SER6OHdEQnF0QkpBZVc5MWlRZ3YyaU11NVR4ejQrcEdSZGJFazlKd0Uy?=
 =?utf-8?B?NXJWcWhPbjk4UHJ1MjVDeVhWQjFJdmhwM3hzamhyNTFyU1lKaWlFQS96b1Ra?=
 =?utf-8?B?aW5yb3hFbTk3bnloenE0c1RmTFBBQk1YR3NTNFNoVFd3NHlWU0w4ZGtDbkNh?=
 =?utf-8?B?RXlMKzhEb3VrVU5KZzQ1QUZWVEEramwyT3dweStZNnFsVFJDVmMvWndNaStq?=
 =?utf-8?B?YWdCMTdGMHpCY3J2NEZKZUxtLzZXL2dKdXBNTnNnMTcvbUoyaFM5MGNTYUZF?=
 =?utf-8?Q?2P+/poHCJRHOrCrNOggLDKeJAHYV1FVT/ffX7h0mm3+XF?=
X-MS-Exchange-AntiSpam-MessageData-1: gNsbO4ZKmJzc5w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d409619-5fec-43cc-fe6a-08df2e922eaf
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 10:09:09.5609 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RTyr2iJ2Bb+KGRFcHLk9bKyUUsSe7GTmPw1FX8ooA19mDufAMAVbTJFudaJtuG29edBqN0+nA9mg675OQoqUQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6862
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

