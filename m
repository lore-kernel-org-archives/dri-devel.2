Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C0BAEC01CC
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 11:08:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D44E10E426;
	Mon, 23 Mar 2026 11:08:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="nBzEyMkQ";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010053.outbound.protection.outlook.com [52.101.56.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8946510E426
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 11:08:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pifs0tz0SF5xaqkwzQfkE1zn28mw06WZr2VMBkJqIaUg6Fcd7NV25VohwwCfytYYqJdnrEQ0Fb9MexOnTzpMkm15BMFTUNF8lZWziy9pPNl8ZxDuVbBAO2f2MUYUEMniJKH3z/o9tCwKz/sTXTuyRxC2vyKz17gqMvHBrXObMk6Q+5a4nWhs4ro2zyc07VHr0ADCp3e2t07/1/EE029M6P5fsTogp4EsqjojmfXZyyngYc/H8jBFcvMtjwy1z4/8lacFCv3DOb96PqgDVLHn4WKhQZVWWj8h4iM/6N4UizG4VDH5rYiajJtrktOXXmKaBwY+DnKSeBxIUa2LnZstKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=liGDEY1vPDJTVsJIaaJuZDYQChwSViW37J1LOdGho88=;
 b=DwdnpjKzwR3ctLdwKTV1FY3ZVdJeceSdVHPyBVtaBbOoctDUROV6WtfoF/lZtcwQYZM7nRoEvgBVP+HD2m7vj/oVFbbw0Z0beADSsLv0Mexur7df+kwgW+jvA+nhJFoaPZp+9rAxQZdAFbszAnZnD65OVF7GAmhREDLe6WBPWNaJaQ/tYnOZe3wKBhk+4tE/f4zqaP102fy8uFicgJShmCrykXba1xUjIUGRA85R7zsz42Gfe8nh6MxPV4wTkgj2b040PhG4WLyEeP4/AphOwzjjYwowUeLWhJtwMsLY2WAPGSJghj3h8oaUmxPZROkV3Lde9pYcsBqglaW4NDP39w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=liGDEY1vPDJTVsJIaaJuZDYQChwSViW37J1LOdGho88=;
 b=nBzEyMkQS7dekal7Ily3eKEwGxQA5e9f+nJHGyN4GcrzG5Z8t4D+0DIKuTjo2MsABAM6LfvWllvf1b0uSOjQvU0zQHn3YNXJ0VUfEC/Bweq2FqoIhHnVLUIA9/Ze2r5lNFAJQUoGvu8xKTgJ3cbbeQDhpby+o7ElLivNc7WY4kDCWXWk3yECNMQzljIsgaSHz+DFPwgYBc+M0QeJmYYLG8g+yUe6d0X6o4wURgUQWfByBb5rRrG7FoPIIIkN64zM3LOvEsPMkuLsuGK+2cBxZleH7dKzawf6g6AuqFwcMVZ+wNXf3eu3TDyk+Fw2ltTHyXd/7jxTNXKK7gxiTLYp7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA0PR12MB9009.namprd12.prod.outlook.com (2603:10b6:208:48f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Mon, 23 Mar
 2026 11:08:10 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Mon, 23 Mar 2026
 11:08:10 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 23 Mar 2026 20:07:41 +0900
Subject: [PATCH v3 06/10] gpu: nova-core: convert PDISP registers to kernel
 register macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-b4-nova-register-v3-6-ae2486ecef1b@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0104.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::20) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA0PR12MB9009:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c3146b1-6a94-42fc-2ec2-08de88cc77fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|7416014|376014|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: DkL0VZSnJr9cZBoNZhG2TyJTeMmsCMxIYBooGw5SBpJcukhLh35urMLNPpzt1/YhoLMVQ/XQnPuqsr+CdhoOHgh5GcAJMF70QId7+8B1vKEjFmWhOMvP03FNJcGvuZ2iAlAEhOFuDxQTer9SpplEEJgge5x/8q4umGLdwo1864AS20i1K6ON5eLZet/p+Z6r2ZLyvbkEY9NSheEqIalaqT33Cx/yaLHGcq4eAX7cofTZEcs6mh3ZK/Wy9ubwWwIfRrMx5Du+Ra7UZ0XI70LvVWzWqJffs32uUD2iga7xE4SeETvXvc3qBn+rESIN6Ig/C5q6J2B5S8NQCk/2zJNAGp2wQolyENlZuvU0auQ2G7b+oT+l1ZhJpzHggGd6SBW2NfyN08y3BqwZ3qufManndc1fRL9tBUrdnD5ITzwpXv0lt8bbvzO5lST8xjKoSP/e1+GMfWBaq5smygrFhh3YhHD4B+RjHRngY/REX7wqh9jSCyD9wBLrhA2tt8kBfkQ8V2VNd81crfJ8fKJYUQVOxL5Q7awpKty1NTAN12+R7H9rh1PwllQeLpUCPzUhQTI7iy8a82+3mcodMigTNXy2BB415PNSuOOySVoE9ZJLjUDecmfLkc1ugcFdsQEtCpPN+lejtBaDPyLfUxhdSVX/HASrtTa1SjiWFhNPDs+xl3q+AplmSubOOJTE6tc948wHA/mPH7MXlKeptkDaCrUkvG0YBtpKxYHC1iyMDDD0bFLsO3v2Isb6eidVLt3mn4wdphJselGIViaMcpvD/OffqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014)(921020)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0srQ0FsZHBCeUc3Zk04aEkvbkxiaURuZTRhbEg1bnVHR3pjRzd1YjcrL3RI?=
 =?utf-8?B?T2F4MEFvbmkyQ1pIYzIvaHlPT0x4NU9ZTEE1WHltVlp1dzF2ZHNQeEg5Q2tm?=
 =?utf-8?B?L092NFJPRjFWOC8vbG5ITGp0WTBPWWQ5Ync0eWRXRVZIY3FnLzhkbVRsdmM2?=
 =?utf-8?B?OUJuYXV1ckFhOUhzLzBLUldpbkEyOXVVR3BSMkUxR2wxL3ROekN3Qng1OW85?=
 =?utf-8?B?ZmtEbzlVTlR2S3JpcUJGWUtVK0RhNjJFMys1UUJQTVlnZmZkcG5KUXBlb0l5?=
 =?utf-8?B?eHUzNmxVVU1EK21rdE4zRGlLWE14cWhMQU1Zb0U1QXA1ZnI0VEFCamMxYmVK?=
 =?utf-8?B?MW1WaFNxSnd5OHpqYWpyMUZjY0NpYk9LN3UvVmliTEc5allOaXdnbkpZRGFK?=
 =?utf-8?B?R2N2NjQ2eTluRnlDWWNZWmpIdjdyQkVOeWYvTUg3U2c5Q2g0a3JmcGU4MFl5?=
 =?utf-8?B?R21hdzhPVGdDUFVhdHU1QURTTDJmNFZzTUw2R1JoQ0tXbmhLZ1Jsc0NlMWpP?=
 =?utf-8?B?d25teTF4eHJSamlkTWloSzFJUDFYbGVGWXU5UXZJTUFaSklYU0xSbVVPVnVq?=
 =?utf-8?B?ZzlpM2syK0I3UWJsYnpudWhSRmJTSi9oMStYRUJIMDFMcTE4bFRidTFidjBH?=
 =?utf-8?B?cFRTYnRjMXJVNGJKcEhzR3VMaWtPalVWUndmM3ptWFRXTlRGWlpYc0pHMWFL?=
 =?utf-8?B?cjF5eTlBTFI5Qmdrb1g5VzhhMmNrTUtrNk5ZSU5IbEpuYlg0bzR4UXd5L0N0?=
 =?utf-8?B?M0ZJMmZCb2kza0pFREpxLzlIZDVJejlqZ3lLM2VKNUdHSVlkalExa2dadzhx?=
 =?utf-8?B?TlUrNGxWdkRzdFlwTDNDZXV5Ty9Md1FHOVZhdUMyT1QxTjVjNVRQdzR4TEpR?=
 =?utf-8?B?S3l6WWRqY0hDUGFMKzFKbHdNVFVKcVhVVE1seTFNUzV2K1Y1MnVyNkh3R3Jz?=
 =?utf-8?B?Z0NiY3haZkV2cVlYWCsvUnhHZGI1UTFUNmxaWjNBajgyTkI5T1piU2tBRWNO?=
 =?utf-8?B?RUViOHVIN3FERFVzUmkxakM0V0pSUWNrSVNZYW4vejQ4UnB3d2ZicStpY00z?=
 =?utf-8?B?NzlqWkJEaGUyUTFQL3lCRjVzakVYR3RVNnRuckpadXl5Tk9XYTlGQWI4a2pE?=
 =?utf-8?B?eG03UkdhUnJyaEQ3R1VzUG9kY3UvUUZJd3lBUm9xRnJyeitLZkwyVDhGUTdk?=
 =?utf-8?B?MEVuSmh4amV6aU1XTktSMHIvdGZOeU9VSW40TDBMTStCWFhCM1FBc0tRQUMr?=
 =?utf-8?B?N3Bid2NkSnZyQ2xYMlVTRkY4aHVMRk4rMHdsVmJXQXVZR3ZxSUVzSVc0MVhX?=
 =?utf-8?B?a2d5cmxHNGZ1ZVhXZUEyclVLZWJaT25PcE1scHltQ3B1VHFqamVjY2ZSdnlQ?=
 =?utf-8?B?SEx5a1ZPaGlzZW1tQ0Q0Vk85Q3lvT215TGd0N253NjdhY3pMbnl2cHFJQUhK?=
 =?utf-8?B?NmptY2g0ZW5taWprK1dHakdraVlJVWdheXEzVEZxZFI1SmZwd0J6VjBVQ0R2?=
 =?utf-8?B?Z2V2Uzh3cDFZamt6QjVEWG9uYncxZnQ5SFZadFN6bW1VMUt1ZG9CN2RGM2pr?=
 =?utf-8?B?M1kveU9DSE9xZEZRT1JkYWs5N3hxek8wL0xRclVmK1dZR0gxTHdvZTcxdkJu?=
 =?utf-8?B?eGcxWkF4UENoWnlCdDFTMzRON1FwUnZTT3h0dGNqblhRdktlMUg0bm5xZEcy?=
 =?utf-8?B?cVh4ZXZqZ3lYRktaMENDby9NcEtSTlBnVFNUQ3dRUWU3UThjaURlYndoU2FW?=
 =?utf-8?B?elg5WktmazNEeUFwZ2QwOStOd1FxZEtBbDNwTTBGakZDcWYxT2FHQmRJTGdV?=
 =?utf-8?B?ZUVVQm5jdGhjdVJDcElVM3NOc0pmdnNzeThHS0hxY2ZZc25LcEo3aUsrSCtR?=
 =?utf-8?B?YXVLQmZqUlNidENzQ1lXaGkrRGFZaW9sWlpGVkVpbnFrREhpbWpHbE5PakxH?=
 =?utf-8?B?WVI2eXdXZzdIM29hWVNlZGd1OTVaYkMvWnVucm9NZE1FSjd2N3FSWk5VazZj?=
 =?utf-8?B?QUtjZ2hmdUxjRHNDdWdSN21nQVdLZGNOYjVzK0NWZUNsWU5hVzJQamxOM1pC?=
 =?utf-8?B?MTlaVklZUmdqTzJPdDFkS2RDRFJ0VWQzS0UrTmk0cG5SaXRoL0ZsazI4eWND?=
 =?utf-8?B?b3FLczg2YjRZUXcxR1VTd2lHaXBxeFdsN0ZOQnJ2ZnZCUENGZlR1c0JaUXBZ?=
 =?utf-8?B?MzlMQlZod21Ednk3S3UrZzhTTEE2UEN6cm1SamNPb1Z4dXlBTDJBWHRSdEUv?=
 =?utf-8?B?UnZ5bVJZUmxVNHhJejdOUDM2SHRnTi9WRzc4M2FvWHkyNnF6WC9HNHgvWEZO?=
 =?utf-8?B?RTQzWXIxYkpselF0Y0E3dVFtNmhhYlJIOFZkQlBGSnMxc29XanVvU2F0VVBM?=
 =?utf-8?Q?AMg8J953jlJda1iQ+RWHaZegEzlQAnZgtu3Xwdb4obO+2?=
X-MS-Exchange-AntiSpam-MessageData-1: hueGQINyD/r1rw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c3146b1-6a94-42fc-2ec2-08de88cc77fb
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 11:08:10.2319 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /J7l+quBnCbbXG+z1CgYPc9+bTQaUacMcytpG7NdX65T9FRDRCfGr6nKs4WieJ5p/ewvb5fnAN5l0AgKkrJoIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9009
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

