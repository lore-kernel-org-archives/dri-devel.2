Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E19E9381A
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 05:52:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5730C8961D;
	Mon, 13 Apr 2026 05:52:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="tF3P/3Dg";
	dkim-atps=neutral
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 066068961D
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 05:52:39 +0000 (UTC)
Received: by mail-qk1-f173.google.com with SMTP id
 af79cd13be357-8cb20bcff5aso372394385a.3
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 22:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776059558; x=1776664358; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jSGzBK0vRtSGgnqUijtqcTjFMvAPUSIRJpU4Molx+ao=;
 b=tF3P/3Dg/yuhv4PXiNfWGZ/id/2owgvf03bSaQ16fiZVZ1TqV93byYfpoqfs5olBWb
 5NFufDW9ohuxvz/C73EtSw2Z5lsAZQQQWDOTZzL6shO0HdN7DRGVxmOjQpt3wfVdPL80
 cADZV24s1JkZmvIGTCM0nf5T5p0hJFc6iCTxgF5HSLjarNe6Pjrks8oG/u9APiivqJTj
 inqyQbFdqywOWrqDQskKiJQo/jIxVyAZZKxbsdPOVgrfnAKJIMi4zu2oP8YAz9Ob2Rtk
 gCtWxFwNjKcRL30bkxXSxkg9mNCRmYwpJT0ShFR1Op2B9QKLdSy9Ftn4c+sCrJrzjFxW
 RwIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776059558; x=1776664358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jSGzBK0vRtSGgnqUijtqcTjFMvAPUSIRJpU4Molx+ao=;
 b=ERWkzIaa4kkRaEuwgqBL/1egQGfvYkzS49cPAPFucq71EP6bMR0WTFrzlyaVSwxgzf
 doEqrG57eh+cLkh0J7p+M1BtCohq/4hrAsfSKHUIu7M9c2rmzQpTvuqQQRfUi4N/Lc0m
 5RIYlRWLJVtVrRDMy/UQwqNQ0kXQBrXLYYCvkqVM4Pgbn4ATb7OowKZ1QM7S2AFautAV
 Fm91A1HNTCnNkyH4yP5Jq2+SqCSonJECV3JzHgFjunCH+9Hta3aj3diSrolK/xyiO76U
 eEU7hIOnrtu+p61BoUQoaJq3RUifvEx4lfWlrFz+e6SMrL5AF0gB6NEkjD8ypc887VFN
 rXqA==
X-Gm-Message-State: AOJu0Yxg8fQoO1h9W1Naa7D9SScIEeiY4cIzc1CDtExOy2nL4yQMQeW0
 E7n7YVLdPGQT9q9XzP7wtL7x5vuh7jFU8Ah/DlO4ZfMQxHTccsy2tqH96hoLSAc3FJhuvg==
X-Gm-Gg: AeBDieuIUaR0F8vm30nNh3BaHkxub/7W8FXN6MyiG4oU6qS8FYGRgdHKTVwZ+KPR4+H
 WI0XTlXR5M1dPC5KgiXSZwmRSRmeqegJRPbD7c3VX4lBg7VsVvbj5LLylq3Ifeuy442JDu9yws2
 EtVboYF39YrIctH1WxN12F6oA0wWQgoDqspyYHCC8GkAZ0tRIm8xUgpvhr9tK3g+e/hJ/mN/6qB
 Dpl3KrnUWeLUrh/J0/wdmUhSQkoBznzkXn0GPtLpdHoJCdJkj68o3BMOvqGB8WCA+0r6OK8vO0R
 lL9oMsq70zpU5IXp0Nti04dQ587Ogt8AgFz7JJ7AMFVe3DoKhBdajAPgE3fpahGF70/NXm3mo1s
 m9PM0jlOsrWKO8AJYolca2SD+zAEvrkkQPJlOCSxuU4vUGN3ka0daNevIbqdk76+oSp7RZAEDvu
 VwVxoieqqjGZJkj05785lXN3OCSTfHrcdwy0+NCJjIH75P2A/jTif8WHkHYS3KGlhHkT0yI0VAq
 4FJ/EwftnvD55AmeDdodL+HMPM5
X-Received: by 2002:a05:620a:2944:b0:8cf:c56f:cadd with SMTP id
 af79cd13be357-8ddcd02484bmr1777722085a.13.1776059557751; 
 Sun, 12 Apr 2026 22:52:37 -0700 (PDT)
Received: from
 TDC4045031631.e0cglfehwr0e5gttmepj3hi3hf.ux.internal.cloudapp.net
 ([20.63.37.123]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8ddb66587e4sm804111185a.19.2026.04.12.22.52.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 22:52:37 -0700 (PDT)
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: mcanal@igalia.com, itoral@igalia.com, stable@vger.kernel.org,
 Ashutosh Desai <ashutoshdesai993@gmail.com>
Subject: [PATCH v2] drm/v3d: Limit ioctl extension chain depth to prevent
 infinite loop
Date: Mon, 13 Apr 2026 05:52:30 +0000
Message-Id: <20260413055230.3349114-1-ashutoshdesai993@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cbcb794f-0d82-40b4-a9a5-6aca99e8c434@igalia.com>
References: <cbcb794f-0d82-40b4-a9a5-6aca99e8c434@igalia.com>
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

v3d_get_extensions() walks a userspace-provided singly-linked list of
ioctl extensions without any bound on the chain length.  A local user
can craft a self-referential extension (ext->next == &ext) with zero
in_sync_count and out_sync_count, which bypasses the existing duplicate-
extension guard:

    if (se->in_sync_count || se->out_sync_count)
            return -EINVAL;

The guard never fires because v3d_get_multisync_post_deps() returns
immediately when count is zero, leaving both fields at zero on every
iteration. The result is an infinite loop in kernel context, blocking
the calling thread and pegging a CPU core indefinitely.

Both i915 (stackdepth = 512) and xe (MAX_USER_EXTENSIONS = 16) impose
an explicit depth limit on the same pattern.  Apply the same defence to
V3D by introducing V3D_MAX_EXTENSIONS and capping the walk at 7, which
matches the number of currently defined V3D extension types.

Cc: stable@vger.kernel.org
Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
---
 drivers/gpu/drm/v3d/v3d_submit.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index 18f2bf1fe89f..8951909198c2 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -11,6 +11,8 @@
 #include "v3d_regs.h"
 #include "v3d_trace.h"
 
+#define V3D_MAX_EXTENSIONS 7
+
 /* Takes the reservation lock on all the BOs being referenced, so that
  * we can attach fences and update the reservations after pushing the job
  * to the queue.
@@ -802,12 +804,18 @@ v3d_get_extensions(struct drm_file *file_priv,
 	struct v3d_file_priv *v3d_priv = file_priv->driver_priv;
 	struct v3d_dev *v3d = v3d_priv->v3d;
 	struct drm_v3d_extension __user *user_ext;
+	unsigned int ext_count = 0;
 	int ret;
 
 	user_ext = u64_to_user_ptr(ext_handles);
 	while (user_ext) {
 		struct drm_v3d_extension ext;
 
+		if (ext_count++ >= V3D_MAX_EXTENSIONS) {
+			drm_dbg(&v3d->drm, "Too many V3D ioctl extensions\n");
+			return -E2BIG;
+		}
+
 		if (copy_from_user(&ext, user_ext, sizeof(ext))) {
 			drm_dbg(&v3d->drm, "Failed to copy submit extension\n");
 			return -EFAULT;
-- 
2.34.1

