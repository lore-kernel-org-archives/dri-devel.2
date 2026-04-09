Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 467E9F364C3
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 22:37:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58B4C10E88E;
	Thu,  9 Apr 2026 22:37:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="WDgXoLNJ";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93FE210E88E
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 22:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1775774261;
 bh=mMZFlS36rjorHgR/mWWffVLLV2B7T9gk0BFFHkidN7c=;
 h=From:Date:Subject:To:Cc:From;
 b=WDgXoLNJg4XeYrwn12V6eES2wHHDyctKx1HgKhBZmIBtfD4b4zxRXznTdh2iZL4/c
 ugeQJuprMgY/NrMVOHrg3ESaYRN9baFIOpHocwgy6EHhZKXmcGGJWyFD8Mq6ccHe+t
 qjSbnY+eufxSJCX250lHByl5dGvgZQ38AV6zdbX2Z7k6ZnStw21pec9kTU/810ONXp
 riocy8rWXXgh3fLrK9HHQOowRtLPQiw3Ivu+X95AMPi0HW7eI3Ofhb17U6CkTQ7Dv2
 +pq91segVwXKaafhvtQh7yfucH+BAR5/oioRtGkewB4GwH1GZ1Biw+XD9/jROfqEeF
 S7wIquU+E6jIQ==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 38F1817E12B9;
 Fri, 10 Apr 2026 00:37:41 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id EF4BB48002C; Thu, 09 Apr 2026 23:34:50 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 09 Apr 2026 23:34:41 +0200
Subject: [PATCH RFC v2] drm/rockchip: vop2: Add clock rate mode check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-vop2-clk-rate-check-v2-1-b207cfc427d7@collabora.com>
X-B4-Tracking: v=1; b=H4sIAHAb2GkC/32NTQrCMBCFr1Jm7UgzYNq4EgQP4Fa6SMfRhv6kJ
 CUopXc39AAuv/d431shSnAS4VysECS56PyUgQ4FcGent6B7ZgYqSZekKkx+JuShx2AXQe6EeyR
 dkzZVVbNlyMs5yMt9dusD7rcrNDnsXFx8+O5PSe3VX2lSqNDUpj1po5Rp7YX9MNjWB3tkP0Kzb
 dsPGxQsFL8AAAA=
X-Change-ID: 20260217-vop2-clk-rate-check-268269778cac
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>
Cc: Daniel Stone <daniels@collabora.com>, Alexey Charkov <alchark@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6139;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=mMZFlS36rjorHgR/mWWffVLLV2B7T9gk0BFFHkidN7c=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGnYG3pi93cTW4yCyNLQ/GfeLTF0kZ4v7mNL0
 OjnrUV3xsUT+YkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJp2Bt6AAoJENju1/PI
 O/qavSEP/A0aU+k3AfM0XGEz8p1RH76/YOZ9FzU2UErXy0i5r6jS48u4EPfvOr0xn4Syk6epyMz
 jm65iH6FdShVljTsPUvorvrLWAIpbdlNgmL0AF8meRHLaYMF+I0BWmIgJvK3X0MrC0WxLS4crKP
 hvmp/JbkwvTGg4yeTs/7Ec9KNpSvGgB60xyPw4ucCMzIwF1O36gritfoRIA3PoHWNJ9mzAnOW8J
 jEX6OgP2aIPAv4Htm6O04uqSsJVtaX7fgZr7zloX97kxZHrYKIjpUKEO5XTD4NSbY3kt7GQRqK0
 YhsO/NIA4/33Hg1tejWdUM6Wu0zcAv32GWb+4BKmFYitrzyz+nbdTwZnfSAgBaeJlIGvjmwehT+
 s2y4gFTnfVYSNLrtfQOs66BU1Exhbt3EHcH10uwpMqpMjWH5WkTB0rEUEhSWEGm2Q7snzmH23qv
 Gqk0ALPvoOH6eb5Fo3nzCMqPzgwjMpvNhZHhJ0ZK3MASBd+iGVBAQwBVZXD+limymSbkK1dqf7G
 Ktq7Cen14fOOvvt7Rsu/6j3WDRAlMvmfcP54KwFRlT7ymXfLMkcrioRvBnLKEc3YuYGijk9b3Ij
 /333Y5/ZlWPsuX4ObbS0f4/UZ+ntlgn3vt/j9HdYXWbYmObLME0CXGWJjdJgZ8CX3KP8rt3Lj5n
 aSKCmBd1HEPPoqMrHAxk4DA==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A
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

The display might offer modes, which exceed the maximum clock rate of a
video output. This usually happens for displays that offer refresh rates
above 60 Hz. This results in no picture (or a broken one) being displayed
without manual intervention. Fix this by teaching the driver about the
maximum achievable clock rates for each video port.

The information about the maximum clock rates for each video channel and
the tip about multiple pixels being processed per clock were provided by
Andy Yan and roughly checked against the information available in the
datasheet (which specifies limits like "2560x1600@60Hz with 10-bit"
instead of a specific pixel rate).

For the video ports supporting a 600 MHz input clock, there is some
logic to handle up to 4 pixels in parallel when needed resulting in
the extra multiplier.

Suggested-by: Andy Yan <andy.yan@rock-chips.com>
Link: https://lore.kernel.org/linux-rockchip/1528d788.186b.19d08ed974c.Coremail.andyshrk@163.com/
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
I've kept the RFC tag, as I'm not sure about the 4x parallel pixel
processing. IIUIC all of the video ports with a maximum of 600 MHz
input clock support it, considering they can go to 4K @ 120Hz,
which is above 1.2GHz while Andy mentioned a max. support clock rate
of 600 MHz.
---
Changes in v2:
- Link to v1: https://lore.kernel.org/r/20260217-vop2-clk-rate-check-v1-1-989b569119ba@collabora.com
- based on v7.0-rc7
- rename max_clock_rate into max_pixel_clock_rate to distinguish from
  input clock
