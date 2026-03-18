Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF961077611
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 19:50:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EDE610E7B0;
	Wed, 18 Mar 2026 19:50:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M//l2vJp";
	dkim-atps=neutral
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5335310E03E
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 10:19:18 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-b97e5956208so166018266b.2
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 03:19:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773829156; cv=none;
 d=google.com; s=arc-20240605;
 b=htet42HXE81BP3srJJi3imMrUt7zEegLlr8YiiUBGs08LmYcEBTtKlRaDa+oZG8UG/
 miTJI5YziWo58VEVZfMAZ3gqcc+gUa3MB9rzxy+zr8jfl/hoGfn6Sb1S1lhaZbb1DQsD
 dhBZlIH1SEhdpUXcn+67SK5ukZAd+cH/VvVN4uOT/RPlpn7j7nakmkjPrVAy+5fVNtl2
 RumLkdtnF+HXTyRNQfy1MsJfP5/yZwbz52sXcFPcuDfhTluHeQSYwXh7K7rfFRAEUO/9
 0wAi9b3jQNwouywrwJl+x8malCfEABWmYgM4YmK+zZBK9y8psglSlguuD8MbqmfMBymp
 e6Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=kVTTafEsEhZmGYQANAe1QvE83H6Mzq2McTNP/J0kkXo=;
 fh=Mu/I29PrmJTlJfALwwV+pFIv/JY5qWzwDOI+4mz1Q5g=;
 b=lh93wSRQMu1Ra/LDvaXk0GaLeh+LFLfAMWvUNEdf8068z8l3hi4LMqtKrrg6dq1Ew1
 f3BfXvuvieOVvs/6yIODI9yEyXf3On8GBtMguFZhgLRVs7HpefwB1zu/JyvvcZ/i6Ckx
 aJy6Qk6JvtOhuyd2FsJg8Bw50z28wQKGoyh2+nq+IgJb2jkafoqPrPMg+VDjEo3CerNe
 eahsOKMmP7x/BKR4m99kwgYkYm2uyJyuAqb8cMmQwVF1PmbfJgU4ChHYFN1SZxDFwW8p
 5sxQGX5agX260ptyG5Y5SVtXLW2zGma3J2AA0Q5s333dvu29W18LeXO7CzfPpkf0omLv
 ovVw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773829156; x=1774433956; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=kVTTafEsEhZmGYQANAe1QvE83H6Mzq2McTNP/J0kkXo=;
 b=M//l2vJps95jF5nrPNhW/7e8NBtCzMzD1vRQU27eS6kMef1fIgpXV/4AZcXeBd/Ql3
 pVAoZAW5UPMfK6N2YkdUjJxpVIKxFP0zHbugt33wTSsfHNGTYdhhMOvSNEVCN/AWMZi1
 PQd5f34euK4rVOIfCHiaFCxUiaytj0onngV6VMxIPPBFBVvfteSTaTYiWSHVn0ugpgsu
 XwUlg4H5yXrADNjwkpMDfoEJ/8YIPWijI8Tm1xEtjKQqglKOTsybNaftBQ0lTgIIIx60
 Osp5Ot/W4P4QXfGMp6dNesANDQ38gDBhEibxWBjpj4s6epqqC0ordca0PNo7INTQfVOA
 H3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773829156; x=1774433956;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kVTTafEsEhZmGYQANAe1QvE83H6Mzq2McTNP/J0kkXo=;
 b=lGjmtIj0l4oRpML1T/HFN0RiEBTrFIYk3Gqrpi2HsjwFGUcbxaHztVvPINzE5Edw8j
 45aWxUtEZqdaov/wSGw9ruCm48akeMWu84cRmpJWUrUSeXFrAJ025Og4rAwtmU4+Vr/Q
 YFevdDobKz0kVmhSRbOgTGarqupDmayWt1QxuhF8MB9E3mHczx4ejL+MuiXW7F2BK1yY
 g7SuMZc0y2a9ZgiPpiem9Fe9qRHwWYk96Ppi0kNZIQiydnwLPrwAVjfG1DkNfISHE//3
 64rt2vizSb06NKjbqsbwkXT8aj36ayaLRJvXjOhpoANTSstFQ1wi9qRpG44VVgSbMf8K
 6Qhg==
