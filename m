Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD7AC982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 23:14:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05EF710E0C4;
	Mon, 21 Sep 2026 23:14:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="LMfaUS4X";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012028.outbound.protection.outlook.com [52.101.43.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCFE610E0C4
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 23:14:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fk45T0QQ5Qj4SYRh3Gdxch52Buvu093cCXCG5KlpATmDD+Pb5sHti9nbJ7Jr9ZvQia+kIwrFWEMhomLw+CIvtHBmdxlpiruIsq38k3R0mPcdxshQVwF/Q/apZEzpgdSgqMLJOcjpn52p0jJFdbenu4lYn41oet4nio26DaA+Y3s9VnejTkja/OW6ZJaLYlzeoU01InKV7vA/H8zeXTII5oJpM2knvXQ86e7Osv6WPOe3oj9/0r/F6oYhUbfmfkoPweywhAK6qm9QOeFnlcWUu/ijXdH0XCGVIBSP4/gOMWS/jJhNTep1GqYzy+BI1vs5IqPDRCDI8DQj1i00GTCR4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ESal+K+R+ZhHuIYZ3jiXpo4fpALZFbeV2UW550wuhU=;
 b=c65RyN19KIm2KbrVXYCJfYtaOgzvGkpV7PJ4ZrKh8nZfvnSPCe6UT5vMaA6dnFYkST2Xv/bjkDxhUhsov0oEA0xrnDmk4rH/VyBsAum9IO+y/01d7hD7ITgKmeQojtyiRKbN4k5/e9Tg2RMyeR4zjtsRGPeT9VqdbUS6HlxWbCUwFl1qHfyrql1ErEC10NNqTqQm05onqup6P4BLs/RPEFq3Ng1BLqJo31QilXLnizdyRJgKbLnaL1UUFeWXvEXAPP2fAyjU4EORcqibkrKsS7IPtz8howzlGW3IchC4vmaLNvOUckbO2L0uNnS5Y+bb+MmOCqDNJN5mZca9l8WJjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ESal+K+R+ZhHuIYZ3jiXpo4fpALZFbeV2UW550wuhU=;
 b=LMfaUS4X1z7gYCIG+EraxntYFvFFjL7VcdYtdlwzRVedlFe0uu2GsQsijIgHH938LF3c1nQfQw+4ooWrdMPYSXCul8EoVEGYEdEXuYd9dG/ZUGREYwaj1KBs/JBeJe5mJtdMp64Fx5P1wuSosK22H8Dsa0NR9QSUdyy5Agzci+a+2NgGcUoZTSJ95Ll14cyYnIyputzKSC6+Edc6lmEVK/7j8X+xCis+bs63bYpQh5FX6JbQFJdAaDa9XbnwcBwxBdY8OaO6rWu3qwgbKxJ1RNzUO8Z4XEwCOIHL+5v9ix83cm4k2axe8rNFqf/eZXBTZu6+d+JSFptvkiNQUEJLHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by CH3PR12MB9251.namprd12.prod.outlook.com (2603:10b6:610:1bd::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 23:14:11 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 23:14:10 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Sep 2026 08:14:06 +0900
Message-Id: <DLLDJLPUZGMT.1JPALHEPYP3YF@nvidia.com>
Cc: "Antonin Malzieu Ridolfi via B4 Relay"
 <devnull+dev.nanonej.com@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 4/4] gpu: nova-core: Extract PFALCON register
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Nanonej Dev" <dev@nanonej.com>
References: <20260826-b4-extract-pfsp-registers-to-falcon-mod-v1-0-38351df09084@nanonej.com>
 <20260826-b4-extract-pfsp-registers-to-falcon-mod-v1-4-38351df09084@nanonej.com>
 <DL06EAP0GF04.2X3P68IPD0Y7X@nvidia.com>
 <kIdb8vQDIzXcbzWMhRY98VQbxMOEgAco-4AUdcK8u3YM1WP8XCjdrqTEGfj3PKMcahDDiizBwLFH6JwMlcUxuIkjsacGqNd7W8YJKeRqmFA=@nanonej.com>
 <2jQVZV73cgrJOjnRVQ-gT1k4iBhKks2rB7H2doPH0l4zkbumXvnyoLEIFmATkIhpfwxRBwOFClJrf0f_iM7-mHyvYFbgyXt25Aqqp50vm18=@nanonej.com>
In-Reply-To: <2jQVZV73cgrJOjnRVQ-gT1k4iBhKks2rB7H2doPH0l4zkbumXvnyoLEIFmATkIhpfwxRBwOFClJrf0f_iM7-mHyvYFbgyXt25Aqqp50vm18=@nanonej.com>
X-ClientProxiedBy: TYCP286CA0231.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::9) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|CH3PR12MB9251:EE_
X-MS-Office365-Filtering-Correlation-Id: 2be12b81-d798-4ce7-f52f-08df18360af2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|10070799003|376014|1800799024|10067099003|56012099006|18002099003|22082099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: YRfiG9tsYQrpqE+CTrMfSGq/vG7J5byslZE7NJBjmAVAXMeUhujyJ4qFC1KyY6ep6dPas/cmS2MsRYYrZzbagyZNbZlNcJgJbnQVh7tEMTXTcZxcthT5t9g1rMqAQTiy0MpvGKXdUIJESXRk2O2HWhkJWRo2jpEuTkz3pAfjhD+l8eCCYnwVi6bD/Dbca6fwOyUJgxlm8rJmRz7WNdNhUA5qI2fjggs2tjSE2h3ws2Fy9gZs8mAh0HkQCDag4Cexp0Cw5LAKRM3+RzcYOFGFfI03T+SP7A2bbKPn1p5N/FxivHDvLLuJ4z5Le5BdPpzBqlYhLLhd4SAtrfjJlt/Plf/JY8C/e3v705iTBOoIo7rc42ILoz5DXo6zIhqZZcfXylkOHwCtCY6NX66IbS1rsJofv8FARU9I+ONUmTLVTvffFdUple7n7wsc3K3qkmKmHV86jpHio2DO8IJmcOeA52CrsM8n+vR66gHJZNecqZLaS+FCN1Z4ZdOLzOfpgyc/4iYNCkcCa69DNMX4VO97WZazjxHdPd6GmKlwWQZTIho3uXAkmrBy1qtDgifJ1Qj5eYaxR5/E4MrUkbHuAVGX5eNhouytO7+ZEw/KjTBVKA37JTfWh1KlAD6iv2Mx4aiSEa7onyY9pmNU8Q+tAuU99lWG1tRvf+uyClmaMmqF2m8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(10070799003)(376014)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aU1WaDdpYVBjajd6ejFqOU85Qy93ZC9nQkw0ekhnNDUrcWk2ZmRMeVlqU0g1?=
 =?utf-8?B?VmpRa2Q3RnFmTVRGVTZmbncxeXYzczBvRzh0VzNMWWgrWXVCREpwNkdzMU1E?=
 =?utf-8?B?enN6MUZ2ZWI1NTNac2M1Mk1tY01HSGFwNUkvVWs3M1RPcXB5MWFvdDJweitT?=
 =?utf-8?B?dWI2WFhoSWFQcGp5SHNKYUJWNVA3TWlXekxtb1Y4enNJSFNJY0N6N1JDS0Yy?=
 =?utf-8?B?ZnhVTFFCbm5wb0JXTkh2NU5uUW1BSWpCbXlRU0ZvU2xaQjZpMFlNWU9vdy9a?=
 =?utf-8?B?M2ZjYXo4RlVDYXB5K0J1TStsMk5jcVFmYWpDek1VZk5YNCtER0xBNjZNMWxp?=
 =?utf-8?B?ckFLSXlPWWhkdVRYTVlraHh2MFYyNHhNTGZ1WWE5MFdPTlQvdlp0ZjVPNlJK?=
 =?utf-8?B?aXRjVTlzM2lBZXZLL0p4MlJTQ3RvWUZ1ZHRFay96dFpTcVNkWVVlckJoUko2?=
 =?utf-8?B?RXN1Wnlvb1prclZBSVlPcW5KSkE4VGMwR21RY2I5a2N3NzJQdE5qQUFzM1R6?=
 =?utf-8?B?dFJESVZMSlAwMWJxYTY0ZUdSdG5UaUtDazYzSVcyRzBGTXFUbTdJYjF6Zmkr?=
 =?utf-8?B?RmVGQ1VhSFExaXdMakhOK0ZPQ1dwenpVUC9EQmNlZlNyTFNPN08ySjZLS2dH?=
 =?utf-8?B?M1ozd2RCTFVVN0d1a0EyeUNVcGVNaGY0VndYaEgzbjM1VCtFTFU1WWRXdEFP?=
 =?utf-8?B?YnlZdm81N0NmdFcrZk1TL0RDWDdEOTltcERUMG9rN0twWE81RjVtbGZLajRj?=
 =?utf-8?B?Z0FDRWI1ZTR6SzZuNVBCNDJTYnZ6UFYxZ1Z2UU5nTEwwRk83Vjc4YkFwYmhh?=
 =?utf-8?B?SDRZL0gvYUUyL0lybWJicEQrYytNY2l2dXA0NTBnM0Jlb1FpNkdDNXFzL0F1?=
 =?utf-8?B?aTdia0loTThWL0JYYTRDOGg3eURJT3lrbkJ2Z1h6ZWk5VEVndjl5OUkwRnli?=
 =?utf-8?B?RnV2d01EVTY5ajdadGwyNWF5MzIvTS81Ni80bUhvU3NxU3k2dHB0TVBCRldO?=
 =?utf-8?B?bDJrK21IMzY3WDhGL29CK3hTVUNkVFlyQzJvK25hR0l6OEora0htb24wbHZo?=
 =?utf-8?B?ZEM3REtCaUtaVm5EWjlxMWZjM2plZGlaY3dkNGRIZlc0eEdHbzJad0JIQVdW?=
 =?utf-8?B?RXB6VDhORUJXZTRWdkNNTWdSOGhOWmdOQmhXaE1RSjlocUlBZWZzZ0JiVzNG?=
 =?utf-8?B?OVdqSmlpdTEwY3dMbUg3UnZRZHg2ZngvamVZMDh4L3EwTHdhbGJWY0YwMktP?=
 =?utf-8?B?Tk13dDlocnlSSDZyV1dQUnVvM2dUWmhEY1NlWEZySHdwaHN1OStSOVlMRzFq?=
 =?utf-8?B?bG95d0V1aEpTd1FSMjU4cDQxVVNaYkxQOWNrNzNESGtQakZYcnVCRURxMjE4?=
 =?utf-8?B?Sk05TGVweDhBaHNSN0VqOWxHYTFQQ1JTL3ptRXdHa1hOUVZ0cWZNbmJYSHAv?=
 =?utf-8?B?S2lVUEZFdUdaQkEzRklRVlJ3cWRzblZmbVhMaWl6OENLRmxGSlZLV2I0Uy9L?=
 =?utf-8?B?eHZsZ2tab1hra0hIWFo0M2ZOSHltU21KZUJaREtlVEExNFFPSVpZRkZsZ2ZS?=
 =?utf-8?B?djVtTjVrcHpJVmJzOVExT3cvVzJwdzlmVWlFR0RpdmlRcnFvdkk4ejIxOE11?=
 =?utf-8?B?VDZWTUcvZkQ3eTRCVUNIdlQ1RWNzUXhMODJrTVUwVlN5TW9CS1htZXBsN3U0?=
 =?utf-8?B?ZjN3RS9FUjl6eTF5QStkSCs1ZGl2TzB1eXlFOVUrS0ZDaWZ0dXpSTElBcDF6?=
 =?utf-8?B?UWkwUUQ1aHNVSUM5RDhDSFdiRCs5b0FUdDJYazFod2NFWG9QcnBoMHNEYUha?=
 =?utf-8?B?MDBUQWlYUlNrK1pFbTlPaFVhendSOHZ5Lzk3dG1VL0NvWWVtSmJQekl0YXUr?=
 =?utf-8?B?N0ZxVnpaenBSb2o1Q3RiZnA3U0c3a2MvWk9PZ3A3WWhCWlZVTVBacWs4a2h0?=
 =?utf-8?B?ZXNYVzVVWHNVOUNyYXNTZCtDS01SbEF5amtUR0FLMkdESXpzSDRualVjeGNQ?=
 =?utf-8?B?UWRpWUtrYWNxVWlMckN0dDI5cVE5QTUxV3NrVXluL2EwYU5CdE02RlE1Zkl3?=
 =?utf-8?B?QlA1RytpRFFIVHU4cUNiNXU4Q0NQeElOdTJyazhiZ0lnRE4yQXE2OVN3UzJu?=
 =?utf-8?B?bGQyT3hEMXlZazVrMnhmN2I1dTFzTld5SmJzTTFmN002VVZNZ3E4TG1WKy9u?=
 =?utf-8?B?VXJFVFJ0bHZVTkl3Y2ErS0lBQkE2N29GNnRrdkZQYys5bG1Bb0lLSjZTL2Zo?=
 =?utf-8?B?b0dYYmtGZk5FVE9lbnZwNkxCMm03SE0xN0lIdlArT0dBaGowQmVaZVh1dnd1?=
 =?utf-8?B?MSt3aVhWOXp4TG01TlZlaFZybW04ZXJXdjB4b2Z6cVJzUjFXQ29iUmovSDVJ?=
 =?utf-8?Q?+5Pifqrz89wHuXtUessjLrlDsbVKv3ofXrbdxwFT+ncl5?=
