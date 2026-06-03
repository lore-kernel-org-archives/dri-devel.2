Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C39CD6E55
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 10:30:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 248B310FBA3;
	Wed,  3 Jun 2026 10:30:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ItbtXZup";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010010.outbound.protection.outlook.com
 [40.93.198.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A635510FB9D
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 10:30:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tlK25Oo9Lb6NmbQ0BtFeDtetA4X6x22m2C7Lj2tx9aahegbvRDJIVKwBqeHDCAaY+v6tmmPvqCCadg7ly21N0fsz/FVt1PWgXCkSpN69qXx95rrJ1LkKrP5Iw3RkW/eVXbFZbURV7cFI1tFpLjI4ipVdkBzvAv8HL/H0QBPnuLVQum7JJ3vv8+QvL3aA7XceiO/EGnA9MD8XVLj6xqlwLcOBPpBjanAzkiXkiFRpSsjk5U1qwr5ttupi/S3ztSSw0YfmDLSwnrapDmvub3UQh1cIezieWPx2+6XJRX+We2AbpDyCC8fbbKbr5xB8np+AD81wtfVULRCZFuLMfdF2mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWmCeieLZ1bqnhcS5nB48xZR+gbfYi0RXS0krCz6uzg=;
 b=AfsbWqQ3h0SOWgLejBU6W/SoAQ2/5I5hU1KOX2Imu01aiD+f8Nxz4/SMXwpqHNMZMul2rj560hSDF9PBHhJed7ssiuPmdDdfKCdW8bOP6tm71FJfbf03Ku17WA7vHXcRaCMA1jCMerBfaxMs46setpoBAQZgFpA6FqZhs8vaphrn3bE9TW25cpFvgHVDMAG3gGupujt8twOxDyut3L5uHMEmDKuuTj0PcPv4c+DJi3U0lNFSkNZHXv7ozkiAoO08/wuniu9nc15oCW1pm/q/LaChjfC8OojsuhtpgpdChyus6yxAYkPBCw81djW6Cs5W1l6avc6DEw7f6AATRkR6zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWmCeieLZ1bqnhcS5nB48xZR+gbfYi0RXS0krCz6uzg=;
 b=ItbtXZup3iyvFRkJsD/aZkijPE135SNHbBmyhVA+KeMiqjFf1yUuf8+KdS1+dO6G7tC4dNbdsoj6qayWk502JfMLuJ5HULoG7XeFDrrXRnOC6JpqEK7iarYQ6N2lghn2agnFobSc5YQRkl7EMrXVtuO0M7EhziULFgrwuouGHxNqhWGs0J6iq0aHpGAyhVPWne28eU1jKkE5Dig21cP3iySSdiSU2tl/Jj5/Hai6Zv9GL+NMGQ2TFS8DgfdkGTMUYc5YuFgZdXxRJdtnERYFZUJUu56VjQ4uOcD+5l7LkhlfK4ZVJyR8HV02lfOn0KsEnTO7hMPE2g6LzGrRH/r8HA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by BN7PPFED9549B84.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6e7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Wed, 3 Jun 2026
 10:30:37 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 10:30:37 +0000
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Jun 2026 19:30:33 +0900
Message-Id: <DIZCF27FZH6I.17CWGBTLDNSMP@nvidia.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Nathan Chancellor"
 <nathan@kernel.org>, "Nicolas Schier" <nsc@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair
 Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, "Joel Fernandes" <joelagnelf@nvidia.com>
Subject: Re: [PATCH v3 0/5] gpu: drm: nova: enable calling into nova-core
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
Content-Transfer-Encoding: quoted-printable
References: <20260530-nova-exports-v3-0-1202aa339ef7@nvidia.com>
 <CANiq72kbzmLeFv58mkiKn+LvhCXmH5g7UsnTYTcVmJ6kyc+vLw@mail.gmail.com>
In-Reply-To: <CANiq72kbzmLeFv58mkiKn+LvhCXmH5g7UsnTYTcVmJ6kyc+vLw@mail.gmail.com>
X-ClientProxiedBy: TY4PR01CA0086.jpnprd01.prod.outlook.com
 (2603:1096:405:37d::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|BN7PPFED9549B84:EE_
X-MS-Office365-Filtering-Correlation-Id: 58cee80d-c05c-4ff0-f374-08dec15b26d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|10070799003|366016|1800799024|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: jTi/xNoQArdysXuFqIwabv7C5MgahKhvtcoDCqy05G+pUQmbG6Hc5g+IiIDltJujXOlUqveZyJ53/mDbjKHax1CsZaz8ry9jmIk2VSsCU9me4vcGMOrklzYkC4vwGN0j+ptDkK98aDLvwBRsg3NbmxZEX7cZrLTlEmb0OVrF4auA/jVJFp/TdikljF5Q9zp2s9ShVkWqyZ0abNWxVC9xtKyiWAtzRq8ZTt1BhOSm4r+gVd3co0YkO4Z0VX9FyFhDMsLZ8Of5+XASEi/wg1wIjLFF2Q8OGhwuphg8TjoNQvrFTm2gh/8GWZ4f64SHhjym7lwGkfDx/KamUHsztVHs6nlKSSKvn0njT3ecdlLqlEDEmHlKcwTxsxaxT5cfv+31FHH2u9vvSlkqfEKQCr3g15R1ly+LpnwDXUE+RY8h/L/UXPhpv0T9I1zVzcH/Zd0ZftTWl+5TIyJV/5oo40MYwq614cF/4KMfCm8LSVVkUUDhUFBEbQUH5FetvkieUcarTXcaFYzHz8A1MMLAUEq8Ax06owDBtlG5q6aGIZh70zkUKbKhG0zzcZdTLAV8vyBXO4o6cwanIHwH2zs1wt3xm9TtyIghTkeORImV1DqcFtfCwPfJ5EVif1jRSRYw/7L5f9R1jP2YQx+xhwfbf7HtbfKuj79h3p+cmfE/aMJ4s9o6X7oPVURZGY+1PwtkHvML
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(10070799003)(366016)(1800799024)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OG0rMGNyVjgxMm0zcTF0elRtQVdZS1BBZ3NwelFobUFwaWxRcm1pa3UrS1Fy?=
 =?utf-8?B?dzhTRUtOa3c0MGxDbkIrWG1iN3JVTnhkN1Y0bG03UytSUzJQUjlrSVJQSURH?=
 =?utf-8?B?azUxZWRFYXd4YVd0T2g5Q2dwcytNaXk1czgzZE53QmI4RDRLcTZpR3FTaG1S?=
 =?utf-8?B?M1ROa1IxV0gzZzZmZzFUWjJFOUl6UCtMNWtBdE8zY2h3U1V6b3RoWUZMc2pT?=
 =?utf-8?B?S1dickppa08zSmJKYjBvbHRsZi82blpvY2VGR1pDeEpacThaL1czUUxlQjFl?=
 =?utf-8?B?ckRQYUYvMlJoZnBOUENOR0JvVHhiM2JiZ00vSVZuSjJCWEN3UHNhUWN3ZGFH?=
 =?utf-8?B?ODRWVjF6SmV3Rk1Ld2RjUk9EQ0FOR0tUMHpQeVdWWGRVK0hyUUo5ZnowNmdV?=
 =?utf-8?B?SnZHWnB5WmNDQjhyd25VaU13ZGlodWVSVXppWHZLUUQyZnB2VUd0SUg2dXJP?=
 =?utf-8?B?L3M3d09ZMWZPVXlTdUc2STlpYmFaaDNDdlczUTZCK1Q5OEtSeGVSVldOYXhO?=
 =?utf-8?B?VUlHclpObk9nazNHZ0JhRldveXkrK01jcnhydGRjRFZZNUdsN0xCdzhRMFBL?=
 =?utf-8?B?TWJIeno1amJrL0xCb0tNTjJSVlp0U0t2ZVpPWE5CdGFnY0VZeXdNTG5KRC8y?=
 =?utf-8?B?SlVZcjNOMm5GbHhLZWtYRGVLcGVTbi94L1NKTHIrcGNCWnRDdE5uUTlaVnUr?=
 =?utf-8?B?QnRsR0ZUczBqTlBualdSRTNZVis1eExDQWV0ZTQzZXI2bnk4WGRRRlY1cG5o?=
 =?utf-8?B?OUthaDQ1NmFycmRGZ0RaUW80SnpwbmlIMjAvREh2dGpJa0Z3M3BEakI5bUMy?=
 =?utf-8?B?eHFCa1c5bjdNak5kVnViYUc3VkdsTVowQ1REN1lqUC9qbWFnTU01QnNKcmdO?=
 =?utf-8?B?VDdFT0tsWXVMbGZvNXBzdTVIS0p6T3hLMWd2UHVpZDliZllKSkRvZXBodDVi?=
 =?utf-8?B?NnB1ZFJFT1dUT0ZEMUhhOTBBSC9ucm52eG9ObjZKaVRDU0dwQy9HYmlFWk9k?=
 =?utf-8?B?WGlkTHFPQThCTlNkMUFWd1h6R1pkLzZsR21OemdPdVc3N0c0K2svWjJsRGZt?=
 =?utf-8?B?d2UybTdHOWlXTEdxaVFtV0FPWUd1Vll5QzMxKzVkUkREVVB1b25aU1pmUzM2?=
 =?utf-8?B?T3RtZ0FHZUVIdjYxTkloT1VVMlo4UXg2enZMWmlDUHoyZmt3am5KZHhrdG1k?=
 =?utf-8?B?b3Z5ZHdEUGVGREw5c1JoRzh0MHg5eGhmTFdQd2dOaEpKV09wek9ZSjFDcDVh?=
 =?utf-8?B?Q3pPOEJTWm15Wm5YelJqSDd4bTIxbVBBbkc3bkRpdG5PbzFHWm41NnJnVUJR?=
 =?utf-8?B?NkxjU2FNZi9QSEduK0VUTFFwVVZXclpHbk54MlFGaENlWm0rUnlvQm5xdkFz?=
 =?utf-8?B?eURzV2s3WnVrQmNtckJ3RUdpZEhKOGRhR3VFUzVUc09JdVNJa1plU1RXSWNT?=
 =?utf-8?B?Nm1IUDR3MkZnYlJvUTN3NE5OTmwzZmE3OHVrU29DK1BlQzhrTWtLRlVHUWhN?=
 =?utf-8?B?WVRiRXVLTXZTWmxNdGF2bkVOcXExS2xyUzBocGNWUXdSMVVEYU1IREovd2Jk?=
 =?utf-8?B?RnhVVnNNQnp2anlnNWtzRjJjeUgrSjFJUUZ0T09nV2NTZkppWC9YVWZnWmND?=
 =?utf-8?B?eVBsYlJCK2hDS2l5TDlVMVhoejF3TFRyclN6eHZtTWp5Zy9rUm9vVDRnS1ZP?=
 =?utf-8?B?KzF0OU5nTWJ5aklQQVBRdXNadTdRT093NGRwWEluYjZ0QmtrSkdMLzlaWkVa?=
 =?utf-8?B?ak9xVWRVakZIa2xCQ0xaT29ma3lZTy9JWG5VaVp6Y2NtWmNWTE45QlRYOUNZ?=
 =?utf-8?B?YzE0S2RXU0drWWlPZU1rQ21BOU9Sd0JBRmh6dmxxVXMwMFo2S05KWEJmaDJj?=
 =?utf-8?B?RWR2RTBlMC8xYS8wSEFVOThINVA3czZ6VzBJd09GQTBsZnFBMVBXYnIydnBQ?=
 =?utf-8?B?cndRWGw1MTdOb052b2NFaVdIb0ExZTVPcklxQVlRTEJybU9YNm5XTDRKVi9w?=
 =?utf-8?B?WHRyaVAyeXpPNnMyZG9tbjVxOU54ZjkwM21uSHRLTFJGTHpMY3c4dmlreGpw?=
 =?utf-8?B?S3dNT3B6WTFSMlNZR1JFNTdQSDFwSitrcUpGQVNvODV0MzFUSm9hTU1FTk9H?=
 =?utf-8?B?VDZoNTZwMEZqZEEwenhaODdjNkYveXEvRkk0RWR6bjBpL292YTcxQjJtMlhT?=
 =?utf-8?B?QWN0NGw5Q2dibWYvNEY5NGJqNFhMQk1Jc1hQREdjOFJJWG1GM3htb25Kd1Z1?=
 =?utf-8?B?MEdZRTIxNWRXRVJ2Ykxwd214cVM3ZE5oakg0R0pBYnRZa3hvQTBKOGtSVVZj?=
 =?utf-8?B?WkhvWjhjZEdSd291eE1FczlnUFFUUkdkQjdkMVFPUDdRVEMvODNoVFNZQ052?=
 =?utf-8?Q?JyBaQE1YMP3YyoJ20O/zL/bX6YcI/Rb+wa+T22CG1USEQ?=
X-MS-Exchange-AntiSpam-MessageData-1: s7zYtBO9QETGkw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58cee80d-c05c-4ff0-f374-08dec15b26d1
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 10:30:37.2955 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ySMzdGlmtss2Cr5fLbPghuY16ziQCgE+JMK6ZLbOGYzPEzmSig+MycZtQSy3Ol5Fadg0HlPcYOG71uDxBZZ8eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFED9549B84
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

> On Fri, May 29, 2026 at 5:28=E2=80=AFPM Alexandre Courbot <acourbot@nvidi=
a.com> wrote:
>>
>> In the meantime, this series introduces a Nova-local workaround for
>> `nova-drm` to call into `nova-core`. It generates the `nova-core`
>> metadata that `nova-drm` can use to resolve references at build-time,
>> and also builds a list of exported symbols for symbol resolution when
>> modules are loaded.
>
> The "local approach" is essentially what I suggested back then, so if
> this works for you then I am happy -- with the understanding that we
> will replace it with the global support soon (it is good to have a use
> case in-tree :)

Yup, I just want to have something that allows us to call from
`nova-drm` to `nova-core` as it becomes increasingly pressing for us to
be able to do so, but will be very happy to replace this with the global
support as soon as it is available.

This patchset won't make it for the 7.2 merge window, so if support in
the R4L build system comes during the next cycle we may even be able to
skip this altogether.

>
> I see you play some tricks to get the ordering right, including a
> sub-make with a double build of the `.rmeta` in "private", which in
> turn forces you also to do the `.o`, right?
>
> What I originally had in mind was simply to do everything from a
> single parent `Makefile` instead, precisely to avoid complexity (after
> all, it is the local approach, so you don't need to force yourself to
> handle that). That should remove all those shenanigans, and it is way
> easier to get right. Did you consider it?

I haven't thought about that, no - in that case the parent `Makefile`
would need to be the one in `drivers`? Or am I missing something?

>
> By the way, I think a `.gitignore` entry for the generated header is miss=
ing.

Thanks, I'll add that.
