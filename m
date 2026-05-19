Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D240ACD4F57
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 10:38:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1968F10EC0E;
	Tue, 19 May 2026 10:38:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="oVyM9Ujh";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7D4910EC0B
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 10:38:07 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 2E03A4E42CF1;
 Tue, 19 May 2026 10:38:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E81E6606E9;
 Tue, 19 May 2026 10:38:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1E240107E8AB2; 
 Tue, 19 May 2026 12:37:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1779187083; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=2HHwOejiA0v96EaB9cJgeNaDUC0EGsbdFq71eccbvCI=;
 b=oVyM9UjhG5nU/qJDP9Dyr8xpxqY85zTlYabmB1DqVUxiGuKfLtfYNlNi3nGaRR7YhRJ9X+
 vFxPXnXc7J7y3hPpowFRhn0gwjw6qqakaGelEq1M2ohDqon7ETgj9VOhLsaHdFMLIFgqcO
 9cM1GAhHLemMRPxGfACUNx8xJ1koeIgNPmH58VtXIXSUQo9JMdqkufodItqMtlkHYHWWJE
 xDbJIcRY4rp3m/GPyyK3r9C7L5ivAoaF4h25MhF1yNitCFAho1NKVSx57yo3GbXv9IEpI+
 PQt3UqiRDF/+EEQwTe4m9zs/IP7KX8QJdu7pHzWdn/Qdv3CmzFQboomAPeWnDA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH 00/37] drm bridge hotplug
Date: Tue, 19 May 2026 12:37:17 +0200
Message-Id: <20260519-drm-bridge-hotplug-v1-0-45e2bdb3dfb4@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAF09DGoC/y2N2wqDMBBEf0X22YDGJoi/UnxQs+oWb90kIoj/3
 m3r42FmzpzgkQk9VMkJjDt5WheBPE2gG5tlQEVOGHSmbWZyoxzPqmVykoxr2KY4qIfV1rii0X1
 pQIYbY0/HT/qs/+xj+8IufE13g/Ed5S3ctev6AEYmRBOLAAAA
X-Change-ID: 20260515-drm-bridge-hotplug-46265d3a2f85
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, Marek Vasut <marex@denx.de>, 
 Stefan Agner <stefan@agner.ch>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.15.2
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

Hello,

this series adds support for Linux-based devices with a DRM pipeline whose
final components, including one or more bridges, can be hot-plugged and
hot-unplugged.

TL;DR:

 * This new approach is totally different from the one proposed in the
   past [0], and the code is an almost completely rewrite
 * If you already know the use case, feel free to skip to the "Design"
   section below

Use case
========

This series targets as its first use case a professional product (GE SUNH)
that is composed of a "main" part, with the main SoC and able to work
autonomously with limited features, and an optional "add-on" that enables
more features by adding more hardware peripherals.

The hotplug connector has a MIPI DSI bus. The addon has a DSI-to-LVDS
bridge and an LVDS panel attached to it. Different addon models can have
different components. As a consequence, a DRM bridge must be added and
removed at runtime without tearing down the whole card. This is currently
not possible, and this series enables it.

DRM already supports pipelines whose display can be removed, but all the
components preceding it (all the display controller and any bridges) are
assumed to be fixed and cannot be plugged, removed or modified at
runtime. Additionally, dynamic drm_connectors are supported for DP MST.

This picture summarizes the DRM structure implemented by this series:

 .------------------------.
 |   DISPLAY CONTROLLER   |
 | .---------.   .------. |
 | | ENCODER |<--| CRTC | |
 | '---------'   '------' |
 '------|-----------------'
        |              MACHANICAL
        |DSI            HOTPLUG
        V              CONNECTOR
   .---------.        .--.    .-.        .---------.         .-------.
   | 0 to N  |        | _|   _| |        | 1 to N  |         |       |
   | BRIDGES |--DSI-->||_   |_  |--DSI-->| BRIDGES |--LVDS-->| PANEL |
   |         |        |  |    | |        |         |         |       |
   '---------'        '--'    '-'        '---------'         '-------'

 [--- fixed components --]  [----------- removable add-on -----------]

