Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82CD4F45A0F
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 21:49:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC10710E9D2;
	Fri, 10 Apr 2026 21:49:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dpn8yBjn";
	dkim-atps=neutral
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com
 [209.85.219.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DF8110E9D2
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 21:49:45 +0000 (UTC)
Received: by mail-qv1-f51.google.com with SMTP id
 6a1803df08f44-8a00566c11bso31817176d6.2
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 14:49:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775857784; cv=none;
 d=google.com; s=arc-20240605;
 b=ZpLNbuORyAGCzlyJ2N6cl1DZur5R5oQ2P4nNIa4QxRT3v/twZ1sVaFT9znKStQQhLL
 TPwdqeG39akv/lKNF3H7bhLdH7wMd0cxgACgeUyzpuAQf9Oxcbc2cr3TkR5k7qY8V2YQ
 6hXQx+OjyBp1C/kE2nGr2UQLNq9Q3G9pYmWpzBZQ1DSIkerXrXgc4lgnu6UOfqW3hPgE
 yEIS9XIfoaJlKpyUkW3UBvyHk4UD3Rn/zSSgY2gyqEXwWGUdBVzbJOLT+nM0zsOxsZOD
 ZzkePriRCAW68ykmThBHxayrMIp3J39UQNisp3Zussr4Nyqcn0LMo4GKWaDIthA73XzF
 qfdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=6QSsb24FSsaq09RhjEXh2VhN+gzpCqfc18wY1FqcLMA=;
 fh=PV58MO8QeVri7HbJhOkp2d7UIR8WWFOiJ6Jn8OyHO9k=;
 b=T9+S3HD4lS018GHAgtGUO/CLhdfh4WrJhWschSd6+v41FgR6pMzVDNzxtbZk/EJswG
 +vTGNutoOyUjy36LYIIsfJP7iXWLWTXOe8US7s2L5FJMh94DQI+N2vOwCvmqL8hmrYNe
 T8VW0KHVSI+YURqbxooL0kOTqGLSSe7s2IDLxmsIhjdvsaAWvycWZb6uWKgNlfHQ/O2E
 9qkU0OYmA+rTV2dq2ZHjDmRsorP4Rj0igb94BzhKyjdi7j7T+518ZTn1ZLSXcMNMMunF
 hw9cjWrDNlZMNj+W9mlLUqyDQEt7GIV3n0Og4v4nwudGzO2wYXTvU0FId3Y1LvW3hynM
 JlsA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775857784; x=1776462584; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6QSsb24FSsaq09RhjEXh2VhN+gzpCqfc18wY1FqcLMA=;
 b=dpn8yBjnafnqLU+FNdA0hKx20fzyWSv0AWztXInjB3lzeuKdATdK//yfch6uhJ85pv
 B7VNYJ188xCwDF++/x4AmAcuxZujmtAHEV+K6cKE5rbSTzfoBMf/Vgq0MVTx4jt9Nkf1
 zDtyEQKq15dhlZwwpoeS9mntUADSKSHWbhpQF14dGWRDhzgKVheP3m2orCRnviipWL0W
 Q7QwLBBHGqps8im1aefIC+1BunXNyij4Q0LhF9nMRo6rRQZRi1NqZaSzx2E4RvjCgn7Z
 NObIKaXBsrH3pX74anVSkOYtZO+eeWpj8pJdMXBnIPFxSKtqT0HbzLUY2/8Pko1c2IDV
 yyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775857784; x=1776462584;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6QSsb24FSsaq09RhjEXh2VhN+gzpCqfc18wY1FqcLMA=;
 b=ZtBeT1btifbqn63yG5M2osTszDYERf9NQO4JrkCqeBlvv32venzpp4EqcFAaXUL8PW
 c4drsVpYHLWI2xI9e8VF+xhih1qhXPli7/2Qt+9ks6rJIol1ELWZjyHR2XnOaJF5yo5I
 gvyTMFgjKWiRXhC8ns+esos/GetfNzl9maioRGEbezC6eTfWClgesqehLOgiGW/hedhE
 gfh6a9MGZLOe/WckaYv+t6OF6YQ8dQnaFpvZMCVgTFWnqDtozRX+uFUlrgNbeU00KUyI
 r3LNT6cvAWLXjxhgByklYOYOJoAztUyXWJaZV8sK4q96UUHcbiXf0QqTnbhwAEVM9vgl
 +cHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDg9rzFURq58fxsUjH8YpM0x2y8bVVOXUL8sm/sO7Zi3T64JYC0OExVsuteuaUX8Y/Bbm0F4mgM+I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwCBaFE/qHlJelsYzv5gQprsd1R/fduQP656tGCNI58SrovlDOF
 6JL7MPX4H28d223xBYK9NszM6821swhKKhDhdedX912NP04VP2ZnTmev7fADdimJtM4djx0ziNP
 kslto1VtnC5qNMW/9QNNLtl3V1htUScQ=
X-Gm-Gg: AeBDievsAnzoQjQeZTBNeRmworUrcCyHHa/U5NGDkYXTMoMEMNKaiiMyh9H/rCxMNQ+
 vUG9ZNAzzf5QuSpKXJsbIYjcbajHEYd4U8mSDiVkWS06co3+y7e/BusxmLiix95hghLK6bs9cYp
 H/d11FgzyKLlgSF3pIi5MwQiCmD5EgfAgfIUgtv0g5E1/Dw+zbYOoqLsp1eTZctjKF+MqDfhzK3
 XI5OQEvpvSuPr8jvSBu3srRUQcCITt/XQFLbAKRVaXoD6KO64CQbmINpG2Ve/0qSA1P58VLjYc6
 yQTqH36wKB4W+jzujhvdpTBO8Mw+Y5v6JR540fcTTQv8oWSu/WUSo0KgeZhpk/8Y5Hs=
X-Received: by 2002:a05:6214:3a89:b0:89a:14be:4593 with SMTP id
 6a1803df08f44-8ac862a4732mr72045286d6.35.1775857784020; Fri, 10 Apr 2026
 14:49:44 -0700 (PDT)
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 11 Apr 2026 07:49:32 +1000
X-Gm-Features: AQROBzDMP1Vycgoy_ieVyvpjVCxODWUxqfWB_-B7kfN5h0mgKwEgfR_CAFZXwPE
Message-ID: <CAPM=9txY3LS3UxiixDHoWkdiyM7N=mHoEAGXr3TSWeqt-zUYhg@mail.gmail.com>
Subject: [git pull] drm fixes for 7.0 final
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Simona Vetter <simona@ffwll.ch>
Cc: LKML <linux-kernel@vger.kernel.org>, 
 dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

HI Linus,

Last set of fixes, a few vc4, and i915, one xe and one ethosu Kconfig fix.

The i915 fix for the vma fix that is already in the tree, is in here
and well documented.

Dave.

drm-fixes-2026-04-11:
drm fixes for 7.0 final

xe:
- Fix HW engine idleness unit conversion

i915:
- Drop check for changed VM in EXECBUF
- Fix refcount underflow race in intel_engine_park_heartbeat
- Do not use pipe_src as borders for SU area in PSR

vc4:
- runtime pm reference fix
- memory leak fixes
- locking fix

ethosu:
- make ARM only
The following changes since commit 591cd656a1bf5ea94a222af5ef2ee76df029c1d2=
:

  Linux 7.0-rc7 (2026-04-05 15:26:23 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-04-11

for you to fetch changes up to b3be33f2c18f7e3663d103a92cdd00b4771b4aa7:

  Merge tag 'drm-intel-fixes-2026-04-09' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
(2026-04-11 07:35:22 +1000)

----------------------------------------------------------------
drm fixes for 7.0 final

xe:
- Fix HW engine idleness unit conversion

i915:
- Drop check for changed VM in EXECBUF
- Fix refcount underflow race in intel_engine_park_heartbeat
- Do not use pipe_src as borders for SU area in PSR

vc4:
- runtime pm reference fix
- memory leak fixes
- locking fix

ethosu:
- make ARM only

----------------------------------------------------------------
Dave Airlie (3):
      Merge tag 'drm-xe-fixes-2026-04-08' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
      Merge tag 'drm-misc-fixes-2026-04-09' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'drm-intel-fixes-2026-04-09' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes

Jean Delvare (1):
      accel: ethosu: Add hardware dependency hint

Joonas Lahtinen (1):
      drm/i915/gem: Drop check for changed VM in EXECBUF

Jouni H=C3=B6gander (1):
      drm/i915/psr: Do not use pipe_src as borders for SU area

Ma=C3=ADra Canal (4):
      drm/vc4: Release runtime PM reference after binding V3D
      drm/vc4: Fix memory leak of BO array in hang state
      drm/vc4: Fix a memory leak in hang state error path
      drm/vc4: Protect madv read in vc4_gem_object_mmap() with madv_lock

Sebastian Brzezinka (1):
      drm/i915/gt: fix refcount underflow in intel_engine_park_heartbeat

Vinay Belgaumkar (1):
      drm/xe: Fix bug in idledly unit conversion

 drivers/accel/ethosu/Kconfig                     |  1 +
 drivers/gpu/drm/i915/display/intel_psr.c         | 30 +++++++++++++++-----=
----
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c   |  2 +-
 drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c | 26 +++++++++++++-------
 drivers/gpu/drm/vc4/vc4_bo.c                     |  3 +++
 drivers/gpu/drm/vc4/vc4_gem.c                    | 19 ++++++++-------
 drivers/gpu/drm/vc4/vc4_v3d.c                    |  1 +
 drivers/gpu/drm/xe/xe_hw_engine.c                |  3 +--
 8 files changed, 55 insertions(+), 30 deletions(-)
