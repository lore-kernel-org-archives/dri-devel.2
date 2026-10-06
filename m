Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13714CA5FFC
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 23:19:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F46B10E49F;
	Tue,  6 Oct 2026 23:19:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T/DLcsoN";
	dkim-atps=neutral
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 099E510E49F
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 23:19:51 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-33bf40b0c8bso1912729eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 16:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791328790; x=1791933590;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=69yN0Ial5JtjSpn2ZK2Zu1JwU36ThXT4fMCp+kgmyIE=;
 b=T/DLcsoNZHQSMDcGarltRh0wOabsliy0BUY0ya1gX+xk0lMciSUrBdgWOMO0rT2t1x
 D+gkAPyH0GGhDPGzzQ6U+XN5bAgNB+Tg/wVyAvHcODPl6q7bAwUfExDJxk9f9hgigsr1
 earnSKH53Wl9TFLF88BUpp1kh+8j5aPlVbS58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791328790; x=1791933590;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=69yN0Ial5JtjSpn2ZK2Zu1JwU36ThXT4fMCp+kgmyIE=;
 b=ZEhz1t83Bqm+tvsYWHcP5GoWHtOriZfJZvAM8WFDd2fQXbST81+Zd6hpxc+L0Cc/sg
 5tM8Y8Sy2VX7rZKrh6araIY3XP25jQCjEK4PVtb2+t5WPfOAF4+LoWXhAVZvJl/VKl2H
 wLDOwpf1o4Ah19A1q1ite9hGAW+ZggTyyvcOJ+rIJO34cJpp+rPR7npru0pu16PVV/a6
 5khbPba/m8peOizetdA8hcfD6c80eYbPfVzjjzG0HOIya6G1B0jC9LbtRXfSsnNWiLXn
 Dq0y/yMqfAms6GZVBvShUBByaeIHULpDos5omcXCKTD9Tm74QzCNIJxpaGH/JBdz8feq
 5DYA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy6onj+5jDXExdieBslmf6LBqNxk7ZibCTexabor6E1oSJDhcau3SimVTHsGMic1soy4EsBVj0MoLk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++njmhErwnWyqSUk4XSEJXBpZiow13DqkhftOgW0uPZhMJO2Fh0D
 tYRhOiIx3cV6C7buAqHAT/miCadJCRrP36xtY/3RY+DqTZnsSaWi8L887d26EEip5w==
X-Gm-Gg: AYBFou3hKzQeA13/AGxwHoG1UjIplZzXjXED0Ry1wrOaV2CBcAHhQHn3QmaONx7EJtm
 TbxNT0L/q3J7k+jDHd6pw2nMC0n4AI3KCqMvq9QFjI9Al5s1w+tsWW6qucXbTurE48/RTWA44Gd
 jlQ+I63bX542YkbwuJyXeBZuXtUrYm1sA1OZsR8zvoeNIc8qOths3uhEQABPyrxZtFLonUsK0uX
 JTCKa1t8/D5iYvAP6/+fzwnEd9W49xxOHBBQzVxa7/pteaci/kO4mL7TymXAe+kg7JvkEXwevVb
 9KeQgt/OuDgX5uonG4hCxmgl7y7meE3PMccng0P6XM1IYHJaB7DyZBX8iMJQW74hVcamYCdKi79
 +ZVHF1RSNeYfqXqT6qo6uysVnMm5razBpAUSmyUBqQeAsICNz7aQCNVilJzOZhpVL9JPP2Oxhgd
 5gpetb1A2oYXYqxDmVlnL34Tef6BdtlX8XB5GGpgU+qh60fxhWpT2/FMWbY/icxrrvCC2zgqJjs
 CdE5JcmsRQuxRdLM2bqlakMsJkNQA9zg9B87A==
X-Received: by 2002:a05:693c:87d7:20b0:34b:d400:e999 with SMTP id
 5a478bee46e88-3515db9c5efmr355962eec.5.1791328789999; 
 Tue, 06 Oct 2026 16:19:49 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:63eb:e7f9:1d47:7d47])
 by smtp.gmail.com with UTF8SMTPSA id
 5a478bee46e88-3515abb5389sm1959671eec.2.2026.10.06.16.19.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2026 16:19:49 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>,
 linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Jessica Zhang <jesszhan0024@gmail.com>, Jyri Sarha <jyri.sarha@iki.fi>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Melissa Wen <mwen@igalia.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 dri-devel@lists.freedesktop.org
