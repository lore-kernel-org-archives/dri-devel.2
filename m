Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD81C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 22:37:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7DBD10EB5E;
	Mon, 13 Jul 2026 22:37:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l4YfgoLC";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7C6B10E655
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 18:38:59 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-493ae59eca6so1356585e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 11:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783967938; x=1784572738; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BZeraapBlFPUrYW3IPPqI51an2y6HYhJis8cCxDtDlM=;
 b=l4YfgoLC83LLluf6C5hkuFt09wVoLhl5KPqOndPlFpC1giSAc11hL17FRgOgp22R84
 oRi+RHlTFH0uAjydJURBhw0HmMD0F56N9ezpwu0Vst4Tl6pCVRaVWyR5PoCVqOq1KUoy
 v5a07AvtrO638RSsqmNvbFeIJyN8Adiz6lNhqc8VM81lrRP2OcHi2zYcAGhtJDvjyuZZ
 mngfaZ0s3zDnJNqXWqTxekka4W7FSCg6Mk0rA1o8fwdWXSi6kxLwEvEo6H14E8YI8PYB
 SsdnoCHokZujI3Yo/3hrvrtS1uIlT5+ahAy1X0VGF21+hSq8tpdvSz3fKaxSm8nlPXv+
 c9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783967938; x=1784572738;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BZeraapBlFPUrYW3IPPqI51an2y6HYhJis8cCxDtDlM=;
 b=OJXvQquw42QWA15W14+JC9SPfS/oTdx7PC3fRVXdCUaoVL2BtpRgbZ+vRRh68gwTEI
 2QKwN/v2olndYSz4yS550cuktu9p/S4wh4IzNAk484t/nAu1R+YgDObsln5UiOU0WW8l
 7ga/Dae2PI3hwoqn43FdTjo6ZZsYP4/bER+TIvnRVFnn991XyzZlOkIrR+N6MjAo0HMS
 y57zocqg6BttEW/h/QsUguxMSyBrjVgjTlEZwO44S+U6aPwnIDxG2jF6dibyFJFUkLX5
 WBlBfHgZ4XpIYCMBcyfKlDihkRYfodPdmNTPAn4It/viBjL/IEal027tOJlymIp0SHZf
 o3Pg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrEriSL3A6Xs5u5VLdnTUMIzWwwobhhQN1cQlBNklP7zQ9aVGW1jD0FvlZp6i5K07LQ2LYmiK0/42o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwkYJoTcB2wY6a8X+mls+RhOIym1L4/umIjXdwRvolUaPE607Vz
 g4YsJRUnEq0LnF6Rv65FUFLIdIkhpE6QzTRowBXhBARL2c865pC5hZIe
X-Gm-Gg: AfdE7clN/GoPNQ6QrlWOV6SJe8C1FwA1OhNBIMR0o3L7raAPYpCx899U3ekjIb6TzDn
 nKxBL+EEVBzDPobyi4KnlTftRK4MYPRY0HX4W9TXr9T/Zl0Ak4nqgSib8gyjTQusE0UwtTwkeQS
 MWrxHTRQINATYOhiPBs2driXl87DZSeqYwKD/On+7eL85ADXi6JirbBAwJgaCyqMVjDnmLEWI6r
 6sCv3KdHlRn7LNKhDtzxa4LRFLVssJKKUUO+ZUZ54KHjcXqqbnYXXdfoVKetYtRgAaot9GfcgfB
 /hc7jdya0IdwIXpKhunecqHMPwrsKw71pAoFqOGcKRNtcAnP6VXftQBmpoajNZfDxyckIxP8kFs
 r8R1pd0nvavOFcevkhw+d191OJ+oeLIvETi2I8DvWre3ttdi/HxkOWpkCNFUltottlNIGJuCeY0
 egjFIXhBdkCWEAR9lZE5wGULmVry4H
X-Received: by 2002:a05:600c:310f:b0:493:ee3a:f05b with SMTP id
 5b1f17b1804b1-493f87d7fcdmr103793315e9.7.1783967937889; 
 Mon, 13 Jul 2026 11:38:57 -0700 (PDT)
Received: from timo-z13.fritz.box ([193.30.163.202])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508727f7dsm14702455e9.4.2026.07.13.11.38.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 11:38:57 -0700 (PDT)
From: =?UTF-8?q?Timo=20Pr=C3=B6mer?= <timo.proemer04@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Rodrigo Siqueira <siqueira@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 =?UTF-8?q?Timo=20Pr=C3=B6mer?= <timo.proemer04@gmail.com>
Subject: [PATCH 1/2] drm/edid: Export drm_edid_block_count()
Date: Mon, 13 Jul 2026 20:38:40 +0200
Message-ID: <20260713183841.5921-2-timo.proemer04@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713183841.5921-1-timo.proemer04@gmail.com>
References: <20260713183841.5921-1-timo.proemer04@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 13 Jul 2026 22:35:59 +0000
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

Drivers currently calculating EDID size by reading the `extensions`
field of the raw EDID structure (e.g., `edid->extensions + 1`) will
calculate the wrong size if the EDID contains an HF-EEODB (HDMI Forum
EDID Extension Override Data Block). The base extension flag does not
account for these override blocks, leading to truncated EDIDs.

Remove the static declaration and export drm_edid_block_count() so
drivers can safely query the true block count. This allows drivers to
leverage the core DRM's proper handling of HF-EEODB and other edge
cases without having to parse the raw EDID fields themselves.

Signed-off-by: Timo Prömer <timo.proemer04@gmail.com>
---
 drivers/gpu/drm/drm_edid.c | 3 ++-
 include/drm/drm_edid.h     | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index df3c25bac..34560b33a 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -1698,12 +1698,13 @@ static int __drm_edid_block_count(const struct drm_edid *drm_edid)
 }
 
 /* EDID block count, limited by allocated size */
-static int drm_edid_block_count(const struct drm_edid *drm_edid)
+int drm_edid_block_count(const struct drm_edid *drm_edid)
 {
 	/* Limit by allocated size */
 	return min(__drm_edid_block_count(drm_edid),
 		   (int)drm_edid->size / EDID_LENGTH);
 }
+EXPORT_SYMBOL(drm_edid_block_count);
 
 /* EDID extension block count, limited by allocated size */
 static int drm_edid_extension_block_count(const struct drm_edid *drm_edid)
diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
index 04f7a7f1f..4a990bf87 100644
--- a/include/drm/drm_edid.h
+++ b/include/drm/drm_edid.h
@@ -481,6 +481,7 @@ const struct drm_edid *drm_edid_read_switcheroo(struct drm_connector *connector,
 int drm_edid_connector_update(struct drm_connector *connector,
 			      const struct drm_edid *edid);
 int drm_edid_connector_add_modes(struct drm_connector *connector);
+int drm_edid_block_count(const struct drm_edid *drm_edid);
 bool drm_edid_is_digital(const struct drm_edid *drm_edid);
 void drm_edid_get_product_id(const struct drm_edid *drm_edid,
 			     struct drm_edid_product_id *id);
-- 
2.55.0

