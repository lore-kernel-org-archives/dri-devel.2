Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DE8606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=neat.no header.i=@neat.no header.a=rsa-sha256 header.s=google header.b=XShfKYuF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC22110FCDD;
	Wed, 21 Oct 2026 08:53:01 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65E6010E814
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 15:19:51 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a1d75f2f11so23556975e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 08:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=neat.no; s=google; t=1792509590; x=1793114390; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0Vej13u2jckucyDYWl6nd0WIjVU37Ltm8NkmLR/CfY0=;
 b=XShfKYuF2d383sBTtrqlxqFfNbXnOpx2OvgeYNyDqGuiynsN0EcW8dDVrw2Td0Ewd7
 z2m0O3guGMnA4/fBge/7e2zpp1Dd2pQ40kP2tqChoNJe6cOI2g5lUY1jozZsrLacatxY
 XHyeKBkqtmLvEMfEZ7ZNqRFO2ERWXl/cFdPW7+3F8OO5nuuIbyrurSGDsFheZ63exd4F
 WBkG0fRi7yejST+4T+MAJpKu1r/Kw29ys0QRVvFqx6aRWo3AXBVWpaIRCDyq1jsPd+7x
 8De+aoAwqGW037e48nEhcSfydnub+O1wJyyE3IlzceJXiPQtbDgGffE8YHTa9tYdCsYc
 aefw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792509590; x=1793114390;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0Vej13u2jckucyDYWl6nd0WIjVU37Ltm8NkmLR/CfY0=;
 b=mTC4jZDjBRbU/mf5LsWA98T/Y53jXI4ibNpTir2+Uzzz+z2jFNR1VK27VFDbgqXfsj
 fpdLYwbScKnm1OcN0L5MJ5VuJeigV30gR5/nXESKPgNqZqrYNEDqymjOS1rcH5bHuYe0
 wbW257a1/KU3OCtK2DesTS1oo3lfjFe4I8dt4ZB4liboD1JUnG/IgO5+W2/Z/cwhizMe
 9QVVmzg+0DAzSZ+ZwGQcvs5ZXQYaz7QJTS9G6v16pq81d2P7imgCY+ymYuxh+FG9wpsG
 1JWbcLsq1qjVGpFVbkjezM3MO5uOObNidTbTnTzOJ/vAqBTayWRScVtk9JyMR/yE+deO
 ON+g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwNIMrGdDAgH1whJxSPcEQJSVa9dLw/JkjU3Ufu7rHaXZ2pmbwfmuf/fjRKUTS6tapNJoh400yQKQ8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLQek8QumcJtbnZErEZtRxe1E/3qIdO2JXPQmyYMuuIL4quBINt
 Zx125G1UQWxSyITWPPxzOzC1WuzPln63S/f1+OqC7N7vyDMcrPKKQsoB0m4B8z0QjK8mFXkWTeg
 pIV/hW65omUXtPtm4wAwuidwx0rzpiXopBea+DM7F4q6U2oG8mErXmWlZCJ96AMEcxxGxU8k6+Y
 LRxnuNQLBo7p8HudH4xAJwz+RRrcDmV5+rXs53FdG+2m7FeID4+3kIKKQTT5NNgNGmf/I1OV5Tn
 cIbAuhhKXWuBxsAM3zxLrfnZbM=
X-Gm-Gg: AYBFou2a3wcSJNUazm5yYulFjtrkO93+r88uYAn9FmTqQFXxiDXWJG/M4tsjcYt9h3j
 QJV6HiwYtSmWRc5FKai+z8p3HR9JmL0Wgpytdz4mB3+YPWhpD2KVD+zYR47apg7wDudYDL6HcXr
 NcWf/HE/49DTXxN6PfGer286wzQTCq3SuHlTPsfn+JjSgZmmFtxXgsH0xjzk8RFRxMZol7V261i
 MvsSy52kE6aEcqDR3gi4wI+dgNi+5qHluYqI59BNI01CVJrsAYaGGA43Q341ZxIX+HItQsS95R6
 w+5L7LFBz9P/uPHYey00MdYOf4EqDQSWDQt7vr28SaSpMt7k1WXio8QtA9GH4pf6JZkOkbs7O/A
 QIA7xdN2FHBt0zxQkQFoYhtPf+5GqeqHyi4Wasu2TJ9GSfzl37TskPBxsHaUbgLi8W1hUKPOjno
 hcALuclzGTiaKrvBgdMpP+VG2Tga7dEJ/qBbT7oEOwTUXWW94tcER3+kf4ZEXCmAAOTjziHPNNu
 BZRSas=
X-Received: by 2002:a05:600c:4f47:b0:4a1:e0db:8cf8 with SMTP id
 5b1f17b1804b1-4a1e0db8f0amr235245705e9.3.1792509589526; 
 Tue, 20 Oct 2026 08:19:49 -0700 (PDT)
Received: from threads.localdomain ([81.79.62.202])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d817d80sm7410663f8f.26.2026.10.20.08.19.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 08:19:49 -0700 (PDT)
From: Lucas Tanure <lucas.tanure@neat.no>
To: Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Dom Cobley <popcornmix@gmail.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] drm/vc4: hdmi: enable scrambling before the TMDS clock
 starts
Date: Tue, 20 Oct 2026 16:19:45 +0100
Message-ID: <20261020151948.83459-1-lucas.tanure@neat.no>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 21 Oct 2026 08:51:51 +0000
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
was an empty stub upstream, so the clock did not stop on disable; the
Raspberry Pi tree has carried this since 2024. Patch 2 fixes a
pre-existing race in the scrambling work cancel that the fix would
otherwise make easier to hit.

v1 was tested on a Raspberry Pi 5 running the Raspberry Pi 6.18 kernel
with the same change applied, against the sink that showed the
problem: plain enable at 4K60, 1080p60 to 4K60, 4K30 to 4K60, a sink
reset and a sink power cycle all lock with zero character errors. v2 is
compile-checked only so far; the hardware test will be repeated and
reported in this thread. Mainline was not booted on the Pi 5. The
BCM2711 path is unchanged except for the enable order; I have no Pi 4
at hand.

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
  drm/vc4: Implement vc6_hdmi_phy_disable

Lucas Tanure (2):
  drm/vc4: hdmi: always cancel the scrambling work synchronously
  drm/vc4: hdmi: enable scrambling before the TMDS clock starts

 drivers/gpu/drm/vc4/vc4_hdmi.c     | 10 +++++-----
 drivers/gpu/drm/vc4/vc4_hdmi_phy.c |  5 +++++
 2 files changed, 10 insertions(+), 5 deletions(-)

-- 
2.56.0

