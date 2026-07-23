Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D179C531CC
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 19:23:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 969AB10E5E6;
	Thu, 23 Jul 2026 19:23:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CS5MkcmX";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E0AA10E5E6
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 19:23:54 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4954df200ddso6394215e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 12:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784834633; x=1785439433; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mqxcfVrR6DJH7Q8LkKVdFh0w04HNqAky5ozgYuy/EFs=;
 b=CS5MkcmXuq7qV6i2i6KCCz3i8vPUuyowuhN/EOLrAMvKKNE8ybnDALE9/R/VSNEgMu
 5t8DIVM+6jNYmGoa7TCKKGMFLTV/tbLTE2h/LrxX1OCCwdHTf1aUY4hg79OX5lNl0XM2
 vttxMlv4knH5USERj6Wg7Zi4wCcUoARYygCgTUv3NJeIRAncFA8PXSqddq3zctrV/qIN
 lgAf25JlDSZYmAovnGl4AR0Eo4mD5xxdMK0w7bCOsYXOfiJB0VjkjMsLckca8BiiHneN
 1p9xLf+R7RJ4QCG8wg4BxX0UMYjCR+CEolMhaS9p8mhsLm5OsTsNG68kZ/Jf4mvsvTer
 5Mag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784834633; x=1785439433;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=mqxcfVrR6DJH7Q8LkKVdFh0w04HNqAky5ozgYuy/EFs=;
 b=kemQ+pNzk84+RxJ0i+LuKfEriCBGaNPymx2uP7bePLeetP5+tMNWpPMkA74bZJTrWL
 ONG2XJ0RHVetlSg2z+x0kbopX7mLK1N7g5HdQwkQejjW+ZvnfPP5+/q4Vd+wG6+vmllA
 x9dLvJ/g4B/rc66NBj/Za0p9qf7QhdzL9N7lg3Ex0nglg4QzYIFere6enIswikBYtnNv
 yceGZgcMJZlwp6xu1ZKfX307f6ABRROApfxPeOp3loKgBP4GuKRL48QUXx7stb66G1xv
 c1ZxIXElrPDtlrEtJwi4K++aaCAQdZThH+HPZG2oKNk16opmrNXHqrAxnlllKsEZC1TL
 Mg9w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrT2pT405veqW/c0s+ueIwOJsqH5l9krzzB9cMrcr/npL8ar30q4zBcjQRTriK82pRqOPe0y7iwWXE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzG5pNwXbODMEaUo4gczdvgXwYZyHw90FyZ48Um2SI802fAHBVy
 7Q0U8Bomil1FKCRkiJxqL5snDUiVxxdY9vd4e85Smcl7yV0tpQOyASY=
X-Gm-Gg: AR+sD13r78in1egMbarffRoWsslKpbRS9CrDflarJnjEmdKEeSAtGK2vu7Jje1GRAJT
 W0sAFAVwMrqs4rfew8qbDn4FbefybNYf3TEIMyC/0B/a9mCLia045UypdzSeWUzqF4GlsWRjOtU
 5ghUAbTtnYYhUtkZ87Jj53ot4gskCIiJcTut0/mkvB3d2SdhiziXkak4UpLWVr6Ve7/YkPk9IVJ
 Q29EfxuQRtsqlDh8rAnyTB7T4UlN7yWA4Tgla4be8Jsue1KTsNGe69v277I2srgcROvnfrzzHMP
 0SbD+nR7/5gBt3WOPD07KeCLCB676oKxr61NS07N4zqALcskeouX3n/cMOhN7kadWybTNO2VHkT
 a29DLqJlNNsMnVTi7u6+Tjn8OSUHSyLQ3/EB5hAfogtj5UGglft/ghVaQNiygoXj/zXY63mrBSx
 G9DsWK1hf5hhRAVMrgqMQ=
X-Received: by 2002:a05:600c:1d29:b0:495:699:84ca with SMTP id
 5b1f17b1804b1-49573d142bamr50812275e9.28.1784834632689; 
 Thu, 23 Jul 2026 12:23:52 -0700 (PDT)
Received: from [192.168.1.67] ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957af5d4d7sm15416245e9.2.2026.07.23.12.23.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 12:23:52 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Thu, 23 Jul 2026 21:23:22 +0200
Subject: [PATCH v2] drm/msm: remove objects from evit list after pinning them
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-evict_list_fix-v2-1-bd0725e56253@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNQQ6CMBBFr0JmbQ0dk6KuvIchpLQFxgA1LTYaw
 t2d4trM6v+8/2aF6AK5CNdiheASRfIzBzwUYAY9906Q5QxYoiorPAlmzNKMFJemo7eQVl+wRYW
 V1sCjZ3Bc78J7/cvx1T6cWbIlEwNPffjsH5PM3F95koJPS3su205J0936SdN4NH6Cetu2L7Q/2
 /m+AAAA
X-Change-ID: 20260723-evict_list_fix-1da92b2627aa
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Anna Maniscalco <anna.maniscalco2000@gmail.com>, 
 Antonino Maniscalco <antomani103@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784834631; l=1651;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=k/JTkZF0a0smNy/xXdhUk8nFQroFgmrlPE0Qs9N4U1U=;
 b=TGbF0HVMiylKJpQxVKlBl47m+NOEpqrAnzusIERxCbECnNRC8S4Q/4v14QhTClm/aFf7aK7cf
 DdwDEysRadnDG0LErRTVatQILEmbeO27QwE4jTL27uRG/gVmt1oWTVf
X-Developer-Key: i=anna.maniscalco2000@gmail.com; a=ed25519;
 pk=0zicFb38tVla+iHRo4kWpOMsmtUrpGBEa7LkFF81lyY=
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

Once objects are pinned they should not be kept in the evict list as
that will cause drm_gpuvm_validate to keep ieterating a growing list of
objects needlessly.

Once an object is pinned remove it from the list.

Fixes: 2e6a8a1fe2b2 ("drm/msm: Add VM_BIND ioctl")
Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
Changes in v2:
- Added Fixes tag
- Link to v1: https://patch.msgid.link/20260723-evict_list_fix-v1-1-1a1d80bf61cf@gmail.com

To: Rob Clark <robin.clark@oss.qualcomm.com>
To: Dmitry Baryshkov <lumag@kernel.org>
To: Abhinav Kumar <abhinav.kumar@linux.dev>
To: Jessica Zhang <jesszhan0024@gmail.com>
To: Sean Paul <sean@poorly.run>
To: Marijn Suijten <marijn.suijten@somainline.org>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Antonino Maniscalco <antomani103@gmail.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/msm/msm_gem_vma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index 1a952b171ed7..4422677f095c 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -458,6 +458,8 @@ msm_gem_vm_bo_validate(struct drm_gpuvm_bo *vm_bo, struct drm_exec *exec)
 			return ret;
 	}
 
+	drm_gpuvm_bo_evict(vm_bo, false);
+
 	return 0;
 }
 

---
base-commit: 9a967125427e03c7ebc24d7ad26e9307e8403d4e
change-id: 20260723-evict_list_fix-1da92b2627aa

Best regards,
--  
Anna Maniscalco <anna.maniscalco2000@gmail.com>

