Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE357CA5FC4
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 19:35:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0631410F4C1;
	Wed, 30 Sep 2026 19:35:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M5lYq9rN";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013019.outbound.protection.outlook.com
 [40.107.201.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2A6810F4BE;
 Wed, 30 Sep 2026 19:35:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UV60PqEvcQf7qwFwnhBP2kjYqNc/RV5PTdjZ3Y13QH1/d/GYBKz6ePEBPYN9i3ACY8JKGDa6AfUj+vR6CUoKGJ8ZsPdeF4jRG449rmZ7gXUUtKW3tixbTdE86YVdwGkXZ7wQeWOSrnlzg9R8hl/spjPRK43nW3zl99UlFz0kOZamEVrUvGrI455FvqG9dmlSvBbA8q6R5ePPTPGulI48GpWdB0d+y+PPCG4Ypk2bEQdhIKX8Dbqq8jSpdMkYgPgr9mwGHmIPBEW9EHfHaEVO1EJ9bOxNYKarZx240QHUGQl+AgEIHBCaEbJs1yPwZGedV+IVVXf6DuFU1oeeqVGY4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kPE/saip/jcXjYQa6myV77q5KC0w1JY+YwcqdLxJa0=;
 b=gQmXuqgJ4DA/dUqZM4MJxPi+XYiAh+6B2rDTnE42DZmh54nKBGP8TO5y7J1nW7MWrvT6YUxn7rcKEng8pWqjXj0qtC/XAN2uKpZ7Q6hW319n1qt7x/SfQ1kDFziu2/tAq7SBLd6b9dJVVovj+SrXOV/QZWu5Le5TMNuWMy3Y8uJuD2b4AgJlp6qXyffJVDFfbUaPS1r1gf7qVDJl2KnT6vFdLQ6tEchYHEOEEL50tHOpmrdjVqAKox5ghR0E/49lgnfyQjcDa2+gVArqi7gacvILP6mUhKGdxw35O2/ZVasKf8U2Xt7fk9P7Z+WzvqgFgf9J1Va4CYNUTs5bqzoAdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kPE/saip/jcXjYQa6myV77q5KC0w1JY+YwcqdLxJa0=;
 b=M5lYq9rN9sEyk8089QuNSvweDpO9a2Dw+90bVkk7cyZ5kcOI1OA3OzOzA5sGh8gq4OHZaW1vDwNEc8Em8jEMH51m8S6HKM+hXEcDXpZv7lFnJuO3/f8sCzR62tf8O+4mkcyhAstBg0EhFCKlxzvcTp+cSKA5s8S+B7u6ynqO6pE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by SN7PR12MB7912.namprd12.prod.outlook.com (2603:10b6:806:341::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 19:35:15 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%3]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 19:35:15 +0000
Message-ID: <3c16bf4f-fd9d-4dd0-afbc-ffd1125322c9@amd.com>
Date: Wed, 30 Sep 2026 15:35:08 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/11] drm/amd/display: make shaper bypass mode cleaner
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
 <20260811171011.184964-8-mwen@igalia.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260811171011.184964-8-mwen@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0392.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::8) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|SN7PR12MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: 97fae8cc-5bd1-4f7a-6f02-08df1f29f3a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|4143699003|921020|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: fiFSUejGJbVsSRio7aTQ4RAVanSyQn0T10LmijP8DwwFyr2GQOhf1DC8zRYRvaiv9J4fV56fL3XeGYHU0o1PVcFb5bx/Eg8vsWztXCYT1vwrY6TihqzVLqLzHz6Cvj2T6HggMVgKT8W3c0Cdn+bYlBH47E7KbRUsVOCkXO5Y+QcY9LGR0ZjIFmP4LsAgJ3hg2Mj+nXX3Yvpg/wK7yEYlUJk/JSm7MfSWxBlQmrWCXZGmv2O+n3utxYwUt731goYAcBTZf6h1QKdA3WkOG6x9rQI/nzXPQ0mPw8DFBkfY5nkcmnlD4IjkIS2pH0unnSag9TVX/fKLK2bMpkGMQBCrbu4w4Hf8sjW4Vc9yv9k4qn3OPaW0zZ0olDeyRgez+YCLzpABWdssnolFoc8hWJQwtK0ZD2GNLYW/UrSWqtalepL1jztGU3AWTAwQs8ft7Wb28rd7muCTUFFmPsQvgs0nDjXIrlN3jRoGjcfy4dYKI2ZYUNkM2cTmh8W7sWkDhqqt8RdiS3vWPGjmFPIrjbKF5BBdNkBrpKqcfWwjPojvNaOyBagKXXm0ugCkpTjZMIpz/wdoP7JnF6oYz4WI3RlRn3yXUrgJ+0GBEvHEcp4ZssCJVfL6OIKwWWnJZEB+gMLelUTMnHmEEyHmybhfgtT8hnAmxr3LMYI5TINO5AqKxxans0VSdEtqJ5IKWMOwJup0or7xE/h6jtmbWZ81m7/nlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7007.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(921020)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1FQNHZkaXRpM2Jpalo4N3dobjdTSnJSYVFFMTdocktGWjBJMVMzZXUrQzdv?=
 =?utf-8?B?M2ZrUXFFMmR0OU9mRDJBMzU5QWlLNG1oM3cvbjR0Rm9KeWZBT0p4UmxZZFBh?=
 =?utf-8?B?YXZPSlg4MVVwQVozaURQc1I1bDlFeHhKdzdQcFFnaUVxTG9HUUpjaGFob001?=
 =?utf-8?B?cUQ0dGdNa3drb2F6d1F2TG0yUk9OcG9CMWUwVHpkUmhWRnZCbDJxMVJ2SEVN?=
 =?utf-8?B?d0RyV1QvOHNKbm90bENjOVVuUW1ZZi9yOGszWElWMk5ZNWJhTkhQS2JWakYr?=
 =?utf-8?B?elVmbjdkZlRoYWNwakRkMHA2RkxBS0huSmNEVXRFbnEvaXY1bmhSNXlGaDFM?=
 =?utf-8?B?WUtoQWR0R3VzNGxJK1NweVFNajhiWFp4aExCclRKcHgzMG9BTTl6bXNhR2J1?=
 =?utf-8?B?WjAzNmxRZkJFZEJkSGhxSVFhZE9TaWVUemQ1ajd6enlUN0RKU1hLUXd3Zks2?=
 =?utf-8?B?N0h0YkVLckE4SEtDODBiMmpBcU9sOXFvbHYrQVIyU0xtTzFzOUJZZFZndTJR?=
 =?utf-8?B?RWtiaWh6S0ZNUThIN1oxYXMxK2EwQitRSTlVQTBKQlJsc2VBTTQvdHJlMWZ4?=
 =?utf-8?B?OHNObElOblpnc2ZxTy9mWkMrc0dEZ293U1dpYmJ6b2EyMVhVb1NVSWk1b3Ns?=
 =?utf-8?B?Si9RV0hjSVJKQ1ROU2hONlo5b3BmTFA1dW5SQU1Fc3RoTklkNFMzUnQ1Umdl?=
 =?utf-8?B?MU9kMnpIeHJFZWFJTHU5QlRFdm1zQ2c2TUtjTTl4b05yWmRMT2V4YU84TGFu?=
 =?utf-8?B?ZEFwcmdGdkJid3d4eXVjS0ptNVlyNVpBVmRXMW9aQXExZDdGdzYrb3NXREx5?=
 =?utf-8?B?U25na0xSVzMzVkJ3UUI4SjdGN3RzeElidERHTXF0MG5qQ2w3WVJZZ0FxS0xI?=
 =?utf-8?B?R2pWMmpRZE1ZVVhMd0NsQnBRSWhHeHdDcllENnA4ZlJKRi9sU01MUTdrMEhO?=
 =?utf-8?B?eW51NFdzK0hCbFA2enhmQXc5M21QdWhyRXc4cWpPOUc0RGNHL2UxZ3Z5UzRj?=
 =?utf-8?B?T0pHbXFPVXRNbXU4eW0yY2YraHltNTNJZjVmYWcwcUpDbWRnTHVYYzMzZ3lY?=
 =?utf-8?B?SXJETkhHWmUySTBJa1JmRmVhSUtzbHJVMXU5ZEx6cU9KUXM2OVZmcjZjQ2ti?=
 =?utf-8?B?bS93V0xtQUcrYkx6RGJaRzFJUFp3R1VvQXEwQ3NQTEl3clFabGptRVFveUJQ?=
 =?utf-8?B?MVRId0F6WnY0RC9TTnplY1BzcmxDOXFKMW8ySGZyK3pZazJFTVR0UzRqdk5J?=
 =?utf-8?B?N1kvN3dPenRlQkdaUVYxT3VhVkZzR3FFcDVOak5xQVZJZERPOE05RlRiVVpS?=
 =?utf-8?B?aVhScGJZd3NwbUgwQXhmcmdXWkdrdEoxNWlsbkp0U05kTVRkR0VseS9IL2pp?=
 =?utf-8?B?aUIyaCtSK3RxREZRSmJ4VnVCTGFVUUp0MlVDa2JWMENRMlNhendFbktKNllE?=
 =?utf-8?B?ZE5FbWw5QWprZGZsN2VRNlFrOTBWRnlmSUVybngxc2FOZHpvNE96bGtKeWRq?=
 =?utf-8?B?RTZFYnpET2xOeGVZL0RaU0lidHdvOGFnWHVhQXB6dk1uOFFmUnYvZFdFUlhk?=
 =?utf-8?B?KzR2Mk5Db2RRdUQ4UXFhVEZpNk9URG9oT1ErNHg0UDE2bnFOUk0xei9DalN2?=
 =?utf-8?B?dnl5Z3RKOEw1QmRBcmw4UGJhSmFmb2lBNmtYZytjREZiU05tdGtsNUFjeDQ4?=
 =?utf-8?B?MTBSWHlIaHZ3TjJpWUlBRktjK1lNb2txRndobXZlTFZzbytUZStRR04zbWhG?=
 =?utf-8?B?QXFZU01RRVVmUVF6cDdkVFp3OFF6VnBvbHBPbThKMnhRTCtydU9vRUdLQ2VY?=
 =?utf-8?B?TnNNQ3FsVVljRWVJZGdoVzMyVTFIQ0Jta3F3M1NVUURYK3NHSzhFSndOVlZM?=
 =?utf-8?B?cWF0aHduL0lvK2VnUFRmTnFmYVdTc2VGVjNkTFVGekVyeTUzcHpJSEFTOHBW?=
 =?utf-8?B?cEg3YmpLc1J0UU1GYkN0L0ZRQWxHUjZzRndxbGRYTFFZWVlNMUlMcXhKbWsy?=
 =?utf-8?B?MWkrd0pqZkZYQ2hwdkg1ZjNPVDdYNEtQN3ZkK2VXd1RmcUprNGx0aVNiQlpp?=
 =?utf-8?B?UVZ3Y1B5REtESHI2K1YybGFMVFhtNDdhMVNRUTY4UWIyd0wrMFNqSm40Q2tV?=
 =?utf-8?B?SzhxOEVidE9ocW8xMGdZaDNlemdHOUtBc1UycERrb3FjVzVyOHB2SXJnQmpz?=
 =?utf-8?B?WjRXaW8wRGlkdWZFV21ObDBTQ0w0d2hDdWx0RlNjQy92MDNlSmRyQ0RPcHBm?=
 =?utf-8?B?eVhoM21hYzFqUTM0ZU8zb0JrWUtra3hybVJkZlpPRmFBRGl2Z2J5V3ZWVHE2?=
 =?utf-8?B?WkUySTVhSGZQRjJXTnU1Z0hxLzZPZ1JhakxsM0taWG5sb1J1cTFZZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97fae8cc-5bd1-4f7a-6f02-08df1f29f3a4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 19:35:15.3824 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7s1XjbeIvnoClOYOqrXtOHX7dS7FLtrlcia4MwyjzMvUjvmDvZLGisHWTX7MwKp8yv6C0eMojoDIIonfcfd9Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7912
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
> Start shaper transfer function setup in bypass mode, i.e. tf->type ==
> TF_TYPE_BYPASS and let the helper checks set it to a different mode
> according to userspace request. It's aligned with current blend setup.
> 
> Signed-off-by: Melissa Wen <mwen@igalia.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>   .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.c   | 15 +++++----------
>   1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> index 450a1469d0fd..ca9e43e81edf 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> @@ -1666,10 +1666,12 @@ __set_dm_plane_colorop_shaper(struct drm_plane_state *plane_state,
>   	struct dc_transfer_func *tf = &dc_plane_state->cm.shaper_func;
>   	const struct drm_color_lut32 *shaper_lut;
>   	struct drm_device *dev = colorop->dev;
> -	bool enabled = false;
>   	u32 shaper_size;
>   	int i = 0, ret = 0;
>   
> +	tf->type = TF_TYPE_BYPASS;
> +	dc_plane_state->cm.flags.bits.shaper_enable = 0;
> +
>   	/* 1D Curve - SHAPER TF: find state */
>   	old_colorop = colorop;
>   	for_each_new_colorop_in_state(state, colorop, new_colorop_state, i) {
> @@ -1703,7 +1705,7 @@ __set_dm_plane_colorop_shaper(struct drm_plane_state *plane_state,
>   		ret = __set_output_tf(tf, 0, 0, false);
>   		if (ret)
>   			return ret;
> -		enabled = true;
> +		dc_plane_state->cm.flags.bits.shaper_enable = 1;
>   	}
>   
>   	if (lut_state && !lut_state->bypass) {
> @@ -1719,17 +1721,10 @@ __set_dm_plane_colorop_shaper(struct drm_plane_state *plane_state,
>   			ret = __set_output_tf_32(tf, shaper_lut, shaper_size, false);
>   			if (ret)
>   				return ret;
> -			enabled = true;
> +			dc_plane_state->cm.flags.bits.shaper_enable = 1;
>   		}
>   	}
>   
> -	if (!enabled) {
> -		tf->type = TF_TYPE_BYPASS;
> -		dc_plane_state->cm.flags.bits.shaper_enable = 0;
> -	} else {
> -		dc_plane_state->cm.flags.bits.shaper_enable = 1;
> -	}
> -
>   	return 0;
>   }
>   

