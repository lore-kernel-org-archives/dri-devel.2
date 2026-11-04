Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21250606A328
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 12:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tomeuvizoso-net.20260707.gappssmtp.com header.i=@tomeuvizoso-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=oLBWZjPi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 663B410E38F;
	Wed,  4 Nov 2026 12:56:33 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E73C10E772
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 12:56:25 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so6700745e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 04:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tomeuvizoso-net.20260707.gappssmtp.com; s=20260707; t=1793796984;
 x=1794401784; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a3viuefWVHlkOcjcyLognlTI0g9S7LK7g5mw2hwAeX8=;
 b=oLBWZjPiT2I2bufO+rET71T/rV458tPp9Q/P7VjZCTYsclvjOu+4Hg/IGFkJkbRNTL
 khL4CmLqJIb3/4Xg2DhnRw9n6r1fhaAPYFF2/shextfPbwF8Ixz0LsnDRA67WZ62tfGs
 A9hHNehJa9rbphyU2rtBtp5yVz4OWVRO9X0oW8MgsnwgLqIwjowrPkkj1M5CDXKC23M2
 6ltGtLqU6lwi6VxZ2PK+hM00hhg3A8oJs+37uKjOoB719D7WWpoeprHnSmCu7oWODRPL
 Kvv46LQkcpvj3RJV9W/KfOXcbs5z64MJkKdFBBs3aHGgLzfFXHvbcoTW48ErlXsY0wae
 Lsbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793796984; x=1794401784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=a3viuefWVHlkOcjcyLognlTI0g9S7LK7g5mw2hwAeX8=;
 b=gD9KPNrHuQwgtIKJoOQ97Ut+NomOJKA0lSduQ243PsN8YMgtkAWN9Pdp/1YugebUF0
 KQp6Iv/noN7wWJDzT24KBSCQzclF4DHnEqfJjkIQeEJ0V2HDAxRxRj7nOWltN4tl740f
 VPy0Tfuhv5gaAppmYkdMu/hU/Zm84SiXzciOaIc7HHC5MQUeLTJRfxCwtGUjOq9KGVAC
 SpYvDgTbtZY5QTUh5NM4HfJ8UDP5B38UTb5WMWG0rH30NzayLdP9ocLzFmcS3szinF05
 ErVtCA3egd8IfzgLPukAXVkmbKfO7JdaeRVBYd5/b1c3Z+x4Wjcc+txUgaGRp4Lb/d8K
 q9KQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwkALX5kWNAOty+hY0WC8Xq41aKCAqhFSSKF6L0F/5atrTTlW0XPLXV/8Xy06Y5Ly/vkMQyoaTny+Y=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8kvA65blFyXkU+kXCo4CeJO497g5rDdN0DIHoZM4AM5KY6wE2I
 R5y/+EMZNU10lFEoQtvmBJhMsZjyZwV+bzn+WNDxDTz3z5TeYW4rZlcZcFLrBIWqTM4=
X-Gm-Gg: AYBFou37w6z98W9K93KHrZnoN20WkOTkKP2R3GdqHqlvLLHDdZdvfMYdr4qiqAFfiw6
 RszLCM9EYDzcl4KQAg3uYab+P24uasSsMdEXE2n08NFByf7/e8rQAsZBQcSXcTfaXGXH5LHtTI8
 +yapb1p9eJtLKjK/PXzB/jx6qbURZcoDWeoEgMBtSuLxWAbqZww8IVqTxczjg1VohNZOOBItn52
 ZG9705jW2Q7VYK6rh2VFFctlH6KPAuy56l4Jnx7+AruRhnHkvMAyM8ws1m7KlwiUmX+G55b05LQ
 SQvG1PFcHr0N5kX/yyvDBAjIzaDPl9ZhrG085WVV+S0JMSmlAvWoAqX7IJVF2ofVHdldvpIM/qz
 qUAakXhDwOT+/2/BYnVjQRinDihQrCgNzh/ozzqgJTKA4VMWg2OapI08zM+0rcPFxBLdxyEqX7c
 KNEtvwG6BmfaGysiY8SANyKCnY1z9K4MTZVdmx3b6qFFGFn0SZRHt8lF9r69+8k2NgpizhAGreB
 ohJOgutWg9Xus01L2ue60ZMsCnWBf9++X+VWJcDQFTGceDNqHSoFhT0/amZHUr8TEWpeGslbuoO
 iLTTCYjv+wGaawuXeKrwRPj5kpPV6oIWcc4Reok/PS+aDYJUP4xfJ1Yjk8pXsQDaocGGAbxbcTd
 yf6/k5PILsswy/1+H4TSwuAP/JiYJ6YkFHX1ECA97wIjfVqQvyPI3blpa+fjdPqBE6j20AfU=
