Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF4560A5BC5
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 06:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=tJ6p+64D
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61E6F10E585;
	Fri, 23 Oct 2026 06:40:23 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61E1D10E5B3
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 06:40:12 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48dfb76b304so16196f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 23:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792737611; x=1793342411; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JL+6FnUEXojGRmPuV+pQ9Io/1b7HqqhVfuwu3G8N4CM=;
 b=tJ6p+64DGcEPCbPvPDBbLtk5/iX1OpTRkUzzzQ8TNXM+JEFQkEFKh2eC2nOHwJk3b8
 o+NdpR9VI/fmclpFZPhW4Y8Uckx4hhuhLZMH0Q+JGZ+gXrSFnQLMGeV9FJ3BKGkYLrCU
 agLhok2XAkvscyL/uANkjpWKS7L68H/eCyNhmdhJmapoOQfMa1bhPv9X8P6/mROTFAhx
 fVGo57MUzcMQteTZLvC2tV4cWgl+HWMsgptUJVLSvjZ/Tvaa+APGIHrBy6HjJa72PJSz
 D5ohdJccidjCp0thVAGwMSEun6TIU7i2S18QBk6youW3PrhIbTZ2i0QQxo7l6uunEXuv
 qBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792737611; x=1793342411;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JL+6FnUEXojGRmPuV+pQ9Io/1b7HqqhVfuwu3G8N4CM=;
 b=FUiJf72g5DMO52hRDb7zClM0zsRdeWoLw8ZIWLeNym63v6qSjzMvTzT7KRD3JdSQXv
 S95LQhDeHd9wAfJNcdE81O4jyYFcYSu4d3/UbCNpgMx3fh1nRAUg353C1IqQ6ceJEinD
 23INyGZiHGru7OPdxaElRjzPtOezYzRWApoVD9NhDG0iBMTym7Bi7umthu7vWNehjG03
 40sjbkR8IU1tWG3o2NRITxXBgWyCG1vYlGy7bPk+m8fm79SP5Jcso6rwxjR8dwcUPeBQ
 fFnrr92VhrlyOoRCb6MwIp5/hdRHXZIZlv3Wv7TUUWmRcgG895jws2AmbBPpzyx1U8Xb
 y+KA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxjlXB8Lxv/CGKvNoBX1AgOpNUOK5k1jxgjtpT1t7JPZoIm+O+yxoe8sjxvx9w9rM4fihz9Mm7I/jA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIvxxpON0Ibj12ytELlGkgW7h/TR5OfOOIy0Gux22/sCyXENi1J
 3SvlXTzCo/zNGPZk+xRZLW42T57qwWqzmtWJBX6U19Bv11OGMIQTE0Fr
X-Gm-Gg: AYBFou1aONgCJv1eHYi90LjxNssqQRMMRlmIK4r6YlH3Ag0N9IdAD3lsG9xrnt8EGyX
 KS6eh5JKaFthoXYk9ncSDimOh0jMY+IEcKfKAH0H6VlLF6b9F0gAM2xSmplvaxa7lWg3wAZ+sR+
 0PZfl4rJWdWipu+IIZeq/fFon13C0v2hI1OuDqNSQTmQOZqpNDANQ+iVuyPRDNLHVhEMgJmlQFP
 FjRs2BMRlGH+BTjDIF/AV01YMY8j+KrDNDQbcvj0oL3Mk+OBy1E9Tct/7JgiIK2b0m22hIeIERm
 f+ZrQbvVRtbwOZfn3zlAVnDHnRny97KRqYvzbAjFOlfLl0Qn1JICAdPV6P2G9VT/03pnPMm4NWv
 YcKnSeEYPq7ovzavnsxEiH/9L/awwqbyMReRyoy82jheZKqkHsC6IPBcPQa/qHy6V65O1x9pWCE
 cHIddcLRGn5+9ZdfWh06x3qCW0gKjA4D1lJ6HJNcK0dGexYEw0mkF/F7rhaakk+FkquA/1sMjzO
 qOqYp94I/ei6DILtog/zVuPg+fD/GZMJX4Gdkku9yp+u2ZICiDvZ+ShoyLOmjw3kcZlkP6QXgcA
 KWXoURUsnilDbAkSeeW8Q8UufgACmaLuBj9Qn0U+zp9Qpw0KBgQ0dC6sIT+bh5EbCcBSc/BqcpF
 +LM0=
X-Received: by 2002:a05:6000:41cb:b0:485:8c17:9764 with SMTP id
 ffacd0b85a97d-48e385aee25mr1691514f8f.38.1792737610377; 
 Thu, 22 Oct 2026 23:40:10 -0700 (PDT)
