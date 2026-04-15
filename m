Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C9D9F428D0
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 19:58:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB78F10E746;
	Wed, 15 Apr 2026 19:58:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="i1lyYKl2";
	dkim-atps=neutral
Received: from LO3P265CU004.outbound.protection.outlook.com
 (mail-uksouthazon11020081.outbound.protection.outlook.com [52.101.196.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BFEC10E18F;
 Wed, 15 Apr 2026 19:58:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YDZrCHGyy8kVmcEI+3B4aS/ElN+e1OoTKHzuzycRmAQ/Mq6zTlkbNCfnFAzwcgP3Uj4Nv5wd8Hc7Pux9vSYlvdLYlDtTWKngnxicwbY8e0S7hvXYjvGxS6PHYGZvmC2jxaSeZf/LMRb9UKsqhPKXRYtjfsmEhiAwLBwKUgBJ0QwIwTGgS98hJtWkphO6c+dc7IfAUo18s2GC8aoUg0E+d9SixXezgVUJqU1soYmXNN3J8oM2AdQiP+HCTwRfedUtAhk96DxSeLVfcZo7ljIl+6KjPfdOz7dlMzLG9KsltDZcsTGMdoCeagJNKG9whia8RydOuSN7Bi9GNMkTnENcoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpjY6jK4dzuJg9RjHWUzuRc9xXXEwcexrr4wnzfgOEA=;
 b=w3DNtADwPg+rZKTaEilPzaSwn7KsFVQDItqALct9Bm+VfU6FiFdQ/E5F7QIVFY4rfFkCwupy8OrcKHDRJeW9nC6EHv82a6JtmQIUFvBMp47tsy/wDbxgxpFp8odXrVmF+2Xf8XprdRtmgop9/+ddSxlEGACApuudPIsUKcGFc4Inyt5UjDDGs6I6DtrvLJUS9zMPVAsAyq25BVrXuR/W8d/NllHJXDJ55aUq82yDZMPdIrmQCZ/DPhPzgyOkZlxcDHNpIifQGNpu22LD+BYj2cEThRPwJmO5dbVZdgFIQVA69wx1Y6cfbpxBBUh+EmrD3DcCpCnYRGCjMVk0WKItDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpjY6jK4dzuJg9RjHWUzuRc9xXXEwcexrr4wnzfgOEA=;
 b=i1lyYKl2kq/V8MCz7evJnpkarle+mt6aOzwLsAI4Dmzjfvyzz8famE1zQP64zBq2flRqAuJExLzWOUhUfFE0CN6rFJA3/IlqAcxT7DA7/i+j3d3mbUFRhe/+kwC4rv92qrE18Sd/535OyPFjwJISwUtaKrjvtdQrXMGbMEx+ETc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB1910.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:32::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 19:58:06 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 19:58:06 +0000
From: Gary Guo <gary@garyguo.net>
Date: Wed, 15 Apr 2026 20:57:13 +0100
Subject: [PATCH 2/5] rust: dma: update to keyworded index projection syntax
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-projection-syntax-rework-v1-2-450723cb3727@garyguo.net>
References: <20260415-projection-syntax-rework-v1-0-450723cb3727@garyguo.net>
In-Reply-To: <20260415-projection-syntax-rework-v1-0-450723cb3727@garyguo.net>
To: Danilo Krummrich <dakr@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Alexandre Courbot <acourbot@nvidia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Gary Guo <gary@garyguo.net>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776283085; l=3112;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=UhRRiSC/fJzIqFGzc8d2bQlud9AWS1icv1eLsg8ynFw=;
 b=XcUKIpsjnLXZz7tCTlpJYhdM4xH9EH99h2FgvwhakbOolu9FZF2B0xOB2zikPnrKO2qd+9Uw0
 y5lVGkvsUsXBl/B4jF4ug48bFcdQbGVAoLEd49rPNNFGHxBqP/b5f/I
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P123CA0276.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::11) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB1910:EE_
X-MS-Office365-Filtering-Correlation-Id: e3f8dca8-7780-461e-7701-08de9b294f9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|7416014|376014|22082099003|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: C4/qb2tSAuoQud72PPIeEaCeAJ+mk6wpbaxXbaHJaLd//5HdkD6/dAEJyErHvTMLAVnArmZXmiMEOrrQrPVyXMbXLqIdKZVsQn/VWU7XY0vtuMFO4TyzcMh2p3IXTZ3GOJwyU/qKy/XYpgYK8WqC97chSvDsUop1w3fFYnGGCGFurj2cmBZ/akWMeZYkFlCUmfLWMopjEnfgi4ZLnYKB3p20kHGe5428uskesQTMrGxiA3jjRD7llQd0V9Ovl0ExFyI+LXYN2f37HZwE0ftcaWYuCGdIj8MRYSli1KBUpyuZCRrYMWTxAoNO3rOiL3//7giMVGieDURWvYYZfzDqZkbp62br1YEm0Ybuor83zgkHBGY6SjGADr7P1qFym/sZWcTvcZZJzCWYC2TCVKtJQPWKmLzq26p9HDT7NHB7bGArQrBKbKwDImgONNuDZxoXugMfiu7hpvCyBoGeg/E7eBCY2gzoNIOjYzZTPELM7jHVi2LgCsHyXm/cbn171J7uVsmwCOkm1hSCNFZsOWokonnZvRSLOZ5AqMnPOr5Tn9nF/nFj9Ga9nPdMK6GlY0kBGjS9LEpOrkAP6BLSo5rGX+M4h9S4e/mKhA9kWK0wdizKGA1+QdLjZ/mnG88uDNB26jwMcvq8kYhwcg+qliMwVzfR/KhU7K5XYorcIJWakIOSXt6VB7q3qKMM48dQisyGoO2id+wQu31yxfjEYVl5Wi7yjrxl/OCfets2Y4WMa5EMoSfjr8kZ6LK/1oCgAm4FFsPHLWYkwXl4Pv2J91QMhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(22082099003)(921020)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlpSN1M1eWxyVERFQlF2bXYvQXVjcW1qWGo2MktYN0NhdjFhQTVETkd1MmQx?=
 =?utf-8?B?cE9lSlBoNi9lZnNYNzRIS0xQN2Y4U2JyTklGNG1venBMMStYN3VXdm4vNUgz?=
 =?utf-8?B?OVUvSXlRek1PdTZVcnQrZ3kranMvTUxFOW4ra1Y3SWltRFJPNVJyQmxUME1r?=
 =?utf-8?B?WlpSK2VuMUtVbUZQREVEd2FzWUZ2UnpROWtyeDV5VjFnUjJZUzBMdkYrRGdI?=
 =?utf-8?B?SU5TNlJJRVUyUndsUFZMVUFkNjNOblF5MkkrbXl4bkh5b25aWjBaWm10T2J5?=
 =?utf-8?B?aVluaVZETkdyelo2ZFlNUHFWUVpaWks0TDlrNEMzQmFWd1ZUS2R2ajJTaE5T?=
 =?utf-8?B?czFFaXlMSnZPSmhLcmFDNXF6NkNMK09nM0NkWEFHRDM0ZXVaYmZSRS9xL21T?=
 =?utf-8?B?bE54MXNIaWEya1ZaVFpCOGZpV2xRMmcwa1NOUTIxYkwyUDVGSnRxSHF2NUJn?=
 =?utf-8?B?OUQrR1RrY3NhRFd5NDh4LzBZOUd2Q3VsSVgwdXpJcTNmcmZFV3VpN1lML2lk?=
 =?utf-8?B?NHIwdkd5VXUvT2dUMTFWOHowTHI5NjNCMzRqQzhHVHloalNleFNXVkpuUWIr?=
 =?utf-8?B?RzBGbERaMExmcHI0a0hjVFQzMW9BMDhKMzZwR29pUmc0b2NlNnBlQzZsM29v?=
 =?utf-8?B?WlhMeW4yWkZ1c3lrUVZWUE1HaHFiY09WTHlqWTQ0SnovWXhIK25lU1RxZG1V?=
 =?utf-8?B?SjFSM3lXZnZhUldBcmUyS0FyaWx5dlF2M0JrQU1odWk0NUw3UGdpK3lpajQ5?=
 =?utf-8?B?SUQ1cGFDN1g5djAvcGNhaG95Mmp0dVkwMzRFRUlCMGFFOUpIVGUrTTRFSnRB?=
 =?utf-8?B?dmtrOGFuUExHRFJIWjEyNEU5N2pqM3lVMmMwc0dmR1F2MW1lbzdLMWlndGNx?=
 =?utf-8?B?Snl1aWROR21LVFpYVi93bGNkcGxsVGt5YmhCUzlBUVl1UEdjVys3cTloamFX?=
 =?utf-8?B?cFRVVVJtTjNibjNNUkpJcmhTYy9UK1c5cG0yR1BxeTBKOE8vUmFZaDNOczhY?=
 =?utf-8?B?U3o5U1NQVWUvTndIeGR4OUxUN2JTRnhTQ2VLZGRtcXo4RHNJMG5IZVE3Q0JB?=
 =?utf-8?B?SlJ5emRWa01ZVTV1eUtMRkUvN2ZaM1VzVkZHMGlSYk9lMkFLWks0clVOb2lp?=
 =?utf-8?B?YUc2SUNmUkNSQlZwWUZFU3JaSTlXWVJicGNYbW5GUEhVOVY5aktrR01VckR6?=
 =?utf-8?B?Z0tjRUpQdXAraXhJeVFPQmtJZmk4bVdjK1FBejgzWGJZNHdwc3VRL2xtcW1S?=
 =?utf-8?B?UjJaTDNPV2EzSUZUZkthVnB3VzJIbGtib1QzYi9zbE1yNHVCSGNWbm1rVTdM?=
 =?utf-8?B?OCsyWStHd2c1ZjZWVEdwWHJ1TWFLbVI3QjNRVE9RU29rU0ZyckpxMGdNVXh2?=
 =?utf-8?B?emlaTHQ1amtGbXY4aVNnZE1QUU5ZWDBKS1VmQTJxeWkwcnM3dEtyYWFJeVRR?=
 =?utf-8?B?TXJoQ2ZidGZXdHJnVk10Q3RORWZsellreGg4RVRiNExuUUg4NDc2M3gzTXJK?=
 =?utf-8?B?QlA3ODN3aEpLN0VFdldRaHY0ZjQ5d3FkdllWaEx4V1E1b3ZjS1QwdkxmM1Rh?=
 =?utf-8?B?TzMxL1VyMk82K0pwbXVaT2pvWm9MSEdlK1FXVUswNHdsaHJ6WnVTUGg5YjZJ?=
 =?utf-8?B?VWE0UkpCYnFEajZpMzBPOHIvTHNSbzh6dnM0NmRSenhPdGNOa1BmbTZiNXNH?=
 =?utf-8?B?clNiSFhoR0IvNmswUWU4dE14ZUc3WE9Dd3R1Yks1Z09mNDhIaVp6VDl1SFdK?=
 =?utf-8?B?aU9YWXRiYWMvb0grVjBJZ2duVWxoR0xSVFhuQklUUTM4cTdsY3N0bmVjZ1Zj?=
 =?utf-8?B?UXBZSlN0ZGFNbllNdnY1NUNKemM2RFVWMFVFS2ZlNkRzU2tUOG5OT1AwbTht?=
 =?utf-8?B?cGdDdFZiK0MwQXQrY05JMmJkSEk0aE85cnNtRHVtOWFvcHZJYkFFKzlsYlNs?=
 =?utf-8?B?SSt4WldJU01pMWR1eW1tRHV2dkNOVFVzQnpOdVgwbFVob2J3QlBqSlRtNlBp?=
 =?utf-8?B?elkxTXFNRkpjakc0c0diTjA1RzZPSTR3M3VrWmNYNElPNzJSbzBBRk1Bcm1T?=
 =?utf-8?B?NjZNYmhQanRWcGZmdWZIWXJ2M2dXbmJmVGVpRHkxK2NUZ2pYTWZ5RDhwbDZP?=
 =?utf-8?B?d3cvbHViU3FDNE56TmZ3QnFRQ3daSVZvdzFNYjlYbnhjNVNxRmtGRWRMN0k2?=
 =?utf-8?B?L2xhZU95Mm9QZ0s5cTZBTGY0b1dzSEdrbzVQV3AxMlZKUUZRZVRlUjBIVDB0?=
 =?utf-8?B?RWtkYjNKUEdjeUF4N1VNeW85VE5BTUwvM1dVdXNBZm1lNUhPTkcyTnlrTVB4?=
 =?utf-8?B?dldMeEtaR3pLSm9aOUcvQ0FadVBDaU5LTnFFQkJoT1A5d2J1Q1kzdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f8dca8-7780-461e-7701-08de9b294f9e
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 19:58:06.5657 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /z3JXxufy70e3FLJOk7A/4c6UZM7xFJYalr92MELxDmBaEj8Et2GBU8cNvR5GaOlgvh/Sbw1S3V6tW80cEJoPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB1910
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

Demonstrate the preferred syntax of index projection in DMA documentation
and examples. A few `[i]?` cases are converted to demonstrate the new
variant.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/dma.rs       |  8 ++++----
 samples/rust/rust_dma.rs | 12 +++++-------
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 3e4d44749aaf..d6382904a90d 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -1152,8 +1152,8 @@ unsafe impl Sync for CoherentHandle {}
 /// unsafe impl kernel::transmute::AsBytes for MyStruct{};
 ///
 /// # fn test(alloc: &kernel::dma::Coherent<[MyStruct]>) -> Result {
-/// let whole = kernel::dma_read!(alloc, [2]?);
-/// let field = kernel::dma_read!(alloc, [1]?.field);
+/// let whole = kernel::dma_read!(alloc, [try: 2]);
+/// let field = kernel::dma_read!(alloc, [panic: 1].field);
 /// # Ok::<(), Error>(()) }
 /// ```
 #[macro_export]
@@ -1189,8 +1189,8 @@ macro_rules! dma_read {
 /// unsafe impl kernel::transmute::AsBytes for MyStruct{};
 ///
 /// # fn test(alloc: &kernel::dma::Coherent<[MyStruct]>) -> Result {
-/// kernel::dma_write!(alloc, [2]?.member, 0xf);
-/// kernel::dma_write!(alloc, [1]?, MyStruct { member: 0xf });
+/// kernel::dma_write!(alloc, [try: 2].member, 0xf);
+/// kernel::dma_write!(alloc, [panic: 1], MyStruct { member: 0xf });
 /// # Ok::<(), Error>(()) }
 /// ```
 #[macro_export]
diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index 129bb4b39c04..a2c34bb74273 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -73,7 +73,7 @@ fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<Self, E
                 Coherent::zeroed_slice(pdev.as_ref(), TEST_VALUES.len(), GFP_KERNEL)?;
 
             for (i, value) in TEST_VALUES.into_iter().enumerate() {
-                kernel::dma_write!(ca, [i]?, MyStruct::new(value.0, value.1));
+                kernel::dma_write!(ca, [try: i], MyStruct::new(value.0, value.1));
             }
 
             let size = 4 * page::PAGE_SIZE;
@@ -91,16 +91,14 @@ fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<Self, E
 }
 
 impl DmaSampleDriver {
-    fn check_dma(&self) -> Result {
+    fn check_dma(&self) {
         for (i, value) in TEST_VALUES.into_iter().enumerate() {
-            let val0 = kernel::dma_read!(self.ca, [i]?.h);
-            let val1 = kernel::dma_read!(self.ca, [i]?.b);
+            let val0 = kernel::dma_read!(self.ca, [panic: i].h);
+            let val1 = kernel::dma_read!(self.ca, [panic: i].b);
 
             assert_eq!(val0, value.0);
             assert_eq!(val1, value.1);
         }
-
-        Ok(())
     }
 }
 
@@ -109,7 +107,7 @@ impl PinnedDrop for DmaSampleDriver {
     fn drop(self: Pin<&mut Self>) {
         dev_info!(self.pdev, "Unload DMA test driver.\n");
 
-        assert!(self.check_dma().is_ok());
+        self.check_dma();
 
         for (i, entry) in self.sgt.iter().enumerate() {
             dev_info!(

-- 
2.51.2

