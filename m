Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B6B1CC6B12
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 17:58:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1DF410E15A;
	Tue, 13 Oct 2026 17:58:14 +0000 (UTC)
X-Greylist: delayed 589 seconds by postgrey-1.36 at gabe;
 Tue, 13 Oct 2026 17:58:04 UTC
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 368B210E15A
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 17:58:04 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 7870AC653F4
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 17:49:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D658B60362
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 17:48:13 +0000 (UTC)
Received: by mail.galae.net (Postcow, from userid 0)
 id 778C011D70C37; Tue, 13 Oct 2026 19:47:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1791913693; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=GGIXi1kV+kCR2h5S/gUS/WOZ0+fEirhDT48WZLYxblo=;
 b=Ndz5X1AfFKZXdlMdtpJMWjrB4KfJu9atB5k/o08nPiNmgioP8a5IOBCwrOmqKapAr7KnID
 GdXrrz659A0B8klvCXpJ2U4e/gy8bZFGwrKTplQWNtZZk4gZJRlxjXmVLVkhR+IrHc367p
 vdGbR1h1TcRXmsQV5qWbMVLb8P5LXUbd2zHH7pZgjlJx9LiRsdogjPtwsBiPrf8p/RqE62
 MXnPE60ajnlvlkR6J6eUEnXnzNsMOjac+DS9zm6I7UV8BD1UgLYmeo6jqecWbTXdrzYAi5
 txvKToNc1rIQDyAe2WdMbc4iDIS/DUij2wo6N+CnRK9/PIW4S4M6od2vXmroXQ==
Authentication-Results: mail.galae.net;
	none
Received: from mail.galae.net ([172.22.1.253]) by 9e7fea892943 with LMTP
 id sLJDIqL4zGr4hhEAtaWaaQ (envelope-from <kory.maincent@bootlin.com>)
 for <kory.maincent@bootlin.com>; Mon, 12 Oct 2026 17:11:30 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B398E11D7012D; 
 Mon, 12 Oct 2026 17:11:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1791817884; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=GGIXi1kV+kCR2h5S/gUS/WOZ0+fEirhDT48WZLYxblo=;
 b=aHgUcb7RjoE/3nkLUjCiPBxyqhUMjDqJPhCa+pN1b8fpTJD/gqSpx+YouaDkYQA/mTax/5
 R0+c3I8S9sYnzcBIxbWGuvToSypTC1NNzkvSMtbkKE1mhJ6V2+n2DwozTaXHcQH7yYzBxV
 29jZ6mJhfARl0PQTBVOBsJCpl1IMd4d1vQjlE911WlQchP5bj5ZIH9RcZolFykQoL+PKrJ
 5dBcEpD5k3Cu+76dmJkIckEM2wvQQgSali2uYyBX8veRRztGpC+dJEgQQg3GA2kltLTsfz
 YxUR7a09D11CyahwWY9ML4kF82hL+VG5DqE+T05Cyp/JahZaAAe3nRa7KbPTow==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH RFC v3 0/8] Add support for DisplayPort link training
 information report
Date: Mon, 12 Oct 2026 17:10:55 +0200
Message-Id: <20261012-feat_link_cap-v3-0-7517f4aba0f3@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAH/4zGoC/2WNQQrCMBREr1L+2kjyW6JxJQgewK1ISZNfG9Smp
 CUopXc3ZCPqcmZ4b2YYKTgaYVfMECi60fk+hXJVgOl0fyXmbMqAHCVHlKwlPdV3199qoweG3DS
 NbEthKw6JGQK17pl9ZzgdD3BJZefGyYdX/ogiT1lXcfWji4JxtuFS0VYoZQj3jfdTmtfGP7Ir4
 oeX4o/HxOvSkqkMR23VN78syxv9+9NJ8QAAAA==
X-Change-ID: 20260226-feat_link_cap-20cbb6f31d40
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Daniel Stone <daniels@collabora.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mark Yacoub <markyacoub@google.com>, Sean Paul <seanpaul@google.com>, 
 Manasi Navare <navaremanasi@google.com>, 
 Drew Davenport <ddavenport@google.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.16.1-dev-17221
