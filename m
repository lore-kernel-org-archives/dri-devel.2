Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB49C43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 13:26:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A806610E352;
	Sat, 11 Jul 2026 13:26:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="jHNXs8Ro";
	dkim-atps=neutral
Received: from LO0P265CU003.outbound.protection.outlook.com
 (mail-uksouthazon11022122.outbound.protection.outlook.com [52.101.96.122])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 797AD10E386
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 13:26:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bnozrz1hIjphyCYyq7pPADLHAUDOEnZYGXvybcgDbLr3eSZffeOJHMIXX2xvzo6Lh7vPJD+UP3uweHvulWVGM0+S483EdX7lf8mRQrpYPZsj2em9Vl3d7dKgTaXcC0WT4K/Djjs6lAmc4Ha/sWvQ7sd8HWr6QAqb5yQSqnGsdLyC4+1RRKO/BqiLkYrKQhGUqd6iYGallcrtO6DjkfgqX2sXdxx8+Gn1NyIn1UhUKuaZ2chRrX6goboKc2fih6xoenP+joWsNiQI1Di67dP/eyBP+c4KvVhy5MhEzWeeciOG3KJm0Hwd8EnvL0JEYP6M5ZmrDPlNII+8EqGDDIxtfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xX/51rM4WxORv57Xf5TzFoGOvgTm2QDlToVUIbbvGfE=;
 b=a+6VhgS3Q4rSMtILndWoHFfe+dhMI8LkDafCyzwjpj2W8NCz8tNPtz2RpCH3+46e9OCvg9//krute1YB9vQFsedZHWLBVNFbju6UGswtBMxE/jW/MaRrJDgnq8pCC9rtupEkH6OB5I9G5GpAVHsOV9N/4wN9EFYlz/I1qneK6PB6KpHdhzzj8h9YX8Y3vWnlprCsFUU50AOhuWRNPsLDDQWAJJefqeCGE8M5HbElzkkGbFA06i9aMYtRv+l7YaoKOW++h2e1hXBZn3oJb+QTlfX4cxKc64y+5x5c0+pKJrCeMX0HR8gLnE19+PHUKmAL1CC0f9Esg6ewuI02u7CHVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xX/51rM4WxORv57Xf5TzFoGOvgTm2QDlToVUIbbvGfE=;
 b=jHNXs8RoFQdnw8tFMIFZr+wO31x11po7WGN+O3cBDkfu9qkriynoS/8PP6szNnhosP5N3P1yhmyj75BMH2nxe+hd3NOsrHBO4cPRD2nSYqds+warhJfCQvero7XMI67ADmO+5qXgSnYK2NKcLx7aWCUs2RiUEAhVMzErXi/jpFU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB5285.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:22a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.19; Sat, 11 Jul
 2026 13:26:32 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0181.017; Sat, 11 Jul 2026
 13:26:32 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 11 Jul 2026 14:26:31 +0100
Message-Id: <DJVRYHMLVAMH.1UK0QWBNSMDO2@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Alice Ryhl" <aliceryhl@google.com>, "John Hubbard" <jhubbard@nvidia.com>
Cc: "Eliot Courtney" <ecourtney@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "Greg KH" <gregkh@linuxfoundation.org>, "Burak Emir" <bqe@google.com>,
 "Yury Norov" <yury.norov@gmail.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH] gpu: nova-core: add ChannelIdPool
X-Mailer: aerc 0.21.0
References: <20260710-chid-maple-v1-1-4ee869055268@nvidia.com>
 <84bc8bd2-e292-4b84-9580-a1b5df4c5bdc@nvidia.com>
 <alI2-KaHDTmUvNK8@google.com>
