Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D6AC44520
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 11:41:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 976C610E8E4;
	Mon, 20 Jul 2026 11:41:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="le2Q1rpx";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80F6B10E8CF;
 Mon, 20 Jul 2026 11:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=rn3Y3zgMY2rgzd2WztSEgoxVCDU9RsYZyCv6ebpmYOk=; b=le2Q1rpxZBcZKpFurI3wIWYtnV
 rzLhcbDoQb6n8NQA1Au03VyOPFUYOGXb7eAAh2vPssyH+oo7AeF2iekKhDXQ9NG67yfWfxotclZd7
 R0G0PEw4vFW+Wnt362E5FxNE2qSh83KPCvjyEAN3blt+3OrJSpQXhZgV2bQoy4FzBfgECJGM/01rF
 YDfbK4x5hvptpZQyfmjcm9i1E5y9c9ad7THGSTwRnZ9C/K2dMido8RKJG0NGhEwAmQPSZCucPB4t4
 2fZMjoRpR6UsSG7LeCkwVF0KEZPe3VhAzEmRmsqjDlHUGFWR9vXwLD4bvHfVyf+FFPHGuO8x/xAKG
 lcTAevTw==;
Received: from 100.red-79-144-92.dynamicip.rima-tde.net ([79.144.92.100]
 helo=[192.168.1.202]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wlmMb-00137N-7n; Mon, 20 Jul 2026 13:40:49 +0200
Message-ID: <1a4b98e8-18d5-4a53-bbe6-01a7d888b14f@igalia.com>
Date: Mon, 20 Jul 2026 13:40:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] drm/atomic: reject colorop update from inactive
 color pipeline
To: John Harrison <John.Harrison@Igalia.com>, airlied@gmail.com,
 alexander.deucher@amd.com, alex.hung@amd.com, aurabindo.pillai@amd.com,
 christian.koenig@amd.com, contact@emersion.fr, daniels@collabora.com,
 harry.wentland@amd.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Uma Shankar <uma.shankar@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Xaver Hugl <xaver.hugl@kde.org>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260609121230.1358786-1-mwen@igalia.com>
 <20260609121230.1358786-3-mwen@igalia.com>
 <2a1ea63b-646e-4064-bb60-982b6b027c75@Igalia.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <2a1ea63b-646e-4064-bb60-982b6b027c75@Igalia.com>
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



On 26/06/2026 00:38, John Harrison wrote:
> On 6/9/26 13:51, Melissa Wen wrote:
>> Only allow updates on colorops that are part of an active pipeline, i.e.
>> check if a colorop belongs to the color pipeline of a plane in its
>> current, new or old state. If not, reject the state change of this
>> inactive colorop. Performing this check later in drm_atomic_check_only()
>> to remove the ordering dependency that would exist if done at the time
>> of colorop property setting. Userspace is allowed to change colorops of
>> an active color pipeline, or when activating or deactivating its
>> pipeline in the same commit. However, changes in inactive color pipeline
>> is not allowed.
> The last two sentences here seem to be a duplicate of the first two 
> sentences. Maybe drop them as redundant?

Sure, I think I can explain it better.
I was trying to say that we are changing this behavior on the kernel 
side to align with userspace expectations.

