Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C86A9C98324
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 11:15:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D48F810E57D;
	Sun, 27 Sep 2026 11:15:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="s07GPqd8";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010037.outbound.protection.outlook.com [52.101.56.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A6C010E54A
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 11:15:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SrGG2LazteDT1ZRzj4wVZ+ZXgfjgkH+RROfsRPDFC4khoRSfFfLVAWGancVOWrmjpbPpy+LIfEIDiUW4D0RAu+24yu1a8FrHAqyiD8lwqDZ4aiIAHAChZNe4/FQxZD4/pa8+qPjCzGp3T30laOI252nyCygNKait2/zmC4y7oGjklEPy73GqfTTadybytEMiWr3C7cxZ6JsQbyHOqGhI4a8v7yKBMXKn+lLmTpkyo6y9jA6PeSEbJCIv+6xSg4vODxU7v5gIJ8tAhMCWAs9RjPpEFhLqqbCjpsT7467A1y1/mLiSiFnphmPWdxUzefeGiZYk8uurRue2gEyrggVTXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rd2wrTncN4iYab2ghP93bX6ow/+czgZBbtXHT7hn0s=;
 b=Oty0jFIPEz3pPHZG7AC/lRc4m/oJOYNEnUgHhVUj4TKOgcCcq42hMbe0RlV00QWqVhBjucQE5aChT/XZ8MfOqSAGm29qpu4HHWu4/QC/aaAXziIZpq1D5FYjYbeLZ6cTLX8BzSZXx2w4wlyiQe33tWIJ9ezyefZXez7PKoQ82+41VaVoVGes4hdhyspN2cu2TJlXufl4/HjLq5nMZaECcCNYdPJkMaPNbk7AazQg6DKxPU/tf9Sw+GK1Iqsgsgd7qmy9UawefqXU/Bq6j5YlrBRJdw/VsduMWZsczUbd2qeRi8F0NaZw7rRd49fQvlZWH5pqUVLINGxWST7W0wMy4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rd2wrTncN4iYab2ghP93bX6ow/+czgZBbtXHT7hn0s=;
 b=s07GPqd8Tc7QRexNNjEH1RcCK0Lz4iyHCTevMQlkazMGFvUasS7O/4o/s4HqP1YxJsRkooB+BIMMoayhLgXaQ6IzaKg+fBqpqTHO62BH1SSn8rOc336QWQfGq37cJ9Njxxn/jEbosRVCW3HWqvSxhHHBChFX8mzFifVV1dHcDdbk/YgiNUj/yTbddJBZ39upU3xz1mttTPI4VVmfBzh8HbMgIix7ZpfhDGdbHM0sPKmiZ4VDSgv1sw1T1U21D8xogvtGOBChGumebirdb6QVFOmCey2IgSDUzhYwRKAWm7Sb0S5xxzdz7JUmDoUBs4nQ7xJqSCcdZv6vDOBuRMO73A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by LV8PR12MB9154.namprd12.prod.outlook.com (2603:10b6:408:190::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Sun, 27 Sep
 2026 11:14:56 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0451.022; Sun, 27 Sep 2026
 11:14:56 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Sun, 27 Sep 2026 20:14:31 +0900
Subject: [PATCH 09/10] gpu: nova-core: gsp: move the RPC commands into a
 sub-module
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-cmdq-rpc-v1-9-822db5af910e@nvidia.com>
References: <20260927-cmdq-rpc-v1-0-822db5af910e@nvidia.com>
In-Reply-To: <20260927-cmdq-rpc-v1-0-822db5af910e@nvidia.com>
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
X-ClientProxiedBy: TY4PR01CA0051.jpnprd01.prod.outlook.com
 (2603:1096:405:372::19) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|LV8PR12MB9154:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c3ee3be-52fd-45c3-7592-08df1c888f75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|10070799003|23010399003|6133799003|22082099003|18002099003|10067099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: ngCC70eG7AmtcZVCeHBRSaANceEnegrWA0N4jlTw2qwHhrhLFmPeZpYPX1c6SZ7mScXWl102ACpDK0dfoHDatltnlxwdWHwc62Q6RD1PGZk2cRVkan+xt7rS49CSJPaWb0BIKeoc8+uqHLwdGoKIgqG8cfAGltuVHXgJwu6rRZtPrhpVPpmFzbiyRcmZ/JjNF1aV7lGdcLbBz/nDgQKofRFrqYQxRTYf+eF/1vTzDfd64yz6ynGgEQjqHeR/94+sxgUzGuzJ6LzMhDBG2I+94kFzLYa3wGteY5IHtnThsoWz3xxGF2fHSQwwIVvBT5gGg81h5Yy7X99UbRhBKODl/Go+HHoixZoCBK9zozFFCRDJJZrERvJyiC9fLhCCZ4zQLDgvIVKtw0APHYMSnj0FQWcGK6N8T3pvYQ9LIqYDtbUkA6eiXajeS7GhVxzaoOWCkgLWMb7r0UL5kTybGiaWQKjoiXUqHjePvVzIygVJWAFnW15ps5b4QTKxWpLL2EdM01Spmht5P1+awMKWz7dIrt2ZB8f4eWgsesH2M3P8ZSmagQOJ+xt+PJMbBeBvIFnFWY4LWuweAv4ZMvdeh/A450CXCat3GDGPVTM7j67wrixHhiFrlWikcAr2HNkvfE8diG3DUhuDSiK8RxQdnrTZHU1OuGNz1WeZCercnenUeMI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(10070799003)(23010399003)(6133799003)(22082099003)(18002099003)(10067099003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTBkaTdkM01RQlJ0bFRZODdzV1FFdW1uMGpCb24yM3d4UHlUK040aThMeE1z?=
 =?utf-8?B?dWhlRDlNOW9DN0hkOUJrT1JjVldjRjZSS2s2elBjTmEwSFJKcHRocmJJK0hH?=
 =?utf-8?B?U3lkaDBGdVFYS0s3dWRKc3ZiYzJUd1FZSDRZU3lLUEtXSFk1dS9KSmFLeTg3?=
 =?utf-8?B?MFYrdDV2N3IyUzJGNFJ1Y2UvWFBFbkI3eUVpTGJOaFVvczQ0RzNjUTFsa3g5?=
 =?utf-8?B?ZUIrQWFqL2x2MFBxNU5ac2t3K3kreWErM1czcGJZcENXMXBuNWtGeGVMUGZV?=
 =?utf-8?B?dlZIQnZRRDFLcW1Gdml1bFp6ODlvZ3ZrMkRBSzBtTmZLM05TS1pqaEIzOEZj?=
 =?utf-8?B?UVVKUkJsdXRGMndHUXQyNXNHQ1pHbjBsbXh6VkV3bmR3UnRHazl3MlBqQVhQ?=
 =?utf-8?B?SWhZaVVYOFlvc1l2cy9OS2JFbFlPR2p2M29YWW94akxuaytkSUxBRzk4WHh0?=
 =?utf-8?B?UGZMQjA0WldsS1J5SnRYd3dYcVBqdWQ4RkwrNmV6QmlCMDZvTG5VZE95ZmJD?=
 =?utf-8?B?TlgvdHlQcDBybGVrVHJtQnFnM3ovSDZZcTl5WkZEeEppSDRWSDc2cGx4cDBx?=
 =?utf-8?B?Nzh3cDE4b0UyUkV6dTlSd1VndEQ5VmZYUTJ2NzFHWW41enVVUU11OWdxZ3VL?=
 =?utf-8?B?YWJiTUJpUjZwcGF0eW5tNG1JQllxSkhpdXJicUc4VkFuV0ZKM2ZQY2VmcUpF?=
 =?utf-8?B?M3M4K2FCdE5ZYXRISFl2cUFxWXNKdHZNSk5IVVBPN2JMTWk1Y3E1S05FOUFI?=
 =?utf-8?B?ZWhJLzhudjM3WGl5d01vK0hWbmFMTWdNbzJVYWh5VWhzdDBkZ2tJWnRLN1JS?=
 =?utf-8?B?MlVLeDMvaFF4a1NPRFp4QWZaM09VcHR5RUIveHppR0x6cEYySkF0cVNpZlh2?=
 =?utf-8?B?RmlzRlVGRytDRmU1UFBLaTBjd2krdFN4NGRhUTBlV1JyUExqYTRlNTA4VVZF?=
 =?utf-8?B?UWdwaWtFeVI4Q1JLbzcxcVJrb1BRRjJvTk95RHpWajk1UGRkbmdDMFlQci9u?=
 =?utf-8?B?ajVic3B5cWVWcS9vYVZsbUhuRjhLQlRvMU5OM2dLYnY0bUFmUjR3UmF4WDBS?=
 =?utf-8?B?NW96OXVIRjJINVhFUWh0WlJ4b21hdkhSSjAvZk1mUTlMd2ExVWk4REdZQ01h?=
 =?utf-8?B?eXhkSEYrNFFFWXUrMmpmTnppSVl6eFpxaVF2TEpWTkFiR2FXOXBCVUR3NHBy?=
 =?utf-8?B?eDJXOUdoQW94emFwWk95SVVXcWE0cXhobU9EaUZMQnRjZnNkQXUrVnJsMjhT?=
 =?utf-8?B?Wi8rVmswb29lZFZ5Z3ZNZTBOK3BVRXV1K28yTmNVbU1wUXVPUWY3ZnFTMU8v?=
 =?utf-8?B?VkJOK3FWam5hS3VlbnlKQkZPZDRVbHNoUjNOdTk5NG1OcXkzQ2ZIVEU2bWJj?=
 =?utf-8?B?Z1lYcS85U0RhVjgwUVNjQSt2WW1OU2FUYmlicUFIcVZCdXJRUUNzKy9zRkRX?=
 =?utf-8?B?SVhUY3JsdmhuUmxTbjRXak1vajY5V25sMjVVVlh3NlJXQ3BxczNjNzQ3aTF4?=
 =?utf-8?B?WXlBbDFKNjNuTzdSSEFJdFFlRU14RDFnNk9QSDBxdXRHbzBXdEpuOVRKcUNZ?=
 =?utf-8?B?NVdpWEtyZGpJQ1FHTVRCMlc5alpsZ1ZsY3c4RjljbXQ1UkNZdlVQc1BMaENZ?=
 =?utf-8?B?bXczOVpORGprRklHNnJOTjUwRnd1Q1Nab2IzT2tBNGdneEVrTnVieGE3MXVX?=
 =?utf-8?B?R2lacU9hTGhsRkVPUTZzS2xrTi9tSzg2anVuTHk5NU9EUTkzTDF0VDlVM1Vv?=
 =?utf-8?B?RE90OU1PeXd5dTlwU04wRnptRWFvQVBidXVVZkJBcXZQcmpuVTdjT2c1NEZu?=
 =?utf-8?B?Z2crcHNlNE15YStqM1VmMytKUVprY29JYlhmV1drUjNRc2tSQ3NyK1JleUtR?=
 =?utf-8?B?MXFWUnRJZk5uNVdpSSt4dXpDa0RPNk9FbW9BdSt2STlPcnN2Q0d0ZzBmN0Qz?=
 =?utf-8?B?RlJ0VjFzdzhaWlZBeFBoQlIxZ1lEVjA4aGdSVnlZNDJHRnhBdng4eTJaUlFZ?=
 =?utf-8?B?SFYrTUtPcWREVE45QjVlNW9EZXZNVTRpVTErMXQ5M1Q1V1BycExHMEFpdnNz?=
 =?utf-8?B?aW03Qmpad05kR254eHFDMmlCbzEvSExJTDVrOHRweEtPbUQybjlsMHdDM0NJ?=
 =?utf-8?B?ZlQ5YXpxbmhUeXdkR2lLeGpKbHRZYVQ4UTNhT2E2dEl1bzdDNjgwNkplZ1du?=
 =?utf-8?B?ZXdKZUY0UWp6ZUJKK2lOa0xDd3FXazdyajh4Rmw1TFd3VGV2TW5IVVRyTWw1?=
 =?utf-8?B?UlFCd2F4TXBjaFBqV0dYQUVHNWZNM1hqVC9kMlpWc0dzZHJXMWIzcXRGUnp1?=
 =?utf-8?B?cUd4REEySjRsL1VLdEIzMkVSOGRlUHRCREZPdi8yUmZvaGE2WmNPL3JnZW5q?=
 =?utf-8?Q?/l6+nQieaczkfkLyZXFsnKLD5eMZ9ZIroRGmWpdbD2uJZ?=
X-MS-Exchange-AntiSpam-MessageData-1: 6nL+haImJmuoKg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c3ee3be-52fd-45c3-7592-08df1c888f75
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 11:14:56.2590 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8jTcUmquF6y+A8mjdW/fy96oHG1eR+L0sxfb+joYu1kxBfdN//hs7C7Ge3MlFw9r2pPWO/C4r1UjRHbgFMPQ+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9154
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

Move the types and code related to RPC commands into the
`rpc` sub-module, and update their users to reference them from their
new location.

This is a pure move commit, with no functional change intended.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs              |   2 +-
 drivers/gpu/nova-core/gsp.rs              |   4 +-
 drivers/gpu/nova-core/gsp/boot.rs         |  12 +-
 drivers/gpu/nova-core/gsp/commands.rs     | 314 +----------------------------
 drivers/gpu/nova-core/gsp/commands/rpc.rs | 316 ++++++++++++++++++++++++++++++
 5 files changed, 326 insertions(+), 322 deletions(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 8f30186f10ba..b6c691361895 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -34,7 +34,7 @@
     fsp::Fsp,
     gsp::{
         self,
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
index 81bd457a6eb6..5f1c944678be 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -1,316 +1,4 @@
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
-    loop {
-        match cmdq.receive_msg::<GspInitDone>(Cmdq::RECEIVE_TIMEOUT) {
-            Ok(_) => break Ok(()),
-            Err(ERANGE) => continue,
-            Err(e) => break Err(e),
-        }
-    }
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
-pub(crate) struct GetGspStaticInfoReply {
-    gpu_name: [u8; 64],
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
-            bar1_pde_base: msg.bar1_pde_base(),
-            usable_fb_regions,
-            total_fb_end,
-        })
-    }
-}
-
-/// Error type for [`GetGspStaticInfoReply::gpu_name`].
-#[derive(Debug)]
-pub(crate) enum GpuNameError {
-    /// The GPU name string does not contain a null terminator.
-    NoNullTerminator(FromBytesUntilNulError),
-
-    /// The GPU name string contains invalid UTF-8.
-    #[expect(dead_code)]
-    InvalidUtf8(Utf8Error),
-}
-
-impl GetGspStaticInfoReply {
-    /// Returns the name of the GPU as a string.
-    ///
-    /// Returns an error if the string given by the GSP does not contain a null terminator or
-    /// contains invalid UTF-8.
-    pub(crate) fn gpu_name(&self) -> core::result::Result<&str, GpuNameError> {
-        CStr::from_bytes_until_nul(&self.gpu_name)
-            .map_err(GpuNameError::NoNullTerminator)?
-            .to_str()
-            .map_err(GpuNameError::InvalidUtf8)
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
index 000000000000..a3262cc3e0e9
--- /dev/null
+++ b/drivers/gpu/nova-core/gsp/commands/rpc.rs
@@ -0,0 +1,316 @@
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
+    loop {
+        match cmdq.receive_msg::<GspInitDone>(Cmdq::RECEIVE_TIMEOUT) {
+            Ok(_) => break Ok(()),
+            Err(ERANGE) => continue,
+            Err(e) => break Err(e),
+        }
+    }
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
+pub(crate) struct GetGspStaticInfoReply {
+    gpu_name: [u8; 64],
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
+            bar1_pde_base: msg.bar1_pde_base(),
+            usable_fb_regions,
+            total_fb_end,
+        })
+    }
+}
+
+/// Error type for [`GetGspStaticInfoReply::gpu_name`].
+#[derive(Debug)]
+pub(crate) enum GpuNameError {
+    /// The GPU name string does not contain a null terminator.
+    NoNullTerminator(FromBytesUntilNulError),
+
+    /// The GPU name string contains invalid UTF-8.
+    #[expect(dead_code)]
+    InvalidUtf8(Utf8Error),
+}
+
+impl GetGspStaticInfoReply {
+    /// Returns the name of the GPU as a string.
+    ///
+    /// Returns an error if the string given by the GSP does not contain a null terminator or
+    /// contains invalid UTF-8.
+    pub(crate) fn gpu_name(&self) -> core::result::Result<&str, GpuNameError> {
+        CStr::from_bytes_until_nul(&self.gpu_name)
+            .map_err(GpuNameError::NoNullTerminator)?
+            .to_str()
+            .map_err(GpuNameError::InvalidUtf8)
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
2.55.0

