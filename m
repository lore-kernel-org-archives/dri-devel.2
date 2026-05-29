Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3009CD6E51
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 12:21:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E31610FE45;
	Fri, 29 May 2026 12:21:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="MKgyE5Ci";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oHVgbi/z";
	dkim-atps=neutral
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C47AA10FE43;
 Fri, 29 May 2026 12:21:40 +0000 (UTC)
Date: Fri, 29 May 2026 14:21:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1780057299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Lk6J8Yay4yJw29ZMp1a44IgTYA3zIlsMamRU59bPHEk=;
 b=MKgyE5Ci4fmUYnA5JOEnB4n4ljFf5Au4EUx66ry6llbuCwmprN1bF9bi91TPTzfqcPG/rh
 UdAaxjYkl26wGci7upMeJXE4aQsyKimpRJKJgu10pRFDT9zDZe+u7U4jFReNbVB4dBmoG4
 +ng4kxcR1YkcKmhaT0vcTbtHI5S4FWmujTC9+qlywDmoNIa2BUEv9NBG1Cl8k7nAhuvhCB
 Rs15yPqHLzolELj25UgKJia8ckEm+ikv2vKE/CMgmAno0K3n3CLwIm7wE49P3BUYDRDKBz
 IxwTtVBWHzfrNu2G0QG1sHHjqzoatLBVyxmMj4OqGbYxf0X7iJojHr7fdvEkeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1780057299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Lk6J8Yay4yJw29ZMp1a44IgTYA3zIlsMamRU59bPHEk=;
 b=oHVgbi/zFlD1tQdiDiwM6YKnRLFgyzv6Lnl4DT2HVyxg5F/aj3ru4qKlT7az3qQRzXBfv/
 K0fGA1qi1JoTY5AA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Maarten Lankhorst <dev@lankhorst.se>
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>, jani.nikula@linux.intel.com,
 rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com,
 tursulin@ursulin.net, airlied@gmail.com, simona@ffwll.ch,
 clrkwllms@kernel.org, rostedt@goodmis.org, jerome.anand@intel.com,
 pierre-louis.bossart@linux.dev, tiwai@suse.de,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, jianhao.xu@seu.edu.cn,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915/audio: use generic_handle_irq_safe() for LPE
 audio irq
Message-ID: <20260529122137.VZtFvQvw@linutronix.de>
References: <20260528154551.3708290-1-runyu.xiao@seu.edu.cn>
 <20260529074816.k1K16jyy@linutronix.de>
 <2023cf0e-85a8-4128-857d-cae806ff0e58@lankhorst.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2023cf0e-85a8-4128-857d-cae806ff0e58@lankhorst.se>
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

On 2026-05-29 11:50:18 [+0200], Maarten Lankhorst wrote:
> Hey,
Hi,

> It's been absolutely rock stable since the last time I submitted it.
> I've been using it on my local machine, and the amount of times >100us
> (evasion failed) with and without PREEMPT_RT are identical with
> the vblank changes.
> It still applies cleanly when rebasing.
> 
> The vblank patches are the most involved change, and they ensure that
> absolutely no lock contention happens in the critical path with irqs off.

So that is the good part.

> Unfortunately the status is still same as the time I submitted it before it,
> and pending reviews on the series.

my memory is that you have no work items and the auto-CI isn't worse
than before. The series just waits for a review then?

> Kind regards,
> ~Maarten Lankhorst

Sebastian
