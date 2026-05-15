Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2EB6CD4851
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 09:03:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECCD810F4A7;
	Fri, 15 May 2026 09:03:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="TsuWbZDi";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46A1A10F498
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 09:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778835804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LfHDA2lu9SdmcNfUFLEQpGK4hzLMbqXJdHhI2cGEcxc=;
 b=TsuWbZDiwQuGL4rbaO7+3ywRbfmRD+UgsGJvElbECJOY36boidNIQyxvNCq6Uh4q4JPVer
 aDFaRK5bguB2g/OuwBhddCCy4D7akinsGCuELGfUNW+4zNl9QVq1NF46zunAE4BTq2eufH
 BnFYMHV/ZG8uh+n/FAqn1AjUSCl9fYI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-XJOrLLDwP1Ob3DWIGeamNw-1; Fri, 15 May 2026 05:03:22 -0400
X-MC-Unique: XJOrLLDwP1Ob3DWIGeamNw-1
X-Mimecast-MFC-AGG-ID: XJOrLLDwP1Ob3DWIGeamNw_1778835801
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48fd233d1e2so21842835e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 02:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778835801; x=1779440601;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LfHDA2lu9SdmcNfUFLEQpGK4hzLMbqXJdHhI2cGEcxc=;
 b=UMVs4FTCAdpRHsL1u7IDp/B7yeH9/XKN+bnYllttId7fnmXDIyU+OtbOWTa8g6AmAc
 d/NIsW0PaJDDdqVzcYM6EEgPL1EeQd9klcQrDHPL6IaDCbxE66AmvMJxvQMGGLxYQ+Vf
 edWtcBzkA7//wYjWSyPrxFp+w+KQfMue/GDrNrFEk6ikxMT+D9yx8Lhz5ZF1P+livj5L
 QQL3itG4Dm9CX+J/1lST0e5os5gNZxBXgcePhu4UiAScmE2laDW2ARf+/7sVdhSpgA7T
 AtfuUEIXELfpOizshP51UIHG6gGzt8lBGSb3GABoZIjiUBEv/TRx6iwgSjW7VOM1jdyY
 nYyA==
X-Forwarded-Encrypted: i=1;
 AFNElJ866g23Z9a1pIybHy1yIy1MaVO1aR5yKwvcbS3LMZGxVPby6aR+bghqgr7HfoJMPLSON0IIntpxCmM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxL07QCXaR7gHGeiUfX8PCoPYJF92V/JCikQviwM1YEA/lfRptW
 ACCshSrUkJxbCyspC7M70fRugglDRjck65+b5IIQ36Q3fvdC5xElheKFGFEl3XKrY5WVMJ2ALUR
 Hg2amQgQBaAWC6GHZ0jsTZEBDINoRAKBqrq3BC2EzjBnbzP7CnsjS8RdudHOt0HoZbHTuCg==
X-Gm-Gg: Acq92OF3bguVeNR+zUhdpl3RhY8eoBRMWAVG/jqgPaTATlvEYXtexRFNn0sZZHub9GD
 YvoqhOgfwx3I8CCvT6v4LNEEhuaTLkqcgBmwhJZlxMhSUAnvDvh+dcdlxntQ/1HMbFf9I97MXLC
 GlcfgrlWNAsOGgs16wlb63aJDGcExl/h2nLWW1k0ry3rPMzmXm+BhWhzXiKyd8lv7xi5Wg8V0iR
 x0mXlsPmKuSpZXgbSiwaRm7KMPR1oH0XrtCDJ60d5pINkb66jFNl1Og7/707u5vSEMdXkm6RNpD
 Xx8ARJjn0lUshAsXzTlunmxQBfgEGpTwfXOvEFzPE7xQVWhCObJxfngeSPqn94wMU7AYH3LaVsC
 z9PXS1yH4pv+CpuXCyzj07FW4L3VRlCY/84DhtIduPKDNk4p9L+MDLgH8ZA==
X-Received: by 2002:a05:600c:3506:b0:485:40db:d40c with SMTP id
 5b1f17b1804b1-48fe60e13d1mr41799635e9.3.1778835801314; 
 Fri, 15 May 2026 02:03:21 -0700 (PDT)
X-Received: by 2002:a05:600c:3506:b0:485:40db:d40c with SMTP id
 5b1f17b1804b1-48fe60e13d1mr41798765e9.3.1778835800593; 
 Fri, 15 May 2026 02:03:20 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4c88e5asm47427035e9.6.2026.05.15.02.03.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 02:03:19 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, David Airlie <airlied@gmail.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Phong LE <ple@baylibre.com>,
 Robert Foss <rfoss@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Subject: [PATCH v4 0/3] drm/bridge: ite-it66121: Fix display output for DVI
 monitors
Date: Fri, 15 May 2026 11:02:08 +0200
Message-ID: <20260515090220.809830-1-javierm@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RISM85y0hdai39T44M2JPNTgTtMXlvHD5Jk1bXGN74c_1778835801
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Display output does not work when connecting an AM625 BeaglePlay board to
a DVI monitor, because the DRM it66121 bridge driver assumes that the sink
type is always HDMI. This patch series fixes the issue.

Patch #1 reworks the driver to use the HDMI helpers instead of open coding
the AVI infoframes buffer management.

Patch #2 moves the .mode_set logic to the .atomic_enable handler.

Patch #3 finally fixes the mentioned issue by using the display information
to determine whether HDMI or DVI mode should be set.

This is a v4 of the series, that addresses issues pointed out by Maxime.

The patches were tested on both DVI and an HDMI monitors.

Changes in v4:
- Convert the driver to use the HDMI helpers (Maxime Ripard).
- Move .mode_set logic to .atomic_enable (Maxime Ripard).

Changes in v3:
- Move the HDMI/DVI mode set to the .atomic_enable handler (Maxime Ripard).

Changes in v2:
- Don't store the sink type in a per-commit bridge state (Maxime Ripard).

Javier Martinez Canillas (3):
  drm/bridge: ite-it66121: Switch to the HDMI connector helpers
  drm/bridge: ite-it66121: Move logic .mode_set setup to .atomic_enable
  drm/bridge: ite-it66121: Select HDMI or DVI mode based on sink type

 drivers/gpu/drm/bridge/Kconfig       |   2 +
 drivers/gpu/drm/bridge/ite-it66121.c | 198 ++++++++++++++++-----------
 2 files changed, 121 insertions(+), 79 deletions(-)

-- 
2.54.0

base-commit: 4c26e162947f91aa78ba57dd4fddd38fc80e7d60
branch: it66121-fix-dvi-mode-v4

