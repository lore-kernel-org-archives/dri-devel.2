Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D103D1090248
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 15:55:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE73610E187;
	Thu, 19 Mar 2026 15:55:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="uXMcY6oo";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F62E10E187
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 15:55:17 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fc9JK4n3zz9tYm;
 Thu, 19 Mar 2026 16:55:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773935713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dp3I3CjyeJhqX7ZIk+Vjux5OAdrU6+z0fiLmhH0G6Bs=;
 b=uXMcY6ooybv3BzG7AkcEMhfdkdidJCnGzrfca/dMfQuv9SZJ7q2pa8UIRpJn9h2DSjMOxg
 5p5629z6OUMtojsQP0HywbKLI+kA/ppL1LskC23rcJLxEglj4dLzjo4B4sbBzV1z6eU0/A
 plqYgswKwZVANqQhAz8W56Tqrv6YHdsz/5mobxREuUoRDLatG8UT0akl2adUzMJKaWXWWB
 nuGx5YocXQd/cwQehR3SYMrpuBSCAPcHYUnO5yjqXFoQhx2Su3EHverOU5Oy0dlhbnCsro
 HtJpP+9vy/z57jRoiAg1rwZDWQ0YwFtoVhsrJf0ysovh0eaglcYMFg9iwx6IkA==
Message-ID: <f68acaa0-4752-423c-afff-b1a734f0671f@mailbox.org>
Date: Thu, 19 Mar 2026 16:55:08 +0100
MIME-Version: 1.0
Subject: Re: drm/simpledrm: no handoff to amdgpu on Picasso/Raven2
To: Jill Ravaliya <jillravaliya@gmail.com>, tzimmermann@suse.de,
 javierm@redhat.com
Cc: dri-devel@lists.freedesktop.org
References: <CAHr0PbtxGWQdv1iOU5XDmoWND+GCzxvnerJHhkcd2aDp0pUwNg@mail.gmail.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <CAHr0PbtxGWQdv1iOU5XDmoWND+GCzxvnerJHhkcd2aDp0pUwNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: f296a46b904ed9f322c
X-MBO-RS-META: 1e9p39rixjkzuw6u5xyiduzoyzt71pch
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

On 3/18/26 11:19, Jill Ravaliya wrote:
> Hi,
> 
> I've been debugging a boot issue on my machine for a few days and
> wanted to bring it upstream since it's been sitting unassigned on
> Launchpad since February.
> 
> Hardware: AMD Picasso/Raven2 [1002:15d8], ASUS Vivo AIO V241DAP
> Kernel: 6.17.0-14-generic, Ubuntu 24.04
> 
> Problem:
> simpledrm registers on minor 0 at early boot:
> [0.404994] [drm] Initialized simpledrm 1.0.0 for simple-framebuffer.0 on minor 0
> 
> amdgpu loads ~16 seconds later and gets minor 1 since minor 0 is taken:
> [16.512693] [drm] Initialized amdgpu 3.64.0 for 0000:04:00.0 on minor 1
> 
> GDM starts, Mutter picks up card0 (simpledrm), calls drmModeAddFB,
> gets ENODEV and crashes:
> gnome-shell[1743]: Added device '/dev/dri/card0' (simpledrm) using
> atomic mode setting.
> gnome-shell[1743]: Integrated GPU /dev/dri/card0 selected as primary
> gnome-shell[1743]: Failed to ensure KMS FB ID on /dev/dri/card0:
> drmModeAddFB failed: No such device
> 
> systemd restarts GDM. Second attempt finds card1 (amdgpu) and works:
> gnome-shell[2509]: Added device '/dev/dri/card1' (amdgpu) using atomic
> mode setting.
> gnome-shell[2509]: GPU /dev/dri/card1 selected primary from builtin
> panel presence
> 
> This crash-restart cycle is the black screen on every boot.
> 
> Workaround:
> Adding this to kernel cmdline fixes it:
> initcall_blacklist=simpledrm_platform_driver_init
> 
> With simpledrm blocked, amdgpu claims card0 directly and GDM starts cleanly.
> 
> Is a handoff from simpledrm to amdgpu expected to happen on this
> hardware?

Not sure what you're asking exactly.

The fundamental issue is that control of the GPU is transferred from simpledrm to amdgpu, while gnome-shell is already using the simpledrm kernel device, which becomes unusable when the transfer of control occurs.


This is essentially https://gitlab.gnome.org/GNOME/mutter/-/issues/2909, which has some background information.

TL;DR: This is a tricky issue which isn't fully solved upstream yet.

There has been an attempt at addressing it in GDM, by ignoring simpledrm devices:

https://gitlab.gnome.org/GNOME/gdm/-/merge_requests/219

This should be part of the GDM upstream version shipped in Ubuntu 24.04, maybe it was patched out by Ubuntu or just isn't effective on your system for some reason though.

https://bugs.launchpad.net/ubuntu/+source/gdm3/+bug/2115451 is also relevant, though again presumably your system has the fix for that.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
