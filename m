Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE8A60A2608
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 07:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XGN5Ez40
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BADD10E2DF;
	Tue, 10 Nov 2026 07:15:07 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0DDB10E2DF
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 07:15:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 31DCC40301;
 Tue, 10 Nov 2026 07:15:01 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794294901;
 b=TQVmsnRG1gj56u1dNa9ELY9ePTVIXh3H6qoAVlg16OD2uLnli2PUauF6NzwBQyBHNlPC
 8VPt4NPujVFPnTKFJlVOLZ5HEgHKv5TVSk67biLfrjQ+tCgOQAj7nW2oLqQA3jxf7L051
 gEwb79FAfXBTCp0DyQJf/CfmYpkd+ubFkNEPCiOZQxmL6ef2U4HPzmQVHI1vmGHowt/gO
 1RbJRor58Q8x4o9xOljxyDQ9rJy2QWblt/bN8jTl2UwpZ4n3Jtx4Hth1zDxX3/lRwN33s
 JbrLw3DS0h2PeGYBp9llhZYJp/aZ//IuLCPTe1jew7iDhBe3hgDxnRDRWd1LSVwVRQg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794294901;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=ae4pe3RUGygwlUhXax0I830rKA/M8Wy+tBPNgk2/UPg=;
 b=oXY5P3iFg5HpaYNu9v9jBwwGs+m8cDVJmhyUw/Uboslf+7sqFu22w7d0fEsW9+Ek5sfH
 wtSjNXIlSvhICN0ABIaWpU2+tAGB+/fHgBBzG7QXIS3LEUzE/bDaHfOYaBYvuAoXuNmO7
 ht1FkqBc4Fy2GhPXeSD9pjvuaYnV78Sq4tqFkpSdvbRXTm0R4OBaxM4xPfxL72ojNWSJR
 2/u12hdlqF+JXmzQP4MWTYgeoaQmz0us4CJrdhYTHtztaiYobigT7yYlQvD9rKTJJMU1f
 nLhy864oqLdfdh//FpJMTZkJEyGVsDTaba40qzzbeyAH2HES0oopAd/Z6JnbXggCRKQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 5C8701F0089F;
 Tue, 10 Nov 2026 07:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794294901;
 bh=ae4pe3RUGygwlUhXax0I830rKA/M8Wy+tBPNgk2/UPg=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=XGN5Ez40NfwkOD1+4OcbvyRmxrQRyys3RMZUhsE1y/MAu9UYLLAua0GLJ5AaO9QZK
 3ax0zShK7tOo3FXCJ0XWefFeFO4Drv9A1A1YAt6q4IcOFnJIHK1C/q/lzve0sn+6gm
 iAvFPrbmoaHd7D2DMogSlrpfO9+PqBvzcIfevbnA3sP3MIUj4W+dq9uHfT6q6i3BPF
 LTW0G/GIPUj0ybbMokMNA7puIR2E588VzZAJJ5Hxo7vgcSxEH1Is79IUbdrPNWaJvB
 gwntZh7y1gpa0iU17WsokybzvignlDGZdD/64l1Wz0oVD4yWMIYp9fPuE5xjdixNy9
 0FBobJaC403tw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id E1A47488E6;
 Tue, 10 Nov 2026 07:14:59 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 07:15:00 +0000
Subject: [PATCH] drm/panthor: Do not change the GPU clock rate while suspended
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261110-panthor-suspend-clk-v1-1-53457050e51e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBBG4auQWTtJhwgLr2JcQPsjo6Y0HSAmh
 LtTdPkt3tvIkBVGt2qjjFVNp1ggl4r82MUnWEMx1a5uRcRx6uI8TpltsYQY2H/eLBKa1l0HND2
 olClj0O/ven/8bUv/gp/PFe37AdSOyWx3AAAA
X-Change-ID: 20261110-panthor-suspend-clk-11d5604fe5be
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 Jonas Karlman <jonas@kwiboo.se>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794294899; l=5357;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=5go781LIcqxZXcS2fgUKEcRmZbGKWGhE55YnHaY3k5E=;
 b=sWRK/xNMMI8xbnZDMbozJG0VgEE8K+dtXH8cCcg14tTn5zwqv8mxRZjPzpKtbbHeqenDlJfM8
 gr0hTA/AC6NBSGHJyQncQxQBZNCzvdDvdueMUOmBbsYasltnVlaC1mH
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Content-Transfer-Encoding: 7bit
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
Reply-To: aiyengar1990@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Arun Iyengar <aiyengar1990@gmail.com>

From the start of panthor_device_suspend() until panthor_device_resume()
has enabled the clocks again, the GPU clocks are off or about to be, and
the GPU power domain may be down. devfreq can still call ->target() in
that window: a write to min_freq or max_freq in sysfs, a thermal cooling
state change or a PM QoS request all end up in update_devfreq() whatever
the device state.