The video bus is MIPI DSI in the example and in the implementation provided
by this series, but the implementation is meant to allow generalization to
other video busses without native hotplug support, such as parallel video
and LVDS. Addons which terminate with a HDMI/DP connector are possible too.

== Design

The old approach [0] was based on a hotplug-bridge driver, connected
between the last fixed bridge and the first removable bridge.

That approach has been rejected, and this new approach is based on a
central place to handle DRM hotplug, not a specific driver.

The drm_bridge_connector is nowadays the recommended way to implement DRM
connectors when a chain of bridges is used. It takes care of adding the
drm_connector when the pipeline is composed by an arbitrarily long chain of
bridges, which it scans to properly implement the drm_connector
operations. 

As such the drm_bridge_connector looked like the ideal component to
implement DRM bridge hotplug. 

This series augments the drm_bridge_connector code to be able to create and
destroy the drm_connector reacting on hot(un)plug events.

== Series description

This series has many preparatory patches: to make the drm_bridge_connector
code allocate the drm_connector dynamically and to prepare various other
parts of the involved DRM code.

In current code the last bridge in the encoder chain is always assumed to
complete the pipeline. There is no way for a bridge to tell "I'm currently
the last bridge in the encoder chain, but I need an next bridge to
work". This series has some patches to allow such a behaviour:

 * bridges can now report whether they conclude the pipeline or not (I
   propose the "tail bridge" naming to tell this)
 * returning -EPROBE_DEFER on bridge attach is not considered a hard error
   anymore, it's normal when the next bridge is needed but not yet present

Compared to the hotplug-bridge approach, now bridge drivers need a bit of
adaptation in order to support that the following bridge is
hotpluggable. So there are a few changes to the samsung-dsim bridge driver,
which in the hardware I'm working on is the last fixed bridge.

Finally, as the current drm_bridge_connector API is unable to support
hotplug, a new API is added to enable the new features. This makes existing
drivers not affected by the changes. The last patch shows to changes needed
to an encoder driver to switch to the new API enabling hotplug support.

== Series layout

 1. Add a dynamic variant of drm_connector_hdmi_init()
    (needed for the bridge-connector to allocate the connector dynamically)

     * drm/connector: split drmm_connector_hdmi_init() in 3 parts
     * drm/connector: add drm_connector_hdmi_dynamic_init()

 2. bridge-connector: split the long drm_bridge_connector_init() in various
    parts in preparation to be called in different ways

     * drm/display: bridge-connector: rename variable for consistency
     * drm/display: bridge-connector: store the drm_device pointer
     * drm/display: bridge-connector: split code creating the connector to a subfunction
     * drm/display: bridge-connector: use a drm_bridge_connector internally, not a drm_connector
     * drm/display: bridge-connector: extract drm_bridge_connector_get_bridges()
     * drm/display: bridge-connector: return int from drm_bridge_connector_get_bridges()
     * drm/display: bridge-connector: extract drm_bridge_connector_init_hdmi_audio_cec()
     * drm/display: bridge-connector: return int from drm_bridge_connector_init_hdmi_audio_cec()
     * drm/display: bridge-connector: return int from drm_bridge_connector_add_connector()

 3. bridge-connector: create the drm_connector dynamically

     * drm/display: bridge-connector: hoist error management to common code
     * drm/display: bridge-connector: move drm_bridge_connector_put_bridges() definition eariler
     * drm/display: bridge-connector: add non-drmm variant of drm_bridge_connector_put_bridges()
     * drm/display: bridge-connector: allocate the connector dynamically
     * drm/display: bridge-connector: move per-connector fields to the dynamic connector
     * drm/display: bridge-connector: protect dynconn creation and destruction with a mutex

 4. samsung-dsim: prepare driver to work when the following bridge is hotpluggable

     * drm/bridge: samsung-dsim: remove the panel_bridge on host_detach
     * drm/bridge: samsung-dsim: move drm_bridge_add() call to probe
     * drm/bridge: samsung-dsim: attach: return -EPROBE_DEFER is next bridge not yet available

 5. Misc preparation work
 
     * drm/bridge: initialize chain_node list head on allocation
     * drm/bridge: initialize chain_node list head on detach and attach errors

 6. drm_bridge: stop pipeline when a bridge is removed

     * drm/encoder: add drm_encoder_cleanup_from()
     * drm/atomic: move drm_atomic_helper_disable_all() and drm_atomic_helper_shutdown() from drm_atomic_helper to drm_atomic
     * drm/bridge: shutdown and cleanup on bridge unplug

 7. Add notifier mechanism to let common code (the bridge-connector)
    take actions on hotplug events

     * drm: event-notifier: add mechanism to notify about hotplug events
     * drm/bridge: notify about detached bridges
     * drm/mipi-dsi: turn DRM_MIPI_DSI into a tristate
     * drm/mipi-dsi: notify about DSI attach

 8. Allow common code to know when the pipeline is complete

     * drm/bridge: add drm_bridge_is_tail() to know whether a bridge completes the pipeline
     * drm/bridge: panel: implement .is_tail
     * drm/bridge: display-connector: implement .is_tail
     * drm/bridge: samsung-dsim: implement .is_tail
     * drm/bridge: ti-sn65dsi83: implement .is_tail

 9. Allow probing incomplete pipelines

     * drm/bridge: drm_bridge_attach(): don't fail on -EPROBE_DEFER

 10. Implement bridge hotplug in bridge-connector, enable it in a driver

     * drm/display: bridge-connector: handle bridge hotplug
     * drm/mxsfb/lcdif: enable bridge hotplug

