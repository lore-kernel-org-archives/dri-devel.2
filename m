Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A3C2F3028C
	for <dri-devel@archiver.kernel.org>; Sun, 15 Mar 2026 22:34:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50F7010E167;
	Sun, 15 Mar 2026 22:34:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m8Gmqo4y";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C123D10E127
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Mar 2026 22:34:53 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4852f8ac7e9so47119185e9.1
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Mar 2026 15:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773614092; x=1774218892; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vT4CyMXqzzZQnzh0fKnlLc2lOrrVq4ApdEBBPyIY3U0=;
 b=m8Gmqo4yQ1x2/XoXxgW1uVFTrXbdguMSwKYyrNmYI8mdBrpgJ1xu3QLCobM9hMMzaC
 eu0VnFGdCq0S/Y91HAxpixCUGFw2mRo6ejRDRDZbLNZOaMEPB8bMDC1X66d1s+vhoU3c
 EDStL01qzCC1z9ry1BdAxEigoHUWNfwXRTZOWHt4h/fl9VYLgAa6x6mgFhWaOt1EHjqK
 90O/Qi+TqVmah9iYA+P+R4B0HeQdhi9lQA9D6xQMpl8Itbxqdon1MxOjDKwasHZahLVs
 9PHFPRj1GTcnu+yaacNtUaRgzCjZq700tRayRGL0BF7IdSqJoNB4rbYB5IQIChTJs+NV
 ylRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773614092; x=1774218892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vT4CyMXqzzZQnzh0fKnlLc2lOrrVq4ApdEBBPyIY3U0=;
 b=QGXT9wrNQHy+YeNpqw7FG8KqcyFLxI+OZNH6nfNFQ1FODz00sXj4gdgCJjZVuNb8T5
 +OVHkuY2Gutc8DtO2G2tRcxszvHOmz0QS2LYakf/KLNJiJ2P5LuFK7JyzNc6c7HRSkLr
 a/Xo+FFYyWhWdxiMTqrN0OZ5b3E2Ketu4RgEWi/F0G3XUEotsTQMXUXtJSW4CRa3TzFA
 W8YcwAe360Ccn8ZYrQ9FKLlkd0gMBNi2Xm5lqA8bqiAQxkDtWhn9IIRXyJDBgp41QQin
 DcpWO0SpV+ch1AXPnwEaCPFl2E72S29TWum/DcsZxuhDivaNymbKmc5Xnrg0AcxQKYeW
 cucg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVAAzFRODjE9fSIxK7EHXclb3TNuXAyATzBCWBYc0a106/V+UIOWZBIAyUe0gDorc939bs1UAZagc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyjJcsqsAYwtJIsreZX6fLjsb1P7hEGWkj8VmyKv+D/tZn8RkK/
 Up0T4IWeHmzmyuN15t+2MfBR0LdmbFTVUSdJRvSPdfy/3bReY92SIcDO
X-Gm-Gg: ATEYQzxqKH04dLs5WbtHnUu2XpFjPAxDBjtBk8aWiisC1uBz8f+qDiOdmRUBxftcSGw
 R1A7/Cji6uZ+d7DL0SLMCzlFLuEFtkGAnoGZ2qbjAwmgIKcLe0ervwa+8+1RTQPwTuB1vIvOcTA
 1hIKkpxqSG/cwwuH1vb7o4E8ZVex14reOeW3cEJk87WL7zLH8Fg3CNAqxQBshwATlQRX4zr9DnQ
 X/PvGZty5CI+x6NdXD2PcrcUH9FIyeq4yb4hss8vS6Cnd8xvaKJVxQjb6+gK73O9iPUmOoufqDk
 ifV1YOEhztYMTThvk3Po6kMyv1eod4AUISiIQpsg4i4/wHYBa+cG4+O3ILCStnQ0UUdnFwDNtsc
 yZb3XMdflq9RahaKwIPWGoQUKv/DbLgkVQuQ3H4UJDc++ki3l8jQqedmRTi+8IFh4Z7s2/CUtKj
 S2kfjH9poNbILZtvmJq/E4CM57xZjvGCHZlS2EEfpXjDXMtZxM99ykYDiEa5HnfAnsx3oYVrMtt
 OCRUxrVPZRvTjjFK2yN
X-Received: by 2002:a05:600c:64cf:b0:477:7b16:5fb1 with SMTP id
 5b1f17b1804b1-485566cf893mr182557815e9.7.1773614092190; 
 Sun, 15 Mar 2026 15:34:52 -0700 (PDT)
Received: from localhost
 (p200300eba70b6e00ca7f54fffe019321.dip0.t-ipconnect.de.
 [2003:eb:a70b:6e00:ca7f:54ff:fe01:9321])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541b6f6e6sm821489895e9.10.2026.03.15.15.34.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2026 15:34:51 -0700 (PDT)
From: =?UTF-8?q?Johannes=20W=C3=BCller?= <johanneswueller@gmail.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: =?UTF-8?q?Johannes=20W=C3=BCller?= <johanneswueller@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/4] drm: add edid_overridden flag to drm_connector
Date: Sun, 15 Mar 2026 23:33:03 +0100
Message-ID: <20260315223307.45807-2-johanneswueller@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260315223307.45807-1-johanneswueller@gmail.com>
References: <20260315223307.45807-1-johanneswueller@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

When an EDID override is in effect, the physical connector may not
match reported capabilities. Adds a drm_connector flag that allows
drivers to detect such mismatches.

Signed-off-by: Johannes Wüller <johanneswueller@gmail.com>
---
 drivers/gpu/drm/drm_edid.c  | 2 ++
 include/drm/drm_connector.h | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 26bb7710a462..9b0f410ea2de 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -2373,6 +2373,7 @@ static struct edid *_drm_do_get_edid(struct drm_connector *connector,
 	struct edid *edid, *new;
 	size_t alloc_size = EDID_LENGTH;
 
+	connector->edid_overridden = false;
 	override = drm_edid_override_get(connector);
 	if (override) {
 		alloc_size = override->size;
@@ -2380,6 +2381,7 @@ static struct edid *_drm_do_get_edid(struct drm_connector *connector,
 		drm_edid_free(override);
 		if (!edid)
 			return NULL;
+		connector->edid_overridden = true;
 		goto ok;
 	}
 
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index c18be8c19de0..43d7ac31deba 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -2261,6 +2261,14 @@ struct drm_connector {
 	/** @bad_edid_counter: track sinks that give us an EDID with invalid checksum */
 	unsigned bad_edid_counter;
 
+	/**
+	 * @edid_overridden: Indicates whether the last read EDID was an
+	 * override (e.g. via debugfs edid_override or drm.edid_firmware kernel
+	 * parameter), which can cause the physical connector to differ from
+	 * the advertised capabilities.
+	 */
+	bool edid_overridden;
+
 	/**
 	 * @edid_corrupt: Indicates whether the last read EDID was corrupt. Used
 	 * in Displayport compliance testing - Displayport Link CTS Core 1.2
-- 
2.53.0

