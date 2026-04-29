Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C62FF8867
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 10:10:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EE1710EF28;
	Wed, 29 Apr 2026 10:10:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="axb468uP";
	dkim-atps=neutral
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com
 [209.85.128.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 817F110E3A8
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 02:50:03 +0000 (UTC)
Received: by mail-yw1-f182.google.com with SMTP id
 00721157ae682-78fc4425b6bso124414517b3.1
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 19:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777431002; x=1778035802; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bEcKFoy1o4f1may1pNJc6Ss/wPvSop5G6kcO/t8tvuA=;
 b=axb468uPDtQGYL8GhJ62NyLXsLe+YPezezJD+WRiXTiZeIhUo1FO6PYcKVG3jYJriV
 J7tbIhj8BzDTXKs1eMBDL9ofQ+nAKRvhLaIHHAsCOZkdNkIUfQ9EKV29Px1/3ChYLzlG
 8r1/KDLwR23/lLoooMaUaErQlUfqiwxWGzpq6WDI60jW0dejhyUMuJBj6kynrG8EKsa+
 HohRA1Z7EidldmUOSSCS9UmzsTwDB58N/prvM2whmuMDCzDJQiltZrJMNdx3Qn5LOWFa
 dfm3O7S/11zK9/1Q27cAXiSnBFKeUsOR2p99lLAjGr/4I008uNvWOx48jTsgD8UNUnET
 YW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777431002; x=1778035802;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bEcKFoy1o4f1may1pNJc6Ss/wPvSop5G6kcO/t8tvuA=;
 b=pFnAXVtXqrgHq1pj148fNCVU+Gp4wCoy08Hg/qVPIW8iq036GPDax5uhv5Bjh1822W
 hUK0aGMMGeNKbCk3Y5am6AqBleb5ZcpVnHirC+VPBB6lcoKbwl6ukNxNjq80Mmk8YWph
 dS0PT6bkQchIucUBOnVC5/ymZlRQGIlF3bXrL5I0d8w7uCpFF8m5mCZ1CYBbYBhjOUVC
 ezLaYc7lXsyiVJhdX0dLqcIP2L0+i5mnpcG8S85l9+7NHwymQpzvdudBn6b78YsbFMa8
 x47FxLB9gTz9ivums8ebjJDjFRi7zKZSi5OyKZeVsBa99RJvmxh7ZyUvta+6sYfwj58J
 peIA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9kxRXsDk3ybvMFIAUPYqYIviT08Br6LwVKi4gVEVPanAGO+qzFj2Xel8xXjSjHWPLfeJ9OMailR68=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxdpB4LSeLZPlQNtkXbquOFCTEfzBJ8Et7+7KF1+mw7FKRB2uc5
 Jp+piFFL/L0bPphSS8k6CB0bfNuF+wLtExk2nfbDMLkYPV7HLGKTrTbf
X-Gm-Gg: AeBDiesR231WAIH85o99YjDPHX6VnV5AP3zF4f5yXmcdGwXeqHx0dO0b4dltBZgWIJP
 bC33oqnsFSrZgl8eCYc/7MPCM0bSKVQbUS9tTXowI3nj5440Vu1dSSuzepyufxhmdmmxB6oxys8
 SVOgoT3lgFfgrTNhnbTx4polTHlJa64SVGhhnNB0wao0pyUh7veJd41FufkHNIB7/lnG/68yzwb
 pU+0ixV52TKvZHdzc2/uO6xA6fuAtpK/SLT5X9ftLPnLSJGGQB49HgEHfphUh8PBQPKT5W771Yt
 zbutAX+R76QSP+RbA3ihPFxFyIbaf/R1sCtDw2uIwul4Y9EpfzGKaxGOxZA4ccd471Kev6dpl3N
 48e3GPlfMoxQXu9yE//GnNefDXSpXoQobfnUgeU3Qk53TmXK6nNIs6jn+KPnWGT1CxnNGyO1soC
 MiY4rm8gLHEChGx0YyI3maBUEQP4kd3sTOAXFJ6BYD+tY3FsxeIP/UGn5F4etyt8+TFIkEMncEB
 T3ZvbCjezuO2U2VkyUiX0C+5gLa4RjrHHo=
X-Received: by 2002:a05:690c:2610:b0:7b9:ed52:deed with SMTP id
 00721157ae682-7bd1d851418mr23852557b3.26.1777431002488; 
 Tue, 28 Apr 2026 19:50:02 -0700 (PDT)
Received: from tux ([2601:7c0:c37e:2360::111d])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7bd259e3d9asm8380007b3.45.2026.04.28.19.50.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 19:50:02 -0700 (PDT)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: Jagan Teki <jagan@edgeble.ai>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Linus Walleij <linusw@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH] drm/panel: jadard-jd9365da-h3: Fix signedness bug
Date: Tue, 28 Apr 2026 21:49:54 -0500
Message-ID: <20260429024954.697411-1-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 29 Apr 2026 10:09:58 +0000
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

The function drm_of_get_data_lanes_count_remote() returns negative error
codes and dsi->lanes is an unsigned integer, so the check (dsi->lanes <
0) is always impossible.

Detected by Smatch:
drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c:2959 jadard_dsi_probe()
warn: unsigned 'dsi->lanes' is never less than zero.

Fixes: eb019688f2a97 ("drm/panel: jadard-jd9365da-h3: support variable DSI configuration")
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
 drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
index 7157b1299bfd..f6b04de1182e 100644
--- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
+++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
@@ -2955,9 +2955,11 @@ static int jadard_dsi_probe(struct mipi_dsi_device *dsi)
 	dsi->format = desc->format;
 	dsi->lanes = desc->lanes;
 	if (!dsi->lanes) {
-		dsi->lanes = drm_of_get_data_lanes_count_remote(dsi->dev.of_node, 0, -1, 2, 4);
-		if (dsi->lanes < 0)
-			return dsi->lanes;
+		ret = drm_of_get_data_lanes_count_remote(dsi->dev.of_node, 0, -1, 2, 4);
+		if (ret < 0)
+			return ret;
+		dsi->lanes = ret;
+
 		if (dsi->lanes == 4) {
 			if (!desc->mode_4ln) {
 				dev_err(&dsi->dev, "4-lane config is not supported\n");
-- 
2.54.0

