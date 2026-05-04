Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF08CD342C
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 11:15:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32D4910E641;
	Mon,  4 May 2026 11:15:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Ml8EFgm3";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 274AB10E660
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 11:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1777893325;
 bh=DFybYs16j+UQIzyKR0NoGVrbwoeuu7MHZgrH7CxDzrs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Ml8EFgm3Dqvo2K7U7yzB86T+hWTbSJ6oOraN7sHtU2bW9Q5AHUnsDcTW9nGBl71AI
 qLgT8olXlr6WGIC7tc2jKWK5jFC3/HRHLNgbwHmTbPEjS0IkBaWXWIp2uMENXEuRnF
 j1JO6xT6Gw7dnX9TXSy06x5yXzanSJ8NTpZqrcc1usFzowFqpJRlsxyCgPkJqc9E5K
 SrbrrtqFCrdgyXHO++JBUaKvJw5qWzQcgbMePLZJ3Xl7DXi502BdP56eNDbXl4xlXI
 YWmd0nebTYW2BWJaOckM7bNM3+leC17ylUcVR0Awbv1CBfYCxddS238JnLwQ/EyEgi
 pNxD54cBv0zcw==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 5D29517E1305;
 Mon,  4 May 2026 13:15:25 +0200 (CEST)
Date: Mon, 4 May 2026 13:15:21 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] drm/panthor: Introduce interrupt coalescing
 support for job IRQs
Message-ID: <20260504131521.49f4750d@fedora>
In-Reply-To: <c6560418-fc24-4f8f-9b46-fd34d8d72b5a@arm.com>
References: <20260429-panthor-signal-from-irq-v1-0-4b92ae4142d2@collabora.com>
 <20260429-panthor-signal-from-irq-v1-10-4b92ae4142d2@collabora.com>
 <c6560418-fc24-4f8f-9b46-fd34d8d72b5a@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri, 1 May 2026 15:57:35 +0100
Steven Price <steven.price@arm.com> wrote:

> On 29/04/2026 10:38, Boris Brezillon wrote:
> > Dealing with interrupts from the raw IRQ handler is good for latency,
> > but might be detrimental for the overall throughput, because the system
> > keeps being interrupted to process job interrupts.
> > 
> > Try to mitigate that with some interrupt coalescing infrastructure,
> > where we wake up the IRQ thread if close enough interrupts gets
> > detected.
> > 
> > It's still experimental, which explains why the feature is off by
> > default, and can be enabled through a debugfs knob.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>  
> 
> I think we need some more serious benchmarking to decide whether this is
> a good idea. We've experimented with coalescing interrupts in the past
> and it generally regressed some important benchmark of the day. But I'm
> not in the loop of "benchmark of the day" any more (although I do know
> that glmark hasn't been for years...) so it might have changed. From
> what I hear AI workloads "benefit"[1] from spinning a CPU waiting for
> jobs to finish.
> 
> [1] AI workloads don't tend to care so much about power... at least from
> the CPU.
> 
> One typo I spotted below. And I'm not awfully keen on the debugfs
> interface (but for testing it's obviously fine).

Yeah, just to be clear, patch 10 was really meant to be an RFC to get
the discussion started. What worries me a bit is the regression I'm
seeing on refract/terrain when switching to "event processing from the "
hard handler, which is why I worked on that.
