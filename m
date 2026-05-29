Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C3FCD5BD2
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 09:50:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4096810FC1F;
	Fri, 29 May 2026 09:50:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="D5cQBJ29";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EDD510FC1E;
 Fri, 29 May 2026 09:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1780048220;
 bh=nQhEEJC7UiBSk+EjxGg14ByJ7Sa+/PNen/fIZQlXYJ0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=D5cQBJ295FX/kz8ZSMxTRJ6szEjP1/q59dWdJTQatz4CKMniWu6veA2lHdMJ62wn/
 P2mICAsVqXkLrLL1FZn/XAbvFKLhqdicaxPJAYFD81gRg0/IG+ME1PR7YWXf1gAYSi
 +8XsyKSrsZbZjsMBSMIJT9IdqAnVftv0j/vVclLbGjqzJ/mLBTQBne2uYalLiZDDdf
 44N065p5Adab47o+f1uOhmBeWE5BfLEGZ2JApxKGz4K95/XL7l7+45CE+LfYQ4sjr6
 BZyUbaZyaeoJAPSukU+ZM6NoY6EyEP3amGUkg8GSaE7gcGLRIov3ltt3YhjDq88MMW
 mlUhrEmaxwrVA==
Message-ID: <2023cf0e-85a8-4128-857d-cae806ff0e58@lankhorst.se>
Date: Fri, 29 May 2026 11:50:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/i915/audio: use generic_handle_irq_safe() for LPE
 audio irq
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: jani.nikula@linux.intel.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net, airlied@gmail.com,
 simona@ffwll.ch, clrkwllms@kernel.org, rostedt@goodmis.org,
 jerome.anand@intel.com, pierre-louis.bossart@linux.dev, tiwai@suse.de,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, jianhao.xu@seu.edu.cn, stable@vger.kernel.org
References: <20260528154551.3708290-1-runyu.xiao@seu.edu.cn>
 <20260529074816.k1K16jyy@linutronix.de>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <20260529074816.k1K16jyy@linutronix.de>
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

Den 2026-05-29 kl. 09:48, skrev Sebastian Andrzej Siewior:
> On 2026-05-28 23:45:51 [+0800], Runyu Xiao wrote:
>> intel_lpe_audio_irq_handler() forwards the LPE audio child IRQ from the
>> i915 parent IRQ path with generic_handle_irq(). The forwarded child top
>> half is not an independent hardirq entry point; it inherits the context
>> of the outer i915 interrupt dispatch path.
> …
> 
> This looks very familiar and is work in progress
> 	https://lore.kernel.org/all/20260310115709.2276203-16-dev@lankhorst.se/
> 
> Maarten, where do we stand on the i915 series?
> 
>> Fixes: eef57324d926 ("drm/i915: setup bridge for HDMI LPE audio driver")
>> Cc: stable@vger.kernel.org
> 
> No stable fix needed because i915 can not be turned on PREEMPT_RT.
> 
> Sebastian

It's been absolutely rock stable since the last time I submitted it.
I've been using it on my local machine, and the amount of times >100us
(evasion failed) with and without PREEMPT_RT are identical with
the vblank changes.
It still applies cleanly when rebasing.

The vblank patches are the most involved change, and they ensure that
absolutely no lock contention happens in the critical path with irqs off.

Unfortunately the status is still same as the time I submitted it before it,
and pending reviews on the series.

Kind regards,
~Maarten Lankhorst
