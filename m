Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C495F606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 08:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bODmJkOZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B07F10F129;
	Wed,  4 Nov 2026 08:58:54 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAF6010F6B0
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 15:53:22 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a59ffacb51so6376635e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 07:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793721201; x=1794326001; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=anB0zTq8jJujneJmcQG5UHQs5K86qJzq/JkXXdegQ0Y=;
 b=bODmJkOZG3lDFGQUCgje8kJbS2vvb4/N4Ghdr7zTV5NUxM7rn8YMk8GebE+hDMNnA3
 2xuubS+YPJo4DRnOh0A2X9en/6npi54h8XfJ8jTn7cMTNKNaxjs13FOqTWa7Bfm1JEPE
 2nzQoFs7VAiqGMRlTzkE1io2kw+tbmkYhLn6uDrpqKAaJdyZuNpJOR70G5D5CP5jxXkf
 ZE8S5VpcHlWZgCrI+LgRNC4o5dg4l48dSVYQpEVsDaGSD9CyBprTtx015aHCt4czqtFm
 Sza+o6ekOV4Npe+Nq4WsqTNj3iIhwwVcRwxxVIhBqyH+6Qsj0X52VK8hS1Y8UKJD2RC3
 /aXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793721201; x=1794326001;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=anB0zTq8jJujneJmcQG5UHQs5K86qJzq/JkXXdegQ0Y=;
 b=T2sFOt9ai9kfKjiZgsPBaD24mF0SBMGv3qqcLA2t3G5EK9h/Qj1O7+oi9UlJcYePh1
 sNEP0AilCTnil2YIxnR4F4R9DZlpr3p4tcv+T8dNV6/xcwdGSlDDBLsNNqNVohPOEAKx
 zX7fzxGzLYK9+U/px31iIay7BfV9OfntfhQ4APB0bjPKrPBjwUfc5E+dSd9gfSDzH/UR
 C+wcAOC575638Z1Yl5vEIeUk5KGGBcgsrl1VdGFnay99afTlQWVIzkkNNhF65gmW7Wku
 oD04DNX/0CryAPiP0FNoeE1dtkNiJiz0rrFHzlrVZuTU0F7ST2Us+Jts1Lb5t3/nbIMl
 Xoxg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzdUdHGEnv3eqbdZMuiaNkit+u8wpKFycxkKOEjjUSfpIVxXxp3nizyJpK7bMcc6KiSx7ciY17gOrw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/5v+E2xZyfDsu9nuHhyMWkqBhxd0kveIjbAcn0PzHoHQA+ecus
 2lyfAIzq/k5cTWj8UzHYn+p3oTp22v1Gblimat1M+s+kddGBDjqZX9Vn
X-Gm-Gg: AYBFou1mlWmnSsgOYvC6Q+vh+Cyi5xI0mPxdUReXmTd8/OFAoxVYrmB/0g8Z2NIEz5N
 LpKe+HRb1lvMcwEoAxa+U4JwP1QKquEn07+gyQtsemZbKJCjm3UN4rnLW5b9RUkLWOOC8pxpSpB
 EolCdvRHcAoqikmM3n5/+6CZw2xHCDqlJbgfnupk5tBmL0PyvMBqZ270vOPNl1x38JioCmK5L8W
 BeA5uHbIc8fwUaVxXJqRgtqA4Ba2rKKvAI2zfm80vm+wl6eLvjVlmYndDL/EAysqVjd24Ayd2U4
 kAKyGH/PSLgC9wSxJ5vT3sDGJ2ZjnlHXRkG70rObOWarKYOH/q4KdfQwo1656ljdJKsRsBOdmj/
 1XTKmLafXfAMESWQTOY1BRmfasVu2e1B4Muxx/SM26ytlKN1dsHHmvhGfOYYHz14X74M1XH05xD
 BXX/2VbayM6aKe90Vzs0gbXXwWo+U6iiXzE2CdXYXYDcJDPqqT02TnAeypRL6Cwh+zdOkDHgTHF
 dsTutlr3DwN+AIl4wQOCcA5gLO4MtBJoKAYX2lMuTxTXYA3QjP9jvYB4d9GfeQissCZQVZANEUj
 CviaGmSERC7MqBxo0QDFPRYbCHEkHh9B6nYFN1iJS/r6DRVmN63dkAAbrSq1gefAtBKK/gl3
X-Received: by 2002:a7b:ce0d:0:b0:4a1:715d:1913 with SMTP id
 5b1f17b1804b1-4ac177538c5mr237110155e9.1.1793721200982; 
 Tue, 03 Nov 2026 07:53:20 -0800 (PST)
