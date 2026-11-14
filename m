Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208E0606A323
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Daj35KDa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAAD110F03C;
	Sat, 14 Nov 2026 16:25:16 +0000 (UTC)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7D5310E591
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 08:19:26 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-36dc4797082so208734eec.2
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 00:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794644366; x=1795249166; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C58R8Pgzd1hKqtVMoaWOgYvgQVTOllRn5nwLnk9mw7k=;
 b=Daj35KDa3FUpOICgbyj62ZRtNWNlNQSpDFfUQKlNYyJzpReE/nH1i4+ZZ4GEDTjyE7
 XKUXwQBquilRJmXN4LTHIcH9qlh9DT+yQyKKI6DEZxgiVdYFfS5doVn7vWL+dXH3KK7e
 U9nvQ5vp9rvNgqINA/UtNK4NOqF50+uqpqeMftmOAixbxYGdmRNSaIcDOYAdbTutKBtl
 rjzgvd+xAyad5zBrloJ5CVa0aZEW7yqW5xKaANIYBD+ASND6BY1SEveBS8mmbUb83I6H
 Z3/wAFUgx4iOydbnFgfcWy2TlB3/fALxvn8vTHpD0ojAEy6Fowtk8DBkighsJvq8lucU
 isow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794644366; x=1795249166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=C58R8Pgzd1hKqtVMoaWOgYvgQVTOllRn5nwLnk9mw7k=;
 b=h8K1mVLm7T+BngkAWriWts3egmNcFjM8qKlXwzNYQnfZOCjwVgwpDz+s4p1w+lHyuu
 8Ix6533Po5phNgOi4EfH63uZOwsAuvc/YuTNO+ReIH3U4X/Cn7jiSwJ0NvnVaeN3560P
 +IuI36uv4DVSvevcSRWrNPVRx8B4AnJ1hCGhFFZp8af1k1s/cMpxcw3IKSdtSkqByWc1
 G2GpXHKdQzsC876T4/MTEJVhYhPiv9KniSFg/cqrzYsbJexNc6644XQXv4Nba0nHvGwV
 OSnIA7KpWyT7hQwyBFnh/XVYgLr4sOwOLnGsl7QZTVYQgvW2FlG9qwtPq+Yt7lwc4+cX
 YWGA==
X-Forwarded-Encrypted: i=1;
 AL+hErFX7wz2r2PTavlB6Ejunr1TSz7aFOluuJCKGA76CGSPfZZPVBvlLqMW9SBQT1Kizbz/fnr9sb7GWpA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+SRFLCdA4nhHcENWFskkqSrTviqwQpwAfwfxNwJD32q85fAWL7
 RrRlNO/mZHRu5Uq0UhRscF52REHP8yrhMD91pkXyzztNH1UtjE0f5vGY
X-Gm-Gg: AYBFou1HLInqAA4lQQWHGKflWS8WNaBwMYci3VZBe34LQGBRT72qH1+03e+P+j9mvVb
 lZuhVSpLirK1pWO8xvvBt2T2Rq0AuCULGu3y8Y9YsPvbKZgwRSKqUfgNzm/EYm/WiwspOGBl+Ok
 hy2E/57tw5w6NQk6jdxlNCP/y+KkZHS+HXLXVBQavm027s7ugdjHCJsKaCnHJ0nsHqQFLLxWded
 ps1+XFT9qB99mD8fE2FiYcDoEmY9YcWxXRU6g8i4RHvm47H8YkG5L55n/oSsmPLL0jJPV1W/PpB
 9Ua3ZD3BMTj0OiIg5a9gWpoiOVlluSpkbGagvkMtMc4wbbwpSnbitx+f6K1PhUKVtHNdpcRN5X5
 slZM0FJVZ6ClnxkhsXL6yg5sTsD7QgvQWqWpvnmylTFDn9vZ1Gndx9vv+UzAvM8f8eklJpU9C+b
 GowAHJPbYM/Usbbh7uZWhxQqvvRs7lJc3R2+WBmzJNpO8qtoyOxoYAKAONnXrtXTEpp5bvvbCsu
 A1KjLNMGZFh3j0RT9zq6Qaq3FpWTKgMCCl5nCbiVHtXSfKdwx+NWMwK5rYFkl+KlKsYIJignDbk
 iaar7XSt2XviIpq7DNJ2+7vw31PfOOCKtQ5R9lgBbDvcNlE5EQPCuySaKGZEyNfcvRy8q15Xo5z
 kRWpAqI5s7RZzUdQ3p5jLeXts
X-Received: by 2002:a05:693c:881a:20b0:36e:66d8:1424 with SMTP id
 5a478bee46e88-3796047ff23mr7029007eec.0.1794644366120; 
 Sat, 14 Nov 2026 00:19:26 -0800 (PST)
Received: from DESKTOP-CJ1L666.localdomain ([211.198.99.62])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3795378d7e5sm14008333eec.3.2026.11.14.00.19.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 00:19:25 -0800 (PST)
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
Subject: [PATCH v2 3/3] drm/msm: Put the VM_BIND queue last in
 msm_vma_job_free()
Date: Sat, 14 Nov 2026 17:19:02 +0900
Message-ID: <20261114081902.1669-4-arpe1618@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261114081902.1669-1-arpe1618@gmail.com>
References: <20261114081902.1669-1-arpe1618@gmail.com>
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
 drivers/gpu/drm/msm/msm_gem_vma.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index b1fa1d749c2f..1bffade78623 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -816,11 +816,16 @@ msm_vma_job_free(struct drm_sched_job *_job)
 	job_foreach_bo (obj, job)
 		drm_gem_object_put(obj);
 
-	msm_submitqueue_put(job->queue);
 	dma_fence_put(job->fence);
 
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

