Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA307606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 23:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d6cja1am
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02CAE11200E;
	Wed, 25 Nov 2026 23:27:01 +0000 (UTC)
Received: from mail-oo2-f7.google.com (mail-oo2-f7.google.com [74.125.231.135])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B575112009
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 23:26:47 +0000 (UTC)
Received: by mail-oo2-f7.google.com with SMTP id
 006d021491bc7-6dcee5a2fa8so245662eaf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 15:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795649206; x=1796254006; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hO8RLWgXAol9xN62Zc8zT+WmHPhN/Afuqjr33ogoN5A=;
 b=d6cja1amq7NS9pezVZA7cYcwu2y+nvkMWtGmD+iXpCp0QVcgxHlLE0j8wp8B+ALvlv
 97uG80J3fhvJtglXHwUghmMj7k/pLmFzpylmGJDBI7zigzIzn6lVIEDo0n1wTnB+eV83
 hJ1ISlvEzsRD9VUabxvOu/cxCAz63RMViiR9/0AaTS4NP8cIxWeq3y+Z4VnexTkaucFp
 VcUCDSwphimTL8zfCj8X+3arwaMCgxI/wxurj9dfq9M1WbXeKCvHItA8j/LPeElKOM1B
 nGxwfH7CJ8sQtLAEZVRQEG4wR+m+b8bObHl1Kz9d7vd2AS65mHA+x5+C9VD+VWemmpcU
 Jf7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795649206; x=1796254006;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hO8RLWgXAol9xN62Zc8zT+WmHPhN/Afuqjr33ogoN5A=;
 b=SyKYbZ2jZMrAfI6AxAlZlpiMAfjlmkfaFs7I+UUiB07/zkElP+FhDWhEs2JyH11lWH
 9YCt8AKrx0ECa8BcgApYqQP6RGFXSI+pQGs+AeW/m3whaIMA5bt69oTnXkfD5bPgwd6u
 xJCcWyQRxFUmSfrgko4SXDb3YkkaldAr5Vu9mZvK0/dHQEcUdvlRYUxI6vqBYbTifger
 C7inEtJaVKgf33KSeq0UAw8GdjWMOSMUXEo9lmsRPl/bqBiv4SINmfi6/+Z5MMN8I37G
 /WPg9NkBApLg+i18KcbXseuN//hvJCYmpKl5kDzrXxNzBcOTKBQApqR1iRfK30L8juut
 aYQg==
X-Forwarded-Encrypted: i=1;
 AL+hErGGm++yKdwTz+h1HAw8Hrwz8GglLmR2AdpTzKQt7FpbFh2QHK5PPwHXFA6/n++Ki9QSjtIFaga0TDY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9eUW8KrCXKOUZjgyxSJ6slIZfOADpzaDKx4CUPKp/G6o0+bcgm
 Qydg2RC37VfJex4DbeCmR0zkoxf7gUZ37St/nvl7DuYu08ep+zKUoZYC
X-Gm-Gg: AZFdTZfw66fSiuQ05eTgbIpc5CbbPpylBLs3Z8ChMWI5Q7WZKd8lduTv2jg1Ebe+euK
 /heudsLOfthaMM8lHfdtqbihGJ0yA6JW1OF82TrePkoidOd8b3jbXOZhiyas2ELPO/U2Ci0NkOR
 5YsXd3GZ7TE9MXsCYJ+OGocPj2cMjHk81wTo7eOCtqOwAR3LxortfpiQU+vBoq+xcvpdbjLjJBa
 tIBBnq8cQ4wGLqGR9GiICFS7RncRqRrACzvBayqX1l2g2L3N0uTKwfZr/h59jAmraBHzPE7cvbo
 oUbA6qHWwXAX92CEQGY99vwTVTS9g1br79QCvF9oA2c6HheomK6dTHQfeuM/9ufYtzku5Gv95Al
 mDa3+LGf/gWM3HPLsISIqa1bYw96olrqJ1bx5UItJm1qyau7VqETro/Lysq18L2SOCRONXjfk9F
 i9BwDqtTStdLjdsFGYufj+WezmiaBv1DehO9IL5XxsHOFpxHM9PHvN8AdR2tfnYjsZUE08WRqrC
 ItUUZkEhpQY1fES7q7ndYQ1ejteTZ7mrKRcEsor9MsoOki1P+R51Jm3OZpEVkb9dB8gpHxhipki
 4Db2Rffm8QPZxQLFMuSdcRjBTVYPU/18poQ=
X-Received: by 2002:a05:6830:3491:b0:863:3892:70d3 with SMTP id
 46e09a7af769-86338927828mr10242972a34.14.1795649206522; 
 Wed, 25 Nov 2026 15:26:46 -0800 (PST)
