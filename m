Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C490BC53209
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 18:21:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C79C10E6B9;
	Mon, 27 Jul 2026 18:21:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="ZzlpFv3w";
	dkim-atps=neutral
Received: from mail-oo1-f97.google.com (mail-oo1-f97.google.com
 [209.85.161.97])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F44F10E6C0
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 18:21:47 +0000 (UTC)
Received: by mail-oo1-f97.google.com with SMTP id
 006d021491bc7-6aae5e437caso1442699eaf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 11:21:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785176506; x=1785781306;
 h=content-transfer-encoding:mime-version:reply-to:message-id:date
 :subject:cc:to:from:dkim-signature:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7oGG9Mgh9HlifuBC9vi5phW5QUpaNtLCFs4rWkBhaAI=;
 b=b+O36edQhITW4Pk/Jy+Nz3jSwp9SMq9MeVV2LAcg/J3b4Sqrx+1PWk/0bBMVIJKsP4
 aohmE6gBtp5QGecGWKb6M0MIOSn6ne4YmpjfJRD4L1hTIw064JaoONTg0zwAtjFeNsqF
 6FqE02/sQGrVX+OzbeQI3Ylu+S/W+eXcfAIKF/Zch2kN2TBRGFtvYsjVP20hFg1hfBTX
 ubLZWP+Xap/diU8ErZZLY7TXeOsEABOkhQzMJzN4WQAwAIIICVu/4JlWlJ1cofkb8Y/G
 Uskq/3D8nK+cqMVJzxhQJembjA9HYccMwVemRjzpqDHswHkQz+dW3BzEg60LLwJsejU7
 EwUw==
X-Gm-Message-State: AOJu0YwY/XZfY4dTsdC0Mw6FGXES3gJcpmi4kw33oHgR40W/inez2gfD
 yWRHgc9rAGBgpaZUhifIwFlddWomrYDRCeLg9GtjKQoUQH+YMcOw4NZWEiP+K2s8DCkshCq3Pto
 jVdYG+Ny5+4vdWkzAZBWIRizEXdLB6xVMvIViFZWlUR7SbTdeeyd0Etk2kzXbSE9bD1CypeVrdR
 NkRbbBiqGUKtuWSr1ZskoE40FxeEjI/qpWhBx+VfYw+1qIuHzY5t5Pya+Epv5hlt7aGSTQsqJGt
 kMUJ0AFxKGoKfhN8pGa77J74jNH
X-Gm-Gg: AR+sD119EKYzqhCuC6kaRw/XtBaKg8q+3IqhHYPEN5qFtf9qcETpTKsbWjeUPOYaD7o
 7JMQkYbv3bu4OVB5/vAm698k4My/0HhLxNVfK1DAoW94VUoF+8/3eTBiE5LwhhKEUYc32eVki9A
 Y1obSS1xAMg9TZ9m2VRVe10tFS1zJOdlBr49ZroWK2AW4stfUkTLzhHxKCplk+3s/Rbuc2uDkpO
 polWUFvpF5d5sCBgT00tgbNUzdEgjQWiHScFS/fajDZtS2jMdPhm3vDtjoi2cqdk6gQ81VzBJPp
 3eX7WkJ10rl9Z2dOk7ul77nHkJXrvLi33+B8jDAx5kdmpdcUPbAeffRUuaeYWMwGXsrDzfI0ECf
 viWpvARu6og3n6dhfHj5z9m/Wqbye8GdS5IkAjep9DG1u22wLClp4tV8Oe/FbVuSiffn+TEnssN
 RupIEoIgB+4zFSgLS1TQRgALtEKpchGrWq51Lk5oki