- update max clock rates to the numbers provided by Andy Yan with
  extra 4x multiplier for 4K 120Hz VPs
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c |  3 +++
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h |  1 +
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 10 ++++++++++
 3 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index a195f5c819a2..35a0edda5375 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -1434,6 +1434,9 @@ static enum drm_mode_status vop2_crtc_mode_valid(struct drm_crtc *crtc,
 	if (mode->hdisplay > vp->data->max_output.width)
 		return MODE_BAD_HVALUE;
 
+	if (mode->clock > vp->data->max_pixel_clock_rate / 1000)
+		return MODE_CLOCK_HIGH;
+
 	return MODE_OK;
 }
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
index 9124191899ba..fd46913f3346 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
@@ -225,6 +225,7 @@ struct vop2_video_port_data {
 	u16 gamma_lut_len;
 	u16 cubic_lut_len;
 	struct vop_rect max_output;
+	u32 max_pixel_clock_rate;
 	const u8 pre_scan_max_dly[4];
 	unsigned int offset;
 	/**
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
index f3950e8476a7..6ae3d506c476 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
@@ -559,18 +559,21 @@ static const struct vop2_video_port_data rk3568_vop_video_ports[] = {
 		.gamma_lut_len = 1024,
 		.cubic_lut_len = 9 * 9 * 9,
 		.max_output = { 4096, 2304 },
+		.max_pixel_clock_rate = 600000000U,
 		.pre_scan_max_dly = { 69, 53, 53, 42 },
 		.offset = 0xc00,
 	}, {
 		.id = 1,
 		.gamma_lut_len = 1024,
 		.max_output = { 2048, 1536 },
+		.max_pixel_clock_rate = 200000000U,
 		.pre_scan_max_dly = { 40, 40, 40, 40 },
 		.offset = 0xd00,
 	}, {
 		.id = 2,
 		.gamma_lut_len = 1024,
 		.max_output = { 1920, 1080 },
+		.max_pixel_clock_rate = 150000000U,
 		.pre_scan_max_dly = { 40, 40, 40, 40 },
 		.offset = 0xe00,
 	},
@@ -775,6 +778,7 @@ static const struct vop2_video_port_data rk3576_vop_video_ports[] = {
 		.gamma_lut_len = 1024,
 		.cubic_lut_len = 9 * 9 * 9, /* 9x9x9 */
 		.max_output = { 4096, 2304 },
+		.max_pixel_clock_rate = 600000000U * 4,
 		/* win layer_mix hdr  */
 		.pre_scan_max_dly = { 10, 8, 2, 0 },
 		.offset = 0xc00,
@@ -785,6 +789,7 @@ static const struct vop2_video_port_data rk3576_vop_video_ports[] = {
 		.gamma_lut_len = 1024,
 		.cubic_lut_len = 729, /* 9x9x9 */
 		.max_output = { 2560, 1600 },
+		.max_pixel_clock_rate = 300000000U,
 		/* win layer_mix hdr  */
 		.pre_scan_max_dly = { 10, 6, 0, 0 },
 		.offset = 0xd00,
@@ -793,6 +798,7 @@ static const struct vop2_video_port_data rk3576_vop_video_ports[] = {
 		.id = 2,
 		.gamma_lut_len = 1024,
 		.max_output = { 1920, 1080 },
+		.max_pixel_clock_rate = 150000000U,
 		/* win layer_mix hdr  */
 		.pre_scan_max_dly = { 10, 6, 0, 0 },
 		.offset = 0xe00,
@@ -1061,6 +1067,7 @@ static const struct vop2_video_port_data rk3588_vop_video_ports[] = {
 		.gamma_lut_len = 1024,
 		.cubic_lut_len = 9 * 9 * 9, /* 9x9x9 */
 		.max_output = { 4096, 2304 },
+		.max_pixel_clock_rate = 600000000U * 4,
 		/* hdr2sdr sdr2hdr hdr2hdr sdr2sdr */
 		.pre_scan_max_dly = { 76, 65, 65, 54 },
 		.offset = 0xc00,
@@ -1070,6 +1077,7 @@ static const struct vop2_video_port_data rk3588_vop_video_ports[] = {
 		.gamma_lut_len = 1024,
 		.cubic_lut_len = 729, /* 9x9x9 */
 		.max_output = { 4096, 2304 },
+		.max_pixel_clock_rate = 600000000U * 4,
 		.pre_scan_max_dly = { 76, 65, 65, 54 },
 		.offset = 0xd00,
 	}, {
@@ -1078,12 +1086,14 @@ static const struct vop2_video_port_data rk3588_vop_video_ports[] = {
 		.gamma_lut_len = 1024,
 		.cubic_lut_len = 17 * 17 * 17, /* 17x17x17 */
 		.max_output = { 4096, 2304 },
+		.max_pixel_clock_rate = 600000000U * 4,
 		.pre_scan_max_dly = { 52, 52, 52, 52 },
 		.offset = 0xe00,
 	}, {
 		.id = 3,
 		.gamma_lut_len = 1024,
 		.max_output = { 2048, 1536 },
+		.max_pixel_clock_rate = 150000000U,
 		.pre_scan_max_dly = { 52, 52, 52, 52 },
 		.offset = 0xf00,
 	},

---
base-commit: 591cd656a1bf5ea94a222af5ef2ee76df029c1d2
change-id: 20260217-vop2-clk-rate-check-268269778cac

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

