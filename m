Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D6FCD4F47
	for <dri-devel@archiver.kernel.org>; Sat, 16 May 2026 11:07:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0667C10E4C1;
	Sat, 16 May 2026 11:07:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RgP+xfq9";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF8C110E491
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 11:06:57 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so7681315e9.0
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 04:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778929616; x=1779534416; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GUzK0JUispp8nMHz/jfrYyUsKO3YYZqffLIW7XXNsp8=;
 b=RgP+xfq9R23d0wWf9qOnhevSLX8NkjnNfKJnnUnjd6qXNUEkM+cKdL6XVaGok5WmIA
 tDEAunxtQEHxPUuKjs/FrSXFmi3RA7xpoEfhC7t73V1YPxOV/lsTD567T4VFJhpp6Umk
 wm9ni7tK3nmleeRB+I6/6d/k3PL4EaroNxxjpdwTG98/icbIvH+NHwGfsPhsx+73Yvqk
 G3nX2WtjYBHO9/j7EqKpCQFfWtZuZrDpbzW/g2AMBPxn9fyQMSgce8Eu0IG8rf3hSPvM
 3lr5mlZNBbXFQstEZj+hQVggkXRUBhBdyvj949zkmLNderz88Afgbmn1EBvjn4rfuly/
 UAEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778929616; x=1779534416;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GUzK0JUispp8nMHz/jfrYyUsKO3YYZqffLIW7XXNsp8=;
 b=ZWAZl9awX45dDOzdowjx7LsEv1IxonNvvnGUIY57xrAV0Liv3HRFrpfZaOFdPFqBW4
 PSxe5nln+NWDG+pi/Go3pXJ024v0yGWRdl0daJPowddPq95G7w/pKaCQ9GuTK79BM7UH
 XvZ7VFANmGlBKTxt5CR2DC12TSw6RRJoXHrplnQmAu9Yn1W3jWlf+hiZ8Vd4s2Zn2Qxr
 wwSoex7gJ7rwuHZzUpN1149nYEFEG6ERTnYYe6QEhUSFX5fl2+fGGi7orNVOtyxjsGzg
 rgWMgnDO6JX5b3uGndasMPlZI31gh0gXfYR1WkkaA6QfHN53BRR3Q4908yWg71ApNPIi
 10RQ==
X-Gm-Message-State: AOJu0YxKuESBQAwHRdICb6+9CZKW58UEUxbGb1h/gpfXiPbfvW9c7XQD
 omsa9pnc3usp5PrfTdMYX7HoTqUk5u+esJLv/fLQZy/ZxT2PWFgIqxEn
X-Gm-Gg: Acq92OEfmgkf/cWgvc/nGIKuHZU65F8s7UeNi/hCMhgfCuT8YmHKOoPdc00Tvfkty2+
 J0yzmNkIlZG7tkt8EBThbV/MGPqp13q594e2/gZ5gkEftgzAdG6EXzc26eEXgL4hzBsS/iKm44i
 n6TKr0neERlERjMHW8+qTrSLpPmd6Ydz+1YIQVwXsbBZgJ0XV2nZnAoRE72KwrYE2TaxBAscRXv
 kqItQFP1MTMuGvTehi8Yob9uJjNFD/8bXglw9XQADiISKFlSPMCs508FlJR3qZPBBoKN53I3fwR
 1R59BwkZN/LXQVGvMQcr4gNloZAzLFMwBG5ME/WMaFmUfl92eXM9grp42zcYb6Y73KgnxpHGoOK
 WA3LX2GwL7cV+V0atBUKAW+zkBgG59wjB56jfJQGhcKqsDBiF5DTT15wuoCPoBT253tLOa5ZZGZ
 xkTsL9hblSQDVj5GpNkKIBOa/v7bgDRHtW7M+A9AQJ7Ad+3x3GCTVnWTYoDZi+Tn6rO0TrH765U
 SDfun8=
X-Received: by 2002:a05:600c:c087:b0:48a:7b55:12a6 with SMTP id
 5b1f17b1804b1-48fe5cb36aamr88176225e9.0.1778929616265; 
 Sat, 16 May 2026 04:06:56 -0700 (PDT)
Received: from [10.13.0.20] (ip87-106-117-14.pbiaas.com. [87.106.117.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feb00e5easm36399545e9.13.2026.05.16.04.06.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 04:06:55 -0700 (PDT)
From: Julian Orth <ju.orth@gmail.com>
Date: Sat, 16 May 2026 13:06:12 +0200
Subject: [PATCH 09/12] drm/syncobj: fix resource leak in
 drm_syncobj_import_sync_file_fence
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-jorth-syncobj-v1-9-88ede9d98a81@gmail.com>
References: <20260516-jorth-syncobj-v1-0-88ede9d98a81@gmail.com>
In-Reply-To: <20260516-jorth-syncobj-v1-0-88ede9d98a81@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
 linux-doc@vger.kernel.org, wayland-devel@lists.freedesktop.org, 
 ju.orth@gmail.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778929602; l=1383;
 i=ju.orth@gmail.com; s=20251120; h=from:subject:message-id;
 bh=5APNMtl2NCstrrwoxtWKTvFVItf0IqBmltZkdCTjBxU=;
 b=uBiahrAmREDZy7Fj07y8SVauSH9GmZFa2clMwUB1MLOYdGIifgpx+NgONorTf5/6Z4hk84rCI
 KXcKOq9bDW9D2GMf5/UEmHT+/8WQoDxsc8BjwHF2qniEf5cY8txk1A8
X-Developer-Key: i=ju.orth@gmail.com; a=ed25519;
 pk=uM2SS4lelkuIoYHc7v9N9bgBZ3hS632zJS2xjRJLPLI=
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

Previously, if dma_fence_chain_alloc() failed, the syncobj and fence
would be leaked.

Signed-off-by: Julian Orth <ju.orth@gmail.com>
---
 drivers/gpu/drm/drm_syncobj.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index 9b7ecc2978f5..1da96e23dfc0 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -767,30 +767,35 @@ static int drm_syncobj_import_sync_file_fence(struct drm_file *file_private,
 {
 	struct dma_fence *fence = sync_file_get_fence(fd);
 	struct drm_syncobj *syncobj;
+	int ret = 0;
 
 	if (!fence)
 		return -EINVAL;
 
 	syncobj = drm_syncobj_find(file_private, handle);
 	if (!syncobj) {
-		dma_fence_put(fence);
-		return -ENOENT;
+		ret = -ENOENT;
+		goto err_syncobj;
 	}
 
 	if (point) {
 		struct dma_fence_chain *chain = dma_fence_chain_alloc();
 
-		if (!chain)
-			return -ENOMEM;
+		if (!chain) {
+			ret = -ENOMEM;
+			goto err;
+		}
 
 		drm_syncobj_add_point(syncobj, chain, fence, point);
 	} else {
 		drm_syncobj_replace_fence(syncobj, fence);
 	}
 
-	dma_fence_put(fence);
+err:
 	drm_syncobj_put(syncobj);
-	return 0;
+err_syncobj:
+	dma_fence_put(fence);
+	return ret;
 }
 
 static int drm_syncobj_export_sync_file(struct drm_file *file_private,

-- 
2.54.0

