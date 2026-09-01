Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF8CFC61DE4
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 05:07:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5EF610E149;
	Tue,  1 Sep 2026 05:07:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="KelSDsyw";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011066.outbound.protection.outlook.com
 [40.93.194.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE6D510E149
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 05:07:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJKWfR3vWg6XaEyZgV3guzDzb7ltMqC70oIvnvkFrA15gPeH891FieUi6DrjdTt608Ja4+p8GTGi2UDXhkHtaZb4phnC3ssKKxC1UT0FSicJDrmoSEkeITM+vUgvSm9nj8BPRVimG4aRizzJOUYYP/MmViu+P4n83yxfA+jAquQ2f8S9eKLUM9pBAG7K4fW/mAxgXwuw+BYOsw36prK1NBqzjjj3ka/X69oodZeIAGJ6SLLu4eT6rnl8I8kzeCv4VyBlHs6ocK2ZmN1i0wUIU8efplm9aHFEWwkolFmjhWcP6mBv26uhpUf3UffEKPwcX6CkBa8LYOXb5yDDZzyiIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vTP35ggZQkGQbWVO+Z4auXTPWLONMiwWahTlQAru5BE=;
 b=xM7j7VM8KEj8ovs18oidi40v27uGMa+aL2E/dSObh4kktUfKdChvhCXKaPLo8U+JzqZc0F5/K84VzZVCtEnhDHE29f6Wl+06DDpQcKGiJxdZQV/4IWvKJRBJml7+cPTFI8aHppdnTOmWRcNuyuxXTjauXuMkcj960AIb1eF31JGxmD1jHyHKgKLeacWJbkDLBZglxUn+uXxKs/IivlUDZN7+n/dazPx5J/StvLo9vy3oUKIMifAo0cZaxpvOu6g1/g20TFb/d4VsRwxl2RSMczcmd8ffFH1FFW//d59PI3Kadu1Vu5uDsv8nd+9MZDY0pA4eBGXvkDggtDY1IKEN+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTP35ggZQkGQbWVO+Z4auXTPWLONMiwWahTlQAru5BE=;
 b=KelSDsywkMaVUzVKoeYhPKTy5+x9EFuQEjRS0LFLRjcvurrnHkcpBEqAlwHBbKWe1ZH8elpJ27lCvyFeBKflEzbrpPbHQ9X7Iz4+CTT+zZmoGBov8wah9sbaAcrlgnh/F0ok/5TqzkJKkv1OPJUN3/Gqny6YAvIdkauwo69whkGF+NNfGDY3PcGarwWxaTfZoPOabCbMUeg9HQL4n9VFnzGEfSJiQUh/IJbxuAdeaf2ksnS8htY3/7ih6odgoKHO3gvVdeF9abCa6J92OYWBsAXEiQi4L1ZQFk2wBKYNalHKYvtCGQMVRuL7xK2hfCmyiL6X81lFqm1jGOdBibAdug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Tue, 1 Sep 2026 05:07:00 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 05:07:00 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Subject: [PATCH v2 0/3] rust: introduce cv! macro for safe const
 conversions of integer-like types
Date: Tue, 01 Sep 2026 14:06:39 +0900
Message-Id: <20260901-cv-v2-0-446bc69d2ade@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/02OQW7DIBBFr2LNulQYsIWz6j2qLGAYkqkUOwUbN
 Yp892C7iyyf9ObNf0KmxJTh1DwhUeHM01hBfTSAVzdeSHCoDEqqXlplBRZhg6GhUxFbg1DFe6L
 If3vk+3xwXvwP4bxd/huJfpdanw8NvMskcLrdeD41SDTooXMYrDTak+yN8apDbXx0tu+VjsoPu
 oOtfuU8T+mxLy7tHnsfV1ohhbGutTJENGi/xsKB3Wd9Bud1XV/wG/kk8wAAAA==
X-Change-ID: 20260828-cv-8d4e952fc14c
To: Alexandre Courbot <acourbot@nvidia.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCPR01CA0180.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::20) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|DM6PR12MB4355:EE_
X-MS-Office365-Filtering-Correlation-Id: d4f4cd6b-976b-4b02-be57-08df07e6dad9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|7416014|23010399003|18002099003|56012099006|4133799003|3023799007|11063799006|10067099003|921020;
X-Microsoft-Antispam-Message-Info: u9QuyXoivLlqv5mk32CroQ0ozNmiPfvWMg9S7cadkDYS6ea8kiHDuK1D8qpZwgO5T9f127fH2ncDPmxayHdlWIkTjNVF/r5KHTu6/FpcMlQ6gFJctqHeOYRlw1FnkGf/pOKYSR7j3iDkgtc44NCqUBj/wGR+mCZbTQD7d9BFrMYwP+/WRKF1VxxJwysXi5NMSZoXFlKtB+fZ3rNPvM1eOqOAK7YboM1wsTfcnoyzZN+rzv/i6ul/B7ygm/QE/funtZhmkiWU/RSFv3VOXkArjLg1BJ8P6IqncvG55rqwNrGR20CqzwwxlZ6fghY+1TWr7eMWTVwGlRTzGcURv2qozD5Q3LkLGzo4HLq2mE8ElcfUS2GWM0aclzq0FzKQmMWYi2fNF5isplp4Tl1xYy6V1HkAf+FOOtuGnBULXSZulGyyRfowLEKCErr5rkfLzh0G72Q1MEPqwnQ3Y6L0efaOkYW3j58SIM1eulTRDQINX+0midNZIHz7jjUJ1/CWhjAwqvMO2peMYdAZgQX24rXmHWE68aBhS1ytaWZ36tsVE3B6mZ56cEUtDfS8GyAONUsdYOt9we544b499h1Lb91tsrlfPJOEH//8kFANNQunLFo5BkCpAgnsjscKT84RwpFx8bTy8TYHdO34J7lA/asdKBQ9dROyn1LTP3nw/NT0Yo1qO93lTGXSHsZjSFa8cGdBVDU0gZyVHg8cEc3og+3xPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014)(23010399003)(18002099003)(56012099006)(4133799003)(3023799007)(11063799006)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnJsbXhvdGxXWW9VVVdLRmQyL2VTY0xVM3F5NW1oTEhIbytwZzA3b21zbUw3?=
 =?utf-8?B?RVcxRjlKSmxsQUMveVR4YmhMbDg0dUpvMmw3K0ZHeGZKNFNSaVdPc25SRU5w?=
 =?utf-8?B?ZWgzdTZzZGxnTzhyY0wzZWRyb1ZuYVVTUEhrYlIxazNFK3lGQ3JQYzVaa291?=
 =?utf-8?B?Wjc1ZkFzWWRIQ3B3SlVVbTBWdmhCOFA0YVM4cVNHRUlNakFEYm5sa3JVcSs5?=
 =?utf-8?B?SXVKWDlSODJ2T1dBQWNaaks2Z3ByN1grcjd0YW5pVVRqVW90UmkxcjhIOFpz?=
 =?utf-8?B?WjgrS1RUdGNyQmdzQnlMMWkzYlFLR093WGwrTW1FUVNTT1hZc2luZzVWZWVS?=
 =?utf-8?B?VjFkYjFvVHA3RmdCL28yTnFlUGRlVis0TkYxQzdMOVQ2bFZWQWJwS3g0Y3cr?=
 =?utf-8?B?MFh4L01rTFdqTnBVSXBhOXQrQXVFYlB6T28vdjFYTURGYlU1N1NCQjQ2NjVD?=
 =?utf-8?B?ZTdodnFVRGdqc2tKYkc2cDU2N3l5SXVQMVFwTTY4Mit6UWhqYjE1WFY2RkR2?=
 =?utf-8?B?aGhuSVMyYmdMdGM0VVdrY2VreFRwbmJUL3o0UC9sbjJLYnFBZHVFcWg0Q1gy?=
 =?utf-8?B?UExVOVhzblIwMXZUVThmNlhIUXc1VWgybHl3MEdDdmhheGpLNjNnZEIxSFhk?=
 =?utf-8?B?WHEzNnlFWkhPYWowam16bUJybzBmWUVUNnZrdFdtVTBHOHFIdDhtMUdwQzdZ?=
 =?utf-8?B?TjNxa2R0N2tIdDlSTkcwSGxpakc3azN2T1pXNXFQeCtCOTMrN3hnM3hSQUhX?=
 =?utf-8?B?Q0tCSndKOVRDUUl0Si8rK25ic2R6dUZreUNPazAzazR3NzlRMmkrSFFtZU56?=
 =?utf-8?B?N1FZZVJndTJTT1BzNDFibFY3OWVoQ1VjWDdxS013N3dmdFhMK1BGK3E5aFJQ?=
 =?utf-8?B?c1pLL3gyNFRMMCtHc0RKWjdKeDl3R0tIUWhDdlRTcTVEM3VEYUphOWVpTlFW?=
 =?utf-8?B?ZW96SVJHajJUazdUdmlHWDNKREdIN0wzY2VYSVc3eFdqRFFJbnc5YXpTNWth?=
 =?utf-8?B?NDZOMGJPSnFwa3M0L2lZcnFmVGlxY0g1bDhLb3NwemlncmRQQnRZcTJkTjJC?=
 =?utf-8?B?ZWVFaXNFUWRxd2tFL1pacEdzUDVrbGE2S3NqazhlbWVBdFo4WU0zUjMwZ0Zy?=
 =?utf-8?B?aXlIQUExdkl1dTNDZEtrMmZKZ3VzT2FPdzArN05XS2EvTHVHVldFQW55QTdM?=
 =?utf-8?B?QTNZcnV3SWIxcFdjV3ZiNnZZeHQ0bXdaNW1QZ0R0bUYySndwWStIR3Zqd2hm?=
 =?utf-8?B?eGIyUGtvaTEyWjRwNGhIOEs1bWM4bUxHV2xCcU5UTDlGaUdyUHRRYmZGQ1c1?=
 =?utf-8?B?eWNvTU5HcnJoMng4NUtpWklEL1Z5U3N1RU5ZU2R4cTNpOEsrU0xFVnB4YUp2?=
 =?utf-8?B?dFF1R0VOTTV6MC8wbWhONGs1SWpnYk4zSFlSUWJYWFpaM0poV1g3d2swSHlw?=
 =?utf-8?B?VDNVTzFJRDlIWjdqUTlUMGUzbUZ3d0d0aTE0cHErRjZ0RTUvNUxRTlBZVVJu?=
 =?utf-8?B?SDNaM0dpZDFFWS96cloyMUhMVUVSWTR1cCtGYkczVWwrOUFpOEppQUljY0M1?=
 =?utf-8?B?aU5ORTBYYVZpUEZrRFVWanhQNHNmalNGWFdEYnhXazNmQTQzK1RLU3lnRFpw?=
 =?utf-8?B?MHpKcFFJNlE1VDZ1RXg0TDVWRWd2NzJvQlFlRnNhUHR6LzFjSXV5OTJRVzA3?=
 =?utf-8?B?cnp6cUowM3FjTTZXVHd6cUpOZXl1WDU1TDBNUFp6NHVncDg1OGlyZzBmejAr?=
 =?utf-8?B?SFBYNmVYTlY4OUh5TzlydzdXd1JqSGg0aFMvd1YvYWxjekpVVlhwVmV3MUE5?=
 =?utf-8?B?UGgveXlTazE3eTA5MVc4Q1h5endWQlJESlAwbnAvalNXQ0JhN2MzM0lwaVFW?=
 =?utf-8?B?allaSnhOMEJwNkgrSnNpQlBpWHEycW5qRVkwSWZiVkNoOE5pVU1VSTQva2VV?=
 =?utf-8?B?bCtUaFdxRjFRNVRxUGMwMCtXcFJ2N2NFUGVHSDBVS1dDZVVXM2R6Y090WFk5?=
 =?utf-8?B?ZE5xRmhsRUEveWQzbEJURlVsdFRaenN0V1lpeDdranNxSFVvZm85ckFKMzBC?=
 =?utf-8?B?VEdaRUZvdkEySUd4dWhXcEc4SUhWTVZqOGdvdTdJSkIydXU3RklxOHdZK1d0?=
 =?utf-8?B?MDY0ZEJERFhXZUtpSU9RU1JtUXdSMC9XSEhPV2MwZTlNZjFUNXpEUnhmM1ZJ?=
 =?utf-8?B?S0dyQW8vSmdsR0M1Z2tSZVloS2RhVis0VFpPdmJ4cVhXUHVOdU04YWRyanZs?=
 =?utf-8?B?UXJPc1RQNG5UU2ZoMStQVlpybWNlVjhPcGxjY3ljd2lYZTNUazQ0cjBDY3c3?=
 =?utf-8?B?Q1EwTjcwWmhENE1SOHJ0VWdPKzdhRHlHT2l2NmJ2WnozYUlVbUR2Rm1mZ0th?=
 =?utf-8?Q?A10Dg3qIYMN/PChl2PAvvX9GwE/DN4pw25tHoNaFXPPig?=
