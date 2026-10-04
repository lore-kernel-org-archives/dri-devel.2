Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A454CA5FF0
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 16:47:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59C8310EA9E;
	Sun,  4 Oct 2026 16:47:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=furiosa.ai header.i=@furiosa.ai header.b="SKic81Gt";
	dkim-atps=neutral
Received: from mail-pj2-f0.google.com (mail-pj2-f0.google.com [74.125.227.128])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 646F210EA9E
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 16:47:55 +0000 (UTC)
Received: by mail-pj2-f0.google.com with SMTP id
 98e67ed59e1d1-3a476ee8669so339607a91.0
 for <dri-devel@lists.freedesktop.org>; Sun, 04 Oct 2026 09:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=furiosa.ai; s=google; t=1791132475; x=1791737275; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MplwpeuSIBeXa4kTMHRjBXSdtpzWWqZO04EAnu2iID0=;
 b=SKic81GtNnOU2Se+CJIheH6U1Yojm9M5vtcTofNIjIIyO2R3vDtfHvkSN/HP9IUkvu
 ykyXldJJFKnIWNAgwfnN/D2bGGxJaMBui0oM3KeAP7ja7xwsTrTCT07XEprdrZ+LPx2j
 64J4+s0E9D+nJMRVv4pBpjjI1g0ilQ6/y4lEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791132475; x=1791737275;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MplwpeuSIBeXa4kTMHRjBXSdtpzWWqZO04EAnu2iID0=;
 b=pOHxBc9YLLV/JmBqwbdxKQFvcQ3b/5sHqklKGdJCD6McmZJ2hEosrvHjs6NsgwpEnO
 KAKnKpKVHaySvlLdcPKWzav63sUfmfmp8RJ9YnlScnJcdci17iI2ty9uoX2f6qoJGJKT
 3YqERn2pMGBgFe3JzkGEr91fEPE39ht2ldGQpwa31XK+4k1loJvZO7YM+lke2g+9kLS9
 klYcqGEqWnLJWh6DBgV8h5eHuO/B3lVc55DYoCsFLtuHZyieRsZi7Riv8x56Dds480Ij
 fJSuq78o76HCK6XJcWcq4QrOY370F3ltdA6mu2yjfWPHLRrQBxC4H6s96FfG+A+2wR9B
 01CA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxj2uLp3frjWrb3+2GCZk9QKw1YVG4T20e6u9vv2dVEz4cL+iHLfP3ttyVRb6wBES43loXYzekl8xU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL2jx6w3cj3lRb7tJUIueqV/ZiSujwgegKR1qMjCbaQSua3G7mS
 xMtsdbkE6SUBvmTunpf/8IMLscGMxxYN+aE79RyJpKZyxriGO1tQY/vAIFDXFNn9ZWE=
X-Gm-Gg: AYBFou0m6tCs+1FgaAZZlCIVcleTfm2cxJZHNxedb0IJb33+KFSwxIHV/wa6RvTfNX9
 xkqbluvcv2Y2lr8GGdNZcEwCGeZUyLKOwg4p9e8yorF3RnURtgrD+vEWtz7P4xhXm3iaIH+glbc
 3hZ5E5xJV6kagk7CfiyI2tYRELptQEAjeFTSMYzj4lX+qDPXLS6YelYqCcnvBx/+xLJxu/4To3P
 LkeF6bAV7wWpeCqDFKONHtv6lKYTIvGmNuAOB1ILrK2eLx4Q5f6kvHZBkNt6utPqAOsg3IqwsIp
 x/ozNQn9w9AN9bSSOO/diWnrOlC+aRlxQTTQ0GrV5HSn18VwaOWhO/9HfsSoK75zWvOsE1BQsaC
 PEvae4mFUpTvwoxZCNAhUy0oiFKFtxzCEgdbSvb2PBVxBA4Tu6M5XAIYPOgzkgiYQq8JhYEQPon
 YsKSWvlXa9O4VB7UIXZuuocIEcq1GSOheZNkZF1ZImI0eF3IDOoWkBeng1ZsoQ22uDfn0bfbHp
X-Received: by 2002:a17:90b:164b:b0:3a4:9859:9749 with SMTP id
 98e67ed59e1d1-3a7873dcbc8mr4126659a91.38.1791132474877; 
 Sun, 04 Oct 2026 09:47:54 -0700 (PDT)
Received: from rock-5b-plus ([61.83.209.48]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a6dd0cd76bsm6500454a91.2.2026.10.04.09.47.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 09:47:54 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Sidong Yang <sidong.yang@furiosa.ai>
Subject: [PATCH v2 0/3] accel/rocket: Validate task regcmd fields
Date: Mon,  5 Oct 2026 01:47:24 +0900
Message-ID: <20261004164727.466164-1-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
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

Patch 3 rejects misaligned regcmd addresses and out-of-range regcmd
counts at submission. It is unchanged from v1.

Patches 1 and 2 fix two pre-existing issues from Sashiko's review of
v1. Of its other findings, the ignored submit error [1], the
iommu_group leak [2] and the unchecked allocation in rocket_job_open()
[3] are handled by patches already on the list. Until [1] lands, a job
that patch 3 rejects is dropped, but the ioctl still returns 0. The
__u32 regcmd cannot truncate an IOVA, as the rockchip IOMMU aperture is
32-bit.

Tested on RK3588 (ROCK 5B+): Teflon MobileNet v1 output and latency are
unchanged, the bad regcmd values are rejected, and an injected
drm_sched_init() failure fails probe cleanly.

Changes in v2:
- Add patches 1 and 2.
- Rebase onto drm-misc-next.

v1: https://lore.kernel.org/r/20260711062137.36044-1-sidong.yang@furiosa.ai/

[1] https://lore.kernel.org/r/20260828064152.37822-4-Naixumogu@whut.edu.cn/
[2] https://lore.kernel.org/r/20260610071045.3414828-2-zhaojinming@uniontech.com/
[3] https://lore.kernel.org/r/20260818041505.1579320-1-triet.hoang.dev@gmail.com/

Sidong Yang (3):
  accel/rocket: Don't tear down the scheduler when drm_sched_init()
    fails
  accel/rocket: Use an unsigned index to copy the job's tasks
  accel/rocket: Validate task regcmd address and count on submission

 drivers/accel/rocket/rocket_job.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)


base-commit: 70456f05d4b6396b22048c4b8cd3cb98ecf9f9e3
-- 
2.53.0

