Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33050606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Db7RY90V
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BFAD10F132;
	Mon, 16 Nov 2026 13:10:50 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 161AE10F12D;
 Mon, 16 Nov 2026 13:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794834644; x=1826370644;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=FE8Eb/o2jNhMmUkY0cmLF5+hbV0dzwgrgopBYqNs/2g=;
 b=Db7RY90VJBMp0IobypR/45LHYchBIG55PtBnIF62pvPKlws3a0zSfHpJ
 FqdpSYbOXsu5Vko1Qlqk4SYO9cPLQrM3C6XhGOd6GmvrKtW7zc19lIDhG
 Bw/McS3IAwLu1cWrpaG8snjCyFORJTj+JKn42P/U1bhQdsUscvnIPEi3I
 mxkde87AKXLpvIROSwA+2vC8VoM80yZI32Gqll8OovpH0J6GoYSk4cd8G
 /m/RsaudiU7b1+1rjyvtZb4jKuvE179SVNZqyUSaZhq9ZWu3qLRClpdi4
 gWRZY5SJ9/20MP4Kk1hdTCqYGhHL8ickdcN+lxYMciEvKrdJu/weypXoq A==;
X-CSE-ConnectionGUID: sAmTLOMWTm20BhMkZW3rig==
X-CSE-MsgGUID: 45avBj4RS56S7amHHLiQPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3464635"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3464635"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 05:10:43 -0800
X-CSE-ConnectionGUID: neqRBvN9TSuOXPoowwyZdg==
X-CSE-MsgGUID: HJr8YL80TZmLcafdJ7R4kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9388760"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost)
 ([10.245.245.117])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 05:10:34 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Kory Maincent <kory.maincent@bootlin.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, Andrzej Hajda <andrzej.hajda@intel.com>, Neil
 Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Luca
 Ceresoli <luca.ceresoli@bootlin.com>, Chun-Kuang Hu
 <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Daniel Stone <daniels@collabora.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Mark Yacoub
 <markyacoub@google.com>, Sean Paul <seanpaul@google.com>, Manasi Navare
 <navaremanasi@google.com>, Drew Davenport <ddavenport@google.com>, Louis
 Chauvet <louis.chauvet@bootlin.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Kory Maincent
 <kory.maincent@bootlin.com>
Subject: Re: [PATCH RFC v3 0/8] Add support for DisplayPort link training
 information report
In-Reply-To: <20261012-feat_link_cap-v3-0-7517f4aba0f3@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20261012-feat_link_cap-v3-0-7517f4aba0f3@bootlin.com>
Date: Mon, 16 Nov 2026 15:10:30 +0200
Message-ID: <51ec15feef9a88e460ab6fefc48b5b982f4857c0@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 12 Oct 2026, Kory Maincent <kory.maincent@bootlin.com> wrote:
> DisplayPort link training negotiates the physical-layer parameters needed
> for a reliable connection: lane count, link rate, and optionally Display
> Stream Compression (DSC). Currently, each driver exposes this state in
> its own way, often through driver-specific debugfs entries, with no
> standard interface for userspace diagnostic and monitoring tools.
>
> This series introduces generic helpers, for exposing DP link capabilities
> and state as standard sysfs entries.

So how did we end up with sysfs here?

> The aim of such development is to guide users to select the most suitable
> DisplayPort connector for their needs. For example, if you have a USB-C
> hub with lesser capabilities than your computer=E2=80=99s native DisplayP=
ort
> connector (such as HBR2 versus HBR3 support), the system could recommend
> connecting high-resolution displays directly to the computer=E2=80=99s po=
rt
> instead of through the hub to ensure optimal performance.

I do wonder how all this is supposed to work in more complex real world
scenarios, though.

I believe the user primarily cares about *modes*. Which display modes
can be used with each display/connector pair.

With the low level link information, are you proposing to compute the
required bandwidth for modes in userspace? I think it's going to be a
lot of work to compute the bandwidth requirements, taking into account
DP SST vs. MST vs. UHBR and DSC and bit depth and everything, and you'll
still miss any driver/GPU specific contraints. Or are you just proposing
to match the physical characteristics only?

Given all the connectors and displays and their modes on a system, you
could estimate a) for each display, what modes could be used on each
connector, and b) for each connector, what modes could be used on a
display, if connected. From the user POV, they could be shown why some
display mode is not available on the current connector, and crucially,
on which connector it could be available.

In general, I'm wondering if you're really after higher level
information, something like "connector max available bandwidth
with/without DSC", that would more directly map to the user needs as I
see them than low level link details.

Do you have the userspace somewhere? That's needed for merging UABI
anyway [1].

[1] https://docs.kernel.org/gpu/drm-uapi.html#open-source-userspace-require=
ments

