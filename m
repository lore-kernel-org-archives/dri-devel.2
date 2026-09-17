Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BDF8C982D0
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:36:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75E2F10E686;
	Thu, 17 Sep 2026 08:36:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="qihWSfb2";
	dkim-atps=neutral
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE16D10EC43
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 08:12:11 +0000 (UTC)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-396ccd4f99cso542794a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 01:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=snu.ac.kr; s=google; t=1789632731; x=1790237531; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=INycUrmvpGrxYHCE44iGg+M6064+jK2e/qtdtHH4BSQ=;
 b=qihWSfb2APZHggF81P6aGfL8UkzBDhnKwzPuttPFXw9dwZdD7B4+NsYnFZK3fw8ov2
 0pBPNgtqszEnT15h6z/LcrrzKrHY+5U4t97+wgnQavFXEfbR5naGB6bGStttvdTO7Ox6
 vpkNJIg764x+cqsfUZBoUnGHUVyxW+DtHEDm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789632731; x=1790237531;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=INycUrmvpGrxYHCE44iGg+M6064+jK2e/qtdtHH4BSQ=;
 b=ZNgGyNWmrmtaAByQUy8WbJ1nKd+zO7p3Dg7aoPLZFUYwxQyZIOcfs9vsDNd50UQu3i
 WFDPe/9fNB9XdjXjN0aVhuvc0dUf91diGuWQauIkZcjL+YGIrcNn+QsQo2E7MiXyODl8
 eOvXAM0m6KFktVssWVdn6MkFiqI6/Sv3UqYH1VOAH0BZvQRd0XHg1t4Cjd3Htt8MQYqe
 8S+xhl/vjtO0rUDqEVv8JzfHOwqtS5GDI6Vh7icWFunBy5DUBiqnDzRE8tyvGjPcT7yf
 KZL8GQmaQwD6Ln6caN+nZzTI05E8uy0ypGccQtsTEkW78zGgQNwZ7YPQRE4ygMMhUVu5
 yPSA==
X-Forwarded-Encrypted: i=1;
 AKwUvByJANIe66HFlO973KY2I/EPsFcuS35Ej5xEKUoXwo0CmGA7WZAqXQSvL/lcIg5dKCwDC/oweP67PkI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kCleKuatMtmh8zGPy7eXHkp++MNwzemou4UMSsAM54hutBhXPh
 KzgX8ULQWAQTTMrMeWlqLRCnhSG1ZWHxAUSHz7g5rpi9SEj3wXSLDmpTTEGZ4tZtrU/h2sw4rX2
 Bgp99+t0=
X-Gm-Gg: AYBFou3ar30xsrfoPg6XxODF8k4+AdeaZOujctYDaTMqQPtykagcMM4t9qc7VUuOE26
 Oa8aRfMyruhk5trD9wmWed3Il4FUxb+F4IyX5aCmAsPjZuFf6HBmPOZ0BY9/gI34HhgqihSNgy0
 5mTeNvuRM9pHvmF7Nav4kZf2CXEiF05cSU7+gbO7ZEQOo+XGruU4MXhMHBkRn8d3456nCTDqOkk
 9qYo8895N6QU/YY8CYOJJEaWe82lSsUxd06VYMZdiG/cd32oOAbwOFdzwO9yKwsmE7TZ2g4tdfw
 VF2cYLImT4lRsKHW6rdUAN0A2nWdLkUwIiQMYxJpeiAi7YKtAaRE6N6nfo/juzE3tcmQQYf+lSD
 yu1YEtu4BEFWJ5YkRR3p3PX44/pTj5tcIj4FkkNV7QFxVkA2TYU7ptVwS8BqB+YaMEipwKoaBQu
 dW6NfMsJwu3T+xBbBx00BmLqmodedswasZ8zRQZ74U6dFj4SpAFXyjtXhqL4qDwjCKZLdCKwTn1
 SwNnA==
X-Received: by 2002:a17:90b:254a:b0:39b:ac66:bbc with SMTP id
 98e67ed59e1d1-39e1e2ee271mr13586772a91.7.1789632730722; 
 Thu, 17 Sep 2026 01:12:10 -0700 (PDT)
Received: from nina.. ([147.46.174.17]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e35e732d6sm3822361a91.11.2026.09.17.01.12.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 01:12:09 -0700 (PDT)
From: Junghyun Park <mastpark2001@snu.ac.kr>
To: l.stach@pengutronix.de, linux+etnaviv@armlinux.org.uk,
 christian.gmeiner@gmail.com, airlied@gmail.com, simona@ffwll.ch
Cc: etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, jjy600901@snu.ac.kr,
 Junghyun Park <mastpark2001@snu.ac.kr>
Subject: [PATCH] drm/etnaviv: reject read-only userptr BOs as perfmon targets
Date: Thu, 17 Sep 2026 17:09:42 +0900
Message-Id: <20260917080942.1258716-1-mastpark2001@snu.ac.kr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 17 Sep 2026 08:36:29 +0000
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

submit_perfmon_validate() lets a submission name any buffer object (BO)
as the target for perfmon results, but the kernel writes those results
back into the BO on job completion: "*pmr->bo_vma = pmr->sequence" in
sync_point_perfmon_sample_post() and the counter store in
etnaviv_perfmon_process(). It never checks that the BO was submitted
writable.

An unprivileged user can register a read-only userptr BO backed by the
page-cache page of a file it can only read, via
DRM_IOCTL_ETNAVIV_GEM_USERPTR (userptr.ro = true, pinned without
FOLL_WRITE), then name it as a perfmon target in
DRM_IOCTL_ETNAVIV_GEM_SUBMIT. etnaviv_gem_vmap_impl() maps the CACHED
BO PAGE_KERNEL (writable) regardless of userptr.ro, so pmr->bo_vma
becomes a writable kernel alias of the read-only page. On completion
the kernel stores a caller-controlled 32-bit value into it, overwriting
the in-memory page-cache contents of a file the caller can only read.
All etnaviv ioctls are DRM_RENDER_ALLOW, so no elevated privilege is
required.

Reject a read-only userptr BO named as a perfmon result target. The
submit-time BO_WRITE flag is not usable for this: it is caller-supplied
and describes GPU access, so it neither reflects nor constrains how the
userptr pages were pinned.

Fixes: 249300c740e5 ("drm/etnaviv: add performance monitor request processing")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5
Signed-off-by: Junghyun Park <mastpark2001@snu.ac.kr>
---
 drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
index 1a77a09b3..e44fa40fd 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
@@ -322,6 +322,13 @@ static int submit_perfmon_validate(struct etnaviv_gem_submit *submit,
 		if (ret)
 			return ret;

+		/* perfmon writes the result back; refuse a read-only userptr */
+		if (bo->obj->userptr.ro) {
+			DRM_ERROR("perfmon request: BO %u is a read-only userptr\n",
+				  r->read_idx);
+			return -EINVAL;
+		}
+
 		/* at offset 0 a sequence number gets stored used for userspace sync */
 		if (r->read_offset == 0) {
 			DRM_ERROR("perfmon request: offset is 0");