X-Received: by 2002:a05:600c:1d28:b0:4a2:1612:637a with SMTP id
 5b1f17b1804b1-4ac1793fb6bmr425311395e9.16.1793796983815; 
 Wed, 04 Nov 2026 04:56:23 -0800 (PST)
Received: from alcachofa.home (cst-prg-36-190.cust.vodafone.cz.
 [46.135.36.190]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48feda20935sm3705844f8f.54.2026.11.04.04.56.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 04:56:23 -0800 (PST)
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de,
 ogabbay@kernel.org, zhangqing@rock-chips.com, royalnet026@gmail.com,
 abel.vesa@oss.qualcomm.com, sebastian.reichel@collabora.com,
 sidong.yang@furiosa.ai, u.kleine-koenig@baylibre.com,
 chaoyi.chen@rock-chips.com, diederik@cknow-tech.com, alchark@flipper.net,
 leonard@lausen.nl, jeff.hugo@oss.qualcomm.com, rfoss@kernel.org,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 03/15] accel/rocket: wait for a running IRQ handler
 before resetting a core
Date: Wed,  4 Nov 2026 13:55:18 +0100
Message-ID: <20261104125529.3229301-1-tomeu@tomeuvizoso.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261101082307.151957-4-gahing@gahingwoo.com>
References: <20261101082307.151957-4-gahing@gahingwoo.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 01, 2026 at 09:22 PM, Jiaxing Hu <gahing@gahingwoo.com> wrote:
> drm_sched_stop() does not wait for a threaded handler that is already
> running. Call synchronize_irq() after it, outside job_lock, which the
> handler takes.
>
> Before the sync, mask the block's interrupt and clear its raw status, so
> that an active core cannot signal a completion after it. Do that under
> job_lock, since rocket_job_hw_submit() arms the same mask under that lock,
> and only when pm_runtime_get_if_active() returns a positive count: the
> reset holds no runtime PM reference, and with the domain down a register
> access takes an async SError.

The above I understand.

> Igor Paunovic's induced-reset runs on RK3588, including a two-task job that
> puts hw_submit() on the IRQ thread, found no fault; as he put it, "this
> does not show the race is closed".

This is completely out of context for a commit message. How is somebody who is
reading git log know who Igor is, and what his "induced-reset" is?

