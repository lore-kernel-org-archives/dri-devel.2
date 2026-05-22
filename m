Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3806FCD5BB0
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 09:23:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AC0F10F51A;
	Fri, 22 May 2026 09:23:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="FCzIIng9";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08CB710F50D
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 09:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779441796; x=1810977796;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=zpUx7pgE7dGZ1EgENSHHQ/pITq/AWUQDi5Wy33xEqmA=;
 b=FCzIIng9UvacOctEKShvJ+TBsOQXY+Gy5NPphOFdZ+oIwBNWPSh333tC
 TKX21Xih9BGoNLoPwsCvtiGNbVKXXWhfWk2ezKgS+1fHz3Y2lp8fR9u0Y
 EofMQt4SIFCOVKM5wBTIL0niYohuW9X+1jZj0h8URR7tnjI/JGPXIhD4b
 jBf+ITuYozotAvd7uGOb8cFKIFOwXvV9V83tbXfvVWy4JOYcJ57/IhNC/
 NZu5SHeRz9eBJ4oA6/qBgA/FzW8zN3X9laYu4po9IjHVGGMjzDvDMGiQZ
 OJZe3sz1Ck7LIrpMzUw/b/QayIJix5wmXQfvzOsgRoy7TJd+1Wjh62YK8 g==;
X-CSE-ConnectionGUID: 1PSpZhL3T2abJBZJ360GpQ==
X-CSE-MsgGUID: mu1KUKYmSSqgNKOLPeWr8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="80549997"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="80549997"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 02:23:14 -0700
X-CSE-ConnectionGUID: iJlfCes5T+GmhH3xgtuE/Q==
X-CSE-MsgGUID: W1uz+iWWRj2reco7DY28hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="234512805"
Received: from abityuts-desk.ger.corp.intel.com (HELO [10.245.244.203])
 ([10.245.244.203])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 02:23:12 -0700
Message-ID: <874533c1-716d-4c96-aa6f-87ab04c5f617@linux.intel.com>
Date: Fri, 22 May 2026 11:23:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/client: check whether CRTC is active before waiting
 for vblank
To: Icenowy Zheng <uwu@icenowy.me>, Jani Nikula
 <jani.nikula@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260519092420.1124348-1-zhengxingda@iscas.ac.cn>
 <889a09d63c62d88a85d8a31a85feb8bbc178534c@intel.com>
 <7b49ae842c07a0437e6851aae944003785ef31a3.camel@icenowy.me>
Content-Language: en-US
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <7b49ae842c07a0437e6851aae944003785ef31a3.camel@icenowy.me>
Content-Type: text/plain; charset=UTF-8
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

Hey,

Den 2026-05-19 kl. 13:29, skrev Icenowy Zheng:
> 在 2026-05-19二的 12:41 +0300，Jani Nikula写道：
>> On Tue, 19 May 2026, Icenowy Zheng <zhengxingda@iscas.ac.cn> wrote:
>>> Currently the implementaion of drm_client_modeset_wait_for_vblank()
>>> assumes drm_vblank_get() will fail when the CRTC isn't active.
>>> However
>>> it seems that this is not true, and running fbcon on a device with
>>> the
>>> first CRTC inactive will lead to kernel warning in some cases
>>> (which
>>> could be reproduced with the loongson driver).
>>>
>>> Change the implementation to add a check for the active state
>>> (atomic) /
>>> enabled state (non-atomic) before calling drm_vblank_get(). As the
>>> assumption of drm_vblank_get() failing for inactive CRTC isn't met,
>>> the
>>> error status of drm_vblank_get() can now be exported too.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: d8c4bddcd8bc ("drm/fb-helper: Synchronize dirty worker with
>>> vblank")
>>> Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
>>> ---
>>>  drivers/gpu/drm/drm_client_modeset.c | 13 +++++++++++--
>>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/drm_client_modeset.c
>>> b/drivers/gpu/drm/drm_client_modeset.c
>>> index bb49b8361271a..1b03bf351256e 100644
>>> --- a/drivers/gpu/drm/drm_client_modeset.c
>>> +++ b/drivers/gpu/drm/drm_client_modeset.c
>>> @@ -1310,7 +1310,7 @@ int drm_client_modeset_wait_for_vblank(struct
>>> drm_client_dev *client, unsigned i
>>>  {
>>>  	struct drm_device *dev = client->dev;
>>>  	struct drm_crtc *crtc;
>>> -	int ret;
>>> +	int ret = 0;
>>>  
>>>  	/*
>>>  	 * Rate-limit update frequency to vblank. If there's a DRM
>>> master
>>> @@ -1326,15 +1326,24 @@ int
>>> drm_client_modeset_wait_for_vblank(struct drm_client_dev *client,
>>> unsigned i
>>>  	 * Only wait for a vblank event if the CRTC is enabled,
>>> otherwise
>>>  	 * just don't do anything, not even report an error.
>>>  	 */
>>
>> I'll dodge the question whether the change below is right or not, but
>> for sure the comment above needs to be amended to match the change.
> 
> If the change is right, it perfectly matches what the comment above is
> saying -- it's the current behavior that does not match the comment.
> 
> Thanks,
> Icenowy
I would rather have expected drm_fb_helper_ioctl to fail like you mention.
Probably needs a fbcon_is_active() there to prevent it.

The damage helper should not be triggered if no CRTC is active, so that means
the check here is slightly too late.

Can you fix it at a different level, like damage helper or its callers instead?

I believe when the client gets suspended, all the pending damage is flushed before
suspend.

Kind regards,
~Maarten Lankhorst
