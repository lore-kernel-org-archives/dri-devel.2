Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D871606A325
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 02:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=B1wPB/cS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E2C810F95C;
	Wed, 28 Oct 2026 02:21:48 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010038.outbound.protection.outlook.com [52.101.201.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE41F10F952
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 02:21:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IM4KZRTHEJKadXl8ghFGRTCfI71HxAXD8KrgmyLafBYYfd9sKmpAq/04oEBG08GfSV/ahGal27Jg/Ge2s/6CAEZIRxpq7SMAL1wNyyBrOeg14H5ohHxVcciZ6R2eY7QRl3+cTkzmhQM/LE/F5Rrq7BwuNcL3KhyYBycVkyc3IASYCyXwZD6gowujxI/NTkbKA863THo76WiH1393s+lQP0+TfEajTf8mihzgPWCnAjHhn/A1ayuR0FkrRD9zsg90R134ASpurJT4HT4KLPYUpz+PgiWZ3Erw5XEWeKDKrjyM62XnBnPyxAB2d8QWvwE2tFkHiD7VVXuVxKGe/WPdJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6JiMBBWcfrUokb8D8554bK6WqhMpT35s0LlogrJoSI=;
 b=VhoIIKR+QJeDJne4kN5/WrWJ4MRbU8PAtaMAVBRPE/EDvXhpip5wHrafGR/K9jtBtHHWQpDpT4X6C+h2tskdUn1erhv0TKclEOK8XrUF880yMNCf4u+FB2omtAK7BTZVILWOanmO4EPXhMMouEYRocBsMXMAzZTeljEn7edbJVnAEU5CLUMPFopeB1eze/2qzUKlilhIoMD4izVTZRZ6uBz+xYqXzsmp4SRwTm6VRPcTEz3+p+4VMO3wtOho4okhZ5iRDN5apkQxxPnyQDVL1qb1MzK1JNGyKGiXcuggx/rxA057L3eheZ4Nr6AvZQ5F2pVVwAD5tQ5nVPBJKSM0+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6JiMBBWcfrUokb8D8554bK6WqhMpT35s0LlogrJoSI=;
 b=B1wPB/cS0ElLCIFc7RLAq6siIkO/t8P3ld+FhJF1FYluyItl4Xt908a2yyFlh6z7gNQ89Z228i1Ws3YbUdPzE3/WQrAbvR/ZRxxPoH23CU1K1q+V+FrrKQzmQiBuHRTLdo3WDQEqXf9+ccInMjGPum1AN7W7Lt2N3kD2ELZnO1rvMoWzh8DjDDQ3zlVgvptJBkY9j11qjCHau4yZhaEuedDguH3tymvUhr0s26wp9CiFX9lgqnNIAdL+AsUVE2nLL0GqK0sjV1UTjKioeE2vZOTykGjF5+YvUvCc3JTz0opr2nd72qCD7f3RNPosQpNy33bLQDo0PwmAZ9Uot53JZA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 CH2PR12MB4086.namprd12.prod.outlook.com (2603:10b6:610:7c::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.22; Wed, 28 Oct 2026 02:21:32 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0546.016; Wed, 28 Oct 2026
 02:21:32 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 28 Oct 2026 11:21:00 +0900
Subject: [PATCH v5 1/7] rust: alloc: add Vec::try_push_init and Vec::push_init
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261028-b4-nvkv-v5-1-ef78909b513e@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0313.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::8) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|CH2PR12MB4086:EE_
X-MS-Office365-Filtering-Correlation-Id: a0664c86-239b-4cf9-3b63-08df349a2e6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|10070799003|366016|23010399003|921020|11063799006|56012099006|261009223027099003|261022105027099003|261026121527099003|261021121427099003|261026140227099003|10067099003|261021123027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: Mel/+y4xwH5TMeovv+LE7YVU06NqxqbDmFn70hQJ6yuIWhv/MyxJ7fYJLXHJcJFfImqmdTtLL9fxzvhleXOStFslDrCnrvdkJzuRbaTUq5IgyiVZj1kby2tQSM+cJD67+ghY4xaAD0M/MV2WzJbvdo1SuYwNtBjIe2Us1hGiqwdHTK3YSKBc7lobzeXKAVufHQUPsjtUKWK8QbQ2ee9LDAo1sXZpnJaLnwXJWWZJ/vyeR4bHO3u8lyWkpelyF2f25NnfV3059FH5CUfiOc4IVAMNiAmbTTbvOvkpVxpiWUbUh6QGKiGWb+dxtWlDDrZskaPG9CcBHvIW9o8oWQ8HBU1Y+yrzV6mCR/Dh573SptXheXMEZ1y3t6Yp5YK0RXUZy/gmrtKZzcfOuCDiUEmk+5PuPHvg6PhtoEZlUnxTX0Xo7yZmBU29UHeHPSudbz9dmKAzcykCKGLi2rycjTLD/gfGEr5BERTpUsf2wVoGdHRmgBKj+Z+Qa7sLxqRykvIXoya73xwSYR08V8iBqg3BVz3amZXDSmm/PAMQ4T52T8kGfJ/eiTJiIB99h3/OqvY6r7xCmFNgk1xJAdD+gbgW94pQrwh25vQf+YCdgSnmDhiuNgSIue9mKAJP34upphuArAIY2n0alw3MnvsmYfUTiQpqNYg8iElg2asp/0vF0kRPRN5k+QmyBLPRt8nuDC41ZPvbViRvVyaqM9qX7yfOyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(23010399003)(921020)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261026121527099003)(261021121427099003)(261026140227099003)(10067099003)(261021123027099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjJrWklheExNMWk0MnVrSmNYNk90WnBHeFBOa2ZDbTczeXlqVHpoaktxL1ph?=
 =?utf-8?B?dFlBV3hTZGVwOGNwMnR2aFBPMjdaaWJLRElMeTFhNGVHOGNaQ3V1OWR4VmhS?=
 =?utf-8?B?OFYwTThMYmh0LzlCcDBiODFVS0pndUtuYkFDWkd2V1pkbVVydUZKVGpIT1dy?=
 =?utf-8?B?SEVMcTh1c091OUtEZXpBQUx1NEI4OTh6cWVvdXRpR1lUZEdSelFHdDVGMWc4?=
 =?utf-8?B?R05LTVZTOGxZbjcrOWxoK3V1WkNtNkkrVExUVVRxbndRWHJqeVRWRjdrQTlL?=
 =?utf-8?B?Yks3Uk1yY2hUVXU5b2xFaDBqRVN6TTBOakRZSDF3di9iZm9WcHp1WXNqbS9I?=
 =?utf-8?B?azNvRHVqVHFrRTllYjBuYmI0UTZOUk1tRDlLK2hMWlZKQW8xbStWN2lkdW9Z?=
 =?utf-8?B?QmcyUVlLWkgvZjI2clYxOTFoVndPL2RyUEZqWEl5aGdkTDYrSzBzNzZVRlcy?=
 =?utf-8?B?dlFIYXVLVDhYYWp3U1BCYlBlT2M2K2JvNzN3QkpzVXZ0Z2Z0MzduY2J6cjY0?=
 =?utf-8?B?UFE3eTNNdWttUkJ3WlpqbUFGU2F0TGd3UjB3U0plTXdTV21UK0Y5THhPNGRu?=
 =?utf-8?B?ZzRSdFVGREppVC83K1NueGhKeFIxUVRza1VlOWFVK2VhZ3B0dlJ1MU9URGdp?=
 =?utf-8?B?Ny9RbGthWmFlYU9xQW9ZNEtXVFpkSElwNm80b2tqMW9BL2hEMFphdkI2ZllY?=
 =?utf-8?B?Y0tOZlJRK3VCY1JGZjgwU3orQU5HRHRXY0tralZFZlhiN0t0REFHSnlmRTRm?=
 =?utf-8?B?eXFBMUswSUcxYWRIL2lHSm5RS3NqWVZ2SFdkaDVwd3VPSkhyTWlEdVFvM2ZL?=
 =?utf-8?B?engzZ1I2TSt1cVRNamxiTkhPQ09YTDZNQmg0RnZ4b3RHMllNbmJhYmZrVFYr?=
 =?utf-8?B?akJDdG9mZzl3VjNRYXJRTjVFUWg4VkNVZ1F6MEUydlo5NFZwZjJ3SGhZN0t0?=
 =?utf-8?B?eXFsVFU0K2dPclZ1N2hINnVhOHNUdm05eXdZZWc0K1VyWXBmVDJtRm8wdDBG?=
 =?utf-8?B?NkV6NUhHc2dZL2dIc25GTFkrbGs0RERqUk41Nm5MVEg3R0FjQndqQitJRWU5?=
 =?utf-8?B?UW1zTFdsVEVwU1huYkhuMEVNWkxwendoVGMwRmdwai8zRkN0c0ErYUJVeUgr?=
 =?utf-8?B?dllOdVdjSWFNZ2ZYZDMwQ2RUMkt2OE4rQ29UTTVNSU5zTmg4SHFYbXJPSkRz?=
 =?utf-8?B?dEhEa080QWp0TXg4K09IV0ZIcmVxS3lPbDQrajI5NWFld3Y1TUptWDlqdDlU?=
 =?utf-8?B?MXlmbUpSQ2Nyd0tDTG91SkI0UUpmVEhxVWZSdHNiZXBGK1N3dkZCL0dOQkE3?=
 =?utf-8?B?T2dJdTZsdExQd1pPQ09pRHFRaitKOXJNM3hDdExhM25ERTUzQXlBbjZodFFr?=
 =?utf-8?B?MFRzV3FXazFSbUNUL0YzazliWjFtV3RDY04zUEdtVitlN3Q3aHZXVmN0N1B4?=
 =?utf-8?B?Ukk5UTFaQWplczM0L2VmRi93TzVuekZZQnZFZ292elBSMXV2MmU1cEdFME12?=
 =?utf-8?B?Y2hVZSsya3hZNDBqMFZwMlZKSHJzU0ZCOVRsSFFRNXk0R0MrMWQyajBubUp1?=
 =?utf-8?B?RWo2OGF4c1RPM2g3RmhLemVLQWxZaFJSdDIrSkIzVzd6U1loV2NKaWt4RCtH?=
 =?utf-8?B?TjNLanliZDl4QnJKYk44RlNDV294Skh4bDNtTTA4SmVwMXYvRDMzSm5obmFF?=
 =?utf-8?B?dzh4MWZsaHc3RlZMVjArR01zR1I3RnVMNWRVWTRud3NKRHVkendFcTQ4azV6?=
 =?utf-8?B?YnhUdTZFRElZS2swZG1BVkI1M2NEYkh4aXlLOU9IYVVwZFVVeDU1Rk5ycEhU?=
 =?utf-8?B?MmpyNlF0eWlrYytsSXVBVWlqaVdNT09oVHFBUDdLUXVDTVNmdzdFUnVVSlBJ?=
 =?utf-8?B?QW8rL0JZQTQ5MXlla0RKbktackpYYUp3Sms2bG5XMjZBTnFUeXpIMmw0VGJO?=
 =?utf-8?B?ZHNLaitjdVZyaW1yMW5VNTA2bTV6Z0JkNDFaNFpXM1Bsd2JEdlg3ZE1RcS9I?=
 =?utf-8?B?dGFEVEk3VmV4MVppYkd6STJvc2pIS0RqOEJkR0tMS0tKRnpSZDFCcnNpdVRM?=
 =?utf-8?B?L0QwQVB1cE5iN2NKWTVzczFTSmJzeStQdFU5U0tyM0tuc1hiWWRtdzVpTHRJ?=
 =?utf-8?B?N2VweW51bXZtRm42eGdkS3lrbnRTZDZUZjY1TEx5ZjR3Y1ZrcGhjbGtqZURl?=
 =?utf-8?B?RWN2VFlhVjRyK1dkaEUzcEdCeEhSRHJMS1J4eXNtcUdrREF4OTI3Znl4cmJD?=
 =?utf-8?B?ZVhwanpsNlQrUTZDRGw5WXBsbVdkSHRpaXZML25hR1NTUk1WNEozcjluRitw?=
 =?utf-8?B?a0FGVWlmd3FHZXl1ekZxL1NaZE1yTWV1b0ZueEF0d1I3RVpJSHFvWDlWQ2Fu?=
 =?utf-8?Q?ALuR++XcXUfLPrUDu2BxE/TAkENVRM4fbKFUGeDtJAHb2?=
X-MS-Exchange-AntiSpam-MessageData-1: sExp3S2xtPVxxA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0664c86-239b-4cf9-3b63-08df349a2e6e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 02:21:31.9628 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BqhdjfOLr9x6vqZFpjTkTe4tOn+8vHl/VeUAcTf3lIUFYv2+FzGQpIUG3pnUVTAEhTVws/iKj8VrfEYNJCs7Gw==
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

Add `Vec::try_push_init` for fallible initializers (`impl Init<T, E>`)
and a new sum error type `TryPushInitError<I, E>` that it returns. If
allocation fails, it hands back the original initializer. A `From` impl
for `Error` lets callers decay the `TryPushInitError<I, E>` to a regular
Error if they want.

Add `Vec::push_init` which is the init-infallible version of
`try_push_init`.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/alloc/kvec.rs        | 85 +++++++++++++++++++++++++++++++++++++++-
 rust/kernel/alloc/kvec/errors.rs | 30 ++++++++++++++
 2 files changed, 113 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index c7546b9da4fa..c8b312f64657 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -52,10 +52,18 @@
     }, //
 };
 
