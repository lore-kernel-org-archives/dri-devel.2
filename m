Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53826606A32E
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 02:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=HGBs9/ss
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8468E10F958;
	Wed, 28 Oct 2026 02:22:06 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010038.outbound.protection.outlook.com [52.101.201.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BB3A10F95B
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 02:22:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vZfaWyynltwVABQfbyS4nqvrFD59kDTU4orOTwJQCVHmXf73WGIll1i0hRm9Y2pFpayzyq5VMmgC/YR1jTubHbPD54fImPP903FcyezYKJOj/lvo8L586DmKCf5ypfDp0hfFnJSwuxiZhNdjX1ATNtagsV46k+YbFtSK2RbBfKJSHefTQYBWkVimUL23WnmMuMbfyYcDbIEMm/g3enkCKGbHf/HB68p9N4QDfuTDzNF9jcl+JJbJcei1RKPhZm7xinUL1C7CseoqHzDtkaC7+nlz6zZiXVXEwsQyaS4ONDSrR6dh9KSL5WyzG6naajTW1Ngxoxwn/iNxFOXPYrMQSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6c44a5KsLhJafwae6s73eGeviH/y9u1U6olPikiBPlo=;
 b=IRVJB5o7XHfRhmmGnJHPHHuNjOMWMVeYWAJ7eYdiEBJsFRwQTjQMOGcwBiPT7znTYdF6Q8BNKhDN/QCv9NGnhjTL94Gln2uQCVqra3vlt5BtrvuTz+m3Vtei8p5ctha6YOueX9X+VCTvFqS61GCANv1CjX4Tjt8nfBmUJn8K+ulpdCYDUBUAP0DCktFxj47A2vfcJt16VkrUQIoVVOK0vwBhLcs8MGVufp262ttdGKtlIJU7nos7XANyYE0q3L1o3ynMrY2i9H9LkajcbiuSD0Em+UQ5oYJuE8brYzkidm3zjNV2hPUJydf6QN2vAJq6449e2Fr2g96GMDRCnv695g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6c44a5KsLhJafwae6s73eGeviH/y9u1U6olPikiBPlo=;
 b=HGBs9/sshXQTQcMHPeYUWrYmnpe6AmWvg7egCMXuOVNHCITvaebV7Hf4tV5UwVtUyArvzauy6dmtDBmOhiQwPhLeOdm595IH2aVO02EuzaL310KFY//n+DqrsQ2wTO84rkoLtXMHO4CvWO5hvxI8122TwD6j51PFlzDvVjhsDSXtIa6ySY5dsE/0cKwIPvGtKjgUGIf88wlSYa9zMGhGIoJ20klFqCANixvH6+sYVRfuQh37So9j75bp0V8wn3p0cx4ePrL3FREljCin+A1bT+C2jeEArT695lG+vR0Lx+DjblMh73lRUSj8IJyFZDff3Qj4bjjlJ7yD5UI4LYgrzg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 CH2PR12MB4086.namprd12.prod.outlook.com (2603:10b6:610:7c::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.22; Wed, 28 Oct 2026 02:21:47 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0546.016; Wed, 28 Oct 2026
 02:21:47 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 28 Oct 2026 11:21:04 +0900
Subject: [PATCH v5 5/7] gpu: nova-core: add NVKV typed encoding
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261028-b4-nvkv-v5-5-ef78909b513e@nvidia.com>
References: <20261028-b4-nvkv-v5-0-ef78909b513e@nvidia.com>
In-Reply-To: <20261028-b4-nvkv-v5-0-ef78909b513e@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0092.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::10) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|CH2PR12MB4086:EE_
X-MS-Office365-Filtering-Correlation-Id: 66d99ce1-01ab-4c6a-ce9c-08df349a3794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|10070799003|366016|23010399003|921020|11063799006|56012099006|261009223027099003|261022105027099003|261022075727099003|261026121527099003|261021121427099003|261026140227099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: ZBdOL53VgyPIq14GtMmrkKMGQLQpLFQyLvA4Ni5OY2o9AdhWXmA1/fKYMLOZI9d+TH6kh0FSdLNtRzO31OzGmWh9VHyvqWKH73Qip0Qm6hdtwyHWDtarWlP0wc5NiULBnsa0CcyYZTlbdH7Cr7SzFSmG/xLLzTVe3YZROQOXvZxmsNVaVLNoXqhSOO2Mv3+QXNQMl0AtWfQZQETFzzanoR0CkeXTUl6VkbFRoqj1uxiUzQmR1tZZz9spdz9O7/twK+EpwjBSmi/ec+pDGAxQksvdX6m5MHtJm8ItHPNuZek8fbJdEHBe9kyzr0iPbPfDonTSr/fe0MCrssL4LGVoxox+mbANH6hQvwn5GOYJTEoCig5PdmkrGN+gW4d+F/b0yHFxAZqgTMJ/6czEzvMmuEyar0XaxYJMVrMvpqipMUz1sSdi4NVjO15hv2cezs7NoXWYocX+tTB2Fh7oTd06DTiC/mpsZXCCi6pG20dsQO2TD3jhJivsVcZod18xyG8AhEVyLANdFDNmUSYM9/H+x3SdosxKMDW5V5TGxuGJmlACM3LoiGrpVJGCb5wkfUllsoyAjc3ZFZ0Nf8xlbeXbipcow4DfLYDA5x99wMd1lEEV/cru1knkvwcJd1dnKtmjynaYpYlgcrW8YIag801WZamz/K+KJq8+QbIXlLPFwnGJiktdkvqFi6DspJHDQBjCIai8LwGF0vwStSFjktbBPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(23010399003)(921020)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261022075727099003)(261026121527099003)(261021121427099003)(261026140227099003)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHliRmEyY2VYdkZwM1FLZnpqMmJJVzIxVlZ1TS8xejMrOUE0WjlkQ0RFRlUx?=
 =?utf-8?B?NThmTGFPU0pFR1BrSHJZOEFucjlHcVNjZHVLZ2JHQTZ3dUVndHpwMkpBNnN0?=
 =?utf-8?B?a1V2bCt2VWpDZGRhT1NINGMyWGFtTC9QdTI4aytwSHQzcW9QczQrTVhZMEJu?=
 =?utf-8?B?cjVUZEZXc3hvYzMxL0hVbU4xTFAyUDNjRGEzMzNLSXpPVHRBaThEM1JVa0VF?=
 =?utf-8?B?dHhFamlwSDhsS1FyMFZ1Nk92UW16YXFqODIyU2xSUXpxeWpvWTE0UExrMk4y?=
 =?utf-8?B?RUdCdFVBZmEwbWRhYmFiL3JFcFJHcmNxeTFBWjY0cENNU0Jma1gzQzI5ZHdq?=
 =?utf-8?B?WGp4bzZpaXMxYkZEQTR2U1A3aEptYVZKTUlEeXRPbG5GV3FkSzQ1TVkvZ1dD?=
 =?utf-8?B?UVZlQlE3RVNsZFRkREx4a1o0RG9CMzBLS2dzcHdTSnZzN3ArWVd3djAvbGx0?=
 =?utf-8?B?akRwdmVuRklLUUVDbGNxQldkYmhjbmF3ckNuNFNXSkV1TVNSWnlSNFVxZjl2?=
 =?utf-8?B?U0o4REdwdVo5V2Q4WVhBMWdaYW9qR3VRN0VjSHdYYVY5R1h5Y0xicENqQXBv?=
 =?utf-8?B?bHN1K1FLUGw2Z3hiNjVmeVJKNzU0aDhudDhXVWxKRUJhUnlacllFeWhsaW50?=
 =?utf-8?B?Yy9EeTJIUEhLWGk5ZEgxNktjQUZWRE16V3FhWkxqTHRhUTFvWWV4MjNHd2pV?=
 =?utf-8?B?TWZ3UUxEUmdkeS9DTE01WUxwbGJOQWllV2lObTc0MFd0ajNxTzlKcmdLaVVo?=
 =?utf-8?B?L29WZDdWU0QxRExOUzBnWCtQbjVINmhkUExBaC9mbjJyQjJXdGwvbldHNGp1?=
 =?utf-8?B?TERaSXFaNys5V0xrWVdjcG5WUTFoOTViMEpJbHF6aXZHNXJIUXErdFF0eVVD?=
 =?utf-8?B?WUxoeElZWmNFTVE1YkUvWEJiUDREZ2xQTmhYdHZubUh0OXB6dnFFZjNyeHI3?=
 =?utf-8?B?MkIwSCtCMXdHUE00eFVobzdQL0lIUU9xeDU3c0ljY3RmL2YwenRubzZuNnli?=
 =?utf-8?B?MGZVNXR1N3E3NHdNallRUzVKRDdnaUE2NkZPYTRHOERPSS9XKzJLeEpqRG82?=
 =?utf-8?B?K1ZwMW00U25KUWVqRTNML08xRmNBcnEzdnJJYisxMXJjQlh3d0pMNSs1ZTZH?=
 =?utf-8?B?a25RYmVOM1U1SXFiVXJhTCtZYWxlTUQwZ1F4SGU4VUhZd2I1dzRiTVlOMTN6?=
 =?utf-8?B?Q0pUdXQ2Wkt3WXpLV1NDTzVpY2MvTXBCeGRXcFRrTW5uTWVQOEdMZ3BkY0pw?=
 =?utf-8?B?S2pkS1E2SFQrYWcydkVaL1Fwai8yUGZ4T1RqYkg5bS9JRzZQOGRWVFpQVWM1?=
 =?utf-8?B?SnhWNzMyZWtlYUR0KzBhR3lTNENrTkZoV29IRzJLaVd4dVhjQndpK1JSQU1s?=
 =?utf-8?B?VklqU0prRlFtVWg0SWtXTWprK2pWckIwRlRWd0N2S01nQ3BCbWprZmZYcVhl?=
 =?utf-8?B?VkNOeTRRMXJ4TVlYR1p4cHMvcXlTTG9YS1NtN0cvWmRYektkUVh2WStoZGF5?=
 =?utf-8?B?Z0RrL0czc2NZRDBEVUNML3FzYXREZERJTXplYlo4d2ZmbFV4K0FyZTRia1F0?=
 =?utf-8?B?czdnL1ZOZGxmRU5MRklnZzIrTTJhZnFRQWx0SmNRNlVXdXN0WVcyWTZNbVJw?=
 =?utf-8?B?a2lCc0xVZTF5eTJMOU1uZEtoU0pzeHN6ZVFYR2xWVVdSL3NSazJuNy8yaGE3?=
 =?utf-8?B?amcwajNwbkZ3WlVZRVlwaFFWUXlFRTk2OTRDcG9DcXBGYk9nb1cyZklCOEls?=
 =?utf-8?B?MFN4RmNMUWlVbklUUWRWM3ZNRGNxbThwMmpKYkxiNmdsUzNoK3k4QXhaeG0y?=
 =?utf-8?B?TkFjWURqLzhFSXp0cHFDKzZDQ2JDRzc1VzFIZEFwMkNBQVA3WCs3OVlXTWJv?=
 =?utf-8?B?WFBqOVN2VEYweUFXL01XYlZGckk1VlFoTG1wVHN1Z2VpUjA1Q3ltaDNyRzd0?=
 =?utf-8?B?WHNVamNoeWZmb3FDTUI0K2lZTk9WQTQ3WW4zcTRTNkpnc1dUOUxWTndXVUFw?=
 =?utf-8?B?NUNqZFhyajNoVkd0QTVPMUNuOTVjbmErTk0xWSsrR1BXZjIzSkpTaysyMmd3?=
 =?utf-8?B?YWNUUVNoZUFCTk1xNUEvSFd0RU1NdDJFSWFGZUg4Ym80NWpucVp1UTQ3UVFn?=
 =?utf-8?B?Yi80bi9BR003aU9OaU9vVjRPSi9PYkMxMFE4Y2dFMHJsMnRGM0pjWlVKdGRZ?=
 =?utf-8?B?dTNWT0ZJVzhvZ2FCdHhhY0duVTVURHlJb3RHRDBiYzRQeTBNd0tSa1JQV1dt?=
 =?utf-8?B?OW5VWW1EQ2cwdGdhZmFnMnlqaXh0RCtpUnIvR3NPYVlYWTh4aHNDUTdVVnR4?=
 =?utf-8?B?TmhreXZENDE5bWJ5UWlicDVFLzNOOUUzWnVBTU1lMzhzSXJXbkxTV1VIblEy?=
 =?utf-8?Q?YC5M9j7jpUdTP1Uu/lb5Wu3QOgVhFse5zTepAJGw93mj5?=
