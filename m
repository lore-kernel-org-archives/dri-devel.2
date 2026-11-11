Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F19D60A2613
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=NVhvDbIr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35F6910F963;
	Wed, 11 Nov 2026 08:22:48 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB4E010F920
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 08:06:23 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-6b577addee9so4036505a12.1
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 00:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bairaktaris.de; s=google; t=1794384382; x=1794989182;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3LLEGJE7y5aPT+HnIU6J6m7BGoZ7itZoJV528pdc6LI=;
 b=NVhvDbIrIekNLUo7qbqyZTUiZXpzEW5+rbVGqLAUgQAeJ9CiM3MKPsCs85HDxmtUcM
 H7d2YgCuiAY098U6/kFABkQOxWPgHytxPKXNOrJGpOMBgGrKWc9ixj6QtZaXHC8bJ/yj
 zBRykmGpRAVhD5f14/uYloE6yqjtEBl1RnSY6YUZOng403NTmgt7AWrc+zGrIgIq8IOY
 d/Eev/2jiKYU8X+JmuuizRy0e4MOTzdDlMP5wZoIVHf9SNZkiJ25JJPpDVjVItLfhfEH
 rO9LVJcXIuUuRHeTJ+ueg9DYAK4FRjztP+NwEgXSegCFFDLX4kDTOvfOBI3czq6gcd0c
 X0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794384382; x=1794989182;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3LLEGJE7y5aPT+HnIU6J6m7BGoZ7itZoJV528pdc6LI=;
 b=ITeze6+k5RxvUvJxRJNlECj2oCDhFPtudMxkdxm+QbLi3scTL48Va7EYWGyIRmPr/g
 dcc+2rHA4Ejy9UjF7CqiUr6raK51nx140B14F9cMvEizzL/QoZ+0Iq9pat1i/zGLH3bA
 ZxlsL7/1z1jdwUUMus+l3lWnFJNoUwEaHzFH02+e6HuzTglGYfj+LWL11JEmVa8NApuE
 bWvLkoQzTF6Bk5oZ4mtcbQvg5BqsjIfmvFh5V6fZQjyjfcr2bwSP4tCyE2T1OPP2Nkgn
 zTK0wcgEqolXQ7AIP6VEQfMDIFi1+qeKaCYrWipEa7pSB17sbbvxtYAvorSEcrWpp0nF
 FpSg==
X-Forwarded-Encrypted: i=1;
 AL+hErEh6HfRxltuDXx9BFdZmOnsE5889V713qGN/R9c5T3XCkN0FAF6+MNMOXiJ0s7AY7fbvgd9FlysqBA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+6rbfFznjr7y+0TWytByeuFh2W0eD2ohHkpfZMsJiw6JpRaVlS
 DlZo60HUtl8BSrKRP/NTspE8YZU/noy1TAA4ayVGrlJsUnjfWEPDUVY7fOddhCpqVw==
X-Gm-Gg: AYBFou28bbxF3KhkKYhLu3MD5TpThOYzAn0l91qXNW6tQv8ijH7RNuFo1pJLcAbmT6H
 +HwY5LZ0QLTkzf30v5hS/noWZJql4Qpyk22n6OKmtOe+yRalJt3ZZVvpSf1gwyILfAJ/P6EauHh
 3/tJFcZFv6G4lm4YFUCQz+9L6Kmx+wiVFIbqNwkCBlVLWK4KESzzpbGVjyMIeWCHedaeaJQ/6qH
 7+UFSFNrE2/h55mG9uKtSb69vr0WKq0Pq+b+K/xWKkxqLuK2r+MIUYO1vLrfb5a6lzUe5oLO6qd
 JQChJt4rVApzS9A0GvE4QeSzAGNNuScN1IYVdfBJWUr0XS42VKdRz854NVAvDxldFiaYqMYEgv2
 0TUWYI6XHFffnjCOkXrH9TaUkk3lGXhFdcHeYXFw9U6/mKC8l4xLd5l7F7N6i+1BPF0lttE5Niz
 SvOdrkPjcrFcK8fnmnl1w1M88hdRo60yStx/W6OfKzZBcyTEbhiwPGdWg/uF/UztFtp4KJUOo6W
 XKqy1WDS1GMy+JTUO7wZQIpX2CiEEItm5a7Xg3U/tuMS+WnoNNFwAIyKsASxrNHEf8jcdw3yS/x
 qcGISFm2gPZMu2v4JX35O1F3o73nRH3hT8Hc9sUIVlf/P/UN5l5p7RfbIzy9GhooltwqwasIP6b
 zHoLkzY9/Mox9y+Y6DWXPy1jJyzVifGsCWCMokBXKojZDVi3DDnPB9oULV6BhAwXoFRiK6ij0dY
 m3uKquWJqhYJjJ0cb+pdap06I2N+lQS1bubWjQjccXK9Wszrnx99V/uS6gsE3alqwCIXiZcA2m1
 DRRnjXEPdJv+zzc07SlMjf4R0HUHicpg/T1UyyDLncpjIztW6g8ETUQJWxdWbyvQnuQgC+sjI3v
 Mki2Ldw9TE7TH2cjumY=
