Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4E6606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hAt4cnNr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4421F10EBD3;
	Mon,  2 Nov 2026 08:04:08 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E07110E3DD
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 18:05:43 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-8a064fac8cbso1508178b3a.1
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 10:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793556343; x=1794161143; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xkS6xbmE+ewGMYaLKZHzgOXG3y/RT/Y6ukuGmQk4oP0=;
 b=hAt4cnNrvdV5KoJmwnvyIjefHjEHq9ofrZbEQb6uef4AluHJRJ1GrnIfoNjTFGJe3j
 4SURmDEqr9XnR0EbnLsjJvGHUwXT5lBGfxYAy3Jq2pCVelpYhzDHWQtrTTmktU7GKQ3h
 ftGfLBl9YgWytb1qGWfjqJ7W6pmLsTfRzUIM8RSDPSE5V6p3252JeXuTnHfVkdQyBk0X
 tn0AI+ijp0I8ex++bF1SdVdtv9BHAv8OXBD9/ZT7nXjiUFUr7wVMV8Ht17IpTTS5DalN
 ochNDis8TTuDHHu3JrnAbl+eeuGuVpIUbrTSUbcPBxvVJL8FBGN70UYW+19neYCMR8Hx
 LVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793556343; x=1794161143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xkS6xbmE+ewGMYaLKZHzgOXG3y/RT/Y6ukuGmQk4oP0=;
 b=TzHcUSeC72giboreS6Gudu+qmZjQwoOhfIwgbK3PVvqUgkjPp6zvu5rH+e7uLuACBL
 87qruUfbnpHhmLV5FCp+4LKbr/saBMB9FgENlvXjNfYXXQT5TvVc09LiyAWdZ1nKxpy3
 3g/NQzyD4Xd9KciigOiDqkQjEcUbyQCiDHQwafB/+rj7kT9xbWG19OVklQ/OKXV9SMlU
 FYZlfwiLXvYVFp6fXj/a/gYdSr7dFIl/ZTaGkBNtFlO3rqGHCG/JfUljqhK2UZtMK3Xp
 yjagvo4eX1ooGBq31jNbzMdf4S5f6AmUPndsUiNBTcYm1B5DVn4RsD5fthtfju+dTP9B
 JD8w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxCWqh/W98KwPIgwG4vdVJjtaJt2yjukWV9TmaK7rRw/ZYtoKFi87j6n7sLZ9XiXWTBToaTqtgZhS0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYId4BpMaVpi02yKwOBqtYNmlWmZKTZpKG5Qjz0kXM78tDX+k+uR
 kG9nwWGr5d8yy+Akur3GdfgjUL2JKjvUN/Rn5ofVR+2AkarE8L1PCI5b
X-Gm-Gg: AYBFou3cUi4nEhpU1LmaluhCAG/vOlMzs5/d9QeDMA4R+5tuAyfDvNAgtZfn+ykL1W4
 yNhx3ipqHuPch0Y30a+MLCsamIDIVrpNOu9pM3uNWJcHtJ4gEPAUUw7R8vyTVrP8vJUMo/RHNgC
 5x1tpBKTNVNcdbKKUhlwJXe7xi0MWUsSzdGcnMsutRcK80N8tGLSF+KraIqtyM8IipbCgCdynIu
 CJa6bdIj4w1fiInP12A1rV94gbfhYywsDJQ9LAeJ/kQSCfeRZx5QGhNYa3W3xj5Ciu+YqFwfw7u
 +N0GsW0amn2TGml4KkSul57cuK9bCDYzf0ICocwDoSPYTmzC1s3qNqixiQaHpONhaO1NpTyWMh9
 h5wSdL4jgbrpywdqCb5/vH7NoF0gnp6EtGgBNJsLxYsWGy+JSnD2JbpJe6ry3WaJojlJIEjZG4l
 bfMB6nseofeRXrCW5g/EFITJ99NxbKS5HZAdcL1mMA3BTOrfUjfRsYp2y++ye+NzuFeKpFolMcC
 Ez5/11YIybAXvJFeHzmnROutizXMA70jxn0CC+52GSH8mYdbUk9gyBJNbTiqXlcfYqZ7Ei+1lmv
 9KC3S3q4/m4Esldj8ZHM3y4=
X-Received: by 2002:a05:6a00:181b:b0:89d:eb23:4e83 with SMTP id
 d2e1a72fcca58-8a9beb67de4mr6450461b3a.30.1793556342787; 
 Sun, 01 Nov 2026 10:05:42 -0800 (PST)
