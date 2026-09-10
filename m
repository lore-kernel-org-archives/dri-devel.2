Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED3EFC79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 06:57:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CACC10F2EC;
	Thu, 10 Sep 2026 06:57:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="JEP2GRUh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JjuqFWsA";
	dkim-atps=neutral
X-Greylist: delayed 580 seconds by postgrey-1.36 at gabe;
 Thu, 10 Sep 2026 06:57:07 UTC
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7516510F2EC;
 Thu, 10 Sep 2026 06:57:07 +0000 (UTC)
Date: Thu, 10 Sep 2026 08:47:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1789022845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TeCdhF7Yub4R/46hTdO2r+79dtJz2WzZGwh+bE6OaSE=;
 b=JEP2GRUhQsVhun7vbhk1q9LvyAQfQP6zlP59QQ16UqndaplL5J/G1L3Q+pLm/IA5W5OJku
 W/nUmdYFWR5TLyN15PGS1CMsPN8/0FNOpSGJHyvEzM7d6V0chIl/yzSOesYtohM4TDoNMo
 Uc6H+6gOWG9BpmB3KsKMez1osxj9vsavovGbs4Uj4GwHaHRnyCKJGm78K7YvoFbGtPmACJ
 JvA/ljnPgvtFoPvj54Tf0jnyxMy3E2ra3Ua3ZNnPPqrP6klllygp9kN3Mbl5lxV/sfyuU4
 ILvdjhY+ewOr6EWAX4JO6U1B56pXnwzeoKLjH1g5hgXrWDipe16LFxcsVsvnSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1789022845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TeCdhF7Yub4R/46hTdO2r+79dtJz2WzZGwh+bE6OaSE=;
 b=JjuqFWsAOS0tHwzrdR0C9BlJ5ndwIJ8Ve/rzT3pLTGNtgF0OG43Wpyi8+mA/spQ3L/3McA
 Qo9UJmp7R8zCuyDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: vishnu.saini@oss.qualcomm.com
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Jordan Crouse <jordan@cosmicpenguin.net>,
 Sravanthi Kollukuduru <skolluku@codeaurora.org>,
 Archit Taneja <architt@codeaurora.org>,
 Jeykumar Sankaran <jsanka@codeaurora.org>,
 Chandan Uddaraju <chandanu@codeaurora.org>,
 Rajesh Yadav <ryadav@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 venkata.valluru@oss.qualcomm.com,
 Naman S Thaker <namathak@qti.qualcomm.com>, stable@vger.kernel.org
Subject: Re: [PATCH] drm/msm: split DPU core IRQ handler under
 CONFIG_PREEMPT_RT
Message-ID: <20260910064723.pbZP3vic@linutronix.de>
References: <20260909-drm-mis-next-split-irq-v1-1-89bc9c512c53@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260909-drm-mis-next-split-irq-v1-1-89bc9c512c53@oss.qualcomm.com>
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

On 2026-09-09 14:22:16 [+0530], vishnu.saini@oss.qualcomm.com wrote:
> From: Naman S Thaker <namathak@qti.qualcomm.com>
> 
> On a PREEMPT_RT kernel, dpu_core_irq() runs as a true hardirq handler,

*why* is this the case. The code you replaces adds some ifdefs around
request_irq() with 0 as flags. This does not make it run has hardirq.

> but it dispatches per-encoder callbacks that take sleepable locks
> (spinlock_t becomes an rt_mutex on RT, and some DRM-core locks reached
> through vblank/CRC/writeback handling are sleepable as well). Sleeping
> inside a hardirq handler is not allowed and eventually crashes the
> display, which is what happens after running GLMark2 for a while.

That is correct. That is the irq handler are threaded by default and
only non-threaded if explicitly requested.

I suggest to stick with non-threaded by default.
There is only one request_threaded_irq() as far as I can tell and this
msm_dp_display_request_irq():

|         rc = devm_request_threaded_irq(&pdev->dev, dp->irq,
|                                        msm_dp_display_irq_handler,
|                                        msm_dp_display_irq_thread,
|                                        IRQ_TYPE_LEVEL_HIGH,
|                                        "dp_display_isr", dp);

and its primary handler will be threaded on PREEMPT_RT, too. So you end
up with two threads here.

Sebastian
