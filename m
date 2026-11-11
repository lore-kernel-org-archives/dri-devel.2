Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33199606A327
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fnq77L87
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0717010F969;
	Wed, 11 Nov 2026 08:22:49 +0000 (UTC)
Received: from mail-oo2-f8.google.com (mail-oo2-f8.google.com [74.125.231.136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB48610F88D
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 01:36:58 +0000 (UTC)
Received: by mail-oo2-f8.google.com with SMTP id
 006d021491bc7-71702e8143cso960476eaf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 17:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794361018; x=1794965818; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fmd8pZhTX1jp07WLrA39wwhl3cP5kgTKffdM12tuCUI=;
 b=fnq77L87XG6zHLVbkMmeoyS4d/jNqjc9hoxv+a4MQD4VlnqwVZrBfdvFCs7+B0pd30
 sgO5Bd29DLUT1yofXC9k7ZBuBF+Kb5xhcH87r48T3etPSCKbwwjHNQ4yjznN5/G19aqu
 /PyKGTGNISQvd/BC4zMAnc8JcreBk0+14a7+zkDY9GNmhZ7TvxiVA4T5L4cW8dCb4MWS
 4kME0gylMDz/Gb82cBP0XoTy0ZuFfsHcRdPYsVXaQTzUVKTzm2ftpYqsDvfSTphbvJgb
 oH8ugO757su3XEyqfI77/9dA7GjbrYeTa9rzBDctQ9UUcp8qmvwlvWwNSwAYY+VrBQi+
 5YEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794361018; x=1794965818;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=fmd8pZhTX1jp07WLrA39wwhl3cP5kgTKffdM12tuCUI=;
 b=SRpoFQfhGs54uDwOeo5SF+rSxvmutJ+KkoYIT9drtleIrBC0wTkGE8u8XpzqlIpnkb
 oM2ML7osQ1zMq1adBKxM8FYT9CxaSl4VlJtAFpLLBiXzHQCevxIF5x5C7H9GBHWlJfcY
 8M54sSoy2ZFheHpeAz9tsFeKq7PQ7veJUYvvcE1jpfNZKRTvMPy9zlSLie+D5wawbz40
 05pgtB/lmMkWz907QqvVytO2AGKxCRZzH285Vnp59MQUEZ/MgkwoejpDSrvODlbRbCNL
 sqKbsllXwaTMeJNdqSJ1EZTHcIuoneHHnsMFFUy8BolKTnawlgItwBcXSqagA2aLmr4r
 hrxQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGxY6B5n3NoU+dDqE9urCCsggnE70T4tKJ9PKx67ObLVpdFkkSbFBzQAWAou7V3lc6mXSLuLAGa+Jk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+/WAbcwK9BFYBgmThKjvBU+NbnxZYNHP8GPNdISn6hGulr/k+g
 zAElcS/PJLy1UhaWIH/kGx8IkKoTjV3FuVEJiBH52s2q12MIFaX69mu4
X-Gm-Gg: AYBFou27ey00RtcYINUacp9CFrEv/515Ue9X9FJ4NKNK2Sts5xaiXNJJx3BeHZjsCoQ
 ztahYArtV4281dEHeEFgu5R+RklDq8+P89uFG4+PQJUbROaNC7w1tkjGwQtNVIIr/1bChr04BFd
 nmhL6vUl6Vml+yn8BPKvaQbQwoBbfcHlONwjMgKg8MotSeq015FO1lBpuQcggrXytSH23Rb238s
 OuEUBwcRgITZVUjHfrogObOQy3IILejwX4MIcM4jNYc+g68ivWiWzwLmQi+JK93KHD9uDkuFnI3
 zPa0unQMq5uIImhiLH1t3fYCopMpZseTjSHN01Vmz3v2GsBK6NbBqOFb48X36zb1kHgNv0z19cK
 TleZ4gDC3i0vIfDkZt7EIuWxWe00Nma0YpPtZrpH1hAC27ZhKlzHzWeV4adGhnB1bulQTxne1a2
 DlWqjguhofEGjX9xWgtzFLiBDzQKzYcGuxYnP1SpuXJHabf2zfSn8iJ0Y5c3FvmOEU8b1XYxdMQ
 SoR+ZX3OPiFSMmDBU85HIqQI+E35ijhD/KobkrXm/uqzlBHTDfhzqTKIe5oz3xh1PhpqR2LqgwI
 s478WyIQ3AKwa1oG1oCxONZW
X-Received: by 2002:a05:6820:c0d4:20b0:6d7:a325:35f7 with SMTP id
 006d021491bc7-71917963ac3mr467673eaf.81.1794361017863; 
 Tue, 10 Nov 2026 17:36:57 -0800 (PST)
Received: from [192.168.18.164] ([2600:8804:5716:d800::f01a])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4ae22f6a1c7sm2462267fac.6.2026.11.10.17.36.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 17:36:57 -0800 (PST)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Tue, 10 Nov 2026 19:36:48 -0600
Subject: [PATCH] drm/imagination: Wait for the firmware's interrupts before
 stopping it
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-rbrue-suez-upstreaming-pvr-fw-irq-handshake-v1-1-8872686d14d0@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/x3NUQ6CMAwA0Kss/aZJQTSyqxg+NimsMc7ZOjQS7
 m7iu8DbwFiFDbzbQHkVk0cG79rGwTWFvDDKBN5BR92pJepRo1ZGq/zFWuylHO6SFyyr4vxG0Se
 mkCdL4cYYzzQcDxwH6iM0DoryLJ//dhn3/QeQ1M4/fQAAAA==
X-Change-ID: 20261004-rbrue-suez-upstreaming-pvr-fw-irq-handshake-b80953eb904b
To: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sarah Walker <sarah.walker@imgtec.com>
Cc: imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Ryan Brue <ryanbrue.dev@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794361016; l=6676;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=UU+/DlUPZcdKbo5wZeicD1NjDIpa69zyRxMNYLyF5Rk=;
 b=iCYmXiI6nZQFvfT/rzhvhgqrx7Fg/JKpqoCaCXsfk5SCXdvphmefsouyNfMit0Ogz6jxhqSHu
 p2CYksSC3DUA4lVjalQ41zdZMeRelKO55wgvMDWkcmWujrBtnqCk+8T
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=
X-Mailman-Approved-At: Wed, 11 Nov 2026 08:22:47 +0000
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

Once the firmware has acknowledged the POW_OFF request, a runtime suspend
disables the IRQ and stops the firmware straight away, even if the
firmware has raised an interrupt the host has not taken yet. On an
MT8173 (GX6250, META firmware), the SIDEKICK_IDLE.GARTEN poll at the end
of pvr_fw_stop() can then time out. The suspend fails with -ETIMEDOUT,
runtime PM latches the error, and every later pvr_power_get() returns
-EINVAL. The recovery reset that follows can fail the same way and lose
the device.

The firmware counts the interrupts it raises in its OS data. Sample that
count in the IRQ thread after clearing the interrupt, and before
disabling the IRQ for a runtime suspend, wait until the host has seen
every interrupt the firmware counted, as Imagination's DDK does. Clear
the host's copy when a hard reset clears the firmware's.

Fixes: 727538a4bbff ("drm/imagination: Implement power management")
Cc: stable@vger.kernel.org
Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
Found on an Amazon Fire HD 10 (2017), an MT8173 tablet that's not upstream
yet. Its GX6250 (4.40.2.51) is not on the driver's list and runs with
exp_hw_support. With a compositor running, about one desktop start in five
hit this before the patch. A debug build that logs timed-out register polls
named the poll, SIDEKICK_IDLE read 0x7a, GARTEN not idle.

Only META firmware on this one GPU was tested. Each failing suspend in the
instrumented runs was off by exactly one interrupt (for example firmware
14320, host 14319). Why the META core then can't go idle is inferred from
the DDK, which waits at this point; a fixed 1s delay in the same place
also stopped the failures here.

The hard-reset part is untested at runtime. A forced hard reset of this GPU
times out before the firmware objects are cleared, so the stale copy it
guards against can't arise here.

It reproduces within a minute with vkcube --present_mode 1 on the
compositor's display and the GPU's power/autosuspend_delay_ms set to 1.
---
This patch was developed with the help of an LLM. I know there's a Mesa
policy against LLM use for the powervr driver there, so if there's a policy
for drm/imagination too, let me know.
---
With continuous rendering and a 1 ms autosuspend delay, a suspend failed
this way within 22 seconds in 7 of 7 unpatched runs. Three of them were
instrumented: between them they made 2711 suspends, and the three that
failed were the only ones with an interrupt still outstanding after
disable_irq(). With this patch, 8 of 8 runs lasted 60 seconds without a
failure, and in a further run the wait was needed in 15 of 6925
suspends, for at most 6.1 ms.
---
 drivers/gpu/drm/imagination/pvr_device.c |  6 ++++++
 drivers/gpu/drm/imagination/pvr_device.h |  6 ++++++
 drivers/gpu/drm/imagination/pvr_fw.c     |  3 +++
 drivers/gpu/drm/imagination/pvr_power.c  | 27 +++++++++++++++++++++++++++
 4 files changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/imagination/pvr_device.c b/drivers/gpu/drm/imagination/pvr_device.c
index 992509d95d28..99a3842c2783 100644
--- a/drivers/gpu/drm/imagination/pvr_device.c
+++ b/drivers/gpu/drm/imagination/pvr_device.c
@@ -215,6 +215,12 @@ static irqreturn_t pvr_device_irq_thread_handler(int irq, void *data)
 		pvr_fw_irq_clear(pvr_dev);
 
 		if (READ_ONCE(pvr_dev->fw_dev.initialised)) {
+			struct rogue_fwif_osdata *osdata = pvr_dev->fw_dev.fwif_osdata;
+
+			for (u32 i = 0; i < MAX_THREAD_NUM; i++)
+				WRITE_ONCE(pvr_dev->fw_irq_count[i],
+					   READ_ONCE(osdata->interrupt_count[i]));
+
 			pvr_fwccb_process(pvr_dev);
 			pvr_kccb_wake_up_waiters(pvr_dev);
 			pvr_device_process_active_queues(pvr_dev);
diff --git a/drivers/gpu/drm/imagination/pvr_device.h b/drivers/gpu/drm/imagination/pvr_device.h
index c246122b4caf..91cf2bde589f 100644
--- a/drivers/gpu/drm/imagination/pvr_device.h
+++ b/drivers/gpu/drm/imagination/pvr_device.h
@@ -176,6 +176,12 @@ struct pvr_device {
 	/** @irq: IRQ number. */
 	int irq;
 
+	/**
+	 * @fw_irq_count: Firmware interrupt counts, as last sampled by the IRQ
+	 *                thread after clearing the interrupt.
+	 */
+	u32 fw_irq_count[MAX_THREAD_NUM];
+
 	/** @fwccb: Firmware CCB. */
 	struct pvr_ccb fwccb;
 
diff --git a/drivers/gpu/drm/imagination/pvr_fw.c b/drivers/gpu/drm/imagination/pvr_fw.c
index c7988278df3f..7b42a898aa00 100644
--- a/drivers/gpu/drm/imagination/pvr_fw.c
+++ b/drivers/gpu/drm/imagination/pvr_fw.c
@@ -315,6 +315,9 @@ fw_osdata_init(void *cpu_ptr, void *priv)
 	struct pvr_fw_mem *fw_mem = &pvr_dev->fw_dev.mem;
 
 	pvr_fw_object_get_fw_addr(fw_mem->power_sync_obj, &fwif_osdata->power_sync_fw_addr);
+
+	/* The firmware's interrupt counts restart from zero, and so must the host's copy. */
+	memset(pvr_dev->fw_irq_count, 0, sizeof(pvr_dev->fw_irq_count));
 }
 
 static void
diff --git a/drivers/gpu/drm/imagination/pvr_power.c b/drivers/gpu/drm/imagination/pvr_power.c
index eb4b6ecdf4f4..2d0fbcf457f6 100644
--- a/drivers/gpu/drm/imagination/pvr_power.c
+++ b/drivers/gpu/drm/imagination/pvr_power.c
@@ -89,6 +89,26 @@ pvr_power_request_pwr_off(struct pvr_device *pvr_dev)
 	return pvr_power_send_command(pvr_dev, &pow_cmd);
 }
 
+static bool
+pvr_power_fw_irqs_taken(struct pvr_device *pvr_dev, u32 thread)
+{
+	return READ_ONCE(pvr_dev->fw_dev.fwif_osdata->interrupt_count[thread]) ==
+	       READ_ONCE(pvr_dev->fw_irq_count[thread]);
+}
+
+static void
+pvr_power_wait_for_fw_irqs(struct pvr_device *pvr_dev)
+{
+	bool taken;
+
+	for (u32 i = 0; i < MAX_THREAD_NUM; i++) {
+		if (read_poll_timeout(pvr_power_fw_irqs_taken, taken, taken, 100,
+				      POWER_SYNC_TIMEOUT_US, false, pvr_dev, i))
+			drm_warn(from_pvr_device(pvr_dev),
+				 "FW thread %u has IRQs the host has not taken\n", i);
+	}
+}
+
 static int
 pvr_power_fw_disable(struct pvr_device *pvr_dev, bool hard_reset, bool rpm_suspend)
 {
@@ -107,6 +127,13 @@ pvr_power_fw_disable(struct pvr_device *pvr_dev, bool hard_reset, bool rpm_suspe
 	}
 
 	if (rpm_suspend) {
+		/*
+		 * Let the IRQ thread take every interrupt the firmware has raised
+		 * before stopping it, as the vendor driver does. Without this, the
+		 * META firmware processor can fail to go idle in pvr_fw_stop().
+		 */
+		pvr_power_wait_for_fw_irqs(pvr_dev);
+
 		/* This also waits for late processing of GPU or firmware IRQs in other cores */
 		disable_irq(pvr_dev->irq);
 	}

---
base-commit: 476d658928af91f5ccb455957be60763d8b00fd3
change-id: 20261004-rbrue-suez-upstreaming-pvr-fw-irq-handshake-b80953eb904b

Best regards,
-- 
Ryan Brue <ryanbrue.dev@gmail.com>