>
>>
>> Suggested-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
>> Signed-off-by: Melissa Wen <mwen@igalia.com>
>> ---
>>   drivers/gpu/drm/drm_atomic.c | 60 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 60 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
>> index 464562861408..960b52624deb 100644
>> --- a/drivers/gpu/drm/drm_atomic.c
>> +++ b/drivers/gpu/drm/drm_atomic.c
>> @@ -943,6 +943,55 @@ drm_atomic_add_pipeline_colorops(struct 
>> drm_atomic_commit *state,
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
>> + * property of current, old or new plane state.
>> + *
>> + * Returns: 0 on success, -EINVAL otherwise.
>> + */
>> +static int drm_atomic_colorop_check(const struct drm_colorop_state 
>> *new_colorop_state)
>> +{
>> +    struct drm_atomic_commit *state = new_colorop_state->state;
>> +    struct drm_plane *plane = new_colorop_state->colorop->plane;
>> +    struct drm_plane_state *new_plane_state, *old_plane_state;
>> +    struct drm_colorop *colorop;
>> +
>> +    new_plane_state = drm_atomic_get_new_plane_state(state, plane);
>> +    old_plane_state = drm_atomic_get_old_plane_state(state, plane);
>> +
>> +    /* No changes in the plane state. Check current-committed plane 
>> state */
>> +    if (!new_plane_state) {
>> +        for (colorop = plane->state->color_pipeline; colorop; 
>> colorop = colorop->next)
> Doesn't the first patch add a macro for wrapping this for loop?

Yes, thanks for pointing out. I'll replace all occurrences.

>
>> +            if (colorop == new_colorop_state->colorop)
>> +                return 0;
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (WARN_ON(!old_plane_state))
>> +        return -EINVAL;
>> +
>> +    /* Check if the colorop is active in the new plane state */
>> +    for (colorop = new_plane_state->color_pipeline; colorop; colorop 
>> = colorop->next)
>> +        if (colorop == new_colorop_state->colorop)
>> +            return 0;
>> +
>> +    /* Same color pipeline as new; no point walking old. Colorop 
>> isn't active */
>> +    if (new_plane_state->color_pipeline == 
>> old_plane_state->color_pipeline)
>> +        return -EINVAL;
>> +
>> +    /* Check if the colorop was active in the old plane state */
>> +    for (colorop = old_plane_state->color_pipeline; colorop; colorop 
>> = colorop->next)
>> +        if (colorop == new_colorop_state->colorop)
>> +            return 0;
> Doesn't this situation count as changing the properties of an inactive 
> colorop? And should therefore be rejected? The colorop was previously 
> in use but once the commit goes through, it will not be. So any 
> changes to its state will not actually affect the new post-commit 
> universe. Or am I missing something?

We still need it because the userspace is still allowed to change 
colorops of a pipeline A that will be disable in the same commit. I 
mean, they can change colorop settings of an active pipeline A and set 
COLOR_PIPELINE to Bypass in the same commit, and this change have to 
persist for the time this pipeline A will be reactivated, even if in 
practice those colorop changes will not be programmed in the hw because 
of deactivation. I'll add this comment to explain this contract better:

+ * Userspace is allowed to finalize colorop's settings in the same 
commit that
+ * deactivates its pipeline, and the changes should persist for when that
+ * pipeline is reactivated later. So that, changes to colorop in the 
old plane
+ * state's pipeline is accepted even though it won't drive hardware 
updates.

WDYT?

Melissa

>
> John.
>
>> +
>> +    /* Colorop is not part of an active color pipeline. */
>> +    return -EINVAL;
>> +}
>> +
>>   static void drm_atomic_colorop_print_state(struct drm_printer *p,
>>                          const struct drm_colorop_state *state)
>>   {
>> @@ -1792,6 +1841,8 @@ int drm_atomic_check_only(struct 
>> drm_atomic_commit *state)
>>       struct drm_plane *plane;
>>       struct drm_plane_state *old_plane_state;
>>       struct drm_plane_state *new_plane_state;
>> +    struct drm_colorop *colorop;
>> +    struct drm_colorop_state *new_colorop_state;
>>       struct drm_crtc *crtc;
>>       struct drm_crtc_state *old_crtc_state;
>>       struct drm_crtc_state *new_crtc_state;
>> @@ -1808,6 +1859,15 @@ int drm_atomic_check_only(struct 
>> drm_atomic_commit *state)
>>               requested_crtc |= drm_crtc_mask(crtc);
>>       }
>>   +    for_each_new_colorop_in_state(state, colorop, 
>> new_colorop_state, i) {
>> +        ret = drm_atomic_colorop_check(new_colorop_state);
>> +        if (ret) {
>> +            drm_dbg_atomic(dev, "[COLOROP:%d:%d] isn't in an active 
>> color pipeline.\n",
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

