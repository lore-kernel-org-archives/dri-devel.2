Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733016071A5A
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 08:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fULWnQEz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00A8B10FC75;
	Thu, 12 Nov 2026 08:33:19 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B400010FBDF
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 08:33:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9CC2C4791B;
 Thu, 12 Nov 2026 08:33:08 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794472388;
 b=erdygLEBqaceeRIneVQtngsWxUPorg4YZ5ro7J+10r3jG5rYN57VwEZ7Pv1cSvKlp1Mq
 o+LZaE/VXy4FwHnG8WY/xkiF61jLbJrf06wh25/Z+lazLsauruHCFH7/WNj7ae6WZTGN6
 kybk2fEXW7K4A7g8XhwtWX2qxw5LXQUMiEtYQOfCPyaD6OdYhXx3YdT6E8zPrxvqflk1X
 56IOZbn3aFp1L4qJDLz6SJEU8FXbqK/xr1UUq9yQ4TmtNC9UsC3dzOKXDrdNnqA/8WUPI
 kpTp5ZA8rXRuKwROE2FutyTJwTwOMfdHzR9M5PMZaYnfJbbtRY4RQcXWF9hLfhYnp9A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794472388;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=s1Qj21qpcNfOQIR9sV5LF1bI2tlwUQfLEP8RYtsxPDs=;
 b=aix1mE+j9ogrrTsGiR6pzlCnavqD4+0DLByVredCd97nuaiKJT9hHFTovAoaHlc6TK2A
 p/vN7d5uYzgPHOguKVR6CsFrwCbNRsh/WW2yUe0i0O/lh992A6ZW7/TPPLhpAFiaTJyu+
 JTkJBNtSj4nl4SSNzN0pgystI4p+iDkeQ6SwAW5HfUt/APB8f82JkmZWPyVkvxLPT5qDU
 pdMNKt6t8SQ/og7Jn4boY6rRg+65LMgJHy1QpGimyp7iWQPnCAh0ynzCj8SHp3zFMwrw6
 G4qs1Dbh0/1GfLYqIEckmCVls5lN7TXbrUSvLYWkaBtlAm3yXT97Qp1fmlEz8KXnyoA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id EFB221F00A0E;
 Thu, 12 Nov 2026 08:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794472388;
 bh=s1Qj21qpcNfOQIR9sV5LF1bI2tlwUQfLEP8RYtsxPDs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=fULWnQEzBenPW//AusdSEtwF9InOwVooMr9vbTriZrgp8Nhxpyt7b2QiK74b4U1Sc
 RjL7GDfHfL2O0XO4O2huOb6f24rjA5xmJrFZu2qnyaLyi+6VhsKVvysdOZX1r0/By0
 PSP6yYJmLxjUbjrKHPopNlTl91qRqtTHyr/oZmUr+g2SA5G4jI+WQHNMPl9v5iCQnj
 /zlTmysAUaHIjd6O9Wvc3E+z3GW4GOtpjEop5HN7Go4WGrWhVYmWGqa0XRX91Nmukz
 SkpoY3pydbJmNPNa4S+9Yy+jJhAL45MYbqLrylGZL5XEEu4A1C33tlrRmvCQ5ydM9Y
 elG5silqoa7MQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 76D1C493AE;
 Thu, 12 Nov 2026 08:33:06 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 12 Nov 2026 08:33:07 +0000
Subject: [PATCH v2 3/9] drm/rockchip: vop2: Fix the HDMI sync polarity on
 RK3588
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261112-vop2-fixes-v2-3-8218c1cf8ac8@gmail.com>
References: <20261112-vop2-fixes-v2-0-8218c1cf8ac8@gmail.com>
In-Reply-To: <20261112-vop2-fixes-v2-0-8218c1cf8ac8@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: Piotr Zalewski <pZ010001011111@proton.me>, 
 Chaoyi Chen <chaoyi.chen@rock-chips.com>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794472385; l=1785;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=/jrSLrVkUlalHW0TPexjIwQp3BO194HjqfgHRaS4qLM=;
 b=Jg6meUyXq0Uz256Ig80kxHy1oSEEEHzihfWIPDgi7+o3Q6fpbL85hn/hAbCg0vMy9MpP3Odlr
 WQL9UBlqIQGBH0yPLhS8/8B/4jqeq1nmTgMzh6oC4mkeXm7Jf8wRuU0
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

rk3588_set_intf_mux() passes the POLFLAG bits of the mode to
rk3588_get_hdmi_pol(), which decodes them as DRM mode flags: the
VSYNC_POSITIVE bit is taken for DRM_MODE_FLAG_NHSYNC and POLFLAG_DCLK_INV
for DRM_MODE_FLAG_NVSYNC. As a result GRF_VO1_CON0 marks the HSYNC of
every +HSync/+VSync mode (e.g. all 1080p, 2160p CTA modes) as negative
and both syncs of -HSync/-VSync modes (e.g. 720x480, 640x480) as
positive.

The bits in GRF_VO1_CON0 are set for a negative sync; that is how the
vendor kernel programs them (vop2_get_hdmi_pol(), called with the mode
flags, sets them for DRM_MODE_FLAG_NHSYNC/NVSYNC on RK3588). Decode the
POLFLAG bits accordingly.

Fixes: 5a028e8f062f ("drm/rockchip: vop2: Add support for rk3588")
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
index 659fd0a3ab63..7c48b440cb29 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
@@ -1687,12 +1687,16 @@ static u32 rk3588_get_mipi_port_mux(int vp_id)
 		return 0;
 }
 
-static u32 rk3588_get_hdmi_pol(u32 flags)
+/*
+ * The HDMI sync polarity bits in GRF_VO1_CON0 are set for an active low
+ * (negative) sync.
+ */
+static u32 rk3588_get_hdmi_pol(u32 polflags)
 {
 	u32 val;
 
-	val = (flags & DRM_MODE_FLAG_NHSYNC) ? BIT(HSYNC_POSITIVE) : 0;
-	val |= (flags & DRM_MODE_FLAG_NVSYNC) ? BIT(VSYNC_POSITIVE) : 0;
+	val = (polflags & BIT(HSYNC_POSITIVE)) ? 0 : BIT(HSYNC_POSITIVE);
+	val |= (polflags & BIT(VSYNC_POSITIVE)) ? 0 : BIT(VSYNC_POSITIVE);
 
 	return val;
 }

-- 
2.55.0


