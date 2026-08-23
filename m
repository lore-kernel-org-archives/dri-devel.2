Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD9EC5DF8C
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 11:20:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9535C10E4D1;
	Sun, 23 Aug 2026 11:20:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AITcRx6Q";
	dkim-atps=neutral
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6A3A10E3EA
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 11:20:23 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-c247f6687dcso270840866b.2
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 04:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787484022; x=1788088822; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FM+ywSXoVmivGfPkou8dixjoNeI0v4/sGEtAdMoWSOk=;
 b=AITcRx6QrY9Ipzz3pLVMt9UQdl9FzUCuP2fijfUt1BWe7LQJ4LNaIZoQH3w2xExG9A
 Pu2/HX8Kuu0CTrv3EHvInDRDbgrqM/3bq+/KOM0XeV6QMkmOrnTZnJWow3s8AmULbAJL
 /PXxA/6LnWyJ9Zk14vWEO1fHYblt/fpGFobiOnNJb8mLQKFaI6IaTJsV1HuDaQeBx0Tk
 ZUDCRZfQ8h8mFAhixhe7Q5jH0s03xPok+RAEVELiBX5QWj4yNfzax2fk9Ci98b/6WEje
 RzX2tuZCUA82k65LvtjM8lZd83JfDIG3aDF1WkiKAHj/Ec1p2kf2YWClSvG+FrbauwZd
 pj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787484022; x=1788088822;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FM+ywSXoVmivGfPkou8dixjoNeI0v4/sGEtAdMoWSOk=;
 b=aTgbIvhaumsKEPGGwoZ3V1/13MB2qF9xukXQwC9O01TrEJI2RDyHQJbXVcyB/n7MnN
 A1BDQcN0z/5BO1RJGv4chv2XonQ8QDnsh8jTeRpLh7H1xn8vYSecfZqs/fpU4U8wXRAU
 XtGkR8MsumJ52fpDl+lKf8Jt7BQC4wUdmvFeh+QOYjTd2A4QKyGkzy/IVSFL53EN+dg3
 LbMRxZEj3WFOHXoZnS76/zG5rOhRDzn+dGgWWCyAoUxa7Pyu0Tsclal6ktnRhto/Fiis
 v2WUX2w2k0Y0iVHkmvhg+hsycuHSvnvH7b+glsHl4IJU5JdypxBSmoleXJzb2c4nfGAo
 PX3g==
X-Forwarded-Encrypted: i=1;
 AHgh+RpziUn+BCRCCZvF/qA2McwPHMRIcoC7ajgsarRn2DWQ6GFZZdSBD09PZMEJf7PCyxIHvEES/TLJppM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n0TUSe1VVo3EmvVc69Qbsg4xOkwHV9XY24UU+AFFxT2wDIB1DF
 D6ItxpJ5SEz4su0NjjKaoJ7j7K9X44zbIhph8qD5mSoE0pT9x/NniGXG
X-Gm-Gg: AR+sD11dqgumQcB/A2yERKMgV4VBq92SUm7jNJb8PPtYobch3rgwuDottjwCZoJ3Pqm
 lGKGtj1fuIx2OL+ceAk1gfLCAHDOMFl+gfSe6Xeb5G57KXAB1yFMRGxpftEodsnZQOfbwdd3RTR
 87A1Rkkt6yt+1T1x6bQ33XuIuTCt0EaV3CwX+ZURW/9tdl1vP1aI3wqsbozpH9MyAKTgEFfSmJa
 apVXoHQQ/00lOFrYBkYSOjsamV+1tAQ5JDpq0/7AwxfvSAQmtN4csMcLaUbVXNMxcwtNknrbX+p
 ZL+bq6zzzgpWw87BqmsqVCbDWN9AG7pczhwPdpb/fJaFWczLP/7k/3zemVgHexsMteBN6jnMQ7e
 kAUOjpMGoQOJU8HP9OCPciDXsyPysSSS48BTZA1TZoTbab/9HMrXU3KVylZebFChv8qwN0QgaxR
 U33KHnq6BJHVsRt9g7pPm8v7WlVbO4nnWX1Mg35ZO3AcJYiubPkRLjzUGRTmLtjLp5Zg==