Received: from tabby-boi ([2a09:bac5:4fad:e6::17:370])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8ac269b8805sm446544b3a.44.2026.11.01.10.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 10:05:42 -0800 (PST)
From: Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Connor Abbott <cwabbott0@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH 4/4] drm/msm: serialize devcoredump reads of the crash state
Date: Mon,  2 Nov 2026 02:05:08 +0800
Message-ID: <20261101180508.66598-2-nicoangelodelacruz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261101175553.53746-1-nicoangelodelacruz@gmail.com>
References: <20261101175553.53746-1-nicoangelodelacruz@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 02 Nov 2026 08:03:58 +0000
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

adreno_show_object() converts each captured buffer to ascii85 the
first time the crash state is shown, in place: it checks *encoded,
replaces *ptr with the encoded copy and kvfree()s the raw buffer.
msm_gpu_devcoredump_read() only takes gpu->lock around the reference
get, and every read() of the devcoredump renders the whole state
again, so two processes reading the same devcoredump at once can both
see *encoded == false and both free the same buffer, or print a
buffer the other one just freed:

  WARNING: mm/slub.c:6733 at free_large_kmalloc+0xb0/0xf8
   kvfree+0x44/0x60
   adreno_show_object+0x190/0x240
   adreno_show+0x1d0/0x438
   a6xx_show+0x68/0xbd0
   msm_gpu_devcoredump_read+0x144/0x1f8
   devcd_data_read+0x34/0x48
  page dumped because: Not a kmalloc allocation

The dump also changes length between reads, so a reader can get a
short copy that ends at a page boundary.

Seen on an Adreno 830 with IGT's msm_recovery reading the devcoredump
while a udev helper copied it out: 16 such warnings in one boot, none
with this patch.

Add a mutex to struct msm_gpu and hold it while the state is
rendered. Only one crash state exists at a time, so a per-GPU lock is
enough. gpu->lock isn't used because a devcoredump reader would then
hold up recovery and fault capture for as long as it takes to render
the dump. The new lock is taken after msm_gpu_crashstate_get() and
dropped before msm_gpu_crashstate_put(), so it never nests with
gpu->lock, and it is taken interruptibly so a reader waiting behind
a slow render can be killed.

Fixes: 1df4289d5b23 ("drm/msm: Optimize adreno_show_object()")
Cc: stable@vger.kernel.org
Signed-off-by: Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>
---
 drivers/gpu/drm/msm/msm_gpu.c | 10 ++++++++++
 drivers/gpu/drm/msm/msm_gpu.h |  8 ++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index fded78fdb..428dc9666 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -191,11 +191,18 @@ static ssize_t msm_gpu_devcoredump_read(char *buffer, loff_t offset,
 	struct drm_print_iterator iter;
 	struct drm_printer p;
 	struct msm_gpu_state *state;
+	int ret;
 
 	state = msm_gpu_crashstate_get(gpu);
 	if (!state)
 		return 0;
 
+	ret = mutex_lock_interruptible(&gpu->crashstate_show_lock);
+	if (ret) {
+		msm_gpu_crashstate_put(gpu);
+		return ret;
+	}
+
 	iter.data = buffer;
 	iter.offset = 0;
 	iter.start = offset;
@@ -214,6 +221,8 @@ static ssize_t msm_gpu_devcoredump_read(char *buffer, loff_t offset,
 
 	gpu->funcs->show(gpu, state, &p);
 
+	mutex_unlock(&gpu->crashstate_show_lock);
+
 	msm_gpu_crashstate_put(gpu);
 
 	return count - iter.remain;
@@ -914,6 +923,7 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 	gpu->funcs = funcs;
 	gpu->name = name;
 	INIT_WORK(&gpu->crashstate_free_work, msm_gpu_crashstate_free_worker);
+	mutex_init(&gpu->crashstate_show_lock);
 
 	gpu->worker = kthread_run_worker(0, "gpu-worker");
 	if (IS_ERR(gpu->worker)) {
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index db9e11e7f..9b683973b 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -264,6 +264,14 @@ struct msm_gpu {
 	 */
 	struct work_struct crashstate_free_work;
 
+	/**
+	 * @crashstate_show_lock: serializes rendering of @crashstate for the
+	 * devcoredump.  The show functions convert captured buffers to ascii85
+	 * in place on first use (see adreno_show_object()), so concurrent
+	 * readers of the same dump must not render it at the same time.
+	 */
+	struct mutex crashstate_show_lock;
+
 	/**
 	 * @recovery_in_progress: true while recover_worker() holds @lock, so
 	 * that fault capture and GMU waits don't wait on a fault devcoredump
-- 
2.53.0

