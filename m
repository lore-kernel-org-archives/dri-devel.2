Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0032C5AC82
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 02:59:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D61C510E2D1;
	Sat,  8 Aug 2026 02:59:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="U3esOBYK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dMXx51JW";
	dkim-atps=neutral
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E59E810E2D1
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 02:59:45 +0000 (UTC)
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1786157983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lhwuIE0zT+IiBqvhQLOpEcS/lGGVH+Bj5PmvGL4nLO8=;
 b=U3esOBYK6yJpD5fVQ/b+bHyU1wrzT97Zsn8KM5ECQqi5u41JHnWHBYdUCNKce65jOpwo31
 SMvLNWRaln34LYsnJtGt02jhob8rjDRDGP1FNUjZ2YxsTceitrkr0yu0II17kUSwkrgSHa
 MB4JNbGhzJaLYKCGHimij/VPOWS135w8VWU4UKrIDW/4MPjOovA/x1Zak7HhaLbWjq8x3p
 EO2EaqBUZeWeYGbu3SpxaHLAwfaMBCwEc0kncUtuU1saLZ5fpzuOH1Bwy1Zp8b00ChhP9Z
 F0/CJPFt975vs9bpdfpC+vwN02N4yOKqjYy2kdbLyHfUr/sBUDRiU/p79IBdww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1786157984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lhwuIE0zT+IiBqvhQLOpEcS/lGGVH+Bj5PmvGL4nLO8=;
 b=dMXx51JWLovgzeDso0jw9r6M6/EuXb3sDkUB36Q+UCoQ6+yoVlt3/ogqaZ6ORyt999AQXi
 60R462v3r+rVoEDg==
To: Hui Su <sh_def@163.com>, andy@kernel.org
Cc: gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, sh_def@163.com,
 thomas.petazzoni@free-electrons.com, notro@tronnes.org
Subject: Re: [PATCH v2] staging: fbtft: make dirty_lock IRQ-safe
In-Reply-To: <20260807150953.2811933-3-sh_def@163.com>
References: <20260807150953.2811933-3-sh_def@163.com>
Date: Sat, 08 Aug 2026 04:59:42 +0200
Message-ID: <874ih5b9lt.fsf@yellow.woof>
MIME-Version: 1.0
Content-Type: text/plain
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

Hui Su <sh_def@163.com> writes:
> fbtft_mkdirty() can be reached from the fbcon rendering path while
> processing printk() in hardirq context. Meanwhile, dirty_lock is also
> taken by fbtft_deferred_io() in workqueue context with local interrupts
> enabled.
...
> Use spin_lock_irqsave() for fbtft_mkdirty() and spin_lock_irq() for
> fbtft_deferred_io(). They only access the dirty line range, so the
> IRQ-off regions remain short.
>
> Fixes: c296d5f9957c ("staging: fbtft: core support")
> Signed-off-by: Hui Su <sh_def@163.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
