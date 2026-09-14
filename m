Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1137C88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:00:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E093B10EC01;
	Mon, 14 Sep 2026 09:00:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XmOUjyRy";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 244BA10EC01
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 09:00:20 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912d8239so9505055e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 02:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789376418; x=1789981218; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=t6dLCC4SP39QTvmzDlgaQNGqLw7x2HJIM7l5Mx7gUsk=;
 b=XmOUjyRyzk9XbLXd0yYnUnVkR1PKIC05XyXtcrNOwNnter2B3FYh0DLzlfly07ktGC
 wfQ4Rj/TTILGG0lxaanNLa4ILzwVt7QRZU8kv+WeUKd1H2rbEmMCxK1SYxukT1cLcXJ+
 glFtyT3uwut6PixUm1UKGz2yO2/mQ/Ti2JPgQvIGNle07Om+5qkM9fQ+t0YYNoGacZ+v
 +3TK81c41UoQgpt7KANoJ6ZhPwiLGqppZW/DcSz6yHOvuhX+ZEK1E600j/RXxw5u63PE
 aRSdRAGSYfmrGIkW942RjBTq+x/r7A878gc9eIJtsGXP9fOS8wwnC72LEKMiwPLajiHF
 IPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789376418; x=1789981218;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t6dLCC4SP39QTvmzDlgaQNGqLw7x2HJIM7l5Mx7gUsk=;
 b=UZsoWNcjo2MqB6cvZL3sQoB41zQOOmBVvJIOaGO1sZf8+7uK3ZiC2pSHv7eLGLbkk3
 uzZ+/hHjQVXbg6GN+rD5JyK2qglPR8kYLBv5g+Ct/jOo4PbH3oP9A3X0sNR8CIFz6XgS
 cRh7JxuqeRfyDo4jdKsey4T8mBgx3i6noe1h68/HLamzjQ2gUgzZXp9tQkUlKrj3AK30
 al2RIZbeZcv8Zs80Ook/FwMS8ybACU1h3z6q/oMEHNUhypbL1Q3ZwhoYY8wVNUDIH93D
 eZTnSZHdSSCr9nyFnsrrjcsz+/Szg0qAuNNJrNjZS4PX4f1njHiQqYYnPNi4bshvjAcj
 8h9g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwhNrx3NyCjHXZaq9LGjMcbS26ozRZAoTZJPagMmrqs3ADMimPb7RM8eAjuQamVOOUB8rQ+S9xdcHg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++loE1ZBvnkbudh+wFjCmvZnUHosbW8+jOMeb7ugDV2TK0SAE3pf
 BpIUi3fkSSzNm5uKT/vMF20jsc3xlQsZh/09s6suNTJ3umGN0IxxFamn
X-Gm-Gg: AYBFou3X/gaE+N+CK2HW15o+7HuzP7DuZCVjxQMc5DfX+KEngsQvQMzuPKzAXZwwfZJ
 wWz9ta/g9Rlc2ZUZuwZzPamMh/wBTvPFx3fqWHc6ZrLicDlY7zQ2R/pdS7zgYuBk0WNqrzK264K
 oP/guGRycT1AO5/5e1/7DiqdLw2fuDOsnkf/4RhLtj5yYUSzPBQiPlIKokznnR61L1BrGL40PLw
 QK35h/5TXogQISINJS5Wj7odmaXjRM3zbWFcAD5Pe4I89ugeFzUo/fBEh+0phdOwfKLF8rDiuTu
 Px+s2cjEJeoV+Mi4rz+3VGrmD5E/jjiSA6uQnFyPSVLi8aOeOHiTTltVtordYqj4oaq2Fh8N3/q
 B5+BXJuAi5Uu0lE64T6Hk/SmbykjErrnJOFGnnievgYxd9OcxFALG/8VfsLrkGYYnQD4hQs3lKK
 k97tzpI6Vu48I7pR7fSMI5BOJRxm1Ngnv5WWNzNzOvz042DXTKR1BvZVNlDbtQ5bCW6gCo3Xikd
 e0OOz3oLIVSPA==
X-Received: by 2002:a05:600c:6090:b0:49c:fa21:1c7e with SMTP id
 5b1f17b1804b1-49e7a68c9bamr14829435e9.19.1789376416688; 
 Mon, 14 Sep 2026 02:00:16 -0700 (PDT)
Received: from anthony.local ([2a06:c701:9cc4:c200:33d8:8ea2:e077:ebe1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb32e7f5sm25245851f8f.9.2026.09.14.02.00.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 02:00:16 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: javierm@redhat.com, airlied@gmail.com, simona@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: andriy.shevchenko@intel.com, holofermes@gmail.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, amit.barzilai22@gmail.com
Subject: [PATCH v6 0/6] drm/ssd130x: Add support for the Solomon SSD1351 OLED
 controller
Date: Mon, 14 Sep 2026 11:59:25 +0300
Message-ID: <20260914085931.66857-1-amit.barzilai22@gmail.com>
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

[1] v5 of this series:
    https://lore.kernel.org/dri-devel/20260823111959.17029-1-amit.barzilai22@gmail.com
[2] Command parameter path discussion:
    https://lore.kernel.org/dri-devel/20260811122603.30773-1-amit.barzilai22@gmail.com

---

Changes since v5 [1]:
- Patch 6: move the zero length check to the top of
  ssd130x_write_cmds() so it guards both command paths, and comment
  the len == 1 early return.
- Use the "Assisted-by: LLM" attribution form.
- Rebased on drm-misc-next.
- Collect Andy's Reviewed-by on patch 2 and Javier's on patches 4, 5
  and 6.

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
 drivers/gpu/drm/solomon/ssd130x.c             | 421 +++++++++++++++---
 drivers/gpu/drm/solomon/ssd130x.h             |  10 +-
 4 files changed, 433 insertions(+), 65 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/solomon,ssd1351.yaml

base-commit: 766bfba0f3bae329f99b42dcabc3ef11fa368f0b
-- 
2.55.0
