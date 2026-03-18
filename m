Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 252EDFCD0C5
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 07:16:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A0E810E6C5;
	Wed, 18 Mar 2026 07:16:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="bpN16MMM";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010040.outbound.protection.outlook.com
 [52.101.193.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7290010E6B5
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 07:16:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N8AORH4cKouks90DcLfTqMie3KE3b6cncYGHHpmPtgIC1yiuCr0AnzdFJ/A9V8s5a+L32tAstblHSzL6y89sXPaLfVnH58IPIxHSmdhR0Y7FDCFNqq1VRUaseXkGBHwPNmFWvg5a2EzTFFxS05qDyjACr+Uh4sBmEUKV3fcxKz05fqjUEHrWhDEb4zIXtqMsj4/V4N9a/1IOoMo79wL4IydIkjPegXNsuVvFvVf2rfhz/KTdpwVB2Het4BQQVwHZTr9ggjHX3egl1PQsJTuppcRSON4XM9N1COnLTCcC0EYRfOHi9yTJQRbQadXFu3bwBZ7eNDUBjpcforpnWOtxFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NO8V3zSADDvaOqcgnm8lOQnUFvVnGJXDqRgcQ2erTQ0=;
 b=XffxBfNNbVLTbTkidq2yLEaGcmTBXjScCpHI7QZCn0gOLDwUJRLMEe2PxvTZDxP/+NaQE+SseuvMRBhPqhKLRU7neIVMJHLOIgj8Z1y3HHKhplKIt4Igfcge2BF9/UOqhW6r8q17f+3Ksp+W3u//jL2X++5L55h6WL8YIoKWnO9iqz8/dUFW6TBG+KybfOF1MTZ9VHXO00MsR57cg4cRhNtT0mLIM/MG7aSKHlQzwNgqXDj2bSDSmUlZK3m24sCFosWE7asWh0HuOGITd8MZ/+hYfq2N1CEbRfnQWLKFWqdvl1ShBzibbUwZZwZDOEd75TNJIvLao5y5gtso1bDsHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NO8V3zSADDvaOqcgnm8lOQnUFvVnGJXDqRgcQ2erTQ0=;
 b=bpN16MMMKS5+1x8TytfNX7sY+bsnUblF6aotiJEdzEDDVsGqaU0s09WPo9ZBOVs+N8i1D0D30KTWSYZDP3RPvP8LBL2c5yJrr4JtzZmLvk3uElw2KB5EwR0ugjV+8NqOwJ4pHeDhbNJpQAovfsFNW6R3+TqPbgeyzlR7DrzIkfMs5oZCHfHE8pq9p3vQLq+3mWXgVOkDZ4kZcakAJMk0QMnCOU0iLvZKcPdRrZXYJOhjoYxJVDE9DfhVpvhCVIHaQYjvuEDIQlJcDOc3h0J4QuzhybVlmePMovBBlLSIUszqOTwwIflswu9XLXZt+7H74ACoA7YB6g/NnQraAvqCjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by MN0PR12MB5764.namprd12.prod.outlook.com (2603:10b6:208:377::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Wed, 18 Mar
 2026 07:14:54 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9723.016; Wed, 18 Mar 2026
 07:14:54 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 18 Mar 2026 16:14:01 +0900
Subject: [PATCH v2 5/9] gpu: nova-core: gsp: add types for RM control RPCs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-rmcontrol-v2-5-9a9fa6f1c4c3@nvidia.com>
References: <20260318-rmcontrol-v2-0-9a9fa6f1c4c3@nvidia.com>
In-Reply-To: <20260318-rmcontrol-v2-0-9a9fa6f1c4c3@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TYCP286CA0001.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::7) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|MN0PR12MB5764:EE_
X-MS-Office365-Filtering-Correlation-Id: b596ba2c-d751-48e8-7fa3-08de84be0dc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|10070799003|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: i52ZhXozw3Ad+sae9VO4KgEI+3qsdU521OUhZ8zH2Ueq/8x9lt1B7FBeO1q48dyyxlEEr2qqhW5DKviXzj8X7vyKEQydQtf2jFSgEjJ08uiVJb6/ZKaO9tuD+1RzHaHwdSh39abjbbOhiV7a+IfXU/U56oL57hafa7slB8vEXv/Bpvs4RlsrzGV+ZlQPQefF9ogZ1VDSqLMfmmE75ptrJIJAGkYjs7MJk4vZB5vxsCKJuQjA/cwW9ErD8tI3puNzCYTQ+5dgWVfr5Z81136fRyq0ihO1XmrgEzIK5UuIqaWtg4rs7sGgkOwoigNAoz+ttr0lnAYB1J1H7e/6zLlNEDZ7rWivljIKSBGNrT66vdJPU5/qQfETw+TpO9AdzfE4on+bHdLiv1U7CXs43QDig5WaWzjdJwgiQ2u+piIc4vn5znaSbzOWZIhwrKWeNpJMY0XTwAy1J5w0O/AG2SFyRJjw9eVsTapYD0pRCjgEZIkvEhl6rAaPtsGlq85ey3MlxMjBh4ICIg30Q4TpEwrFZ3tqpP1iXZo+BsKV2Fgnvs5sOx5vvUSdyhMCkCii8/3LdEIrGGnGfwjK2vAtxnAoqRU0rkdlO/InXEiraAfabhODf88WCDFqJa+2PFr595uGnJ8yoEN71wUmHItlnNicawRSbhwjvNvQkXI0ApOWsIdQa163x93QR10Z8kDtu5cznfXH9RxCS/JN9kGc9PBBVm3hB/AXWdZSdUegvmrc4b4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YThaWExVSUQ0RS9qRWFDTmYzOEdUeEwrb2w5OHhiMHFIZ0hnb0h4Mi9LRE5v?=
 =?utf-8?B?K1VOTjNNWUI1UkdKRmRpUjBaUUhub2RmYi9hMmk0a25RQWZpQmF1TTJQZnRh?=
 =?utf-8?B?WEVHK3dkRUJiNWdsZGp2WkNMZFNrWDAxVEYxakhjVFp5alpkamVQbHNyVDNF?=
 =?utf-8?B?REcvaVFCNGQwWHREVzBpYlN0alA1NE52akF2Q3hxbnMxdWRJUWszUWpnZEVQ?=
 =?utf-8?B?YmNGWXAyeXo2QjAvdGc3MkFzUmcwaU1aczlIckJ1RFVjTndjWGRReWQrb0py?=
 =?utf-8?B?MmRIMVVLNm5XTFE4SjdSQm9EeHNoRlVUZHVTS0s4M2RqdkNUblh4SkZIay9I?=
 =?utf-8?B?NTdWdUZsRzNaTWdjSTl1cE5UOWRnZG1hRlowdzRTWXZPYWNVTm5sUXNyWDAz?=
 =?utf-8?B?Mk1LU2hBVVA2Zkd5ODduK2JaRDJ4N2tpb0hkZldrMW9STk8wbStwbHdSbk9F?=
 =?utf-8?B?WUNKVGpVM0ZoRnRXcWYzd0tYWmRhcmlBaDZOdWRFWCtNNGs4R1lKejZTVjNn?=
 =?utf-8?B?VDVIUmE0cThlN0hBNWd5NUZQRmY5elU1WUFYS214MFQ5NWJtekVPVVNKMFF2?=
 =?utf-8?B?elAwY1ovajZxd1drNVoydWIzcmI5N2RjWld6MEp5TG53UHRXa3ZhSG1lRWFS?=
 =?utf-8?B?UlZmSnlCWEpqdndFOWEydHp3b05VakZ4VTVrckI4UzVxZEJkODFhaEVMWWlD?=
 =?utf-8?B?bnRHWnIrd0ZsNFhiemt2aVQyTDhuSnpnWGI5cmV6T3VmVyt2dGxDU0t0bVZG?=
 =?utf-8?B?MmsyK3BDclRDc0RSb3ZYQWFlZWpGSlFKSVp3NjVpRkZCV2FXOG9ZbWsxeGRK?=
 =?utf-8?B?b2tjeFlzdTFkazBXZDM5djlhcWZLbzd2OUZtdDR3VWF0Vk9DR3pJVUcrZDVx?=
 =?utf-8?B?c0lORnBSbWlmeGxRNm93NFVrTjNvaE8rendyaGRFMlNsYW5ObTlNOVZSRnJk?=
 =?utf-8?B?cUhxTEhSaU5tOHIvTzNVeUFsYkR4QkFCQ2dYTjYvcDQ1UFdDVTBhOU5pRHZp?=
 =?utf-8?B?eldTanhvMy9YMnNjQUNmZTc2QTdOUWhNZWRoc3hScWRub1ZVMGNNejU3dlFZ?=
 =?utf-8?B?b3R3QzF0YUsrbDA2ZEU5QXFzMjhLZ1U0MHRUUkNyS3c3WEJuR05VcXJqdjY3?=
 =?utf-8?B?VktjTVJ1Y0dtRWs4MVBQM041bjIwVmp3eGc5TWlsMkRFcER5UndFd1ZaYm9o?=
 =?utf-8?B?K3VmczUvSFN2Y1gyWFQ1UlZSTFV0eU45ajlKSWp4OG50SG85OTROcTlLaFdo?=
 =?utf-8?B?YzIwTGlBc25wbWlGMjVmcXliNFUway9TbVkvT3ZvNU5Ec1JPZTN5QUdFNDJK?=
 =?utf-8?B?Snptb0tZOEdKODBSM3RueWlzQy9qOTM0Snh2c1JPeXFPMy9yQWhwVnRReVhV?=
 =?utf-8?B?cHVOSUs3WFdPeTBlaTFCWlNrNCtCdFhCRnZJck8waDRGQWVJcDBxTWxkcTFQ?=
 =?utf-8?B?bjUvY0hFVWN1TkNlbFVVQzJZUE1FNURyTEhoL0YycmlrdEQ4Yk1xV1ZFKzZp?=
 =?utf-8?B?dXFQMnliajg3TFV4S3V4MkF5andvUTVHdFI3NjBTWlNkYmRKckR0UDNpdFA1?=
 =?utf-8?B?RjhvNnpYaTZaMXhXbEIvbDBrcld5MVhKV1FRRG0rUldpckxxZ0xaUythdElI?=
 =?utf-8?B?UWRkK3k5alF3QjducnZHM0l0bEV3cW14MkJmZ2hCTUsxRTNIekhYN2FVbGZQ?=
 =?utf-8?B?L0NEVXQ2R3BSTFVqRWlXcW8xU3g3aWhyaUZYU2l6T2JxTjNraWxERWhzS3ZN?=
 =?utf-8?B?eGhRU0w3WVNPejlNQWRab0ZhejhQakR2NitNVnEyNDh6c3RrdGNueTJpYk8w?=
 =?utf-8?B?UHgzNDZIT2s2cERaQnFBbTBFVUFaVzdZOU9FR1puUFlHbFV2MUFQZHBSWWtG?=
 =?utf-8?B?SDZQaTRWb0gwTEFXTnRQbXZjY2hJVVhjZUdSS3R5ZUIrKzFkei9tN3hnNzVM?=
 =?utf-8?B?Y0h3dmhJeG55eEVWSTNyWGJKQ2VVbUUxS3YrVkN1Umt2cUc5dlpDU2h0NzBo?=
 =?utf-8?B?aVVobEg3NDUvUzArNitVVW5lQ2FlUXJDUWo4cldCMFQrYlFBTWFVMS8xbUxt?=
 =?utf-8?B?R20vUWlid0hWYTVLcTRrVVpobjdWQUNuRVN4OWpmcnJxSUZWTjI5TjFHellx?=
 =?utf-8?B?cC9Yb2sxNUxsaXhxK2Nac1hkbVRMblJJM1lwakJHRVBsWCtrbVozL0srUkRT?=
 =?utf-8?B?dTZONXN5UDNWWDJOUXVPd0tyakFZS0RyakxyT0YzaGhKVWw2dyszMk1GWklz?=
 =?utf-8?B?NWRHcUdwTXVzY05wV0JvWVlIZWgwZSs1dUU4VXUwaTRXZWYxeXVicE0vdXJw?=
 =?utf-8?B?eFB1YUtVaXRISzQrS0R0NThsWkxCNEc3cTJZdFpDK0NSZ0gzYmNOM2VsSHA2?=
 =?utf-8?Q?3nvfqbFR6nQvsb5FOwYENf0lwbQFADqQRkPBYG4hAXATl?=
X-MS-Exchange-AntiSpam-MessageData-1: ml3tyxN6Xaej6g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b596ba2c-d751-48e8-7fa3-08de84be0dc4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 07:14:54.4127 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hvIVjLMifuRyjp/Wpbfoyyn0JTDbw88Z1dbtwB0NHDu8TW2yorzYMLa7RTKj6Rx881h3dbJa+4zhoyK6G6/ejQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5764
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

Add `RmControlMsgFunction` which mirrors `MsgFunction` in fw.rs. This
denotes the type of RM control RPC. For now it contains a single
discriminant only (which will be used later), which is needed to prevent
compile errors when using an otherwise empty enum.

Add `GspRmControl` which wraps the RM control RPC structure from the
bindings.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/commands.rs             |  1 -
 drivers/gpu/nova-core/gsp/fw.rs                   |  1 +
 drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs |  1 +
 drivers/gpu/nova-core/gsp/fw/rm.rs                | 88 +++++++++++++++++++++++
 4 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index f3566f3ea6a7..8c9599aa227b 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -77,7 +77,6 @@ pub(crate) fn new(raw: u32) -> Self {
     }
 
     /// Returns the raw handle value.
-    #[expect(dead_code)]
     pub(crate) fn as_raw(self) -> u32 {
         self.0
     }
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 37831034ec3e..8cbe90ce8271 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -2,6 +2,7 @@
 
 pub(crate) mod commands;
 mod r570_144;
+pub(crate) mod rm;
 
 // Alias to avoid repeating the version number with every use.
 use r570_144 as bindings;
diff --git a/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs b/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
index 05e205e6dc58..ece31cc32f5b 100644
--- a/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
+++ b/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
@@ -44,6 +44,7 @@ fn fmt(&self, fmt: &mut ::core::fmt::Formatter<'_>) -> ::core::fmt::Result {
 pub const GSP_FW_WPR_META_MAGIC: i64 = -2577556379034558285;
 pub const REGISTRY_TABLE_ENTRY_TYPE_DWORD: u32 = 1;
 pub const GSP_MSG_QUEUE_ELEMENT_SIZE_MAX: u32 = 65536;
+pub const NV2080_CTRL_CMD_CE_GET_FAULT_METHOD_BUFFER_SIZE: u32 = 545270280;
 pub type __u8 = ffi::c_uchar;
 pub type __u16 = ffi::c_ushort;
 pub type __u32 = ffi::c_uint;
diff --git a/drivers/gpu/nova-core/gsp/fw/rm.rs b/drivers/gpu/nova-core/gsp/fw/rm.rs
new file mode 100644
index 000000000000..4a4f97d88ecf
--- /dev/null
+++ b/drivers/gpu/nova-core/gsp/fw/rm.rs
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use kernel::{
+    prelude::*,
+    transmute::{
+        AsBytes,
+        FromBytes, //
+    }, //
+};
+
+use crate::gsp::commands::{
+    Client,
+    Handle, //
+};
+
+use super::{
+    bindings,
+    NvStatus, //
+};
+
+/// Command code for RM control RPCs sent using [`MsgFunction::GspRmControl`].
+#[derive(Copy, Clone, Debug, PartialEq)]
+#[repr(u32)]
+pub(crate) enum RmControlMsgFunction {
+    /// Get the CE fault method buffer size.
+    CeGetFaultMethodBufferSize = bindings::NV2080_CTRL_CMD_CE_GET_FAULT_METHOD_BUFFER_SIZE,
+}
+
+// TODO[FPRI]: replace with 'FromPrimitive'.
+impl TryFrom<u32> for RmControlMsgFunction {
+    type Error = kernel::error::Error;
+
+    fn try_from(value: u32) -> Result<Self> {
+        match value {
+            bindings::NV2080_CTRL_CMD_CE_GET_FAULT_METHOD_BUFFER_SIZE => {
+                Ok(Self::CeGetFaultMethodBufferSize)
+            }
+            _ => Err(EINVAL),
+        }
+    }
+}
+
+impl From<RmControlMsgFunction> for u32 {
+    fn from(value: RmControlMsgFunction) -> Self {
+        // CAST: `RmControlMsgFunction` is `repr(u32)` and can thus be cast losslessly.
+        value as u32
+    }
+}
+
+/// RM control message element structure.
+#[repr(transparent)]
+pub(crate) struct GspRmControl {
+    inner: bindings::rpc_gsp_rm_control_v03_00,
+}
+
+#[expect(dead_code)]
+impl GspRmControl {
+    /// Creates a new RM control command.
+    pub(crate) fn new<T>(
+        client: Handle<Client>,
+        object: Handle<T>,
+        cmd: RmControlMsgFunction,
+        params_size: u32,
+    ) -> Self {
+        Self {
+            inner: bindings::rpc_gsp_rm_control_v03_00 {
+                hClient: client.as_raw(),
+                hObject: object.as_raw(),
+                cmd: u32::from(cmd),
+                status: 0,
+                paramsSize: params_size,
+                flags: 0,
+                params: Default::default(),
+            },
+        }
+    }
+
+    /// Returns the status from the RM control response.
+    pub(crate) fn status(&self) -> NvStatus {
+        NvStatus::from(self.inner.status)
+    }
+}
+
+// SAFETY: This struct only contains integer types for which all bit patterns are valid.
+unsafe impl FromBytes for GspRmControl {}
+
+// SAFETY: This struct contains no padding.
+unsafe impl AsBytes for GspRmControl {}

-- 
2.53.0

