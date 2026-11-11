Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F191606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=XQN8FHoR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B989710FA14;
	Wed, 11 Nov 2026 09:28:56 +0000 (UTC)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.155.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1FE210FA14;
 Wed, 11 Nov 2026 09:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
 s=mxsw2412; t=1794389303;
 bh=1x6/q7+L9dxEYBNaqg2ktHXf+EsDRsOOjKgT005SyVg=;
 h=From:Date:Subject:MIME-Version:Message-Id:To;
 b=XQN8FHoRTkEzuOstNYTqZfTRafJorAlJCnVk8USfAdG3gjrPVrHvSCBO58jNUR+WC
 L7EZiH/WarNfa7BLMItRuQATpubfy7e3X6XStbUF9sqAdstKPhFZjZ1cKdsGTH/x9p
 LWmGqkRKoB/RRDRIdXqvt2IAFCzvQd1TIxkHKzgk=
X-QQ-mid: zesmtpsz9t1794389297t3edad2e2
X-QQ-Originating-IP: +XOiLYpaIA0jQa7S1Ua/duinw3+aYlE6x4ssoBLSJ1g=
Received: from LT-LIANGBAIHUI.dc.com ( [120.237.158.181])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 11 Nov 2026 17:28:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9060423660867139962
EX-QQ-RecipientCnt: 19
From: Baihui Liang <liangbaihui@linux.spacemit.com>
Date: Wed, 11 Nov 2026 17:26:38 +0800
Subject: [PATCH v2] drm/imagination: re-check firmware idle state before
 runtime suspend
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-img-pm-autosuspend-v2-1-427689f6f2f9@linux.spacemit.com>
X-B4-Tracking: v=1; b=H4sIAM009GoC/32NwQ6CMBAFf8X0bAktSNGT/2E41LLAGmmbbkswh
 H8X8O5xknnzFkYQEIjdTgsLMCGhsxvI84mZQdseOLYbM5nLSuTyynHsuR+5TtFRIg+25Uop2dZ
 FKapOsW3oA3Q4H9FH82NKzxeYuJd2Y0CKLnyO10ns3t+DSXDBZVVfRF3muijh/kab5oy8NjBiz
 IwbWbOu6xc4aKxxzwAAAA==
X-Change-ID: 20261029-img-pm-autosuspend-7772d83416f7
To: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Yixun Lan <dlan@kernel.org>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, Baihui Liang <liangbaihui@linux.spacemit.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794389294; l=3688;
 i=liangbaihui@linux.spacemit.com; s=20261015; h=from:subject:message-id;
 bh=x6K34nWpBSBqZdwbwRIhO9SVuy6u2jufX/yBvPX5t3s=;
 b=Nj5gTEREc6EDBnytR7IQoe/3SnxudUrSdxdlKMaGc9y3JbQk6N5bF/u8ohmdtVft9Via5jINg
 tcmXPIUZt3uBOWXEoPob0o7ZFn0SkE8dVwDYC9hYEVFUI7O9FLtmeYU
X-Developer-Key: i=liangbaihui@linux.spacemit.com; a=ed25519;
 pk=L9Pa1YBHFuJrRPNu/FfSW/likBvv9j2dUrR3r+YyJ5M=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NjuDfT6zrIZctbTuX7v6lwY5Cf/QCqoCeG3BScg0IQVlz/ZpxYISa+k8
 VHdGjlZJXiXl01u4QuLJhPa2Uht09CaaMvf1rNyatshuTmCadGwYMopuBr5uFTJZchRdG2u
 bxe7qkPdhmC2ISvH25Gc1vM6+MeWw8UGIZb6TzItxvpMyEDyBtgXGxUGbdcWL8Pjh221mDL
 hioJQOh5ZnuIRXI/Zm1CaEdypxdygXwQ6kIUYS/LQissz4ruOydg0rEtLaDVMgn1HJ5+0Q4
 QPurfRKo44Ydc6zD3aapz3hRyx/9K+QbFj2SL1VIDmQvpO5Czw/qSraXeiZIFSlS16qp1FS
 6RpXAW91zcUIEO01nGOYGywoFrjNWIowIeQxFOXJFvNUZUyvJzlv5Yut1tySUVRZMd+PUML
 ZDZjFzShBSjjHGi/lSBFFA+V+l3FCZ5X+I4Ld9hJ+9Dw4apqPhbBoHkV0DDnkzGE0Ah8/1M
 EKiBoV/yFnhrvjYFd8tin+Y72KcJ1g+iLE5MSu1xd3h2qyp7oHgfUKv/aHxnwae5KInDSNd
 uoQvgXMZCP6XXCIPJNaysyQmRzBVq0azxUCuj2Beqm69o6tfSWNvnF3EinlbO0YBYYOcCHR
 7rFMzAKgqJRecgayccL1rg97zn5BcpnGEzSjAV6t/PDBNTXyNHtmFGtfSFwNbnQkJgp9oK+
 PxO97F6ij3MlzuDpuMgFh0v+diw73RIYQ/dI79/IgNahgRWH6xIKQziqSjBVK5uwO3NJqGk
 G6Dq+1lztqsJFYEdhGPRKrLiTm+rANsIASTcKeLe6r7R+f1Al3yisXtbPEgpQBQ9rrJxxyV
 yJBnW2nsG7g+toSi5or8PAB7N61Qo6ckUd0sK8Lt9InWYoyq0GKcsl4SoVYAUhYCQ3fYQVe
 gecK4XrXv8e2K26Ks3pIGzOKWuqfQOvsAy6Ipc7OehnjZmdwbm2swy5+Jq1hP9Xw8a9Jaep
 5uNQSscBQbSOgRewyA4pce/0wadPgWA5gcynuiU04LRafzzp557M13NX8p8x8/xtUeE1T1X
 DgymDSTTzvZPxayPv9PPisOypcKmHBDv7yXNF7+l+s6FvgoBGh1+VLLBz7rAU=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

