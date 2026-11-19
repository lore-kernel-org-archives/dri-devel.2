Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D774606A33D
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 10:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RUHnXtCQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9810810E686;
	Thu, 19 Nov 2026 10:06:13 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CF4911224A
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 10:06:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BE50662FD2;
 Thu, 19 Nov 2026 10:06:01 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795082761;
 b=hLQZMoVhaPqKHRDXkgj8Ei5QjUp4Y1oKHNxWcnJAJDSVhsIZ7fw7E7eafzA/Po5Sx631
 VjxepB1RwT4NgSQxKgsvf1AjBOUVUJd7jW9waLMYzkcNFPtTIs99PbF5hQ/yU7/gQsbyz
 vYiOHnhZa1lGc5zUT1EG8Sq8N6iKEVlfaNXkGfVKxnkIdnaGQJ7mcJt1r5jQTuy9LA5dN
 ajToVh7QEi5svJ4as+/9tGndEC7ay9eZ35A+NCZ5kwi6/1MiSZwPzku8NF/K1piHXuD7X
 Ub3dfTIgp7WjdVEsQ1dLfIdDlrmYIkUBSb1PGJjMd0vfeIuY4C9i+4TtMg10y1XgILw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795082761;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=iXyY+UYmKdflgbYV1YHbe5m1ibrRAzHSBYj2RsZcPe8=;
 b=EcXWEpYgepOY5mXGc7EYdxU9KlC1Y/TRlpv6v/Glg7dEgQ0oE38A6OTY4BlGMesEDo5N
 bqRVXAxS9MmQQ7cToB6V/tKCrtx9fYHZBj4rygvEldDFv0PhoPPuWKiRKl8MmFf1ibwoN
 1kfwNgUcVdaan6cFyHu66SKV39xfaM5BqygvxqActs+RM1/1PKkSk6jZCVnOojA8gDLUy
 2PY7oTBN1+UJg4OhupFVuyEK/DDeh/Bi2f0quM3XWP32399qusH5lF9kzmA9cmSMhe/vF
 Mz/JNfhbmFcYixhGEZros5SFNK2nw/eVaZOGUnUEhumjYy4F4L8o+WreWma13ioMQ2w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 5C72A1F000CB;
 Thu, 19 Nov 2026 10:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795082761;
 bh=iXyY+UYmKdflgbYV1YHbe5m1ibrRAzHSBYj2RsZcPe8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=RUHnXtCQMyvPvn2UerYoIbKqbiRyVe9ic8sh7adibtwSv5JXuS/lJ9efv26zGXOah
 oHdKRfY6RLfF1PlsXQ1/iw5p2X2rL97kN+rhWxhS0f1NDh270LndJDlCMvRjrk+v2F
 UWa3mdsVU2Cv6JdIKzWQnd81NGwxCKVJ9dluQew7ZA258idrGI5bvHe2zYQy+Ekft2
 PogqPFrh+qJlW9THFuRJ/hP9tNFwXyO0u+im28j+fhTfbyqlm5tVnElNdXI0uGIlO6
 ND652MdZZb8iE7f+IjkVqsb8tUgCpTmTmQXjC88xzI6l8L5BbFIXgVdGEIEhsx+xoD
 JIk8IsKF870Zg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id DA3B44B219;
 Thu, 19 Nov 2026 10:05:59 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 19 Nov 2026 10:06:00 +0000
Subject: [PATCH 1/2] drm/rockchip: vop2: Reject double clocked modes on RK3588
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261119-rk3588-interlace-v1-1-993212e389cd@gmail.com>
References: <20261119-rk3588-interlace-v1-0-993212e389cd@gmail.com>
In-Reply-To: <20261119-rk3588-interlace-v1-0-993212e389cd@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795082759; l=1221;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=552SdLdmG+KybFPqh32b97uQLYRUzbBP6Eh4nDlCs5k=;
 b=y6rLEloNTiqrvVs+2r1raoh58iyJiXIURveUiIwb8wYBqizSVv4oGyrBzPmVOtWLfQDH91eyf
 WIChskGgOiGARTrP5etUwuQVMvCNfwJ9qadI5CSNkDji33DJPr3i35q
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Content-Transfer-Encoding: 7bit
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
Reply-To: aiyengar1990@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Arun Iyengar <aiyengar1990@gmail.com>

Pixel repeated modes (DRM_MODE_FLAG_DBLCLK, e.g. 720(1440)x480i) need
each pixel sent twice. RK3588 cannot do that: DSP_CTRL.CORE_DCLK_DIV is
reserved, dclk_core already runs at dclk/4 and the HDMI QP TX has no
pixel repetition. The doubled dclk then sends a timing that does not
match the VIC. Reject such modes on RK3588.

Fixes: 5a028e8f062f ("drm/rockchip: vop2: Add support for rk3588")
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 76d151b8bc52..1458d8ae79d6 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -1581,6 +1581,11 @@ static enum drm_mode_status vop2_crtc_mode_valid(struct drm_crtc *crtc,
 	if (mode->hdisplay > vp->data->max_output.width)
 		return MODE_BAD_HVALUE;
 
+	/* RK3588 cannot repeat pixels: no CORE_DCLK_DIV, dclk_core at dclk/4 */
+	if (mode->flags & DRM_MODE_FLAG_DBLCLK &&
+	    vp->vop2->version == VOP_VERSION_RK3588)
+		return MODE_H_ILLEGAL;
+
 	return MODE_OK;
 }
 

-- 
2.55.0


