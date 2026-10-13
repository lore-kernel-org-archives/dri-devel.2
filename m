Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC58CC6B0E
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:26:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65CCD10E77C;
	Tue, 13 Oct 2026 08:26:38 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010027.outbound.protection.outlook.com [52.101.46.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B490810F5E7;
 Tue, 13 Oct 2026 08:26:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rTIAkjcWI2RzovA3vpmaF7CwIyEK+EmucxNflmP+2NzfprzSu6O4N9Fevj8f6fNLOI+9SCbRJQL4L2CrPoK3U1sO7Vnz2N0Y6jRCbkXjj+AWPVDe/6Tb630fVWGaRsM6zwFAGIA09OnD/JGou1neNXIkd9GB83MFx1XpsVWjY9FS+kLcYE0hQFFcnm4jZ0cOL7IpJjFgquiCJJZ111sw9yYvLgZoLfBEPeNtw83VQUaeyVIS9KSPj+8AauFyS3UjyBD2ivqZOKNkvKRiF3vAjlnkYUmiwT/KYtI1rkb6I7+gS/tWcDDdKuC09Yv6qZAcLwvOm/QcFuQI1jUiulrOWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kq6VjNvj6OaD43BHViAp+QiBDCbXedPg6rYqVCjmKmY=;
 b=crfB0mZddA3VLiuNWjdvvQ2NKfEc8Wh7Mh2ca+lFAbcEfHIIN256oXFMogqWLqjYeuCbQMP0Id9Vp2cAkf6pdhEJUyXXSXQ4lkD1VJi5r5sCTjOPmpy1i7V+leByp0yyX67IKmz1gl8sRv/r1cz4lnG5DgzZhlYI6a5EGgDFI2GN/7m+FQ+eoJpbgEOSdhDbA36k9Gfqd4xYvAM+7Hp3l6uWwmy51SvEm57hYNrih5RFn3UYw1Ps41Pad2Swx6d3cjLiEq03c5vkpf2vae/oh5lgbITDrRnDRtlp/XluDeqgDMG177uNtlsFN29xe1HTViygjxFk8ZRlIJhlMzQpfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kq6VjNvj6OaD43BHViAp+QiBDCbXedPg6rYqVCjmKmY=;
 b=ErYEzhGieLHlxN8n6K85DOeBkm/SoHv5T2a9Ozs0qtyQf+PKzKEHBpkRA0FB+DE4/SvNMnQ6edV/uMKR6l2OiV5HwcZvtylpfnF7uiS2YRmNXiR3fgyj9Fg4ArmNypz9iFR+5IWn5YExFQoEKa4xSp9GyZTmP5zpnnHRATxQ0SMjb/Qvg/il9sEu2zgHuR3T/C7GLI58inn0dO3S+hZa2a0oHU0SRyBJyIfVbCuxYkdHjX8zHP1XgCaIpIiPgBiaYg1rCICR8ABR8ALNbOfrcY2T3Bd6Z8s9fw/K1Yz1hKp6Qr37Dx6pkkL1S/yt2gOCE5OZckMo6cGKXZ9W4A9YYg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 DSAPR12MB820198.namprd12.prod.outlook.com (2603:10b6:8:51d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 08:26:27 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 08:26:27 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Oct 2026 17:26:23 +0900
Message-Id: <DM3KFWEO53FR.3CYNPELLFNVIJ@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Lorenzo Stoakes"
 <ljs@kernel.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, "Uladzislau Rezki" <urezki@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v3 5/8] gpu: nova-core: add NVKV decoder
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260928-b4-nvkv-v3-0-f04504c262c2@nvidia.com>
 <20260928-b4-nvkv-v3-5-f04504c262c2@nvidia.com>
 <DLYC3REXSZIE.2LU3UFZP93SJ0@nvidia.com>
In-Reply-To: <DLYC3REXSZIE.2LU3UFZP93SJ0@nvidia.com>
X-ClientProxiedBy: TYCP301CA0082.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::20) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|DSAPR12MB820198:EE_
X-MS-Office365-Filtering-Correlation-Id: 174971c0-02f6-416f-3405-08df2903acaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|10070799003|366016|376014|1800799024|23010399003|56012099006|11063799006|4143699003|261009223027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: KGlXDLHaz6u0NMd0ZqoOWV52uEibQxyyGuGV2banGldnVc7/CtMKSdyTgKn0yfjnToVB4AMr/V6EZnDJODr6BuKn83j076ZHlHPPiRrkwR2sVpeAyryHRSUsOgmdR1EeugeVwh1i5lrFighGVwuv1ORhqIO7+lVOXpknknOJBg2R/+PJ/3An/yJsidNWClUJy4VTUtaolczhP5szN+Hbt1wfhnElvF0mgjXAk433v4RgeEhDT5yBwDnY8WWm3g4/78Scd3rDfAJNhcmnKBXuuahTuvwKdLamELf/OSE9RlVImXOcE21Ppo0WDph3p4yMn0VGcUuOpewLmZM3dLQFLvwaKRF8sK8ZR6At+y9Ht072KPQmPcr9AmHOFjP2BKxvBrSZHX/zRX4R2bdJU3V37OeAysd2CdFL8CjamvbDoirS3s1t7o3ApEHNKo4J1iNyl6S++bR1SiWZL1zaIp5alsU/F+9ofvpiR6joPXh8GA+zU/0Efp0AGMj8rNKyDYgwzFUDjV/pSXjqtNKLhrC6iXuQPkZ03yEBCdSBOjhMFAdvBkWbHoZX+F6/l5wCT/0fHVAo/R+5HvEsELH1Eefs8dyP2bsI2ZPZOrmaps8E58C4frxOmiPhYLT7KjgBVyzfXITz7ga4vdCEMfMM1Ecod2fp4OkIiFsW+1fQk1sI0B0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(10070799003)(366016)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3hPQmNEdlVPVWJVNFJBZVlaSVhkZjJaSnhyQ3Q5dHJDRkwyVVhiRWVnNkxY?=
 =?utf-8?B?Y1FVU0l3anhFU1Q2YzBKR0ZnNGZxRFhwMktqRkxDMGVDbTM2ajc3QVZxamFQ?=
 =?utf-8?B?empWc1FtU2hWdGRnU2JhMFFCY1hpeWsyNml3RlVjU2QwYXcrN01PM05sZHBZ?=
 =?utf-8?B?V1JZblVSanlNUTlPVlRDL0NWYWNSS1J6K3VzVVh2dXRaMEpiQUtKMnRYbzk2?=
 =?utf-8?B?ZXhqYWQxa0YvRHFyU0lzWFBZZ3NuQlgzOW1ZYXFlaHVJbC9wTHprcW1WUGxR?=
 =?utf-8?B?MTVMeUp6Z1pVMUkyam1CL0lJN252eUlZQmFrZ0J5ZHhhSXU4ZjRBRnBaUENu?=
 =?utf-8?B?VVFRVEhRR2VUVWdkdHlJTEhpbkNQYTl0OHRxVHozUGhGMHMzOVArRFBkbEFL?=
 =?utf-8?B?OWlsb1BwaDJ3anozNlpOc0NqN0ZOdFRMV3B5TTBWaVNxZ051VmxIT3I3YWNr?=
 =?utf-8?B?WCtCR2c5L2ltdVFQSXZjRkJHNkg5L1dOd0VYbmdvQWJhTllhYXZ2M1BXVi9F?=
 =?utf-8?B?SjhHaWdZNm5oWE9YMkhkMFBXWVJrbHlqM2l3cUNlL0xibFlFK3NWNUp1dHp0?=
 =?utf-8?B?L2xleURmQ0w2Wk1SSXg2MTE1L25Ta2xFQnFNVEE5L3BYRHZKWUZ4YWU2elh5?=
 =?utf-8?B?NmhGVS9HV1VvYklRaWZLVHZhWGxvOGgvOUJ1RTJPL2hvL3YzdG1leE9zWkh1?=
 =?utf-8?B?RWtmTzFKdXR4UDNtbDUxbDE5dm5vaVUrT0VBcHNjU1VzZzBqZE9HSWFoZ3Vm?=
 =?utf-8?B?VktoaStIRnU4cXBpQVREdGhtSmtzWWtiL0RDL25VbmtYZEwrMHBuV2xEU3VH?=
 =?utf-8?B?TXZwMldpNVAxSHpqOHhZZ0FFZ3hCOEQrb083S1RKYUJhVWZqKzN6OGJ4QWFQ?=
 =?utf-8?B?dDRIb09ySzZYN1oxeTY2Vk9OdzdzWHpZMTF1K0tOSlZoOVo3RHF2UjFOZzNU?=
 =?utf-8?B?NzdsVXlsYTk4cC9mTnpvN1h4bnZCVC9nRzQxVDY2VGlWUzhQK0JPQTBMLzAr?=
 =?utf-8?B?NzNYM0Vld1lyTzR4WC9UOENlYy9wYWpCT2dCYVdSRG5Bb3J3T215eUdkMFJ6?=
 =?utf-8?B?ZFYzL25XZXB3YnpHVVY0aFQrbDE3ZEx2SVNsZ1Q2Wit5MU5BRTVFUTRPeVJt?=
 =?utf-8?B?OGNrM2ZIRjNpWE1LN3JaV1Q2ejRidTljRUZXMUFKQ2t3QVFkQjRCclQ4VmNl?=
 =?utf-8?B?RUFQNkFPRTExSTlLdHBTTWRZMHFOQjZlM0s1ekgrOEk1QmpmeDcyUEhiRkRQ?=
 =?utf-8?B?eVN3ZnAwKzJsOFFsQkZtM2ZHVUNhMktzMlZabjlzSHcvUlpxbUxYR2VsbXlU?=
 =?utf-8?B?NmlEYW45TjZrMGJGcjdCejlEaTNNY01SdG1iOTFON3czalF3eG5tZHFrSlZl?=
 =?utf-8?B?RURqSThnQjl2aG1sUEJWTlNKSE5mZ2c2MzlVNFdiSzNjWkMzSkxRQSttOVRv?=
 =?utf-8?B?d3lLRVhaVGZ3bG1Meml5U2lFMDI1QzhJTHJicVFBVlBrWm9NZXBSSU1VRFFi?=
 =?utf-8?B?T1IyR0pXUGViTTFoYlcxWVkwRWdJWTduUlkxQ0Zyak9UcHBhYUtLdmhsUGNi?=
 =?utf-8?B?QzhDK3AvaE43RFhpV3FOc1V3R2thKzV4b0xPYkhYOTBJQzkybXQ4bVRlaVpr?=
 =?utf-8?B?NldFQkJmRzdIZmUyYTNkSFIwM3JtZmwwQUF6TDgxVXh2ejVQTUk2T2RoaXJo?=
 =?utf-8?B?NnlxZmlmcDU1MUpmMVNRU2dMTlc0c283UmtMQnpZTmF5bGQ3bVFuYlE4SXNK?=
 =?utf-8?B?aSt0T05KdS9GL3lCTFA4RVN5bnk3VTVLU0pnVWtmN1JFRDU3OHBDZmtWem1Y?=
 =?utf-8?B?bk1teVZiZmR6NHpWZkdFSzlLa3JFdTc3M2tFY2U2QmM5cUErdGR3YzZFZElP?=
 =?utf-8?B?c1lvck9EMFpwcDE0clozUVowMjA2bVFFeVp5UE8rdkV2YldUY3llSEprWk8x?=
 =?utf-8?B?WVJiVTRRcG8wSFVEc0s4MjVmTDYxeGlJNkxVOHQ4TkF6SmZkUkt5WTl6QXpM?=
 =?utf-8?B?eVh3NTFHeEdNc2p4SUF1NVZMVnYxZHpPLzBVcGNKR0ZFWUgya2JWTUZZZEM5?=
 =?utf-8?B?Qkd4TmpITncwZEpWM1lmUUVVRVRjREpPTnJrSHp1TnJtVVJKRVNuQkMrYU85?=
 =?utf-8?B?bytpUU4vOXM1ODF3VGtEaGQyOVVCRWlYQzI5QTE5UkUxNmo1SDk2a29zcmVh?=
 =?utf-8?B?VHVWbGtSeWtEc0FXczhEMmQ4bEVTS1FYbkZKRzNTVTJkdmRHazBNUVczaWRC?=
 =?utf-8?B?ZzZMeDFUR2IwZ2txWDh1Y2NNY21NZzRNQkJhVDhsSUh1d2hQdHh1cG96V2pP?=
 =?utf-8?B?WGlrYmppaU5MYmo2Ujh5cHhTZlNHTDVhNkZBS1RhSHJaRThNN1JvK1BNRXRk?=
 =?utf-8?Q?mfbE3VIBz4zK3Gww0j/BoPSBBG6w/AQw6Uii7DQO/Seng?=
