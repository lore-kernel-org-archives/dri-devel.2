Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F6DCD6E7D
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 16:41:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD4C711A9AE;
	Fri,  5 Jun 2026 16:41:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="XwbuD8pm";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D65011A9AE
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 16:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xgi5aRhWVs79pmEQen2qJtbFudPfuhIRp1u86gTu0vI=; b=XwbuD8pm6KIwhfM0NYFc+E+4Sx
 ApUFp5RU+NG4dokbgGATxs6l7CFIf+mRk9eprAaZPxGmEuK57cFBb9eOSjvex7Jcim4RtX8ykb5tb
 DPJtgiGfPuYH3GdD3jcQ8u7KFoOpWFuhJHGg6/W2TO6jU7YmYSe1rdKEmMmvExXdPJ1mMeQ85axWP
 vhU7O7/nwUMW4TnxU0GAi22+h+EGLHfmnwx8d7pyr8MLqaHIitu2aLv1R3aDwPWitHwG82/uxFXP/
 8jUVjB2mSYsVsWxJj5V54aUoDpsqIjzEeu0PxNBnU9TOL5wMsNKR3PnFo0eVaHZdBbuy0LiyTas9+
 fnxi/0FQ==;
Received: from [189.7.87.67] (helo=[192.168.0.2])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wVXbQ-00DHMw-0s; Fri, 05 Jun 2026 18:41:00 +0200
Message-ID: <5d4a7439-ffe6-4191-b8ec-08af6973a927@igalia.com>
Date: Fri, 5 Jun 2026 13:40:55 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] drm/rocket: Stop submitting hardware work from
 the IRQ handler
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Rob Herring <robh@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
References: <20260605-rocket-per-task-jobs-v1-0-e3319adf3c49@igalia.com>
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Content-Language: en-US
Autocrypt: addr=mcanal@igalia.com; keydata=
 xsBNBGcCwywBCADgTji02Sv9zjHo26LXKdCaumcSWglfnJ93rwOCNkHfPIBll85LL9G0J7H8
 /PmEL9y0LPo9/B3fhIpbD8VhSy9Sqz8qVl1oeqSe/rh3M+GceZbFUPpMSk5pNY9wr5raZ63d
 gJc1cs8XBhuj1EzeE8qbP6JAmsL+NMEmtkkNPfjhX14yqzHDVSqmAFEsh4Vmw6oaTMXvwQ40
 SkFjtl3sr20y07cJMDe++tFet2fsfKqQNxwiGBZJsjEMO2T+mW7DuV2pKHr9aifWjABY5EPw
 G7qbrh+hXgfT+njAVg5+BcLz7w9Ju/7iwDMiIY1hx64Ogrpwykj9bXav35GKobicCAwHABEB
 AAHNIE1hw61yYSBDYW5hbCA8bWNhbmFsQGlnYWxpYS5jb20+wsCRBBMBCAA7FiEE+ORdfQEW
 dwcppnfRP/MOinaI+qoFAmcCwywCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQ
 P/MOinaI+qoUBQgAqz2gzUP7K3EBI24+a5FwFlruQGtim85GAJZXToBtzsfGLLVUSCL3aF/5
 O335Bh6ViSBgxmowIwVJlS/e+L95CkTGzIIMHgyUZfNefR2L3aZA6cgc9z8cfow62Wu8eXnq
 GM/+WWvrFQb/dBKKuohfBlpThqDWXxhozazCcJYYHradIuOM8zyMtCLDYwPW7Vqmewa+w994
 7Lo4CgOhUXVI2jJSBq3sgHEPxiUBOGxvOt1YBg7H9C37BeZYZxFmU8vh7fbOsvhx7Aqu5xV7
 FG+1ZMfDkv+PixCuGtR5yPPaqU2XdjDC/9mlRWWQTPzg74RLEw5sz/tIHQPPm6ROCACFls7A
 TQRnAsMsAQgAxTU8dnqzK6vgODTCW2A6SAzcvKztxae4YjRwN1SuGhJR2isJgQHoOH6oCItW
 Xc1CGAWnci6doh1DJvbbB7uvkQlbeNxeIz0OzHSiB+pb1ssuT31Hz6QZFbX4q+crregPIhr+
 0xeDi6Mtu+paYprI7USGFFjDUvJUf36kK0yuF2XUOBlF0beCQ7Jhc+UoI9Akmvl4sHUrZJzX
 LMeajARnSBXTcig6h6/NFVkr1mi1uuZfIRNCkxCE8QRYebZLSWxBVr3h7dtOUkq2CzL2kRCK
 T2rKkmYrvBJTqSvfK3Ba7QrDg3szEe+fENpL3gHtH6h/XQF92EOulm5S5o0I+ceREwARAQAB
 wsB2BBgBCAAgFiEE+ORdfQEWdwcppnfRP/MOinaI+qoFAmcCwywCGwwACgkQP/MOinaI+qpI
 zQf+NAcNDBXWHGA3lgvYvOU31+ik9bb30xZ7IqK9MIi6TpZqL7cxNwZ+FAK2GbUWhy+/gPkX
 it2gCAJsjo/QEKJi7Zh8IgHN+jfim942QZOkU+p/YEcvqBvXa0zqW0sYfyAxkrf/OZfTnNNE
 Tr+uBKNaQGO2vkn5AX5l8zMl9LCH3/Ieaboni35qEhoD/aM0Kpf93PhCvJGbD4n1DnRhrxm1
 uEdQ6HUjWghEjC+Jh9xUvJco2tUTepw4OwuPxOvtuPTUa1kgixYyG1Jck/67reJzMigeuYFt
 raV3P8t/6cmtawVjurhnCDuURyhUrjpRhgFp+lW8OGr6pepHol/WFIOQEg==
