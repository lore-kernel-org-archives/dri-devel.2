Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB89606A33C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 14:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=NYmg/+Rm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD9B910EA1C;
	Fri, 27 Nov 2026 14:04:41 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010011.outbound.protection.outlook.com [52.101.201.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25B9610E9E4
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 14:04:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SppT+jLbBWN/YSJtvj61r/dS8QsxZTErca2wIPGGMaOnDiZ1I3gCaeYR/29ozNe3gBgl+ukeOrWtU+DLkmfG5az04NfINo6t5myhir3LYLOnXbh7u8GzdP50y1h+YoMc/xtPRI8cyq4/w5ICEIm5Afaq1QFKKu0hKDcpaNXwFesYT9Y21sMH/WYNM6R9jXQf63BPaxJaOUav3J+1RKWnkto5E9qFlIclfQJhywZ2Y1VwtYTnOd5p3zVdp6eW5/lOVvXj+/1gksUrWAWo8+jcH+CRbcrYKLAjDSCljtVz91Nk8JyzBOSIMcFPn2mZA22E5PpCngCHDjqrvU67j4h5Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1cewgi6KcGubosCpHxc5Lsm6nAbig8YeWoQ2WlFewRw=;
 b=n0HLQaLt/e1v07Em8EmXbO+O8DK3kAjisTbYvUjnnxzVkN9EmzsRcfdXHq6j5DW+G/B/pJx0+8Ce36wen2Fij6sg8lsSfh/4knIkTL/+R+PTZ9ciqcdC9crPcq/MuxBOUNWKZyB+AOOokCgaUuZCJtDZUFXzGNKgZd87DLkqLTQYaRQiL43fNeCCQ7TNOP5HwQ3o+oq+pYQI7Y6d0Qi+RlwJkhaqbAmC7mtdEEJKyH+tjdFGjmEAv4CaAuTy8zgfNo8c3Cxlyshg+fI1zYwlF33/6jqxQqHIisSavv7ojlx+SWHo+SWpltaeMWkTLaJx/4EORbVUdWNesH6rLmJo4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cewgi6KcGubosCpHxc5Lsm6nAbig8YeWoQ2WlFewRw=;
 b=NYmg/+Rm7ww+4YwCGH2g6U5aQ18FOLlwQkNRgbCsY59Dn/UbpdL4JTFH1Sy5jpRHrvhK+OnxfSxJnZ6Jo2zavWTlly2W8l4mOtjliWgODqamdPHrqBh8zAd+/WM+Tab4YcJ7G92nepR8DPVTMIFJ/hvJ5i2P84N6/5vsQ7O/7Zf0qONE9ymDYlrtYNjUzKM88WBmdH0uCIRdUy4vyFCFAqAnlM83Txp8Q74hYRUGgORR2BKf/DFfawzsG8NSTd6Mv7AUmbm0vcwWRh06VgA5mSToEMADGGE7AFs12n8dT2b++YWSL6Dy7ZrcSsEnAETtlrjSPbkKVF1HnpobzCE2iA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS7PR12MB6168.namprd12.prod.outlook.com (2603:10b6:8:97::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.4; Fri, 27 Nov 2026 14:04:22 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0662.001; Fri, 27 Nov 2026
 14:04:21 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 27 Nov 2026 23:04:08 +0900
Subject: [PATCH 4/4] gpu: nova-core: gsp: add the short name and GID to the
 GSP_INIT reply
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-nova-r000-staging-v1-4-4eaf6e3c0942@nvidia.com>
References: <20261127-nova-r000-staging-v1-0-4eaf6e3c0942@nvidia.com>
In-Reply-To: <20261127-nova-r000-staging-v1-0-4eaf6e3c0942@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: TY4P286CA0098.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::6) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS7PR12MB6168:EE_
X-MS-Office365-Filtering-Correlation-Id: e8e26047-fa98-4a3e-e505-08df4c8f560e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|10070799003|23010399003|261026121527099003|10067099003|11063799006|261026140227099003|56012099006|261021123027099003|261022105027099003|261022075727099003|261102123227099003|261009223027099003|261021121427099003|261028144727099003|22082099003|18002099003|6133799003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info: b7RcVEWyP558uBdnuhLzxNEiGAakF7Qogck9Nd+KK6yS+L2dIMCJPbfXy+IURQcN4z/ua4Sm3UnSHBf89+X9l2Wey7nVaMfbDS2dawazWV3F6GGfC2jr883tIF0DJX1TECW/f3W6H/3QkdcYwiC1hZrRFd7w8Gh42AlOyQOHuhv0Yamb+b6BUj1siqH2INo6cLyF44dZtPDx4+mfsWaX1/NzgFFGvzq5S2uvytXWSNUTtYGr/yu32+AF5zCRHByAf0MhVT34gG0lsTOR/YeKB1XkyBxq/Ed8GE3IwDJKprH+CV66+fMR4fqF4dcQXlleGKevSI4cPTLg3yQIoF8aMTqOB8Nba/y++uF3L/jLYJ9swEDyQZ1fgVCRXk4HNLa6Z0DXGE1mMfEIw2RoagADRKCbveQcffU++iq2DSJahWtVSDADFUCWFn215h7hw6wS0DTNB3DsB0Ufk2j1UD4yMANTH56pHn25DG54IBJPujiuqbCcO3UNUKNcT21XSIqMy06UFLcMGRbrftSGRE1zNwpUa2km1CY93b8XKyZEXfbxBfYHt0O+tiukrGeG3CoUuc6LTgP1Dex1l2QvizbmmsonPVAyZwq8ohW6IxhWyn4vbcOU5kwsVZEq3uNRYmCe9h/oi74M4ELoow0ib23mjm+zgLewlQXsvO+iaqB5PF4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(23010399003)(261026121527099003)(10067099003)(11063799006)(261026140227099003)(56012099006)(261021123027099003)(261022105027099003)(261022075727099003)(261102123227099003)(261009223027099003)(261021121427099003)(261028144727099003)(22082099003)(18002099003)(6133799003)(13003099007)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bURQa1NCRTRha0xJSENMYXdWOFBwYnhLcDBIWnhvV045UmFFUFZaWktycGV1?=
 =?utf-8?B?ellpMENJKzM0ZWlxUWRESFovUkRKOGxxeXFLQkJyL1pYbzJEY3NEczF3WnhU?=
 =?utf-8?B?R0hXc292dTBmL3JNT3R4em1RVG1VRm9oSlFxcEplUzBiMFVYYlpoREl3OFFJ?=
 =?utf-8?B?YzFPUDY5QjVmYlE4Vi9JbGQ2QXBYR0lCWm5lVHFuMVpzK1NJUldrcStIa0JN?=
 =?utf-8?B?d1F0OGI4Ky93dWcwUlpKZE1hS2ZsejhSY2E1WFFxNXo4bmVianBqb0VDNG42?=
 =?utf-8?B?Y2lBNlFCSnF2dDZzNEZCSjhkbFgxNG9FaWtVZkVMeWhFUklRcjVqaVRWZVFk?=
 =?utf-8?B?c0w4amduajNXcjFDZi9MSmRJV2NzclMwdTBEa0tLd01sREpTa1BHU1VDRFpP?=
 =?utf-8?B?VWtFZ0I3RGx6YXgwL1ZZWlVMempBTndGUm5waWxkSmRkVE5TMmZXb1h5VkFL?=
 =?utf-8?B?ZUJUUjRGNDJnR3BlUTNRZzNoMHRnTWxxWHIxQytwNlhXU3ZNN051S21lTm1E?=
 =?utf-8?B?aVNleTZuR0JIUDBDZlRBdUtlckZ1dTBUcTB4ZzZPemh2d1JZdUtQcDIwV1RE?=
 =?utf-8?B?QndRdjdENTNCSktwTXZsZlV0OW1GQmhSY2NncDBtOFVCbkdTZDkwa1ZPUjNo?=
 =?utf-8?B?REIvdkd2OEFUaWp1azAyc0d5L3lDRC9OVFZ3K2NkREtialNkR09ucGQ4OVV1?=
 =?utf-8?B?UlRONkJSN2J1bGtrQTFGWGpiS2lFblg3UDNzaE11SStMNHpIWUl3Z0R3WE9v?=
 =?utf-8?B?MjhocVJrVE5FVDJLY3BVWFZDYnRZZ2NET29pQVhYdndlM0J4Uld5SlZ0clB5?=
 =?utf-8?B?ZE1nMWN1TC9MYlNGTVlzOFVTVjdNYUwzOXZqOFZIMEFleThNMUpoRzk1R3VN?=
 =?utf-8?B?Q1U2b3BnUXd6OTJpcWRGNWhJK3cwdkxHbk1xeGYrcW1kTjZZV1krZTNBaTNu?=
 =?utf-8?B?RHFUSXczTUpOQzRRejlSVU5oQ2tJams0VEFTV1NuNDE1UndQaE5sSC9uek52?=
 =?utf-8?B?SFg0b2xVdno0aVZDVXNmQU9rOVB5RjdxcWFhNk1SM3Y4VDNMSjQwSXo2ZC9C?=
 =?utf-8?B?enMwWDFReVJFcjFSTmxuSmRwSUJUb0lZRmROZGdCL0NINzZtdnhHMCtvdDJu?=
 =?utf-8?B?cm8vMzFSZ05UOVhMS3k3djl6NnA0aHpsOTd4U00vK3pUVXo1TTBhaC9NZDNV?=
 =?utf-8?B?NGdDY0RuRFJoSVpQdUxVcDBFZklQZ01BNENNalF4YW9MTnZZR1RvVmhNK0xY?=
 =?utf-8?B?MnJGQjZ0amkwRkk2VW5obHZOZERpOFZOZ0xoUUJsclRTRENRalFqN2lrY245?=
 =?utf-8?B?MzdoRWNXZ1daSExwU3Q2eVZRazZxcUR1MFg1S010UlZaZDFlMmY0Nm8rU0ph?=
 =?utf-8?B?OFVxMGpET3NFblRoSW9IcGRJZU9SbDFwSXhFMUJiTTA1OThPL2ZhNVNCcXM0?=
 =?utf-8?B?dzZ1Z2tVRC9kaVBpZ241MUlZR245OFZacEdpeWpPVk9lWnFPdG9hOHVDNDJ5?=
 =?utf-8?B?M2Y2Zkk3bzFOcEVuZVhqb1JCWUkycUR6REtEdVhOYmljQ3FVRVVBTmczTlNO?=
 =?utf-8?B?UENBeDNETHF5akUraklaQnVNMXluUjlIaG1tQUltOHM3RXB2TXJWTktRZkpR?=
 =?utf-8?B?UlM0NXVreVFzalR1RkVXQTZwb0pmQjVnMFFnQnVuaDJZWUozK0QvRFN4dEJ1?=
 =?utf-8?B?WFhYQlhBRk50d3hwMVVWRldyY0VEWmZLakViNEppSzlNcWlWZWVSQkhMK01X?=
 =?utf-8?B?RXlZak9SV2Vxck1EQU9oZ0JSWFE3WTROeWY1bGJVMnQrTDlPUDNFbTM1L0s4?=
 =?utf-8?B?Qm4rdUVnbXE3Y2lOaDFJYSswcE80UWRGUEVDaGJNK3pqaXRBV0J6NDNqcDVn?=
 =?utf-8?B?NDduMTNhaHdUWkZBMnl5bHkzUWZBU2tYMGVZYWdOSFlrYTgvZTNXeGNUZncr?=
 =?utf-8?B?VHFwUHQyblM5QU5HL0I3TTRBY0Vmamx0ZFU3N1czSlZsVlJKNk55d1UxSWEv?=
 =?utf-8?B?bTJmbjdLQ21sUFpQVEVydDI0Y3dXb05FL3RPU1ZwelBvNjFHNWhRbm1uTmdC?=
 =?utf-8?B?Yk5TaUdYcERRakVrMHN1ZDVVNU55NkZqekV0anlZcmdVaGl4dzVjeGRSSmVX?=
 =?utf-8?B?eEpkdE05OVpaQS8xcEJXbVh1d1RJUC9XbUJaVHF5Z0ZEOW1uQk5ncDlPbG52?=
 =?utf-8?B?MU5xdm1JdXl5dW12TEpWSXc2NU1GNmpBVkEyaW8wNHpNMUd4eDFiYmRvYTRN?=
 =?utf-8?B?a2swek01aWhrZDR4eW1sYmdFTWl1aTlBV0Q4ajVwNWdLaUd2UzEwdjhZeW9Q?=
 =?utf-8?B?L05WcnRaMmhja3BmclFxNmpLMm9mRXhPS2ZDb0dCWGNDUlgrVzJoVFlBWjNH?=
 =?utf-8?Q?23DDp2hp3hgMuOj+/f0RH015moNbrmvLzuXeSznr2o8pe?=
X-MS-Exchange-AntiSpam-MessageData-1: GNeDJx1+EdhvZQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e26047-fa98-4a3e-e505-08df4c8f560e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 14:04:21.8627 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9hPPZudSiZNVcUxd3w7CPiiLBJcj6zkAMbevB9Bju+bHGl0tfz/lcGNErrdGlKKp21MeKy3iQV3Pjc9A7iJXZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6168
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: John Hubbard <jhubbard@nvidia.com>

The static GPU configuration holds the short name of the GPU and the GPU
identifier (GID). Nova-drm reports both to user space, and the r570
static-info reply provides both.

The r000 GSP-RM sends both in its reply to GSP_INIT, and nova-core's
schema of that reply has no key for either.

Add the two keys to the schema. Move the lengths of the names and of the
identifier onto the static configuration type, so that the schema and
the type share them.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/commands.rs    | 11 ++++++++---
 drivers/gpu/nova-core/gsp/fw/commands.rs | 13 +++++++------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index 4aae94b7ca2e..390be8fdd0ba 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -14,10 +14,10 @@
 /// The static GPU configuration, which GSP-RM reports in reply to
 /// [`GetGspStaticInfo`](rpc::GetGspStaticInfo).
 pub struct GspStaticInfo {
-    gpu_name: [u8; 64],
-    gpu_short_name: [u8; 64],
+    gpu_name: [u8; Self::MAX_GPU_NAME_LEN],
+    gpu_short_name: [u8; Self::MAX_GPU_NAME_LEN],
     /// The 16-byte SHA-1 based GPU identifier (GID) reported by GSP-RM.
-    pub gpu_gid: [u8; 16],
+    pub gpu_gid: [u8; Self::GID_LEN],
     /// BAR1 Page Directory Entry base address.
     pub(crate) bar1_pde_base: u64,
     /// Usable FB (VRAM) regions for driver memory allocation.
@@ -37,6 +37,11 @@ pub enum GpuNameError {
 }
 
 impl GspStaticInfo {
+    /// Length of the buffers holding the GPU names, NUL terminator included.
+    pub(crate) const MAX_GPU_NAME_LEN: usize = 64;
+    /// Length of the GPU identifier.
+    pub(crate) const GID_LEN: usize = 16;
+
     /// Returns the name of the GPU as a string.
     ///
     /// Returns an error if the string given by the GSP does not contain a null terminator or
diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index b4bdbddad79f..214f1a8c68df 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -18,6 +18,7 @@
 use crate::{
     gpu::Chipset,
     gsp::{
+        commands::GspStaticInfo,
         nvkv::{
             nvkv_decode,
             nvkv_encode,
@@ -386,7 +387,9 @@ struct GspInitRequest {
     // https://github.com/rust-lang/rust/pull/154377
     #[allow(dead_code)]
     struct GspInitResponseSchema => GspInitResponse {
-        gpu_name: TruncatingArray<u8, { GspInitResponse::MAX_GPU_NAME_LEN }, 0x2000>,
+        gpu_name: TruncatingArray<u8, { GspStaticInfo::MAX_GPU_NAME_LEN }, 0x2000>,
+        gpu_short_name: TruncatingArray<u8, { GspStaticInfo::MAX_GPU_NAME_LEN }, 0x2001>,
+        gpu_gid: TruncatingArray<u8, { GspStaticInfo::GID_LEN }, 0x2002>,
         fb_regions: Accumulated<FbRegionSchema>,
         bar1_pde_base: Required<Key<u64, 0x1020>>,
         vmmu_segment_size: Key<u64, 0x1050>,
@@ -398,16 +401,14 @@ struct GspInitResponseSchema => GspInitResponse {
 // https://github.com/rust-lang/rust/pull/154377
 #[allow(dead_code)]
 struct GspInitResponse {
-    gpu_name: ArrayVec<u8, { Self::MAX_GPU_NAME_LEN }>,
+    gpu_name: ArrayVec<u8, { GspStaticInfo::MAX_GPU_NAME_LEN }>,
+    gpu_short_name: ArrayVec<u8, { GspStaticInfo::MAX_GPU_NAME_LEN }>,
+    gpu_gid: ArrayVec<u8, { GspStaticInfo::GID_LEN }>,
     fb_regions: KVVec<FbRegion>,
     bar1_pde_base: u64,
     vmmu_segment_size: u64,
 }
 
-impl GspInitResponse {
-    const MAX_GPU_NAME_LEN: usize = 64;
-}
-
 nvkv_decode! {
     /// Schema for one FB region of the `GSP_INIT` response.
     struct FbRegionSchema => FbRegion {

-- 
2.56.1

