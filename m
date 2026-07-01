Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE041C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 09:34:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CD9810E34F;
	Wed,  1 Jul 2026 09:34:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="dbi780vP";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0C0810E34F
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 09:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rkkSHqFyVp2fyO4zhsA5xQzb55y8BJkjvdnC/dmJ7zc=; b=dbi780vPfR0drg5RINie+jGdE8
 mPUp0ueEEct0j7NBYL3UhDqKkYfe2YaMuIxqwEOxjArdH8Xrp0y7zU87XrjLzuGj/DmzjxtiiHJ4M
 C/aVrhTiYUY7+lVh6c1S21eH10NRgaVfDDvMC08qcBVzm2KKNgiUSORgS4Lprapx5jrVYQOZwRCOD
 c4/M7VPv7iD295rCgrQOi7LEj1iKRJmhE0yo5Qdc5MRFlfIXHBasyQFPzpSPkGCUovtKt0JfEIOg+
 9iGIAj/uPDd3O42m84Joma9507V1pkiT9KPJkMQ3bcLUZzZ3A2onS8RrsCmRURUl37SLn98eXS9kp
 UzGKhNaQ==;
Received: from [90.240.106.137] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1werLE-007Ufe-6F; Wed, 01 Jul 2026 11:34:48 +0200
Message-ID: <65d4d6dd-a526-409e-96b7-e9a71ed47f23@igalia.com>
Date: Wed, 1 Jul 2026 10:34:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] drm/sched: use dma_fence_test_signaled_flag()
To: christian.koenig@amd.com, phasta@kernel.org, simona@ffwll.ch,
 sumit.semwal@linaro.org, dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
References: <20260624122917.2483-1-christian.koenig@amd.com>
 <20260624122917.2483-6-christian.koenig@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260624122917.2483-6-christian.koenig@amd.com>
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


On 24/06/2026 12:13, Christian König wrote:
> Instead of dma_fence_is_signaled_locked() use
> dma_fence_test_signaled_flag().
> 
> No functional difference the mock HW fence has no signaled callback
> anyway.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/scheduler/tests/mock_scheduler.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/tests/mock_scheduler.c b/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
> index 14403a762335..82dce344bfa1 100644
> --- a/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
> +++ b/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
> @@ -224,7 +224,7 @@ mock_sched_timedout_job(struct drm_sched_job *sched_job)
>   	}
>   
>   	spin_lock_irqsave(&sched->lock, flags);
> -	if (!dma_fence_is_signaled_locked(&job->hw_fence)) {
> +	if (!dma_fence_test_signaled_flag(&job->hw_fence)) {
>   		list_del(&job->link);
>   		job->flags |= DRM_MOCK_SCHED_JOB_TIMEDOUT;
>   		dma_fence_set_error(&job->hw_fence, -ETIMEDOUT);
> @@ -258,7 +258,7 @@ static void mock_sched_cancel_job(struct drm_sched_job *sched_job)
>   	hrtimer_cancel(&job->timer);
>   
>   	spin_lock_irqsave(&sched->lock, flags);
> -	if (!dma_fence_is_signaled_locked(&job->hw_fence)) {
> +	if (!dma_fence_test_signaled_flag(&job->hw_fence)) {
>   		list_del(&job->link);
>   		dma_fence_set_error(&job->hw_fence, -ECANCELED);
>   		dma_fence_signal_locked(&job->hw_fence);

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

