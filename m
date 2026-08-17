Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 447DDC5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 12:59:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BF3510E7CB;
	Mon, 17 Aug 2026 12:59:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="lJmhvBp/";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012056.outbound.protection.outlook.com [52.101.48.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A67DD10E7CB
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 12:59:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UKq3SQ+or917+9cCXtTlR9DqJ4VzZDmMuVSmgEWYJUpMg5yrKw2b8FY577dRFSXFqUKQJ2b7dyuv/YZYIw+9wY8MpyY5KpKgcBu5OJambb3SFc0H0odmRsKWsZj31XhD0Nite/dEwvTWSC0aAB3HKmYRlVCVt+imweQoDsBAXOArMYhhedEAS1tG1BnhauRkXtsmH12XHyDcpDh2RSuo14GKOJpcq6V8mt+QVc/CH89IHeE4PauIPQIyqjTiQi458m4s7M47lYDvWa/Lr0NOanmiaom0dpUGoHmtstsqyXOk/A0Ybf3s45mk5tn5YVYXImy2EyLSs/mrHXxHlkQCZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K4I7cy5xmBH/a46u7T8YnfSqDhfSRPzyxl0+RYOeS80=;
 b=U8gmcT+uToJaXvBoJA1QtuTCgNTX8kFdkMfhsrzBTFKPKEC8AsJykjmwbqnL7GjyidI47eIL3Sjxq++o1tGBEhuRU8ubNu00zkeZIVaWI9k1ZoPGdEwFQFaF2Z+oil0oKch6tvvtZxi2X3KldHWYIutnzO1M0dF7M2nkIW0ScHLEp5osF0bpuc1CUeHBHPGZd5QPjOK+cWUgZHDGSIaWrc1LM+7/H9lJYTHxdGLTPJwCLaBtjK/SKsyCmyi7fAjulwT0Dc30VXx18CigLNd2EY2FQ4ilc7AAcR4TXJY2qfnbvrQc/d/OFiwjyuK3hm7bno2aoLvavk+U6N6Yd23k3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4I7cy5xmBH/a46u7T8YnfSqDhfSRPzyxl0+RYOeS80=;
 b=lJmhvBp/pP1paNgz0I6ZjGd/aJ+XFz/AYtL+1VdeGtGDnFkrHcC57Bm27z4eOJbu6/L4t15QeoAxlX3mGj77OEyAloYSmGaltyRnrM53Ag7LwfGqj7Hn+qqnVs9Jb0rrATD5gU/utNvXj8RBuGk7VpLnW+JRr6QQ+zsO4y02F7y5I389W9NUhCGHB4OuAV5PHKkfbzt0eCkgeVd7Rtz2a7IH0f48n8a4xa/jHftZxjmwrrohSDUN4xdr5GVkgWW+XqQUTv6Q0fTmDiGM2ZSrde6EwVDNgiaW5G0CF5YblCATxTnxZG8k89XSKBM8fJm58QsxokmAk53ToCFxO5YbhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by PH7PR12MB6833.namprd12.prod.outlook.com (2603:10b6:510:1af::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Mon, 17 Aug
 2026 12:59:27 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 12:59:27 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 17 Aug 2026 21:56:41 +0900
Subject: [PATCH 6/6] gpu: nova-core: add NVKV GSP_INIT schemas
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-b4-nvkv-v1-6-b84db5e84b67@nvidia.com>
References: <20260817-b4-nvkv-v1-0-b84db5e84b67@nvidia.com>
In-Reply-To: <20260817-b4-nvkv-v1-0-b84db5e84b67@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0004.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::13) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|PH7PR12MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bb9a681-548c-4328-8657-08defc5f5edb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|7416014|10070799003|18002099003|13003099007|921020|22082099003|56012099006|10067099003|11063799006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: Y3YoSu6q7uxgo/XNf/ZMUuV4YnAimDvo5C5Zehj+FX7FxSegY7983dR3PUWxvM0ps3Qp/IP4MCoYJOIqU/UCIvG+p/JhFWdH58UNXJL6kP/gN0pO+RRZA+58oF2w0O6I9/mu7EDQZcP7jFtacYSEcdCdElNnJtIgg9XpVESfFuj/qqfl3ss3waosre13FKxO+m1FVEzf5sp92BvePecCEa9kg3172vUlC8eZumlDe67OckeI3WFISS4GmI5DoUyDJc+wcoDwqM+CdcgURqPywBdJZW8wPeAjJrpLPbX+vTOQ82kctVAQMJY1F4ThSd3XJ2i0QmABWkdcSRQBSz5DtuZEzlc/NcNhiJNzRCc74Ch4/SnJmxm4r3pKuzcq9gfpff03/iogUa5TmVRy4U5fThYsXrDZnnByAEWbeF/lit/Zwm/U9EEcfzjz8ZJxMKotBI09QlVr/MOay8a9P51iuyJG+Dy6yrDYT6kQcCNyP1bZnpGN6P3aj8lW4v2vAPEm0t49TCvxpRLwzTm32n6itCedSn4wFNChcYDkYJ2226Iv2ZJZjjWGan/gIs62X6Q3vNQuSk2p/NrKvhdl8/3KN16s2Cm7q+mNLPVslkQeIvu4Dbws4vntQI5Fbq/kuOx2cnUgDZdVTuukijtirXD3vJCTMSmpr/hcOQf+g9DIb0c5hIiLIgHQmAOtr5zCKVkDllo6JQ2xtt5A+qHQ3Oqy8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(7416014)(10070799003)(18002099003)(13003099007)(921020)(22082099003)(56012099006)(10067099003)(11063799006)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0tMRmpUeFFUdDRqY1B1azB6Z1JJTzlPZnVpcDZENWdwTjdSMXgvTU9JZkV0?=
 =?utf-8?B?K2dRVUJtMEVMSktlRUtvZkVFTWc3TjZNbDJZWkFWdi9MZkdDM1E4WFZkT054?=
 =?utf-8?B?Z1VoYzFqRzVLa1IrVXJzclVFS1VJU21kMHQrQnU3Z1VxTWd0MFRucHZLbkdM?=
 =?utf-8?B?RHZHdHNhbHpYMkllK1h3US9JSFBWZThicjZYdlZiYUlzN3puWTFxMU1rb3VH?=
 =?utf-8?B?ODlSY0F4bU1GdnBWZW5yVDMzaTNHUnd5SFNPSkoyb001WG9QUnlqNkdWZ01H?=
 =?utf-8?B?TW5EeUY4S2VkVEVYS2NKNmRxQU1UZ0o5NTdrc3RqMEcyRVBZMEQ0b0JNaHBN?=
 =?utf-8?B?ZnpnUGNUbzByQlVrME51dzhkUnNVUWJ0TGlDY01tWDhkZXFpaThFTkM5Mk4x?=
 =?utf-8?B?V2t3NEZYMnlPQUhKbEhjRUVldWoxL3pQZEV2azFDTytTb2FiQitTVTlteWxl?=
 =?utf-8?B?dldEWFB2WDdJU2dUSHIzdGphT0ljclhUQnMwRE83VElCN0tNSTU0MVpjSnls?=
 =?utf-8?B?WHNJdVp2VkdjOUNYWjBYcjRjVW1OaGNCZlhoUmNtSExiYy9WRVQzN3VVOFdY?=
 =?utf-8?B?c1JzZjJHd2h2YktJRndERU1ETURVb2l3VmJFSTdMdzNZMDFGUlQxUDE3MEZr?=
 =?utf-8?B?YXBwcFhaZnZ0c0g2aHlleVdudzQ3SVZGUlFOQVVjU2JRUk9KeFl1SkZ1R2Vq?=
 =?utf-8?B?QU5OZTZEY0sydXkvY2pZa2V0SVZlSWJrVld1UUxMNU9wWkNKMlBYMWVNMml0?=
 =?utf-8?B?b3o1YmowcTBjVWU5eGNnbjljZ1hURFFzMFVOWEVOQlhoKy9QK2thd1l5RndO?=
 =?utf-8?B?THcwR2V2MG16RGRKa08vQXV0WkJWUjVyZkZ4QVBUZWhzZTdmekk5clhGdlNm?=
 =?utf-8?B?cS92d2dZUzZCRnRqQWUwRnNLUk1UQWZhbytMd3hGWlR2S0xieEdPYkhoY0pi?=
 =?utf-8?B?c2NRb2laUWx4d2pHYjdZTHExbmhjMmNKY3NMN1JvcytvUHlRTmRFTEkzNkhm?=
 =?utf-8?B?dHhBT3RMeHNVMXNFMm5nNjYzRDVlVjNpTHZ2NjRRY2tzOU9hTTFKb1p5ZWRS?=
 =?utf-8?B?ZVdjT1E0aG9QTWExQXJTakdTTWZtdHhvR0dLcUpqWUJ0VjJ5UjZSWEE0aHNW?=
 =?utf-8?B?Y29JZ3grSTZKYUF1bHdSTjliZjQ0Rms4cUNLdnZDYXhjOE1xRENmQnpoc0dT?=
 =?utf-8?B?QlI0b093bmtpQlJoZ0JJaFVzUDhuWHY0WDF5ckRNMUJ3Tnc3aHhQZXEzWEdy?=
 =?utf-8?B?NCszMGZKaWs2V0hXZHZqL3dhNkNsbUV6UmZVTVpPT2Z6K2VTNGV4bkMwNHJE?=
 =?utf-8?B?elpnQjZka3JVVUlsMStQL1MrUitQU09YVmlNbmFuVDhEMnVZdFZvaXdSblB3?=
 =?utf-8?B?RWNHdEc5OGs2Mm5qS1pIZmlwZ0gxR0JOWHJHcEhWblVnMmdjYjV1bnpwRHVI?=
 =?utf-8?B?ZG4xNzdYekZTTzRIdzJ2QU5IVDFOR1dUWkRONWJDZjZTN0lOc1hZRFI4dkNQ?=
 =?utf-8?B?SGg0Y3RDNzdvUDZmNEJMVDBYK0ZIeWRtNDZvOVV5WEt6ZTZnSzl6OFB4QVdz?=
 =?utf-8?B?RmJ1dDVsTE1iMHlFRjRBV2xoVzNEY0xIUy91K3J3SWIrNG5vR0grZTdpUEZr?=
 =?utf-8?B?Rm9kYVVNRmF5MUJYamlUMWZxenN4TElIN05iQnhJZDVXVkpadzlXZTU3V2s5?=
 =?utf-8?B?N3ZCR00yNlNvZityM3Z6SVRqMkE5Z21OcWc5VnUzR0h2VytSOVBKSjFZRUZq?=
 =?utf-8?B?VFpxNlg3dDdKZlNmRWp5TmVpOTM3eGErRktXVDdQa1ZLSUMvWTBlQVVzeGM1?=
 =?utf-8?B?L0Q4OEg3ODljd0dEaEVUOTJhQXlzVWdmdkVzWWx3bXg0VFZtVTZhelVHc2cy?=
 =?utf-8?B?aUROVUVuMWlDTmZrVENEMmdJNyt3Q1BtNWJyTHBQVDlzc21iQVBSZnQ0RXNr?=
 =?utf-8?B?YWZjMDdDSXE4VWhqM0xFV2xKTTh0dS85N01RbDl1MWdnOG9icHpPUVNFL1N2?=
 =?utf-8?B?Y1BVRFg5QTRkSkV1VkQyV01jajhTSTR2M09vM1N6ZXlBNUpFRjdHcWlvUFRk?=
 =?utf-8?B?eFNhWFU2M09KOWhtOHJZck5qcHovTFZFam41WGxCOHgvRWlrczNkekF3d0U1?=
 =?utf-8?B?emNBK3JOVHgvWjB5SkVSZ2NzTUxibUpnUlNOUHg2VTVNRTRlQWJuYkNodG0z?=
 =?utf-8?B?Z0RMblMweE5LamFjeXhobHNqTExlMDBJRlkzUWpoQXlMWXRpVG1SNU5WQ1pV?=
 =?utf-8?B?bFl1Q282UEM0Z2tjaFpkNlpYcXQrMCtRWjFSc3B0MmZBamJNMkNjQ0pLMFNN?=
 =?utf-8?B?c3FJVGxST2Z1YlNZL3NFZEcxUFdzcHBRWDlCSXBaSFFXZThid3UvVTUvK2Zv?=
 =?utf-8?Q?UqZTtmJdTXgEmIdxmCAKJdYxr8PpL6plJ5AXzzTflB0ge?=
X-MS-Exchange-AntiSpam-MessageData-1: Ly2oCDxXCxn4zg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bb9a681-548c-4328-8657-08defc5f5edb
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 12:59:27.7841 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yz+wJHqbjcFHCUJsJ3aYOcoirdByFMiS9riAq6vUni8wVNg6mltDA7G1kX1aaS/2Wy/uFHVol3I/i7BoRBBtsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6833
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

Add the first user of NVKV encode/decode which is the request and
response for GSP init. For now this is exercised via unit tests. Later
patches will support GMCAPI in `Cmdq` and use these messages.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/fw/commands.rs | 349 +++++++++++++++++++++++++++++++
 drivers/gpu/nova-core/gsp/nvkv.rs        |   3 -
 2 files changed, 349 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index 6dc31d1bf5ae..4de44c2dc6aa 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -4,6 +4,7 @@
 use core::ops::Range;
 
 use kernel::{
+    bitfield,
     device,
     pci,
     prelude::*,
@@ -19,6 +20,20 @@
     num::IntoSafeCast, //
 };
 
+use crate::gsp::nvkv::{
+    nvkv_decode,
+    nvkv_encode,
+    Accumulated,
+    Array,
+    ArrayVec,
+    DecoderValue,
+    Encodable,
+    Encoder,
+    Key,
+    KeyId,
+    Required, //
+};
+
 use super::bindings;
 
 /// Payload of the `GspSetSystemInfo` command.
@@ -217,3 +232,337 @@ unsafe impl AsBytes for UnloadingGuestDriver {}
 // SAFETY: This struct only contains integer types for which all bit patterns
 // are valid.
 unsafe impl FromBytes for UnloadingGuestDriver {}
+
+/// The host CPU architecture.
+#[derive(Clone, Copy)]
+pub(crate) enum HostArch {
+    None = 0,
+    X86_64 = 1,
+    Ppc64le = 2,
+    Arm = 3,
+    Aarch64 = 4,
+    Riscv64 = 5,
+}
+
+// TODO[FPRI]: This is a temporary solution to be replaced with the corresponding derive macros once
+// they land.
+impl TryFrom<u32> for HostArch {
+    type Error = Error;
+
+    fn try_from(value: u32) -> Result<Self> {
+        match value {
+            0 => Ok(Self::None),
+            1 => Ok(Self::X86_64),
+            2 => Ok(Self::Ppc64le),
+            3 => Ok(Self::Arm),
+            4 => Ok(Self::Aarch64),
+            5 => Ok(Self::Riscv64),
+            _ => Err(EINVAL),
+        }
+    }
+}
+
+impl From<HostArch> for u32 {
+    fn from(value: HostArch) -> Self {
+        value as u32
+    }
+}
+
+nvkv_encode! {
+    /// A GSP registry entry.
+    struct RegKey {
+        key_name: Key<&'static [u8], { Self::REGKEY_NAME_KEY }>,
+        key_value: Key<u32, { Self::REGKEY_VALUE_U32_KEY }>,
+    }
+}
+
+impl RegKey {
+    // Define the Key IDs read/written by GSP.
+    const REGKEY_NAME_KEY: KeyId = 0x3070;
+    const REGKEY_VALUE_U32_KEY: KeyId = 0x3071;
+}
+
+impl Encodable for KVVec<RegKey> {
+    fn encode(&self, encoder: &mut Encoder) -> Result {
+        for regkey in self {
+            regkey.encode(encoder)?;
+        }
+        Ok(())
+    }
+}
+
+nvkv_encode! {
+    /// SR-IOV virtual function information.
+    struct VfInfo {
+        total_vfs: Key<u32, { Self::VF_TOTAL_VFS_KEY }>,
+        first_vf_offset: Key<u32, { Self::VF_FIRST_VF_OFFSET_KEY }>,
+        flags: Key<u64, { Self::VF_FLAGS_KEY }>,
+        first_bar0_address: Key<u64, { Self::VF_FIRST_BAR0_ADDRESS_KEY }>,
+        first_bar1_address: Key<u64, { Self::VF_FIRST_BAR1_ADDRESS_KEY }>,
+        first_bar2_address: Key<u64, { Self::VF_FIRST_BAR2_ADDRESS_KEY }>,
+    }
+}
+
+impl VfInfo {
+    // Define the Key IDs read/written by GSP.
+    const VF_TOTAL_VFS_KEY: KeyId = 0x0080;
+    const VF_FIRST_VF_OFFSET_KEY: KeyId = 0x0081;
+    const VF_FLAGS_KEY: KeyId = 0x1003;
+    const VF_FIRST_BAR0_ADDRESS_KEY: KeyId = 0x1050;
+    const VF_FIRST_BAR1_ADDRESS_KEY: KeyId = 0x1051;
+    const VF_FIRST_BAR2_ADDRESS_KEY: KeyId = 0x1052;
+}
+
+nvkv_encode! {
+    /// Payload of the `GSP_INIT` command.
+    // TODO: expect() doesn't work here due to Self:: reference, fixed in 1.97.0
+    // https://github.com/rust-lang/rust/pull/154377
+    #[cfg_attr(not(CONFIG_KUNIT), allow(dead_code))]
+    struct GspInitRequest {
+        pci_device_id: Key<u32, { Self::PCI_DEVICE_ID_KEY }>,
+        pci_sub_device_id: Key<u32, { Self::PCI_SUBDEVICE_ID_KEY }>,
+        pci_revision_id: Key<u32, { Self::PCI_REVISION_ID_KEY }>,
+        pci_config_mirror_base: Key<u32, { Self::PCI_CONFIG_MIRROR_BASE_KEY }>,
+        pci_config_mirror_size: Key<u32, { Self::PCI_CONFIG_MIRROR_SIZE_KEY }>,
+        host_arch: Key<HostArch, { Self::HOST_ARCH_KEY }, u32>,
+        bus_device_func: Key<u64, { Self::NV_DOMAIN_BUS_DEVICE_FUNC_KEY }>,
+        regkeys: KVVec<RegKey>,
+        vf_info: Option<VfInfo>,
+    }
+}
+
+impl GspInitRequest {
+    // Define the Key IDs read/written by GSP.
+    const PCI_DEVICE_ID_KEY: KeyId = 0x0001;
+    const PCI_SUBDEVICE_ID_KEY: KeyId = 0x0002;
+    const PCI_REVISION_ID_KEY: KeyId = 0x0003;
+    const PCI_CONFIG_MIRROR_BASE_KEY: KeyId = 0x0010;
+    const PCI_CONFIG_MIRROR_SIZE_KEY: KeyId = 0x0011;
+    const HOST_ARCH_KEY: KeyId = 0x0070;
+    const NV_DOMAIN_BUS_DEVICE_FUNC_KEY: KeyId = 0x1020;
+}
+
+// Decode:
+
+// Should decode with UnknownKeyPolicy::Ignore.
+nvkv_decode! {
+    /// Schema for the `GSP_INIT` response.
+    // TODO: expect() doesn't work here due to Self:: reference, fixed in 1.97.0
+    // https://github.com/rust-lang/rust/pull/154377
+    #[cfg_attr(not(CONFIG_KUNIT), allow(dead_code))]
+    #[derive(Default)]
+    struct GspInitResponseSchema => GspInitResponse {
+        gpu_name:
+            Array<u8, { GspInitResponse::MAX_GPU_NAME_LEN }, { Self::GPU_NAME_STRING_KEY }>,
+        fb_regions: Accumulated<FbRegionSchema>,
+        bar1_pde_base: Required<u64, { Self::BAR1_PDE_BASE_KEY }>,
+        vmmu_segment_size: Key<u64, { Self::VMMU_SEGMENT_SIZE_KEY }>,
+    }
+}
+
+impl GspInitResponseSchema {
+    // Define the Key IDs read/written by GSP.
+    const GPU_NAME_STRING_KEY: KeyId = 0x2000;
+    const BAR1_PDE_BASE_KEY: KeyId = 0x1020;
+    const VMMU_SEGMENT_SIZE_KEY: KeyId = 0x1050;
+}
+
+/// Payload of the `GSP_INIT` response.
+struct GspInitResponse {
+    gpu_name: ArrayVec<u8, { Self::MAX_GPU_NAME_LEN }>,
+    fb_regions: KVVec<FbRegion>,
+    bar1_pde_base: u64,
+    vmmu_segment_size: u64,
+}
+
+impl GspInitResponse {
+    const MAX_GPU_NAME_LEN: usize = 64;
+}
+
+nvkv_decode! {
+    /// Schema for one FB region of the `GSP_INIT` response.
+    #[derive(Default)]
+    struct FbRegionSchema => FbRegion {
+        base: Required<u64, { Self::BASE_KEY }>,
+        limit: Required<u64, { Self::LIMIT_KEY }>,
+        flags: Required<FbRegionFlags, { Self::FLAGS_KEY }>,
+        tag: Required<u32, { Self::TAG_KEY }>,
+    }
+}
+
+impl FbRegionSchema {
+    // Define the Key IDs read/written by GSP.
+    const BASE_KEY: KeyId = 0x1011;
+    const LIMIT_KEY: KeyId = 0x1012;
+    const FLAGS_KEY: KeyId = 0x0012;
+    const TAG_KEY: KeyId = 0x0013;
+}
+
+bitfield! {
+    /// FB region attribute flags.
+    struct FbRegionFlags(u32) {
+        0:0 support_compressed => bool;
+        1:1 support_iso => bool;
+        2:2 protected => bool;
+    }
+}
+
+impl TryFrom<DecoderValue<'_>> for FbRegionFlags {
+    type Error = Error;
+
+    fn try_from(value: DecoderValue<'_>) -> Result<Self> {
+        if let DecoderValue::Scalar32(v) = value {
+            Ok(v.into())
+        } else {
+            Err(EINVAL)
+        }
+    }
+}
+
+/// One FB memory region.
+struct FbRegion {
+    base: u64,
+    limit: u64,
+    flags: FbRegionFlags,
+    tag: u32,
+}
+
+#[kunit_tests(nova_core_fw_commands)]
+mod tests {
+    use crate::gsp::nvkv::{
+        Decoder,
+        Index,
+        UnknownKeyPolicy, //
+    };
+
+    use super::*;
+
+    // Tests that `GspInitRequest` encodes correctly.
+    #[test]
+    fn gsp_init_request() -> Result {
+        let mut encoder = Encoder::new();
+
+        let mut regkeys = KVVec::new();
+        regkeys.push(
+            RegKey {
+                key_name: b"test_key\0".into(),
+                key_value: 0xdead_beef.into(),
+            },
+            GFP_KERNEL,
+        )?;
+
+        let gsp_init = GspInitRequest {
+            pci_device_id: 45.into(),
+            pci_sub_device_id: 67.into(),
+            pci_revision_id: 3.into(),
+            pci_config_mirror_base: 0x1234_5678.into(),
+            pci_config_mirror_size: 0x1000.into(),
+            host_arch: HostArch::Aarch64.into(),
+            bus_device_func: 0x0001_0203_0405_0607.into(),
+            regkeys,
+            vf_info: Some(VfInfo {
+                total_vfs: 8.into(),
+                first_vf_offset: 1.into(),
+                flags: 0x7.into(),
+                first_bar0_address: 0x1000_0000.into(),
+                first_bar1_address: 0x2000_0000.into(),
+                first_bar2_address: 0x3000_0000.into(),
+            }),
+        };
+
+        gsp_init.encode(&mut encoder)?;
+        let encoded = encoder.finish();
+        assert_eq!(encoded.len(), 22);
+
+        Ok(())
+    }
+
+    // Tests that FB region decoding fails when required keys are missing.
+    #[test]
+    fn decode_fb_region_missing_required_fails() -> Result {
+        let mut encoder = Encoder::new();
+        encoder.encode_u64(FbRegionSchema::BASE_KEY, Index::new::<0>(), 0x1000_0000)?;
+        let data = encoder.finish();
+
+        let decoder = Decoder::new(&data, UnknownKeyPolicy::Ignore);
+        let init = decoder.decode(FbRegionSchema::default())?;
+        assert!(KBox::try_init(init, GFP_KERNEL).is_err());
+
+        Ok(())
+    }
+
+    // Tests that a minimal and a full `GSP_INIT` response decode correctly.
+    #[test]
+    fn gsp_init_response() -> Result {
+        let name = b"test name\0";
+        const BAR1_PDE_BASE: u64 = 0xdead_0000;
+        const FB_REGION0_BASE: u64 = 0x1000_0000;
+        const FB_REGION0_LIMIT: u64 = 0x1fff_ffff;
+        const FB_REGION0_FLAGS: u32 = 0x7;
+        const FB_REGION0_TAG: u32 = 0;
+        const FB_REGION1_BASE: u64 = 0x2000_0000;
+        const FB_REGION1_LIMIT: u64 = 0x2fff_ffff;
+        const FB_REGION1_FLAGS: u32 = 0x3;
+        const FB_REGION1_TAG: u32 = 1;
+        const VMMU_SEGMENT_SIZE: u64 = 0x0200_0000;
+
+        type Resp = GspInitResponseSchema;
+
+        let index0 = Index::new::<0>();
+        let index1 = Index::new::<1>();
+
+        // A minimal response: only the BAR1 PDE base, so the FB region list stays empty.
+        let mut encoder = Encoder::new();
+        encoder.encode_u64(Resp::BAR1_PDE_BASE_KEY, index0, BAR1_PDE_BASE)?;
+        let data = encoder.finish();
+
+        let decoder = Decoder::new(&data, UnknownKeyPolicy::Ignore);
+        let response = KBox::try_init(decoder.decode(Resp::default())?, GFP_KERNEL)?;
+        assert_eq!(response.bar1_pde_base, BAR1_PDE_BASE);
+        assert!(response.fb_regions.is_empty());
+
+        // A full response.
+        let mut encoder = Encoder::new();
+        encoder.encode_array8(Resp::GPU_NAME_STRING_KEY, index0, name)?;
+        encoder.encode_u64(Resp::BAR1_PDE_BASE_KEY, index0, BAR1_PDE_BASE)?;
+        encoder.encode_u64(FbRegionSchema::BASE_KEY, index0, FB_REGION0_BASE)?;
+        encoder.encode_u64(FbRegionSchema::LIMIT_KEY, index0, FB_REGION0_LIMIT)?;
+        encoder.encode_u32(FbRegionSchema::FLAGS_KEY, index0, FB_REGION0_FLAGS)?;
+        encoder.encode_u32(FbRegionSchema::TAG_KEY, index0, FB_REGION0_TAG)?;
+
+        // Test that this unrelated key can safely interleave.
+        encoder.encode_u64(Resp::VMMU_SEGMENT_SIZE_KEY, index0, VMMU_SEGMENT_SIZE)?;
+
+        encoder.encode_u64(FbRegionSchema::BASE_KEY, index1, FB_REGION1_BASE)?;
+        encoder.encode_u64(FbRegionSchema::LIMIT_KEY, index1, FB_REGION1_LIMIT)?;
+        encoder.encode_u32(FbRegionSchema::FLAGS_KEY, index1, FB_REGION1_FLAGS)?;
+        encoder.encode_u32(FbRegionSchema::TAG_KEY, index1, FB_REGION1_TAG)?;
+        let data = encoder.finish();
+
+        let decoder = Decoder::new(&data, UnknownKeyPolicy::Error);
+        let response = KBox::try_init(decoder.decode(Resp::default())?, GFP_KERNEL)?;
+
+        assert_eq!(&*response.gpu_name, &name[..]);
+        assert_eq!(response.bar1_pde_base, BAR1_PDE_BASE);
+        assert_eq!(response.fb_regions.len(), 2);
+
+        let fb_region0 = &response.fb_regions[0];
+        assert_eq!(fb_region0.base, FB_REGION0_BASE);
+        assert_eq!(fb_region0.limit, FB_REGION0_LIMIT);
+        assert_eq!(fb_region0.flags.into_raw(), FB_REGION0_FLAGS);
+        assert!(fb_region0.flags.support_compressed());
+        assert!(fb_region0.flags.support_iso());
+        assert!(fb_region0.flags.protected());
+        assert_eq!(fb_region0.tag, FB_REGION0_TAG);
+
+        let fb_region1 = &response.fb_regions[1];
+        assert_eq!(fb_region1.base, FB_REGION1_BASE);
+        assert_eq!(fb_region1.limit, FB_REGION1_LIMIT);
+        assert_eq!(fb_region1.flags.into_raw(), FB_REGION1_FLAGS);
+        assert_eq!(fb_region1.tag, FB_REGION1_TAG);
+
+        assert_eq!(response.vmmu_segment_size, VMMU_SEGMENT_SIZE);
+
+        Ok(())
+    }
+}
diff --git a/drivers/gpu/nova-core/gsp/nvkv.rs b/drivers/gpu/nova-core/gsp/nvkv.rs
index a0068847bb80..0afd6d5c48bd 100644
--- a/drivers/gpu/nova-core/gsp/nvkv.rs
+++ b/drivers/gpu/nova-core/gsp/nvkv.rs
@@ -9,9 +9,6 @@
 //! function calls will map to some struct - for example, f(GPU_NAME_STRING_KEY, 0, b"some gpu")
 //! naturally maps to storing a &str with the GPU name.
 
-#![cfg_attr(not(CONFIG_KUNIT), expect(unused_imports))]
-#![cfg_attr(not(CONFIG_KUNIT), expect(unused_macros))]
-
 use core::marker::PhantomData;
 use core::ops::{
     Deref,

-- 
2.55.0

