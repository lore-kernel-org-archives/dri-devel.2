Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73E87C98328
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 05:39:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2A0310E784;
	Mon, 28 Sep 2026 05:39:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="b0OPE0zp";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012036.outbound.protection.outlook.com [52.101.48.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F6C310E784;
 Mon, 28 Sep 2026 05:39:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q6kqn0TofeyIHLi/tFWdlCl9pkIb6a71NbT5OaG+X4f7URSUCf7yvKzgTOAo7V8h5MkstAZ4t/mgNLOPz8hemPPf3sZaHV60kGi3j/1zkPKa4Mj8LmXgUq8eTkAj+l6vi5GXgu7TeKJuaHySZJPKrSw/aNzLtRdsBN2y4mFkRLHLW1CORuT4TxLyKw8uPZDXAVX6nYwz4wrN37uuBA4y0r6qpja/omE6zgeGZ7jcoI7CGbJqsM05HksJAI80Y0F/BCXy9GPWF+hPRXBNz+gdViyju3PlXce89//UKbU5djbiXtpuyD0BbwCQxfxAjPim6VhGD0zFf/in02yk0XetUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPoX2CCdaUEZaSrrLMjBBCdvYrlRLGU6nmjQL8nZYG8=;
 b=cOlVFsA0VwhqOJW6KSs/15LjHGPXtEMqDv3yhkod3iSp25HaAdsHoJ2QQhbQEIGIGV2BF61ABgWkVkB/UC1fDMUHwH0o1dC3EHL98rQ8SA99EXhnjBdacd7R/k7COCQZkxcC7I4tyKBfLjqO0TEhz/ASF19dpD30lcYPvfOWIxoSiwoMcanUrWpa+Qg2Zhs2tqsfhJE3vzRMuC7QP7jfT2OKfMTPllLhLromiOM6FrjvKfIcowzANV0FfVZDli7aVQjXoCJE9W+EZPXCdDf1Hb7at1gxhU+lTtdbP+RA22j5is2RtMbwM21q78yIF6x1eqqO0BuA+4dmdKMpUzba9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPoX2CCdaUEZaSrrLMjBBCdvYrlRLGU6nmjQL8nZYG8=;
 b=b0OPE0zpJG1mqR4V1PGen/jrQhmi6vsUz73DUXjW9cbZ64/MfZm00EXddEuW6dxFSIoCiFPOLq5bK8EEON2PHVVtEwPoWV8dc6cX7nNqmN+XB9Si/iFqvSr8SpRxNKoJyXd602G4Gv6DuZZZcEPHavdVOwyZ961xe6W02ZGdsEPoYoTCupxdR/ir377awDPr2/376lAei71gODJIVfHAVZVPQT2onyR+Ieg5xYVO78ITw/yt98Wc/Nct+slmYUh0JALwcWHQK8FUlQ3ERh74I+oztfnp7ipIrU5xinOWyb4yU3BlEW+r4Rp7sP2x5352QPRCZlV8mGugz+YbIm0Syg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 PH0PR12MB7009.namprd12.prod.outlook.com (2603:10b6:510:21c::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.23; Mon, 28 Sep 2026 05:39:45 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 05:39:45 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 14:39:42 +0900
Message-Id: <DLQPI3PEJ5FK.3C03O6SC33PHF@nvidia.com>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 2/4] gpu: nova-core: remove unnecessary Arc around BarUser
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, <acourbot@nvidia.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260926124405.604707-1-dakr@kernel.org>
 <20260926124405.604707-3-dakr@kernel.org>
In-Reply-To: <20260926124405.604707-3-dakr@kernel.org>
X-ClientProxiedBy: TY6PR01CA0015.jpnprd01.prod.outlook.com
 (2603:1096:405:3bb::11) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|PH0PR12MB7009:EE_
X-MS-Office365-Filtering-Correlation-Id: 81eedbce-8964-4cb6-1da8-08df1d22e6dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|23010399003|376014|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: mUsihkVp9Qyq7i7ggwn7Bttikyyxjq5pBg+eYNycEYKB6FsiuZu1ncxbR80m4Ciq697eVxfv4qE7p0OCGLe7vh2wae0R33D4e7IZuER8OiVxJU/MoAmBH1tjOqOjdzLTStSU9brVJV4Wt5ufY2iwEO1wPbxB5nMt0jH2t3zGus8Nycz2fQtu2GEu5TG18dwOIiWFIo5d3hPd4LpF4/I99K8TWI+8xyGS0KGzo4EaOw4eXtPVh1R1bPX5UklOmKvz3lyY76KYJjFmLxzE9mb5PaGBYiS0lXEzLG3aXv6FkWgJoT/ykFH1P/3GFIOLjn4RrIGGQm4YjBkxIOVT+Tu1LfzCQn/Vx2A/wmRgn8RqKHal6XX81b39gcya+c9iQLZkVC7BDVaM/oNKGDrPdcWRrBuTMLVyVHkND3HuFafrlJylsvUcgHPBhLZ3RcOEMNUgWXIQu2JvTXreNZjF6mLXBwNuPY8zNU4b7KdYPxJZvK7C4hgxdoH1MnXtHvTUk7S+i54ek15sW+kXseggIaVTuTQQolqv04UBrL0EFN9FCiKNL2QI5k9mGA2AFRLu4UqaQGAh3GZWNG9R0kG91O8Dq6nHNbqDA55Y/UEFLKpkusO54OXRkRbkrawICj4VhKCx+yHK8+MsIZ49NYrSipnzs6zKZ6JErNqAx4zWEmNk+vA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(23010399003)(376014)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L201aVNOdVFTZXUvOUs2enhzZ3NxaklzeTRFWmw4VTVXMTlzWFZOTFFSRm9B?=
 =?utf-8?B?VDZhS3dhMWhuL2lTT1hFNlVpZU9UMXlNNUxkRWRyQUhndlJ2LzZIKzlDVnNY?=
 =?utf-8?B?VHNGZzFlL1h1MHEzS25KMG9hOG0xQnNxdFBlY0I4ZlFNZ3paK3h5a1ExeWc4?=
 =?utf-8?B?UjdPRTBLdnZLVkFOblAvSmlHUnIzNTZLbTNmdXBtVmZTWW1LM0VZYzl4aWFP?=
 =?utf-8?B?YjdFNlhpcXdJL2prYW40SmgrRUpRd1J1MGRwcENlU3N0c01Jb1pvRW8zUHZp?=
 =?utf-8?B?YmFZNGVvSEFHTWx4eURFWjl3cnJrekZMV2p6ZFFud3g0ZjhYUGxMbkgrS1dt?=
 =?utf-8?B?dVNGd2xIdjlkU1FubEpOb0tFWFhFc1pONVdRYjQxWWtWSkdueWpOVXlQZmM4?=
 =?utf-8?B?Z081SlFLLzN2THdWdHd2OFJHb0JLWVJYOTdZNTRFSFdhWGkyTzMyTHFEU3RC?=
 =?utf-8?B?TWViN3ZWN1dyYUpwMHYzU0QwU3cydmUzWXEzU0QxaU13aVAwYjN3R3ZjQ1Nk?=
 =?utf-8?B?SVBBM0FiajVHdTh1QUUyQ0M2VDVNaE82Mnh2bkVydjFrckVDZ2FQR29CSFZu?=
 =?utf-8?B?R2JnbnQ0b25iN3NQRjUzYjR4ZWZkZVdIOWVDZWR3cmRJbWF3R3VrZ0p2NzhW?=
 =?utf-8?B?SnFIM25FZjFaQUFFWEFCek5FL2RPWE9MMk9UZzdUc2ttR0V5aHd3aGxIY3Vl?=
 =?utf-8?B?NkNHMnhYcmVkQmdDUVJNL3I4YnZGQWZ0dm81T2pTVS85TlBxeHYzRHpuR3Fp?=
 =?utf-8?B?TzhSa3Q3MUZKUWdjRHJJSHVsQUlXbG9tUjhkQmN6NGlPQ0xDbnNwdk0vM2Ix?=
 =?utf-8?B?WUpHcXB6dktHOVVaV3E0WklKN0tLOGVoNmExeW9rUmViY1V6dWh5SVplNm85?=
 =?utf-8?B?LzZORnlDZG9GcTdlMVBhN0VaMHhTU2J4eVRXWC9CTU1jTU5MOHU5cVhIYXhU?=
 =?utf-8?B?L1hOMmVGajIvbndXNmc5U3R5azY3czYxWGNNTDh1aEsyc3FOYlBiTGs3NXFD?=
 =?utf-8?B?V09zNUxsRGM5MEkybjcyajZWV08zeEo4WVNBK0F6RG5MeS8raEtMTTUwOERl?=
 =?utf-8?B?Z29Vb2hWL3ViQmk0TlRZWjdVbEJZaE9qZmJ3MFdVdy9iMXIwZDFSZEl6ZUFX?=
 =?utf-8?B?eWl4SHMwTWpWUlFENFpJUkRlZ0piYnFic1d2M09BYUVYM2hWdy9VM1J4OUpK?=
 =?utf-8?B?SFFodFhZL05UZHlLWU52dk9laXdLTW9vcUxRWnNIUXJBUmIzUk9WeGVGUnI0?=
 =?utf-8?B?UFhJSnZDUkJpMm53ZlFBV0pYdk1VN1FYQVRVbmwvTzVtekczNjJNSHowWkh2?=
 =?utf-8?B?Z1RIS1hZMmc3a0YyRCt0SGpudG1CVjY0STJNcXdJYThnNGNwcURKT2RHeFJ6?=
 =?utf-8?B?T2FzYWIzMWZPUG9BU2FwWjJBcFFqT3llM3dnaGZrU0RwbGJhQU9jMytrUlZD?=
 =?utf-8?B?QnQzL0dhbXhJclFIYmpueGI4Mzd4T1p0OWdPL1BaZHFqTjA2ckowa0pBbmo1?=
 =?utf-8?B?ZGVKVDU0SlhHL3VsL0FVQVFkMmFGQ1FiWjJMNjFpTGdabkhkTmZJaUduRjM1?=
 =?utf-8?B?WE1BaVQwRGFuNVNsWElNN3JIRVUzNHZkeUJJOTZ1MXdlMUtqaksyOWRLRFJw?=
 =?utf-8?B?MmxTcE1nRDI1bzZTRFJLZ2MwdHhMSi9sUjgvUm1obnQ0NE9nRG5DTHNtblRn?=
 =?utf-8?B?OEZJVFhPaCt5RU1zZzRVQW5GQzBTd1hWWHltT1dJY3ZlYnFJYlpzMXdCRFI5?=
 =?utf-8?B?ZFArYVR5cng1M3Q5a0lqem5qQnRDSHVXZkFzNGU0Wk1VUnI5a3poWHhDZWhl?=
 =?utf-8?B?c3hNM2VJMmF2K3dobVhQNzFndUNVb3l1T21EM2dEa0xsTGZsdEc2Q1ZvVVI3?=
 =?utf-8?B?dVcxbmdvZHcxbkdIV3p2MC9ZSFRxR1VMK1I5YUZRS0xmckNxOTBHU0kwS2F2?=
 =?utf-8?B?NDFvMml0UW5iTzlCNjIvcnAxNS96U0FyNVFDT2JMOWc2VGl1djlvZGlHK2px?=
 =?utf-8?B?dkc2VE5ValpPZGUxQWNsSkFGL3NiVE5YNTc5OVl1U3FqbnYxeGU5Q1M4cDdK?=
 =?utf-8?B?cmlvSzNvVWdoN1pSd0JhRlZ3TTVuWWpiaGwxNVRoVm90aS9EME92NUJDdzdX?=
 =?utf-8?B?NWpDOXhIcWs2bDdQYStwQXkrMEZ0ZDNGUjNEVk0wR2FobzRGQTk0cnFDRlA3?=
 =?utf-8?B?OGxLaTRzd3gvQ1VOcDN5bEVzSjJpMG1tSUc5R3BHT0ZXc0Rva3ZsQTV4enpa?=
 =?utf-8?B?UmorVXBaMDEwQ0E4b2x5R3lIQk1ldVdVazV5S0lhOGE3OHo5Vk9abnc3czBq?=
 =?utf-8?B?TmxGQmtWNFlLL3Q3N1dHazROR01qVVQyNFRzMEZzL1JPUHNmWWFDNXFQeUov?=
 =?utf-8?Q?qG5Ds/2apMd/ubpU3UsjruaDVKGbdp8FD3+F7C5VV6Sst?=
X-MS-Exchange-AntiSpam-MessageData-1: 9K8LCTy4/4ADVw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81eedbce-8964-4cb6-1da8-08df1d22e6dd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 05:39:45.0197 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v+zMU2LvA0QgUhUr91GVqTCrjRplqGE5dw/3uItqWGFvgHWvuCtPx8m86zTbOuDX1Eb+Gtoi0sPeL8VXlDZJeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7009
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

On Sat Sep 26, 2026 at 9:43 PM JST, Danilo Krummrich wrote:
> Remove the unnecessary Arc around BarUser and get rid of
> Result<impl PinInit<T>> in favor of impl PinInit<T, Error>.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>