With the RK3588 GPU core clock switched to the firmware-managed
SCMI_CLK_GPU (needed to reach the PVTPLL rates of the upper OPPs), such
a call is fatal. To set a PVTPLL rate TF-A programs registers in the GPU
GRF, which sit in the GPU power domain, and with the domain off that
access ends in an asynchronous SError and a kernel panic, for example
after

  echo 1000000000 > /sys/class/devfreq/fb000000.gpu/min_freq

while the GPU is runtime suspended.

Only apply a rate to the hardware while the device is resuming or
active, plus the suspend frequency that devfreq_suspend_device() applies
from the suspend path while the GPU is still powered. Other requests are
still accepted and recorded by devfreq, which applies them on resume or
at the next governor update.

The RFC this is based on (Jonas Karlman's panthor SCMI clock change,
carried in Armbian's linux-rockchip pull request 380) checked the
runtime PM status instead. That
status is still RPM_SUSPENDING after panthor_devfreq_suspend() has run,
which leaves a window where the rate can be raised again right before
the power domain goes down. The devfreq suspend count cannot be used
either: panthor's first runtime resume calls devfreq_resume_device()
without a matching suspend, so the count is -1 while the GPU is active
and 0 while it is suspended.

Suggested-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
Tested on an Orange Pi 5 (RK3588S) with the GPU core clock switched to
SCMI_CLK_GPU and a 200 MHz opp-suspend (the configuration from the RFC,
not yet in mainline): writing min_freq while the GPU was runtime
suspended no longer ends in an SError, the request takes effect at the
next job (1 GHz measured), max_freq likewise; 200 suspend/resume cycles
with short GPU jobs and a 3 minute sustained load ran without faults.
With the mainline device tree (CRU clock, no suspend OPP) the SError is
not reachable and the guard only skips rate changes while the GPU is
powered down.

This patch was developed with Claude (Anthropic) as a coding assistant:
it wrote the code and the commit message, and I reviewed and tested it
as described above.
---
 drivers/gpu/drm/panthor/panthor_devfreq.c | 42 ++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.c b/drivers/gpu/drm/panthor/panthor_devfreq.c
index 2249b41ca4af..cab86e9c9d46 100644
--- a/drivers/gpu/drm/panthor/panthor_devfreq.c
+++ b/drivers/gpu/drm/panthor/panthor_devfreq.c
@@ -60,20 +60,56 @@ static void panthor_devfreq_update_utilization(struct panthor_devfreq *pdevfreq)
 	pdevfreq->time_last_update = now;
 }
 
+/*
+ * Whether a new rate can be applied to the hardware now.
+ *
+ * From the start of panthor_device_suspend() until panthor_device_resume()
+ * has enabled the clocks again, the GPU clocks are about to be disabled
+ * or are off, and the GPU power domain may be down. devfreq can still
+ * call ->target() in that window: sysfs
+ * min_freq/max_freq writes, thermal cooling and PM QoS requests all end
+ * up in update_devfreq() whatever the device state.
+ *
+ * Changing the rate then is pointless, and harmful where the core clock
+ * is managed by firmware: on RK3588, setting SCMI_CLK_GPU to a PVTPLL
+ * rate with the GPU power domain off makes TF-A access the powered-down
+ * GPU GRF, which ends in an asynchronous SError. So while the device is
+ * suspending only the suspend frequency, applied by
+ * devfreq_suspend_device(), reaches the hardware, and nothing does
+ * while it is suspended. devfreq records the other requests: they are
+ * applied on resume or at the next governor update.
+ */
+static bool panthor_devfreq_can_set_rate(struct panthor_device *ptdev,
+					 unsigned long freq)
+{
+	struct devfreq *devfreq = ptdev->devfreq ? ptdev->devfreq->devfreq : NULL;
+
+	switch (atomic_read(&ptdev->pm.state)) {
+	case PANTHOR_DEVICE_PM_STATE_SUSPENDED:
+		return false;
+	case PANTHOR_DEVICE_PM_STATE_SUSPENDING:
+		return devfreq && devfreq->suspend_freq &&
+		       freq == devfreq->suspend_freq;
+	default:
+		return true;
+	}
+}
+
 static int panthor_devfreq_target(struct device *dev, unsigned long *freq,
 				  u32 flags)
 {
+	struct panthor_device *ptdev = dev_get_drvdata(dev);
 	struct dev_pm_opp *opp;
-	int err;
 
 	opp = devfreq_recommended_opp(dev, freq, flags);
 	if (IS_ERR(opp))
 		return PTR_ERR(opp);
 	dev_pm_opp_put(opp);
 
-	err = dev_pm_opp_set_rate(dev, *freq);
+	if (!panthor_devfreq_can_set_rate(ptdev, *freq))
+		return 0;
 
-	return err;
+	return dev_pm_opp_set_rate(dev, *freq);
 }
 
 static void panthor_devfreq_reset(struct panthor_devfreq *pdevfreq)

---
base-commit: 8deaade4a5a4ff635df91e246e42139ab2b33f6d
change-id: 20261110-panthor-suspend-clk-11d5604fe5be

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


