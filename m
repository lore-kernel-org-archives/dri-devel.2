Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C18B6082BDD
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 09:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TXfCfukL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 037D710F128;
	Mon,  9 Nov 2026 09:31:40 +0000 (UTC)
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9ED410E636
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 17:43:09 +0000 (UTC)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-1a3c08d6928so2932612c88.0
 for <dri-devel@lists.freedesktop.org>; Sat, 07 Nov 2026 09:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794073389; x=1794678189; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=r9DC+v4ThjyXVkuemQANfxNZK1eNGzIbXEHQZPaQePg=;
 b=TXfCfukLWpTuNX69tznpxWRxl+AnasTqUQilw0JJ+++ZGMKR8sIY0l6jz8tPsySfxP
 7QuCbXXKQfTQ/SjbrpDZ7xCp+g7kkFD6JvDlLI3aL2kgTPN+XO/v57maT/HrP/CLL1kq
 0NaFK2dwl3HCwcKPfAo6BswGg/C03OfdGiHggCGFM+CYq/hFx0TsGfztfmvDKRpciXm6
 +BEUUvzhC16BO2/H20Pqa5BLmhkbpdqplLpMVHRH8CbLfBaZP4h+6lpJVODYuF3lA0xt
 yFUkgaZvbboqIcsr0nZJ1u2HVUthZihIG7gc9suQ0Qswbz/ztqAAF7CCtuH3BlpF86am
 PAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794073389; x=1794678189;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=r9DC+v4ThjyXVkuemQANfxNZK1eNGzIbXEHQZPaQePg=;
 b=P/eFEJgIm1yKS3ZtmE688kcXlEy0WiKiNw7xw2b64fkNz/4BEtq0Uw8vMbI3j1Tc1f
 FtjXjul0rse040GwdjMoPHuAht2yukhk4TdOVrUyO8WiGPLu0hYh8jOIhsOo2qWJOXJK
 7yz0l/Sh1vvRpwqSX/vbS6pn3V53NAjutiRJ2cdXtcYKKCYX7QGVUu4y0DqPMoysSW4A
 jVmrYjyvox2toZHufTZHzS1DWAyxTDjni/sXQTyfVqwi8LXYsAy2dl9TUR8r6Kk9h5I2
 DbL9kkM7QYhQjsgrOaPHlkmRJlcm3dQQCMkDfm9C6x44RYZidEJJd2GJSfmvnxfEBBaq
 XWlA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwucQpqyWed85k1ICwfZVeoT3d3Vndf0GMo7QQei1SZIjjjA3CaLXJTVqSm3uiZDduWUc+abTsb4jE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+dfySubIfCi9EQoR8VbBoVyAv/Niq4P5TS6SaZHZpqHGYLhi5O
 aZchDw9xmp9UblL95LX3pwqgBY7a3pDeLn0Ojsy97TgigD5FQLgZbkMN
X-Gm-Gg: AYBFou3x+XQ1xktxw2Qpx44Q9LrId4qbHy8zSOOITfofvJTeKqWADsbFXhLtk68+OrX
 zmonjJHfV8k7CqwuQctgCKvsx4fEcj4Yo5bKlXY1gr1y57TfJ2KUjfsvdL0E+KVAne0MJauK9fq
 1OtYT7UUABBwXYMkj3uO0yjx7VPnZP42IaH4R+MevSOpmmbFC2jMh2lsAGEk31odEB0wCgP0i8e
 UmDvqCiGA9K1GI0wKrglwkCXLIfZ407OgCa52Rt971XZHZCdH0mSEVjvtBpIX+/Wl7v9EKHxCsM
 TVGUM7wCJFncTeJl6E92qggl4pOr5kscWFZq3qqw2iaSe/z7DP9xjexiZ+0Vq62oReeMhaV6+g4
 XRznTBiVtik6Rr1IIwxLDc0E1W5ZBmSt54Udk+JKPci9+NcBISOvNW0fIneRK7RpAREETCvh7vH
 +seL72wEeqNjRFSsABG8HRR4CUttXAcDPQ1rbOwwnUDgxX+8xN9vgBk8jSFPTR7pgH4+d9lbW06
 kLNuTFfqHO8HwVbqEDVYpl1seD4Qb5gZpONEm2GwgxDY85H1CDok6JrVs6iDwQ+yPNu/lSjBAeM
 T/gma7NKB87j+YyIijAvyHhprmIGr+KWdlkLMN/UFd6h0+rEEBg=
X-Received: by 2002:a05:7022:3f0e:b0:168:fe32:35a with SMTP id
 a92af1059eb24-1b25d334fc8mr7817275c88.20.1794073388791; 
 Sat, 07 Nov 2026 09:43:08 -0800 (PST)
