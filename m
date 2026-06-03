Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E8AECD6E6B
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 11:27:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18FB410FC6D;
	Wed,  3 Jun 2026 11:27:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="s34N3cAq";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3997210FC60;
 Wed,  3 Jun 2026 11:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SskacXz9nn9lh6X6a6P91EXX6t2deHKrepH0n7+A9Zk=; b=s34N3cAqiTFiFsUGSuXnF9zJRh
 5buVIAQFeoer6w+qFj/tKG7ivF386OjXm+kgR+PA13uhDX9Nn1IfXQUHKWmxPwM8HzCsRrTM3eG6d
 yW4lMTtXNH2Vx3ElWAWIw2QBFUisVSryGEs9aLmwZS/tMi18b0M9zeAhCqcIiP015G3OzbKWONxgu
 Enw8rKlCEq7lRIqmv+rr6aBWT+1owuUrWxKy+eKZQ1Qi5gyWfVKnSXPURya4ONHc1/dKY4wZpeh/j
 bKWbkA9GtPrDbyX5+fUL3e+z6WWuoKgoXL39HU0y0SJW6FQZa182YHn7qIvFC0FEjWETdCxS71Pvu
 RHM2m1iw==;
Received: from [79.117.146.159] (helo=[192.168.1.135])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wUjkn-00C92S-6G; Wed, 03 Jun 2026 13:27:21 +0200
Message-ID: <cb0599d2-9dd5-4e93-b21e-b843f4a79182@igalia.com>
Date: Wed, 3 Jun 2026 13:27:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/atomic: only add states of active or transient
 active colorops
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>, Alex Hung <alex.hung@amd.com>,
 airlied@gmail.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 simona@ffwll.ch, tzimmermann@suse.de
Cc: Simon Ser <contact@emersion.fr>, Uma Shankar <uma.shankar@intel.com>,
 Xaver Hugl <xaver.hugl@kde.org>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 John Harrison <John.Harrison@Igalia.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, amd-gfx@lists.freedesktop.org,
 kernel-dev@igalia.com, Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org,
 "harry.wentland@amd.com" <harry.wentland@amd.com>
References: <20260526142940.504911-1-mwen@igalia.com>
 <20260526142940.504911-2-mwen@igalia.com>
 <e8aaf4da-8fb6-4d6a-95d6-563ac0562b49@amd.com>
 <4452e675c4853faf665b520a8932a960946206bb@intel.com>
 <f9e5f9ed-ed15-40ae-9330-44f8c42f5f98@intel.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <f9e5f9ed-ed15-40ae-9330-44f8c42f5f98@intel.com>
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