X-MS-Exchange-AntiSpam-MessageData-1: 2rTTTFvDxKuhfg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66d99ce1-01ab-4c6a-ce9c-08df349a3794
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 02:21:47.2977 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XAYk1la9gBRf38Kn+5Pi4cxOiHQeXQrsDetluUq+0j+zkgok26JgWCWPaBk9KnXwHVBukrpI+UIcUFB9kLscRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4086
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

For struct-like GMCAPI messages encoding field by field manually is
noisy. Add some type machinery and a macro to automate encoding of
struct-like messages. The `Encodable` trait can be implemented by any
type to say that it can be encoded into an NVKV `Encoder`. Add a simple
`nvkv_encode!` macro that works on structs and encodes each field in
order. Provide some base types, such as `Key` which statically
associates an NVKV key with some value, to avoid having to make a lot of
newtypes and implement `Encodable` on them.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/nvkv.rs        |  68 ++++++++
 drivers/gpu/nova-core/gsp/nvkv/encode.rs | 273 +++++++++++++++++++++++++++++++
 2 files changed, 341 insertions(+)

diff --git a/drivers/gpu/nova-core/gsp/nvkv.rs b/drivers/gpu/nova-core/gsp/nvkv.rs
index 98c5c31c3717..9d89e09e02f5 100644
--- a/drivers/gpu/nova-core/gsp/nvkv.rs
+++ b/drivers/gpu/nova-core/gsp/nvkv.rs
@@ -11,6 +11,14 @@
 
 #![expect(unused_imports)]
 