X-Received: by 2002:a05:6820:2016:b0:6ab:480:7172 with SMTP id
 006d021491bc7-6ab048087ffmr6440411eaf.4.1785176506285; 
 Mon, 27 Jul 2026 11:21:46 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-73.dlp.protect.broadcom.com. [144.49.247.73])
 by smtp-relay.gmail.com with ESMTPS id
 586e51a60fabf-45766e2846dsm1235755fac.2.2026.07.27.11.21.45
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 27 Jul 2026 11:21:46 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-c16711b9473so294681066b.2
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 11:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1785176504; x=1785781304;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:reply-to:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7oGG9Mgh9HlifuBC9vi5phW5QUpaNtLCFs4rWkBhaAI=;
 b=ZzlpFv3wCHsVU+IWXUgYIUoR7iAxUGB2cVTFnFRFLqWXJw8sDi+wsRXOzeaAqub5SO
 PjMvZZXgZjVY66Ro4mvWVqzdpDewk5JVBhsVCoaI8yNiJ7gDGvZJjZeHlzw/QhQB6t9k
 VRYzbHFRCHk8DuzTIXlIeyTms2erlkOQ/QZVA=
X-Received: by 2002:a17:907:3d02:b0:c16:12c:9aa7 with SMTP id
 a640c23a62f3a-c1f1f1588a8mr423712966b.40.1785176504592; 
 Mon, 27 Jul 2026 11:21:44 -0700 (PDT)
X-Received: by 2002:a17:907:3d02:b0:c16:12c:9aa7 with SMTP id
 a640c23a62f3a-c1f1f1588a8mr423710866b.40.1785176503969; 
 Mon, 27 Jul 2026 11:21:43 -0700 (PDT)
Received: from mombasawalam-Precision-5820-Tower.cap.broadcom.net
 ([192.19.50.250]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1f5e717da4sm82222366b.4.2026.07.27.11.21.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 11:21:43 -0700 (PDT)
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, ian.forbes@broadcom.com,
 zack.rusin@broadcom.com, Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Subject: [PATCH v6 0/4] Fix some issues from igt runs.
Date: Mon, 27 Jul 2026 11:26:18 -0700
Message-ID: <20260727182622.236086-1-maaz.mombasawala@broadcom.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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
Reply-To: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

I ran igt-gpu-tools with vmwgfx and fixed some issues I found.

Changes in v6:
- Remove memleak fix in ttm_prime_fd_to_handle() since the fix
is already present.

Changes in v5:
- Get display unit from cursor plane, so there is no need for
old_crtc.
- Cast ALIGN to u64.
- Check return value of ttm_bo_reserve().

Changes in v4:
- For ttm ref change, changed to incrementing the refcount on
the ttm base object of the dumb surface instead of holding a
ttm ref object so that it is not exposed to tfile.
- Added Fixes messages.
- Removed BO cleanup patch.

Changes in v3:
- Minor changes so series can apply cleanly on drm-misc-next.

Changes in v2:
- Changes based on Zack's comments.
- For vrefresh changes, removed stdu specific checks so that test
kms_invalid_mode@overflow-vrefresh passes with sou and ldu displays.
For ttm ref changes, fixed a ref leak in ttm_prime_fd_to_handle()
which fixes a memleak in test vmw_prime@tri-map-dmabuf and removed
release callback for dumb buffer surface since the gem buffer will
handle release of the surface.
Added commit to remove duplicate functions in vmwgfx_bo.h.

Maaz Mombasawala (4):
  drm/vmwgfx: Add some checks to vmw_cursor_plane_atomic_update
  drm/vmwgfx: Check vrefresh in drm_mode_setcrtc.
  drm/vmwgfx: Reserve ttm object before resv usage
  drm/vmwgfx: Change ttm refs for dumb buffers.

 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c           |  8 +++++-
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c | 16 +++++++----
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h          |  1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c          | 30 ++++++++++++++++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h          |  9 ++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c         | 12 ++------
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c      | 12 +++++++-
 drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c         |  8 ++++++
 8 files changed, 79 insertions(+), 17 deletions(-)

-- 
2.54.0

