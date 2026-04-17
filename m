Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F3AF436B8
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 15:34:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0141310EA8A;
	Fri, 17 Apr 2026 15:34:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="DsRwyo2x";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012025.outbound.protection.outlook.com [40.107.209.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F93510EA8A
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 15:34:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ljb72/DmfcltfAzTDHP5uh8enLt53F/P9k5luVIrgd2noK5g10wwTjpkOuVv0/U0paAHCDF64Bi+6va2l2UWR5Q7v7HjZ/cTgdVvC8ZgJoA3+ehZHO9tRQ2TZQgkfwhWPX5FiyTDzOeKdK06VucK3Rq86kGo7N5bQu2QgyDAWA6URiIno5N2FlF3b3a0zrZw/RUtcGvU6LUtPrQd4DOmHfBCgNCb1bUXUr4rZAZyEjpOeLniQjhPTu5jOo0wsLX7DYmJgnuXsWpkQjI8/TikiHtYiUiSqChoaPRDSdW0Ve8wopZG8dyHZ0Qz+9YwLlB45VjD1+/I5I/eDbUc2y3VzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98AABtFxaTQwBmaeWSNV2GTK0DFahs3+qDZs4Up5nj4=;
 b=j+87a+M4UZY59A76Oo5UrukoCOP0tSF55ZTyFnt+O7aoavCNO5XHt8qXBtmpw9UBs07GcWYK+2l2RyhUa+2lXzXJ7fNXinBH5I7XMBHZfxIibb57S/drOSBd4HeZgzZkgsqXrsDFb0g9FvLKbQdCRGlZrW0AxpUJa23kH9b+h2fbQwlu4MMCtjvX002zL5fJKI7W0Tlk1WvfshCFJE4NMgUMj5xepclhwrAXwthJxrBtTirRU30oRUfKNpt91/VAv9naMNJLvRpgfaTEOcTD+bGU4vyqRAOkP39B1X7GOMVc18mpHQXQZErSfkn3I8jCDgw/y1uDHBNt2WTC5vkzdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98AABtFxaTQwBmaeWSNV2GTK0DFahs3+qDZs4Up5nj4=;
 b=DsRwyo2xXXAzKHisRi8LTXO/dWzG5DuTqNsqFddKEfjY+ohTnUPNeF62//1PKQm7BHfHHV5nqz1QB0sLd7GZmdt3UefSvbEkrHEO4T9B2HIJMLcM0OKpNcFzlzbWFqTVVLY4KJFLerPIbzbUL6XhM86OsQdtYiWPecw3DhbbYn/loRaC1S7hltbCe3bjhrqTLDwfE+dQm6n9OTtvtoSH6v3b9/FBEoHaAeXDpCgig7IGMSRsWCjlvJhZqKKsf/OHpKWNG6F2/ONuNqYS3x4//G24gooxaySTeBO6WgVnTGR9waqAsbhayQoigfsExfFZ8iV+QN5aCD9GsOtT4DoRTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DM3PR12MB9389.namprd12.prod.outlook.com (2603:10b6:0:46::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.25; Fri, 17 Apr 2026 15:34:01 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 15:34:01 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Sat, 18 Apr 2026 00:29:26 +0900
Subject: [PATCH v4 8/8] gpu: nova-core: gsp: add RM control command
 infrastructure
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260418-rmcontrol-v4-8-fda8c76dbb95@nvidia.com>
References: <20260418-rmcontrol-v4-0-fda8c76dbb95@nvidia.com>
In-Reply-To: <20260418-rmcontrol-v4-0-fda8c76dbb95@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: DM6PR02CA0039.namprd02.prod.outlook.com
 (2603:10b6:5:177::16) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DM3PR12MB9389:EE_
X-MS-Office365-Filtering-Correlation-Id: fdb7a1d7-b4e0-4a41-670d-08de9c96bfef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: T0MI5CrZu1QH7O8K52Qp12bhV2HNtyEEdjEjzAZ3k83zcow59ORlzV9rvKxNWyyXUAIWIchRbVdkFIfgOWr16R9YfQKMeER61DKq/MgOTPJcZpeWufdzs7dwSyBfmGZObwrkhTEt1y1OMsMZudHTODU/Bd6l+Im0nBpXzDJvkEWavTQB0gyIzONPa5gnZNnIYUQ7zGOtu0s4gggR6i0jfrVOR/NR1J6IVrqGX56ulAREd4hhYsfv5rA/ZBfrC23hwmOvFB1a0ye06Q8yPIcoZhx3bqA4ei+k550BfS03OY3H5V+MfZ6NJjXegfMKNYSsi581h08hgMvmxvT3LkHoVrHL+6ZfMvwrZAYXCZviGiuVH78Tt9DrVZfXMU+ulKyGXVirpP4vvqkPmQQGf9L2Rch3OLdciCdY53ffBZyndjWWAApNwkO3LT79w+GAny2JTn3S3hhwrQ+8gZZzSew7C6UKcmKGm/cQ7rAzjjGLmq5Qf8xxOv2Wfew/uyNE21L2nKSwyQazyJLSofMz4fuq36cOfgelu4tpIQcJFQfAn+p0Sxyfd3tqutgqRfsWlVZi68BWMej3MLfnFoASmpDD48GCd8NhU1//ASedy8Id5f/5nE0HM11c0ChF6XFY+vzf7WGJ6bq4isBqHjf+X1wu+rhau6Xe4Z9E4oqRIzMavA95RoL3HkuRrHN8Trbso55qv9Mqrx5YJeAj6rOXiv+vWx9T2U3z8hT5Jnq8CO1C67c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cENzOVhVeHh2bEladlNYZHh3dHF0ZzMwcnlCaHlrdHhCNk92MGgwM1lKU24r?=
 =?utf-8?B?MDJPT25YZkFtVTVPblM5bU0vK0cwYU9sK2V5R0poUUVMT1RlMXpaTU8yaEEx?=
 =?utf-8?B?K2xQd3NiRWdweUVUZ0hvd0t3azhtbEx1dEJXWlVadDZuNm1malpzZnFQK1NW?=
 =?utf-8?B?akxLYXFJeVY4VUVDNmN2Y053L00wZFI3dkVnK0k0d3ZBOHBNTFVuYml3Umtn?=
 =?utf-8?B?U1pnYnRUbW1sSWdYeWNzTGNQUWl1NEVRaEdRMWlSVkZwSzdySC9EMXJuTDFV?=
 =?utf-8?B?V2k1UTd0YmsxQ3c4UGZFZUYrTGFhSkdpenFzNS8rajlBQWROSTF6QW1qM2t3?=
 =?utf-8?B?dy9vaHFhN01qWDBXTTY2KzZtUFhHNngvNEVlejVDVk9vMVlTOEtSeFVmQmhk?=
 =?utf-8?B?N3JDKzkyRnV0R3dRRTdyMDd3bTIzOExiQTQyeE84SVB5UklDSGpqWTFmVS81?=
 =?utf-8?B?RVFMWHpFVnVjdGNmRmZtKzA1NWNISXFpQkxRWTlpQnV2OXlzcnV3MlNxZ0NS?=
 =?utf-8?B?MzBmb1ZtcFpqWDhsVnNYNXcwZUxTd1U3Zkx5bXRSdVlLVWtXMVNLWFJzZnhy?=
 =?utf-8?B?UmJ1M1RXdzlhY2NQSE9VOGYrbVh3ZkwyL21oVDgwV29ENFU5VTdhZkpPRTNZ?=
 =?utf-8?B?M2VmZW85UEY1ajFSQ05Kak5kRW5GK3h5Mk1TcUdPRVo3VTRsdFNPVkkzeWVk?=
 =?utf-8?B?MUFiMzU2d3laejdvMklkQ0djZlZHbnJldSt0ZmV4akNkVTE2ZzdISytDVjE0?=
 =?utf-8?B?eXdSMkVFcWJEUzFCS3NuYVJhZ1gyUk4xMkFLWDBiSkFIdmx6SjNzWHpkQThh?=
 =?utf-8?B?S0dtb2hqVzhNbFhrMXVWUTVCc1dHNnFIYzNTc29yNHFaRzlnaU5FT094UXVp?=
 =?utf-8?B?V2tId3czUHBjV2lrVVdrT3locjZSOU04NlJ3Nm9BOXZ0TEZPc3ZUeDk1S0JF?=
 =?utf-8?B?SEUxb0FuNldUWGhjbHh3cEdoeUVsbDA2dnNLNUFkb2ZUcklWVXhJRGdWRElE?=
 =?utf-8?B?WXJ2Y1ExTVFHRE9yYnorZzJwZzVKT3VDRDBlTFBWQzZVWlRUY0ZzWUJZY2JK?=
 =?utf-8?B?aUNXcTJSUng4UVVWU0dzcE1RTzRBYTJrM01OcjB2V25EOFFpZ3IwOHdDVWl4?=
 =?utf-8?B?SzQ2WUVtOU1DekRnZEFFMmhBWVVWTEE3VUdzSGxaRFlVTklzSjJlYzFGMVNW?=
 =?utf-8?B?amtOb3ptci9lYjNKZitkMllSMU1KRXUvdGFidE53TURweEFUdFg2emdaZGpw?=
 =?utf-8?B?NmxsYURERW5rUk4yTWRoeEk3aUlNVWpDZmxRTjVsWDZacHpkRFNPekY0RFRK?=
 =?utf-8?B?d3BhcHAyTXhtMEJidVcrS1VjQlJYbkdoMHBIYkh6VVpzckQ2cTBaWVdVa3pD?=
 =?utf-8?B?SjVFQ3VRMWhWSU5RcXkrVEZYZzg2L3BncWZ2MHI1NnZQQ2ZPV0Q2MVlWUncz?=
 =?utf-8?B?aWY3OXQ3S2MrclRUUXk1Z1FXWjZLL0ljV3d5akVhc2ZpSGRlMWk1a1Jjd0pC?=
 =?utf-8?B?RmlOWmxBSlJPVTdIZ2o2ZzJxaVhlNW9UYjFvNkduYVZHOG1FS0JGbVBYclMy?=
 =?utf-8?B?MmR0ZU5MdVE4YTZCSVROWDlndlcrYWRrK2VsUHpVN21LVUVFd0pEdmJ0VWV2?=
 =?utf-8?B?NW9tdDVlTWJWMW9veE1GcVdlSmpnaHNxU3laUm1ieCtlb1R3cWUvYzJYY2xt?=
 =?utf-8?B?MkRpVzlXVm5uSGVZeEhDY3ZVNjdUbVUwaEtBMmZCaUZoR2g1UENISVE4YjFF?=
 =?utf-8?B?cGQxYXloTW9Sd3puMmFIdThVNTBIN2QwZXJNQ2dIamFNakxlZCs3MlVJdkl4?=
 =?utf-8?B?TVlKcWwzWWV1VnA0YmdoSzRhU0VIWWt4LzZ5UzhVRndlMUg4Yk9HNFBjb00r?=
 =?utf-8?B?elpRNzcrY0ZTdmZsVHVSRGxacEV1cHRZeWgrZURxZ0UrUjJBWUNxVGEya3ox?=
 =?utf-8?B?NkU4UEpOQXZ1dk9DdnNJYmd5T3crblQxV1RpSnhoRmkrWFdSc1ZNcXlSOUVy?=
 =?utf-8?B?SE13T3FlNTdlQUZKZ0ZOYkRNNGpqVkJSTDVHeXhlbjBPYmJsYVBJclJFK3Vw?=
 =?utf-8?B?UENBQTF3SzVXR3M5b1FKNXUwVlcrYTMwN3ZUaUh1VU1oSTNWTmdFU2sydlc2?=
 =?utf-8?B?T1VsUnVlck1BK1hnbnQyaWZOQ0ZrY08xSFN1UmkvSUM4dW5YMkJKNHdxTG0z?=
 =?utf-8?B?R0dYU2M0UHFHSmhod0dSK01mVEJxZTFCVkJ6YVA5VktUZllDVGVxWkgwRkdV?=
 =?utf-8?B?VHdOendxRFFDaTEvT0Ewc0FVYUhiOTh3eEQwcnhQaXZubG4yWUNZNTVaRmlZ?=
 =?utf-8?B?djhxbjRIaTlxckoxNlI4U2NybTB4VTlvdDFBbElZSEEveFduL0pZTWlXUm1u?=
 =?utf-8?Q?Hl9uqyat8Sm4JyJz9t8Lo822qOe1JRqiVqQr8I1y0o4LE?=
X-MS-Exchange-AntiSpam-MessageData-1: OjFUpwMXkc8ZXw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb7a1d7-b4e0-4a41-670d-08de9c96bfef
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 15:34:01.3504 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eNC/iFVFOLcYHJpx0m2IImh5ihEZh1Wq3D+nIcp34xqH1ntXbXOodQj51ziuaVOSIk4yySWNt8JixLYgecxVgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9389
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

Add `RawRmControl` which implements CommandToGsp for sending RM control
RPCs. Add `RmControlReply` which implements MessageFromGsp for getting
the reply back. Add the `RmControlCommand` trait for defining an RM
control message.

Add `RmControl` which sends an RM control RPC via the command queue
using the above structures.

This gives a generic way to send each RM control RPC. Each new RM
control RPC can be added by extending RmControlMsgFunction, adding its
bindings wrappers and writing an implementation of `RmControlCommand`
that can be sent using `RmControl`.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp.rs             |   1 +
 drivers/gpu/nova-core/gsp/fw/rm.rs       |   1 -
 drivers/gpu/nova-core/gsp/rm.rs          |   3 +
 drivers/gpu/nova-core/gsp/rm/commands.rs | 155 +++++++++++++++++++++++++++++++
 4 files changed, 159 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index ba5b7f990031..58e3d7d21557 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -21,6 +21,7 @@
 pub(crate) mod cmdq;
 pub(crate) mod commands;
 mod fw;
+pub(crate) mod rm;
 mod sequencer;
 
 pub(crate) use fw::{
diff --git a/drivers/gpu/nova-core/gsp/fw/rm.rs b/drivers/gpu/nova-core/gsp/fw/rm.rs
index e51fdcec1f27..baa3857533e5 100644
--- a/drivers/gpu/nova-core/gsp/fw/rm.rs
+++ b/drivers/gpu/nova-core/gsp/fw/rm.rs
@@ -54,7 +54,6 @@ pub(crate) struct GspRmControl {
     inner: bindings::rpc_gsp_rm_control_v03_00,
 }
 
-#[expect(dead_code)]
 impl GspRmControl {
     /// Creates a new RM control command.
     pub(crate) fn new<T>(
diff --git a/drivers/gpu/nova-core/gsp/rm.rs b/drivers/gpu/nova-core/gsp/rm.rs
new file mode 100644
index 000000000000..10e879a3e842
--- /dev/null
+++ b/drivers/gpu/nova-core/gsp/rm.rs
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: GPL-2.0
+
+pub(crate) mod commands;
diff --git a/drivers/gpu/nova-core/gsp/rm/commands.rs b/drivers/gpu/nova-core/gsp/rm/commands.rs
new file mode 100644
index 000000000000..33be7a663a8c
--- /dev/null
+++ b/drivers/gpu/nova-core/gsp/rm/commands.rs
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use core::array;
+
+use kernel::{
+    device,
+    prelude::*, //
+};
+
+use crate::{
+    driver::Bar0,
+    gsp::{
+        cmdq::{
+            Cmdq,
+            CommandToGsp,
+            GspRpcError,
+            MessageFromGsp, //
+        },
+        commands::{
+            Client,
+            Handle, //
+        },
+        fw::{
+            rm::*,
+            GspMsgRmStatus,
+            MsgFunction, //
+        },
+    },
+    sbuffer::SBufferIter, //
+};
+
+/// Wraps a [`RmControl`] command to provide the infrastructure for sending it on the command queue.
+struct RawRmControl<'a, T>(&'a RmControl<T>)
+where
+    T: RmControlCommand;
+
+impl<'a, T: RmControlCommand> CommandToGsp for RawRmControl<'a, T> {
+    const FUNCTION: MsgFunction = MsgFunction::GspRmControl;
+    type Command = GspRmControl;
+    type Reply = RmControlReply;
+    type InitError = Error;
+
+    fn init(&self) -> impl Init<Self::Command, Self::InitError> {
+        let params_size: u32 = T::LEN.try_into()?;
+        Ok(GspRmControl::new(
+            self.0.client,
+            self.0.object,
+            T::FUNCTION,
+            params_size,
+        ))
+    }
+
+    fn variable_payload_len(&self) -> usize {
+        T::LEN
+    }
+
+    fn init_variable_payload(
+        &self,
+        dst: &mut SBufferIter<array::IntoIter<&mut [u8], 2>>,
+    ) -> Result {
+        self.0.cmd.write_payload(dst)
+    }
+}
+
+/// Command for sending an RM control message to the GSP.
+///
+/// RM control messages are used to query or control RM objects (see [`Handle`] for more info on RM
+/// objects). It takes a client handle and an RM object handle identifying the target of the
+/// message, within the given client.
+pub(crate) struct RmControl<T>
+where
+    T: RmControlCommand,
+{
+    /// The client handle under which `object` is allocated.
+    client: Handle<Client>,
+    /// The RM object handle to query or control.
+    object: Handle<T::Target>,
+    /// The specific RM control command to send.
+    cmd: T,
+}
+
+#[expect(unused)]
+impl<T: RmControlCommand> RmControl<T> {
+    /// Creates a new RM control command.
+    pub(crate) fn new(client: Handle<Client>, object: Handle<T::Target>, cmd: T) -> Self {
+        Self {
+            client,
+            object,
+            cmd,
+        }
+    }
+
+    /// Sends an RM control command, checks the reply status, and returns the reply.
+    pub(crate) fn send(
+        self,
+        dev: &device::Device,
+        cmdq: &Cmdq,
+        bar: &Bar0,
+    ) -> Result<T::Reply, GspRpcError> {
+        let reply = cmdq.send_command(bar, RawRmControl(&self))?;
+
+        reply
+            .status
+            .log_if_warning(dev, T::FUNCTION)
+            .map_err(GspRpcError::Rm)?;
+
+        self.cmd
+            .parse_reply(&reply.params)
+            .map_err(GspRpcError::Transport)
+    }
+}
+
+/// Response from an RM control message.
+struct RmControlReply {
+    status: GspMsgRmStatus,
+    params: KVVec<u8>,
+}
+
+impl MessageFromGsp for RmControlReply {
+    const FUNCTION: MsgFunction = MsgFunction::GspRmControl;
+    type Message = GspRmControl;
+    type InitError = Error;
+
+    fn read(
+        msg: &Self::Message,
+        sbuffer: &mut SBufferIter<array::IntoIter<&[u8], 2>>,
+    ) -> Result<Self, Self::InitError> {
+        Ok(RmControlReply {
+            status: msg.status()?,
+            params: sbuffer.read_to_vec(GFP_KERNEL)?,
+        })
+    }
+}
+
+/// Trait for RM control commands that can be sent using [`RmControl`].
+pub(crate) trait RmControlCommand {
+    /// The specific RM control message kind to send.
+    const FUNCTION: RmControlMsgFunction;
+
+    /// Length of the command-specific payload to send with the RM control message.
+    const LEN: usize;
+
+    /// The type of the reply after parsing the raw bytes from the RM control reply message.
+    type Reply;
+
+    /// The type of the RM object that this command targets.
+    type Target;
+
+    /// Writes the payload of the command into `dst`.
+    fn write_payload(&self, dst: &mut SBufferIter<array::IntoIter<&mut [u8], 2>>) -> Result;
+
+    /// Parses the reply bytes from an RM control reply message into the command-specific
+    /// reply type.
+    fn parse_reply(&self, params: &[u8]) -> Result<Self::Reply>;
+}

-- 
2.53.0

