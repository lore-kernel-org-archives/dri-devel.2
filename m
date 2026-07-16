Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B38AC44512
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 21:05:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8EE010F3E4;
	Thu, 16 Jul 2026 21:05:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iM9ogRLX";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010057.outbound.protection.outlook.com [52.101.46.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 419B110E3E3;
 Thu, 16 Jul 2026 21:05:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k6ATBFPQ0WDoWzSnG3bhzK60tg694xkRfltE+FbxZJqSzqbC1g7BXPKhNLM3E7bRY9nLtRXpTYYWHm/782onb6M9qHIDDMgm2x1nJ2QMpYYwMkwOPdJpT5CtvOp4s27gtQZba1uHHaAACP8je4mXclV7SPz8QI7LJswIwdxpngcBW2AsqPH8Sm1HaXeCSCM2ZaSO8jhtVaSFqcMMKnjnGpihOHiEDXzdo504fR/PwQZddd6UpWDhHWG9Tnrac6A0y7QYKB2uf40feeLpQIcdRlgrb4j8b2cVcttLvXb4tuwB9SuiaQS5yIHTN+WeyjY/+Y9w2k0a8hCXoA2NNbT1ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVTIYQYuG/frBDA31UmYDgZo2xZs8w84m0pwtpcPYbs=;
 b=pGKEZzBi/xJ/oWmzQaGh8A+oF5xB4sAUzOedp/Lm6370LdWzFcsy47pQnqsVC4UXxUGmZFtV1Nw3YXkCXPBEYJU223bnX3SGUsmXDNEsEmQm9OJsJewfKM7evBSim6EFTpEIxvgREGgkEhL6DkxgM/GAczVVdnneSDCU7xobBWQzMSXradufX4593+D11+VNWphEjeGcqp0qU/NCJdstEJmNRGagMIZm5P24iMErqqMoi157fGRk0Xvo92SuS1zoEZZ95KsdXB6sL/+oGj0RUi/cPMW5zgEG4BpVE2QrYctHz/thIVZK1Rvc1luRA419rIaovZGERBipIY8JsgcUOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVTIYQYuG/frBDA31UmYDgZo2xZs8w84m0pwtpcPYbs=;
 b=iM9ogRLXCo4x/RUJWH+2eyk49/cyJt7x3q0Fy+PL11MPqXhs2JO2XbOP/ZTLEKoJvyfL+tJ7UgGOMNoNFiC4t36QuXFnaE+nhctUNNw0v9m2rlvlpC7eNXYcdSHsp2DfcpXvJ+7qunNZFFl8Ptc1NcUb8oYrLiUAPtbuJBVHPvQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by PH7PR12MB7283.namprd12.prod.outlook.com (2603:10b6:510:20a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 21:05:33 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 21:05:33 +0000
Message-ID: <9c6a9bc7-b6bc-4dec-b248-1054b6e70847@amd.com>
Date: Thu, 16 Jul 2026 15:05:30 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/7] drm: writeback: Modify drm_writeback_queue_job
 helper
To: Suraj Kandpal <suraj.kandpal@intel.com>, freedreno@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, kernel-list@raspberrypi.com,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Cc: uma.shankar@intel.com, arun.r.murthy@intel.com, abhinav.kumar@linux.dev,
 tzimmermann@suse.de, sean@poorly.ru, marijn.suijten@somainline.org,
 laurent.pinchart+renesas@ideasonboard.com, dave.stevenson@raspberrypi.com,
 tomi.valkeinen+renesas@ideasonboard.com,
 kieran.bingham+renesas@ideasonboard.com, louis.chauvet@bootlin.com,
 kernel-dev@igalia.com, John.Harrison@Igalia.com,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260714042805.77934-1-suraj.kandpal@intel.com>
 <20260714042805.77934-4-suraj.kandpal@intel.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260714042805.77934-4-suraj.kandpal@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0009.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::14) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|PH7PR12MB7283:EE_
