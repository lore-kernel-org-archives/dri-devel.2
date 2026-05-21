Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC4C4CD5BB5
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 13:19:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEBE210E49E;
	Thu, 21 May 2026 13:19:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="ZSi5w5iK";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCE6210E1A6;
 Thu, 21 May 2026 13:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IIpdmIOgvl0TQniaAHS+GD+OE1WeFz+0+H9K2/ObYUo=; b=ZSi5w5iKECb9ZrQYLpQ963Qtib
 9XCeOlFYKm3qQQLC4wAgIGxChYh/0Ztvznz73ETHzIJWvRMQt4+JaxJOgd42oVuUodx4MeMXqyucW
 UUnHUxH7ACZsYGwXFWOx44JJlYqE8mx/UHjvYZ5G73+hqHdOqTrMgCQgiTdEcFlzAXedqPsb3tvCe
 tmIAFLbbRRhbf4GsMfoRltHXI8yTWJBJUp5rgaqEA+aaVGfZ1M88aZG+YJcpp/CkFiSVVgZlM4Fsi
 s6q3Ov8OvDiwlMTmH12DLyNvUs61xbnUmLsBrB1fCSFnhUD6WRj65tW783jRc5pPoQMx41DxJpGK0
 CbuCILjA==;
Received: from [79.117.146.159] (helo=[192.168.1.135])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wQ3IX-004MSj-DH; Thu, 21 May 2026 15:18:49 +0200
Message-ID: <c1e5b078-2352-4569-b82e-398cb3c5f537@igalia.com>
Date: Thu, 21 May 2026 15:18:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/6] drm/atomic: reject colorop update from inactive
 color pipeline
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
 airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Alex Hung <alex.hung@amd.com>, Simon Ser <contact@emersion.fr>,
 Uma Shankar <uma.shankar@intel.com>, Xaver Hugl <xaver.hugl@kde.org>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260519211111.228303-1-mwen@igalia.com>
 <20260519211111.228303-3-mwen@igalia.com>
 <5caac879-5063-4999-941f-d062da040879@intel.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <5caac879-5063-4999-941f-d062da040879@intel.com>
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



On 21/05/2026 13:00, Borah, Chaitanya Kumar wrote:
>
>
> On 5/20/2026 2:39 AM, Melissa Wen wrote:
>> Only allow updates on colorops that are part of an active pipeline.
>> Check if a colorop in a new state belongs to a color pipeline which was
>> set as a plane color_pipeline property and therefore is an active color
>> pipeline. If not, reject the atomic state. Performing this check later
>> in drm_atomic_check_only() to remove the ordering dependency that would
>> exist if done at the time of colorop property setting.
>>
>> Suggested-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
>> Signed-off-by: Melissa Wen <mwen@igalia.com>
>> ---
>>   drivers/gpu/drm/drm_atomic.c | 38 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 38 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
>> index 28831a548b0c..659cf56150e5 100644
>> --- a/drivers/gpu/drm/drm_atomic.c
>> +++ b/drivers/gpu/drm/drm_atomic.c
>> @@ -812,6 +812,33 @@ static int drm_atomic_plane_check(const struct 
>> drm_plane_state *old_plane_state,
>>       return 0;
>>   }
>>   +/**
>> + * drm_atomic_colorop_check - check new colorop state
>> + * @new_colorop_state: new colorop state to check
>> + *
>> + * Ensure that the colorop in @new_colorop_state belongs to an 
>> active color
>> + * pipeline, i.e. it's in the chain of colorops set to the 
>> color_pipeline
>> + * property of a plane state.
>> + *
>> + * Returns: 0 on success, -EINVAL otherwise.
>> + */
>> +static int drm_atomic_colorop_check(const struct drm_colorop_state 
>> *new_colorop_state)
>> +{
>> +    struct drm_colorop *colorop, *color_pipeline;
>> +    struct drm_plane_state *new_plane_state;
>> +
>> +    new_plane_state = 
>> drm_atomic_get_new_plane_state(new_colorop_state->state,
>> + new_colorop_state->colorop->plane);
>> +    color_pipeline = new_plane_state ? 
>> new_plane_state->color_pipeline :
>> + new_colorop_state->colorop->plane->state->color_pipeline;
>> +
>> +    for (colorop = color_pipeline; colorop; colorop = colorop->next)
>> +        if (colorop == new_colorop_state->colorop)
>> +            return 0;
>> +
>> +    return -EINVAL;
>> +}
>> +
>
> This causes regression in our CI[1].
>
> I looked into it and looks like the following sequence in 
> igt@kms_color_pipeline causes the error
>
>         set_color_pipeline_bypass(plane);
>         reset_colorops(colorops);
>         igt_plane_set_fb(plane, NULL);
>         igt_display_commit_atomic(&data->display, 0, NULL);
>
> So this change restricts bypassing/disabling both the pipeline and a 
> colorop within it in a single commit.