X-MS-Exchange-AntiSpam-MessageData-1: o/R86gc+8dgRyQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 174971c0-02f6-416f-3405-08df2903acaf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 08:26:27.2239 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HaNM1QcoayasL10nHdJl8SnlqgXq/mVLaOSIxFrVVlMID/BAyY7L4Bt+nP+2Ufu5IXC7ptPu4IJ5B1WqxWgjBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSAPR12MB820198
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

On Wed Oct 7, 2026 at 1:51 PM JST, Alexandre Courbot wrote:
>> +#![cfg_attr(not(CONFIG_KUNIT), expect(dead_code))]
>> +
>> +use kernel::prelude::*;
>> +
>> +use crate::{
>> +    gsp::nvkv::{
>> +        Index,
>> +        KeyId,
>> +        Op,
>> +        Opcode, //
>> +    },
>> +    num, //
>> +};
>> +
>> +/// A decoded NVKV value.
>> +#[derive(Copy, Clone, Debug, PartialEq, Eq)]
>> +pub(crate) enum DecoderValue<'a> {
>> +    Scalar32(u32),
>> +    Scalar64(u64),
>> +    Array8(&'a [u8]),
>> +    Array32(&'a [u32]),
>> +    Array64(&'a [u64]),
>> +}
>> +
>> +/// Implements `TryFrom` from the given `DecoderValue` variant to the g=
iven type.
>> +///
>> +/// `TryFrom` is used by the `Schema` implementations in this file to c=
onvert from the
>> +/// `DecoderValue`s into the types to store. Provide the implementation=
s for basic types here.
>
> nit: proper doclinks for referenced types (recurring problem throughout
> the file).

Fixed (here and other locations)

>
>> +macro_rules! impl_try_from_decoder_value {
>> +    ($ty:ty, $variant:ident) =3D> {
>> +        impl<'a> TryFrom<DecoderValue<'a>> for $ty {
>> +            type Error =3D Error;
>> +
>> +            fn try_from(value: DecoderValue<'a>) -> Result<Self> {
>> +                if let DecoderValue::$variant(v) =3D value {
>> +                    Ok(v)
>> +                } else {
>> +                    Err(EINVAL)
>> +                }
>> +            }
>> +        }
>> +    };
>> +}
>> +
>> +impl_try_from_decoder_value!(u32, Scalar32);
>> +impl_try_from_decoder_value!(u64, Scalar64);
>> +impl_try_from_decoder_value!(&'a [u8], Array8);
>> +impl_try_from_decoder_value!(&'a [u32], Array32);
>> +impl_try_from_decoder_value!(&'a [u64], Array64);
>> +
>> +/// A visitor that consumes decoded NVKV and produces a `Target`.
>> +pub(crate) trait Schema {
>> +    type Target;
>> +
>> +    /// Returns an initializer that creates an empty schema in place.
>> +    ///
>> +    /// Use [`KBox::init`] for the heap or `stack_pin_init!` for the st=
ack (if sure that the value
>> +    /// is small enough to fit).
>> +    fn init() -> impl Init<Self>
>> +    where
>> +        Self: Sized;
>> +
>> +    /// Returns an initializer that makes the decoded `Target`.
>> +    ///
>> +    /// After the returned initializer runs, the schema should be empty=
 again.
>> +    fn finish(&mut self) -> impl Init<Self::Target, Error> + '_;
>> +}
>> +
>> +/// A visitor that consumes decoded NVKV from a stream.
>
> Note that `Schema` is also defined as a "visitor that consumes decoded
> NVKV", which makes things a bit confusing. I guess that's because both
> traits implement different aspects of what a typical visitor does, but
> clarifying their relationship (and the reason for splitting) would be
> helpful.

Right, in order to avoid noisy types when you use a Schema type in a
struct, I split the trait here. So for Schemas that don't need it, you
can avoid having to put a lifetime on the struct that you plumb to the
scehma. Otherwise you'd be writing struct SomeSchema<'stream>
every time.

Let me add that info.

>
>> +///
>> +/// A schema that doesn't need to borrow data from the stream can imple=
ment this for all `'data`
>> +/// lifetimes, avoiding having to carry the lifetime parameter. A schem=
a that borrows from the
>> +/// stream directly should implements it for its own lifetime only.
>> +pub(crate) trait Visit<'data> {
>
> Should this be named `Visitor` instead of `Visit`? Trait names should be
> nouns rather than verbs, and this would make the `Decoder::visit`
> method's prototype read more clearly imho. If you intended to use
> `Visit` as a noun, I don't think that works either since the `visit`
> method is potentially called many times (so it is not a single visit).

According to [1], traits should preferably be named as verbs, and it in
particular calls out the case where there's one fn in the trait:

```
This RFC proposes to amend the convention to further say: if there
is a single method that is the dominant functionality of the trait,
consider using the same name for the trait itself.
```

That said in the kernel there are more noun/noun phrase traits. So no
worries to rename it to Visitor. But I wouldn't say trait names should
be nouns as a rule, it seems that the prescriptive answer is to prefer
the opposite.

[1]: https://rust-lang.github.io/rfcs/0344-conventions-galore.html#trait-na=
ming

>
>> +    /// Visits one decoded pair. Returns `Ok(true)` if the schema consu=
med it.
>> +    fn visit(&mut self, key: KeyId, index: Index, value: DecoderValue<'=
data>) -> Result<bool>;
>> +}
>> +
>> +/// A read position in an NVKV stream.
>> +struct Cursor<'a> {
>> +    data: &'a [u64],
>> +}
>> +
>> +impl<'a> Cursor<'a> {
>> +    /// Creates a cursor at the start of `data`.
>> +    fn new(data: &'a [u64]) -> Self {
>> +        Self { data }
>> +    }
>> +
>> +    /// Returns `true` if no `u64` values remain.
>> +    fn is_empty(&self) -> bool {
>> +        self.data.is_empty()
>> +    }
>> +
>> +    /// Takes the next `u64`.
>> +    fn take_u64(&mut self) -> Result<u64> {
>> +        // PANIC: `take_u64s(1)` returns exactly one element on success=
.
>> +        Ok(self.take_u64s(1)?[0])
>> +    }
>> +
>> +    /// Takes `count` bytes. If `count` is not a multiple of 8 (`u64` s=
ize), bytes are discarded up
>> +    /// to the next multiple.
>> +    fn take_u8s(&mut self, count: usize) -> Result<&'a [u8]> {
>> +        let values =3D self.take_u64s(count.div_ceil(8))?;
>
> s/8/size_of::<u64>()
>
>> +        values.as_bytes().get(..count).ok_or(EINVAL)
>> +    }
>> +
>> +    /// Takes `count` 32-bit values. If `count` is not a multiple of 2 =
(`u64` size), bytes are
>> +    /// discarded up to the next multiple.
>> +    fn take_u32s(&mut self, count: usize) -> Result<&'a [u32]> {
>> +        let values =3D self.take_u64s(count.div_ceil(2))?;
>
> ... and maybe `size_of::<u64>() / size_of::<u32>()` here?

Done

[...] (applied review comments)
>> +    // Tests that basic decoding into a manually implemented `Schema` w=
orks correctly.
>> +    #[test]
>> +    fn decode_raw_schema() -> Result {
>> +        // Decodes an IMM32 pair and a SEQ64 pair (the encoder emits a =
u64 as a single-element
>> +        // SEQ64) with a hand written `Schema`. Keys and value constant=
s chosen to distinguish e.g.
>> +        // saving the wrong value to the wrong location.
>> +        const SCALAR32_KEY: KeyId =3D 0x1001;
>> +        const SCALAR64_KEY: KeyId =3D 0x1002;
>> +        const UNKNOWN_KEY: KeyId =3D 0x2001;
>> +
>> +        const SCALAR32_VALUE: u32 =3D 0x1111_2222;
>> +        const SCALAR64_VALUE: u64 =3D 0x3333_4444_5555_6666;
>> +
>> +        // The output type of the hand written `Schema`. In this case, =
we can have it also implement
>> +        // `Schema` on itself rather than having a separate carrier typ=
e, since the `Schema`
>> +        // implementation is completely stateless.
>> +        #[derive(Default)]
>> +        struct RawSchema {
>> +            scalar32: u32,
>> +            scalar64: u64,
>> +        }
>> +
>> +        impl Schema for RawSchema {
>> +            type Target =3D Self;
>> +
>> +            fn init() -> impl Init<Self> {
>> +                Self::default()
>> +            }
>> +
>> +            fn finish(&mut self) -> impl Init<Self::Target, Error> + '_=
 {
>> +                Ok(core::mem::take(self))
>> +            }
>> +        }
>> +
>> +        impl<'d> Visit<'d> for RawSchema {
>> +            fn visit(&mut self, key: KeyId, index: Index, value: Decode=
rValue<'d>) -> Result<bool> {
>> +                if index !=3D Index::new::<0>() {
>> +                    return Err(EINVAL);
>> +                }
>> +                match key {
>> +                    SCALAR32_KEY =3D> self.scalar32 =3D value.try_into(=
)?,
>> +                    SCALAR64_KEY =3D> self.scalar64 =3D value.try_into(=
)?,
>> +                    _ =3D> return Ok(false),
>> +                }
>> +                Ok(true)
>> +            }
>> +        }
>> +
>> +        let mut encoder =3D Encoder::new();
>> +        encoder.encode_u32(SCALAR32_KEY, Index::new::<0>(), SCALAR32_VA=
LUE)?;
>> +        encoder.encode_u64(SCALAR64_KEY, Index::new::<0>(), SCALAR64_VA=
LUE)?;
>> +        let serialized =3D encoder.finish();
>> +
>> +        let decoder =3D Decoder::new(&serialized, UnknownKeyPolicy::Err=
or);
>> +        let mut schema =3D KBox::init(RawSchema::init(), GFP_KERNEL)?;
>> +        let decoded =3D KBox::try_init(decoder.decode(&mut *schema)?, G=
FP_KERNEL)?;
>> +
>> +        assert_eq!(decoded.scalar32, SCALAR32_VALUE);
>> +        assert_eq!(decoded.scalar64, SCALAR64_VALUE);
>
> Nice test!

thanks~~

>
>> +
>> +        // An unknown key should fail with under `UnknownKeyPolicy::Err=
or` and be skipped under
>> +        // `UnknownKeyPolicy::Ignore`.
>> +        let mut encoder =3D Encoder::new();
>> +        encoder.encode_u32(UNKNOWN_KEY, Index::new::<0>(), 1)?;
>> +
>> +        let serialized =3D encoder.finish();
>> +        let decoder =3D Decoder::new(&serialized, UnknownKeyPolicy::Err=
or);
>> +        let mut schema =3D KBox::init(RawSchema::init(), GFP_KERNEL)?;
>> +        assert!(decoder.decode(&mut *schema).is_err());
>> +
>> +        let decoder =3D Decoder::new(&serialized, UnknownKeyPolicy::Ign=
ore);
>> +        let mut schema =3D KBox::init(RawSchema::init(), GFP_KERNEL)?;
>> +        let decoded =3D KBox::try_init(decoder.decode(&mut *schema)?, G=
FP_KERNEL)?;
>> +        assert_eq!(decoded.scalar32, 0);
>
> ... this part looks like it should be its own test though. That's
> trivial to achieve if you declare `RawSchema` at the module-level
> instead of inside the method.
>
> (also nit: let's assert `scalar64` as well, or none of the values at all
> - I'd lean towards none since that part is already covered by the
>   regular decoding test).

Done

>
>> +
>> +        Ok(())
>> +    }
>> +
>> +    /// Records each visit as (key, index, value), for tests on hand-bu=
ilt streams.
>
> nit: `(key, index, value)`
>
>> +    #[derive(Default)]
>> +    struct Recorder<'d> {
>> +        visits: KVVec<(KeyId, u64, DecoderValue<'d>)>,
>> +    }
>> +
>> +    impl<'d> Schema for Recorder<'d> {
>> +        type Target =3D KVVec<(KeyId, u64, DecoderValue<'d>)>;
>> +
>> +        fn init() -> impl Init<Self> {
>> +            Self::default()
>> +        }
>> +
>> +        fn finish(&mut self) -> impl Init<Self::Target, Error> + '_ {
>> +            Ok(core::mem::take(&mut self.visits))
>> +        }
>> +    }
>> +
>> +    impl<'d> Visit<'d> for Recorder<'d> {
>> +        fn visit(&mut self, key: KeyId, index: Index, value: DecoderVal=
ue<'d>) -> Result<bool> {
>> +            self.visits.push((key, index.get(), value), GFP_KERNEL)?;
>> +            Ok(true)
>> +        }
>> +    }
>> +
>> +    // Tests the decoder on hand-built `u64` values that the encoder do=
es not produce: SEQ32,
>> +    // multi-value SEQ64, zero counts, a non-zero index and padded arra=
ys.
>> +    #[test]
>> +    fn decode_raw_u64s() -> Result {
>> +        const SEQ32_KEY: KeyId =3D 0x2000;
>> +        const SEQ64_KEY: KeyId =3D 0x2010;
>> +        const EMPTY_SEQ64_KEY: KeyId =3D 0x2020;
>> +        const EMPTY_SEQ32_KEY: KeyId =3D 0x2021;
>> +        const EMPTY_ARRAY8_KEY: KeyId =3D 0x2030;
>> +        const EMPTY_ARRAY32_KEY: KeyId =3D 0x2031;
>> +        const EMPTY_ARRAY64_KEY: KeyId =3D 0x2032;
>> +        const ARRAY8_KEY: KeyId =3D 0x2040;
>> +        const ARRAY32_KEY: KeyId =3D 0x2041;
>> +
>> +        let index3 =3D Index::new::<3>();
>
> nit: variable only used once, can be created inline.

Done

>
> I really like how testing coverage has improved in this revision!

thanks for your suggestion~!