X-Last-TLS-Session-Version: TLSv1.3
X-Last-TLS-Session-Version: None
X-Rspamd-Queue-Id: 778C011D70C37
X-Spamd-Result: default: False [2.48 / 30.00]; SUSPICIOUS_RECIPS(1.50)[];
 DATE_IN_PAST(1.00)[26]; RCVD_NO_TLS_LAST(0.10)[];
 MIME_GOOD(-0.10)[text/plain]; BAYES_HAM(-0.02)[49.01%];
 BCC(0.00)[]; TAGGED_RCPT(0.00)[];
 DKIM_SIGNED(0.00)[bootlin.com:s=dkim];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FORWARDED(0.00)[kory.maincent@bootlin.com]; ARC_NA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[35]; MIME_TRACE(0.00)[0:+];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_TO(0.00)[linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,intel.com,ursulin.net,linaro.org,ideasonboard.com,kwiboo.se,bootlin.com,pengutronix.de,collabora.com];
 MID_RHS_MATCH_FROM(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[kory.maincent@bootlin.com];
 TO_MATCH_ENVRCPT_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_DN_SOME(0.00)[];
 URIBL_BLOCKED(0.00)[bootlin.com:email,bootlin.com:mid,bootlin.com:url,localhost:rdns,localhost:helo,msgid.link:url];
 MAILCOW_DOMAIN_HEADER_FROM(0.00)[bootlin.com];
 RECEIVED_HELO_LOCALHOST(0.00)[]; NEURAL_HAM(-0.00)[-1.000];
 FROM_EQ_ENVFROM(0.00)[]
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

DisplayPort link training negotiates the physical-layer parameters needed
for a reliable connection: lane count, link rate, and optionally Display
Stream Compression (DSC). Currently, each driver exposes this state in
its own way, often through driver-specific debugfs entries, with no
standard interface for userspace diagnostic and monitoring tools.

This series introduces generic helpers, for exposing DP link capabilities
and state as standard sysfs entries.

The aim of such development is to guide users to select the most suitable
DisplayPort connector for their needs. For example, if you have a USB-C
hub with lesser capabilities than your computer’s native DisplayPort
connector (such as HBR2 versus HBR3 support), the system could recommend
connecting high-resolution displays directly to the computer’s port
instead of through the hub to ensure optimal performance.

The new drm_dp_source_set_caps and drm_dp_sink_set_caps helper expose
source and sink training capabilities to userspace via sysfs attributes
under dp_link. Finally drm_dp_set_cur_link_params helper is provided to
report current link information at runtime.

Three drivers are updated as reference implementations: i915 (direct
connector path), ANX7625 and MediaTek (via the bridge connector framework
using a new DRM_BRIDGE_OP_DP flag).

Here is a sysfs example:

cur_link_info_dsc            sink_link_caps_nlanes
cur_link_info_link_rate      source_link_caps_dsc
cur_link_info_nlanes         source_link_caps_link_rates
sink_link_caps_dsc           source_link_caps_nlanes
sink_link_caps_link_rates

1620000 2160000 2700000 3240000 4320000 5400000

1620000 2700000 5400000 10000000 20000000

5400000

This series is rebased on top of drm-misc and may conflict with the
current state of the drm i915 tree. Which tree should pick this up,
given that it mixes core development with driver changes?

Patch 1,2: Move helpers out of i915
Patch 3: Introduce DisplayPort link training capabilities and state helpers
Patch 4: Read i915 DSC capabilities in any case
Patch 5  Use dp_connector helpers in i915 to expose link training state
Patch 6: Introduce DRM_BRIDGE_OP_DP and wire bridge connectors
Patch 7: Use dp_connector helpers in anx7625 to expose link training state
Patch 8: Use dp_connector helpers in mediatek to expose link training state

Changes in v3:
- Rework the core to use new helpers instead of an extension of
  drmm_connector_init().
- Add a new mutex to protect sysfs read write access instead of using
  the global connection_mutex.
- Move helpers out of i915.
- Add the support in the anx7625 driver.
- Link to v2: https://patch.msgid.link/20260619-feat_link_cap-v2-0-a3dec4c02ad9@bootlin.com

Changes in v2:
- Removed work converting i915 to DRM managed resource
- Remove voltage swing and pre-emphasis properties
- Expose link training state via sysfs dp_link/ group instead of
  connector properties
- Add comprehensive sysfs attributes for both source and sink capabilities
- Add new helpers for managing sink capabilities and for current link
  parameters
- Link to v1: https://lore.kernel.org/r/20260409-feat_link_cap-v1-0-7069e8199ce2@bootlin.com

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Kory Maincent (8):
      drm: Move sink link rates reading helpers out of i915
      drm: Move DSC capability reading helper out of i915
      drm: Introduce DisplayPort link training capabilities and state helpers
      drm/i915/display/dp: Read DPCD DSC capabilities in any case
      drm/i915/display/dp: Use dp_connector helpers to expose link training state
      drm/bridge: Expose link training state via new DRM_BRIDGE_OP_DP flag
      drm/analogix/anx7625: Use dp_connector helpers to expose link training state
      drm/mediatek: Use dp_connector helpers to expose link training state

 Documentation/ABI/testing/sysfs-class-drm-dp       |  85 +++
 drivers/gpu/drm/bridge/analogix/anx7625.c          |  68 +++
 drivers/gpu/drm/bridge/analogix/anx7625.h          |   1 +
 drivers/gpu/drm/display/Kconfig                    |   1 +
 drivers/gpu/drm/display/drm_bridge_connector.c     |  29 ++
 drivers/gpu/drm/display/drm_dp_helper.c            | 571 +++++++++++++++++++++
 drivers/gpu/drm/drm_connector.c                    |  11 +
 drivers/gpu/drm/drm_sysfs.c                        | 155 ++++++
 drivers/gpu/drm/i915/display/intel_display_types.h |   2 +
 drivers/gpu/drm/i915/display/intel_dp.c            | 249 ++++-----
 .../gpu/drm/i915/display/intel_dp_link_training.c  |  14 +
 drivers/gpu/drm/mediatek/mtk_dp.c                  |  79 ++-
 include/drm/display/drm_dp.h                       |   1 +
 include/drm/display/drm_dp_helper.h                |  25 +
 include/drm/drm_bridge.h                           |  13 +
 include/drm/drm_connector.h                        |  53 ++
 include/drm/drm_sysfs.h                            |   1 +
 17 files changed, 1202 insertions(+), 156 deletions(-)
---
base-commit: 34e9ab0182494d7599dc9759bc216550d814b396
change-id: 20260226-feat_link_cap-20cbb6f31d40

Best regards,
--  
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