X-MS-Exchange-AntiSpam-MessageData-1: +3l1Pk8H4sKsFw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f4cd6b-976b-4b02-be57-08df07e6dad9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 05:07:00.8331 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5CzTQH0NcoBip+WcvVbRJhZbINwH8mnMa0yzFJ7kFg5+zWtXHyHmlcT8+52CJygNBgEwvc0/T+XMkfR7vMHUZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355
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

This series introduces the cv! ("const value") macro for safe compile
time conversions of integer-like types. The syntax is `cv!(literal or
expression)`, or `cv!(literal or expression => type)` when it needs some
help with type inference. The result is that many expressions can be
rewritten into a compile time safe (no `as`) and less visually busy
style, for example:

```
- const DMA_LEN: u32 = casts::usize_into_u32::<{ MEM_BLOCK_ALIGNMENT }>();
+ const DMA_LEN: u32 = cv!(MEM_BLOCK_ALIGNMENT);

- .with_const_msg_type::<{ casts::u8_as_u32(MSG_TYPE_VENDOR_PCI) }>()
+ .with_const_msg_type(cv!(MSG_TYPE_VENDOR_PCI))

- data: [[u8; GSP_PAGE_SIZE]; casts::u32_as_usize(MSGQ_NUM_PAGES)],
+ data: [[u8; GSP_PAGE_SIZE]; cv!(MSGQ_NUM_PAGES)],

-pub const NSEC_PER_SEC: i64 = bindings::NSEC_PER_SEC as i64;
+pub const NSEC_PER_SEC: i64 = cv!(bindings::NSEC_PER_SEC);

-//! let b = Bounded::<u16, 5>::new::<0x18>();
+//! let b: Bounded<u16, 5> = cv!(0x18);
```

