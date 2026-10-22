Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FEF606A31B
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 07:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TnLPye/L
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7B191129E2;
	Fri, 23 Oct 2026 07:29:02 +0000 (UTC)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com
 [209.85.217.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E38DC112524
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 11:48:13 +0000 (UTC)
Received: by mail-vs1-f44.google.com with SMTP id
 ada2fe7eead31-7cc365db987so1179375137.0
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 04:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792669693; x=1793274493; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wazDlZjKfyP7wNB9LE8dQu7qNqOMALjuh7zvPs0dUkU=;
 b=TnLPye/LtLt5aVfKNDFcSI8U8/LdYgNIeyjbM5WFJC90W1iFDk0+jrAhHeRjfdqaXk
 G10L+9enTJ/VVfdFdLnWvUePmyO8vXb/w4x8UUKN2LyfLkPpg+Knmj8XPyGSz1EuGqcg
 HGRwU+kv19JciT4/ciXDnzHGDD9ayrCe3rvDUT9wP2+MVKM76DqX2OhpDdT9W86YlOhJ
 MpuF6RXGBW1li5nDPwEINg/KE2pQV5im3WfF4bVMP2vQm+ZOF3JU3M7VPAUV5TvrcpJo
 o2Dj8LQFgVBPzQ4qKYb4esWcd08Ua3wEiMq2RHc9/q3sR84D6T9CWRgpbeG007HlJ5jg
 wd8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792669693; x=1793274493;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wazDlZjKfyP7wNB9LE8dQu7qNqOMALjuh7zvPs0dUkU=;
 b=P5dRM+PYRIziw/jSh5zsV6lVe17PrnZ6qEOCLJVr04zK/NLi8eEKT1qf1ovfBnFCjw
 bdQq9Vz5oCCjv3X1OSySNtg4W31LPwP+WQjx9EZO/72mV8UhDLpdkgWxzm9Ar6FyxYH0
 hk/2GHi/B9VpVw0dTlclxcPpR202fJxf+UCGN5UhfGrEuXKH5mFfVCkQIZsL2+YGk+u6
 2Pyk9d6pPEIhjBzc0z0DgP/8Vj3XLs/WV6tvRKwjl2/H5hK5qn0HR7gK93G3y8rGB4L9
 IoFfyas148taPL8liax5xuGZOxido95qrg2Ah3Bq7j9Zsj2w/fqr7uhIVf6PIDI3TRFF
 IkjQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx/nLQBKFrMqdHAWtjY23i1JOjIinl8MoSoQqLZhY6Am9sG6ZtbfsZkGpcLTE2M9gm/9HhkWB06sEE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIMTzV4GH6E8WAiggxy2Bj17Z6ZWQ1Gtr5eJq4damV7Tg8MRRnJ
 QEhQumHg2moTic8i+FPNCO80ljsvDoYBWdgiMn5/p4MLFe9GNG9CWQ1E
X-Gm-Gg: AYBFou3DlrEsudpNW40zKS+u+c+wRwKJTb7guP2F/K7zDnq91HDmb6YBV1PpP2u+Fid
 XPzFQiuOw7EJK3ysobWq/LRXZl+RjAVVTa7/PT8dPHQ7csGvFMHsTV3Mf0yRsMt730TzdvExU+U
 rJ4NOHUIZ0udAtcHO6nkY1hDw2OLa6S+6J5sEBinkQayE4LYfzjOt0eCB0br1Z0Nbgzb3zWfPUK
 QsE+4+ADT9NJTu96vwqJ0OwhDROrBIoGjjWNv/gQ5NYS6tNtdV7a+lNNk5IYwuWmWKdV13FS+uG
 koUFT7OJNjXbZujYIaE+iLSEGYnLVgrqMP6rgiAj9uCCD+rgTPBITypAuyJlcUOUxuMstlv/5/S
 pRfD40L5HQLciDueaWqQXcU6Th8N/Zpqu6uDc4+0LWXQhcukZAOaeXIeyrd+XFeJK0TKahrLNt4
 PGzIDAVCX46j8RHo1HqwwYqaYJV8lDoIUQFPYdwybnbDrzHPHvhJlKJ/igbXffB0WZKL/luYQNU
 Endx4YFkZPIJp9FysncBjfEwenQtyRwNmK0gj3MI57Mdlr8+ywwSUSagEgX/AB09DiNa3LY4yW2
 dTcmwht+tLRBLHfQ
X-Received: by 2002:a05:6102:6a83:b0:7c3:1395:a090 with SMTP id
 ada2fe7eead31-7cc925f94e2mr2135424137.6.1792669692664; 
 Thu, 22 Oct 2026 04:48:12 -0700 (PDT)
Received: from localhost.localdomain ([177.155.254.104])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-990d117c005sm6177793241.9.2026.10.22.04.48.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 04:48:12 -0700 (PDT)
From: Matheus Tagliari <mptagliari@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: Matheus Tagliari <mptagliari@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] drm/radeon: fix VCE1 encoding on SI by handling the
 VCE interrupt
