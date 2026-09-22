Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E45C982F1
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:01:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B3ED10E45B;
	Tue, 22 Sep 2026 08:01:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sx0w/Ajq";
	dkim-atps=neutral
Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com
 [74.125.225.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C24D010E45B
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 08:01:32 +0000 (UTC)
Received: by mail-wr2-f35.google.com with SMTP id
 ffacd0b85a97d-48436686a40so356918f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 01:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790064091; x=1790668891; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uM6eJlIue+3ZnByR9U7PRXrgVvVnosyPWdGdGl87I7k=;
 b=sx0w/Ajq5eg5sBnFBWft7Fm4sSfwTNcXQ1hLCNV2Os9wiYcQYJZ5DBiowJ0oM0zFwN
 b9/5Zzrr6sBwDkPoaQa4GHsgcohA4zeAvV/aOWUr7wVvL3xx0UhUDE9QzBY9FLVS2rJ6
 VG3Y1R4iAqUHx7gNjReJ4P56ABtOdS6yuaBF07xZWxzfp05uILmXeaVvrWZmbMRHkkST
 FmwCYJkRgKq+x76Gr7hgagIVOyPtfp2MJa8V1Iu7iJt0+hX8GfbEOzdDMS1Y2O236fc8
 6WQTHCdjWq4H7bl7dUBC/mTYvL/eAUT87Byu4d8U5nfUmhOMTfzqhC9MlZ4c1jCvNsSs
 Zkig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790064091; x=1790668891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uM6eJlIue+3ZnByR9U7PRXrgVvVnosyPWdGdGl87I7k=;
 b=usxXh1ZCCO91LVaFjZMP1QK731TilNJjcfYTm4lIQIzBWFJ+SbZVELk8rF8co3k0jR
 AqxH+bRO/nESyzqG0bEPQE4x00mSxgPZF2Vy3+QmmG5Op1ESm5QVFIzRO3QGmmtMzM1E
 3udPNlFmlYBM8/5hMJVFGKjpLYGvzh1NzDXtE22wICPHF/V1IyQyVX9JnVw9UPbXE6q/
 eZZ26bSQhib8yEZveuSCQt8kLUjn8S1F8rszV3haA9dkzpuHLIKul+yxsI8r01/gtFwB
 /2D8e9D7A8xKZlNrRS2EA9nq8SOBnJ8bE5jXrYLzido7QMWaF8Aa+pJ4Gjw2ZD2SkoTG
 2krA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzW2F/wXAaZ62nOQv2QAd5MnF3n0XSv+QdcgUxvWyULlhzRtvGkUGWAqMp1+PvugpDjS64o7mT1nWE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mbGPI9yNQ8oKoxSlMppMjoQErfO7v+DFvB42FwosV/63THdCnS
 VVinjaFQpdxekABj11n0qNpePGDU9j9DrJvHdsj/HfyWEtZDoU+mXURr
X-Gm-Gg: AYBFou1S61Apu5HapNaP9MepxmAbuocukGHLmARXwz5bIzCm0VviX4yW0jQ3F8Qrt87
 pk2Yoq1DdpfXoNf3lroGwAdX63cilGo16/0JWfMgYnqzqOCzqy4i2JdZf1vhX5AL/s+VvrN/6H0
 Rqv+ybcYxZlPsUxYGitS6+wdtwQ/6z9jpdxk4ACV+yqGdr5hobRlEGwu5hZX2c3BTyf63xzZcWF
 oY2lstFmQjx80mYbmQlLLkKNc5iobXblSJJDgxkMrArh4DmTWEeQGOgS6/p419VNTMkpBmlCUgR
 DCQ1Dx0tgadMRua20CbKoe+Je/IwNerpOQlm8rYEvb/SeJYQxBo/J+Hmos2JYzyZ3RRT5w6UbOr
 Lt4UUmwZm/SFeRqtDog6sLzovj9tiwM0Wlk3XZ8JIM5hOVs0djXUxSrlMGqApUmKe/70FitladF
 vMrr1bNDwpo7RWuzh7UcdlWl6FHBjbaGU/MiKH9in07Ls178zqE65JIIvFxNGVrbTnhetW0Ahck
 bPSl7g5HmcxuTKoJZkdI5rpyRM6x0aKtX3NExYSQAZgrOiZZSUoKYPzKIx+S9GE+ApUu4qvxJ+F
 b1jk
X-Received: by 2002:a05:600c:1d1b:b0:49e:7cc6:ec88 with SMTP id
 5b1f17b1804b1-49fc7e00555mr163235615e9.1.1790064089430; 
 Tue, 22 Sep 2026 01:01:29 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B80530056971C6280202175.dsl.pool.telekom.hu.
 [2001:4c4e:1b80:5300:5697:1c62:8020:2175])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdaaf97e2sm18248625e9.2.2026.09.22.01.01.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 01:01:29 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Robert Foss <rfoss@kernel.org>, Sidong Yang <sidong.yang@furiosa.ai>,
 Diederik de Haas <diederik@cknow-tech.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Jiaxing Hu <gahing@gahingwoo.com>, Nicolas Dufresne <nicolas@ndufresne.ca>,
 Jonas Karlman <jonas@kwiboo.se>, Guangshuo Li <lgs201920130244@gmail.com>,
 =?UTF-8?q?H=C3=BCseyin=20BIYIK?= <boogiepop@gmx.com>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Igor Paunovic <royalnet026@gmail.com>
