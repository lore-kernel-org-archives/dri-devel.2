Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19822CA5FCF
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 19:12:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7D9810F3C8;
	Wed, 30 Sep 2026 19:12:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ehA3Fn2K";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E68110E0E8;
 Wed, 30 Sep 2026 19:12:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lliSPHBPFrUH4l+PcMPImmOjaWQWK/9iYTUtQvT9xODmyoEhcMOn5t9MdubRlqSYaObY3etFrwuaCgfMJAvHcaXxT0ruGVYQaaTIpa173RMlf38YwUIQtinx8o2pLRgNuGgtQcsrTumVunM7i1ptfcL8AiFtkT77L+CmBQ1F6McWVDqEnRV5wMqrGfz7rRYQuU4zlX+CULLkoIEJrx2MwOwFh9sKUo9eAaLayd6JePBdaWl2FH6Ur9oQVAe1QvbmyIQX3vpl8w2zUwagNG6dCaq5zkmTSQZixhZVMjYaEdBtixR5oOjkxnhsLLIFczgkKsxMQSKFsdrGUhLHK9I7MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5wKxFuFAC4LioUkzK4OYLtMj4BYyJev5r7AuA8HLEw=;
 b=ZAgBDrLctC2tc2AyizRZxnkrQTVd0a//GJDYrFgaSKx0xAzBOFS7ZcFoCmd+oxYXR8wKI5rc+LH8YbLDWR1hEBs9xmtBPau4ofjeESv7YbZIaPjm6TtMHLOBJMfY6cHa0mKzJTGpozmtFC4zBFxV19uKam92xZ4AhvtYnitFZm3gQ7BOZvGIIi3hBH9SZ0QEZPBV/HvsLvrMnXmlOdfRijV3f8lDm6xAKit3bg0fjOwTcm/+T5SkBrfOprzuGz4BqIqGIaO+Nqnra6GXlBvNuuRmQhLNrwdngQ5x/hDCuCsQkUb7Htwa9kz4hFMMUR+71IxZ1hbgcsf+o7Ij4frEwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5wKxFuFAC4LioUkzK4OYLtMj4BYyJev5r7AuA8HLEw=;
 b=ehA3Fn2KMrHEbvNpEoEa5cKcrLu8zSSx08TIPsnugCfP+An0bt4AiATfuwxhrscxPjkHToz+OgfbCvabDp+VdEuReoJViKaTZmW6sFEXuPuSVqZpr4nNiRsh4MmDcwY5Jp8G4QhLJCn4Wmcw02q4Ph90RZYppdInYsGPMD76vrE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by DS7PR12MB6093.namprd12.prod.outlook.com (2603:10b6:8:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 19:12:04 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%3]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 19:12:04 +0000
Message-ID: <c66d2ba4-bebf-434f-8d91-58b867b4a407@amd.com>
Date: Wed, 30 Sep 2026 15:11:57 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/11] drm/atomic: only add states of active or
 transient active colorops
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
 <20260811171011.184964-2-mwen@igalia.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260811171011.184964-2-mwen@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0386.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::7) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|DS7PR12MB6093:EE_
