Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F12E606A327
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XKs3V54q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CE54112131;
	Thu, 26 Nov 2026 08:11:10 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE6CA10E8F0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 14:23:46 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-8b9c51097e2so2252132b3a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 06:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795616626; x=1796221426; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QLpPl7baMKQWoRUzD0T9VbRlCTvpU8BbJZCKDFjhuus=;
 b=XKs3V54q6Zofe4ArWEJBf2QZqvXeKgdKmGqB0kRgsIY0Gq1NJzhRqFLy3nMpTCpdh7
 oSlv6LpI5OqCrcnYfhL8hZZWNBge6k57+zHotaiR9ItjmZ0RdB+zL+EVKSMiODxfgxJY
 nPqAitCNojodX0Zv2xLnGFeL0AdUk+Zl/4mSHo0zRM28p90NHKJV9oLKmJFqhlNBOtPq
 a7Ak4Y2Z35upMEzBO9jA2xTUZLJ569QjIf8P0Uj6ffthk8njUERmzfqM6qPPEfpZTFfw
 USelVm8PNSNpwGyENGQ6USm6VuqYu61duji66fotHcqdThOJbPbddXPxk/0uPmXIEnxB
 UkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795616626; x=1796221426;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QLpPl7baMKQWoRUzD0T9VbRlCTvpU8BbJZCKDFjhuus=;
 b=1EqBqG5XFGH+Uhi9M9Aqa8fP8GH4pw2lmrTbm/b0nG58j80JBSgzgaz/DKXnhsTKhj
 zCfh/bJjywdu1HOHtXCc0vg4FI6Rhf34CedHLnHUmTjCl9AJTt7CHoRG9/74WOtmLvoU
 0Au60QfegOL/bE0C1qA1zirC6zKvn7R2mOxjwJJ6BxRvJjCDnKzqeV36MqkVB0uHzkwP
 3yP24RR40NvpGLWQGA/i7uONquHdO5KVsQJ1tkkBtxebwhaL5uLe0OteYl4g02wFUGw7
 9dlchTgWsit7mv3nZOuJHVwbRgz/GW9tFutuY4rjAU4vIwviAT4RPPPzV/O4IlJD0FyE
 2MMQ==
X-Gm-Message-State: APuU4Z8biqAZHanAPdmfUNpT8YlVtgdP8x7pC7c8IKYqpJhmH7yg67T7
 3a3E/OfEfHt1F5Tf85UZ2DnQTqCakwhjHh1HMTQd8Ae6/sNF6SauWVj39xxfQg4P
X-Gm-Gg: AZFdTZcpCoGEjBAIw1pTMOEV/lXuBNQSzoHp3ucg6PT86N/63eaXx5eic82LsMfXGHo
 W9Jf9JGHe9rpY6JD4QF0JsEJt/VfqJaW3mReKNBvgYPBz/FSPYYV29LYF9zfPPaivUqSC8Mk9SY
 nOzQKZ9hjstE7zhy5ANYVvcQqjV88V8qplpd1Eqoa5TfqWfSxfzUatnOXvfTtkyPqn/ooteGxkR
 VgjNEcWRi8L8I11J9gyRVpobnXqCqp9qdz0X0xI6m1Y3XPmEmejHIsBNnRB7bldKpvThoMGG+Iw
 ASvNrRAjIRoipE8zf6BTChOSVkxhhMrnqhMwChprjvwdPradi5HVnp7jyIMnWq1ByRF0LJxE7l5
 H7EBW3UCyg9kM6L4ETrbJLaEK7NjV2uY1jOIY47mbZ/Dc+YiuQDBHlLF1HILOxjPE1kwAgeOPys
 5bwm+S0h0Le2JTZjB9PYKKrANAPIQFPWgevh6zJTQ0NfVEDH5k09UBGH/sNapAEucG5vz4FDUbh
 xAdjmON9f5+ENzVG0+icIOUIx99Zo6IoAvA822LiUQm8vOLwlUo7EyiUEpd9lwviXzlSngk5xc1
 ZuSa+dRuWYQKXvRJf01zSmvgRI//MJ6scgEwgwr7vw==
X-Received: by 2002:a05:6a00:238b:b0:89f:521:8089 with SMTP id
 d2e1a72fcca58-8c87bcbcfebmr16278448b3a.19.1795616626383; 
 Wed, 25 Nov 2026 06:23:46 -0800 (PST)
Received: from a-VirtualBox ([168.188.125.88])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c872e45eccsm9115841b3a.31.2026.11.25.06.23.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 06:23:45 -0800 (PST)
From: Minseo Park <hiyoukou@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: alain.volmat@foss.st.com, rgallaispou@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, benjamin.gaignard@linaro.org,
 Minseo Park <hiyoukou@gmail.com>
Subject: [PATCH 0/3] drm/sti: move commit work out of .atomic_check()
Date: Wed, 25 Nov 2026 23:23:27 +0900
Message-ID: <20261125142330.15298-1-hiyoukou@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 26 Nov 2026 08:08:59 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The three plane .atomic_check() implementations in drivers/gpu/drm/sti
do work that belongs in the commit phase.  The cursor frees and
reallocates its pixmap, the GDP reparents and reclocks the pixel clock,
and the HQVDP boots its coprocessor and registers a VTG notifier.

DRM_MODE_ATOMIC_TEST_ONLY runs drm_atomic_check_only(), which calls the
plane .atomic_check() hooks and returns without ever calling
.atomic_update(), and a commit that fails a check on any other object is
dropped the same way.  Either path leaves the hardware changed by a
configuration that was never applied.

The cursor is the worst of the three.  The buffer it frees is the one
CUR_PML points at, so the display engine keeps reading it after it has
gone back to the DMA pool.

I do not have STiH4xx hardware, so this comes from reading the code
rather than from an observed failure.  The series builds warning free
with W=1 and COMPILE_TEST on x86_64.  Testing on a real board would be
appreciated.

Minseo Park (3):
  drm/sti: cursor: do not resize the pixmap from .atomic_check()
  drm/sti: gdp: set the pixel clock from .atomic_update()
  drm/sti: hqvdp: start the XP70 from .atomic_update()

 drivers/gpu/drm/sti/sti_cursor.c | 65 ++++++++++++++------------------
 drivers/gpu/drm/sti/sti_gdp.c    | 52 ++++++++++++-------------
 drivers/gpu/drm/sti/sti_hqvdp.c  | 43 +++++++++++----------
 3 files changed, 74 insertions(+), 86 deletions(-)


base-commit: 4dce97c6c265544342e716e62fd24bbb232590c5
-- 
2.43.0

