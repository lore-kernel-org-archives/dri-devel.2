Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128F4606A31F
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rmsa4f+h
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 470D410F31C;
	Tue, 20 Oct 2026 07:36:51 +0000 (UTC)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 914E010F057
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 16:17:39 +0000 (UTC)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-35829219da8so3889111eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 09:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792426659; x=1793031459; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DodzdsbvDAWeDZMO/tmg1Z+RgzxRjG1yETm3wmiwdhs=;
 b=rmsa4f+h4oKEh7YyVfrhUblzDuhXllQ8RfSt7sqRf69MGAGpS7nO4e41sAUIQUWh/6
 LUVS4olP9f14eaMAGMx1bX+veamD/hFQHsUTci2PMZXqvXb1KnBYC2m6vPDuN7mYsiG8
 vHEQOxXBnd7gUbN5JoHupaEWUUdhmF4k5oybcq1edpsNldaxnGTIypGGy+lzAx4JlwIw
 XVKYxGbalqQ4qUQn/NrYMEGbnK0YGrBmhScbhxxI64VjiMFby5rZO59DG03qrVKxD5ba
 MiY5YgJCPSIy09FsQRW0/EFJ43Iickkw/yUBOr2U6c/zmxYKiKYqV0YsN+FDaCwmdsC2
 LH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792426659; x=1793031459;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DodzdsbvDAWeDZMO/tmg1Z+RgzxRjG1yETm3wmiwdhs=;
 b=2XfZtAfMiNTzuBJzcNPKeSAJYPC4YD9mYo+B0Pzj1OZoxhg1go60iktgETKFHxwvez
 uhEKGJ0ozsfu3HCMjQ92fgHJ4Pu+iG4FY49a0/rjvqlApWUhV7004abSuQg9HLldk75j
 fG5NDr95v3DWXxuBXgnFwlwuq/YYaC96OvUtvIP9f3ZVA2wF4N8dhiZ3qi4qLCC/nozJ
 LXCDE1MsnQDJCmdnE5QtIFeUjsJ+myETwHeXJO2683NL5yArm+22CCxYkZcHmHtH0+mX
 dchktobh0VTU+n8FqxT8nuVwgDHamxwWulmiFNBTU9N/SJI/Bxm9JfX9+B6ev0rvzRzW
 b6nw==
X-Gm-Message-State: AFq9FYJXdc1vh8EPaauaQahMya5mljx2puewubVPbkolB5drVpAfxTgV
 EzIFyYMMxsGSmd5D7A50tsfTJ26k5KLjW/8ZLKFFXH8xZ+eY8QAKhOCm
X-Gm-Gg: AYBFou3OVFiNeFTDN0nV1L/R1tZSrRw3Hgw226YrRBwdpI5dP7UbsTF7IlLXz9Zbl42
 a+9bLUs7g3g3hPEHlD0h7gLPYuhjDNYKodhPUUdgkTa+XN4dxy699YocRx5onv3+xcqGR1/RXCA
 oMZ8LCXsguRsJ2zhzV2PAZ54RPxAPWGi+La4SH86AJLefxARukrHSaxyMLWI2uhCLJyzrlf2spK
 +y7cRTUM6jQiNGz5qcAKjRk7X2p87Jej3EAjs7J6yt17EPNM4X716n6vjyMcnTp5IL+BaEY8HL3
 jk9d++glfPnuWqjCeTIhIqj0J4IN9GV8sH5StippyoVYTYWtIpHSENj3uJn+Kh6eFFi3sB/+63j
 2/PXurV3FgQP5/8LQHqEQagx/EO5EvtAWlDRTe22b3cp6soD3MqhvNdjNwgdCrdnRUe8RsgdvVC
 QQX2vFqRWG/je2t88ct4jeAkLO0hJt1YggSDP/JWn/HBwTIUeXzICjaeMMI24jPwxk11OxzLESg
 BHNJ7SG7Jc=
X-Received: by 2002:a05:7301:6f0b:b0:353:7f47:8168 with SMTP id
 5a478bee46e88-3602e69d2a3mr13680943eec.17.1792426657937; 
 Mon, 19 Oct 2026 09:17:37 -0700 (PDT)
Received: from redducc.localdomain ([183.83.156.125])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-360813b63e1sm35064341eec.8.2026.10.19.09.17.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 09:17:37 -0700 (PDT)
From: redducc <sushmit718@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Philipp Stanner <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm: Don't BUG when a CRTC fence signals during a name lookup
Date: Mon, 19 Oct 2026 16:17:31 +0000
Message-ID: <20261019161731.2341-1-sushmit718@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 20 Oct 2026 07:36:08 +0000
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

dma_fence_signal_timestamp_locked() clears fence->ops on signalling when
the ops have neither a release nor a wait callback, which is the case
for drm_crtc_fence_ops.

dma_fence_driver_name() and dma_fence_timeline_name() load fence->ops,
check the signalled bit and then call into the ops. If the fence
signals between that check and the call, fence_to_crtc() rereads
fence->ops, finds NULL and hits the BUG_ON(). This takes down any
caller of SYNC_IOC_FILE_INFO on a CRTC out-fence, such as Android's
surfaceflinger, which hit it on a Snapdragon 8+ Gen 1 phone (msm).

The CRTC behind the fence outlives it, so reading the name after the
ops were cleared is fine. Only warn when the fence carries foreign ops.

Fixes: 541c8f2468b9 ("dma-buf: detach fence ops on signal v3")
Assisted-by: LLM
Signed-off-by: redducc <sushmit718@gmail.com>
---
 drivers/gpu/drm/drm_crtc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
index 63ead8ba6756..1dbd0e9db536 100644
--- a/drivers/gpu/drm/drm_crtc.c
+++ b/drivers/gpu/drm/drm_crtc.c
@@ -158,7 +158,13 @@ static const struct dma_fence_ops drm_crtc_fence_ops;
 
 static struct drm_crtc *fence_to_crtc(struct dma_fence *fence)
 {
-	BUG_ON(rcu_access_pointer(fence->ops) != &drm_crtc_fence_ops);
+	const struct dma_fence_ops *ops = rcu_access_pointer(fence->ops);
+
+	/*
+	 * Signalling clears ops, and can race with a name lookup that already
+	 * picked our callbacks, so only a foreign ops pointer is a bug.
+	 */
+	WARN_ON_ONCE(ops && ops != &drm_crtc_fence_ops);
 	return container_of(fence->extern_lock, struct drm_crtc, fence_lock);
 }
 

base-commit: 6a56f4f29711dd2da49f03a5b99ce53779e638d7
-- 
2.43.0