Subject: [PATCH 02/13] drm: Discard pm_runtime_put_autosuspend() return values
Date: Tue,  6 Oct 2026 16:13:30 -0700
Message-ID: <20261006161337.2.If1822f9a34be06cf5939be44ac6465c543087c75@changeid>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
In-Reply-To: <20261006231900.3230373-1-briannorris@chromium.org>
References: <20261006231900.3230373-1-briannorris@chromium.org>
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

Several DRM drivers use or propagate the pm_runtime_put_autosuspend()
return value, which is not particularly useful.

Returning an error code from pm_runtime_put_autosuspend() merely means
that it has not queued up a timer or work item to check whether or not
the device can be suspended and there are many perfectly valid
situations in which that can happen, like after writing "on" to the
device's runtime PM "control" attribute in sysfs for one example.

For this reason, modify these drivers to simply discard the
pm_runtime_put_autosuspend() return value, and change the return type of
v3d_pm_runtime_put() (whose return value is never used) to void.  Also
drop the redundant pm_runtime_mark_last_busy() calls right before
pm_runtime_put_autosuspend().

This will facilitate a planned change of the
pm_runtime_put_autosuspend() return type to void in the future, similar
to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
type to void").

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
This patch is independent of the rest of the series, except for the end
(changing the return type). I expect it can be applied by individual
maintainers, and we pick up the end once the dust is settled.

 drivers/gpu/drm/panel/panel-simple.c | 8 +-------
 drivers/gpu/drm/tidss/tidss_drv.c    | 7 +------
 drivers/gpu/drm/v3d/v3d_drv.h        | 4 ++--
 3 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index c95964ba25a9..193d1b2b0ba5 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -318,12 +318,7 @@ static int panel_simple_suspend(struct device *dev)
 
 static int panel_simple_unprepare(struct drm_panel *panel)
 {
-	int ret;
-
-	pm_runtime_mark_last_busy(panel->dev);
-	ret = pm_runtime_put_autosuspend(panel->dev);
-	if (ret < 0)
-		return ret;
+	pm_runtime_put_autosuspend(panel->dev);
 
 	return 0;
 }
@@ -389,7 +384,6 @@ static int panel_simple_get_modes(struct drm_panel *panel,
 
 		num += drm_edid_connector_add_modes(connector);
 
-		pm_runtime_mark_last_busy(panel->dev);
 		pm_runtime_put_autosuspend(panel->dev);
 	}
 
diff --git a/drivers/gpu/drm/tidss/tidss_drv.c b/drivers/gpu/drm/tidss/tidss_drv.c
index 1c8cc18bc53c..44b0b009c29a 100644
--- a/drivers/gpu/drm/tidss/tidss_drv.c
+++ b/drivers/gpu/drm/tidss/tidss_drv.c
@@ -40,12 +40,7 @@ int tidss_runtime_get(struct tidss_device *tidss)
 
 void tidss_runtime_put(struct tidss_device *tidss)
 {
-	int r;
-
-	pm_runtime_mark_last_busy(tidss->dev);
-
-	r = pm_runtime_put_autosuspend(tidss->dev);
-	WARN_ON(r < 0);
+	pm_runtime_put_autosuspend(tidss->dev);
 }
 
 static int __maybe_unused tidss_pm_runtime_suspend(struct device *dev)
diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index 29fa14be130b..eb002048ae9c 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -669,9 +669,9 @@ static __always_inline int v3d_pm_runtime_get(struct v3d_dev *v3d)
 	return pm_runtime_resume_and_get(v3d->drm.dev);
 }
 
-static __always_inline int v3d_pm_runtime_put(struct v3d_dev *v3d)
+static __always_inline void v3d_pm_runtime_put(struct v3d_dev *v3d)
 {
-	return pm_runtime_put_autosuspend(v3d->drm.dev);
+	pm_runtime_put_autosuspend(v3d->drm.dev);
 }
 
 /* v3d_sched.c */
-- 
2.56.0.360.g66cac248cb-goog

