Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C55CD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 13:35:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82F7E10E114;
	Wed, 20 May 2026 13:35:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="ZeJ0tHt1";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F34410E114
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 13:35:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779284134; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=TDA14aBLdZtwH5zSE6Yzahb+n/1Firf5P/wtJmFmpimt0EVYxF81f1CoMx+qgBkRI9XQsFQ4FS/O6t1xFXsb8qkdt1iWPNl8LzJr4f3T54ITxcgICBGqVxdXaJK545OvjifG/TcIaaQw+vKe+xPH/pqrqsbqC5czAVZrv4y6mnQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779284134;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Dydjle+ZeMiHMb+0AWgqEJ9CT4r7znpYI2IJz3ZeFFk=; 
 b=IptYXB+npTehK/3hGnd7EXoYxb6ll+N+bYifK3Wha68Dr+f0G9qVXGLPanGyZV9/218PzetnDHMbJMwEGVjjgN4Acw1M9G3ecU9EZOd1C+xGpucjyGdcbzJm3IZVduCb174hSYZDYVDGM5uGpAdc57mSXVgxlRlvdE0N4mP19PQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779284134; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=Dydjle+ZeMiHMb+0AWgqEJ9CT4r7znpYI2IJz3ZeFFk=;
 b=ZeJ0tHt1yx5aIgj6brAZaiJ48KPTMZi0+vB3CWnDP+4sWTh9hlhglJNtFWlpr9V7
 5l+06QaTzIe5DphMjq2fdd0BGpEYz1RZgjV7ZXL6fHtAeJ4Ufsdz5NqtK0cy7TAzgDy
 P83jJK1G2Rge6gASDJM0fePbQhGE09BrpZQDnzro=
Received: by mx.zohomail.com with SMTPS id 1779284133252925.7316183234259;
 Wed, 20 May 2026 06:35:33 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: [PATCH v2 0/3] Add SCDC information to connector debugfs
Date: Wed, 20 May 2026 15:35:13 +0200
Message-Id: <20260520-scdc-link-health-v2-0-511af18cd64b@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WOTQ6CMBCFr0Jm7WgLiujKexgXpQx2tFBtK9EY7
 m5Fdq4mL/N+vjcE8kwB9tkbPA0c2PVJ5IsMtFH9mZCbpCEXeSnWssCgG42W+ysaUjYarHZFesm
 i2ZUaUuzmqeXnVHk8/XR41BfS8dszOzzdH2kr/mxQq0CoXddx3GeN7zDybTVf+JYYDtH514Q5y
 CkzE23+iQaJAivaFpKqilQrDtpZq2rn1TKNwGkcxw9n/TWV+QAAAA==
X-Change-ID: 20260413-scdc-link-health-89326013d96c
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Daniel Stone <daniel@fooishbar.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.15.2
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

HDMI uses the DDC I2C bus for communicating various bits of link status
out of band with the actual HDMI video signal. This information can be
useful for debugging issues like questionable cables sabotaged by feline
teeth, Enthusiast Grade cables made of cow fencing wire, and other such
problems that ruin one's media viewing plans.

Consequently, this series exposes various bits of pertinent information
from the SCDC protocol in an HDMI connector's debugfs. To continually
poll the link status, userspace can poll the debugfs file.

---
Changes in v2:
- Add HDMI 2.1 SCDC status reporting
- Link to v1: https://patch.msgid.link/20260415-scdc-link-health-v1-0-8e731e88eaf0@collabora.com

To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Andrzej Hajda <andrzej.hajda@intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
To: Robert Foss <rfoss@kernel.org>
To: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
To: Jonas Karlman <jonas@kwiboo.se>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Daniel Stone <daniel@fooishbar.org>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: kernel@collabora.com
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

---
Nicolas Frattaroli (3):
      drm/scdc-helper: Add scdc_status debugfs entry
      drm/display: bridge_connector: init scdc debugfs for HDMI
      drm/scdc-helper: Implement parsing and printing HDMI 2.1 fields

 drivers/gpu/drm/display/drm_bridge_connector.c |   4 +
 drivers/gpu/drm/display/drm_scdc_helper.c      | 341 +++++++++++++++++++++++++
 include/drm/display/drm_scdc.h                 |   9 +
 include/drm/display/drm_scdc_helper.h          | 113 ++++++++
 4 files changed, 467 insertions(+)
---
base-commit: 7d39df83e93eba14a23b1fb6ffff076eb191f27b
change-id: 20260413-scdc-link-health-89326013d96c

Best regards,
--  
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