Received: from [192.168.0.98] ([50.26.120.197])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8631692f049sm14304892a34.25.2026.11.25.15.26.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 15:26:45 -0800 (PST)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Wed, 25 Nov 2026 17:26:07 -0600
Subject: [PATCH 2/2] drm/imagination: Don't wait for a running META to idle
 on a hard reset
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-rbrue-suez-pvr-reset-recovery-v1-2-2cea8b163e7e@gmail.com>
References: <20261125-rbrue-suez-pvr-reset-recovery-v1-0-2cea8b163e7e@gmail.com>
In-Reply-To: <20261125-rbrue-suez-pvr-reset-recovery-v1-0-2cea8b163e7e@gmail.com>
To: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Donald Robson <donald.robson@imgtec.com>, 
 Sarah Walker <sarah.walker@imgtec.com>
Cc: imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Ryan Brue <ryanbrue.dev@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795649198; l=6765;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=iczJBCCH7lzPQjGHXOusehPAUKAtFplLFsiGkVaoMM0=;
 b=wahARHemZ0pFlEFvtDIyI/IQAg5Cht+KlcKCGznTWsYp2NMwlZqLL2zegFg+qEgLv2BnfxcfQ
 +o/m6ygL/ruA51YXB3188uGviKyPtTeD9sGV7C4T1DmNkzXaAA0fk2q
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A hard reset skips the idle and power-off requests, because the firmware
is presumed hung, and then calls pvr_fw_stop(). On a META firmware
processor that is still running, the Garten wrapper never reports idle,
so pvr_fw_stop() times out and every hard reset ends with the device
lost, even with an idle GPU. On a GX6250 (MT8173) every other idle poll
in pvr_fw_stop() passes.

Skip the Garten idle wait on a hard reset, as is already done when a
debugger has halted META, and let the soft reset that follows stop it.
The decision is META's must_wait_fw_idle() hook, so pass it hard_reset.
The other idle polls, and other firmware processors, are unchanged.

Fixes: cc1aeedb98ad ("drm/imagination: Implement firmware infrastructure and META FW support")
Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
 drivers/gpu/drm/imagination/pvr_fw.c           |  2 +-
 drivers/gpu/drm/imagination/pvr_fw.h           |  3 ++-
 drivers/gpu/drm/imagination/pvr_fw_meta.c      |  6 ++++--
 drivers/gpu/drm/imagination/pvr_fw_startstop.c | 10 ++++++----
 drivers/gpu/drm/imagination/pvr_fw_startstop.h |  4 +++-
 drivers/gpu/drm/imagination/pvr_power.c        |  4 ++--
 6 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_fw.c b/drivers/gpu/drm/imagination/pvr_fw.c
index d620141b5df0..d75fa3e4c575 100644
--- a/drivers/gpu/drm/imagination/pvr_fw.c
+++ b/drivers/gpu/drm/imagination/pvr_fw.c
@@ -976,7 +976,7 @@ pvr_fw_init(struct pvr_device *pvr_dev)
 	return 0;
 
 err_fw_stop:
-	pvr_fw_stop(pvr_dev);
+	pvr_fw_stop(pvr_dev, false);
 
 err_destroy_structures:
 	pvr_fw_destroy_structures(pvr_dev);