== Grand plan

This is part of the work to support hotplug of DRM bridges. The grand plan
was discussed in [0].

Here's the work breakdown (➜ marks the current series):

 1. … add refcounting to DRM bridges struct drm_bridge,
      based on devm_drm_bridge_alloc()
    A. ✔ add new alloc API and refcounting (v6.16)
    B. ✔ convert all bridge drivers to new API (v6.17)
    C. ✔ kunit tests (v6.17)
    D. ✔ add get/put to drm_bridge_add/remove() + attach/detach()
         and warn on old allocation pattern (v6.17)
    E. … add get/put on drm_bridge accessors
       1. ✔ drm_bridge_chain_get_first_bridge(), add cleanup action (v6.18)
       2. ✔ drm_bridge_get_prev_bridge() (v6.18)
       3. ✔ drm_bridge_get_next_bridge() (v6.19)
       4. ✔ drm_for_each_bridge_in_chain() (v6.19)
       5. ✔ drm_bridge_connector_init (v6.19)
       6. ✔ protect encoder bridge chain with a mutex (v7.2)
       7. ✔ of_drm_find_bridge
          a. ✔ add of_drm_get_bridge() (v7.0),
               convert basic direct users (v7.0-v7.1)
          b. ✔ convert direct of_drm_get_bridge() users, part 2 (v7.0)
          c. ✔ convert direct of_drm_get_bridge() users, part 3 (v7.0)
          d. ✔ convert direct of_drm_get_bridge() users, part 4 (v7.1-v7.2)
          e. ✔ bridge-only drm_of_find_panel_or_bridge() users (v7.2)
       8.   drm_of_find_panel_or_bridge, *_of_get_bridge
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
 5. ✔ Migrate i.MX LCDIF driver to bridge-connector (v7.2)
 6. ➜ DRM bridge hotplug
    A. ➜ Bridge hotplug management in the DRM core
       1. ✔ bridge-connector: attach encoder to the connector (v7.2)
       2. ➜ drm bridge hotplug
    B.   Device tree description

[0] https://lore.kernel.org/lkml/20250206-hotplug-drm-bridge-v6-0-9d6f2c9c3058@bootlin.com/#t

== Dependencies

