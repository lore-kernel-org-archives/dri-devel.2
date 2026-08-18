Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC67AC5DF70
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 08:06:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18E1610E170;
	Tue, 18 Aug 2026 08:06:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Kbk0XTSC";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A218D10E170
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 08:06:43 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-47de0093c42so3762128f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 01:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787040402; x=1787645202; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=T3gyymCw2mkTKTP8bdUhLC8gklixH+KEg3+DpRRVJRc=;
 b=Kbk0XTSCDVCiNtL226/lrWaIUvbXVgD8/Cvw1+abVw16asXtjnwKqlX74aujt+6ZkU
 XnQMBLNjj28qk8/FML3IFU5aM2MAsq74hOpecopUMjKfI1sGDlxGef5QTSvZpXXrc0kc
 PpdH+L2WnAFGjxBYWm7/1roIn9vPTr7iu+UbbwCh/HCDVYc0HsQ5iHZC7K5UAUknMnCR
 3H1SSKRZS2wplYBK/B8HUvP9a9Desjsx/tejwOrHx4JTuZQ+bCL7KYkNkd1YzSA0XEiz
 7EXyyOg8I6dftbi5G9fU1J3fXyzuqV3LeH8dP6N5CGBWFheLdp78YN2oTnT1mUqiiXch
 iMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787040402; x=1787645202;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T3gyymCw2mkTKTP8bdUhLC8gklixH+KEg3+DpRRVJRc=;
 b=LjveZXFIKMaQznQdzVqbBNFjtVeZXZIA8lm1yQQQAkW8yC9JujqHk9RUuaw5cqVWEs
 FCTeKNZ//ide9rJsli1+t3zrrNrCP+DxecZIypebHxCsBiDjJe0u7MUuSEC7iid9A8PT
 l91VxDDfXuYBFBH5M+IHPbQev76rytAV2/qylSxQQOU+4VIjyDZ9ut1Y7OYwjKf8ghU/
 m4wCsCAB5CJqabz9AyNHxBF98mISbfG/SuXunCYQcXP1XDmV8ZnSRqr/w0iAXf84+c0O
 A2q/zwPOdMTUWqgJkXDGI12x0aU2Cd8Ma4/OYhW7GiFgbpXyUzU7Vb7CZFrF+Ekx5ZY7
 8EMA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqRbzndf0cT1o2jIPMQB+LM6l2sKw2yAfd9NFIO+grpTtahh7BtUerGro+iLLRtvtvPz5l/gIN5nrM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzCEAOenzsfpX+UvThs39BsdR5HZ0PhDtCvRMvMlylZHFnPJKmi
 AQ8PIzKPSaiOjNCsbtRTHGRcYY0Zf92n9yY6uTHFEGFtazxRLH6alFIV
X-Gm-Gg: AR+sD10leeODOABH51W5CNLfrm6TQzGhBQkEf7lb8T9WcO/rKRtDODt6Bjuw8skRTIi
 QDr3wSiyrt3EIkS/QHEGQLgJaRTrRTNlnE37O6gJNQgSvI7WZxBl7tms2dlra4KYrCEIAxD0rKD
 cQ4vXagcCHLZOdUg0l7KzunC59ug5CQiU7ifMb96mkMXoY9wN+TsG/RQqQPUvKr5bP8NwdZyXp/
 6jksa4sktQdINbQIY2ggzHA9q98sGB6EO58COng3DDX8aLz1bq8UzCB4eIGo56G5vFwmINLcnaO
 5CyXzWiYKIAhQ9vvgAoMbA6egvPfj1Wxp/JmVkEXVaTVhjLRIVoFt+Uk96K7/q7L9TsH3p23UqY
 LeYCbnPpwnnliDo3mCGrk31sx0V47PYA5iFIek7FbWB5aAQvwhjkYfWPHC7tagFAW8F0YfVkpzA
 /h3dhS1j8ETHPoNrCnLYBw61cT8j2Xgvc1jzvUmjFtbMy0ukB56NjnCvxXoKhPO8uw7et1rcu0i
 es=
X-Received: by 2002:a05:6000:18a9:b0:47f:8ac0:ccb4 with SMTP id
 ffacd0b85a97d-4816071a60dmr44149734f8f.10.1787040401603; 
 Tue, 18 Aug 2026 01:06:41 -0700 (PDT)
