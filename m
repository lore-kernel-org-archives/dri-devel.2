Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514A5606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HszM9iea
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9189910F321;
	Tue, 27 Oct 2026 09:32:00 +0000 (UTC)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBBD910E25D
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 19:16:57 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-19305bcb72cso2486609c88.1
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 12:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793042217; x=1793647017; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZmT2nATq+bZ29K53UZMGVTr9REnvo4iJdWh63MeUqzM=;
 b=HszM9ieavp/KaP4hiFEgrmwAuSIRccXyARm65UBjDlnV1D5CZ/EmnuUoDmE+xxY875
 22AfRqFRgh4p7F4pRYtOxJr9Xpi4zffksE/klfXt3m/l/q65kFJyY8/0GtsnKmZx9KaZ
 Vd8ADGMgAvDzNjeyWu0i3VTe7EFwNQzu/q5HTjc1j32bhbHNeepazQbbn7lMH3m22RcT
 yPbcE/t2+/G+Bco0osEJiRjsCnFaIffVFN35fvZuT3hx1VWXX8GDz7WXIcA//CGGScJX
 knYsQQM1t/d2nBYCTKm0GSCFt3Bxsiy3PiVC7e6kp9nIVfSI6jt2cV04psMJDQzwFeHN
 53Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793042217; x=1793647017;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZmT2nATq+bZ29K53UZMGVTr9REnvo4iJdWh63MeUqzM=;
 b=Fk2uRIkoRrkeorszJaWncfuRaEI99v9Zet1hYMl8OOB/7vBsGfZUixTwnTMOBjiw4+
 XUJmmLrtOpjN1B8zPclplf/OdFgWjz+PPUyJM6BX1qkhvVkDuBi+vkg/Zveq2tkAKkgN
 arIKuqS5pnr+u/3+ArkA7RVqxevdql+mfAlHhS6qA7jlDTqP6cgepP3UOtu33eQ222TU
 ZeNQrHVb7P2xycY0pmHDUTdvXkJLXWkqLQZe7E41yApTN3RO9yxB7I2Zm9tgtF1jqNnR
 2WOYqTtt0jCvfNVu9E7VqJVbuLIG6MDovWSyoKO1fMk6R4nvmeisqnOPQrpJTLhvgQzX
 P/NA==
X-Forwarded-Encrypted: i=1;
 AKwUvBySBGrt4dAv9B8MNfHySTmNr/cKB+5naSkwowNZBer9Q82EDTU2Ioi/IHP0kx0qwYphyukEX6P0y4E=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK6kwYh4qEuGpeTQLhGtuGDqmQt6bFsByzH4zWHSA/x+7Fn+lh6
 28qqTYzqx5ji8RtFuH2d9kgt2rKpIn2Hjn81SBHZ5t7tpbkicauTNl9r
X-Gm-Gg: AYBFou2makmjsNeU8oga6d5hUgvAUle15aYk08fTP20uETfEPY4zTkU16SRznCdeOTD
 /Sl68glsmNlrPAvtSPvvim8JrfYs+hbNyK8q02gCMxvvm06tgYyRhKRvABQyKRK/O8QV+VRyu9j
 bd2bAzM/AkcDDFR1qAeSZ5wPLk23f0iTwpk4U8tMt78lcbouPr/DVpXcjXSamfsDQ3jXpOIY87L
 DL5iTShvoR8qJCYWLv+3bXz7U7wY9SGzKK7NWjQgbJuHRe9xfq31jXZlqsZCXU/YqLHiFCQvOlV
 s1HmhWu3Cuj2aLfE/PkPZWxBvoenciR+TGSC35vs8vStFiyUEXOZSkHALDMooQWW12ap0Qd2auE
 puAdnZ92xHDHTHWpATm6eS0vX2gJprIot7MvGhB12MqvJajlqLO/uZrMJ3XkWEucavE82xSdGxH
 PP0tbo2SLDWR+33BU3s1MeVenu0fqj2j2Yw4a0K4liZF92/RFbB2SOM6QIZVsOBmENq4THcDHyo
 but7dZKXe0XeJXI7Z1JP9kmbfmQEBo9JiUcTbI8/iVSWkMclvphtLJAWL4Hg+uN34WE2Z/wQzm4
 hNzOYJKQQ1Ukz/Dh2aU9
