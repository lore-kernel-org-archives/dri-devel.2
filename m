Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB5EC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:22:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C47410EB79;
	Tue,  7 Jul 2026 07:22:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="i+ijTAed";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010006.outbound.protection.outlook.com [52.101.56.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB2E010E48A
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 07:22:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n0KqVBVaucqxgZzmJi+pSiUxvQmXawTMuq/Y3WjH90vpbVW8/KheGX1Xk9/S7oSlP3aDjhapY5eV7XHOUqoAIvwyhGZow1ogD6SpPJfm6xwLwRbNzj5IYHhA+N+f5bzFesXRolNmz/DvSAZUOBrW219qPeWuvhqXwDkixLBVUZU0nDUj8anS0imlKPXwrMa3NLEh3FFQcQVP6k6Xz0IZeRnSuIiK4MujYsL4mEU5bS7NiVcMOCTsPiTti5dhLjwsRLw4rC1lYs43RDNINfAV7ZjZfmYAoJAlho+PM8jgbHkQ76weZoCHu7iLbNuBxpcFgAn7DlggbAUNw+1SdC685A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2r3HyKN8UAOxjtGYKPstGKODmIAs4P61U+YSAWDQzps=;
 b=AutUuM7ihvTPqUikkP6UObIjp48ktocHinCwDvqlLsnOx6e+uZWCSeLlrlqP0yW+LqB3Nr/sROi2rjeWwoiF3LpydhG9KJcmZvpePEYCO4G/CnIuJeh5sfPfjNUjPWuQZd0QYr1NjhWTgElVh+CwZ0aJVWPS7qVRkx1OD9KeVjlgSAkyNHUxHUyXrJS9id50mUtnidE8S1yvHicWmGdHPhCRYbXdd+RCleIMDk7saEVJIx/t/hki5AT4pcPoeqc+QKZZBhZDvf9jNnLfd3XMQeo0Mszd9RyM+xfA1T0p9P9DqkuwYeaPoaj8HgmpU6Svlvz28Noj5Isjn5NVldsA9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2r3HyKN8UAOxjtGYKPstGKODmIAs4P61U+YSAWDQzps=;
 b=i+ijTAedrjH113VBaAwSKNvGRqqTAv4Ms/XBz7aBNwK41wOZtQgLVvBD9EmAmELwYS0bjBOIKVIhfeFg69rOtvpQ7stk5N3eProYA57VVpY5/nZyiTWo05FikKqAnl/uK9I1OcCaUTOx8+o+c5YhkrLCw+unV3hEeTRkuFi0ZcdX7E5WVcT1imsMiHAaGECgM5mnHRbgCNriaWBQoZ5b9d48eHk1nd1CgCCRRyOtxu/y1Wkb45Oi/4QbYWrUqNO5oGN9CpfSxQEMC4fsabSaFUiziiMHSlxjZPDhwgy3NoZBxqvX4XpNT9qyE4/XP5JvW+j/p9YrO4xs76sNo7yYIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Tue, 7 Jul 2026
 07:22:40 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 07:22:40 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 07 Jul 2026 16:21:45 +0900
Subject: [PATCH v5 12/13] gpu: nova-core: gsp: separate context and GPU
 lifetimes in GspBootContext
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-nova-bootcontext-v5-12-ecad9346387f@nvidia.com>
References: <20260707-nova-bootcontext-v5-0-ecad9346387f@nvidia.com>
In-Reply-To: <20260707-nova-bootcontext-v5-0-ecad9346387f@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Gary Guo <gary@garyguo.net>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY6PR01CA0009.jpnprd01.prod.outlook.com
 (2603:1096:405:3bc::11) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: fb8853ab-16a0-40e1-6082-08dedbf88750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10070799003|18002099003|921020|22082099003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: Dc8m+mKRwd+pyKOEaxQ3+Ucc7urAB3KQXJ8LAroPG62HO7FZ4i+QBuzbgVENOKavqmXTMlC7Z3dQeCD8kGJBndjhagSc6DQNI7tT0lIThuYyK3Pzxl6p4KK8jTBqzNjUx/4idbIoAAUdyvLWgqQZgp2PNhTaTbUv6dZIHX4vpaCUA6FBCL7trZ3fkJ5EcfPx9pd//2vA5PK30jSxRL3EFsFtIFCz6XgoZTA6saKBUpdwaYfQd0pOJymb5VVvjIjGPPnX+QgQACrNAIra3p5x01Pa6m+KXcDk3FUqyV0Qa50yF9rz4YIriijPxYZXYCvjc+Pih8mPncPwlsbQS/SeKo3TV6odDCY1xcWPNK/MyKMG5PKIV/K/uWXheaIIuYWL8wiVCyTMd2TdmLk6i1YqxfIfV8uaTQMVcH2p8TErLX6bS23crherRLxoWRGGLkfLu4Py4fdQwhNXFILzpOZKphUIX08MDzFWwKptnzOo2wLdMtBlgNXoAKB9GZlktA28pI4YgolQppc90W/ckVQPSDaAXtASdXnQzlDG9oj27Te6Qly3qzjT4l9OvJraY2AQX1iLplTmQgPajISG0YIMcnbPfOxcj8p/hhxh8/jGheMadE6qIubofo/HqAlo6OkYOkwugdTk8UDwaX6r+3GCxOJPUbRxMnmk4FN4zXcZV8W+lDWj0dwz018j1f41b0E00YGSKZYide1k1/Br2iuF0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10070799003)(18002099003)(921020)(22082099003)(11063799006)(5023799004)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UldVbmhKYmFpLzIyVUZrd2VsSERXaWZlNzZLM1p2NjVScDJnVnlpOVp6MFYz?=
 =?utf-8?B?WE1sMUNPVi9oQmZJVnQ1QS9rWmdqM1JydjgyMm90eDM4VXg5emY3cUxFYWJy?=
 =?utf-8?B?MjdqZDhDR1MyNHBQbGc1VTJCWDhtL1BYSE1rV21HLzBoU2d0WWdUcnVoeG5H?=
 =?utf-8?B?L1lpVXhWZDJsSHFPMUFYMWtSdEFlcjJNYTV2TnBqOGk0d0Vpbnd2bjYzKzRW?=
 =?utf-8?B?OS9xTnVmbHhHOGtSendHTE5xZ2MrUGMwOXJoeElZQU0vODFnRm9YMkFmMDVM?=
 =?utf-8?B?Szc4b1RxWEwvUklJNzVhUXRTYVBIQWNRSjRXSXdOZ0dmbXkvNTBTUXpkVklU?=
 =?utf-8?B?WXc2eEdDbnB2RDJxTDdjRVlVUEpOS1hjcXZzWFVIZ2xmNkMyVUxjbG56Ymda?=
 =?utf-8?B?Sm5BdTZaTFdIVnRKdkl3OVgwOGpVY0ZzNHpBK0J1Rnlxb1dhRjJzQ3ZTaDQz?=
 =?utf-8?B?UmpFb2tMeTVlL2ZJanc3TkVLbGdMSXZvMHR2eGFTM1BEOEFmbG02b1lyVVJ6?=
 =?utf-8?B?U3A0UzlrODRCV3BQUFhhTElNcjdpNE9OdDkxSXJaNEhFeWtDblZ0Q1ZoSG9L?=
 =?utf-8?B?UGxTY1I4c0xVZjBFcy9kTFhhWkR2SnVQeTVPVVBlTUpZbm5xVHBwNUtHaCs4?=
 =?utf-8?B?ZWNIbjVFQXlVQjRBeVJzVFZKSWdYOUs4dWdDY1VQNUFXMUsydWVmOGlzbWZ6?=
 =?utf-8?B?Q001djZRZ2IxYVk1NmpqS2Mxbm1lTlRQYmpqTFpYYkxFdENUOWFBQ1F5VHVR?=
 =?utf-8?B?UnhqeDQ1RmlBSzNzY1R5cHUraUdCb1RodC9ndk9qUTEyMC9LUUdlU0svd3NI?=
 =?utf-8?B?VG9pd3hBMXlpSDNKQitKbWxPajJmZGRYOXVQV3RxdlVEWjB2UFZFMGNyWXFp?=
 =?utf-8?B?aXhnRzR5STh2NldsVzhHNzA4UTRmY2dEY2dhNDhlVHlYdmp2bDU5MElpdU5I?=
 =?utf-8?B?eFBKR05BY0Z0cEhRbUhPMkU5SURmdlExYmRkTHMrUkI0VjhpcTB6a2pPTHUy?=
 =?utf-8?B?OUl5RUNRRUpoNDZSbXNiNzJjTEc5T2xSTE04MXJmYlF0a1hXeC9iU0ErTExQ?=
 =?utf-8?B?MWVUNUc3dnA4OWJ6cFNEajVKbVh4VWxUTmE3ZUZoL3NKN2ZPc2E1TFU1bW90?=
 =?utf-8?B?YWRNeG8rN1FEOG9reEdWdE5wRExhQVQyUmF4UGVycHRQc3BucWMvbFZxcERZ?=
 =?utf-8?B?c1d2ZG0wSmtEYXlnT3dXcmxLSy9yQmx4Z25zdWJ0NHBlRVVoZ0xYUlU0V0xu?=
 =?utf-8?B?SXRHVzJWR01WNmVTalg3S1pVZGlZNWRhakw2M2ZGdkVEd0l5NmhSNGJvalhX?=
 =?utf-8?B?NXAwRHR6cDZrK0NoM1dZSEJjazQ5VjJqVGZpd1FxK2pyZ3F3U2JiUFdVR0dJ?=
 =?utf-8?B?WXpweUNjZmo1REt4Sm9jLzZ2aERudjZwcytGYzZIWGVMWURpWjZBL3FuRWdU?=
 =?utf-8?B?b1ROSkNnSjZBZ0ttWXF2Wm42QjloZWgvVnRZRHQ1NnZJRWRiT29BVTNsOVdu?=
 =?utf-8?B?dFg4YlRDN1hwVjZwNEQrclNnTTlJbU0vRmIyL0xtK2ZpREZVZHRoOEtuaUhC?=
 =?utf-8?B?czl4aEpYMURBcy96TkhvWWpLTVFjUysxd1oyTFBzRENNY2FReVpSRXlPSW54?=
 =?utf-8?B?NWkxWCtnN1ErSkpBUUd3RmlwWkt4VG9RVzVYMDBhS1g1Nk1Dd1dXNFhCVjgz?=
 =?utf-8?B?TXNNWFVxTGQyVnpnYjdzbTY3eUNyZ3lLb2Q1OHJaU29sU1VEc0pZYk14TjFH?=
 =?utf-8?B?a1NOQ2VBR1RBN2swa0ZmSnZnbXNUNndWeE1COWo5RHJaS205alNFeXV1Ukxw?=
 =?utf-8?B?bXMrenVkRzVoNWlZZDNHa080Q0pTM3hlb21oSjVwcys2SXJYRlVzb3NsWjd3?=
 =?utf-8?B?UmlFTk1IMElQS0tHUUI4elZDTmxOZzFDcEl6WXcraDNSYjdPMXpPNGNhVGZY?=
 =?utf-8?B?cHE5MVVxOGQralA5ZXU5Y1l2U3NhMlE5RlM0cXB0NkJJSGY2QnFMUUlzNG9U?=
 =?utf-8?B?ZC9BYXhKQVRRNFF4c29KeEZnNklkTG9zdVk4YmdkSXFjbkJFMS9Wc2RlZmVp?=
 =?utf-8?B?UHErYjZVYjExYzBZc2xWaUJaNDRxemdmUE5jTDNvdVRNUU5iV1ZQaG9yc0FE?=
 =?utf-8?B?N0tRY2tydXYzM0ROaFNKOU1BSXNGbUMyMnRaSDNNNk5IYU5hL20vdHFKdmJP?=
 =?utf-8?B?amFnb1AwY2YxUytKM1Fnek9VVzVXaGFTR0o5VFdjMmpPbHVQcFNIU1R2a1pT?=
 =?utf-8?B?K3VHTXdVSGNuWXFXS1J1T3FITTdoNmZmMHMwM0ZURHdPRU1pNUo1dHh0bEJH?=
 =?utf-8?B?eWhBV1J2NUV3MDNSK1BWMlhNbFExUjdSREwwTDk4bGpJU0FTUFdFZmRlY3do?=
 =?utf-8?Q?tBra8xkUv3+3HWNZQTe6ShN5HUflS/HChnDKAqOFWGwY0?=
X-MS-Exchange-AntiSpam-MessageData-1: 6+KpitlrqhBLSQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb8853ab-16a0-40e1-6082-08dedbf88750
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 07:22:40.3042 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5VAzqBDur7zTc8P9xe4le2xYbJ64fbIPCr5IDsT8mkI+lyYippI8VTsz7J42HuXP52P/S5upiSi8yy912k6Yjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6604
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

`Falcon` instances retain references tied to the lifetime of the bound
GPU. `GspBootContext` currently uses that same lifetime for its own
borrows of the `Falcon` instances and other references.

But these lifetimes are independent: the references captured by a
`Falcon` remain valid for the GPU lifetime, while the context only
borrows the `Falcon` for the duration of a boot or unload operation.
This distinction is hidden for shared references by covariance, but
cannot be ignored anymore if the context carries mutable references to
GPU subdevices, as will happen for the `Fsp` and the `Falcon`s.

Thus, give `GspBootContext` separate lifetimes for its subdevice borrows
and the GPU resources captured by those subdevices, and update its users
accordingly.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp.rs           | 19 ++++++++++++-------
 drivers/gpu/nova-core/gsp/boot.rs      |  4 ++--
 drivers/gpu/nova-core/gsp/hal.rs       |  6 +++---
 drivers/gpu/nova-core/gsp/hal/gh100.rs |  4 ++--
 drivers/gpu/nova-core/gsp/hal/tu102.rs | 11 ++++++++---
 drivers/gpu/nova-core/gsp/sequencer.rs |  2 +-
 6 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index d5cca3c8350a..9f055a0d6cb9 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -54,16 +54,21 @@
 pub(crate) const GSP_PAGE_SIZE: usize = 1 << GSP_PAGE_SHIFT;
 
 /// Common context for the GSP boot process.
-pub(crate) struct GspBootContext<'a> {
-    pub(crate) pdev: &'a pci::Device<device::Bound>,
-    pub(crate) bar: Bar0<'a>,
+///
+/// It carries two distinct lifetimes:
+///
+/// - `'gpu` is the lifetime of the bound GPU device, as captured by the GPU subdevices.
+/// - `'ctx` is a shorter lifetime during which this context borrows those subdevices.
+pub(crate) struct GspBootContext<'ctx, 'gpu> {
+    pub(crate) pdev: &'gpu pci::Device<device::Bound>,
+    pub(crate) bar: Bar0<'gpu>,
     pub(crate) chipset: Chipset,
-    pub(crate) gsp_falcon: &'a Falcon<'a, GspFalcon>,
-    pub(crate) sec2_falcon: &'a Falcon<'a, Sec2Falcon>,
+    pub(crate) gsp_falcon: &'ctx Falcon<'gpu, GspFalcon>,
+    pub(crate) sec2_falcon: &'ctx Falcon<'gpu, Sec2Falcon>,
 }
 
-impl<'a> GspBootContext<'a> {
-    pub(crate) fn dev(&self) -> &'a device::Device<device::Bound> {
+impl<'ctx, 'gpu> GspBootContext<'ctx, 'gpu> {
+    pub(crate) fn dev(&self) -> &'gpu device::Device<device::Bound> {
         self.pdev.as_ref()
     }
 }
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index f093e0215b66..c347558aa8e5 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -39,7 +39,7 @@ impl super::Gsp {
     /// [`Self::unload`]) returned.
     pub(crate) fn boot(
         self: Pin<&mut Self>,
-        mut ctx: super::GspBootContext<'_>,
+        mut ctx: super::GspBootContext<'_, '_>,
     ) -> Result<Option<super::UnloadBundle>> {
         let pdev = ctx.pdev;
         let bar = ctx.bar;
@@ -125,7 +125,7 @@ fn shutdown_gsp(
     /// This stops all activity on the GSP.
     pub(crate) fn unload(
         &self,
-        mut ctx: super::GspBootContext<'_>,
+        mut ctx: super::GspBootContext<'_, '_>,
         unload_bundle: Option<super::UnloadBundle>,
     ) -> Result {
         let dev = ctx.dev();
diff --git a/drivers/gpu/nova-core/gsp/hal.rs b/drivers/gpu/nova-core/gsp/hal.rs
index 7ebdeafc1432..34b4bb82a999 100644
--- a/drivers/gpu/nova-core/gsp/hal.rs
+++ b/drivers/gpu/nova-core/gsp/hal.rs
@@ -31,7 +31,7 @@
 /// required for unloading is prepared at load time, and stored here until it needs to be run.
 pub(super) trait UnloadBundle: Send {
     /// Performs the steps required to properly reset the GSP after it has been stopped.
-    fn run(&self, ctx: &mut GspBootContext<'_>) -> Result;
+    fn run(&self, ctx: &mut GspBootContext<'_, '_>) -> Result;
 }
 
 /// Trait implemented by GSP HALs.
@@ -43,7 +43,7 @@ pub(super) trait GspHal: Send {
     fn boot(
         &self,
         gsp: &Gsp,
-        ctx: &mut GspBootContext<'_>,
+        ctx: &mut GspBootContext<'_, '_>,
         fb_layout: &FbLayout,
         wpr_meta: &Coherent<GspFwWprMeta>,
     ) -> Result<Option<crate::gsp::UnloadBundle>>;
@@ -55,7 +55,7 @@ fn boot(
     fn post_boot(
         &self,
         _gsp: &Gsp,
-        _ctx: &mut GspBootContext<'_>,
+        _ctx: &mut GspBootContext<'_, '_>,
         _gsp_fw: &GspFirmware,
     ) -> Result {
         Ok(())
diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-core/gsp/hal/gh100.rs
index 043a15dda5be..be531df8680b 100644
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -114,7 +114,7 @@ fn wait_for_gsp_lockdown_release(
 struct FspUnloadBundle;
 
 impl UnloadBundle for FspUnloadBundle {
-    fn run(&self, ctx: &mut GspBootContext<'_>) -> Result {
+    fn run(&self, ctx: &mut GspBootContext<'_, '_>) -> Result {
         // GSP falcon does most of the work of resetting, so just wait for it to finish.
         read_poll_timeout(
             || Ok(ctx.gsp_falcon.is_riscv_active()),
@@ -137,7 +137,7 @@ impl GspHal for Gh100 {
     fn boot(
         &self,
         gsp: &Gsp,
-        ctx: &mut GspBootContext<'_>,
+        ctx: &mut GspBootContext<'_, '_>,
         fb_layout: &FbLayout,
         wpr_meta: &Coherent<GspFwWprMeta>,
     ) -> Result<Option<crate::gsp::UnloadBundle>> {
diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index 4e2f48c27368..29bb17171f56 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -78,7 +78,7 @@ struct Sec2UnloadBundle {
 }
 
 impl UnloadBundle for Sec2UnloadBundle {
-    fn run(&self, ctx: &mut GspBootContext<'_>) -> Result {
+    fn run(&self, ctx: &mut GspBootContext<'_, '_>) -> Result {
         let dev = ctx.dev();
         let bar = ctx.bar;
 
@@ -258,7 +258,7 @@ impl GspHal for Tu102 {
     fn boot(
         &self,
         gsp: &Gsp,
-        ctx: &mut GspBootContext<'_>,
+        ctx: &mut GspBootContext<'_, '_>,
         fb_layout: &FbLayout,
         wpr_meta: &Coherent<GspFwWprMeta>,
     ) -> Result<Option<crate::gsp::UnloadBundle>> {
@@ -314,7 +314,12 @@ fn boot(
         Ok(unload_guard.dismiss())
     }
 
-    fn post_boot(&self, gsp: &Gsp, ctx: &mut GspBootContext<'_>, gsp_fw: &GspFirmware) -> Result {
+    fn post_boot(
+        &self,
+        gsp: &Gsp,
+        ctx: &mut GspBootContext<'_, '_>,
+        gsp_fw: &GspFirmware,
+    ) -> Result {
         GspSequencer::run(
             &gsp.cmdq,
             ctx,
diff --git a/drivers/gpu/nova-core/gsp/sequencer.rs b/drivers/gpu/nova-core/gsp/sequencer.rs
index ddce32cc4e30..422a74f9ecbd 100644
--- a/drivers/gpu/nova-core/gsp/sequencer.rs
+++ b/drivers/gpu/nova-core/gsp/sequencer.rs
@@ -335,7 +335,7 @@ fn next(&mut self) -> Option<Self::Item> {
 impl<'a> GspSequencer<'a> {
     pub(crate) fn run(
         cmdq: &Cmdq,
-        ctx: &'a GspBootContext<'_>,
+        ctx: &'a GspBootContext<'_, '_>,
         libos_dma_handle: u64,
         bootloader_app_version: u32,
     ) -> Result {

-- 
2.55.0