X-Received: by 2002:a17:907:934c:b0:c15:f65a:43a8 with SMTP id
 a640c23a62f3a-c246a604950mr2181314566b.12.1787484021753; 
 Sun, 23 Aug 2026 04:20:21 -0700 (PDT)
Received: from thinker ([2a13:54c2:f000:e268:6d0c:d746:2b12:231f])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24966f58dfsm707233866b.38.2026.08.23.04.20.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 04:20:21 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: javierm@redhat.com, airlied@gmail.com, simona@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: andriy.shevchenko@intel.com, holofermes@gmail.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Amit Barzilai <amit.barzilai22@gmail.com>
Subject: [PATCH v5 0/6] drm/ssd130x: Add support for the Solomon SSD1351 OLED
 controller
Date: Sun, 23 Aug 2026 14:19:53 +0300
Message-ID: <20260823111959.17029-1-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.55.0
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

This series adds support for the Solomon SSD1351, a 128x128 65k-color
RGB OLED controller, to the ssd130x DRM driver:

  - Patch 1 adds the device tree binding.

  - Patch 2 switches the SSD133X family from RGB332 to RGB565, bringing
    65k color to the SSD1331.

  - Patches 3 to 5 are preparatory cleanups requested on v3: constify
    the ssd130x_write_data() 'values' parameter, convert
    ssd130x_spi_id[] to C99 initializers, and reimplement
    ssd130x_write_cmd() as a variadic wrapper around
    ssd130x_write_cmds() so a single loop remains.

  - Patch 6 adds the SSD1351 as a new SSD135X_FAMILY. It gets its own
    primary plane update/disable, encoder enable and backlight
    callbacks; only the callbacks with no family-specific logic
    (ssd133x_primary_plane_atomic_check(), ssd133x_crtc_atomic_check()
    and ssd130x_encoder_atomic_disable()) are reused as is. It also
    sends command parameters on the data path, handled in
    ssd130x_write_cmds() via a new cmd_params_are_data flag; see [2]
    for why the split lives there rather than in the SPI transport.

Testing:

  - Patches 1, 3, 4, 5 and 6 are tested on an SSD1351.
  - The SSD1331 RGB565 change (patch 2) was kindly tested by Javier on
    his SSD1331.

Thanks to Javier, Andy, Krzysztof and Fabio for the reviews.

[1] v4 of this series:
    https://lore.kernel.org/dri-devel/20260818080626.30430-1-amit.barzilai22@gmail.com
[2] Command parameter path discussion:
    https://lore.kernel.org/dri-devel/20260811122603.30773-1-amit.barzilai22@gmail.com

---

Changes since v4:
- Move assignment of fi and plane_state to be just before their
  first use.
- Move ret variable declaration below cmds[] in ssd135x_init().
- Constify remap variable in ssd133x_init() and ssd135x_init().
- Replace ARRAY_SIZE() with sizeof() in ssd130x_write_cmd().
- Collect Andy's Reviewed-by tags on patches 3 and 4.

Amit Barzilai (6):
  dt-bindings: display: Add Solomon SSD1351 OLED controller
  drm/ssd130x: Change SSD133X color format to RGB565 from RGB332
  drm/ssd130x: Constify ssd130x_write_data() 'values' parameter
  drm/ssd130x: Replace positional ssd130x_spi_id[] initialization with
    C99
  drm/ssd130x: Implement ssd130x_write_cmd() on top of
    ssd130x_write_cmds()
  drm/ssd130x: Add SSD135X_FAMILY and SSD1351 support

 .../bindings/display/solomon,ssd1351.yaml     |  42 ++
 drivers/gpu/drm/solomon/ssd130x-spi.c         |  25 +-
 drivers/gpu/drm/solomon/ssd130x.c             | 420 +++++++++++++++---
 drivers/gpu/drm/solomon/ssd130x.h             |  10 +-
 4 files changed, 432 insertions(+), 65 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/solomon,ssd1351.yaml


base-commit: 843bc34db94bff0612c8294861b156489958897b
-- 
2.55.0