> Link: https://lore.kernel.org/all/20260819073530.6087-1-royalnet026@gmail.com/
> Link: https://lore.kernel.org/all/CAEWPSH5mxTbUkNouxm6yecMZYvDowquhvYvhaXQ8HoMtHD5U1g@mail.gmail.com/
> Link: https://lore.kernel.org/all/20260912113717.6819-1-royalnet026@gmail.com/
> Link: https://lore.kernel.org/all/20260916132824.13527-1-royalnet026@gmail.com/
> Link: https://lore.kernel.org/all/20260919103422.148834-1-royalnet026@gmail.com/
> Suggested-by: Igor Paunovic <royalnet026@gmail.com>
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, three cores, induced reset, JOB_TIMEOUT_MS=2
> ---
>  drivers/accel/rocket/rocket_job.c | 71 +++++++++++++++++++++++++++++--
>  1 file changed, 68 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
> index 03e5f094f60b..5b2abf40b618 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -401,9 +401,74 @@ rocket_reset(struct rocket_core *core, struct drm_sched_job *bad)
>  	drm_sched_stop(&core->sched, bad);
>  
>  	/*
> -	 * Remaining interrupts have been handled, but we might still have
> -	 * stuck jobs. Let's make sure the PM counters stay balanced by
> -	 * manually calling pm_runtime_put_noidle().
> +	 * Mask the block before waiting. hw_submit() arms INTERRUPT_MASK on
> +	 * every submit and only the hardirq clears it, so on an ordinary
> +	 * timeout it is still live and a completion can arrive after the sync
> +	 * returns. The next submit re-arms it, so nothing is lost here.
> +	 *
> +	 * Only when the device is already awake, though. This function holds no
> +	 * runtime PM reference of its own: the only one in the window belongs to
> +	 * in_flight_job, and the completion path may have put it and cleared the
> +	 * pointer before the timeout worker got here. drm_sched_stop() above can
> +	 * block for a long time, and it drops every pending job's credits, so
> +	 * rocket_job_is_idle() is true and nothing keeps the core resumed. On
> +	 * this hardware a register access with the domain down takes an async
> +	 * SError, so a reset must not be the thing that causes one.
> +	 *
> +	 * Only a positive answer will do. pm_runtime_get_if_active() tests
> +	 * power.disable_depth before power.runtime_status, so -EINVAL MASKS a
> +	 * suspended device rather than excluding one: pm_runtime_force_suspend(),
> +	 * which is this driver's own system suspend callback, disables runtime PM
> +	 * first and turns the clocks off second, and rocket_core_fini() suspends
> +	 * the core and disables before it cancels the timeout worker. Both leave
> +	 * the domain down with -EINVAL on offer.
> +	 *
> +	 * The cost is the other half of that ambiguity. A core that is still up
> +	 * with runtime PM disabled (pm_runtime_force_suspend() before its
> +	 * callback has run, or CONFIG_PM=n under COMPILE_TEST) is left unmasked,
> +	 * because writing to it would mean writing to the half that is down as
> +	 * well.
> +	 *
> +	 * Clear the raw status along with the mask, the way the completion path
> +	 * does. Masking alone leaves the DPU bit latched until
> +	 * rocket_core_reset(), and the hardirq decides on raw status alone, so a
> +	 * fault from the IOMMU that shares this line would wake the thread again
> +	 * and what the comment below asserts would stop being true.
> +	 *
> +	 * UNDER job_lock, because rocket_job_hw_submit() arms this same
> +	 * register and always runs under that lock. reset.pending is set here
> +	 * without the lock and read there with it, so a submit that has already
> +	 * passed its check can re-arm the mask after this clears it, and then
> +	 * the synchronize_irq() below fences a handler that is no longer the
> +	 * one that matters: the block is left running a task with its
> +	 * interrupt live. rocket_job_handle_irq() avoids the same race on
> +	 * OPERATION_ENABLE by making its completion writes under this lock.
> +	 *
> +	 * pm_runtime_get_if_active() does not invoke a callback -- it only
> +	 * takes a reference on an already-active device -- and
> +	 * pm_runtime_put_autosuspend() is asynchronous, so neither can re-enter
> +	 * this driver's runtime PM callbacks while the lock is held.
> +	 */

This is just absurd. The driver will quickly become unmaintainable if we merge
this kind of comments. 

Please remove all LLM-generated text (cover letter, commit messages, and code
comments) from the accel/rocket patches in this series, and replace it with
your own.  I don't mind if you write it first in your native language and use a
LLM to translate it to english, but I need for you to understand the code you
submit and write yourself any communication with humans.

If you don't understand anything in the code well enough to write the commit
messages, cover letter and comments, then I suggest you use the LLM to assist
you in acquiring the knowledge that you are missing.

Also, please read:

Documentation/process/coding-assistants.rst
Documentation/process/generated-content.rst

Thanks,

Tomeu