In-Reply-To: <20260605-rocket-per-task-jobs-v1-0-e3319adf3c49@igalia.com>
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

On 05/06/26 13:06, Maíra Canal wrote:
> After Rob mentioned to me that Rocket could have a similar redundant
> job_lock just like Ethos [1], I decided to take a look at the driver to
> see if we could remove this lock. However, as I was reading the code, I
> identified that, more than the job_lock, the issue is a bit different. The
> job submission procedure in Rocket breaks the DRM scheduler's design in a
> fundamental way.
> 
> Currently, a job spawns further hardware work from outside the scheduler.
> The function rocket_job_run() submits only the first task of an inference;
> every subsequent task is submitted by the threaded IRQ handler, which calls
> rocket_job_hw_submit() directly.
> 
> The scheduler expects all of a job's hardware submission to happen in
> run_job(). Submitting jobs from the IRQ handler instead is completely
> invisible to the scheduler, which can cause some issues, like:
> drm_sched_stop() only synchronizes the scheduler's workqueue, not the IRQ,
> so the reset path races these IRQ-driven submissions. This creates the need
> of a job_lock mutex and the reset.pending flag, which exist only as a
> workaround to that self-inflicted race.
> 
> Considering the current status of the driver, solving this issue is quite
> simple: don't consider the whole submission as a DRM sched job, instead
> consider a task a DRM sched job. With that, the driver can comply to the
> DRM scheduler expectations and get rid of some locks, flags and indexes.
> 
> Having said that, this is only "compile-tested", I don't have this
> hardware. I was just driven by Rob's comment to take a look at Rocket's
> code and the design looked unusual to what I would expect from a DRM
> scheduler-based driver. I'm also CCing some scheduler maintainers to check
> if they agree that the IRQ handler shouldn't spawn further HW work.
> 
> Apart from that, this series also has some clean-up patches.
> 
> [1] https://lore.kernel.org/dri-devel/20260516144623.2582427-2-mcanal@igalia.com/T/

Sorry, I forgot the RFC tag.

Best regards,
- Maíra

> 
> Best regards,
> - Maíra
> 
> ---
> Maíra Canal (3):
>        drm/rocket: Remove unused reset worker
>        drm/rocket: Submit one drm_sched_job per task
>        drm/rocket: Drop the dedicated reset workqueue
> 
>   drivers/accel/rocket/rocket_core.h |  10 +-
>   drivers/accel/rocket/rocket_job.c  | 282 ++++++++++++++++++-------------------
>   drivers/accel/rocket/rocket_job.h  |  26 +++-
>   3 files changed, 159 insertions(+), 159 deletions(-)
> ---
> base-commit: 640c57d6ca1346a1c2363a3f473b405af979e046
> change-id: 20260605-rocket-per-task-jobs-b797f7e2b1e9
> 

