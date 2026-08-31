Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9E1DC61DE4
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 02:12:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96AF310E5B7;
	Mon, 31 Aug 2026 02:12:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="DLjQqy1c";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011065.outbound.protection.outlook.com [52.101.62.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B55110E5B2
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 02:12:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wln+TsT+Qjx1rnhHTp1NIaCfrF5gsK0sU9bT1qC9f1X+USdHdjQHcs2QORA2RD35SuA/81gHEP7JdHIP1z2gmhkhyMSonEjBXedndetC4UVL0LFfLNLVL2Subc4K/qmgd3RHWfWZvhDRGfPaGe5DDiB/XJbOYN9sFs5gVZXF7Wcn8GWcRZ7fhRTcwv4cgAhG1Nbr8/h6/4nB5s9TE4Dcs/5NzbYRKFt/5YaljGXR+QyrfzMgHHdD/ylNdhrRYpZkgCLOpfnGq8iWsVU7gxE4I9hkC/cMs9+VU8I0lmMsJNWO64Si+K6YpDo95YS0V4F4HuP3ldxo4Wa+462EA1f90g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUMxgiYKV+tWWC5RC4QUVuhnyLqK4JUAmu1clQFXwDs=;
 b=SzXE+sjd/waPlhIThbkK0Ais0/uBuW8jHePXf/Miqbl6VssSJ3iwRVip70x+E3TYwtGmDmNkRn2WY/U8x6QsxXlWmj6SMKRJutpnn5tR/ey6fbwnpPflAHYnx87dupTIcHccG5NY3XRMzAJ4E3hKokLusgghyaE8swnanaL6EdYGa4bdwaIXWAnpckuf/IVLnNi65UjE92TKIF6LxdO92hw4fHr+QVvIZBQMg2YP69l74IP7oiLWN1tj2gtf0AlJkX4mj4xGpnpWU1kzffzQqi4Ss//SYZxUSl+kxV5zEUHnK4UXEqMX8xJkgJSwmDkZUqT2DzjmCEAHsuhAfWE6fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUMxgiYKV+tWWC5RC4QUVuhnyLqK4JUAmu1clQFXwDs=;
 b=DLjQqy1cECJk0B3ZtQs/AMuJ/AmaEUou/8bzo105qp8hj4LxkgvxogwMpADgPxojIxt3S04fZBp3z05kDg9kjkkTGQWv7DTugz5BE6ojgyO/3mE0MwQbpuLq7yI8XvmYZ1WFBheyILaKYCecYk7+r1HkjGTVaECR5DQHpBLkSyoPGrXpU5ARQhEY67j3R4wkrHgfx3oSyGMq8nZeoXWEyn67sULa6Hgj1Vk+qhp9sNtXKdpDqgM5+I5Q/iwkhqr4X4Ya5C6SHZBQBut7mbU4CGnRI1eYmgcDn+1Avh8cwny7l7IEGwkGVcJ1HvUXSSbKwq3zk2NOH+/1bc5QBsX7Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by PH0PR12MB8100.namprd12.prod.outlook.com (2603:10b6:510:29b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Mon, 31 Aug
 2026 02:11:59 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 02:11:59 +0000
Content-Type: text/plain; charset=UTF-8
Date: Mon, 31 Aug 2026 11:11:55 +0900
Message-Id: <DL2RJRG4Y0SE.39RJW9A9IS5NV@nvidia.com>
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
Subject: Re: [PATCH v8 11/12] rust: id_pool: do not round capacity up to
 BitmapVec::MAX_INLINE_LEN
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Yury Norov" <ynorov@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260827-chid-v8-0-bc74c77d0214@nvidia.com>
 <20260827-chid-v8-11-bc74c77d0214@nvidia.com> <apMY3lO6LlEHP1Zr@yury>
In-Reply-To: <apMY3lO6LlEHP1Zr@yury>
X-ClientProxiedBy: OS0PR01CA0020.jpnprd01.prod.outlook.com
 (2603:1096:604:25::7) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|PH0PR12MB8100:EE_
X-MS-Office365-Filtering-Correlation-Id: 09c9998d-b23f-4979-69b6-08df07053ce9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|10070799003|22082099003|18002099003|11063799006|56012099006|5023799004|6133799003|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info: py2CK9EddKEP2jRSk9XP/BXHOwgboIyMxTsbP/K5GwlZTiK8aTYMa77j3U+8/peaW2PAVfdB/M8qewk1/nK5Yy7E+hm1ldQan3B8r3LiNfhp/OyJZE+zRQHEZdQt3SPL3EDnLi4jrjYwuSdZO/yTCqncsTw3XMaY1VYxYbz9gKl9ztQBaX105UX+3NI3jiQMnxAtpnktgTGEOmIC4xSg6Ieypc8weM6+4WePwkqicxzi5Vv46HofMjA/AJvAz1bioI5VLQ+f30/CnH8GnJJSsawvNFrfEOLyvNUJxJgGKsX+3TldjqLedoKxyhpWPQuUxy0rRSj6aT9N1vAzlZrhCifiku2BcIjLQOn3PIrV5qdpYErKrMlt4A1j0vtuIaKmNhfanfeMyz1NEXT6DMK0ARHmbuCPbTXRat8qk5SOVlnjpS81rAE0kovy6V3PiMvDF7GBzAg1+1KGpEpK4F0P1N9ib/rIEuS9DfBKee04y5P6Kl75h8kDDTSUZxUt2JeGNmDJkvLkIA971s24qdLIiKTBa6yXVMiU/7W3HeLgiZ0VjXvvi7Og398Y+dmOPw8EUOGuZgCKKAsdqc6N6yukkJMY63EFo7hqjNmZ/XOT97XLWjcb4XmkD7LDBmqgk+Ixh0QqmAbWldhqUQ/4qLZYz2ojIS8rPVlZEmTtAkDrqgQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(10070799003)(22082099003)(18002099003)(11063799006)(56012099006)(5023799004)(6133799003)(10067099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnJ5K0FEcFQxNUp2R0R3anVZdTlsNWlaeGxQNzYvTW5sNmZ2WUxKTWNxbGhY?=
 =?utf-8?B?eWpKR0ZCYVRINHVBa3NDL0JYOHoxQXRsOVRDUE80SGhYZ3Z4YXlyd09YQ29a?=
 =?utf-8?B?VDUxcFVYOFpkTkp4ZGFIa1czajVUdEo2Y0NlWloydThTZklvbnZENHA4T3BQ?=
 =?utf-8?B?WnQydFhuUjhzSy9aWktJbUlSckg0djhpRi9kVHcrbXZIM0ZBTWQrYzdyT0lN?=
 =?utf-8?B?K2JmWi9IaXB6MnUwNkEzamx6WFdmQlFRdGdEZVp4RFRidnlxeEdiM2FWOFhG?=
 =?utf-8?B?K1hNNGVjOWNxb1J1YW82M09FaEE3bmYxUmtWbTFTS0xPMEROcVI0cEE3Z3ps?=
 =?utf-8?B?TXFQT25rN3JISkg0WWNJd0lZV2JhZDZaRGhveFM0emdwc3BOU3NpQ0htbUJD?=
 =?utf-8?B?cU9XeWRqbGFDd2hveVFhNlpGRFBwN3VyYlFqT3MwQWR0NW9IRWVKYTFPeXpS?=
 =?utf-8?B?WDEzUDhBQzU4WTFFNkU2ZmdGT2RBNm5sK1BlaVpXNEtjeXhxNmsyMDl6YXJK?=
 =?utf-8?B?ZTFWNUo4bjJUb1FHYlEydklrVHNxblpxM0VwcStwUFBYdkIvOWFXUWpKc0Z2?=
 =?utf-8?B?YUhhMjNZWEgwcUc5UVRENkpzR1I5eUdRTTJyUmI2UGw3UlJ6aUlpRC9BY250?=
 =?utf-8?B?ckdKWEExL3pkajVxRzVnN2VId0x5NDQyZGliVVlzUGUwcnpxeHpERzA2T0Zx?=
 =?utf-8?B?dDFuQjlTc3NpeFpjb1FUVDNPVmlqSUJZNXI0MEFBNWRaMTV0a2hoSGR4WmVI?=
 =?utf-8?B?aFY2enp3STRHcm8xbENDcW5sL1hwL2lzaFJqaHA4WHY2SURYSWdLSGJRUDVJ?=
 =?utf-8?B?dmJ2R21aNWxNZXp0RWlYd2RZSVFlbGZCNGpIRXp0cmRGejNYTmV5RVVQV2d3?=
 =?utf-8?B?dyt1RlVhdFc4S0FqMU1OUll5dmdtRlIvMlV5U3VkNjFyRXptRUVIV0ZjRHJr?=
 =?utf-8?B?cmlGYWZwRHhoR2p6eW51b2Jxbm55MVJpb2pPTmdQWUYrbVFwTzEyTC9ZVnV6?=
 =?utf-8?B?RE5oZld1U2dHMThuWXRSUjRrdFhMVFBoSHZsVVFIUXoyd1lWU2pTTWFFUTlw?=
 =?utf-8?B?MG12UHp0UllNMnJjanZKQ3ovUklRckY0TDQ5S2JwV3RpVGF4NDB6cWhMT2FT?=
 =?utf-8?B?aWV1UGVYNlh6K3B6L2lkSTZkbGtXZFlWVkNoYTluRkxtd3VwdlcxNGpsUzgv?=
 =?utf-8?B?RHhUQk1BTU1VWVJHejVlWEUyWXg5ZWd0MitkajRCSEorQVNvSHZvOWhDY09G?=
 =?utf-8?B?WTV6NXlIaE5iTHJWZzd4dkIxV0NmUnl1ZWNqZThZWmlUQy9lMWllM0MyNUhT?=
 =?utf-8?B?enkvUTJPTnMxRFlsYXVUSm0wM011UUE1dTlEU0pMcDFTSVljVlRnekEzQ3N3?=
 =?utf-8?B?cExuemliZzByRVZHYzRwQzgzZ01QcnJiR2c3d0lqcU9mUzNGclpBTi95SCtR?=
 =?utf-8?B?ZGdCK3drQTlDVFdxYlVYaE5md1RxckZLamdOSk15THlCcWpGUHZ1SE0zZDJU?=
 =?utf-8?B?S2U5Nm1PdnhURXlEbEdvTlZlUnZub3p1K0xsT2o4Nnd0bUVvQ0EySTVGQ0M1?=
 =?utf-8?B?dWhwUGd6aG4rNGdhZjBoNFlKWlUvSEVqcVVjM0UzcjE4V0xlb3IrUCtIZjhk?=
 =?utf-8?B?bHNuWGhtSVM4TnluQWFNMW1qekgwdjY1UisrUXl3RVpNdnJnUGVuMWJwQ0RK?=
 =?utf-8?B?dTlvc2E5YnVKV0tZVTk4bEpsQ21ycmNPSmNwczY3c2dCbExaald0SUpwdEoy?=
 =?utf-8?B?WDJiS3VGTUlPdkk4TlhjTE9pUllHZTczQUtGNXRBaStNNlZ0aEFOeEp5WUR5?=
 =?utf-8?B?WTJROTN2aHQ0ZkJMeGNSZVRqRDE1VHJMSXZPbVgybmlkTGtnZGhFM1dnZElx?=
 =?utf-8?B?RElOYmF6MWRMVjQyVkNYc1dVR0FHMDNzREhBYW4rSS9VTlhyZ0NtU0UvMzFm?=
 =?utf-8?B?elhYMlJsWDVBOXUyWGc3QWsvZFNkaXdRYmtKK0FibXltR1pDRzZ5ZENVN3Qw?=
 =?utf-8?B?VVZQd1FNWHMvcTI0enExUUsxK2FCVnpBaFhYdlVKSkl0WUJGQjl3d3d3RUV5?=
 =?utf-8?B?dEhIenNUUklwU2dzaGExZWxvdWQxaUdGd1lJbzdzYVVYZUsxV3JkbzFUcnNW?=
 =?utf-8?B?M0N5bGZYbG5ybFZtTEI1T0lRWU5ib0xqOUlZWVUxdDlab3JTOXUrQWRBYm1o?=
 =?utf-8?B?SzVzS2xtUG84ZVJ2NTBkdktBUVg0bXBYTkJMY0JhQlVzQXczN0tXRTNWVmVY?=
 =?utf-8?B?UUFXNklJcy9XdHg2SCtpTVp1czZjMjFWQjM5SEdhcyt3eTVQdE4rTmczRUcx?=
 =?utf-8?B?Q0w2OEh6MEdDbGRjU0xoNCtDdy82aUVrbU51UWFxUWdNNW93YWszRXZnN0c1?=
 =?utf-8?Q?VJMUJ1l7gJTzyXpMVoBndlrfZWmF9u1JrUTW8y5wdaAsQ?=
X-MS-Exchange-AntiSpam-MessageData-1: r93F5F9POTY6iQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c9998d-b23f-4979-69b6-08df07053ce9
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 02:11:59.0176 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DYB6R9g0wimostAGbXRcN8XS/Ip59+6cD5VQDFT/7iA3kNJTnJm40WfONt5m0dfeoV6fZjNR//xo+GXDs8+MPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8100
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

On Sun Aug 30, 2026 at 2:37 AM JST, Yury Norov wrote:
> On Thu, Aug 27, 2026 at 04:28:39PM +0900, Eliot Courtney wrote:
>> Current code in IdPool::with_capacity rounds the capacity up to
>> BitmapVec::MAX_INLINE_LEN, but BitmapVec::new works fine with values
>> smaller than this and still uses an inline representation. Remove this
>> behaviour.
>>=20
>> This allows specifying a real capacity of 0, which was not previously
>> possible. This breaks `grow_request` in this case, so change it to grow
>> to at least `BitmapVec::MAX_INLINE_LEN`, mirroring the capacity floor in
>> `shrink_request`.
>
> It wasn't possible previously for a reason: allocating 0-bit bitmap is
> something questionable.

We had this discussion on the previous revision [1] [2] and the
conclusion was that it should be supported. Let me elaborate a bit on
why.

We tend to use `NonZero`, `Bounded` and other limiting types in order to
guarantee that invalid values that would otherwise require runtime error
checking cannot be expressed. The main benefit being that it removes
error paths and simplifies the code by removing footguns.

Here disallowing 0-bit bitmaps doesn't give us that benefit, it just
adds some burden on the user in that they need to build a `NonZero`. But
a 0-bit bitmap is not intrinsically invalid - it's actually a reasonable
starting point for a user that eventually wants to grow it dynamically
now that `grow_request` can support it.

That being said, you are correct when you say below that
CONFIG_RUST_BITMAP_HARDENED will make any query panic, but the problem
is that the documentation of the panicking methods does not mention that
behavior (although [3] addresses that). It is also not specific to a
length of `0`: if the bitmap had a length of, say, `4` and the user
called `bitmap.next_zero_bit(4)`, then it will panic just the same.
There is nothing special about a size of `0` in that regard.

[1] https://lore.kernel.org/rust-for-linux/DKUHJF1YTTY6.1XXC1L2SYXEMF@nvidi=
a.com/
[2] https://lore.kernel.org/rust-for-linux/ao2U1jNaT7waibJW@google.com/
[3] https://lore.kernel.org/all/20260828133543.2259029-1-georgeandrout13@gm=
ail.com/

> =20
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>> ---
>>  rust/kernel/id_pool.rs | 38 ++++++++++++++++++++++++++++++++------
>>  1 file changed, 32 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
>> index 06a4c71c4c6c..4f329249df9d 100644
>> --- a/rust/kernel/id_pool.rs
>> +++ b/rust/kernel/id_pool.rs
>> @@ -112,13 +112,8 @@ pub fn new() -> Self {
>>      }
>> =20
>>      /// Constructs a new [`IdPool`] with space for a specific number of=
 bits.
>> -    ///
>> -    /// A capacity below [`MAX_INLINE_LEN`] is adjusted to [`MAX_INLINE=
_LEN`].
>> -    ///
>> -    /// [`MAX_INLINE_LEN`]: BitmapVec::MAX_INLINE_LEN
>>      #[inline]
>>      pub fn with_capacity(num_ids: usize, flags: Flags) -> Result<Self, =
AllocError> {
>> -        let num_ids =3D usize::max(num_ids, BitmapVec::MAX_INLINE_LEN);
>>          let map =3D BitmapVec::new(num_ids, flags)?;
>>          Ok(Self { map })
>>      }
>> @@ -152,6 +147,13 @@ pub fn capacity(&self) -> usize {
>>      /// let resizer =3D alloc_request.realloc(GFP_KERNEL)?;
>>      /// pool.shrink(resizer);
>>      /// assert_eq!(pool.capacity(), BitmapVec::MAX_INLINE_LEN);
>> +    ///
>> +    /// // A pool at the `MAX_INLINE_LEN` floor cannot shrink further.
>> +    /// assert!(pool.shrink_request().is_none());
>> +    ///
>> +    /// // Neither can a pool with a capacity below `MAX_INLINE_LEN`.
>> +    /// let small =3D IdPool::with_capacity(8, GFP_KERNEL)?;
>> +    /// assert!(small.shrink_request().is_none());
>>      /// # Ok::<(), AllocError>(())
>>      /// ```
>>      #[inline]
>> @@ -198,12 +200,36 @@ pub fn shrink(&mut self, mut resizer: PoolResizer)=
 {
>> =20
>>      /// Returns a [`ReallocRequest`] for growing this [`IdPool`], if po=
ssible.
>>      ///
>> +    /// Grows to at least [`MAX_INLINE_LEN`].
>>      /// The capacity of an [`IdPool`] cannot be grown above [`MAX_LEN`]=
.
>>      ///
>> +    /// [`MAX_INLINE_LEN`]: BitmapVec::MAX_INLINE_LEN
>>      /// [`MAX_LEN`]: BitmapVec::MAX_LEN
>> +    ///
>> +    /// # Examples
>> +    ///
>> +    /// ```
>> +    /// use kernel::{
>> +    ///     alloc::AllocError,
>> +    ///     bitmap::BitmapVec,
>> +    ///     id_pool::IdPool, //
>> +    /// };
>> +    ///
>> +    /// // Grow goes to at least BitmapVec::MAX_INLINE_LEN.
>> +    /// let mut pool =3D IdPool::with_capacity(0, GFP_KERNEL)?;
>
> Please don't add explicit examples for creating ID pools with 0
> capacity. It's a factual error, and should not be explicitly expressed
> in documentation.

I tend to agree that starting with a small capacity > 0 is probably a
better illustration of how to use the API.

>
> Also, it looks like your 0-bit bitmamp would trigger bitmap assertion:
>
>  IdPool::find_unused_id(0)
>    -> Bitmap::next_zero_bit()
>      -> assert!(start < self.len())
>        -> assert!(0 < 0)
>          -> panic if CONFIG_RUST_BITMAP_HARDENED=3Dy
>
> I like your version because it allows to create an arbitrary capacity
> for ID pool, i.e. 4 bits. Right now one can explicitly create ID pool
> for 4 IDs, and allocate up to MAX_INLINE_LEN from it.
>
> But 0-bit ID pools must be prohibited.

I really think [4] we should consider removing
CONFIG_RUST_BITMAP_HARDENED, make the conditions for panicking clear in
the methods documentation (set/clear bit do panic, other methods don't),
and add checked variants to allow users to write more idiomatic code.
Bitmaps are really just arrays of bits, we should make them work as
close as possible to regular Rust arrays.

[4] https://lore.kernel.org/rust-for-linux/DKUKM1RPFDA7.1MBU5EY40OJ4J@nvidi=
a.com/
