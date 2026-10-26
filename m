Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8ED7606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=neat.no header.i=@neat.no header.a=rsa-sha256 header.s=google header.b=B+UPMxIo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6776610F333;
	Tue, 27 Oct 2026 09:32:05 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE5E510F065
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 16:40:31 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-48afcd7ba9bso1904301f8f.3
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=neat.no; s=google; t=1793032830; x=1793637630; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=klRyRRDnFZYZ2CDpmJK+E/gioA1RuNNa1jRJVKORvEE=;
 b=B+UPMxIo9WJqfJn6sPCDVESLB4t2hkekO+hH95wo4gd7TmL06hg/DRLOSgXFeyWZ1b
 1IictS20ufS8ymhI52aQ/KkhJivFLKI/Dc005erqzRaDSAu0QiszG5vlqGY9uMlOxbZU
 2qBFg6wtN5KS+R/tf/W0JG8z5Btmgc3HQuu5lrL8eBOTcP9fLEiIXCv8afPnTbHk/huA
 zLL8fi5Bx/OYa6Dwlxu/hIx+9OnMKnsgjMMWyskOlkw/fZJJwCYajKogjlE/bb+Z1vpo
 ek22I4A1g9ouROgk1BLSyW/LLC/arCgowUmU9Mnzh6Gpr1ws4x4ISXId3FvWPQo/Slio
 i/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793032830; x=1793637630;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=klRyRRDnFZYZ2CDpmJK+E/gioA1RuNNa1jRJVKORvEE=;
 b=K06epTB34hYckz24fxmo4LBYmAkp9c0d6nbmbsS9oe/X99w+7Q1BaBbN0Vh5ZX8adj
 DGDCUhD7rxWT/x+rVX5Zh+3Is+sDskxBj5catEanYTzEiPm66KUK0jPFrHDp6MTuytJD
 RpFViQkVerKEbrTsOp1h7qR+MHAIVRRSr11ZUHmKMHUw7VPo/NoVlFsrM+3/EB26og4e
 Uggj5ZzCtxg7Hy5VlxlpTopzYd8d7GSX7tAwPTWU5yuqyw5R26vZjh+8kzTw2sBsRyh1
 L0iRBRAmPCZBHWNjV6hXXLdeCyGelaIYhrngKcdV62h+HAsa8NR+qb+qQJyZpHacXDNa
 PFfw==
X-Forwarded-Encrypted: i=1;
 AKwUvByzG6Sq9sxH1t5k9qV7AUChmqNVfVxHiRZvzqbPHBiOxBA3700Ud/BGod5vLWB7jR1v3A7UTolnW9w=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJmbUUjmY+QTV7qAUnA6yu+phrzpSeh6TYZbGKJNxmH7lu0DUnB
 AWOC1VpI1yEbsEaDLWjf8W/TI/iR85XySuWdlsyuBBv02k7W0uXsaxky6AnPVrR90nnggWmAzSQ
 VX6nvr16vdtfS+K1NUjb+6JKJyLdGZ/OUB+uLt74aomjzzIlv5TBECujW+hITZM/ZdyP0iI5B5V
 JmiIEWhYpwzhkDpYcStwCgp/nQHyY36uYggB46FZOvpYOElC9hcEMtvUzD/6VieS12ZZh6lrB3Z
 05HQ2yltRZj2K8+y3ZG6fObwmA=
X-Gm-Gg: AYBFou28w4bUqV3d55tBCOfpeFzAp8N3FNLaf8rXaEIUVN0b/A5xgQ0adlSz83Pj+zl
 8Ta7bRhOcdAyx8OhZ8d3pAcA1fDflclvus62rKnUJEnK93CD9DBlBwM75xQcurJGcmXP5aleMs+
 yyxWTY6zvom9Brns4wUcN6oPQM895XsjrCmv2m5O+BirMs2YPBTQJuP6P3fZ17fC8mRr1vfCzl6
 TChcG1jmK5NzB/KnRBJm1nsfV0AhrCwIAQ9cMm9IpMUKe4zWvSGYq2Jr8CCAbww72SJhKSua8rM
 UM4mTRh2m/4uiTdqXcuq5hxkRP3Fhu4jM88vbbEaQILGemhk6cK/1KFTwUbWDFRjGiGimGXgZpY
 NN3bq4BcajewLbqJREUD/c+MGXliCQM6tj++1L4Kge68KZnt/p6jAPEt02zZc65cV78s9lR7aS3
 HEtANVckr/6YR5xhcM7wUZ8o2b2nN5f1HD+APhjfVWZiINetCKeKYEd+vNif2MHenL1fSYsjHFV
 Eg21RdIOEjWOzEL3hR4L4TVtBYF3+YY+ZAz5CR4vLksJJ/FAyL+gi6gFnNKIJZZ
