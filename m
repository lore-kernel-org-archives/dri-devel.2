Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E0CCA5FBA
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 11:04:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A190D10F2F2;
	Wed, 30 Sep 2026 11:04:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="q2IhEGJk";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010047.outbound.protection.outlook.com [52.101.56.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 638C010F305
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 11:04:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tz6chN9KCRmFCj3CcLjmWMQIoGZgdOgve6J8Q+U9AlYuIVpFOKkg5V2syspPGR1DFTibS0SJ5Uyn0T5fay9c9l4WIVs4P+4Uz1ZwX3/JLbeTmuMNNpFDGvtvRWa6rmeu7hsfxWePrNQQsl5eyfDcH+3wCK8Nw71DgbGWU4J6Q3PjE0R4A6v6el1B/QwepEmumrOiD92Jmwg9QWe8t118OyjldWfLnlbPaFyd/dCV0jzvbjDpbnewMV3XCgq20mzgGZA23oREEhjkzFP5IGDRKrIJyaYvip9Dm47KwM8GTYgcNCQec8iiGTSL0/cUKh9e1J9qW+7asW0HSBiEeRvQpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwkGj2Cht22XH7o1YZ7wmig5egpobELSsJ5cDtoFTEc=;
 b=q9nwiOBG+y7jCSjG1KHlvnGjomUFhUaYcECQK4cJEoGqlrwcsya4uWtTyinoWxKBlAyHI+spfF7vmwHPVrZj0doYi0dH3jIsHio8+nu0hkwuKyT4UnrW+Uotu/7efxQlB4rwWuVdpCJLsP1kr1UOdJfNYT/48DBSOCbwwfSJPOTo/26/ERCfIS7N7Iy6Q8eo0HTY3AC49ztrKap7bAm8kVuf4iX6db11Vop8/O1HN8jQ/O6PKto3s32MTK9nQ5WN1nXvYIyioCzFKgTsvm4v6Ns+a77oKLTqHDXli4Hx+sOHYsEp68yJbd/lbi616dsnQbQTu0LWSBKRh8g4wRg7Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwkGj2Cht22XH7o1YZ7wmig5egpobELSsJ5cDtoFTEc=;
 b=q2IhEGJkBC5wgnVW/Ayub77ZU1S/t3rT91uE/uADOiU8hOv3ffRdmkb79HbikTTzIPFTrcb2JKUEoKsZhWJZR5zp1pQpsW4R+rJ1o/obHzCK0klmvS7bGlqPfu9Z4slho62elPqUlhP6LNh7L+Jws4xJOya+nnHOzg+oPB+5wKFyIOcExrMRFtV4/x3Uk8hXFXQAhK3ErVBpBr8WiZWdthlOPPDTMQOvtY3mc5OELEBFqt7TYQBL2/ylFQwNfGT3zoAiexjiBaEHkYZ/FHprh/vWesm7kfhtXqgrAcGSTnnju3HUyRCcut6HPJhpNcGqy6y9G+ODlEfl0lbXd01S4g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by MW3PR12MB4348.namprd12.prod.outlook.com (2603:10b6:303:5f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 11:04:11 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 11:04:10 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Sep 2026 20:04:07 +0900
Message-Id: <DLSLNL9HDUKM.HN7Z0MACZZSB@nvidia.com>
Subject: Re: [PATCH v9 3/9] rust: sizes: add sub-1K size constants
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
Cc: "Eliot Courtney" <ecourtney@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Burak Emir" <burak.emir@gmail.com>, "Yury Norov"
 <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
References: <20260930-chid-v9-0-0d6cca376cff@nvidia.com>
 <20260930-chid-v9-3-0d6cca376cff@nvidia.com>
 <CANiq72kcqVfvVj_b7KTHKrCDj63LMKpsfP30zafoYB8c924i2Q@mail.gmail.com>
In-Reply-To: <CANiq72kcqVfvVj_b7KTHKrCDj63LMKpsfP30zafoYB8c924i2Q@mail.gmail.com>
X-ClientProxiedBy: TY6PR01CA0018.jpnprd01.prod.outlook.com
 (2603:1096:405:3bb::16) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|MW3PR12MB4348:EE_
X-MS-Office365-Filtering-Correlation-Id: ff9e9f28-f9b9-4e19-e7e9-08df1ee28e2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|10070799003|23010399003|1800799024|366016|376014|4143699003|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: orrQ7FW0tVh3kG08YNuVuGYN+BqJt2L8HxAs3dh64lbBsI1q2r34+zmc4uQXXQ0vLdlBrwBM1xuROwCJANczrL+Nq9ZS3BDL0/klmF6sytrOn8ajkZZEFtDKZhutHRSCCBgbUYhSFKw3rjqlfYa39IUMLvIFQcbEA76UR0YSN0HRPC6VwrYM4Dr0RcqXM23K1zWwouIlKG821HJYHfL0v0dWsWnJKPU6QKNYGyVOThM5B4LycMZPsvbsCgpxKFwIuLphSsD9XyUgZHUUDzPKbsZan3Re3TTeQJOmppaSJJAktsHZZPymXEB+9XWwZgPudGBDLr0Vhv5CfBCFhRPccV3AcAojQfs3N1sJwZ2mhaBMpf/WaeG3ojzyRTClzI6oTc0tm3MVK2eiFICE2wweFsA6GCEHxNIlysPPOkfkKkiLHKbKk6Mju0Pz/wUSdMaBFvwHvLLOOvABPNCh1PsME/V3qu+0dIKnMmx9ZuHTRznEyanHPaUQkTifc2Fh2RA/pxWApUosze8LgzobJc4qqcHPHbILay1ZSnnWWLpOOcGqYBqwytULc/JFnvWeWX8X9K2X4MMIhRESwJpaNMlvun+3jkOSq0VbooINV9WCV3E7kmrFKV/z8yfyaLlZdOmVkK1mlCodUF2p6tRMyzcyWEzK27t2xErUr2X3pw6WSew=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(10070799003)(23010399003)(1800799024)(366016)(376014)(4143699003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cExqVkU2OU9vNVYrcFF5OFIzUlZZdVhBdkQwWkd5TUw2cm04L04vZUIrK2JS?=
 =?utf-8?B?eHNqMm1xeHJzZDk5dUl3QUJrdWxFdGlpRkhWZW5tbDRvWG1YNTBiSkw2L1V1?=
 =?utf-8?B?SFpjclZ5ZmFkU2o5b0kvVkROL2tUVkY4YklIYkZBQ1RobmtLYTFFcUtGQ0l4?=
 =?utf-8?B?VmVNT29pZ1c4RjMyTHVtQS9xWW00cWxuVHgrenY3N3NlRXpnRG9NTEowMTFw?=
 =?utf-8?B?cmFhWmI0SUtmMERjREFIQXp1dlhYZ3llVEs3K3V0b2ZGcDZ1OFlsUER1Qjh2?=
 =?utf-8?B?MjFsMU5VYVVvcGxzeEJLSVZVRkVsSkxhcGZmRnJjYXVVYjA1WlRDRUNPSyth?=
 =?utf-8?B?dmNBcDVTQTN4VGNJQ0JDWi9scjhjY2RYTlVlWllTSTJWc3k4OGgxMlVOM2l4?=
 =?utf-8?B?MlNqdnU0V2xZZjhuM0hLbkJtN1c1YTBOKzk3eDluVTQxQjdPWG8wenlxZHZV?=
 =?utf-8?B?cTBRNDZucitvMjRyUEtGTDM5Sno3ajNzeTI3UjlmNUVyV3ZJekFLNWxPcnY3?=
 =?utf-8?B?VlU3dzFXbUkvOHBRQUwzTmRDMFhXMXNoS0tLc2VtZmVuM1RYaDVabjNzcTBs?=
 =?utf-8?B?ZW5jT0swRnp3YmJPazRTVTRHd1VDaStEUFhYNEtSbU1vWk1qbHR1ZEFDQnRv?=
 =?utf-8?B?SGJhNGg4ZGROQ0lwWmVLY2FOZTBaUGtDMUVoMjRPZWxidmlEUExNTHU1SHJW?=
 =?utf-8?B?M0UvUXZUdGJra01WcE1nMEVSdSsxcXV4YzhGbzlXclRFQnNocVhjZ0NxVmx5?=
 =?utf-8?B?MVhwK0NFR0hLVnhqL2hldEtIRkZXQ3UyNGJEQVFnMXVFTmVlMkdka0RZWjAv?=
 =?utf-8?B?eFQxV1ExT2ptR0hxWTNJanh4YlhMNHdSNHgwZnVZV1JLQjhtK2srRVJtYUsy?=
 =?utf-8?B?LzhyRFozb0h3QjFTWE83c3l1ZmpqY0wvY25LcUZnMnRISDczL3E1THEzTUtn?=
 =?utf-8?B?NjlQcFNDdGlKYy8vODVYUHdYMi9QNTFIdkhERytuNFYwUWFkZ1BLVFlRaGJH?=
 =?utf-8?B?WE9tVTYrT0FlUlMzYlFrL1UxcXV2ODR4QnBXaGFUTW8wMFZhUGlqM0N4VVcx?=
 =?utf-8?B?azJXaUJ2MG9LVlhyZjVGcWRobEVlQktPUmVkV0RmV3c4bVNtTGlKdlV2WmRS?=
 =?utf-8?B?bHk4VVVja0pPTW9MVFp0ZGp4aGJTWTVhR3FKYTEvV3ZhZ3hleCtiNTlYeklv?=
 =?utf-8?B?WUU5eWZWSHp0eEd6WmRWK0xNbDFtN1JjbkIrdlNkQ0VmWkh0azJXTGY4MVNX?=
 =?utf-8?B?d24zbFBTQXhJc3ptZm1nL1I5NHFEbFRQSnVCKyt6YTBweG8yN2Q0Z2ZGTHJG?=
 =?utf-8?B?d1lvMXhsUDdPdEJZcEdDcHhFWEpZVFhBd251QU5uZXkyTDN2TmVwVXpnVE1h?=
 =?utf-8?B?Yit6dzJmZkJiVGpvbW9JWWtjRUlFMW9oRld5Ym96OFN5Y0o3SlR4QmJreEZk?=
 =?utf-8?B?WXVsSkNPeFJWbUNoK1BFeWU5anBDR0FGa2RVWjZJbjNwNUtzdDJJWXp5MmNT?=
 =?utf-8?B?dzYvSnZSQlBhQlNJdEtKM2xPSURNTVBRMkIydmxxemxGQzB5cDBNcWFLTGtT?=
 =?utf-8?B?Mzhpb0lKQSt6cEthdDcwZEVQelhITG1kdUM5S0d1REZDMzNTYWU3enMvQTZV?=
 =?utf-8?B?NlB2Y3BDV0x6eWlZaHJRTk0xTFhPUkN0bmpIMmgvYzQraUcrQnV5NlJ0dTRF?=
 =?utf-8?B?OHNSRnVsdEl3c1VsbkF4bmkxTFQ0blovWUZpcHhteEl4QWkzZGhoWkp2K1Vv?=
 =?utf-8?B?MTBqM3pncGRZYzNtakJ3dEFmZUM2TXNtUE00UjdqcFR1aHFMMlRWWS9IOVlS?=
 =?utf-8?B?U2E3MUhqQ0ZIajZ5Y2hlRXo2S3BOU2hNdXNKeHVZRjJUOE9iVWkzbER5aGNv?=
 =?utf-8?B?TTgwYzQzUUZRenNFWU53MldCaDJzYWVWUFpqUi83UnBGRkhQQnpYZkZqZGIw?=
 =?utf-8?B?a1lSWmgyWU5OVlRpNjgvL3VIdElEZkQ2eFpoWTk3OGxxZk13ME4vRy94ZnZL?=
 =?utf-8?B?aENTdVpxM3ZJTFpVSkFtby9ZcWtBR2tFdnRCajdQelpIUWlnZ3g4bG5xbG1y?=
 =?utf-8?B?S08wcmFRbFJtbk9SME9HYjZLQlpndFpSa1FyVkd6ZDlCV3o2Mk1JTm1yVXdH?=
 =?utf-8?B?Ri9sajhPRlFIYThUY1N3eGd2RzFPKzlQYjZheklNWDhHL1ZaMXJNRCtEL2Z4?=
 =?utf-8?B?a2E0S1RzcnUrNGhjbWl0UjRjOHBoY21JTnBNZjltQ2xWeWpXR0gySXg4SkVG?=
 =?utf-8?B?TEs4ZmFpcDFhdnVtL0ZGb2pBUUJ6SWtGc25HYk9aQWVFN1hDZ094dGRMUVor?=
 =?utf-8?B?UVphUnAxV0RvUWJ0VUFtVm5nS24vemQxaTNSZXJqL3RKUjV6b2VGcHc1WFNs?=
 =?utf-8?Q?yTlXNrhQKcFgOHbpZ9KGVU6bvig0BI/8Aj224aTKBPvRo?=
X-MS-Exchange-AntiSpam-MessageData-1: PeCwiEhLcrC0+A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff9e9f28-f9b9-4e19-e7e9-08df1ee28e2b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 11:04:10.8904 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R8vDd0VkM7lLwwRGzBRLgyJZCWHgEF9fyXn0ETD5OjfOKso7ISCKIlgiBgUGUBuojRniXdizwsaQYnBgE11w7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4348
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

Hi Miguel,

On Wed Sep 30, 2026 at 6:12 PM JST, Miguel Ojeda wrote:
> On Wed, Sep 30, 2026 at 4:44=E2=80=AFAM Eliot Courtney <ecourtney@nvidia.=
com> wrote:
>>
>> Add some more size constants, mirroring include/linux/sizes.h. This is
>> useful for making `Alignment` implement `SizeConstants` in a following
>> patch, because these are more common alignment values.
>>
>> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>
> If this ends up going through bitmap or DRM or similar this cycle:
>
> Acked-by: Miguel Ojeda <ojeda@kernel.org>
>
> Otherwise, I can pick this one up this cycle.

I am considering picking the series through DRM, but it also has a
dependency on the `cv!` macro [1].

Is this ok if we take the patch introducing `cv!` through DRM as well?

[1] https://lore.kernel.org/all/20260917-cv-v4-1-547ef5727451@nvidia.com/
