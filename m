Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E674D606A325
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 02:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ovih68NL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28DA510E6DF;
	Wed, 18 Nov 2026 02:08:01 +0000 (UTC)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3DE910E6DF
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 02:07:53 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-33bb5afa736so4388eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 18:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794967673; x=1795572473; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ecuacG42mOJlCKP+Xm2vtenahXDM0oGaAEC/qmvo8Ow=;
 b=Ovih68NLCsaFWqoWjhi5+QsZDAcD2M0oAUlLoAcm46T5HOfGZ8lGTveUlYAcya0A0T
 hFN6MwvhF4NlW3tCMwCYWeqkJlDzQ9qK2Sr4woFrQPo7iPL/42eXLXPwhQaUJnqdPRPQ
 4b0Z31wSYwKhiJPnajmCvHRsXkKQp73VrWcUqL2jin3gEiXMnv0l3fWsi4Ol2vIZYLG/
 rklWFjieoTd//JfeeUQ34GY7i5NbOv347bsG0dNZgJq5tV0dmXKXvh5SqQK5s9o27qTU
 Hs01mPJY+M6rPI2y+UO1/ABPzTP7idDIKHPqdVshKdPznXetwEhZVBYZnBvKspU72Zbx
 Rc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794967673; x=1795572473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ecuacG42mOJlCKP+Xm2vtenahXDM0oGaAEC/qmvo8Ow=;
 b=td1H3l6HWo/etmTXz1F82RiKZtC50C0WwtDwHf0wGTxpdpb2JP6eTUjQ9LqMTRmHRJ
 t/8t1Yu38m7bE7UeQqYc9w5QMMNgrO1cGlZRILyy7bqFFVAhDGHomrWCpEQdp5ifAF0A
 pGWsz3baGnqymtPBJ0a8+2vWXgootDzKdcd5ljWY9rLppEQMNji9eLeUaEPsVmKi2aOo
 blwVTtMQEMq2Y8ObCsceOWP7FAEeCG0NLbsTCTiQVpJGZIZm1Q3yjEdECwgHWN4MCXwn
 vnyh42PpfJjwB8fnMDio/KMmIGlrOqymFosJpXw2L8ayoubp6DNmDt3AJ5qv66gCI4Xs
 8d5g==
X-Forwarded-Encrypted: i=1;
 AL+hErHMfBNb51ECzf3OKn2fQsHKzHuCsRiGk1Qvu3r+E4QbqNR6jer/iR+FQH1oeDleG3fO6rWdv4fQ+uo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8x5u+7chO37+ginQFwSLfgZPv1A2dPT0MHJZyHJbI6qzxnyBbu
 3b4r9TarZ6RmKRPtNurbSO86YV5Kd36Z+dnWARgfCT9tNVa+E4MGbre7
X-Gm-Gg: AYBFou0C7JPXGfE8xJtFq027yg34IvlwB30m+pCKqpPUjZoaSbs5FI36FRrE09sTBwQ
 0tlqp2bTF7omoxJ3Ij68hEp/9fYOlx5MHJP7/ks+OCXk8wemi3aeau4gVw+hjOdYHJIvzIfZyvm
 fv3eDJK60Rn1zykEwcyAUCM/aC2v9sfDY5s10tzTBQeys4SMdjveIE95Q+AksxiORA8Vtm9GNNg
 r+iAl/aBRovSdkZt22D/srwmvTzhqWCv5GTRO2AtBlj8CMRnlfXVjf2Z1LN9hF4IQ83rx1UwS5e
 JqilB0KitePCliQ2WNp4C+1tZ3/kC9zXgjwMiCwIW/iuOUeK2GSTrqi1EycV5pWNn7UdqbJo3Lx
 1IFvXA/MRgYXcPC+KfLs3OX0/3JXAgIBEe7+8rxoqNyQPUbKhtF3YbzaJ4H4Md9tYXFn9vdDweD
 5gjGJPJeGS/dysSO4aOti2SsCRH9SHWB7cQ7EDLFDBaJ+ZqkBi4cNsPH/k8EmPp6o+UPJlQjwag
 OhaHZpNB8QeL0TwGmuzvzyZRGNF6KGHXW2ipmk1B94jVcBUDKTnsEn5I9CUgDxAy1ddtTb8Rd/K
 eR5eWT1/iP0JyIcfyHU6YlN5ihGUjmE34UjOnkR8VVlwm8ytd8Lb9V/czDnYsKKQdGfSBlf+zZQ
 hiW5k/GTJ2b+P/9GKOPy5ePC33jSv
X-Received: by 2002:a05:7022:e801:b0:146:ffa9:2117 with SMTP id
 a92af1059eb24-1b543b829c9mr1993620c88.1.1794967672916; 
 Tue, 17 Nov 2026 18:07:52 -0800 (PST)
Received: from DESKTOP-CJ1L666.dankook.ac.kr ([220.149.255.57])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b544784008sm2862327c88.5.2026.11.17.18.07.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 18:07:52 -0800 (PST)
From: Jiwoo Kim <arpe1618@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Julius Bairaktaris <julius@bairaktaris.de>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH v4 5/5] drm/msm: Put the VM_BIND queue last when freeing a
 VM_BIND job
Date: Wed, 18 Nov 2026 11:07:16 +0900
Message-ID: <20261118020716.1698-6-arpe1618@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118020716.1698-1-arpe1618@gmail.com>
References: <20261118020716.1698-1-arpe1618@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

vm_bind_job_free() puts the job's submitqueue and then wakes up
vm->prealloc_throttle.wait. The job does not hold a reference to the
VM of its own: the VM is kept alive by the context, which the queue
holds a reference to. When the job holds the last reference to the
queue, as it can once the file has been closed, for example when a
killed job is freed, the put can drop the last reference to the VM,
and the wakeup then uses a VM that msm_gem_vm_free() has released.

Since commit 01c8d1f385f7 ("drm/msm: RCU-free the scheduler-containing
ring and VM objects"), msm_gem_vm_free() frees the VM with kfree_rcu(),
but vm_bind_job_free() is not in an RCU read-side critical section, so
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
index c526409f451d..3e9657982291 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -904,7 +904,6 @@ vm_bind_job_free(struct msm_vm_bind_job *job)
 	job_foreach_bo (obj, job)
 		drm_gem_object_put(obj);
 
-	msm_submitqueue_put(job->queue);
 	dma_fence_put(job->fence);
 
 	/* In error paths, we could have unexecuted ops: */
@@ -921,6 +920,12 @@ vm_bind_job_free(struct msm_vm_bind_job *job)
 
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

