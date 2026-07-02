Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65948C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 19:42:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A399110F560;
	Thu,  2 Jul 2026 19:42:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Wz3VF8BX";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3146910F560
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 19:42:45 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-3810e733d85so592212a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 12:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783021365; x=1783626165; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Tm4bDoApmpWrd6k5Z19j/I/Eof7hJXg6y8wwhqvnFu8=;
 b=Wz3VF8BXitgJTBopzhoRhZeR1e52uUFSiPlPB7hel3lk5v9oua4TTURw3k67on+C0I
 mxegcBwCWjs53M4JPOmtf0Z5OK2qbbKNd+pe1EIQwZ469yitB0qak2UuRtZEIYdGP+7R
 pPZpYRo5TFjm//9/QcXHv5pj13FB5PKTn+xRe41hlsXVuD/LlasCJgIl+G71rW9awL8H
 Fzy/znu4jMNd/VchfhbPOI3zOUrW1mCNxUph3T26snbE0OzZwtedM6vt02NHMEagZkH6
 BbCx2R7obhaxM+SU0hfCHUc0QGHPjMTtS5qul0X0y1zIKNSOl29plhmdMuDGv7jaGfuh
 3Y5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783021365; x=1783626165;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tm4bDoApmpWrd6k5Z19j/I/Eof7hJXg6y8wwhqvnFu8=;
 b=cOQoRs3gXoI14kaPYUBNHwo8LqGXx+nqwJk3Drhuo7srU3Bb9XTIKxGpYbnenu+e29
 kCdoxYq+vQ0SOYVolVYeiHfRZ+OkcSzbi1vk9dSjUyCoOtSVVIYZAIWjHrvvrnEnj103
 x5CWhALbWCNOJiXPK1sNi5SVgvYFu7IE+svnE+97Kuotv9gMUQwH1r5DEHuUQArEbEBA
 0BKc0iVsUeTopVKkKlR24niJ3HnWE5IddReo2v6tHVzbS8mZbMhrzLM25hZwgwn2pH3G
 sca7nV/jjuK7APMNvBWxAMHEkKE5QlZwRk7Gx/yMEkF5I68pY4S5FJkYv+rvx+tjN3X3
 AgCQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrFMCO6KXpfJecZYomOTdDEAbwrFEojcEod/1G3XLAsFQOndxgArRGmZ1wPOa1/n6rEN9nkSCp5hTI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyCrl3tcA70Dff6RNDO/8Kp7hnb1BkG4/vVkZR9dIQm46KDLBVs
 CEWMDpzFNMdi9xvCMl9XpI3LvsVWxwZsZDU9uj1b1PtmGfcPaMy++EM=
X-Gm-Gg: AfdE7cnfTknCf713HL6QB+iKTMAcp4cPAcxYeTb7xKBFTnn/Ekcn9unHX7Cn/4AA2jy
 OLmM4ZCByIxmJU7A2wV/48zRDMODAfK5oRMb7k5ebwGEmb/vVCADl1q1biKSu4t4Li7y027uSlJ
 C/7fpyjwnPELjF79/dqKAOELlKPqg/qDLPrktVM4gr2fjP/McRk8qF95xj6MaZdcs0wQ+I/K/k/
 LzWp7BglZXrXE44/lUKOL4f3ZbhQk3F61SIw0kbV3vH45ljtQVRzSdhvuLFfh+Ro5+wdD/iQX0F
 YslvHEYzo8WRk7yjrguhOEV/namP9ULFaZcOBWhtB+I4zW1pVGXq60gAhieGs+36jCE9kQ2TRtj
 UXKHCG8Ot8so9RsQDUVccEHn8IYBGmG5UUzcZF9MjWY1Ocn2x+3/sqZqONP2YzI2jAiGyG6yjZn
 JUEWwxzs2DlH9rAj4E9gq4P1xnFzlf0IZU1PfFOht1PgeNMq3L4iCcGc/o44q1oVoZ
X-Received: by 2002:a17:90b:3b4d:b0:36d:ae6a:22fe with SMTP id
 98e67ed59e1d1-380aa1cad55mr7849058a91.16.1783021364547; 
 Thu, 02 Jul 2026 12:42:44 -0700 (PDT)
Received: from localhost.localdomain ([186.158.238.108])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0b7b9a8asm12923165eec.2.2026.07.02.12.42.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 12:42:44 -0700 (PDT)
From: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>
Cc: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>,
 Brigham Campbell <me@brighamcampbell.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/mipi-dsi: docs: Mark mipi_dsi_compression_mode() as
 deprecated
Date: Thu,  2 Jul 2026 16:42:18 -0300
Message-ID: <20260702194223.290763-1-nico.antinori.7@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
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

The mipi_dsi_compression_mode() function is a thin wrapper around
mipi_dsi_compression_mode_ext(), which is already marked as deprecated.
Additionally, the non-deprecated mipi_dsi_compression_mode_multi()
alternative exists.

Document this deprecation to encourage developers to use the multi variant.

Signed-off-by: Nicolás Antinori <nico.antinori.7@gmail.com>
---
 drivers/gpu/drm/drm_mipi_dsi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 3ac1dd5ad640..9e20818f2de0 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -699,6 +699,8 @@ EXPORT_SYMBOL(mipi_dsi_compression_mode_ext);
  * Enable or disable Display Stream Compression on the peripheral using the
  * default Picture Parameter Set and VESA DSC 1.1 algorithm.
  *
+ * This function is deprecated. Use mipi_dsi_compression_mode_multi() instead.
+ *
  * Return: 0 on success or a negative error code on failure.
  */
 int mipi_dsi_compression_mode(struct mipi_dsi_device *dsi, bool enable)
--
2.47.3

