Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 969D7CA5FCF
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 19:25:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEEC010F4B6;
	Wed, 30 Sep 2026 19:25:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1Xnq7mHm";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012058.outbound.protection.outlook.com [52.101.53.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 867E110F492;
 Wed, 30 Sep 2026 19:25:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r0F45LYupDEV1E6rrnnWOdbUX+vepHkkjP6eZigxDiqQEhAgUHG2Kf/HswFZ7VuKq5VyhszlxFQCqCkf0OXno0JkobyGX3xuOW4BFzbW+euZqsRwOpPbj25XHrBgIzCUwfQ3Ye6HZfUldLEL+8UgIH7lQDtEoncnf+zNhcb+uJiWVYBD5ohTAWwjn7Y0xhfNKEiJ9O9FXzEKAOrp4uep/IGpONJuDJkcrtX8r6Bzlq9d2OKnRX2yHLuc/e4+em6WYILw9TJ0Lgn8NiGRHk0BVCrYlUggEGFtzHJKSQIsIp50KHiLFjCNoNDb30dQXXC9Fb60m8Jg7iF1RHLzr4gENw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQ5VHVl9SboREzNtJ3mCm7+0d8MWUNHbeKnz1SHVqGY=;
 b=CGZT2paJoW0KTwE+57FSPUTBN/SUricVPKAjyhFIIFAXXokBsbRztIUs08bw/W6F73lqIAD5KSy2yq9SzhJjqbzNZ+QanCRt6PiEb3cuM5ZnlfvKvCKnZNCZi4JLgm5D3oHtJQ5j9ykbJlzebnthlZSF7Wi3+8zIY/uvMD5t97zgJi3ny7gK0fOCQryav3dxhvmHH97ZN9rUJ11ETv7pTT89F3RihO6eXNbNalBkwEg6SFr86ZyYk7UfTcBQy41wG2s0knmSh6R0aKv3SEs12aJLvP6a29T6amcT8XrG3dXmt14U5giWhuJTA2U/N5Y6cIuoQsVY/g7DqpCVue2Zdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQ5VHVl9SboREzNtJ3mCm7+0d8MWUNHbeKnz1SHVqGY=;
 b=1Xnq7mHmFOO+RZ68vDvdb7A2X9RQLOLNH23IBOvJh00GfJ/kDop3sOkIJLHPWExXPtCqesDaCcYR1CSferLKMG5QVoEyryjoTLd1RvuoZ8n2G/ZdUjlimJ84Be8NzCbmXTndlR6mJaMiTqALr5GLNVWA31Q6ssI7RrSHEnHAp9w=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by CY0PR12MB388677.namprd12.prod.outlook.com (2603:10b6:930:132::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Wed, 30 Sep
 2026 19:25:48 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%3]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 19:25:48 +0000
Message-ID: <e129e9dd-d6e3-4ba6-b699-e3c554594e53@amd.com>
Date: Wed, 30 Sep 2026 15:25:41 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/11] drm/atomic: check if an active colorop has a
 blob if its type requires one
To: Melissa Wen <mwen@igalia.com>, airlied@gmail.com,
 alexander.deucher@amd.com, alex.hung@amd.com, aurabindo.pillai@amd.com,
 christian.koenig@amd.com, contact@emersion.fr, daniels@collabora.com,
 louis.chauvet@bootlin.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, sebastian.wick@redhat.com, simona@ffwll.ch,
 siqueira@igalia.com, sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Uma Shankar <uma.shankar@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Xaver Hugl <xaver.hugl@kde.org>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260811171011.184964-1-mwen@igalia.com>
 <20260811171011.184964-5-mwen@igalia.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260811171011.184964-5-mwen@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0406.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::22) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|CY0PR12MB388677:EE_
