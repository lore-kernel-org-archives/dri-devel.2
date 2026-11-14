Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC96B606C32D
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 18:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=E2/VSS73
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 916C710F0A8;
	Sat, 14 Nov 2026 18:04:30 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92DE410F083
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 18:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1794679460;
 bh=CoXaP5SMjYToa04HiP4Cu6j1pXkYEZQduwHm/vPwKj4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=E2/VSS73RKr0lwmAIWkHCjym7by0IIMiIoYjIXDlaMG1ek8OAypSOz7ArKri6FZha
 sYFCtQj7eyS36+QCK/5ttFwgNc8+y3fypYCufUaZmpVhaeQJr2OzQmBNzlPWZuSVKq
 25foSCof3c49gT0NtQm9fRmmYB9hWzVGu/paZfyMBiehojBGYnWNdEyHEnBuRmnDly
 1siDXCzYR/GdA0VTFWwWJTbNr+t6O5mg4sTCz0NC540f1nBkMso9igLFS/tr9aIkuO
 tsWB6OCS4QqwuI90P+G/SqjQPn4gmvddbaEh2aTTv9XSSaQUXMhM75yRrtSPqIOGam
 W7wnCbjhQuqxQ==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 2D52317E101E;
 Sat, 14 Nov 2026 19:04:20 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 14 Nov 2026 20:03:28 +0200
Subject: [PATCH 04/25] drm/display: hdmi-state-helper: Reject connectors
 lacking HDMI funcs
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-drm-conn-hdmi-cleanup-v1-4-20e8a33a2286@collabora.com>
References: <20261114-drm-conn-hdmi-cleanup-v1-0-20e8a33a2286@collabora.com>
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-0-20e8a33a2286@collabora.com>
To: Helge Deller <deller@gmx.de>, Martin Bugge <marbugge@cisco.com>, 
 Thierry Reding <treding@nvidia.com>, Hans Verkuil <hverkuil@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

drm_atomic_helper_connector_hdmi_check() must only be used with
connectors set up via drmm_connector_hdmi_init(), which guarantees
connector->hdmi.funcs is set.

Other connectors used to fail gracefully: with max_bpc and
supported_formats both zero, hdmi_compute_config() found no usable
format/bpc combination and returned -EINVAL before
hdmi_generate_infoframes() dereferenced hdmi.funcs.

As those fields are being replaced by drm_connector_hdmi_funcs
counterparts, hdmi_compute_config() would dereference hdmi.funcs right
away.  To preserve the old behaviour, return an error early for such
connectors, and use drm_WARN_ON_ONCE() to flag the driver bug.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index c50cedc7fa65..f533d5a7aab9 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -912,6 +912,9 @@ int drm_atomic_helper_connector_hdmi_check(struct drm_connector *connector,
 	if (!new_conn_state->crtc || !new_conn_state->best_encoder)
 		return 0;
 
+	if (drm_WARN_ON_ONCE(connector->dev, !connector->hdmi.funcs))
+		return -EINVAL;
+
 	ret = hdmi_compute_config(connector, new_conn_state, mode);
 	if (ret)
 		return ret;

-- 
2.56.0

