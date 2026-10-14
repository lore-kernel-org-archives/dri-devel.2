Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC56CC6B1D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 14:01:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F19C112074;
	Wed, 14 Oct 2026 14:01:08 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012006.outbound.protection.outlook.com [40.107.209.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E655C10FEFF;
 Wed, 14 Oct 2026 14:01:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lTyBP530F1hIdPrLYNu5OR5O4rqWkYjSsZauokn8/tLRqreQpXmjMsf0isqOIY20/8IMmfZGexK5bQyI3Pynwlt/8aJSHPwix8cdP0PmpDqm/DQsL/Rf9xqs8jUX/EOtvJ+d8HWPsqyUlSNNzqv/xsXxxL+Kazc1jbsbp5plLpQExa6mD8plraWLflex7386zucecreHo04PhBzGHtRdFZXNeryzGmL19NHlDBEiVmlYjxV2YKVlKpSzs9WufKR0SZUlmsW5u7V1wqCncY5W3vuLLanC9SqYDM5dUe5gM2UGPM1IbAJEADDGIaFlJPDxrwkK7ZJVqMLm0eMDNO+x1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVjCoEJVm+SyNig2MYtHGuozzTwHbNcJ+Sy23lOSdn8=;
 b=PjN8yPKC4pm3tc7BqgLb0MMX6mpxqroj14ithzgxmof5uM+LRf7XpKNfQbP0kjYW78unJJ80v4pCdtBpSM3PGAwcB7DpGcQAYYD1sG7jJqbEqlw2c9lvnxfs2tkJ+aPhZQC0R5nYRmOslLD/h0nHQYKg1pkRvmUm9nH32Zw+Mo2s0A0MIIaY0nthdqDnlYPc4awJLUnrgXKJPtGOAX4+Z785dKgU1axKtKwEtZF5GQye0shYucsY7b+fsX7iw3rwO9YsiGz24PdsPLvFmI7KzE9PA+gdeQTj+0Tq1CJOGZU8kF2BgLooAJh0MyOUKyKSmUlVbnOo+qXCs8t7Uwp44Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVjCoEJVm+SyNig2MYtHGuozzTwHbNcJ+Sy23lOSdn8=;
 b=tbCpZJqi8XxZUmFfyF/XjpDAe1CeHbE+x0C+auuv+D2vnKzmq322DsCTogRoHuc4GtgWR6V9l80z2T5AzrlzBCMIzq/gz/3YpK4Wd1FXzvRwDHWEmLaxU7lXHI517gr7+CwFQ/KuWI8OFvTipilj/9/OvBQaZu2SJ+KR/dSq8tZMRHmjz9JHII0MWeWt23lXaiGF9jDgdL3MgydeA9u2qoYDoBfNUEnpvl7GMyKNWh8vRUBgMFcKckIxbeyrqRjYogQRNW18cWC377TEwe32KfdmG6C1xgyXSgDivgnGp0zGfI/90q9Fds9vzTJ2RluIMgmfytMTtZD8oomj2HE+eA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by PH7PR12MB9104.namprd12.prod.outlook.com (2603:10b6:510:2f3::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 14:00:49 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0522.011; Wed, 14 Oct 2026
 14:00:49 +0000
Content-Type: text/plain; charset=UTF-8
Date: Wed, 14 Oct 2026 23:00:45 +0900
Message-Id: <DM4M6GDGDZDS.29HQ221LYS6QK@nvidia.com>
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
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260928-b4-nvkv-v3-0-f04504c262c2@nvidia.com>
 <20260928-b4-nvkv-v3-5-f04504c262c2@nvidia.com>
 <DLYC3REXSZIE.2LU3UFZP93SJ0@nvidia.com>
 <DM3KFWEO53FR.3CYNPELLFNVIJ@nvidia.com>
In-Reply-To: <DM3KFWEO53FR.3CYNPELLFNVIJ@nvidia.com>
X-ClientProxiedBy: TY4P301CA0113.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37e::13) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|PH7PR12MB9104:EE_
X-MS-Office365-Filtering-Correlation-Id: d80d6f21-1bcf-4596-8308-08df29fb8ccc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|1800799024|366016|7416014|376014|10067099003|18002099003|22082099003|3023799007|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: A1zmOXbQAK0d/EzjYV99r+9T5BhphSgxGTf9f3jr6tSiPauSodHRY/lvNJPd7DcUScN6twDfF4HUBmVRFAM/3275uLx09GzSDo/DmP1MEijER4WuwWd0MITJtCuvpa6NHv9hxEoy1cZM1nK3NUJL7NzfaoAbfGYmRKe0DOW3QQmrrHqG/ki5k918vRsyimYLtAfafGTzWVnoAhG3Bak7Cc4uVyeIkrfih12mn32y1KOoNsG9B2fNV+256mmxRDUFq9ZEH1GsANMBxMQt+9HU07Sh3AMPHHUEm/fLeRFvAHPsDoigIyNKDTEVAhXdUbu9lY0ApmteOrFhiidsshO/fvEi2u9EbK7JU3h+Z9A0kLP4ngtT4S5x7Nsz4e9IIHnSitVUAj5LVb3Ktcnr3d1qE3lE5apbPi2viu/erLQ503SQbl5nexw3fIq7PKtat0UmvsfSKsHIjL/1OGEpthOu6v1T7asotxBIlwSBnEvT34OpJjcaolupNg7PSJDG98VHLZd+wSmLRRa77ET/idc/EowU/slrid8gqJTUZPQfafHlSmnm0BoZD+CPuJ1YTqp/7BJOPkGh6L+3uaM98hbMDceqwRJNfhwb1FAdXbCoeBQbWVLBNyjRXEUtooPRqkhGRuj83mMUsG5e4hSu4rpTaOSWQ73SMWbFBM3SsRLUdw8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(1800799024)(366016)(7416014)(376014)(10067099003)(18002099003)(22082099003)(3023799007)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmwyZXpqeDV6UC9PZE01U2NGcklyOEcxUisrdXVwNjZPeEs2d3pGOG84emp6?=
 =?utf-8?B?aDlRTDNHVlpDQm80OStpc2xpWmloS3A2NVlFenlXcmY1UDdFUnZWTEtZWmx3?=
 =?utf-8?B?VTRaU2w4cUhaV2JlZmVPYUNmTXdZbUdzOVE5dEJTY0hON3NCM3kvSmhXVkNI?=
 =?utf-8?B?aFQxcGg2dW9LTE55L1hWaURMbUVIMDRrZjQ4b0ZHdjEyektIRlA2ck1iVjdi?=
 =?utf-8?B?YW1Ga3lvQkVQNEtBQldrcG1JS1htWUlMMzBVUXM1NFdia0dsZDZObWxGaGZT?=
 =?utf-8?B?aVBJZlBaV2V3NkRjQS9vRE5OSWVybDRZVjdhY2UxclV4NDBKSVpDZHBjdlk2?=
 =?utf-8?B?OGRSeDQ0TjdPVHpwNHNlMGttSW1CMzNLeWNFL2dvSTFseWZrMWpHQVg3a2JR?=
 =?utf-8?B?a0RndnFXZDM2Uk5DWVloRXQwZFEzOWhyV3Q3aitPSC8zS1MvcjdKd1AyRlBk?=
 =?utf-8?B?TWVCK0Z1bkl2TEdVQWhrVm9URENvTXZXMXRGeXltS05zT1hzclVOSHBDakF0?=
 =?utf-8?B?Q1lWV2M1WVFmbEh6dk9jS3d5TWp5S3hNSlc1cTduVHh3djFsaEE0SzFEV3ov?=
 =?utf-8?B?QXhvWm5ZWHhGM011NU9pSkhtV2pQNXY3L3dvMjF1b1NwSVY3VU9JbXFhSjFX?=
 =?utf-8?B?aTVtM3NxNEhvOXVuL1M4dTExNG9NTHUxWnh1M2dYVUVpSXRLbDlGU2dvS1JP?=
 =?utf-8?B?Tmsrc3BCRENVaGhrdkcwdnVRdWYwakNnVnA1QlNpRGxzMkVVVTZSN0NmVFY2?=
 =?utf-8?B?UitOS1pkc21jdmFPZDVGaURiaVJ6YitZemJCay9OUWl4dGpTb3czMHRldzFT?=
 =?utf-8?B?VTVCUE44RjE0QUtNdFgwOXduN1UvWjdOODhWdHNDenZUd1FTNk9TOUxMOHRl?=
 =?utf-8?B?dThNV282SGdUMElIWVJpZHhTVXVJZVZsb0NTbHhwd3hyalZjd1RSZFhlaDBo?=
 =?utf-8?B?QkMxajJKZGNvRDdIU3l5Q3ozaHB0dGVDQnd4MTd6SXBJbUpha2VxODFEVmxK?=
 =?utf-8?B?Z1dCb2FuQzRPaWUvZmo4bXV0TjBxejBJNmVicnMrQUNvQzBnVUtlbEE2NEZv?=
 =?utf-8?B?QjFjQXZJMlRGN0NlbENZZUtTOTNaQzUrNXhpWE1vcnVSVW14M2liYnl4YlNR?=
 =?utf-8?B?SFZKcXdYbFNvRlFXQXVOcThNODdOSzRQMi9HN0w1K0k4Rm1rZW5vSDJKRTVI?=
 =?utf-8?B?bG5uMXhqamlGcDJLWnpYViswTzVrTUVHZkVHT0tGNFM4OFVyTXNEQ0tGdUFv?=
 =?utf-8?B?RGNIdkY5b0l6Uzl2VEkyY1p3ZTk0dkcrRWkvcUp4Tk4vY0txelZsNDZreTln?=
 =?utf-8?B?MUF2L1R1bmVxRlEzOFluR1ViK2I2V3EzVDhwcXZ0eWt0WXhzeWswWjJ5MnlS?=
 =?utf-8?B?TUtwNkJvL2I5UzFQb0JRMU1zSTBkTWFYdnlpL3FQRmdDUlZvUnpQbVpzYkxY?=
 =?utf-8?B?RzM4RjI3QkNObU9LS2NuSnZxWmNzVTc3VXRoc1U2NVdXZzNKQlc4Q3JHMUxF?=
 =?utf-8?B?RHdNZ0pNWkhjWkxPVmVYY3dSd1JZU3l6dFJ4ZzVVRGxwdkVJYzgybmFBYVpS?=
 =?utf-8?B?Y1dxakNLVlFUSGF3aGQwY3lDNnJHWWQ4TTYwb2UvWnNkOWRCdUVwdllJMm9D?=
 =?utf-8?B?TGEzZ0ZDc3pMbVZlZWhDRWFsN1pubnJlc3Q2WmRWcEJmV3l4aWxJYXZhR3l6?=
 =?utf-8?B?K2plMDBwRU9LeDl5aUVrdEY1Yjd4R1dFZFlvRzMra3FaNjlTVHF3QWZBTWd3?=
 =?utf-8?B?b2Zhb0hocUczRjlzeVVyRHpvbWxBNm1VMWJxMHRCeEVqUzc4R2N1WnVkS2lE?=
 =?utf-8?B?NnBLTWh5SlptOXc0OHNaM0JPU0RnWlh1NjNBekcvTDFXU2NhcCsrL1VTYUQr?=
 =?utf-8?B?QmxQcU44ajVvRHlJeUhMd3ZmVTQvbWRBdnZBcFR4Y2ZoallKYmhoMG1GaHhN?=
 =?utf-8?B?ZExwZkdQV1lieEtENy9PK25nVnlUL01rZjRkTUJ0M25yZk5Mang5dXgzbE92?=
 =?utf-8?B?c05Fd0FXMmJPKzY4NmdnUW9NQmk1VFE0MTY3RUJNUG5BWHFUc0ZFSS9nSVR4?=
 =?utf-8?B?WUU4Q2kyUjVPeXhXK0dKcjFZMWFIaUZxcmkxWDRCYnA2OTBnc2ZtVVZSMXFB?=
 =?utf-8?B?emhONHhrNFF6TTlxUTlBOVRSRktoR1hiR1RDSHg2RDFjbXRiVEM5OWdDZktL?=
 =?utf-8?B?dWxrQnFDVnRmYm1BSk9uSXB0NUhqTW9sYzUwOUJtVmtScy9oSVZvVTJOTU1O?=
 =?utf-8?B?UDlNUjVoMEs4dDBmd0tOQWtTdWhzNy91eWdPYnBYQWcxN2hKa0RNYjFPOHdv?=
 =?utf-8?B?eW5KOFd6TlA1d0dscUdNZlJOYWNURU5laG90NkVpL1F3YkFTZGV2Vm1YWlZB?=
 =?utf-8?Q?W8puK4zMKMSQR6RaAxYxvbayv8u823zyqdRqo3hN9opzr?=
X-MS-Exchange-AntiSpam-MessageData-1: zofX9GfnirVRCg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d80d6f21-1bcf-4596-8308-08df29fb8ccc
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 14:00:49.3780 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HkbffHx7ZE8EU5NpY3CxPqOl2o6JTskkGsWRxGNNyEQXIxoGl9/ayJczW6+PdMGycTcixseh41nVTM+sMFl8Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9104
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

On Tue Oct 13, 2026 at 5:26 PM JST, Eliot Courtney wrote:
>>> +///
>>> +/// A schema that doesn't need to borrow data from the stream can impl=
ement this for all `'data`
>>> +/// lifetimes, avoiding having to carry the lifetime parameter. A sche=
ma that borrows from the
>>> +/// stream directly should implements it for its own lifetime only.
>>> +pub(crate) trait Visit<'data> {
>>
>> Should this be named `Visitor` instead of `Visit`? Trait names should be
>> nouns rather than verbs, and this would make the `Decoder::visit`
>> method's prototype read more clearly imho. If you intended to use
>> `Visit` as a noun, I don't think that works either since the `visit`
>> method is potentially called many times (so it is not a single visit).
>
> According to [1], traits should preferably be named as verbs, and it in
> particular calls out the case where there's one fn in the trait:
>
> ```
> This RFC proposes to amend the convention to further say: if there
> is a single method that is the dominant functionality of the trait,
> consider using the same name for the trait itself.
> ```
>
> That said in the kernel there are more noun/noun phrase traits. So no
> worries to rename it to Visitor. But I wouldn't say trait names should
> be nouns as a rule, it seems that the prescriptive answer is to prefer
> the opposite.

Let's follow the Rust rule then - `Visit` it is. My issue with it
probably came from the fact that "visit" can be both a verb and a noun,
and the doccomment calls it "A visitor". But if we rewrite the doccomment
to use "visit" as a verb instead, like "Trait for types that visit ..."
the intent should be clearer.
