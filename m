Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E906FF459E5
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 21:27:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B32210E1FA;
	Fri, 10 Apr 2026 21:27:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FeJ5Vl/J";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1315F10E1FA
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 21:27:52 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4888375f735so24246285e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 14:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775856470; x=1776461270; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rP6p+GX7ae7bsdzZDj/7zTWSRCbnXDsptm9HOU/p8VA=;
 b=FeJ5Vl/JIR3ljToEgmqzDowE9XtB6P8+NaTAg8dBd7cfjZxzbgMGXg20qHA7juS7jX
 VXY63H2sKyXS+TXZmY9+w+WUItcdJCOI5QZRY5aViPF83BjdGBhxJCIG+B3rYxSRagd0
 69cT2Zrj/Sqcp9k5F/1+QkO4Z2z/NVd8Mxm/KQRlXKCfQxTCQ+0vNeiTlVdsr+L0Iivc
 7oPuoHpzQSyIh4uotxmDRGHK1oFXofxi/EmvMwBERC+ublGZs/jH2qTanMZtDehXYk1p
 OdcqR2+H17N8laTu2CVdUrTHQmjeeb4yrOAeptt953BkAQUrvjj+bv0HrMd8RzTdm6JU
 EAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775856470; x=1776461270;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rP6p+GX7ae7bsdzZDj/7zTWSRCbnXDsptm9HOU/p8VA=;
 b=KdY8jIriWsoUMD7dYyyjfNgpdrZ8mNASHSLbpQWaXqo9DX2g8klNCNZnpsRta4d3Gc
 6NpIAw8Ip0a00wUe4BaFKcvoiIWri7j4lyGn2IlUAStVOXVPrSediRei1ogJmjX6KDlp
 NnYd1mMuL3DJQW0Ix0CcJ2I+dGefGH+kdxuDvrnN03dygzpnUhJumvZAXx9tSXiNyAZO
 6928XAbuNo5m56ktkxE6QHZuafP/i7rGO3M7yOQ6t0P/Va99kbntBFM73WuS4iRS3BP3
 N+amr4WO+LFmkctBreNiwEpwX50hwS8DNW8JX0VDwDA81UM8vdDeA4nJuLx2bJiROm1n
 +Wfg==
X-Gm-Message-State: AOJu0YzKEhJLJbnSw169PIUEGgZmiWQODgV8g9ybLQU5141/gzuuKNWm
 glgyuoVcncWJMiiqL+vUhgGLzf/INWB4yuIBe0EVzp4orOuYTbl7/5YbkGX1iTnp
X-Gm-Gg: AeBDievQxZkOjzKm08g4aYsin4x6owQlxR8lDAoDanM8XYfgGPzX7gFHIecwNKby6d8
 LPByYButURLagjtbSCvM/bUPhuaTW1sh6mG8M+hQ2G14efgMufVMMqZYzmzDX3gTxKOk4S6wHbZ
 iafJkWp8/IR7pqTq3+cPt6K65Kd8/OzGlwV+6ZFEoqs5wgPqIB8T8OOJt7ViLxecqQOe618OV1l
 3W+S/unGE0yDoEjq+ir3NLZyxZujRqMLz5WUyIMIEOVhn0PXYBRYFlpR7gRCszNqV5VITDA6MHz
 WY7aPrj4oZSbY4X04oo69mFTJMKLSN37rj5AcCbCIHKg57i2TgFIhzfRwnAS5XU84cWtmXZwaRg
 nrfDuN/6M6Hw+Ueu+CHTZn1GOcm7l18dh+sAs/1GxraXNf0rYdcWc+F/OBSDeihrRJZTWS3vxCI
 6LpZN232+SkWytsBU3OtubietanOkrxCyQ2T9G2AlVniiu0EEbFAStwlwfM9U=
X-Received: by 2002:a05:600c:3149:b0:488:ae4e:519c with SMTP id
 5b1f17b1804b1-488d683d505mr59339415e9.18.1775856470331; 
 Fri, 10 Apr 2026 14:27:50 -0700 (PDT)
Received: from osama.. ([2a02:908:1b6:8980:d356:742:cb75:6153])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d5d9dd86sm49414075e9.4.2026.04.10.14.27.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 14:27:48 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: dri-devel@lists.freedesktop.org,
	luca.ceresoli@bootlin.com
Cc: linux-kernel@vger.kernel.org, Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH 0/3]  drm: remove drm bridge in error paths
Date: Fri, 10 Apr 2026 23:27:46 +0200
Message-ID: <20260410212746.413492-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
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


remove drm bridge in error paths for sti_hda, exynos_drm_mic
and megachips-stdpxxxx-ge-b850v3-fw

After sending similar patches for sti_hdmi and chipone-icn6211
grepping for similar cases in drm drivers shows these leftovers

Osama Abdelkader (3):
  drm/sti: remove bridge when sti_hda component_add fails
  drm/exynos: remove bridge when component_add fails
  drm/bridge: megachips: remove bridge when irq request fails

 drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c | 6 +++++-
 drivers/gpu/drm/exynos/exynos_drm_mic.c                  | 1 +
 drivers/gpu/drm/sti/sti_hda.c                            | 6 +++++-
 3 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.43.0

