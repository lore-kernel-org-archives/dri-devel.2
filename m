Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93992CA5FAC
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 12:12:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3D2610E58D;
	Wed, 30 Sep 2026 12:12:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WNA4MNor";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B52C10F1DE
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 06:59:19 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396ccd5cf02so2582047a91.3
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 23:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790751559; x=1791356359; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XY/E2j9XnFuNBK9WaF/nFTrbzu9uvpf+6HkIq2bPSfU=;
 b=WNA4MNor51ep913JKNLcZ1jLREgIQU67szfWJqJmarhcqxlKSfm2n1x8t0N9r/k+j8
 nQNUDwoheLk4BujqLFtHWIDWc6SsBFqdMQOyZLV6R+ZMys+elZiO7d+6rkHYb7qYujVP
 uWfC9ye/uNPkHqrvNHaWBN9qzztMcN73BxZYzIWzI9Esnee9mge8gkcLpQMVBSTBQIpC
 XPM4tdRdh2DBPfcETN/XpsUdxdD0/YOd6eECetA4bjrvTSC14X62UoTn6Hs2CzEJhoFk
 4CgwYo/Buho1z31EFkQjScm0Pg65zCs5y/VmPbDaELaRaRfnSS3hHOzxwcL05WX8Rw0E
 5Vqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790751559; x=1791356359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XY/E2j9XnFuNBK9WaF/nFTrbzu9uvpf+6HkIq2bPSfU=;
 b=ySUVY51gEooKlRNb/DEU7nrWVJWJJuA1wDgJC3rCDREuKUAnzj5cwJR9A/l2T5+Mmu
 OBXybDQB5PrxpEJMR1P5ue1SO+9IqUQEmSSC79VyvhZVpqkwU3xdrhSzsMPRdr3miGu7
 v/+iwLUo17awVDDryvAsX932QJpT3XBA2gJcaM8sF/F3CTypvjhmV44Roqg276ufJASo
 fY84CUWVHmj1NREdbw6lIzS+bgYK0N1FTi+HkJrT1EgZJBnZggfzGRpS242Lll5zIpS+
 gWryUpZj0tlmbGodCmi4gLVZtjLQcbKJ7z+y1fC/eRXZ3N+4KD77CeLHZ47EDRDilEve
 PQDA==
X-Gm-Message-State: AFq9FYK3U3sGkDvumizdQFceGA5Zsxzm0junXdrmI48Qj2yOR74hMeHo
 uxcgrOACcPgxfchlkaLt+Xy/1dFb3FN+862HH/sqbwIzmMSyIpzSzBdcn12v1vXZ
X-Gm-Gg: AYBFou0S0HlIZvyJpfZnKmMDl9aWoHiSJiPP4BhsFB+xERTl5gooJvOM02Z8YkugKNJ
 Vj+IlK4+RjCwTSdsUiTu3mpsmQVsjMdcRburTQLtrDLGq4xlk+FD0YoXQToz6DECCtAg+1NO4eR
 4IbtRDEmJzkqm6BUUJFHAvfXgjzfFPskKeKVGGNotOfThhDorw1l7QHqsegUQ17r5l7eTheHtef
 ztW4fF+8vQmuRrIshqHqjp7sqOng+Lz03Iq0J+YiO/mgigbp+0maa4vXm6nZXTdE5/WJ0Po+Ti5
 Hwak72K/nz3vFHE1QZV7TxG1TSm7wepnnwhmWrGMeqqZhdkOZNcBUTaU7AaXcLkrhyNBkJcak91
 5MQ+Aq7mRFMb8UJZQ3Cg2MQUqNyOtcBJiGVp3zLUHkVOCKEHwj8uCfkZD2qDjQ+gYv62WHySzeg
 YA9Xz20MS2PQGbx04LwTfZNGO5rUWnSVmIezLr/ZTCW6PnSZTwUWvB6EXF/JkOuIpKvBpSzcJX5
 /mDBwbdLaDV6BNPcL3OKxOzl3ShRztSjIexZpZ3/gwW72P+svNlW4n1ajQ/KbKWSzjqAYlspQKc
 jYHqpq51fQ==
X-Received: by 2002:a17:90b:1e42:b0:39e:6c69:f476 with SMTP id
 98e67ed59e1d1-3a4d18c21bfmr485055a91.53.1790751558947; 
 Tue, 29 Sep 2026 23:59:18 -0700 (PDT)
Received: from phui-2.c.googlers.com.com
 (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4cae9ffaesm2010442a91.16.2026.09.29.23.59.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 23:59:18 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Hui Peng <benquike@gmail.com>
Subject: [PATCH v2 3/5] drm/gud: Prevent shadow_buf UAF by flushing work
 before reallocating
Date: Wed, 30 Sep 2026 06:59:12 +0000
Message-ID: <20260930065914.393939-4-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260930065914.393939-1-benquike@gmail.com>
References: <20260930065914.393939-1-benquike@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 30 Sep 2026 12:12:40 +0000
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

In gud_fb_queue_damage(), freeing gdrm->shadow_buf on framebuffer
dimension changes while the asynchronous worker gud_flush_work() is
running causes a race condition where gud_flush_work() dereferences the
freed gdrm->shadow_buf during a USB bulk transfer, triggering a slab
Use-After-Free (UAF).

Flush any pending background work (flush_work(&gdrm->work)) prior to
freeing and reallocating gdrm->shadow_buf when framebuffer dimensions
change.

Tested in QEMU against Linux 7.3.0-rc3 with KASAN enabled by queuing damage
on a resized framebuffer while background USB flush work (gud_flush_work)
was actively reading shadow_buf: on the unfixed kernel KASAN detected
BUG: KASAN: slab-use-after-free in gud_flush_damage(); whereas with this
fix applied (flushing pending work before vfreeing shadow_buf), 0 KASAN
warnings were generated.

Fixes: 40e1a70b4aed ("drm: Add GUD USB Display driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
 drivers/gpu/drm/gud/gud_pipe.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pipe.c
index aa7792966287..f9726e3d849f 100644
--- a/drivers/gpu/drm/gud/gud_pipe.c
+++ b/drivers/gpu/drm/gud/gud_pipe.c
@@ -397,6 +407,16 @@ static int gud_fb_queue_damage(struct gud_device *gdrm, struct drm_framebuffer *
 	struct drm_framebuffer *old_fb = NULL;
 	struct iosys_map shadow_map;

+	if (gdrm->shadow_buf && gdrm->fb &&
+	    (fb->pitches[0] != gdrm->fb->pitches[0] || fb->height != gdrm->fb->height)) {
+		flush_work(&gdrm->work);
+		mutex_lock(&gdrm->damage_lock);
+		vfree(gdrm->shadow_buf);
+		gdrm->shadow_buf = NULL;
+		gud_clear_damage(gdrm);
+		mutex_unlock(&gdrm->damage_lock);
+	}
+
 	mutex_lock(&gdrm->damage_lock);

 	if (!gdrm->shadow_buf) {
