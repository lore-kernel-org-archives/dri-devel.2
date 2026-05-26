Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC5F8CD5BD5
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 16:10:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C22410E4DF;
	Tue, 26 May 2026 16:10:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Cfp3jBb3";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA4DF10E1B7;
 Tue, 26 May 2026 16:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NVQM7BLJHLhYOoEkHmhcc4JzD44t4ayT0gYW6wGZvM8=; b=Cfp3jBb3IptkOfKHa1BABv6j/+
 YKng3/sOJCVjqe/8w/BxORBpdqVOQVLI23YS2wSdtyYm3IFk3iFNsA9vFwALePv9cn0G3zV8qjGKZ
 iTJ2tIfRbT59Pbk5HFeWisp+nVIAmdUX2rK5qS62o5VSU9DZhWtaJEIHTHjjvYUAnfLlA9eE+zNdj
 wfvOgsQufXC8Uxqnh+KG7S4PyxbSQvK06BbMDsBxQOr2dyH4Xnvs5Ymp+7QZbN0nvWYmVVPmPh1QX
 ykaU+DvJnmOqVMpicrVy1XZemmh/wxrERU/+PT4z/sHcgkxoIifVukzMKHTwuVW7ozjRHjtLqDZcR
 An595ZJQ==;
Received: from [79.117.146.159] (helo=[192.168.1.135])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wRuLR-008VeX-Vv; Tue, 26 May 2026 18:09:30 +0200
Message-ID: <9d30ef2d-cea8-44dc-9669-492ddaa02108@igalia.com>
Date: Tue, 26 May 2026 18:09:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/4] drm/amd/display: use plane color_mgmt_changed to
 track colorop changes
To: Alex Hung <alex.hung@amd.com>, airlied@gmail.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, harry.wentland@amd.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, simona@ffwll.ch,
 siqueira@igalia.com, sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Simon Ser <contact@emersion.fr>, Uma Shankar <uma.shankar@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Xaver Hugl <xaver.hugl@kde.org>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260525100524.304263-1-mwen@igalia.com>
 <20260525100524.304263-5-mwen@igalia.com>
 <85aad1b1-3ac8-464a-ab5a-69c92a491925@amd.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <85aad1b1-3ac8-464a-ab5a-69c92a491925@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



On 26/05/2026 05:29, Alex Hung wrote:
> Reviewed-by: Alex Hung <alex.hung@amd.com>

Hi Alex,

Thanks for the reviews.
As this last patch depends on the previous one, I think the entire 
series should go via AMD's branch, instead of drm-misc.
WDYT?

Melissa

>
> On 5/25/26 03:50, Melissa Wen wrote:
>> Ensure the driver tracks changes in any colorop property of a plane
>> color pipeline by using the same mechanism of CRTC color management and
>> update plane color blocks when any colorop property changes. It fixes an
>> issue observed on gamescope settings for night mode which is done via
>> shaper/3D-LUT updates.
>>
>> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>> Signed-off-by: Melissa Wen <mwen@igalia.com>
>> ---
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c 
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index d590f0df6abd..36425d9c2a67 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -10198,7 +10198,7 @@ static void amdgpu_dm_commit_planes(struct 
>> drm_atomic_commit *state,
>>               continue;
>>             bundle->surface_updates[planes_count].surface = dc_plane;
>> -        if (new_pcrtc_state->color_mgmt_changed) {
>> +        if (new_pcrtc_state->color_mgmt_changed || 
>> new_plane_state->color_mgmt_changed) {
>>               bundle->surface_updates[planes_count].gamma = 
>> &dc_plane->gamma_correction;
>> bundle->surface_updates[planes_count].in_transfer_func = 
>> &dc_plane->in_transfer_func;
>> bundle->surface_updates[planes_count].gamut_remap_matrix = 
>> &dc_plane->gamut_remap_matrix;
>> @@ -12024,6 +12024,10 @@ static bool should_reset_plane(struct 
>> drm_atomic_commit *state,
>>       if (new_crtc_state->color_mgmt_changed)
>>           return true;
>>   +    /* Plane color pipeline or its colorop changes. */
>> +    if (new_plane_state->color_mgmt_changed)
>> +        return true;
>> +
>>       /*
>>        * On zpos change, planes need to be reordered by removing and 
>> re-adding
>>        * them one by one to the dc state, in order of descending zpos.
>