X-Gm-Message-State: AOJu0YyceZ4BN4tQBAw7xxuSCs2xFsEFGxBqnVAE7rb645xjW9YByUtu
 nhDgYV5AiYty6tzM4Ffg1UP3QOARXuEUUsbIZq2QM0x7FHe3gQXxtmUeFVRCJJ/c0eXP5UidIs3
 XeTS4zjLoAd0W0xlT3Sq2RDj6d/Yi2M0=
X-Gm-Gg: ATEYQzw30Dug8G9h9D44lB48c4bEgrZFC3UdGpu4mKURRH3AnrbnlbBhNrCveG6OTGa
 wkd4VdU4uABhfesA4E0r3Z1j/dBB5Cs3AuPZn2OMAZXwQnrYWpVOKU2eG3Gim7wgJ9AmnRcdyEq
 6FIbG9fjF3Q1C4Cw1cSCwmrfi5C/K12nFiFt95v7oRPG7swLkIN4Im8s3pmmLBZwqJkLSIHTkNe
 IYKGJBiEOwzj0f98hx/P7f02pNIkmQDcMQ1YI4E2VkbKAynA3lRxGzXSIkd5/S2ibk38/OpkzmG
 /VkEVwtVv/XVb2/l2ybFA3bNbHKexi/e7d8SeDvB7Q==
X-Received: by 2002:a17:907:9608:b0:b8f:a5c8:f75 with SMTP id
 a640c23a62f3a-b97f4a1a0fbmr158058966b.52.1773829156239; Wed, 18 Mar 2026
 03:19:16 -0700 (PDT)
MIME-Version: 1.0
From: Jill Ravaliya <jillravaliya@gmail.com>
Date: Wed, 18 Mar 2026 15:49:04 +0530
X-Gm-Features: AaiRm51GtZc6vbl_5uNX_VZcRjDfd8nA4m5QvvEUolTfsVTQ6LKDjtdrX3ZT5VU
Message-ID: <CAHr0PbtxGWQdv1iOU5XDmoWND+GCzxvnerJHhkcd2aDp0pUwNg@mail.gmail.com>
Subject: drm/simpledrm: no handoff to amdgpu on Picasso/Raven2
To: tzimmermann@suse.de, javierm@redhat.com
Cc: dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 18 Mar 2026 19:50:21 +0000
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

Hi,

I've been debugging a boot issue on my machine for a few days and
wanted to bring it upstream since it's been sitting unassigned on
Launchpad since February.

Hardware: AMD Picasso/Raven2 [1002:15d8], ASUS Vivo AIO V241DAP
Kernel: 6.17.0-14-generic, Ubuntu 24.04

Problem:
simpledrm registers on minor 0 at early boot:
[0.404994] [drm] Initialized simpledrm 1.0.0 for simple-framebuffer.0 on minor 0

amdgpu loads ~16 seconds later and gets minor 1 since minor 0 is taken:
[16.512693] [drm] Initialized amdgpu 3.64.0 for 0000:04:00.0 on minor 1

GDM starts, Mutter picks up card0 (simpledrm), calls drmModeAddFB,
gets ENODEV and crashes:
gnome-shell[1743]: Added device '/dev/dri/card0' (simpledrm) using
atomic mode setting.
gnome-shell[1743]: Integrated GPU /dev/dri/card0 selected as primary
gnome-shell[1743]: Failed to ensure KMS FB ID on /dev/dri/card0:
drmModeAddFB failed: No such device

systemd restarts GDM. Second attempt finds card1 (amdgpu) and works:
gnome-shell[2509]: Added device '/dev/dri/card1' (amdgpu) using atomic
mode setting.
gnome-shell[2509]: GPU /dev/dri/card1 selected primary from builtin
panel presence

This crash-restart cycle is the black screen on every boot.

Workaround:
Adding this to kernel cmdline fixes it:
initcall_blacklist=simpledrm_platform_driver_init

With simpledrm blocked, amdgpu claims card0 directly and GDM starts cleanly.

Is a handoff from simpledrm to amdgpu expected to happen on this
hardware? I couldn't find any takeover messages in dmesg.

Full logs and investigation:
https://github.com/jillravaliya/amdgpu-simpledrm-handoff-bug
Launchpad: https://bugs.launchpad.net/ubuntu/+bug/2142087

Thanks
Jill Ravaliya
