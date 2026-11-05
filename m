Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230F160A262B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 16:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=oFdNvn2F
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5600E10E492;
	Thu,  5 Nov 2026 16:03:08 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F86D10E3F9;
 Thu,  5 Nov 2026 16:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793894582; x=1825430582;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=3Z0O4+5RumCUzr/1oec2XjDDWA1Q7OPMsIXT7MmiACE=;
 b=oFdNvn2F/3DtNkkCxYgaResKnpXEuAxTpJ902UPQEdQgWAoF3O2ZRDoI
 RFbwVqb2WMyZ0mEvqeO1JLFgrl4SKa571eFttfjlAwKOFAXzrMrjLevVs
 6Npk2EWZCG6rNr3rNpDvh14uqHhOMJGJ1r1D/XnY6MMzkLIUmErUo9dst
 Ch11mCAcepvWRZeAVKnqoD8otq9N+s6YKlOChBQnV8JRRJJPHsUgW+s09
 Z2PBI/qQh/ZALEqUJXN146XaNc64dTs7ybTMquWWF6YjrMNb0UTg/3EPE
 06NBuq0TChTF/i7opaB3sa3eKbHyarhXZk3iwxZ8TtxDtTpDeTJXqLgFp g==;
X-CSE-ConnectionGUID: xz+5VrO7QsKaPEbooPW8mg==
X-CSE-MsgGUID: iR7FQLGXSPaE9XWPn9F8pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2706042"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2706042"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 08:03:01 -0800
X-CSE-ConnectionGUID: TdoOQ5CpQm6EKMIBns42tQ==
X-CSE-MsgGUID: 56Suo9wMTtyvaYRpTIniFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="8795674"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO
 kvehmane-desk1.ger.corp.intel.com) ([10.245.244.200])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 08:02:54 -0800
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Takashi Iwai <tiwai@suse.com>,
 Jaroslav Kysela <perex@perex.cz>, linux-sound@vger.kernel.org,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?q?Tom=C3=A1=C5=A1=20Hnyk?= <tomashnyk@gmail.com>,
 Wim Taymans <wtaymans@redhat.com>, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: [PATCH 0/2] drm: Populate ELD Port_ID to identify audio endpoints
Date: Thu,  5 Nov 2026 18:02:38 +0200
Message-ID: <20261105160240.2850042-1-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The ELD Port_ID field (bytes 8..15 of the baseline block) is typically
zero on Linux today: drm_edid_to_eld() leaves it empty and no in-tree driver
fills it in. amdgpu, radeon and nouveau pass the raw connector->eld to
the audio component. On the amdgpu DC Azalia register path the value
is a hardcoded constant, the same for every port.
Only closed display drivers fill the value.

Pipewire added support for "Port_ID" in merge request:
https://gitlab.freedesktop.org/pipewire/pipewire/-/merge_requests/3025

As a result, when two identical monitors are connected their ELDs are
byte-identical, and userspace (e.g. PipeWire/WirePlumber) cannot
passively tell which HDMI/DP PCM belongs to which DRM connector.

This series adds a DRM helper that fills Port_ID with a common layout,
and uses it in i915:

  bits 63:48 - PCI domain of the DRM device
  bits 47:32 - PCI bus/device/function of the DRM device
  bits 31:0  - DRM connector object ID

The upper half follows the layout documented for the AMD Azalia sink
info registers (dce_audio.c: "PORT_ID1 = 16bit BDF"). The aim is for
this to become a convention other drivers can opt into. For drivers
that copy connector->eld to the audio component (amdgpu DM, radeon,
nouveau), adopting it would be a one-line change. Comments from the
AMD and nouveau folks on whether the layout works for them are very
welcome.

An alternative would be to fill Port_ID directly in drm_edid_to_eld(),
so every driver gets it without changes. I went with an opt-in helper
to avoid changing the ELD contents seen by all drivers and existing
userspace at once.

The value is exposed to userspace via the ALSA ELD control and
/proc/asound/cardX/eld#Y.

Kai Vehmanen (2):
  drm/eld: Add drm_eld_set_port_id() helper
  drm/i915/audio: Populate ELD Port_ID

 drivers/gpu/drm/drm_eld.c                  | 42 ++++++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_audio.c |  2 ++
 include/drm/drm_eld.h                      |  3 ++
 3 files changed, 47 insertions(+)

-- 
2.43.0

