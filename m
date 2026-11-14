Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181B9606A32D
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tO5VJ1I0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 889D610EE0C;
	Sat, 14 Nov 2026 16:24:49 +0000 (UTC)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D43210E53F
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 06:25:56 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-33c10faf6easo223747eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 22:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794637555; x=1795242355; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2G/wlgst0b3QmNrVuRQ50SldBGJC/pdF4BObZ2EI5Ls=;
 b=tO5VJ1I0r1oHwFUt43MAOCDikglCiZcF9DrACqDAsspLaEZwBA4IpQd7SMHlCMMMlw
 7+iYxXGY558BAjgvx2LPJX2Z6dka1eY9RUVxeggVZEHAsH/hyQUczFVHhmL54GGWXLZL
 zRNePObSQL4quSTq3xeM0XNafGiEeZiBBcuUBqOQ1liUa3x7e3E4KAqRzVZSny6uPvsF
 pup625Tq8syk6uuT3vbFULf1FopEd3AtZFyv0AQoBCAdfbo590m9s6khKB7X/qYpev03
 LpwpfzdHxLbch++h/rv+CEIcHZALWs2j95AOwX6EPnMIL9ojRqVYVxHHVvTL7l6XsHH5
 BnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794637555; x=1795242355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2G/wlgst0b3QmNrVuRQ50SldBGJC/pdF4BObZ2EI5Ls=;
 b=ptucC+8SfK9nyhXD3UI/a/rY0ck+Rl18za6+Fobyun6dJYpUSiou7D/c8B+bk5tpqa
 XHA0iQd7hSdSbwIsYbrFVJj+K7pVl4MtOFue13WQV9FAF2DIO5k4bBUzrNKxcklnM51t
 10etMXpTVn6kZerR3iUZxQW8+XNb4V/BKpvAFvNkBb9odwrrTfOnLBVEbYvXuF42Pybn
 uaUlB0PH3U40sA/HIJMqDLI92QRhAUYmtM40DG6N0x9IuzOt5jXoDB1t+2XtJJVWW3LB
 SuKhdUIPQISy3vj6soj705e6ckghqx3USfgzrJ7JSSjubwyZ7IoLJrPUAHO2JXp6CIZT
 Y6EQ==
X-Forwarded-Encrypted: i=1;
 AL+hErH9xaxcWGP3Ot+6eI3heG5pT8VSGynnAFmMUZ7ZhC2RnayfAxHZtzf9MHS3JTEl38Y6GQKARU7BZ0g=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+CvY/Ca6+heYsVBJ3bBQOsPBCE0o5CLNgPUvu8eiJcZ+kU9ssd
 pRkVLMfuY6JA5fW3G+seCHEvj+cHfmCAwMKyNiw/tthcP5LEMnOjf/wz
X-Gm-Gg: AYBFou17w9G7QXp2FKXRa9jfWiL6Ja4kvjVcikA1uiL/cpu8lLYJ/0vwJGEsGNST2MS
 MgeTvHurBeZWXMgNLX/SSTeVWCnJbsjLGPWtLL+Q1kU0stqOmjkpnuACdFZACYrYHRiV1WsvMUd
 tzzNmYLxkpfxw0o3Y8g9meGgxKeaGWBCpcx1+gVOrLMV/n2844igRsJt/BdCJ2oYxWFY0COXPQc
 syyAfI7jWBGN3EaOlXl8w4sdHZQ11VFs3NyC7WzRKKNuFWM1nO+ISY6l3M0qod8NrSdODaJgVUa
 3z7B0CWC0652Q/uP7wqY6bLz4IylF85VWAb7rswlFpxgkNEKavc8EIT3zB/OORozWDDoZgQhcqu
 /3C0HO4YO96RHm6Lyqg18ld0pxGzkFMD9sqIbcpTIYgm1392i9ebrmOCPWBW5PH/gDHrUDRNqx/
 UHWgjyehHgYOxgPfxFm2+QE4P0Yr4v/9t2o1dE907ucn+XAA9cOSzF6mHjpcR5iMTmHtRQSOjFR
 0yG8qVGk6jhgjVDThUtUQ+DOmdH60059hH5H97gGff/23TE/TDIw2u/B/RC/oA1W306T5PmLzV0
 YNG0X7oMBDqNDIW7DenzjmGBDe6nk4w7/fTyaFRVZdBeegqAHReQJuM2XsNbV7smskk4H1EAmjT
 Xkrg=
X-Received: by 2002:a05:693c:881c:10b0:36d:5fbc:8c8d with SMTP id
 5a478bee46e88-379655d503emr6618386eec.2.1794637555183; 
 Fri, 13 Nov 2026 22:25:55 -0800 (PST)
Received: from DESKTOP-CJ1L666.localdomain ([211.198.99.62])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3795591f4f8sm13537585eec.13.2026.11.13.22.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 22:25:54 -0800 (PST)
From: Jiwoo Kim <arpe1618@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH 2/2] drm/msm: Put the VM_BIND queue last in msm_vma_job_free()
Date: Sat, 14 Nov 2026 15:25:41 +0900
Message-ID: <20261114062541.2001-2-arpe1618@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261114062541.2001-1-arpe1618@gmail.com>
References: <20261114062541.2001-1-arpe1618@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 14 Nov 2026 16:24:47 +0000
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

msm_vma_job_free() puts the job's submitqueue and then wakes up
vm->prealloc_throttle.wait. The job does not hold a reference to the
VM of its own: the VM is kept alive by the context, which the queue
holds a reference to. When the job holds the last reference to the
queue, as it can once the file has been closed, for example when a
cancelled job is freed, the put can drop the last reference to the VM,
and the wakeup then uses a VM that msm_gem_vm_free() has released.

Since commit 01c8d1f385f7 ("drm/msm: RCU-free the scheduler-containing
ring and VM objects"), msm_gem_vm_free() frees the VM with kfree_rcu(),
but msm_vma_job_free() is not in an RCU read-side critical section, so
a grace period can still end before the wakeup, e.g. if the task is
preempted in between. Before that commit, the VM was freed right away.

Put the queue only after the last use of the VM.

This was found with an AI coding assistant, which also drafted this
patch and its changelog. It has not been reproduced, and the change
has only been compile-tested.

Fixes: b74fae5492d1 ("drm/msm: Add VM_BIND throttling")
Cc: stable@vger.kernel.org
Signed-off-by: Jiwoo Kim <arpe1618@gmail.com>
---
Independent of 1/2.

 drivers/gpu/drm/msm/msm_gem_vma.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index 0cf518420656..b4b284ca5b38 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -775,7 +775,6 @@ msm_vma_job_free(struct drm_sched_job *_job)
 	job_foreach_bo (obj, job)
 		drm_gem_object_put(obj);
 
-	msm_submitqueue_put(job->queue);
 	dma_fence_put(job->fence);
 
 	/* In error paths, we could have unexecuted ops: */
@@ -788,6 +787,12 @@ msm_vma_job_free(struct drm_sched_job *_job)
 
 	wake_up(&vm->prealloc_throttle.wait);
 
+	/*
+	 * The queue may hold the last reference to the context, and so to the
+	 * VM, so put it only once we are done with the VM.
+	 */
+	msm_submitqueue_put(job->queue);
+
 	kfree(job);
 }
 
-- 
2.43.0

