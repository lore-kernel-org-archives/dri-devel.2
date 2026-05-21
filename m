Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 542AFCD4F3D
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 13:51:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B58C410E476;
	Thu, 21 May 2026 13:51:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ygt7GAb4";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012009.outbound.protection.outlook.com
 [40.93.195.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8651510E476
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 13:51:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNWVzbhNea4VfQ6KC4TFP9is73hURtzoizivpn8OHFEnav85CerQDBEXWYBdHEkDCV+OFcLNsEbvUngOhB+ckI0UnBVHS15u4yibhrwNDzB5wFIP2UQArgikrtFSkF9T7k5MXwzBRRL/2SZfmAromOqeVjyP+d4uHS0JW14VieSaeeik7HwhJgGeraN/fybx6TaPqwRk/xZc0LGErS0FRhfs0wgoYgvfwyau+vGWNKWZ7RAarw6jl6P20I3wckXhvlMo13f3qCyzY+WGQDIpm/k2fedmFK4SzehuaGxJ5dmfQ3R0LFngrZtbgRKmYjcN/vEUCh6+P4SAyCdzmXSQvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rfJpHbGly0iEuZyX9SDdYtr5/tXgqLAcXG1ESn+RUCI=;
 b=lrerQHsB+H6EMXBSevfaEOie/bAi6gaVwVRicYMY7qaBB/uUr31Vitl4NeNYGNkr7JvwoJS8qRH2M0QQ3A7W2V5R3B+VymHbxXE6DKHgln0KAcV5H6dWNWBxjTAMwt11EFeBtxyLsXsoJts/3hW27LEilQ0oG1BRiEK2AfjheH9ZCZvg63Jm7rAhIp4BsRG8+jTdpusnYn/jeCUh0fX5KG4W3DkJXIfJCKMrQotmJU+WczrGu9P9AImVhMg3TbTa21nQDrg1KpMU6htUHDBcJvhGfnlIZHxPRm+YyFnRJci8lofaZk2epTZuFfPY2/0GK4yb5cm7NUzF5OuPrYCj8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfJpHbGly0iEuZyX9SDdYtr5/tXgqLAcXG1ESn+RUCI=;
 b=Ygt7GAb4zTH4URp4zK6PNrgMNAz2eQOv8wFc9EGfNH+DGyDGH0xG7xuxHuIycSGS8jAYz466MkjnX+WR19eJPfkEYil8RBtoy3UphSFTmhCaM8pp9nwztJK5y+yGF8O28Q/6pWpqMPhYYrscjQOeyFAXhPq01BAh9avRWB2THDJm0T2QsxT+OmYvsvgAwMTb5QW6QJTjicC/7QxOiq7pg4F4Ykq0vGYs4WryyKC2T9kehtv7/8zXqKet/KsSDJKIxAhOk4E42hgk7vo86Y/Bvr1o+QpPhOy4QC1UmCDQ+fp2IKMGTbbsVOvNZ4NZrbjbyRyv3qu2uhA9e99pjrQ0iQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SJ5PPFCB5E1B8F5.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9a1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 13:51:06 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 13:51:06 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Thu, 21 May 2026 22:50:49 +0900
Subject: [PATCH v6 2/7] gpu: nova-core: do not import firmware commands
 into GSP command module
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-nova-unload-v6-2-65f581c812c9@nvidia.com>
References: <20260521-nova-unload-v6-0-65f581c812c9@nvidia.com>
In-Reply-To: <20260521-nova-unload-v6-0-65f581c812c9@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCPR01CA0102.jpnprd01.prod.outlook.com
 (2603:1096:405:4::18) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SJ5PPFCB5E1B8F5:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b144bc3-6689-446d-8bae-08deb7400173
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|376014|22082099003|18002099003|56012099003|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info: zBmV8hD2UIDmg/DGi5mVzVjXZ6HcPID2TZI45hD90HLRudzcIfXNM16JhTc8A2DFd0z9fke7a1jTJv4iNrCbrr/Wj7t9Ob40TLGLfo47BnoObVdix5EGCA0UFDr+irLZ5WIj+0xPLuTVTAaZiqZeb1VaKr+K+yIWNUc7aDEntkcZtMwYPx3ExUPIYYBeAgFjRSRpnTha0bg/7xIefYbMb/tfdOKCd1rh6NJF8tiIHGgAOSoZN0AbJc2kLG9vpSOykFARRqQfcftvZksJ+7iX20W9UU7e6AOdkf1Ps/YvpmEICKINTnatouXqwAeTS+ZNO34C0fhr4+VqniwM3HeXPUOUu7gMJTIadteU/0qmGuv8LC/QOj6eGq3CTRfC9uDGBB7NFE1uE7BQqdBKhlCSlYUzcR6Wrtv6843yfl+ekZ7OE+iLDRM1MMdD5SLtijacbA6ThewJRhQwlaVtX3Q3q+uP6GC+zWJVO0WBiaKi/xWqtgi01NUE7j1D/H2GqIG+XwUkEw1cmUR5BdRzSKAlu77kIALIEPN8DA0ydSHnNn3jviPe51yB0q1+BYDonkkMTZDzOaCAScpKmGurBeb6N9yY6MJ4TshaBvIv6LIRnfmdpLtAXZpZaKF5cDBhg60v9GP/O8+AhsaXmI1iDqFZRIuZmE2qqgjUG766DqriK6jIOtpHFG8YixJKi3KdRDSB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(22082099003)(18002099003)(56012099003)(3023799007)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0RJOWE3Smxiakx0eitTWjhmNS9veW5XRll1ck1LYkxEeGpLZ1B3Lys2M04w?=
 =?utf-8?B?UVNMSFJPeFV5Y0d4R1JXYllqTHgwdy91ekF2TGlkWXVObVI4b0hqVHJRNDQ2?=
 =?utf-8?B?ZXQzQlUyaXRld1AxLzRYWFA5Um1zbE52K1BJMHAvR1FibDNETERFRC9tSjZy?=
 =?utf-8?B?WEpLUU81ZUxiSkhGcCtyTVVid3gweHV2SnkyaXVTY250cmN2M3Zua1QyZHBS?=
 =?utf-8?B?c1ZHZkNmbEZZRmgzbkJOVENqdytHNDBieldKcThIcXpvTUNQY2hJc1hqeVlw?=
 =?utf-8?B?ZDJyb1dxdSt2YlhEODduYXBuUkdPL1NXT1U1K2Z4OCtrZmFKdEJ2d2NIK1VG?=
 =?utf-8?B?dEdZTldrSmdoSFFoelZ6ZGVMZHQrZGIvajY4L2ozeTJkdkVxUnZFcWlhVUFG?=
 =?utf-8?B?ZGZVdmtWaGQ5VXBMdjRoL2pFdDVPVU44bE5FSjg4L0lIRk9ld3N5dzBRMk9L?=
 =?utf-8?B?NkNYOVlvRkJXcmZuKzdFajVIU29xcis4LzZOM1VaTVNiTG12S2FONlhkdURw?=
 =?utf-8?B?UDFoNDVFaUlQQXZBeGJSNkc5Y2lzV2s1amNuVkFjbUNGSWFBZ3Y0cXVkNm1V?=
 =?utf-8?B?bUR2aUsyRFpSay9oOWU4ZGVoK2pQN2VsdWtCM3c1YTVGQ0huRE1PWWplVTNE?=
 =?utf-8?B?aFNrN2NTK05QYlhSYmJhMTBQU09jQUNMcWU3dGRGV2tWM0VDL21xb0VtbFRu?=
 =?utf-8?B?UTFXVGVGVlMvanRVKy9zdXNwbE1ZQU8yMHU1QjZEYzdWcVNNdzExVmQzVzJk?=
 =?utf-8?B?UGQvRjFTR3FXSUVXcUpoWnYrRzl0MWl3U29BWHBaSERWR2hiMmVIK0FXNDVG?=
 =?utf-8?B?R21RcG1nU09CSTFldHEzMDc1ZUpoVEFiUFBJVWRJekhIUkFRRTByWTJQQ25U?=
 =?utf-8?B?eDFIMW9SbU0xQkhGRjRNRTA2d1I4R01FNER6S0xRaHAweXhlV3p0a082ZVZm?=
 =?utf-8?B?T09takFZVWpOMS9JbUhodUFFcEhnVGxBdU5ZSUtURWF3WWwyaDUwTUhVSDNH?=
 =?utf-8?B?TkpLY0ZBRkx2a0FNS01YSWJxbE5Dcm9TSlhrNDdRUnlZQ0lHTDZ2R0NDMzBk?=
 =?utf-8?B?alNHWFZpQUt2Y3pTT2tCRjlNRTlERjg5ajdBcU5LdWpBdE5hRjBVU2VOYita?=
 =?utf-8?B?OXNLUGlneWVtUXZ0ZDVrMEJTd3FSbDBpY1NEUWdJSGRPSW9KRWNSbjdUbVJ3?=
 =?utf-8?B?Tk5tUWNJeW13L1piMEdDYWRHN21EbXZIM2dLRXp5SEY1S1JzOUY2c0Z3elgw?=
 =?utf-8?B?M2ZnNmRtRCtBRDdZY2RqRXMzRmgxQzIyQ3NPSDNUYmdMWEN4Nlh6V2txWnVt?=
 =?utf-8?B?UVFDOGVXK2dDWWxudVoveGY1cWFMalVCUnFXYTNzTjdvV1pENjE0cDRXV2Ni?=
 =?utf-8?B?RVBraVVrWVQ1TnJ3eTZBUUZRQXhPaUlZamYyaVVRcEgwMUdaTjJId25BMnhC?=
 =?utf-8?B?NVNaN2dYeVUwelB3RlpNNVZyR29lQ0hRMExPdTYxdVQwaGdhNkVKMGkyVlFG?=
 =?utf-8?B?aEpucWVqUDhlTlRXOUFaWGFxR0R4a09VZkZodjRhckcwdFgyMUF5bFFDODc0?=
 =?utf-8?B?QnVGK3UwYVNpMWtBMzF0VnFkNCtreWtkcDVUZUtkVDd5aklJTmM3K2wvcFRF?=
 =?utf-8?B?a2FBNVgvVVpReFlicDI4UXltLzhVLzlOcDBPbUsxVEhqc0ErcDdzdURCMDZY?=
 =?utf-8?B?KzJud0ZES1BIUzVHRnF0MHMxQ0VOMVFiOENKVVNyYUxWUTFpT1RXcGJnUHN6?=
 =?utf-8?B?b1hTOVJBZjQ3eHdSZ3dyZjhzRENPWERqajdscWt6bnhCUjZzZE9rbFRKT3JH?=
 =?utf-8?B?RDhTblJQS3poV1lMV2pTWXhGMmdQOERVbjh3ZlREY0prWC9WMDJhak1HZVNw?=
 =?utf-8?B?NjVoZm03UXQrYzZHdG8wcjF6a1dFYkFnbFdZYlRoOEE3eXU3OFpwTXRnMHkx?=
 =?utf-8?B?NE9HOHA1UE9MVW5GWHArckkzNHMvR2tldktnMWhva3hSa3gvbnl5dnkzWlMz?=
 =?utf-8?B?VVo4MmV1Nk1VajNVNysvaE1BT0R5QTF1MkZkaWRvSDdjVFkzUG55VDZ5b1Rz?=
 =?utf-8?B?N0FNQlh6YjBxUnRGNjdDdzcrRGRzU3kyUHdBU3JwZEZMRHlrQTFYVk9QRk5j?=
 =?utf-8?B?eEorMjhzYzZsNTE1RGJCSjlJOGYvNW51cU9IdHAxb2NWelh0eCt2VndJOGJ2?=
 =?utf-8?B?MTVIYURSQW5IYTRsTzZQUkdta0xqd0pwcHp3ZGpXNWtHem42SXlCaFljL0hJ?=
 =?utf-8?B?Z2crRjRlMm1kdkg3OTRoWlB3TkhnU2JpcVNXeGdVdVpEMER3Yjd5ZHBRRGxx?=
 =?utf-8?B?SHBxeXZqbEEzT0cxNWw1eVZObVRFWGJPM0VKWXYwaWkremREczlibTR6Qms1?=
 =?utf-8?Q?TJ/RgV65a0Z0Yd125XHx3oD6qEtjFLqPb6Pg8LOPVhWi/?=
X-MS-Exchange-AntiSpam-MessageData-1: AKp9fcZL5H8+8Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b144bc3-6689-446d-8bae-08deb7400173
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 13:51:06.4966 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RjjMHvbzZgyEbnKZ5udM9bLURClBActg5owyQBcOFmUeejQBx7Lb7rpNcjcg8Wdrx5IX3AQj7PIIKKTiMSt1gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFCB5E1B8F5
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

Importing all the firmware commands like we did is a bit confusing, as
the layer of a command type (fw or GSP) cannot be inferred from looking
at its name alone. Furthermore it makes it impossible to create commands
that have the same name as their firmware command.

Thus, stop importing all commands and refer to them from the `fw` module
instead.

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/commands.rs | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index 74a8a79bd2d6..cc8df448ff39 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2025-2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
 
 use core::{
     array,
@@ -26,7 +27,7 @@
             NoReply, //
         },
         fw::{
-            commands::*,
+            self,
             MsgFunction, //
         },
     },
