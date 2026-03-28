Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91610F3D5FF
	for <dri-devel@archiver.kernel.org>; Sun, 29 Mar 2026 09:53:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BA4910E0E8;
	Sun, 29 Mar 2026 09:53:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OTjnlqXT";
	dkim-atps=neutral
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DF0410E060
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Mar 2026 15:25:56 +0000 (UTC)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-2bd9a485bd6so5942271eec.1
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Mar 2026 08:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774711555; x=1775316355; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gAjwX6kT52RVXlZMnfnNFPa3vKSL/2ZW2fBqwvzrgwg=;
 b=OTjnlqXTjX7gWO5TMtdRuwwhl2G3CFNXd3/UdTABbbKLQ6jf3ERzChmlvbRYyoW2NH
 OdWfbc/arNg5zBKYiiNw5TVA/+ycNwFl9cpzp8IF1bacJnVCqM5iylsPvWHAcRfKlDBh
 ywlVDMNTWXwWhTHOXgGb7e92xRvaaFAhoPZRAtZNWECQG7AVhQkpCA7rQBdyw1AbjCpj
 eCSqxs5qwJh8aq6iWXxGVpxl+Zl1sXkWaoWjL85Bh37WWmewbHl/yvanFUzNbsyaXe3l
 Xbt6WKLDdk5LYYTYSb+eiH4ARNKzLcViwhLyPg/48RdjLM0d46IkG10JvUHp0ZNByk6P
 evXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774711555; x=1775316355;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gAjwX6kT52RVXlZMnfnNFPa3vKSL/2ZW2fBqwvzrgwg=;
 b=Ws6FMrhAj2tnRCRp4CKfRtnB7jHlpAr/fTpIVGNvLpECoYr6LEaMwdginBGtwN7Axb
 P31KmTBN+hB5PFxlswd7wCCZwa8oKrkNCeQeOFQf8j/fvNvUIIjIDynochyO8wgXm1pY
 xxzeO11PcTY36GiJumWp3+jWxoMsVxkgFqH49DCY8CiTCdQatQKFX3GEJU9u7SeLHaW3
 raPmhCouEsb73pgajcoFHGeXSnMJnmrE97IWYbF4PS60MCbx3gmD0ZOqYDIVaxih7ER/
 uhgEOnld0Adn55ezv89MLnETxyvh4WBkPsqkgbtWklvh/kz54MXSL/xmRfl6EGEIyLTZ
 L8Mw==
X-Gm-Message-State: AOJu0YyaVWwz4o4ZyRpFxTjEXln4KWqMkRmBjnXT7lanxAXD7cFj6iGQ
 bmZYyhbKyw+GuSUlsUhnJUrS+EgVjEyd9rIdsavGVbaKSCY/ApW1hjQIJehzdfU6
X-Gm-Gg: ATEYQzzqy8EX5ZwF9L+BgZ5rPX3yas/UZvdEluQHBis3ThQChKxS5ik6mT5BOZ8n+Z6
 zbD9J98gJ+YVkFKKs3dKawHPgwlBzxXjjNy4YM6wxBgny6NVZiUH4/locdID85HTcMPHtdAHiLr
 4SRPQagpb5Wq3R1XPNAMMGJ9ULbt/lFfJvSWTEsSlOF71x0G+3fINnmuI3WjCHqMXNibx86y+n+
 tZft5cS+FQB88lpzNQikAtjnktlJlZt3HAo7ncQj7J4toWgdfBQ+xf9LNy68ibX8cDx6PSOZPKP
 jtIMZJXJg+dGyMFUvGabXjMFFq5s5PX/cJ0Mb4CeNzW13ygjyTL1mAp51GdhT9MHsoI4kaYAs2b
 xKDFAqCib8LOu64nX7xfCoUk8FQ640vxPntmK3+EUtEAxwfnrfElW9rWJ2s+oMRin61fvwzByUG
 1AHb5FJpMIIXruqNiaqtLyGQa/FaSc82LPBq496ys=
