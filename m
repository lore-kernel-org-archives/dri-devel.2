Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D608ECD6E55
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 15:44:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40EE010E5A0;
	Mon,  1 Jun 2026 15:44:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="q+T9gBgc";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB6341134F2
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 15:44:45 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 98795C62479;
 Mon,  1 Jun 2026 15:44:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 683506026B;
 Mon,  1 Jun 2026 15:44:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B45D910888A84; 
 Mon,  1 Jun 2026 17:44:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1780328681; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=vjUe9OR3qvJ4tcQD/mGNwFMxVbel1aCfVYAXd+ym47g=;
 b=q+T9gBgcPSug6dFbRNGMm4UBGtGM19XF0M3FXAjtiK+iwyXRzNpMAxuTjZzLhql/rZUq1f
 yqR/QHu2wdCecwnPN1RdCZNH0M0uptv+rYGj5mgNfha82AyiQJvzhazvPKdcgwC5qwcGXz
 KBUKGeqaz7WdqKtbVK5XBMsU/wREbZXoto6Kv3xNuSZ7n862CVHfm4r37cwe2ZlaR0wrz5
 CTHY9diKKZ4teLgU1CqlzzLXT9UU2aL0kf3qSrILC5VRRs8kSdRS+2oswiJK2WogmikIaH
 JyY58fczpyVTB6EozruKVPVaqp9CtqcgZ1Ygm/JdXKsQoN3qDm+Om1btMuzONQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jun 2026 17:44:31 +0200
Message-Id: <DIXTUCXAU68V.1T7X89LMEUF2F@bootlin.com>
Subject: Re: [PATCH 00/37] drm bridge hotplug
Cc: "Hui Pu" <Hui.Pu@gehealthcare.com>, "Ian Ray"
 <ian.ray@gehealthcare.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <imx@lists.linux.dev>,
 <linux-arm-kernel@lists.infradead.org>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Inki Dae"
 <inki.dae@samsung.com>, "Jagan Teki" <jagan@amarulasolutions.com>, "Marek
 Szyprowski" <m.szyprowski@samsung.com>, "Marek Vasut" <marex@denx.de>,
 "Stefan Agner" <stefan@agner.ch>, "Frank Li" <Frank.Li@nxp.com>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, "Pengutronix Kernel Team"
 <kernel@pengutronix.de>, "Fabio Estevam" <festevam@gmail.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.21.0
References: <20260519-drm-bridge-hotplug-v1-0-45e2bdb3dfb4@bootlin.com>
In-Reply-To: <20260519-drm-bridge-hotplug-v1-0-45e2bdb3dfb4@bootlin.com>
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

I presented this series last Friday during the Display Next Hackfest
2026. Here's a summary of the discussion.

The discussion was mostly with Dmitry Baryshkov (major contributor to the
drm_bridge_connector code) and a bit with Paul Kocialkowski and
others. Thanks all!

The proposal to extend the drm_bridge_connector to implement hotplug, and
the general architecture proposed, raised no objection. So I'm going to
continue with this approach.

There were various implementation aspects discussed, which will be my
focus in the coming weeks:

 * The requirement that bridge drivers (the last bridge before the
   hotplug connector, at least) must return -EPROBE_DEFER when the next
   bridge is not present is risky: some drivers might just defer during
   their probe, potentially generating defer loops.

   * Alternative discussed: bridge drivers can expose info about how to
     find the next bridge (the fwnode perhaps) using a new API, keeping the
     existing untouched. Maybe they could also expose the previous driver
     fwnode, even though it currently seems unnecessary.

   * There are various options about how such new API should look like:
     during registration (drm_bridge_add()? too early for some complex
     drivers?), at attach time (maybe too late?) or as a new callback
     (called when?). In all cases this new API would be a superset of the
     .is_tail callback proposed in patch 30, which would then become
     unnecessary.

 * Dmitry asked whether all the attach chain could be entirely moved to the
   drm_bridge_connector for drivers using it. Worth investigating.

   * I did a quick investigation after the event and it would work nicely
     for many drivers but some are tricky. Needs more understanding.

 * The added drm_atomic_shutdown() is wrong, it would stop streaming on
   all outputs on the card. But it is probably unnecessary, just removing
   the connector should be enough.