In-Reply-To: <alI2-KaHDTmUvNK8@google.com>
X-ClientProxiedBy: LO6P123CA0049.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::9) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB5285:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e7d1da6-1813-465b-10af-08dedf5005f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|7416014|376014|1800799024|366016|4143699003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: my1PugzdEnu3CcBieqInUYiNmDqLtAIFKdfUXJqsDEzBQNA7r3eDafDkxy6vPBsqsj4b4ubGzUyS9GmOsi4ARvGTjoqdJMHUBb452/OiNw50VjoWXOcZjP/CNLAl9qOIp1XBEqGRtdyIFKr1zQYqg2L/wYEGHfbgMfQhaIDt3x8wBMB4WhRkzVTeUVlmfiKKFWp25NNG+9dGzvxTzudkKCQLko6tVS4LPid9UB+gvJdO4KmIAMdgfDphKTkqv/yezHqFskrBT1Jms+LfHJFYQFHtCrRUWreuI2DbOVjApv3wPpxG9absU2mQzW165utHL1vTCAVDp/2lkS/RBHW2WRkQkpPg8cAeibFWRXsWMUNNoFBWDcg6qfnA08yqueF7nW8RZUlYtbkS7vq6OxWSYJ4Lw7CSoYtcm7JOoa2CghuxknfqhaMKM1Aqw61qtpwZwc0h22VjPMwCSa9C2Jq4iU562amUCiG71J3txfojy9uAGgO8D7hc1vQaec9tKUTUeCBYHZCA4bBv4xPMtEbuuCMmoWGyGCpsyQUVs6HNpv+RttxtYrO8U869tOrIXQOnf96Uomv9Q8DUplazsd8kNQKd9qLzbRcmsqjPtvP9q2uHNXqQLOTg2477RVAhFyxe0zYlzf6ocNLAwJBznSUhAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(7416014)(376014)(1800799024)(366016)(4143699003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0h1TlE3OHRnbmZ0dTBtVC9rZG5NSWpTL0ZBYXNYeTJPUWxvR08wS0laRSt1?=
 =?utf-8?B?S3pFRXE0ODZuVkdwVGdNMERzV2psdjFPRGE5djh3T3ZkK0dhWEtDdnJweU5o?=
 =?utf-8?B?K3VUSER0bXltUmNrRkc0RDBMT1BRUU9QeFNTSXVDdlUrRFJobFpZcXpnWHJa?=
 =?utf-8?B?ZERmTkh4aXVRdWo2dkw1bEU4clcyMmJLclI2N1d3dk1xRHpCcFNTb3ovSWxR?=
 =?utf-8?B?cnNvdGtJRCs5a205OGZSWXhBRGFpdXFraGtLczB2TVp5Y2VzSzE3MUp1RXZ0?=
 =?utf-8?B?T0IrWFQ4SUprdUFwRnFJN1NyblpCT3JMS3YxZkVIRkFYWmloNTVHMStqUFZw?=
 =?utf-8?B?Ly9TNmRNYnR3NTBDclFEVGovcTh3QVdzMnpkOUg3bFc5aXhpakkwRy90NFI5?=
 =?utf-8?B?NUJlNTNMMFlZSU9oT0tQYzBRTGY1NW40K0ZjYStpSXNFU3dMSjM1eEw5dS9J?=
 =?utf-8?B?M3RjekwxckxTUnRlVytNZEpReW9WQzZ0NjREZDJ1WmlsOExDemFuOWhVQjBo?=
 =?utf-8?B?SVQyZjR2SDZ0MWFVT1FhUk16eHFwdE1QYlc5M3lxcEhPNzFEVkVTU2dPVlQ4?=
 =?utf-8?B?aUhwUm9qdHZyMkRpZFo3MzZhRjgwdmZLTUhmWUdLNVVsMXdPbHJLeGY0MVRu?=
 =?utf-8?B?UmdBbyt2YWN6Sm9CMWVnSVQrdFM4UmhEOGcyOFFKZTBnekREdTd2NzI4Q1Rz?=
 =?utf-8?B?Wmp2Q3ErRWpVZjdHeWx0S0hSR2FNT1hENUx3a3JnZXRuVk9QVHFKU0prbjRT?=
 =?utf-8?B?WWlLeEhLUnNYaUZteXA0ZlR4WTBaQ0MzaG5NdmptakkwSWdGekFYWVBHc0Rs?=
 =?utf-8?B?RkdxSCswU3h2NG9WWEdTVTUrTWtiSis1VlFhYW00eHZ1RnJualFkejk3NGNV?=
 =?utf-8?B?ZUlHNElYTmtIaVdSdDYzTmZGalI0dWg1UEpOQzMvNzR0ajRBZmFPeU1MRklo?=
 =?utf-8?B?Vm52d2tLSDJkeGtFNWVic1pXc3FNL09tR0pYMDFJRU1oanZPRXFkTDJBVnNB?=
 =?utf-8?B?T1JnSmxsZThYRnVnMXQxK1NJWFB6aHBmV1BBdE1JcHEycGcrcUhJUEc5aE9n?=
 =?utf-8?B?c2RIOHZFRXNXcWxGQ1B0bysrZ0FrbmFyQThRRmh6YjF2cTNQejQzZ2JoaTB2?=
 =?utf-8?B?dmNlejhiQVlWblcxOHVobG5SQU1FZ1BOOXJzenBuV200dkZROTErbU15dVRi?=
 =?utf-8?B?cnd0Ukk3a3dUTzJFRE41aFZvYmhUbldpaUw5Z1ozTXpGd3NZTGpQdGZZSTN5?=
 =?utf-8?B?ODRveFBvdWFRL1BEU3JuaFo1QityaklJU0Y5TjM5cmFEdVZCKzBqVk9wYnBj?=
 =?utf-8?B?UnJVbmMyOWhJUFVHTkVmWmVWU3A2QkR1ZWZMdVpFcFRQR0w5VHpGaHljd1M1?=
 =?utf-8?B?U3B0R0pBQUl6UnR1Z3BmdXR5b29nNFkzNlZXZThCcTZTQVE2MzlRYmdOd1pH?=
 =?utf-8?B?azFtVmlwTENtM2ZuTnFWWE5uWU5CTGUwbllFVGlaTHVCQVEzY2pmQ1RIdUpM?=
 =?utf-8?B?WEtJUHhBOG5BZWQraHUzZXNSTzhvVXhWSGFtL2pFZnZVTW1GSHNEOTRzRWFT?=
 =?utf-8?B?V0xvNTM5eU1lTHBRWUlnWldvYmJ3Yk1yTnZXanNQTGs1ajNLU1V2NDdGME8r?=
 =?utf-8?B?ZHpUQjhZUEtNNlJjOExVY1RoUEd1MFZjc2hQTE53c2pJUjZ4N3lRTmNyOSsr?=
 =?utf-8?B?Y0I4bFp5bGZpbm53MmhGcFlKa2dMUG42MXZQQ0ZUUkh1Q0tWU0p5ci9FRklX?=
 =?utf-8?B?ZDNoZEJrc3NKTG8ySFZ4bHMxRlQ0N204a3ZIdDdSRml4WDlFUzhrMkhiYWFY?=
 =?utf-8?B?R01kdVB3M2ZxUXZ4cXVuWE9Hb0xaa0pOa0d3SXBiY2lyTzBOTTg4WU1jNUwz?=
 =?utf-8?B?VHZJNlQxd3liNVMwS05hWmdSeFJpeHo5b0RkQ05jQTN6REpQb3NqOVpWMmFZ?=
 =?utf-8?B?a1hiZFlNY2o4L29nalJNOXQ1V0VFSGxpMXZZS2Z0QXVqc1d3ZzdFbmhiMldX?=
 =?utf-8?B?NE5qNjFoZ1c3OVNpVkxPamo4ZGdaV09FSGxsRmZyWXpWUlhvMzcwSWtYMlpw?=
 =?utf-8?B?ZHFrM21IOUJuVTExY3l1eG9IMllMUEJkc2VUVm1NYnJ6MElqTnhKcVBheUpk?=
 =?utf-8?B?UU9mRTZmSE1MQlYrRVlwOHNCc1VEVEtCZi9HWmE1Q0h3SHdOOFIrdDFDbEZU?=
 =?utf-8?B?SzYwOVRLQzB2aDJ1K2Yrb2RuQmNIVENoV2lBVW11TmN6ZUpmRE14bjBCQ1U0?=
 =?utf-8?B?VG9tYloxa0NEVlNPdkwwWno4Sy9iMUdhMWh4Z0c4c2hkR1g3bXU4MlVGZ0Fq?=
 =?utf-8?B?aThyOXJadG14RVRWTGFJdXdya0x3Y0NFdWlQZzV6NTE3ZDltVThnQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e7d1da6-1813-465b-10af-08dedf5005f0
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2026 13:26:32.3962 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xFsxYltjjtppAh6Dj3LL2Vfa8V6dkvikbwKkC2RD5OKammOUg4uhXVsJUF2FjDxx6PjfuGTP5pJm0fACU0+SSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5285
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

On Sat Jul 11, 2026 at 1:28 PM BST, Alice Ryhl wrote:
> On Fri, Jul 10, 2026 at 02:29:39PM -0700, John Hubbard wrote:
>> On 7/10/26 6:42 AM, Eliot Courtney wrote:
>> ...
>> > +use kernel::{
>> > +    maple_tree::MapleTreeAlloc,
>>=20
>> Hi Eliot, Alice, all,
>>=20
>> Eliot already laid out the maple costs (the alloc_range+erase loop
>> replicating find_next_zero_area, the extra mutex, allocation on
>> alloc and free), so I won't rehash them. What I can add is why the
>> alignment is a hard requirement, since that is what seems to make
>> the decision clearer to me at least.
>>=20
>> Pre-Blackwell, USERD sits in BAR1 at page granularity, 8 channels to a
>> 4K page (chid =3D page*8 + slot). Giving a VM its own channels means
>> giving it whole USERD pages, so a VM's chid range has to be 8-aligned
>> and a multiple of 8. Blackwell moves submit to a per-function doorbell
>> keyed by (runlist, chid), and the constraint goes away. So it's a
>> constraint we're stuck with pre-Blackwell, not one we can design away.
>>=20
>> Given that, the bitmap version is hard to argue with. The aligned
>> allocation is the one call the API is built around, roughly:
>>=20
>>     let mut ids =3D self.inner.lock();
>>     let area =3D ids.find_unused_area(0, count, align_mask)
>>                   .ok_or(ENOSPC)?;
>>     // area.acquire() reserves and returns the range, drop clears it
>>=20
>> One lock, no retry, and release is a bitmap_clear that can't fail. For
>> 2048 IDs the backing store is a 256-byte array. find_next_zero_area()
>> is also the existing idiom for this (IOMMU, DMA, IRQ), so it answers
>> Greg's reuse-what-exists point as well.
>>=20
>> I'd go with the bitmap id_pool.
>
> Completely agreed. The loop in this patch seems like a really bad idea
> to me. If the maple tree doesn't natively provide a way to allocate the
> range with an alignment requirement, we should not attempt to hack in
> support for alignment by looping. Please use the bitmap.
>
> (Even without the alignment requirement, I think that the 2048 size
> limit is also a good reason to use a bitmap, but the argument is less
> strong in that case.)

I think the reasoning is strong, you get everything fit within 4 cache line=
s and
with even a dumb prefetcher you'd have no more than 2 cache misses . It's g=
oing
to be faster than data structures that need indirection.

Best,
Gary