Received: from [192.168.1.22] (cst-prg-49-173.cust.vodafone.cz.
 [46.135.49.173]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e38030c47sm3104782f8f.21.2026.10.22.23.40.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 23:40:09 -0700 (PDT)
From: Tomeu Vizoso <tomeu.vizoso@gmail.com>
X-Google-Original-From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Fri, 23 Oct 2026 08:39:35 +0200
Subject: [PATCH v3 10/16] accel/thames: Recover from faults and timeouts
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-thames-v3-10-3ab40aa17157@tomeuvizoso.net>
References: <20261023-thames-v3-0-3ab40aa17157@tomeuvizoso.net>
In-Reply-To: <20261023-thames-v3-0-3ab40aa17157@tomeuvizoso.net>
To: Nishanth Menon <nm@ti.com>, "Andrew F. Davis" <afd@ti.com>, 
 Randolph Sapp <rs@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>, 
 Andrei Aldea <a-aldea@ti.com>, Chirag Shilwant <c-shilwant@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Beleswar Padhi <b-padhi@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Oded Gabbay <ogabbay@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Robert Nelson <robertcnelson@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Markus Elfring <Markus.Elfring@web.de>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, Suman Anna <s-anna@ti.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-doc@vger.kernel.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, Tomeu Vizoso <tomeu@tomeuvizoso.net>, 
 linux-remoteproc@vger.kernel.org, linux-hardening@vger.kernel.org
X-Mailer: b4 0.15.2
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A Kernel that faults, or runs past the 500 ms device timeout the kernel
writes in every Ring entry, ends in its own fault record, which the
firmware fills and userspace reads through the existing query IOCTL; the
Context continues.

The host's timeout, 2000 ms, is longer than the device's: a Job still on
the Ring when it fires is on a core that stalled. The kernel moves the
Ring's head past the failed Job, stops and starts the core through
remoteproc, reads the handshake again and pushes the Ring's other Jobs
again on their same fences, so a Kernel may run twice; the uAPI says so.
A core someone else stops through remoteproc goes offline, and a
remoteproc subdevice attaches to it again when remoteproc starts it.

A Context with 3 faults among its last 10 Jobs is banned: its Jobs not
yet run are cancelled with -ECANCELED and its later submits refused.
The thresholds let a client survive a stray fault and stop one that
faults repeatedly, each fault costing the core a fault path and, on a
timeout, a reset.

Assisted-by: LLM
Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
---
 drivers/accel/thames/thames_core.c   | 191 ++++++++++++++-
 drivers/accel/thames/thames_core.h   |  19 ++
 drivers/accel/thames/thames_device.h |   2 +
 drivers/accel/thames/thames_drv.c    |  33 +++
 drivers/accel/thames/thames_drv.h    |   5 +
 drivers/accel/thames/thames_job.c    | 452 ++++++++++++++++++++++++++++++++++-
 drivers/accel/thames/thames_job.h    |   8 +
 include/uapi/drm/thames_accel.h      |  98 ++++++++
 8 files changed, 806 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/thames/thames_core.c b/drivers/accel/thames/thames_core.c
index 85e8f48aec60..2a50fb62fe1e 100644
--- a/drivers/accel/thames/thames_core.c
+++ b/drivers/accel/thames/thames_core.c
@@ -30,6 +30,8 @@
 
 #define THAMES_RESTART_TIMEOUT_MS	5000
 
+#define THAMES_IDLE_TIMEOUT_MS		2000
+
 /*
  * The IPC memory is the core's first memory-region, which remoteproc allocates
  * from only for virtio rings and carveouts this firmware does not have.
@@ -383,6 +385,38 @@ static void thames_core_free_doorbell(struct thames_core *core)
 	put_device(&core->mbox_dev);
 }
 
+/* With every core offline all stay ready, so an entity keeps a run queue. */
+static void thames_core_update_sched_ready(struct thames_device *tdev)
+{
+	bool any_online = false;
+	unsigned int i;
+
+	guard(mutex)(&tdev->sched_lock);
+
+	for (i = 0; i < tdev->num_cores; i++)
+		any_online |= !thames_core_is_dead(&tdev->cores[i]);
+
+	for (i = 0; i < tdev->num_cores; i++)
+		tdev->cores[i].sched.ready = !any_online ||
+					     !thames_core_is_dead(&tdev->cores[i]);
+}
+
+bool thames_core_test_and_set_offline(struct thames_core *core)
+{
+	bool was_online = !atomic_xchg(&core->dead, 1);
+
+	thames_core_update_sched_ready(core->tdev);
+
+	return was_online;
+}
+
+void thames_core_set_online(struct thames_core *core)
+{
+	atomic_set(&core->dead, 0);
+
+	thames_core_update_sched_ready(core->tdev);
+}
+
 static int thames_core_rproc_boot(struct thames_core *core)
 {
 	int err;
@@ -405,6 +439,91 @@ static int thames_core_rproc_shutdown(struct thames_core *core)
 	return err;
 }
 
+static bool thames_core_rproc_is_ours(struct thames_core *core)
+{
+	return READ_ONCE(core->rproc_caller) == current;
+}
+
+/* The stop cannot be refused from here; the core is taken offline before it. */
+static void thames_core_subdev_stop(struct rproc_subdev *subdev, bool crashed)
+{
+	struct thames_core *core = container_of(subdev, struct thames_core, subdev);
+	bool idle;
+
+	if (thames_core_rproc_is_ours(core))
+		return;
+
+	if (thames_core_test_and_set_offline(core))
+		dev_warn(core->dev, THAMES_CORE_FMT
+			 " is stopped through remoteproc; it is offline until remoteproc starts it again\n",
+			 THAMES_CORE_ARG(core));
+
+	/* Its fence lock may be held by a thread that never returns. */
+	if (core->completion_stuck)
+		return;
+
+	if (!crashed &&
+	    read_poll_timeout(thames_core_idles, idle, idle, USEC_PER_MSEC,
+			      THAMES_IDLE_TIMEOUT_MS * USEC_PER_MSEC, false, core))
+		dev_crit(core->dev, THAMES_CORE_FMT " is not known to idle; remoteproc stops it all the same\n",
+			 THAMES_CORE_ARG(core));
+
+	thames_job_complete(core);
+	thames_job_fail_submitted(core);
+}
+
+static int thames_core_subdev_start(struct rproc_subdev *subdev)
+{
+	struct thames_core *core = container_of(subdev, struct thames_core, subdev);
+	struct thames_caps caps = {};
+	u32 head, tail;
+	int err;
+
+	if (thames_core_rproc_is_ours(core))
+		return 0;
+
+	if (core->completion_stuck) {
+		dev_crit(core->dev, THAMES_CORE_FMT
+			 " stays offline: a completion of its never finished, a reboot is needed to use it again\n",
+			 THAMES_CORE_ARG(core));
+		return 0;
+	}
+
+	err = thames_core_wait_handshake(core);
+	if (!err)
+		err = thames_core_read_handshake(core, &caps);
+	if (!err) {
+		head = READ_ONCE(core->ipc->ring.head);
+		tail = READ_ONCE(core->ipc->ring.tail);
+		if (head != tail) {
+			dev_err(core->dev, "Ring on " THAMES_CORE_FMT
+				" is not empty after its boot (tail %u, head %u)\n",
+				THAMES_CORE_ARG(core), tail, head);
+			err = -EIO;
+		}
+	}
+	if (err) {
+		dev_crit(core->dev, THAMES_CORE_FMT
+			 " started through remoteproc did not attach (%d); it stays offline, left running\n",
+			 THAMES_CORE_ARG(core), err);
+		return 0;
+	}
+
+	core->ring_tail = head;
+	thames_context_rewrite_entries(core);
+	thames_transfers_rewrite(core);
+	thames_job_release_held(core);
+
+	core->suspended = false;
+	core->unfinished_seqno = 0;
+	thames_core_set_online(core);
+
+	dev_info(core->dev, THAMES_CORE_FMT " started through remoteproc; it is online again\n",
+		 THAMES_CORE_ARG(core));
+
+	return 0;
+}
+
 /*
  * The firmware drives these timers with no power request and the device tree
  * reserves them for it, so the driver holds their power domains on.
@@ -546,6 +665,15 @@ int thames_core_init(struct thames_core *core)
 	if (!core->tdev->num_cores)
 		core->tdev->caps = caps;
 
+	/*
+	 * Under the rproc lock: unlike rpmsg's, this subdevice joins an rproc
+	 * already registered and maybe running.
+	 */
+	core->subdev.start = thames_core_subdev_start;
+	core->subdev.stop = thames_core_subdev_stop;
+	scoped_guard(mutex, &rproc->lock)
+		rproc_add_subdev(rproc, &core->subdev);
+
 	return 0;
 
 err_doorbell:
@@ -564,6 +692,10 @@ int thames_core_init(struct thames_core *core)
 
 void thames_core_fini(struct thames_core *core)
 {
+	scoped_guard(mutex, &core->rproc->lock)
+		rproc_remove_subdev(core->rproc, &core->subdev);
+
+	thames_job_drain(core);
 	if (core->mbox_chan)
 		thames_core_free_doorbell(core);
 	thames_job_fini(core);
@@ -595,6 +727,53 @@ bool thames_core_idles(struct thames_core *core)
 	return READ_ONCE(record->kind) == DRM_THAMES_FAULT_FIRMWARE;
 }
 
+/* Runs on reset_wq, the ordered queue the timeout handler runs on. */
+int thames_core_reset(struct thames_core *core)
+{
+	struct thames_caps caps = {};
+	struct rproc *rproc = core->rproc;
+	bool idle;
+	int err;
+
+	err = read_poll_timeout(thames_core_idles, idle, idle, USEC_PER_MSEC,
+				THAMES_IDLE_TIMEOUT_MS * USEC_PER_MSEC, false, core);
+	if (err) {
+		dev_crit(core->dev, THAMES_CORE_FMT " is not known to idle; not stopping it\n",
+			 THAMES_CORE_ARG(core));
+		return -EBUSY;
+	}
+
+	dev_warn(core->dev, "Resetting " THAMES_CORE_FMT "\n", THAMES_CORE_ARG(core));
+
+	/*
+	 * So the restarted firmware does not run the entries left on the Ring
+	 * again.
+	 */
+	WRITE_ONCE(core->ipc->ring.head, core->ring_tail);
+	/* Order the head before the stop. */
+	wmb();
+
+	err = thames_core_rproc_shutdown(core);
+	if (!err && rproc->state != RPROC_OFFLINE) {
+		dev_err(core->dev, THAMES_CORE_FMT " is kept running by another power count; not resetting it\n",
+			THAMES_CORE_ARG(core));
+		thames_core_rproc_boot(core);
+		return -EBUSY;
+	}
+	if (err)
+		return err;
+
+	err = thames_core_rproc_boot(core);
+	if (err)
+		return err;
+
+	err = thames_core_wait_handshake(core);
+	if (err)
+		return err;
+
+	return thames_core_read_handshake(core, &caps);
+}
+
 /*
  * rproc_shutdown() reaches the system firmware because the core has one power
  * count, remoteproc's auto-boot or this driver's boot: the probe defers while
@@ -612,6 +791,12 @@ int thames_core_suspend(struct thames_core *core)
 	if (core->suspended)
 		return 0;
 
+	if (thames_core_is_dead(core)) {
+		dev_warn(core->dev, THAMES_CORE_FMT " is offline; leaving it as it is across the suspend\n",
+			 THAMES_CORE_ARG(core));
+		return 0;
+	}
+
 	err = thames_core_rproc_shutdown(core);
 	if (!err && rproc->state != RPROC_OFFLINE) {
 		dev_err(core->dev, THAMES_CORE_FMT
@@ -639,7 +824,7 @@ int thames_core_resume(struct thames_core *core)
 	u32 head, tail;
 	int err = 0;
 
-	if (!core->suspended)
+	if (!core->suspended || thames_core_is_dead(core))
 		goto restart;
 
 	err = thames_core_rproc_boot(core);
@@ -672,6 +857,10 @@ int thames_core_resume(struct thames_core *core)
 	goto restart;
 
 offline:
+	thames_core_test_and_set_offline(core);
+	dev_crit(core->dev, THAMES_CORE_FMT
+		 " did not come back from the suspend (%d); it is offline until it is stopped and started again through remoteproc\n",
+		 THAMES_CORE_ARG(core), err);
 restart:
 	thames_job_resume(core);
 	return err;
diff --git a/drivers/accel/thames/thames_core.h b/drivers/accel/thames/thames_core.h
index a78414d18ad3..aa607d22064c 100644
--- a/drivers/accel/thames/thames_core.h
+++ b/drivers/accel/thames/thames_core.h
@@ -52,12 +52,23 @@ struct thames_core {
 
 	spinlock_t fence_lock;
 
+	/* Cleared only when remoteproc boots the core again. */
+	atomic_t dead;
+
 	/*
 	 * @rproc_caller is the task inside the driver's own rproc_boot() or
 	 * rproc_shutdown(), whose subdevice callbacks then do nothing.
 	 */
+	struct rproc_subdev subdev;
 	struct task_struct *rproc_caller;
 
+	/*
+	 * @completion_stuck: the same Job found unfinished at two timeouts in a
+	 * row.
+	 */
+	u64 unfinished_seqno;
+	bool completion_stuck;
+
 	struct drm_gpu_scheduler sched;
 	u64 fence_context;
 	u64 emit_seqno;
@@ -92,8 +103,16 @@ static inline const struct resource *thames_core_window(const struct thames_core
 #define THAMES_CORE_FMT "%s"
 #define THAMES_CORE_ARG(core) ((core)->name)
 
+static inline bool thames_core_is_dead(struct thames_core *core)
+{
+	return atomic_read(&core->dead);
+}
+
+bool thames_core_test_and_set_offline(struct thames_core *core);
+void thames_core_set_online(struct thames_core *core);
 int thames_core_init(struct thames_core *core);
 void thames_core_fini(struct thames_core *core);
+int thames_core_reset(struct thames_core *core);
 bool thames_core_idles(struct thames_core *core);
 int thames_core_suspend(struct thames_core *core);
 int thames_core_resume(struct thames_core *core);
diff --git a/drivers/accel/thames/thames_device.h b/drivers/accel/thames/thames_device.h
index 0a34764885df..f87c78a5f512 100644
--- a/drivers/accel/thames/thames_device.h
+++ b/drivers/accel/thames/thames_device.h
@@ -46,6 +46,8 @@ struct thames_device {
 
 	struct ida ctx_ida;
 
+	struct workqueue_struct *reset_wq;
+
 	/*
 	 * Seeded from the boot clock at load, so no serial repeats an earlier
 	 * load's.
diff --git a/drivers/accel/thames/thames_drv.c b/drivers/accel/thames/thames_drv.c
index fc3328834162..5f704cbfe1d0 100644
--- a/drivers/accel/thames/thames_drv.c
+++ b/drivers/accel/thames/thames_drv.c
@@ -52,6 +52,7 @@ static int thames_open(struct drm_device *dev, struct drm_file *file)
 	thames_priv->tdev = tdev;
 	kref_init(&thames_priv->refcount);
 	mutex_init(&thames_priv->mm_lock);
+	spin_lock_init(&thames_priv->fault_lock);
 
 	file->driver_priv = thames_priv;
 
@@ -163,6 +164,25 @@ static int thames_query_copy_out(struct drm_thames_dev_query *args, const void *
 	return 0;
 }
 
+static int thames_query_job_fault(struct thames_file_priv *file_priv,
+				  struct drm_thames_dev_query *args)
+{
+	struct drm_thames_job_fault fault = {};
+	int ret;
+
+	if (args->size < offsetofend(struct drm_thames_job_fault, job))
+		return -EINVAL;
+
+	if (get_user(fault.job, (u32 __user *)u64_to_user_ptr(args->pointer)))
+		return -EFAULT;
+
+	ret = thames_job_query_fault(file_priv, &fault);
+	if (ret)
+		return ret;
+
+	return thames_query_copy_out(args, &fault, sizeof(fault));
+}
+
 static int thames_query_caps(struct drm_device *dev, struct drm_thames_dev_query *args)
 {
 	struct thames_device *tdev = to_thames_device(dev);
@@ -190,6 +210,7 @@ static int thames_query_caps(struct drm_device *dev, struct drm_thames_dev_query
 
 static int thames_ioctl_dev_query(struct drm_device *dev, void *data, struct drm_file *file)
 {
+	struct thames_file_priv *file_priv = file->driver_priv;
 	struct drm_thames_dev_query *args = data;
 
 	switch (args->type) {
@@ -199,6 +220,12 @@ static int thames_ioctl_dev_query(struct drm_device *dev, void *data, struct drm
 			return 0;
 		}
 		return thames_query_caps(dev, args);
+	case DRM_THAMES_DEV_QUERY_JOB_FAULT:
+		if (!args->pointer) {
+			args->size = sizeof(struct drm_thames_job_fault);
+			return 0;
+		}
+		return thames_query_job_fault(file_priv, args);
 	default:
 		return -EINVAL;
 	}
@@ -333,12 +360,18 @@ static struct thames_device *thames_device_init(struct platform_device *pdev,
 	atomic64_set(&tdev->last_context_serial, seed);
 	atomic64_set(&tdev->mapping_generation, seed);
 
+	tdev->reset_wq = alloc_ordered_workqueue("thames-reset", 0);
+	if (!tdev->reset_wq)
+		return ERR_PTR(-ENOMEM);
+
 	return tdev;
 }
 
 static void thames_device_fini(struct thames_device *tdev)
 {
 	WARN_ON(tdev->num_cores > 0);
+
+	destroy_workqueue(tdev->reset_wq);
 }
 
 static int thames_platform_probe(struct platform_device *pdev)
diff --git a/drivers/accel/thames/thames_drv.h b/drivers/accel/thames/thames_drv.h
index 2115f7eae589..65e5c900313d 100644
--- a/drivers/accel/thames/thames_drv.h
+++ b/drivers/accel/thames/thames_drv.h
@@ -53,6 +53,11 @@ struct thames_file_priv {
 
 	struct drm_gem_dma_object *user_stack;
 	struct drm_gem_dma_object *save_area;
+
+	/* Bit 0 is the newest completed Job, set when it faulted. */
+	spinlock_t fault_lock;
+	u16 fault_history;
+	bool banned;
 };
 
 void thames_file_priv_put(struct thames_file_priv *priv);
diff --git a/drivers/accel/thames/thames_job.c b/drivers/accel/thames/thames_job.c
index 6560106d47a8..1f1a00eb8c63 100644
--- a/drivers/accel/thames/thames_job.c
+++ b/drivers/accel/thames/thames_job.c
@@ -9,7 +9,9 @@
 #include <linux/dma-fence-chain.h>
 #include <linux/iopoll.h>
 #include <linux/mailbox_client.h>
+#include <linux/math64.h>
 #include <linux/platform_device.h>
+#include <linux/time64.h>
 #include <linux/xarray.h>
 
 #include <drm/drm_drv.h>
@@ -45,6 +47,8 @@ static void thames_job_put(struct thames_job *job);
  * it fires is on a stalled core.
  */
 #define THAMES_DEVICE_TIMEOUT_MS 500
+#define THAMES_HOST_TIMEOUT_MS 2000
+static_assert(THAMES_HOST_TIMEOUT_MS > THAMES_DEVICE_TIMEOUT_MS);
 
 struct thames_submit_bos {
 	struct kref refcount;
@@ -72,6 +76,24 @@ static void thames_submit_bos_put(struct thames_submit_bos *bos)
 		kref_put(&bos->refcount, thames_submit_bos_free);
 }
 
+#define THAMES_BAN_FAULTS 3
+#define THAMES_BAN_SPAN 10
+static_assert(THAMES_BAN_SPAN <= 16);
+
+static_assert(THAMES_FAULT_KIND_KERNEL == DRM_THAMES_FAULT_KERNEL);
+static_assert(THAMES_FAULT_KIND_FIRMWARE == DRM_THAMES_FAULT_FIRMWARE);
+static_assert(THAMES_FAULT_KIND_TIMEOUT == DRM_THAMES_FAULT_TIMEOUT);
+static_assert(THAMES_FAULT_REG_IERR == DRM_THAMES_REG_IERR);
+static_assert(THAMES_FAULT_REG_IEAR == DRM_THAMES_REG_IEAR);
+static_assert(THAMES_FAULT_REG_IESR == DRM_THAMES_REG_IESR);
+static_assert(THAMES_FAULT_REG_NRP == DRM_THAMES_REG_NRP);
+static_assert(THAMES_FAULT_REG_NTSR == DRM_THAMES_REG_NTSR);
+static_assert(THAMES_FAULT_REG_SE0_FAR == DRM_THAMES_REG_SE0_FAR);
+static_assert(THAMES_FAULT_REG_SE0_FSR == DRM_THAMES_REG_SE0_FSR);
+static_assert(THAMES_FAULT_REG_SE1_FAR == DRM_THAMES_REG_SE1_FAR);
+static_assert(THAMES_FAULT_REG_SE1_FSR == DRM_THAMES_REG_SE1_FSR);
+static_assert(THAMES_FAULT_REGISTERS == DRM_THAMES_FAULT_REGISTERS);
+
 static const char *thames_fence_get_driver_name(struct dma_fence *fence)
 {
 	return "thames";
@@ -146,11 +168,96 @@ static int thames_job_hw_submit(struct thames_core *core, struct thames_sched_jo
 	return 0;
 }
 
+/*
+ * Copied once: the record is the Job's only if its seqno matches, since a later
+ * Job's slot keeps an earlier record.
+ */
+static bool thames_job_read_fault(struct thames_core *core, struct thames_sched_job *job,
+				  struct thames_fault_record *record)
+{
+	memcpy(record, &core->ipc->fault_records[job->ring_index], sizeof(*record));
+
+	if (record->seqno != job->seqno)
+		return false;
+
+	if (record->kind < DRM_THAMES_FAULT_KERNEL || record->kind > DRM_THAMES_FAULT_TIMEOUT) {
+		dev_warn_ratelimited(core->dev,
+				     "Job seqno %llu: fault record of unknown kind %u refused\n",
+				     job->seqno, record->kind);
+		return false;
+	}
+
+	return true;
+}
+
+/*
+ * The firmware faulted with its Ring empty: it writes the record at its head's
+ * slot under that slot's stale seqno and takes no doorbell after.
+ */
+static bool thames_job_read_empty_ring_fault(struct thames_core *core, struct thames_sched_job *job,
+					     struct thames_fault_record *record)
+{
+	u32 head = READ_ONCE(core->ipc->ring.head);
+
+	if (head % THAMES_RING_DEPTH != job->ring_index)
+		return false;
+
+	/* Read the fault record after the head that says it is there. */
+	rmb();
+	memcpy(record, &core->ipc->fault_records[job->ring_index], sizeof(*record));
+
+	return record->kind == DRM_THAMES_FAULT_FIRMWARE;
+}
+
+static void thames_job_set_fault(struct thames_sched_job *sched_job,
+				 const struct thames_fault_record *record)
+{
+	struct thames_job *job = sched_job->job;
+
+	guard(mutex)(&job->lock);
+
+	job->fault_kind = record->kind;
+	memcpy(job->fault_registers, record->registers, sizeof(job->fault_registers));
+	job->fault_valid = true;
+}
+
+static void thames_context_count_job(struct thames_core *core, struct thames_sched_job *job,
+				     bool faulted)
+{
+	struct thames_file_priv *priv = job->file_priv;
+	bool ban = false;
+	u16 history;
+
+	scoped_guard(spinlock, &priv->fault_lock) {
+		history = (priv->fault_history << 1) | faulted;
+		history &= GENMASK(THAMES_BAN_SPAN - 1, 0);
+		priv->fault_history = history;
+
+		if (!priv->banned && hweight16(history) >= THAMES_BAN_FAULTS) {
+			WRITE_ONCE(priv->banned, true);
+			ban = true;
+		}
+	}
+
+	if (ban)
+		dev_warn(core->dev,
+			 "Context %u banned: %u of its last %u Jobs faulted (Job seqno %llu)\n",
+			 priv->context_id, hweight16(history), THAMES_BAN_SPAN, job->seqno);
+}
+
+static bool thames_context_banned(struct thames_file_priv *priv)
+{
+	return READ_ONCE(priv->banned);
+}
+
 void thames_job_complete(struct thames_core *core)
 {
 	struct thames_sched_job *job, *tmp;
+	struct thames_fault_record record;
 	LIST_HEAD(done);
+	u32 hz = core->tdev->caps.timestamp_hz;
 	u64 completed, signalled;
+	bool faulted, firmware_fault = false;
 
 	completed = READ_ONCE(core->ipc->fence.seqno);
 	/* Read the entries after the Fence that covers them. */
@@ -173,16 +280,52 @@ void thames_job_complete(struct thames_core *core)
 		job->stamps[4] = fw->kernel_entry_stamp;
 		job->stamps[5] = fw->kernel_exit_stamp;
 
+		faulted = false;
 		if (fw->fence_value == THAMES_FENCE_ERROR) {
+			if (thames_job_read_fault(core, job, &record)) {
+				thames_job_set_fault(job, &record);
+				faulted = record.kind == DRM_THAMES_FAULT_KERNEL ||
+					  record.kind == DRM_THAMES_FAULT_TIMEOUT;
+			}
+			if (faulted && record.kind == DRM_THAMES_FAULT_TIMEOUT)
+				dev_warn_ratelimited(core->dev,
+						     "Job seqno %llu of Context %u: its Kernel ran past the device's timeout (entry to exit %llu us)\n",
+						     job->seqno, job->file_priv->context_id,
+						     mul_u64_u32_div(job->stamps[3] -
+								     job->stamps[2],
+								     USEC_PER_SEC, hz));
+			else if (faulted)
+				dev_warn_ratelimited(core->dev,
+						     "Job seqno %llu of Context %u: its Kernel faulted\n",
+						     job->seqno, job->file_priv->context_id);
+			else
+				dev_warn_ratelimited(core->dev,
+						     "Job seqno %llu: firmware could not honour the entry\n",
+						     job->seqno);
 			dma_fence_set_error(job->done_fence, -EIO);
 		}
 
+		thames_context_count_job(core, job, faulted);
+
 		list_del_init(&job->node);
 		signalled = arch_timer_read_counter();
 		dma_fence_signal(job->done_fence);
 		trace_thames_job_done(core, job, signalled);
 		thames_sched_job_put(job);
 	}
+
+	/*
+	 * The firmware's own fault moves neither the Fence nor the head: it
+	 * rings the doorbell and parks in IDLE.
+	 */
+	scoped_guard(mutex, &core->job_lock) {
+		job = list_first_entry_or_null(&core->submitted, struct thames_sched_job, node);
+		if (job && !thames_core_is_dead(core) && thames_job_read_fault(core, job, &record))
+			firmware_fault = record.kind == DRM_THAMES_FAULT_FIRMWARE;
+	}
+
+	if (firmware_fault)
+		drm_sched_fault(&core->sched);
 }
 
 static int thames_acquire_object_fences(struct drm_gem_object **bos, int bo_count,
@@ -215,6 +358,12 @@ static void thames_attach_object_fences(struct drm_gem_object **bos, int bo_coun
 /* Nothing here fails, so a submit call pushes every Job or none. */
 static void thames_job_push(struct thames_sched_job *sched_job)
 {
+	struct thames_job *job = sched_job->job;
+
+	/* Before the push, so the submission's own record cannot be lost. */
+	scoped_guard(mutex, &job->lock)
+		job->fault_valid = false;
+
 	scoped_guard(mutex, &sched_job->tdev->sched_lock) {
 		drm_sched_job_arm(&sched_job->base);
 
@@ -270,6 +419,12 @@ static struct dma_fence *thames_job_run(struct drm_sched_job *sched_job)
 	if (unlikely(job->base.s_fence->finished.error))
 		return NULL;
 
+	if (thames_core_is_dead(core))
+		return ERR_PTR(-ENODEV);
+
+	if (thames_context_banned(job->file_priv))
+		return ERR_PTR(-ECANCELED);
+
 	/* The done fence keeps the seqno of the Job's first push. */
 	job->seqno = ++core->emit_seqno;
 	if (!dma_fence_was_initialized(job->done_fence))
@@ -285,6 +440,223 @@ static struct dma_fence *thames_job_run(struct drm_sched_job *sched_job)
 	return dma_fence_get(job->done_fence);
 }
 
+void thames_job_release_held(struct thames_core *core)
+{
+	struct thames_sched_job *job, *tmp;
+	LIST_HEAD(held);
+
+	scoped_guard(mutex, &core->job_lock)
+		list_splice_init(&core->held, &held);
+
+	list_for_each_entry_safe(job, tmp, &held, node) {
+		list_del_init(&job->node);
+		thames_sched_job_put(job);
+	}
+}
+
+/*
+ * Held, not freed: the system firmware may refuse the stop and the core run on.
+ */
+void thames_job_fail_submitted(struct thames_core *core)
+{
+	struct thames_sched_job *job;
+	LIST_HEAD(lost);
+
+	scoped_guard(mutex, &core->job_lock)
+		list_splice_init(&core->submitted, &lost);
+
+	list_for_each_entry(job, &lost, node)
+		thames_job_fail_done_fence(job, -ENODEV);
+
+	scoped_guard(mutex, &core->job_lock)
+		list_splice_tail_init(&lost, &core->held);
+}
+
+static void thames_job_recover(struct thames_core *core, struct drm_sched_job *sched_job,
+			       struct thames_sched_job *bad,
+			       const struct thames_fault_record *record)
+{
+	struct drm_gpu_scheduler *sched = &core->sched;
+	struct thames_sched_job *job;
+	struct drm_sched_job *s_job;
+	unsigned int resubmitted = 0;
+	LIST_HEAD(lost);
+	int err;
+
+	drm_sched_wqueue_stop(sched);
+
+	/* Failed before drm_sched_stop(), so the stop finds it complete. */
+	if (bad) {
+		scoped_guard(mutex, &core->job_lock)
+			list_del_init(&bad->node);
+
+		dev_warn(core->dev, "Job seqno %llu of Context %u: the firmware faulted\n",
+			 bad->seqno, bad->file_priv->context_id);
+		thames_job_set_fault(bad, record);
+		thames_context_count_job(core, bad, true);
+		dma_fence_set_error(bad->done_fence, -EIO);
+		dma_fence_signal(bad->done_fence);
+		thames_sched_job_put(bad);
+	} else {
+		dev_warn(core->dev, THAMES_CORE_FMT
+			 ": the firmware faulted with its Ring empty (IERR 0x%llx, NRP 0x%llx)\n",
+			 THAMES_CORE_ARG(core), record->registers[THAMES_FAULT_REG_IERR],
+			 record->registers[THAMES_FAULT_REG_NRP]);
+	}
+
+	drm_sched_stop(sched, sched_job);
+
+	scoped_guard(mutex, &core->job_lock)
+		list_splice_init(&core->submitted, &lost);
+
+	/*
+	 * Kept until the reset has stopped the core, which may still run one of
+	 * their Kernels.
+	 */
+	err = thames_core_reset(core);
+	if (err) {
+		thames_core_test_and_set_offline(core);
+		dev_crit(core->dev, THAMES_CORE_FMT
+			 " could not be reset (%d); it is offline until it is stopped and started again through remoteproc\n",
+			 THAMES_CORE_ARG(core), err);
+
+		list_for_each_entry(job, &lost, node)
+			thames_job_fail_done_fence(job, -ENODEV);
+
+		scoped_guard(mutex, &core->job_lock)
+			list_splice_tail_init(&lost, &core->held);
+
+		drm_sched_start(sched, -ENODEV);
+		return;
+	}
+
+	scoped_guard(mutex, &core->job_lock)
+		list_splice_tail_init(&lost, &core->held);
+
+	thames_job_release_held(core);
+
+	drm_sched_for_each_pending_job(s_job, sched, NULL) {
+		struct dma_fence *fence = thames_job_run(s_job);
+
+		if (IS_ERR_OR_NULL(fence)) {
+			thames_job_fail_done_fence(to_thames_sched_job(s_job),
+						   fence ? PTR_ERR(fence) : -ECANCELED);
+			continue;
+		}
+
+		s_job->s_fence->parent = fence;
+		resubmitted++;
+	}
+
+	dev_info(core->dev, THAMES_CORE_FMT " restarted, %u Jobs resubmitted\n",
+		 THAMES_CORE_ARG(core), resubmitted);
+
+	drm_sched_start(sched, 0);
+}
+
+/*
+ * Only job_lock: the core's fence lock may be held by a completion thread that
+ * died.
+ */
+static bool thames_job_in_completion(struct thames_core *core, struct thames_sched_job *job)
+{
+	struct thames_sched_job *pending;
+
+	if (dma_fence_is_signaled(&job->base.s_fence->finished))
+		return false;
+
+	guard(mutex)(&core->job_lock);
+	list_for_each_entry(pending, &core->submitted, node) {
+		if (pending == job)
+			return false;
+	}
+
+	return true;
+}
+
+static enum drm_gpu_sched_stat thames_job_timedout(struct drm_sched_job *sched_job)
+{
+	struct thames_sched_job *job = to_thames_sched_job(sched_job);
+	struct thames_sched_job *pending, *oldest = NULL;
+	struct thames_core *core = container_of(sched_job->sched, struct thames_core, sched);
+	struct thames_fault_record record;
+	LIST_HEAD(dead_jobs);
+	bool found = false;
+
+	if (core->completion_stuck)
+		return DRM_GPU_SCHED_STAT_ENODEV;
+
+	if (thames_job_in_completion(core, job)) {
+		if (core->unfinished_seqno != job->seqno) {
+			core->unfinished_seqno = job->seqno;
+			return DRM_GPU_SCHED_STAT_NO_HANG;
+		}
+
+		core->completion_stuck = true;
+		thames_core_test_and_set_offline(core);
+		dev_crit(core->dev, "Job seqno %llu on " THAMES_CORE_FMT
+			 ": its completion never finished; taking the core offline, a reboot is needed to use it again\n",
+			 job->seqno, THAMES_CORE_ARG(core));
+		return DRM_GPU_SCHED_STAT_ENODEV;
+	}
+
+	thames_job_complete(core);
+
+	scoped_guard(mutex, &core->job_lock) {
+		oldest = list_first_entry_or_null(&core->submitted, struct thames_sched_job, node);
+		list_for_each_entry(pending, &core->submitted, node) {
+			if (pending == job) {
+				found = true;
+				break;
+			}
+		}
+	}
+
+	if (!found)
+		return DRM_GPU_SCHED_STAT_NO_HANG;
+
+	/*
+	 * Any other timeout is a core that may still run: it is taken offline,
+	 * never stopped.
+	 */
+	if (!thames_core_is_dead(core) && thames_job_read_fault(core, oldest, &record) &&
+	    record.kind == DRM_THAMES_FAULT_FIRMWARE) {
+		thames_job_recover(core, sched_job, oldest, &record);
+		return DRM_GPU_SCHED_STAT_RESET;
+	}
+
+	if (!thames_core_is_dead(core) && thames_job_read_empty_ring_fault(core, oldest, &record)) {
+		thames_job_recover(core, sched_job, NULL, &record);
+		return DRM_GPU_SCHED_STAT_RESET;
+	}
+
+	if (thames_core_test_and_set_offline(core))
+		dev_crit(core->dev, "Job seqno %llu timed out on " THAMES_CORE_FMT
+			 "; taking the core offline until it is stopped and started again through remoteproc\n",
+			 job->seqno, THAMES_CORE_ARG(core));
+
+	drm_sched_stop(&core->sched, sched_job);
+
+	/*
+	 * The core may still run their Kernels: it keeps the push's reference,
+	 * and with it the Context and the buffers.
+	 */
+	scoped_guard(mutex, &core->job_lock)
+		list_splice_init(&core->submitted, &dead_jobs);
+
+	list_for_each_entry(pending, &dead_jobs, node) {
+		dma_fence_set_error(pending->done_fence, -ENODEV);
+		dma_fence_signal(pending->done_fence);
+	}
+
+	scoped_guard(mutex, &core->job_lock)
+		list_splice_tail_init(&dead_jobs, &core->held);
+
+	drm_sched_start(&core->sched, -ENODEV);
+
+	return DRM_GPU_SCHED_STAT_RESET;
+}
+
 /*
  * A done fence not signalled here is a Job on a live core's Ring that may still
  * run.
@@ -305,6 +677,7 @@ static void thames_job_cancel(struct drm_sched_job *sched_job)
 
 static const struct drm_sched_backend_ops thames_sched_ops = {
 	.run_job = thames_job_run,
+	.timedout_job = thames_job_timedout,
 	.free_job = thames_sched_job_free,
 	.cancel_job = thames_job_cancel,
 };
@@ -316,7 +689,8 @@ int thames_job_init(struct thames_core *core)
 		.ops = &thames_sched_ops,
 		.num_rqs = 1,
 		.credit_limit = THAMES_RING_DEPTH,
-		.timeout = MAX_SCHEDULE_TIMEOUT,
+		.timeout = msecs_to_jiffies(THAMES_HOST_TIMEOUT_MS),
+		.timeout_wq = core->tdev->reset_wq,
 		.name = dev_name(core->dev),
 		.dev = core->dev,
 	};
@@ -326,6 +700,9 @@ int thames_job_init(struct thames_core *core)
 
 	spin_lock_init(&core->fence_lock);
 	mutex_init(&core->job_lock);
+	atomic_set(&core->dead, 0);
+	core->unfinished_seqno = 0;
+	core->completion_stuck = false;
 
 	INIT_LIST_HEAD(&core->submitted);
 	INIT_LIST_HEAD(&core->held);
@@ -414,6 +791,9 @@ int thames_job_suspend(struct thames_core *core)
 	cancel_delayed_work_sync(&sched->work_tdr);
 	drm_sched_wqueue_stop(sched);
 
+	if (thames_core_is_dead(core))
+		return 0;
+
 	scoped_guard(mutex, &core->job_lock)
 		pending = list_count_nodes(&core->submitted);
 	wait_ms = max_t(unsigned int, pending, 1) * THAMES_SUSPEND_TIMEOUT_MS;
@@ -446,6 +826,40 @@ void thames_job_resume(struct thames_core *core)
 	drm_sched_wqueue_start(&core->sched);
 }
 
+static bool thames_job_ring_drained(struct thames_core *core)
+{
+	thames_job_complete(core);
+
+	guard(mutex)(&core->job_lock);
+	return list_empty(&core->submitted);
+}
+
+void thames_job_drain(struct thames_core *core)
+{
+	struct drm_gpu_scheduler *sched = &core->sched;
+	size_t pending;
+	bool drained;
+
+	drm_sched_wqueue_stop(sched);
+	cancel_delayed_work_sync(&sched->work_tdr);
+	drm_sched_wqueue_stop(sched);
+
+	if (thames_core_is_dead(core))
+		return;
+
+	scoped_guard(mutex, &core->job_lock)
+		pending = list_count_nodes(&core->submitted);
+
+	if (!pending)
+		return;
+
+	read_poll_timeout(thames_job_ring_drained, drained, drained, USEC_PER_MSEC,
+			  pending * THAMES_SUSPEND_TIMEOUT_MS * USEC_PER_MSEC, false, core);
+
+	cancel_delayed_work_sync(&sched->work_tdr);
+	drm_sched_wqueue_stop(sched);
+}
+
 int thames_job_open(struct thames_file_priv *thames_priv)
 {
 	struct thames_device *tdev = thames_priv->tdev;
@@ -759,6 +1173,7 @@ static void thames_submit_syncs_signal(struct thames_submit_syncs *syncs, struct
 int thames_ioctl_job_submit(struct drm_device *dev, void *data, struct drm_file *file)
 {
 	struct drm_thames_job_submit *args = data;
+	struct thames_file_priv *file_priv = file->driver_priv;
 	struct thames_submit_syncs syncs = {};
 	struct thames_submit_bos *bos = NULL;
 	struct ww_acquire_ctx acquire_ctx;
@@ -780,6 +1195,13 @@ int thames_ioctl_job_submit(struct drm_device *dev, void *data, struct drm_file
 	if (IS_ERR(handles))
 		return PTR_ERR(handles);
 
+	if (thames_context_banned(file_priv)) {
+		dev_warn_ratelimited(dev->dev, "Context %u is banned; submission refused\n",
+				     file_priv->context_id);
+		ret = -ECANCELED;
+		goto out_free;
+	}
+
 	ret = thames_submit_syncs_get(file, &args->syncs, &syncs);
 	if (ret)
 		goto out_syncs;
@@ -844,6 +1266,7 @@ int thames_ioctl_job_submit(struct drm_device *dev, void *data, struct drm_file
 	thames_submit_bos_put(bos);
 out_syncs:
 	thames_submit_syncs_free(&syncs);
+out_free:
 	kvfree(handles);
 	return ret;
 }
@@ -867,3 +1290,30 @@ int thames_ioctl_job_destroy(struct drm_device *dev, void *data, struct drm_file
 	return 0;
 }
 
+int thames_job_query_fault(struct thames_file_priv *file_priv, struct drm_thames_job_fault *fault)
+{
+	struct thames_job *job;
+	int ret = 0;
+
+	xa_lock(&file_priv->jobs);
+	job = xa_load(&file_priv->jobs, fault->job);
+	if (job)
+		kref_get(&job->refcount);
+	xa_unlock(&file_priv->jobs);
+
+	if (!job)
+		return -ENOENT;
+
+	scoped_guard(mutex, &job->lock) {
+		if (job->fault_valid) {
+			fault->kind = job->fault_kind;
+			memcpy(fault->registers, job->fault_registers, sizeof(fault->registers));
+		} else {
+			ret = -ENOENT;
+		}
+	}
+
+	thames_job_put(job);
+
+	return ret;
+}
diff --git a/drivers/accel/thames/thames_job.h b/drivers/accel/thames/thames_job.h
index a851febe8f98..c9aaed79fe82 100644
--- a/drivers/accel/thames/thames_job.h
+++ b/drivers/accel/thames/thames_job.h
@@ -55,17 +55,25 @@ struct thames_job {
 	struct thames_transfer_table transfers;
 
 	struct mutex lock;
+
+	bool fault_valid;
+	u32 fault_kind;
+	u64 fault_registers[DRM_THAMES_FAULT_REGISTERS];
 };
 
 int thames_ioctl_job_create(struct drm_device *dev, void *data, struct drm_file *file);
 int thames_ioctl_job_submit(struct drm_device *dev, void *data, struct drm_file *file);
 int thames_ioctl_job_destroy(struct drm_device *dev, void *data, struct drm_file *file);
+int thames_job_query_fault(struct thames_file_priv *file_priv, struct drm_thames_job_fault *fault);
 
 void thames_job_complete(struct thames_core *core);
+void thames_job_fail_submitted(struct thames_core *core);
+void thames_job_release_held(struct thames_core *core);
 
 int thames_job_init(struct thames_core *core);
 int thames_job_suspend(struct thames_core *core);
 void thames_job_resume(struct thames_core *core);
+void thames_job_drain(struct thames_core *core);
 void thames_job_fini(struct thames_core *core);
 int thames_job_open(struct thames_file_priv *thames_priv);
 void thames_job_close(struct thames_file_priv *thames_priv);
diff --git a/include/uapi/drm/thames_accel.h b/include/uapi/drm/thames_accel.h
index bd2b4271b896..d193967485cb 100644
--- a/include/uapi/drm/thames_accel.h
+++ b/include/uapi/drm/thames_accel.h
@@ -251,6 +251,11 @@ enum drm_thames_dev_query_type {
 	/** @DRM_THAMES_DEV_QUERY_CAPS: The capability query, &drm_thames_caps. */
 	DRM_THAMES_DEV_QUERY_CAPS = 0,
 
+	/**
+	 * @DRM_THAMES_DEV_QUERY_JOB_FAULT: The fault record of a failed Job,
+	 * &drm_thames_job_fault.
+	 */
+	DRM_THAMES_DEV_QUERY_JOB_FAULT,
 };
 
 /**
@@ -382,6 +387,99 @@ enum drm_thames_fault_kind {
 	DRM_THAMES_FAULT_TIMEOUT,
 };
 
+/**
+ * enum drm_thames_fault_register - Index into &drm_thames_job_fault.registers
+ *
+ * The control registers the fault handler saves, by the names SPRUIP0 gives
+ * them.  A register another core generation reports is appended here and at the
+ * end of &drm_thames_job_fault.registers, which the query's size convention
+ * lets grow; a register the firmware did not save reads 0.
+ */
+enum drm_thames_fault_register {
+	/** @DRM_THAMES_REG_IERR: Internal exception report register. */
+	DRM_THAMES_REG_IERR = 0,
+
+	/** @DRM_THAMES_REG_IEAR: Internal exception address register. */
+	DRM_THAMES_REG_IEAR,
+
+	/** @DRM_THAMES_REG_IESR: Internal exception status register. */
+	DRM_THAMES_REG_IESR,
+
+	/** @DRM_THAMES_REG_NRP: The return pointer saved at the exception, the faulting PC. */
+	DRM_THAMES_REG_NRP,
+
+	/** @DRM_THAMES_REG_NTSR: The task state register saved at the exception. */
+	DRM_THAMES_REG_NTSR,
+
+	/**
+	 * @DRM_THAMES_REG_SE0_FAR: Streaming engine 0's fault address register:
+	 * the virtual address of the earliest fault on stream 0, 128-byte
+	 * aligned; 0 when no stream has faulted since one last closed, or the
+	 * engine could not capture the address.
+	 */
+	DRM_THAMES_REG_SE0_FAR,
+
+	/**
+	 * @DRM_THAMES_REG_SE0_FSR: Streaming engine 0's fault status register:
+	 * bit 12 ERROR and a 12-bit syndrome below it, SPRUIP0 figures 3-139 to
+	 * 3-144.
+	 */
+	DRM_THAMES_REG_SE0_FSR,
+
+	/**
+	 * @DRM_THAMES_REG_SE1_FAR: Streaming engine 1's fault address register:
+	 * the virtual address of the earliest fault on stream 1, 128-byte
+	 * aligned; 0 when no stream has faulted since one last closed, or the
+	 * engine could not capture the address.
+	 */
+	DRM_THAMES_REG_SE1_FAR,
+
+	/**
+	 * @DRM_THAMES_REG_SE1_FSR: Streaming engine 1's fault status register:
+	 * bit 12 ERROR and a 12-bit syndrome below it, SPRUIP0 figures 3-139 to
+	 * 3-144.
+	 */
+	DRM_THAMES_REG_SE1_FSR,
+};
+
+#define DRM_THAMES_FAULT_REGISTERS	9
+
+/**
+ * struct drm_thames_job_fault - Argument of DRM_THAMES_DEV_QUERY_JOB_FAULT
+ *
+ * What the device reported for the Job's last failed submission, filled by the
+ * firmware before it signalled the Fence, read by the host on bounded fields
+ * and never trusted beyond them; the registers raw, decoded by userspace.
+ * Every kind counts towards the Context's ban; the kernel resets the core for
+ * %DRM_THAMES_FAULT_FIRMWARE.  The record is cleared whenever the Job is
+ * submitted, a refused submit call not counting, and set when a submission of
+ * it fails with one; the query returns -ENOENT while it is clear.  A client
+ * that submits a Job again before its last submission completed may read the
+ * earlier one's record.
+ *
+ * When the kernel resets a core, the Jobs on its Ring other than the one that
+ * failed are pushed again after the reset, on the same fences.  Such a Job may
+ * have started before the reset, so its Kernel may run twice, the second time
+ * from its start: a Kernel whose outputs depend on running once, one that reads
+ * what it wrote in place, must not rely on a single run.
+ */
+struct drm_thames_job_fault {
+	/** @job: Handle of the Job, input. */
+	__u32 job;
+
+	/** @kind: One of &enum drm_thames_fault_kind. */
+	__u32 kind;
+
+	/**
+	 * @registers: The saved control registers, indexed by
+	 * &enum drm_thames_fault_register.  For a timeout only NRP, NTSR and the
+	 * four stream registers, the Kernel's PC and TSR and the streams' state
+	 * when the timer interrupted it; every register is 0 when the timeout
+	 * is transfers that did not drain after the Kernel returned.
+	 */
+	__u64 registers[DRM_THAMES_FAULT_REGISTERS];
+};
+
 /**
  * struct drm_thames_dev_query - Arguments passed to DRM_IOCTL_THAMES_DEV_QUERY
  */

-- 
2.54.0

