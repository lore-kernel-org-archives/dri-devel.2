Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E022CCA9ED5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 07:32:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA0CF10E3FB;
	Mon, 12 Oct 2026 07:32:02 +0000 (UTC)
Received: from mail-qk2-f4.google.com (mail-qk2-f4.google.com [74.125.230.196])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ED8410E0CD
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 00:43:03 +0000 (UTC)
Received: by mail-qk2-f4.google.com with SMTP id
 af79cd13be357-93cc7e652d7so79923685a.1
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 17:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791679382; x=1792284182; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=X9wwtOfFZ3dlRyxA00OaR8axrYegTwtr34ydCtqSvyE=;
 b=jc7yzo0PZYhyrfTDblDrjelHuk5OOai8lnFv3Oa0MRSMy0ZjC+Ld17B0s0JDTTPMD5
 mQF8R7M5COFTAfVaM7QIjrUe5aimwACZ8MIsTYub5OA1Q0syJ5bieC8iE2yIC5ufHDSk
 g1/+3g2COXcHtSwFhGu77RX2l1YVGalBrBDZSrSzWbG5XtWpeSktEKX/nINdPq4qeL00
 FkF00WpzQTCRBTehWD2zvDhKyc/8022nSNqF/mGjq3Ck1GHiEggvzhHfNNU1UBS+nlP3
 9znpMQ+0OAzlNoSLM0W03rXHsXSAq//R3YhyTZthPujJdwT6jdVTajkUENKaC0va+hST
 25qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791679382; x=1792284182;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X9wwtOfFZ3dlRyxA00OaR8axrYegTwtr34ydCtqSvyE=;
 b=uASM/dUh4AwC9jAemBoVvcB6gdpmiMwisxSp+MayaZ5fd62HEeqmf0Q1QeNEMde6LN
 IjplVtJK0AiBmglLSfS3d1FQKrerIr0zgX+1KR7cSjhcVEpEJtgVRti9Hr0/BhnSqUvY
 KsxOoeNujQPozi7efH/KvRy/60+Im3nmv09IL2cVzxHu4V6ZpkWPj8kV18ekoADQ2XT9
 +F4Ip3cuITg/j3gP38GY1cUX7ZdRefVkHxEIziqPjxFUh3x1wvonzypesLNz8WPtahQU
 pdWnn7LZZv8OjMRK+06VE3thHKUyYJnjwMqWR25U8v4B/5Ljbsu9DdMX9ISDfMY5+1sn
 +pAA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwsXH6Uzr61fhfBh20ED+OPekF5PG7sHjJkgasnPNIEHz9E9H2OgM4SYpg1QxJSrMDh8xH+J+BL/eo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIqfxb9v2GQ0D8wKKqUbOYJl8iFkpBvS+B2CU+HCCaTQ7fF5OVg
 x7/rROndmI39uYecMCp0yklhvk04PPli7vxcIyHWsQ7AGy72bEtSPMVk
X-Gm-Gg: AYBFou302TKR5/hJlCt+sZYTsQKMRz+03qQQX+z+vtHCjBPAJBzFW3gZ/lkJqE9jKTq
 nbsBedMBecb9w9alBOTwTqxLYfUNBj/rtfEXLUXvLeq0cmaCitonB18o+H9TumW6eN7GFM++oI9
 BBYy4b78H5F6hbXbzTzmgutRsf1RePX6Pc2E5jsU7QmvAQWesgKx8AX/OMJeYFiCv1QIzVyZxak
 8rXAZKUENA/D6yOM3XjXDfGSk/hUzywlCUqeeyWboO8xg83bOvd6ZtAwvB3n8hfYbVRMZNKVok9
 NEwKq7f9+8I7BQqs7cwOxdawxIi7NiYESzxmssk2Cgej92oMBVC7mpq1JZfsLKpDfz8/KtnMF8q
 AisvqAK0jKGHvu06TNM+ZLboAQ+nThC3H/PoHYviWoTLkBWvgp90ezSKeLrU5FftLl3QMid0IbP
 aJ85Iu7uSWyfkUrNWPWxk5OdAIpC9/Pk/mSmmDiKHfBq6HoLGAJJxWKoKLc4hwL8fPS7o=
X-Received: by 2002:a05:620a:3194:b0:93e:942f:b8a6 with SMTP id
 af79cd13be357-93ebd2973f0mr1024374385a.59.1791679382152; 
 Sat, 10 Oct 2026 17:43:02 -0700 (PDT)
Received: from omarchy ([2601:804:8780:3df1:6ff:277e:31c7:ac13])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93eb9848702sm532320085a.12.2026.10.10.17.43.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 17:43:01 -0700 (PDT)
From: zoan37 <agentzoan@gmail.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Jason-JH Lin <jason-jh.lin@mediatek.com>, CK Hu <ck.hu@mediatek.com>,
 Nancy Lin <nancy.lin@mediatek.com>, Nathan Lu <nathan.lu@mediatek.com>,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] drm/mediatek: mtk_crtc: Fix connector route handling
Date: Sat, 10 Oct 2026 20:42:45 -0400
Message-ID: <20261011004248.1117649-1-agentzoan@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 12 Oct 2026 07:32:01 +0000
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

Three fixes for the connector routes of mtk_crtc (the output component
picked at enable time from the encoder in use), found while bringing up
the external display path of an MT8189 Chromebook, where one CRTC
drives either an HDMI bridge on DSI0 or USB-C DisplayPort on DVO1:

1. The route components are looked up in the private data of the mmsys
   at index drm_crtc_index(), not of the CRTC's own mmsys. It only works
   by coincidence today (the only route table is on MT8188's CRTC 0);
   on MT8189 it oopsed on the first HDMI hotplug.
2. Destroying a CRTC whose route slot was never filled dereferences
   NULL.
3. The route is only picked when connectors_changed is set, so a CRTC
   whose connector was attached or swapped while it was off is enabled
   with no output (NULL dereference) or with the old one.

All three were compile-tested with W=1 on next-20261008 and run on the
MT8189 board; the per-patch notes say what was and wasn't exercised.
The MT8189 display support itself isn't upstream yet; these patches
don't depend on it.

The changes were written with the help of an AI coding assistant
(hence the Assisted-by tags).

zoan37 (3):
  drm/mediatek: mtk_crtc: Look up connector routes in the CRTC's own
    mmsys
  drm/mediatek: mtk_crtc: Skip the empty connector route slot in destroy
  drm/mediatek: mtk_crtc: Pick the connector route on every CRTC enable

 drivers/gpu/drm/mediatek/mtk_crtc.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)


base-commit: aac26bee2287c88af5be5a5ff96d783b19a28790
-- 
2.43.0

