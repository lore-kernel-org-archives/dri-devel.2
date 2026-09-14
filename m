Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4334CC88E65
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 10:53:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A556610ED45;
	Mon, 14 Sep 2026 10:53:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KKdD906b";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010066.outbound.protection.outlook.com [52.101.85.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D3C910ED40;
 Mon, 14 Sep 2026 10:53:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZoQWx/S0wuF5qUOL2q2Ez+Hn0Um6tDRXLRuUhZTgllUA0QQH6RcTCSgIQGPsUfv4Kb9AtRsEtQdrsCL8xdPjLMUJQTBdEdqVS6Xm/P32zPlNAvn5i8XT/X1Gm6oZ0Jp9TZIJk0BfolKtY9EOe1OJprA6gPZpFp/MNj0aeeW/Wd2XsVBnmE977sN0HWnxFwxKToqMeBqoF9AmTKZAtaRvl5gkxRpUkY5gj5VMC/qwZDqvfjfajAaVZXWVZ6dAoHQBzobThymxKbn3+xeCB2DZUGWfQjqyg83ZP/yQIanBxssGCbyYdjqGlEZfnVxNCSrZZuSybmTn6ttHsPrsQ/Efxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X93ax+vWmlV1beP5dKOTorWuANHrFv3wwm7d92XH+4c=;
 b=ap5+ZigHTvebDgW2NMvhCKbdP+YG3hGc47uCsbWbFExHH2W+nCnBWvaFwhgRgI2aPOgf6l1aErswJpeRDkQKDHb3sIMkCdrDnlUyMdoHCj/FblNpH28Byh+noftgc3jJaPhk/YT8EhaE7muP2+A6qIDqmsIvtQebnO/nk2mRaO2TMQ/4iU9YJMdIKepTsajrnB51rrFUCZdPx2wyDdnhIn3oK3CAQIp3T+EVMowaF43x4mYTmIXgVApRo9eN9X/KskbSMW++9/Zt9Kabgs+17PQDgfECp9J+gaSuXCVsq3ycAvpuwDTeBfuYWb1DptojW4QTofUYNQ556EdMQ7VXAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X93ax+vWmlV1beP5dKOTorWuANHrFv3wwm7d92XH+4c=;
 b=KKdD906bbN+YPEaep75Tf3McVrDOkNqUkHrc+XM5Z74VY/1OqtKOWy+aYtEMentDtPFJYYYVE6yHe5mVf8jZ7Fx/QATlhQt3uZwJ1r9td7gtcUDjH0NBnMr/wTzsr7yWP3cx7svFttW5qT9ycvy1K99s+mNFF2kB5CXKPhkzRlA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY1PR12MB9625.namprd12.prod.outlook.com (2603:10b6:930:106::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 10:53:23 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0406.005; Mon, 14 Sep 2026
 10:53:23 +0000
Message-ID: <eaa458e4-47be-45d9-ac65-19c8451c277e@amd.com>
Date: Mon, 14 Sep 2026 12:53:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: update git tree for radeon, amdgpu, amdkfd
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: felix.kuehling@amd.com
References: <20260911191316.1705352-1-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260911191316.1705352-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: IA4P221CA0010.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:559::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY1PR12MB9625:EE_
X-MS-Office365-Filtering-Correlation-Id: a9ad366b-12b5-4198-0fb2-08df124e65bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|13003099007|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: r0rDFOiusgNSQrriL2fct2uZ67+lcMKc7nk38+0f+r7zXZD8tEe24nJuK0xv+qbIRviFseyOfWieY3O92biMEZD3iVlDEHOu1tF5NSWa0Htap8gS5dpvu/HtTPQqZa+Xgx/aJ3MRGh7U3Q8p2QCASBolLjjQM/6Bj1SLH8WTsYwpeb+FfmTG0yf9WCgpKcp0XpaAFfOhvZrZJZnEqqsa0iTzHKoaIPA7t5z74J4bsH6wmdoXDRY+buZVOVFDkOXSw6RI/COgywRBdxwQH+/qlTsvXug2TOqmY9UoHMswnHIijLeM4FRNDz/kr25R9rF8Cu2tD+osX749dzskBXQyiG8PWJqZ+mnoH/io25keW+ssp1xgI6yaHLMk343PyPes5GoDMOIpDlNP/m4reLmlBULDQG2w9zDtMtacmjGTDors3fMG2XKzonbXUKDh7c/1+HhcwtQj+haRXiNKJhHSjTsJc03Dh5+Mt4bTxLTfZZzMq0kg58Uncrg5wBy/Y5t9CoBC/HS9jLVL7nf/+9DYiEAjoJ4QApjlNBop+EtLeQF28JbZOlzztMPdGDjcZA5SB6Fqe1GLZCxiIFywGzqR1Lz+tzqH6kS8XjqOjWL7ZrQjvTydDCXfJ/9rbYfbycz4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(13003099007)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QU1TTlEwWnZoWXdYcXlzcEdvL0cyL3NqWml1U2tvdUl5aTI3Qy9pN1VwQUI1?=
 =?utf-8?B?ZzkxZmVwd2phdTVwS2N5d3h3Nk1UcnJGeExrQ2RtcU5VZlNXcDBZRW1YaU43?=
 =?utf-8?B?MUNML3BXSWJqNVFWeTlXL2FDYkNONUZYZjEvc0gyQTFwUUFTN1FTY1locHlB?=
 =?utf-8?B?ajR3dlVsSzFWYTB5QlZTMzd3SVBmM3Z0VXNPRmdRM0V5L093b2VhTlVuMHhL?=
 =?utf-8?B?N3duV2o2YlFBVU1vYXpqRHlGalB0T0xSS3dnQU1vM3Y3VFMzRU5LKzZaSE5U?=
 =?utf-8?B?REU5SEREczBKeTRKRzkwVUpsdkl2d3NqOW5PNnZhaGNtakN0YTZjK296WEVB?=
 =?utf-8?B?cWxOalk2YXJYdHgyOFNKL25HWnJsTEdXRzBxaXpXa3FNVkJPZ21NQUV5Wklk?=
 =?utf-8?B?OWRPTzAxMHZ0Ti9ya2EyVHd5aTJ3MG85QzNtRkxhaU1PZE5kSTNYcnNRQ0lF?=
 =?utf-8?B?S0FDaG5rK1dGbEtXdnlyQXZuNVBoSXBCNFJmdnRER0hWNWRQUkxsanpRS3hN?=
 =?utf-8?B?NjhrVG5TVDFHeVJhcytqWGJyZS80SCtza202aC9SNzcwZjF2bXN0L2g3RHpn?=
 =?utf-8?B?MHhvZ1BLK09GTUoxTFRoK3U2RmlDU0pKa0JDSG9YTjVLQ2Z2cFNiK2ZUN2lu?=
 =?utf-8?B?ZEVRY0c5ME96VnFOMmx0USswRlp3OVQvY3ZhcDlhUXZrbVRqMDQ4NnlObEVp?=
 =?utf-8?B?eENvUFVFQmhLdXJ2aHUrdDBXMDgyRU9IV0dJK05nYzVDRTdrM05IWU1IdmV6?=
 =?utf-8?B?WnQ2L1cxVHdPNkZIUUNQdm56d2ZheXFJa2duZDFRbDhWbU1WOGxCa3pNTzNU?=
 =?utf-8?B?Q24wMXJoaFU0am15R25YcVZRMkQ4ejJXUG8rNzg0ckxiQVNHaVpGSGVjM0du?=
 =?utf-8?B?UnZLTlpPUmluZ3NvM3RYL01xOHh4V2hic2VnUUxxekFHdVFpVUpjN3hKRmFC?=
 =?utf-8?B?UGtST2orTHFpQlVFSlQxRis2YlM2NC9qcXhybDlCZHpkd2VKZ0FMaUkyYktz?=
 =?utf-8?B?SlIxSXlkVnhuUENXLzBPZEc5bC9DcTViMCtwQWJkR3A2c29Ja1c5aFdkWDA3?=
 =?utf-8?B?TGFrRXYxSHhpZGpSZEx3Nm9oRzVyZDRJVkpGMWpXbUNsY3p6M0NGYmhzYVEx?=
 =?utf-8?B?emNFOVE0VWl6VzcxU2JBWHM2YUdaWkR6UUtpV250eFR3MEc2dFdqTURTbE9z?=
 =?utf-8?B?TUhCWmJqbC9zWndldmMxMElHN3dpNEJNMEdHSE5jcXluOHJRS3VZMlRYbVVl?=
 =?utf-8?B?K1c5bTVWYW1XcStCcm82SnVSV3l1WTN5Unk1b3JSS1BpcEd2U200NjhINWsw?=
 =?utf-8?B?NnJyazczemc1WDV2cVR2SnRPZW8xM1I4ZzFUZ0orNlp5d1JCb0twZUlraDNT?=
 =?utf-8?B?VzV2eVlSUDFhSzlzU2RKQWZRUGc5ODU2bVhOSEdFc2d4YnIzZWg5aFJzcDFE?=
 =?utf-8?B?cVdIdmlaVFNhU0dDM2d1RExKeHZaeG5YUmJUWDd0YjJzUDVmdFIvZmRyNWFK?=
 =?utf-8?B?cy9taVUwUHRuM2EzNEhpTzlWZFE0UWw2U3NVMDBMYzZFZndiSU83SzU1VkRC?=
 =?utf-8?B?c3pWMlB1S1lTVjczTm9pQ3RwSzNjQXdsVnBUMlNZZm41RG9BOStoR1ZxdGxP?=
 =?utf-8?B?RVNxYmlGZ2s0UmV1OUNqYW9HTVVOMW1uOTY0Y2JST2V6YkF1QXF3TUFIS0lH?=
 =?utf-8?B?STNDSUYwZzZBcDE3QjJnZEg2WE9hWGdkMktoWll6REJONnFJYkVYNmIyM1hm?=
 =?utf-8?B?UjAvaHlrdXJEbTdSMkg0MG52d2pWVlpjRnl4Vk1YNmUyTFh5Mzl6aklQbkRi?=
 =?utf-8?B?YU1DZUp3c0pYb2Z2WnFyMWppcFZXYncxbThySEJ0MVQxQ0RaL0QyL2xJMExv?=
 =?utf-8?B?Qk5vRThtbWtSY1h3ZGRWMUpFa1Z2S2pEQlVaaG9BY2swOFdpbXRiR2xrRm5r?=
 =?utf-8?B?aUtiVWxZSEhqaGZtYllTSGRmemY0U3lNVndCQUN4eWRwUWh0c3lyMUxzWUg2?=
 =?utf-8?B?bWt6eHRDbFNWb1RmdzZLbENDQ0VqTzE3dmdJOEd6UUZySTBvOE8xYXNnZllY?=
 =?utf-8?B?ZzU0czQ3VjhWdWhMWWUrcW5Wam5XUEJoZ2oxQ2JOMG42ZTFCeXZ3QnQxVFAv?=
 =?utf-8?B?MkRPOEFaRmVQWU5ySm1ETkt5blNPUk1kSlNDaytjNU1lN1ZoMUUzblFjd29u?=
 =?utf-8?B?SmlOdEpIV2M3Wnd3U01ZamNKYlFzZ25SNGNqcEZwVS9td0NQL1VVV3dhekQ1?=
 =?utf-8?B?MFZuYjJlck5qVHJvdGtsbzdVczFaNTZ1QVFXOEdOaXJvV01pb0xhZU9tUDJI?=
 =?utf-8?Q?E2lIV7kbY83n2AGKSD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ad366b-12b5-4198-0fb2-08df124e65bf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 10:53:23.5645 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wm37Gx/Ll40KdOO/1ZIi/PhxDXVmUexITsqBh6OdOru5lKhKbnRxb+8ehF3NM2al
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9625
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

On 9/11/26 21:13, Alex Deucher wrote:
> Point to the new repo on gitlab.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: christian.koenig@amd.com
> Cc: felix.kuehling@amd.com

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cc2d3e4275654..4c5ad2d7f3f88 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1188,7 +1188,7 @@ AMD KFD
>  M:	Felix Kuehling <Felix.Kuehling@amd.com>
>  L:	amd-gfx@lists.freedesktop.org
>  S:	Supported
> -T:	git https://gitlab.freedesktop.org/agd5f/linux.git
> +T:	git https://gitlab.freedesktop.org/drm/amdgpu/kernel.git
>  F:	drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd*.[ch]
>  F:	drivers/gpu/drm/amd/amdkfd/
>  F:	drivers/gpu/drm/amd/include/cik_structs.h
> @@ -22193,7 +22193,7 @@ L:	amd-gfx@lists.freedesktop.org
>  S:	Supported
>  B:	https://gitlab.freedesktop.org/drm/amd/-/issues
>  C:	irc://irc.oftc.net/radeon
> -T:	git https://gitlab.freedesktop.org/agd5f/linux.git
> +T:	git https://gitlab.freedesktop.org/drm/amdgpu/kernel.git
>  F:	Documentation/gpu/amdgpu/
>  F:	drivers/gpu/drm/amd/
>  F:	drivers/gpu/drm/ci/xfails/amd*