Received: from IdeaPad ([2401:4900:1c54:f394:91ce:f63f:7155:e3c6])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b25e4d36efsm15306719c88.17.2026.11.07.09.43.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 09:43:08 -0800 (PST)
From: Daksh Sahni <swizzguy76@gmail.com>
To: karol.wachowski@linux.intel.com, andrzej.kacprowski@linux.intel.com,
 ogabbay@kernel.org
Cc: jacek.lawrynowicz@linux.intel.com, jeff.hugo@oss.qualcomm.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Daksh Sahni <swizzguy76@gmail.com>
Subject: [PATCH] accel/ivpu: Disable recovery work on probe failure
Date: Sat,  7 Nov 2026 23:12:15 +0530
Message-ID: <20261107174215.15818-1-swizzguy76@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 09 Nov 2026 09:31:09 +0000
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

If the NPU raises an error interrupt while ivpu_dev_init() boots the
firmware, the Buttress, MMU or WDT IRQ handler calls
ivpu_pm_trigger_recovery(), which queues recovery_work. When ivpu_boot()
then fails, the err_ipc_fini path tears the device down without
disabling recovery_work and probe returns an error. devres unmaps the
register BARs while the work is still queued or running, and the work
faults on the first register access:

  BUG: unable to handle page fault for address: ffffcfc6680200f4
  Workqueue: events_unbound ivpu_pm_recovery_work [intel_vpu]
  RIP: 0010:ivpu_hw_ip_ipc_rx_addr_get+0xc/0xb0 [intel_vpu]
  Call Trace:
   ivpu_wait_for_ready+0x155/0x220 [intel_vpu]
   ivpu_boot+0x9e/0x270 [intel_vpu]
   ivpu_resume+0xa4/0xd0 [intel_vpu]
   ivpu_pm_reset_complete+0x2c/0x90 [intel_vpu]
   ivpu_pm_recovery_work+0xf6/0x140 [intel_vpu]
   process_one_work+0x1da/0x3c0
   worker_thread+0x1af/0x340
   kthread+0xfa/0x130
   ret_from_fork+0x2b9/0x380
   ret_from_fork_asm+0x1a/0x30

The work dies between pm_runtime_disable() in ivpu_pm_reset_begin() and
pm_runtime_enable() in ivpu_pm_reset_complete(), so the PCI device is
also left with runtime PM disabled and never autosuspends after a later
rebind.

Commit 5eaa49741119 ("accel/ivpu: Prevent recovery invocation during
probe and resume") stopped IPC failures during probe from triggering
recovery, but the IRQ handlers still can.

Call ivpu_pm_disable_recovery() at the start of the err_ipc_fini path,
as ivpu_dev_fini() already does, so the work is flushed and cannot be
queued again before the device is torn down.

Reproduced on Meteor Lake (Core Ultra 5 125H, vpu_37xx firmware
20260219) by kexec'ing with the NPU runtime-suspended: probe in the new
kernel gets an ATS_ERR Buttress IRQ during firmware boot. With this
change probe still fails with -ECANCELED, there is no oops, and an FLR
followed by a rebind brings the NPU back.

Fixes: 852be13f3bd3 ("accel/ivpu: Add PM support")
Cc: stable@vger.kernel.org
Signed-off-by: Daksh Sahni <swizzguy76@gmail.com>
---

Notes:
    Tested on v7.4-rc1 (d48723711bae).
    
    Two things this patch does not address:
    
    The trigger is kexec with the NPU runtime-suspended in the old kernel.
    The driver has no .shutdown hook, so the new kernel's probe sees stale
    NPU state and gets ATS_ERR. A cold boot doesn't hit it. Whether that
    wants a shutdown hook or a reset at probe seems like your call.
    
    In one of four runs that hit ATS_ERR, probe succeeded while
    recovery_work was running concurrently. Probe returned 0, but the
    autosuspend request from ivpu_pm_enable() landed while recovery had
    runtime PM disabled, so the NPU stayed active until first use. Not
    allowing IRQ-triggered recovery until ivpu_pm_enable() would cover both
    cases; I can send a v2 that does that if you prefer.

 drivers/accel/ivpu/ivpu_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
index 247ed6b2ff62..4fcccf78ec5d 100644
--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@ -852,6 +852,7 @@ static int ivpu_dev_init(struct ivpu_device *vdev)
 	return 0;
 
 err_ipc_fini:
+	ivpu_pm_disable_recovery(vdev);
 	ivpu_ipc_fini(vdev);
 err_fw_fini:
 	ivpu_fw_fini(vdev);
-- 
2.53.0