>
> The new drm_dp_source_set_caps and drm_dp_sink_set_caps helper expose
> source and sink training capabilities to userspace via sysfs attributes
> under dp_link. Finally drm_dp_set_cur_link_params helper is provided to
> report current link information at runtime.
>
> Three drivers are updated as reference implementations: i915 (direct
> connector path), ANX7625 and MediaTek (via the bridge connector framework
> using a new DRM_BRIDGE_OP_DP flag).
>
> Here is a sysfs example:
>
> cur_link_info_dsc            sink_link_caps_nlanes
> cur_link_info_link_rate      source_link_caps_dsc
> cur_link_info_nlanes         source_link_caps_link_rates
> sink_link_caps_dsc           source_link_caps_nlanes
> sink_link_caps_link_rates
>
> 1620000 2160000 2700000 3240000 4320000 5400000
>
> 1620000 2700000 5400000 10000000 20000000
>
> 5400000
>
> This series is rebased on top of drm-misc and may conflict with the
> current state of the drm i915 tree. Which tree should pick this up,
> given that it mixes core development with driver changes?

For development, please just base your work on top of drm-tip, and the
tree(s) will be sorted out later.

BR,
Jani.


> Patch 1,2: Move helpers out of i915
> Patch 3: Introduce DisplayPort link training capabilities and state helpe=
rs
> Patch 4: Read i915 DSC capabilities in any case
> Patch 5  Use dp_connector helpers in i915 to expose link training state
> Patch 6: Introduce DRM_BRIDGE_OP_DP and wire bridge connectors
> Patch 7: Use dp_connector helpers in anx7625 to expose link training state
> Patch 8: Use dp_connector helpers in mediatek to expose link training sta=
te
>
> Changes in v3:
> - Rework the core to use new helpers instead of an extension of
>   drmm_connector_init().
> - Add a new mutex to protect sysfs read write access instead of using
>   the global connection_mutex.
> - Move helpers out of i915.
> - Add the support in the anx7625 driver.
> - Link to v2: https://patch.msgid.link/20260619-feat_link_cap-v2-0-a3dec4=
c02ad9@bootlin.com
>
> Changes in v2:
> - Removed work converting i915 to DRM managed resource
> - Remove voltage swing and pre-emphasis properties
> - Expose link training state via sysfs dp_link/ group instead of
>   connector properties
> - Add comprehensive sysfs attributes for both source and sink capabilities
> - Add new helpers for managing sink capabilities and for current link
>   parameters
> - Link to v1: https://lore.kernel.org/r/20260409-feat_link_cap-v1-0-7069e=
8199ce2@bootlin.com
>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> Kory Maincent (8):
>       drm: Move sink link rates reading helpers out of i915
>       drm: Move DSC capability reading helper out of i915
>       drm: Introduce DisplayPort link training capabilities and state hel=
pers
>       drm/i915/display/dp: Read DPCD DSC capabilities in any case
>       drm/i915/display/dp: Use dp_connector helpers to expose link traini=
ng state
>       drm/bridge: Expose link training state via new DRM_BRIDGE_OP_DP flag
>       drm/analogix/anx7625: Use dp_connector helpers to expose link train=
ing state
>       drm/mediatek: Use dp_connector helpers to expose link training state
>
>  Documentation/ABI/testing/sysfs-class-drm-dp       |  85 +++
>  drivers/gpu/drm/bridge/analogix/anx7625.c          |  68 +++
>  drivers/gpu/drm/bridge/analogix/anx7625.h          |   1 +
>  drivers/gpu/drm/display/Kconfig                    |   1 +
>  drivers/gpu/drm/display/drm_bridge_connector.c     |  29 ++
>  drivers/gpu/drm/display/drm_dp_helper.c            | 571 +++++++++++++++=
++++++
>  drivers/gpu/drm/drm_connector.c                    |  11 +
>  drivers/gpu/drm/drm_sysfs.c                        | 155 ++++++
>  drivers/gpu/drm/i915/display/intel_display_types.h |   2 +
>  drivers/gpu/drm/i915/display/intel_dp.c            | 249 ++++-----
>  .../gpu/drm/i915/display/intel_dp_link_training.c  |  14 +
>  drivers/gpu/drm/mediatek/mtk_dp.c                  |  79 ++-
>  include/drm/display/drm_dp.h                       |   1 +
>  include/drm/display/drm_dp_helper.h                |  25 +
>  include/drm/drm_bridge.h                           |  13 +
>  include/drm/drm_connector.h                        |  53 ++
>  include/drm/drm_sysfs.h                            |   1 +
>  17 files changed, 1202 insertions(+), 156 deletions(-)
> ---
> base-commit: 34e9ab0182494d7599dc9759bc216550d814b396
> change-id: 20260226-feat_link_cap-20cbb6f31d40
>
> Best regards,
> --=20=20
> K=C3=B6ry Maincent, Bootlin
> Embedded Linux and kernel engineering
> https://bootlin.com
>

--=20
Jani Nikula, Intel
