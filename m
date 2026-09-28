Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2888CA5FA4
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:45:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD31E10E8E6;
	Mon, 28 Sep 2026 08:45:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="LjrMkTNm";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010047.outbound.protection.outlook.com
 [40.93.198.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B3B710E865
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 08:43:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c1cdMwD56vsYxd3OGmsjbNf5O5TltwNJqmPTcuie9+BPamWn7ob79+eEcV4NWLLFXBSy8wDH1CKledUKRhOygciIHRL3UMEWgsHdtzAYFLDyxzJidCL/K2QNKvZJ6Nz3ZIj4lXQ3AwajoPUcMNYPdv2Cbyzrb3a4ruj60F7Andc8rAHD63i5qCu8CyV8b7oCPrKonOfd94T5zuUlu8R0YeZE3T1q6hPHWFnPbAeVhISIsoEALwsLnh62aPnrlgT/jMcicvIh2/ofr3vIZUqPuUU7uPotRVguWsDZ9yjkt18eU+F8seQn8uBbwplN3GI5hWhKv4KI/5a1h8PjWD513A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8Qt4tkjb9EowBOopQTF/mGrZ0Ii17ox9dnn6/61w64=;
 b=DKjczq31HiAyABO0UicyeNor0OWe8qskHEu+xZ0qi8b2DPaZrgYBgKgctVyABbOx4N9o1WvL87LcfeMiTAPt2mlphVoMcXjCVAczy2USWfEe64jJOfUfXhPfk6Nn4ttiEWDJNLgGV1l6Te8BSM0ZnRc1/eZrEXqdCYaqU73YNuGHHJu38m28JmiJUxQzIM27l9vfBC89eicAQ6jqIkT/4c546VctJGi1f9fdkSyApovOi+j9uLMmbzHDZeGuvNX5a82ye7rYn1qrN1itrwNHCqLZGTcrHpE7B8PMsbvhF/N7MWQJ6h4oDY4/lsTcFDFkt7gsC98kkjkCIbVpcMhMFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8Qt4tkjb9EowBOopQTF/mGrZ0Ii17ox9dnn6/61w64=;
 b=LjrMkTNmpyzoAeP19xyU6bzpxoZd25WiG16zITXg46FaAV5ICdD/1s8K+qAr9tRFPs1GaUTvN5xr93u4xazJ0mVED5ucMxpW7RfzGqmZzAn1j9WzYZOFenUEJ9V06QC/JipTCdusH3jRID3Iwt2WjGFfQoDcsr9Ym80D1GbFPY/5xhQji+kXjLl4RmZpkJICBsT6cXWSjFA+Q8JbB2XHoJmJ19AZAyICYxKSynfbhfOd4jWuXSMueiGIDc1ac8/Uhk91cB52B++Nba5zCPkQR7N7MfHZ/bnGm/0S19WyG6CBFlZpp0Pt+TK+kkHLmY7jjM0PHfnSvaX7jXO39oOu7Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 CY8PR12MB8065.namprd12.prod.outlook.com (2603:10b6:930:73::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.24; Mon, 28 Sep 2026 08:43:20 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 08:43:20 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 28 Sep 2026 17:42:45 +0900
Subject: [PATCH v3 6/8] gpu: nova-core: add NVKV typed encoding
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-b4-nvkv-v3-6-f04504c262c2@nvidia.com>
References: <20260928-b4-nvkv-v3-0-f04504c262c2@nvidia.com>
In-Reply-To: <20260928-b4-nvkv-v3-0-f04504c262c2@nvidia.com>
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
X-ClientProxiedBy: TY4P301CA0072.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36f::19) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|CY8PR12MB8065:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e880ddb-fb48-4b04-0968-08df1d3c8c58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|7416014|376014|1800799024|366016|10067099003|56012099006|11063799006|921020|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 9hwEPCPpvKWqZEWbL5C0Qj7b1Zfdfj05unLXReOTCBehbevIAEJfSpcOp65Y7TeLdkTyuM3lz68C+IvoWwLhFTURGLhDm2XIACsE0G6Ge+AFvTOscon4kqwMeQobYCDDCJKgOKrKpVCTTHxV7WO0904hhP5qbSP4XgJ5a2kjeyq6XNaYftee/38OTknOCI1WHd5EMEgPIvYpD2Y3N+S1O2gzlu+6UESiLurcK1HllEOvTvtn+vy27VNGSndfZMOPtx3Hw9cGBKFMpQaepX+NFNJuIbMIj8ycnX83K/l9UMCEpmjraPlsCQFXbvKRIpo7YCYCbve/DOn+uexb7IvKYcztKu9msKy9WyC1g19SsrxtszWyBRLGZl3oQgOQk3y2T77rQAIZGTTTaydl0qVp7pHJOZKBSiDpEH/bFTIsibmINsS3k/gQS6jbqlNgXkNCmBu25tvGEiNueWgVWE1dLVHSj+fctziHCrIEb39CB0Uk24yCOOgYiRDm/EV3aIRbxUs0SVT+4lzcX3Y7H1uKl9qQJP+Me/minCJNh4YX/774fHvxAUFgVM6prFyew7F9Xarn6/B/dfvTkNnohYfBa6cPIhKlB2EYE1nSAy42kAjZrdNO8HPB5JOPppn0pgmO8ByhHqdNDDr4C5Ae35St+dJib98/XBV0FPjiwHHndlqP8jHyzHuNN1Xh5JuLLNla9HH+e7vhORjUbNnECVmrcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(7416014)(376014)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(921020)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U09zUG1udnRDSDNFYThWOHJnNzNmY09UbVJkWk9tdnVrOW9Nb29VUzdtb3FP?=
 =?utf-8?B?RGs5WStBYVNZaXErNnVVeEFZa1lXc0hPaTB0bkdpYitLRFcrcWhoYUp4Nko0?=
 =?utf-8?B?OURBcms1VVd4aVByYXg0aUtSd09mdGVxQy92SlQ1NTVhc0w2UTFNeWltaWhp?=
 =?utf-8?B?ajhNeFNRb2l4Vm9PK0Mxbi9Kd3phK3pDc3BRQnNWZC90R1dtY2E5eG13NVdO?=
 =?utf-8?B?bGxSQzFadDZoY01XdEJuVlNXOWJWYjA1M1pOWS8zT3lwMTBiQnpJZWttcExO?=
 =?utf-8?B?SC8wOEtJc0xJMkRNQ3E1MWYyclBtdUR6RDdVYWEwclhiNGlhTXF6TjdiVXlE?=
 =?utf-8?B?NFZmLzlMWUp4ZWVGWXhYZFRkOXJuNlpDVUhTZEhCMFZZaGZucnJQbDdna0o3?=
 =?utf-8?B?OG5Jdis4TmZrQjdKT2x6c1VNdjVpNDJBTjlCVi9NekJZWmFLZUZ0aEg3Kzd6?=
 =?utf-8?B?dW5zcEd2MWEzNmlVL0E4NjNOcTh0SmVJUm5pdlRCZDY1dkxXMWc4WWZhZHNn?=
 =?utf-8?B?aHEwWEJwZXcwdXdZUHlwd2FXbjFpWWxaSnpmNGgzSTNDaTJtVEMwVWhKYThq?=
 =?utf-8?B?SjVuZ1FDQ29xNGFweDliZHhXa3lOdm5kT1hIMWJBUFJZRXJBQ3dnYlpPT2ox?=
 =?utf-8?B?bC9uOHg3RU8rOERCUStURStHbFNwdk9DSGQxMEJTUGxQeDlkM1VkdVVFRzBt?=
 =?utf-8?B?Z3ZnNmgyUVR3d3NaL3p5SzY4ZzU4RGhuYTNyenUrSGxySXlaKzVNcmorK05G?=
 =?utf-8?B?bG9ybG1tWkVwVHNrdUN1dDJuRVNhTzVrOTQ4dHMrVnhKRlE1SWI0WFF1a2l1?=
 =?utf-8?B?bFBxTjRQeFlyUGo5WmVHc29zOVllVDNZaEdPd2ZjYlBIUjJuQW1ScHJHMmtu?=
 =?utf-8?B?RlBkY3Q4QThaSlVHYTNXcHppcE1yUVRNeFFzL2xSSEFGN3BqejY3SlpFdlow?=
 =?utf-8?B?cXozWGNlTmxKOTBLZEhmMUttRUtUY2F2UzA1azRhTTFoM2lVSSt6SDN3dHNn?=
 =?utf-8?B?Rm9WY0UrWnZzM041UUExT0hoZEVuNlk0bnRuUEJCMTljV0JDU0xSUURVSG5v?=
 =?utf-8?B?UWxETHJMbS9hVHZqR1cwK3pnVUdqajIyeDNHcEZFSWVFTC9IR0xKUDdHaHlF?=
 =?utf-8?B?V0FqVWE0UWZxYmFTcFZjZlFsaFhkUHc0R0lUM0IybVJPdGZSbGJIMGVYVnB3?=
 =?utf-8?B?OGo3Y3RMclZnUnNkdmNidllBR1VLZUxKMWM3S3U1NDRJalNwbkhQNktFUEl5?=
 =?utf-8?B?eFNWSUpHZHVUYVZCVGNQa3c5aUlLSzRyNmxUSnFBMjBPZ250WWRpUlZYbnUz?=
 =?utf-8?B?QUwzZXVMTTZMbzFUNHRIc1dEYVJyNjJiSXp3L3doVUhldW51TXVnSGU3TTZ3?=
 =?utf-8?B?QlBJUXY5WTRGdUxLRWNtUVJGQlRjcUJpOGN5WU1VcFkwOXBBYXVMVmsxbW1w?=
 =?utf-8?B?Yk52K0h4YVZCTXA0RE1iUnZiYzAxd25KUkhzN0JNaVp0KzFsWS9kT0lDbEFt?=
 =?utf-8?B?WFl6aVJ5Q3ppMVFOaDNxVTNBK1pxVTdJUzYvMXQ3d2pIeTZyaXo0TXhYOEc5?=
 =?utf-8?B?ZlRLVzJLcmsxTkhaOEZtbC9lOVdMZk9NWGlpZ3RyUUFaUW9adCs1UXlFcklS?=
 =?utf-8?B?TkZzdmpzei9HQUlRaHUrUTFRMkswdFo3ZDRPR0ZTOG02clhSK2pMVzh1cVJV?=
 =?utf-8?B?Y2xjOEtEdzk2K0Z0QUJsWFREc2ZVTlFFWk45enMrb2JIaWR2VUVhSkNIUEJZ?=
 =?utf-8?B?cm15SE4wZkdkT0pwam9ndjgrblFESWlHQXJrMXVTWnM1NDk5OFNSYlhHYWgv?=
 =?utf-8?B?RGY2eFpjUGZSOUExREtGUFppa09OcEdWL3BESVRZZlIvNncrOVFhMUIyVkRo?=
 =?utf-8?B?WEl5MXBNMEV2K2JvbzdrRHR6dUZsVy9vVU9zdHpHVng3QW0yUlpmdzgyQmVx?=
 =?utf-8?B?YkV0MUdmSk1BZWo0ZmRURUlGWTdxVC9TRXBnWEtkNEJRY2xqczc3SElmVkhq?=
 =?utf-8?B?ckFOUWpHTFd6aGhZZE1zMFNDU05FRzk2NGs2VUNJQ3o4WXV2MXJ5ZFRES1Rz?=
 =?utf-8?B?Uy9VZ1Bndi81ZG1obHp1QlhVNk52R2dyUkN3NGozbmR1V21MblpoY2h0anZI?=
 =?utf-8?B?WTVyNEZlMjd3OGkzeWI1Y1hpbWxNaGlXVTNsVDVsY0R3OTd6SXdWeXJSVHVu?=
 =?utf-8?B?NnNISWxmRUFxSmdyeE40aGk4Q1VaYVExN1VpNU90OEZpcHNKT3hIQ2VkczY4?=
 =?utf-8?B?QVZ2R2ZWRFV2OU9tRFBFNTJKZ1RQZDYwTlNIKzZRbmVWeS9FT25GY3RFL2x0?=
 =?utf-8?B?WHN0cWdSZVRzUGxhNyt2ZElGY1J0ZllCd3lkMVJUOXNIb2lPc3A5VnVXQVZw?=
 =?utf-8?Q?v4R8qQPUKbgV+zukSXqKkgDNNUGXQrsY5CHU6TOdGM8SR?=
X-MS-Exchange-AntiSpam-MessageData-1: kC/0knvNjl6rTQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e880ddb-fb48-4b04-0968-08df1d3c8c58
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 08:43:20.2114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 76c48xtcmeuRJx+vg3BnYDF0+WYEcwV7m+DviOd9j3bnWaEYAtqhueHGEGj04gHrUZCxtyDIDhHZgOPhR6elMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8065
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
 drivers/gpu/nova-core/gsp/nvkv.rs        |  56 ++++++-
 drivers/gpu/nova-core/gsp/nvkv/encode.rs | 241 +++++++++++++++++++++++++++++++
 2 files changed, 296 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/gsp/nvkv.rs b/drivers/gpu/nova-core/gsp/nvkv.rs
index 10f7a16ffc23..7ac3a459a98b 100644
--- a/drivers/gpu/nova-core/gsp/nvkv.rs
+++ b/drivers/gpu/nova-core/gsp/nvkv.rs
@@ -10,8 +10,15 @@
 //! naturally maps to storing a &str with the GPU name.
 
 #![expect(unused_imports)]
+#![cfg_attr(not(CONFIG_KUNIT), expect(unused_macros))]
 
-use core::ops::Deref;
+use core::{
+    marker::PhantomData,
+    ops::{
+        Deref,
+        DerefMut, //
+    }, //
+};
 
 use kernel::{
     alloc::{
@@ -94,6 +101,53 @@ fn deref(&self) -> &Self::Target {
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
+pub(crate) struct Key<T, const KEY_ID: KeyId, As = T>(T, PhantomData<As>);
+
+impl<T, const KEY_ID: KeyId, As> From<T> for Key<T, KEY_ID, As> {
+    #[inline]
+    fn from(value: T) -> Self {
+        Self(value, PhantomData)
+    }
+}
+
+impl<'a, T, const KEY_ID: KeyId, As, const N: usize> From<&'a [T; N]> for Key<&'a [T], KEY_ID, As> {
+    #[inline]
+    fn from(value: &'a [T; N]) -> Self {
+        Self(&value[..], PhantomData)
+    }
+}
+
+impl<T, const KEY_ID: KeyId, As> Deref for Key<T, KEY_ID, As> {
+    type Target = T;
+
+    #[inline]
+    fn deref(&self) -> &Self::Target {
+        &self.0
+    }
+}
+
+impl<T, const KEY_ID: KeyId, As> DerefMut for Key<T, KEY_ID, As> {
+    #[inline]
+    fn deref_mut(&mut self) -> &mut Self::Target {
+        &mut self.0
+    }
+}
+
+impl<T: Default, const KEY_ID: KeyId, As> Default for Key<T, KEY_ID, As> {
+    #[inline]
+    fn default() -> Self {
+        Self(T::default(), PhantomData)
+    }
+}
+
 bitfield! {
     /// The op word that starts each NVKV operation.
     struct Op(u64) {
diff --git a/drivers/gpu/nova-core/gsp/nvkv/encode.rs b/drivers/gpu/nova-core/gsp/nvkv/encode.rs
index 8b66ddb15189..2cc0cfbad814 100644
--- a/drivers/gpu/nova-core/gsp/nvkv/encode.rs
+++ b/drivers/gpu/nova-core/gsp/nvkv/encode.rs
@@ -8,11 +8,152 @@
 use super::{
     EncodedStream,
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
+            #[inline]
+            fn encode(&self, encoder: &mut $crate::gsp::nvkv::Encoder) -> ::kernel::error::Result {
+                $( $crate::gsp::nvkv::Encodable::encode(&self.$field, encoder)?; )*
+                Ok(())
+            }
+        }
+    };
+}
+
+/// A value with a specific index that encodes under the NVKV key `KEY_ID`.
+struct IndexedKey<T, const KEY_ID: KeyId> {
+    index: Index,
+    value: T,
+}
+
+impl<T, const KEY_ID: KeyId> IndexedKey<T, KEY_ID> {
+    /// Creates a key with the given index and value.
+    fn new(index: Index, value: T) -> Self {
+        Self { index, value }
+    }
+}
+
+impl<const KEY_ID: KeyId> Encodable for IndexedKey<u32, KEY_ID> {
+    #[inline]
+    fn encode(&self, encoder: &mut Encoder) -> Result {
+        encoder.encode_u32(KEY_ID, self.index, self.value)
+    }
+}
+
+impl<const KEY_ID: KeyId> Encodable for IndexedKey<u64, KEY_ID> {
+    #[inline]
+    fn encode(&self, encoder: &mut Encoder) -> Result {
+        encoder.encode_u64(KEY_ID, self.index, self.value)
+    }
+}
+
+impl<const KEY_ID: KeyId> Encodable for IndexedKey<&[u8], KEY_ID> {
+    #[inline]
+    fn encode(&self, encoder: &mut Encoder) -> Result {
+        encoder.encode_array8(KEY_ID, self.index, self.value)
+    }
+}
+
+impl<const KEY_ID: KeyId> Encodable for IndexedKey<&[u32], KEY_ID> {
+    #[inline]
+    fn encode(&self, encoder: &mut Encoder) -> Result {
+        encoder.encode_array32(KEY_ID, self.index, self.value)
+    }
+}
+
+impl<const KEY_ID: KeyId> Encodable for IndexedKey<&[u64], KEY_ID> {
+    #[inline]
+    fn encode(&self, encoder: &mut Encoder) -> Result {
+        encoder.encode_array64(KEY_ID, self.index, self.value)
+    }
+}
+
+impl<const N: usize, const KEY_ID: KeyId> Encodable for IndexedKey<[u8; N], KEY_ID> {
+    #[inline]
+    fn encode(&self, encoder: &mut Encoder) -> Result {
+        encoder.encode_array8(KEY_ID, self.index, &self.value)
+    }
+}
+
+impl<const N: usize, const KEY_ID: KeyId> Encodable for IndexedKey<[u32; N], KEY_ID> {
+    #[inline]
+    fn encode(&self, encoder: &mut Encoder) -> Result {
+        encoder.encode_array32(KEY_ID, self.index, &self.value)
+    }
+}
+
+impl<const N: usize, const KEY_ID: KeyId> Encodable for IndexedKey<[u64; N], KEY_ID> {
+    #[inline]
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
+    #[inline]
+    fn encode(&self, encoder: &mut Encoder) -> Result {
+        IndexedKey::new(Index::new::<0>(), As::from(self.0)).encode(encoder)
+    }
+}
+
+impl<T: Encodable> Encodable for Option<T> {
+    #[inline]
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
     stream: EncodedStream,
@@ -207,4 +348,104 @@ fn encode_all_value_kinds() -> Result {
 
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
+        const INDEXED_KEY: KeyId = 0x0006;
+
+        nvkv_encode! {
+            struct TypedRequest {
+                a: Key<u32, U32_KEY>,
+                b: Key<u64, U64_KEY>,
+                name: Key<&'static [u8], NAME_KEY>,
+                fixed: Key<[u8; 4], FIXED_KEY>,
+                opt: Option<Key<u32, OPT_KEY>>,
+                indexed: IndexedKey<u32, INDEXED_KEY>,
+            }
+        }
+
+        const U32_VALUE: u32 = 0x89ab_cdef;
+        const U64_VALUE: u64 = 0x0123_4567_89ab_cdef;
+        const INDEXED_VALUE: u32 = 0x1234_5678;
+
+        let index5 = Index::new::<5>();
+        let request = TypedRequest {
+            a: U32_VALUE.into(),
+            b: U64_VALUE.into(),
+            name: b"name\0".into(),
+            fixed: [1u8, 2, 3, 4].into(),
+            opt: None,
+            indexed: IndexedKey::new(index5, INDEXED_VALUE),
+        };
+
+        let mut encoder = Encoder::new();
+        request.encode(&mut encoder)?;
+        let encoded = encoder.finish();
+
+        // `opt` is `None` and is not encoded.
+        assert_eq!(encoded.len(), 8);
+
+        let index0 = Index::new::<0>();
+        // `a`: IMM32 with the value in the `Op`.
+        assert_eq!(
+            encoded[0],
+            Op::zeroed()
+                .with_key(U32_KEY)
+                .with_index(index0)
+                .with_opcode(Opcode::Imm32)
+                .with_value(U32_VALUE)
+                .into_raw()
+        );
+        // `b`: a single-key SEQ64 followed by the value.
+        assert_eq!(
+            encoded[1],
+            Op::zeroed()
+                .with_key(U64_KEY)
+                .with_index(index0)
+                .with_opcode(Opcode::Seq64)
+                .with_value(1u32)
+                .into_raw()
+        );
+        assert_eq!(encoded[2], U64_VALUE);
+        // `name`: ARRAY8 of 5 bytes, zero-padded to one `u64`.
+        assert_eq!(
+            encoded[3],
+            Op::zeroed()
+                .with_key(NAME_KEY)
+                .with_index(index0)
+                .with_opcode(Opcode::Array8)
+                .with_value(5u32)
+                .into_raw()
+        );
+        assert_eq!(encoded[4], u64::from_le_bytes(*b"name\0\0\0\0"));
+        // `fixed`: ARRAY8 of 4 bytes, zero-padded to one `u64`.
+        assert_eq!(
+            encoded[5],
+            Op::zeroed()
+                .with_key(FIXED_KEY)
+                .with_index(index0)
+                .with_opcode(Opcode::Array8)
+                .with_value(4u32)
+                .into_raw()
+        );
+        assert_eq!(encoded[6], u64::from_le_bytes([1, 2, 3, 4, 0, 0, 0, 0]));
+        // `indexed`: IMM32 with a non-zero index in the `Op`.
+        assert_eq!(
+            encoded[7],
+            Op::zeroed()
+                .with_key(INDEXED_KEY)
+                .with_index(index5)
+                .with_opcode(Opcode::Imm32)
+                .with_value(INDEXED_VALUE)
+                .into_raw()
+        );
+
+        Ok(())
+    }
 }

-- 
2.55.0

