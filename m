Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 610C0C88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:53:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A79610E669;
	Thu, 17 Sep 2026 08:53:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="bkQk1TmN";
	dkim-atps=neutral
Received: from LO3P265CU004.outbound.protection.outlook.com
 (mail-uksouthazon11020103.outbound.protection.outlook.com [52.101.196.103])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BCF710E669
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 08:53:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fIzjw+pm7nk14lTF5PRwIek1LQ/uw91g47y88fJsg3vbngIx+WDq3OAcr1aw3xSVQV82LlVWVfid9Wfjj1fAvWln+P0yw+cgmxsjH7CvQQk5Db94G8gcfUF5l7CGeoddgzzwaWfb+qed6dixTUsAPx/+aoZljZxh72hykzUnCQhYLTyH2fmml8mDtm8gFKfCzg50mu4Gbp/hVMRBEnQC3qmkAaXKVvOxMv9LdD7rVBBtsHBma67bVcpRlAxFh5gNI50WMSZ/DeDq8pheZCxRA0TJ0VYHPOoYq+DPMV4vMkGX9QgylpPED5JNgacuMY8A/v2c6qNl+SkKfNkXWOl8Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/rHM1U2ducQ6DLsbSclwkd+1NB4ihu+3YqYvg+fxps=;
 b=mz5ZdOArmfWS88yVXG16AcVw11Rr+VCKGHvVunJmsbdXUwm0LvhH+CwKleAHFXEuGFmXhQFsafLhuamLhpwfE7WvkMPeLQkjeA9Owr1xxIhXka5F0RTt0WHJ8VV2QDoskOsloEmr9m2S2Z3Lld1n4cQkmFQK6uxUNq8LKcVJgzIZO04wTYOiYXKr//zc3PL+zyA/8eY5SI1qoBc4j8B3N+ymwPvxvsBmWmCnnbZGbxkauOuRLcg39udTYVD1alaE5XVwC/MJ3CVwIfJEbajB/Hf5KL1LZTX/9G9tajVxglzE5+Ov6ScTgdzqksKQMD6/UefziCIMC2ef4AX1V22gbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/rHM1U2ducQ6DLsbSclwkd+1NB4ihu+3YqYvg+fxps=;
 b=bkQk1TmNN8mvOLZ9ZB6g1wKOjJBGf0M3S9iXgqjkgqXKbGspi5ordTs9675JcQdX0uvHHzcQtn1kJcvmxBbP2U8yz3w9oMltLTlcHHWBe0dwKCw7cGWBufDTrYTVgiEDBmsarUQgug6rC2lJc5KdDum6X43NQhrYWuqcYWv1aL4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b4::24)
 by CW1P265MB7457.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:215::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.13; Thu, 17 Sep
 2026 08:53:45 +0000
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a]) by LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a%4]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 08:53:45 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 09:53:42 +0100
Message-Id: <DLHGQN9VQ3TE.JYI851RVF7VD@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
Cc: "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v3 1/3] rust: num: add cv! macro to create values from
 constant expressions
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.22.0
References: <20260902-cv-v3-0-0f90659e711d@nvidia.com>
 <20260902-cv-v3-1-0f90659e711d@nvidia.com>
 <DLFPWSS3LZSN.12G96EM0FI18C@nvidia.com>
