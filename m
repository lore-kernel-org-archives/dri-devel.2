Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D96606A331
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 08:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=OYt6b6/D
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2407B10EB95;
	Wed, 18 Nov 2026 08:23:18 +0000 (UTC)
X-Greylist: delayed 50300 seconds by postgrey-1.36 at gabe;
 Tue, 17 Nov 2026 23:18:29 UTC
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E63910E506
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 23:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=2X
 iawxssXXv44CNWTaqQT2qKQdjrgp5aUYtmWBVrWtk=; b=OYt6b6/DZuxN9m65Wz
 xbjsou0Q3LqRlvdSX5wGjdw1+9zP57hawgwifC6iUat0xlRH+0ThedclIchtfhrt
 4zV5/HG6GTid5BjPlVPcCRFMrIHEtZxmdFlElvpOJfouw1rGLU3N52r1JgYG89Sm
 LXxmbSyqWwRrL3F1T1qKklOj4=
Received: from SYPC (unknown [])
 by gzsmtp2 (Coremail) with SMTP id PSgvCgCXyQiu4Pxq15exGA--.55935S4;
 Wed, 18 Nov 2026 07:18:09 +0800 (CST)
From: Yang Siyuan <hsyysy@163.com>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 Samuel Holland <samuel@sholland.org>, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] drm/sun4i: backend: report coverage blending for
 alpha-capable planes
Date: Wed, 18 Nov 2026 07:17:51 +0800
Message-ID: <20261117231751.264258-3-hsyysy@163.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117231751.264258-1-hsyysy@163.com>
References: <20261117091932.12063-1-hsyysy@163.com>
 <20261117231751.264258-1-hsyysy@163.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PSgvCgCXyQiu4Pxq15exGA--.55935S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw4DWFyrGF1xuFWrKr1Utrb_yoW8GrykpF
 4kGayUK3W8Crs0qayxAa4UZr13Wa1rGFyIgF9xX3s3Xwn0qFnxC3s8G3Wa9FyUJrs7Cr4U
 tw15WFZF9FnrC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j4_M3UUUUU=
X-CM-SenderInfo: 5kv152r16rljoofrz/xtbC7hE+cmr84LED1AAA3j
X-Mailman-Approved-At: Wed, 18 Nov 2026 08:23:05 +0000
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The DE1 backend planes expose ARGB8888, ARGB4444 and ARGB1555, but the
driver does not create a blend mode property for them, so the new
validate_blend_mode_for_alpha_formats() also warns on A10, A20, A31 and
A33:

  sun4i-drm display-engine: [drm] [PLANE:31:plane-0] pixel format with
  alpha exposed but blend mode not setup. Please fix.

The backend blends a layer onto the pipe below with the layer's own alpha
channel and has no premultiply control, which is the DRM "coverage"
equation.  Advertise DRM_MODE_BLEND_COVERAGE for these planes as well.

Signed-off-by: Yang Siyuan <hsyysy@163.com>
---
 drivers/gpu/drm/sun4i/sun4i_layer.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
index d65587d..0e6e0d1 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
@@ -228,6 +228,13 @@ static struct sun4i_layer *sun4i_layer_init_one(struct drm_device *drm,
 	drm_plane_create_zpos_property(&layer->plane, layer->id,
 				       0, SUN4I_BACKEND_NUM_LAYERS - 1);
 
+	ret = drm_plane_create_blend_mode_property(&layer->plane,
+						   BIT(DRM_MODE_BLEND_COVERAGE));
+	if (ret) {
+		dev_err(drm->dev, "Couldn't add blend mode property\n");
+		return ERR_PTR(ret);
+	}
+
 	return layer;
 }
 
-- 
2.56.1

