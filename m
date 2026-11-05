Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5918F606CF8A
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 16:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WoMGCBpK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8155710F31D;
	Thu,  5 Nov 2026 16:03:26 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B8E910E814;
 Thu,  5 Nov 2026 16:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793894600; x=1825430600;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5A1ID+DV3XCVNTv9Mjjz9nlWW6YzcsEntOZT7aRGMNk=;
 b=WoMGCBpKXMifHxwx/8YZXa9x0tvX5M3TvMvyccC/Ob2EbUNvzC5ogPUI
 t0KDyOC8ffhc8eyoETsOM0F1YJ1JeYTWLCqEXhJ6I4fbHK/kJodUwsip6
 Pwr7jeFxPL82gI9k2snFfVctTMmGP+c6Uo5bL225L2yL5HnuYIZzridMA
 RgfIEMuiQLJNMOd4YvIXG+3XyyRHOv1FD1I7XR5Uf7A7sTAYo9kuKJ2xS
 oG8aZ4lJh7YMivTA+Qy91YDUQfv+S6QtJ4KeVPGwWV4mMQAXVaEgB5S2x
 BST7FqPnXhblfWjXwShjr28+yQnE+7xMiqz4QG01jUVp7yXYTQ1jD0d3i Q==;
X-CSE-ConnectionGUID: V6oqMtyYQ9+FHwLqMwp8xA==
X-CSE-MsgGUID: wdE0iLuPRVqzT4Gx1fDuPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2706090"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2706090"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 08:03:19 -0800
X-CSE-ConnectionGUID: C78hwW1aRtiqLgiCJitF4A==
X-CSE-MsgGUID: p2bUQgOBTUmb6bFfq3fetQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="8795710"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO
 kvehmane-desk1.ger.corp.intel.com) ([10.245.244.200])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 08:03:13 -0800
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
Subject: [PATCH 2/2] drm/i915/audio: Populate ELD Port_ID
Date: Thu,  5 Nov 2026 18:02:40 +0200
Message-ID: <20261105160240.2850042-3-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105160240.2850042-1-kai.vehmanen@linux.intel.com>
References: <20261105160240.2850042-1-kai.vehmanen@linux.intel.com>
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

i915 never fills in the ELD Port_ID field, so it is always zero, and
the ELDs of identical monitors connected to different outputs are
byte-identical. Userspace then cannot tell which HDMI/DP PCM belongs to
which DRM connector without toggling the connector audio property.

Use drm_eld_set_port_id() when computing the audio config, so the value
reaches the audio driver through every path: the audio component
get_eld() callback, the hardware ELD buffer, SDVO and LPE audio.

The value is fixed for the lifetime of the connector, so it does not
cause extra audio re-enables when the ELD is compared across commits,
and state readout stays consistent because it is copied from the
programmed ELD.

Link: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16693
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_audio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_audio.c b/drivers/gpu/drm/i915/display/intel_audio.c
index 32f8c5e55319..3277e67748ee 100644
--- a/drivers/gpu/drm/i915/display/intel_audio.c
+++ b/drivers/gpu/drm/i915/display/intel_audio.c
@@ -881,6 +881,8 @@ bool intel_audio_compute_config(struct intel_encoder *encoder,
 	crtc_state->eld[6] = drm_av_sync_delay(connector, adjusted_mode) / 2;
 	mutex_unlock(&connector->eld_mutex);
 
+	drm_eld_set_port_id(crtc_state->eld, connector);
+
 	return true;
 }
 
-- 
2.43.0