Subject: [PATCH v2 03/11] accel/rocket: search every core slot when looking up
 a scheduler
Date: Tue, 22 Sep 2026 10:01:06 +0200
Message-ID: <20260922080114.44662-4-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922080114.44662-1-royalnet026@gmail.com>
References: <20260922080114.44662-1-royalnet026@gmail.com>
MIME-Version: 1.0
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

sched_to_core() walks rdev->cores[] up to rdev->num_cores, and
rocket_remove() decrements num_cores for every core it removes. Unbind a
core that is not the last one and the cores behind it fall outside the
search, so sched_to_core() returns NULL for a core that is still bound and
still running jobs. Neither caller checks the result:

  rocket_job_run():      rocket_fence_create(core), core->dev
  rocket_job_timedout(): dev_err(core->dev, "NPU job timed out")

Unbinding the middle core of the three on an RK3588 while three clients are
submitting to all of them faults twice, once from the surviving core's
job queue and once from its reset work:

  KASAN: null-ptr-deref in range [0x0000000000000220-0x0000000000000227]
  Workqueue: fdad0000.npu drm_sched_run_job_work [gpu_sched]
  pc : rocket_job_run+0x234/0x838 [rocket]
  Call trace:
   rocket_job_run+0x234/0x838 [rocket]
   drm_sched_run_job_work+0x2cc/0xad8 [gpu_sched]
   process_one_work+0x640/0x14f0

  KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
  Workqueue: rocket-reset-2 drm_sched_job_timedout [gpu_sched]
  pc : rocket_job_timedout+0xf0/0x1e0 [rocket]
  Call trace:
   rocket_job_timedout+0xf0/0x1e0 [rocket]
   drm_sched_job_timedout+0x188/0x6a0 [gpu_sched]

Both are the third core: the workqueue names are its device and its
core->index, and it was left at slot 2 while num_cores had dropped to 2.

Search all the slots that were allocated, the way find_core_for_dev() now
does. A core that is still bound is then found, and the two callers get
the pointer they already assume they have.

This does not make unbinding one core out of several safe. An open client
keeps an entity pointing at the scheduler of the core that went away:
drm_sched reports it as not ready for every job that lands on it, and the
client waits in dma_fence_default_wait for a fence that will never signal.
Stopping the NULL dereference is what belongs in a fix; the rest wants
more thought.

Reported-by: Sidong Yang <sidong.yang@furiosa.ai>
Closes: https://lore.kernel.org/dri-devel/apwUewaRnoTNXHCt@rock-5b-plus/
Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
Cc: stable@vger.kernel.org
Assisted-by: LLM sparse checkpatch
Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
---
Unchanged from the standalone posting, which this series supersedes:
https://lore.kernel.org/r/20260905150432.7477-1-royalnet026@gmail.com

 drivers/accel/rocket/rocket_job.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index f404355058185..4bc4f9c8ee403 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -283,7 +283,7 @@ static struct rocket_core *sched_to_core(struct rocket_device *rdev,
 {
 	unsigned int core;
 
-	for (core = 0; core < rdev->num_cores; core++) {
+	for (core = 0; core < rdev->max_cores; core++) {
 		if (&rdev->cores[core].sched == sched)
 			return &rdev->cores[core];
 	}
-- 
2.43.0