diff --git a/drivers/gpu/drm/imagination/pvr_fw.h b/drivers/gpu/drm/imagination/pvr_fw.h
index e9a802be45b2..d985089ae191 100644
--- a/drivers/gpu/drm/imagination/pvr_fw.h
+++ b/drivers/gpu/drm/imagination/pvr_fw.h
@@ -189,6 +189,7 @@ struct pvr_fw_defs {
 	 *                     to report FW idle before proceeding.
 	 *
 	 * @pvr_dev: Target PowerVR device.
+	 * @hard_reset: The FW was not asked to idle before this stop.
 	 * @wait[out]: Whether the FW stop sequence should wait for FW idle.
 	 *
 	 * This function is optional. The assumption is that we must always wait
@@ -199,7 +200,7 @@ struct pvr_fw_defs {
 	 *  * 0 on success.
 	 *  * Any appropriate error on failure.
 	 */
-	int (*must_wait_fw_idle)(struct pvr_device *pvr_dev, bool *wait);
+	int (*must_wait_fw_idle)(struct pvr_device *pvr_dev, bool hard_reset, bool *wait);
 
 	/**
 	 * @has_fixed_data_addr: Specify whether the firmware fixed data must be loaded at the
diff --git a/drivers/gpu/drm/imagination/pvr_fw_meta.c b/drivers/gpu/drm/imagination/pvr_fw_meta.c
index 41f5e9ddc7f0..19baea23c434 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_meta.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_meta.c
@@ -562,7 +562,7 @@ pvr_meta_irq_clear(struct pvr_device *pvr_dev)
 }
 
 static int
-pvr_meta_must_wait_fw_idle(struct pvr_device *pvr_dev, bool *wait)
+pvr_meta_must_wait_fw_idle(struct pvr_device *pvr_dev, bool hard_reset, bool *wait)
 {
 	u32 reg_value;
 	int err;
@@ -574,8 +574,10 @@ pvr_meta_must_wait_fw_idle(struct pvr_device *pvr_dev, bool *wait)
 	/*
 	 * Wait for Sidekick/Jones to signal IDLE including the Garten
 	 * Wrapper if there is no debugger attached (TxVECINT_BHALT = 0x0).
+	 * A META that was not asked to idle (hard reset) keeps the Garten
+	 * Wrapper busy; the soft reset that follows stops it.
 	 */
-	*wait = !reg_value;
+	*wait = !reg_value && !hard_reset;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/imagination/pvr_fw_startstop.c b/drivers/gpu/drm/imagination/pvr_fw_startstop.c
index 40af04a64b0c..f543ebd2f56d 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_startstop.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_startstop.c
@@ -188,13 +188,14 @@ static inline bool layout_is_mars(struct pvr_device *pvr_dev)
 	return layout_mars_value > 0;
 }
 
-static inline int must_wait_fw_idle_before_stop(struct pvr_device *pvr_dev)
+static inline int must_wait_fw_idle_before_stop(struct pvr_device *pvr_dev, bool hard_reset)
 {
 	bool wait_fw_idle = true;
 	int err;
 
 	if (pvr_dev->fw_dev.defs->must_wait_fw_idle) {
-		err = pvr_dev->fw_dev.defs->must_wait_fw_idle(pvr_dev, &wait_fw_idle);
+		err = pvr_dev->fw_dev.defs->must_wait_fw_idle(pvr_dev, hard_reset,
+							      &wait_fw_idle);
 		if (err)
 			return err;
 	}
@@ -205,13 +206,14 @@ static inline int must_wait_fw_idle_before_stop(struct pvr_device *pvr_dev)
 /**
  * pvr_fw_stop() - Stop FW processor
  * @pvr_dev: Target PowerVR device.
+ * @hard_reset: The FW processor was not asked to idle first.
  *
  * Returns:
  *  * 0 on success, or
  *  * Any error returned by pvr_cr_poll_reg32().
  */
 int
-pvr_fw_stop(struct pvr_device *pvr_dev)
+pvr_fw_stop(struct pvr_device *pvr_dev, bool hard_reset)
 {
 	const u32 sidekick_idle_mask = ROGUE_CR_SIDEKICK_IDLE_MASKFULL &
 				       ~(ROGUE_CR_SIDEKICK_IDLE_GARTEN_EN |
@@ -309,7 +311,7 @@ pvr_fw_stop(struct pvr_device *pvr_dev)
 		if (err)
 			return err;
 
-		wait_fw_idle = must_wait_fw_idle_before_stop(pvr_dev);
+		wait_fw_idle = must_wait_fw_idle_before_stop(pvr_dev, hard_reset);
 		if (wait_fw_idle < 0)
 			return wait_fw_idle;
 
diff --git a/drivers/gpu/drm/imagination/pvr_fw_startstop.h b/drivers/gpu/drm/imagination/pvr_fw_startstop.h
index a3cef061bd60..79a95bbbe4e1 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_startstop.h
+++ b/drivers/gpu/drm/imagination/pvr_fw_startstop.h
@@ -4,10 +4,12 @@
 #ifndef PVR_FW_STARTSTOP_H
 #define PVR_FW_STARTSTOP_H
 
+#include <linux/types.h>
+
 /* Forward declaration from pvr_device.h. */
 struct pvr_device;
 
 int pvr_fw_start(struct pvr_device *pvr_dev);
-int pvr_fw_stop(struct pvr_device *pvr_dev);
+int pvr_fw_stop(struct pvr_device *pvr_dev, bool hard_reset);
 
 #endif /* PVR_FW_STARTSTOP_H */
diff --git a/drivers/gpu/drm/imagination/pvr_power.c b/drivers/gpu/drm/imagination/pvr_power.c
index eb4b6ecdf4f4..d88a522c4bfd 100644
--- a/drivers/gpu/drm/imagination/pvr_power.c
+++ b/drivers/gpu/drm/imagination/pvr_power.c
@@ -111,7 +111,7 @@ pvr_power_fw_disable(struct pvr_device *pvr_dev, bool hard_reset, bool rpm_suspe
 		disable_irq(pvr_dev->irq);
 	}
 
-	err = pvr_fw_stop(pvr_dev);
+	err = pvr_fw_stop(pvr_dev, hard_reset);
 	if (err && rpm_suspend)
 		enable_irq(pvr_dev->irq);
 
@@ -133,7 +133,7 @@ pvr_power_fw_enable(struct pvr_device *pvr_dev, bool rpm_resume)
 	err = pvr_wait_for_fw_boot(pvr_dev);
 	if (err) {
 		drm_err(from_pvr_device(pvr_dev), "Firmware failed to boot\n");
-		pvr_fw_stop(pvr_dev);
+		pvr_fw_stop(pvr_dev, false);
 		goto out;
 	}
 

-- 
2.56.1