-use pin_init::Zeroable;
+use pin_init::{
+    Init,
+    Zeroable, //
+};
 
 mod errors;
-pub use self::errors::{InsertError, PushError, RemoveError};
+pub use self::errors::{
+    InsertError,
+    PushError,
+    RemoveError,
+    TryPushInitError, //
+};
 
 /// Create a [`KVec`] containing the arguments.
 ///
@@ -359,6 +367,79 @@ pub fn push(&mut self, v: T, flags: Flags) -> Result<(), AllocError> {
         Ok(())
     }
 
+    /// Appends an element to the back of the [`Vec`] instance by initializing it in place.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use pin_init::init_zeroed;
+    ///
+    /// let mut v = KVec::<[u8; 200]>::new();
+    /// v.push_init(init_zeroed(), GFP_KERNEL)?;
+    /// assert_eq!(v[0], [0; 200]);
+    /// # Ok::<(), Error>(())
+    /// ```
+    #[inline]
+    pub fn push_init(&mut self, init: impl Init<T>, flags: Flags) -> Result<(), AllocError> {
+        self.try_push_init(init, flags)
+            .map_err(|TryPushInitError::AllocError(_)| AllocError)
+    }
+
+    /// Appends an element to the back of the [`Vec`] instance by initializing it in place.
+    ///
+    /// Unlike [`Vec::push_init`], the initializer may be fallible. If the allocation fails, the
+    /// original initializer `init` is handed back in [`TryPushInitError::AllocError`]. If the
+    /// initializer itself fails, its error is returned in [`TryPushInitError::InitError`].
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// struct Element {
+    ///     value: u8,
+    /// }
+    ///
+    /// impl Element {
+    ///     fn new(value: u32) -> impl Init<Self, Error> {
+    ///         try_init!(Element {
+    ///             value: u8::try_from(value)?,
+    ///         }? Error)
+    ///     }
+    /// }
+    ///
+    /// let mut v: KVec<Element> = KVec::new();
+    /// v.try_push_init(Element::new(16), GFP_KERNEL)?;
+    /// assert_eq!(v[0].value, 16);
+    ///
+    /// // The initializer fails because 256 does not fit in a `u8`.
+    /// assert!(v.try_push_init(Element::new(256), GFP_KERNEL).is_err());
+    /// assert_eq!(v.len(), 1);
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub fn try_push_init<I, E>(
+        &mut self,
+        init: I,
+        flags: Flags,
+    ) -> Result<(), TryPushInitError<I, E>>
+    where
+        I: Init<T, E>,
+    {
+        if self.reserve(1, flags).is_err() {
+            return Err(TryPushInitError::AllocError(init));
+        }
+        // SAFETY: The call to `reserve` was successful, so there is at least one spare slot.
+        let slot = unsafe { self.spare_capacity_mut().get_unchecked_mut(0) }.as_mut_ptr();
+        // SAFETY:
+        // - `slot` points to a spare slot, which is valid, uninitialized memory.
+        // - If `raw_try_init` fails, this returns without increasing the length or touching `slot`.
+        // - `init` implements `Init<T, E>`, which removes the pinning requirement.
+        unsafe { pin_init::raw_try_init(slot, init) }.map_err(TryPushInitError::InitError)?;
+        // SAFETY: The call to `raw_try_init` returned `Ok`, so the first spare slot now holds an
+        // initialized `T`. The new length does not exceed the capacity because `reserve` ensured
+        // the capacity is greater than the length by at least one.
+        unsafe { self.inc_len(1) };
+        Ok(())
+    }
+
     /// Appends an element to the back of the [`Vec`] instance without reallocating.
     ///
     /// Fails if the vector does not have capacity for the new element.
