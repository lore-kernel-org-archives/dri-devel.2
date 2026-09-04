Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF35DC79F85
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 15:04:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5909D10E2A9;
	Sat,  5 Sep 2026 15:04:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jHcgrsfJ";
	dkim-atps=neutral
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com
 [209.85.167.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D71710FAF1
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 12:05:09 +0000 (UTC)
Received: by mail-oi1-f173.google.com with SMTP id
 5614622812f47-499f6e0bbabso660622b6e.0
 for <dri-devel@lists.freedesktop.org>; Fri, 04 Sep 2026 05:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788523508; x=1789128308; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sYrDdFiVD38RqgIzTk5IkPI7oe3vWfrIZd42ghxcZC4=;
 b=jHcgrsfJpWHqXcX1HHq206JOcGpJlrOpWD6iCE/KqKdBFk/ldAZCeGC0lE43KnKQ1r
 9tuP523NZ1JovU9+Y6ZpVCCOEjQcP+2oGbnINE08z8kO8sfT4BO6tLTvG2qpsM8uoaMT
 u9qdz4OVVBpgdM7hANXX5aCr/5xxYlIEOjWGo93vQ8Jmm+CktsylSDsyCocnPAJMNi8/
 m6RkFxt3YxA41sktGiEGmYO6LTVpuFLl5Y7sItXCJgv4fxJPTbJcIC/k4IwLYuweCjGR
 2govAWvEn2yDyJ+nBlv5Kw2JNHh+Bg+mmeqlyOgAdZUAMDBAc721/zH2hVDJgTXqi4Vi
 5mKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788523508; x=1789128308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sYrDdFiVD38RqgIzTk5IkPI7oe3vWfrIZd42ghxcZC4=;
 b=gxgdnL2X+UYGK2iJe72ZE/BBUREcN7WpE8uAvb1VIHnxMqtzV4zqzL2Kj8kOoQMo2Y
 zaabhpazTIYrUDInWodMJbvU04m8gSo16B9wXImVFZRer3T7USkNfo+FoSgAeAexG1Ln
 QqdNNsvyJ0sQxIZA8CemVTtH9D5o6RIX4YOHCaz8C7YV/b5gkYUpHrxx2Sevop9U0ulW
 mOmduGU1Dp8H/AK/0iNqQ3v2azQLhzklDF545OZscHZirTTTbRALdSyw9NcfXRyh5YAs
 iGpc3+bAyJHa/wpfE43wSO30wWb2fi0xjPlIc1mSvN6MfA2lhRJKmavWduDSPxUoBdxI
 2GPA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw18UB3tMiQT6GiaXAwjUjAc6hKuncKctq5NEVAYeGm8Up4BklRFdsXAE9emmRePp810IF0xywNj2U=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mC5fMYVOL2mnMl6bYA13g/n2jqi7iTZBny1JE/BprIqf4m5kUd
 aGxfvSlCxqcJZsVwD6JPVTaGM5AllmO8L14AVn8lTthTv+C/KM5we9yL
X-Gm-Gg: AYBFou2jXe5b0Hb5f72Yvn/Uwi6fDl//AS0xKmJqe7ywqDJp/m0YcwpoLHjVai06ZR+
 edIaRGARjgaR5VhGKvO+mLjlX4Au2DFhJNr2cyRymrNXD/2vga/IG9p91DHG7DiPXvBv2L74OpG
 TulRoTLPRECo8hj11J8CiNcWWTi5FmnaH9ToeLJMOwSsoH7wza/MUHl8mEi/j7+oWIqb8lWHlFu
 ltLZCW2X9xz3NnqrUTjRavOatozFuzXKBwnuSmu2IsfMlbFbOCW2+KBxm5B5B+Lk4mcL6eLWAgH
 qAuDocW+KFICK47VZVO2FsHA3/+71AOml6gAmMeLEWroIpabXVlU75+qaWhXoFHZsn2UpLp/zOI
 QxOZpD2dklUFakdyAyg1rPU0RlRVQZ2LQMXXbr/Hnc9AS0yyyEdL3cYW4q6TzjG/UVFZMRNeQpD
 eeFCkW7cTChyTaCtFixLnPZyQwQ2ZUbS4IFhP/Qz+8QnYUou40hLCozugW/TDasHCjKYGEFgIGv
 +PisElYCf3mDjE=
X-Received: by 2002:a05:6820:818e:b0:6b7:8415:d78e with SMTP id
 006d021491bc7-6b78415d959mr1361190eaf.57.1788523508058; 
 Fri, 04 Sep 2026 05:05:08 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339b8f787esm5770422eec.23.2026.09.04.05.05.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:05:07 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, Zack Rusin <zack.rusin@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org
Subject: [PATCH 2/3] drm: fix repeated words in comments
Date: Fri,  4 Sep 2026 17:34:17 +0530
Message-ID: <20260904120430.17224-3-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260904120430.17224-1-hemanth.selam@gmail.com>
References: <20260904120430.17224-1-hemanth.selam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 05 Sep 2026 15:04:14 +0000
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

Drop words accidentally written twice, reported by checkpatch.pl as a
possible repeated word.  Only touches comments, no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/gpu/drm/drm_syncobj.c                  | 2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c | 2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c        | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index 2fa170a29a62..fda036175a3a 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -85,7 +85,7 @@
  * With binary syncobj, all manipulation of the syncobjs's fence happens in
  * terms of the current fence at the time the ioctl is called by userspace
  * regardless of whether that operation is an immediate host-side operation
- * (signal or reset) or or an operation which is enqueued in some driver
+ * (signal or reset) or an operation which is enqueued in some driver
  * queue. &DRM_IOCTL_SYNCOBJ_RESET and &DRM_IOCTL_SYNCOBJ_SIGNAL can be used
  * to manipulate a syncobj from the host by resetting its pointer to NULL or
  * setting its pointer to a fence which is already signaled.
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
index b8d847101b13..dab340ffef3f 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
@@ -910,7 +910,7 @@ gf100_gr_fecs_elpg_bind(struct gf100_gr *gr)
 		return ret;
 
 	/*XXX: We need to allocate + map the above into PMU's inst block,
-	 *     which which means we probably need a proper PMU before we
+	 *     which means we probably need a proper PMU before we
 	 *     even bother.
 	 */
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index 6dfb45592d74..be3c3c074e75 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -339,7 +339,7 @@ static int vmw_execbuf_res_val_add(struct vmw_sw_context *sw_context,
 }
 
 /**
- * vmw_view_res_val_add - Add a view and the surface it's pointing to to the
+ * vmw_view_res_val_add - Add a view and the surface it's pointing to the
  * validation list
  *
  * @sw_context: The software context holding the validation list.
@@ -367,7 +367,7 @@ static int vmw_view_res_val_add(struct vmw_sw_context *sw_context,
 
 /**
  * vmw_view_id_val_add - Look up a view and add it and the surface it's pointing
- * to to the validation list.
+ * to the validation list.
  *
  * @sw_context: The software context holding the validation list.
  * @view_type: The view type to look up.
-- 
2.48.1

