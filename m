Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA54BEC01CC
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 11:08:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29A3610E4DC;
	Mon, 23 Mar 2026 11:08:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="UtYfk2WN";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013054.outbound.protection.outlook.com
 [40.93.201.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D47810E444
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 11:08:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OAnrEuUVBf6QVFjBv57/djrZzjT788j2PVw3qRn7lKQR6AJ8W6dC+EwqtncXy/PHqaHVqhOSBQXD8eECIswJzBHuWD+qBmatsnt76hgHFExHsuoiZcOsH8fM/Hy9h2L+vVIGnQWgV09DbzloIPRfImHj2pIoo33MYW+FXwwEHrUdQ++eZdUym5gGLSG6BCigZzM7naF1euoggX+vUqlYtuW2XsZ+/kakeTP0IlFvMg2BzIAMxLsIx6Yrsmw2BWDHRv2It2TZy3vqoyRE5M2DecIxVeXPn1i34J2UBBsDNEfe5pXMXClRlzK+jSmy2qQ3LWzCc+h7fJKAWlLkY+lHAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DtCy3JjxfDTz44vuIpnRs4XDZc1gwoMIAnOSORjFnE=;
 b=f5a/lnxxA5qbWT2YWfy1eaPamcbKljkxnlol1a7EG5dduqi+uRScz5Ypyl/ufy83k4ucMNE4wYJAHGo2ArzNgTeyTnZnpKbPzrdtwCQY6UmfzGh0UjqWg8I+6vNBm0H6Co7C9+3v65ZYm8mO33NwJb5kYpfTX40tEyk1tXeUAiqjvxQBiVDWgGa8OnIor/ByEfJ3aXXRr9ML6+OAnJkR8q/wCuVkppX0RnpSimlPvt5AwAymD/hBOMDSaecIH3FGluBZk8yYEPr0fh3HbrZZIseA+/jNcTspw3aqaMo/Uwkwo69nntTBkp9zIY/NnDVs96PXGW8nI5dgwRrE9wDThA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DtCy3JjxfDTz44vuIpnRs4XDZc1gwoMIAnOSORjFnE=;
 b=UtYfk2WNac2zXHSktv30co48UxYcmaobNBUfcVfc+3by+BL3WJib7OSfvvSxSgcf/TRA8JAds+1rlCWdjN6xVAEQUI5h7AhKaJvbP0lzL9vhl28y8V+9ZFR39kGgF42SjOUMAXcGXubkAIMDnNE6Q1PLpIoBvI3RWacMZ9pV5hhXiv3ZDMYU8PqK6t4iJ1p4LONxnxSQOOOD/4G4FM4blLB7DPVu4GqO8iai0L2oAZwHow+oMX+9GkNnHbBgeOShtdo3fqVOh99c5HmP4CBr06YVXHQqD3Xj1Wk10foA9YPeOa0aXezHUDfWvZ+SnE3gLDJ0QrG3Ydm3d4kl8z4RTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH2PR12MB9458.namprd12.prod.outlook.com (2603:10b6:610:280::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Mon, 23 Mar
 2026 11:08:21 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Mon, 23 Mar 2026
 11:08:21 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 23 Mar 2026 20:07:44 +0900
Subject: [PATCH v3 09/10] gpu: nova-core: remove `io::` qualifier to
 register macro invocations
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-b4-nova-register-v3-9-ae2486ecef1b@nvidia.com>
References: <20260323-b4-nova-register-v3-0-ae2486ecef1b@nvidia.com>
In-Reply-To: <20260323-b4-nova-register-v3-0-ae2486ecef1b@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.0
X-ClientProxiedBy: TYCP301CA0031.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH2PR12MB9458:EE_
X-MS-Office365-Filtering-Correlation-Id: 875dcd33-19b2-40b1-ac60-08de88cc7e6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|7416014|1800799024|366016|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: JS3ZmfGKwohoQAV2voBPgAjKTODaPbIqvtaaJ7eAUX/MRr0fh7zc0Iz80vT88muk+oRDYyLum3LFodigOfIbecggXdHeJ1KBvNUHUaido+0KLveZ9rgBK9EEW+d+hHOkixm5p+2JSlV903SLnD1Z4MpveGzSOG01V46HSIV9ejI2c3GVzuO/A8twXotNgbusjSGih09N0ff5us4A/KEr/sU9btwIRtFM7A0uoDnaRhwGmlc3e7qw+Mc1BHhy/MQwd4j8UmvxH3uieAFmlr5lwUSca4wIsVI/gHbmjL4PapHLHObGI+PKxCrKe2ztPZaj8mCDJbUGk//wxdCMqBR96IvEsRpBr9g9MeBJ4pz0ml0SLe3KxHImHZAbDCqX2jm48OjAKDIJ/AyRFIMYIBzOY7d6bhgupSM/x8p1nNi+s1Zp20imb0XeK6MEC4sUpkWTH2qIwdGlXG+FMuVvB8bNJALB7TgGU0F4e/9/rvhKZHk+ZG0+xO2Q9fuEMCzIb39KR0i+Mno/dvq+9Bg17zWD4rKZ+G0etMa8H7u+jP/LRyg4f63WlATDccbfR74mKT+ijFxRLtuk0LNbz34XYZRnr2l9FFyscpMd7lAkq/MNiUzm9hI2KGFtysK3Wwb+tKyspsdOi0eP5OcsTn1hpyJTAgDX4avoH23AhgblsjoGi4NMoUplN21WFkiZJj2fYi8jmfZiCJS7DxHbSChnhqdUirQKAqreKHYw7dyfPPl04iUV2JwWtJf98ECot4ANNrnzU53iGtZbHe117c+5MfFjSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFNCTmlXVGVPaVVGVkY1VHgrRWcyOVlEWlFKRHFCUjk5alAxN3RuT2lpK3BQ?=
 =?utf-8?B?UXRKMEVRbHJGRnZLVUhQU3hac2VNaEExZXdHUmVtdzZmK2EzamkrdGhBWm51?=
 =?utf-8?B?VHpxNUxWRFBpUmp0NnkyVERybGRkajFVdjUrSkNid2s3N2o2dy9BaHFFZzNw?=
 =?utf-8?B?aitzam9vekhna1FNYTByeDZZYWtTL2U3VUd1ODhNbC9rWjNtRkRkaEU1ZjlJ?=
 =?utf-8?B?SmtQMjlzVlBwVjlsbWcvMkRLMzg5NzNLRXE5NEx6bzBrWkptdStIUFozcGpm?=
 =?utf-8?B?cS96QlVkMis1aHp4UnNSOWhpdzFtVHJyTFZoSExnejI1OEc3VTNzb1lkRktk?=
 =?utf-8?B?eDJsclU3Yng5eGdsbnZyVEFJcVNJcWxQWEVsOXJGK3ZsL2xraUx0NmxsZmZT?=
 =?utf-8?B?ZmpBZU9QYk1PNXQ4aklYRnNia0VIc0ZrZU82K0wyNnoreDQyb0p4RjBxZXBZ?=
 =?utf-8?B?WVgvb0Q1Qk01U1pVZ3paZURnN2JiTHAvbEs0WGs2cno4TDE1Snl6WlRvWG16?=
 =?utf-8?B?MnBJRml5MFJtVkxBa0pEdFdDT1A4YVVsbHNmRlMyODQ0bWpGUDRua2VTTGZY?=
 =?utf-8?B?UGFVcFQrZTNXU0JDcmxkWnlibFFJOExib0FMZ3JCTnpGS1pTL29SWk4raEZH?=
 =?utf-8?B?VS9MMitKUDNGVkoxM2Z3eFZhM2hBMDJQVUgvc3VCd21xdUZRZlgybkkxWElz?=
 =?utf-8?B?c3BuZzhCckJCT2VCSnJtb1ZIYk05aWxzUmN4L2l3NS9yNGhKUTF5R3dxcTZZ?=
 =?utf-8?B?ZnNSOUovUlNLYzJMTnRFSTlwQ3NUdXFONUVidEZOa1JBOTAzTkRPUS8rayth?=
 =?utf-8?B?SGFtcWtjVm9SZEVPQUhyc2pzeXZLZUlScmpUMDFRZ2ZKRVdub1Yzenc1YUFo?=
 =?utf-8?B?bHBHVm5Pd2dqNWVDS2tocWZ5ajVlUnNYM0F1NUFaQW1Lc25kOUkzRlowSmhN?=
 =?utf-8?B?SllyeUYwekpTRFhmdks2OWxvQTltcjdDM2hrT3N0MDRQTmRQNHFoVU1aTU56?=
 =?utf-8?B?NUs0NVdaNGg0YmdqeElERGhiSC9LaUp4ZTFZK1lHOXNrMExKa0dlc014SWdj?=
 =?utf-8?B?LzgrczlXSTJFNmo5WWF4NytLZW9sVW5PNWdTWm05T0xTTW9SM0NPTkJBbGh4?=
 =?utf-8?B?VExmUmk0a2NPWFl1U0JrYXN3YXBaNjA1TFpKODBOYW1jUC9ndFY3YlBOeEUw?=
 =?utf-8?B?VGRBWGVKMzVObGhxaTdCc3U4cExDNnpLQ0JiZUdVTlVMSHRlTzRHRmpnMU1n?=
 =?utf-8?B?clFXK09hUVN3QUttdk1oYllKckI2VjJxcFllMCtlUU5LNDVCM2pOTEw5L242?=
 =?utf-8?B?cThhQjViNFN1cUJHU2VLT3c0M0tRRndCY3czZjh3WktyczQ4MmdvR2lNMTBm?=
 =?utf-8?B?VmNuQ0xrTFpITUxvVGxqQm95N0ZiRy93bExIM2I2N1JkNmkrVzRNMWV0ZG5k?=
 =?utf-8?B?dFpvRVJLYnUwTWkzQllHekV2WGlGR09RSWlDSWdUTHQ1OSthUWxtTXBxbHBk?=
 =?utf-8?B?YzNUdFRQSzc4TEVvRmRJQ3R2dGFueTg1bUhwZGdyOHpHS1dwVzdJSEJhQVZr?=
 =?utf-8?B?dGlNM25LR09veUcvR0hmYjhIRHVVYlo1ajAxZXN2aWlxUEk5SDdUSHlreCtz?=
 =?utf-8?B?OGF1b00rUWt4U04rK0NibUV1QjZKRElzcUxJWVZ4d2ZLa3NNb25WSTArZUQr?=
 =?utf-8?B?bjlIbzEzN1h5U3FaQUo1RFpPT2owbkVHcXNxSVBqVWdWMHBBMVdCTUY3WEM3?=
 =?utf-8?B?T0pkVmMxbGo2bzZFUFVET2t4TlRZZGxPOXJtb1p6bktkeFhpVStUQkdWR0Jx?=
 =?utf-8?B?RU01Kzh6SXJjekJhNVkvTXVCeVJSN2ZwWjdybkVjSzFYTzdRUGd5dk5SeHZF?=
 =?utf-8?B?ZDN6TUtRY2tFMjdpdGdEa1JwTXl2dGVoRiszcThDOWlLQWU0RDlGSDAybkpX?=
 =?utf-8?B?SVdLajlLZEFQcDhUakliM1ZQN2MrNjdkQ3NMeERMYkdVZzdhbnhSRkdacG5S?=
 =?utf-8?B?VlRia0tNY0txTENDWEF4RDZBUFVLT1JvQXJWNDhzQUdJdU5lUkdmbHNpbnFL?=
 =?utf-8?B?VUF2a0YvN01PdVlDcmQzaVRrOFYvL1RLTFgxTCtwa29EcVNQNkFHV0Y2L2Zx?=
 =?utf-8?B?WXFaQmV1UEJpRm1SQ1RwWkRpRUV5NzZaTE9naXFHenZKOVc1NENkNjBnQncw?=
 =?utf-8?B?RDBWUWtPbWRaTWhYQTF5Vm10UXhPeGd3MlRnalNxV0pYejYvQy9mQm5vQjBu?=
 =?utf-8?B?Tk8xbTFySTNKaW1Wb3g3b0pKQ1pxdUMzRHdOSC9sdlhBMGpzaEpiTHlRaUZ1?=
 =?utf-8?B?STJLWHNlSXZHM0JqRVREd2dMWE1sN0JXdmJUSERXbFB1eTRaYUREc0VZZmpy?=
 =?utf-8?Q?X5rMgLSH672Zn6DPKEv0T+N3WCR+uc1An3gyh0oF/dC/I?=
X-MS-Exchange-AntiSpam-MessageData-1: pu3LlMs7pcxrpA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 875dcd33-19b2-40b1-ac60-08de88cc7e6d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 11:08:21.0326 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dQSpiwEOn0ewYh3136i2DhFyboRroWCAEvuIlDdFkoEuoFUXQCB9M3V1AdjWSu6As5sJUXb2+UoNG6U/imDwuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9458
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

The kernel's `register` macro would clash with nova-core's own version
if it was imported directly, so it was accessed through its `io` module
during the conversion phase.

Now that nova-core's `register` macro doesn't exist anymore, we can
import and use it directly without risk of name collision.

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/regs.rs | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index 87c2977ba6e4..2f171a4ff9ba 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -2,7 +2,7 @@
 
 use kernel::{
     io::{
-        self,
+        register,
         register::WithBase,
         Io, //
     },
@@ -35,7 +35,7 @@
 
 // PMC
 
-io::register! {
+register! {
     /// Basic revision information about the GPU.
     pub(crate) NV_PMC_BOOT_0(u32) @ 0x00000000 {
         /// Lower bits of the architecture.
@@ -106,7 +106,7 @@ fn fmt(&self, f: &mut kernel::fmt::Formatter<'_>) -> kernel::fmt::Result {
 
 // PBUS
 
-io::register! {
+register! {
     pub(crate) NV_PBUS_SW_SCRATCH(u32)[64] @ 0x00001400 {}
 
     /// Scratch register 0xe used as FRTS firmware error code.
@@ -117,7 +117,7 @@ fn fmt(&self, f: &mut kernel::fmt::Formatter<'_>) -> kernel::fmt::Result {
 
 // PFB
 
-io::register! {
+register! {
     /// Low bits of the physical system memory address used by the GPU to perform sysmembar
     /// operations (see [`crate::fb::SysmemFlush`]).
     pub(crate) NV_PFB_NISO_FLUSH_SYSMEM_ADDR(u32) @ 0x00100c10 {
@@ -180,7 +180,7 @@ pub(crate) fn higher_bound(self) -> u64 {
 
 // PGSP
 
-io::register! {
+register! {
     pub(crate) NV_PGSP_QUEUE_HEAD(u32) @ 0x00110c00 {
         31:0    address;
     }
@@ -195,7 +195,7 @@ pub(crate) fn higher_bound(self) -> u64 {
 // These scratch registers remain powered on even in a low-power state and have a designated group
 // number.
 
-io::register! {
+register! {
     /// Boot Sequence Interface (BSI) register used to determine
     /// if GSP reload/resume has completed during the boot process.
     pub(crate) NV_PGC6_BSI_SECURE_SCRATCH_14(u32) @ 0x001180f8 {
@@ -247,7 +247,7 @@ pub(crate) fn usable_fb_size(self) -> u64 {
 
 // PDISP
 
-io::register! {
+register! {
     pub(crate) NV_PDISP_VGA_WORKSPACE_BASE(u32) @ 0x00625f04 {
         /// VGA workspace base address divided by 0x10000.
         31:8    addr;
@@ -271,7 +271,7 @@ pub(crate) fn vga_workspace_addr(self) -> Option<u64> {
 
 pub(crate) const NV_FUSE_OPT_FPF_SIZE: usize = 16;
 
-io::register! {
+register! {
     pub(crate) NV_FUSE_OPT_FPF_NVDEC_UCODE1_VERSION(u32)[NV_FUSE_OPT_FPF_SIZE] @ 0x00824100 {
         15:0    data => u16;
     }
@@ -287,7 +287,7 @@ pub(crate) fn vga_workspace_addr(self) -> Option<u64> {
 
 // PFALCON
 
-io::register! {
+register! {
     pub(crate) NV_PFALCON_FALCON_IRQSCLR(u32) @ PFalconBase + 0x00000004 {
         6:6     swgen0 => bool;
         4:4     halt => bool;
@@ -468,7 +468,7 @@ pub(crate) fn mem_scrubbing_done(self) -> bool {
 
 /* PFALCON2 */
 
-io::register! {
+register! {
     pub(crate) NV_PFALCON2_FALCON_MOD_SEL(u32) @ PFalcon2Base + 0x00000180 {
         7:0     algo ?=> FalconModSelAlgo;
     }
@@ -490,7 +490,7 @@ pub(crate) fn mem_scrubbing_done(self) -> bool {
 
 // PRISCV
 
-io::register! {
+register! {
     /// RISC-V status register for debug (Turing and GA100 only).
     /// Reflects current RISC-V core status.
     pub(crate) NV_PRISCV_RISCV_CORE_SWITCH_RISCV_STATUS(u32) @ PFalcon2Base + 0x00000240 {
@@ -516,11 +516,11 @@ pub(crate) fn mem_scrubbing_done(self) -> bool {
 // only be used in HAL modules.
 
 pub(crate) mod gm107 {
-    use kernel::io;
+    use kernel::io::register;
 
     // FUSE
 
-    io::register! {
+    register! {
         pub(crate) NV_FUSE_STATUS_OPT_DISPLAY(u32) @ 0x00021c04 {
             0:0     display_disabled => bool;
         }
@@ -528,11 +528,11 @@ pub(crate) mod gm107 {
 }
 
 pub(crate) mod ga100 {
-    use kernel::io;
+    use kernel::io::register;
 
     // FUSE
 
-    io::register! {
+    register! {
         pub(crate) NV_FUSE_STATUS_OPT_DISPLAY(u32) @ 0x00820c04 {
             0:0     display_disabled => bool;
         }

-- 
2.53.0