@@ -47,12 +48,12 @@ pub(crate) fn new(pdev: &'bound pci::Device<device::Bound>) -> Self {
 
 impl<'bound> CommandToGsp for SetSystemInfo<'bound> {
     const FUNCTION: MsgFunction = MsgFunction::GspSetSystemInfo;
-    type Command = GspSetSystemInfo;
+    type Command = fw::commands::GspSetSystemInfo;
     type Reply = NoReply;
     type InitError = Error;
 
     fn init(&self) -> impl Init<Self::Command, Self::InitError> {
-        GspSetSystemInfo::init(self.pdev)
+        Self::Command::init(self.pdev)
     }
 }
 
@@ -99,12 +100,12 @@ pub(crate) fn new() -> Self {
 
 impl CommandToGsp for SetRegistry {
     const FUNCTION: MsgFunction = MsgFunction::SetRegistry;
-    type Command = PackedRegistryTable;
+    type Command = fw::commands::PackedRegistryTable;
     type Reply = NoReply;
     type InitError = Infallible;
 
     fn init(&self) -> impl Init<Self::Command, Self::InitError> {
-        PackedRegistryTable::init(Self::NUM_ENTRIES as u32, self.variable_payload_len() as u32)
+        Self::Command::init(Self::NUM_ENTRIES as u32, self.variable_payload_len() as u32)
     }
 
     fn variable_payload_len(&self) -> usize {
@@ -112,22 +113,22 @@ fn variable_payload_len(&self) -> usize {
         for i in 0..Self::NUM_ENTRIES {
             key_size += self.entries[i].key.len() + 1; // +1 for NULL terminator
         }
-        Self::NUM_ENTRIES * size_of::<PackedRegistryEntry>() + key_size
+        Self::NUM_ENTRIES * size_of::<fw::commands::PackedRegistryEntry>() + key_size
     }
 
     fn init_variable_payload(
         &self,
         dst: &mut SBufferIter<core::array::IntoIter<&mut [u8], 2>>,
     ) -> Result {
-        let string_data_start_offset =
-            size_of::<PackedRegistryTable>() + Self::NUM_ENTRIES * size_of::<PackedRegistryEntry>();
+        let string_data_start_offset = size_of::<Self::Command>()
+            + Self::NUM_ENTRIES * size_of::<fw::commands::PackedRegistryEntry>();
 
         // Array for string data.
         let mut string_data = KVec::new();
 
         for entry in self.entries.iter().take(Self::NUM_ENTRIES) {
             dst.write_all(
-                PackedRegistryEntry::new(
+                fw::commands::PackedRegistryEntry::new(
                     (string_data_start_offset + string_data.len()) as u32,
                     entry.value,
                 )
@@ -179,12 +180,12 @@ pub(crate) fn wait_gsp_init_done(cmdq: &Cmdq) -> Result {
 
 impl CommandToGsp for GetGspStaticInfo {
     const FUNCTION: MsgFunction = MsgFunction::GetGspStaticInfo;
-    type Command = GspStaticConfigInfo;
+    type Command = fw::commands::GspStaticConfigInfo;
     type Reply = GetGspStaticInfoReply;
     type InitError = Infallible;
 
     fn init(&self) -> impl Init<Self::Command, Self::InitError> {
-        GspStaticConfigInfo::init_zeroed()
+        Self::Command::init_zeroed()
     }
 }
 
@@ -195,7 +196,7 @@ pub(crate) struct GetGspStaticInfoReply {
 
 impl MessageFromGsp for GetGspStaticInfoReply {
     const FUNCTION: MsgFunction = MsgFunction::GetGspStaticInfo;
-    type Message = GspStaticConfigInfo;
+    type Message = fw::commands::GspStaticConfigInfo;
     type InitError = Infallible;
 
     fn read(

-- 
2.54.0