pvr_power_device_idle() rejects runtime suspend while the firmware
hasn't reached ROGUE_FWIF_POW_IDLE. The PM core doesn't reschedule
idle notification after rejection, so no further pm_runtime_put()
arrives on an idle GPU and the device stays powered indefinitely.

Move the idle check into pvr_power_device_suspend() and return -EBUSY
after pm_runtime_mark_last_busy() so the PM core reschedules the
autosuspend timer and retries until the firmware is idle.

Signed-off-by: Baihui Liang <liangbaihui@linux.spacemit.com>
---
Changes in v2:
- Move the pvr_power_is_idle() check into pvr_power_device_suspend()
  and return -EBUSY after pm_runtime_mark_last_busy().
- Drop pvr_power_device_idle() and pass NULL in RUNTIME_PM_OPS().
- Link to v1: https://patch.msgid.link/20261029-img-pm-autosuspend-v1-1-26851840a34e@linux.spacemit.com
---
 drivers/gpu/drm/imagination/pvr_drv.c   |  2 +-
 drivers/gpu/drm/imagination/pvr_power.c | 22 ++++++++++++----------
 drivers/gpu/drm/imagination/pvr_power.h |  1 -
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/imagination/pvr_drv.c
index 5c965ef0274..541351d4bb6 100644
--- a/drivers/gpu/drm/imagination/pvr_drv.c
+++ b/drivers/gpu/drm/imagination/pvr_drv.c
@@ -1516,7 +1516,7 @@ static const struct of_device_id dt_match[] = {
 MODULE_DEVICE_TABLE(of, dt_match);
 
 static const struct dev_pm_ops pvr_pm_ops = {
-	RUNTIME_PM_OPS(pvr_power_device_suspend, pvr_power_device_resume, pvr_power_device_idle)
+	RUNTIME_PM_OPS(pvr_power_device_suspend, pvr_power_device_resume, NULL)
 };
 
 static struct platform_driver pvr_driver = {
diff --git a/drivers/gpu/drm/imagination/pvr_power.c b/drivers/gpu/drm/imagination/pvr_power.c
index eb4b6ecdf4f..71267f714c7 100644
--- a/drivers/gpu/drm/imagination/pvr_power.c
+++ b/drivers/gpu/drm/imagination/pvr_power.c
@@ -378,6 +378,18 @@ pvr_power_device_suspend(struct device *dev)
 	if (!drm_dev_enter(drm_dev, &idx))
 		return -EIO;
 
+	if (READ_ONCE(pvr_dev->fw_dev.initialised) && !pvr_power_is_idle(pvr_dev)) {
+		/*
+		 * The firmware has not drained the GPU yet. Refresh last_busy so
+		 * the PM core reschedules the autosuspend and retries this callback
+		 * until the firmware becomes idle.
+		 */
+		pm_runtime_mark_last_busy(dev);
+		drm_dev_exit(idx);
+
+		return -EBUSY;
+	}
+
 	if (READ_ONCE(pvr_dev->fw_dev.initialised)) {
 		err = pvr_power_fw_disable(pvr_dev, false, true);
 		if (err)
@@ -427,16 +439,6 @@ pvr_power_device_resume(struct device *dev)
 	return err;
 }
 
-int
-pvr_power_device_idle(struct device *dev)
-{
-	struct platform_device *plat_dev = to_platform_device(dev);
-	struct drm_device *drm_dev = platform_get_drvdata(plat_dev);
-	struct pvr_device *pvr_dev = to_pvr_device(drm_dev);
-
-	return pvr_power_is_idle(pvr_dev) ? 0 : -EBUSY;
-}
-
 static int
 pvr_power_clear_error(struct pvr_device *pvr_dev)
 {
diff --git a/drivers/gpu/drm/imagination/pvr_power.h b/drivers/gpu/drm/imagination/pvr_power.h
index c34252bda07..7d8df45c7b1 100644
--- a/drivers/gpu/drm/imagination/pvr_power.h
+++ b/drivers/gpu/drm/imagination/pvr_power.h
@@ -18,7 +18,6 @@ bool pvr_power_is_idle(struct pvr_device *pvr_dev);
 
 int pvr_power_device_suspend(struct device *dev);
 int pvr_power_device_resume(struct device *dev);
-int pvr_power_device_idle(struct device *dev);
 
 int pvr_power_reset(struct pvr_device *pvr_dev, bool hard_reset);
 

---
base-commit: 067c5c24cef23d913b67eaaf71ae67e7169a6620
change-id: 20261029-img-pm-autosuspend-7772d83416f7

Best regards,
--  
Baihui Liang <liangbaihui@linux.spacemit.com>