X-Received: by 2002:a05:7022:6283:b0:143:7001:7645 with SMTP id
 a92af1059eb24-19937022b7amr15370847c88.47.1793042216791; 
 Mon, 26 Oct 2026 12:16:56 -0700 (PDT)
Received: from localhost.localdomain ([136.126.251.209])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a01fa4c58sm25348449eec.21.2026.10.26.12.16.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 12:16:56 -0700 (PDT)
From: Henry Zhang <henryzhang62@gmail.com>
To: Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Henry Zhang <henryzhang62@gmail.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] drm/vc4: dsi: Make failed reads visible and recoverable
Date: Mon, 26 Oct 2026 12:14:54 -0700
Message-ID: <20261026191618.9430-1-henryzhang62@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 27 Oct 2026 09:31:59 +0000
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
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DSI reads on the Raspberry Pi 4 (vc4, DSI1) can fail in two ways that
the caller cannot handle:

- A peripheral that detected an error answers a read with an
  Acknowledge and Error Report. vc4 copies its two bytes into the
  caller's buffer and returns success, so the error bits look like
  register contents (patch 1).

- After a read whose bus turnaround times out, every following DSI
  transfer times out as well, until the display is switched off and on
  (patch 4).

Patch 2 rate-limits the error interrupt messages, which patch 4 would
otherwise turn into an interrupt storm. Patch 3 serializes host
transfers against each other and against the bridge callbacks, so that
the recovery cannot reset the block under a transfer or while it is
being configured.

These patches do not prevent the timeouts. With video running, vc4
does not keep commands within vertical blanking, so a command can still
collide with active video and time out. That is a separate issue; this
series makes such failures visible to the caller and recoverable
without a modeset.

Tested on a Raspberry Pi 4 (DSI1, 2-lane video mode panel) with the
same changes backported to the Raspberry Pi 6.18 kernel:

- 5 minutes of generic long writes from 4 extra threads with video
  running: 40394 writes, 583 timed out; each timeout was followed by a
  reset and restore, and the following writes went through. The DSI
  interrupt rate stayed at 131/s, with one error message logged.
- 50 display off/on cycles with 2 writer threads running (the case that
  locked up v2): no lock-up, no warning.
- 250 display off/on cycles without extra traffic: 248 panel inits
  succeeded; 2 failed because the data lanes did not reach LP-11 after
  power-up, which this series does not address.

Reads were tested with these patches plus a change, not part of this
series, that stops video while a command is sent: 2000 of 2000 reads
returned the expected data.

Compile-tested on drm-misc-next (arm64 defconfig, DRM_VC4=m, W=1), each
patch on its own.

Changes in v3:
- v2 is not safe; please don't apply it. Its recovery keeps the block
  usable after a timeout, and a peripheral that leaves the data lanes in
  a bad state then raises the "data lane 0 sequence" error interrupt
  tens of thousands of times per second. Printing each one starved a
  Raspberry Pi 4 until it had to be reset.
- Patch 2: new, rate-limit the error interrupt messages.
- Patch 3 (was 3/3): moved before the recovery, and also taken in the
  bridge pre_enable, enable, disable and post_disable callbacks.
- Patch 4 (was 2/3): only recover while the block is enabled, and mask
  the interrupts while the block and its AFE are in reset.
- Link to v2: https://lore.kernel.org/r/20261019174930.7237-1-henryzhang62@gmail.com

Changes in v2:
- Patch 2: restore the registers in the same order as pre_enable, and
  call synchronize_irq() before the reset (Sashiko review)
- Patch 3: new, serialize host transfers (Sashiko review)
- Link to v1: https://lore.kernel.org/r/20261012190249.3167-1-henryzhang62@gmail.com

Henry Zhang (4):
  drm/vc4: dsi: Don't return error reports as read data
  drm/vc4: dsi: Rate-limit error interrupt messages
  drm/vc4: dsi: Serialize host transfers
  drm/vc4: dsi: Recover from a timed-out transfer

 drivers/gpu/drm/vc4/vc4_dsi.c | 172 ++++++++++++++++++++++++++++++++--
 1 file changed, 163 insertions(+), 9 deletions(-)


base-commit: 650385a0fd0ea6475a17d39a20ec90470c7a4c67
-- 
2.47.3

