Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EBCAC9832F
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 13:35:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E752310E5F2;
	Sun, 27 Sep 2026 13:35:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="tYjEQLeD";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013027.outbound.protection.outlook.com
 [40.93.201.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F7EE10E5F2
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 13:35:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oYC2nhjzgCSQSQZR51Op+PbdyqQA9/FjrBLLyFsdmIzxhn9IbxzFGxt2Cl7muTkW19C3zt/Q+kk26p43UShreJhHtsD+LzDp7FXHuobB9crit58T1r+cFpFRXvpLcEqaEdrgc2aHr8UMp0CWBqDVNJ6P3ewLMKiIMs6Z/brJabzbXVC0IbqaJURsLVrVmQuW44v8NsFvyECgb+o2ke3n7Jh9wUdzCpJXXw9QhcYJ8/3dv5Qm8Hn9JR7mpo02L5ngYQP7/qf0YY8lbBcDYRZaLxWtaEMZ0vBTxujyLqdrps3aSkCGPjelfdfNnVyLs2MFU0qXbNt0z+uarIV6cTGHcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFb4Z2B6vOkxrEossoIrOT4XRCmd3cvAKoASWQ2MhGI=;
 b=HnJ3JeUJ7UXoRRcrk8DR4MXh3qzf3NxfJrKSIaWeAqk18QgzWKG+0MiHPakCa/9b/RGB/G5janl8ReAijHlz50RV4qUFMbBO31Vu0dE1M7Lmd2f6tFfWV7VFF/yfsuQ/h0fR23Hn4OLFxqWKXtnw1ExicTPr5CMub4iMIpFiQJUBLiHyzVlMMI7h34P99rlPFKX+RLy+tH+fSghOwrHOvcDuS1d+udtgU9wl5iKoEzyNTZnEMkjiQf7qaFz5tYDtxBjnkMIAm1M/D7jXM//4Y7ul4kPvUsoUyVcwHEIqIQZyZGaMRgV1s4m6GI/6sIbGJ+mx6uVqDrmmAqG2hScWMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFb4Z2B6vOkxrEossoIrOT4XRCmd3cvAKoASWQ2MhGI=;
 b=tYjEQLeDd1GpKbIj/L1SXEotWAraHTxp02vGO132AVDhdswizkcZqIrUjWORhdGTph9dvnBkZ655h13ZxkZ0u+hoeS4anjbLYaQ3gVmBLcxEorfjNY6WOiuXw4onvxSMPWaewQNYSqmveSgsxvAfmOi98bXw/SV6rbuu8xxkTBFf+6FVs6NAsWyXKVaNNZ1HArX0UQtE/cvFMZS6cDQRQU1oRTbLIMlE+LizUnQQkhlCxunYzqJuE06LqQJQj/Vir5L/4BshJ6+nrSJ/PPdcwflB8B8xV6XyKNbAbrZaldk7IQxjxuL7PpInlPkAZZxWNjJ2LiYHETkf5BeFFJP8RQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by IA5PR12MB999302.namprd12.prod.outlook.com (2603:10b6:208:605::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Sun, 27 Sep
 2026 13:35:43 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0451.022; Sun, 27 Sep 2026
 13:35:43 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 27 Sep 2026 22:35:40 +0900
Message-Id: <DLQ4ZZLFG1DN.3B0F3UJI725A7@nvidia.com>
Cc: "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Eliot Courtney" <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>
Subject: Re: [PATCH 00/10] gpu: nova-core: gsp: prepare the command queue
 for r000 dual-message types
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "John Hubbard" <jhubbard@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Benno Lossin"
 <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>
References: <20260927-cmdq-rpc-v1-0-822db5af910e@nvidia.com>
In-Reply-To: <20260927-cmdq-rpc-v1-0-822db5af910e@nvidia.com>
X-ClientProxiedBy: TYCP301CA0013.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::16) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|IA5PR12MB999302:EE_
X-MS-Office365-Filtering-Correlation-Id: 98ce7b19-7baa-4b53-d1c6-08df1c9c3a88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|7416014|376014|1800799024|366016|10067099003|11063799006|3023799007|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: 4SgnGeW1+ftkSZeoHx25omAbas+MLhFbE+/4+GiIcIsbNp7tADwMIy4m0L8hlnZrC8DrpfcLcpKD++G+j1oEC3SvPMn0CEng4RIZt+Y0ICEYCvxMYwGminCLROZ4B+QV6KZGT0ibYlfGIjWXEj43r82vmSJulqbgsd5pp6yNx7NSmN30yFV8a1e2jMgFteqQBa/BWuTxnt6nBzT1QEzjV+y0MoLNApOHoTYDZ0cccbJfoKacUtQa0cLIE6nd6WJBTl786nYBKie0u98S8+8mWJf/eFMJEzZyiXD1PxF10Zza9g1LSd/QnJy5ufQ9uDoxN5PMG4LGpz78nXtbD3QPRBPG9qgR8WbnAi74QC3/ooeP22TqXaydSDORJRT6Vspkm++gnxEGLKrFSlIzWxdYbcfx2ypkqxtPvVuWuD/o9cH2ElPxZ3h0Ccywvdu0Y0imxYQP2lyWm3XWSfErAbbIVObpSOEfopHs5Kcs5Lugo+TK4+U9ZG2xSqMxq/yHyhHBo9WpCmcm3y3L5yAnB+edFB1gINA3spidoqr4aqDrXYJ+HfHCQe8cRa9G0yVWKFT2KUqTjui0SPN3yuQYHzcKJsI0iFAMXnbZZiOtBF2i75xcDJ1FCJGYk3BVu2EFKy4Y64rgfO+szElyp/8ofvlTKpLROUzBolH+Cz+C4l7YFv4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(7416014)(376014)(1800799024)(366016)(10067099003)(11063799006)(3023799007)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2NoSlorNWRtWFppQkFhSzJNZE5rcnFWMnZsWWtEM0hsT2JURkFOQXNINU1x?=
 =?utf-8?B?dis2SFcxeXBzdnBZQXR4RDg3MGswVS9UZGJxR3ROZXBNM09zZ2JTbVNUczdz?=
 =?utf-8?B?S1JoR2EzcERPZlFMK21Pa2pUa1FwUy9xSXVDbCtocEh6cFVWL3FycVJUdDB4?=
 =?utf-8?B?UmI5aXlIckhSNkpSckVRdDRjMFhTcGg5K0w5NkMrcjBMRWQzUUwzbXM1dEdm?=
 =?utf-8?B?UjhnamRjc3pIYnlSQlF1anB4YUxjYkJpRnF6V3hOTHM4cDM1SC9xV0hNb0VH?=
 =?utf-8?B?ZWU4eThobmpWbWsvbWF2ZXEzbHkzZWJ6UytSWWRLMVd5eFQ4Kzlqd3VJUlZH?=
 =?utf-8?B?L1RvdVNnYXpObXhiejhEOHQzSWtmVkxTV08xRkdIZHY3akVmWTc4Q3E3ZDZJ?=
 =?utf-8?B?VUN4UndrRzZOM3JKaTFFSUNRR2Q4czBzd1RCYVMrb2dwMjFJMTBrSUZiY0U5?=
 =?utf-8?B?cGl4aU1aVUNCTi9weHZlZ0RCTG5pdktjS1FoRUFNdnY1VEI2RGJmRVl6TDBR?=
 =?utf-8?B?Wms1ZEY4cjVvbTNpLzErSmQ4TlZwUEo1citOa0RiRHkzUFZKK0hDQzhJa25W?=
 =?utf-8?B?ekFWVHh3UU9hZzVDMnBicVByeGxnbTlIMmx1bEg0OGNsWktWMWRwUHowUVFV?=
 =?utf-8?B?ekI1SlNqUjVwNGROR2pEL1lJcG5scWN3RmNVNUNRSWJzcm0zbHdrbitiTFZC?=
 =?utf-8?B?OTNGUWJRRDFZclFQbU9XR05Qc21iWVVsdG9hd2RyZ2tSZkEzdk1xV2c5aFJJ?=
 =?utf-8?B?UHlYUm0rb3d2NnR1UkpmZU5hR3BIYmZGeFppUzkrTGsvRUJtU1NyUnQvc2ky?=
 =?utf-8?B?aEloem5yOUxERXNVbXBXdFdsUVo3N1lDRlpmMjIwY2ZPcm85MzlmODZjTEJ3?=
 =?utf-8?B?dVpOdzFDUk5DOFhqdTdpMUttc2p3eSt4MkV3cjd5OElRREl4by9iUHJ0QlYy?=
 =?utf-8?B?K1FRbjdZN3FKcWJ6SEhoWllYZytlRWdCaXZjU0RYU1ZWWEFGUEhJSGYvSjFH?=
 =?utf-8?B?allmNW5LREI5M2lJV1BEQldoeWtseXErbHhIaVQzY2R1ekZIWXRyNzJIRk8y?=
 =?utf-8?B?RGVmNVdqVlpaTUxSV0YvZkRDcjRkYzFjZ1dOYUF5RzlCVlord0hJeU0ySkFE?=
 =?utf-8?B?bERDODZTRHlLYTltR0p2eHBITHJacXpNZ2orSERuNmN1K2czc2xrQnByNUV0?=
 =?utf-8?B?NHczVVN4bTR2VmduVmZlNG0ycmhTbTdkUHR1MlMwYWtoby9TenVPZHhoVjE0?=
 =?utf-8?B?YTUxY016eGxHaXBHS2ZoUGhtSmYxd3dpL0VYOFU4RFRMaUtjaGJCOGJVNzk4?=
 =?utf-8?B?SEo2Wi9UQkNibDBtdmZPclRtZXZpZFd3aUswMjVYREVrZW4rRlo2OFdVSzNz?=
 =?utf-8?B?c1B6bkVDRXc2MHQxOWovc2RzYVVIa0FpMnFkbzFyQ2J6UjFLU09ONVdYemxh?=
 =?utf-8?B?RXJ0NTl6SUJ3Tjc3K3laMUV5K05DR3pzRmkzUFVDY1RPYjF6YVd0MzNJSjQy?=
 =?utf-8?B?SEplQTVINXdxYWp0QktjTHkzQ1M2ZHFaQzNSLzA0VVZ5dU4zVnA3aGZsQm01?=
 =?utf-8?B?Wjc0MVE5aHFIQVFhM1JyMWcrNkxQSDlGNWJRU3BzRVFERzE0eGVXVG9BSnIy?=
 =?utf-8?B?UG4wQ1ZuWTQ4T1BtMjY1NDVmUlIraXVGeWJMb0ZnNjVHTGthRlAzaXNtZGpz?=
 =?utf-8?B?eUVxNmszY3AwaEkxZ0pjQ3JuUDJRODVvQ3FvbC9ELzlwYUcxcDBrY25oenF3?=
 =?utf-8?B?dm52aGR0L0c3Z3NYT1BKcHZpK3RoUFhQZVRIdGlIcUYzdE4rd01Rc2hLcm9T?=
 =?utf-8?B?cFUzZnFMVXRuZDJwOEZJWFh5eVpuTDdwRjB5dmRHbmhFblMzR1JqTXRZK0Jy?=
 =?utf-8?B?VnVhZTgvQytEY29wZTFjZ05VMkdHTVFBSjgxWGJzUldBdFV4WGc3alErYkt3?=
 =?utf-8?B?Q0t0TmlGdXhSUjhpZDJ2dWVTcnVLQlJ3VWdNdm1VOXo5OWkwU2FkL0QwOFhs?=
 =?utf-8?B?Nk1HNVF2OElWcmx3cUVJdGJlNXRyaDZHbHlTREo2VHZpNnQ4b0ZDSExtL2hl?=
 =?utf-8?B?TFJJdDlnSHMxK3Nxak5JNjViVWlKc21qOFhhNUpZN1dyb0krd1Yzbk00R2Zt?=
 =?utf-8?B?NEYxamlZa0tDVlByZ0d2MVovdHdnRkFDU09zR1dSY2RLWnVlUTNmZHhKL3NI?=
 =?utf-8?B?VzAwaU9NeEFCWjVaTzRpbm9wcjlsb0Y1aDFXTVNDY3lXRUcvT3pwU0FnSlVu?=
 =?utf-8?B?eDY4MTlNMHhyTUtpWDc0TXdMSlZNS0k1U2MvK05TNmI1ZDc0eWFmdFhFV2lm?=
 =?utf-8?B?UXNOVWcrY2llMnM2Nmc0N1BMdzdrcXZEc0NOQ2lqMDNUQlRjQk83NW11eE1Q?=
 =?utf-8?Q?CT+ebhr1/AoQuOIZRaPQac3MhkTdb1/pKnxFTKh+YC3OV?=
X-MS-Exchange-AntiSpam-MessageData-1: nrBSIA8OKnTtZA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ce7b19-7baa-4b53-d1c6-08df1c9c3a88
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 13:35:43.5168 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kL0zCWhNamrRa/L8lIJDmDY/PQj8V5hwi6qbL9M+KLPZkC4qMVjb2NxIVExdC9VBLOdUlC7s0jEk5vaJwWjXRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA5PR12MB999302
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

On Sun Sep 27, 2026 at 8:14 PM JST, Alexandre Courbot wrote:
> The upcoming r000 firmware support [1] introduces a new type of command
> named GMC alongside the existing and already supported RPC command type.
>
> Since RPC was the only command type supported so far, it was embedded
> into the lowest command queue level: the message header actually
> includes the RPC header and the code considers them as one.
>
> This makes the r000/GMC support difficult to land without a refactor,
> with the result of transport layer code being duplicated between the two
> message types, and no clear separation between the RPC and GMC code
> which are mixed together in the command queue. Merging the code that way
> would introduce quite some technical debt.
>
> Thus, this series prepares a proper landing ground for a new message
> type by extracting all the RPC layer code and moving it into its own
> sub-modules, making the `cmdq` module completely agnostic of the type of
> message it transports. By the end of the series, the only mention of RPC
> in `cmdq.rs` is for the `rpc` sub-module.
>
> With the transport and message layers properly separated, support for
> GMC can be added into sibling modules of `rpc`, and the transport layer
> can be converted once when doing the switch to r000.
>
> This moves quite a bit of code around, but most of it is moved verbatim.
> No significant functional change is intended.
>
> For the r000 series, this essentially means the following:
>
> - Its patch 7 making `allocate_command` generic can be dropped as the
>   transport layer makes no assumption about the message type.
> - Patches adding GMC support will do it in dedicated `gmc` sub-modules,
>   following the model set by RPC. These `gmc` sub-modules will start as
>   `dead_code` as they are being built.
> - The "switch to r000" patch will essentially operate on the transport
>   layer level, i.e. `cmdq.rs`.
> - There should be no need for extra post-switch RPC fixing, as the
>   transport layer code will already be shared with GMC.
>
> Overall, this should make the r000 series much easier to review and
> eventually land, while not creating new technical debt.
>
> This series is based on `drm-rust-next`.

Sashiko has found a couple of serious issues, and I've found another I
had overlooked, so please ignore this revision. I will send v2 shortly.
