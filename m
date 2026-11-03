Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76E7606A331
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 20:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=btf8BMyR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56A6010F84B;
	Tue,  3 Nov 2026 20:47:14 +0000 (UTC)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com
 [209.85.221.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A91B10F866
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 20:47:08 +0000 (UTC)
Received: by mail-vk1-f181.google.com with SMTP id
 71dfb90a1353d-5eafb65e163so2482653e0c.2
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 12:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793738827; x=1794343627; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UNLZOB7RlMn7c8blD1Uiiei/dC7dkvXjaLxBgJvaSyg=;
 b=btf8BMyRJdYDI3ilZpU4Fo0fsuBYsn6UKbNhi7ax68MV5p+3TguGYw6aSMR+YK2O0y
 znCQp5eBrqnf8UeEZmoPOiCPYF0kdVOQKuRyyE0b6+EbU1bE1RGN8hmoYsY7nlz9/4SW
 8CsUAYsaziJ4eDuxlr+/StfsK49gFhUdbo/1ros1P6UqBvVtp+kmEWaM77b30dabkLRX
 1b1THvn1Yvxv5K5slrU5kVamVGsUb3vGnyEEhmAX/i31rNhMVazCx9ZjAMbKOQqUZhmT
 wd1Qqwd+q9EJ1t0Vt+IWbZrL7yqtYHY4w5v3DqvH0fh6VjSTUqJAlKxxulLeaTAZTBPw
 xaug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793738827; x=1794343627;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UNLZOB7RlMn7c8blD1Uiiei/dC7dkvXjaLxBgJvaSyg=;
 b=k49OdG3J8tWvYLAEM8FmHWzDAQV3JGpSnPZA4xfxw3U2Dqz7gJYgX5LaNVlmr9epkD
 3SeeOAwy1WM/SMgANXaIeKLT2Zwn3rW5FZIX8Tdar3ysLD7tWCzJhP5ttkG8Ofaqwz/R
 2x1Bqq8SfQ1oiPfK96NHwFV8MXCJwHSIX7ldttO7ulfgEWWRZdpYZAOTAAeCKnrkU3L/
 wSQUU+fMA0bPfZmv6PEgFUxcDY5ZuHCTM8WVoyPFlMFDtrBDUgeSK/rA1VbooBxBOKMl
 JUfbeWVMJf6Iv/7dLnElN6dTmGATOC/RTZrUhUkv1tD+e46jQLJtm3vilcWx6f1tSis1
 4KOA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzrYXAdkPil6kSIyKL0E4UCUhH2c8uaSwd9l/EGrWEgUu4Dr2sEA6/Lr072W/77x8HcDvrVhdS/Bsc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/GUCmE7pDCL/raGlwMwyf7/2GVO6ZWiqOPum4k3dSzO/125ncj
 X6C10rMvpVp5CRZQYi0yTpenTR5g/sQ2SFFhVuFVWGsFGHrLKKia5WU=
X-Gm-Gg: AYBFou2NWyKAN/lstz3MRJVPHEIHN81z5RfYEav/RpYsEi90yhxP+FramHlHiW3hCYh
 dDEFxJMw/kR/J0SCNIqANZbak55H5XN3K3OpPa8Ze6moa7AisLUK1jkjP/2FGU1onle/md4aK2Z
 8ugnsk/vSuD6rwz1HMKkn1hioZVUjDs82SDCdAnBibO5+pwAaXYyfPAplYJhjjtIeiD+WSeBhHB
 1OczDiqR1296dug1FkqyUjl0o5Dw7PhJeZ7N4A4wjJXzdbn8Q+nfH0Tu3yJpEIdWRTDYbPMd7DQ
 UazlisljvWqGDZ5/fMpp/G6DeKwZunxEOQ/YnVPMIvoYNZUbiHffKNFhPe1MWX03kAqcySsiNpT
 a6uvtra19Me7lPJd10Ml1Cdl06/TF6JmTXMOvmqZc/OJ3qqQMITZfo3pnEGnN3vtEeqTxOp3PiH
 ozsE3j2NbXQGhFnWnHWCerk/f8X3Z3POQu97NCHaK1LQ6BZp66cHwX+/cHFKQNupnRjl9HmGm5j
 qtdcHTHBNMZt3h73iQM1ExV+o8JGceHnirdXfVoDyjUIgb+8ZZl6WiVVUiAqI9YukeA9WVSRPms
 2NlsFq2U5Gk5Bi5VLUjliGOtB+Mk8fZf4KZRh8VgJKFLB3+Hz7B2dcFJ1IsAYCv2+KVwcI6Q3Go
 WFImh
X-Received: by 2002:a05:6122:328b:b0:5c7:fbb5:6ea0 with SMTP id
 71dfb90a1353d-5ec68952670mr7610678e0c.4.1793738827265; 
 Tue, 03 Nov 2026 12:47:07 -0800 (PST)
Received: from localhost.localdomain ([186.158.238.108])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5eca89b81b3sm119618e0c.2.2026.11.03.12.47.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 12:47:06 -0800 (PST)
From: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>,
 Brigham Campbell <me@brighamcampbell.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jori Koolstra <jkoolstra@xs4all.nl>,
 Shuah Khan <skhan@linuxfoundation.org>, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v6 0/3] Add support for CH1115 Controller
