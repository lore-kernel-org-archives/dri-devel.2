Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E052FB44C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 07:44:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25A5D10F35F;
	Fri, 24 Apr 2026 07:44:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bW3xz+yn";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5324610E289
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 12:59:32 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2b2503753efso66698945ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 05:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776949172; x=1777553972; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qD6y1U4KRFjO1L+byjvxtAYfsQZMOWhppKERXu4m7z0=;
 b=bW3xz+yn1eOez6B8TVhyEGTd1EJvjesgOrtJJQM3NV8RfD39sUHxLlM1FhHlTXTLWw
 oGmMSv3AjjHlxR6OKBHeqkM13KF3g6BiAeft4DmNX6r9PcRk/Pl+FUqEKnatghYBEuL1
 PWjD8uaCl9XE7opYCUMosJVbNewBhqBOsseCewrHlqje+ldHOqsv+yPlUAKloq4UVt3M
 Kad09Hopqaa4yFeTQfSM2g2RvEToOq1YQddvYugguP/vi0arLRWM9zLHx8A+X8bGyOlm
 1ASAQ83uRtkGzJDX2wyD/8tc/SFgTukqgo1fKBSO/0r2s5BBDR25VX/Od3MDyuIEHQSr
 iSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776949172; x=1777553972;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qD6y1U4KRFjO1L+byjvxtAYfsQZMOWhppKERXu4m7z0=;
 b=DM+ALGfN7R8DYehbUIUXM3t8SMYF5XxioVAW8xiWxRlso1qOn12w9NYKDfY4BPb+Bq
 0f3ce4CDWZTK1q6lF3kqt8Db71y5fWXL7Qny21/MdG4pGnTN8UuaXImItrHeZhErUIu2
 dsl2A1rJPRKliGVkWWiTx7fJNWNYbFTDlF3NgBwm3H8UIQ0sGVpd/bE08Zm78I1art34
 Y4V825w18CMBhoJHePRBGpmDbd3aMSTNllq4WsOovKjXSvbKH6Q7dwKdHSwy3AQfYmCm
 gB/p6zdc+ysfCfeIuKVLbga+zbrSAdY7qSDrnK1otJ56P/e417yzCJykC4U56nL4XUtA
 L/Rg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+l2i7nsxYQyR8N9irC6Cl5zLISHdsNojCP+L1wKKrmN4N3qjdkrk4kh6epWkgIdopXxO3lS1SQGCQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzpvVdqCbIRsXu6Zo1M7Nq1ueYoinZbwR4SzUaIyEDTOOUFBmG4
 vUG0GEyIvpHmQbAbvotoNik5QWdsFqxwmFZUu7N3hiy6kYSYQwP1geY=
X-Gm-Gg: AeBDieto6x1rr2LiMznVigsJG8sB3ELM0AHRXZXoUdtS/o0r7kSCKX4I94dtJIm7Eyh
 9BZ1kKVtoR06yqeGQlJYQ02WNaV7di8CUO70mwMDN9nrjiKBbRC+6L2Y3x9sA0EquDAM9rMy65Z
 VMnlCvant7zYbTh+7XisD/3tQiWb67BV95ShnJ6a3BQkrrkwlMwUKh1Rc+6dHnv7ULsi6vTKdHu
 7itUQrlXJoFCaND1XkoRG4tStkYR9sytRgZihc7rP9DtBOXrPhjZpUHJLZ4OU0BsqP9X9vY7SEe
 zBjAgDg8S6V+U5vNTAn9dRZPoLfhpDGLxrcCZmBlNhZXlD48Y2Xwik2Kx29IYguexuOL5rMwYpn
 xJF3sI5TlHPVcuX7h57KorOIX+2I06O389Rvj4CpyLIYWcrib2Oy7td1d5EUg5tjNJjLgjz4/Hj
 cu3AQhAdZH2g0QVkZFvTZLO44Q6IVivftaCYUoms8dmL9114lAYhbivq6jgacE4regPFylSq19v
 sy8rymPRw==
X-Received: by 2002:a17:902:8308:b0:2ae:c529:a13f with SMTP id
 d9443c01a7336-2b5f9eb2249mr191974495ad.14.1776949171770; 
 Thu, 23 Apr 2026 05:59:31 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab28e35sm193499065ad.64.2026.04.23.05.59.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 05:59:31 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Myeonghun Pak <mhun512@gmail.com>
Subject: [PATCH v2 0/3] drm/panel: switch panel registration to
 devm_drm_panel_add()
Date: Thu, 23 Apr 2026 21:59:19 +0900
Message-ID: <20260423125922.57428-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 24 Apr 2026 07:44:43 +0000
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

This respins the previous attach-failure fixes as a single series.

drm-misc-next now has devm_drm_panel_add() in commit e43a8e3ad8fa
("drm/panel: add devm_drm_panel_add() helper"), so convert the three
affected panel drivers to the managed helper instead of open-coding
drm_panel_remove() in their failure and remove paths.

Changes in v2:
- group the three related panel fixes into one series
- rebase onto drm-misc-next and use devm_drm_panel_add()
- drop manual drm_panel_remove() handling from probe/remove

Myeonghun Pak (3):
  drm/panel: ilitek-ili9881c: use devm_drm_panel_add()
  drm/panel: jdi-fhd-r63452: use devm_drm_panel_add()
  drm/panel: lg-sw43408: use devm_drm_panel_add()

 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c |  7 +++----
 drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c  |  7 +++----
 drivers/gpu/drm/panel/panel-lg-sw43408.c      | 10 +++++-----
 3 files changed, 11 insertions(+), 13 deletions(-)

-- 
2.47.1
