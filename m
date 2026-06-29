Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBDFEC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 09:26:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CD0A10E7E5;
	Mon, 29 Jun 2026 09:26:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=psihoexpert.ro header.i=@psihoexpert.ro header.b="jXH1h0Ys";
	dkim-atps=neutral
Received: from mx1.wiredblade.com (mx1.wiredblade.com [72.51.58.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F90D10E7BB
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 09:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; d=psihoexpert.ro; s=dynu;
 c=relaxed/relaxed; q=dns/txt;
 h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:In-Reply-To:References;
 bh=OttsIzjNQjYyQpZiUKo5XDS5QeXvKFZsZT7zR3RzaiM=;
 b=jXH1h0YsimHZ9E7nQB/TLMWupnud0ivrKdffksjW/L1lMtjTC0zYtUlmB/t8pNIeuraFehZgw+OC8rt5zRDFwXyxT/7CFOhvsI+TtEDbRH4FfhDwm+a21F4RMX4unkxaq5UcSwS99LzVOEKs+/BlV9vJUFoLoPTa4T6//ek2YRBRmfjGcqg7k9/4YCIOOYZXOMjCnRsYGQrI153D3YYTswpa81ta+I6ZEI2ojEXvwKPbGHA+EHI7+l0yZo
 yIH4hwjOKeMRamP6CgUWClk9jKMfxkIpJk1BLYQBgWecY5xdZQ+8iV1NMUqoNEActkU6dR5ZiM/QnSBXUY8rYlwcKNtQ==
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=dynu.com; s=mail;
 b=IgtEGpUy4BzN/BG2ev6hIQzFt7WwcFsMs9waVEtMCF0bFN/Prvv5RYFH41OZAC+sFQC3EnvgX9CbPd3HHY0dgYi24ws+eQldRSMmyshcBGwhPa/Tsl6XFWcEEGmOmr3fr7av058CRdbrjw3opXm3T+BgHvRbIog5UdB9eHrpLjCY4qEvjhJBEG2pi60dW5+BYfhmPSQ4xWE28DhYt508XMEYsKZOzwkRvSxiRZ1z9C5yCgbg7XsH5/HXGW
 sHdQL691kj2kb1x6a5moijz6tlFislRJNBmZf1JsyPywHWlqie2aWjX4FLrFYS8XeDANqKKeumsTq6WEuE8yEC/DkV/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dynu.com; s=mail;
 h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:In-Reply-To:References;
 bh=OttsIzjNQjYyQpZiUKo5XDS5QeXvKFZsZT7zR3RzaiM=;
 b=iuBkhcIx5mma8Ygk5jGTAer7dBlFqwdHzz33qoZGRxB84uMcYck+CfJ+8xpeIpmYkyqHQ4M0bltqjwS8YLe5XPWQViJxD4H11spzl+AW22vwkLR78yCURI4usuDifhqmNz1dOo2IR3CEgk5l794ow4nkOWQ1o/Xn3sBnNAPt5SQiVeFijMDgFb8+U1BAJbk7Nnhdcoxyvu7HKhfqb1OuYg/h3BuBiNDl3X+YdDhYKbJ05gaJIBHwye7rEi
 8IdIBdqufbCuc2rb6/HT02XVpJOl0yXXaNIex37xICvwfIF8YhkeYzLLUtoaT68JkPAcKiUKJDWKng0frgoyovnCo4YA==
ARC-Authentication-Results: i=1; mx.dynu.com;
	dkim=none;
	dmarc=fail
Received: from GRAPHRT (188-24-194-9.rdsnet.ro [188.24.194.9])
 by mx1.wiredblade.com with ESMTPSA
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256)
 ; Mon, 29 Jun 2026 09:26:22 +0000
X-Original-Rcpt-To: m95d+git@psihoexpert.ro
Date: Mon, 29 Jun 2026 12:26:25 +0300
From: Marius Dinu <m95d+git@psihoexpert.ro>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Marius Dinu <m95d+git@psihoexpert.ro>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, Steven Price <steven.price@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>
Subject: Re: [BUG] drm/panthor: intermittent freezes in Xorg xserver
Message-ID: <akI6QaSayNAgdnYv@GRAPHRT>
References: <aj5neetgYdu0QpcK@GRAPHRT> <20260629094419.6bb56d99@fedora-2.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629094419.6bb56d99@fedora-2.home>
Authentication-Results: mx.dynu.com;
	dkim=none;
	dmarc=fail
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

On Mon, 2026-06-29 09.44.19 ++0200, Boris Brezillon wrote:
> On Fri, 26 Jun 2026 14:50:17 +0300
> Marius Dinu <m95d+git@psihoexpert.ro> wrote:
> 
> > Hi.
> > 
> > The system is Radxa Rock 5 ITX, RK3588, 32GB RAM,
> > mainline kernel v7.1.0 with panthor driver, mesa 26.0.7 with panfrost driver,
> > xorg-server v21.1.22 accelerated by modesetting driver, x11perf v1.7.0.
> 
> Are we sure that's a panthor issue? Also, is this a regression
> introduced by the latest kernel version, or has it been like that from
> the start?

It was from the start, not a regression. I think I started from v6.18 on this
board IIRC. If you need me to test earlier versions, say so.

> 
> Also, would you mind opening an issue on [1]?
> 

I already did.
https://gitlab.freedesktop.org/mesa/mesa/-/work_items/15721

> > 
> > The most clean way to reproduce this bug:
> > Form a console or ssh session, start Xorg in background, without a window
> > manager, and then run x11perf on that display.
> > 
> > Xorg :0 &
> > x11perf -all -display :0
> > 
> > The bug: weird intermittent performance issues in some of the tests.
> > Examples:
> > 
> >     1000 reps @  18.0799 msec (    55.3/sec): 10x10 rectangle outline
> >     1000 reps @  18.0791 msec (    55.3/sec): 10x10 rectangle outline
> >     1000 reps @  18.0790 msec (    55.3/sec): 10x10 rectangle outline
> >     1000 reps @  18.0789 msec (    55.3/sec): 10x10 rectangle outline
> >     1000 reps @   0.0287 msec ( 34800.0/sec): 10x10 rectangle outline
> >     5000 trep @  14.4691 msec (    69.1/sec): 10x10 rectangle outline
> > 
> >  5000000 reps @   0.0029 msec (345000.0/sec): 1-pixel solid circle
> >  5000000 reps @   0.0009 msec (1100000.0/sec): 1-pixel solid circle
> >  5000000 reps @   0.0012 msec (818000.0/sec): 1-pixel solid circle
> >  5000000 reps @   0.0000 msec (20900000.0/sec): 1-pixel solid circle
> >  5000000 reps @   0.0000 msec (32300000.0/sec): 1-pixel solid circle
> > 25000000 trep @   0.0010 msec (979000.0/sec): 1-pixel solid circle
> > 
> >     1000 reps @  31.6607 msec (    31.6/sec): Fill 10x10 trapezoid
> >     1000 reps @  16.9012 msec (    59.2/sec): Fill 10x10 trapezoid
> >     1000 reps @   0.0234 msec ( 42700.0/sec): Fill 10x10 trapezoid
> >     1000 reps @   0.0272 msec ( 36700.0/sec): Fill 10x10 trapezoid
> >     1000 reps @  32.1268 msec (    31.1/sec): Fill 10x10 trapezoid
> >     5000 trep @  16.1479 msec (    61.9/sec): Fill 10x10 trapezoid
> > 
> > There are no messages in kernel log or Xorg log.
> > 
> > Visually, most of the tests runs fast as expected, but in some of the tests
> > it gets "stuck" randomly. The test suddenly freezes while drawing the pattern.
> > Then, after a while (a few seconds up to a couple of minutes), it gets
> > unstuck by itself, draws a few more patterns extremely fast for less than a
> > second, and then it gets stuck again.
> 
> It smells like a signalling issue. Can you check the CPU activity and
> report any outstanding process? Can you maybe connect a gdb to the
> x11perf to see where it's blocked, and post the backtrace here (or in
> the gitlab issue)?
> 

x11perf is waiting on I/O (red "D" in htop). CPU is completely idle, not even
grey "io-wait" activity.

I have no experience using gdb. Please give me the exact command to run.

> Regards,
> 
> Boris
> 
> [1]https://gitlab.freedesktop.org/mesa/mesa

Marius

