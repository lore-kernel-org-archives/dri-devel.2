Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AEFFFF885A
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 21:50:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 907EF10E88F;
	Mon,  4 May 2026 21:50:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z7i9PLbn";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010034.outbound.protection.outlook.com [52.101.46.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A27210E1B4;
 Mon,  4 May 2026 21:50:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KgmI5iRbZSppJ3RKfwk+rQsgDPzEDPbXm9aINo9iM2CFNkRxPVu4IpG9z771Le6fmomHSVQdOhcGmOEfRUpRs13mAwGnE6q8e/+NOIirxoZSlD9HJ9osLIYeDxylzJ4EUfGtFETcQ9NvDEqd95PE+/GBDLx5/fxi6TsnzFDGBj71d5hcVAhau5tGQiVhc5W/WsyZKZHQomUO0F73BXz6JgDomjwULfTBNOlOAy0M6qtE5kCD7Y3XMWXTT/t1sM7Bdrp5p8v1waPnv2PfcvLTr6NL01lqKYs2d2xjd8qyLD5AM9zfZpsz2X/fUe/C37IKrhad9jkAIMcPeh5AtWOybA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4VwKopxczeCgptzafWS2CoS47svuEl+ErUZk5MwRRk=;
 b=Ran6psYFNwd4wzuHUNHzz4s7cmkhKEakJ05ubkrLa5h1ZXdCCuAQ4J3RyWRFvRGSbChHdjUuzeXqr8fSwK6TP4ZoYBnxgr45EtKFEPkVlIHnx3VnQa+nHBN+W58/lRqTGL6RAm0+BxZdIcVJXn64GVdrJtvYhdWk+axDUHk/jL5XNtmQcocdu34YzeE3/FsjEJTGS2AFmmkJEPYz1T7B34mgx5DEZ8LSMIa9jTibwKYUnvmmxDXMi9yAvVlzz4owpvU9w3PEVIizo2IwihE8QVTY9R3Rl/NvAeusiqZb5vLYedM7y+cE+/NxAoT9peeddggSCGAVC9bQpR8o+FeaaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4VwKopxczeCgptzafWS2CoS47svuEl+ErUZk5MwRRk=;
 b=Z7i9PLbneVlxVWrKJD2zKU07GrRqcFgMiCt9vhEglrohZTmWui8Kw5FwWZIGhWolQAG+CXEkspdkQoPEpR/3Nxvq9OHp1CetoJ+uXsuuXNp/LHJGcQAzabRgRgHN8xP9Nh+OMM+4ihlDotiwb2rWb89SzQP0HOOmiRRUtJjMyEY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by CY5PR12MB6057.namprd12.prod.outlook.com (2603:10b6:930:2e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 21:50:26 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 21:50:26 +0000
Message-ID: <5dd93e29-a076-491b-9861-e08a0204c77d@amd.com>
Date: Mon, 4 May 2026 16:50:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] drm/atomic: attempt full modeset on page flip
 timeout
Content-Language: en-US
To: Hamza Mahfooz <someguy@effective-light.com>,
 dri-devel@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Alex Hung <alex.hung@amd.com>, Ray Wu <ray.wu@amd.com>,
 Wayne Lin <Wayne.Lin@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Ivan Lipski <ivan.lipski@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>, Yussuf Khalil
 <dev@pp3345.net>, Tom Chung <chiahsuan.chung@amd.com>,
 Roman Li <Roman.Li@amd.com>, Colin Ian King <colin.i.king@gmail.com>,
 Charlene Liu <charlene.liu@amd.com>, Kees Cook <kees@kernel.org>,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260501203552.749080-1-someguy@effective-light.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260501203552.749080-1-someguy@effective-light.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0192.namprd03.prod.outlook.com
 (2603:10b6:408:f9::17) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|CY5PR12MB6057:EE_