X-Received: by 2002:a05:6402:a646:b0:6b1:8818:1090 with SMTP id
 4fb4d7f45d1cf-6b7773f30d0mr845593a12.22.1794384381940; 
 Wed, 11 Nov 2026 00:06:21 -0800 (PST)
Received: from Desktop (p54aff574.dip0.t-ipconnect.de. [84.175.245.116])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b75790875dsm2075683a12.34.2026.11.11.00.06.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 00:06:21 -0800 (PST)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Sean Paul <sean@poorly.run>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm: Keep objects of queued VM_BIND unmaps busy
Date: Wed, 11 Nov 2026 09:06:19 +0100
Message-ID: <20261111080619.244138-1-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A VM_BIND UNMAP closes the VMA when the ioctl runs, but the pgtable
entries stay until the bind job runs vm_unmap_op(), and the job can wait
on a caller-supplied in-fence for as long as the caller likes. In that
window the unmapped object holds neither a pin nor the job fence:
vm_bind_job_pin_objects() and vm_bind_job_attach_fences() only cover the
objects named in the userspace ops, and an UNMAP op names none. The
shrinker then sees an idle object and purges or evicts it, and
put_iova_spaces() no longer finds the closed VMA, so the GPU keeps a
mapping of pages that are freed and reused. The unmap half of a remap
and a MAP that replaces a mapping take the same path.

Reserve a fence slot on the object when an UNMAP op is queued, and add
the job fence to it along with the fences of the mapped objects, so the
shrinker treats the object as busy until the job has run.

Fixes: 2e6a8a1fe2b2 ("drm/msm: Add VM_BIND ioctl")
Cc: stable@vger.kernel.org
Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
---
I used Claude (Anthropic) to help write this patch.

 drivers/gpu/drm/msm/msm_gem_vma.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index 8b702422030af..d12df7e42fce8 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -473,7 +473,17 @@ struct op_arg {
 static int
 vm_op_enqueue(struct op_arg *arg, struct msm_vm_op _op)
 {
-	struct msm_vm_op *op = kmalloc_obj(*op);
+	struct msm_vm_op *op;
+
+	/* Slot for the job fence, see vm_bind_job_attach_fences(): */
+	if (_op.op == MSM_VM_OP_UNMAP && _op.obj) {
+		int ret = dma_resv_reserve_fences(_op.obj->resv, 1);
+
+		if (ret)
+			return ret;
+	}
+
+	op = kmalloc_obj(*op);
 	if (!op)
 		return -ENOMEM;
 
@@ -1419,6 +1429,8 @@ vm_bind_job_prepare(struct msm_vm_bind_job *job)
 static void
 vm_bind_job_attach_fences(struct msm_vm_bind_job *job)
 {
+	struct msm_vm_op *op;
+
 	for (unsigned i = 0; i < job->nr_ops; i++) {
 		struct drm_gem_object *obj = job->ops[i].obj;
 
@@ -1428,6 +1440,17 @@ vm_bind_job_attach_fences(struct msm_vm_bind_job *job)
 		dma_resv_add_fence(obj->resv, job->fence,
 				   DMA_RESV_USAGE_KERNEL);
 	}
+
+	/*
+	 * The VMAs of unmapped objects are already closed, so the shrinker
+	 * no longer sees the mapping.  Keep the objects busy until the job
+	 * has removed it from the pgtables.
+	 */
+	list_for_each_entry(op, &job->vm_ops, node) {
+		if (op->op == MSM_VM_OP_UNMAP && op->obj)
+			dma_resv_add_fence(op->obj->resv, job->fence,
+					   DMA_RESV_USAGE_KERNEL);
+	}
 }
 
 int

base-commit: 1e59855738454b14021b64115f0090eafc7526ae
-- 
2.53.0