X-Received: by 2002:a05:600c:4e87:b0:49f:c199:e1e2 with SMTP id
 5b1f17b1804b1-4a35acbea9amr145367215e9.28.1793032829991; 
 Mon, 26 Oct 2026 09:40:29 -0700 (PDT)
Received: from threads.localdomain ([81.79.62.202])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a30e22csm205961655e9.2.2026.10.26.09.40.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 09:40:29 -0700 (PDT)
From: Lucas Tanure <lucas.tanure@neat.no>
To: Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Dom Cobley <popcornmix@gmail.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] drm/vc4: hdmi: enable scrambling before the TMDS clock
 starts
Date: Mon, 26 Oct 2026 16:40:25 +0000
Message-ID: <20261026164028.78792-1-lucas.tanure@neat.no>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 27 Oct 2026 09:31:58 +0000
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

HDMI 2.0 asks the source to set TMDS_Bit_Clock_Ratio in the sink while
the TMDS clock is stopped and to start the clock at least 1 ms later.
vc4 writes the bit, and enables the scrambler, at the end of the enable
sequence, long after the PHY has started, and clears it before the PHY
stops. A sink that samples the bit when the clock appears never locks
a 4K60 signal from a Raspberry Pi 5, while laptops that follow the
order work on the same sink.

Patch 3 is the fix. Patch 1 is needed on BCM2712, where phy_disable()
was an empty stub upstream, so the PHY kept running after disable; the
Raspberry Pi tree has carried this since 2024. Patch 2 fixes a
pre-existing race in the scrambling work cancel that the fix would
otherwise make easier to hit.

v1 was tested on a Raspberry Pi 5 running the Raspberry Pi 6.18 kernel
with the same change applied, against the sink that showed the
problem: plain enable at 4K60, 1080p60 to 4K60, 4K30 to 4K60, a sink
reset and a sink power cycle all lock with zero character errors. v2
and v3 carry the same code; the hardware test of the final form is
still pending and will be reported in this thread. Mainline was not
booted on the Pi 5. The BCM2711 path is unchanged except for the
enable order; I have no Pi 4 at hand.

Changes in v3:
- Patch 1: rewrote the commit message as requested.
- Added Cc: stable@vger.kernel.org to all three patches as requested.
- Collected the Reviewed-by tags on patches 2 and 3.
- No code change since v2.
- v2: https://lore.kernel.org/lkml/20261020151948.83459-1-lucas.tanure@neat.no/

Changes in v2:
- Add Dom Cobley's vc6_hdmi_phy_disable() from the Raspberry Pi tree so
  the PHY really stops on BCM2712 before the SCDC bits are cleared.
- Cancel the scrambling work unconditionally with
  cancel_delayed_work_sync(); the pending check skipped a running
  instance that then re-armed itself.
- Enable the controller scrambler at the same point as the sink bits,
  before the PHY starts, instead of leaving it at the end of the enable
  sequence with the sink descrambler already on.
- Drop the extra usleep_range(); drm_scdc_set_high_tmds_clock_ratio()
  already waits.
- v1: https://lore.kernel.org/lkml/20261020134941.631907-1-lucas.tanure@neat.no/

Dom Cobley (1):
  drm/vc4: hdmi: power down the BCM2712 PHY when the output is disabled

Lucas Tanure (2):
  drm/vc4: hdmi: always cancel the scrambling work synchronously
  drm/vc4: hdmi: enable scrambling before the TMDS clock starts

 drivers/gpu/drm/vc4/vc4_hdmi.c     | 10 +++++-----
 drivers/gpu/drm/vc4/vc4_hdmi_phy.c |  5 +++++
 2 files changed, 10 insertions(+), 5 deletions(-)

-- 
2.56.0