That's all according to my notes. Feel free to reply in case I forgot
anything or something is wrong. Expect a v2 in the coming weeks with the
above changes, or discussion in case of unexpected issues.

Kind regards,
Luca


On Tue May 19, 2026 at 12:37 PM CEST, Luca Ceresoli wrote:
> Hello,
>
> this series adds support for Linux-based devices with a DRM pipeline whos=
e
> final components, including one or more bridges, can be hot-plugged and
> hot-unplugged.
>
> TL;DR:
>
>  * This new approach is totally different from the one proposed in the
>    past [0], and the code is an almost completely rewrite
>  * If you already know the use case, feel free to skip to the "Design"
>    section below
>
> Use case
> =3D=3D=3D=3D=3D=3D=3D=3D
>
> This series targets as its first use case a professional product (GE SUNH=
)
> that is composed of a "main" part, with the main SoC and able to work
> autonomously with limited features, and an optional "add-on" that enables
> more features by adding more hardware peripherals.
>
> The hotplug connector has a MIPI DSI bus. The addon has a DSI-to-LVDS
> bridge and an LVDS panel attached to it. Different addon models can have
> different components. As a consequence, a DRM bridge must be added and
> removed at runtime without tearing down the whole card. This is currently
> not possible, and this series enables it.
>
> DRM already supports pipelines whose display can be removed, but all the
> components preceding it (all the display controller and any bridges) are
> assumed to be fixed and cannot be plugged, removed or modified at
> runtime. Additionally, dynamic drm_connectors are supported for DP MST.
>
> This picture summarizes the DRM structure implemented by this series:
>
>  .------------------------.
>  |   DISPLAY CONTROLLER   |
>  | .---------.   .------. |
>  | | ENCODER |<--| CRTC | |
>  | '---------'   '------' |
>  '------|-----------------'
>         |              MACHANICAL
>         |DSI            HOTPLUG
>         V              CONNECTOR
>    .---------.        .--.    .-.        .---------.         .-------.
>    | 0 to N  |        | _|   _| |        | 1 to N  |         |       |
>    | BRIDGES |--DSI-->||_   |_  |--DSI-->| BRIDGES |--LVDS-->| PANEL |
>    |         |        |  |    | |        |         |         |       |
>    '---------'        '--'    '-'        '---------'         '-------'
>
>  [--- fixed components --]  [----------- removable add-on -----------]
>
> The video bus is MIPI DSI in the example and in the implementation provid=
ed
> by this series, but the implementation is meant to allow generalization t=
o
> other video busses without native hotplug support, such as parallel video
> and LVDS. Addons which terminate with a HDMI/DP connector are possible to=
o.
>
> =3D=3D Design
>
> The old approach [0] was based on a hotplug-bridge driver, connected
> between the last fixed bridge and the first removable bridge.
>
> That approach has been rejected, and this new approach is based on a
> central place to handle DRM hotplug, not a specific driver.
>
> The drm_bridge_connector is nowadays the recommended way to implement DRM
> connectors when a chain of bridges is used. It takes care of adding the
> drm_connector when the pipeline is composed by an arbitrarily long chain =
of
> bridges, which it scans to properly implement the drm_connector
> operations.
>
> As such the drm_bridge_connector looked like the ideal component to
> implement DRM bridge hotplug.
>
> This series augments the drm_bridge_connector code to be able to create a=
nd
> destroy the drm_connector reacting on hot(un)plug events.
>
> =3D=3D Series description
>
> This series has many preparatory patches: to make the drm_bridge_connecto=
r
> code allocate the drm_connector dynamically and to prepare various other
> parts of the involved DRM code.
>
> In current code the last bridge in the encoder chain is always assumed to
> complete the pipeline. There is no way for a bridge to tell "I'm currentl=
y
> the last bridge in the encoder chain, but I need an next bridge to
> work". This series has some patches to allow such a behaviour:
>
>  * bridges can now report whether they conclude the pipeline or not (I
>    propose the "tail bridge" naming to tell this)
>  * returning -EPROBE_DEFER on bridge attach is not considered a hard erro=
r
>    anymore, it's normal when the next bridge is needed but not yet presen=
t
>
> Compared to the hotplug-bridge approach, now bridge drivers need a bit of
> adaptation in order to support that the following bridge is
> hotpluggable. So there are a few changes to the samsung-dsim bridge drive=
r,
> which in the hardware I'm working on is the last fixed bridge.
>
> Finally, as the current drm_bridge_connector API is unable to support
> hotplug, a new API is added to enable the new features. This makes existi=
ng
> drivers not affected by the changes. The last patch shows to changes need=
ed
> to an encoder driver to switch to the new API enabling hotplug support.
>
> =3D=3D Series layout
>
>  1. Add a dynamic variant of drm_connector_hdmi_init()
>     (needed for the bridge-connector to allocate the connector dynamicall=
y)
>
>      * drm/connector: split drmm_connector_hdmi_init() in 3 parts
>      * drm/connector: add drm_connector_hdmi_dynamic_init()
>
>  2. bridge-connector: split the long drm_bridge_connector_init() in vario=
us
>     parts in preparation to be called in different ways
>
>      * drm/display: bridge-connector: rename variable for consistency
>      * drm/display: bridge-connector: store the drm_device pointer
>      * drm/display: bridge-connector: split code creating the connector t=
o a subfunction
>      * drm/display: bridge-connector: use a drm_bridge_connector internal=
ly, not a drm_connector
>      * drm/display: bridge-connector: extract drm_bridge_connector_get_br=
idges()
>      * drm/display: bridge-connector: return int from drm_bridge_connecto=
r_get_bridges()
>      * drm/display: bridge-connector: extract drm_bridge_connector_init_h=
dmi_audio_cec()
>      * drm/display: bridge-connector: return int from drm_bridge_connecto=
r_init_hdmi_audio_cec()
>      * drm/display: bridge-connector: return int from drm_bridge_connecto=
r_add_connector()
>
>  3. bridge-connector: create the drm_connector dynamically
>
>      * drm/display: bridge-connector: hoist error management to common co=
de
>      * drm/display: bridge-connector: move drm_bridge_connector_put_bridg=
es() definition eariler
>      * drm/display: bridge-connector: add non-drmm variant of drm_bridge_=
connector_put_bridges()
>      * drm/display: bridge-connector: allocate the connector dynamically
>      * drm/display: bridge-connector: move per-connector fields to the dy=
namic connector
>      * drm/display: bridge-connector: protect dynconn creation and destru=
ction with a mutex
>
>  4. samsung-dsim: prepare driver to work when the following bridge is hot=
pluggable
>
>      * drm/bridge: samsung-dsim: remove the panel_bridge on host_detach
>      * drm/bridge: samsung-dsim: move drm_bridge_add() call to probe
>      * drm/bridge: samsung-dsim: attach: return -EPROBE_DEFER is next bri=
dge not yet available
>
>  5. Misc preparation work
>
>      * drm/bridge: initialize chain_node list head on allocation
>      * drm/bridge: initialize chain_node list head on detach and attach e=
rrors
>
>  6. drm_bridge: stop pipeline when a bridge is removed
>
>      * drm/encoder: add drm_encoder_cleanup_from()
>      * drm/atomic: move drm_atomic_helper_disable_all() and drm_atomic_he=
lper_shutdown() from drm_atomic_helper to drm_atomic
>      * drm/bridge: shutdown and cleanup on bridge unplug
>
>  7. Add notifier mechanism to let common code (the bridge-connector)
>     take actions on hotplug events
>
>      * drm: event-notifier: add mechanism to notify about hotplug events
>      * drm/bridge: notify about detached bridges
>      * drm/mipi-dsi: turn DRM_MIPI_DSI into a tristate
>      * drm/mipi-dsi: notify about DSI attach
>
>  8. Allow common code to know when the pipeline is complete
>
>      * drm/bridge: add drm_bridge_is_tail() to know whether a bridge comp=
letes the pipeline
>      * drm/bridge: panel: implement .is_tail
>      * drm/bridge: display-connector: implement .is_tail
>      * drm/bridge: samsung-dsim: implement .is_tail
>      * drm/bridge: ti-sn65dsi83: implement .is_tail
>
>  9. Allow probing incomplete pipelines
>
>      * drm/bridge: drm_bridge_attach(): don't fail on -EPROBE_DEFER
>
>  10. Implement bridge hotplug in bridge-connector, enable it in a driver
>
>      * drm/display: bridge-connector: handle bridge hotplug
>      * drm/mxsfb/lcdif: enable bridge hotplug
>
> =3D=3D Grand plan
>
> This is part of the work to support hotplug of DRM bridges. The grand pla=
n
> was discussed in [0].
>
> Here's the work breakdown (=E2=9E=9C marks the current series):
>
>  1. =E2=80=A6 add refcounting to DRM bridges struct drm_bridge,
>       based on devm_drm_bridge_alloc()
>     A. =E2=9C=94 add new alloc API and refcounting (v6.16)
>     B. =E2=9C=94 convert all bridge drivers to new API (v6.17)
>     C. =E2=9C=94 kunit tests (v6.17)
>     D. =E2=9C=94 add get/put to drm_bridge_add/remove() + attach/detach()
>          and warn on old allocation pattern (v6.17)
>     E. =E2=80=A6 add get/put on drm_bridge accessors
>        1. =E2=9C=94 drm_bridge_chain_get_first_bridge(), add cleanup acti=
on (v6.18)
>        2. =E2=9C=94 drm_bridge_get_prev_bridge() (v6.18)
>        3. =E2=9C=94 drm_bridge_get_next_bridge() (v6.19)
>        4. =E2=9C=94 drm_for_each_bridge_in_chain() (v6.19)
>        5. =E2=9C=94 drm_bridge_connector_init (v6.19)
>        6. =E2=9C=94 protect encoder bridge chain with a mutex (v7.2)
>        7. =E2=9C=94 of_drm_find_bridge
>           a. =E2=9C=94 add of_drm_get_bridge() (v7.0),
>                convert basic direct users (v7.0-v7.1)
>           b. =E2=9C=94 convert direct of_drm_get_bridge() users, part 2 (=
v7.0)
>           c. =E2=9C=94 convert direct of_drm_get_bridge() users, part 3 (=
v7.0)
>           d. =E2=9C=94 convert direct of_drm_get_bridge() users, part 4 (=
v7.1-v7.2)
>           e. =E2=9C=94 bridge-only drm_of_find_panel_or_bridge() users (v=
7.2)
>        8.   drm_of_find_panel_or_bridge, *_of_get_bridge
>        9. =E2=9C=94 enforce drm_bridge_add before drm_bridge_attach (v6.1=
9)
>     F. =E2=9C=94 debugfs improvements
>        1. =E2=9C=94 add top-level 'bridges' file (v6.16)
>        2. =E2=9C=94 show refcount and list lingering bridges (v6.19)
>  2. =E2=80=A6 handle gracefully atomic updates during bridge removal
>     A. =E2=9C=94 Add drm_bridge_enter/exit() to protect device resources =
(v7.0)
>     B. =E2=80=A6 protect private_obj removal from list
>     C. =E2=9C=94 Add drm_bridge_clear_and_put() (v7.1)
>  3. =E2=80=A6 DSI host-device driver interaction
>  4. =E2=9C=94 removing the need for the "always-disconnected" connector
>  5. =E2=9C=94 Migrate i.MX LCDIF driver to bridge-connector (v7.2)
>  6. =E2=9E=9C DRM bridge hotplug
>     A. =E2=9E=9C Bridge hotplug management in the DRM core
>        1. =E2=9C=94 bridge-connector: attach encoder to the connector (v7=
.2)
>        2. =E2=9E=9C drm bridge hotplug
>     B.   Device tree description
>
> [0] https://lore.kernel.org/lkml/20250206-hotplug-drm-bridge-v6-0-9d6f2c9=
c3058@bootlin.com/#t
>
> =3D=3D Dependencies
>
> This series depends on:
>
>  * "drm/atomic: drm_atomic_private_obj_fini: protect private_obj removal
>     from list"
>    - https://lore.kernel.org/lkml/20260324-drm-bridge-atomic-vs-remove-pr=
ivate_obj-v3-1-64deefe84044@bootlin.com/
>    - Reason: avoid sporadic deadlock
>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
> Luca Ceresoli (37):
>       drm/connector: split drmm_connector_hdmi_init() in 3 parts
>       drm/connector: add drm_connector_hdmi_dynamic_init()
>       drm/display: bridge-connector: rename variable for consistency
>       drm/display: bridge-connector: store the drm_device pointer
>       drm/display: bridge-connector: split code creating the connector to=
 a subfunction
