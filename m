Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A092CA5FF6
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 17:19:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A20710EAD3;
	Sun,  4 Oct 2026 17:18:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=saltyming.net header.i=@saltyming.net header.b="fmWMp4YF";
	dkim-atps=neutral
Received: from smtp-sv1.saltyming.net (smtp-sv1.saltyming.net [152.53.31.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0024810E2E5
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 23:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=saltyming-dkim-202512; d=saltyming.net;
 c=relaxed/relaxed; 
 h=MIME-Version:Message-ID:Date:Subject:To:From:Content-Type; t=1791071055;
 x=1791675855; bh=YTIDmR7uDyYS3MzPy8IMzU6ozNqY3r0FgOdpTRPN1+M=; b=fmWMp4YFNK
 sO+/cPen4xkKT4VLBF0Xuy2NE1XeUR06sESohUISBc53kshEwxRzIKsAkhEo0JQU4SpuHrzTSHj
 UYzsOblP3gru5MlFUywMGEKjQAsOZdkIylrs4KJ+9CJPfTy3dBoN6JJMV6mY+VVQ4mU8Ylsobra
 LJeDvocMdW6hXnI3GrwQOS0fEOHvr7csY1KjqE1IYPO76t/LZCvO/dOxOyFoOQz1dG023KVEdQs
 Y83ImOvGCt/32AjQ9XkWoPrvsAAHpz5vacZz2+DjSIEFRf7N7646+CpuhzK+QwE+B2MK3YHhejm
 aSLQ6bTu+KID0QG/V0Ck94v4YeEGOnTA==;
Received: by smtp-sv1.saltyming.net (SaltyMail) with ESMTPSA
 (version=TLSv1.3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256)
 (No client certificate requested)
 id d9338c4b-2551-4aae-ad55-e5548537ffe2
 for <dri-devel@lists.freedesktop.org>; Sat, 3 Oct 2026 22:32:27 +0000
X-Virus-Status: Clean
X-Security-Tags: spf_none, dkim_none, dmarc_fail, dmarc_quarantine, arc_none,
 av_clean, ham
From: Hamin Sung <hamin@saltyming.net>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Ben Skeggs <bskeggs@nvidia.com>, Roy Spliet <rspliet@eclipso.eu>,
 Roy Spliet <nouveau@spliet.org>, Hamin Sung <hamin@saltyming.net>,
 stable@vger.kernel.org
Subject: [PATCH] drm/nouveau/fb/gt215: don't sleep with PFIFO paused during
 link training
Date: Sun,  4 Oct 2026 07:32:15 +0900
Message-ID: <20261003223215.59266-1-hamin@saltyming.net>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 04 Oct 2026 17:18:49 +0000
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

gt215_link_train() brackets the training with gt215_clk_pre() and
gt215_clk_post().  gt215_clk_pre() pauses PFIFO with nvkm_fifo_pause(),
which takes the FIFO lock with interrupts disabled and holds it until
gt215_clk_post().  In between, link training builds and runs PMU memx
scripts: nvkm_memx_init() and ram_exec() send messages to the PMU and
sleep until it replies.

With preemption counting enabled, which PREEMPT_DYNAMIC kernels always
have, the first memory reclock of a GT21x that needs link training (for
example after writing a pstate to the debugfs pstate file) logs:

  BUG: scheduling while atomic: kworker/1:3/256/0x00000002
  Workqueue: events nvkm_pstate_work [nouveau]
  Call Trace:
   gt215_pmu_send
   nvkm_memx_init
   gt215_ram_calc
   gt215_link_train
   gt215_ram_calc
   nvkm_pstate_work

A second report follows from ram_train_result(), which runs after
gt215_clk_post(), only because the first one reset the preemption count.
While the PMU runs the scripts, anything else that takes the FIFO lock,
such as enabling or disabling the non-stall interrupt for fence
signaling, spins with interrupts disabled on another CPU.  And if sending
to the PMU fails with -EBUSY inside the bracket, the error path skips
nvkm_fifo_start() and leaves the lock held.

Pausing PFIFO under the lock is not what keeps the engines off the
memory during training.  gt215_clk_pre() also halts PFIFO through
0x002504 and waits for the engines to go idle, which is all a normal
memory reclock relies on: the memx script that gt215_ram_calc() builds
halts PFIFO the same way before it reclocks the memory.  Let
gt215_clk_pre() skip the pause when it is not given flags, as
gt215_clk_post() already skips the matching start, and pass none from
link training.

Fixes: 7f4b961618d0 ("drm/nouveau/fb/ramnva3: Link training for DDR3")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5 sparse # max effort
Assisted-by: Claude:claude-fable-5-1 # max effort, review
Signed-off-by: Hamin Sung <hamin@saltyming.net>
---

Notes:
    Tested on a GeForce 310M (GT218, 512 MiB DDR3) with 6.18.54
    (PREEMPT_DYNAMIC, lazy) by writing "0x0f" to the debugfs pstate file after
    boot, which runs link training once:
    
      - without this patch: two "BUG: scheduling while atomic" splats, one
        from nvkm_memx_init() and one from nvkm_memx_train_result()
      - with it: none; the reclock still ends at core 625 MHz, shader
        1530 MHz, memory 789 MHz
    
    Booting with nouveau.config=NvClkMode=0x0f also trains and switches
    cleanly with the patch, and with nouveau.debug=fb=debug the training
    reports its 64 result words and the computed 0x100720/0x1111e0/0x111400
    values (30032100 02000404 00000000).
    
    When link training runs while the system is up, the interrupt handler on
    the other CPU can still read 0xffffffff from the GPU (the WARN_ON in
    nvkm_intr()) and a few dozen "fb: trapped write ... [PFIFO_WRITE]" lines
    are logged.  Both happen with and without this patch and look like host
    access while the training script blocks it; this patch does not try to
    address them.
    
    Found while setting up nouveau on that machine with an AI coding
    assistant, which also wrote the patch and ran the tests above on it;
    I have reviewed the patch and the test results.

 drivers/gpu/drm/nouveau/nvkm/subdev/clk/gt215.c  |  7 ++++++-
 .../gpu/drm/nouveau/nvkm/subdev/fb/ramgt215.c    | 16 ++++++++--------
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/gt215.c b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/gt215.c
index 5421200282b9..ad5167d23742 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/gt215.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/gt215.c
@@ -303,6 +303,11 @@ calc_host(struct gt215_clk *clk, struct nvkm_cstate *cstate)
 	return ret;
 }
 
+/*
+ * Halt PFIFO and wait for the execution engines to go idle.  If @flags is
+ * not NULL, PFIFO is also paused under the FIFO lock with interrupts disabled
+ * until gt215_clk_post(), so the caller must not sleep in between.
+ */
 int
 gt215_clk_pre(struct nvkm_clk *clk, unsigned long *flags)
 {
@@ -319,7 +324,7 @@ gt215_clk_pre(struct nvkm_clk *clk, unsigned long *flags)
 	) < 0)
 		return -EBUSY;
 
