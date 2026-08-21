Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB98C5DF87
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 08:31:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9664110E28B;
	Fri, 21 Aug 2026 08:31:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bz8/KIbx";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010071.outbound.protection.outlook.com
 [52.101.193.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A77710E28B
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 08:30:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vtlUg0yK5D//7s3hy1JV/upNoFvU746DCpVRU3UBftlSia4fOroxtK8LMXAuBso+ks2RcS438KcRfB0efHhawtY7NX1MRbirHVZeqeOHFnfiZnpmMo+0dS4XAFsODZ2xy/5sXKYsFp5AO8duWmMpKHAANOyzX/xC++1PmuS0cDiLqHRb6Sa3wAJU+YAgJNLXkr9u1k4hhNtG8oap73iGnUvMKRok1ieW4z7p6UcdS9elJqBXKbcuq4BPLbEecHcPTJY6/myNBKinCvGy04N2JP4Ptj7McqsNAyVN6eXEyG72kILM5kvXyPxS59Wx+Sh5Swp/bz8jQlMLKfoGZZg1BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lIk4Sncg6ejmNc7EtarqYNBuLCS7Z8u5VE87YBIeyLQ=;
 b=DhYIZksKnHrvZhB9LXH/IiXGeFmBI9eH0YG6Dte6kR/FQL48GktZrxtkK9NfPbhclVGEjbxCIJT2FSSJHNMKWpPOY14cWjC/qbPTfNzgQQf+UEO/T0U0e1J1w3tivNzHzcz3R135SEN6MkntPv1Zp4xPi2TnQM0vzWGEd7bNVNLRO91h+1sijkkg33Equ0zlkEOaXakMfXRJmzBXplqQJql1PsMOGnT0UemW2u+aNXKyPJnMV2Un8vj8xw8kjM21Uo8F/VAwcfusgE/e5XB8LFmSrnjGXl8W6sv7g08yeItmAyHjt0rp+Wga19rxs/4v0GomLNxi6qEXjX6FsOBrpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIk4Sncg6ejmNc7EtarqYNBuLCS7Z8u5VE87YBIeyLQ=;
 b=Bz8/KIbxEXgl1lUxbpGBFwHPiwZJZd2LaEenFOM7TZwfd3rF2l2FA51J63/UbSxHMngdLabvnV3iNVlE6V6ctc2TviKx8Y+rALUnB7rUkrmWF8gPjhlTaIRneBOVzu/TUJ23ksDpdjsP8/2IkJ/DswmZ6MwRsYGfd+D/Wz04rrgS1x7/f0Xmen91xHOOck9mcjuGV4TS6n9igfvnJJn8XHBtrQQeswg24xxNHnFFf9Bvv7/DCVE0UWxNtYFvCIKigGdGJfDL4fjLmnzDdRhx38ZGVod4olxFb9Yxl7e6RkPPCeeetMseKSmZNNRHcx8XK99AA2dm2gv8cr3/7Jgpmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH8PR12MB999206.namprd12.prod.outlook.com (2603:10b6:610:35a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 08:30:51 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0339.007; Fri, 21 Aug 2026
 08:30:51 +0000
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Aug 2026 17:30:48 +0900
Message-Id: <DKUHCEFY1MDD.8J8XDOCEY59D@nvidia.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Burak Emir"
 <burak.emir@gmail.com>, "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v7 07/10] rust: id_pool: add contiguous ID reservation
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260817-chid-v7-0-a5872e64d8f4@nvidia.com>
 <20260817-chid-v7-7-a5872e64d8f4@nvidia.com>
In-Reply-To: <20260817-chid-v7-7-a5872e64d8f4@nvidia.com>
X-ClientProxiedBy: TY4P301CA0027.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::9) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH8PR12MB999206:EE_
X-MS-Office365-Filtering-Correlation-Id: a6e51ce5-14c6-4e15-6463-08deff5e823b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|376014|23010399003|366016|1800799024|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Ga3J+y2EV3AzXM5Y1lzV7o4VKQYEbIfT9KVvw4HfKMeVkpuyQ3ifHu7zGzwuVlOKJ6LjAb+PvdeCdZrjWFlzYUwIpcn2W0yQyurcnbiG5lwJHvZ1znAhdO0mQglaPufcz6CkKFfO4WZORzSII+dmn1Io2eWlOxP/XfwFOgw9LM1F/trRLPnxJn4dFFjWGQ8EYPxUzhvC6iv1uZ7qSrTUinjsBfoEpTe+xHQ3kqWuW9Xv7uW5A1yBh9+tH8InRqzylGclaZyN8Zfc8Ez5Q83wUX0I7hDn297zW8DeWruFxQ3209/vgdaIvG3K0W6TT9r26R0j9cEyv0rCCCe0vQ65UWm6JXwKoyW5VvbIIyhr8TdcqihmJckamr1iOJMfQugTjDxCiWGnFJPGjZcWlehg4nUiEerHGsYZI4BaEPqYjntgJkrQqOhKRmlde44+QRamALrihU6fjC85WIevytWAjeSIZu5s6W7I7i5x7Ey2UsSm5SHeWeuONEb09RSaMNdrCS2KF3qThzITx+/H1c6PtaJOU/qr60AytPAJeMMC6RppiyrsQg1pfzFv59KYImEvyovfPW8aKwXsX8olCQz4T8icsqv6sLWYHAMMFTtT+JbjmCqDQnKtl+U7RelTcyEUYwrUQjlteEjfY1A++JLwF1yQa4IvDdiqng9Jb0Nl0uM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(376014)(23010399003)(366016)(1800799024)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWkrMGxmcVM0bUZ6UUR1a0FoYWhDTXg0dlcxUE0vVTlBUDYrNUt3Yng5TlZJ?=
 =?utf-8?B?TzdKbE5qeUVXc3hSald0VW13MGltRTJOdGVZRUhlTHRWTE1UQ20rOWVIaGx6?=
 =?utf-8?B?eUZkdXd6TC9oQ3VPd08ycFdGdW90dHRJVUdSNEE4cXN4Zk1pYnJ1ZnA4M1Mv?=
 =?utf-8?B?Q3FOcitwODBjUjkwSE9ndFd2ZjZObTVaWVZJZjdvS1JCWGVhSUdwR25Uemhl?=
 =?utf-8?B?SXZDMlhGTDNOZkhjTlFNZDZBNXcvMXV6dkJiaVRsbktGUnpMUlVqZDdwd1BY?=
 =?utf-8?B?Z2NUVUExN01abWMxMlF0eVkwS3hMN2NjNFNYRGdtT21QcmE2a3VXOHFyU3hq?=
 =?utf-8?B?SkF0a20xcTVPaWhWbmtEWHlXTFZSdUhuTVVLSHNMMFdHb2p1aGwzMEo2WkZn?=
 =?utf-8?B?ZlV0bUdEcFVRdGt4RndpMzhaRm5DZUNxeXExUmJ3SGNxM0RQRDBDeG5wSFJU?=
 =?utf-8?B?VGFtaWZaa2FvU2FoWE80bGh6eEhEZEFIS0Z3Zjh1SEhacG5xSU51ZDIyUktk?=
 =?utf-8?B?T01nQ3lzbm03eWQ0d1RQMGhWUFNtakJpSmxOVm9JVmN2QlNLRkQvVXRuRXhW?=
 =?utf-8?B?Z1pOc3dKTXlsc0pWWkNoNjZqdTJpZFBkNVo0SEEvTHZvVXFCdnp3YU9odzhM?=
 =?utf-8?B?Q0U0Qmc3aGlJOWNnT1AzSmlscHkra1I0ekFZdC9iaW40KzQ4anNBeDBicGg4?=
 =?utf-8?B?dnlPYVlYMFB0WGE0eUw0UHNsOWgvc2MySC9XSjAyVkppZEY1dFpWL2REMHVP?=
 =?utf-8?B?aHJMbHBsK0x4bmRsWis4azNheUdHaEVYS1FQc2l6TlRKaXVhaTlRcDAwbGZj?=
 =?utf-8?B?bC9WcW9CS2FNbTRZZTZrRE95djhaK1RGbjloaWNZbkF5bG94K0Fua3pCUTRr?=
 =?utf-8?B?VTZtcHFBSkpmaStOS3A1bWVhd0o2azRDQmRFRVJTN0I1NTFQdDVacE5EcHdx?=
 =?utf-8?B?S1NwVHU4TWNJTVRZZitTZmxtbGlWVXlaL1hMaXA2SFNKSkZscVRoN3lidzJU?=
 =?utf-8?B?OTVHWWp2TG4ydkFvRDFkQkk2NWpxYTA2bkMwNDZadTNBNllxTDlHelJwZlU4?=
 =?utf-8?B?SXVyaGRmTmdTSnVCd0oyb1FETDZXM2NwT2c0eUVkQStjZTdHd0diOCtCWVZk?=
 =?utf-8?B?Q2ZkNWlsTmtjQzhBaUFpWnhwd3NaV29oMDI0d1NqWEJwTWwzUnpzZlh1TExO?=
 =?utf-8?B?WXZHcEJId2tTRmNMaXh0dWRuU3VtbWkyWDlYdEl3YWZFR0ZMY2t3YVhRRURE?=
 =?utf-8?B?QWIvbENvMDZ1WHp1WWdHVTN3OGRLYkpvSml3SjVZWmQyQlJNWDJiTTlzeU9I?=
 =?utf-8?B?RjUvRUlFT0ZuQ3UwYk81VCtCaWR6U0RvUjkvRmdMc0Fva2MrYTl3L0Z4SURu?=
 =?utf-8?B?UkZ3Y2ZVa0VCUmJWbVoySDkwOVA4TUNpV212eU9XWTg1MUN4cTk3ZHcxdXQ4?=
 =?utf-8?B?enJVYjdwdTZqNjl3bXZVdXFnUzB2QWV4VU8rVzZjRFkxeGE4TFVXSXhjMkZn?=
 =?utf-8?B?eDNITVFUaHRlZzdrTHp1aVJ5VGdRMzFZUmozY04xVnI0QlA1RWhyclRSeUxs?=
 =?utf-8?B?THAvZmtTb2tldWpxcVZycVd2YlJqYWwrTmllRUsrNSsxZjJLMkRLZGJmQk0v?=
 =?utf-8?B?QmJMRnBaa05pS2Z6N3J0RGpTSmQ3a20wdlgxaWlySVp3ZmNvZURRbHFlejZy?=
 =?utf-8?B?OVFNd2FKUUl3cVYyckNxMWwxUVYrUGxSZVVlMDlHMnMrUkl6Ly83UmNYUkZm?=
 =?utf-8?B?cXM0SzNtUU85R25NNGwraEU4MDlKRjRqQjhqS0Z5MUU4YVgyQThFdUpHdmZQ?=
 =?utf-8?B?bk5sTEVEdlMrZzlwelFEM0I5d0lwNzNzd1A4aVNib2cydEQwTmNSQkhLUTRu?=
 =?utf-8?B?UU12UGRvRXZGOW05d1hueEtreUlmVmM1eUVpUm44cDJHRnpzYm1uM09iQVRw?=
 =?utf-8?B?aTVvRGFqVEV2YXc5MndDWHE2UUxoVExJdThHRE4wWHl5NkZPZ1dvamVtS3Nr?=
 =?utf-8?B?dEM5UlQwWVdoOVpYM0JFZWU4V0pPelNBYnJpeFNFckpXNStSRktWalhmc3Bt?=
 =?utf-8?B?TjQ0NzBnZ2FkOUljeFpYMzQ0WnhmNGQ0UkkreitsazBiZWUrY2dvRDdDNFdY?=
 =?utf-8?B?dGZRNEd1MHpLQUpEdWlpZFF0SWt1eTFnc1V2alBFcUJTbWdOcTlKaFB3T1Fh?=
 =?utf-8?B?VVY1ZFc0eVFwNnZuZkFGUXArR0Jrcy9HM1lyMmppWTdRN0hTRU1xYTRjOHBi?=
 =?utf-8?B?RzdqYlBKdzJVQ2wxNUtBeWtoRFUzMWJUREFWTmdKcnZkb0Z0aERyNUVmWWZu?=
 =?utf-8?B?RXp2YlFKdXNRSkVuMVdQT0YvS1hKanBva09uQzVhbGc3Y0liczVvb1RXY0d5?=
 =?utf-8?Q?KTKWNmV6Bx5Gy3RSH+3jUCgO979PK4e2313p6yOIMYWkz?=
X-MS-Exchange-AntiSpam-MessageData-1: 7IN4obR7qlmWUg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e51ce5-14c6-4e15-6463-08deff5e823b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 08:30:51.1561 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qjjjf9rhdidpaac15JneavpTbD5lXfEP/TCIUoei/gWquRmG8SCePhZF93oNOQdI6z2vCse0slLsKLB2Ednhkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB999206
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

On Mon Aug 17, 2026 at 4:04 PM JST, Eliot Courtney wrote:
> Add `IdPool::reserve_ids` which allocates a contiguous range with the
> given offset, count, and alignment.
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