Date: Tue,  3 Nov 2026 17:46:50 -0300
Message-ID: <cover.1793735996.git.nico.antinori.7@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series add support for the CH1115 Controller [1].
It is a monochrome dot matrix OLED controller that supports several
interfaces such as SPI and I2C.

This driver only supports the I2C interface, but all common parts could
easily be put into a common file to be used with other interfaces.
I only have I2C to test with.

This is the first driver I write. The work is based on the driver
located at:
- drivers/gpu/drm/sitronix/st7571-i2c.c
- drivers/gpu/drm/sitronix/st7571.c

Tested with Raspberry Pi 3b+ on Linux 7.4-rc1.

Changelog:

v6:
General:
- Patch series based on 7.4-rc1
Driver:
- Fixed KConfig dependencies: added depends on MMU because of
  DRM_GEM_SHMEM_HELPER select
- Removed unused constant CH1115_MAX_PAGES.
- Removed unused ch1115 struct member pages.
- Fixed width and height checks error messages
- drm connector: use atomic_create_state and remove
  drm_atomic_helper_connector_reset: This change is because of [3]
- drm CRTC: use drm_atomic_helper_crtc_create_state and remove
  drm_atomic_helper_crtc_reset. This change is the because of [5] [6]
  [7] [8]
- Replaced devm_regmap_init(...) with devm_regmap_init_i2c(...). Deleted
  related unused code. In this driver `I2C_M_IGNORE_NAK` is not used.
  The way of communicating was carried from an old version of st7571
  driver (and me not understanding better). This change is because of
  [4].
- Early exit on failure in ch1115_encoder_atomic_enable
- Removed "CH1115_CMD_ALL_ON" in shutdown sequence. This was a
  misunderstanding of what this command did.
- Fixed Sashiko report from v5: "[High] core: uninitialized variable
  `bl` used in IS_ERR check". Apologies for this, my LSP did not
  highlight the problem and I overlooked it.
- Fixed Sashiko report from v5: "[High] drm: out-of-bounds heap read in
  ch1115_transform_xy()".
- Fixed Sashiko report from v5: "[Medium] sysfs: unprotected state
  modification on registered I2C device"
