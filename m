Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41917CA5FCD
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 13:33:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6166E10F3F7;
	Wed, 30 Sep 2026 13:33:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UgwRw4V0";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 192EC10F3E4
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 13:33:07 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f6350f91so3136851f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 06:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790775185; x=1791379985; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/T8gMBX5SXPAGkoLIA5GhKIYAcxw/XWcrRzadX1Y9sM=;
 b=UgwRw4V0MKi4RrbDg25jV7+kCpvGFjwRSAt3JDw4WG0Dt8upblJ9LjhL2mXDZ3mMz7
 ThlIqXBmiJ78OYEo+nGZCh2as1XDfDqLiFvksjOla8Q0YKLyJHW+ZUuoTOrc4OiYMsZx
 zOIUTN1CjGwTTWpianGeksKxmubsQXTEg6ppbVRjeiBaSW8xkKvOStjP5ooG/iCp4pDl
 +vH4Pj6hSDFn7fahdv/HlmSYL2qxwoMRROZX/spBB1FFXvhXh+Q7tq5lWR+g4p/A8MfZ
 MdiWwWQ/DeMWWKpalFZoqerR2j+yP3tgw9YQC3p9Q1g7Xzxc0YZQO83f7xTK2uNAsO/O
 FOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790775185; x=1791379985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/T8gMBX5SXPAGkoLIA5GhKIYAcxw/XWcrRzadX1Y9sM=;
 b=elwVm9IFS5Jd5pzeWyP0Kx9XM2+82OnHLSXxumBVTcE/zbTmRKHDSjEzTC1woc0Zf/
 xFkF9+ir3GhXQR+x3rzW/3GkTQlhVmkG96nPuCAf8LfSeP4nhZb2kpqjzZbUBGJJqlD9
 8NJzzVUQXKkuQQzeuVweX2zXxcXpgt+rkgJzHcdFgpI6X+fB7wfmpwXNtWJs7aLbES7+
 Rk3P5Q+BEuFEAj76AhqPGQps/p5Pn7dHj5iZERjaSUNWY14uTuJYu0ICCMlH1qOPcrbQ
 k4eonyk0qsiP/KmhHCh65JbutmMRwPhc0LR47oDQxrk7gExPRU9t257gYVtdbUDKhgl3
 20xg==
X-Gm-Message-State: AFq9FYKXeQ+kSzZwhWREHXd/EHvGHLcF/mjaSxRy5MKKVm4HsKYNrZvX
 WTA1eoMsBooId8Y+OUnDo5BobqNYpfVYDQH0YUOkxXNLE5vztu0xdWqn
X-Gm-Gg: AYBFou3fZkkaKu3FaA/bA3Yrz0NCYfTWQCqw+hskVXMsTW7VrqdOxiT7Xfnh8TjbxLH
 LJomqAkLGQ59QsjCaYQ2mBsn8r+iJChrYMISx0SRj12ey1SsDk8MI3g8XsZRru7GTW9oPPXZg6l
 iIEZPRJpc0cl8n8Cex2eUueTYWMzWEm33drv8Ep0MIC5lmnANtq/5MJGNpG4Zr6UW5KBo/SayXJ
 b2ViFpuvHXcEc0Ls2Eyf9Aa6krFDA9a2r+2Lwgzlg1m8iipXLqXkrPEnsqGlqhahxYUn4C2HZNe
 bIcTDRJ3SgT2/vg/fcsZcMrF20SOOaEnmCcwbTuh7DdQ3Jo+2i87zz+SDmRMQSNk/sig6cQZmKR
 ZlUcKOjAxmvF9KW0mQA0E9n6tW89LybY/SgHi85Ba/Y2Y9dfFB9DY3TEy1dKPi6ODpatxr7W8Pa
 ll3zHOWpkimJIcbx8Tn4SGBQZANcX8If2bR6ApVdQSXrWEODRrVkvVTjU5FnUoai+f7aL6epG1z
 8K3NGO5cvMjBJNPovlsGDU=
X-Received: by 2002:a05:6000:605:b0:486:f46d:bb02 with SMTP id
 ffacd0b85a97d-48b02585d75mr2843621f8f.57.1790775185199; 
 Wed, 30 Sep 2026 06:33:05 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:bade:1500:bcd:b3ec])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b029f2b02sm3685582f8f.24.2026.09.30.06.33.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 06:33:02 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Subject: [PATCH v4 2/9] drm: renesas: rzg2l_mipi_dsi: Add activation_dly to
 hw_info
Date: Wed, 30 Sep 2026 14:32:44 +0100
Message-ID: <20260930133257.23210-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930133257.23210-1-biju.das.jz@bp.renesas.com>
References: <20260930133257.23210-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Biju Das <biju.das.jz@bp.renesas.com>

Move the post-reset activation delay into the hw_info structure as
activation_dly, allowing SoC-specific values to be defined per
compatible. This prepares the driver for supporting SoCs that require a
different delay after reset deassertion.

Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3->v4:
 * No change.
v2->v3:
 * Collected tag.
v1->v2:
 * No change.
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
index 2128fd16ebc9..1538eeece2b5 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
@@ -59,6 +59,7 @@ struct rzg2l_mipi_dsi_hw_info {
 	u32 dphyctrl0_init_val;
 	unsigned long min_dclk;
 	unsigned long max_dclk;
+	u16 activation_dly;
 	u8 features;
 };
 
@@ -806,7 +807,7 @@ static int rzg2l_mipi_dsi_startup(struct rzg2l_mipi_dsi *dsi,
 		if (ret < 0)
 			goto err_phy;
 
-		fsleep(1000);
+		fsleep(dsi->info->activation_dly);
 	}
 
 	return 0;
@@ -1534,6 +1535,7 @@ static const struct rzg2l_mipi_dsi_hw_info rzg2l_mipi_dsi_info = {
 			      DSIDPHYCTRL0_RE_VDD_DETVCCQLV18 | DSIDPHYCTRL0_EN_BGR,
 	.min_dclk = 5803,
 	.max_dclk = 148500,
+	.activation_dly = 1000,
 };
 
 static const struct of_device_id rzg2l_mipi_dsi_of_table[] = {
-- 
2.43.0

