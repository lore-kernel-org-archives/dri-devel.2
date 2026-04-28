Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4538FF8868
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 14:47:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 142CC10E0D5;
	Tue, 28 Apr 2026 14:47:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="z872g9Zm";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BD3610E0D5
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 14:47:17 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-446fea16729so478988f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 07:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777387635; x=1777992435;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ctIsKyjLGAxorg+U+rmNLCdOJMyrX/ml0WoUktvYWis=;
 b=z872g9Zmd0iwVJxrJUmAvMdLRsNPyv3kwDa06ZmW+NgTaLAoQ/Ae+VmOOVhTCulaHZ
 3D3u9l4Eqckq3qvbx5Jldy8UjiGoLUnzQn8808PO2SrN6eO/+/wHMljzvAwKUaGCr2dB
 lVJCC6R2yn49vx3KA6Y9SGyghpxMk9kRywkuMj5jpUBiZxOc31+L51f4JT3ZrWQ1zrpk
 2vAJRsbefNumXCbpJN97WyDwNxTBTZYiC7wQihtVi1n+lwAKfeWje5WzlUxv67L9nGat
 Y+lpechD02o23xr8hXJtb/JPeR2u2NY4kHj7htHUF5nrJ89vp38IRU4hG32i4gnfCF2P
 fwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777387635; x=1777992435;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ctIsKyjLGAxorg+U+rmNLCdOJMyrX/ml0WoUktvYWis=;
 b=q7WOmRGcnTJIJ1JEjo1ewk0nkW3m094lihux/y8TpYHcvGbDNzcmL0stsy8QoX1hzu
 0VIzW5uq8J+pZUJFMAVmHqNrXsMgaw48I8pqZB1lFcO1PFmkIlFPwpKcxGF4oepQ/MRW
 hCuPGnEpGeIX20vbzLKbujh6OUpa3I0B9oFiuSMyNqFTSXJrJFKNhIjJDIxCltqguez+
 O3AohXczRri+jtW/z5DfO+q5KZTIKJttbpNXxbQp6x2/z9p6+Wr87lZpBFXOMm4g5zuY
 rYic4uFr88oVVPprEtu/RYq3xG8QVAUYGnR6tLSh+9NR6QyPCHQgE3kER97F0msKxktR
 Z1Vg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Q+dZXP/QslMwCpkTx2tCq/vcpwJBurHyiCd5q6TR732QwdAayxc2J1LtLNYh4H4v/yR/dqmcIEmo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxX7ksGt/xUnN8W21w8mGbTno7tGa1Xn7skrkQDSBHO7Tls72jk
 gae3pTl5GszJPlDPGAI7H89499rRa2Gc7K633LGU33Tx75E/dZN+H0DhBUgLwuTa6jE=
X-Gm-Gg: AeBDiesoF8auqrDc4JO4QJaLoiJ4+DrF2K3RkTXGNUDxR/3QND8xLWBD/HHo+7LPnbC
 r/u6xUxhSMrUs6IT9UFAFGoU1OVRHRGgQyvwYdt8D0x49TS5yGd6IeGOlOitiuCbdw+WysgDvSC
 3aLLeQJ3vm4gQ4TBoYwnpafIkWOuu0plVHrfpqOq6Jd2Hjkp2Y2quhDRvXJpeJQw9evOhLM1HUc
 JJ+yMPeMoLrUSZn4DRHFNLCOtwUU6+JvKuiFON+Id9M0QuRqzR6oB+zslX0WeOBccLGzjYZyfiV
 1ls+LSX1KYE9Y2j4F80FI2+q2CeB06Ou/9GugpojcgD5FEGQ3RrftL6vjViiQf8yKncHUOAOygi
 mjdhvrObVBOLfjMWPZgrwMkPOt4SFzUwFfswu4lXv8ttlvvFcTV/oxKO2eKDJORoKdMoV/KqAnS
 br8vIMg5SAmw8zs7IuTgQcmGnrTdJJGiqTSa5GKeq+EugBx4LZ79cyQXnidhZF9nvavrhncZWDT
 rMmHn4a1JIvP7I9zonh3VNtZw==
X-Received: by 2002:a05:6000:3107:b0:43b:5b25:67f8 with SMTP id
 ffacd0b85a97d-44648963af5mr6294818f8f.20.1777387635558; 
 Tue, 28 Apr 2026 07:47:15 -0700 (PDT)
Received: from localhost
 (p200300f65f114e083adbfb3674088b9a.dip0.t-ipconnect.de.
 [2003:f6:5f11:4e08:3adb:fb36:7408:8b9a])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-4463cb59e65sm7467306f8f.1.2026.04.28.07.47.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 07:47:14 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>, Kees Cook <kees@kernel.org>,
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Don't use UTS_RELEASE directly
Date: Tue, 28 Apr 2026 16:47:03 +0200
Message-ID: <20260428144704.1114562-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1607;
 i=u.kleine-koenig@baylibre.com; h=from:subject;
 bh=T/ApXNSXXSl6FROM6HS9+qFlZCnlOYwqQBBavKeuaVg=;
 b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBp8MhozzAn6fh0oyFbng3DD+O55AKxKYvMEvAX0
 fNJRcIZd52JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCafDIaAAKCRCPgPtYfRL+
 TsF0B/9wmHtE3j+P3DMorqCIPp2H5O0klH3BBl5IqPL608ZWjPOoYQx4q+H15H36JxjFRz1m02n
 q6j03BUVSvrDEqZQy7oAF+hub7dL/giJv3xM3k+sfnc5RKQWFwMpvUc+gpAwapy3wXQxneyEdE1
 HDWEkU9qD1EfDDWGOPAPjNrYFlqEsdfBOBjfLFNkMOQZfqYf6iMFrIbrjDtrY2DwK9S1YL5Wpue
 Xkz81bhbjI7ibXVqC64R66M+L/50hpY3m5Uiicnrnn10UpFO8E5t97FC/H8zjlsZYdSyM2O927h
 DLyI72a2bghslevEdLu6Hq3DrHt4BZuqE/ax0kebn6r66Poz
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp;
 fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
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

UTS_RELEASE evaluates to a static string and changes quite easily (e.g.
uncommitted changes in the source tree or new commits). So when checking
if a patch introduces changes to the resulting binary each usage of
UTS_RELEASE is source of annoyance.

Instead of using UTS_RELEASE directly use init_utsname()->release which
evaluates to the same string but with that a change of UTS_RELEASE
doesn't affect amdgpu_dev_coredump.o.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index d386bc775d03..20ae2bd4617a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -22,8 +22,8 @@
  *
  */
 
-#include <generated/utsrelease.h>
 #include <linux/devcoredump.h>
+#include <linux/utsname.h>
 #include "amdgpu_dev_coredump.h"
 #include "atom.h"
 
@@ -236,7 +236,7 @@ amdgpu_devcoredump_format(char *buffer, size_t count, struct amdgpu_coredump_inf
 
 	drm_printf(&p, "**** AMDGPU Device Coredump ****\n");
 	drm_printf(&p, "version: " AMDGPU_COREDUMP_VERSION "\n");
-	drm_printf(&p, "kernel: " UTS_RELEASE "\n");
+	drm_printf(&p, "kernel: %s\n", init_utsname()->release);
 	drm_printf(&p, "module: " KBUILD_MODNAME "\n");
 	drm_printf(&p, "time: %ptSp\n", &coredump->reset_time);
 

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3