This series depends on:

 * "drm/atomic: drm_atomic_private_obj_fini: protect private_obj removal
    from list"
   - https://lore.kernel.org/lkml/20260324-drm-bridge-atomic-vs-remove-private_obj-v3-1-64deefe84044@bootlin.com/
   - Reason: avoid sporadic deadlock

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Luca Ceresoli (37):
      drm/connector: split drmm_connector_hdmi_init() in 3 parts
      drm/connector: add drm_connector_hdmi_dynamic_init()
      drm/display: bridge-connector: rename variable for consistency
      drm/display: bridge-connector: store the drm_device pointer
      drm/display: bridge-connector: split code creating the connector to a subfunction
      drm/display: bridge-connector: use a drm_bridge_connector internally, not a drm_connector
      drm/display: bridge-connector: extract drm_bridge_connector_get_bridges()
      drm/display: bridge-connector: return int from drm_bridge_connector_get_bridges()
      drm/display: bridge-connector: extract drm_bridge_connector_init_hdmi_audio_cec()
      drm/display: bridge-connector: return int from drm_bridge_connector_init_hdmi_audio_cec()
      drm/display: bridge-connector: return int from drm_bridge_connector_add_connector()
      drm/display: bridge-connector: hoist error management to common code
      drm/display: bridge-connector: move drm_bridge_connector_put_bridges() definition eariler
      drm/display: bridge-connector: add non-drmm variant of drm_bridge_connector_put_bridges()
      drm/display: bridge-connector: allocate the connector dynamically
      drm/display: bridge-connector: move per-connector fields to the dynamic connector
      drm/display: bridge-connector: protect dynconn creation and destruction with a mutex
      drm/bridge: samsung-dsim: remove the panel_bridge on host_detach
      drm/bridge: samsung-dsim: move drm_bridge_add() call to probe
      drm/bridge: samsung-dsim: attach: return -EPROBE_DEFER is next bridge not yet available
      drm/bridge: initialize chain_node list head on allocation
      drm/bridge: initialize chain_node list head on detach and attach errors
      drm/encoder: add drm_encoder_cleanup_from()
      drm/atomic: move drm_atomic_helper_disable_all() and drm_atomic_helper_shutdown() from drm_atomic_helper to drm_atomic
      drm/bridge: shutdown and cleanup on bridge unplug
      drm: event-notifier: add mechanism to notify about hotplug events
      drm/bridge: notify about detached bridges
      drm/mipi-dsi: turn DRM_MIPI_DSI into a tristate
      drm/mipi-dsi: notify about DSI attach
      drm/bridge: add drm_bridge_is_tail() to know whether a bridge completes the pipeline
      drm/bridge: panel: implement .is_tail
      drm/bridge: display-connector: implement .is_tail
      drm/bridge: samsung-dsim: implement .is_tail
      drm/bridge: ti-sn65dsi83: implement .is_tail
      drm/bridge: drm_bridge_attach(): don't fail on -EPROBE_DEFER
      drm/display: bridge-connector: handle bridge hotplug
      drm/mxsfb/lcdif: enable bridge hotplug

 drivers/gpu/drm/Kconfig                        |   7 +-
 drivers/gpu/drm/Makefile                       |   2 +
 drivers/gpu/drm/bridge/display-connector.c     |   7 +
 drivers/gpu/drm/bridge/panel.c                 |   8 +-
 drivers/gpu/drm/bridge/samsung-dsim.c          |  36 +-
 drivers/gpu/drm/bridge/ti-sn65dsi83.c          |   7 +
 drivers/gpu/drm/display/drm_bridge_connector.c | 835 +++++++++++++++++--------
 drivers/gpu/drm/drm_atomic.c                   | 115 ++++
 drivers/gpu/drm/drm_atomic_helper.c            |  76 +--
 drivers/gpu/drm/drm_bridge.c                   |  47 +-
 drivers/gpu/drm/drm_connector.c                | 155 +++--
 drivers/gpu/drm/drm_encoder.c                  |  38 ++
 drivers/gpu/drm/drm_event_notifier.c           |  58 ++
 drivers/gpu/drm/drm_mipi_dsi.c                 |   3 +
 drivers/gpu/drm/mxsfb/lcdif_drv.c              |   8 +-
 include/drm/bridge/samsung-dsim.h              |   2 +
 include/drm/drm_atomic.h                       |   3 +
 include/drm/drm_bridge.h                       |  19 +
 include/drm/drm_bridge_connector.h             |   2 +
 include/drm/drm_connector.h                    |   9 +
 include/drm/drm_encoder.h                      |   1 +
 include/drm/drm_event_notifier.h               |  36 ++
 22 files changed, 1078 insertions(+), 396 deletions(-)
---
base-commit: 289b9a790d52a6865db3006f07922a9191faa54e
change-id: 20260515-drm-bridge-hotplug-46265d3a2f85

Best regards,
--  
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

