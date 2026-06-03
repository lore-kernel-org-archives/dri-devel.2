Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2900FCD6E55
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 07:00:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 866EC10F916;
	Wed,  3 Jun 2026 07:00:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HA4cpx7c";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012044.outbound.protection.outlook.com
 [40.107.200.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCB3B10F916
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 07:00:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+zPjzHAlG2SO/+ecuW4iu4hIcc8fAtQyhuUuskeVqpYgDcpMWY4ldG9Kq0jlq2ampsijCD+GoP9D2mTg6Q55Rj5aMBAt7Iz1txQa/kN6mapSpiW6CYVGZo/oGeQehBdF4Q3lAhLPgBFx9oJmrQUlwVfh4V6NnGSHgrzp8Xe8K32kotsMCllJ58IWKNnqYs/qyoWSMbe3inkXOQ8mOiUhFYmG1sFI5AYK10qKxrWjvrOwg9yGd5LEyQIshTmPInXwZw7xLSywwPxuESJI2QBTP/D8g+7bJrvYkoRVMcEt0Br/3ZYpumHBHoim9elHeOVC8wuGkziNimDVzMhpat4GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=glxa/qiwrC5Nh4NV5FYIvLvt08tsDfgG41NbVAMZry0=;
 b=FNRiE1a8RevLHNlGz+dMaIagMgZCtgu4157VnEuTCClGRqEkYNY6RjN1ge5tr90YUpD9PC3ECDRZ2M3gr87R54+1tnROIPv06tg3yflFMAKsnOnT5VOP1HeTm2dmb1t+efwoDHEdtWSN8yoxUMZL7qxBxS4S3/uRxGVbrHUFZVUyydYaZUZ8p+z5PAVSXNBlINgI2ACo7yaZpStkq71T9rJUKYfz/xXWCznTWcAI/Y0Xw3Vr7T3QkiUFkHQwzjN2n89Mr4PWpHreLr3CwUYfuR96by/Rf7Gfy+owLcLjTcChZGIGJIiSEXkanq8VPoX9NLjXeObCMj3dAhzccvIIWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glxa/qiwrC5Nh4NV5FYIvLvt08tsDfgG41NbVAMZry0=;
 b=HA4cpx7cWchS1GyM2JlaRUDSeM8gNHv9qouTfxF5XXIzIT2BZhMmM4QnFEmSibky9UW0/+0Cjn7XVdOhYXYxyupEWQZVH1KaZJG9aAZRa2zFTXPmsg4EFN7Scb6JQT+uxnfusL6LnsXVHznwvQWkQbufI0VLbTGkJirlBxnMV78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4314.namprd12.prod.outlook.com (2603:10b6:5:211::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Wed, 3 Jun 2026
 07:00:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0071.011; Wed, 3 Jun 2026
 07:00:12 +0000
Message-ID: <fbac6fc1-9efe-4b62-8352-b231879cf64d@amd.com>
Date: Wed, 3 Jun 2026 09:00:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sched: fix NULL deref when logging missing entity
 runqueue
To: Candice Li <candice.li@amd.com>, dri-devel@lists.freedesktop.org,
 Philipp Stanner <phasta@kernel.org>
Cc: Alexander Deucher <alexander.deucher@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
References: <20260603025636.1301481-1-candice.li@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260603025636.1301481-1-candice.li@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0161.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4314:EE_
X-MS-Office365-Filtering-Correlation-Id: b251664b-03b4-4a7a-711b-08dec13dc19a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: EguHJK2mn0v0aJ1ZmgCtiT0NqiBMhPPQWyl0+/UMO/8/HW1qO3NatezhSOaTk2qhE6X2Wssyih/qNDaZ4uvtruhc/0YwCBsjZil4C+NZJshN8eMH3INtJSyF8XulIimgDe2XDYLse2tgVyOIHnwH7XRg0i2jIgXfvXG19Cb45MOjxM/SYj2GyT5pNwqKmwKWaTURcdrNpJ+1v5if6WlukUe/hYrm9SEH91rYRiD6VRx+6EUrXO9rWdEozHd+84ALKKqdq8kNNbR9rTolRMFN4H4GY7EmPgGYWnyxPSAkiabaFrsFKaEG0A8pbPBUF7iLGgOz5mZ3MxqzqczHDg2ic+zaAC5qq6ixljqeBX3kq2887YnJVEgRzCRU3dkE+Tm7iTEmZhd6kvpq2co8ky9uKsvbjXWLwDCvQtH4oswTHTSqp5Dow9lf3qbGIXC+RZo79R1ejP0AJKX4JxtNwaTRE7XAa+3vCkhWNZanZhRnuWRjUPN6L3LOABzunFeyLf76w4SgJdVCEenEN5i9I99+g2qIUG3+K1R1uUHX8RkuLey3jU88izIh01MPgQYHsi+Qdb8+8rOh4vr3J0EV+eWMWQeIWe+EPGJF5GfZdf0QmfXOw42ulwY7SWQHRHrm6o1lEuFeoZOAW3APrIS3LQpr9Csql/hubbpDuPd58cjDgKr8mUTXJsCuxgEO7O7B31fm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(11063799006)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWRiSjRXc2tiWTdZMlU1WnYvS3h1NmVHbHltbS9ia1VQRnpYdTJqQmN0Q0l0?=
 =?utf-8?B?QWR6QkpkN29sRUFvajJ6NFhPbHlJZ0F4bE05dCtHT29kNzRPM0JzOElCeFlm?=
 =?utf-8?B?ZEd1TUxxSTVIRnZSdy9QUFJObCtzMzdrYzRKRGtvVjRaQjZyZjFYLzdEQXpB?=
 =?utf-8?B?UTNLTXdvNU03K2Jxamswbm85RkFOeVp5VHhSdFB0ajFzY2FNNHdVZVJ6UEpH?=
 =?utf-8?B?TFZMN2EwSlBSbnVpb0FhQlg1R2YxVXpXTlhLQkdmTytjRkZ5MjRtdkxqZkJx?=
 =?utf-8?B?Q1ZjSHZQT0RqMHFSck9zbDBMdm52ZUhkRGlRcGVhZ2ZGNHdqbTJ1dGdWOTIz?=
 =?utf-8?B?YXpSNzhDOUppTFlweVJFQnMydzJnbTlkVlRwMVNhcWNuZzBqYW1KZ25paWVi?=
 =?utf-8?B?VlNpWkNjYjN5T2RLbHp4a2JzMDNubkpqOG9EdWFSSWxaSXg3YTZ6UENrQVZx?=
 =?utf-8?B?VkFvbGJwdVZ5a0VianYvWHVEaDNJSjdnUCszSVBkTGdOTS9PcS9SR25aUjdL?=
 =?utf-8?B?cXB2RjE3aEhsL1l1bHJ1cTVtOTU0RlJDYmxVbXZrMUxBZUlPNjNUUyt3Y3ZQ?=
 =?utf-8?B?bXVRNkV5VWVMRUVMUWZ2ZFBnN3EzTVBYM09CQjJTcENlU2lKRVExRExkd2Vt?=
 =?utf-8?B?MjNabzFZakozbVgzOG1hWEw4LzNpZXZnRng2dWl0dkEvQVJ0dWV5Y0VBVzJv?=
 =?utf-8?B?d3QyWWxROUhCekhMWjhPdlpYSzNqcmpzdlhpbzVkOXV0VXJNNU9FSWJQUjU2?=
 =?utf-8?B?dG1lKzk5cHFCOUI1ODIvSFQ0NVBqZllMbk53RzE4c2NEbzRscXRJdjQ3Y0lW?=
 =?utf-8?B?QjFwN0Zocm1Gb296NzRoa3Q2cmNSUTJMNGR0Rm9MQnV0cWl6TVhRRXFRZU15?=
 =?utf-8?B?bExXYnpteTM5b2crS0hiSENxanpLVEl2Mm8ydTd3Z29rcnVWWTQ5V3N3dzBK?=
 =?utf-8?B?ZFVaRDlkeWkrYTFVQXhYMFFTNkxTTWZLZFIvTURsNUFvQ0s5OUdkNVdoK0lx?=
 =?utf-8?B?dDJLYUdDUisyWHFONXRNcmkzM2VPUTA0b256TjVvblpoNTZlYk5NOStKMmt0?=
 =?utf-8?B?VnQwVm42ckxFUFFBUHVvS01YNWNvS2pSc2F6blBMVWg3Ykx6ZllIZG1mZVps?=
 =?utf-8?B?b2pIcFgyczZML0QxdjhDTExldXZTSHJ6cW9LZ3VTckh5bm5OUTF4Q2lyWnJq?=
 =?utf-8?B?TFJxT1RoVnJjQWRHcGc4UFlKaE10aFMwdG9wejhHYWNkZ2tOTXUxblI4Vmd4?=
 =?utf-8?B?cjBsMXVZL1NFeDBvN0xXVC9OVDNsK3lTbHZoTDNuVXpvRWpPeGM2QTFLZmxK?=
 =?utf-8?B?MWtCWVBFM1RWQ2M0bW9MWmtFZ2xWbCtXaGVONWpiYUVVdzI0TFk3ZDlPU0Q1?=
 =?utf-8?B?R05KSzB3TmQ5dG00Z1hZZFhtRUk1c3FUam04OHJWdG5acXRueGFrbG40MUZL?=
 =?utf-8?B?MS9hVXA0YzM1L0JlWGpFYUZqbHByQXZ3TFk2UGJTVEFUblF4Q3hxQnhaeVgv?=
 =?utf-8?B?QlIzaUpsQjJNamYrZDJqdWVOcHRsSXRjN3RvT1lyd0pIWU5kMHlxcVVsTTZV?=
 =?utf-8?B?Z1paMm4zZmliWnlZSk9mNW1iLzd6S3ZLcnM2TWVFMXNyazNXRXRCcVZMRURu?=
 =?utf-8?B?SE15QnErOTBWaUhXeHJlQlF2ZGU4RmpnMFIyK04weldweFNHOW80a0QweXpS?=
 =?utf-8?B?Q1FKUVJPNHE0dWQzWk5vTzErTkY2d3ZvRU50SWRLRWRMY1dIZ3BxVWcrTnA2?=
 =?utf-8?B?L3piVmtFb2hnQVVQMmc3blVhZllRU0hLeDhOdVAzbytCL2pQN2QwS2xrUGVU?=
 =?utf-8?B?b3VoZVpDNkNHWGk4cDVpaE1XZEJRZW1SbWJ6cUU1bWdPalFKbG00OFl2MlIz?=
 =?utf-8?B?NWZYUHVyeXIrZ21TeVZ0aThlZlJwNlZxcHg0a2ZXUk1iNFoyL2NwOVhJYjVN?=
 =?utf-8?B?S2I4SnEydVZ6aE9Oc1E4NWkvanpXMTFrcE9OU1haRGlYR1RlVWxQV2toTUQ1?=
 =?utf-8?B?c0ErWE1vbXQvUFpLU1pva2V4V0gwYk1lMStlcTlqOXVKeVQ5UkZpYmJhZFVB?=
 =?utf-8?B?UXFSeDlGeGlaQVJKR3BEdjd3RU91bXBtam1ha1dZb3Nqd0dyWk1ESWUwcEZo?=
 =?utf-8?B?ZFI5QjdvYStycm5RaUVGU2NpeG83R1NaQ0NDMW40WGJtRC9VWEs0eHQvYmto?=
 =?utf-8?B?S0V5QW1KQnU4M3BnbklzVVZpaE1uNEV3Y3lvdmE3V3dHZXRPeVdYWDZ2TGto?=
 =?utf-8?B?RVNCZjlmSTRsTGFMWUJheE4rcG42VjBEUzFzTEdNTkZ2d0RKYkVoaE56UjZS?=
 =?utf-8?Q?6uh1IuRQ2T0cEE8bAE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b251664b-03b4-4a7a-711b-08dec13dc19a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 07:00:12.0450 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MBGui0pqDbvMytHXNnL9JImvgzVJNfHuwz2rcHzOtkJ+l6sE/35zskAaQtqfy34u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4314
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

On 6/3/26 04:56, Candice Li wrote:
> job->sched is not initialized until drm_sched_job_arm(), so use
> pr_err() instead of dev_err(job->sched->dev, ...) when entity->rq
> is NULL.

You need to CC the designated maintainer on stuff like that! Please use get_maintainer.pl script.

Regards,
Christian.

> 
> Signed-off-by: Candice Li <candice.li@amd.com>
> ---
>  drivers/gpu/drm/scheduler/sched_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index bd7936c03da2aa..d21eada76cedf1 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -806,7 +806,7 @@ int drm_sched_job_init(struct drm_sched_job *job,
>  		 * or worse--a blank screen--leave a trail in the
>  		 * logs, so this can be debugged easier.
>  		 */
> -		dev_err(job->sched->dev, "%s: entity has no rq!\n", __func__);
> +		pr_err("*ERROR* %s: entity has no rq!\n", __func__);
>  		return -ENOENT;
>  	}
>  

