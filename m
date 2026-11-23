Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F0D606A327
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 16:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=JHAZeWjz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 239B010EC3C;
	Mon, 23 Nov 2026 16:32:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id A21EA10EC31
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 16:32:19 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40AFB143D;
 Mon, 23 Nov 2026 08:32:16 -0800 (PST)
Received: from [10.57.63.212] (unknown [10.57.63.212])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC84D3F632;
 Mon, 23 Nov 2026 08:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1795451539; bh=KhxNIpGSzlXvEjcbWdqGMKZlQcHc/27HY9nyACtvYyU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=JHAZeWjz3labj4HkqSbae/RQ4xXHLlp++Cg7+Inbu67rR6whvGAoBW/97PRbGatoF
 ZDdXPZa1ingKjQBX3NZPmVbkcZQmAAYGEtAIHWUSsGV8lvyhQ9Dri90TRGpoDS1JDN
 NVDMvRujrs7fJlM23mYi5ak5hX00/+5RbnQd6dfA=
Message-ID: <c6b04a8f-a575-4f78-828c-1d5684446584@arm.com>
Date: Mon, 23 Nov 2026 16:32:13 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/panthor: Suspend devfreq until the GPU is first
 resumed
To: aiyengar1990@gmail.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Akash Goel <akash.goel@arm.com>,
 Karunika Choo <karunika.choo@arm.com>,
 Lukas Zapolskas <lukas.zapolskas@arm.com>,
 Chris Diamand <chris.diamand@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heiko Stuebner <heiko@sntech.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 Jonas Karlman <jonas@kwiboo.se>
