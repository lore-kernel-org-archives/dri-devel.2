Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96831F532F6
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 08:58:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF6AC10E5E5;
	Tue, 24 Mar 2026 08:58:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="P14ISgXe";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EB8710E60B
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 08:58:23 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id E3E564E427C2;
 Tue, 24 Mar 2026 08:58:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id A7ABF6011D;
 Tue, 24 Mar 2026 08:58:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 997C010450F09; Tue, 24 Mar 2026 09:58:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774342700; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=0YYcFvTeFMf/gl+zq/BHt1rzXd/DVu9rJ6SvC4A/yS0=;
 b=P14ISgXetik877thgaUfhyGi/jG5GmZLxbiC6avF1z8ASw5vMqssFrZ41yFePfLRRFnZjA
 Rg7CTW1DJJdOXtwDh5dZEk+DLLrInJlI4pPBEdNpN9HiZ/o/Aozk998wzvLnsnoWiA5PWP
 GmtqH9wOtmmOaihQWrnZ1jLb5G8Thg0TuLgdVxIvEmP0NNqSZJBwg0XKUostrnOKBtJPL1
 Ql28yMacXuMTatrDDkNxquv06/bVdHi6sjCCpvQ+Mz9U4pXqPMS4wAU7CxR8k5g2hkJ3qu
 5GIAkPXb0q6xtmeAimNQwL5MJkBP3B/vsj54EtnJA/NJnTi47UIsU+QAD0Dl8w==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH v5 0/7] drm/bridge: protect encoder bridge chain with a mutex
Date: Tue, 24 Mar 2026 09:58:07 +0100
Message-Id: <20260324-drm-bridge-alloc-encoder-chain-mutex-v5-0-8bf786c5c7e6@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAB9SwmkC/43NTW7DIBCG4atErEs0/Bp31XtEWRgYN0g2VNi1U
 kW+eyeRkrTKxuw+QM97YRPWhBN7311YxSVNqWQa5m3HwqnLn8hTpM0kSAOtNDzWkfuaIr10w1A
 CxxxKxMrpe8p8/J7xzH3jopXgDKJhRH1V7NP5ljkcaZ/SNJf6c6su4np7D9htgUVw4FJ5K4Nul
 LHdhy9lHlLehzKya2KRD1YAqI2sJLZxvrfCOOjAvrLqL9tuZBWxoQWMjdbYY3hl9ZOls5HVxAr
 phULvAvTuP7uu6y+AzzXy3wEAAA==
X-Change-ID: 20250925-drm-bridge-alloc-encoder-chain-mutex-b78d62085ee5
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Ian Ray <ian.ray@gehealthcare.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
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

This series ensures that the bridge chain of the encoder will not be
modified while some other concurrent code flows are iterating over it.

Some patches are already Reviewed-by: Maxime Ripard, some are unreviewed.

== Series description

The per-encoder bridge chain is currently assumed to be static once it is
fully initialized. Work is in progress to support hot-pluggable bridges,
breaking that assumption.

With hotplug and especially hot-unplug, bridges will be added and removed
without notice, and thus be added/removed to/from the encoder chain in
drm_bridge_attach/detach(), concurrently to the code iterating on the
chain. This can result in disruption of the code iterating over the
chain.

Patch 2 has a detailed example to describe the problem.

This series prevents concurrency bugs by introducing a mutex to make list
insertion, removal and iterations mutually exclusive.

== Grand plan

This is part of the work to support hotplug of DRM bridges. The grand plan
was discussed in [0].

