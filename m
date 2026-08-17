Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7654C5DF7A
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 12:59:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06EDB10E7C4;
	Mon, 17 Aug 2026 12:59:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Se9FV6SE";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011025.outbound.protection.outlook.com [52.101.62.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9010D10E7C2
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 12:59:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wYMJ1JsHAmcYbeK6EjFi58s0DN2AzO3sxDtCnzgQXHscW3bxc8qjkMJ5qjBnGXF4B7ExJeJ7SbBgm0L9ER/4+bZWO98YJns1v3Rd5ryy7eOLnD7+ylTUfnyWU8zOTAWCX2lSTdz3ND/AqeHaYr8HBRFiqgJzMxFILPs0Sy/xKm23FAvTTphoOb8yufRHywdrc3KeEv/siPZOqW5kZ/5p7Jj2HkNqGEFgBO6eyQsM/YJ8EnaI82oD6XgeLscJQvKEHnGudm86KVo/JugnjWMM/l1xRTx41su8VDdSXpgUfE0LjxFI+Ja43yXRgYh2zl5alvzJoc17J/bfgLe7poesMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOmkd5T88Bq0wU++qSGlZULAYsPUNErSajC+nEysSng=;
 b=Rjz+akV4WJ8blMOALa1jRhwAaaY7ubo2i/tWJGKatkpSMtcXvJ3Y9nJdjBpP+SvGEBun6jSOffOV4rHloMaqhj+h2JnC7rxcqHO5HDo3o36aR4jHa8MkbONVqcew4//53KfR27p0bqd9z/7w6XE7NAU46mDHKtfp/YHFOvKT/Iu4mM0f/ZLoE8d5RquIur847sIeIA57AIqMEToaxBLYNSEZtmATrwAElhRZ7x3/50JeZkA4sEmvf3f+twM4f3+h8zLWe4eiRvofyl6/cENz+KivmnBgCOpIfBvbqWTXomNb4zo9Cy6/1PQDRUdPWcsdigv6IyQY2el1ILkrqEkxNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOmkd5T88Bq0wU++qSGlZULAYsPUNErSajC+nEysSng=;
 b=Se9FV6SEJZNymnJdnYBSeVPGUkaiRIW10WqX/rSqRuIJD1B7IXQLsyXrv0NDEGM54N2phrpP60mKSnyB7Oyq99UShRbV4x0xjsRf7d5AthKTtcU4ApNorIPVaHpJ9CqHSCDMgv2ZHXhYSEn83ZiKR1C3VX37iYJS+G++zZmzSkQS5h041tZFCy4n85VB7DC+LjcpiRT3Lv/o6CkWZnCeqhYRCL0N6mPm6/JTZ41MdGcrlQe6CNiI/xhleqaWvvGZJE28bY9p2wMdZd9dsJGhSFjVh7uO1uN/vQTCXkjZO73VquBU9INytFpfFAc5K5ecQTmKd5lXEW9flnv+qUTPbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by PH7PR12MB6833.namprd12.prod.outlook.com (2603:10b6:510:1af::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Mon, 17 Aug
 2026 12:59:07 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 12:59:07 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 17 Aug 2026 21:56:36 +0900
Subject: [PATCH 1/6] rust: alloc: add Vec::push_init
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-b4-nvkv-v1-1-b84db5e84b67@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0260.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::18) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|PH7PR12MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: 25a49a6b-0959-4ef7-f4a0-08defc5f52d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|7416014|10070799003|18002099003|921020|22082099003|56012099006|10067099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: 7gKFtynk8U+69avo0EWn4bufUSTqiMLRK18W9mRRz9ZRQg3bHHSSChkMimmvdw+souPQzBryLw2vCIt3akcB+JMpzzrvyqfugNnqJlg8bVALA+Gr3cHJmB0oCBsG+42J+tFAfPbae4jJh3b6Ep+KZXXU4P0RFnDbebaPZC8QjfLEwr+XjjlJiCorrNBhg4bSPsScaT8naBT69k+ECnKZxaXRY92rpwykgsHKK25rvKIX+e/m/XroNn0IMdNQf/MCEf3WQE2h0NdveAK+29l8clCYvHfIrTrj/DVYVz73qPdWEz51butT8YEuZVBnqlRt8RbR7x7Uzt6raGrInRSgDyxT6xwkp+teWAKcJ+qwWAqgHU5nwvY2s3FN9QVCK+upgipQVFplOnVmKRZ+1WUaYWFhywQjXTHawV3h18hJWBYNXIK3LE6jToKwIvmRQr49F5FjjKxy0BCeJGWoRnFRz1roe4YxvDIRBl5HAzffRmXqB/okCEZdKAqHXJixv9PFnYQ9P9Gfwb5HlBBK0At9nfd5l9GBuejIC4mNkKsMLS87nGoLKYwjtBPFtZc6CmgFW2DwM53utpXj9W3hGzRYhwcZXWSFPq1C+05uurgPAOLucC6MOzsxyWciDIxJJWOPSJAGTBS/JBK3h7xQ0HsniQ1cor5zKeyTYtbFALRK52mYv8xyxak30Rlc7YAvJfqfqnFipP6zINdotp/fPbjuCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(7416014)(10070799003)(18002099003)(921020)(22082099003)(56012099006)(10067099003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzFrdmsxWitjTDBEaGRYWGVYaFl5U1JiYTlQUGpDL2lmOEp5MTJLNGpLbnB3?=
 =?utf-8?B?ekw5aGxyRjJMaGRVNjNKcDFUNmIvakRUK083dU1Oa0tFVjdCUFJoc1ZDWmJO?=
 =?utf-8?B?MmxsMWtCTlZWYjFxSmE1UnpiRFRlU3g0S1JhaDlQRVQxanJ0V0k4eTNCVy9P?=
 =?utf-8?B?VHdJcVVqV0ZHb2FmZW5paFg5d3hhOWVNMmpTaUYvN0IvQ3RZREMvb2xROEtn?=
 =?utf-8?B?UzJOaHBadkZPVmRlU09CSmR0WGE5OXdVZ0s5cXVSdTRIQkdwK1N4V3NRTzRD?=
 =?utf-8?B?Um9NTnA0VzkxVFdyYkk2NG9rUFBBdW5Mc3RNZUovYisrdkl0b1paYWYwVFdt?=
 =?utf-8?B?OFBvSWF0MjR0NWNIU05xcTlTTDRraUd5OUpPcHV5YWlNOEIwTnpTcHZqbjJC?=
 =?utf-8?B?UUIzWUQ4eDNRc01ocW5JWDI1WmRHYUJzY1FkaHNKQ1hqc0pJQzJmTERmS0pu?=
 =?utf-8?B?MFNFZTRHcGNySmlpa1dmYTFUZE5IZzU3VEg5b0dvZHR6cENEc2RnbzNDN2ls?=
 =?utf-8?B?MEpGSGJ5YXhySXBoUXpSNnlGcnd4bE5jenQwcW5Ydk5udFd0Nk5FN1RlWFRF?=
 =?utf-8?B?SXA4akx3MFdHSHBwL0o4UlFqZHErcDZ6RjlpUHUrWjExd1RJa2RJMUJHMzZW?=
 =?utf-8?B?S09GcHNoS2I1ZWF5TDk1QjArKzV0anlXRnhQUGtHM0VmZGljQ3JuK1JaMldG?=
 =?utf-8?B?K0NUMnlOVFdOQnRuR1g3VzhWWXNVNVFtWlN3cmFJaXNaeW5ycFh0Q1I4UFZz?=
 =?utf-8?B?U1g4VHB5bktDeEFsdG91ejEwcHRrdk54NWhSTlo1NG1oZTB3TksweTBuMFo2?=
 =?utf-8?B?UjNESVJabHVCT3hVTDY1WWN1a0tMUzg3RFJ1eWg3NnNGUXIxT1ZSWUNXNGFW?=
 =?utf-8?B?NjE1NXpza25QRTVnR0NqK0tnK2xOdHU5eDM0Z2U3K2ErWXFIU2lEdlZTMk03?=
 =?utf-8?B?YkFXN1ZKSmV3SExHN1hyQW15bUg3MGR3UU1YRGVrT2FqdWN6RDBNSEs4d0Z2?=
 =?utf-8?B?YWhWQWgrRTFPMHgrZVhiM29vUFBiazE2SCtuc29nT3hHWS9XamZuRDZpZ254?=
 =?utf-8?B?SWptb2RHMUlkSnNjRzRKcm9NQmRYSlpJUGhNNE5SdmkyRVREVWs2bjJJNnRM?=
 =?utf-8?B?aERNbE9wS2wxaWh6eC9VQ3Z0K1ZjMkJtbjJTaE1iZCtFNTY3Nmw5cUJVQzFH?=
 =?utf-8?B?VTg1RDYvNzgyeExTSk0rZ0lmQWlIbUZ0SExHcWZUanFaTVBVS21JRGxaT2Za?=
 =?utf-8?B?cmlyRE9HSzlONDMrak8zb0NTNnJxMmEya1ZlV25pdDZJaWttOFJ2UXpZRm5C?=
 =?utf-8?B?dFIyanFDR001WXRmclBXUE1JSlFCRXpaVkkyN0tHMmtyOFlRamlwYmRJT2lN?=
 =?utf-8?B?UWlTQURvVWRHV1lBekNLaFlMMVhJZWJEbmtIM2FNdG5nM2lzaTEzcC82c0lS?=
 =?utf-8?B?cU1pOUcwRTk2bTNQdE1sNFB1czkzdUt6SFN6SjlBT2pVWEt4dzd2bXZhbG5j?=
 =?utf-8?B?TWhtNG1HenF6b2lCRVJPOVg1OWVRblJaS2Z4eGdwWHdZRWdHT0dDSFMrRHRz?=
 =?utf-8?B?MytoNzQyaXFNUmc4WTFNOW5TMHZXdlR4aUlPMFBsRm54TFNva2Y1d0J5UVo5?=
 =?utf-8?B?QmE4VTJJWHNVNUFuNU1oT0NVN0xwVi8rU2daRllzcTJKM2RtcXdIV255eHN6?=
 =?utf-8?B?YXpxbCtQYm1hSTF6K0krOVovbjRjOHN2MVlwd1h4YkhnMldKYmFna0MwUXdI?=
 =?utf-8?B?U0RzZElxR1gvWjVzV1JEL1AxTG83OXNIbnQ2QXZDRWlDd2I5VEVrU28zQm9h?=
 =?utf-8?B?OHFyUTlyWDUxeVN4VXZvS1VJbnh0b1F5WDVDa1FNYnFrOFNrWVFyL2RBbHk4?=
 =?utf-8?B?Rm9GcGNzR2NLZDFkRGo5SjFOK1RhVkQ0WlBvbUh3aHRkSDZtN1M5dTJ3L1J4?=
 =?utf-8?B?bWtPNnljNTZsWkJ2bG4zTDJUTjMzSnFLd0tnMituS0JQMlJCMGJHOE95Vm8z?=
 =?utf-8?B?azdxYXRHcUEzNzg5RkFTdExnYXQ4Zi9XeFI5MTdoQ29RaXYyZ3kyZzhBSTZq?=
 =?utf-8?B?L2krbkordjQ5RFZ4aVdPc2psMXJzemV3dm51cndQYkVkcGhiQTAzQVhCMnl5?=
 =?utf-8?B?OGhxSXp0OTRLUHVpcUZGZlp1TU1hak9VWXFGVDF5NENucTNMb2RNaFREekE5?=
 =?utf-8?B?bnZIR1NHOFJJa25kdmNFalY1bEJXT0ZmQThZMDQ4NlEyOFVKYTBpcFFZUGN3?=
 =?utf-8?B?RlkycjEwVXFZdlk4alErc2NPVm8rdWVlYUswZFNtdzVPYjduRUJueGRZMGI4?=
 =?utf-8?B?VzlNUUc1bjJiZkI0ZzZ1T1VhQjVaZVJSd0pTL21JbTlEdXNyUEtaU1lEYThJ?=
 =?utf-8?Q?CnfOf4iB1gv3uJmgTly9v5Lyy1j9XCVonXDvUo96E3nTt?=
X-MS-Exchange-AntiSpam-MessageData-1: ZnrnIZShce3oOQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a49a6b-0959-4ef7-f4a0-08defc5f52d8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 12:59:07.7847 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MveHWVIytEiLPjQZUedxBORZQ+O5RfygC1vVln8GfB5QNOLildDtaJqcE6cN7d7ceiGXG7C4dfJaKpwUsxe3og==
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

Add `Vec::push_init` which initializes a new element in place. We can't
modify the existing `Vec::push` signature to take an `impl Init<T, E>`
without changing its Error type.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/alloc/kvec.rs | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index c7546b9da4fa..9f6f25d7e218 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -52,7 +52,10 @@
     }, //
 };
 