Oops, cc'ing everyone.

"
I wonder if userspace resetting colorops to disable a pipeline or 
configuring colorops before enabling the color pipeline is an expected 
behavior.

For resetting properties, I think I can solve it by taking into account 
old and new state to collect the active colorops, not only the new state.
But if configuring colorops before activate a color pipeline is 
expected, there is no need to have patches 1 and 2, since setting an 
inactive colorop have to be allowed. In that case, the solution is just 
drop both patches from the series.
"

Melissa

>
> Also Sashiko had the following to say
>
> "Furthermore, does this unnecessarily restrict UAPI by preventing 
> userspace
> from configuring inactive pipelines before enabling them, or from 
> resetting
> properties on a pipeline in the same commit that switches away from it?"
>
> So this will also fail a commit which tries to change a pipeline and 
> disable the colorops in an old pipeline.
>
> That got me thinking whether the first patch[3] in the series is also 
> correct, since it is quite similar to the change[4] I added, where 
> colorops are only added to the state when a pipeline is active. In 
> both cases, we could end up ignoring colorops that are not part of the 
> currently selected pipeline.
>
> [1] 
> https://intel-gfx-ci.01.org/tree/intel-xe/xe-pw-166922v1/shard-lnl-5/igt@kms_color_pipeline@plane-ctm3x4@pipe-a-plane-2.html
> [2] 
> https://sashiko.dev/#/patchset/20260520073827.3395745-3-chaitanya.kumar.borah%40intel.com
> [3] 
> https://lore.kernel.org/dri-devel/20260519211111.228303-2-mwen@igalia.com/
> [4] 
> https://lore.kernel.org/dri-devel/148df44d-2456-40e3-8be6-f98b89b7ee4d@amd.com/
>
> P.S. Can you please send the next version to intel-gfx and intel-xe too?
>
> ==
> Chaitanya
>>   static void drm_atomic_colorop_print_state(struct drm_printer *p,
>>                          const struct drm_colorop_state *state)
>>   {
>> @@ -1665,6 +1692,8 @@ int drm_atomic_check_only(struct 
>> drm_atomic_commit *state)
>>       struct drm_plane *plane;
>>       struct drm_plane_state *old_plane_state;
>>       struct drm_plane_state *new_plane_state;
>> +    struct drm_colorop *colorop;
>> +    struct drm_colorop_state *new_colorop_state;
>>       struct drm_crtc *crtc;
>>       struct drm_crtc_state *old_crtc_state;
>>       struct drm_crtc_state *new_crtc_state;
>> @@ -1681,6 +1710,15 @@ int drm_atomic_check_only(struct 
>> drm_atomic_commit *state)
>>               requested_crtc |= drm_crtc_mask(crtc);
>>       }
>>   +    for_each_new_colorop_in_state(state, colorop, 
>> new_colorop_state, i) {
>> +        ret = drm_atomic_colorop_check(new_colorop_state);
>> +        if (ret) {
>> +            drm_dbg_atomic(dev, "[COLOROP:%d:%d] is not part of an 
>> active color pipeline.\n",
>> +                       colorop->base.id, colorop->type);
>> +            return ret;
>> +        }
>> +    }
>> +
>>       for_each_oldnew_plane_in_state(state, plane, old_plane_state, 
>> new_plane_state, i) {
>>           ret = drm_atomic_plane_check(old_plane_state, 
>> new_plane_state);
>>           if (ret) {
>

