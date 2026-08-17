Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C792EC5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 12:59:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3556710E7C5;
	Mon, 17 Aug 2026 12:59:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="tvCq4SvI";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012031.outbound.protection.outlook.com
 [40.93.195.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8582B10E7C5
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 12:59:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UtBPs0Gjx2BAk+U7Z2mnq8lOb9i8AxjvuXQWDjiC91g9fGEArWO00an/U5oQ3xyLdUHj1iTefgi7bNdOrMC8OV84pc9Q6M6z0kzyv6ErQmgGkuAue8mG3oHOvA8+WicHi//ieE2UFhW1uRm3A+H5VnGO5nklSdtofztBA+OcnCsuErTKocie0o5rwE7zy+EOPmt3mKv3D7BJpM7c3Xupb68DnpTBmzJH+UZLzQp8lL5zNhxqXB1fktDmvoGvrAjjB5eE+sed81k+t2wOBuGiRsCQbn3UTb/699YJNS+JcbNR7nKQrQWA0ut1CqRi0YOUDyRdq+GS3ghvaRvgg3tDew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLSAaXzPw0WqoBFDH5K+TgNKYlW/Z0crlO8b4Fmtkc4=;
 b=pzj5EteqeXmgWWFBKBZktMMqyxrDiZ9fm3F8s3auZ4xOITDXCUZqhb1GAp6NxSBfDk/95pIl/mCZqQkW0o0iFeuZ56jgrzArJ0P18A5HEH8xf1KTv8sbHiV1cDd/pYUGPQZLXH6An7+yQmJWF6uuW5wmc1ypDH7V2UEnTS+5es3J9mHZ7AP/A9gmhRjSwxUm3Y7pZDrP8QGIbiH3KA6dG/0yZTlrUjzCxXW2Qcr55yv+o7W+Pwh5L6eSxN7PyGKVYC4EGQCB0KVB85sqY2P3YctL8ZuaGAZ9ydat/elAglP6OKEYExzsxJ1jAtyz0BBnYbh5hkG+RBPlAtw787bxtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLSAaXzPw0WqoBFDH5K+TgNKYlW/Z0crlO8b4Fmtkc4=;
 b=tvCq4SvIOuAZrp7tGaGJDkjGQdXzypH2RY+n/HvlIapUUXvZLYEO5LmIaVTzalOzbaTGE324USmjWiEjvuJi+Fp0Xq8kGrnGBNLiA+mzrzf0sy2w+/v37IgHXUeEl+DX9gOPSQoNBKOt1IzW80Z+niZjtlIfJbEFplEcHUwivb/rmTOBQhFQcpAvgwalyfoQRbo9Z/vnRSEQ1gMK5KyFNYY9PAW0J90GZnAstcI97PA9SVRJ87F+vc4LQ9V5yKlVVVTimao5aVcW9+AMd9cao7a9gfNMm12IXBOLIfKcjah87WokoYoUAANKmmd/Lj7f4gKBm90EoqptF+8h6ASjyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by PH7PR12MB6833.namprd12.prod.outlook.com (2603:10b6:510:1af::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Mon, 17 Aug
 2026 12:59:19 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 12:59:19 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 17 Aug 2026 21:56:39 +0900
Subject: [PATCH 4/6] gpu: nova-core: add NVKV typed encoding
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-b4-nvkv-v1-4-b84db5e84b67@nvidia.com>
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
X-ClientProxiedBy: TY4P301CA0044.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::8) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|PH7PR12MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: 10d1bc4c-9560-4a98-3701-08defc5f5a17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|7416014|10070799003|18002099003|921020|22082099003|56012099006|10067099003|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: w0IuVFXRpEYQL/wDxHpECtFiQxdKGpX4udB5fnTSJH3qx9nsA/0+iPMwKHDH8jkwM+rIb4qdkSJx2crg6c5pgFKq8av7eDBjbQ8FvfBEh5egfUetV8FeF23IRuLQCBZErbVrE5PQNosf4dbsjQEqW1NFVfeVmfhu6t1Vl8nvdBMdw7/HwquDJfBBOcg2rsS+OxxXM4vECtHY+x4MUDyPffP0MKwj+Yu46JeDjpRbj/V/hvBONLjsQpQkx/tCR2B5B9RVbOvbay4OCGBS+E5C336jPdOzfRYl7OzkLZQr5CLc2FgXxoLPegXwbQCm8Adsax+4vCrcgiKP2Cen/rgV7NB1lCHD6qW3b7uVJbTww+fFbrrU/rXQ5XDjZV5kF+yk4ilv68KXDtU4/5PtPdf4FcCaqL2zXIi7hu9br+Tg0F2mmk4DE9jYlzAxoIAv56jQW0zNeZRTgIygovRmkLJlYHZf03c4lABNMciId8BFcvQWNaNrcAZqGDoAUuc41Ld2LYiNzsVQeCJo643TkfEcgELYth0S6nzo8ad3hP3YkfF3wT2KmaTu/G24MM3E9D+eeabEyvoDoLS+L2tfZohs1b7m/E8QDg1z8wVZBaUbXCplCQgFfJ1ZC7GZI00+qKYfM1H75m2L/j3EVi6FPX/ad7SpVk98qZ21xf6+AKTu9TMo3pDHdGvoUVA0GMULycIQZnbB2Bb9uOVDm16iV3DC5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(7416014)(10070799003)(18002099003)(921020)(22082099003)(56012099006)(10067099003)(11063799006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnNneXU5UnF5RGs3VE9xVkNleDg2USthcWYwM1AyMkFuZ1pnQksvS09FMEpF?=
 =?utf-8?B?QzVCSTQyOFYxck5TLzFITHZ0Sk9wOWNUY0dOZElIQm5VcXFvUW9JN2NCUTh4?=
 =?utf-8?B?ZHpqZC9DYXU0bnZtVXlHL3JJTGw4TnRQVUNlMWtCRVpNM01rd2RmQWU5SWYx?=
 =?utf-8?B?aHVwVlJJZ2M1ZzFEQlE0cm5EVVE2UERnZEEvVFpqb29UNVduR3c0SGpQVkZQ?=
 =?utf-8?B?V281ZG9KMUNQNS9ocGc1R29LZGtudVBiMU5hNnBPb3M1andQY252SEpCZkVm?=
 =?utf-8?B?bHRTZ2cvY1piYkkrKzFXME1kT2FNVlpVZUt0a3NjZGhmWUVQWnpqYkJMQ01r?=
 =?utf-8?B?ZUVTeExzSytXMml6eTVENmNoUlhLWjJFRmFKL0JXZmM2YW1XUHdNZzlRbVJZ?=
 =?utf-8?B?a3JlYlRLYzU1M0RwNGc3dG51VmFoVHBraWppL2hDYlVLRmZjR3FLYnRwWEdz?=
 =?utf-8?B?cU84WmhRaW1qK243bVRHYTUvNTE1ZXdGWG84Tm5HZDZ6VUY3dlpGMk5aTk9K?=
 =?utf-8?B?R2cvU3VqcVVuYXJLUjFVU2ZUM1RNWkpZc0t1OFZRM05rQ3dndjJ4dTJRTmNa?=
 =?utf-8?B?ZXlIOHNzeThwWTVRK1dDc2tKbEEyeWt2MWFlakRmbmNuZjlFWnU5TEpGRFBC?=
 =?utf-8?B?TVBQR3JZd25ROHh2VXBiUkxCeUcyWlZuT1poaEZnMkwzazNlMlo3Q0ZXeDBE?=
 =?utf-8?B?Zis3bEpaNi9LeFRqb0hJNlR1WnphR2g2YlBYTVkxVEIvN3A2M2NaNW0yMzZL?=
 =?utf-8?B?Q3NMR3l0eUJ1RnBJMGtNbGMyeEFYd1VtZjIwbnREOXBnMFU3czg4OVJqVXJl?=
 =?utf-8?B?MGx1WUxxQzNSS1R2U1NKNmFOTlY2ZnZ1aUhUdjZrWEtnaDVIaGtPeHB0N1pu?=
 =?utf-8?B?N2VHVXZONEJIS0lZcVNTTmVacVE3V2MwcjZUemhudFdUajVCREZDV2d4VUdU?=
 =?utf-8?B?Q2xzeHFBRS90Vk1VY1pDREt6R2tVMWdpcUpUakhkWXNqV0ZiaWk2WDJSRzBs?=
 =?utf-8?B?NS9oRUFpODdWSTU3VkVxRmRzakk1Qzd6QytONkRBWjMyNWJ4VTl1WnltOW5s?=
 =?utf-8?B?YWxXc2QyS2JIRnAzbmVPakVPZ3Z4MEcrbllsN095REU5M3JCNkVxQ3ZBamhh?=
 =?utf-8?B?Y0I0ZEg2YmdLbGtMa21Za3VwRUl3RDg3dnZsYi8zU0w1MFI5SXovVnBvS0dY?=
 =?utf-8?B?cXJTMkQ0bVRpc01heTVMSW1UOStUNGo4MzhOWWs5d0QrcENDVzYzR3JFZnRu?=
 =?utf-8?B?RFZIZFFUVCt2dXU0M2w2Z1FOUkZoTWd6eUhhZ1RjTGdtVEpaVkVZeEx0SGtq?=
 =?utf-8?B?YVRCV2k2UjBUUHgwbWp1cDJocUVkQnlrbzBWU0w5L0J4SThEcjJmL1FaTkNa?=
 =?utf-8?B?YXRldU5kTGU3bUNUQWp2SjRCVlRyQllwdFhQcGEvajMxelVDbUFZZDh6WXNV?=
 =?utf-8?B?WnhRRTVQNzZ5WU91bjFGc3lmY056ZHN1aG5iQ25lYUtkM2VjVnpBYXpCaWJO?=
 =?utf-8?B?VUJUckxBNkZHZis5TFhEbThkZE1BN3VHelkzdElZTXZOaUFmQnRUeHN2UnJS?=
 =?utf-8?B?MHVhMjVuVzdUZmczTFFKOWVmR0k4YnNlS0hKaWNGdm12YWNNUmt6UjFmMmlz?=
 =?utf-8?B?YWthUDNtZXV6VmhjWjVKeVY1dmQwUHh0VTErRFlBOWltVWt2S2dkNDNrWERI?=
 =?utf-8?B?M0xpOStkK2xXMjhFZCtmeDA5MkJEOUZPOFpFa0g3OHNzdk1ZaFBkWU5LaTB6?=
 =?utf-8?B?S0xGc1lkMEpNRyszZ21uTUtWSUZqUmtOM2t6aFBMSHVPRG93STB5a1hZVC9h?=
 =?utf-8?B?bkpuVFpnb3hOL05NQTlMK3ErWXNvWGlSaU9Wcmo4bCs2TXVmUUhEa003QWNH?=
 =?utf-8?B?Sk9qakFMY2NmNFFBS0FNOGhmdWRvVWp4SmI5WGI1T0FkMmFsRTVKeUEvSzUy?=
 =?utf-8?B?Z0NaendvdE1vMHl1WkE3SXhHdlV5djc5M2NKcFJWQ0M5bWtqMnlkSVBuV3Vl?=
 =?utf-8?B?cmdLaXZuOG5wa3RrTkhZQlZONlRRUkY5VGZBa2hQS3ZQNzczcEFXckl6aGZH?=
 =?utf-8?B?MEhSbHgwYlUwUXFYNnRaNW1hR3ZtN0R2MUI0UHNtOU9oOFpXcWlDNDNJcUxP?=
 =?utf-8?B?cXJSQ2JCdXB4YjI4cWE4UW9Yb1JDRW1aUldLYUx2L04zQUc3NVg2bjMyOWFa?=
 =?utf-8?B?eHYzRERwRkc4cWFoRTAyRlVLSHBEbVZWTmlOd0cxTjl5SmRkdUN0Wmd3L3ZC?=
 =?utf-8?B?RVhpU3NLMDVkNzdSY0k4dlpOTzQrOHlCZkhaTytvN2ZjK2JwSENHMXZvZ3BJ?=
 =?utf-8?B?MlRBVnBzUzRQVWdOMWlWbEh3QVRFMUVXVUVrUHpySXU5WlFGWStGN3JRU3NB?=
 =?utf-8?Q?t2jcl0F6BQPe1HHSbcXlFxDha4FD68qCYr6iELMs9Oa5p?=
X-MS-Exchange-AntiSpam-MessageData-1: LpCOnZbTgSc9Eg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d1bc4c-9560-4a98-3701-08defc5f5a17
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 12:59:19.8271 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yJPrWYpNRdMvdxDs5Eek0f4Z5LdipRTeaJl/O7pW+cDxd8r+8ms4wjP85NzQoV5gGuucTiYX1LYMqXLJbrpQmQ==
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

For struct-like GMCAPI messages encoding field by field manually is
noisy. Add some type machinery and a macro to automate encoding of
struct-like messages. The `Encodeable` trait can be implemented by any
type to say that it can be encoded into an NVKV `Encoder`. Add a simple
`nvkv_encode!` macro that works on structs and encodes each field in
order. Provide some base types, such as `Key` which statically
associates a NVKV key with some value, to avoid having to make a lot of
newtypes and implement `Encodeable` on them.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/nvkv.rs        |  49 +++++++++
 drivers/gpu/nova-core/gsp/nvkv/encode.rs | 178 +++++++++++++++++++++++++++++++
 2 files changed, 227 insertions(+)

diff --git a/drivers/gpu/nova-core/gsp/nvkv.rs b/drivers/gpu/nova-core/gsp/nvkv.rs
index 64d8d0118452..bf6500d54b21 100644
--- a/drivers/gpu/nova-core/gsp/nvkv.rs
+++ b/drivers/gpu/nova-core/gsp/nvkv.rs
@@ -10,6 +10,13 @@
 //! naturally maps to storing a &str with the GPU name.
 
 #![expect(unused_imports)]
+#![cfg_attr(not(CONFIG_KUNIT), expect(unused_macros))]
+
+use core::marker::PhantomData;
+use core::ops::{
+    Deref,
+    DerefMut, //
+};
 
 use kernel::{
     bitfield,
@@ -29,6 +36,48 @@
 /// The index of an NVKV value.
 pub(crate) type Index = Bounded<u64, 12>;
 
+/// A static association between an NVKV key `KEY_ID` and the storage of its value.
+///
+/// Use with the encoder or decoder macros `nvkv_encode!` and `nvkv_decode!` to let them know how to
+/// map the value `Key<T, KEY_ID, As>` to/from encoded data. For brevity, `As` inserts an additional
+/// conversion (`From`) to avoid having to implement [`Encodable`] for many types. For example,
+/// enums that are easily convertible to a u32 can have `As = u32` and rely on the existing encoding
+/// for u32.
+#[repr(transparent)]
+pub(crate) struct Key<T, const KEY_ID: KeyId, As = T>(pub(crate) T, PhantomData<As>);
+
+impl<T, const KEY_ID: KeyId, As> From<T> for Key<T, KEY_ID, As> {
+    fn from(value: T) -> Self {
+        Self(value, PhantomData)
+    }
+}
+
+impl<'a, T, const KEY_ID: KeyId, As, const N: usize> From<&'a [T; N]> for Key<&'a [T], KEY_ID, As> {
+    fn from(value: &'a [T; N]) -> Self {
+        Self(&value[..], PhantomData)
+    }
+}
+
+impl<T, const KEY_ID: KeyId, As> Deref for Key<T, KEY_ID, As> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        &self.0
+    }
+}
+
+impl<T, const KEY_ID: KeyId, As> DerefMut for Key<T, KEY_ID, As> {
+    fn deref_mut(&mut self) -> &mut Self::Target {
+        &mut self.0
+    }
+}
+
+impl<T: Default, const KEY_ID: KeyId, As> Default for Key<T, KEY_ID, As> {
+    fn default() -> Self {
+        Self(T::default(), PhantomData)
+    }
+}
+
 bitfield! {
     /// The op word that starts each NVKV operation.
     struct Op(u64) {
diff --git a/drivers/gpu/nova-core/gsp/nvkv/encode.rs b/drivers/gpu/nova-core/gsp/nvkv/encode.rs
index 6da81a371651..31ea5788e772 100644
--- a/drivers/gpu/nova-core/gsp/nvkv/encode.rs
+++ b/drivers/gpu/nova-core/gsp/nvkv/encode.rs
@@ -7,11 +7,153 @@
 
 use super::{
     Index,
+    Key,
     KeyId,
     Op,
     Opcode, //
 };
 
+/// A type that can encode itself into an [`Encoder`].
+pub(crate) trait Encodable {
+    /// Encodes `self` into `encoder`.
+    fn encode(&self, encoder: &mut Encoder) -> Result;
+}
+
+/// Defines a struct together with its [`Encodable`] implementation.
+///
+/// The implementation encodes each field in declaration order. Each field type must implement
+/// [`Encodable`], which is done already for types like `Key<T, KEY_ID>`.
+///
+/// # Examples
+///
+/// ```
+/// nvkv_encode! {
+///     struct Request {
+///         id: Key<u32, 0x0001>,
+///         name: Key<&'static [u8], 0x0002>,
+///     }
+/// }
+/// ```
+macro_rules! nvkv_encode {
+    (
+        $(#[$attr:meta])*
+        $vis:vis struct $name:ident {
+            $(
+                $(#[$field_attr:meta])*
+                $field_vis:vis $field:ident : $ty:ty
+            ),* $(,)?
+        }
+    ) => {
+        $(#[$attr])*
+        $vis struct $name {
+            $(
+                $(#[$field_attr])*
+                $field_vis $field: $ty,
+            )*
+        }
+
+        impl $crate::gsp::nvkv::Encodable for $name {
+            #[inline(always)]
+            fn encode(&self, encoder: &mut $crate::gsp::nvkv::Encoder) -> ::kernel::error::Result {
+                $( $crate::gsp::nvkv::Encodable::encode(&self.$field, encoder)?; )*
+                Ok(())
+            }
+        }
+    };
+}
+pub(crate) use nvkv_encode;
+
+/// A value with a specific index that encodes under the NVKV key `KEY_ID`.
+struct IndexedKey<T, const KEY_ID: KeyId> {
+    index: Index,
+    value: T,
+}
+
+impl<T, const KEY_ID: KeyId> IndexedKey<T, KEY_ID> {
+    /// Creates a key with the given index and value.
+    pub(crate) fn new(index: Index, value: T) -> Self {
+        Self { index, value }
+    }
+}
+
+impl<const KEY_ID: KeyId> Encodable for IndexedKey<u32, KEY_ID> {
+    #[inline(always)]
+    fn encode(&self, encoder: &mut Encoder) -> Result {
+        encoder.encode_u32(KEY_ID, self.index, self.value)
+    }
+}
+
+impl<const KEY_ID: KeyId> Encodable for IndexedKey<u64, KEY_ID> {
+    #[inline(always)]
+    fn encode(&self, encoder: &mut Encoder) -> Result {
+        encoder.encode_u64(KEY_ID, self.index, self.value)
+    }
+}
+
+impl<const KEY_ID: KeyId> Encodable for IndexedKey<&[u8], KEY_ID> {
+    #[inline(always)]
+    fn encode(&self, encoder: &mut Encoder) -> Result {
+        encoder.encode_array8(KEY_ID, self.index, self.value)
+    }
+}
+
+impl<const KEY_ID: KeyId> Encodable for IndexedKey<&[u32], KEY_ID> {
+    #[inline(always)]
+    fn encode(&self, encoder: &mut Encoder) -> Result {
+        encoder.encode_array32(KEY_ID, self.index, self.value)
+    }
+}
+
+impl<const KEY_ID: KeyId> Encodable for IndexedKey<&[u64], KEY_ID> {
+    #[inline(always)]
+    fn encode(&self, encoder: &mut Encoder) -> Result {
+        encoder.encode_array64(KEY_ID, self.index, self.value)
+    }
+}
+
+impl<const N: usize, const KEY_ID: KeyId> Encodable for IndexedKey<[u8; N], KEY_ID> {
+    #[inline(always)]
+    fn encode(&self, encoder: &mut Encoder) -> Result {
+        encoder.encode_array8(KEY_ID, self.index, &self.value)
+    }
+}
+
+impl<const N: usize, const KEY_ID: KeyId> Encodable for IndexedKey<[u32; N], KEY_ID> {
+    #[inline(always)]
+    fn encode(&self, encoder: &mut Encoder) -> Result {
+        encoder.encode_array32(KEY_ID, self.index, &self.value)
+    }
+}
+
+impl<const N: usize, const KEY_ID: KeyId> Encodable for IndexedKey<[u64; N], KEY_ID> {
+    #[inline(always)]
+    fn encode(&self, encoder: &mut Encoder) -> Result {
+        encoder.encode_array64(KEY_ID, self.index, &self.value)
+    }
+}
+
+impl<T, const KEY_ID: KeyId, As> Encodable for Key<T, KEY_ID, As>
+where
+    IndexedKey<As, KEY_ID>: Encodable,
+    As: From<T>,
+    T: Copy,
+{
+    #[inline(always)]
+    fn encode(&self, encoder: &mut Encoder) -> Result {
+        IndexedKey::new(Index::new::<0>(), As::from(self.0)).encode(encoder)
+    }
+}
+
+impl<T: Encodable> Encodable for Option<T> {
+    #[inline(always)]
+    fn encode(&self, encoder: &mut Encoder) -> Result {
+        if let Some(value) = self {
+            value.encode(encoder)?;
+        }
+        Ok(())
+    }
+}
+
 /// An encoder for an NVKV stream.
 pub(crate) struct Encoder {
     backing: KVVec<u64>,
@@ -242,4 +384,40 @@ fn encode_all_value_kinds() -> Result {
 
         Ok(())
     }
+
+    // Tests that encoding via the `nvkv_encode!` macro works correctly.
+    #[test]
+    fn encode_typed_struct() -> Result {
+        const U32_KEY: KeyId = 0x0001;
+        const U64_KEY: KeyId = 0x0002;
+        const NAME_KEY: KeyId = 0x0003;
+        const FIXED_KEY: KeyId = 0x0004;
+        const OPT_KEY: KeyId = 0x0005;
+
+        nvkv_encode! {
+            struct TypedRequest {
+                a: Key<u32, { U32_KEY }>,
+                b: Key<u64, { U64_KEY }>,
+                name: Key<&'static [u8], { NAME_KEY }>,
+                fixed: Key<[u8; 4], { FIXED_KEY }>,
+                opt: Option<Key<u32, { OPT_KEY }>>,
+            }
+        }
+
+        let request = TypedRequest {
+            a: 0x89ab_cdef.into(),
+            b: 0x0123_4567_89ab_cdef.into(),
+            name: b"name\0".into(),
+            fixed: [1u8, 2, 3, 4].into(),
+            opt: None,
+        };
+
+        let mut encoder = Encoder::new();
+        request.encode(&mut encoder)?;
+        let encoded = encoder.finish();
+
+        assert_eq!(encoded.len(), 7);
+
+        Ok(())
+    }
 }

-- 
2.55.0