X-MS-Office365-Filtering-Correlation-Id: 7da92880-29cf-47d5-0c16-08dee37df9d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|23010399003|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: lPh+bU6msDeYYIU7hxIyfq+wSfDiQ1KCkg1P99NYn5VExjoQs4SZXveQOYFd6rAJltKDDh6x/ACVizO8RfAkJO8pf0R/GtSJQyXZJqwgxAC1d8986D/e6DDDfXrypndO9T0OVjeV8DMoiPeinhwgnXTft9dKiRe9LF6p6SfsbEDCQmCURx6+2BvKuOECPZRMsyM4zlNOXE02r2KR5GghNLiRaIZmohJOaEZAhT9jcRdJyViiqWCY49iEMAjLjSrgi7tIrEb80lzelwI/2ICKEJsHNti/vhYvXZChK+C0JRS8GIZF2ySt1ea7yfRhbfNW9cbd3kUAFHWIq4YrvPARdPEoc1q1y4Em+CocX92yUsznCi7jh99PAGYplYIXhSp/WMN4FZpa1RTpXr5fgKEOPyB59ZJU1fWXo0NejSVQAIU0ZnqYInYxBCHqAz2VZ7r/yaLQILTu66iZmo0ed8kL/XeIybr0rgUvUJ2huPyepEv6f61ynUExrujyDsdqklgU4zofTkC5bgxS0aA2x4wC//iydvS/5xDU1dDpbyj1zVlE9UhN0wb/YTpualKmJI/qESqqt3zutFukfuVaHiYC2d7e96LBtX+tnQETE29+pzjaLm7cikqjr16vJqYPFRpmaaGfY7sAHqDbArm7nBBt1lXs8O1ey7S3jEg8ByS/+s8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVNzdEdFNUxVUUdsWWZOMCtuVFZTZGJYU1JiOWdSUXJWTlFhM1BOUXZtaldF?=
 =?utf-8?B?S0t2MGhTREZrdGhZZXNObHhXQ3FRV3IzSGxzWFd2M2w2dUdoTHA0UmNmakhx?=
 =?utf-8?B?TlZNTk5ZRkUzMEFpRDJNRkJNTlVVcFdkQkc3QWJ4MjJ2b0tnVVUvN2xNdGZT?=
 =?utf-8?B?SmgzWkNsdkxMdE5qQXJ3K0UveFFmUFZzbDhjUjFtaDNTbjRSNTZldkc4SEpI?=
 =?utf-8?B?T2lrTlozVzE0TVh3dFh0bGs1Z1hDTVd2aytwaGZCWkg5UXltYVZTbGJFMDRo?=
 =?utf-8?B?cEJTRXRQeGFudEFEeVkxa2xPd2Y1RjRnRUxKMFR6UjZwd3piMkYyVENqWjJE?=
 =?utf-8?B?QW5qUTJ3eE14Z0lzTWdsU0M1VjdjSGdvZDFLTG00Nm1zT2dLMjJmZ1NRc216?=
 =?utf-8?B?RkU4Zi9mRVVsbHE5MmZGcHY1a1piVmhuWnZYeFJzemlrazN2NjZOTzZ2cDRv?=
 =?utf-8?B?QWlzK2JzeTQzbzBENFFxSktGNVBjVy90dCswWUlGc1FJbFNPZlZ2VC9ZN3Bk?=
 =?utf-8?B?Q2NnTjg3c0xJbHAxSlJOMzg5Q21rd3lnWlpjV082OWtFWVE2dC81T0JGWkdq?=
 =?utf-8?B?b3ZYTzNlTjU2SGR2MUJaWUJ5ZnB5Yi81dHArNVFkaTdLaFpORVhOaFUyVk5F?=
 =?utf-8?B?eHVXOXdsK3o0QzRlV0t5Z1ZIRjFkMlhSdlVPalRwS1FCUStkNDJob3RlMTN5?=
 =?utf-8?B?VisrS09TZjRsWFdkbTF6OG9zSGRiSWhmUUFMOFpGNkViT3UyNVJULzlobXFN?=
 =?utf-8?B?UWpQQWQxU3U5RnQvMHRQTUVLbU0wYjJCTTYwR0VPYm5qMU5TbTdXVWN0SWFm?=
 =?utf-8?B?QkxLdHFhTVBmOXFPT3NnZFlqOWg3NmJDelYzSHcyTmUvMkxFckJEYkQxbm9Y?=
 =?utf-8?B?WkVmV1FhUHl6MFhTWkVhQTAxaTdTR2wxL1NhR1UyYy9OanpWMk1aSnpkSU1R?=
 =?utf-8?B?T0lwSEZEOE9NcU9oWHdwYVRGQ0dFOXhZekRRMVFjdlltNGRqN1lPcHJOYllS?=
 =?utf-8?B?Y0ZmcU5HL3RjOEw3SWZNRFA5K1QxY3VSeExubmdvZ2tUUEdYUXJ3RjViN1d2?=
 =?utf-8?B?dlhmcWZEZUJ2UURoUlhBS3Qxa3VOYm9EbWJXeGh4dzd3RXd5R21FS0oxUTAz?=
 =?utf-8?B?ZG91Tkg2aHRqSlJiMm5La2t1TkNRZEMvcWhrcnhFWEc4Y3l6NUdJS3A3dXNy?=
 =?utf-8?B?aHBhUTh1dDE4bXVTdm12Vnh1Q3l6cFZFT1Y5WUNpcVRoYVBYZ0JuNVhhZFNY?=
 =?utf-8?B?bm5EWm5VTW5TWnVlajRqYmhlV2Z5aE9iaUxtVzg5Szh0QnlpVGxkaUc2MDM2?=
 =?utf-8?B?bmY4WWVBOUYvUHFTbDhwMTFzdUF6NUN0eDB5TmdwTTMzdjFxN1IrUDl4ak5M?=
 =?utf-8?B?dmxaNkx6Rk1GT1VSdjNjUmZ4SVpOeDlIeUNWK1hvcjlFeHlxVERqNDRRc1Yw?=
 =?utf-8?B?bjExQWRteFNRYTJnaTdjWG9iSVNJVFBTaUVlUGRFS2pJTTZiUzNsWmR4bVNq?=
 =?utf-8?B?ZUR0dHVtTEJsQ3NBcmltRkJiZW1nTjNZMlloNGtlampRVHFvZENQNGlyNlZh?=
 =?utf-8?B?Q29wQkhtVmJwMUVZeDNENHlONllvVTY5ZUQ4aHNrM0dsVlFJNStLcENVRUdO?=
 =?utf-8?B?c3J3NHZ1UDgvNFB6bXFZWXZXOXlLSkMvOUljQ2hJUlBBMEtDaVVlZCtWWmlT?=
 =?utf-8?B?OCt1N3Q1d0ZDeXhOWjFHWHZhU2Q5ODVmMDlEamN2d2gwZXQ4Smk3Rkp4aFFY?=
 =?utf-8?B?bjRhVnBsSzFOZ0I3eS85emtIVVhjWTROTHk5NlkwTTE0RTU1eGJlYmpjWEtP?=
 =?utf-8?B?UHNiM09KSnNVcFBIWHVpV3lob1cyRkxQS0s4SzZUMk9Xc0xQNE90bVFic1k5?=
 =?utf-8?B?R09ycHpKZmhVSWtMQkxhbEVpZ0tJZ3N2SFByMW1EWGRTaDlkb0xQVHl2aitP?=
 =?utf-8?B?aUNqeDc2Q21zR0REWWFkUVE0WGIyUEU2MmZMc0VqVzJYVnZRTlNGNUJWRWdL?=
 =?utf-8?B?QWk4cjFuNFYwZGxIZXl6UjdvRFZPYnArSEswV2VZWnJtZG1YczVhS2dETDB2?=
 =?utf-8?B?QkVXZ0tDNDNBTWZrbzl4U2ZvNFpDQlUwZXdQRjlNL0wxQzVsb2JvTVpaS2tI?=
 =?utf-8?B?YkxSWUV2M0FWWGkwc0pGeXdDdUF2WitUeE81VjVQV2lNUTA2cUY4SndZSjZW?=
 =?utf-8?B?dHI2c1ZXZHRVNUxHVkhpT1NZM0pnSGdiMUh3eERIbXFSUXEwYThkWWFPdUhx?=
 =?utf-8?B?dEVOOFRhZHBNcENqQ3RoM1VGNGJsZWR6WHpFOXpPQld0Zy9ERWxUclQvSy90?=
 =?utf-8?Q?N7+3znuVdzVV1LQJVj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7da92880-29cf-47d5-0c16-08dee37df9d3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 21:05:33.6254 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PVZhAIiUzQgQXx8dh4XDH8kJuTeA+sb/N4mJ+RrKtiPQ+jzcQmphiAQZ0MfniQG3G7RE/2AH/gzvhiEQStY7dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7283
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

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 7/13/26 22:28, Suraj Kandpal wrote:
> drm_writeback_queue_job() needs access to the parent drm_connector
> object as well as the drm_writeback_connector object itself. So,
> pass in the top level drm_connector and traverse down to
> drm_writeback_connector rather than passing in the lower level
> object and traversing back up. This is also consistent with the
> rest of the writeback interface which is being updated to use
> drm_connector as the top level handle.
> 
> Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Reviewed-by: John Harrison <John.Harrison@Igalia.com>
> ---
> v5 -> v6:
> - Rebase over latest kernel
> 
> v4 -> v5:
> - Make @connector kerneldoc wording consistent across the series (John)
> 
> v3 -> v4:
> - Update subject line for consitency (John)
> - Update commit message across commits for consitency (John)
> 
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   | 2 +-
>   drivers/gpu/drm/arm/display/komeda/komeda_crtc.c    | 2 +-
>   drivers/gpu/drm/arm/malidp_mw.c                     | 3 +--
>   drivers/gpu/drm/drm_writeback.c                     | 6 ++++--
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c | 2 +-
>   drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c | 2 +-
>   drivers/gpu/drm/vc4/vc4_txp.c                       | 2 +-
>   drivers/gpu/drm/vkms/vkms_writeback.c               | 3 +--
>   include/drm/drm_writeback.h                         | 2 +-
>   9 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 427a8a52d256..9504f6b5571e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4975,7 +4975,7 @@ static void dm_set_writeback(struct amdgpu_display_manager *dm,
>   	dc_stream_add_writeback(dm->dc, crtc_state->stream, wb_info);
>   
>   	acrtc->wb_conn = wb_conn;
> -	drm_writeback_queue_job(wb_conn, new_con_state);
> +	drm_writeback_queue_job(connector, new_con_state);
>   
>   	/*
>   	 * Writeback completion is detected in the CRTC vblank IRQ
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> index 6611920c45fb..c64cf5d97e62 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> @@ -271,7 +271,7 @@ komeda_crtc_do_flush(struct drm_crtc *crtc,
>   
>   	conn_st = wb_conn ? wb_conn->base.state : NULL;
>   	if (conn_st && conn_st->writeback_job)
> -		drm_writeback_queue_job(&wb_conn->base.writeback, conn_st);
> +		drm_writeback_queue_job(&wb_conn->base, conn_st);
>   
>   	/* step 2: notify the HW to kickoff the update */
>   	mdev->funcs->flush(mdev, master->id, kcrtc_st->active_pipes);
> diff --git a/drivers/gpu/drm/arm/malidp_mw.c b/drivers/gpu/drm/arm/malidp_mw.c
> index 271ec83c7e48..159d7bb3a189 100644
> --- a/drivers/gpu/drm/arm/malidp_mw.c
> +++ b/drivers/gpu/drm/arm/malidp_mw.c
> @@ -244,7 +244,6 @@ void malidp_mw_atomic_commit(struct drm_device *drm,
>   			     struct drm_atomic_commit *old_state)
>   {
>   	struct malidp_drm *malidp = drm_to_malidp(drm);
> -	struct drm_writeback_connector *mw_conn = &malidp->mw_connector.writeback;
>   	struct drm_connector_state *conn_state = malidp->mw_connector.state;
>   	struct malidp_hw_device *hwdev = malidp->dev;
>   	struct malidp_mw_connector_state *mw_state;
> @@ -264,7 +263,7 @@ void malidp_mw_atomic_commit(struct drm_device *drm,
>   				     &mw_state->addrs[0],
>   				     mw_state->format);
>   
> -		drm_writeback_queue_job(mw_conn, conn_state);
> +		drm_writeback_queue_job(&malidp->mw_connector, conn_state);
>   		hwdev->hw->enable_memwrite(hwdev, mw_state->addrs,
>   					   mw_state->pitches, mw_state->n_planes,
>   					   fb->width, fb->height, mw_state->format,
> diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
> index 79c4be2acbbe..e999eca5b649 100644
> --- a/drivers/gpu/drm/drm_writeback.c
> +++ b/drivers/gpu/drm/drm_writeback.c
> @@ -408,7 +408,8 @@ EXPORT_SYMBOL(drm_writeback_prepare_job);
>   
>   /**
>    * drm_writeback_queue_job - Queue a writeback job for later signalling
> - * @wb_connector: The writeback connector to queue a job on
> + * @connector: DRM connector which contains the writeback connector to
> + * queue a job on
>    * @conn_state: The connector state containing the job to queue
>    *
>    * This function adds the job contained in @conn_state to the job_queue for a
> @@ -425,9 +426,10 @@ EXPORT_SYMBOL(drm_writeback_prepare_job);
>    *
>    * See also: drm_writeback_signal_completion()
>    */
> -void drm_writeback_queue_job(struct drm_writeback_connector *wb_connector,
> +void drm_writeback_queue_job(struct drm_connector *connector,
>   			     struct drm_connector_state *conn_state)
>   {
> +	struct drm_writeback_connector *wb_connector = &connector->writeback;
>   	struct drm_writeback_job *job;
>   	unsigned long flags;
>   
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
> index e2a328225c9e..0a4026f22274 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
> @@ -486,7 +486,7 @@ static void dpu_encoder_phys_wb_prepare_for_kickoff(
>   	state = drm_conn->state;
>   
>   	if (wb_enc->wb_conn && wb_enc->wb_job)
> -		drm_writeback_queue_job(wb_enc->wb_conn, state);
> +		drm_writeback_queue_job(drm_conn, state);
>   
>   	dpu_encoder_phys_wb_setup(phys_enc);
>   
> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
> index 6b27307941a4..5cd6c81a9710 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
> @@ -246,7 +246,7 @@ void rcar_du_writeback_setup(struct rcar_du_crtc *rcrtc,
>   		cfg->mem[i] = sg_dma_address(rjob->sg_tables[i].sgl)
>   			    + fb->offsets[i];
>   
> -	drm_writeback_queue_job(&rcrtc->wb_connector.writeback, state);
> +	drm_writeback_queue_job(&rcrtc->wb_connector, state);
>   }
>   
>   void rcar_du_writeback_complete(struct rcar_du_crtc *rcrtc)
> diff --git a/drivers/gpu/drm/vc4/vc4_txp.c b/drivers/gpu/drm/vc4/vc4_txp.c
> index f11ad54d067a..9cf2ec99bdfb 100644
> --- a/drivers/gpu/drm/vc4/vc4_txp.c
> +++ b/drivers/gpu/drm/vc4/vc4_txp.c
> @@ -356,7 +356,7 @@ static void vc4_txp_connector_atomic_commit(struct drm_connector *conn,
>   
>   	TXP_WRITE(TXP_DST_CTRL, ctrl);
>   
> -	drm_writeback_queue_job(&txp->connector.writeback, conn_state);
> +	drm_writeback_queue_job(&txp->connector, conn_state);
>   
>   	drm_dev_exit(idx);
>   }
> diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
> index 9341533b0325..2e3df9388dd2 100644
> --- a/drivers/gpu/drm/vkms/vkms_writeback.c
> +++ b/drivers/gpu/drm/vkms/vkms_writeback.c
> @@ -131,7 +131,6 @@ static void vkms_wb_atomic_commit(struct drm_connector *conn,
>   	struct drm_connector_state *connector_state = drm_atomic_get_new_connector_state(state,
>   											 conn);
>   	struct vkms_output *output = drm_crtc_to_vkms_output(connector_state->crtc);
> -	struct drm_writeback_connector *wb_conn = &output->wb_connector.writeback;
>   	struct drm_connector_state *conn_state = output->wb_connector.state;
>   	struct vkms_crtc_state *crtc_state = output->composer_state;
>   	struct drm_framebuffer *fb = connector_state->writeback_job->fb;
> @@ -153,7 +152,7 @@ static void vkms_wb_atomic_commit(struct drm_connector *conn,
>   	crtc_state->active_writeback = active_wb;
>   	crtc_state->wb_pending = true;
>   	spin_unlock_irq(&output->composer_lock);
> -	drm_writeback_queue_job(wb_conn, connector_state);
> +	drm_writeback_queue_job(&output->wb_connector, connector_state);
>   	active_wb->pixel_write = get_pixel_write_function(wb_format);
>   	drm_rect_init(&wb_frame_info->src, 0, 0, crtc_width, crtc_height);
>   	drm_rect_init(&wb_frame_info->dst, 0, 0, crtc_width, crtc_height);
> diff --git a/include/drm/drm_writeback.h b/include/drm/drm_writeback.h
> index c6960c7e634e..b4c11d380df0 100644
> --- a/include/drm/drm_writeback.h
> +++ b/include/drm/drm_writeback.h
> @@ -94,7 +94,7 @@ int drm_writeback_set_fb(struct drm_connector_state *conn_state,
>   
>   int drm_writeback_prepare_job(struct drm_writeback_job *job);
>   
> -void drm_writeback_queue_job(struct drm_writeback_connector *wb_connector,
> +void drm_writeback_queue_job(struct drm_connector *wb_connector,
>   			     struct drm_connector_state *conn_state);
>   
>   void drm_writeback_cleanup_job(struct drm_writeback_job *job);

