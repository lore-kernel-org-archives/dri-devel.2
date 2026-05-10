Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 904D7CD3427
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 19:15:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF1BD10E24B;
	Sun, 10 May 2026 19:15:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="ThueMIGu";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F18F710E24B
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 19:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778440527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=L5ghcGO/uZykueCouYPVSIKgvYjawm0B2pG8CDHe00c=;
 b=ThueMIGumNKNPVfcZotai6M2UrD18fxe4bf6C4ZOhNX/jfmqeCqCWWgrdmDOyuSG4pYI9F
 p0V/gdeP+C0CzNj3bU2RH/SWt8/Ax5MDwVmA0uvVaLaQ2kuIJvwp3EU+4+R+N+WUhd9uGi
 sj4tBWoxu7lTsbUhhusywG1aUHA7lfU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-oACq_cC9Mdibg5yvUSKojg-1; Sun, 10 May 2026 15:15:25 -0400
X-MC-Unique: oACq_cC9Mdibg5yvUSKojg-1
X-Mimecast-MFC-AGG-ID: oACq_cC9Mdibg5yvUSKojg_1778440524
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48a5952c635so41265275e9.2
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 12:15:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778440524; x=1779045324;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L5ghcGO/uZykueCouYPVSIKgvYjawm0B2pG8CDHe00c=;
 b=tJVCbsT1KGkFpG/P0tge/sGTRh+DUEk6Z0yf/jJKFTVmfqlMOasNfNbLGMEwouxt0o
 pKgg8Y8usepJhQB19473/tamFGC2/LMJ6sJ/Ckb8737PXKu9IBSdOxxRlL3jFaE+n8Th
 eRtRbQK2ZvUPIfFVVyHsgEUPfPJANJx+tqzgeV6d9z1j1TKR20cxYVSSBkyidOoWN8aR
 wWykWKa0XCQ+oKP5YuO+4BlaUJNZmC6HXhzY4M7zwFjLYC7s+jrHXlu1Chp4E51o5boK
 obuNfWzxwS/+8Z0Ip1j4frzA4WHXjuPCRL9wlFLZyJmZyGU23XRyPdGmuH3XlBhXFJzh
 wxVg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+bcw5rTWe2lY9Ps/3c2epjzDWKaDraAJB6kxfyYTrO4k/qqSE22T5/cE2+mIoGHOzMMva4CFJchL0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywsha8Db3hCcnNg3auTlC9zxEfNn+pPsgVfmJ6kGgj94YC8mKOC
 xu/IW78X9/lkTBjlvfR4TaZYeyC8aBjldpbzKkGSTuYHIrVb86vfvTXaf/MrXBc2UANZMzzDZsf
 4DfU8BFC0ypk2nOTdpNbjlPGBmBmoSISwUtFelbTqmlRYjQHhdUVra9FnyaQo+3FqpjZPLg==
X-Gm-Gg: Acq92OHcDp3C4/9n29wgw+5rP1FdA3JgCWAob/HdOPxRqn8kwj22w908gxS0SlfNcps
 1YM0KgPq4jI0h/g6VkhYGjWbIhUTiwpQrWBpVmTuTYlWJQAe+5WpQX7BnU1/Lb0iDS5aU+RS/rt
 o9xXKOyzDvXQIXkHME2IJOCvx52xlVKPx6ybmI83U6sbE3eWQ4agkXZTbHhrKDgsM7KF4n4aoN0
 5QGZWXnEgMe/ABF8bSJG5rMp6VWYThwI3uq1dLwNP0cWpMSfSRER/UTR44useTx5Wqwv6unLeWs
 uri9bCJ2eI3mCBt5oLwxZ3gs7hVaHe7bjbrK9QDSS4Xu6nJGCp/9CLigYlre/D14DmL8T7EWXoS
 39FOAYIyuz88VkRt4CsEvML/iNFixuqIkSMN9nvZ2YTaKtRA=
X-Received: by 2002:a05:600c:8907:b0:48a:65ad:1881 with SMTP id
 5b1f17b1804b1-48e51f32a46mr277826395e9.13.1778440523896; 
 Sun, 10 May 2026 12:15:23 -0700 (PDT)
X-Received: by 2002:a05:600c:8907:b0:48a:65ad:1881 with SMTP id
 5b1f17b1804b1-48e51f32a46mr277826135e9.13.1778440523384; 
 Sun, 10 May 2026 12:15:23 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e6db0ec25sm48506205e9.24.2026.05.10.12.15.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2026 12:15:22 -0700 (PDT)
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
Subject: [PATCH 0/3] drm/bridge: it66121: Fix display output on DVI monitors
Date: Sun, 10 May 2026 21:14:46 +0200
Message-ID: <20260510191459.90769-1-javierm@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BbqmIFVbcU1H35x3Nz3rRaXAFLBeWOeWq0ced2en71Q_1778440524
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

I wasn't getting any output on a monitor connected to an AM625 BeaglePlay
board, and I tasked a Cursor agent based on Claude Opus 4.6 to conduct a
root cause analysis.

It correctly figured out that it was due to the IT66121 bridge assuming that
the sink type was HDMI and sending AVI infoframes, but this can confuse
DVI monitors.

This patch series fixes the issue, the changes are fairly trivial and I
take full responsibility of the contribution. An Assisted-by tag is added
to the patches in conformance with the AI Coding Assistants [0] policy.

Patch #1 is just a cleanup to avoid doing direct calls to container_of()
and use a helper function which is the convention in most drivers. Patch
by storing the connector sink type in the bridge state, to determine
whether the mode should be HDMI or DVI.

The patches were tested both using a DVI monitor and a HDMI-to-DVI adapter
and a HDMI monitor, to ensure that there are no regressions for HDMI mode.

[0]: https://docs.kernel.org/process/coding-assistants.html


Javier Martinez Canillas (3):
  drm/bridge: it66121: Add bridge_to_it66121_ctx() helper
  drm/bridge: it66121: Add bridge-private atomic state
  drm/bridge: it66121: Select HDMI or DVI mode based on sink type

 drivers/gpu/drm/bridge/ite-it66121.c | 137 +++++++++++++++++++--------
 1 file changed, 100 insertions(+), 37 deletions(-)

-- 
2.54.0

base-commit: 19d584a634fe999786acfb0ac5289710cc84a5f6
branch: drm-misc-next