+use core::{
+    marker::PhantomData,
+    ops::{
+        Deref,
+        DerefMut, //
+    }, //
+};
+
 use kernel::{
     bitfield,
     num::Bounded, //
@@ -30,6 +38,66 @@
 /// The index of an NVKV value.
 pub(crate) type Index = Bounded<u64, 12>;
 
+/// A static association between an NVKV key `KEY_ID` and the storage of its value.
+///
+/// Use with the encoder or decoder macros `nvkv_encode!` and `nvkv_decode!` to let them know how to
+/// map the value `Key<T, KEY_ID, As>` to/from encoded data. For brevity, `As` inserts an additional
+/// conversion ([`From`]) to avoid having to implement [`Encodable`] for many types. For example,
+/// enums that are easily convertible to a u32 can have `As = u32` and rely on the existing encoding
+/// for u32.
+pub(crate) struct Key<T, const KEY_ID: KeyId, As = T>(T, PhantomData<As>);
+
+impl<T, const KEY_ID: KeyId, As> Key<T, KEY_ID, As> {
+    /// The maximum size in bytes we allow to materialize on the stack while
+    /// encoding or decoding a [`Key`]. This is checked at compile time.
+    const MAX_STACK_SIZE: usize = 32;
+}
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
+/// A value with a specific index that encodes under the NVKV key `KEY_ID`.
+pub(crate) struct IndexedKey<T, const KEY_ID: KeyId> {
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
 bitfield! {
     /// The op word that starts each NVKV operation.
     struct Op(u64) {
diff --git a/drivers/gpu/nova-core/gsp/nvkv/encode.rs b/drivers/gpu/nova-core/gsp/nvkv/encode.rs
index ca4189f35feb..a9d0420d0936 100644
--- a/drivers/gpu/nova-core/gsp/nvkv/encode.rs
+++ b/drivers/gpu/nova-core/gsp/nvkv/encode.rs
@@ -8,11 +8,137 @@
 
 use super::{
     Index,
+    IndexedKey,
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
+/// Use a lifetime on the struct if its fields borrow data, for example, `Key<&'a [u8], KEY>`.
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
+#[cfg_attr(not(CONFIG_KUNIT = "y"), expect(unused_macros))]
+macro_rules! nvkv_encode {
+    (
+        $(#[$attr:meta])*
+        $vis:vis struct $name:ident $(<$lt:lifetime>)? {
+            $(
+                $(#[$field_attr:meta])*
+                $field_vis:vis $field:ident : $ty:ty
+            ),* $(,)?
+        }
+    ) => {
+        $(#[$attr])*
+        $vis struct $name $(<$lt>)? {
+            $(
+                $(#[$field_attr])*
+                $field_vis $field: $ty,
+            )*
+        }
+
+        impl $(<$lt>)? $crate::gsp::nvkv::Encodable for $name $(<$lt>)? {
+            fn encode(&self, encoder: &mut $crate::gsp::nvkv::Encoder) -> ::kernel::error::Result {
+                $( $crate::gsp::nvkv::Encodable::encode(&self.$field, encoder)?; )*
+                Ok(())
+            }
+        }
+    };
+}
+
+impl<const KEY_ID: KeyId> Encodable for IndexedKey<u32, KEY_ID> {
+    fn encode(&self, encoder: &mut Encoder) -> Result {
+        encoder.encode_u32(KEY_ID, self.index, self.value)
+    }
+}
+
+impl<const KEY_ID: KeyId> Encodable for IndexedKey<u64, KEY_ID> {
+    fn encode(&self, encoder: &mut Encoder) -> Result {
+        encoder.encode_u64(KEY_ID, self.index, self.value)
+    }
+}
+
+impl<const KEY_ID: KeyId> Encodable for IndexedKey<&[u8], KEY_ID> {
+    fn encode(&self, encoder: &mut Encoder) -> Result {
+        encoder.encode_array8(KEY_ID, self.index, self.value)
+    }
+}
+
+impl<const KEY_ID: KeyId> Encodable for IndexedKey<&[u32], KEY_ID> {
+    fn encode(&self, encoder: &mut Encoder) -> Result {
+        encoder.encode_array32(KEY_ID, self.index, self.value)
+    }
+}
+
+impl<const KEY_ID: KeyId> Encodable for IndexedKey<&[u64], KEY_ID> {
+    fn encode(&self, encoder: &mut Encoder) -> Result {
+        encoder.encode_array64(KEY_ID, self.index, self.value)
+    }
+}
+
+impl<const N: usize, const KEY_ID: KeyId> Encodable for IndexedKey<[u8; N], KEY_ID> {
+    fn encode(&self, encoder: &mut Encoder) -> Result {
+        encoder.encode_array8(KEY_ID, self.index, &self.value)
+    }
+}
+
+impl<const N: usize, const KEY_ID: KeyId> Encodable for IndexedKey<[u32; N], KEY_ID> {
+    fn encode(&self, encoder: &mut Encoder) -> Result {
+        encoder.encode_array32(KEY_ID, self.index, &self.value)
+    }
+}
+
+impl<const N: usize, const KEY_ID: KeyId> Encodable for IndexedKey<[u64; N], KEY_ID> {
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
+    fn encode(&self, encoder: &mut Encoder) -> Result {
+        const_assert!(
+            size_of::<T>() <= Self::MAX_STACK_SIZE && size_of::<As>() <= Self::MAX_STACK_SIZE,
+            "`Key` here would materialize too large a value on the stack"
+        );
+
+        IndexedKey::new(Index::new::<0>(), As::from(self.0)).encode(encoder)
+    }
+}
+
+impl<T: Encodable> Encodable for Option<T> {
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
     stream: KVVec<u64>,
@@ -189,4 +315,151 @@ fn encode_all_value_kinds() -> Result {
 
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
+        const CONVERTED_KEY: KeyId = 0x0007;
+        const INNER_KEY: KeyId = 0x0008;
+
+        // A value that is encoded as the `u32` it converts to.
+        #[derive(Clone, Copy)]
+        enum TestEnum {
+            Value = 3,
+        }
+
+        impl From<TestEnum> for u32 {
+            fn from(value: TestEnum) -> Self {
+                value as u32
+            }
+        }
+
+        nvkv_encode! {
+            struct Inner {
+                x: Key<u32, INNER_KEY>,
+            }
+        }
+
+        nvkv_encode! {
+            struct TypedRequest<'a> {
+                a: Key<u32, U32_KEY>,
+                b: Key<u64, U64_KEY>,
+                name: Key<&'a [u8], NAME_KEY>,
+                fixed: Key<[u8; 4], FIXED_KEY>,
+                opt: Option<Key<u32, OPT_KEY>>,
+                indexed: IndexedKey<u32, INDEXED_KEY>,
+                converted: Key<TestEnum, CONVERTED_KEY, u32>,
+                nested: Option<Inner>,
+            }
+        }
+
+        const U32_VALUE: u32 = 0x89ab_cdef;
+        const U64_VALUE: u64 = 0x0123_4567_89ab_cdef;
+        const INDEXED_VALUE: u32 = 0x1234_5678;
+        const INNER_VALUE: u32 = 0x0bad_f00d;
+
+        let index5 = Index::new::<5>();
+        let request = TypedRequest {
+            a: U32_VALUE.into(),
+            b: U64_VALUE.into(),
+            name: b"name\0".into(),
+            fixed: [1u8, 2, 3, 4].into(),
+            opt: None,
+            indexed: IndexedKey::new(index5, INDEXED_VALUE),
+            converted: TestEnum::Value.into(),
+            nested: Some(Inner {
+                x: INNER_VALUE.into(),
+            }),
+        };
+
+        let mut encoder = Encoder::new();
+        request.encode(&mut encoder)?;
+        let encoded = encoder.finish();
+
+        // `opt` is `None` and is not encoded.
+        assert_eq!(encoded.len(), 10);
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
+                .with_value(1)
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
+                .with_value(5)
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
+                .with_value(4)
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
+        // `converted`: IMM32 with the `u32` that `TestEnum::Value` converts to.
+        assert_eq!(
+            encoded[8],
+            Op::zeroed()
+                .with_key(CONVERTED_KEY)
+                .with_index(index0)
+                .with_opcode(Opcode::Imm32)
+                .with_value(3)
+                .into_raw()
+        );
+        // `nested`: IMM32 with the single `u32` it contains.
+        assert_eq!(
+            encoded[9],
+            Op::zeroed()
+                .with_key(INNER_KEY)
+                .with_index(index0)
+                .with_opcode(Opcode::Imm32)
+                .with_value(INNER_VALUE)
+                .into_raw()
+        );
+
+        Ok(())
+    }
 }

-- 
2.56.0

