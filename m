Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072DD606A32F
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 10:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PA4Zop6l
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29DCB1121C1;
	Thu, 29 Oct 2026 10:51:58 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A21F41121A1
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 10:18:30 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-c38ac26cc5dso314245766b.2
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 03:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793269109; x=1793873909; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hPXRAqx03CWF4KTxZfjeshWKEYqjwFf9UJcm90FGUJk=;
 b=PA4Zop6lc4Y0kYBfPSbeWAY3q95w72m3C0ddOquLE218biaECm6ssDCry5uvj1Wnba
 yS5dTMXLDkptNTZd20npvoSjM7DcyqZqsrzPHopEOyQ732UKe5Rni1TDrH4UuxSW3be3
 RALyBeWq/vhoilt8lvIeA5zJOxfI6oEXlM+bh1aSwx0URrQgeW9U89uNhtkp4sO7Gujn
 jv8RMIMcpyxNHNKpXM/EK/pGF65RH0rS1+1bjBtYFZ+wjsHe/swchqW0AwGTjFN93V1N
 1NsWYxS1/QMytHXUHSeOOhX8PJtfur6JlqBZQyfkQAGcfhiKQeYyxgKjrsohxXe7DUbH
 GEwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793269109; x=1793873909;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hPXRAqx03CWF4KTxZfjeshWKEYqjwFf9UJcm90FGUJk=;
 b=uJRl9kP3tkTwBgXWXYe14AEsVHvO7guLTituJKKa4rew9LlwPutDrG9Re61wEuHKjm
 pwXH1k8XGWkhRWB+wzRFZMSgjIusK3ULoUjd492kgaocmbDxcb7rvpFIo+C8Jb1wVhhV
 9e2SIN3DpgO3xXd9bSPr/udS13ovj8ikx7nZbnm9/2MNzkZ8JN1sv9+JB5jkZZ7mE+QQ
 Bjc8Lspb0ThTGvbdufmdCuhBS6GQwncgGkk9I0/7ffA/R8wbX5RmqqMMwP015MxqkmDi
 RtmWX0JhOQigFDiNFpiYzwB9coc2MDxcUgxials5zCvX4J0ogQgluljmQnw2k3mr+S3A
 y+jw==
X-Gm-Message-State: AFq9FYKnJL3Dn5jn8krn2aRriP9uiIPkBhXlLbfGRxnirHeQY04Mirk/
 RFMiYa4E5dcyk7vcHtxkU2ggICZqR23pr88jp1XdaihmMb8LhYu3asTTwIa18Z8V
X-Gm-Gg: AYBFou009oR3TIK8zQM6tyJHGjT0jarPv0YEC7Vyws1AzuTNqxuHB9kXNQ0neU0LXh8
 viH0LxeX3FWJGJ4tC/HC9XUKKkbgfb4WiHL43CEA1g5mAcneZ6LCdXzw++q0LUUeAjpcJInqzG6
 v/kYvNG+pgYXCmdb3T3S+Ho7kbX5nMLuoA6g2suYaqjOGbuepISQHZlMXNzvuprk/NZJ+CeerWn
 IRC0GZfpxPshIjshEGbEWOquGaaDAX0oAt7YvkwYaTHtXACKi7ATHT1dcXF/FWN7FcgNBAYXIIu
 aBDndRWtg+FxORw8FpTXbfywdxziVwzUwztpbPslxdf7MAs2MFzQC8LIucl2CsDjyr7AUKlhu4n
 nxPs23OAxLktjVB0pYaO8GlGKrSIe6pj/F/3qj/1K0Qsz4biTFkM4tEmEsJn2d3ilW+MlBOoMbf
 VbjTJFPiCRo52bBHspsgC97XGrAZbx+euNEkjht8IC2T3+/uzY5FQLtTsw9lOhiVZI6g/EerHFL
 bFtaquxIB451CGXRgNT/eV7qrEAKxIvjsEaGUoIKviyPi0Ukt0Kt+yWWrggHcmR3lGhX+bxGd6F
 gNdR9j5Ca4mhdh0RmtfvJ/FidM2jeu2R6f1nLdCJH3HCewhk2jM8cYgzPuJ/73I=
X-Received: by 2002:a17:906:730e:b0:c40:231:6eab with SMTP id
 a640c23a62f3a-c49bdf393b4mr415116466b.16.1793269108982; 
 Thu, 29 Oct 2026 03:18:28 -0700 (PDT)
Received: from localhost.localdomain ([46.205.195.0])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd66c6dbsm712145966b.59.2026.10.29.03.18.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 03:18:28 -0700 (PDT)
From: Dmytro Malovanyi <dmitrymalovanyy@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Dmytro Malovanyi <dmitrymalovanyy@gmail.com>
Subject: [PATCH v2 0/5] drm/dp: Always use enhanced framing for DPCD r1.2+
Date: Thu, 29 Oct 2026 11:18:21 +0100
Message-ID: <20261029101826.72773-1-dmitrymalovanyy@gmail.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 29 Oct 2026 10:51:56 +0000
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
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Xiaomi Monitor A24i clears DP_ENHANCED_FRAME_CAP in its extended
receiver caps, and through a USB4 dock it does not sync without
enhanced framing. v1 kept the bit from the base caps. As Jani pointed
out, the spec says to enable enhanced framing for DPCD r1.2+ without
looking at the bit, so v2 does that in drm_dp_enhanced_frame_cap() and
converts the remaining direct users of DP_ENHANCED_FRAME_CAP.

amdgpu DC, mediatek and hibmc already enable enhanced framing always,
without checking the bit.

drm_dp_get_phy_test_pattern() still uses DP_ENHANCED_FRAME_CAP, but
there it is a bit in DP_TEST_LANE_COUNT, so it is left alone.

analogix_dp has its own copy of the check (DPCD_ENHANCED_FRAME_CAP()),
I left it out, can do it as a follow up.

Patch 1 is tested on i915 with the affected monitor, the rest is
compile tested only.

For nouveau I converted both dispnv50 and nvkm in one patch, so the
watermark calculation and the enable stay in sync. Happy to change it
if you prefer another way.

v2:
- Do it in drm_dp_enhanced_frame_cap() instead of patching the
  extended caps (Jani)
- Convert cdns-mhdp8546, it6505, gma500 and nouveau
- Commit message: the sink only fails through the dock, directly
  connected it works without enhanced framing

v1: https://lore.kernel.org/all/20261028162941.62762-1-dmitrymalovanyy@gmail.com/

Dmytro Malovanyi (5):
  drm/dp: Always use enhanced framing for DPCD r1.2+
  drm/bridge: cdns-mhdp8546: Use drm_dp_enhanced_frame_cap()
  drm/bridge: it6505: Use drm_dp_enhanced_frame_cap()
  drm/gma500: Use drm_dp_enhanced_frame_cap()
  drm/nouveau: Use enhanced framing for DPCD r1.2+

 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c   |  2 +-
 drivers/gpu/drm/bridge/ite-it6505.c                   |  2 +-
 drivers/gpu/drm/gma500/cdv_intel_dp.c                 |  8 ++------
 drivers/gpu/drm/nouveau/dispnv50/disp.c               |  2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c         |  2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.h         | 11 +++++++++++
 drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c      |  2 +-
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c    |  2 +-
 include/drm/display/drm_dp_helper.h                   |  4 ++++
 9 files changed, 23 insertions(+), 12 deletions(-)


base-commit: feaa32dc98090b2f45f7b6f179711a6640169c1a
-- 
2.50.1 (Apple Git-155)

