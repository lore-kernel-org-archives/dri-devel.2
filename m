Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A08606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 06:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=WNGm6GEy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61CBE10E0FF;
	Thu, 22 Oct 2026 06:45:34 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011033.outbound.protection.outlook.com [52.101.57.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A0E410E0FF;
 Thu, 22 Oct 2026 06:45:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C0NC3Xla9WRggE4HQQeQnV+cKAwodgg7ttOJvn9OLu3Z8pX2I99K3u0lj3hqbPVeEBnEMhc7+Jmm00m2XDI9lsm309Kg/qknG9OO6z0cxu+SwOouCOWz+gJEZk3FGfkpyM+XDTjuBsaNDTdVVL9Dlq4aCgDKB88Uk9rLWVOCeIgt21Xy5Vl+pcNxx33BInlurNtQH0ZZdtl2uREBOoGC+hbroLJwBuNXge5cPZaUuLr/EY5wkwXIYwLXtUXBWIL86RzfVjpwtvXElwzqlDGXrvnq4AxJyXCPz4TJ2kJbPEPyXF66nhYmrA6QYX55WT9OKrVmKQFD/6ZpfEpBnNjhpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCjm+rY0oyeYaCguTIhjpJ2dbm8UcT+Mb2Rvy4uZLVU=;
 b=KWRa7RlOGE+24lUd8tlEfoLMCHuRaEgonCynQePdYu27wY33kETtWYSdPTx8fveGzchPbw6rtQQDlIlSs6Js0ddiubdVSzcu/juatX9AtA0+xVC7uxND43OWJ0rb4C+IB4/eZ6AAYwWNTCmcK7nU3/ysPP3Qd6UH9TBPjLr/YBCixudUqGUJ31VLKfuw8IWPjFKq+sgaVFUWx1UwOextlhx1/ecW9UI+xnMBtluWDvapOKxxJSHOghSURqzSkwKAuc39RunNfNG7MOXvK02x+SSbsceiYD5jo+xB/YsdnY01IARZZrLWRGM1y8QRsf8vcwqXowwymLlOoFQypjTMpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCjm+rY0oyeYaCguTIhjpJ2dbm8UcT+Mb2Rvy4uZLVU=;
 b=WNGm6GEyK8VnM5+DAuZZjYixQKuyzxYF+1WJxQoO565rU2BKodb0aeRLQs7emdgQwidB73imMfVBZBg0fy1uC2pGuiKRd/v8z0hP04dFHAZQaox19bzqGs4FRnc+P46o2GH9fVuuHc2EEeJf0AYppUQ1m+b7QDhja9tW7ItbOjCIlaKJDEYJqmVtL0wjW9VCG8jYtDO4S8BxKjKbwAnIZhj9MODjcI0VUrFoKdmZhb3jjYqxYNas86XN1XhtDIZl8taWVQpkhKJeiHDKHKhZ7itbwx+i4D7aAneSp1JDN5pUwKeFdNnqxnm1a+xRMbfEpiThfJ0vOW3I+Zdz00Knhw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 DS4PR12MB9745.namprd12.prod.outlook.com (2603:10b6:8:2a9::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15; Thu, 22 Oct 2026 06:45:24 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0522.017; Thu, 22 Oct 2026
 06:45:24 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Oct 2026 15:45:20 +0900
Message-Id: <DMB5XFL1A5I4.2JGQ6SMGQ32UH@nvidia.com>
Cc: <sashiko-reviews@lists.linux.dev>, "Danilo Krummrich" <dakr@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>,
 "Gary Guo" <gary@garyguo.net>, "Alistair Popple" <apopple@nvidia.com>,
 "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <ojeda@kernel.org>, "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v5 11/14] gpu: nova-core: gsp: cmdq: use consume_element
 to implement drain
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "John Hubbard" <jhubbard@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Alexandre Courbot" <acourbot@nvidia.com>,
 <sashiko-bot@kernel.org>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261020-cmdq-rpc-v5-0-dceeb8f360ec@nvidia.com>
 <20261020-cmdq-rpc-v5-11-dceeb8f360ec@nvidia.com>
 <sashiko-outbox-178822@kernel.org> <DM9QI47QSJ0L.2QMRVD4AP5WIV@nvidia.com>
 <DMA6GSC7REE4.1OL8XYR8JKJ3C@nvidia.com>
 <2cedd65e-514e-493a-a8dc-cba683c84fea@nvidia.com>
 <DMA702E74W05.2L7ZRW1M6H3NM@nvidia.com>
 <c19b1cea-0a35-4889-a36f-891f0d9fcb13@nvidia.com>
In-Reply-To: <c19b1cea-0a35-4889-a36f-891f0d9fcb13@nvidia.com>
X-ClientProxiedBy: TYCP286CA0133.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::20) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|DS4PR12MB9745:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e3d90bf-84ad-4ffa-075e-08df30080caa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|23010399003|10070799003|261021123027099003|56012099006|4143699003|11063799006|22082099003|10067099003|18002099003|261021135927099003;
X-Microsoft-Antispam-Message-Info: VPjIEEkJB7X6bs2t6qsTsUZ0oYIwCHPaks7ph5Gxjo8SVdfIpclznqTIoYeSiSOjlM2aGZsPBBLmy8drUpaqHU4Z9uwXfm4IuvufgmVmeWQ9iFi3AJklGqJeAc9oezhodw7aaVCouLTgGOLbyvpFtFiBSQdvgTYuu6NC9QcmKxL06Z6Gz7nmRS2sUTqXQyThMJ/mRgpOb3JtfpWZtWpUrL1WJVpHG6tE3Veb5CRlqd65508MtR0eMb+IhfVPOoAbK3OVtBtu5aLmFtAvcnZ3G6EVybkjgx1ZEORlYoWFTL8fNSWRccenYTx9od8jHY3NvFVcr9aMYF46tVQnjBQm4jKbupwXescmx6YVXmnFwPzrY6FiJg1A+w+rxeTWd3vnXu4FwX5mgyqRN2DNufpu3R9SU9/VPoxk2Bz2kvBzOUhe8wZkmLQ48U/VuzAKDqq2RPQIoaP6h7rmxbPhLHjNwEBTgB0g6UaujGr/5/yxRcBJMCueVJbDYfyWp2beX0D9ZVmpdq5Od4GxxJ+cAKaphiZTYtAECiEWOwYNBfpnFNEEKD67NeXX6ea0wr22A+WVkz2U6RPL5QPOQGUWX4Vs8JASTT1kZGMWelavgULxaHk4gXYeysIHgFFOgFR/V6/a93DOiLg2g7XzrB7Ae+UtFzjbiUqh6uV54J5wpTPwKD4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(23010399003)(10070799003)(261021123027099003)(56012099006)(4143699003)(11063799006)(22082099003)(10067099003)(18002099003)(261021135927099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STlYQzdqTEk3cjFMalRXT25BczNOTW9jUG5jV2szTURXMHBoaTB5QmlMam12?=
 =?utf-8?B?NUdWNndpejRnOHhYek0wNlg0dWRlc3BiT1ppNjBra3F6VVJEWS93RVJYWTQ1?=
 =?utf-8?B?TEhBSFFVT1o3cmRuQWFWVWMzc243QXpMVW8zZ3BDSU1BWFArM3VPSlpMTE5K?=
 =?utf-8?B?K0NVYkVTZjlaZHQ0R2FpZEk0YVBjY3dKcWRCTENSQW9sbFpEbjBEdzNWMXht?=
 =?utf-8?B?SmVUYk1ybXFLSm1MVXR5WUk2T1RTUGdRb1NaVEtaVS9kTm9kV0EwdmVDR0Zh?=
 =?utf-8?B?ckF3TExiUUozTHZDYW5FSjdvdThXeGk4SVg3QlNuUkNHRTJNektRbFFxZ3po?=
 =?utf-8?B?c1FEQ0lJOTZJRk4vb3pUSW5vaTBiNmpqY1BvWjY1Q0NITjNlcTVzUjgvaktJ?=
 =?utf-8?B?STBnVjFhN3hINldldGVxZlIvbndvcThlRWs2cXBCTHlWcWI2KzdtbVZWVlky?=
 =?utf-8?B?dzhHejZHNm5QN3VSemxhSHdGeVVyZ3JJc2R6RnJEZFJUSVdnN0RGZFNXbVdl?=
 =?utf-8?B?Y3c4SFFvbnV3V1luVXY1cm5VdmRmSkdXK1NDZFd2MEtmK1JJMnR3NzdYclpD?=
 =?utf-8?B?VVlDeVJWbk9JRkkyMC9ncklpWS9ucndhbGNyU0FYWnhjNFJNQkNJaFlKb1R3?=
 =?utf-8?B?RW9TY3BoN2laelhoYWFTdzhBT1hXNm1xRUZRZGVwNlpQQ3kwQ2w1QlJ6eHFw?=
 =?utf-8?B?RjZHZXFsUnd1bW1WVlUrODI5VWtoU3pQL0p6b09QQ3VVdWZYOFdGQzlYUXdh?=
 =?utf-8?B?Z3lyb3J3d2MxVzVaTXcvNUs3YnNBbGMvZFUxSDA0RzArVkwwSmpBUkJjcFNn?=
 =?utf-8?B?RDU1STdjb1pHbE03K1NPbUdZM2ZlMktRaTExZUNHMUUxRzBPK3diMEJ4eGxF?=
 =?utf-8?B?Y3d1Vm9uVlIrdEdQdFVhcllnVktOakpTUUlBdndWNlAvSzE3RHZYc0ZDODJa?=
 =?utf-8?B?NXB6YnE0QTFQV3F3K2lXc3pPeUxuazZYaGFDQStkV2ZrZHZxN1Yxd0dUTDZQ?=
 =?utf-8?B?aEg1L2VIYUxXbXplVkpHM3VMendsTzRVY1dJVFA0ZjRYaGFmczdJZ0tUbDhB?=
 =?utf-8?B?Tk92K09Ma1JJNTAwMzJ6UlViVGwxdVZ2bllMNENWa1F2UmQwTVV5NUYvT2Nz?=
 =?utf-8?B?c3RHOFlDekt1Mk53UGpESlpmZmcwbVFvSGQrZUlHK01kc3RSQ3lUblVmRTc1?=
 =?utf-8?B?Y3AwVjVDbHkyRG85d3ZGRlZsTTExbkpjcVlDNWI2RFRUR0oxQnNINkZFL01Q?=
 =?utf-8?B?d2NTTkxTaFpLM0hrRzBuT3NTRG1ESjU2LzZSWElxSFF0SHdGRUNPaWJFbzlM?=
 =?utf-8?B?NXRDdktlUWhLOFpFOFNjUFNadnJRT2ludS9MZjdDM0w3ZFNETjE4Vnc4cTc0?=
 =?utf-8?B?M2tzZ1lJL1Nhekd0YVRQOXFsNTd6dnVBUEVjNktQNGxqQ0ZKRlJ2T2h5U0hz?=
 =?utf-8?B?MTdIRURxc0owQ0dmdlpjdGRkZjZLNXR0T3MvQjFwbi9ZMUkwdmwzWENlL3lY?=
 =?utf-8?B?b0t3dmVaZk4xcEFlNm1rTmt4aVVuVCtXNC9LTGtTdWZlMHNBVXlRa2ZqQXU2?=
 =?utf-8?B?RERwMXZzclNMTzdFYXNyc0NqTS9RNFRXK2FoWGpkcTB0bG5sTUNtT25zTU4w?=
 =?utf-8?B?NnBOcHM2RmJ1ZW1lMS9tSFEyZ2hEU3VZU214WTVkaTZLK2twVmZNRlNIUiti?=
 =?utf-8?B?dUYwOTFrckVIbkl6S3ZtcnhNcmRvK1VTOG51OWxSUTlxMjhDaXphdUZaakcv?=
 =?utf-8?B?bVl1VlZMSDByQ0ovWDNXa0s3RTRLS2YvR1k2Y2NLRStsN1ZmZHV1eXVoYXZC?=
 =?utf-8?B?ak1aMXNpTW1SdlJLVFJFR29PRjVpS1JMZDU4ckdBdFAvTktsbUVmalM4RFRw?=
 =?utf-8?B?YUswT1NySmtuR2ZheW15NFgzWjVjU2s4Z1ZxQ0Rwd1lDMXlPYk9nNWVvTG5B?=
 =?utf-8?B?MVprYmZkRWxPSXZXWDFsTzZqKzRPT0cwVVBQdU1FRjVaZ0ZwQkV6cktZMmxz?=
 =?utf-8?B?dWJQZVFiTjRZbndMVXVXZ0xhT3htbzVFUWJPZ2JZdlVNRmNEYWg4ajliVzZX?=
 =?utf-8?B?V0U1Uk1EdXA2MVhXakhWNHZtYlV3UnRzS2RjTTdKTDMxTU45TE1xcFhGTGNu?=
 =?utf-8?B?VGFoamwyanpWSlNQYWE2c0dINmFSWmpMTGgrenU2T2MxTG0vV2VSTWJ6OGR0?=
 =?utf-8?B?NkdnZDJDR3ZhK3ZFY25JZnNuaVFyK0JKb05oM1BPMVVEbHZyck56ZHovWUFi?=
 =?utf-8?B?TnFKRmdmcVF1ODArUURwK004ZjdreFN1ZjUyOHR5NTNLNmt2bitjUHdRQ0dY?=
 =?utf-8?B?cjI2K3YrNWhyN2Z6WWRNODBZUWlsQitlOHllWUc0NmRFQ0xWUU4zM0x5OVV3?=
 =?utf-8?Q?i4DUCEm0C8Hq/NPxD2lOs6wbayFYFSlbpt2YX5CLxV9Kx?=
X-MS-Exchange-AntiSpam-MessageData-1: P5P/98+FDTm/XA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e3d90bf-84ad-4ffa-075e-08df30080caa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 06:45:24.1655 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PGOI3qs4b+nIZY1r+pMRE1ox2BITcmUHnXqKElwhIJxTxQUOIwtN6b5sHAFbo9PMEilvQALlMq3vbeo3ZW1Sog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9745
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed Oct 21, 2026 at 1:05 PM JST, John Hubbard wrote:
> On 10/20/26 8:23 PM, Eliot Courtney wrote:
>> On Wed Oct 21, 2026 at 12:12 PM JST, John Hubbard wrote:
>>> On 10/20/26 7:57 PM, Eliot Courtney wrote:
>>>> On Tue Oct 20, 2026 at 11:27 PM JST, Alexandre Courbot wrote:
>>>>> On Tue Oct 20, 2026 at 7:18 PM JST, sashiko-bot wrote:
>>>> [...]
>>>> I'm also fine with special casing `wait_for_msg`, but personally
>>>> (maybe) sleeping when you set timeout to Delta::ZERO sounds busted to
>>>> me.
>>>
>>> It's not necessarily wrong, depending on how you think about it:
>>> "sleep, but timeout at zero" is something I've seen used (I forget
>>> where) as to mean "context switch away", kind of like a cpu_relax().
>>=20
>> Here, it only sometimes sleeps ("(maybe)"), depending on the resolution
>> of the timer and how long stuff takes. So it's really pretty
>> inconsistent IMO.
>
> Yes it is going to act in ways that look non-deterministic. And that's
> OK, because:
>
> a) It's not broken.
>
> b) It's not unreasonable nor even terribly surprising behavior: one
> can reason about it.
>
> c) The requested behavior itself is impossible: "do X for an infinitely
> short amount of time".
>
> Why are we adding code to optimize behavior for callers that should
> not even exist?
>
> thanks,

Yerp you convinced me. I also realised that we can't just change
`start.elapsed() > timeout_delta` to `start.elapsed() >=3D timeout_delta`
because it could end up not waiting enough time (due to integer stuff).