On 01/06/2026 11:24, Borah, Chaitanya Kumar wrote:
>
>
> On 5/29/2026 7:16 PM, Jani Nikula wrote:
>> On Tue, 26 May 2026, Alex Hung <alex.hung@amd.com> wrote:
>>> On 5/26/26 08:17, Melissa Wen wrote:
>>>> Only consider affected colorop states those that are part of an active
>>>> color pipeline or a pipeline that is about to be activated or
>>>> deactivated in the same atomic commit, i.e., colorop is in the 
>>>> chain of
>>>> old/new plane color pipeline property. To cover color_pipeline
>>>> deactivation, remove the condition for plane_state->color_pipeline.
>>>>
>>>> Signed-off-by: Melissa Wen <mwen@igalia.com>
>>>> ---
>>>>    drivers/gpu/drm/drm_atomic.c | 67 
>>>> +++++++++++++++++++++++++++++++-----
>>>>    1 file changed, 58 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/drm_atomic.c 
>>>> b/drivers/gpu/drm/drm_atomic.c
>>>> index 170de30c28ae..4fb3a23e862a 100644
>>>> --- a/drivers/gpu/drm/drm_atomic.c
>>>> +++ b/drivers/gpu/drm/drm_atomic.c
>>>> @@ -812,6 +812,59 @@ static int drm_atomic_plane_check(const struct 
>>>> drm_plane_state *old_plane_state,
>>>>        return 0;
>>>>    }
>>>>    +/*
>>>> + * This function walks old and new plane state color pipelines and 
>>>> adds all
>>>> + * colorops in use by @plane to the atomic configuration @state. 
>>>> This is useful
>>>> + * when an atomic commit needs to check all currently enabled or 
>>>> about to be
>>>> + * enabled colorop on @plane, e.g. when changing the mode. This 
>>>> also avoids
>>>> + * including colorop states that are not part of the atomic state.
>>>> + *
>>>> + * Returns:
>>>> + * 0 on success or can fail with -EDEADLK or -ENOMEM. When the 
>>>> error is EDEADLK
>>>> + * then the w/w mutex code has detected a deadlock and the entire 
>>>> atomic
>>>> + * sequence must be restarted. All other errors are fatal.
>>>> + */
>>>> +static int
>>>> +drm_atomic_add_pipeline_colorops(struct drm_atomic_commit *state,
>>>> +                 struct drm_plane *plane)
>>>> +{
>>>> +    struct drm_colorop *colorop;
>>>> +    struct drm_colorop_state *colorop_state;
>>>> +    struct drm_plane_state *new_plane_state, *old_plane_state;
>>>> +
>>>> +    new_plane_state = drm_atomic_get_new_plane_state(state, plane);
>>>> +    old_plane_state = drm_atomic_get_old_plane_state(state, plane);
>>>> +
>>>> +    if (WARN_ON(!new_plane_state || !old_plane_state))
>>>> +        return -EINVAL;
>>>> +
>>>> +    drm_dbg_atomic(plane->dev,
>>>> +               "Adding old+new pipeline colorops for 
>>>> [PLANE:%d:%s]\n",
>>>> +               plane->base.id, plane->name);
>>>> +
>>>> +    for (colorop = new_plane_state->color_pipeline;
>>>> +         colorop;
>>>> +         colorop = colorop->next) {
>>>
>>> This for-loop is used 5 times in this patchset. How about a macro in
>>> drm_colorop.h?
>>>
>>> #define drm_for_each_colorop_in_pipeline(colorop, pipeline) \
>>>       for ((colorop) = (pipeline); (colorop); (colorop) = 
>>> (colorop)->next)
>>
>> Is there a reason struct drm_colorop reinvents lists and doesn't have
>> struct list_head node?
>>
>
> I believe that's because the "next" colorop is exposed as a property 
> (of the current colorop) to userspace. Since the chain is already 
> described by the property, a struct list_head would be redundant.

Also, each color pipeline is an immutable chain of colorops where the 
sequence and position matter: once the chain is built, colorops are 
never added, removed, replaced or walked in reverse. It's a forward-only 
chain that ends when next == NULL, and it directly matches userspace 
mapping. Another point to take into account is that there is no struct 
drm_color_pipeline to hold a list_head yet, since each color pipeline is 
identified by the first colorop element in the chain. Maybe we will want 
a container to link a given pre-blend color pipeline to a specific 
post-blend color pipeline for example, but linking pre- to post-blend 
color pipelines is something we are still not clear about.

Melissa

>
> Harry, others can chime in.
>
> ==
> Chaitanya
>
>> BR,
>> Jani.
>>
>>>
>>>> +        colorop_state = drm_atomic_get_colorop_state(state, colorop);
>>>> +        if (IS_ERR(colorop_state))
>>>> +            return PTR_ERR(colorop_state);
>>>> +    }
>>>> +
>>>> +    /* Same color pipeline as new; no point walking old. */
>>>> +    if (new_plane_state->color_pipeline == 
>>>> old_plane_state->color_pipeline)
>>>> +        return 0;
>>>> +
>>>> +    for (colorop = old_plane_state->color_pipeline;
>>>> +         colorop;
>>>> +         colorop = colorop->next) {
>>>> +        colorop_state = drm_atomic_get_colorop_state(state, colorop);
>>>> +        if (IS_ERR(colorop_state))
>>>> +            return PTR_ERR(colorop_state);
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>>    static void drm_atomic_colorop_print_state(struct drm_printer *p,
>>>>                           const struct drm_colorop_state *state)
>>>>    {
>>>> @@ -1591,11 +1644,9 @@ drm_atomic_add_affected_planes(struct 
>>>> drm_atomic_commit *state,
>>>>            if (IS_ERR(plane_state))
>>>>                return PTR_ERR(plane_state);
>>>>    -        if (plane_state->color_pipeline) {
>>>> -            ret = drm_atomic_add_affected_colorops(state, plane);
>>>> -            if (ret)
>>>> -                return ret;
>>>> -        }
>>>> +        ret = drm_atomic_add_pipeline_colorops(state, plane);
>>>> +        if (ret)
>>>> +            return ret;
>>>>        }
>>>>        return 0;
>>>>    }
>>>> @@ -1607,10 +1658,8 @@ EXPORT_SYMBOL(drm_atomic_add_affected_planes);
>>>>     * @plane: DRM plane
>>>>     *
>>>>     * This function walks the current configuration and adds all 
>>>> colorops
>>>> - * currently used by @plane to the atomic configuration @state. 
>>>> This is useful
>>>> - * when an atomic commit also needs to check all currently enabled 
>>>> colorop on
>>>> - * @plane, e.g. when changing the mode. It's also useful when 
>>>> re-enabling a plane
>>>> - * to avoid special code to force-enable all colorops.
>>>> + * currently used by @plane to the atomic configuration @state. 
>>>> It's useful
>>>> + * when re-enabling a plane to avoid special code to force-enable 
>>>> all colorops.
>>>>     *
>>>>     * Since acquiring a colorop state will always also acquire the 
>>>> w/w mutex of the
>>>>     * current plane for that colorop (if there is any) adding all 
>>>> the colorop states for
>>>
>>
>