Dt-binding:
- Removed adding Chipwealth to vendor-prefixes.yml. This was added in
  commit 058ee00216a1 ("dt-bindings: vendor-prefixes: Add Chip Wealth
  Technology")
Link to v5: https://lore.kernel.org/all/cover.1790200427.git.nico.antinori.7@gmail.com/

Note: Sashiko keeps complaining that i2c transfers are called in
atomic_update callback stating that it is forbidden to call sleeping
functions there because we are in an atomic context. AFAIK this atomic
context is not that the kernel is in a non-sleepable state, but refers
to the DRM way of working by doing check -> commit. In fact, the driver
I based this driver (st7571 [9] -> [10]) and others (ssd103x) do i2c
transfer in an atomic plane update. Am I missing something?

v5:
General:
 - Patch series based on 7.3-rc1
Driver:
 - Fixed KConfig dependencies (OF and BACKLIGHT_CLASS_DEVICE)
 - Initializing baclight with backlight_properties struct
 - Moved driver from drivers/gpu/drm/chipwealth to drivers/gpu/drm/tiny
 - Fixed allocation for hwbuf if width or height are not multiple of 8.
   I was allocating less memory than needed in those cases.
 - Fixed damage rect horizontal alignment.
Link to v4: https://lore.kernel.org/all/cover.1788711082.git.nico.antinori.7@gmail.com/

Note: The last two fixes listed were pointed out by Sashiko in some
occasions but when I checked them I dismissed them for false positives
because I misunderstood them.

v4:
General:
  - Patch series based in kernel v7.3-rc1
Driver:
  - Fixed nits found by Christophe JAILLET.
  - Fixed max_width and max_height in modeset to avoid having bigger
  framebuffers than resolution.
Link to v3:  https://lore.kernel.org/all/cover.1787973729.git.nico.antinori.7@gmail.com/

v3:
- General:
  - Patch series based in kernel v7.2
- In dt-bindings:
  - Removed "chipwealth,contrast" property (added backlight_device
    support in driver's code)
  - Renamed "chipwealth,invert" -> "chipwealth,inverted"
  - Added default value to "chipwealth,offset"
  - Removed 'status = "okay"' from example
  - Indented example with 4 spaces as stated in the documentation [2]
- In driver code:
  - Added support for backlight_device
  - Replaced drm_dev_unregister with drm_dev_unplug to cover the dt
    overlay unload case
  - Executing drm shutdown operations before turning off the display
  - Checking that the width (panel-timing.hactive) and height
    (panel-timing.vactive) parameters are greater than 0
Link to v2: https://lore.kernel.org/all/cover.1787321297.git.nico.antinori.7@gmail.com/

v2:
- General:
  - Patch series based in kernel v7.2
- In dt-bindings:
  - Fixed linter problems
  - Replaced first_page property with offset
- In driver code:
  - Fixed dst_pitch calculation
  - Renamed file from ch1115.c to ch1115-i2c.c
  - Support flip-vertical and flip-horizontal dt properties
  - Fixed several things found by sashiko-ai
Link to v1: https://lore.kernel.org/all/cover.1786110720.git.nico.antinori.7@gmail.com/

[1] https://datasheet4u.com/download/1576606/CH1115.html
[2] https://docs.kernel.org/devicetree/bindings/writing-schema.html#annotated-example-schema
[3] https://lore.kernel.org/dri-devel/20261022-drm-no-more-connector-reset-v2-26-0b7e4e85b1e8@kernel.org/
[4] https://lore.kernel.org/dri-devel/87345ckt2n.fsf@ocarina.mail-host-address-is-not-set/
[5] https://lore.kernel.org/all/20260915-drm-no-more-crtc-reset-v5-0-bda007735748@kernel.org/
[6] https://lore.kernel.org/all/20260915-drm-no-more-crtc-reset-v5-9-bda007735748@kernel.org/
[7] https://lore.kernel.org/all/202609260122.KLDd6aW4-lkp@intel.com/
[8] https://lore.kernel.org/all/202609260545.eEm9FCKo-lkp@intel.com/
[9] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/sitronix/st7571.c#n371
[10] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/sitronix/st7571.c#n224

Nicolás Antinori (3):
  dt-bindings: display: add Chipwealth CH1115 OLED Controller
  drm/ch1115: add support for Chipwealth CH1115 OLED controller
  MAINTAINERS: add entry for Chipwealth CH1115 OLED Controller

 .../bindings/display/chipwealth,ch1115.yaml   |  81 ++
 MAINTAINERS                                   |   6 +
 drivers/gpu/drm/tiny/Kconfig                  |  17 +
 drivers/gpu/drm/tiny/Makefile                 |   1 +
 drivers/gpu/drm/tiny/ch1115-i2c.c             | 859 ++++++++++++++++++
 5 files changed, 964 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/chipwealth,ch1115.yaml
 create mode 100644 drivers/gpu/drm/tiny/ch1115-i2c.c

--
2.47.3

