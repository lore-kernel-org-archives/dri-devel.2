Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22AA7C5B56A
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 17:14:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C5CE10E17E;
	Tue, 11 Aug 2026 17:14:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="JZl2Lk25";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82D7810ECFA;
 Tue, 11 Aug 2026 17:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=ZUifnrXaGOXqElCxZBIG2/TN6SacYXw61kxHNyWu/pY=; b=JZl2Lk25ZvHG+2qnkjXArjoJMr
 8QsIY71Dxi9gj/p50vwqMZDz8GIFAm37ymLoFuWQTkZunw7h0vp6gO55jy6B+CBH173B99DWRJ8ag
 9YmWHT3HT1tEVY9XfW9jqcQ+Zc/JtwJI0QuHuLMDZipPvqoOCetT0/iHISnegsY5c2gYKoC53FTnn
 jPaeUIx1gs2nODype7VokqM4kdNGVyEvKAssQ32CyNlTMTLetPq4McZTgCDi+y2Tl0s3sMxAkzPLt
 hweDpQao54pMblC6hci/Tx5pwmGXVOIlheejiyN2oLaH5nRUvXc6ZUCIrXOAywwIOvIyAuIXP6hLp
 IV/FRilg==;
Received: from [90.249.211.112] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wtq3h-00HHPQ-UI; Tue, 11 Aug 2026 19:14:37 +0200
Message-ID: <bbe573b2-cee8-4647-bb75-662ced57b2d3@igalia.com>
Date: Tue, 11 Aug 2026 18:14:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/20] Revert switching default DRM scheduler policy to
 fair
To: phasta@kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Luke.Wildhardt@proton.me,
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20260811140738.96974-1-tvrtko.ursulin@igalia.com>
 <c8f1e84b8ee1b51e6927c8252d28ef89d26cecb8.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <c8f1e84b8ee1b51e6927c8252d28ef89d26cecb8.camel@mailbox.org>
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


On 11/08/2026 15:42, Philipp Stanner wrote:
> +Cc a few more people
> 
> 
> On Tue, 2026-08-11 at 15:07 +0100, Tvrtko Ursulin wrote:
>> There was a late minute user regression report[1] so lets revert this so it can
>> be debugged in peace.
>>
>> I have not been able to locally reproduce it yet, but at least a partial fix
>> looks to be this[2]. Further debug will be needed, possibly after the holiday/
>> vacation season is over.
>>
>> [1] https://lore.kernel.org/dri-devel/TfhgV1W0W5LI6RWUO6J35B3R8QIYH_FN3Eihzdo_9PH39hfn1AVByT-QBPHmWiAR-L0Kqi2sppM_EhFPKwZPGmb5pFgpF2MrzeFzkZDmpG8=@proton.me/
>> [2] https://lore.kernel.org/dri-devel/20260811134223.96203-1-tvrtko.ursulin@igalia.com/
>>
>> Cc: Luke.Wildhardt@proton.me
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: Danilo Krummrich <dakr@kernel.org>
>> Cc: Philipp Stanner <phasta@kernel.org>
>> Cc: Christian König <ckoenig.leichtzumerken@gmail.com>
>>
>> v2:
>>   * Forgot the SoBs.
>>
>> Tvrtko Ursulin (20):
>>    Revert "drm/sched: Remove redundant entity->rq initialization and
>>      checks"
>>    Revert "drm/sched: Remove drm_sched_init_args->num_rqs"
>>    Revert "drm/xe: Remove drm_sched_init_args->num_rqs usage"
>>    Revert "drm/v3d: Remove drm_sched_init_args->num_rqs usage"
>>    Revert "drm/sched: Remove drm_sched_init_args->num_rqs usage"
>>    Revert "drm/panthor: Remove drm_sched_init_args->num_rqs usage"
>>    Revert "drm/panfrost: Remove drm_sched_init_args->num_rqs usage"
>>    Revert "drm/nouveau: Remove drm_sched_init_args->num_rqs usage"
>>    Revert "drm/msm: Remove drm_sched_init_args->num_rqs usage"
>>    Revert "drm/lima: Remove drm_sched_init_args->num_rqs usage"
>>    Revert "drm/imagination: Remove drm_sched_init_args->num_rqs usage"
>>    Revert "drm/etnaviv: Remove drm_sched_init_args->num_rqs usage"
>>    Revert "drm/amdgpu: Remove drm_sched_init_args->num_rqs usage"
>>    Revert "accel/ethosu: Remove drm_sched_init_args->num_rqs usage"
>>    Revert "accel/rocket: Remove drm_sched_init_args->num_rqs usage"
>>    Revert "accel/amdxdna: Remove drm_sched_init_args->num_rqs usage"
>>    Revert "drm/sched: Embed run queue singleton into the scheduler"
>>    Revert "drm/sched: Remove FIFO and RR and simplify to a single run
>>      queue"
>>    Revert "drm/sched: Switch default policy to fair"
>>    drm/sched: Mark fair policy as experimental
> 
> Acked-by: Philipp Stanner <phasta@kernel.org>
> 
> 
> Doesn't yet apply to drm-misc-fixes, I suppose because of the merge
> yesterday.
> 
> 
>  From my POV you can push this to misc-fixes if you can make it apply;
> hopefully it's not too late for v7.2

I've rebased against drm-misc-fixes, posted v3 and pushed it. I wanted 
to prioritise getting the reverts in quickly to not miss the fixes pull 
rq so I did not log the acks against all patches since there is a lot of 
them. There were two small conflicts while building drm-tip so fingers 
crossed that's all good. I compile re-tested both drm-misc-fixes with 
all affected drivers, and drm-tip for x86 only.

Regards,

Tvrtko