Date: Thu, 22 Oct 2026 08:47:45 -0300
Message-ID: <20261022114754.865669-1-mptagliari@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 23 Oct 2026 07:28:18 +0000
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
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hardware H.264 encoding with the VCE block on SI GPUs (radeon driver)
hangs the GPU after a few dozen frames.  I hit it with the KDE Plasma
RDP server, which encodes through VAAPI, and reproduced it with a
plain "ffmpeg -vaapi_device ... -c:v h264_vaapi" test on a Radeon HD
8870M (Cape Verde).

The VCE1 code never enables the VCE trap interrupt and the SI (and
Trinity) interrupt handlers do not process it, unlike the CIK code and
amdgpu.  Patch 1 adds the handlers, patch 2 enables the interrupt.

Results on Debian 6.12.113 (see patch 2 for numbers): hang before,
none after, and 34 fps instead of ~4 fps for the workaround that avoids
the hang.  The KDE RDP server (KRDP) itself, driven by a local FreeRDP
client, now encodes on the VCE ring for several minutes (about 40
fences per second on ring 6 in the radeon_fence_emit tracepoint) with a
clean kernel log.

Two caveats:

 - I have not worked out why the missing interrupt turns into ring
   lockups instead of only added latency.  What I know is that the
   hang needs the VCE ring to wait on a hardware semaphore (disabling
   only the waiting side, or both sides, of radeon_vce_semaphore_emit()
   avoids it) and that handling the interrupt makes it go away with
   the semaphores left enabled.  If someone knows why, I would be glad
   to improve the commit message.
 - The Trinity/Richland change has not been tested on that hardware.

The series was developed and tested on Debian's 6.12.113 with the
radeon module built out of tree.  It applies cleanly on drm-next
(fad06cf), where drivers/gpu/drm/radeon builds without warnings (W=1,
allmodconfig) both after patch 1 and with the whole series.

v1: https://lore.kernel.org/r/20261021114122.94008-1-mptagliari@gmail.com

Changes in v2:
 - Patch 2: only enable VCE_SYS_INT_EN for VCE1 (family < CHIP_BONAIRE).
   vce_v1_0_start() is also reached on CIK (vce_v1_0_init() from cik.c,
   kv_dpm), where the register is at a different offset and is already
   enabled by vce_v2_0_resume(); v1 would have written the VCE1 offset
   there.  Thanks to the automated review of v1 for pointing this out.
 - Patch 1: unchanged.

Matheus Tagliari (2):
  drm/radeon: process the VCE interrupt on SI and Trinity
  drm/radeon/vce1: enable the VCE trap interrupt

 drivers/gpu/drm/radeon/evergreen.c | 14 ++++++++++++++
 drivers/gpu/drm/radeon/si.c        | 14 ++++++++++++++
 drivers/gpu/drm/radeon/sid.h       |  2 ++
 drivers/gpu/drm/radeon/vce_v1_0.c  |  9 +++++++++
 4 files changed, 39 insertions(+)


base-commit: fad06cfaf385787b9ffa2f73f049d42dbe1de57f
-- 
2.47.3