X-MS-Office365-Filtering-Correlation-Id: c24c1e03-d731-49df-8e04-08deaa27266f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 7zqGTBlxKyhoaiqg+dF7Qi8NVd9UDyr4hFfdCzWms4vHloDO6RM1WPGM0kttgg/SAcjNToYfve9ZnnAnU99uaxBdolhaYmVSx7QZohSvVcwIsAyOBYv4KKQfbxDcVKzwowoye+nbskO4olZ4Bc7JkyvxZn8fPUVXt8MC9shn36IlD0Ai7WpC2EBd6kJigVHR556GDUMetZT9jRdJqkHitBQUGgnnAeahVPo8K07zDvRZssfnPViYh98y4HIokG6mbBKJnXWgcP7cfJGFcvHRG6UPf5ko/QFxDiBG11RsfSD+FhYzs6Uvp3JwUAFwQPFz5YMuGCB+qdy6vCHWoRxnMcgYD1i7dLgOli4WP4Jkomn2n299YI4Ona1AMrqsObsmSUPw3PbZnUZjcoUAqwV5gtZCTesHQWbrvoY8tB9zwG1im3Fmfdzmfg1MAChBGqaYY5KuIpTUuEWionBMN7trTXhEZO96B6gfSNDE3qnY2ckjAvGhOkYf9wlXXJErVh/+oI4yVlopfoKmwQZoGa//p3s3k4Bh4UNMy4OIKrQtuOOHtZiJmXk9GdMWXoLzVSw7JBsZ1pBmKnn8Iawg3Anf8nWuHVillb4L2qVsd4/qE2SFwLqaPYt1x+AaNqGPeR0xrhkpVvnITWVCCa4/2fwBO99rNJyW0HlgVVoZXWKZ8dyBZZoYbvNGl8BCEKA4HZXH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEtNbUxPZWQrL09SUTJFbldoa0docEJ5bGRqNmY3dmdoVG5KengzeHNwenll?=
 =?utf-8?B?OUU2OExlMzlqZDFXeGRsTEVDdWVKVmR5QzlyWktJQ3ltR2NycHh6TEFDYkNi?=
 =?utf-8?B?dWhzOS9CMXVlN3dDb21ubUZrWEFROXJNakU5SktPUTAwdXN2TkhyTVZFekpM?=
 =?utf-8?B?U0hiWGgvcEdOM1A3R0sxaHFGZlI0bC9OTVdtaHN4M0hkVGJ0VVBXckQycXFn?=
 =?utf-8?B?aFk2aGQ0UXFvRWFOTUpKVkV5L1pQY3JaREdWUmNOd0Q2MW5JWno5TjMvaDc3?=
 =?utf-8?B?ZCtkSjV6N1Y1M1ZRekNDU2VSN0t5OXpia2tEKzFVZW01RlpVWjV1clZKMHlN?=
 =?utf-8?B?c2hzZjU0S1hDanpaaXlMWUhmNy9RWExyYkcrejVRL1AxQklvQitMaFBFcDZN?=
 =?utf-8?B?RFloZ2tNb240MHphRkxUSUk1MUVGNkZNWUlFekFKNlVzRG82TE1CT2dORFVW?=
 =?utf-8?B?bm5rRFRCN0poWEFmSC9FRlJnT2ZzaVdBbzdRVlhCb3FubFZEMmllSERYUWkx?=
 =?utf-8?B?UW1HS2lIZ1B5WGpCeEo3Wkp5dU5XQjdKdU0rd3lOY0JSQnNnaVNFVW5hWjE1?=
 =?utf-8?B?L1NmcDNXRk5HUHRJc3R0L1EyRndYV2xNU0lHSnhQZDltU29zOWhqL3pVT3h4?=
 =?utf-8?B?ZXBHbzRZSkUwQUhqVEFzZCs1aWJOclJlQldFYzBEN1V2aFpER2h3RXFkTFRU?=
 =?utf-8?B?b3RNUzZnbkEvNm5xbUs0Sk9yRkFlMUlMSS9wQ0VEZ2ovd1VmSmFXK0ZUM0JE?=
 =?utf-8?B?azhEMVpDY05sYjU2YktNbXcrWml6VVBpVXVDMUNXMVlmOFVKRjZ6dHVXK0FQ?=
 =?utf-8?B?RFY0M0VydWRMaHJuanM4SlRiR2pVSytNalNtc3ZoRlc0WlppMzZYRGFSQjl5?=
 =?utf-8?B?OTB0cmFlNHJUVSswVzZoanpIRDJNamtSZ3FkK21tV1Q0aTk4Zll0UzVJRTNK?=
 =?utf-8?B?ZmNzVE1ZNkZkK2Z0eFdkVWJZYm9mQlVzbTV4SGt5T1lhMkVJZU1jMFBwNEx1?=
 =?utf-8?B?R0srdnV6MmZ5bk5CZUM1bld3NjRaaFpTb0JSM2VWbENOVHhQK2lac1N4dE5W?=
 =?utf-8?B?OFpxcUFTQXQwT1U5QUVzK2RVZGpmUENWZDZDeWpsRGttWUl1OXR3cHE1WXBK?=
 =?utf-8?B?SnVNOGhScU5TN2djOFpHcmN0RnhYd0d3YnVCdk85NGtSK3MyVGlrREhISWV2?=
 =?utf-8?B?cDdtRHBOTFlzalpDcjlRK1BGbCtYYUhDdTk1a2g3WXllRWdhdlBrSTRjRVFz?=
 =?utf-8?B?cUY3TEpISzYzQVgxZlJUajNUd0ZFRkVtTHU5NnB4Z0k1Q2p4WEpKSGpxSjRG?=
 =?utf-8?B?TDJoUmtoRWRGNU1obnVzMUhaaG9zTzRWcHJzWk41MTU4eHBHQnowbktSd2FC?=
 =?utf-8?B?cWU0Wk14SUc0V2VhK0hYbjEwVHAxRFNUcWhaUjNucTVyWTJZbTgvWTdtZ0Jx?=
 =?utf-8?B?UkNNVFFSQ3NvWnlNMmc4MjJaaHNCbndOT01JeEpsejcxL2Y5ZlNSeGtGMEtD?=
 =?utf-8?B?TVRLYXdxMVdmUlR2eXBqY2I5c2ZMRG9Hbk8vY3huWDFrVkVLeGxjcFlyM2Rt?=
 =?utf-8?B?RXgyVnM3S1lQNFhkK3lGWFpWTXVXMDhIMWxrQjlYSUZyLzdkZ1hmYTU4OUUw?=
 =?utf-8?B?NEQ0Zkg1RG9VSjZSNVRsNW9TbCszdyswa0hwbkxtSXdibmtXcWRnZUhWVlpi?=
 =?utf-8?B?VDNDYU5EOGdPRzBjbm93NG5PUU9FZktBVmVIYkpUaDZVQ0tXVk5aaW5MMWd4?=
 =?utf-8?B?QTZOamgzQy9XUjNNMHZlVmhaTktpM3BXSGdtZVF5S0NucWVTN1lkakZPbXBk?=
 =?utf-8?B?VjQwQUVlMnN3WlE5OHAwbVZ5NDZhTnVBeHYxZk04NEkwUWtoTVRJc1BoSjdW?=
 =?utf-8?B?WkZoNDZmcEoweElMVTAyS0hBWkwzaktTeG16Y2xsY0ZCZ2hIS1R3c3FLOUN2?=
 =?utf-8?B?MEZqeE1DdzZUeGFYZWU3c2Qvam5MYjhJWGVlTVAzUFIzWDZSNTAwcUlwUEg1?=
 =?utf-8?B?WmoxMFA5WDdZMXNjakpTZ2VkWFZJRHpYWTYrNUdUQ3ZRTE5JTmxFREZSRy9W?=
 =?utf-8?B?V3AwQ21VbHhxVlk0RzZNVXpsT0x3bkpwcHJTZ1ZlZ2xudEhHM1JKVHRTMTVD?=
 =?utf-8?B?aG9KQU9iNDIyRUV3TnJkOS9mR3Vub1R1TlE3YjJESWY0TVdQZHYraldnd3Ns?=
 =?utf-8?B?ZStHaWlkbDdtV05MNTV4eXUyM2ZDUk9KdHYzWWxRcnNjek5ZQVY5clNvQWZq?=
 =?utf-8?B?RXl5d05hczZZbTFpMWZ4SVQ2cHdaWThZOVdjZVhLbVZ5a3hMZDB1WWt0OFhG?=
 =?utf-8?B?VTZQb01EZGkxblc0QVdWTkpqNkw2eEdraFFkeHhrd1EwaVdXUG1tUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c24c1e03-d731-49df-8e04-08deaa27266f
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 21:50:26.1056 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s9/pkOo3ywx5NZKj2s1vGk5/zjzG6hf2M9PF2CzVWDQSXvByzyc5O9+QbsEt6HLUzt64PJ1ejsrz1DDSVrhvvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6057
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