Received: from anthony.local ([2a06:c701:9cc4:c200:33d8:8ea2:e077:ebe1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a3b2e9sm10367223f8f.9.2026.08.18.01.06.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 01:06:41 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: Javier Martinez Canillas <javierm@redhat.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Fabio Piparo <holofermes@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Amit Barzilai <amit.barzilai22@gmail.com>
Subject: [PATCH v4 0/6] drm/ssd130x: Add support for the Solomon SSD1351 OLED
 controller
Date: Tue, 18 Aug 2026 11:06:20 +0300
Message-ID: <20260818080626.30430-1-amit.barzilai22@gmail.com>
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

  - Patches 3 to 5 are preparatory cleanups requested on v3 [1]: constify
    the ssd130x_write_data() 'values' parameter, convert
    ssd130x_spi_id[] to C99 initializers, and reimplement
    ssd130x_write_cmd() as a variadic wrapper around
    ssd130x_write_cmds() so a single loop remains.

  - Patch 6 adds the SSD1351 as a new SSD135X_FAMILY. It gets its own
    primary plane update/disable, encoder enable and backlight
    callbacks; only the callbacks with no family-specific logic
    (ssd133x_primary_plane_atomic_check(), ssd133x_crtc_atomic_check()
    and ssd130x_encoder_atomic_disable()) are reused as is.

Testing:

  - Patches 1, 3, 4, 5 and 6 are tested on an SSD1351.
  - The SSD1331 RGB565 change (patch 2) was kindly tested by Javier on
    his SSD1331.

Based on drm-misc-next, as requested on v3, now that the ssd132x/ssd133x
column and row end address fixes have landed there.

Thanks to Javier, Andy, Krzysztof and Fabio for the reviews.

[1] v3 of this series:
    https://lore.kernel.org/dri-devel/20260704080925.75113-1-amit.barzilai22@gmail.com
[2] Command parameter path discussion:
    https://lore.kernel.org/dri-devel/20260811122603.30773-1-amit.barzilai22@gmail.com

---

Changes since v3:
- Rebase on drm-misc-next (per Javier). The v3 dependency on the
  ssd133x update_rect end-address fix is gone, it is upstream now.
- Split the ssd130x_write_data() constification into its own
  preparatory patch (per Javier), patch 3.
- Split the ssd130x_write_cmd()/ssd130x_write_cmds() unification into
  its own preparatory patch (per Javier), patch 5. It is a pure
  refactor: the bytes sent and the bus transactions used to send them
  are unchanged for every chip on both transports.
- New patch 4: convert ssd130x_spi_id[] to C99 initializers (per Andy).
- Patch 6: give the SSD135X family its own .atomic_update,
  .atomic_disable, encoder .atomic_enable and backlight callbacks
  instead of branching on the family inside the ssd133x ones, and drop
  the shared ssd133x_write_pixels() helper (per Javier).
- Patch 6: the SSD1351 command parameter path is now driven by a
  cmd_params_are_data flag in struct ssd130x_deviceinfo rather than a
  hardcoded family_id check (per Javier). It stays in ssd130x_write_cmds()
  instead of moving to ssd130x-spi.c as originally agreed; see [2] for
  the reasoning. In short, SSD13XX_COMMAND is the I2C control byte 0x80,
  whose Co=1 bit promises exactly one payload byte, so routing command
  buffers through regmap_raw_write() would have changed I2C command
  framing for every existing chip. Keeping the split in the core also
  avoids duplicating it in ssd130x-i2c.c if an I2C part ever needs it.
  Fabio reports the SSD1322 needs the same flag and plans to send
  SSD1322 support on top of this series.
- Patch 6: the SSD135X family now registers a backlight device like the
  other families, using ssd135x_set_contrast(). v3 skipped backlight
  registration for the family because SSD13XX_CONTRAST (0x81) does not
  exist on the SSD1351; the per-family backlight rework that landed
  upstream in the meantime made a per-family callback the natural fit.
  The SSD1351 takes all three color channels as parameters of a single
  command (0xc1), which ssd135x_set_contrast() handles.
- Patch 6: drop the post-reset delay comment in ssd130x_reset() (per
  Javier), it documented a mistake rather than the code.
- Collect Reviewed-by tags on patches 1, 2 and 3.

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
 drivers/gpu/drm/solomon/ssd130x.c             | 414 +++++++++++++++---
 drivers/gpu/drm/solomon/ssd130x.h             |  10 +-
 4 files changed, 426 insertions(+), 65 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/solomon,ssd1351.yaml


base-commit: 09b47186a4164f3aaa3591313f80794443117342
-- 
2.55.0