In-Reply-To: <DLFPWSS3LZSN.12G96EM0FI18C@nvidia.com>
X-ClientProxiedBy: MA3P292CA0019.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:47::9) To LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4b4::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOZP265MB8551:EE_|CW1P265MB7457:EE_
X-MS-Office365-Filtering-Correlation-Id: 136c17ba-7920-4c9f-bb05-08df14992e72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|23010399003|22082099003|18002099003|56012099006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info: oqqQCde9NOxMf443awVPKughnq9OMY2p76fx39DprH2fgriCoSc40bM9GIrSGIFJl9xRynUFTQza4j5+WplP4aUwaKg0LyOKp+FiJ1SeAMrkz7Xzr16NK1UVBal15dMX4X0Z2kmbjM+0qtaLTHiEVOMdnJLj311M0M9puy7adxMfTiywBX+z6CbXls3G3me2nUo5zRsDDbGD/z0ZHqW5NSIq5VoZ2LlLiK5WfNI2pD7HRNaskUaNWFmV1NUdzDHEwbRTDYHoHz8cVeJjxN+7YdZcnw4Ni1H2iS+2Xf6Tzz6pWsdOAhSVB/C85pfzAiExVf5/S5hisAXCXpos+8yMAyxW+MV3kxp3EEQ3X1jsMzFodN6i+ILeKlxsFeS9C1rW8gf9ZyS5X4KBRD44uVHCgYBiOXu8rMU/koCuHkCA1/OyyVG7CzyNZ5CNoxQE0vA+wRcG2qU4eRr2FerOFgYnCKwOC5Sb/J+KT2h6DG+vrl8i60HqilG7Bwocp/j7GElnVT9OiyQ3svpPcCeu11j/DmGESlDRDmrz+Mkt7+7FxwCv0siaiHGwh9lp4fLd++s4i1lyzemNu34QN6rkogKCFPmJSorZFz0if/btFAKsnly3gzkuBx/7N8flLlcz+EliZmZKSvO8fJ2N1RV7awAamRI8LLgGVqYng4WJZL4pYXo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(10067099003)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWhReGpWS2E0cjltS1VxNEpQeWtnZkxQczBGaURpQXMrWWpjV21oU2htU0J0?=
 =?utf-8?B?QkJiR2xQMS9vaU85d0Y1SjNrdndkWDBZSW8zWkxTWlBuN21XdzhPdExnbGtW?=
 =?utf-8?B?dkpmMkRPdWhiNFliWVJDaXpIblJqNHZ1TFFPc3hTK3NNWWRYMWNQakd3d0hN?=
 =?utf-8?B?WVI2N05menk0dnFOMVJxdHVteWNjWS8zRkl3bkZtYUhZUzlZUW9OMDNUNmJ0?=
 =?utf-8?B?bVNob2NhN0d1ejR5bFRYT0FIekNoVDhHMGthWGc3SjBOcUFCTTE4aG1oeitX?=
 =?utf-8?B?UlF3dS85WTNlRjNIUUQwNkxzcGwzZVE3M0tDTHk4MUtQMlZMaFl6dmVOR1BO?=
 =?utf-8?B?Szc5Ym9lNzUzMW1uR085UC9NOTByZ09FbTYxUW1XVzNLb2RoRWkwSEF4dFY3?=
 =?utf-8?B?ZTVoVHh4VHZ5c2xjTitwdHVONkpFdG9rKzk2Q3JDcEp5WjA1Mk5IQzhMdmRz?=
 =?utf-8?B?SW9TcXNuRGt0Uk1GNTZrSHhIdXVIVmxadGdQbEozVG1OTUpSWEZJelp5OFNv?=
 =?utf-8?B?aGllTVZWL0MvT2lWREZNRk9SZnA4ZEx0RGVmcURqazBRMzZSN3pIWEtLK2tH?=
 =?utf-8?B?OHZQd0lFQjV2QzUrelBNK3lUemtvQnJKVW9VYlovQjV4NXZhazc1RnM4SW9T?=
 =?utf-8?B?bDZRdWdtU2NSbFgvc04vaG1NMTYzajNMQkpoT3lyVW9PUHcwSm03S2F6TEJG?=
 =?utf-8?B?azdsTSsxeWp6K0gvVVJIejBlWk1iVndXUlhmTzJZOGlXaHhTeXpnZGRpUm1u?=
 =?utf-8?B?RXJSUWREMlg0S0lhS2dFR1EwR1lCaHB0Y09zODJubFhRUnZBZk1OdW9SaWJh?=
 =?utf-8?B?a0R3WERvbzFEY3VmczF5Nk9MWlBJVVNxZ1VkT0FIVmltTVlNVWtMRlZyaDUz?=
 =?utf-8?B?SE5qZ1g0dEFGdGZBK0ZWcTQvNk01dCtUUEZ5RGYrRWRyaVJKbWhyak9TSjBa?=
 =?utf-8?B?NGlFcWdQZDBDQkRTL2lXd0wwNHZJdGRxRTBFcWRlUU5ZM3paUzQySitXcHVG?=
 =?utf-8?B?VnNuWlRlV2tmb1cwcFNlWjljdVMzdUF2R2x6ZXMybU5IRVJkMDdvZWhuMWVo?=
 =?utf-8?B?YzhPZHp4QlVWUnI0TkNpVEdhS2p2WHZpdFlwVEpta1AvS3NVdEJ6UnVxSUEw?=
 =?utf-8?B?blVudmZwWGZGVGg0RUE3dEVUc0N2azI2Y2V1MTRFVmhXeHNrN0VrcHBSMWpV?=
 =?utf-8?B?UnBrWE5ONFc3RVRGQUxzK0VNQXp6OGVWOC9XdlQ1WDBPUDFNMUJRZjZuSjNr?=
 =?utf-8?B?QWwvSTR1NC9CVG84S2JKdUZtbnBGVkxyc3RjbDRaRkIrUjNKNVBDYlMyQ1E2?=
 =?utf-8?B?czVzblJwdlFUYUw3dm80ZmdnN01ueEFVcGpReE9OTU5ISXl3Y0ErU082bFFu?=
 =?utf-8?B?VXpsNEFMeXpHR3dib0I3aFAvTm1pU011SmFYcUF3UzRXM0owVm81OEFqeVVw?=
 =?utf-8?B?V09wMGw5eWdBTFY2TTYwYjdhRkFjV3IxYmhTSWpPZXgrQVBhMlFsU0JCK2hn?=
 =?utf-8?B?NVhEMEUrVXdncEN2WlZrVnlOcTA4LzlGcDc1Y0R6TUE3QWJ4WW1RZWdtbm1L?=
 =?utf-8?B?cnltM216Y1MvSmNjVTAzRDJrR3N6NEdMZTNBTi9QRXF5Y3crR0dhZGVVSHZz?=
 =?utf-8?B?a2MzcXEzZ2JTT3RIaDZPWmRpSE8rQnI1cFVtT2haelFjdkVGVFZ6NkhrbmlD?=
 =?utf-8?B?R3JkZVhkOWFsY1VWLzc4K0pIamQvY2xvSEZaQ0N3VTZYMHMrc2VXSWR5dzdq?=
 =?utf-8?B?dTg5L0xkbjl5SGZzeXRJVFRyQ2FiQ3d3VzhWcURWWDI4eURUTmw1aElVbGJD?=
 =?utf-8?B?cXRpZlN0YlJ5UmxOMzlEVUlwcThVMEpmeWNjTmpxQXN6T1dCcXo5QU5RWDZL?=
 =?utf-8?B?VXIyR1E2ZTdhUDdxSGtSTmN1dlBBUnlLVlhtOGRVL2xhTzdvNE1uRnlSUDd2?=
 =?utf-8?B?dmtucngzK1VRNHV5NDVnTU16a0h0MEdLSVFwb051YlY0VGl3V21kMlhObTlv?=
 =?utf-8?B?ckdKWnpUdUtoaFpQVjV4WDh5NGZZY0dtTVF0TlNWQnJsS1RXTkMrcHlwZjBB?=
 =?utf-8?B?RkJXYjRqK3FsWk9BbjFBdEVObW5iemhGNTE2YWpFaDBRU0p6Q201b2RLbERX?=
 =?utf-8?B?bng1aDJZKzFFbEFmVktPUHp1UTBCUlZkR3FkUzkzUXpJK3JtMERWOUc4Uys4?=
 =?utf-8?B?bjRvUzZYQ3ZiLzVWY3hJL285aEU4Zklwa0pxV1ZVb3phUnQ2SS9JRTQvUitO?=
 =?utf-8?B?SjNBU0FyUUdKQ1o4TWtNL3FkdjBZUFRZRmNSeVVyYlFmVTB4d2tVTXRCUm92?=
 =?utf-8?B?N3R3OVN2VnFwSkV1YWM1anJOUE11SzJFL0tYM2kzR2pvdlIzdEQrZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 136c17ba-7920-4c9f-bb05-08df14992e72
