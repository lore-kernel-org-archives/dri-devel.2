Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A48910987B0
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:42:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C640910EB8E;
	Fri, 20 Mar 2026 16:42:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B05UDANj";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76C3D10EB6B
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 16:42:03 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso7696445e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 09:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774024922; x=1774629722; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3By9JWUmg9qQ/pqhNEezgrYY//+LwMSXyyt4mTlVhH0=;
 b=B05UDANj4anPGwsxnp3VomdalrfXBzJN8fsByQ7crzUphZYzFRX7fDS+Vt1X1ZBnvT
 PHW8h3d+V8AzM02oinsEpV1uDcMeurIIJR3axNm2sONigK7pQh91ZNAmgMgRDRqO8Oua
 fs7zKberNfQ4RI9LJgiDmegnsCxNMfgJphmx65CcoO1EgeKE99oHq0jm+mDVfH0ndIKn
 MgM6tSQIxAWLDjx4kdcKmyccaee06vLg0p7hGaCLI9/OlwxIxlF8RMb3ce2h2vCEZjC9
 ADaOw5hVcv67bY7vkzfYtloWQfwIG2cUs197zWJ8KQXvvmT8qrYjgVt8ItELC6SBAbSO
 +0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774024922; x=1774629722;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3By9JWUmg9qQ/pqhNEezgrYY//+LwMSXyyt4mTlVhH0=;
 b=h286al1QahbeNdMCRyzCFoCW1OiSU7sV+69377kK1J27tvxPNvJaJOzv6z+cHK7+ip
 5vV/LrVaBCOfM/FcmyxRG33kPgIJkOhxrm2rzl9gTgDg8ZklMA+QNKAlqROO8Ms/Pan+
 irguQ2Hr0urNg6AdKtF74sv0k9tVXWEtbR6z+D9BAqjZupMbhWKc2zUema2DskzzWFl/
 GmCw8g2RW9TaLdTZmJIUvc6Qc4YjdSxoM5ed8yjznPuAmTAihj+Eqs1lZkp5Q7ni1dw4
 TXHOXDqJPt/NffEeWTR2v7P3yB3pqEWyBYbV52G8nVh78aqKGImrJ7GznZWAxSMs7EPU
 1Kdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEC2figlUsbfWmFYRk28EgZXBwrmQ/cTGEIl/vN6x/CGnuJJ9eVV7HW+o7Q5uPIt7WIvxBSLGnibg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxP3IBafJ34NTe6QkhId5/Z8WSVQJOmRFzT2CVDyTB3mTwyg+0y
 Z1BkMWcYT+InsAjiXQHn9eC0EKCpSzs9Rx7VbjoBVbKknUz8BBHdmRMX
X-Gm-Gg: ATEYQzw5rGepUHXiZzG0/rHexTzkGKE5zDG4/DAWyHhDTetKSMc4niTXGpyRs0mFVuO
 x+gXpPpU3//PZ38QOdVWwcCk+7lbKoyatNMjSpULBhE4XVrqPp02YFth4Hoqfb1BFHo/CaKpRw5
 yOUtpU2f1nA1JjlxvpRil8wpZk1Rqx05v/+AEC0ga9x7bPwrMwmDkZykIKir3bP+w6hOKNtt2SC
 Ev5vI37NIh1LNUvZHAFsHdTsZlJ7DMgUR/bwTj8MYQIoZrq9Lj5YcIAl2guDGnxZ+3HnPCcev+z
 y6wkVWgKJrlIchdQjud8AcPjaEfRKMMqJWy+0MGTxEI14FXCxcmZiuU6D/vxuFGy8c3e1r+emYB
 aJWBsHEJ6lX1W5r2Mkd/wJzu1Ex1SkDfUfOLeWkf/GyyX6vEukVGQezqlyoYzgnfyovaCK+GmjG
 1kavDql+pqGDuI6aZ8bUVhkuw/Ccv7QPw=
X-Received: by 2002:a05:600c:c09c:b0:486:fcdf:c065 with SMTP id
 5b1f17b1804b1-486ff01caa3mr43316465e9.27.1774024921602; 
 Fri, 20 Mar 2026 09:42:01 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:5b93:d2b1:bc5c:9231])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64703650sm7016575f8f.20.2026.03.20.09.42.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 09:42:01 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v2 0/4] Add RZ/G3L GFX support
Date: Fri, 20 Mar 2026 16:41:46 +0000
Message-ID: <20260320164158.487406-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
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

From: Biju Das <biju.das.jz@bp.renesas.com>

The Renesas RZ/G3L SoC includes the Arm Mali-G31 GPU as a 3D Graphics
Engine (GE3D). The Arm Mali-G31 GPU is a graphics acceleration platform
that is based on open standards. It supports 2D graphics, 3D graphics, and
General Purpose computing on GPU (GPGPU). Add the binding and driver
support for suspend/resume functionality along with some improvements in
panfrost driver.

v1->v2:
 * Dropped duplicate err assignment
 * Changed the format string of dev_err to "%d" and simplify the dev_err()
   line by using err rather than the same PTR_ERR().
 * Collected tags

Biju Das (4):
  dt-bindings: gpu: mali-bifrost: Add compatible for RZ/G3L SoC
  drm/panfrost: Drop redundant optional clock checks in runtime PM
  drm/panfrost: Add bus_ace optional clock support for RZ/G2L
  drm/panfrost: Add GPU_PM_RT support for RZ/G3L SoC

 .../bindings/gpu/arm,mali-bifrost.yaml        |  2 ++
 drivers/gpu/drm/panfrost/panfrost_device.c    | 34 ++++++++++++++-----
 drivers/gpu/drm/panfrost/panfrost_device.h    |  1 +
 drivers/gpu/drm/panfrost/panfrost_drv.c       |  1 +
 4 files changed, 30 insertions(+), 8 deletions(-)

-- 
2.43.0

