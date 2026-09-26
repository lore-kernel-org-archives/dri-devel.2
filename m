Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB00CA5FA3
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:43:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77AA410E87C;
	Mon, 28 Sep 2026 08:42:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YaaRDDIx";
	dkim-atps=neutral
Received: from mail-qk2-f39.google.com (mail-qk2-f39.google.com
 [74.125.230.231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA2A389E59
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 16:31:35 +0000 (UTC)
Received: by mail-qk2-f39.google.com with SMTP id
 d75a77b69052e-5332bdd8296so7308181cf.2
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 09:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790440294; x=1791045094; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nKaiZuCWzgj/35GoC92DyRMuXF3uBWzJWZETTYPAMUo=;
 b=YaaRDDIxOkIpQOCyStqb9buhE30uFwAKuhgGF5eUJJw06WEM7m4S98kpokD6X6KRkp
 lhBdllJ9AvkqEL0R6IuZj1XmHBDGOUKDzrmOHY7F3kl6yylFCuTW51vIrTHbTZ03/2Wj
 5M1Io8sV7PhF/v+1ej1mbdOuNpFVCMhIJ6/cJDQ+OMByuWixU+MZ9HAPZ2re2RnhECDV
 Fg2J++j9TG6aL1ockz6bI+CG5dLClWPYbHid6j47+fK4iNWlpzdBF3AvwtPT2atQl6TH
 n/dh7KLRGVZKFqi/v+NQ5gIH5qEiHmaZhciSiczk9AdN3oXuyKnCsPt68oleCw+zovux
 gqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790440294; x=1791045094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nKaiZuCWzgj/35GoC92DyRMuXF3uBWzJWZETTYPAMUo=;
 b=j8Jah2baS8sZRVCDUvVjdGRWmUy7k59YTUUAk8CsL4cQxcrbAGIsZweY3q2/sf/TSb
 oMgtdSeobRivxUzLUIUNeAOMgsTD9Fk32s4KWk1QjU2Wzn8J4R9l3V2Cz97XCrQjsoKk
 Wv0Hr417XlLGX04hgTANLRBRXUcx2IgV8v6MzK/Jn2RPYuk+jlDVIdi7uE2RVLOrSDSL
 uawgPSTl2i9QxBgaITNMeXUZ3Vca4rscHnEIjnbrqND6cHh5Ny6SbkTc5rJY5rJmO/Dx
 iS774/QvF5gXNFYqek9gN1B+lb2V1QepbYzck8VBdWj+ClFsgzYb6e0GKqBoTBCHnTcb
 7QFw==
X-Forwarded-Encrypted: i=1;
 AKwUvByghmaa9GQ/+HtFLl/hlswkP3mpA6M9x1Rf87cPw5bSIEBNCn0s8JnIp5VYiKjmMJJtDdvFFdHeMXA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lcVN0Az02OXBs5G7vX+MbCE+ZkjOGc6eDNz3lWg2NUBWhgCM9/
 8tb1QXVm7UEQ8Z+UfMsCqbiIKYctateXHS52ekSeIE70ZGftwh8d877p
X-Gm-Gg: AYBFou1CRcGJ6n9sb53WZdKVm/qJJKk5pbf/PjQFbArEGjLTrw8sTM3tJ7p+/AJFP8U
 Appd1rV+HWafqs/jZrUQgQf7W1Z+qpsFZv66kK41NHJb6tG64DCfrZmnnURJXoNZc4/CgPSfo0c
 wPEju+7V9bAkQs4pvlAkD6QIgjvdXNc+SeQyWwppOPjwJwh/XdNSXyxuisWDcdjpnAtJUY0Zq64
 Xd54p9nsBd3HcUh2aTH1vkdv5A5E/k/6/JT21kRq0lXtfVMxNz0nSNycP+uNwjNzZKqiKxmlp/N
 hx3hN2pQAo+g83pBcw/iz/swnAY1uN9dXsRj/avrPQM378hEPpJXxTt1Pmh2q+axJgTOM78KBGM
 6Z4JXv5Kace176BdfxyctE4fYzeAR1b46i+wDx/JMNA5dIcmkZEhexP6uPPJPDVn4x5MwZFTAtq
 V5MQbTVBcja+VePQLdRnohUBJYHJ2l4MI850vAx6Glz6NnsHoavzAQXy98oLngxP74pHPTe5sVA
 iHttBaJMGJm6aB81OQoX+O0H6FxxsGOWyJz2fRx23OeLq0HL3mEhAwqDo5rxFxNkX8=
X-Received: by 2002:a05:620a:4686:b0:93a:2e8:5afa with SMTP id
 af79cd13be357-93c43ca5e78mr1028604385a.30.1790440294481; 
 Sat, 26 Sep 2026 09:31:34 -0700 (PDT)
Received: from localhost.localdomain
 ([2600:4040:29f7:9600:f571:6178:b590:34a4])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93c4fe09037sm341332385a.27.2026.09.26.09.31.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 26 Sep 2026 09:31:31 -0700 (PDT)
From: Dillon Amburgey <dillona@gmail.com>
To: Dave Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Cc: Dillon Amburgey <dillona@gmail.com>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, christian.koenig@amd.com, krisman@collabora.co.uk,
 noralf@tronnes.org
Subject: [PATCH v3 2/5] drm/qxl: wait for pending commits before applying
 DirtyFB
Date: Sat, 26 Sep 2026 12:31:20 -0400
Message-ID: <20260926163123.39217-3-dillona@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260926163123.39217-1-dillona@gmail.com>
References: <20260926163123.39217-1-dillona@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Sep 2026 08:42:42 +0000
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

The modeset locks protect software state, but a nonblocking commit can
swap that state before its hardware updates finish. DirtyFB can then
race primary-surface replacement and draw into the preceding surface.

Wait for the current CRTC commits while holding the modeset locks before
checking the primary and issuing dirty updates. Return wait and lock
errors to the caller instead of reporting success.

Fixes: 9973c879cff7 ("drm: qxl: Atomic phase 3: Wire up atomic page_flip helper")
Assisted-by: LLM sparse
Signed-off-by: Dillon Amburgey <dillona@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 1f869734e14d..51087cacff74 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -437,10 +437,17 @@ static int qxl_framebuffer_surface_dirty(struct drm_framebuffer *fb,
 	struct qxl_bo *qobj;
 	struct drm_modeset_acquire_ctx ctx;
 	bool is_primary;
+	struct drm_crtc *crtc;
 	int inc = 1, ret;
 
 	DRM_MODESET_LOCK_ALL_BEGIN(fb->dev, ctx, DRM_MODESET_ACQUIRE_INTERRUPTIBLE, ret);
 
+	drm_for_each_crtc(crtc, &qdev->ddev) {
+		ret = drm_crtc_commit_wait(crtc->state->commit);
+		if (ret)
+			goto out_lock_end;
+	}
+
 	qobj = gem_to_qxl_bo(fb->obj[0]);
 	/* if we aren't primary surface ignore this */
 	is_primary = qobj->shadow ? qobj->shadow->is_primary : qobj->is_primary;
@@ -464,7 +471,7 @@ static int qxl_framebuffer_surface_dirty(struct drm_framebuffer *fb,
 out_lock_end:
 	DRM_MODESET_LOCK_ALL_END(fb->dev, ctx, ret);
 
-	return 0;
+	return ret;
 }
 
 static const struct drm_framebuffer_funcs qxl_fb_funcs = {
