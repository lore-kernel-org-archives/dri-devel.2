Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99AF4C61DFD
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 07:58:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A38C610E476;
	Wed,  2 Sep 2026 07:58:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="mfyjy7n1";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011054.outbound.protection.outlook.com [52.101.52.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 372CA10E476;
 Wed,  2 Sep 2026 07:58:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k5JCEjhs1gC9rnGEMXbGBjZPY31PmfkVKU4JxU2ZZyc0WZ6sk92953GOf3iHrteyQUSU7Qc8I8cv4vsrWzv7E8R5GEmI805zWl7tNSS5Bw6klHBJ2ZPG3PPlYopPRdvJqrNs1sON5A8WMSbQAqCk5qCOETCCPPJogK+5eJWrJgjxefsVXzrYnLol7US33D9IwwczuimqavBdYqzSx1JqsMz//z2xe0yWvMGff0VzIbXzF7JKH1PadYchJiLlDlULwe+0qHq5X2rGDRM9Zi8hds8jhIJhYbqP9Ne5y5hfYuf1/cz5Q+ZRCExEFrxG7Dr2w7qdgsDmzpTgWlVU4uddCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHGNq4tWD52iBRY2gAH86+XG/mAfOTHY8pLLOKkyBqg=;
 b=u9QayChdcysxWqRuj9ei4UGdNN2q+BSKBMFf9I8rFNkZWoQSePNi90tYfMCFTLLg9z391PPrauAAXglJFO1CXHKhEvtJG2M9D2RVkyfKutQfcjEYO1JcViN/zlu9atBv7EaINXFU2vQh9djLhGEV6CV5e1qmNLJhl4sezTIY+rhiCehwTTWLhSx/hZ7gCcXFtnUH3kSK9C2lrG/OJjzUrQYXUssHy25Rh4M+syOuFWatIFvasmBblF2dt631tYi3L3lH0GwrP4F9Dr6VB7wqfY8YZDyaR6BWg6jDOpOxFQkUKhipxIJy+RU02fzvE/ERZ32yF5yJnsRdcu8tECdNcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHGNq4tWD52iBRY2gAH86+XG/mAfOTHY8pLLOKkyBqg=;
 b=mfyjy7n17Naf7UmyGUPCPTZl66fVEsscsdyb64YuIygdyj9RnluO93Sqi+9RIfBwC80LZooPdjM592Ib7OehDtitctZWQOEZmiyDRuWMsVzJ9uNC5tg03CIE+jRlVqO475Z8jc2mFvPnMie+mEVHOY6xlTXQzyLAndcJlpQK/rH6X5fm1n9VPAPBHEuYiCroIHcUKb095FYIZ16M3pbg58kOK3QDzvDBNCOWfjXdN97SOvBxuAcAQZgxYVPctEfBdJ0PIzxd5abqYjS8hjq3R91hIVkx5L2m9A+b2uuMdDN+Ewb1GZzu+MLmH3O373czAhrFHvls+e4wGB4n6BUncg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 DS2PR12MB108293.namprd12.prod.outlook.com (2603:10b6:8:404::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 07:58:34 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 07:58:34 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 02 Sep 2026 16:58:30 +0900
Message-Id: <DL4O67MHAMEX.33Q7UZ7RD9VBC@nvidia.com>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v4 1/2] gpu: nova-core: fix barrier usage in CPU->GSP
 messaging path
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>, "Danilo Krummrich" <dakr@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260901-rust-barrier-v4-0-94427f445310@garyguo.net>
 <20260901-rust-barrier-v4-1-94427f445310@garyguo.net>
In-Reply-To: <20260901-rust-barrier-v4-1-94427f445310@garyguo.net>
X-ClientProxiedBy: TYCP301CA0087.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::6) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|DS2PR12MB108293:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dc980c4-517e-422e-8768-08df08c7fc86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|10070799003|4143699003|10067099003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: qv9ElZplCyi+JYEu8aZ0wrGs7QEFyzAx+a8P3SeNbLAfKhJtCbEzgDzDfAg1BmpIUIQADhh23/5ejmpXp4Le/uuwf08GMoUC5R4YFt19qK7AL4udYhzAtWMD190NlGcRF/OBAiQWlH8Y3zb1imCYD9hCpJtkGaaCNjHF20RK1kPztxh/HoiWNEKbUpiJeeBJzWx0/vtkiUAyV2dyHrH5xcCa/Kw4zR6g3wQ/ti1Arv+u9HoDhj6Lw3bqefeBu/mJxBi8xNr7xH39F85FsJi7R5sgKRrzceoeDsCYfVp7CJVbdPFpth7K2F4qTUYk3s807k16YpbgtMmFFWuR1H5M7MYgVaDYjYLakHGnnY3WAYCmnGS4Xe1uSPqDnDfniP3uy3hq/QyoB0TDhsUFba5KkWm2CuP3cSCFHpG56trUvrqruZHrVS84tFPw0ekkZEQZqMi/6At41NZn5yo6n/gps0NTm9b4uF4ELB32NERGEY4Eds3mTTy15yYK/Ck7dmtkeZNotki8amZcTzSOXC1mMcwTKI9owZx+ctTcKv2aMV/yeP4HLH2SMuMSm3fUn+542VzQiVaKJbB4nejWRaylz+yN2NMQupfA/hQO9qebH+tWeu7kj42dto/Q/woQOTOSS3vGyVlcwzO1KV/bQlQQ4flTKAm9Rovd8Ziivty1PqA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10070799003)(4143699003)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3hYRGU4bnJGWE0zQlhOTUFFOGxrcldsZTloU3lFSzkxTlgydXpHTkVoaXRG?=
 =?utf-8?B?MGpSRmJXUWhOdS9oQ2ZJd2ZCZXdlVWhycHpSdGNBVGVKMVIzSHdVSFBCYTht?=
 =?utf-8?B?bGRCK2ZGOEt4dHNhWkdJcUZudHZSYmpiZFBtU0VtQ2VGSlFkN2ttRFdWeFlH?=
 =?utf-8?B?byttakl2QmpNZklHM2kwRmJpQVVxVE9SSXNxakhVaXEzM3g4bm5nVWZ6dlg3?=
 =?utf-8?B?UDF4KzZ2YlhsQmp4d1laVjVicmx0eTk5NUM4Y2xzS2tXQkNNMHFnUjM2OEN0?=
 =?utf-8?B?MTRYbmxDcEVXajlOajFmdUR1cmtLSTNza3FtbmtFaW00cWp3bnVrdkl3elBJ?=
 =?utf-8?B?Y0xXS0xuUEFSMzdqZ3FwUjFJZEorVUJFaTJYZVR4VFVOdk9uSGdVbWp3eUpW?=
 =?utf-8?B?RVo5WXduQWJQaWhMTFZJQmlHWWgrbzAxZnJxOEJJMnVzdHdJb3ZJTkpNM1M0?=
 =?utf-8?B?c29iVXUwU0x3SFcxRXZ4bEcwK3poS2p0TldaeHZMYm9Fd2VIcWEyN1JpaW44?=
 =?utf-8?B?YTNYbGlKUlRrMjBwYzdJY21tMHJ1WFJqY2hmUFFaQ2NpZEpiTjU2Ty85SWJs?=
 =?utf-8?B?a2NLYXJsbGplNHpqbnphZ1JvUkJZR3dMTzdQclJQellBaWMwMSszSVUrMzhq?=
 =?utf-8?B?RFZSSUp5R3J3SG1wQWtpWHY3Z1Q1Zk41TW05VDlXak0zR1NFbkhhUURteGZD?=
 =?utf-8?B?elNmVE4xQ2d1RFE1aENHYUx5Wkp5ckdZQitwVVpseWgxdE5Rc2J3enlrRTBa?=
 =?utf-8?B?b2FERXcrbXhrNHY4c1B5STJFR2dZdDZ1dHFSWnREcjQwbnZNeEdPQy9yRWRi?=
 =?utf-8?B?S3diMCtQQUxiUDQ0ZFBtVTVtTVdZV0ttVUdPenIzRHczcEEzN1ZFdnY0MGc3?=
 =?utf-8?B?eTdOWkhldVQ1anpMQVQ3OGtRTmpETXFUZGIrbEY5VnJsVTZlQlQveGNPYis4?=
 =?utf-8?B?YUxCbHpjbFVmTjYzNDZlU29SV3p6WFA4emtpY05WVFFmTGJPVGxPQjN1OENl?=
 =?utf-8?B?NWNzcWJ5dUlyVk1pTHR6dnkyWDlDSWtma3hPQkI5NXpoYlorWGZZbTduMlpY?=
 =?utf-8?B?eCswYXlEV3Z6MnJXMXVlYis2Q0tzS2Z4UGlBMFE1UlNJRDdOOHhNR3MrQklY?=
 =?utf-8?B?SDVRb0JMenJ1d0psVlJwT0ZiMmVhb1VBVXlrbWIwcmdpbmFNT2R4anhGQlQ5?=
 =?utf-8?B?dXp3b2JGem9pa2NTb09maXpDRlB3cUhqNUVkR3pXMnZOQ3M1VzdPQmtVNGlK?=
 =?utf-8?B?MS85QVVOWWo4UkpZM3JHdTF1MnI2b21LVUJBeS9COGlJeTd3a21USUlHY3ZX?=
 =?utf-8?B?Um55WnpDYXdXQU83b3I4WERwQVJlNjVYMUtOaFhyVTU1T01LTE1BdTBMZUNy?=
 =?utf-8?B?bjVFWmp2VzJ3Q0ZVVU1TOTlhdS9GUFp0TFB1dzNWaGtsaHFROFlnSnhySk5L?=
 =?utf-8?B?UmloMVhjd08rSURpSnpvbmVuN3ZFN0h2L2tPVUFHcmpDZmQvRXlnRUg3Tkll?=
 =?utf-8?B?MmF6SXBFZHA4MUQvU091MnFnYTdJS2RxWndOT2syOWorN0cycnVHRnAwOVl0?=
 =?utf-8?B?RVZRU3ROcG8yUEJZcU1LckpDV0pPKzI2Yld2dkh3aEJsMmtyamNHWm81Mldt?=
 =?utf-8?B?SnBhVVVEQ1JNdDg4TkM5K3B5bnR1R3lpcWFIUHYvTVBDMUprUEE5SStoODU2?=
 =?utf-8?B?NzYrb1NJZ2RyZy9tcnQ2dSs5Vk1aL1hYZWIrYmc3ZWRZM0lTRnpsbmMxUURs?=
 =?utf-8?B?MmRBa2swd05aUzY1OC9aUUtScUd1UUY2cEF1U2U2L3Bjank2STVZVCt3c0Za?=
 =?utf-8?B?Slp3WTd0SHNsTlZMM3c1TU5Tb2s2NTQ2WDMwamFSRU5mTVJuYm82WGZ0S2ly?=
 =?utf-8?B?bi9kSnJENk4yTTVzZWtQZElIVXJ3YzA1d0RJSVRWL2RiYnp1K3NDUW5ZQThQ?=
 =?utf-8?B?MDRLK3JkSmJHZ1htbksxdUxRZ1IrQmNJK1VnQkJSU1JVY3FTRnlMdm92RVVH?=
 =?utf-8?B?YXFQYjVTaDIyMG95a2RlMm1nMFliMjlrc0I1c3BIeFpBR3NDREZucnF6OUdC?=
 =?utf-8?B?MTBSbUlNN2diYTdyUFlmL24rSkF2aVFnck1QTGs5OHpGN0ZEbGlwMllWZ0JK?=
 =?utf-8?B?QzZDMFdDNFQxTHhOVlR3Sno3TE1zYmtwQWp3MVFmRjZpVmpuTEF1R3hQL2Rx?=
 =?utf-8?B?MEsrbFRYQUdwV0x4TmhGeHJCSzFJUmtQZlhsMWxINTUzS0pSOVFZcktmVkU3?=
 =?utf-8?B?ZVhWYjZJa3d6NVRmNHh1RU1ndGI0TzNyTWtUcnljMnBKNjBBaE9aZ3AvTmFE?=
 =?utf-8?B?c3ZKR3JvTFZvQWMxaHlIQUJZTm8vbUNvMUdXV3YzRUVJL2lDeGhETUpLR29I?=
 =?utf-8?Q?mWUt/XWajoCQA7/pI3fsJv75XkppPsUa663Tph1ZT09Bt?=
X-MS-Exchange-AntiSpam-MessageData-1: gyLQ04tgo3t5zA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc980c4-517e-422e-8768-08df08c7fc86
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 07:58:34.0663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QjXjzFpTCDBZj8j79F3jHedAGgI4UKlvQTEccPndjQWHz6oZNM9tL6QlK19MrYkLp9fqc0h6uFcWQ0wnJwAmBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB108293
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

On Wed Sep 2, 2026 at 5:59 AM JST, Gary Guo wrote:
> In the CPU->GSP messaging path, the code reads the read pointer from GSP,
> writes the command, advances the write pointer, and then notifies the GSP=
.
>
> A LOAD->STORE ordering is needed after reading the read pointer from GSP
> and writing the command. Control dependency exists here which provide the
> needed ordering, but it's best to avoid depending on it.
>
> A STORE->STORE ordering is needed after the command write and before the
> write pointer advance. This is currently incorrectly done after the write
> pointer advance (and before GSP notification), but this can cause issue i=
f
> GSP is still processing ring buffer, as it may observe the write pointer
> advance before command write. Thus move this barrier to be before the wri=
te
> pointer advance. Note that barriers are not needed between write pointer
> advance and GSP notification, as MMIO accessors already carries the
> required barrier.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
