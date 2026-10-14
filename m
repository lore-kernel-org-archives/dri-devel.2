Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F9DBCC6B1F
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 02:05:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01A3B10FA66;
	Wed, 14 Oct 2026 02:05:00 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010049.outbound.protection.outlook.com [52.101.46.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16A3B10FA66
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 02:04:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=op4jFfjyh48KvFyXcCA2dur2wu/Bej+LRLQp6EXIZqTWg0vUXdRlKQZA3x9w2g1BQDAJpfDSA4qqV+SBEf78JzVX8MmFYXe+89j2q37l48VaGymaxht4ybN1XTz4OVv0QIcRl66JXmkSkSBw70Bo6EwnpJ1g29gayW8VPzmxU7/Vnt7yFWBxgYuuSj2jh4Ms1lPJvWGCicw+4ohSszCSzRCW887r2al/WigKQvnokMSCtoASMJfTgSrWPQc9rS8A5lTxIjGMkmLp6/C10KjnWQYXUO5rj3ipyHJZB9B5RG0ijoJFUAxM+/cOcCCF5DIo/BBtmcQwCpIzwgJCrrtvlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eq8dS0Dvl26BsgyGTpLK4Lj/E2w9/VjZrEsMUDC+jgE=;
 b=TwHWeSdakHN7hiqYVKroeM2kN2cEVUwN8PWnJkUDw1k9Vxl3JaBmxIyOd3vvBuBIMHZmLxk2WdaMLKkTCNTsLm9axOn26BCZ1pXQclABfCoAPPpuv04ECBM/dAvhQAbtiotKUJcXogWi3Ic2A444w6T2sfCoSNG3wlYrdYJ57EgLuzZAOvOMGy9ojxSFoqt5+h/wi4iJ6+/KLVUZzwe7FYFgpTQh30j8MEZ1QfwucA8TrE6Me0ZqmlU3UCKE+eg0aYri/KJKqAg1Iyc+1ejUaAruz8svii+GZKBBecsEN8+xKXfjYs0Bn/Ieqj6qYtf9xGBWMttY3x1NjgeqS8cMUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eq8dS0Dvl26BsgyGTpLK4Lj/E2w9/VjZrEsMUDC+jgE=;
 b=UP5kgumQLya6IjTeOtlZikY9i9GDblRl8bPZceIzzW382h52ozcY24V1z+2Vs/G0RrL6mjz/vkoTML5l7kMk7SVCHOHKXHZYnASMcxAjJalj/0Wc7WHr2EpoTx/95lQZSrNHmvaJTnb8bTZHijxDIMJzrLPnc4iUOjZrRnH4QBrQ4niLD484+mqADIZyJkzrxB703WlV35tzsjGwPW9NuNDjh7vRZyIqK4aNlOvWwjhckHArKffhquXpzAjFBotOhTZ9X5NjcOxitOwd//nx3NcYMR3n0ef/7KzMhodNVxEjP5smnfn6msoolf0hqaeKhl55jXYRJcuUCEe91ejSuQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SJ1PR12MB6028.namprd12.prod.outlook.com (2603:10b6:a03:489::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Wed, 14 Oct
 2026 02:04:48 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0522.011; Wed, 14 Oct 2026
 02:04:48 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 14 Oct 2026 11:04:46 +0900
Message-Id: <DM46Y905AJVV.1K0F8AK1ZP4IO@nvidia.com>
To: "Burak Emir" <burak.emir@gmail.com>
Cc: "Yury Norov" <ynorov@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Alice Ryhl" <aliceryhl@google.com>, "Yury Norov"
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
Subject: Re: [PATCH v9 8/9] rust: id_pool: do not round capacity up to
 BitmapVec::MAX_INLINE_LEN
From: "Alexandre Courbot" <acourbot@nvidia.com>
References: <20260930-chid-v9-0-0d6cca376cff@nvidia.com>
 <20260930-chid-v9-8-0d6cca376cff@nvidia.com> <aryYkkB9j14xnWo3@yury>
 <DLTA93JE6VF2.37UGB3SWU6ID6@nvidia.com> <ase7IBtZjQsPVWSN@yury>
 <DM0D75ZTTQXJ.2XADVI38UGH7C@nvidia.com>
 <CABwQupMVzUOsqP_fTZQdwUU+xEO1k2Q4=RQQuq2qd5HCYY0ZUg@mail.gmail.com>
In-Reply-To: <CABwQupMVzUOsqP_fTZQdwUU+xEO1k2Q4=RQQuq2qd5HCYY0ZUg@mail.gmail.com>
X-ClientProxiedBy: TYCP286CA0325.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::8) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SJ1PR12MB6028:EE_
X-MS-Office365-Filtering-Correlation-Id: 42d07438-1eb8-409b-9089-08df2997864a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|10070799003|1800799024|23010399003|376014|6133799003|18002099003|10067099003|261009223027099003|22082099003|11063799006|4143699003|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info: 8gexm8GbWJ1AlBG1k6kBbZgKVGkyIQ1xaJyJw2pjJ1cKgL53TQdgUgIgWQ7uxXbryyxUtO8yiGhQrg+x05uGF03cbSILr1ax2Q6iHq+RC6S/GKUDSWT57hmGgMI4G2t519qzA9WdlDu8TdYsOHmYNk9RBdyz55VIgmIdRZYzuJQCBlmJOB3zD94cVfH8DYhMRkvaYexGJ/vpe0omiJQKEvAPlshUzRwHXYmn9Wq5j1TAYU9bvhN305tH7QWM0y3UHpv0lmwoDUnIXUQJ7oRJV4KVx2BjLv5kVK4ufXV6fjziYZgHgmutAdnw4Mli/j5vg5n8TFQ6YzsixyVaRlem+0ixlF2mtl6ne3KbtNrINdAV0Yh8JGBL+P3QA/tIq2W3rmDU9cHlhLSSsyPRm6vkSWaoz8mFiLp3h/ZYvMpIqRrRaqw6B0/7TUCRx28JDaWrXO5XSqtVT5tLKLFzLQxs3OdjK5MXN1Or+OwJZFgwq9Pl5kcjhWhyHW0QeCdL/fIJ+DHYJPwUFUUeCH0tEfvCmwYlpVB2seMEZuQiad/8EbttDqqhDJFhJEPeGvgOhUi1yw30GP4JUjykaZiWVOaQ1MuJaffCXT2qd0eTtkv0n2ZmzM8Jtj73eSn+v8QJYjt6ixrjHh6Iagt9KPH6X2D7pdKR6t5SpP33Q1ZaoKkfdSM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(10070799003)(1800799024)(23010399003)(376014)(6133799003)(18002099003)(10067099003)(261009223027099003)(22082099003)(11063799006)(4143699003)(56012099006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnhVaUJUV1JqazE2NXhzNSs3b014NHI1TWFkTFU2Uk0ySXdqN2hxRHRtQWFr?=
 =?utf-8?B?TnFSQ29sWVdxNXFLTzVnQkd6MUs0Skd2ZUdwQ2h3QVJlWVprZU0rQnljNWdI?=
 =?utf-8?B?bEdQSjg0cVBhSnRaTjBtR0pmbTIxNWc5bzZESGRLOVVVakxQK1JXVy9wYmRR?=
 =?utf-8?B?OHdIQ1RwdmQzb3NDVWh3cTJ3SVdRc3VHTEM4aWlOOXcyMmR1QUtXTXV2bXN3?=
 =?utf-8?B?UWdUUTIraUVZMUJJT0srcWRvNEw3VW9JR2pOZ01PdkRxdHFxL0g3Y24yYzg5?=
 =?utf-8?B?RHFXWFFCdXRPQVlOWkZDZ25TL2w5WkdnSXlCTXFVNzJMQllvMlJZc2k5QnpQ?=
 =?utf-8?B?VExMM3NXME1LSStuNUEyQk1yM2xGVWtVLzlNUmFIUVJxQlpxcitCdkxXRVgy?=
 =?utf-8?B?VVZYQ29idURCQXdBcGhxM0dkSk5iR3VRZncvWlkzcmVmZ0Q2YmZsWERXV01H?=
 =?utf-8?B?bXRwTkdsVVpUSE9RSlBhb2dLWURLT2JXdm9wbStBUzVNdndma0MvK3RqS1dN?=
 =?utf-8?B?Q0NuckIwV1Y3VVNrODhoWkh5Ym1BUVpnZUN3aEFEU3pVT3ZFNkdQenRVRnF5?=
 =?utf-8?B?MU1sUm1nL1c0OXpmSTNvSzZGZXdTcGtOYUlHajA4S3czak5zcFJpVTJ2cHRI?=
 =?utf-8?B?ZXVkOWdrYTRTMStLSDR0bVBpWkZJS3lEbGlaQTlJa2xhNFZ1bTVNd0R3NTdV?=
 =?utf-8?B?RU9meG5BNXhLUVMwTG11WmpsUUx2N2hBeGgrZmthaGRJWWFhVzNDNmduUElQ?=
 =?utf-8?B?MVgybUp1VStoRUpJazk1UWN5T2gxaEo4aTg3UjhKQWlnZ1RmYkxwNkRQZW9K?=
 =?utf-8?B?V2RpVktJSDQ5SWJBd001STZFbi9HcVJDYnBudkV3SW0zUFBnc1ZQSXVtaFpQ?=
 =?utf-8?B?OWNSVUpqYk84Rnhia3M0OFhSTXVNV0FZM2dGNGlGWDZZeTdMZUpuajZtblN4?=
 =?utf-8?B?a3dNZEw0TUI3U0lMeGx6Y0t3UGl4UkFsd3R6dlcrMzlHL2VyNCtJYnlaWDA4?=
 =?utf-8?B?YXRWY3AwT3FlZy9wbWtiM2tDMTY1Nmg5anh3YmlKblh2dVRYcjZ5cmxWU0NU?=
 =?utf-8?B?SUJrQ0o1R2g0aWh5Ynl6OVFHc2hGZE96RHR2eWFHMzFzcGdNM0Z6YlordmRG?=
 =?utf-8?B?N3g0S1Y4MmpULzExa042NnUzQkRreGFpaEkxUWhoWllNTUxVZGhVZjBUelZH?=
 =?utf-8?B?SDE4STlnNXVEaHJIU3hxQndWZ1RwaFRCdEF3V2k4Kzg2dDJ3TVRYN0dEclhu?=
 =?utf-8?B?MTZ5cGdkYjlBbDBlK1JpZDVFS3FaN0JMaCtVbTVuaDVzeGhDSlJZV0tkU2Zr?=
 =?utf-8?B?SnBHdnl5VzMzZnZybTR1WmpId0szRnBjeTltTlo0SVVtSnVKZVNWVGpaZHU5?=
 =?utf-8?B?N1EvajhIRGFlVXhCUkZpaTRKZUlhSXA3bmlibjNVVGF6QUNObFNMeEVmM3NH?=
 =?utf-8?B?MEFSMGVWTndiQ3hJbXB3MHAreVFCNWZUcTliYWJ2TlRHZGpYVEQ4Z1hndDFG?=
 =?utf-8?B?VXE4aS9QazR1U1RCMDhwV2NhRThQQklEZmcwVjNiemJmdURzeXV0RlRHT003?=
 =?utf-8?B?MWtzTzF4aStxS29yaTVrK0dZQjZCT3NieGVGNzNQTkxtenlYMFh5Y0Nzb0c3?=
 =?utf-8?B?VWY5MWQrV3YvVTdzL2UrU09mOVBDRXhmSjAvNjZDbWhIb0ZtZGxLdGc1WnUr?=
 =?utf-8?B?UG1iMERna04vV3hzRk1JQ3NuWXhMRGhOZ1BkRTFmd0hhOXlOTFp2S2F1S1VO?=
 =?utf-8?B?Z2pYVWdWclJCV2ROTFhDUVlyYmY1d3lSdXREeFN3eVg5bTBVcDBsK1VYbXNn?=
 =?utf-8?B?OEJqMno2UGQwcW04WTYya05CcXcvRVNWUnE3TThBbGdUM1Zsb1pSSmNGVFQy?=
 =?utf-8?B?L2Y2VXBSTEZMM00zanZlS1FnQjFrakN6QWJlQ0s1NkZtUTBFMEo0STdsblNU?=
 =?utf-8?B?cE53ajBLVGFnc1YwUXBkWUk3MDE1anQyNUVoaUZOVjVEMytkZnhhV1BRbVln?=
 =?utf-8?B?aU1zbmhRRTI2Ukd6a0Q4eERRTzVvM3BVWE9Dd013cWlxT2MrTDNkQnYrd0xt?=
 =?utf-8?B?ZVQ4Mi9mUnVpRFVqVDRlYnJQUVpnc2lrOWc4dDBOLzNXM1F6bXNOMmF4QWxu?=
 =?utf-8?B?VFU3cGpBbUdWWlpPNk0vY1lHSnVjNEd1YVhCaitZTmZQOG0zNEsvVW44dnVT?=
 =?utf-8?B?RnRWQVpsd05rV0R4NytqYzE5WHdGVE16TW9CTUxLOFJWcUdaeStpdHZBQVlw?=
 =?utf-8?B?K2UwRjZGMHhRdkJKZ2lLSXNGbXlnWCtLODlrNXhjM3AxcDUwVjNuRlp5a1cr?=
 =?utf-8?B?aXBBbVJhUlU3SzFUZWRtTGhZK3pOODZDVG1vdVBndDdTbnlGQzIzYnlCbEcz?=
 =?utf-8?Q?H3F1n8Z4HffHJ1BBSzzxyFGIkFq2Gi1QO/JpI0OKBmp69?=
X-MS-Exchange-AntiSpam-MessageData-1: CXXLisDePQo/cA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d07438-1eb8-409b-9089-08df2997864a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 02:04:48.1244 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ZU6+ShV8XfX0RudfEBvcaZsCaeHgCUAh5oh3m9MENwOtoboMvMBpMbCBALUfbKD4YCWkEU9/xeLJ5sWN+jqZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6028
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

Hi Burak,

On Sat Oct 10, 2026 at 3:48 AM JST, Burak Emir wrote:
> On Fri, Oct 9, 2026 at 4:07=E2=80=AFPM Alexandre Courbot <acourbot@nvidia=
.com> wrote:
>>
>> On Fri Oct 9, 2026 at 12:47 AM JST, Yury Norov wrote:
>
>> > If you still think that you need 0-length bitmaps in Rust, can you ple=
ase
>> > give the clear and thorough explanation why rust needs those 0-length
>> > bitmaps. Are there any in-kernel examples? Any language concepts requi=
ring
>> > it? If not, it's still a NAK.
>>
>> I don't know of an in-kernel example, but please look at the
>> `bitmap_vec_new` test which has been here since the API was initially
>> merged last year: the first thing it does is create a zero-sized bitmap.
>
> Well, yeah: I wanted the behavior that the implementation rounds up
> documented so it can be recognized as intentional.
> Later, the `new_inline` method was added, which is a clearer way to
> get the largest non-allocating BitmapVec.
>
> I think the problem in this discussion is that we want to treat
> capacity like length, which is maybe suggested by the BitmapVec name
> and its len method.
>
> With the minimum capacity behavior documented, it is as if we have a
> specification right now that no IdPool instances can ever have less
> capacity than BitmapVec::MAX_INLINE_LEN bits. This patch here proposes
> to change that.
>
> It is not clear though why client code would be happy about *less capacit=
y*?
>
> In other words, why should the client of the IdPool have the right to
> control the *exact* initial capacity, even if it is below documented,
> free-of-charge minimum capacity?

The ID pool is used in Nova to track the number of hardware channels, of
which we have an exact, fixed number. For this use-case rounding up is
not "free-of-charge", it just allows to allocate IDs that are invalid as
there is no hardware resource to back them up.

>
> The IdPool, despite being backed by a BitmapVec, is not meant to be
> used like a vector: it does not grow by itself but client code calls
> grow and shrink explicitly, and client code has no control over how
> much that growing and shrinking happens.
>
> Like, you cannot grow to 65 and expect to get a capacity 65. So why
> insist on exact small sizes?

Actually with the current code you can call `IdPool::with_capacity(65)`
and you will get exactly 65 IDs. And if you call grow the new capacity
will be `65 * 2`.

The point being that in the current code the initial capacity is exact
for every value *except* those below `MAX_INLINE_LEN`, which doesn't
come across as consistent. All this patch does is remove that exception
for which I don't see a justification.

I think we are conflating capacity with length to some degree. Actually
the code does exactly that:

  impl IdPool {
      pub fn capacity(&self) -> usize {
          self.map.len()
      }
  }

>
>> It is also easy to imagine a user starting with an empty pool and
>> growing it on-demand. Having the ability to create a zero-sized pool is
>> convenient to avoid special-casing user code, and in this case I'd say
>> expected, just like you can create a zero-sized vector. Again a size of
>> zero does not trigger anything that a larger capacity cannot trigger, so
>> I don't see a reason to forbid it.
>
> With an initial capacity of minimum MAX_INLINE_LEN capacity, it is not
> about forbidding, it is that the added capacity already comes for
> free.
> You could say "not enabling" instead of "forbidding", but pretending
> that the capacity is somehow not there does not seem to buy us
> anything.

The capacity is not necessarily there when allocating IDs for finite
resources. I suspect that's where the misunderstanding stems from, as
Nova is using the ID pool for a new use-case. But I think we can agree
that this use-case is not particularly specific and matches what one can
expect from an ID allocator, so it makes sense to support it, especially
as it doesn't affect other users (`with_capacity` has no caller in the
tree at the moment).

>
> Do the other patches in this series need this, or can we just drop this p=
atch?
> If they do, maybe a demonstration of how significant the special-case
> handling is that can be avoided with the exact small capacity could be
> part of the commit message?

The next patch in this series needs this to implement `ChannelIdPool`.
The alternative would be to track the actual length of the pool and
return an error if `IdPool` returns an ID after that value, which is
what v5 [1] was doing (see `num_chids` in the v5 code).

That's the special-case handling that this patch is designed to avoid,
and I hope we can agree that it isn't a satisfying workaround,
especially when the backing `BitmapVec` *does* support exact sizes and
that artificial limitation is introduced by `IdPool` itself.

[1] https://lore.kernel.org/all/20260812-chid-v5-5-6c767770b3f4@nvidia.com/
