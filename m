Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B47BCC2A09B
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 14:22:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CC0010F502;
	Fri,  7 Aug 2026 14:22:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iG4ZAwEZ";
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 246A710F503
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 14:22:43 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-c9ef3e1337fso2558676a12.2
 for <dri-devel@lists.freedesktop.org>; Fri, 07 Aug 2026 07:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786112563; x=1786717363; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FAa78h1UPlEGhvqRIND/hGOzg4aWk1ci1bKFVAtltMA=;
 b=iG4ZAwEZT2xO5ekjbSZsr6k/63b28R+E2r4o/z8RrX88/uUoHbuGSbkJ9gPzbkgDfR
 9tUD9eM0AbPLumPKVYv/jVlBrQtY7x3vGlJEP7CDY4Ay4WZvnxnykmTYPfS4Ovam91yA
 SNX5btmq+fYhxOQRoafp4MdJQa5qq049OlKFk71A4HcWv72x0vaBLkpRpFhxXnoYxgY7
 FRbLQtUVbR44vYqyvyqIpygvhFcmI1RQCrwlCKiUp/1oWLgjqsZVkO5FejTOK7Ay67IV
 rSMN2qIvjiS9H5ctnCRee0+Agb3MOHWcbl9aqXhnTiPbW16mEtnJfhQTw2U9zegaDdfN
 kQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786112563; x=1786717363;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FAa78h1UPlEGhvqRIND/hGOzg4aWk1ci1bKFVAtltMA=;
 b=Ut9pnlHpsE0asREKaaxg/44tJ9yP7CUAr2uHia1S269+KwKSyI8r1bOcAtro88PJYf
 h9nxeJEYWR/JPuPAk1yfiuoW9vjW726rqy2G3hcfYqriDYpbTpMHSpcpGk34AbiwjIFU
 Rr9AaWpT2+NKmn9C9tNMOxLSDGe3/qggh9MXHVzW3T5a8lMDcZpiyHW3XdFXghXytVH5
 BYxkaLB2wWucRtk5l5es3iHqFeGsXbhXhp++Ziwpt3RoEc8lseZJ+TmtnlkvlWmuoWfU
 Y1/E4oelSZC1vBUOhb50E6zrpaMFghI7WamUF79M00TgqCzlxgfM10mrnKFM+3bVtM53
 KeEA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro27ev8axjhCo50CFtAc7kHVCGPO2PqkxkhboVlO5jrfjinqzDCkm6hbrDfrj89Bpcq6N10x/xGQTU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxFx1JPSNFCfHd3+gbSqJd240LLakT6YwXSPfN5GRyfY1HtRCUd
 iW3iNXe1d1ezU1V/wPTKDup/HVx39fIW70JX0f4CSGNUVpHHUS4XzGs=
X-Gm-Gg: AR+sD13z3RpLGAKnvzRJ8rjR2FMCZOlvSDhpKuXemP75c6ysvNq0Zl/oPM60wJ/Fejw
 gvyAXmsUEeF8TxZbXsBeulaWapwNNtS3xJxRl/Gg0uB+2AZBfhDLr9tHPBxbyvJPQem0q4NwLVU
 IrOvJX+4WpmqvFzqkvNaIv483SEY4s+7QvfnQk8q1Tr9rh3Q4WykNQIzvk288MXiQ9YLkp++wWd
 iQ/IHf+khsWhnt8j64snhxkM4kYYxiZjJomliCMu6ipMGUJ7dhXZhVCAGhzJXHmNg8Dye1pIl2c
 eoks4HDbWx/f8bIEqIgD576zJw8l1jr1CgBNktwuvhraebiG+r12fhGlrQyu1KomUQvHpwC9wLW
 kMFVTU3wEDeyeA/Ladm+zG/RE0T5caa+UsvU5skpBtdZrBcXWdv/ewwu+sFeglIbMVxAJCJ+dpn
 DSGhpkgxGQLko/Ik/9vL2uH5uJjlNLwnui0087LAFgF3Y9nYm8j9hot9nJILGuXMEuMtnbyDHc/
 E5AmD+Ol/vI+gFBQsEJ4t6T4p18H+JgRlbv/7a0
X-Received: by 2002:a05:6a20:cfa2:b0:3c4:397a:69b8 with SMTP id
 adf61e73a8af0-3cb85e6c93amr31913005637.21.1786112562606; 
 Fri, 07 Aug 2026 07:22:42 -0700 (PDT)
Received: from localhost.localdomain ([186.158.238.108])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be8a7395sm8521868eec.9.2026.08.07.07.22.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 07:22:41 -0700 (PDT)
From: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>,
 Brigham Campbell <me@brighamcampbell.com>,
 Jori Koolstra <jkoolstra@xs4all.nl>,
 Shuah Khan <skhan@linuxfoundation.org>, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
Subject: [PATCH 3/3] MAINTAINERS: add entry for Chipwealth CH1115 OLED
 controller
Date: Fri,  7 Aug 2026 11:19:52 -0300
Message-ID: <63b7368037a4f03024152716776de23da5442cb7.1786110720.git.nico.antinori.7@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1786110720.git.nico.antinori.7@gmail.com>
References: <cover.1786110720.git.nico.antinori.7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add MAINTAINERS entry for the Chipwealth CH1115 dot matrix OLED
controller.

Signed-off-by: Nicolás Antinori <nico.antinori.7@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b09b0ee33f5d..8430e4f4cad3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8590,6 +8590,12 @@ T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	Documentation/devicetree/bindings/display/panel/samsung,lms380kf01.yaml
 F:	drivers/gpu/drm/panel/panel-widechips-ws2401.c

+DRM DRIVER FOR CHIPWEALTH CH1115 PANELS
+M:	Nicolás Antinori <nico.antinori.7@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/chipwealth,ch1115.yaml
+F:	drivers/gpu/drm/chipwealth/ch1115.c
+
 DRM DRIVERS
 M:	David Airlie <airlied@gmail.com>
 M:	Simona Vetter <simona@ffwll.ch>
--
2.47.3

