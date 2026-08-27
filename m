Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A7F2C61DC4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:23:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E0D310F096;
	Thu, 27 Aug 2026 14:23:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="CfirnHQl";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012062.outbound.protection.outlook.com [40.107.209.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B72CE10F094
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 14:23:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uohBIuKtWq+i3myjuaOuNWaQgHAB4XHvvLZce0L7hShaTJovyiah2vaJR/3ex/IqWfLoZF0D04GkhpwklEi/rpxNOIAh/eoH4fIXaScHILWT4TZZdKE0Cxn3QTn8vvRX+XNPOSwunHXHlG1H+E4kPFzuykyYfoo9N8RylNDIsou7J2G9NzApKduVJvFYpUgS4D8jYNplN9q+PTw2CZkkRgX56i69h8FtHdSZXRG+vWw60qy2HQ29lka89FlrjRY+PhohVSTtV+8z/pkNhzMaO1e1Q76UO/cfc4xizhWrojaDyNqKfyf6PDyBgwEI3ZqJ5tFdBKjIMYIRnc+vLHJatQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1SODgW2UDhmF6w87PmRidCAKOA5siSbqxkN/v1rwYeI=;
 b=yAZ6Ztiv26bpdKJ0uWFErq6FNn6q07hKSZhEIEXPvQfPHAfw4z/BD14BtlnM9mtLvsr7cEvm/6+zU/aEIorAd8YRdNGE8DmdM5sgcAqqUDIQmfzllgDT5ksWnMv2477zcU0rlZCBII0g5agAYbLzQGotktGdabZQB/lXX4WAOdB9a8d62KqApT7xLJJOi/I/Yg5VO277hN5WS/OVsnQIt9Hi6+d0LgJ0Dfo3Fvqe8Mstye7+6nxPoDqMQuXbFrLZmuTkH6XpeUI2ND840LAropoAWfIZoqgWNDnXcJLBCI/1o0QQV17vOIN/00ICmqeW9raT59j89RNnRk4WU9UGJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1SODgW2UDhmF6w87PmRidCAKOA5siSbqxkN/v1rwYeI=;
 b=CfirnHQlwGkf/1FzG3nGD2y+zYMNj9rMYt+O7QfysgHzkEDayasEX93BUzEDyQaXvi1qDPPlf+bJ3lLf1AEXjqolpPZT7P3uJrLMj0Q5KK6SoZ/rDkA1n9hz+hhGFEc6oNudNT4KDuzbnj13NAq0DPVq6Pj2WIk/ed/tZdnL07he8K/WNq8qPf3ijCzgOgHtFdPKYF3BqLvkoxRL7+WyRwSKSdbOvXcPDPpVzO12I0LfmwjcVYW1ak5xmIiClgNxEBjrcjqyF1jWzu/cOeNcGPutD3l/zeoIA0ojedznjdw2TrQBGEIUM3U0PnyDPH9XyZs6IylvWcb1SJRtEWoWHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 PH0PR12MB7930.namprd12.prod.outlook.com (2603:10b6:510:283::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.10; Thu, 27 Aug 2026 14:23:08 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 14:23:08 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 27 Aug 2026 23:12:55 +0900
Subject: [PATCH v2 6/8] gpu: nova-core: add NVKV typed encoding
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-b4-nvkv-v2-6-0de9d5c8658c@nvidia.com>
References: <20260827-b4-nvkv-v2-0-0de9d5c8658c@nvidia.com>
In-Reply-To: <20260827-b4-nvkv-v2-0-0de9d5c8658c@nvidia.com>
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
X-ClientProxiedBy: TY4P301CA0025.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::7) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|PH0PR12MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e62cc15-de93-43ab-a7ac-08df0446b7a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|10070799003|1800799024|366016|18002099003|22082099003|3023799007|11063799006|56012099006|10067099003|921020;
X-Microsoft-Antispam-Message-Info: 38ZBLmGY8g091MV5SSd9err3CaiZc9lE9zmPxaBhjP5NHu41HgENCZpiCIylGKQuLgt941iHdHgDWTc4qjDKlWuDSI3/kkCmDe3lvEh+9YvvLqcUmLndc3trSUm4f5hGFW8jlkBIwrWN1x9pDjjxlaeRdlsziiKzU0FY2H233dIUef8cG6Al/X743SZMYcd7Wizfd30vVv8blBwgWVh8hoUF5LMAAy0KkcWUualNBBe0sbPDtmiDHzEUcWOSI3vn+NEcyBlb2lvaGP/jVA38j7lv90dmEzkG6484PeCRSTQRntgbYcd57n1/Nc+v1n8Ig/X5w+edrGwh63frm2h/thO6JfZQZnPEhyEw5oAD/pzMqNK5dZJvr3ZULyDhFmgAT9ij/S7VNkM1wz/5D2tIOrYPwPfYjAOL2NmD8PpSd/S+Hh9psr3SlYtc5O7J2kc3KHK2rTXXYADf4I9hvPOnexheug6DXsWGBE5ZV7BZ3PB0jD3nlGbiGRAhqjBw2+hnoUbly2Frzxm3QDooFrlSiQBmjWsDwrc+IdrhVgTZrhJi+C7gOU8WbdnLQ8fhsMT4UHdoVxO9vqzNc/mdBh6u9wtHafCmyjCNdrzaq2t6bW3e3n7uWvn12IKt9hDJKOdgmZI6CsPuZIldcw/PWBxoTg5kChakNeAEOT2eP8PB8fRqgKo7X7iNl0Huw85lGQ208tY/sS1eQ4pa6Ghhun60bA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(10070799003)(1800799024)(366016)(18002099003)(22082099003)(3023799007)(11063799006)(56012099006)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmlEOFFuN0Q2TXc2UTYvM3hGVTBnK0RLOHhweDQzYW9CSlpsY3ZSTlAwSDJ4?=
 =?utf-8?B?MXNVVUVrRUdvTmJnbm1GdGM3dndKWHQ4OW5qR3Bwam1DU0h0ZjVIQ1Q5cDNx?=
 =?utf-8?B?V3Y3NjI1SExrazZPblZrak8rR1U3SisyT1BHT05BYjYxbTIvWVRha1g1NkRR?=
 =?utf-8?B?NkI5WDNWbXZ6TWIxNEFpT3NHTU90ZVlsQng5Y0NHZFluRStHaVdoMFFka01o?=
 =?utf-8?B?b3BXY2RxeGV4ODF3cUVGcE1SZmFKOVdBRWxlMjRsd0NSV08wekVQQjZWd1Fa?=
 =?utf-8?B?dEgwMyt0c0xnT3ZqcWI0VXE1NEhFL1R4MTFSZXZONFdJOU1jZVl4R2JUWFc1?=
 =?utf-8?B?bERheHVUVndMdE1nekVvcEg5NDdJVmI1QVNNVTIzYXZ5WkRzT3RRUmZUZlJ5?=
 =?utf-8?B?WkNQSndTWVlhWVN5cmZqM3h4MjY2Vkx4Y2toOFJJOU81c0N3NHk2aXJsM1JY?=
 =?utf-8?B?K3hXQ3pyVTZnbEw4S295SFFrQ1dGSXJXYkJGZGRNa3ZaQmt1WTZkUDVDZkZX?=
 =?utf-8?B?a2tjTzB3eXhPMFc2Sm11VlRoL3VMalFMZHJJalp2cGx6QllHT29EeUVKcVhR?=
 =?utf-8?B?Q0Q0aUlPOERObjNCZVBpRC80UGt0K1hjck9JalJkSkIvbEJEZkJNakRHb2Uz?=
 =?utf-8?B?TDhOV3g5VDMzREdWQmJyb0NwOXNJbkFpcy83TlVyOEkyUkdQRE0rNDJUdlVB?=
 =?utf-8?B?Z0xSelFBYWhwU0M4SGRIYi8vekFVQUFrRm1CSUtnVkNmSlVpSkllekNmTEkr?=
 =?utf-8?B?dVMzb3libGUyb3U1TzJLNmt5VE5abUVVM3ZXUElvK2YxcG9DaCtMV0szWGNx?=
 =?utf-8?B?QmVwMWlpOEtVeHRMTHhGdWFETFExSkRuSDE0VC83ckhORmo0NGRuR0d2bzVH?=
 =?utf-8?B?a1N6WlNwaTVsL2pBTWcwY096ZUYwTCt6aGJIS0ZnYmU1YlhxbGs5dmtGMDQy?=
 =?utf-8?B?cE1VZlRFZFBuWkh6dDhwNTQyQk94TzQrSUE3RjFCT2NwaEt1WXFKQnRuMTNs?=
 =?utf-8?B?VzR1TjhKZUwwcGZ6Q0hjOVRpSVZObmtVT1g3NHp0L0pTazJRYzhsaWhSRDQv?=
 =?utf-8?B?bFFNTDY3Sm1ZeTlyNlhzSk9hV3NuaXBkeU4zYTVVeUgvRktnZ0JWTUVGWVZI?=
 =?utf-8?B?N2Z1YkVvWXAzOWRMRDRtLzUyTzBaVmtjSVdSNE1ZSVE2bUNvK3NDZEo4Z3ZU?=
 =?utf-8?B?ZGpzRmp6SkZHRzRETFdJblFkMDNTc0tTanVsMEpyWlljeDladlNweEdsQ2pw?=
 =?utf-8?B?UVpPTndPZGI3Rm51dkM0UStmdGh5Z2RNbUZ5cjZkUU5iWGs3ZC83OVp2WlZV?=
 =?utf-8?B?ZWVpWUJMUjRob2JtdHFQcG00ajNLaExncnRvNngwL3J0RnRRNmtVNnZ5RWJ3?=
 =?utf-8?B?YlJEcUhyajZscWxTSHVjOGkrc05tMXhObmdiTzBoQXkvOGNKT21BMFA2Y2hO?=
 =?utf-8?B?ZzZzL2FNVnlBWEV5cUNFVGV6RHgyaEUvSGFUWVZDMnk2Z3MzbHFXMDRvb0E5?=
 =?utf-8?B?a3RRbkFQWXBibS96L2FjQ29YOWdpSUZtUnkrUEtEVTVtVUZsYWxCWVY2K3Jw?=
 =?utf-8?B?NGw0aWlYYmF5ZmtmR3REakcxeSs4aHhCTVEzYlBtTjAzOCs2M2RhK3pKaHhV?=
 =?utf-8?B?SllUZWZTejNFMTlINjN0anZrbkV1MlJXVDcya3BNRW9CRmpXcDFpU1Ayc2VJ?=
 =?utf-8?B?bTRod0hpRlcyTXVDdmI4MjlxNTNvY0ZFalhTN0k1YjdpaUR0cE9lSVRBQWd3?=
 =?utf-8?B?UDBVNHY3RytnMFcrSjVuQlFwYnJsZUlEZS9GVTMySmUvbFZLMWk1bkE0THIr?=
 =?utf-8?B?ZFp1em9pR3kvMkJXUXJOMm5nRStNVUpsa01XV2ova0NsTk03Z214bEJDNUoy?=
 =?utf-8?B?eW1CdSsvZ3lVN1l1S005cDVFYkR3Z25jWUIrckN1QXQ4MTdLTGJvOXVZakFY?=
 =?utf-8?B?NGtsWFE4SmxjcDJ4Yjdkb0NqSW1ua042YTgvZmxDZXVaQk4yQm1RSGF3Rm9R?=
 =?utf-8?B?ZExEZko3SllGbkVPbjFCQW9DKzdIaDVpeDJ1aXpSalBkWnhpVkdiQjJsZzln?=
 =?utf-8?B?T2pBZ3ZOSWp2YWFWemU1YWxqUWUrRWVPNGtUWGl0bU1pNGxNVGxEeE1abEJo?=
 =?utf-8?B?eXhzczdCVXNiQ29CWDl0SW9xWVI0b1drNkhETDdPUXpnT0JRZkZNdUdFQi9J?=
 =?utf-8?B?K0lTZ21GWGNQaFJ5TTdvdHY0aUdNWHNuanNBelZrM3hIVFhHR1dmNE0vY0lh?=
 =?utf-8?B?Z2c1aUVOWlZQZkt2WGNnWlBLUENVNHp3WEUwaDI1UHhabEx4dnRObUJEcGNS?=
 =?utf-8?B?WWZ2UFNSK1pRYTVxTnpwRzhscnJodDhMWVhVamRua0V3Uis0b2hJZ1B6YUhV?=
 =?utf-8?Q?pFPYsiTYfUpuYwyu4FFii9Jy3FLQ9V/21vbWmBJ8nV6Pd?=
X-MS-Exchange-AntiSpam-MessageData-1: 6QzfDdA60t5nCQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e62cc15-de93-43ab-a7ac-08df0446b7a3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 14:23:08.6840 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sy0U+Xc6ljGaauiQTnK1g5urx5bvFKycxOJP30HzHxrMzlBviALgw2ItaoNT+sfboAdopX0FWIoD9bL9BSWxNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7930
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
 drivers/gpu/nova-core/gsp/nvkv.rs        |  49 ++++++++-
 drivers/gpu/nova-core/gsp/nvkv/encode.rs | 178 +++++++++++++++++++++++++++++++
 2 files changed, 226 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/gsp/nvkv.rs b/drivers/gpu/nova-core/gsp/nvkv.rs
index cbeee7f376b6..10dcbb9e602c 100644
--- a/drivers/gpu/nova-core/gsp/nvkv.rs
+++ b/drivers/gpu/nova-core/gsp/nvkv.rs
@@ -10,8 +10,13 @@
 //! naturally maps to storing a &str with the GPU name.
 
 #![expect(unused_imports)]
+#![cfg_attr(not(CONFIG_KUNIT), expect(unused_macros))]
 
-use core::ops::Deref;
+use core::marker::PhantomData;
+use core::ops::{
+    Deref,
+    DerefMut, //
+};
 
 use kernel::{
     alloc::{
@@ -92,6 +97,48 @@ fn deref(&self) -> &Self::Target {
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
index 6c1a9cbd90e8..0047be65e8a9 100644
--- a/drivers/gpu/nova-core/gsp/nvkv/encode.rs
+++ b/drivers/gpu/nova-core/gsp/nvkv/encode.rs
@@ -8,11 +8,153 @@
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
     stream: EncodedStream,
@@ -207,4 +349,40 @@ fn encode_all_value_kinds() -> Result {
 
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

