Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59ADBCD5BC8
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 10:20:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEA2C10E186;
	Tue, 26 May 2026 10:20:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="fivFZDl1";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E4C710E186
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 10:20:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779790826; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=WVeKtsK3w3GiySd0N2NFtZVTGtPFVDc53tjDDjjSlE8NcjxmHz2BogEJzW6SUEp2T2VhWroulGCJ57LlRK3W/l15gp5wjtiwPjP1hDUqIMfN7cozXex3zwr1eDng/mXRb0GBDcHo/jTBWAlyhp8v8/xxBl3tYEI4MdxEeOdvoFA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779790826;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=h3ONQKNZedByi4cctJEY3O+tdeJyYQGllqWFhAoyvcQ=; 
 b=QdCf9I8x0Jdz75NtLjh4aJGrFfjUanXhmx3i3vJ1sA4czpV8PUR5aSV0ct0nkPoDkfzluY4ejC+ieZH2guqT6wpnd3+gngr9RDUnWzPlG4x7hRf4ihhVoMI9vjqyF0ZsGFvTwhGrGCsLwSJUacJQCav4TtzyCj6MXbUPEA2H5eM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779790826; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=h3ONQKNZedByi4cctJEY3O+tdeJyYQGllqWFhAoyvcQ=;
 b=fivFZDl1GddsvdAFDocU8q+xZ6Ytuk+nRteo4jOjbxPvVEyypEorsOz9628mQf+A
 cTRCbcE/SlpSCwIx+0FwyQpVEaomXRJtaUB+WaZU508Y++xxhVCwW1d2a/O1oWrUr+Q
 uEpp2ja4WvFh6g0T6E/AO58T6wauf1DznihtW2Dc=
Received: by mx.zohomail.com with SMTPS id 1779790823862385.29510544553034;
 Tue, 26 May 2026 03:20:23 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: [PATCH v3 0/4] Add SCDC information to connector debugfs
Date: Tue, 26 May 2026 12:19:56 +0200
Message-Id: <20260526-scdc-link-health-v3-0-59e4a4aaead1@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22OzW7CMBCEXyXymS3+IcFw4j2qHhx70ywkMdgmA
 qG8e02IVKnltBrtzDfzYBEDYWT74sECjhTJD1moVcFsa4ZvBHJZM8llxTdCQbTOQkfDCVo0XWp
 B71R+CeV2lWU5dg7Y0G1Gfn69dLzWR7TpyVkcAS/X3JVeNlabiGB931PaFy70kOi8Xi57QlqKy
 Yf7PHMUc2ZZVP5fNArgoHGrBGqNpuEH67vO1D6Yj1wyA0f5CyklfwORGVIKYRqhras29V/INE0
 /L3DQLD4BAAA=
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
 kernel@collabora.com, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Daniel Stone <daniels@collabora.com>
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
Changes in v3:
- Add patch to change return type of drm_scdc_read/write.
- Rework error counter reading to duplicate less code.
- Also check lane 3 counter valid flag when reading its error counter.
- Use memset to clear buf for error counters, rather than doing it in
  the loop.
- Make read_error_counters not accept 0 as num_lanes; fix it up in the
  caller instead.
- Link to v2: https://patch.msgid.link/20260520-scdc-link-health-v2-0-511af18cd64b@collabora.com

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
Nicolas Frattaroli (4):
      drm/scdc-helper: Don't use ssize_t return type for scdc_read/write
      drm/scdc-helper: Add scdc_status debugfs entry
      drm/display: bridge_connector: init scdc debugfs for HDMI
      drm/scdc-helper: Implement parsing and printing HDMI 2.1 fields

 drivers/gpu/drm/display/drm_bridge_connector.c |   4 +
 drivers/gpu/drm/display/drm_scdc_helper.c      | 358 ++++++++++++++++++++++++-
 include/drm/display/drm_scdc.h                 |   9 +
 include/drm/display/drm_scdc_helper.h          | 121 ++++++++-
 4 files changed, 484 insertions(+), 8 deletions(-)
---
base-commit: 587c82eb2067eff6f13385e1b7cf49fc6c3febbc
change-id: 20260413-scdc-link-health-89326013d96c

Best regards,
--  
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

