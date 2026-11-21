Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE27606A32A
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 17:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=timsurber.de header.i=@timsurber.de header.a=rsa-sha256 header.s=MBO0001 header.b=HJh39rsn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD67710E63B;
	Sun, 22 Nov 2026 17:14:36 +0000 (UTC)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCE0110E167
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 02:32:17 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jWbnp3qhfzKn5m;
 Sat, 21 Nov 2026 03:32:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=timsurber.de;
 s=MBO0001; t=1795228334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pcu4Z0YBmWCircjybAGycW1Dhcl9eVo6UivDa5/Fmxg=;
 b=HJh39rsn0pCQK2z2PO2POp6xK2+FKPT1CeP+YAoEidmXMinZJzJVxtECgbIGE3fDueqTfe
 Pmv48qfCNA3vGZJdDWbTVnPOqJPpvC0QHdf9QE/rNbayws92eKrn5730LcefjLK/qKJRdy
 PWFDqeTimrEw2LXHTAziBd4WL+z2DYX0mzaYj7QeJnGXBTbmNVWsj0er2O/yIYbh2vcCSp
 y14nWIAeBDChiMSlt5sLZBT5rU2NFsflD1enUul6zuEfygyJJFNde2GLPE59YEREOEyybb
 +z2/uFRqC0n2czfiepexptiFo8b+xMi9KvL+qeA2QyUPzFciJXbHFwA3H42ABQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of me@timsurber.de designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=me@timsurber.de
From: Tim Surber <me@timsurber.de>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Sandy Huang <hjc@rock-chips.com>, Andy Yan <andyshrk@163.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Daniel Stone <daniel@fooishbar.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Igor Paunovic <royalnet026@gmail.com>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 07/15] drm/rockchip: vop2: Reset AXI and DCLK to
 improve robustness
Date: Sat, 21 Nov 2026 03:31:18 +0100
Message-ID: <20261121023139.3515640-1-me@timsurber.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261105-dw-hdmi-qp-yuv-v6-7-1bb63ef5766e@collabora.com>
References: <20261105-dw-hdmi-qp-yuv-v6-0-1bb63ef5766e@collabora.com>
 <20261105-dw-hdmi-qp-yuv-v6-7-1bb63ef5766e@collabora.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jWbnp3qhfzKn5m
X-Mailman-Approved-At: Sun, 22 Nov 2026 17:13:42 +0000
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Cristian,

On Thu, 05 Nov 2026 03:00:41 +0200, Cristian Ciocaltea wrote:
> @@ -953,6 +974,8 @@ static int vop2_enable(struct vop2 *vop2)
>
>  static void vop2_disable(struct vop2 *vop2)
>  {
> +	vop2_reset_assert_deassert(vop2, vop2->axi_rst);
> +
>  	rockchip_drm_dma_detach_device(vop2->drm, vop2->dev);

with this patch my RK3588 board (FriendlyElec
CM3588) hangs hard sometimes when the last CRTC is switched off. Without the series
or with the AXI reset in vop2_disable() removed it does not happen.

Here is a minimal reproducer, run as root, with a display on HDMI and fbcon on it:

  python3 - <<'EOF' &
  import fcntl, os, struct
  fd = os.open("/dev/dri/by-path/platform-display-subsystem-card", os.O_RDWR)
  try:
      fcntl.ioctl(fd, 0x641F)        # DRM_IOCTL_DROP_MASTER: leave KMS to fbcon
  except OSError:
      pass
  while True:
      b = bytearray(struct.pack("6IQ", 2160, 3840, 32, 0, 0, 0, 0))
      fcntl.ioctl(fd, 0xC02064B2, b)                         # DRM_IOCTL_MODE_CREATE_DUMB
      handle = struct.unpack("6IQ", b)[4]
      fcntl.ioctl(fd, 0xC00464B4, struct.pack("I", handle))  # DRM_IOCTL_MODE_DESTROY_DUMB
  EOF
  while :; do
  	echo 4 > /sys/class/graphics/fb0/blank; sleep 0.3
  	echo 0 > /sys/class/graphics/fb0/blank; sleep 0.7
  done

This hangs the board within a few blank cycles. In
practice I hit it when a KMS application exits: it frees its buffers
while fbcon takes the display back with a full modeset.

This issue can be fixed for me by moving vop2_reset_assert_deassert(vop2, vop2->axi_rst) from vop2_disable to vop2_enable.

--8<--
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -913,6 +913,9 @@ static int vop2_enable(struct vop2 *vop2)
 	if (ret)
 		goto err_put_pm;

+	/* Reset while idle; doing it in vop2_disable() can hang the SoC */
+	vop2_reset_assert_deassert(vop2, vop2->axi_rst);
+
 	ret = rockchip_drm_dma_attach_device(vop2->drm, vop2->dev);
 	if (ret) {
 		drm_err(vop2->drm, "failed to attach dma mapping: %d\n", ret);
@@ -973,8 +976,6 @@ static int vop2_enable(struct vop2 *vop2)

 static void vop2_disable(struct vop2 *vop2)
 {
-	vop2_reset_assert_deassert(vop2, vop2->axi_rst);
-
 	rockchip_drm_dma_detach_device(vop2->drm, vop2->dev);

 	regcache_drop_region(vop2->map, 0, vop2_regmap_config.max_register);
-->8--

Does that work for the cases the reset was added for (the RGB <-> YUV420
switch glitches and the DSI panel on the EVB1)? I can't test those here.


Thanks,
Tim