Here's the work breakdown (➜ marks the current series):

 1. ➜ add refcounting to DRM bridges struct drm_bridge,
      based on devm_drm_bridge_alloc()
    A. ✔ add new alloc API and refcounting (v6.16)
    B. ✔ convert all bridge drivers to new API (v6.17)
    C. ✔ kunit tests (v6.17)
    D. ✔ add get/put to drm_bridge_add/remove() + attach/detach()
         and warn on old allocation pattern (v6.17)
    E. ➜ add get/put on drm_bridge accessors
       1. ✔ drm_bridge_chain_get_first_bridge(), add cleanup action (v6.18)
       2. ✔ drm_bridge_get_prev_bridge() (v6.18)
       3. ✔ drm_bridge_get_next_bridge() (v6.19)
       4. ✔ drm_for_each_bridge_in_chain() (v6.19)
       5. ✔ drm_bridge_connector_init (v6.19)
       6. ➜ protect encoder bridge chain with a mutex
       7. … of_drm_find_bridge
          a. ✔ add of_drm_get_bridge() (v7.0),
	       convert basic direct users (v7.0-v7.1)
	  b. ✔ convert direct of_drm_get_bridge() users, part 2 (v7.0)
	  c. ✔ convert direct of_drm_get_bridge() users, part 3 (v7.0)
	  d. ✔… convert direct of_drm_get_bridge() users, part 4
	        (some v7.1, some pending)
	  e.   convert bridge-only drm_of_find_panel_or_bridge() users
       8. drm_of_find_panel_or_bridge, *_of_get_bridge
       9. ✔ enforce drm_bridge_add before drm_bridge_attach (v6.19)
    F. ✔ debugfs improvements
       1. ✔ add top-level 'bridges' file (v6.16)
       2. ✔ show refcount and list lingering bridges (v6.19)
 2. … handle gracefully atomic updates during bridge removal
    A. ✔ Add drm_bridge_enter/exit() to protect device resources (v7.0)
    B. … protect private_obj removal from list
    C. ✔ Add drm_bridge_clear_and_put() (v7.1)
 3. … DSI host-device driver interaction
 4. ✔ removing the need for the "always-disconnected" connector
 5. … Migrate i.MX LCDIF driver to bridge-connector
 6.   DRM bridge hotplug
    A.   Bridge hotplug management in the DRM core
    B.   Device tree description

[0] https://lore.kernel.org/lkml/20250206-hotplug-drm-bridge-v6-0-9d6f2c9c3058@bootlin.com/#t

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Changes in v5:
- Improved cover letter and patch 2 commit message
- Rebased and tested on current drm-misc-next (v7.1-rc3)
- Link to v4: https://lore.kernel.org/r/20251111-drm-bridge-alloc-encoder-chain-mutex-v4-0-12b13eb8c0f8@bootlin.com

Changes in v4:
- No patch changes (this series was tested a lot since v3 without issues)
- Added Reviewed-by from Maxime
- Rebased on current drm-misc-next
- Small improvement to kerneldoc for the two for_each macros
- Link to v3: https://lore.kernel.org/r/20251009-drm-bridge-alloc-encoder-chain-mutex-v3-0-c90ed744efec@bootlin.com

Changes in v3:
- Re-added the drm_bridge_put() in the for_each macros, leading to largely
  rewrite them
- Removed the drm_encoder_chain_[un]lock() wrappers
- Fixed a potential ABBA deadlock in patch
- Improved some commit messages
- Link to v2: https://lore.kernel.org/r/20251003-drm-bridge-alloc-encoder-chain-mutex-v2-0-78bf61580a06@bootlin.com

Changes in v2:
- Improve commit messages and add documentation as per v1 review
- Patch 4: fixed infinite loop when encoder->bridge_chain is empty
- Link to v1: https://lore.kernel.org/r/20250926-drm-bridge-alloc-encoder-chain-mutex-v1-0-23b62c47356a@bootlin.com

---
Luca Ceresoli (7):
      drm/encoder: add mutex to protect the bridge chain
      drm/encoder: drm_encoder_cleanup: lock the encoder chain mutex during removal
      drm/bridge: drm_bridge_attach: lock the encoder chain mutex during insertion
      drm/bridge: lock the encoder chain in scoped for_each loops
      drm/bridge: prevent encoder chain changes while iterating with list_for_each_entry_from()
      drm/bridge: prevent encoder chain changes while iterating with list_for_each_entry_reverse()
      drm/bridge: prevent encoder chain changes in pre_enable/post_disable

 drivers/gpu/drm/drm_bridge.c  | 83 ++++++++++++++++++++++---------------------
 drivers/gpu/drm/drm_encoder.c | 18 ++++++++--
 include/drm/drm_bridge.h      | 73 +++++++++++++++++++++++--------------
 include/drm/drm_encoder.h     |  4 +++
 4 files changed, 109 insertions(+), 69 deletions(-)
---
base-commit: f6d00f979306cb9baf5ab3d4f61dd34857e78c13
change-id: 20250925-drm-bridge-alloc-encoder-chain-mutex-b78d62085ee5

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>

