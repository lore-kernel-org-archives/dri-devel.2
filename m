Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57818606A325
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PUk7WvhV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39FBB10FCFB;
	Wed, 18 Nov 2026 13:52:16 +0000 (UTC)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3EF610FCF9
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 13:52:05 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-36f8cdd30beso564527eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 05:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795009925; x=1795614725; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PM3UlJlcv8z+zqBrOKfrn/t7+7YdeOarS2V1pVOK/10=;
 b=PUk7WvhVhQmogV/B+84W8wvSWkumSuA+x6EhBiA/d4dYv/YnF1rCwyYafOI+O8wh+/
 YXdAxhMF450pWCPGy/hh+FYB1534+NR7JIvS39Kw0Yujjr6ncjuQSWOsFnXA7sN6sIMt
 Boj8MsDzXbjLXWcaziWSGPpgus82HM6XhpxfbjYPfkZeFSDm9TkxZc3aFJ7FL7mJkA+p
 EqJo05PFX3vjRiNlu5ORHI2nxCo1djvjG4xPyuHX+kavWC86YcEet8/lHasBV3FnEGCx
 JxeC4aeAy9AWFVkd9EDHNUQZmo7Po9Hw/Hsm8mQpRwY1Zb0ERBIa58cnvhPseTn2jvCk
 ToSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795009925; x=1795614725;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PM3UlJlcv8z+zqBrOKfrn/t7+7YdeOarS2V1pVOK/10=;
 b=OYS0ST+xSUbCjBJd8znzVYwGQqqHZvnUlGk9TQvaH8+00FuzGk3E1VlWFHvbN60bsj
 59TBxKzfFrRlJHc3R28trMfL35yi8m7Y5p4lpPv66PPSi5XF8yNIxCVso1VMWXrPIirx
 wNQZk5asVBitDUihBqdiICC75Md40NIsJ09vXcQ+xcrnVzL6DJPGu7FF3wmNQ1zb3+sO
 2WWsvvs9Y8nYXxjzbaTQfmCUrdxHBM1lAEJGxc6Fr6lUIgKVQlvW7Uxq8m4/WJZy6T2T
 ncRGA5gHXxWcXHC54qUGpst3hL1FvYOzGTeUgtTtUKlvUrrkBb6lVAAlRecOk0Hi0F6C
 bZPA==
X-Forwarded-Encrypted: i=1;
 AL+hErFWRNmo2YhDXOHLIgO0gYK9bRo+9kEvWSjgKWyiPaPlWm0ewwQvuRagp2T+mhz6RYdwNFJmADBjdR0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8DW3XiP3Xhm9a1RQ5wd94oohVPnbeNb9YOqnJlQN01rml/ghJ/
 Nv7uVpuIQhAKMOm/8D9d1Z7GNsyUcjIKI4vV22L5PHZJhi8PDJKVWcM=
X-Gm-Gg: AZFdTZdE8hSjq1KvPlu5D8dLF3EZWnaShHMsXslyF7zyQ3YqNE8hICq5X8ZIijEYayw
 NxF21DpXIgIX+R52Bt9F0GETLQy4HPM/mqqBBSp2S+SrhRe/x6XPzKiln9Cci9RD0KHLxHbNcF5
 AcaS7vfTTYAFBw0Dqtz9QchvDHwXCmmMmkQxQckew+eQpY0GGSNznXi7qbHg5b9bkViiT8MriDj
 LEf9PgCiqDdm/p3RTesDmlR9tK327X7jOrcg2gnPWw0uXVJmA2CORndy7TFmmzUvVIKOB9ftqev
 ek4x5qNbFj+KqKPa+z/FQ5ic/UydTmCFTN0XlwX1PqauRYZ+TTNnJjFTZmARk85zp4cvvumsiH2
 uqSQQ4OZRQS9oX6KI9pciQ428/rrW+DikB7KOEmExlN3+znT4CFkrEZTkbcYcAmrxoI03SK1nAA
 80AJwoAFYECH35AJQfHT4zwLYQhshErYah83wI9MFCbGUN5zseMb4obKqa9czOm/208AUFge1F2
 h5huR7eWpIRCtWJiYPa/1FAXviItu4XEq7glkHMqTHT87JFuBzd5vx6mfH9jMMzJHLYxf/NwKxA
 mpCc9IY+9lfcHd6pdhPCdoNANAj0qXXRgNoefWwzGv045UHEiU2Gx4nUOfEgo7BxmKuK8LE5KGF
 P9OHTYA==
X-Received: by 2002:a05:693c:821b:b0:376:a6d7:8f6f with SMTP id
 5a478bee46e88-38280c34ba5mr2865954eec.17.1795009924614; 
 Wed, 18 Nov 2026 05:52:04 -0800 (PST)
Received: from localhost.localdomain ([186.158.238.108])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-382a7eaf3b3sm9576421eec.27.2026.11.18.05.52.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 05:52:04 -0800 (PST)
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
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/2] Add support for CH1115 Controller
Date: Wed, 18 Nov 2026 10:48:52 -0300
Message-ID: <cover.1795008752.git.nico.antinori.7@gmail.com>
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

Tested with Raspberry Pi 3b+ on:
- Linux 7.4-rc1.
- Linux 7.4-rc3.

Note: rc-3 was tested by pulling the changes of drm-next into the
rpi-7.4.y branch of the Raspberry Pi tree. rc-1 used the Raspberry Pi
tree as it was at the time of rc-1.

Patchwork Link: https://patchwork.freedesktop.org/series/171799/

Changelog:

v7:
General:
- Patch series based on drm-next branch
  commit 601c30449c80 ("Merge tag 'drm-misc-next-2026-11-13' of
  https://gitlab.freedesktop.org/drm/misc/kernel into drm-next")
Driver:
- Changed default contrast value to 0x80: It was 127 (0x7f) by my
  mistake (0x80 is the default in the datasheet).
- Added sleep (100ms) just right after sending the screen on command
  (AF). This is stated in the datasheet but I missed that before.
- Dismissed Sashiko review: "[Medium] drm/ch1115: out-of-range display
  offset 64 sent in ch1115_oled_init()": This is a false positive, the
  datasheet [1] states that the formula for this command (D3) is 64 - n,
  where n is a 6 bit number in the range [0, 63]. I did not use a mask
  for this because the unused bits get ignored and the value is
  constrained to that range.
- Fixed Sashiko review: "[Medium] drm/ch1115: missing DC-DC disable in
  ch1115_encoder_atomic_disable()"
- Modifying MAINTAINERS file in the driver patch (removed patch 3 of the
  series).

Link to last Sashiko report: https://sashiko.dev/#/patchset/cover.1793735996.git.nico.antinori.7@gmail.com?part=2
Link to v6: https://lore.kernel.org/dri-devel/cover.1793735996.git.nico.antinori.7@gmail.com/

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

 .../bindings/display/chipwealth,ch1115.yaml   |  81 ++
 MAINTAINERS                                   |   6 +
 drivers/gpu/drm/tiny/Kconfig                  |  17 +
 drivers/gpu/drm/tiny/Makefile                 |   1 +
 drivers/gpu/drm/tiny/ch1115-i2c.c             | 862 ++++++++++++++++++
 5 files changed, 967 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/chipwealth,ch1115.yaml
 create mode 100644 drivers/gpu/drm/tiny/ch1115-i2c.c


base-commit: 601c30449c80926947d4820d50cec974687d1d11
--
2.47.3