X-MS-Office365-Filtering-Correlation-Id: e1d77b0a-ae38-49b5-7c16-08df1f28a194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|23010399003|1800799024|10067099003|56012099006|11063799006|5023799004|4143699003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: hGvQnvloVWyrVC8xiG0WyLH/SmCUQyo3fdev+m6uKocTDpk1sjbsJ7cm1FGcHSTkBgSNeMPzEmFSLmbHGbN6/p6Rf/NIFphwEOeW4BSbIBPNLq8W+s+8P8vfA19dnU93OsxQUZnZcEbuwS23cvW1tjR18raq/OeBiGhUz560IaHgXGO3cVV6WG9d73jsVV0YjeygtPu4hs0LJ8iKeCGlzZgb6KNStz1ICFbuCkOJ0lFVE+t9RuSGb26C1qw3gIPINp/tEmQ6JvI8vphG8wspLi0McloPMqsJ2rLID+U18uMShnjDV/bq6iLtvOytCSP60d2imkoBq2e/Qpt79kELSGaMAQ0GNVRPERTE+aszb097rQz7L1vh9uPYxHOufEYSg47M/MtK3yAlEXSBb8yYcSbugunxTim47jtEpNwBlYeWOqFVYQwp3nRCz9ifBaVZ9eK4HyrH2hLCcwbaDzSKobl2p00uGfWdURbZaPgWiE9xWj3IheGwjehXdPfzzDhNtbsimKU3S8CErI+dm1hgnJ46hpH1vp3zYnawn6AFkX3JQIzORpmxB0LjkcQT4Htl/+sJzS/0e/RS6EwKg8QYElCbaj4McMH84CaebKh6jjGJoAq2G74JyQukQ8/YioEICAFMHjw4pUMW2U4KskBEMz9z+hnSDm1Px5db1me3llGSpYiZK7BixFd2ZiW1Q7e6+CBsrsV6aYOl5559Uh1dLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7007.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(5023799004)(4143699003)(18002099003)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGFWVW9ydlZJdnltdkdoTmRkdG53VDhKajBLbDIxUGU5R0IxeXBETi9yUjU5?=
 =?utf-8?B?TlNTNXdhK2dvaUwyZDd4emRSbFRQK0NJM2piSHNSZlZuTk9Ub2x0cXV4QUhP?=
 =?utf-8?B?MkhkQlowNHlSQS91dWtWaHNaUDhJSWUvOVNydDFnOGdxWklWb28yWDE5aVE3?=
 =?utf-8?B?dXBwQlhLSEZpUXlLSHQ5cElyY3VYQ3ZER0xIZmY2aVJnemx0ZjJSWFVsQjcr?=
 =?utf-8?B?MDlHOGdCM25rdWdmYVVxNmpSdjBvRkpLUk5QMU9XM2FEbVlZa2d3ZDkycFBZ?=
 =?utf-8?B?YXQxamF6bFlBcGI2ZUhvUGRqS3JSRGoxb1JXK0Z2L3NBeFVQc3hUVFV5N3Zs?=
 =?utf-8?B?dmdIRzBLbHVKVjR4WWd0NUZFY1lJbGoyMXA0aW5UT0h3WjdxanhyWncwUVVt?=
 =?utf-8?B?RWErbW1CdnNqRFlqN29CaXZhYXNVVm9RWUNLdUJacUdTWkRzcVJNTGpER3N6?=
 =?utf-8?B?T2IvYWtxdVNzWDI4ZThGbnBHakpTdTB6NE5yY2VkQzdzVlFLOEg2Qkdacjhu?=
 =?utf-8?B?eElGRDk1Z0NZWHp0S04zR3NuT0dya0RLS21hakhVd1JzRmxKQWk1WlNoZjJj?=
 =?utf-8?B?UTJ3OXVwZTZNdXZNNEFpaVcrcHNVSGZadWZmRjVKN3hHd2N1MXdVWVhsWmJ0?=
 =?utf-8?B?a25aV0hvRFlWbDhDU056UmNrVlFGeHAzdUJTY242S01SMzcwRjZYWDNFWGp4?=
 =?utf-8?B?UTV6V2pPeDQ0V21ET1VIak5Gb2lZMXVuOUhiUnZnbzNDQzJWNDR1OW5zaWNa?=
 =?utf-8?B?R0VpOXNiYS9WT01JckVqYXFMRmJ4WGQ1RjNhcjlaSGRkMzU4MEhWNGZaczNQ?=
 =?utf-8?B?bW1LQ2ZOSzNIZXgvU0c4dFk1WE5xUXB4L20rSU5OWnJXM0JzR3YrL2dXY2J5?=
 =?utf-8?B?QlQvNU4wbGtJUnFzek5FTzA0T1c0dXMyUDdrNERkbDQ0TmE4OTIxVDQwZitw?=
 =?utf-8?B?VWZNS21SK2JxaEZMaTEvZ2ZGcmJzamNFSXBlaVVYdXBiUmtiVzBtZFJxSVNr?=
 =?utf-8?B?YzhpSHB2cG1ITG9JZVR5N0hsc1g3U2FOazFJVFdNY1BodmlrRGMzcHJvUXYw?=
 =?utf-8?B?d3JwUG45aHUwMjNZQWpmYkI0bUptMVpNTWFPeThhNGt2cWFOb1NJVWdJZkw2?=
 =?utf-8?B?UDlDNVppVFFtZ3FpdThBaWhaMEYzNk9zUU5acVBMaU9XNklQSTdPQnBobm82?=
 =?utf-8?B?MEl6cjFLdHdURllxK3JIT1I4ZHgydFR6QVAyeHd1eEJlZmIxcTBSdVU1NVBF?=
 =?utf-8?B?NzlSUXBha011MXJJaEtKMlI5SjgvTlNnb0dJU3NScjJyekNTNWRVdDNkWDBi?=
 =?utf-8?B?UTVyNHJjTXY2QnllVmw5VXFGV2wzaFZ0cHV0VVlHY3BqUkNZVm5MRlVlTXdk?=
 =?utf-8?B?Y1pxQTFGdU9oMVQwNDRyUUpGd2VWTktMdWIrdXVjbFZ3QjFCWkdDYTB0ZlZN?=
 =?utf-8?B?c2h3SWNpRk5CTVFoM0dxMk0zRG51UFFyZ3dwSjBPSzFoY21xck5ic3dTdEt5?=
 =?utf-8?B?a3V2Z1U1YmxrWVhkaUNIaXVEbHB0SWx1eE1qUnVjdFYrRlJ3OUt1dWUwb3BT?=
 =?utf-8?B?d3pCMWpJYjRFTFBvNGdwWWRHMitZN25SS2tLZHBlZTVHT1lPbHJDTHR5ekl2?=
 =?utf-8?B?MjJiSTI5NlRPNE53NVkzQ014NlY1M29xVEd2ejltbVp4YzhSS3dqc1hSdXBB?=
 =?utf-8?B?M3lhcnZvK0pZMElvNEVxYzFOREtjTUZNNk45WDZiQzdmTXJZU21BcHNyWnBF?=
 =?utf-8?B?dkhNdlM4QSs2NnUxRTBrMWFoQlFJTy9qMWNJYTAyYndoMTRmMkp4T25oTFVa?=
 =?utf-8?B?TFhQM2tCOXpRT1o5Qkp0UWo0Ry9vcmhiNTBzZk1MUjQ5di9lU0FBd2N6ZWhZ?=
 =?utf-8?B?UXNMall2SHpqelpGaEFqenRLRDFJMDEvQ0RGZzNNdHpYSTRISDQzbWJTSFkv?=
 =?utf-8?B?Y0pzQmluUlIvTFJQbVkxVXhrR3k1SmRxUXdEWVp0aExPaGVoV2d1UkVIQTBK?=
 =?utf-8?B?Y3RVc2ZVMkVGU29wT0tJZXJEZVNpN0xoRzJkQW9mRUVveHhCc3NDckZKalB3?=
 =?utf-8?B?QnNuNUVPUS93R1M0a3dmbmF5c0tjd09zMHoyakl0WFUxcU5kOTVKU2VSNUZi?=
 =?utf-8?B?bEE4a05pMHlyYW9PbDJqS0JxRmJzTXZQclplNVlRbVg1YjJYZXEyYlZuT2Vx?=
 =?utf-8?B?c0VDYWljakg5WTV0NjloRTBtbmtja0g3NmcvSWlCbSsxYjVPbWN4OTNBb2I3?=
 =?utf-8?B?WDFnRGlWdWowVXgveFg5Ym9wc0hLUkUzRUZhSHBEWW80Z3UvRnd4bGFZWmkx?=
 =?utf-8?B?N2hGczIxN0JRc3phQUdkYzV5TzBqZ2FtbXBwTFI3NC9aWGFmbmZkZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d77b0a-ae38-49b5-7c16-08df1f28a194
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 19:25:48.1513 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: thkMowHVjy7TeafMylqvHN0keZCVsp8IYHq96nQguFZgMMStIxyUkSZH1qfgoYPzrZe+Ge6vccpR2AjrFJHASw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY0PR12MB388677
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

