Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D51606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 08:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qdDvSp88
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC8DF10E9BF;
	Wed,  4 Nov 2026 08:58:28 +0000 (UTC)
Received: from mail-dl2-f2.google.com (mail-dl2-f2.google.com [74.125.229.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DDA710F6FA
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 16:34:04 +0000 (UTC)
Received: by mail-dl2-f2.google.com with SMTP id
 a92af1059eb24-147af88ad01so55979c88.2
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 08:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793723643; x=1794328443; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CkDq4ip3eZVdM6Aw+l6DwI7pxq1Ld8m1+Ex9I/WSbNY=;
 b=qdDvSp889K7FA6NUHGclwKFNbfl3JOMPJMKQ9+dRuDLwNwznbUsmhdmaZ/+vS4gTbK
 itXBbkUmR3tlVYTajVhBPZtmJYKeBRbEmMzcS8Bt38dxSqPpeVUVJl+VymiFfe6rxZE7
 M8jICtWiQazvV9t0UkYZpI4TDEgElIPH3MB4TW4ry9Ke1aI8jFFeHMyZnzrZV1veA+Tr
 VjsWvFeyHqzsOb67WuYQhRUsMt0LNPGgl6YxNeRqub2b5opg7yjo/vunTHBbKbfUA+XP
 jCc7vA4ayE2El4uY/YfG2MLHmQ8DSRmOJ8ZVyaMKzYfTJlL0qyK2p+CmnIo6wTt3UULG
 yZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793723643; x=1794328443;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CkDq4ip3eZVdM6Aw+l6DwI7pxq1Ld8m1+Ex9I/WSbNY=;
 b=Z+ugpQ7juAMFd/n6pVMwoBFSxTzJULckZtS3pMwK39FVB2f1up9Ifjzy3b9VfHUg/r
 ihdXiXKLiMTeOOBEOwq0u+s1wP/2i+V4hxKgrcxlMmrdQ/mkFWIcVXZXT5uAmOaKu67u
 RAqsJlwNrkqWNDRyjBlrUE4JVBePNWSK3CW/4Vg9QpJ93ztJ6i0mnpGKGGYuzrKe5ZFw
 RHtfV5yk8X3YpL5rFHq0z83GxnIkok6HMQAX27tf33eC+W5bH+A80zEg5axq9xCbSxwY
 ZmztKB2gf7aOJ06S28A3Lapc9Scq6scQz8BJyHY0ps85WRiNEfNIbIRJddVGzjGRJVNc
 4Nkg==
X-Gm-Message-State: APuU4Z95L4kUK5QLl7ckw8q1Q2FB34LbZDIGfG2C1VNVtx90/W+sUC4S
 AZbIr9xRbl+Nk/hX0tg0ht/M6uBuxe6LjU/YSDWmx5ool7X4g2IUjAVw5DSA3xQhV2pu1A==
X-Gm-Gg: AYBFou2u6nCD1ic5TyePojUuPP0V6OxRGe18g6Zis7w5mYevW0y+hBlNvgDCgCGu2nK
 OM5FRN1WGeWN+kj1fnjcGNmQDy3I0au4LqP5/oiepkfMfS6uKSBcOCA9XOCRAPqYHTicOjx9v+z
 Vo94WEf9vHpD8qnmL0m0cHsMeq6v8w3xCkXp/kdRtqm3TljKT7Qqekv04cB2bZ9VYDWDPMRtknt
 TvtMKcj+yddlk9GASc1QZZKA3aBYBIZQ3Ka8zR2Rqsfp1Ayk2VGLDcGwAgoDvNFcHLxgAKqq1eZ
 tlh33JiWgW7R/3Ng5PSsnhR6ukK0lkti/cHgPMg81IF4KOO/Fh9ogKrzFH+9CfN6OjI9gCu53oF
 6XifAHSL/qPPPtyP0KDohKhYeZoBcK4lsHrgCxqkFUAD5VLLaiEe0o1+F2ErIz6Vfpz47rveDh3
 p4LdZQ470gbydZV2GSVXXZgHQFYcXcPHgAuHN1UdgxI3zX+0CLzXAyl1Agh5x9PfGl4ip11MP84
 6zKpurq5AkWLB+3mi+dZT68YorxsZA11me4YoRo94f7vH/F0b7GAO1mJWMLUci9mJdf65o4G1He
 uH2TehS1vjV9oDftTVZdrw55mb4s+DfDYFRxd1cDPz13toE9bgqqWhipYhB2njI=
X-Received: by 2002:a05:701b:2710:b0:146:ffa9:2117 with SMTP id
 a92af1059eb24-1ac58e573b8mr29438821c88.1.1793723643278; 
 Tue, 03 Nov 2026 08:34:03 -0800 (PST)
Received: from CRASHEDROM.localdomain ([142.249.36.161])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b245b8822fsm156057c88.2.2026.11.03.08.34.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 08:34:02 -0800 (PST)
From: Chengyu Liu <lui2012qwq@gmail.com>
To: koby.elbaz@intel.com,
	konstantin.sinyuk@intel.com,
	ogabbay@kernel.org
Cc: dri-devel@lists.freedesktop.org, Chengyu Liu <lui2012qwq@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH] accel/habanalabs: disable pending-reset work in
 hl_device_fini()
Date: Wed,  4 Nov 2026 00:33:54 +0800
Message-Id: <20261103163354.1599176-1-lui2012qwq@gmail.com>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 04 Nov 2026 08:58:01 +0000
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

hl_device_fini() sets device_fini_pending and flush_delayed_work()s the
pending-reset work, but flush only waits for a running callback - it
does not prevent the callback from re-arming.
device_hard_reset_pending() re-arms itself via queue_delayed_work() when
hl_device_reset() fails with -EBUSY and the (unlocked)
device_fini_pending check still reads 0, so a callback that passed that
check before fini set it re-arms during the flush, and the fresh timer
survives: destroy_workqueue(hdev->reset_wq) cannot see a delayed work
pending on the timer wheel, so the work fires later, queues onto a
destroyed workqueue and runs with a freed hdev.  Use-after-free.

On a busy device (live compute contexts make hl_device_reset() keep
failing with -EBUSY) this work sits in a per-second retry loop and the
callback body is a real reset attempt, so hitting the window on device
removal/FLR is observable in practice, and retries are free.

Use disable_delayed_work_sync(), which waits for a running callback to
finish and leaves the work item disabled, so the callback's
queue_delayed_work() re-arm has no effect.

Found by static analysis.  The race was reproduced on a KASAN build
with a small module exercising this exact flush/re-arm/free pattern
(no Gaudi hardware available); PoC and splat are below.

Cc: stable@vger.kernel.org
Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
---

Reproducer notes (PoC source below; a module parameter selects the
shape): mode=0 (flush_delayed_work + lockless guard, this bug's shape) produces

    [    2.22] BUG: KASAN: slab-use-after-free in __run_timer_base.part.0+0x807/0x900

after the teardown frees the container; mode=1
(cancel_delayed_work_sync, i.e. this fix) stays clean.

---------------------------- reproducer: pm_flush_poc.c ----------------------------
// SPDX-License-Identifier: GPL-2.0
/*
 * pm_teardown_poc - mechanism PoC for the drv-teardown-sync C/D variants
 * (F-026 ipoib / F-028 epf-ntb / F-029 habanalabs).
 *
 * Modes (module parameter):
 *   0  F-029 vuln shape:  flush_delayed_work + lockless guard
 *   1  control:           cancel_delayed_work_sync (>=6.9 swallows re-arm)
 *   2  F-028 vuln shape:  cancel_delayed_work (non-sync) + unconditional re-arm
 *   3  F-026 vuln shape:  cancel_delayed_work (non-sync) + guard check/queue
 *                         race window (test passes, teardown slips in before
 *                         the queue_delayed_work)
 *
 * Every vuln mode must produce KASAN slab-use-after-free when the orphaned
 * work fires after kfree; the control mode must stay clean.
 */
#include <linux/module.h>
#include <linux/workqueue.h>
#include <linux/slab.h>
#include <linux/delay.h>

static int mode;
module_param(mode, int, 0444);
MODULE_PARM_DESC(mode, "0=flush(F-029) 1=cancel_sync(ctrl) 2=cancel_nosync(F-028) 3=cancel_nosync+guard-race(F-026)");

struct pm_td_ctx {
	bool			fini_pending;
	struct delayed_work	work;
};

static struct pm_td_ctx *ctx;

static void pm_td_cb(struct work_struct *w)
{
	struct pm_td_ctx *c = container_of(to_delayed_work(w),
					   struct pm_td_ctx, work);

	pr_info("PM-POC: cb running, fini_pending=%d\n", c->fini_pending);

	switch (mode) {
	case 0:		/* F-029: lockless guard then long body then re-arm */
		if (c->fini_pending)
			return;
		msleep(300);
		schedule_delayed_work(&c->work, HZ / 10);
		pr_info("PM-POC: re-armed (flush shape)\n");
		break;
	case 2:		/* F-028: unconditional re-arm, cancel must catch running cb */
		msleep(300);	/* long body so cancel lands mid-run */
		schedule_delayed_work(&c->work, HZ / 10);
		pr_info("PM-POC: re-armed (no guard)\n");
		break;
	case 3:		/* F-026: guard check passes, THEN teardown slips in */
		if (c->fini_pending)
			return;
		/* widen the check->queue race window like ipoib's 724->725 */
		msleep(300);
		schedule_delayed_work(&c->work, HZ / 10);
		pr_info("PM-POC: re-armed past guard (test-queue race)\n");
		break;
	default:
		break;
	}
}

static int __init pm_poc_init(void)
{
	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
	if (!ctx)
		return -ENOMEM;
	ctx->fini_pending = false;
	INIT_DELAYED_WORK(&ctx->work, pm_td_cb);

	pr_info("PM-POC: arming, mode=%d\n", mode);
	schedule_delayed_work(&ctx->work, 0);

	msleep(50);	/* callback is mid-run now */

	/* teardown sequence for the selected variant */
	ctx->fini_pending = true;
	switch (mode) {
	case 1:
		cancel_delayed_work_sync(&ctx->work);
		break;
	case 0:
		flush_delayed_work(&ctx->work);
		break;
	default:
		cancel_delayed_work(&ctx->work);	/* non-sync: C variants */
		break;
	}

	pr_info("PM-POC: teardown done, freeing ctx\n");
	kfree(ctx);

	msleep(600);
	pr_info("PM-POC: SURVIVED (no KASAN splat)\n");
	return 0;
}

static void __exit pm_poc_exit(void) { }

module_init(pm_poc_init);
module_exit(pm_poc_exit);
MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("drv-teardown-sync C/D variant mechanism PoC (F-026/028/029)");

 drivers/accel/habanalabs/common/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/habanalabs/common/device.c b/drivers/accel/habanalabs/common/device.c
index 09b27bac3a..4635dc8572 100644
--- a/drivers/accel/habanalabs/common/device.c
+++ b/drivers/accel/habanalabs/common/device.c
@@ -2487,7 +2487,7 @@ void hl_device_fini(struct hl_device *hdev)
 	dev_info(hdev->dev, "Removing device %s\n", dev_name(&(hdev)->pdev->dev));
 
 	hdev->device_fini_pending = 1;
-	flush_delayed_work(&hdev->device_reset_work.reset_work);
+	disable_delayed_work_sync(&hdev->device_reset_work.reset_work);
 
 	if (hdev->pldm)
 		reset_sec = HL_PLDM_HARD_RESET_MAX_TIMEOUT;
-- 
2.25.1

