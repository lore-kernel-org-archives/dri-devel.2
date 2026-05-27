Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC7BCD5BD5
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 14:04:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D8D210E07D;
	Wed, 27 May 2026 14:04:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="glzkbYf5";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED01510E07D
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 14:04:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779890643; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mbFsPGXiVxIRAkUsziETjscP64TWXR5RP3TXbWQHt9Qj2WN5J78ZRXKQWxqRWscJvVGT04qC0SRS/5/Y8hhrtNGKzQ9i7RCpwMphlJwzsBDkmup3SobKIewhSnuxPjMjq8J8WpWUUeUgLnoBAoI0NM5ExhP+zH2nhzTy4tDVHCw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779890643;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=imyabtFRE3JrFNbS4iRw295chjV3YaK1QVQezGG8UpM=; 
 b=DbfTadOPRRz7bczRSytDz1A84fbpc6ViWiGvMOy6X7aWTZDz8LzqfapDTgx8nhCDrnd2iuH2JTty5A3Cq20nhd8Uo1CBPHhsrLgXM52LdlxLELxei0wI3iLkXvxF4Pj2OWdpZPx6G5xjRl8TE0Vtf2ajTSzpbsII5Z4GkghPEgg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779890643; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=imyabtFRE3JrFNbS4iRw295chjV3YaK1QVQezGG8UpM=;
 b=glzkbYf5Q4fP2211d8jc34No0X7P04RV059vxQzfm+lT6za4V705mM2JILtvlQEm
 Rgcf+yxrAvvsPvIsEUCKXho34vkA8ushgsHA7zLbS/c4P0OqJWaM6FdIEaNayMlKbdR
 hU9DYUZOQT9G5/d2rizyfjCNYCgy/3okWPTq8ICU=
Received: by mx.zohomail.com with SMTPS id 1779890641633377.0495591080544;
 Wed, 27 May 2026 07:04:01 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: [PATCH v4 0/4] Add SCDC information to connector debugfs
Date: Wed, 27 May 2026 16:03:41 +0200
Message-Id: <20260527-scdc-link-health-v4-0-622ea40a1f59@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23OTW6DMBAF4Ksgr+vUf1CTVe9RdTHYQ3ELOLUd1
 Cri7jEEKVHLynryzDfvQiIGh5EciwsJOLno/JiDeiqI6WD8QOpszkQwUTHFJY3GGtq78Yt2CH3
 qqK5l/uLS1pUhee0UsHU/K/n2fsvx3HyiSYuzTQT8Pudb6TZGGohIjR8Gl46FDQNN7vS8vWRBO
 heTD79rzYmvO1uj8n+jiVNGNb5IjlojtOzV+L6Hxgc45CMrOIk7Ugq2g4iMlJxDy7WxlWr2EPm
 IVDuIXJAaFSgABMv/IvM8XwEvqFhogwEAAA==
X-Change-ID: 20260413-scdc-link-health-89326013d96c
To: Jani Nikula <jani.nikula@linux.intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
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
Changes in v4:
- Don't use C struct bitfields for parsing status flags. Switch to
  bitwise AND for boolean flags, and FIELD_GET for multi-bit values.
- Drop the superfluous !! and parens
- Drop the __pure attributes on static functions
- Initialise stack local arrays with {}, not { 0 }.
- I've kept the print macros and %-30s format. Reason being that I don't
  want to repeat the format specifier and str_yes_no(foo) a bunch, and I
  like the %-30s format because it means all values are aligned with the
  value of the longest field, which is 30 chars long.
- Link to v3: https://patch.msgid.link/20260526-scdc-link-health-v3-0-59e4a4aaead1@collabora.com

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

To: Jani Nikula <jani.nikula@linux.intel.com>
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
 drivers/gpu/drm/display/drm_scdc_helper.c      | 377 ++++++++++++++++++++++++-
 include/drm/display/drm_scdc.h                 |  16 +-
 include/drm/display/drm_scdc_helper.h          | 105 ++++++-
 4 files changed, 493 insertions(+), 9 deletions(-)
---
base-commit: 971288d0e77f7a0d356287121ce549ab5dad570a
change-id: 20260413-scdc-link-health-89326013d96c

Best regards,
--  
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