On 2026-08-11 12:45, Melissa Wen wrote:
> If colorop TYPE requires a data blob, userspace have to set a blob
> whenever enables this colorop, i.e. when setting this colorop bypass
> property to false.
> 
> Fixes: e5719e7f1900 ("drm/colorop: Add 3x4 CTM type")
> Signed-off-by: Melissa Wen <mwen@igalia.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>   drivers/gpu/drm/drm_atomic.c | 22 ++++++++++++++++++++--
>   1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 86e4348cad58..7b9d52cf87d0 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -947,8 +947,13 @@ drm_atomic_add_pipeline_colorops(struct drm_atomic_commit *state,
>    * drm_atomic_colorop_check - check new colorop state
>    * @new_colorop_state: new colorop state to check
>    *
> - * Ensure that the colorop in @new_colorop_state belongs to an active color
> - * pipeline, i.e. it's in the chain of colorops set to the color_pipeline
> + * Check that a colorop whose TYPE requires a data blob has one when it's
> + * enabled, i.e. userspace can't clear (or never set) the DATA property while
> + * taking the colorop out of bypass, since drivers would have nothing to
> + * program.
> + *
> + * Also ensure that the colorop in @new_colorop_state belongs to an active
> + * color pipeline, i.e. it's in the chain of colorops set to the color_pipeline
>    * property of current, old or new plane state.
>    *
>    * Userspace is allowed to finalize colorop's settings in the same commit that
> @@ -972,6 +977,19 @@ static int drm_atomic_colorop_check(const struct drm_colorop_state *new_colorop_
>   	if (state->duplicated)
>   		return 0;
>   
> +	/*
> +	 * Reject if colorop TYPE requires a DATA but set bypass to false and
> +	 * no blob submitted
> +	 */
> +	if (new_colorop_state->colorop->data_property &&
> +	    !new_colorop_state->bypass && !new_colorop_state->data) {
> +		drm_dbg_atomic(new_colorop_state->colorop->dev,
> +			       "[COLOROP:%d:%d] enabled without a DATA blob\n",
> +			       new_colorop_state->colorop->base.id,
> +			       new_colorop_state->colorop->type);
> +		return -EINVAL;
> +	}
> +
>   	/* Not a plane colorop */
>   	if (!plane)
>   		return 0;