X-MS-Office365-Filtering-Correlation-Id: ec382a0a-e151-47a5-2270-08df1f26b67d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|23010399003|4143699003|11063799006|10067099003|6133799003|56012099006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: 86bI8i5GmMJW1UWfwYKN5946kQOwUNcS6izLlrEOFPr+ozlsCnviQyCQBpYf5S5nvq+Sp1zCAwC5JeBdiddpI6E/jZT7MLRJZnX2caH5sREMrcoODmVsb6R1rGjgmy3j5DpEb8rii6BteSwP8azrBrCrUDgIsTz/Nfign4P+0TeplE0UctJFWljye594ozyS6T47gITaBgc6hL5fB/4YFBL3KLTXMgEcjnx9npRMAEqtJEx1IYrsRX9Lc8zKvszBARAj0lvT+pdP5wh+FObTXeY7B7QVUxKjlM6dBNt6fA6CqUoI0/t8Y3ptpsSnY/nFXRoql/yK4jvnf7w9meTYTYPAshUVtuDmxg3YtRSjlxA4QaFRuL7IkTXSegCJa0ht36cSdxelNmqeF9BD+ipVU2n4KLAU3XyBSjyoDNVuzHCvbHp/jvj8QsV/vAYambYK66DP6dJVdGuN3JAeIKm07Ef6A3fN33hNu2kECrzy1izVmR5uxhIaM61kPHWc1RFtvzADNeZBw/ouWLYgcpCCPdg0yhv9grCL8X1YzCXfxoOsVaygn46kxQhDHb4AnFmVDkawwLGQtQKp+cj7J3zBtuAcCxk2MBPnI1dluySn4Kd7hW3kLq0p7jySdGYKaeGR59AawpwWx8Q7DuvIcs2lCmDKmF2t6kpWNC7AaBX5iMEQr/KBwSk+feD/hHmWzXC6Nj9UxZFhY9Y8nMTtoC3p4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7007.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(4143699003)(11063799006)(10067099003)(6133799003)(56012099006)(18002099003)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHNQSUttYnlUYUk4ZkFLV2hNVG5sdWpCdHJtQkcrU1Z2dHJmNE1ua3gzSExv?=
 =?utf-8?B?ZzM2TytKR2Zad3ZQb2pXZFBjdWdrSGc0L3pTVW83cmFEK0F5SzlkM1UzVWZs?=
 =?utf-8?B?YitYR0dyQVg5aXkyMHkweisrZHhLSUhRRlpvdVp6R05kOWRWSGpwaUt4NFF2?=
 =?utf-8?B?SngxTWRFNFJMWjhLek9obloyUE9PQ0dndWRYdzQrL3lIaEdKT1FHc3lQd1JD?=
 =?utf-8?B?TVNtRmlGV3RRdjNlTzRYSkFPT2hTVm53MGNhUUtPNDRTM1JMK0NGdkF6dGYv?=
 =?utf-8?B?c0VMUWdlL3dUUmI4RGMzajNpTGlEWXQvNFVmZ2wrNUpwSmxDOVNIRlZBd2ox?=
 =?utf-8?B?dTFDcW9qVGpRWFpnQUhBRXVzZnRhU1I2VG42MFY2bDdhVlMyZzlNcTd3MUNq?=
 =?utf-8?B?RkwxMlpINFZzWDRKc1MvTTdncmVSZVVFY1ViNUZwakpVWHN4cUZCejlRbWtS?=
 =?utf-8?B?QWlwZEtXZldPVUpzTG9pdXNOT0UxblJUZGhxK0Q0ZEJqbTdVQXdrM2NMLy9o?=
 =?utf-8?B?SGpvSSs1S3YrWG95T3h5Q09aR3A5bDJSL3BGTURFb2ZQbEM3aTNINlprcWFD?=
 =?utf-8?B?dnlRQ2V4NWpjanZTeEVXM0V4OFJtb0wzbHlCRm9aNWZiOUFrMGFyaXYrU2dR?=
 =?utf-8?B?T3Y0djJCd2RDcGh6cjJVUlhnajhKK1FHbm1vbjlwR3JBQ3ZjZnpTK09wdnhZ?=
 =?utf-8?B?RGVpdlk2ZUdIVDJwalcrRVJuVWF1RXlEaGRSWC8vUXhUZGgyMXU5a1J3U1c1?=
 =?utf-8?B?WGJEKzNuRkxzVHB6OHR0TzZVbU5wYTBBcWU0WnFGUXljT3NkYzRUWGRYVFh6?=
 =?utf-8?B?MUF5ZngwSzFFRExtUkMwTG9pR25URTdOTjc3MnpNNW95cXRJdHcwQ3pkR3Ex?=
 =?utf-8?B?MHVDbXhidi9vTFN2VDFDNjVXa28ySXpEcDFtV0xnNG5IdEdUR0xvNjNBdkVK?=
 =?utf-8?B?aGpkMTM0dDJiZ1RUcFpZRW00MnNlTXJ6dm5PdDU0T3dYOTRHOTF6T0R6b3I3?=
 =?utf-8?B?T1ZQbGwrU0s2TldxdjFjdXpJbjBCZTQwejM5QjFoM0pZSVZTQzZCeGhEaHFQ?=
 =?utf-8?B?eTJ6b1hyQTRHbUJQRExHNE9LaTNtSVo2MTJTREE3RmgyTDQzVzJpUFNoNXY0?=
 =?utf-8?B?WHhjOWxqZi96dHF3RXQ1a3FXZlkwRCtGQXdRbzU5SVdac2RobkRKM3AvcmVx?=
 =?utf-8?B?UHpDK0x5eEJ1NTR3TjNnbDcvR1ZQM3ZFenhjWERHVWltSmVGeEU5V2RtVmNJ?=
 =?utf-8?B?THovMGNWNGpVYk5QTXhjQmRvTlA5N2QyVGQvMFRRQkpWTEdoUGh6S25ma0NO?=
 =?utf-8?B?ZnRnZjdndWgzeUhHU2xCSmdMSzZ2Y0VrNDk0T24yZmFXVXBvN2tJNkxZTVpo?=
 =?utf-8?B?czlxeXVMZjgyUzI0aEN3azhUeGJpNTBSRkpPR3cyOEt3Lyt2TDFwZXdYWml0?=
 =?utf-8?B?VXZvVlRPTWpzL0xNdGRUck05eGlsakdrWDJ2dTVRTHFRbGFNL2taZ3hpNE1o?=
 =?utf-8?B?TEorY2UySnQ3bmhmZjNYNStIMnVOV2wrRlA5R1pjZzRJdHlEbEdMVmNLWWNv?=
 =?utf-8?B?K09tVGFrSFhDUFJDdTBBWUxWWkNZeWdjNDlTeG9GVGtHOTB0ZVFsb2lKaXN4?=
 =?utf-8?B?bE5aZ09lU3ZNMUFwcnpqVlhiaGRSeENKdzNLU25mQkxuUmFuRi8xSGN1b3Ey?=
 =?utf-8?B?UTVobzhtRHN5VHVCOW5aK3pOL1J6M21nekVPTUl5MlhXZXh1VnNzY2toWEhu?=
 =?utf-8?B?akptT1BCaHhjYmVFaXgrTHlZTThZdEJJK005V2tXUHptaFhDeHBSM0tEUFhI?=
 =?utf-8?B?SS9uTXg5cTBoZHB4bWFlZXNEdGNpYUR5KzBiLzJwVE94T05BS1VkSEkxTGRr?=
 =?utf-8?B?M2FhbWRwQkcrYkkvZHJKUUtNZ0JLem1yOGJzanZUelZnTjVDcktvWUFJV2FY?=
 =?utf-8?B?SUZrdml1bFQrYUw5UzhCNlc5VGM3MEw4UFRYVEFkbDJNS252U0xGWTdpUmNa?=
 =?utf-8?B?WUE0VjNrR2lMcC9YZk1mTmF0QllaQlUycE9xV28zVkNzRzJtQnNuSzZTNVN4?=
 =?utf-8?B?TWFiUWRJYndWRmNZTUhxbWFnUzZUYlpRVkNkcSszRlpGZmJ3Q3dxblM3R3Fy?=
 =?utf-8?B?TE9HSXFhQnBtNEMxM29yWWhkbW03bUJndWJMcHFGT3JaUGRXV2YwN082a1Qw?=
 =?utf-8?B?dncyQTlNd2lqcVl6MndkV3IwSmkxMDh2bFp6VnVvN0dtbldTb1F0L29GK0ZR?=
 =?utf-8?B?cTlhWHFEeC9CaEdwdmJ0djc5b0MyMGdQY2ZWNUV6VDNkUlJoSXc0SHhoeE1Z?=
 =?utf-8?B?eFo1NkVOR3F3VzRkY09nOEJEdmVaSUUrcmxqOGRxRDdlaVZtbmJiQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec382a0a-e151-47a5-2270-08df1f26b67d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 19:12:04.2743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hlt9Y2QCcssDR2chJoraQLBRgsn1t6g3FSe3gyFwtP5AQZM5twOgF8D8u7Q0fVqfdk6+zEf0XUGvtAN+k36ZWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6093
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
> Only consider affected colorop states those that are part of an active
> color pipeline or a pipeline that is about to be activated or
> deactivated in the same atomic commit, i.e., colorop is in the chain of
> old/new plane color pipeline property. To cover color_pipeline
> deactivation, remove the condition for plane_state->color_pipeline.
> Make drm_atomic_add_affected_colorops() static and move to
> drm_atomic_helper.c since it's only used by
> drm_atomic_helper_duplicate_state() now.
> 

