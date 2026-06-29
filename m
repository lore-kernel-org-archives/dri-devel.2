Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD451C43327
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 07:44:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28E9B10E73B;
	Mon, 29 Jun 2026 07:44:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="KoK+c+dt";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B157E10E73B
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 07:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782719079;
 bh=mjdaelFFBbsf9dEtW9+UwJ9rw2Yq4Kx9/BLbeDxbjxk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=KoK+c+dt80d/uwglsQgyED1NamKLFrWEPawNWo+wJ++crZ9aaXLy4XjtnHM/DLGNT
 KVzx0ItMd05iN1N8Ao0BN+o4Musg/zDHdXsTBGDvWf/9Ca9P0MHFZ5V+pqe/yqw1J4
 bCS0fhf+/CGRRAYk9mdL8z/7gpSKHnt8GZ4WherUfvceDdd9OXUzaWCdR5XiBRWmIV
 coMzlLacD7Vu1yFMtLfKnleLypPQfj4n4rDvD8gvSjoDYJXnCoNZX1zjNrmuvG3SNs
 lkHTP/00B5cRs728gtTmEruHyb0IHMOREBnUTrqOiNN/bewRsj5BX54LHUebxznc9Z
 hKv6eXxNi3tCg==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 7E96717E0851;
 Mon, 29 Jun 2026 09:44:39 +0200 (CEST)
Date: Mon, 29 Jun 2026 09:44:19 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Marius Dinu <m95d+git@psihoexpert.ro>
Cc: dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Subject: Re: [BUG] drm/panthor: intermittent freezes in Xorg xserver
Message-ID: <20260629094419.6bb56d99@fedora-2.home>
In-Reply-To: <aj5neetgYdu0QpcK@GRAPHRT>
References: <aj5neetgYdu0QpcK@GRAPHRT>
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

On Fri, 26 Jun 2026 14:50:17 +0300
Marius Dinu <m95d+git@psihoexpert.ro> wrote:

> Hi.
> 
> The system is Radxa Rock 5 ITX, RK3588, 32GB RAM,
> mainline kernel v7.1.0 with panthor driver, mesa 26.0.7 with panfrost driver,
> xorg-server v21.1.22 accelerated by modesetting driver, x11perf v1.7.0.

Are we sure that's a panthor issue? Also, is this a regression
introduced by the latest kernel version, or has it been like that from
the start?

Also, would you mind opening an issue on [1]?

> 
> The most clean way to reproduce this bug:
> Form a console or ssh session, start Xorg in background, without a window
> manager, and then run x11perf on that display.
> 
> Xorg :0 &
> x11perf -all -display :0
> 
> The bug: weird intermittent performance issues in some of the tests.
> Examples:
> 
>     1000 reps @  18.0799 msec (    55.3/sec): 10x10 rectangle outline
>     1000 reps @  18.0791 msec (    55.3/sec): 10x10 rectangle outline
>     1000 reps @  18.0790 msec (    55.3/sec): 10x10 rectangle outline
>     1000 reps @  18.0789 msec (    55.3/sec): 10x10 rectangle outline
>     1000 reps @   0.0287 msec ( 34800.0/sec): 10x10 rectangle outline
>     5000 trep @  14.4691 msec (    69.1/sec): 10x10 rectangle outline
> 
>  5000000 reps @   0.0029 msec (345000.0/sec): 1-pixel solid circle
>  5000000 reps @   0.0009 msec (1100000.0/sec): 1-pixel solid circle
>  5000000 reps @   0.0012 msec (818000.0/sec): 1-pixel solid circle
>  5000000 reps @   0.0000 msec (20900000.0/sec): 1-pixel solid circle
>  5000000 reps @   0.0000 msec (32300000.0/sec): 1-pixel solid circle
> 25000000 trep @   0.0010 msec (979000.0/sec): 1-pixel solid circle
> 
>     1000 reps @  31.6607 msec (    31.6/sec): Fill 10x10 trapezoid
>     1000 reps @  16.9012 msec (    59.2/sec): Fill 10x10 trapezoid
>     1000 reps @   0.0234 msec ( 42700.0/sec): Fill 10x10 trapezoid
>     1000 reps @   0.0272 msec ( 36700.0/sec): Fill 10x10 trapezoid
>     1000 reps @  32.1268 msec (    31.1/sec): Fill 10x10 trapezoid
>     5000 trep @  16.1479 msec (    61.9/sec): Fill 10x10 trapezoid
> 
> There are no messages in kernel log or Xorg log.
> 
> Visually, most of the tests runs fast as expected, but in some of the tests
> it gets "stuck" randomly. The test suddenly freezes while drawing the pattern.
> Then, after a while (a few seconds up to a couple of minutes), it gets
> unstuck by itself, draws a few more patterns extremely fast for less than a
> second, and then it gets stuck again.

It smells like a signalling issue. Can you check the CPU activity and
report any outstanding process? Can you maybe connect a gdb to the
x11perf to see where it's blocked, and post the backtrace here (or in
the gitlab issue)?

Regards,

Boris

[1]https://gitlab.freedesktop.org/mesa/mesa
