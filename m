Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01587C4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 08:59:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49AEA10E2B4;
	Tue, 21 Jul 2026 08:59:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="jLmoZl36";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5A6310E2B4
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 08:59:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784624360; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=TpmxDqB+9PXZf/5XfSWtzkLrrooh4dsvgjznOOwq96//U8+bINkZWw5qvolj/OjnIcxyLuvgc1Y0tEAMGjtyBcIInBI03WJDUKoaaIQEPFsCxrNClwzYf4iRlgNZw0oFKXd8Ab0L3Uc5C1cvddkfVad1vMHQ6i5awJm3aWmeTQw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784624360;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=0zQlbPcaMiJ1gejg/GHI2kq1vW7b6hSbSPF7DRaFsjQ=; 
 b=lHGUwE5asFF3LVbG1zlZEBUspHPE+m0DROdpNeHu+iZ3oJqpUxoS84pUZ06Vy+iFGwkPxxCRa9fKJOvKd2sTYBcnVU7GIAB+08IL1+fGG9Ypc3JqF6bs/OkUy3Ebx61oTgJk6k+QTWstcjgHw+ReIhO1L8d88IPdtOFtbDJLZtU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784624360; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=0zQlbPcaMiJ1gejg/GHI2kq1vW7b6hSbSPF7DRaFsjQ=;
 b=jLmoZl36LGvQN/IDbK+6ZrBO8I5+xcUFEf1cIw12EHLf1oDD8yU2hoUwZrWgBXeZ
 f9pA5qx+a2kPVhn0JvAzlXQWyZf1k1MPC6H5g/MD5iuNArVzumknmoyql9Yzsg8yjeQ
 6g35nEw8Mb8pK7TCH3TnDCDW2CKhq8KahrzozEUU=
Received: by mx.zohomail.com with SMTPS id 1784624358563570.7228757268492;
 Tue, 21 Jul 2026 01:59:18 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: [PATCH v7 0/5] Add SCDC information to connector debugfs
Date: Tue, 21 Jul 2026 10:58:56 +0200
Message-Id: <20260721-scdc-link-health-v7-0-92df1b6ad5fc@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23QzW7CMAwH8FdBOS9bnK+2nPYe0w5u4q7ZCoWkV
 JsQ7760IIFETpEV++e/fGaJYqDEtpszizSHFMZ9LqqXDXM97r+IB59rJoW0QoPiyXnHh7D/4T3
 hMPW8blT+AuUb61geO0Tqwu9Kfnxe63Rqv8lNi3PriHQ85V3TtY21mIi7cbcL03bj445P4fB2e
 9mC9CFNY/xbY86wztwSmedEM3DBa6oUUF0TduLdjcOA7RjxNS9ZwVneESNFAZEZMQDYQe281W0
 JUY+ILSBqQRrSqBEJPZQQ/YhUBURnxEpJqAVCZ5oSYu5IvkoBMRkBgEq1Ap3yVELsAwJQQOySR
 Imqrgza1jwhl8vlHwCYTFRSAgAA
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
 Daniel Stone <daniel@fooishbar.org>, 
 Hans Verkuil <hverkuil+cisco@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
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
Changes in v7:
- Move HDMI debugfs registration to new state helper, fix up all users
  (sun4i, vc4, bridge)
- Register scdc debugfs in new hdmi debugfs helper
- Link to v6: https://patch.msgid.link/20260611-scdc-link-health-v6-0-6307875a6b5e@collabora.com

Changes in v6:
- Fix off-by-one error in drm_scdc_read_state
- Link to v5: https://patch.msgid.link/20260604-scdc-link-health-v5-0-11173b0ac3de@collabora.com

Changes in v5:
- Read all SCDC data regardless of update flags
- Dump SCDC data as hex before the human-readable output. It's separated
  with "\n----------------\n\n".
- No longer write 0 to read-only registers
- Add Reed-Solomon Corrections counter parsing
- Parsing has been kept. A desire was expressed to get this data without
  any external userspace tooling, and the kernel will need to parse it
  eventually anyway to set the link status.
- Functions have been made static as of right now, since external users
  may do another pass over the function signatures anyway.
- Link to v4: https://patch.msgid.link/20260527-scdc-link-health-v4-0-622ea40a1f59@collabora.com

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
To: Hans Verkuil <hverkuil+cisco@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>
To: Samuel Holland <samuel@sholland.org>
To: Dave Stevenson <dave.stevenson@raspberrypi.com>
To: Maíra Canal <mcanal@igalia.com>
To: Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: kernel@collabora.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-sunxi@lists.linux.dev
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

---
Nicolas Frattaroli (5):
      drm/scdc-helper: Don't use ssize_t return type for scdc_read/write
      drm/scdc-helper: Add scdc_status debugfs entry
      drm/scdc-helper: Implement parsing and printing HDMI 2.1 fields
      drm/debugfs: Move HDMI debugfs registration to state helper
      drm/display: hdmi-state-helper: Init SCDC debugfs for HDMI

 drivers/gpu/drm/display/drm_bridge_connector.c  |   3 +
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 156 +++++++++++++
 drivers/gpu/drm/display/drm_scdc_helper.c       | 285 +++++++++++++++++++++++-
 drivers/gpu/drm/drm_debugfs.c                   | 157 -------------
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c          |   1 +
 drivers/gpu/drm/vc4/vc4_hdmi.c                  |   1 +
 include/drm/display/drm_hdmi_state_helper.h     |   3 +
 include/drm/display/drm_scdc.h                  |  21 +-
 include/drm/display/drm_scdc_helper.h           | 103 ++++++++-
 9 files changed, 564 insertions(+), 166 deletions(-)
---
base-commit: 97aed8a757dcf4d64b13c6387637821a2888586e
change-id: 20260413-scdc-link-health-89326013d96c

Best regards,
--  
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