>       drm/display: bridge-connector: use a drm_bridge_connector internall=
y, not a drm_connector
>       drm/display: bridge-connector: extract drm_bridge_connector_get_bri=
dges()
>       drm/display: bridge-connector: return int from drm_bridge_connector=
_get_bridges()
>       drm/display: bridge-connector: extract drm_bridge_connector_init_hd=
mi_audio_cec()
>       drm/display: bridge-connector: return int from drm_bridge_connector=
_init_hdmi_audio_cec()
>       drm/display: bridge-connector: return int from drm_bridge_connector=
_add_connector()
>       drm/display: bridge-connector: hoist error management to common cod=
e
>       drm/display: bridge-connector: move drm_bridge_connector_put_bridge=
s() definition eariler
>       drm/display: bridge-connector: add non-drmm variant of drm_bridge_c=
onnector_put_bridges()
>       drm/display: bridge-connector: allocate the connector dynamically
>       drm/display: bridge-connector: move per-connector fields to the dyn=
amic connector
>       drm/display: bridge-connector: protect dynconn creation and destruc=
tion with a mutex
>       drm/bridge: samsung-dsim: remove the panel_bridge on host_detach
>       drm/bridge: samsung-dsim: move drm_bridge_add() call to probe
>       drm/bridge: samsung-dsim: attach: return -EPROBE_DEFER is next brid=
ge not yet available
>       drm/bridge: initialize chain_node list head on allocation
>       drm/bridge: initialize chain_node list head on detach and attach er=
rors
>       drm/encoder: add drm_encoder_cleanup_from()
>       drm/atomic: move drm_atomic_helper_disable_all() and drm_atomic_hel=
per_shutdown() from drm_atomic_helper to drm_atomic
>       drm/bridge: shutdown and cleanup on bridge unplug
>       drm: event-notifier: add mechanism to notify about hotplug events
>       drm/bridge: notify about detached bridges
>       drm/mipi-dsi: turn DRM_MIPI_DSI into a tristate
>       drm/mipi-dsi: notify about DSI attach
>       drm/bridge: add drm_bridge_is_tail() to know whether a bridge compl=
etes the pipeline
>       drm/bridge: panel: implement .is_tail
>       drm/bridge: display-connector: implement .is_tail
>       drm/bridge: samsung-dsim: implement .is_tail
>       drm/bridge: ti-sn65dsi83: implement .is_tail
>       drm/bridge: drm_bridge_attach(): don't fail on -EPROBE_DEFER
>       drm/display: bridge-connector: handle bridge hotplug
>       drm/mxsfb/lcdif: enable bridge hotplug
>
>  drivers/gpu/drm/Kconfig                        |   7 +-
>  drivers/gpu/drm/Makefile                       |   2 +
>  drivers/gpu/drm/bridge/display-connector.c     |   7 +
>  drivers/gpu/drm/bridge/panel.c                 |   8 +-
>  drivers/gpu/drm/bridge/samsung-dsim.c          |  36 +-
>  drivers/gpu/drm/bridge/ti-sn65dsi83.c          |   7 +
>  drivers/gpu/drm/display/drm_bridge_connector.c | 835 +++++++++++++++++--=
------
>  drivers/gpu/drm/drm_atomic.c                   | 115 ++++
>  drivers/gpu/drm/drm_atomic_helper.c            |  76 +--
>  drivers/gpu/drm/drm_bridge.c                   |  47 +-
>  drivers/gpu/drm/drm_connector.c                | 155 +++--
>  drivers/gpu/drm/drm_encoder.c                  |  38 ++
>  drivers/gpu/drm/drm_event_notifier.c           |  58 ++
>  drivers/gpu/drm/drm_mipi_dsi.c                 |   3 +
>  drivers/gpu/drm/mxsfb/lcdif_drv.c              |   8 +-
>  include/drm/bridge/samsung-dsim.h              |   2 +
>  include/drm/drm_atomic.h                       |   3 +
>  include/drm/drm_bridge.h                       |  19 +
>  include/drm/drm_bridge_connector.h             |   2 +
>  include/drm/drm_connector.h                    |   9 +
>  include/drm/drm_encoder.h                      |   1 +
>  include/drm/drm_event_notifier.h               |  36 ++
>  22 files changed, 1078 insertions(+), 396 deletions(-)
> ---
> base-commit: 289b9a790d52a6865db3006f07922a9191faa54e
> change-id: 20260515-drm-bridge-hotplug-46265d3a2f85
>
> Best regards,
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com




--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
