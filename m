Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6E3606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 02:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hszvgDcU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABB5710F961;
	Wed, 28 Oct 2026 02:22:17 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012053.outbound.protection.outlook.com [52.101.48.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BB5910F958
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 02:22:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TP9wU85g4nN0t+qdQKLTC9vEbEB3eq2scjNnMJ5chYdq7Qt4D2rTOdba4jRleaKJEr8bOLufx24HwWEupFHWvFPCxqCpTkZ/7tdx3Ro3XDjXj8twFqw4eD99MTfYrCCxpUujimCc34i73EsUHWRDuZ5OrrUz/mjQVb+x/K7xramk82WH9ImFUagOJlGBw1jOzzELmopTUGb+kab+E5skyAwgduXG41iAL6yZWvXOjrI6et5MjMbvbL4N81w3JHOyY59p9iwVd52THT3RYuWDBT+/SvM9TIBbRMiChf0M6c/8hixpPNf7a+mKOzE3+9jDJvMw+8pQ8Ee/Tolu5MxmIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sntd752Xs11+M2I6rapl1x/z3pYKLZs1wPXEPdxiFq4=;
 b=m/egy2xIoCWYQ5+XKtCUxoBPoShAxO8OH7xFRdEPb+KlrvvtxPBW2Qqqk1QUN0tl1BVYxpn5LTPo7gm1oEAdd1ScPTVtQ1J2NoOZaGyfEJlCT3E/jogJf5RGCm7aJoM2aIS1h+D89pLodYZiy/GvZTjPGbWeYRhBUfUkS+i9Gh050LuYo8rIV/g1qsY3wYAO09Hhlcmqz6cbDedaZg6cXkufu3JJY4qqb/kw0lDQfjuXYXRB3SXzhXUp1YF6QgfHO8slMPySaAfQdpF6IHDWTz+CskrKQHYCGcdofMXb/+YVsOK63Znin+tMsreWeF2ENbIl8Ygpbi7r+uuqJngvpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sntd752Xs11+M2I6rapl1x/z3pYKLZs1wPXEPdxiFq4=;
 b=hszvgDcUL/Awl4/AHfcJIoegGZ4OdT3+sJCdrzIljODj0ICW0/d3S61XIyfb5kMea/TsatOb3WZknEVDAqFdOBrX/q9ILKI0nzu2ta6wOXATsqs6IJNv92jeYRMClLdkgcz40qQOPvjwYdsT2qMeYLwZZMb4uydD6Z8e8SKBZUMMhU3L68xNHq8uuKs0FYO0lkBrSNFHxXeQOj7aAB24iom6LG71KzleMi7iB/zqA5X3v/Lf58d9xZpwBBfmN9VPq7sbjyd+/JjeAmX+5SI+XQifjKRDCm/LMYuxU+DwEHmkuV5KMc5PErNIi6ndAprgLi7sThpTqaIOv4MAZ9zx5w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 DS7PR12MB6045.namprd12.prod.outlook.com (2603:10b6:8:86::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.22; Wed, 28 Oct 2026 02:21:51 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0546.016; Wed, 28 Oct 2026
 02:21:51 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 28 Oct 2026 11:21:05 +0900
Subject: [PATCH v5 6/7] gpu: nova-core: add NVKV typed decoding
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261028-b4-nvkv-v5-6-ef78909b513e@nvidia.com>
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
X-ClientProxiedBy: TY4PR01CA0057.jpnprd01.prod.outlook.com
 (2603:1096:405:372::9) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|DS7PR12MB6045:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ee99877-fc61-412c-354a-08df349a39d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|7416014|1800799024|376014|23010399003|921020|261026140227099003|5023799004|11063799006|56012099006|261026121527099003|261021123027099003|261022075727099003|261022105027099003|261009223027099003|261021121427099003|10067099003|18002099003|22082099003|3023799007|10063799003;
X-Microsoft-Antispam-Message-Info: jvYWUQ976t21/NA2/Q/3N6t2V0rP+1J1BJrZ3yRstbPBXZJ478NtdLBrfD+NsMoD9yoqrsP+iSHPkAwM8kg7OLg8l/KFqIWtRiVy+yuXqm16CaSF6+SRbx7wuIhTieU6xsYdEU4wqLqUbnc6FnsKz+6Pa2/tc4UKxNInEfN9bJuwdg/pBsua43s1UISBsEdOx1tJapkskQuydQWR0MnqdIPga3wbv8l4vn5+TZB8tCkO5UvPDD3mr2ntbMFUJewp4fIvm8lcxRjW3NyMt+TXEbIuS1pxSpupgLzVfIqssWMfm7jzVWJlHjjPlIUlaZP7LhZ+hTQ4RcYJ0nPYo9QJ5neZ92UOmGxPgAFQPaG+5Se+V3tWx3p/jmM9qxzGcBgHn7A+SVSjVtbZepnHCXIhbALwSnSBOiKdDR1/HS6yy0D6IgohdUSLv7rk1JopctiGr39jK5MLUBrN+ehar3FcM0QeX4tFtUweTAEjTNMbsFE8ai2EDCDmk8Ggjx5X8yGCrlFRCZplYUJrk952l26QfVjHnI+Br/C+x3Wlk4EFrNFTo1kND4vpwQrtUYKOimNHV76W/RaoD7tW0MgWU6F+uVwv5mfO4j1PlYg5cueDA+72hZ5kCe+64BFVu9CocJHvhFUqD7OtrRmr5wMe+3kH+rzZnXMonYWwRkV30bnGb+VzMeQee/rM3TT/MNlVsOpzg1EHU9TKGG8BwkriCjieZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(7416014)(1800799024)(376014)(23010399003)(921020)(261026140227099003)(5023799004)(11063799006)(56012099006)(261026121527099003)(261021123027099003)(261022075727099003)(261022105027099003)(261009223027099003)(261021121427099003)(10067099003)(18002099003)(22082099003)(3023799007)(10063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WURZRkhOUExYM3NHb1BBbWdDeDV1MWNuWTFZUmRTTEM0S09YNEQ3SmkxR0ZL?=
 =?utf-8?B?K3B5SDhtaEM3WG1LRUdNNHFVL0NtbEhmUXVlTWxaM2RFUmJ0NmZPL041UkZ0?=
 =?utf-8?B?Wlh1dStYTnFnODJCemFhK01JTXh5RXRwWTBadi9GN3NVMHFPNUtoa0FEVmpp?=
 =?utf-8?B?VUZZcTJIZW1qZkRaU3k1cVMzRjRRNEIwVEd2eWxFa3BqQWtuS0NISUZLSlVB?=
 =?utf-8?B?aWI3WEhEZGJVSjVUNXJ1MGtXZ1V1RjNTYXhKc0Q0ZHZQVTNWMWliWkhYVUFN?=
 =?utf-8?B?RjRrNGxuZ3JwMVhmMGFFQXRyenVRbVBxakErOUxjNklrbUk4K0dxWWRpVG53?=
 =?utf-8?B?TWhCdmF3b1gvTGZWdTJKZTFTTFJ2aDFZaDBqMkhFZUpDbjNnb0pZS2ErTVR3?=
 =?utf-8?B?N2dMMnhtUWRGMmY1SnJLU2ZkRGF2eUtqQ043dGtnY2pVTEdKbXZJNnFkMFNI?=
 =?utf-8?B?Ti9Oa0R4M2lVSjIzcHg3dDJkVHYrZ0FaYWV3S0twVXhuVzExMDZSdUNJUU85?=
 =?utf-8?B?N0xTM3VrZlF2UVZySk8zdGN2ek04YW1QZi8wRjBaTkVadTFLTTU3VmZvb08z?=
 =?utf-8?B?VFNzMkNudE8xZXlUM2lwSkhEaFY5L2M4cE8zTEJpZDhQQU91SzZRcGNFdEdy?=
 =?utf-8?B?VzB2bm8rVjNja3NTUElLVUFpN0xwUnBKUytFTmZBS3NUenpweGFjZDNZWVNO?=
 =?utf-8?B?MEVwbXZFS05yQVBkZDRESkEvOW5yeEhqYWZFWUhqelZ4UEluVDdqTXRsOC8z?=
 =?utf-8?B?RTVESjJsVU96ajF1TUdWQ09Pc3l3K1U2d2xtTzFjTk9oNC9DZ2Zqb0J5dnpw?=
 =?utf-8?B?YWh3N2YwbFpTSFJEeHJESDhXRFVTNkdqYzhSYzBxNU80aXhlVUtQR2F1MEpN?=
 =?utf-8?B?dW01TDB0NklJWVhNUFhpa0RHQWROeEdUTEVmMiszZHQ3amJXYzBuaGxYVmo1?=
 =?utf-8?B?OXozUUVEUm54WjltSnVJVXpyckV4Z3hRUW5tS1J0TVlYMUxzQW9maXZwakU3?=
 =?utf-8?B?bWk3TTRYczVaQ2UzeHJjNXhMN0ZXZSttR2xWakxYK1RmQkRvK1VoK1NZWUx5?=
 =?utf-8?B?aG1LYzhKc05rTkVJeGlhVmhSV2d5T3R0YUxxVmhYWTNuMjF6NlE1VGZXckRp?=
 =?utf-8?B?TWsxNm1yT0pmVmFLeUpraHZVTFpIQmRmaDF5SndrSGNEajlVYVVjSjdNczZs?=
 =?utf-8?B?RGVLbExabHJ5NmZJV3FCd0ZodFlMNEdycEpnMWFVV1YyV1p1YnoySnQ4M0lT?=
 =?utf-8?B?NEN2QjEwVjl5b1F6ejhZS1RMRXg0MTBpdTZ3MjVVc2xLWTY0V3JIbXUwdXc0?=
 =?utf-8?B?d1RWUnVxaFJmSUFNdnM5UUtVUmoyZCt0RnN6b3dib2N0TGY2WHJWZFBXWFFi?=
 =?utf-8?B?WlVwU2hvVDBra3NrN2VKVTlJNitEVWMycXpYdUtNR0svT3dFa1lFRE9kaDR2?=
 =?utf-8?B?cEt4S0Z0UUtyNXV6K1VZVUo3ZnBqUXJ1TzlUaitEZUFLdk5ESjRBTmNSOVdI?=
 =?utf-8?B?cyt5ODFQd0FHUTR2RVRKQ2xaelUrdTdsYy90bEpnTCs3YnJJd215b3poeGVQ?=
 =?utf-8?B?RzlHT3czZ2RmNEUrNFFSQnhkejRuNXVXMmRWbkUwcjZ1cll4dktaR0hpbVIw?=
 =?utf-8?B?M3YzNlBoNWw3YjJlRTZzaHFkUWxweTBlRC9GMmdFYmRqVUVOa2U5WGluYnRx?=
 =?utf-8?B?cnJoQmtYWUhRbE54OVltUWFXcmR6blBkdVJaTkhmWmx0Zk5yT3UrcnFWQTVG?=
 =?utf-8?B?Y0J0UE9lZEhQTmFRY2ZJaVA1THJJekpNeHZkTlU1VmtpcTdpR0Jyb0ZLNGk5?=
 =?utf-8?B?czRVdXZtcDhJcTBDalFuQUtudUxTcjlwcXE4dzlVUW9XNmg2UWlyWkJJdjZo?=
 =?utf-8?B?VUhHeGhYZmlmUDNmZjZnS2FlODRCcVQrT2ptQ0M4bFZva2ZiSS9nMEcyNlg2?=
 =?utf-8?B?MkdRcXBSWXkxMjNCcThjUkhYVURDQ1ZmZUlKYVpqdUl6ZDV5U281NGF5QVBi?=
 =?utf-8?B?Vm00NWUrd21lc3dHTTRMOXdaT1lZMDBzaFJ2ODRVSzFhTFV6VkVDYWxnWGMy?=
 =?utf-8?B?cU9NQXpCQ2YvNVQzdWh4K3VDVzZoMjY3a0M0c1JxaXNaM2RUb2p4MHR0dzFC?=
 =?utf-8?B?eTZPZnI1V2NqREl6Rm5CZ2VZR1lzd05heWxCNlZiQ3FOTHBZQVZkV1NxNjBU?=
 =?utf-8?B?ZzFLMFdzWnZ3UlFSRDR1OVlIMmNPRlRoZGprOUdsNm5CYTBjcElvYTVudFNN?=
 =?utf-8?B?dVBOeTQ0d3daZTF4cUVIODU4NDI5Q3pyTWhxdjRnME1WR3JFd1loSngyT1hM?=
 =?utf-8?B?dVVacnYxdnNxRVVLR0VaRUFkT0tIYVRsUWJFTm9qSGNZOHp0amVWZWNFcnZ3?=
 =?utf-8?Q?mhRIzXTS6GYvzwp06UAikoVa6680Hp02x0RSEtDciEuEX?=
X-MS-Exchange-AntiSpam-MessageData-1: 9WG26s7pgpoNEQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ee99877-fc61-412c-354a-08df349a39d3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 02:21:51.2090 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +XQHqYdoRyg+Lq0Tkt5chryNZSx76btZJo0PEcMHIj9MHP2fE+tMaVsPx4cnNy9bPlNN0zRUTapHTLP0jz7Ruw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6045
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

Similar to the typed encoding layer, add some decoding type machinery.
Add a simple macro `nvkv_decode!` which implements `Schema` for a struct
by composing visit calls to each member. Add some common `Schema` kinds,
such as `Array` which collects an array value into a fixed maximum size
array, and `Required` which fails a decode if the value is not sent.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/nvkv.rs        |   8 +-
 drivers/gpu/nova-core/gsp/nvkv/decode.rs | 706 ++++++++++++++++++++++++++++++-
 2 files changed, 712 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/nvkv.rs b/drivers/gpu/nova-core/gsp/nvkv.rs
index 9d89e09e02f5..143746daf782 100644
--- a/drivers/gpu/nova-core/gsp/nvkv.rs
+++ b/drivers/gpu/nova-core/gsp/nvkv.rs
@@ -9,7 +9,7 @@
 //! speaking, the function calls will map to some struct - for example, f(GPU_NAME_STRING_KEY, 0,
 //! b"some gpu") naturally maps to storing a &str with the GPU name.
 
-#![expect(unused_imports)]
+#![cfg_attr(not(CONFIG_KUNIT = "y"), expect(unused_imports))]
 
 use core::{
     marker::PhantomData,
@@ -20,6 +20,7 @@
 };
 
 use kernel::{
+    alloc::ArrayVec,
     bitfield,
     num::Bounded, //
 };
@@ -98,6 +99,11 @@ pub(crate) fn new(index: Index, value: T) -> Self {
     }
 }
 
+/// A schema field for an array value under the NVKV key `KEY_ID`.
+pub(crate) struct Array<T, const N: usize, const KEY_ID: KeyId> {
+    vec: ArrayVec<T, N>,
+}
+
 bitfield! {
     /// The op word that starts each NVKV operation.
     struct Op(u64) {
diff --git a/drivers/gpu/nova-core/gsp/nvkv/decode.rs b/drivers/gpu/nova-core/gsp/nvkv/decode.rs
index 6496fab1c0c6..534056b97708 100644
--- a/drivers/gpu/nova-core/gsp/nvkv/decode.rs
+++ b/drivers/gpu/nova-core/gsp/nvkv/decode.rs
@@ -3,11 +3,22 @@
 
 #![cfg_attr(not(CONFIG_KUNIT = "y"), expect(dead_code))]
 
-use kernel::prelude::*;
+use core::marker::PhantomData;
+
+use kernel::{
+    alloc::ArrayVec,
+    prelude::*, //
+};
+use pin_init::{
+    init_array_from_fn,
+    stack_try_pin_init, //
+};
 
 use crate::{
     gsp::nvkv::{
+        Array,
         Index,
+        Key,
         KeyId,
         Op,
         Opcode, //
@@ -15,6 +26,446 @@
     num::IntoSafeCast, //
 };
 
+/// Defines a schema struct together with its [`Schema`] and [`Visit`] implementations that decode
+/// into `$target`.
+///
+/// Each member of the struct should implement [`Schema`] and [`Visit`]. For every
+/// `(key, index, value)` triple decoded from the NVKV stream, the generated parent [`Visit`]
+/// implementation will call each member in declaration order with that triple. If a member consumes
+/// that triple, it will stop there. Otherwise it will keep going until all members are tried.
+///
+/// The schema struct holds the state required by the schema implementation to do the decode. It's
+/// recommended to use one of the existing [`Schema`] kinds ([`Required`], [`Optional`],
+/// [`Accumulated`], [`Key`], [`Array`], [`TruncatingArray`], [`Indexed`]) for each member.
+///
+/// Use a lifetime on the schema struct if you want to borrow data directly from the encoded stream,
+/// for example, `Key<&'d [u8], KEY>`.
+///
+/// # Examples
+///
+/// ```
+/// nvkv_decode! {
+///     struct RequestSchema => Request {
+///         id: Required<Key<u32, 0x0001>>,
+///         name: Array<u8, 64, 0x0002>,
+///     }
+/// }
+///
+/// nvkv_decode! {
+///     struct NameSchema<'d> => Name<'d> {
+///         name: Key<&'d [u8], 0x0002>,
+///     }
+/// }
+/// ```
+#[cfg_attr(not(CONFIG_KUNIT = "y"), expect(unused_macros))]
+macro_rules! nvkv_decode {
+    // A schema which doesn't borrow from the stream. The macro uses a generic lifetime for the
+    // [`Visit`] implementation but not for the struct itself. This allows omitting the unused
+    // lifetime on the struct.
+    (
+        $(#[$attr:meta])*
+        $vis:vis struct $name:ident => $target:ty { $($fields:tt)* }
+    ) => {
+        $crate::gsp::nvkv::nvkv_decode!(
+            @impl ['data] [] $(#[$attr])* $vis struct $name => $target { $($fields)* }
+        );
+    };
+    // A schema which borrows from the stream for lifetime `$datalt`. The macro connects the
+    // [`Visit`] lifetime with the struct lifetime.
+    (
+        $(#[$attr:meta])*
+        $vis:vis struct $name:ident<$datalt:lifetime> => $target:ty { $($fields:tt)* }
+    ) => {
+        $crate::gsp::nvkv::nvkv_decode!(
+            @impl [$datalt] [<$datalt>] $(#[$attr])* $vis struct $name => $target { $($fields)* }
+        );
+    };
+    (@impl [$datalt:lifetime] [$($generics:tt)*]
+        $(#[$attr:meta])*
+        $vis:vis struct $name:ident => $target:ty {
+            $(
+                $(#[$field_attr:meta])*
+                $field_vis:vis $field:ident : $ty:ty
+            ),* $(,)?
+        }
+    ) => {
+        $(#[$attr])*
+        $vis struct $name $($generics)* {
+            $(
+                $(#[$field_attr])*
+                $field_vis $field: $ty,
+            )*
+        }
+
+        impl $($generics)* $crate::gsp::nvkv::Schema for $name $($generics)* {
+            type Target = $target;
+
+            fn init() -> impl ::kernel::prelude::Init<Self> {
+                ::pin_init::init!(Self {
+                    $( $field <- <$ty as $crate::gsp::nvkv::Schema>::init(), )*
+                })
+            }
+
+            fn finish(
+                &mut self,
+            ) -> impl ::kernel::prelude::Init<Self::Target, ::kernel::error::Error> + '_ {
+                let Self { $($field,)* } = self;
+                ::kernel::try_init!(Self::Target {
+                    $( $field <- $crate::gsp::nvkv::Schema::finish($field), )*
+                }? ::kernel::error::Error)
+            }
+        }
+
+        impl<$datalt> $crate::gsp::nvkv::Visit<$datalt> for $name $($generics)* {
+            fn visit(
+                &mut self,
+                key: $crate::gsp::nvkv::KeyId,
+                index: $crate::gsp::nvkv::Index,
+                value: $crate::gsp::nvkv::DecoderValue<$datalt>,
+            ) -> ::kernel::error::Result<bool> {
+                // TODO: This performs worst-case O(#fields) visit calls. Consider optimising this
+                // if it becomes a problem.
+                Ok(false
+                    $( || $crate::gsp::nvkv::Visit::visit(&mut self.$field, key, index, value)? )*)
+            }
+        }
+    };
+}
+pub(crate) use nvkv_decode;
+
+impl<T: Default, const KEY_ID: KeyId, As> Schema for Key<T, KEY_ID, As> {
+    type Target = T;
+
+    fn init() -> impl Init<Self> {
+        Self::default()
+    }
+
+    fn finish(&mut self) -> impl Init<Self::Target, Error> + '_ {
+        const_assert!(
+            size_of::<T>() <= Self::MAX_STACK_SIZE,
+            "`Key` here would materialize too large a value on the stack"
+        );
+
+        Ok(core::mem::take(&mut self.0))
+    }
+}
+
+impl<'data, T, const KEY_ID: KeyId, As> Visit<'data> for Key<T, KEY_ID, As>
+where
+    As: TryFrom<DecoderValue<'data>, Error = Error>,
+    T: TryFrom<As>,
+    Error: From<<T as TryFrom<As>>::Error>,
+{
+    fn visit(&mut self, key: KeyId, index: Index, value: DecoderValue<'data>) -> Result<bool> {
+        if key != KEY_ID {
+            Ok(false)
+        } else if index != Index::new::<0>() {
+            // Single values being set must be at index 0.
+            Err(EINVAL)
+        } else {
+            // Overwrite and take the latest value here.
+            self.0 = T::try_from(As::try_from(value)?)?;
+            Ok(true)
+        }
+    }
+}
+
+impl<T: Copy, const N: usize, const KEY_ID: KeyId> Array<T, N, KEY_ID> {
+    /// Replaces the elements with `elems`.
+    ///
+    /// Takes the [`Result`] for `elems` because this may be e.g. for an unrelated key.
+    fn set(&mut self, key: KeyId, index: Index, elems: Result<&[T]>) -> Result<bool> {
+        if key != KEY_ID {
+            return Ok(false);
+        }
+        // Require to be at index 0
+        if index != Index::new::<0>() {
+            return Err(EINVAL);
+        }
+        // Reject oversized and take the latest value.
+        self.vec.clear();
+        self.vec.extend_from_slice(elems?)?;
+        Ok(true)
+    }
+}
+
+impl<T: Copy, const N: usize, const KEY_ID: KeyId> Schema for Array<T, N, KEY_ID> {
+    type Target = ArrayVec<T, N>;
+
+    fn init() -> impl Init<Self> {
+        init!(Self {
+            vec <- ArrayVec::init_empty(),
+        })
+    }
+
+    fn finish(&mut self) -> impl Init<Self::Target, Error> + '_ {
+        ArrayVec::init_with(move |dst| {
+            dst.extend_from_slice(&self.vec)?;
+            self.vec.clear();
+            Ok(())
+        })
+    }
+}
+
+impl<'data, T: Copy + 'data, const N: usize, const KEY_ID: KeyId> Visit<'data>
+    for Array<T, N, KEY_ID>
+where
+    &'data [T]: TryFrom<DecoderValue<'data>, Error = Error>,
+{
+    fn visit(&mut self, key: KeyId, index: Index, value: DecoderValue<'data>) -> Result<bool> {
+        self.set(key, index, value.try_into())
+    }
+}
+
+/// A schema field for an array value under the NVKV key `KEY_ID` that keeps at most `N` elements.
+///
+/// Unlike [`Array`], a longer value is truncated to its first `N` elements instead of failing the
+/// decode.
+pub(crate) struct TruncatingArray<T, const N: usize, const KEY_ID: KeyId> {
+    array: Array<T, N, KEY_ID>,
+}
+
+impl<T: Copy, const N: usize, const KEY_ID: KeyId> Schema for TruncatingArray<T, N, KEY_ID> {
+    type Target = ArrayVec<T, N>;
+
+    fn init() -> impl Init<Self> {
+        init!(Self {
+            array <- Array::init(),
+        })
+    }
+
+    fn finish(&mut self) -> impl Init<Self::Target, Error> + '_ {
+        self.array.finish()
+    }
+}
+
+impl<'data, T: Copy + 'data, const N: usize, const KEY_ID: KeyId> Visit<'data>
+    for TruncatingArray<T, N, KEY_ID>
+where
+    &'data [T]: TryFrom<DecoderValue<'data>, Error = Error>,
+{
+    fn visit(&mut self, key: KeyId, index: Index, value: DecoderValue<'data>) -> Result<bool> {
+        let elems = <&[T]>::try_from(value).map(|elems| elems.get(..N).unwrap_or(elems));
+        self.array.set(key, index, elems)
+    }
+}
+
+/// A schema field that marks a child [`Schema`] as required.
+///
+/// `finish` fails with [`EINVAL`] if the child consumed no value.
+pub(crate) struct Required<S> {
+    inner: S,
+    parsed: bool,
+}
+
+impl<S: Schema> Schema for Required<S> {
+    type Target = S::Target;
+
+    fn init() -> impl Init<Self> {
+        init!(Self {
+            inner <- S::init(),
+            parsed: false,
+        })
+    }
+
+    fn finish(&mut self) -> impl Init<Self::Target, Error> + '_ {
+        let parsed = core::mem::take(&mut self.parsed);
+        self.inner
+            .finish()
+            .chain(move |_| if parsed { Ok(()) } else { Err(EINVAL) })
+    }
+}
+
+impl<'data, S: Visit<'data>> Visit<'data> for Required<S> {
+    fn visit(&mut self, key: KeyId, index: Index, value: DecoderValue<'data>) -> Result<bool> {
+        let consumed = self.inner.visit(key, index, value)?;
+        self.parsed |= consumed;
+        Ok(consumed)
+    }
+}
+
+/// A schema field which marks a child [`Schema`] as optional.
+pub(crate) struct Optional<S> {
+    inner: S,
+    parsed: bool,
+}
+
+impl<S> Optional<S> {
+    /// The maximum size in bytes we allow to materialize on the stack for the
+    /// [`Target`](Schema::Target) of an [`Optional`]. This is checked at compile
+    /// time.
+    const MAX_STACK_SIZE: usize = 512;
+}
+
+impl<S: Schema> Schema for Optional<S>
+where
+    S::Target: Default + Unpin,
+{
+    type Target = Option<S::Target>;
+
+    fn init() -> impl Init<Self> {
+        init!(Self {
+            inner <- S::init(),
+            parsed: false,
+        })
+    }
+
+    fn finish(&mut self) -> impl Init<Self::Target, Error> + '_ {
+        const_assert!(
+            size_of::<Self::Target>() <= Self::MAX_STACK_SIZE,
+            "`Optional` here would materialize too large a value on the stack"
+        );
+
+        if !core::mem::take(&mut self.parsed) {
+            return Ok(None);
+        }
+        stack_try_pin_init!(let value: S::Target =? self.inner.finish());
+        Ok(Some(core::mem::take(value.get_mut())))
+    }
+}
+
+impl<'data, S: Visit<'data>> Visit<'data> for Optional<S> {
+    fn visit(&mut self, key: KeyId, index: Index, value: DecoderValue<'data>) -> Result<bool> {
+        let consumed = self.inner.visit(key, index, value)?;
+        self.parsed |= consumed;
+        Ok(consumed)
+    }
+}
+
+/// Expects objects specified sequentially with index starting from zero.
+///
+/// This stores two [`Schema`]s which are initially empty. A [`Schema`] is expected to be complete
+/// when we get the next index.
+pub(crate) struct Accumulated<S: Schema> {
+    // Tracks the current index (starting from 0). When this advances, the schema `current` must be
+    // finished.
+    current_index: Index,
+
+    // The current `Schema` being constructed now.
+    current: S,
+
+    // Tracks empty schemas (one that has never consumed a key via `visit`), so we don't call
+    // `finish` on them.
+    current_started: bool,
+
+    // The next `Schema` to be constructed. This is required because we must consume a key intended
+    // for this Schema from the next index to know we can try calling `finish` on `current`.
+    next: S,
+
+    // The set of results generated by the completed schemas so far.
+    accumulated: KVVec<S::Target>,
+}
+
+impl<S: Schema> Schema for Accumulated<S> {
+    type Target = KVVec<S::Target>;
+
+    fn init() -> impl Init<Self> {
+        init!(Self {
+            current_index: Index::new::<0>(),
+            current <- S::init(),
+            current_started: false,
+            next <- S::init(),
+            accumulated: KVVec::new(),
+        })
+    }
+
+    fn finish(&mut self) -> impl Init<Self::Target, Error> + '_ {
+        if self.current_started {
+            self.accumulated
+                .try_push_init(self.current.finish(), GFP_KERNEL)?;
+            self.current_started = false;
+        }
+        self.current_index = Index::new::<0>();
+        Ok(core::mem::take(&mut self.accumulated))
+    }
+}
+
+impl<'data, S: Schema + Visit<'data>> Visit<'data> for Accumulated<S> {
+    fn visit(&mut self, key: KeyId, index: Index, value: DecoderValue<'data>) -> Result<bool> {
+        if index != self.current_index {
+            if !self.next.visit(key, Index::new::<0>(), value)? {
+                // Unrelated key to us.
+                return Ok(false);
+            }
+
+            // Require that objects at index k have all their keys sent before the k + 1 th object
+            // can be completed. Require that objects are sent contiguously in order from index 0.
+            if !self.current_started || index != self.current_index + 1 {
+                return Err(EINVAL);
+            }
+
+            // The current value must be finished. Push it and swap in `next`.
+            self.accumulated
+                .try_push_init(self.current.finish(), GFP_KERNEL)?;
+            core::mem::swap(&mut self.current, &mut self.next);
+            self.current_started = true;
+            self.current_index = index;
+            Ok(true)
+        } else {
+            let consumed = self.current.visit(key, Index::new::<0>(), value)?;
+            self.current_started |= consumed;
+            Ok(consumed)
+        }
+    }
+}
+
+/// A schema field that scatters indexed values into an array of `N` slots.
+///
+/// Values are decoded from the encoded stream using the type `As`, but then converted into `T` with
+/// [`From`], like the `As` parameter of [`Key`].
+pub(crate) struct Indexed<T, const N: usize, const KEY_ID: KeyId, As = T> {
+    slots: [T; N],
+    _as: PhantomData<As>,
+}
+
+/// Copies `elems`, converted to `T`, into `slots` at `start`.
+///
+/// Fails with [`EINVAL`] if the window does not fit in `slots`.
+fn scatter_window<T: From<As>, As: Copy>(slots: &mut [T], start: usize, elems: &[As]) -> Result {
+    let end = start.checked_add(elems.len()).ok_or(EINVAL)?;
+    // Reject indices outside of the declared array size.
+    let dst = slots.get_mut(start..end).ok_or(EINVAL)?;
+    for (d, &e) in dst.iter_mut().zip(elems) {
+        *d = T::from(e);
+    }
+    Ok(())
+}
+
+impl<T: Default, const N: usize, const KEY_ID: KeyId, As> Schema for Indexed<T, N, KEY_ID, As> {
+    type Target = [T; N];
+
+    fn init() -> impl Init<Self> {
+        init!(Self {
+            slots <- init_array_from_fn(|_| T::default()),
+            _as: PhantomData,
+        })
+    }
+
+    fn finish(&mut self) -> impl Init<Self::Target, Error> + '_ {
+        init_array_from_fn(|i| Ok::<_, Error>(core::mem::take(&mut self.slots[i])))
+    }
+}
+
+impl<'data, T, const N: usize, const KEY_ID: KeyId, As> Visit<'data> for Indexed<T, N, KEY_ID, As>
+where
+    T: From<As>,
+    As: Copy + TryFrom<DecoderValue<'data>, Error = Error> + 'data,
+    &'data [As]: TryFrom<DecoderValue<'data>, Error = Error>,
+{
+    fn visit(&mut self, key: KeyId, index: Index, value: DecoderValue<'data>) -> Result<bool> {
+        if key != KEY_ID {
+            return Ok(false);
+        }
+        let start = index.cast::<usize>().get();
+        // Accept both scalar vs scattered array setting for flexibility.
+        match <&[As]>::try_from(value) {
+            Ok(elems) => scatter_window(&mut self.slots, start, elems)?,
+            Err(_) => scatter_window(&mut self.slots, start, &[As::try_from(value)?])?,
+        }
+        Ok(true)
+    }
+}
+
 /// A decoded NVKV value.
 #[derive(Copy, Clone, Debug, PartialEq, Eq)]
 pub(crate) enum DecoderValue<'a> {
@@ -312,6 +763,133 @@ fn decode_unknown_key() -> Result {
         Ok(())
     }
 
+    // Tests that decoding via the `nvkv_decode!` macro works correctly.
+    #[test]
+    fn decode_typed_struct() -> Result {
+        const SCALAR32_KEY: KeyId = 0x1234;
+        const SCALAR64_KEY: KeyId = 0x1235;
+        const ARRAY8_KEY: KeyId = 0x1236;
+        const ARRAY32_KEY: KeyId = 0x1237;
+        const ARRAY64_KEY: KeyId = 0x1238;
+        const OPT_PRESENT_KEY: KeyId = 0x1239;
+        const OPT_ABSENT_KEY: KeyId = 0x123a;
+        const OPT_ARRAY_KEY: KeyId = 0x123b;
+        const TRUNCATED_KEY: KeyId = 0x123c;
+        const CONVERTED_KEY: KeyId = 0x123d;
+        const X_KEY: KeyId = 0x0100;
+        const Y_KEY: KeyId = 0x0101;
+        const SLOT_KEY: KeyId = 0x0200;
+
+        const SCALAR32_VALUE: u32 = 0x89ab_cdef;
+        const SCALAR64_VALUE: u64 = 0x0123_4567_89ab_cdef;
+        const ARRAY8_VALUE: &[u8] = &[0x12, 0x34, 0x56];
+        const ARRAY32_VALUE: &[u32] = &[0x0123_4567, 0x89ab_cdef];
+        const ARRAY64_VALUE: &[u64] = &[0x0123_4567_89ab_cdef, 0xfedc_ba98_7654_3210];
+        const OPT_PRESENT_VALUE: u32 = 0x55;
+        const OPT_ARRAY_VALUE: &[u8] = &[0x77, 0x88];
+        const TRUNCATED_VALUE: &[u8] = &[0x9a, 0xbc, 0xde];
+        const CONVERTED_VALUE: u32 = 0x66;
+
+        // A value that is decoded from the `u32` it converts from.
+        #[derive(Default)]
+        struct Converted(u32);
+
+        impl From<u32> for Converted {
+            fn from(value: u32) -> Self {
+                Self(value)
+            }
+        }
+
+        nvkv_decode! {
+            struct PairSchema => Pair {
+                x: Required<Key<u32, X_KEY>>,
+                y: Required<Key<u32, Y_KEY>>,
+            }
+        }
+
+        struct Pair {
+            x: u32,
+            y: u32,
+        }
+
+        nvkv_decode! {
+            struct TestSchema => TestDecodable {
+                scalar32: Required<Key<u32, SCALAR32_KEY>>,
+                scalar64: Required<Key<u64, SCALAR64_KEY>>,
+                array8: Array<u8, 64, ARRAY8_KEY>,
+                array32: Array<u32, 64, ARRAY32_KEY>,
+                array64: Array<u64, 32, ARRAY64_KEY>,
+                opt_present: Optional<Key<u32, OPT_PRESENT_KEY>>,
+                opt_absent: Optional<Key<u32, OPT_ABSENT_KEY>>,
+                opt_array: Optional<Array<u8, 4, OPT_ARRAY_KEY>>,
+                truncated: TruncatingArray<u8, 2, TRUNCATED_KEY>,
+                converted: Key<Converted, CONVERTED_KEY, u32>,
+                pairs: Accumulated<PairSchema>,
+                slots: Indexed<u32, 4, SLOT_KEY>,
+            }
+        }
+
+        struct TestDecodable {
+            scalar32: u32,
+            scalar64: u64,
+            array8: ArrayVec<u8, 64>,
+            array32: ArrayVec<u32, 64>,
+            array64: ArrayVec<u64, 32>,
+            opt_present: Option<u32>,
+            opt_absent: Option<u32>,
+            opt_array: Option<ArrayVec<u8, 4>>,
+            truncated: ArrayVec<u8, 2>,
+            converted: Converted,
+            pairs: KVVec<Pair>,
+            slots: [u32; 4],
+        }
+
+        let index0 = Index::new::<0>();
+        let index1 = Index::new::<1>();
+        let index2 = Index::new::<2>();
+        let mut encoder = Encoder::new();
+        encoder.encode_u32(SCALAR32_KEY, index0, SCALAR32_VALUE)?;
+        encoder.encode_u64(SCALAR64_KEY, index0, SCALAR64_VALUE)?;
+        encoder.encode_array8(ARRAY8_KEY, index0, ARRAY8_VALUE)?;
+        encoder.encode_array32(ARRAY32_KEY, index0, ARRAY32_VALUE)?;
+        encoder.encode_array64(ARRAY64_KEY, index0, ARRAY64_VALUE)?;
+        encoder.encode_u32(OPT_PRESENT_KEY, index0, OPT_PRESENT_VALUE)?;
+        encoder.encode_array8(OPT_ARRAY_KEY, index0, OPT_ARRAY_VALUE)?;
+        encoder.encode_array8(TRUNCATED_KEY, index0, TRUNCATED_VALUE)?;
+        encoder.encode_u32(CONVERTED_KEY, index0, CONVERTED_VALUE)?;
+        encoder.encode_u32(X_KEY, index0, 1)?;
+        encoder.encode_u32(Y_KEY, index0, 2)?;
+        encoder.encode_u32(SLOT_KEY, index1, 20)?;
+        encoder.encode_u32(X_KEY, index1, 3)?;
+        encoder.encode_u32(Y_KEY, index1, 4)?;
+        encoder.encode_u32(SLOT_KEY, index0, 10)?;
+        encoder.encode_array32(SLOT_KEY, index2, &[30, 40])?;
+        let serialized = encoder.finish();
+
+        let decoder = Decoder::new(&serialized, UnknownKeyPolicy::Error);
+        let mut schema = KBox::init(TestSchema::init(), GFP_KERNEL)?;
+        let decoded = KBox::try_init(decoder.decode(&mut *schema)?, GFP_KERNEL)?;
+
+        assert_eq!(decoded.scalar32, SCALAR32_VALUE);
+        assert_eq!(decoded.scalar64, SCALAR64_VALUE);
+        assert_eq!(*decoded.array8, *ARRAY8_VALUE);
+        assert_eq!(*decoded.array32, *ARRAY32_VALUE);
+        assert_eq!(*decoded.array64, *ARRAY64_VALUE);
+        assert_eq!(decoded.opt_present, Some(OPT_PRESENT_VALUE));
+        assert_eq!(decoded.opt_absent, None);
+        assert_eq!(decoded.opt_array.as_deref(), Some(OPT_ARRAY_VALUE));
+        assert_eq!(*decoded.truncated, TRUNCATED_VALUE[..2]);
+        assert_eq!(decoded.converted.0, CONVERTED_VALUE);
+        assert_eq!(decoded.pairs.len(), 2);
+        assert_eq!(decoded.pairs[0].x, 1);
+        assert_eq!(decoded.pairs[0].y, 2);
+        assert_eq!(decoded.pairs[1].x, 3);
+        assert_eq!(decoded.pairs[1].y, 4);
+        assert_eq!(decoded.slots, [10, 20, 30, 40]);
+
+        Ok(())
+    }
+
     /// Records each visit as `(key, index, value)`, for tests on hand-built streams.
     #[derive(Default)]
     struct Recorder<'d> {
@@ -500,4 +1078,130 @@ fn decode_raw_words_malformed() -> Result {
 
         Ok(())
     }
+
+    // Tests the error paths of the schema kinds.
+    #[test]
+    fn decode_typed_struct_errors() -> Result {
+        const VALUE_KEY: KeyId = 0x2200;
+        const SLOT_KEY: KeyId = 0x2201;
+        const BLOB_KEY: KeyId = 0x2202;
+        const X_KEY: KeyId = 0x2203;
+        const Y_KEY: KeyId = 0x2204;
+
+        let index0 = Index::new::<0>();
+        let index1 = Index::new::<1>();
+        let index2 = Index::new::<2>();
+
+        nvkv_decode! {
+            struct ValueSchema => Value {
+                value: Key<u32, VALUE_KEY>,
+            }
+        }
+
+        struct Value {
+            value: u32,
+        }
+
+        // A single value at a non-zero index.
+        let mut encoder = Encoder::new();
+        encoder.encode_u32(VALUE_KEY, index1, 1)?;
+        let serialized = encoder.finish();
+        let decoder = Decoder::new(&serialized, UnknownKeyPolicy::Error);
+        let mut schema = KBox::init(ValueSchema::init(), GFP_KERNEL)?;
+        assert!(decoder.decode(&mut *schema).is_err());
+
+        // A 64-bit value for a 32-bit key.
+        let mut encoder = Encoder::new();
+        encoder.encode_u64(VALUE_KEY, index0, 1)?;
+        let serialized = encoder.finish();
+        let decoder = Decoder::new(&serialized, UnknownKeyPolicy::Error);
+        let mut schema = KBox::init(ValueSchema::init(), GFP_KERNEL)?;
+        assert!(decoder.decode(&mut *schema).is_err());
+
+        nvkv_decode! {
+            struct SlotsSchema => Slots {
+                slots: Indexed<u32, 2, SLOT_KEY>,
+            }
+        }
+
+        struct Slots {
+            slots: [u32; 2],
+        }
+
+        // An index past the declared slots.
+        let mut encoder = Encoder::new();
+        encoder.encode_u32(SLOT_KEY, index2, 1)?;
+        let serialized = encoder.finish();
+        let decoder = Decoder::new(&serialized, UnknownKeyPolicy::Error);
+        let mut schema = KBox::init(SlotsSchema::init(), GFP_KERNEL)?;
+        assert!(decoder.decode(&mut *schema).is_err());
+
+        nvkv_decode! {
+            struct BlobSchema => Blob {
+                blob: Array<u8, 4, BLOB_KEY>,
+            }
+        }
+
+        struct Blob {
+            blob: ArrayVec<u8, 4>,
+        }
+
+        // An array longer than the declared capacity.
+        let mut encoder = Encoder::new();
+        encoder.encode_array8(BLOB_KEY, index0, &[0; 5])?;
+        let serialized = encoder.finish();
+        let decoder = Decoder::new(&serialized, UnknownKeyPolicy::Error);
+        let mut schema = KBox::init(BlobSchema::init(), GFP_KERNEL)?;
+        assert!(decoder.decode(&mut *schema).is_err());
+
+        nvkv_decode! {
+            struct PairSchema => Pair {
+                x: Required<Key<u32, X_KEY>>,
+                y: Required<Key<u32, Y_KEY>>,
+            }
+        }
+
+        struct Pair {
+            x: u32,
+            y: u32,
+        }
+
+        // Required keys that are missing are an error.
+        let mut encoder = Encoder::new();
+        encoder.encode_u32(X_KEY, index0, 1)?;
+        let serialized = encoder.finish();
+        let decoder = Decoder::new(&serialized, UnknownKeyPolicy::Error);
+        let mut schema = KBox::init(PairSchema::init(), GFP_KERNEL)?;
+        let init = decoder.decode(&mut *schema)?;
+        assert!(KBox::try_init(init, GFP_KERNEL).is_err());
+
+        nvkv_decode! {
+            struct PairsSchema => Pairs {
+                pairs: Accumulated<PairSchema>,
+            }
+        }
+
+        struct Pairs {
+            pairs: KVVec<Pair>,
+        }
+
+        // Accumulated objects must start at index 0.
+        let mut encoder = Encoder::new();
+        encoder.encode_u32(X_KEY, index1, 1)?;
+        let serialized = encoder.finish();
+        let decoder = Decoder::new(&serialized, UnknownKeyPolicy::Error);
+        let mut schema = KBox::init(PairsSchema::init(), GFP_KERNEL)?;
+        assert!(decoder.decode(&mut *schema).is_err());
+
+        // Accumulated objects must be complete before the next one starts.
+        let mut encoder = Encoder::new();
+        encoder.encode_u32(X_KEY, index0, 1)?;
+        encoder.encode_u32(X_KEY, index1, 2)?;
+        let serialized = encoder.finish();
+        let decoder = Decoder::new(&serialized, UnknownKeyPolicy::Error);
+        let mut schema = KBox::init(PairsSchema::init(), GFP_KERNEL)?;
+        assert!(decoder.decode(&mut *schema).is_err());
+
+        Ok(())
+    }
 }

-- 
2.56.0

