Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87872F9EDD3
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 13:41:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0E2F10EA2D;
	Wed, 22 Apr 2026 13:41:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="bU6w1XSx";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012048.outbound.protection.outlook.com [40.107.209.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E06BF10EA33
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 13:41:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BkNE8ZdbzTjsXTa3YLm0ruAQkoO/0LDdTwcp8EuewtzapeQcOSyTpQ+ffkOgBHBmc9WloQjB1NmVzKBtTkFTJgsxukTl0mLsmu63wx5de7y7NqrqZ7D/47Bo52fAU8T7RDHgelqTyM29nJWCVeIgPBrNLWiaG1X3I/IMHeNFAKbxUC3qtvRk0PP0h3j8qJf3SEdIlAiZb9Gyrw+Mb/nAK1ydPE/C79hqAOfGH3goVFM+/2rlXmhWzKrDrWvqJDw9eq2Ouy5pL+YgzrjaoCKaB2k1VkDP0kZYCJT4tpa/tMBbYc6cvlxUN34PPts4mxM+Yi/Sa8X3q0AE9k0GuxdI6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZf3zbUIXpxZGwY+LxKvkuVOlZNZWEOeNs223MK7yvI=;
 b=ElxL0qzwkSvO9jPszmuu982cIYeteUiKPJZ/L1PyFmeobI/7It5QqtrCD0F+o2GqAEKKQP1UJGihAnxJ5/5Iq0Y0zupYl15ZJq+dK4B0IVaZUL/xLi/G4RjEOUunsunNQGgMEJWYSKProVelDMNie4iQqXw2+5KvO9zscfhGy5Q/Q8MC6ssAMQKOLIR9ave1I+fq/o9wGmVDgDje0BHPxwOT5wo+T+BQVRTDyqQoRd3asaSBBG8afIL9Qoff5rCgVst8z4/2Ew0fCYCvmoa4Rhk49l0UWDOGI0CwMT5EVOisrYHbcONMZKNEj+VhUDOwd5mSm/LbX2Kms+4jWkRWKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZf3zbUIXpxZGwY+LxKvkuVOlZNZWEOeNs223MK7yvI=;
 b=bU6w1XSx41I0WqQ6ZQMt526EXbH0Eyn5RtuVCV4fTOa4p5ogiCU1VF2BulEylFECifGjm+SpyqvwuDv4RFEsI4Eu3Nl58T1kqxvhyDbpDE/7W9jz5QbfAgyCWA4g4168KWGmz9IoZFj1p7l5nvT1oaMclcu9a0yLGKbuyQVJd5zw1zErsOx96n6vPGo9cVf7c6Xr2/il5iSE4GfNsJkvnrSW/R1hT8CV3w4iilpFoxswEVbczykNL5M3FQ8ZOH1LbRyq52stvc7H+3l3G1oI2PVJq4Zhrv8k33XVxl/J7kRUhVDfRTtknwaR4woJlfPixlsxKn6BP6YjIwq/60QsdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS4PR12MB9682.namprd12.prod.outlook.com (2603:10b6:8:27f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Wed, 22 Apr
 2026 13:41:11 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9846.019; Wed, 22 Apr 2026
 13:41:11 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 22 Apr 2026 22:40:53 +0900
Subject: [PATCH v3 3/6] gpu: nova-core: remove unneeded get_gsp_info proxy
 function
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-nova-unload-v3-3-1d2c81bd3ced@nvidia.com>
References: <20260422-nova-unload-v3-0-1d2c81bd3ced@nvidia.com>
In-Reply-To: <20260422-nova-unload-v3-0-1d2c81bd3ced@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Boqun Feng <boqun@kernel.org>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4PR01CA0031.jpnprd01.prod.outlook.com
 (2603:1096:405:2bd::9) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS4PR12MB9682:EE_
X-MS-Office365-Filtering-Correlation-Id: dfa9fa05-3090-4056-d9d5-08dea074d0c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|10070799003|366016|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 0iPQ+Nf9247GpUq/2HQ94LhMzs9uQwM1MELIbVLdHJsbZk9uvgC1C3iLHQxbEmo5MK4fLOAUJk4o02QFtA145Dj6SIt1UHhtVbCDtiAYOM+O2GPzuWfdGP2cf8Sc4qP8Nflazk//GYQSgGxgmuzaXgL5F+3O/CoU5ZYYxnJPHTCQZLzswoZhiKMnvEVwvc/uxapfGJfZ0reh7aIjg9zzj3BwlIpECuNAX3GuYND7qsHNfNBPoiP8xrMxp/H0/IMFh14TqXyOAgDVq2YWtRhX0wUGoJEyB8iydN7dfKWT5EdLFYJjW2F6Ev8JVckPgxwQnbUBSHSSd2bqqn11omuAi8lIV/I8GMAqNmDgRAqCuh+gIVhB5oivli9UdWmVxVP1/KIUKtGwRFh6pVSPK6NrVexGYZHhiNS5G8byDxWVrzQBNMDO7pVKVqwrQfkkuXMbT+GS4YxzGBIcTnxecVVsLSe/qrkcgAaS5U3LzCfNNxFV/7CqT6/bcXTiQ6CTeWVshJED+zSw1xT0sCPnLAAmQ7aj6SVeUDXOVM+6FOxysrZCjyQB+K2cS2K2ZuaRrMcCaxIwBLvIcWy0zRJ4fXEib6DfUvgwPaw8eUd7D8cVaqc6nSwclixxpi38mdZEzcuqA0h9TCM6jrOCq6XdySCP0bTiC+Mv30Kstci0BlcrvzmZDBMDYCXKHKxVlmpNCHIdPcoF4EmjUhACWXDFngI92y3d58FFzbt/q+QQ8KeZ1dvNUFmJ3MXLef5gqQbxn2lc1KZXMwbnV3wfjsxkqbO7zA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016)(921020)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHRXTUdoaU9xSHEwN3g2ajhobDBUajJ3MTJnSktTc09tWnRaNmQ2L1cvTWFM?=
 =?utf-8?B?WFgrTitTK0J1YTBJTVZIMktML1pOOHdTcHlEek5ZbWI4KzU3Rlo3d2lKUDIy?=
 =?utf-8?B?UWFQdVVsY0o0VFFwaDJkb1V3elVaYzlnSUxvYlhSSXo1Ui9qU3dmUVllTUJO?=
 =?utf-8?B?RU5QeUhwZUNTdXBuamd2U2xsYXlXUVFnQjV6UVZLV0xqU1ZKS05FelR2d0RG?=
 =?utf-8?B?cDVuNnh5czZlN05vUjRRbyt3S3IwZjkrM0VVbVlEMXB0Q3FnQUtOQW1lWG5G?=
 =?utf-8?B?cUFyN2hwUEpXaGVmcjE3Y3l1TUh4MjVsMTEyUmYxVWV0aitkY21pTzFyTjBQ?=
 =?utf-8?B?QjFjTUQxaGhISlZaWHpVaGYxeGJ1U29CZ3pvT21janVCUnB2ZzQvUUVtamJK?=
 =?utf-8?B?bm1xbEl4c3dtUHZZZUVQeTFwaXdwMmVJY2N2cCs5ZWE3eWRVMzliRDVSSmIw?=
 =?utf-8?B?VkdsaGpLTENsRzdxdkNJbDVUV3Q2U0pTNlZ4dFVKd0g0dTFTYzZyTnNUclZm?=
 =?utf-8?B?QTh1TGdtQ1oyczdaVUVTOHd0QUZzQ2RqVlUyOTRqRDB0UGhqSWwzTlJNTVk0?=
 =?utf-8?B?REswYm9FQWFDN3ZwMXZqREdDSGFzcGRlUHozS0pKZXhMTlY5R2NaemNYQmZ3?=
 =?utf-8?B?anMwTU1nVHhWdU1sdHA4NEpxNzQ4djRmK0Jxd1BjbTc3S2JjSUJkQVpZMEFl?=
 =?utf-8?B?WC9PUmx5NFZGUkVGd1d3cUZ1Wkh6cVlNYURjaEx1Q1FPSFdERVN5dzZaRmx3?=
 =?utf-8?B?SXREMjQwTVFQUHM0ZDRyczNoRnl0M3R5OGhha3lkM3R2blZkRURHWThidWpx?=
 =?utf-8?B?ZlZXNDlZVnZ4Y2U2VjZweWt0eFhMaFk3Qk5ERHltV2Z2MmZBdmFWUHovSDZL?=
 =?utf-8?B?NFpDRFhyYXVtaHp2S1p2VktUdllYbWNHZUZybGdWbU1pRllyM3l1YzQyTVNj?=
 =?utf-8?B?b1dJSjJwYzB2UTVXczZ3andEa2YvaUJFY0Z2eDFXQWxDZVRjOEJHbk5sWTVW?=
 =?utf-8?B?amJPTTRJeG9sWkRvaUdPK1dBckpmZFRuUHNiSTJVMkhFVWs5ekhnc05KMlhS?=
 =?utf-8?B?b0VWYmV2WTRxWGJhK2NCOE5YeGthaklqR2Q2RjdnLzRDZWNGUk9jbVhLUUpT?=
 =?utf-8?B?TjRkTjVaekcvcWtuNm9udDVCaWtpeUozKzhXdWVheFMzd0ZrRzJYZ1ZtaEty?=
 =?utf-8?B?NHJnaS9oMHl2TWxHem54cjU2Y1ozRzdSV0VQamplZHRzUEluNi90MVdIZ2xq?=
 =?utf-8?B?VGNLUGNSZ0NaTzBzWkVjTGF1WHcvV013eWdvOGZxRyt1cjduS1g5bnlKbERj?=
 =?utf-8?B?V1lRb1Q1MDVOUHZzaUVQakFlVXZia1UyM3Z5ZWV0T1FvOEZTb2JncWMzSWE5?=
 =?utf-8?B?MERidTFBMmxSaXV3SE5SS1g1THozSnJxMUxwR2U0WFNiYVhnbm1vZ3g1RjJN?=
 =?utf-8?B?MkVwSGs3WjBtM3ZnZ2RCL1N0MkRUWndrOUd3RWNnN2ZIZHRyTXpIakNuVWcv?=
 =?utf-8?B?cGVUN1Jod2RFNjBvWFlDZFBEOFk5TmRDTVhMcGVXeGRrREI2MzFqWEF2TUJC?=
 =?utf-8?B?YnZOL21VYnRlWm9EVmp5RXVReHNNV0xuZXdEVGpjMVNRRzVRODNzRlQyZE0y?=
 =?utf-8?B?SGtVMXZmbGNnbkowUXE5ZGVka0xYQjA2SDkzR1BWNmFYcURIai9SQ3hubFVl?=
 =?utf-8?B?YVNTV2hIVGJmWi9DbU5LU1RZcUZqUlJuUWxqR0pSZkNlcEFiV3d3a0ZqR1FR?=
 =?utf-8?B?YkxXNjJUeTBXaTF5TDNCWUpBSzdUblVVY1pzQ0Z0NjMxdnRibGtTblVlSWI0?=
 =?utf-8?B?emwySnF2eGY1eE9obUZxbURrYlA1RnY4cFl6Z3BBT00wbFNpcWtGNU1qTHpJ?=
 =?utf-8?B?Rm5GOTJTcTAydVMzeWdsckxIUzhoQmkzSlNIOU1sZllLZ1VsVjVNd25XR1RX?=
 =?utf-8?B?bjZFSkxIK3dCTmlNOXI0QkFzSGM2L1dRUVhiRkVkNU05YzlEbE5nLzNlRTRz?=
 =?utf-8?B?WnBDTkp1TEZrZEcwVVN2cXdVNVYrdGxiZGdDRUlmZVh2WmkwMFIxN0VTWXlX?=
 =?utf-8?B?dHV2Z0p0eGFJdmtHcWFEY1BMYThIcVBrTWhFNHV5NjQ2TldpeWlVNDN0dnh4?=
 =?utf-8?B?THFnbDBoYTNpVUhiQVF2dEVEbmUrbWU5VE1JN1VKQnhOdk9qaFZlMWNIL3hn?=
 =?utf-8?B?YjM1V0FiOGFOVUtnSWhBVW5XTkVwUEk3b0VyMVovTXd5cmVkMjFvbWI2dFVN?=
 =?utf-8?B?OGxJbDE1citFTFdPZktlMGgwM1dQYkR2aHlBVVhITnpobk14c1RHa0tXV21C?=
 =?utf-8?B?TStoeG5VbTRwcmVBdVFmWi9mNTI2dDQyV043NDVDemlDc3VXODNLTWhEanU1?=
 =?utf-8?Q?nqHquWhgMY5r6yGUFoCLXmfnCRgG9BLbJBRTdCgTNPyfx?=
X-MS-Exchange-AntiSpam-MessageData-1: mZgqmVDXJ/yRZQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa9fa05-3090-4056-d9d5-08dea074d0c3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 13:41:11.4354 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ojC21XRF+HWx71v/ClCVN2fYWKmq9CpQ4oyfhu5WSceoj9ftzQHVf8vLTSQ3TomzONQpUC504io8hz3I/pATg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9682
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

This function was useful before the generic command-queue send methods
got merged, but it is just boilerplate now. Replace it with the correct
sequence to queue the `GetGspStaticInfo` command directly.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/boot.rs     | 2 +-
 drivers/gpu/nova-core/gsp/commands.rs | 8 +-------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 18f356c9178e..9b6f349d3339 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -229,7 +229,7 @@ pub(crate) fn boot(
         commands::wait_gsp_init_done(&self.cmdq)?;
 
         // Obtain and display basic GPU information.
-        let info = commands::get_gsp_info(&self.cmdq, bar)?;
+        let info = self.cmdq.send_command(bar, commands::GetGspStaticInfo)?;
         match info.gpu_name() {
             Ok(name) => dev_info!(pdev, "GPU name: {}\n", name),
             Err(e) => dev_warn!(pdev, "GPU name unavailable: {:?}\n", e),
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index c89c7b57a751..e81a865050e0 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -18,7 +18,6 @@
 };
 
 use crate::{
-    driver::Bar0,
     gsp::{
         cmdq::{
             Cmdq,
@@ -176,7 +175,7 @@ pub(crate) fn wait_gsp_init_done(cmdq: &Cmdq) -> Result {
 }
 
 /// The `GetGspStaticInfo` command.
-struct GetGspStaticInfo;
+pub(crate) struct GetGspStaticInfo;
 
 impl CommandToGsp for GetGspStaticInfo {
     const FUNCTION: MsgFunction = MsgFunction::GetGspStaticInfo;
@@ -232,8 +231,3 @@ pub(crate) fn gpu_name(&self) -> core::result::Result<&str, GpuNameError> {
             .map_err(GpuNameError::InvalidUtf8)
     }
 }
-
-/// Send the [`GetGspInfo`] command and awaits for its reply.
-pub(crate) fn get_gsp_info(cmdq: &Cmdq, bar: &Bar0) -> Result<GetGspStaticInfoReply> {
-    cmdq.send_command(bar, GetGspStaticInfo)
-}

-- 
2.53.0