X-MS-Exchange-AntiSpam-MessageData-1: xYdjBFiucYgv+w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be12b81-d798-4ce7-f52f-08df18360af2
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 23:14:10.5925 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oi8rNWm8ygbPuq5fzYvxqkegB6AnLOXv3mlMjmIF0u8NxDECveIvhxoVflE1AbSvjlnhMvmnEmpWwZJa94+92A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9251
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

On Tue Sep 22, 2026 at 12:13 AM JST, Nanonej Dev wrote:
>
>> > I'd like the method to look at bit less
>> > ad-hoc and more confined. So would you:
>> >
>> > - Move it to `falcon/gsp.rs` and implement it only to `Falcon<Gsp>`, a=
s
>> >   that's the only case where we need it so far,
>> > - Make `ctx_dma` a `usize` (it's the caller's problem to provide the
>> >   correct type),
>> > - Add the `FalconFbifTarget` and `FalconFbifMemType` as arguments of t=
he
>> >   method,
>> > - Maybe rename it to `set_fbif_transcfg`, because the fact we touch
>> >   registers is an abstraction detail.
>> >
>> > As a side-note, the series is going to clash heavily with Gary's, and
>> > will need to be rebased on top of it after Gary's series is merged
>> > (which as far as I'm concerned should be the next version).
>>=20
>
>> Thanks for the review I'll refacto on a v2 like that then and wait for
>> Gary's series to rebase and send it.
>
> I see the patch have been merged [1], so I'll rebase and make a refacto f=
or a v2
>
> [1] https://gitlab.freedesktop.org/drm/rust/kernel/-/commit/ea79a50124315=
589da68cbcaf518455a142d6d23

Oh yes, I was about to mention it - now is probably a good time. Thanks!