X-MS-Exchange-CrossTenant-AuthSource: LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 08:53:45.3160 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sQUvDBBtMp/gxW9dzUEzeuDyr1uvnIU3F+rigUNkHADOntKIGKQTL3H6Whh1sAG1qtpiF2na9e7KnstW6VzpWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB7457
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

On Tue Sep 15, 2026 at 8:39 AM BST, Alexandre Courbot wrote:
> On Wed Sep 2, 2026 at 6:16 PM JST, Eliot Courtney wrote:
>> Currently, using NonZero/Bounded constants is quite verbose. It's
>> unfortunate because it disincentivizes using it in interface boundaries.
>> Introduce a macro to make it nicer to use. The macro `cv!` (for constant
>> value) takes a const integer expression and widens it to i128 (at build
>> time only) before passing it as a const generic value to a new trait
>> `FromConst`. The value is then converted and appears in the
>> associated constant `FromConst::VALUE`. The trait is implemented by
>> NonZero, Bounded, and Alignment and lets values of each be constructed
>> from constants without a verbose turbofish syntax.
>> For example, `const { NonZero::new(1).unwrap() }` can be written as
>> `cv!(1)`.
>>
>> Suggested-by: Gary Guo <gary@garyguo.net>
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>
> I don't think we have any user but nova-core at the moment, and it
> benefits from this in several series (patch 3 here, but also ID pool and
> later r000). Miguel, is this ok if we take it (i.e. the next revision)
> through drm-rust-next?

How about a topic tag shared between Rust and drm-rust-next? We could also
remove the old num casts API as part of topic tag and fix all existing user=
s as
part of merge.

Best,
Gary