This works by defining a trait `FromConst<const V: i128>` with an
associated constant `VALUE`. Then each implementor sets `VALUE` to a
constant expression. This works around not having const traits. An
alternative idea from Gary defined a FromLiteral::from_literal<V>
function [1]. This version essentially moves the implementation of that
function to the const block of the associated constant (since it has to
be executable at compile time anyway).

This is based on ideas from Gary Guo [1], Alice Ryhl [2], and Alexandre
Courbot [3].

One (potential) limitation is that const generic types or values can't
be used with cv!, because it requires the const generic expressions
feature. The const_as! [3] macro did not have this limitation. This is
worked around by special casing conversions to language integral types
in the cv! macro (essentially subsuming const_as!). This special casing
can be removed when const generic expressions can be used.

Some code is taken with permission from Alex's const_as! series.

The structure of this series is as follows:

1. cv! macro
2. updates to nova-core to use cv!

For a follow up series (I've already written this, but to avoid spamming
a ton while we iterate on cv!, I'd send this after):

3. updates to various other code to use cv!
4. misc updates to other code to remove usages of `as`

We have multiple ways of converting - T::from(),
FromSafeCast/IntoSafeCast, cv!, *_as_*. This series uses them in that
order of priority, based on Alex's suggestion [4].

This is based on rust-next.

[1] https://lore.kernel.org/all/DKT6WNPI2OA5.3RCBNYHHAFAD9@garyguo.net/
[2] https://lore.kernel.org/all/CAH5fLgiGcOn+HQLj4w9yDc31V54PbqNUQv8cUFRoEuFzQrAAZA@mail.gmail.com/
[3] https://lore.kernel.org/all/20260825-const_as-v1-0-1ce712225fe2@nvidia.com/
[4] https://lore.kernel.org/all/DKYTZNAX6ON6.1K1372FFAQOF7@nvidia.com/

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
Changes in v2:
- Improve error messages (Gary)
- Remove pre-req for Alex's nova-core num->kernel series.
- Link to v1: https://patch.msgid.link/20260828-cv-v1-0-48a180dfc4c8@nvidia.com

---
Eliot Courtney (3):
      rust: num: add cv! macro to create values from constant expressions
      rust: prelude: add `num::cv`
      gpu: nova-core: use cv! for constant casts

 drivers/gpu/nova-core/falcon.rs                    |   9 +-
 drivers/gpu/nova-core/fb/hal/gb100.rs              |   4 +-
 drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |   7 +-
 drivers/gpu/nova-core/fsp.rs                       |   3 +-
 drivers/gpu/nova-core/gsp/cmdq.rs                  |   6 +-
 drivers/gpu/nova-core/gsp/fw.rs                    |  38 +++---
 drivers/gpu/nova-core/gsp/fw/commands.rs           |   2 +-
 drivers/gpu/nova-core/num.rs                       |  55 +--------
 rust/kernel/num.rs                                 | 132 +++++++++++++++++++++
 rust/kernel/num/bounded.rs                         |  19 +++
 rust/kernel/prelude.rs                             |   1 +
 rust/kernel/ptr.rs                                 |  14 +++
 12 files changed, 194 insertions(+), 96 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260828-cv-8d4e952fc14c

Best regards,
--  
Eliot Courtney <ecourtney@nvidia.com>