-use pin_init::Zeroable;
+use pin_init::{
+    Init,
+    Zeroable, //
+};
 
 mod errors;
 pub use self::errors::{InsertError, PushError, RemoveError};
@@ -359,6 +362,43 @@ pub fn push(&mut self, v: T, flags: Flags) -> Result<(), AllocError> {
         Ok(())
     }
 
+    /// Appends an element to the back of the [`Vec`] instance by initializing it in place.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// struct Element {
+    ///     buf: KVec<u8>,
+    /// }
+    ///
+    /// impl Element {
+    ///     fn new() -> impl Init<Self, Error> {
+    ///         try_init!(Element {
+    ///             buf: KVec::with_capacity(16, GFP_KERNEL)?,
+    ///         }? Error)
+    ///     }
+    /// }
+    ///
+    /// let mut v: KVec<Element> = KVec::new();
+    /// v.push_init(Element::new(), GFP_KERNEL)?;
+    /// assert!(v[0].buf.is_empty());
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub fn push_init<E>(&mut self, init: impl Init<T, E>, flags: Flags) -> Result<(), E>
+    where
+        E: From<AllocError>,
+    {
+        self.reserve(1, flags)?;
+        // SAFETY: The call to `reserve` was successful, so there is at least one spare slot; the
+        // pointer therefore refers to allocated, aligned memory valid for a write of one `T`.
+        unsafe { init.__init(self.spare_capacity_mut().as_mut_ptr().cast::<T>())? };
+        // SAFETY: The call to `__init` returned `Ok`, so the first spare slot now holds an
+        // initialized `T`. The new length does not exceed the capacity because `reserve` ensured
+        // the capacity is greater than the length by at least one.
+        unsafe { self.inc_len(1) };
+        Ok(())
+    }
+
     /// Appends an element to the back of the [`Vec`] instance without reallocating.
     ///
     /// Fails if the vector does not have capacity for the new element.

-- 
2.55.0

