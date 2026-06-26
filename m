Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B4D6C43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 11:44:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C31A10E5E5;
	Sun, 28 Jun 2026 11:44:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=psihoexpert.ro header.i=@psihoexpert.ro header.b="ht33PwIP";
	dkim-atps=neutral
X-Greylist: delayed 1811 seconds by postgrey-1.36 at gabe;
 Fri, 26 Jun 2026 12:20:34 UTC
Received: from mx1.wiredblade.com (mx1.wiredblade.com [72.51.58.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAE9010E39E
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 12:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; d=psihoexpert.ro; s=dynu;
 c=relaxed/relaxed; q=dns/txt;
 h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type; 
 bh=88jmE9CjEl0gIewR3F6VmdhybKEN86eNI2ZKa+ty0gs=;
 b=ht33PwIPRx4w70DUB2D5QwnrhYWLH1myC6QTBkPfkawKnHAWXu3itXpqhLUrP6vrK7DVbdwRR+oEnKVPVE8bue8US/AVXcrzNB+vsuDQvnPedbkv4guwi2oPtPEtWBbsSxajAGSLKjneMiMG7ThnZYLXCJaICKNLl/gv9nUQVqWJdHnbRHgmz1ceKQWoVeEkwQ6nHCkuJ5r/DWO+dPG0wrz7IcDj/j2fcVcII0vFei/wCvSZSRx4wpH9uD
 B8Zk0M3AFDokLNJbHlnn1ceCIfMGpSbIdh8N5467CcXyAIizsUjEkiuH5uRObkkNO2jkd5ab1Jp/6duz1SNngHgLZTNw==
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=dynu.com; s=mail;
 b=iWxYCIZLy3jXCjo241DaftI5H3Y+wsFZ817NhTuyacjCV1yqM9CSlSH/SHRnBeIfD/kBIilwGCYCTAsCQoJTXXP73L28FmS5hDmF+1pCs+f7bUJ0c/ewQfmWwLLqhDb6FjeXYBZAZWJGC//SdLBM2Ex+5uRsHTbR/siI26nprN/125t8V9ZTjwFLDMVL+G4k/XKTLOBdRU7kY1QCd2xZtqrHbN61GBETUEiguhlTayH/2/ifubinpxKHLw
 SUaisKJSfINNZqO8ggICBBxqKITaeJOxXgFk7MiCnxfWFLx75OeMMtwR0MO9gyb5qc1+Nwjk6FI7PXIY8FRGoQWVQ50Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dynu.com; s=mail;
 h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type;
 bh=88jmE9CjEl0gIewR3F6VmdhybKEN86eNI2ZKa+ty0gs=;
 b=rSZeoY631KPC+yfPKSgLtvyZxPKg4aZCSCQiFu68pmHBcTyv17NT8sC6KPaex1K4xFitXrpjmhKVLToyeplsi1wm+AbvrP/uFFUuuhWvyIHA5ow4AgWzrJ5HNYu5FHIReuSrFfBB1MER4AifJm1BYp2c5Bfs+c21Uf7jcMFbnvTfIL6Z0k5x8yuNzBvBP1fAFnhk5VQBZJJKdF5z67tbxN/rKsAdIQp4xm0QuPihIO/idZEebrV+Z5T5TJ
 NgdF2Xk7/CsSGPJpK11qqwrSx2lG3x7V2/afb//T6Iai9aLcCA/iO/BW8hvL90NPbXOrtBvQRaaxR7B+6Xg1VF0RVLoA==
ARC-Authentication-Results: i=1; mx.dynu.com;
	dkim=none;
	dmarc=fail
Received: from GRAPHRT (188-24-194-227.rdsnet.ro [188.24.194.227])
 by mx1.wiredblade.com with ESMTPSA
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256)
 ; Fri, 26 Jun 2026 11:50:21 +0000
Date: Fri, 26 Jun 2026 14:50:17 +0300
From: Marius Dinu <m95d+git@psihoexpert.ro>
To: dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Subject: [BUG] drm/panthor: intermittent freezes in Xorg xserver
Message-ID: <aj5neetgYdu0QpcK@GRAPHRT>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Authentication-Results: mx.dynu.com;
	dkim=none;
	dmarc=fail
X-Mailman-Approved-At: Sun, 28 Jun 2026 11:43:39 +0000
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

Hi.

The system is Radxa Rock 5 ITX, RK3588, 32GB RAM,
mainline kernel v7.1.0 with panthor driver, mesa 26.0.7 with panfrost driver,
xorg-server v21.1.22 accelerated by modesetting driver, x11perf v1.7.0.

The most clean way to reproduce this bug:
Form a console or ssh session, start Xorg in background, without a window
manager, and then run x11perf on that display.

Xorg :0 &
x11perf -all -display :0

The bug: weird intermittent performance issues in some of the tests.
Examples:

    1000 reps @  18.0799 msec (    55.3/sec): 10x10 rectangle outline
    1000 reps @  18.0791 msec (    55.3/sec): 10x10 rectangle outline
    1000 reps @  18.0790 msec (    55.3/sec): 10x10 rectangle outline
    1000 reps @  18.0789 msec (    55.3/sec): 10x10 rectangle outline
    1000 reps @   0.0287 msec ( 34800.0/sec): 10x10 rectangle outline
    5000 trep @  14.4691 msec (    69.1/sec): 10x10 rectangle outline

 5000000 reps @   0.0029 msec (345000.0/sec): 1-pixel solid circle
 5000000 reps @   0.0009 msec (1100000.0/sec): 1-pixel solid circle
 5000000 reps @   0.0012 msec (818000.0/sec): 1-pixel solid circle
 5000000 reps @   0.0000 msec (20900000.0/sec): 1-pixel solid circle
 5000000 reps @   0.0000 msec (32300000.0/sec): 1-pixel solid circle
25000000 trep @   0.0010 msec (979000.0/sec): 1-pixel solid circle

    1000 reps @  31.6607 msec (    31.6/sec): Fill 10x10 trapezoid
    1000 reps @  16.9012 msec (    59.2/sec): Fill 10x10 trapezoid
    1000 reps @   0.0234 msec ( 42700.0/sec): Fill 10x10 trapezoid
    1000 reps @   0.0272 msec ( 36700.0/sec): Fill 10x10 trapezoid
    1000 reps @  32.1268 msec (    31.1/sec): Fill 10x10 trapezoid
    5000 trep @  16.1479 msec (    61.9/sec): Fill 10x10 trapezoid

There are no messages in kernel log or Xorg log.

Visually, most of the tests runs fast as expected, but in some of the tests
it gets "stuck" randomly. The test suddenly freezes while drawing the pattern.
Then, after a while (a few seconds up to a couple of minutes), it gets
unstuck by itself, draws a few more patterns extremely fast for less than a
second, and then it gets stuck again.
The small test patterns (10px) are a lot more often affected than large
patterns (100px or more).

The bug can also be seen by trying to move or resize windows.
Setting governors to "performance" for the CPU and/or GPU has no effect.

I'm available for tests.
Thanks.

Marius Dinu