X-Received: by 2002:a05:7300:e60b:b0:2b9:80c1:bb5 with SMTP id
 5a478bee46e88-2c185fb72aamr3664331eec.33.1774711554651; 
 Sat, 28 Mar 2026 08:25:54 -0700 (PDT)
Received: from msedek-pc.localdomain ([200.28.217.234])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c3c796d895sm2149215eec.28.2026.03.28.08.25.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Mar 2026 08:25:54 -0700 (PDT)
From: Miguel Sedek <miguelsedek@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 Miguel Sedek <miguelsedek@gmail.com>
Subject: [PATCH] drm/probe-helper: signal hotplug for force-enabled connectors
 on HPD
Date: Sat, 28 Mar 2026 12:25:50 -0300
Message-ID: <20260328152550.20222-1-miguelsedek@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 29 Mar 2026 09:53:39 +0000
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

When a connector has DRM_FORCE_ON (set via video=CONNECTOR:e),
check_connector_changed() calls the driver's detect() callback.
Well-behaved drivers (e.g. NVIDIA's open kernel module) check
connector->force and return connector_status_connected regardless
of actual hardware state. This means the epoch counter never
increments and no uevent reaches userspace.

However, the HPD interrupt itself indicates a physical state
change on the link. A common scenario is an HDMI-connected TV
switching to built-in apps (Netflix, etc.), which causes the TV's
HDMI receiver to stop listening to TMDS signals. When the TV
returns to the HDMI input, the GPU needs to re-negotiate the link,
but no component in the stack detects this because the forced
status masks the physical change.

Add an epoch counter increment for force-enabled connectors after
detect() returns. This ensures the hotplug uevent reaches
userspace compositors so they can trigger a modeset for link
re-training.

Note that detect() is still called normally before the epoch
bump. This preserves driver-side effects like scrambler
re-initialization on vc4/i915. This approach differs from a
prior patch [1] which skipped detect() entirely for forced
connectors and was rejected due to regression concerns on
scrambler re-init.

The software polling path (output_poll_execute) already skips
forced connectors with an explicit guard. This patch addresses
only the hardware HPD IRQ path, which was previously unguarded.

[1] https://patchwork.kernel.org/project/dri-devel/patch/20220826091121.389315-1-mrodin@de.adit-jv.com/

Tested with:
- GPU: NVIDIA RTX 5070 Ti (nvidia-open 595.58.03)
- Display: Samsung 75" 4K TV via HDMI-A-1 (force-enabled)
- Kernel: 6.19.10 (CachyOS)
- Compositor: KWin 6.6.3 (Wayland)

Signed-off-by: Miguel Sedek <miguelsedek@gmail.com>
---
 drm_probe_helper.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drm_probe_helper.c b/drm_probe_helper.c
index 92f2176..b7d60e2 100644
--- a/drm_probe_helper.c
+++ b/drm_probe_helper.c
@@ -984,6 +984,23 @@ static bool check_connector_changed(struct drm_connector *connector)
 	old_epoch_counter = connector->epoch_counter;
 	connector->status = drm_helper_probe_detect(connector, NULL, false);
 
+	/*
+	 * For force-enabled connectors, the driver's detect() returns the
+	 * forced status, so the epoch counter never increments. But an HPD
+	 * event on a forced connector still indicates a physical link state
+	 * change (e.g. a TV switching inputs). Signal the change to
+	 * userspace so the compositor can trigger a modeset for link
+	 * re-training. Note: detect() is still called above so driver-side
+	 * effects (scrambler re-init, etc.) are preserved.
+	 */
+	if (connector->force && old_epoch_counter == connector->epoch_counter) {
+		connector->epoch_counter += 1;
+		drm_dbg_kms(dev,
+			    "[CONNECTOR:%d:%s] HPD on force-enabled connector, signaling link re-train\n",
+			    connector->base.id, connector->name);
+		return true;
+	}
+
 	if (old_epoch_counter == connector->epoch_counter) {
 		drm_dbg_kms(dev, "[CONNECTOR:%d:%s] Same epoch counter %llu\n",
 			    connector->base.id,
-- 
2.53.0

