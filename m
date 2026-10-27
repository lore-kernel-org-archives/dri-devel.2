Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DCA606A331
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 07:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=kmDP722C
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DD1410F29F;
	Tue, 27 Oct 2026 07:37:02 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011068.outbound.protection.outlook.com [40.107.208.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A4D710E1F8
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 07:36:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AdsWPyLWfi2cpc+FW8T8+JjQJVVCTHFvNFxxbAvZ4stWNOaujgWCbAKN5gWSoPc8s+af2MMz3sL/xWoranYlsIrFf5BPEK7pcyaCwVPdtqQ5Eusy8xyQlK8E3yNIMFhDww/ZWeiVtMdoLM/4uHtG+5/n8timI5Q+zlwmpcFF0behJZv/z+rOmLZBlMVxhfJnJ7qWBejXi1IjsUZAkEIIpc347X0teYl6Fq1azYirrkPev8BKc6h+0Xj3hGq55cX0SSY0PGrcj/S7V6GpXVHx5moqn1PJPkTXOhUBDZrv/X/93GD3/p5Ri9o1B6rCB6/Ngb1sC4CWX8+GI2R6/leZTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPmW/cL12Xsye1mwODi46kltjXliLuKk2FtaVY7Fr7w=;
 b=bNVzXQYr4l/6OVUq3VMYq4V90V+rfYRTPCSGgsdKiUmuOFoETXFOf6Lb88j2vMVnkzi40XqVYMdzXhZdwlEE1w93wrN2t+x3ukEwTnVPFDUJBgygb0uxaTiWJ6o36tBSJFPdeRCmR8DHshTU/3Eln53bnBeRduE4c2eq8cXfa+7ZbSHtng7cJyhzdOhNRbUfdviPZmNxQchp3pHgoQiRDOExmGKmA4oF9ctzxdYdu8phDfLA70BAcSB+TVSrBbFUY0+eoio6/2+tuTNADWXjS4esPm9AQbwebHwaBDHNomx4+gyO+3TKffsMheSo/eaMD+1rQ7p2kZcqRBKEfBhQOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPmW/cL12Xsye1mwODi46kltjXliLuKk2FtaVY7Fr7w=;
 b=kmDP722CYLQe3gpt4NpSQc0A6HLkB/5Shyu5wesjBD3meTcCMB5tni1TGZyjnH515ykKK49Drpc71RBkGVX5antU3SEQQBBQF8l0tavTxFe7pI8L47Z8O8JueWYLG8q6sh0aPwhRQ7X3Q63ytTL+YSgmJozGGVogGboQ8A0YVyNIqRJoPhhUnJ3nx78/KqoLl4vHuKmV+nVfTC3f+ITWiZAdA2wD0ITUv2VQsPe9xb+u3DyJUY5Y5jiYKCF/GrKoxo3hBLVfYec1QUv9hTXLRiS05B7u0An8h1N7svJYAJW73DLig2a6uy427u7P/ddQjno9SiDB1dP4/jn3HpK9Yw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DM4PR12MB8451.namprd12.prod.outlook.com (2603:10b6:8:182::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 07:36:36 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 07:36:36 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 27 Oct 2026 16:35:58 +0900
Subject: [PATCH v6 15/15] gpu: nova-core: gsp: add `rpc` to RPC message
 send/receive methods
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-cmdq-rpc-v6-15-bed9669724ba@nvidia.com>
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
X-ClientProxiedBy: TYWP286CA0024.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::9) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DM4PR12MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ec925b1-c738-4328-f048-08df33fd0802
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|10070799003|261026121527099003|261021123027099003|56012099006|11063799006|261022105027099003|261009223027099003|261022075727099003|261021121427099003|10067099003|22082099003|18002099003|6133799003|261026140227099003|3023799007;
X-Microsoft-Antispam-Message-Info: zfgT5JOQ1Oi1FwWTNzPEA8oC+3UKpvJcLOCoPloLFgV+6O36SU7Ip+tN432fqHUqr9GecGdheONaXO8yeIUlZz29ZxqU+AexZ2M5wnsTUz5HxQYc4NE6LOICW3FFtW+2vbiW+Dl48tN5lyLcgMtNausK7GemtmXqw/hILQwFv+jDWPdLkaMgLcr5VFXz/icASv+kBEDplpfHVuRj+Db0nsxBaZoUqD+HGv1vE96GeegfckhEiBiTQF8WEIowD5rC+Qiq7x8UKbnNJC2cWuE5PLGOsJ9neTLPYeRstC/QPE+yFJFwvUNEG6Uyd/HNX0vVGGIFvlWcUE7/Po4YbJ/h2mVnNI29WopUlNNausFrUXpMIvfCqDwvxp2PFMC6W8GHdgk3gshObtR9Onyi5QUWqgbAs0LEY2E4y01FSJLRDG5O9WAKr9JWJ1AhwBs3VEuoMS7Y+24D35ppr9W86MYgoHMtr9LM41Iz6u033sD5M88gtd3H4yCrkByxY3c2K2df17t0civ8us7bsp8HjfMHu3Qab2ebN+5VNn2X8px6MgyDZJNJkCvp+c8R15w+/6wICK6AKNXbbXHEsvgAx/DUuvAGzQ94OdIC5eGXbIkUiVEoBMAkaH/2//PU5ndvVxT01boCRa6iUcH/sO2cJyJk6NRlL9MeHRqsecXJaeXsXL4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(10070799003)(261026121527099003)(261021123027099003)(56012099006)(11063799006)(261022105027099003)(261009223027099003)(261022075727099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(6133799003)(261026140227099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Risya2h4YXg0VUhiMGUxajFBQnpob3lYRkZpWFczalFUVTVwRDBwSCtWUkhW?=
 =?utf-8?B?RXFXaElXaTRZZ3VWbXp4VHBVSjJDSXFZYUpWUFdwRFZsK1QrcWRnRG4xKzRS?=
 =?utf-8?B?UElXQkVQa05pSVprS1c2b3dyd2drQ2FFdmhqT3JsVXlldFFFYlY4NjNvRnhi?=
 =?utf-8?B?bjlvUE9jZnR6TkYwYjYrbU1hemxZRkllem1GbXlSRmRHOEZvcXpUMm5oRFJ0?=
 =?utf-8?B?MVZqS0IwUHNmVjZxNzNNOEk4S3ZpdWpXT1RXUEtKZlBudDVoSDZLVm9TNXJT?=
 =?utf-8?B?RGtaczhNd21aVW8rQXVKOUJDQmlweXVYVTB1cXhUNTFXRUtUczArLy8zL2Zr?=
 =?utf-8?B?cHFQNjRHMWpsdVhxeTdTeFFySGRLQSt5YjRLbWJ1bDkzZGl3UTU1ZGlzdis2?=
 =?utf-8?B?Vm95Vld5RzBIaW1TNUoyZkxsZXFpdDJQbGVJWGpERHhWeEpnVzg4K1NnVTZG?=
 =?utf-8?B?RUpZOE16WUdnU1ZrRWVpWUNHaFdZUUZrNzQ0THZnemswVFFKVldhV1ZBVmxn?=
 =?utf-8?B?QkZLRDhuZ2JiUUFxTTlUK3VvamRtRXFUeTFDN1ViKysxNHVqcmc1VkJnb0NO?=
 =?utf-8?B?c2JkTWtkLzhzOGVYcUVIRml1d1hZaHVES0N6N0YrcXE0WHVDd1BDcmplMVR3?=
 =?utf-8?B?LzMxc2ZkVHY0dCtUN3NZaDJYQU5iVnZPWVd5SzQ4VFNnYUFOZzVGZEUwUVdo?=
 =?utf-8?B?ZXZONE5sbkpwc1JqRDhGZW1UUGh3bE1EYnkvR3d1d2RzamlxM09ia1RiWUlL?=
 =?utf-8?B?enU1MFhHb2xENUJuQnZpaXdnTzd2VndQRHZDS0VjcEZDQ1hZTnA2NjY3aEN6?=
 =?utf-8?B?a1VMYkVJNHNob3RUOEFqdm90R2xIR2RReU0rWVdiL1ltWFUrRFdjclFWcjJC?=
 =?utf-8?B?UTZyVXd6WmFra1ZDU05xTVQ1UmxTRktId215L2JzVjF3akJCYzVJUlQyangz?=
 =?utf-8?B?NEhzQUFQNUt0WlRpUlAxN0pSQm42Y1pkanBBU2RIQTAvcmJ4R2RFd3JTdDEv?=
 =?utf-8?B?UmtKbnJ4dEgzZWdRT29SL0QzNkVLVVRnQ0Uyek5sUTZrMmpWUitZeWJKNi9Z?=
 =?utf-8?B?M0gvbXpiUW54Q0xybmlOaWVHZ01UekU1dUJObXA5WXAzMnR3WHF4NmsxNVk4?=
 =?utf-8?B?NlFIWmJ3djJlZzBpMFNIY0UycjdlWG1McEh4Mmo5dVVqQzl4aFVkbVMrZENX?=
 =?utf-8?B?MTJxNThkMjZvN0RVQmEvQTBVcll6eVRzOEY3Sjh6ZUlyOHAvU3N2WWlRQTIv?=
 =?utf-8?B?MCsvb2txVHJzQXVVMXdIK3JMSkJlM3JhQ0ZOUjE1U3FObjhpNUZCK1RtTVRk?=
 =?utf-8?B?NGxaVzBuelBKQVdxa2gwamg5SHpDN2ZsK25nSHJSaHh3SlNCTkpXMlpJNnNa?=
 =?utf-8?B?azkrMlIyZzZmZnVsV1hhT3NaOVJrS2FOQkRKVTFWTlZyL054OGsvbFVLZGQr?=
 =?utf-8?B?TGRCMkdnVHI3RzNaVWYva0h5L3dtVER0aFBlZHJrQklBdmZ0ZnNReDRQKzRC?=
 =?utf-8?B?eERwcUI5eHd2OW12S2RIZ0g4Ni9YZWZBTWllc0p5WEhMMTVSUDB4d3NiTkcx?=
 =?utf-8?B?QndvRlNwWnVPRm16RGtCTDBtc0xwZVBaOGZYUExINlBBS3IrRThiUEN4ZTNZ?=
 =?utf-8?B?L0hKL24wRUxzQ2xlcjh5U2JIYXYxM3UyYWRKby9jOUd6TS9nZVFCT2tuS1B3?=
 =?utf-8?B?N3ZRSUtnN3llOEpGRzZMQlBXajRPbW5tdHVpMzJyQ3RPU2pRQlgxclVIcDhz?=
 =?utf-8?B?ckFDOU02THBOQ3NjcXg5VklvSlJjd1d6YWs4N1l6cVprZ0kxYUpzalFzNVJR?=
 =?utf-8?B?TFFmWXdNWE5BREtlVUVVNE9iS1BIT3I1TUlCV2hleFVXUHh3dmtpTzVqTEsz?=
 =?utf-8?B?WTk2THBUd2xxMTBCVnpSQVpvQmN6dWlxRFYzeS9uaUpBN3pZeE91YStTZlN2?=
 =?utf-8?B?bVN3K0JaSGRaYjVYazZUV2E1NEwxQ2RNekVKbmY4ekc2U3NXQjBDeGVYQmJ4?=
 =?utf-8?B?NmVLaGIxeU5iZ2NmMEVhemMwNkFRMzM2TUJDWldnWjJmTXljcm9TTUtIVklh?=
 =?utf-8?B?SmJTS0VWM3RsN2tNY0JsSEQwUnhKVTdzRHViYUJ3d1pvZzNMWENxczJET2J1?=
 =?utf-8?B?cit0ei9QZFNhYlJqZkw3a29wTTZ1eDVnSERZeUdUcU1MaFJ0Wm9jV3FqWHZG?=
 =?utf-8?B?cWZKSG9MKzQybFdFSUV3TDl0ak1nU3llUkt4VjdPSjBGVWlqWElEVWQ1cm1N?=
 =?utf-8?B?VXJ1RHMvbXprVlUwU29hN0E1WlVoL2t4NDZWcXQxSjB5TFVabDdSQmtIWW9Y?=
 =?utf-8?B?Sk94ck8wdUFlOXNMWjhNeVp1dHErL1dWUzhvWnQ0WjhnUUNYU3JTK3p5NnVL?=
 =?utf-8?Q?q5PUY9csD27bChHBmo+cvbeRt+kwzP8qVGQimSnFout+A?=
X-MS-Exchange-AntiSpam-MessageData-1: bL4itj1bTf8YVA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec925b1-c738-4328-f048-08df33fd0802
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 07:36:36.5133 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nnX6GtveUW2l4KrADB5p8IM8zqtpniFfMYeG7XxrLFfBGAAzVurtjv4TXqxaq8gLbZfkDzQeZTzUQBGOO3FrNQ==
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

Since we are going to introduce a second type of message, add `rpc` to
the names of the relevant command queue methods so we can distinguish
between the two.

No functional change intended.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp.rs              |  2 +-
 drivers/gpu/nova-core/gsp/boot.rs         |  6 +++---
 drivers/gpu/nova-core/gsp/cmdq.rs         |  2 +-
 drivers/gpu/nova-core/gsp/cmdq/rpc.rs     | 24 ++++++++++++------------
 drivers/gpu/nova-core/gsp/commands/rpc.rs |  2 +-
 drivers/gpu/nova-core/gsp/sequencer.rs    |  2 +-
 6 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index 75a3ba7d50f4..ed7eef21e8f9 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -221,7 +221,7 @@ pub(crate) fn new(
 
     /// Query the GSP for the static GPU information.
     pub(crate) fn get_static_info(&self) -> Result<commands::rpc::GetGspStaticInfoReply> {
-        self.cmdq.send_command(commands::rpc::GetGspStaticInfo)
+        self.cmdq.send_rpc_command(commands::rpc::GetGspStaticInfo)
     }
 }
 
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 8e446ad1eac2..0d0b07fafd4f 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -43,9 +43,9 @@ pub(crate) fn boot(
         let gsp_fw = KBox::pin_init(GspFirmware::new(dev, chipset), GFP_KERNEL)?;
 
         self.cmdq
-            .send_command_no_wait(commands::rpc::SetSystemInfo::new(pdev, chipset))?;
+            .send_rpc_command_no_wait(commands::rpc::SetSystemInfo::new(pdev, chipset))?;
         self.cmdq
-            .send_command_no_wait(commands::rpc::SetRegistry::new(ctx.vgpu.state())?)?;
+            .send_rpc_command_no_wait(commands::rpc::SetRegistry::new(ctx.vgpu.state())?)?;
 
         // Perform the chipset-specific boot sequence, and retrieve the unload bundle.
         let unload_bundle = hal.boot(&self, &mut ctx, &gsp_fw)?.or_else(|| {
@@ -91,7 +91,7 @@ fn shutdown_gsp(
         mode: commands::rpc::PowerStateLevel,
     ) -> Result {
         // Command to shut the GSP down.
-        cmdq.send_command(commands::rpc::UnloadingGuestDriver::new(mode))?;
+        cmdq.send_rpc_command(commands::rpc::UnloadingGuestDriver::new(mode))?;
 
         // Wait until GSP signals it is suspended.
         const LIBOS_INTERRUPT_PROCESSOR_SUSPENDED: u32 = bits::bit_u32(31);
diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index ddf3f6256222..e6d9a97130ea 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -62,7 +62,7 @@
 use super::regs;
 
 /// Marker type representing the absence of a reply for a command. Commands using this as their
-/// reply type are sent using [`Cmdq::send_command_no_wait`].
+/// reply type are sent using [`Cmdq::send_rpc_command_no_wait`].
 pub(crate) struct NoReply;
 
 /// Trait implemented by types that can be sent as a single command queue element.
diff --git a/drivers/gpu/nova-core/gsp/cmdq/rpc.rs b/drivers/gpu/nova-core/gsp/cmdq/rpc.rs
index 13baf4398632..2c52ec78871b 100644
--- a/drivers/gpu/nova-core/gsp/cmdq/rpc.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq/rpc.rs
@@ -158,9 +158,9 @@ fn write(&self, dev: &device::Device, seq: u32, dst: &mut GspCommand<'_>) -> Res
 
 /// Trait representing messages received from the GSP.
 ///
-/// A reply that [`Cmdq::send_command`] waits for, or an event that [`Cmdq::await_msg`] waits for.
-/// The receiver matches a message's function code against [`Self::FUNCTION`] and decodes the
-/// message with [`Self::read`].
+/// A reply that [`Cmdq::send_rpc_command`] waits for, or an event that [`Cmdq::await_rpc_msg`]
+/// waits for. The receiver matches a message's function code against [`Self::FUNCTION`] and decodes
+/// the message with [`Self::read`].
 pub(crate) trait MessageFromGsp: Sized {
     /// Function identifying this message from the GSP.
     const FUNCTION: MsgFunction;
@@ -284,7 +284,7 @@ impl Cmdq<'_> {
     ///   written to by its [`CommandToGsp::init_variable_payload`] method.
     ///
     /// Error codes returned by the command and reply initializers are propagated as-is.
-    pub(crate) fn send_command<M>(&self, command: M) -> Result<M::Reply>
+    pub(crate) fn send_rpc_command<M>(&self, command: M) -> Result<M::Reply>
     where
         M: CommandToGsp,
         M::Reply: MessageFromGsp,
@@ -292,9 +292,9 @@ pub(crate) fn send_command<M>(&self, command: M) -> Result<M::Reply>
         Error: From<<M::Reply as MessageFromGsp>::InitError>,
     {
         let mut inner = self.inner.lock();
-        inner.send_command(command)?;
+        inner.send_rpc_command(command)?;
 
-        inner.await_msg()
+        inner.await_rpc_msg()
     }
 
     /// Sends `command` to the GSP without waiting for a reply.
@@ -306,12 +306,12 @@ pub(crate) fn send_command<M>(&self, command: M) -> Result<M::Reply>
     ///   written to by its [`CommandToGsp::init_variable_payload`] method.
     ///
     /// Error codes returned by the command initializers are propagated as-is.
-    pub(crate) fn send_command_no_wait<M>(&self, command: M) -> Result
+    pub(crate) fn send_rpc_command_no_wait<M>(&self, command: M) -> Result
     where
         M: CommandToGsp<Reply = NoReply>,
         Error: From<M::InitError>,
     {
-        self.inner.lock().send_command(command)
+        self.inner.lock().send_rpc_command(command)
     }
 
     /// Waits for an unsolicited GSP event of type `M`. Events that arrive before it are logged and
@@ -327,12 +327,12 @@ pub(crate) fn send_command_no_wait<M>(&self, command: M) -> Result
     /// - `EIO` if a message fails framing or checksum validation.
     ///
     /// Error codes returned by [`MessageFromGsp::read`] are propagated as-is.
-    pub(crate) fn await_msg<M: MessageFromGsp>(&self) -> Result<M>
+    pub(crate) fn await_rpc_msg<M: MessageFromGsp>(&self) -> Result<M>
     where
         // This allows all error types, including `Infallible`, to be used for `M::InitError`.
         Error: From<M::InitError>,
     {
-        self.inner.lock().await_msg()
+        self.inner.lock().await_rpc_msg()
     }
 }
 
@@ -348,7 +348,7 @@ impl CmdqInner<'_> {
     ///   written to by its [`CommandToGsp::init_variable_payload`] method.
     ///
     /// Error codes returned by the command initializers are propagated as-is.
-    fn send_command<M>(&mut self, command: M) -> Result
+    fn send_rpc_command<M>(&mut self, command: M) -> Result
     where
         M: CommandToGsp,
         Error: From<M::InitError>,
@@ -379,7 +379,7 @@ fn send_command<M>(&mut self, command: M) -> Result
     /// - `EIO` if a message fails framing or checksum validation.
     ///
     /// Error codes returned by [`MessageFromGsp::read`] are propagated as-is.
-    fn await_msg<M: MessageFromGsp>(&mut self) -> Result<M>
+    fn await_rpc_msg<M: MessageFromGsp>(&mut self) -> Result<M>
     where
         // This allows all error types, including `Infallible`, to be used for `M::InitError`.
         Error: From<M::InitError>,
diff --git a/drivers/gpu/nova-core/gsp/commands/rpc.rs b/drivers/gpu/nova-core/gsp/commands/rpc.rs
index 54c40f29e367..156357dd48df 100644
--- a/drivers/gpu/nova-core/gsp/commands/rpc.rs
+++ b/drivers/gpu/nova-core/gsp/commands/rpc.rs
@@ -190,7 +190,7 @@ fn read(
 
 /// Waits for GSP initialization to complete.
 pub(crate) fn wait_gsp_init_done(cmdq: &Cmdq<'_>) -> Result {
-    cmdq.await_msg::<GspInitDone>().map(|_| ())
+    cmdq.await_rpc_msg::<GspInitDone>().map(|_| ())
 }
 
 /// The `GetGspStaticInfo` command.
diff --git a/drivers/gpu/nova-core/gsp/sequencer.rs b/drivers/gpu/nova-core/gsp/sequencer.rs
index 9f5ab08def2c..23b09fb875e9 100644
--- a/drivers/gpu/nova-core/gsp/sequencer.rs
+++ b/drivers/gpu/nova-core/gsp/sequencer.rs
@@ -343,7 +343,7 @@ pub(crate) fn run(
         libos: &'a Coherent<'a, [LibosMemoryRegionInitArgument]>,
         bootloader_app_version: u32,
     ) -> Result {
-        let seq_info = cmdq.await_msg::<GspSequence>()?;
+        let seq_info = cmdq.await_rpc_msg::<GspSequence>()?;
 
         let sequencer = GspSequencer {
             bar: ctx.bar,

-- 
2.56.0