-	if (fifo)
+	if (fifo && flags)
 		nvkm_fifo_pause(fifo, flags);
 
 	if (nvkm_msec(device, 2000,
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgt215.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgt215.c
index 3135b46cbfcd..6a93b2f164de 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgt215.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgt215.c
@@ -164,8 +164,6 @@ gt215_link_train(struct gt215_ram *ram)
 	struct nvbios_M0205T M0205T = { 0 };
 	u8 ver, hdr, cnt, len, snr, ssz;
 	unsigned int clk_current;
-	unsigned long flags;
-	unsigned long *f = &flags;
 
 	if (nvkm_boolopt(device->cfgopt, "NvMemExec", true) != true)
 		return -ENOSYS;
@@ -186,7 +184,12 @@ gt215_link_train(struct gt215_ram *ram)
 
 	clk_current = nvkm_clk_read(clk, nv_clk_src_mem);
 
-	ret = gt215_clk_pre(clk, f);
+	/*
+	 * Talking to the PMU below sleeps, so do not pause PFIFO under its
+	 * lock.  gt215_clk_pre() still halts it through 0x002504, which is
+	 * all a normal memory reclock relies on as well.
+	 */
+	ret = gt215_clk_pre(clk, NULL);
 	if (ret)
 		goto out;
 
@@ -241,7 +244,7 @@ gt215_link_train(struct gt215_ram *ram)
 	nvkm_mask(device, 0x616308, 0x10, 0x10);
 	nvkm_mask(device, 0x616b08, 0x10, 0x10);
 
-	gt215_clk_post(clk, f);
+	gt215_clk_post(clk, NULL);
 
 	ram_train_result(ram->base.fb, result, 64);
 	for (i = 0; i < 64; i++)
@@ -258,12 +261,9 @@ gt215_link_train(struct gt215_ram *ram)
 	return ret;
 
 out:
-	if(ret == -EBUSY)
-		f = NULL;
-
 	train->state = NVA3_TRAIN_UNSUPPORTED;
 
-	gt215_clk_post(clk, f);
+	gt215_clk_post(clk, NULL);
 	kfree(result);
 	return ret;
 }

base-commit: bca45af5998a05f34b13a2ef11e639bac9c62643
-- 
2.55.0


