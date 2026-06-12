Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 029B8CD98CE
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 07:34:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14A8C10F2B7;
	Fri, 12 Jun 2026 07:34:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HnQaHBcH";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013029.outbound.protection.outlook.com
 [40.93.196.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EACC10F2B7;
 Fri, 12 Jun 2026 07:34:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f3Hei6S26jaXz5BaUJqblIuAAgWFRiAN8ymN0crcTAW7eam5y/W1CPZhKLwIW0LIou0Bi52zK/M+L2i81OvpAzrinv9QIATzyaMOw5R3FUVePBfw2XH9jxyR8uBVd57UpuKysyNBCJJk5BDhe9jm6FeRJBUDodLVvEu97WnyrFBFmFXet1p798aHQERACb8ocYBc2WDMVbIgPmCi0kcUGeKL9Mr5JgD+0gVdZHhU95di0GVrsiFgEs5jUIyReMCEdtr1u6laidQu33AYc6rb4jGiAGEpOsnwfCMBx5WrPcCO51XsYakIt6adrewXk7SoNlGif+Gz/TgU5rZrKrWmjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrYN6bfyIyFwuKgg16nSfVZbgPU0JZFJKUU0KC1iGSs=;
 b=DwTbASKjpaM7fOyLWzxGO5+BmhnvYjy6rQFYA94TjXh156rVFFCy1QZ27dBlnyfKn004wCN5lqDlx1Tsrei7s2pCiaq4B5VpVgBubxmQByVb5zApKRZZyzYQhsj0oKbnrC/pmz+YNZBJ9saQdThkLddUPDTCRl3aD2LLbnoHWYqvAo9h/a5G0qZqp55bkVe3PCsBrUB/TPl8V2b/A9EdHErXEp7ShrSrpaY7I0xKUAdusMZ5dtSV/CgYiP7af3zHBQrRixX+ANLg3Ch5mW0/PuzsxE/zIJ3oGdtZNifcVwbUu+NBK0afyhxB/PnwaxaiQMKIe12C0+0K08dGOCjkgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrYN6bfyIyFwuKgg16nSfVZbgPU0JZFJKUU0KC1iGSs=;
 b=HnQaHBcH5MT7SrehPBguYoNl3dijbeOreBlahuoUcPOrZkY1ogY3NahUzSSe4L2/TK3eXSuZfZ2DcKGIIuLU9hRfOOSwWp0qYSAPMGJ6+buT2TCiAuyhpn9mLprgHyHW3L9BwvMEQ4ohQbuaXYhfuDyIovQtfl+PtPrNgnrSs24=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS2PR12MB9751.namprd12.prod.outlook.com (2603:10b6:8:2ad::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 07:34:41 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Fri, 12 Jun 2026
 07:34:41 +0000
Message-ID: <33b42033-a5ae-4fa2-bafa-ea007a29eab1@amd.com>
Date: Fri, 12 Jun 2026 09:34:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 0/9] drm/amd/display: convert GPIO translation
 logic to lookup tables
To: Guilherme Ivo Bozi <guilherme.bozi@usp.br>, airlied@gmail.com,
 alexander.deucher@amd.com, harry.wentland@amd.com, simona@ffwll.ch,
 siqueira@igalia.com, sunpeng.li@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260611195026.25125-1-guilherme.bozi@usp.br>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260611195026.25125-1-guilherme.bozi@usp.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0175.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS2PR12MB9751:EE_
X-MS-Office365-Filtering-Correlation-Id: a726c98d-8d90-4b5f-afb4-08dec85510bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: e2Rfj/gm9E+QYfaOQc5mZcN5hAgQCwDdm84ZI7F01Hij5qE9lSguhK/E+vR1ll3Lbas6Sj7hffqo7T8jIZzWHxRE47TMVEIfPvhckISnp0KEtDs6b1eFleMexqrj1nleUYrlVSgfvDVAet0Vpo2YbJbnKGOe6evouWNkEJuxUx+AEn7XfCcMFif4hAXn8OUFFciLWZXvtd5lRdfaF+c+GSAgkgWaPuzIQHYNwV6OBxRjFPe1xY5NhE+AuOJQ51xVEBOYIb6zh1Niu1FkX2eXObIAgTJUThkpMf4guHlJP1Vm+9KSlCDskHa3vBTNMt++SK+1Od4ylaKeKIHHFSn/Y/mxTolkQYQhueSHQNG1MCEkgPfewFc0U2kCRXFN/PbIBgT2uTZF2DrfxXvwELU7fsTSgoJ91dqUCz3YmdsiSMy0uFlGKkdSKHVYdb0pLlXMoiviOmikjQ3ARno6X1WVFWobJ/dd64RVHO52PAvt8tYxw+3JYDlX5y68RAd9XbgZOOYOaEchEg6MfaXaHRKBlq2NumdbFz6gzcV9iJ3n51UjjuxWW6lUsNZ9GioJHO1NXPOSr0ffARacaISloyMIUh0AUox2dPAE0QIdL8ma2/rbgSdNh/2eaYHDTOWTEIpC4PGc4gpk94ykR4pfbuodyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0hWU0R6Z0R3VVgralJhQVFWcWtEaUlQT1BFeERYS3YrUnlNZEpHZm5uTlNh?=
 =?utf-8?B?K3UrWlZ3NWhackFVMFFrZkdUNlQrNzFKM2YvS3RWWFpNZ2ZBaGFIT3Q2aURk?=
 =?utf-8?B?MGxXMkU1M3pZOFBuSm9LelRmNTloa0JPcVgvWEdzM0V2bG1USTFzWUVJTHcv?=
 =?utf-8?B?WmtQV0pVMDF1dXNiMzZVdFpvcEhYenFzNXk0Qm81Z055TTExRVd6SVhscEtT?=
 =?utf-8?B?Tis4TmZuWDVVKzN3YzVKcGVlbnhJL3plajBpNzRldkgwRXNpWW1ja0xJeVlB?=
 =?utf-8?B?K2doQnRucHhaeFNrc1FSZFBiT0FHSWxBZ1dSR1Ria2dCbUpNUml2c1ZRMzFR?=
 =?utf-8?B?MDR4YlRhZExtUjdyR1pUalhRaU1tUjVTOUtZTGJlUmlTMEY3UWMzOUVpbFND?=
 =?utf-8?B?T00zdkJPZWdRdGJjSEhYRS9UeHNsOFhrbHFxY2g1aXRIdUtqaUhqemtGd2g2?=
 =?utf-8?B?aVRBSGFTTWlIRkg4VXZ0SXJDMUR3YXF3bTFRNUVZUW9Nalh2c1dDemgzdU50?=
 =?utf-8?B?MFpNYlZtd21nUHRiOCsrQjNINEdsNWFnZHI0bmthVlFabTdSMVpUaUx3M0pq?=
 =?utf-8?B?S1p3bHQ3emNZOUhJbUVuMlY0a1FMMUFGek5DUlB5ekJvK243QnNCSmMzcGdw?=
 =?utf-8?B?MHdCdXB4aUtyZXdVZXd5SFI4VmIyeHliYkJiQktQbUNCTitNZWlLNWR2U0xN?=
 =?utf-8?B?UFlsZVlQb1ZXaWpFUHpKelZnK2hqRUlyUFBUR3NOcTlHQnM4ZjNVVjErcXRR?=
 =?utf-8?B?Y25YK3lKdUx3UUVPRlNRMFlGdktEamtxN3F3UzhkN0VHZFZvRCtQWGwyWERE?=
 =?utf-8?B?THhpcHhHOU11QUJIMlpManN3bkV6MmtLZ2RCanlRbVpyRXhuaDFuWEMrayt6?=
 =?utf-8?B?R1d2bTlnMjNPT09kekF2OVNRU0dtNnpJa3cwamIzeHZGeGdLcnF3R254RWZj?=
 =?utf-8?B?VHFQaWx2UlFvYjBDQzlkM01xYWl6NUhReU1CSVhDZFpZeXE1bjVRRThWSGds?=
 =?utf-8?B?eGRuQUxUajc4NmRNS1ZOT1dzc3NQdEgrOHZRVnJaRlRGRFJpSzE0RnBydkc1?=
 =?utf-8?B?eXI1aDVwUDdFNFk0R3p2N3pZVlZpSFFJT1FINU80TmJDZ045aTVWTTQ3bXpN?=
 =?utf-8?B?ZDk4QkpVM1JnMHRHNWFGYmVTYktSVXBtZWtiVzdjOHJ0K3F0VjJJeHhJb0dv?=
 =?utf-8?B?ckxzSjFXOXVuWVNCNjNKK1luSVhwNjIwbEpxeE9nREY5Y2k4dm44Tmp5K1cw?=
 =?utf-8?B?QzZQdDROWm5YYTRoY2lJamlCWmxPeFZpZGNnaHAwOVRaRk5IdUZNNkNYRVFJ?=
 =?utf-8?B?UGxXMkIzeFRkSCtVdlQxSmV5cVYweFZTczNibm9DYkQreGRvdmZGak50ZC9q?=
 =?utf-8?B?dlAvUzBNTFlONERqSlkwTVZBbXpYRFFrMjVOZ2pWUHNzVEU3MzF3VEVjNnlF?=
 =?utf-8?B?dHk0bkFacnhJUzBhWStBZkJMM0dqK3lQQU5Bc2FnN08xdEZGaGdmZy9xaGo2?=
 =?utf-8?B?NEdXNXBzb2N2aHNMVm9NUzBrVEwxbmJvZVk0Mk9HYUUxMGpIMVlETTBFVVFI?=
 =?utf-8?B?WHF5UEVsdDBuaERzWXRhK3AvYkdoSW95bTZMaUxhdlR0WnRXVXNzaWdSbU42?=
 =?utf-8?B?RzVkUjV5NThnbmh4b3hOSjRIUjliYjUzam5ZejFEUllRMUtvLzk3ZU9GOTY5?=
 =?utf-8?B?WkFWaUt0b3pOaFdUOVd1SDNacC9mRmNubXp0NnBoQnRJd0RFQVBFUGEvTUhi?=
 =?utf-8?B?YXYyVXQ3eTAvK3d6N0ViV3RHNm8zdlJGTkFsNkJ1WnVxRHVZblYvaWhMS0tu?=
 =?utf-8?B?Q0VscHF3NGJzcVJ5Vm40N0M0ZXFMeURZZHBjcDRmL1c4enoxeVkzQTVlVytK?=
 =?utf-8?B?cjBEWnIyRVJQcUY2UEF1QzlPV2paMjhzaHhkNzltOVJFRlJGbC9zbkg2UHM1?=
 =?utf-8?B?NmM3aXM4b3RRK1BFNGcrb1dCdkdmVUI4RkpDR3ZabDZHZitITFkwTE54eXFJ?=
 =?utf-8?B?QlJCWXlVUHhGS3c1Nk55RnBJK2lnMWRJK2JwN1l2N1psbkhPSHlWR0xYcEtY?=
 =?utf-8?B?NDlhaExVSXgzSVRCdlBCT3hVODdNNG9OQ3d2NFhtUHRjZEk4TmdjcTZ0clpL?=
 =?utf-8?B?MDk4dzhDYUxNaHFud2M4VWRUU3lZSDd2d3BjMVA2aWhWMFRwODBCcDJSK1dC?=
 =?utf-8?B?bStqQSt1Z0tDUVFDanFKcVVpRlgvSm5DVWpsU1dhdWZ1N0gvK3A4WVVxbWUv?=
 =?utf-8?B?M1EwOEZXM0FEb3cvUVVEOGV0ZGtWczVLTm42eXVreFp4bWRHTitEc01WdlAx?=
 =?utf-8?Q?4t1ZB6D8KtwAYX9LPk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a726c98d-8d90-4b5f-afb4-08dec85510bf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 07:34:41.4895 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g3m+uaI7T4VrXhvd80KrhrysIJoloW2ajk0tABvW8OMXQbmFYShzROIkDna1kUHf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9751
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

On 6/11/26 21:49, Guilherme Ivo Bozi wrote:
> This series converts the GPIO HW translation logic used by
> multiple DCN generations from large switch statements to
> static lookup tables with shared helper functions.

Not to block this patch set, but please keep in mind that when some array index comes from userspace to use array_index_nospec() to avoid security problems caused by speculative execution.

We already had problems with that in the past when people converted switch statements into an array lockup.

Regards,
Christian.

> 
> The new implementation reduces duplicated translation logic
> across generations and makes the GPIO mappings easier to
> maintain and extend.
> 
> The series introduces generic GPIO translation helpers first,
> followed by per-generation conversions.
> 
> The following generations were converted:
> 
>   - dcn10
>   - dcn20
>   - dcn21
>   - dcn30
>   - dcn315
>   - dcn32
>   - dcn401
>   - dcn42
> 
> The dce60, dce80, dce110 and dce120 implementations were
> left unchanged for now.
> 
> dce60 and dce80 contain special switch-case handling paths
> that currently do not map cleanly to the new table-based
> representation, so they were intentionally excluded from
> this refactor.
> 
> No functional changes intended.
> 
> v1 resend:
> 
> No changes since original submission.
> 
> Automated review:
> https://lore.gitlab.freedesktop.org/drm-ai-reviews/review-overall-20260512190019.228440-1-guilherme.bozi@usp.br/
> 
> Guilherme Ivo Bozi (9):
>   drm/amd/display: add GPIO HW translation helpers
>   drm/amd/display: convert dcn10 GPIO translation to lookup tables
>   drm/amd/display: convert dcn20 GPIO translation to lookup tables
>   drm/amd/display: convert dcn21 GPIO translation to lookup tables
>   drm/amd/display: convert dcn30 GPIO translation to lookup tables
>   drm/amd/display: convert dcn315 GPIO translation to lookup tables
>   drm/amd/display: convert dcn32 GPIO translation to lookup tables
>   drm/amd/display: convert dcn401 GPIO translation to lookup tables
>   drm/amd/display: convert dcn42 GPIO translation to lookup tables
> 
>  .../dc/gpio/dcn10/hw_translate_dcn10.c        | 484 +++++++-----------
>  .../dc/gpio/dcn20/hw_translate_dcn20.c        | 432 ++++++----------
>  .../dc/gpio/dcn21/hw_translate_dcn21.c        | 417 ++++++---------
>  .../dc/gpio/dcn30/hw_translate_dcn30.c        | 432 ++++++----------
>  .../dc/gpio/dcn315/hw_translate_dcn315.c      | 418 ++++++---------
>  .../dc/gpio/dcn32/hw_translate_dcn32.c        | 386 +++++---------
>  .../dc/gpio/dcn401/hw_translate_dcn401.c      | 392 +++++---------
>  .../dc/gpio/dcn42/hw_translate_dcn42.c        | 193 +++----
>  .../drm/amd/display/dc/gpio/hw_translate.c    |  86 ++++
>  .../drm/amd/display/dc/gpio/hw_translate.h    |  21 +
>  .../gpu/drm/amd/display/include/gpio_types.h  |  48 ++
>  11 files changed, 1274 insertions(+), 2035 deletions(-)
> 

