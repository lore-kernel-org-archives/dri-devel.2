Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ADB21099B35
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 19:12:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA25310EA6D;
	Fri, 20 Mar 2026 19:12:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OfgsdMY6";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A7B210EA6D
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 19:12:20 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2b04b4974abso21442115ad.1
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 12:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774033940; x=1774638740; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xUIIgLsCX99WQc0DzamnNAGrsGlCiZNosqsgUhoMCCs=;
 b=OfgsdMY6W6yBhcArlnUMekps4q220NXE1UPgQHVbiywykFOZGokTpm/dknNicq3k1r
 MZAEgB6EOj78bsn3wVeXTMMq0fbYgMV7hYyGIIF17Kj29O1rv58mB74Z1r1uio2ByzQn
 kUIO6Nta79jwYoBW7yk97m0Al5EiauIi8ycy99mhlfqcir1YFABflDBYDubHCndj3Bzw
 UPwgWErSfLanZKPN3sMcr01zU9PqPUvVK5GqIQsLmgs8RDvZwrpjsybCZV+VFmQNZbeq
 4jK4DdzFApzeWuuxbPKOOD2q588gPjTmvMOeR+NiBmY0DNHSv9Y4Yo7YYEp4hWGHgYCi
 Yzew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774033940; x=1774638740;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xUIIgLsCX99WQc0DzamnNAGrsGlCiZNosqsgUhoMCCs=;
 b=mBLJLdfEVtHuSxURT59dMOOsDXbmVofwSvsgpBpBaoGT7IwFHNswoj+OyjyDhfwEXv
 OAuS/4CPwvyWBNuurrXQVvq4AYLjfzmSTTy38e1DooAoN0u+/ZzPiUSO/gom/mUMH9I+
 gC1s4EeGJcmG6nuP6mXr1smjFlXTouC4yyhIv1c7HcfJBonN7rAh0VIQwZFuTrHTQGgo
 cpJggvMiucLkbf7fR9XbneoEGsyTyILy+JVodbmJ/ehyXTr0FFXMb3C1zO4y1lMQ2yHg
 Sazi0ooCwcoGgGlytFVIJw7f47X+lHWCC+q+UsqE6DCXRkGyaAFdyNp7ViU+GIRnqQpa
 6eFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcoP6zAt0REFAenWnZARj0ghhk95iuuZNAddSx4v0cjJh1doISaOwb36ZDoj2iq67HqDTOs6BwbSM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyAB0H3P4flOHaRoT6JhR7q9wjseeEuAJtOEGbyx2WVutxd/yFN
 SP1GZkhJBq67h2T7mjs136rsZTUhhlpuSUIDFjpBAnuvYo9+fj06AUvw
X-Gm-Gg: ATEYQzx3/uZkNyVjgrrkK5CErSBS7t9MtZAysXzPVSw6TtT33evSHbeOU95zPy3px73
 j5MZRtt8XIxD/vwT7ghAxqVkMt23jH5QdCZUpEtqAhfOCeY9yln+vxd6vXZEM684R+5Nv2A9QL0
 x4OssOB5ZyJ/Yj/URkxneKPb5es6k7RsAhZxN2cIVtfleDJ1vZK7jXvRC2fsgu/95CdwGSo9fbQ
 HnOqiMVaTsY7BMVvgcMEA4K27NjsYs40Ir1a6gxAJdNH3HOLQ6JyrRNwIQSKJ8/wZYMHcjhflCw
 SIkY7Xutwq638aw2n6KR13G/yBEeQN4TYCfHg8pzeKaTPnxFEpMoXF6T1x0ruwS9vFkz8Em768K
 97AaNLpRHGGJSD735Qk2ArAAGRSYL7oK7ZfLoDK4ua1UesNgG0t4G3f/hR1hkUu3vf1EBQiIM2c
 9P5odygku/tSWaQ5bbIoR+Xkjp31wvI0PjAixB
X-Received: by 2002:a17:902:cf06:b0:2ae:7efb:6068 with SMTP id
 d9443c01a7336-2b0826d6f8fmr37075695ad.7.1774033939936; 
 Fri, 20 Mar 2026 12:12:19 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.167.147.240])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b083688ca4sm39599915ad.67.2026.03.20.12.12.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 12:12:19 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Subject: [PATCH 0/2] drm/bridge: th1520-dw-hdmi: Two fixes
Date: Sat, 21 Mar 2026 03:12:09 +0800
Message-Id: <20260321-th1520-v1-0-ec877197770d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAmcvWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYyND3ZIMQ1MjA900E2MjM0Nji2TLpDQloOKCotS0zAqwQdGxtbUAiEu
 i51gAAAA=
X-Change-ID: 20260321-th1520-f4326138c9bf
To: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Icenowy Zheng <uwu@icenowy.me>
Cc: linux-riscv@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774033935; l=465;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=1t/7y9mVrx6E4KfyOJWL4pNY3X3iSbND0yHpmonIxX4=;
 b=UJhpD7PbJUjEzKm0lysNNBWIO0bTNKDAkim1dWlVkVTfKRUk4hRSViEiSMgKYaEcRzZfb3zIn
 UjNGG/d3mw+DFYvYr4agLP3RdKYyLLF81DwUqB9zBUEhn1BHIXYHqGj
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=
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

Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
Felix Gu (2):
      drm/bridge: th1520-dw-hdmi: Fix error check on dw_hdmi_probe() return value
      drm/bridge: th1520-dw-hdmi: Fix remove() callback

 drivers/gpu/drm/bridge/th1520-dw-hdmi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
---
base-commit: b5d083a3ed1e2798396d5e491432e887da8d4a06
change-id: 20260321-th1520-f4326138c9bf

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