There is an amdgpu_dm bit in drm-misc-next now that needs it. Would it 
be possible to treat it the same as drm_atomic_add_affected_planes?

There's a chance that Patch 3 in this series fixes it but it'll be a 
while since I'll have a chance to try it.

Harry

> Acked-by: Harry Wentland <harry.wentland@amd.com> #v3
> Signed-off-by: Melissa Wen <mwen@igalia.com>
> 
> ---
> 
> v2: define a macro to walk in the color pipeline (Alex H.)
> v4: make drm_atomic_add_affected_colorops static and move to drm_atomic_helper.c (John H.)
> ---
>   drivers/gpu/drm/drm_atomic.c        | 105 ++++++++++++++--------------
>   drivers/gpu/drm/drm_atomic_helper.c |  43 ++++++++++++
>   include/drm/drm_atomic.h            |   3 -
>   include/drm/drm_colorop.h           |   3 +
>   4 files changed, 100 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index e5c8ef06caed..f00df28e2051 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -892,6 +892,57 @@ static int drm_atomic_plane_check(const struct drm_plane_state *old_plane_state,
>   	return 0;
>   }
>   
> +/*
> + * This function walks old and new plane state color pipelines and adds all
> + * colorops in use by @plane to the atomic configuration @state. This is useful
> + * when an atomic commit needs to check all currently enabled or about to be
> + * enabled colorop on @plane, e.g. when changing the mode. This also avoids
> + * including colorop states that are not part of the atomic state.
> + *
> + * Returns:
> + * 0 on success or can fail with -EDEADLK or -ENOMEM. When the error is EDEADLK
> + * then the w/w mutex code has detected a deadlock and the entire atomic
> + * sequence must be restarted. All other errors are fatal.
> + */
> +static int
> +drm_atomic_add_pipeline_colorops(struct drm_atomic_commit *state,
> +				 struct drm_plane *plane)
> +{
> +	struct drm_colorop *colorop;
> +	struct drm_colorop_state *colorop_state;
> +	struct drm_plane_state *new_plane_state, *old_plane_state;
> +
> +	new_plane_state = drm_atomic_get_new_plane_state(state, plane);
> +	old_plane_state = drm_atomic_get_old_plane_state(state, plane);
> +
> +	if (WARN_ON(!new_plane_state || !old_plane_state))
> +		return -EINVAL;
> +
> +	drm_dbg_atomic(plane->dev,
> +		       "Adding old+new pipeline colorops for [PLANE:%d:%s]\n",
> +		       plane->base.id, plane->name);
> +
> +	drm_for_each_colorop_in_pipeline(colorop,
> +					 new_plane_state->color_pipeline) {
> +		colorop_state = drm_atomic_get_colorop_state(state, colorop);
> +		if (IS_ERR(colorop_state))
> +			return PTR_ERR(colorop_state);
> +	}
> +
> +	/* Same color pipeline as new; no point walking old. */
> +	if (new_plane_state->color_pipeline == old_plane_state->color_pipeline)
> +		return 0;
> +
> +	drm_for_each_colorop_in_pipeline(colorop,
> +					 old_plane_state->color_pipeline) {
> +		colorop_state = drm_atomic_get_colorop_state(state, colorop);
> +		if (IS_ERR(colorop_state))
> +			return PTR_ERR(colorop_state);
> +	}
> +
> +	return 0;
> +}
> +
>   static void drm_atomic_colorop_print_state(struct drm_printer *p,
>   					   const struct drm_colorop_state *state)
>   {
> @@ -1671,62 +1722,14 @@ drm_atomic_add_affected_planes(struct drm_atomic_commit *state,
>   		if (IS_ERR(plane_state))
>   			return PTR_ERR(plane_state);
>   
> -		if (plane_state->color_pipeline) {
> -			ret = drm_atomic_add_affected_colorops(state, plane);
> -			if (ret)
> -				return ret;
> -		}
> +		ret = drm_atomic_add_pipeline_colorops(state, plane);
> +		if (ret)
> +			return ret;
>   	}
>   	return 0;
>   }
>   EXPORT_SYMBOL(drm_atomic_add_affected_planes);
>   
> -/**
> - * drm_atomic_add_affected_colorops - add colorops for plane
> - * @state: atomic state
> - * @plane: DRM plane
> - *
> - * This function walks the current configuration and adds all colorops
> - * currently used by @plane to the atomic configuration @state. This is useful
> - * when an atomic commit also needs to check all currently enabled colorop on
> - * @plane, e.g. when changing the mode. It's also useful when re-enabling a plane
> - * to avoid special code to force-enable all colorops.
> - *
> - * Since acquiring a colorop state will always also acquire the w/w mutex of the
> - * current plane for that colorop (if there is any) adding all the colorop states for
> - * a plane will not reduce parallelism of atomic updates.
> - *
> - * Returns:
> - * 0 on success or can fail with -EDEADLK or -ENOMEM. When the error is EDEADLK
> - * then the w/w mutex code has detected a deadlock and the entire atomic
> - * sequence must be restarted. All other errors are fatal.
> - */
> -int
> -drm_atomic_add_affected_colorops(struct drm_atomic_commit *state,
> -				 struct drm_plane *plane)
> -{
> -	struct drm_colorop *colorop;
> -	struct drm_colorop_state *colorop_state;
> -
> -	WARN_ON(!drm_atomic_get_new_plane_state(state, plane));
> -
> -	drm_dbg_atomic(plane->dev,
> -		       "Adding all current colorops for [PLANE:%d:%s] to %p\n",
> -		       plane->base.id, plane->name, state);
> -
> -	drm_for_each_colorop(colorop, plane->dev) {
> -		if (colorop->plane != plane)
> -			continue;
> -
> -		colorop_state = drm_atomic_get_colorop_state(state, colorop);
> -		if (IS_ERR(colorop_state))
> -			return PTR_ERR(colorop_state);
> -	}
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL(drm_atomic_add_affected_colorops);
> -
>   /**
>    * drm_atomic_check_only - check whether a given config would work
>    * @state: atomic configuration to check
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 285aac3554df..917fd0594259 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -3697,6 +3697,49 @@ void drm_atomic_helper_shutdown(struct drm_device *dev)
>   }
>   EXPORT_SYMBOL(drm_atomic_helper_shutdown);
>   
> +/*
> + * drm_atomic_add_affected_colorops - add colorops for plane
> + * @state: atomic state
> + * @plane: DRM plane
> + *
> + * This function walks the current configuration and adds all colorops
> + * currently used by @plane to the atomic configuration @state. It's useful
> + * when re-enabling a plane to avoid special code to force-enable all colorops.
> + *
> + * Since acquiring a colorop state will always also acquire the w/w mutex of the
> + * current plane for that colorop (if there is any) adding all the colorop states for
> + * a plane will not reduce parallelism of atomic updates.
> + *
> + * Returns:
> + * 0 on success or can fail with -EDEADLK or -ENOMEM. When the error is EDEADLK
> + * then the w/w mutex code has detected a deadlock and the entire atomic
> + * sequence must be restarted. All other errors are fatal.
> + */
> +static int
> +drm_atomic_add_affected_colorops(struct drm_atomic_commit *state,
> +				 struct drm_plane *plane)
> +{
> +	struct drm_colorop *colorop;
> +	struct drm_colorop_state *colorop_state;
> +
> +	WARN_ON(!drm_atomic_get_new_plane_state(state, plane));
> +
> +	drm_dbg_atomic(plane->dev,
> +		       "Adding all current colorops for [PLANE:%d:%s] to %p\n",
> +		       plane->base.id, plane->name, state);
> +
> +	drm_for_each_colorop(colorop, plane->dev) {
> +		if (colorop->plane != plane)
> +			continue;
> +
> +		colorop_state = drm_atomic_get_colorop_state(state, colorop);
> +		if (IS_ERR(colorop_state))
> +			return PTR_ERR(colorop_state);
> +	}
> +
> +	return 0;
> +}
> +
>   /**
>    * drm_atomic_helper_duplicate_state - duplicate an atomic state object
>    * @dev: DRM device
> diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
> index 88087910ab1a..0597041bde04 100644
> --- a/include/drm/drm_atomic.h
> +++ b/include/drm/drm_atomic.h
> @@ -921,9 +921,6 @@ drm_atomic_add_affected_connectors(struct drm_atomic_commit *state,
>   int __must_check
>   drm_atomic_add_affected_planes(struct drm_atomic_commit *state,
>   			       struct drm_crtc *crtc);
> -int __must_check
> -drm_atomic_add_affected_colorops(struct drm_atomic_commit *state,
> -				 struct drm_plane *plane);
>   
>   int __must_check drm_atomic_check_only(struct drm_atomic_commit *state);
>   int __must_check drm_atomic_commit(struct drm_atomic_commit *state);
> diff --git a/include/drm/drm_colorop.h b/include/drm/drm_colorop.h
> index 224fae40ed2b..568dfcc4dd63 100644
> --- a/include/drm/drm_colorop.h
> +++ b/include/drm/drm_colorop.h
> @@ -457,6 +457,9 @@ static inline unsigned int drm_colorop_index(const struct drm_colorop *colorop)
>   #define drm_for_each_colorop(colorop, dev) \
>   	list_for_each_entry(colorop, &(dev)->mode_config.colorop_list, head)
>   
> +#define drm_for_each_colorop_in_pipeline(colorop, pipeline) \
> +	for ((colorop) = (pipeline); (colorop); (colorop) = (colorop)->next)
> +
>   /**
>    * drm_get_colorop_type_name - return a string for colorop type
>    * @type: colorop type to compute name of