Received: from Termis-ROG-FLOW-Z13 ([2001:16a2:4495:e600:1209:ec98:a2b4:9c5a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a879f401sm63777815e9.5.2026.11.03.07.53.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 07:53:20 -0800 (PST)
From: Seifelden Abdelmonem <saif.elden.hatim@gmail.com>
To: Mario Limonciello <superm1@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bin Du <bin.du@amd.com>, Nirujogi Pratap <pratap.nirujogi@amd.com>,
 Benjamin Chan <benjamin.chan@amd.com>, King Li <King.Li@amd.com>,
 Caspar Adriani <caspar.adriani@proton.me>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Arec Kao <arec.kao@intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 platform-driver-x86@vger.kernel.org, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Seifelden Abdelmonem <saif.elden.hatim@gmail.com>
Subject: [RFC PATCH 0/3] GZ302 rear camera (OMNI13B1, OV13B10) board data
Date: Tue,  3 Nov 2026 18:53:10 +0300
Message-ID: <20261103155313.114347-1-saif.elden.hatim@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 04 Nov 2026 08:58:01 +0000
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
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series is NOT meant to be merged yet. It puts the board data of
the rear camera of the ASUS ROG Flow Z13 (GZ302EA) into patches, so the
sensor can be enabled once the ISP firmware supports it. In the v6
thread of the ISP4 driver [1], Mario noted that OMNI13B1 would need a
new amdgpu entry and the matching GPIO tables; this is that data, plus
the board configuration and a small sensor-driver change.

Caspar Adriani already posted an OMNI13B1 amdgpu/amd_isp4 patch in
his RFC [3] and dropped it after Pratap's reply [2]; credit for the
first posting goes to him. This series covers the sensor reset GPIO,
the 24 MHz clock and four lanes in the graph, and an I2C ID table for
ov13b10, and lists where every value comes from (below).

Why not for merging: with isp_4_1_1.bin from linux-firmware,
SET_STREAM_CONFIG fails with error 6 (UNSUPPORTED_SENSOR) for this
sensor, as Pratap explained in [2]. Merging patch 3 would make every
GZ302 show a camera that cannot stream. The stock linux-firmware image
does not start this sensor; on my machine the camera runs with ISP
firmware and sensor setup data from my own Windows driver
installation, read from the Windows partition of that machine. I do
not redistribute any of it.

The values and where they come from:

- ACPI _HID OMNI13B1: \_SB.CAMB in an SSDT (confirmed).
- I2C address 0x10: the sensor answers there; the _DSM returns the
  same value (confirmed).
- Sensor clock 24 MHz: the rate declared for the OV05C10 platform
  (assumed).
- Four CSI-2 lanes at 560 MHz: the ov13b10 full-resolution mode
  (assumed).
- Sensor reset, amdisp-pinctrl GPIO 0, active low: tested on the GZ302
  (confirmed).
- enable_isp, AMDI0030:00 pin 85: copied from OMNI5C10 (unconfirmed).
  The capture driver needs it to probe, no ACPI device claims the pin,
  and the ISP also boots with it left undriven.

Bin, Pratap: the firmware sets up the sensor clock and link, so could
you confirm the clock rate, the link frequency and whether pin 85 is
needed on this board?

Sensor model: as Bin and Pratap explained, on Linux the ISP firmware
controls the sensor, and the reference ov05c10 sensor is not bound by
a host driver. Patches 2 and 3 fit that model. Patch 1 and the 24 MHz
dependency below only matter if a host sensor driver is used, which
is how my out-of-tree setup starts the sensor. Which model will the
sensor-agnostic driver use for OV13B10? If it is firmware-only, patch
1 can be dropped.

Dependencies before this can be merged:
- ISP firmware that supports the OV13B10 on this platform.
- With a host sensor driver only: 24 MHz support in ov13b10, which
  accepts only a 19.2 MHz external clock today.
- Patch 3 needs patch 2: the ISP setup in amdgpu uses the software
  node that amd_isp4 attaches to the ACPI device, as for OMNI5C10.

Patch 2 copies the software-node graph of the OV05C10 entry. If a
shared graph builder is preferred, I am happy to rework it that way.

Patches 1 and 2 have no user-visible effect on their own; patch 3 is
the one that makes amdgpu create the ISP for this board.

Testing: built with W=1 (clang) on next-20261026. Not runtime-tested
in this form. The same graph, I2C address and reset GPIO work out of
tree on the GZ302: the board configuration in a patched amd_isp4
module, the reset GPIO registered from there, and an ACPI override
that lets the stock amdgpu find the sensor. There the clock is still
declared as 19.2 MHz and the sensor driver is adapted to 24 MHz. That
out-of-tree code is in a repository I can share on request. I can
test patches and firmware on the GZ302 at any time.

Related: two isp4 driver fixes found on this machine were sent to
linux-media separately [4] and have been reviewed by Bin and Pratap,
and the GZ302 bring-up is discussed in [3].

AI use: Claude (Claude Code) helped me write these patches and the
changelogs from the out-of-tree code, and run the checks. I reviewed
everything.

[1] https://lore.kernel.org/all/3a671359-b05a-4d58-84ca-f29385088e5c@kernel.org/
[2] https://lore.kernel.org/all/ea758386-13b0-4667-8eca-9aa4efefe92b@amd.com/
[3] https://lore.kernel.org/all/lWYl1YJwDSh-q2Ew2f8b0BweQ4V-SUnPMSMurU5gT1LkqVdrmWFunj0sSgjC7m66bORBAD_jRCFTt1_ZOkotOMukY46rI4ayYbIfPQq4E9U=@proton.me/
[4] https://lore.kernel.org/all/20261026182442.229869-1-saif.elden.hatim@gmail.com/

Regards,
Seifelden

Seifelden Abdelmonem (3):
  media: i2c: ov13b10: add an I2C device ID table
  platform/x86: amd_isp4: add the OV13B10 (OMNI13B1) board configuration
  drm/amdgpu: add the OMNI13B1 (OV13B10) ISP sensor

 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c |   1 +
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c  |  13 ++-
 drivers/media/i2c/ov13b10.c              |   7 ++
 drivers/platform/x86/amd/amd_isp4.c      | 127 +++++++++++++++++++++++
 4 files changed, 147 insertions(+), 1 deletion(-)


base-commit: f1ac44c32cba88ad65dcecd4a279661d14e93651
-- 
2.56.0