On 5/1/26 15:35, Hamza Mahfooz wrote:
> We should try to recover from page flip timeouts. Forcing
> a full modeset should be generic across all atomic KMS drivers,
> so try that first.
> 
> Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
> ---
>   drivers/gpu/drm/drm_atomic_helper.c | 51 +++++++++++++++++++++++++++--
>   1 file changed, 48 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index a768398a1884..8ccc6e833c77 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -1926,6 +1926,45 @@ drm_atomic_helper_wait_for_vblanks(struct drm_device *dev,
>   }
>   EXPORT_SYMBOL(drm_atomic_helper_wait_for_vblanks);
>   
> +static int force_full_modeset(struct drm_crtc *crtc)
> +{
> +	struct drm_modeset_acquire_ctx ctx;
> +	struct drm_crtc_state *crtc_state;
> +	struct drm_atomic_state *state;
> +	int ret;
> +	int err;
> +
> +	if (drm_atomic_crtc_needs_modeset(crtc->state))
> +		return -EBUSY;
> +
> +	DRM_MODESET_LOCK_ALL_BEGIN(crtc->dev, ctx, 0, err);
> +	state = drm_atomic_state_alloc(crtc->dev);
> +	if (!state)
> +		return -ENOMEM;
> +
> +	state->acquire_ctx = &ctx;
> +
> +	crtc_state = drm_atomic_get_crtc_state(state, crtc);
> +	if (IS_ERR(crtc_state)) {
> +		ret = PTR_ERR(crtc_state);
> +		goto out;
> +	}
> +
> +	crtc_state->connectors_changed = true;
> +	crtc_state->mode_changed = true;
> +	crtc_state->active_changed = true;

Do you actually need to set all 3 of these to true?

I would think you only need:

crtc_state->mode_changed = true;

> +
> +	drm_info(crtc->dev,
> +		 "[CRTC:%d:%s] Attempting force full modeset...\n",
> +		 crtc->base.id, crtc->name);
> +
> +	ret = drm_atomic_commit(state);
> +out:
> +	drm_atomic_state_put(state);
> +	DRM_MODESET_LOCK_ALL_END(crtc->dev, ctx, err);
> +	return ret;
> +}
> +
>   /**
>    * drm_atomic_helper_wait_for_flip_done - wait for all page flips to be done
>    * @dev: DRM device
> @@ -1949,17 +1988,23 @@ void drm_atomic_helper_wait_for_flip_done(struct drm_device *dev,
>   
>   	for (i = 0; i < dev->mode_config.num_crtc; i++) {
>   		struct drm_crtc_commit *commit = state->crtcs[i].commit;
> -		int ret;
>   
>   		crtc = state->crtcs[i].ptr;
>   
>   		if (!crtc || !commit)
>   			continue;
>   
> -		ret = wait_for_completion_timeout(&commit->flip_done, 10 * HZ);
> -		if (ret == 0)
> +		if (!wait_for_completion_timeout(&commit->flip_done, 10 * HZ)) {
> +			int ret;
>   			drm_err(dev, "[CRTC:%d:%s] flip_done timed out\n",
>   				crtc->base.id, crtc->name);
> +
> +			ret = force_full_modeset(crtc);
> +			if (ret)
> +				drm_err(dev,
> +					"[CRTC:%d:%s] force full modeset failed! ret=%d\n",
> +					crtc->base.id, crtc->name, ret);
> +		}
>   	}
>   
>   	if (state->fake_commit)

