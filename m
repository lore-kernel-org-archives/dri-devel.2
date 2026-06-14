Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891B4CD98C5
	for <dri-devel@archiver.kernel.org>; Sun, 14 Jun 2026 13:11:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B48C310E082;
	Sun, 14 Jun 2026 13:11:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rPLxvLiG";
	dkim-atps=neutral
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA8AC10E082
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 13:11:05 +0000 (UTC)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-517b1f2c668so27805121cf.2
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 06:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781442664; x=1782047464; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=skavo0y6NZljDzpBk3mdJQvAzCJLC2KJg10+24Pw1cU=;
 b=rPLxvLiGGeZM+ARvyWM8MgaAgj8h8iGrLmRDvMXpuOiIjTChRwVbMUmJUmd9CJRcpT
 KlRCHAlYQEJ1gWal8lzP1mNG5R1rybH2bLb2Qgk6UL+Kr+WDRualrLQ0OARuWS6Bv4Cd
 3RXCxdeldpZoAu+L50Ba+YgNBoH3QUCyQnbhiaatymlaj1mmX1kCJ910e0NwjQR7jIEO
 risDaasrU9x1IFV+dds4QZsUGWE8aDI4+ZG87VbTN8AIFV464WSEW35UQtA/QiKAsQqj
 t6nsaovID6Ia6x+qkJfqx1WbnT37B7Ahu0zqxI6Yu/NPukjUVqKIm0CRqBk2Y6avo/8D
 zqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781442664; x=1782047464;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=skavo0y6NZljDzpBk3mdJQvAzCJLC2KJg10+24Pw1cU=;
 b=OSv2rMXPpWrrv+2W9cNKVJyIfPMgtd35mXvdM58F+YgcwvRXbSLYURkdCOi7fuwB++
 t2kj3P/EKhc1OP8sm2cSrDxzJyrXrjqF4KOFQcUNvxmXxBUcb6mv7zm/Qr7316OpV1ot
 VEfGyVSl1GZR2Ahv/xyx1Z/qyCV+YteyXZbh65XBC7JGKTRbpjflwkkb1Mx1sZqk6YWu
 XF3eTBurdESN6So3ZGLdm62lqkYhMhAk+1/GRfePMwcl/SDZG8I50lTIFEWPNzJ2J6+O
 WW+TKcjcnufMNCjbbvFphisDF6m2Mc9j55tT+v4GMhQK6FOlatOv3qwhjk7jABUSo7e/
 HA6A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8r+oyA2Dll49hjc7NPYTRWJeCoae1EnlnZ6j49T9Pso4GqFlyRiE/OTV1WPSJWLRVy71lUcQLEqTc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzV7pk8aTwEscO912I/kKHEfHxP8UzaSDDu6BP7rssrmvpQoGVl
 lensDQ3ceuaBlkUWVsp2V9GdmoB8EQyYlFRwgAHjLI2JC2gRjqnHjHSp
X-Gm-Gg: Acq92OFwi9g7baHco0HynsmdzVVhuVQObo/O/nJ1fzMk2UnUXOJQrr5udqbDQaWu3Yf
 C54Gum3K2a7tdT/6309SC+9chu/OGfe59s3gFek5CDWqYxjaCroN8Az8/8fssllj2zfqgjahyFP
 HgKqjeuioU3Qp1pRimuXuf7C+1hYL3OdLOs1PqrlLgU5/OuHTHKGr61B4ZVtCvPVrQsc9jscmgC
 MQrmGy3ZRIK+gvKmd5ezNCZOUPET/iR7qCFv0SdUCaYf9Gh1zCnDjHxwfVcdAf/jljq0p0hn7OL
 MjkrQnGK9DLp14zwzO70YvV5Df6qi5xBjMk2zxHt00pyIeco+NKDC87775iABAj7Vu5aBFSbbqO
 7YttjE59+j1EIyfc8qZ8QryHDtmYdDFgzYODIeXM67HC8ryKolyHgAXDku320uiBPD6ugoQYC8q
 f3U/QdHq++sIv90as70qwOz42NwvzGzyiUj+uZg3tlwDKaxglTGHV3oT6dQty1fBeLpM2gYOzEQ
 fZ+ESlsDS3OjdJRLnC0vPvwFCT9xtioF7ehYb4e8rk=
X-Received: by 2002:ac8:7c4d:0:b0:517:7e3a:5ee1 with SMTP id
 d75a77b69052e-517fe18fe18mr153439521cf.1.1781442664493; 
 Sun, 14 Jun 2026 06:11:04 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net.
 [68.48.65.54]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5196073d7fbsm25145811cf.30.2026.06.14.06.11.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 06:11:03 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Melissa Wen <mwen@igalia.com>,
	Maira Canal <mcanal@igalia.com>
Cc: Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Iago Toral Quiroga <itoral@igalia.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] drm/v3d: bound CPU-job copy-query writes to the
 destination BO
Date: Sun, 14 Jun 2026 09:10:58 -0400
Message-ID: <20260614131100.2525157-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
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

The V3D_SUBMIT_CPU COPY_TIMESTAMP_QUERY and COPY_PERFORMANCE_QUERY
extensions take a destination offset, per-query stride and query count
from userspace and consume them at job exec without checking the write
extent against the destination BO. A render-node user (DRM_RENDER_ALLOW,
no master, no capability) can drive a controlled-offset out-of-bounds
write past the BO's vmap mapping; the timestamp variant also reads each
result from an unchecked offset into the second BO.

Patch 1 validates the full write extent against the BO size before the
job is queued, using check_*_overflow() so a u32 product cannot wrap.
Patch 2 adds a KUnit reproducer the maintainer may take or drop.

Reproduced under KASAN via the KUnit over a shmem-backed BO: the trigger
faults on stock and is rejected at submit on patched; two in-bounds
controls pass on both.

Michael Bommarito (2):
  drm/v3d: validate copy-query buffer bounds against destination BO size
  drm/v3d: add KUnit reproducer for the copy-query out-of-bounds write

 drivers/gpu/drm/v3d/Kconfig                |  10 ++
 drivers/gpu/drm/v3d/v3d_copy_query_kunit.c | 172 +++++++++++++++++++++
 drivers/gpu/drm/v3d/v3d_drv.h              |   3 +
 drivers/gpu/drm/v3d/v3d_sched.c            |   4 +
 drivers/gpu/drm/v3d/v3d_submit.c           |  86 +++++++++++
 5 files changed, 275 insertions(+)
 create mode 100644 drivers/gpu/drm/v3d/v3d_copy_query_kunit.c


base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
-- 
2.53.0

