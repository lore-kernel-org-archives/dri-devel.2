Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F2B3103A9A0
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 02:47:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E177010E6B9;
	Wed, 25 Mar 2026 02:47:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="t6yFTaB+";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010026.outbound.protection.outlook.com [52.101.61.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FD6E10E6B9
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 02:47:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rkazDHI+IrVnv2Xnp9CEoRN1nsNu0vGtjzZhur7uswR+ASLvngnX6XRQIl0twntnoVyj1V+cg2lCGdzWri5w65DJx1UAO9XYTkKf/Iyi202+TD2QH7MK0SoCDmVdTz6nAzLQ7jDd9qE1N6yCBiZ9gfV1WfEdlTR3qX+eMUih4zIR4Fd4WOY1y6ZQPEKgR2Jn3kiUASlCRqMsTpAz67Nlat4xrLmdnl4TtvY64vPiLlByaRcsHNubPc0N1GgZz9gIYNvL+WQyKRJYQHVNKV/39cz4WGGW84exS1FFz0iA6KiikUAoQfRG7GMMZihONq9NFuWv6cEYIO+zSD+/r9HJwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=liGDEY1vPDJTVsJIaaJuZDYQChwSViW37J1LOdGho88=;
 b=wVyXX+6TrJGydr3/A631cdalGQkBAG4bwC9Rvrxi4xOG48rv2zmGQYada8jr2z0omUI/PstOXyNikcUn+8YKFvWrbr4OTTlWxBsjS3AH8XgQsYRYEcRdDEgHCuBzXGj+v9XCuMk+mbK764dhfz/ytfJkZ1ZS5q7HqqJlEXOoGpsM+bpyBCVpe9rI5lZjG2pGxUNZSACncVX3pwGI1EZ+Ojv9CN+BmR6oC846N6k+f2G8vP8oc9ThaRoNriR24giHf69zlaFMkVYwmzsnckAudr86MOhV1SJjfKJakpLZCezimoh08Z0KP5ZJn6Ir8s1nQYt1QZZ1pOtw0tMdwAVCVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=liGDEY1vPDJTVsJIaaJuZDYQChwSViW37J1LOdGho88=;
 b=t6yFTaB+1usNN8NINTZ9v9/tZL2vXFSTpZvvYJI7heP4rBj53QIIh6/6m//+0WvhcZQdGMBrG5IyBK17ZpdRkDJ9LPGGQGInSrIabXxevsCmVd5ZzUAXedILwftZ7o59nEeP4LSY5CXpwfhGDzVuy9kkN0mTCyMmzEywOrpLEQD1y4uo/swxOTrc72VbbVJqGDZfd7/axxUVBqs6YUSEa07Hf12GUHbbzNuBGN99m9OB1Nvsb3tzs2slTwaT0BNrMFWY38jvzFRGPEQ5cnHipmfDKcmXcqC8heNEiBsWUVuNKfLApxKaDh+vRiq5DnZALixz6DkxynTzE0gEN4Gbnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH8PR12MB7448.namprd12.prod.outlook.com (2603:10b6:510:214::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 02:47:01 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Wed, 25 Mar 2026
 02:47:01 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 25 Mar 2026 11:46:20 +0900
Subject: [PATCH v4 07/10] gpu: nova-core: convert PDISP registers to kernel
 register macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-b4-nova-register-v4-7-bdf172f0f6ca@nvidia.com>
References: <20260325-b4-nova-register-v4-0-bdf172f0f6ca@nvidia.com>
In-Reply-To: <20260325-b4-nova-register-v4-0-bdf172f0f6ca@nvidia.com>
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
X-ClientProxiedBy: TY4P286CA0080.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH8PR12MB7448:EE_
X-MS-Office365-Filtering-Correlation-Id: f066d587-fc6d-41c8-92f4-08de8a18ca8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|10070799003|366016|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: P4Z9VVSltoiQ3bMJGaj1E5X2ukZQHUes8gSHKpWUw14JVw/OOIP5RkQ6XNhnAE7YY6MmSDCv0WuHiSzxhaEHFF3HzRsL90wVtXC2eytEYjvdBwd24xCMgZKvJCjUWjXbhDSq1zXW1ilF4yAGYDIOjcsFXM1Pr5kHawbky8GZDY/Q5iAz0vbPeJ22AvEBlYf6hWvP9Z92U+c02P1rAOUw2jZY682F3OGhREePJT3MSBlObdznPJA6pNGnWrcxtmau3B+YovGVP2JJh01qRwXSWSVirWAqJGj9/xq7bN0A8xyuwY7kJ1/5VTGaFQZi+hGhIp4rPc7aeiVVnRagXEtuPLLHQf5ohn5kspG2DiXTjE23RHbH33MwDEOgcwuRvWksiT8bu8VubgXeqbzIYS2vHYTRlQ3CgGgyBJjEm4/3Ybd43QSdVWFdzNx+6nNgCeWkbTOfwFl6eFp0Q6utoWnCY9SgnNJuuy2b2zYxHHox2S2U8m0hbowqnqUwLAXUaJSqeLj0oCFUQCozI210yiHYPmEb/IzzCRD/i4PJ8SBm7yoszJ29Ay3SMWvr2kIE6HmqCmCnDVdUxbJcR+xO74xzLB5cV5AX6RFbwnXBFcRr8ryZIkr4PZ/rVPFmc/ifIMZh0qDWyWTHhTDv9iVqJkYw2r2yfp2Dzzc89bHIhzlsyu0ux8khp2W8peiyTHoHs6Gih/DbPz/7yn+zuyet6ARaBpweZ+wZqdd3HULMANLhVgDrMZvoki5KH3g1blBy5jS9kne0NscAREwonu/jsfj63Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(10070799003)(366016)(921020)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cElVRUhmUkhGL01MQ3BjOXp4SUMxQzFzcVZ2OW9PTnZjbTlRUCtzREFsdVNI?=
 =?utf-8?B?WVUrMG1zdEkvb21UTEFwK0ppemc5ZEpIdUpoWHJwRkRaeU9qM2JYQ2FNNThQ?=
 =?utf-8?B?YnJQcnlhc2w4UWtUU1A5ejZzTkRlaXliS0JPSXA5MmlhSlhrcmVpT0xxa3Fk?=
 =?utf-8?B?a3dyeGVNOVE2T1BVVnFVc09FRHhnWkY2WmgwOG1zRFhMQ3kzSHhRWTJRdnBS?=
 =?utf-8?B?bW03Q014bzc3WnBGVTNTcy9MSkVwMnFnUWtDR1UxeHdRRlBVakFBTGdxZnhZ?=
 =?utf-8?B?T1dhdnNCRWsxeHZ0NG8zQjh3NmxmUGV4QkU2TUdiZ0g2aXZNdk1tNmNPalQr?=
 =?utf-8?B?ZEg4ZkEySGtROWxseFdQM05uWGthN0hEZ2tCUTdFUFN2ODdkaEFNZkh6VjZu?=
 =?utf-8?B?TVo3MGZLaU54Tm9CdU4vdmdpYms5d014ZlV1RWJVZHE2NGhHREJUcEFuYUJt?=
 =?utf-8?B?WEFzZVZFZEpmdWNBbUNGVVRYaElyM1RGUGx2TUk1OTQwb21YbmptQXNvdjEr?=
 =?utf-8?B?Ni9tZ2t5bXlyWGdSZXBSNFArZWxOZkJpZUpFVnJGZHMzaDYwQUg2bkFKVVNU?=
 =?utf-8?B?UnU2eHlsenFtUzdRZDhBRnJrMTRkRHhwdytDS2JtQm1Qc1VvWXloZ2h1Vi9D?=
 =?utf-8?B?ZExmWk5oaFNadDRoM25MUHpqa2pCUEhSQWl5R2RCdnUyVnFRZFM1enVsTkFl?=
 =?utf-8?B?eVEvYjdyVGNnTU1zVnJ3NWNCbEJJL1hpOHVjcTg1cXVOa25IWWtjZXo3Ymox?=
 =?utf-8?B?M2V6YlllTVhhWmNYU2l0cXVLdi81dFVYbEhmWXNqU0ZHU2ZnNEdKVlFBUFZr?=
 =?utf-8?B?cmdCR2RoY21ETURpVVVxVXV6YjQyNmVrMzk1QXBlR3V0bGpwZEo2RS9taDM0?=
 =?utf-8?B?RFdBRGYyaFZ6cXpBTFQ3QkFMWnJlNWRTd0pEcXREZk5IVTd2N3dBajRZcXY5?=
 =?utf-8?B?Z3BLdkhmVGY5Z09xd2h6MWFlVEo2eVEvajZucnNZcWpUckVTQVU0NW5QZjlh?=
 =?utf-8?B?MEhjMkE3MXg1SlVBOEFHMHdkRXVaYjQ0T0dVWk5lcWtvcXEzQmJNNEFTK2Uw?=
 =?utf-8?B?b1JvMlU4aEw3VFhjdEM1Sk1HWXhlaUJjUlMrQ2crVHlZRkpXZ0g3WkVrY0Z0?=
 =?utf-8?B?cnhaSi9oNlY2RnVpMFBZMVVYaWlYRGZuTDc0aDFXTTI2T0E0Q2s5STdzNHl1?=
 =?utf-8?B?cHZobnhocUZpV2xaQ3djY3BXOHVMS3RIdnVuU3RDYVJxUldvRmxZS3pOSFFk?=
 =?utf-8?B?OWErWExFT0VpMUY3aDhmMEZ4ODBTeTF3NW9KNnllSUI3T3gxVmNLSUgxcjY0?=
 =?utf-8?B?ZjRhZFFyZFcwSXFSdGZWNHFBTi9XMW9INmRsRVd2V2JnOGF2eEtHSEhQSE1O?=
 =?utf-8?B?ZXZuODRvTkZ1SUk3ZERxYjFPbnhsVUhQbnF4aXVCK0F3aTFlU3V2b3dBSGR4?=
 =?utf-8?B?c3BYUnhHRVVpd1pMMWkrNFdtTGNGcmViRW1TRWhKbHg5NGhSU3VUYWpWa0J0?=
 =?utf-8?B?NDYwdU05Q1pxdzIxTzFIbFgxc01GaFVjZThCUlY3SGZSTkN1eVdsTGRZWk83?=
 =?utf-8?B?RUQ0blBlYm9TQ0k0cCtsWDU2SENqTTRLTEgvOE54SmFFaUZPY1RhUGJHMm5S?=
 =?utf-8?B?WWZMS0JqcGVKNXhNdjVlMkJBNEg2UVB3NWx0bjFWRnRhNXdnZU1uZUJXMnNz?=
 =?utf-8?B?Qm5VRjVrdXRaMDR4YktrV0pzN3p6eGp4cVczRmk0Z3R6dUxIZ0NNNGRwelN1?=
 =?utf-8?B?cVA1c3RqZmtibTR0bWE4ZE5rWG5GdVBNYjU0ZDhqS2xFV0x2bFpRcW5vWlE3?=
 =?utf-8?B?bG9MMkJsU29HV0t3OEk2a0RTUHU5MTVacE1KQXY1TUtYSXQ1QXNTM210M0wx?=
 =?utf-8?B?MnkwbVRCQTREc1dGZ3loRDJMWUowbHZwZUZEVTJUOVVjc1JuVjFkNWlML2R6?=
 =?utf-8?B?UE5kYk8vUjl4MmpqWkEzNzFDZjVmWlBCd2J0Sjc3MFZOYXQzOE15ZHhtQ1BJ?=
 =?utf-8?B?akcrQVBkV09xOXJ4SHpwcXRva1dyL2N5Q05TdndvMmhDODJYaGRuSGJsazRv?=
 =?utf-8?B?R001WDZiN1M5ZFRUdWhmWHdKeitiR01SelFTVHNUWVVmTXZtaDR4dlJnZEZB?=
 =?utf-8?B?elFDMHhRaGxqNWZ3VHkzNVhlNjNjWjNOYUxxVDZ1b01odzAwa3dwRElMM3d2?=
 =?utf-8?B?ejZTN3Uzd21uOHI3aW9uTlByT0gwclk0aENmS2pCZjU4cTVxdjluTk9wR3hO?=
 =?utf-8?B?WTdXSDZ6azVXY1UyVkptWmlkR2pRd3hJNlBDczd2dVRWcjg0RWM4MThqaVNU?=
 =?utf-8?B?Tlhoc2p2a2ZacmgrZThPT2VWdGJMc1lnbitHSkJ0VzVLS2s1Qk92dUd4c0Nj?=
 =?utf-8?Q?6Kmaz0Uv/aQzTYmKI209gHnOWLq9i9sK+XLM4WPz0L4mE?=
X-MS-Exchange-AntiSpam-MessageData-1: 64Cfq6Z4gPr5dA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f066d587-fc6d-41c8-92f4-08de8a18ca8c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 02:47:01.6460 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nwNxoledNI1S6pE+J7tWOcmcxofEjttdDDjQxVj3wM3mHzjSPlEUUEzUsCUFJQMib5kF/7Z1OC78FSgz8fKPOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7448
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

Convert all PDISP registers to use the kernel's register macro and
update the code accordingly.

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/fb.rs   |  6 +++++-
 drivers/gpu/nova-core/regs.rs | 12 ++++++++----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
index 6536d0035cb1..62fc90fa6a84 100644
--- a/drivers/gpu/nova-core/fb.rs
+++ b/drivers/gpu/nova-core/fb.rs
@@ -8,6 +8,7 @@
 use kernel::{
     device,
     fmt,
+    io::Io,
     prelude::*,
     ptr::{
         Alignable,
@@ -189,7 +190,10 @@ pub(crate) fn new(chipset: Chipset, bar: &Bar0, gsp_fw: &GspFirmware) -> Result<
                 let base = fb.end - NV_PRAMIN_SIZE;
 
                 if hal.supports_display(bar) {
-                    match regs::NV_PDISP_VGA_WORKSPACE_BASE::read(bar).vga_workspace_addr() {
+                    match bar
+                        .read(regs::NV_PDISP_VGA_WORKSPACE_BASE)
+                        .vga_workspace_addr()
+                    {
                         Some(addr) => {
                             if addr < base {
                                 const VBIOS_WORKSPACE_SIZE: u64 = usize_as_u64(SZ_128K);
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index 61a8dba22d88..b051d5568cd8 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -250,10 +250,14 @@ pub(crate) fn usable_fb_size(self) -> u64 {
 
 // PDISP
 
-register!(NV_PDISP_VGA_WORKSPACE_BASE @ 0x00625f04 {
-    3:3     status_valid as bool, "Set if the `addr` field is valid";
-    31:8    addr as u32, "VGA workspace base address divided by 0x10000";
-});
+io::register! {
+    pub(crate) NV_PDISP_VGA_WORKSPACE_BASE(u32) @ 0x00625f04 {
+        /// VGA workspace base address divided by 0x10000.
+        31:8    addr;
+        /// Set if the `addr` field is valid.
+        3:3     status_valid => bool;
+    }
+}
 
 impl NV_PDISP_VGA_WORKSPACE_BASE {
     /// Returns the base address of the VGA workspace, or `None` if none exists.

-- 
2.53.0