References: <20261112-panthor-suspend-clk-v2-1-62e1b168052d@gmail.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20261112-panthor-suspend-clk-v2-1-62e1b168052d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 12/11/2026 08:10, Arun Iyengar via B4 Relay wrote:
> From: Arun Iyengar <aiyengar1990@gmail.com>
> 
> panthor_devfreq_init() adds the devfreq device while the GPU is still
> suspended, and the first panthor_device_resume() then calls
> devfreq_resume_device() without a matching devfreq_suspend_device(). The
> devfreq suspend count stays off by one for the lifetime of the device:
> -1 while the GPU is active, 0 while it is runtime suspended.
> 
> devfreq_suspend() and devfreq_resume() around a system suspend therefore
> treat a runtime suspended GPU as an active one: devfreq_suspend()
> applies the suspend OPP, if there is one, and devfreq_resume() restarts
> the polling of the simple_ondemand governor, which then sets GPU rates
> while the GPU is still runtime suspended, until its next runtime resume
> and suspend. With the devfreq core keeping a suspended device's
> frequency alone ("PM / devfreq: Do not change the frequency of a
> suspended device"), the unbalanced devfreq_resume() also marks the
> device resumed while the GPU is powered down.
> 
> Suspend devfreq right after adding it, as msm_devfreq_init() does, so
> that the devfreq suspend and resume calls pair up.
> 
> Fixes: fac9b22df4b1 ("drm/panthor: Add the devfreq logical block")
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
> v1 kept devfreq from changing the GPU clock rate while the GPU is
> suspended by filtering the calls in panthor_devfreq_target(). As Boris
> pointed out, that cannot be done race-free in the driver, so v2 moves it
> to the devfreq core: "PM / devfreq: Do not change the frequency of a
> suspended device" (linux-pm [1]) keeps devfreq from calling
> ->target() between devfreq_suspend_device() and devfreq_resume_device()
> and applies the requests made in between on resume. The SError fix
> needs that patch. What is left for panthor is this patch, which makes
> panthor's devfreq suspend and resume calls pair up; it does not depend
> on the devfreq patch to build or to be correct.
> 
> Tested on an Orange Pi 5 (RK3588S) running a v7.3-based kernel with
> this patch and the devfreq patch, with the GPU core clock on the
> firmware-managed SCMI_CLK_GPU and a 200 MHz opp-suspend (the
> configuration of Jonas Karlman's RFC, not in mainline): min_freq,
> max_freq, the userspace governor's set_freq and the devfreq cooling
> state written while the GPU was runtime suspended, also right after a
> suspend-to-idle cycle, no longer end in an SError and take effect on
> the next GPU job; 200 runtime suspend/resume cycles with max_freq
> toggling every ~35 ms and a 3 minute sustained load ran without an
> SError, WARN or panthor fault.
> 
> This patch was developed with Claude (Anthropic) as a coding assistant:
> it wrote the code and the commit message, and I reviewed it and tested
> it as described above.
> 
> [1] https://lore.kernel.org/r/20261112-devfreq-suspend-sync-v1-1-af64603ef43e@gmail.com
> ---
> Changes in v2:
> - Dropped the check in panthor_devfreq_target() (Boris): neither
>   pm.state nor devfreq::suspend_count can be read there without racing
>   with devfreq_suspend_device() and devfreq_resume_device(), which only
>   take devfreq->lock around the suspend and resume frequency changes.
>   The devfreq core now tracks the suspended state under devfreq->lock
>   and does not call ->target() while it is set, as Boris suggested.
> - New patch: start with devfreq suspended. The first runtime resume
>   called devfreq_resume_device() without a matching suspend, so the
>   suspend count was -1 while the GPU was active and 0 while it was
>   suspended (the reason v1 did not use it). Without this, the devfreq
>   core change would not hold across a system suspend taken while the
>   GPU is runtime suspended.
> - Liviu, on returning 0 instead of -EINVAL: returning 0 was wrong, devfreq
>   then records a rate the GPU does not run at (Boris). An error is
>   better than 0, but -EINVAL reports a valid request as invalid (-EBUSY
>   fits better), and either way nothing retries the request on resume:
>   the userspace and performance governors never re-evaluate, and
>   simple_ondemand only at its next poll. With the core change panthor
>   never gets these calls, so there is nothing left to reject.
> - Liviu, on disabling the clock when the power domain goes down: the
>   clocks are already disabled in panthor_device_suspend() before the
>   domain goes down, and the SError happens in that state. On RK3588 a
>   rate change on the disabled SCMI clock still goes to TF-A, which
>   programs the PVTPLL through the GPU GRF in the powered-down domain.
>   So the rate change itself has to be held back while suspended.
> - Liviu, on the comment length: the remaining comment is two lines.
> - Sashiko's findings on v1 (a rate requested while suspended was lost
>   without a suspend OPP or with a non-polling governor; the lockless
>   state check could race with the clocks going off; Fixes: tag) are
>   covered by the devfreq core change, which applies deferred requests on
>   resume and keeps the state under devfreq->lock. Thanks to Sashiko for
>   them. The new patch has Fixes: fac9b22df4b1, the commit Sashiko named:
>   the unbalanced count is a mainline bug, independent of the SCMI clock.
> - Link to v1: https://patch.msgid.link/20261110-panthor-suspend-clk-v1-1-53457050e51e@gmail.com
> ---
>  drivers/gpu/drm/panthor/panthor_devfreq.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.c b/drivers/gpu/drm/panthor/panthor_devfreq.c
> index 2249b41ca4af..45ae42dacdcb 100644
> --- a/drivers/gpu/drm/panthor/panthor_devfreq.c
> +++ b/drivers/gpu/drm/panthor/panthor_devfreq.c
> @@ -256,6 +256,12 @@ int panthor_devfreq_init(struct panthor_device *ptdev)
>  		return ret;
>  	}
>  
> +	/*
> +	 * The GPU stays suspended until the first panthor_device_resume(),
> +	 * which resumes devfreq. Suspend devfreq to match.
> +	 */
> +	panthor_devfreq_suspend(ptdev);
> +
>  	cooling = devfreq_cooling_em_register(pdevfreq->devfreq, NULL);
>  	if (IS_ERR(cooling))
>  		DRM_DEV_INFO(dev, "Failed to register cooling device\n");
> 
> ---
> base-commit: cb0a63f0c96e8ecb90199eeb99cc2a7fcfa703d4
> change-id: 20261110-panthor-suspend-clk-11d5604fe5be
> 
> Best regards,
> --  
> Arun Iyengar <aiyengar1990@gmail.com>
> 
> 

