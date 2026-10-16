Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E9ACC6B38
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 01:54:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D733D10E0CD;
	Fri, 16 Oct 2026 01:54:36 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012053.outbound.protection.outlook.com [52.101.48.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50FC510E0CD
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 01:54:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=warStiOefukf/Bq2ZAhrycFtpuP6bAxb5ML9CTi+sas38ToK5ZJVUvVvaoFVZzFQIMmPqAkIOuJtigVCADQ3bLpMo4bx1QMeNCnZnNdtgCQSEbXBKPhEInDwmK3DbOKoHNZz+9JapJm0qDvNc+tuL4we359eEPD3+8Az87gNmkX509S/o06nD7D9WmzQfurC5sU5Oe62Z7aKR5wUT9KgMhjDtkR5uF9wTdXhl2R4tzUEKxzy8mdhmwZVctLIslaxOMfV3g8AswlQsSJslqo0q7MulgfZCiq9m788RxP8S0/8cRUTlzy8JGGMlgcI5jOTxlIp3c5XNHituBueAquerw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NY0IHZdchcKP0cmNwiZFx5Xy9jJpcqnRjEOtOdqKnE=;
 b=evlKM9S+A09G5LiWEvgGtOT8b5PNEBVD+VSk6/u+ddI4de5OwTqHO4ECc3gyyr0AwGpOd0wM23SSQq+lJl3oqw10zS/J5rO5UKx6uqKmlWzX3kfaADrl20YeUWqFxO7uAfV63fyF+79ZPTSRx5EvJ5afzsV1foW45kcduckMeZehonUKn8jv+FthcGdnGxt512K0GU9/tXFEHSXlO56/tT7dUdQIUnFJy9B1X5rJ5vsidXbpoAQsyXh/QkMvwzH/mVt4KT4QNPebZNJ4AnkAromSFQPGfTXeYCqFY+Q140/MbqymszQiuEXHEuTevBoF02x4Gqv8t7/1NlLvTvm4Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NY0IHZdchcKP0cmNwiZFx5Xy9jJpcqnRjEOtOdqKnE=;
 b=GFwtAPFgDCcSyLzQujQCX188S1x0lxtre6x9qYsslpdX2Djnn5ziw6OALXfC+tiv+FoXGNhFiUBzjwY5vaGu55QX6Vxl9gX9KCRrwMSYfKLgXxsLrnvnfTcSpYN75QCJfhP8Iqr3lqRoaeK2c9O+Ou6smHpqWk0OmBg8P0Q19ml8Ao79oKSUVO05SeAYPySfa68oENzgwPdoUdPbdlHAql8IvGkbCV2xmTFkoNQZa6NlwcmQOLQ58ojEjPsmCMuH2fOQ4QwSAUFE0akSiQfhEG2J0fQUumVxmUffuFJueT5ydcySh0WFvvexe4/cuC8ItjEwpagSSJ5F9EqfTi+66g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 SA1PR12MB999230.namprd12.prod.outlook.com (2603:10b6:806:4de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 01:54:11 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0496.021; Fri, 16 Oct 2026
 01:54:10 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Fri, 16 Oct 2026 10:53:37 +0900
Subject: [PATCH v4 1/7] rust: alloc: add Vec::try_push_init and Vec::push_init
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-b4-nvkv-v4-1-e8b92b91aa5b@nvidia.com>
References: <20261016-b4-nvkv-v4-0-e8b92b91aa5b@nvidia.com>
In-Reply-To: <20261016-b4-nvkv-v4-0-e8b92b91aa5b@nvidia.com>
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
X-ClientProxiedBy: TY6P301CA0025.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3bf::7) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|SA1PR12MB999230:EE_
X-MS-Office365-Filtering-Correlation-Id: 81ece3d9-a7dc-4a88-50b6-08df2b285f30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|23010399003|10070799003|366016|376014|6133799003|18002099003|10067099003|22082099003|921020|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: XvqdtGf8hnJ1Z1LLNlTU03LRA8W3/TsrSCZk6lWGH4ql4BpX4acExDfaz2Nu2J4MoqDzZXZxbtCfO5EK8ddE2fSAFZm3bCdBYZNdkVZCSc4EbwQh4ZL0X1PGYqpTa7NfJlmVLATAVWwUmKmloGl+4LnRhvFNL0FXWKxC4SIqBBCPYU4Fm0+algwBxYN5TgIxsL/EoQAKRu/LZ8MEnubicCyiIYt62c2RmEkhkmsonrsaaH9yd++Vp2PAxXz/aspdxs9RqZGS/38feLOy8CpvhImSczmQnohxFK9ZiZ0qWJxeWyxhFgsAnxDoYK1wu6YDwYDjqPaIQr1jMwzZSSi4f/qejsOqG8mnGIxBqFEDNWBSVrjoxt8mJXtq7FY2yFwjrT8MakUR38iaVfW+zj9rRBGpInG/aDu0TbiJDAKgoXVIJ9WLuiYreNibroPxr4yXVkSKkwEv2a4AwOknHb8c5b3YwZae7QKGLJv3IHDvEukUel/9fux0prdFZh9Hg/UarShDl+CvmWz+44QZQ8rKUyHEyH3CX1sP+sMP4EXRw5K3Bi4vbKD7u9K8p3xcgHc4GsQKGOgaTcz3NC+2QymG+y9GZ1RzmqQTI+8I9IgRe6ShA8n7bHHDBAF4ZmSL9xCvvitlEkjL8mQY/B4Y4UdCzLQ0KQASp4IiY/91OmT8Fxz+lGuVoNYKvphqs485FWjdW4zq/ulgtvUIRHOOXXRtZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(23010399003)(10070799003)(366016)(376014)(6133799003)(18002099003)(10067099003)(22082099003)(921020)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVpWbDlZeGxEdGZvSlNIMDBVVVNBbmdCNjJROXdDMTMvMDM0Q24rYm9HeWFJ?=
 =?utf-8?B?RGRQVG5VWTRqL0R3ZXBHdGxnODhxWmlaMGNFVFVsUDVCMXFFekpHZEg3NkZY?=
 =?utf-8?B?Qjc1aXJwTlExeC9HTEdTNUhVdjBuQWltbzk0Wno2dFA3Wld6UlBReDg3akNH?=
 =?utf-8?B?bjE0T0dQSDhDNlRLbG1keFVqelFINjh5TDhXbDB6WW1USzJ3V3RhQVptb1RT?=
 =?utf-8?B?OUI0ZnVIYjFqd1Y3RGV3Y1Rtc1lNYkpSekNHK3ZjTE5NNlBoZU8wSGxRY1J4?=
 =?utf-8?B?b3YwZFFkcy9oa3FkOWozR1NhUHVpUzhubWkvNk5CVU1razAwcnFuOEJLU2c5?=
 =?utf-8?B?Sy8walRndmtrZmdMTlpWMVZUQmZkMFNqU2pOSHhRYU9BN0VwZThNV2tHUlQ3?=
 =?utf-8?B?bjNBdmh1RVB4VGttNG5NVlUxUXNVTms4WENiNXNLMDIrWWZZQ1pPVVV5U3BU?=
 =?utf-8?B?QXZTdVdnOWZadzhzQ3lVUUtZNVdIdFFPVEEwTG42blVYTys0MGZZa1F3eGJI?=
 =?utf-8?B?ZkMwVDBkVFRENnA0QlhHbi9VSzNPYUhJck5RYmQ2cThRNUF1dFVJc2EyZlVq?=
 =?utf-8?B?QUFIT1dDZ2tmekhLYVNjWEhxQUI4UjRycnBOWU9jQ0wxTHlEanBUSUN2Uy8v?=
 =?utf-8?B?NFB1VWlSa2V0RnQ4ZmUyUDRCZVpuSkVGNE1TZ3RTSnd5YXBVcVNNaTRPajlI?=
 =?utf-8?B?Z3FlbnJ6NlFUMWNmVC9yT2ZoNlY1dkZsYXJvckFBUTRDcGUyRGt5ZlN3eW1S?=
 =?utf-8?B?Z0xvMEFERWNRaUFOVlFPMi9MUlpSWnlOTVVrRkptQnIvZWNWZFhNbGNOZkQ1?=
 =?utf-8?B?anMyWXZtRjZERGFqN1hGYzNtWnpvYmFBVXo4UUczN04xb3A1a3picTU3MVVm?=
 =?utf-8?B?dXpPSmliaUtWNDh1UFF0OVRwZ3Mrd21kUlFYS3FCMXZ2cUJ6NnNieEsvdEF0?=
 =?utf-8?B?RHFSeEswclQvdWNZU2VNUisyNUR3aVRGRXpYTDZ5QnQ2T0V2ZkFSMXZScW02?=
 =?utf-8?B?dTR2eHNhN2JMa3NRejN1OUZSTmEvamNDTTFpWGJua2hJUFhIbEg3U0VxZGky?=
 =?utf-8?B?MzVxY2FGTTByL0FGUlhvZW8rVFVzNU9NaGZJci9SU0FYVGtZVlFWNGRYRG1r?=
 =?utf-8?B?M3lJMFBoTUdpQXo5UmlGZmhkT2hrSS9ZRDY4V3NzaWxoR1VXSmpNVnJ2c3pH?=
 =?utf-8?B?YUtzb2VUSEdLTHN6OWVnZU5HaWw5N1NzMVJabkpkZElma2JuZEVzUE1mSUZP?=
 =?utf-8?B?OENRS3R2d1Zhc1lXYVhCd2hLRjhSeGxXb2pPUDRORTBCNmd0V2ZCcUJtelVt?=
 =?utf-8?B?bnkzcWxlMTAzVG43YS9pRkNWbXdrNUJNNkgrZjRhVFp4aXpSV1orRGNWYWZ6?=
 =?utf-8?B?emlvMHJwNUZoZzhIbm1wUW1yTi92VnFSVmlZaUk5TkR2RXd4OWN2SnMvZWJE?=
 =?utf-8?B?MG5ISm9qQWFpbVBLdlJLNDI1cXJkWkNsalQyK0dXVGczdUVQcDhXdEtTZ1pm?=
 =?utf-8?B?U2FlZHE4NVk3RXBJRHJkNE1lbmVjN1I0ZFEyc1FzRS9rUVJ4bUZ0eHpiT29U?=
 =?utf-8?B?WUtlbFdncWpMNHYzUUhWUStqdk85QXNRekorV3FZSFBBKzBtblJqcUJpMlRN?=
 =?utf-8?B?bEdoRGdXeDh6UXlXb2YweWZSVHFnMmdLZ0I5YUFEbkp3K3M2V2syait3bVcw?=
 =?utf-8?B?cmE5azRscWwrVWxVZDF0czJ2RE1uTDFEZnpPa0xaaTZPWFk3WWRxemRmZk8w?=
 =?utf-8?B?OGpScWVHdTBOeFlnSytodG85dGVjcnZ3eVBXUW9yQ3g0c2VXdURBdjB0L1pJ?=
 =?utf-8?B?VjdVbGJkc25vQmZFaVhuZGViSExvaHB5eFh2WFhGOTVpbjJuVUovM1c5aExy?=
 =?utf-8?B?VUhnNjg1YVJWcGFkZlc4V1dVZk9CRTRXQnR3QW5qNy9QN1lmdUNlbE9hc3dY?=
 =?utf-8?B?UktxZFRteUwrMWpUYlRZWnhTQ0hlQThVZzA0ZWlRVzFlaWY4eU44S3U0Qjd4?=
 =?utf-8?B?a2NOTmg5bWZlUjdtUGlnbFYyMnlINm5Ycmo0SXBtM3FhUW9Oa2VVTUw0K3p1?=
 =?utf-8?B?eVFVdDA1N1RFaDZnT3VXU1ZoZEFvWlBwWFV3S2t2ZGYzRkVWNXMyd29VLzdv?=
 =?utf-8?B?Y2cydGsrbHV1Q09uSGdKMlp4eGFsTzZBQWc0Si9mVS9RdnBtazBVdlVod3FJ?=
 =?utf-8?B?QTArUXF5YWNWOE56Mkt4WEJhTmJkRWl0a3drbDlyWTVxaXpPVFJ1bzJPVWRQ?=
 =?utf-8?B?NE9pRXdsUlVBYnA3ZmUrSmdBbGtJS3A3T2JkWXhjMEhoSmQ0N1RTOGp1Q0ZP?=
 =?utf-8?B?U2JlSDlJMFJiaE9NQjFLbzExZCtycktzTDk5ZXc4Q1JYNkpzejNiTXB2aGcw?=
 =?utf-8?Q?SD1P5R9x5+rdezQ0aWV9XAYSv/wLbZjvzePf3XdqkYKNz?=
X-MS-Exchange-AntiSpam-MessageData-1: LbLdUcsVAjOrFQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ece3d9-a7dc-4a88-50b6-08df2b285f30
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 01:54:10.6841 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YxY41xdi/YWAC8iq/5CzhScAbQM61F/jpat6YhhZZb7uu7orLUNQiuZVfU7mD8iBUmxQUkd2mTsB3sktdvYZQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999230
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

Add `Vec::try_push_init` for fallible initializers (`impl Init<T, E>`)
and a new sum error type `TryPushInitError<I, E>` that it returns. If
allocation fails, it hands back the original initializer. A `From` impl
for `Error` lets callers decay the `TryPushInitError<I, E>` to a regular
Error if they want.

Add `Vec::push_init` which is the init-infallible version of
`try_push_init`.

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