diff --git a/rust/kernel/alloc/kvec/errors.rs b/rust/kernel/alloc/kvec/errors.rs
index aaca6446516a..d24dfe22834a 100644
--- a/rust/kernel/alloc/kvec/errors.rs
+++ b/rust/kernel/alloc/kvec/errors.rs
@@ -25,6 +25,36 @@ fn from(_: PushError<T>) -> Error {
     }
 }
 
+/// Error type for [`Vec::try_push_init`].
+pub enum TryPushInitError<I, E> {
+    /// The allocation failed. Hand the initializer back.
+    AllocError(I),
+    /// The initializer failed.
+    InitError(E),
+}
+
+impl<I, E> fmt::Debug for TryPushInitError<I, E> {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        match self {
+            TryPushInitError::AllocError(_) => write!(f, "Failed to allocate"),
+            TryPushInitError::InitError(_) => write!(f, "Initializer failed"),
+        }
+    }
+}
+
+impl<I, E> From<TryPushInitError<I, E>> for Error
+where
+    Error: From<E>,
+{
+    #[inline]
+    fn from(e: TryPushInitError<I, E>) -> Error {
+        match e {
+            TryPushInitError::AllocError(_) => ENOMEM,
+            TryPushInitError::InitError(e) => Error::from(e),
+        }
+    }
+}
+
 /// Error type for [`Vec::remove`].
 pub struct RemoveError;
 

-- 
2.56.0

