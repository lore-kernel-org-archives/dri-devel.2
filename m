Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8940EC624A4
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 13:50:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A21C010E8F6;
	Mon, 31 Aug 2026 13:50:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EAky4o+Y";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7880710E8F3
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 13:50:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5FF674361A;
 Mon, 31 Aug 2026 13:50:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CCF11F00ADE;
 Mon, 31 Aug 2026 13:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788184243;
 bh=U0E64T3hJP4AE/m7rXCnZqVqgk4ckJPtMzLH6MWtkjI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=EAky4o+YYBfaSSR42j5fI4Lim+Lz5B0xWq8ELxGT+fsIJUntJEVcwO+cyeNeKMH3B
 fHQ1f4rhw34gwx9kC+5g5N2Op/HuA3DPZvDuPejKMRCSTO9gGEHDorMjclEx1nOiuz
 j2NaPr60vSNPebV+YtC/tTXsO7gFRemB9pCNv/heRPdWN1z2dP+srLKf5mZp+AFj3a
 0Crgir6/rM9nJHKzfGBFsro39m3nHN/aFoiDK8C/MEg1J/AmgbTAl+GM/g1OwWxRlP
 RlZZEBMhrrhSIgk8D7yyMCiCLQ3PUVqoBvpLww19wZcp2XXefYWRNicteh31yQXnhB
 bYDz7TPivIvbA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Linus Walleij <linusw@kernel.org>, Riccardo Mereu <r.mereu@arduino.cc>,
 Sasha Levin <sashal@kernel.org>, jagan@edgeble.ai,
 neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-6.6] drm/panel: jadard-jd9365da-h3: set
 prepare_prev_first
Date: Mon, 31 Aug 2026 09:30:05 -0400
Message-ID: <20260831133314.4125787-577-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831133314.4125787-1-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.48
Content-Type: text/plain; charset=UTF-8
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

From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

[ Upstream commit b55a4b5d4769a650f52ea3f1ae680610169d125e ]

Sending DSI commands from the prepare() callback requires DSI link to be
up at that point. For DSI hosts is guaranteed only if the panel driver
sets the .prepare_prev_first flag. Set it to let these panels work with
the DSI hosts which don't power on the link in their .mode_set callback.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Tested-by: Riccardo Mereu <r.mereu@arduino.cc>
Link: https://patch.msgid.link/20260413-waveshare-dsi-touch-v3-13-3aeb53022c32@oss.qualcomm.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

The background `git log -S'panel-jadard-jd9365da-h3'` search finished
(took ~3 minutes). It only surfaced merge commits — the first hit is
`5d324e5159d9e` (usb-6.18-rc8 merge) — which matches what we saw
earlier: this stable tree’s history doesn’t give a clean upstream
“driver added in commit X” trail.

That doesn’t change the backport assessment. The driver is present in
6.18.43, the bug (missing `prepare_prev_first`) is confirmed, the patch
applies cleanly, and the verdict remains **YES**.

 drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
index 5c2530598ddb9..9e5287829b952 100644
--- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
+++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
@@ -1157,6 +1157,8 @@ static int jadard_dsi_probe(struct mipi_dsi_device *dsi)
 	if (ret)
 		return ret;
 
+	jadard->panel.prepare_prev_first = true;
+
 	drm_panel_add(&jadard->panel);
 
 	mipi_dsi_set_drvdata(dsi, jadard);
-- 
2.53.0

