Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 185A4C9833E
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 05:26:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4442010E42F;
	Mon, 28 Sep 2026 05:26:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="paPhBoJD";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012009.outbound.protection.outlook.com [40.107.209.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8CC710E42F;
 Mon, 28 Sep 2026 05:26:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZQWWgvrtB+eAs9/5hsXpPzfPvNpNoHzMbgJFVeAVka0PZUvFytgej2EAi4NG0Ea8YYiW2DtNBTg4UGFheMXNy0N4LA3SzoPLIEu2mwknWpKdRSpiDgZ6Jv/KFZpJF3HdRfqjiaCG0LorzP4Hfe8aua8t/Me1Uc6xgmiP/cDdtdnljXIMIlmfLTpX1x1IGuKTOdobFvzQYLzysuhRfh3pXm7mnSSRr9Wv04Wp3iBnSK+5FhZUybBqR2EJv4LYZss8wpUrXnvPKo/sLzVyMOml+CZyqob0fns2w1WQJy+XOARNUEzSiC049UTCJb+Hnt+Q/ZFtMQLwV1LAVAfFdOv5oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCsPLZiB2G4MtLQ/XymqEEw26Wsx1cNPvdw9XFtFY40=;
 b=edHZ4E1r+l0fC1VR4aACZHwHCbJmzTGUG4+VVVtlJpYR350JSME5NrHwKEm2vUYuHfxfNUPJg5ViF+IhDDRCb0bJkf4QZLeJkbDK+M+WWaYVhXFCwppKO1mHtHzICImuIvjMqvA/pHo6UCQJkQ/TnIDrNGCSM5kzeoZ3BM9Uear8miVJqjLB3ZuGhdUIMYJYfc+fKo2wtKj5K7aCvYb8l1u/vvf92SaMgI6ZHRAyR+mXM5yl0HMTSij1R540m9UI6+3QHIjwwXq26zYccus3XHhFuN211H9XfOaSScGKwG6vLNM5zJ0ekFy9JYIDNjCP/T07/lTZ0QN0GLptvlDueA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCsPLZiB2G4MtLQ/XymqEEw26Wsx1cNPvdw9XFtFY40=;
 b=paPhBoJDKzMAFoYWrtP6m3IjoTSt2ZD1fcXlBAUKusm1x3jZQwPAcVb5WINdX6DBSbNzNQDGyucgkGFWQxDP1jV2xwuIyXtK7/pik+2b/OoUla+5PfLx1nduz1UlMZbmnXAF9x+j7dhozHWAqbgC46DBvH+2yLkjLvoNoshbOylWRTGc8yc7OijvcpVJFvGzEROYgPQlK+XmyMbbc4MTk6Edh4onVQHMwpn/AwGvIvZ+Zkn5TtxhSwqduFTFUStLYuyxdIXwcvnXpltjbHEzcBgEzX5SmEDoKHNFzUZjbgwqdOS0UaMVb3KLEZarUSTF/8o+f0O+i3Q+Y/QIbbZMJw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 DS2PR12MB127457.namprd12.prod.outlook.com (2603:10b6:8:4df::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 05:25:57 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 05:25:57 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 14:25:51 +0900
Message-Id: <DLQP7HXPX2SG.316QGX8EHU2OF@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "John Hubbard"
 <jhubbard@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>
Cc: "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Eliot Courtney" <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v2 8/9] gpu: nova-core: gsp: move the RPC commands into
 a sub-module
From: "Eliot Courtney" <ecourtney@nvidia.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260927-cmdq-rpc-v2-0-c3f66ae73be4@nvidia.com>
 <20260927-cmdq-rpc-v2-8-c3f66ae73be4@nvidia.com>
In-Reply-To: <20260927-cmdq-rpc-v2-8-c3f66ae73be4@nvidia.com>
X-ClientProxiedBy: PAYP264CA0024.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:11f::11) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|DS2PR12MB127457:EE_
X-MS-Office365-Filtering-Correlation-Id: c6eba04c-c3d6-4766-9dcb-08df1d20f9a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|10070799003|23010399003|4143699003|10067099003|3023799007|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: uxQQucVFZYV+pFDVau3bRfht2Kp4TDKx3s2jOOzOa9+x4GtRec/i4iYQs3/7s2thyWDH5bE3VcdNvFIpeDVLW6RM/iEEVsG3h/Idc1M53G6dbvFJo4diREzNDCqRGWzDcYdSTNtRx4UX7EhXSmFEpgLcVZeST55EEGyV50ZjyY5pqk5UTjgcPJi6foMZUc5vt6NIz3XkPaPAvGOp/5mF2bRLCQThX9qSeDcLBcsOuB9Gg8CS6ncc48IXVj/vXatp7GNz+VA8emG/9giKP17sHsNL2JMV5PZfAyebPvm4My7vIumvcDRrvWS5wmvBnxOXWKf59GVeyEAy0bZnVsxDfFr5QxQJQ8S743z32OPTXzpEAlXT1akIF5lmSM42k2bL8oqyRdwoepdpkgLfyuFihyAPaQDpCuYpkJWKaByJZ+fn872q0rU4Gm5vdwi8pSbW1Q9i0TcmDqpB92yODHAUk0vbwZIO9Y6B4rT02WCEDd124QWk7yNIg5YW85MYUDzZNHWrB1b120ueE4QyX30YEVuVgUhy5G1+GhD2LIy+Nk9hD7VIf/n7l4GmA4w5/AOOuMxWIvc4sG9mvPhh9HEWTtzpElH2ytbz+tFgV/FfX2p8dKFgCrHNvHjiO1Zkmom53YIe8rWp6HXwYpoOW8xAZdf/88hKR8FtxGVd7OtmTFI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(23010399003)(4143699003)(10067099003)(3023799007)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3F1V1F2bXFHUVR3WFBvT0RQUWtVMFFiOXZoaHpOWGRvc2RyVXVnYVBjblBv?=
 =?utf-8?B?SjAyNjBKZ3RnU3ZHbXRmRkkvaWx1QUs3NjA2NjlNcENpZXBENjB6S3VlcUlO?=
 =?utf-8?B?S0QycjVST2V5dTRraEt5YzYwY1V1djh6R1JXZGhaRnA5U0I5M0wwRWxJSVVs?=
 =?utf-8?B?Rmd3a3RwU3NYSzhnZ2tlMXl0ZXRoUVhSUWFjb2JqQ0xOeFRzRktXaUFMZXp6?=
 =?utf-8?B?aTVQRU5OblNiQU1YdEovMml2cVpVMm1IZE9FYXNGWkxLUUxtQ3g1YXkvNllJ?=
 =?utf-8?B?Nk0xRzZWbmNBRDZUVytjQmtHUXdmbGJQMjA3ZU1QSmR3a280eWIzcVMrNm4w?=
 =?utf-8?B?Wnh1SGJuSHJnUkw1amRzY1A5cU9Ia3BuMXhRNzBJSmtzVlFTNGFya2ttUmR4?=
 =?utf-8?B?SlBLNmlqTWZHbFN0d09xdEVtaFBSNWVmOUZxbXNOL2lzUGMwbVpIdGRhRGxU?=
 =?utf-8?B?eCtNZCtmbEk4anE4ZlVqd3VOaGFnZXVIbFRLUVZRQ1JZamRvNmhUMXdTZ3d0?=
 =?utf-8?B?ZjZoQ0lITHlTRHlKd1NvbWxXWnIwRmtINnlNaVZtcmpVQnkwUS96c2R4Um9M?=
 =?utf-8?B?Uk5SZmRJSFhTSlF6eW0rMUZrcTRGVXBQRldyUEVGbkJ2anlMT292OTFUVElh?=
 =?utf-8?B?cVpjWUFpeVNodWNRS29RL04wUXB1UzR4MmtGMWtBdEQ5RlAvMnBwZWZWQVNu?=
 =?utf-8?B?ZEM4V2dTM21MT1JvNzkzemFlQnpSenF1RGZSZlNFZ0lPYnhwMW5aZWFqN0dM?=
 =?utf-8?B?Zld0cVRsT2c5UGpjVFFHOWkvdDNKTFJBZkpMSzZPemJSVUVIdmoxYTVodktp?=
 =?utf-8?B?MzdwYURTYnExTTQ5b2k1NHgyYk9mUEI3SHBEeng1ZE11bnAwZ0VTSGFGdHg5?=
 =?utf-8?B?Q1gxN3p3WVJzSGZDTjE2dy9KbDYrdTJhR056TFpuQWdtY3Y2YmdOR3dTK3VL?=
 =?utf-8?B?aURJaHNBb3ZBZlpSTVh1TVBDUHZlR0hjMjhPcCt4SGdVOEF5SytFTFRwdjU4?=
 =?utf-8?B?QURWVlZUZHZNKzZYTTRPNmpFREFQRHJ4N2dZbmV1RXUrcHk5ZytISWpPUDk2?=
 =?utf-8?B?L3RsNGo1aVovOTFLc2xMS1ZkZWxjSTZUUHBQWC8rcHR5Uk9ldVNPcjl5YkRm?=
 =?utf-8?B?YTNYL2N3U2M1ODgzaTV1eU1lN3dpZXE0d3hISFVjZ01lTHlJcjdaRGZTTFdU?=
 =?utf-8?B?aS9hbGI1Zmowd3A2NjlnQzdTVm1sL3VFR0hCcUZSOWlnUDlRbjRJeUQ2Y3cy?=
 =?utf-8?B?Y3c3SG0zdHh2ZDBLcklGNDFkOWJyQUYyUC80TVFwL0Y3YkY1UXcvdTNtZ0hj?=
 =?utf-8?B?VGNGNzdKNWczQUp5OGRzQzRGQ0JkdHBNeFZaVHVpamJvZHh2aUhSMS9FNGdl?=
 =?utf-8?B?WW10blB4SDR1TDY2MDN5R1BObC9vbG5qSDc0dFNpaFpRdTdPckE2bXd2VXYv?=
 =?utf-8?B?dys4Q3ZHUWNhalJVSnYzUHFjUnpQVFg1b0ZXQmZ6N3czRWhMVTJJTkwwWmhi?=
 =?utf-8?B?Uk5GTE5vVUdTc01uR3VMWDAwcXhhb3N0bSs0dkdlUmdoTTdOT2tQankrVk0y?=
 =?utf-8?B?OXUrSlczRkFGb1N6Qi9ERktRRUp2UWJzamM5Zm1Cc1FMZHJnekdGclhDaG9r?=
 =?utf-8?B?QXJNblJhc3NzRjZ3dC9IaThwQ2VsVUFsbEMybSs2K0Zha0dLT0JqZHoxaVZu?=
 =?utf-8?B?TkNOMHdQaTArYjQ2aUhRT24wc3V2RWdicnBabnVoNk45VkRwRSt0R3hGbDlu?=
 =?utf-8?B?Z2pteC9VNTdDeFQ0OWJ3U2NUVmtHUmZxVVpvUGhLd2FuajBqemZlSXlTZHV0?=
 =?utf-8?B?UmM0T2o0SG0zZC94dWNrTGJpaUIwMzR0N1VOVU5COENQSkpuVUtaSTBnWFE4?=
 =?utf-8?B?OXNPOVE4UjlMQ3Aycno2T2ViMmJtVDkxNVpNWjFHNno5K0U1TkZvS29YSlVB?=
 =?utf-8?B?M0t6SndjcWpYUkFrSDN0TUFHTFVWSEhzU1F2UWswRGNSVVpuaXBFK0F6SWxD?=
 =?utf-8?B?UWJyK3F0NjVZd0RwdXRLakhGb05sZG0xTjd2ay9wVzNDQ0oyZHNxN0g3NW54?=
 =?utf-8?B?eW0xY1I1TWpaNCtRNFBMUUp2aWJBekdUVVdJanp5SzlCMzloUXNzY0R0Wk01?=
 =?utf-8?B?MmZ2ZmVRTjdMVjVzTDVqRlhHYkZlQkc0eHo0ZkNCTVVkdFUxbHAwcEVEbmYz?=
 =?utf-8?B?VmJYbnF3ZmJPQmJBMGdRSlphSDYvbTA5ay9FeHJ6VFVvYkpENEoxaGFHSm00?=
 =?utf-8?B?aGY3UmVmOFNObHc4L0NLb0U5ZzdCbU1ybjkrOUtxODNZWGpTazcyZWtQcW1D?=
 =?utf-8?B?TVVWcGdtZTFTVnF5RTU3SWhndFpMOUtZUnpYS2tvNG04ZlVBRFQzRGx1N2Mw?=
 =?utf-8?Q?Cch6ibIh1FxqAHS97+mVcscML5paDmhTkBusV/xDgvk2F?=
X-MS-Exchange-AntiSpam-MessageData-1: FQ2qYd42wdHncg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6eba04c-c3d6-4766-9dcb-08df1d20f9a3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 05:25:57.5615 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h8GB9plY46zrPFG6kLLS1u88PJ4zM0O/JEZYxo8clghpO1jO+Zg3dSUGI8cowD8NYiY7lTF8pkbcIKLuuHDfLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB127457
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

On Sun Sep 27, 2026 at 10:46 PM JST, Alexandre Courbot wrote:
> Move the types and code related to RPC commands into the
> `rpc` sub-module, and update their users to reference them from their
> new location.
>
> This is a pure move commit, with no functional change intended.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>

