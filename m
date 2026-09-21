Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B33C982EE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 13:18:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB1DE10E433;
	Mon, 21 Sep 2026 13:18:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Refxku4x";
	dkim-atps=neutral
Received: from mail-wr2-f36.google.com (mail-wr2-f36.google.com
 [74.125.225.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1362010E433
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 13:18:31 +0000 (UTC)
Received: by mail-wr2-f36.google.com with SMTP id
 ffacd0b85a97d-4843c3ee4cfso1636401f8f.2
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 06:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789996709; x=1790601509; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wLXxJpO62SZg+/+LfN8p0j/MPIgPoypDyyyAsTbLZEk=;
 b=Refxku4x+qCwC1thf/2yxqt1Twg7w6TFJzEbH+xu4lPcK8PMvFdf3SlpEwv5VnGE41
 /LqefZpYJ5Pg8Z09ycs6iPYdZ+SEzILMQMGRdq/TZmNqKeIYj7sbx2BpTJtDKA/BchMn
 pDkf2WQxVRss1Avvr0arVtJ+0DdaY7x+vifDZxElBdBTpuZXK6UdR9EAtEFLyOAvGqwH
 u74ury05LBYTjd9lYI14yWQevsdXQxS9GgBFJM460E6YJK1N5q2C27pVMw2u7ZbF9Oa5
 1ESKVG991MjVzvV2AEs+m1aC6YOhh3Oa28jjv4yEfyQkO77Dycibq/6PX2Cc3VLyxiX7
 1IWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789996709; x=1790601509;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wLXxJpO62SZg+/+LfN8p0j/MPIgPoypDyyyAsTbLZEk=;
 b=ifFO5PGog61LSX6KwrNG6QiaR6xmYS7KCihSMqvbRwfcCUeG7tnhHwqq6OFmYb1iAy
 scEScTdv+d2elGa6ke2/E0UEcjs9uD4SuWgydiQETtvAPueFPX84ZJ8p4sVLSiazLoBh
 A8PkYZFV6kgCmHHqdzatud7F9+pQbPFXjUJ9WmwPMydFSSmbPl4fotLNbc+0jhhM3Vg8
 Ccy9j2SmaAenfYAnm7hWMhzwicasabDo2jWShVv9u028g78nTmgZ3hNEqUg8d9jBfMxK
 9ZofdLnDbYD6ApbcRaDblHwncramMEj3S5dCNKmbUkXK7FCKWm/sW9lxFbADeiKFQNE4
 TFRA==
X-Gm-Message-State: AFuF++mA3hoHJroGLHiKdBQuZ9LJhShHyLHNsr24zb0ed99SWE0evCZd
 aWPbmEGTUpgwNv8KDPII9rzCAaqwjGZod3/2ZsJwJ9+JAbM3H6CIGHJY
X-Gm-Gg: AYBFou3a5LFOPULIyR2nd5sWLXf1rwhkCyrT+B/HBQJvzslgT6R3lNiFex+Dv5wSkuP
 pWY3p/DbZ27owR78/5VhzskiOpUNyomSiCoRu8EVGhMJI4RbThSRoyzX7QcCQpO+6mGWzwIB9BK
 ov9cScyMeCqaLPEI5/W1CGFQVCux2EQdt0VwqEvE1eMzO7wO8OToRluxlELKosCu0PumCPh9dTm
 BQHIZmeoInxwv5TL083ylE6r37Rnk9zZfJE06dJLLy9JJ8FABWFCYNT1v5L60wOZM26TIlfgzB7
 5G3/73mRM4GpGQ1oxdg6zCzjAvPAM03tVIr9dDHKPtOA2SVj1Ix59h4DHoQvHDsrI3rTQZJgCP2
 4adCuDz+6NWNPvENy3q9NJK4cSJ03SssxBvJZBOr0nBrStQJmZU7wpqTvBfRQiAty1PD1YDd961
 lxN9dp526Trfhh2TPt1IQrT3vZzWxMBK3EMe+IYFjRZes8fTcbe+No3OAJ22S2sltrkoKMVO6tK
 ijUI4tuGvSfQ2fbGzEpmQRZ1ZgXbficlg==
X-Received: by 2002:a05:6000:2302:b0:485:af9d:cd1f with SMTP id
 ffacd0b85a97d-4871e37b88dmr14650398f8f.51.1789996709116; 
 Mon, 21 Sep 2026 06:18:29 -0700 (PDT)
Received: from osama.. ([156.223.80.28]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48724460978sm22198797f8f.11.2026.09.21.06.18.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 06:18:28 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH v7 0/3] drm/panel: Use managed helpers in DSI panels
Date: Mon, 21 Sep 2026 15:17:54 +0200
Message-ID: <cover.1789994813.git.osama.abdelkader@gmail.com>
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

Hi,

This series converts straightforward DRM panel drivers to the managed
MIPI DSI attach and panel add helpers, dropping the corresponding manual
detach/remove calls from remove paths. Split by driver family/vendor to
keep the changes reviewable.

Patches 2, 4 and 5 of v4 (Samsung, Himax/Ilitek and display vendor
panels) are already in drm-misc-next and are not resent here.


v7:
- Changelog is trimmed. No code changes
  from v6.
v6:
- Drop panel-simple and panel-dsi-cm: both run extra teardown after
  drm_panel_remove(), which devm would reorder.
- khadas-ts050, tdo-tl070wsh30: fix build break.
v5:
- nt35510: keep manual attach/detach; remove() powers off after it. (Luca)
- panel-simple: split into its own patch. (Luca)
v4:
- Use devm_drm_panel_add() instead of drm_panel_add().

Osama Abdelkader (3):
  drm/panel: Use devm_mipi_dsi_attach in BOE panels
  drm/panel: Use managed helpers in Novatek and Raydium panels
  drm/panel: Use managed helpers in assorted panels

 .../drm/panel/panel-asus-z00t-tm5p5-n35596.c  | 20 +++--------
 .../gpu/drm/panel/panel-boe-bf060y8m-aj0.c    | 19 +++--------
 drivers/gpu/drm/panel/panel-boe-himax8279d.c  | 23 ++-----------
 drivers/gpu/drm/panel/panel-boe-td4320.c      | 23 +++----------
 .../drm/panel/panel-boe-th101mb31ig002-28a.c  | 24 ++++----------
 .../gpu/drm/panel/panel-boe-tv101wum-ll2.c    | 23 +++----------
 .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 24 ++------------
 .../gpu/drm/panel/panel-chipwealth-ch13726a.c | 20 +++--------
 drivers/gpu/drm/panel/panel-ebbg-ft8719.c     | 20 +++--------
 drivers/gpu/drm/panel/panel-elida-kd35t133.c  | 20 +++--------
 .../gpu/drm/panel/panel-feixin-k101-im2ba02.c | 19 +++--------
 .../drm/panel/panel-feiyang-fy07024di26a30d.c | 19 +++--------
 drivers/gpu/drm/panel/panel-hydis-hv101hd1.c  | 24 +++-----------
 drivers/gpu/drm/panel/panel-innolux-p079zca.c | 33 +++----------------
 .../gpu/drm/panel/panel-jadard-jd9365da-h3.c  | 19 +++--------
 drivers/gpu/drm/panel/panel-khadas-ts050.c    | 23 +++----------
 .../drm/panel/panel-kingdisplay-kd097d04.c    | 30 ++---------------
 drivers/gpu/drm/panel/panel-lg-sw43408.c      | 22 ++++---------
 .../gpu/drm/panel/panel-lincolntech-lcd197.c  | 20 ++---------
 drivers/gpu/drm/panel/panel-lxd-m9189a.c      | 24 +++-----------
 .../gpu/drm/panel/panel-mantix-mlaf057we51.c  | 16 +++------
 .../gpu/drm/panel/panel-newvision-nv3051d.c   | 22 +++----------
 drivers/gpu/drm/panel/panel-novatek-nt35510.c | 13 +++++---
 drivers/gpu/drm/panel/panel-novatek-nt35532.c | 23 +++----------
 drivers/gpu/drm/panel/panel-novatek-nt35560.c | 19 ++---------
 .../gpu/drm/panel/panel-novatek-nt36672a.c    | 25 ++------------
 .../gpu/drm/panel/panel-novatek-nt36672e.c    | 21 +++---------
 .../gpu/drm/panel/panel-novatek-nt37700f.c    | 23 +++----------
 drivers/gpu/drm/panel/panel-novatek-nt37801.c | 23 +++----------
 .../gpu/drm/panel/panel-orisetech-otm8009a.c  | 16 +++------
 .../drm/panel/panel-osd-osd101t2587-53ts.c    | 23 +++----------
 .../drm/panel/panel-panasonic-vvx10f034n00.c  | 31 ++---------------
 drivers/gpu/drm/panel/panel-raydium-rm67191.c | 22 ++-----------
 drivers/gpu/drm/panel/panel-raydium-rm67200.c | 23 +++----------
 drivers/gpu/drm/panel/panel-raydium-rm68200.c | 16 +++------
 drivers/gpu/drm/panel/panel-raydium-rm692e5.c | 20 +++--------
 drivers/gpu/drm/panel/panel-ronbo-rb070d30.c  | 19 +++--------
 drivers/gpu/drm/panel/panel-sitronix-st7701.c | 13 +++-----
 drivers/gpu/drm/panel/panel-sitronix-st7703.c | 14 +++-----
 .../drm/panel/panel-startek-kd070fhfid015.c   | 24 +++-----------
 drivers/gpu/drm/panel/panel-summit.c          | 15 +++------
 .../gpu/drm/panel/panel-synaptics-r63353.c    | 25 ++------------
 drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c  | 19 +++--------
 .../gpu/drm/panel/panel-xinpeng-xpp055c272.c  | 20 +++--------
 44 files changed, 183 insertions(+), 751 deletions(-)

-- 
2.43.0

