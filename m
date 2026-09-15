Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC73C982C5
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:35:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CE9110E72C;
	Wed, 16 Sep 2026 07:35:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hWr/gEmH";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D596110F493
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 12:55:57 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4843378fb37so1540421f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 05:55:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789476956; cv=none;
 d=google.com; s=arc-20260327;
 b=LwLkO6wlwlLKzBxKVLX3WeSB+APBkw7iDa0sLF7iykAfmKSOUAkad5/uyz6N6UC23e
 0EjL6r/2nOxANsnIZHTTuSuWWY123nwRzeJ96Nu/1Iacn1GWloS1uGIGg9QnoZzcwQ5P
 GRgyqKlAqEOdAOY2Z+7AiaA99f+ZtPVLzqLeUKrmQfi552n/9HGcIdDElaRaMeiPex4g
 tBvU22oP8pmsOhM1S/pD6Nu/QNo+QdQdULL/FTMsmPxqlWAZ6zZoYMHd7bvRyb3Klw5J
 OCEvio7NwCbQgJfn1mQAkOHVI0cLD4Vh4oqBx2KKvxNtuMuYAOivWEHfgBSYQ7g7SMNq
 tIvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
 bh=OM+H0ZryYGe579SWVUouyWAsJkTBdNJh5NaAXigLTTs=;
 fh=I63X5axPP2p8WYHSXvdI8I9HKiMiof/Yh96y8BgEpS0=;
 b=N7Ux3aX/dgcwjG5mnvpDz1ig13oE+6LtVWpT/LKHfrngMhTJ3P9l/hvcGet9kwSYsO
 eAUap5IjF9wpjp7PHlNhNabDJWHhAafaQ2X79YY+8C5hGPXvWLhjIBZkYoM83DI0Pu0P
 YBRKPfOCfWkiAEA6j6ZAVW241vl7qK/WvCovlFjs9Zd8S6aOymE6x9iG1QpHe7ov35ip
 LUNcRmC5fSiK4maIydCM97MypVxv6jDxnTE9a6RqLre/IE3XQ0bndb4WFf99mOvlq+eq
 FEiuTl1/nfwV8LoQtUv8cwEPl1VTfxqvCDwvPSYyWI08rQc2HP/MmatCdfbt+LQ/Rv6s
 J9vg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789476956; x=1790081756; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:mime-version:from:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OM+H0ZryYGe579SWVUouyWAsJkTBdNJh5NaAXigLTTs=;
 b=hWr/gEmHX0zCGof1oayHJIHu0ev7DzrGK8AohhtA4NKkSGbR9cV8EYZdGzpfVhLXmi
 CjBhQZReqceirfSPj7poYu53POI2yWmpa/3v13FvHnFAJZs+Mjtj1S/B4NuneoUv7nHr
 hTyFfiO12gegFZcmSoclTy6ymfbnupySaAWY/dZmkp8zn0XFSL7a3A16tiIGWP779xcn
 5mFAAG/nHKMizS++xLFeltohrDA6ys9AsbvzZENsAjsynLBH08ezd0Z63PWrDyfGPNvd
 8+NJSYoxea/BEKcCIgPiWx3SxMy3SwVqHIQhdpiOcmLK/tpy5hsVtFASW2BH/aLtDM37
 bF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789476956; x=1790081756;
 h=content-type:cc:to:subject:message-id:date:mime-version:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OM+H0ZryYGe579SWVUouyWAsJkTBdNJh5NaAXigLTTs=;
 b=MSyQx0fVCAhyf5dYMgQc4+tOHOMH3O01dGAKGhs7aII40azrUPHNseCXK8fxy5VQRM
 vn2gin3HXHgmcVa5pM6R+BxFshXMfaK2e5HXQRtaA1mnd50OmyyG2LNHXVEwhhNLD+Ih
 3D4zMft3LeolntWBnqE1marpvFY8YTHyHxoYLeSEzizO2VTSU0ZpfkTYx6pw1IQugwIR
 IIcptEcvuFUFEz+VCUT7qXH1ziO4PjzUymvZXK7a/P0gllEGXEK9Wat9PAoC25gtN6iO
 bxvRJ54O9PKgJI6vglaUEVYKA68RW0G+JNOn5DeL5CPCBMDmamy2XMRYn7kEDQG+jTn2
 Yv1w==
X-Gm-Message-State: AFuF++n6SotR0JMiXAcsaNtsmwz2QQxFglTmme1lT5buWPr3SERt8JGw
 6CsdbRf+ebHNz3/ChumbX7xZMF0BFODUJshJfb5j47vGAMuTq84/XM1gidIvFwfPkLzlHHulojC
 xkfAqOD6WaGKt7CvNVovWY48ihgWujI2mWeFL1FmITrBR
X-Gm-Gg: AYBFou2P+ZHw1J2qyM6OWtRLkxWi/u4t0AfsZTSND2fQmLQ7+gWYrASAMP+iUzcQtHL
 yc3Y+vC+eHWaMXzYJehnhxq3lp0JwBT1jL+EkeM435PIAE2krjMZfzk6qmDpQ4WDtFbHYt5wU7A
 tmRXu9x0XXS4gbDOV299oe2SRPjxxCiHhGaCMW2R6gHu10q01zb97BcwgTUdRhF1kDO7e3CPNOE
 BAlmp5lZKEnXUhz+NVS9A8YW9gHPyKi2Kz804C6Y51Bl0C1X4NAKiJkzSe3omkZORmL5vj1tE4p
 z6RrIQoqzSJe54MSjOLsO50vp1/44do+uTaH3a9mkZ8mRuIrnZWDbw==
X-Received: by 2002:adf:e005:0:10b0:487:34c:81e with SMTP id
 ffacd0b85a97d-487034c082dmr5699941f8f.20.1789476956079; Tue, 15 Sep 2026
 05:55:56 -0700 (PDT)
Received: from 830778650420 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Sep 2026 07:55:55 -0500
Received: from 830778650420 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Sep 2026 07:55:55 -0500
From: Ruslan Vagner <rusya92266@gmail.com>
MIME-Version: 1.0
Date: Tue, 15 Sep 2026 07:55:55 -0500
X-Gm-Features: AcwNN1UNfMmrw0-gHi__X2t9K26TfeAjjy2aCqnRG196D64nHnpirSqIRvXJWpI
Message-ID: <CAF9RqJ4tqTQ+-Da=M5=4_5VEAwvzjqmiitg1E+y0tsRy7H+7-g@mail.gmail.com>
Subject: [PATCH] drm/vmwgfx: fix comment typo in ttm_object.c
To: dri-devel@lists.freedesktop.org
Cc: zack.rusin@broadcom.com, ian.forbes@broadcom.com, 
 Ruslan Vagner <rusya92266@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 16 Sep 2026 07:35:16 +0000
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

Fix the spelling in comments. No functional change.

Signed-off-by: Ruslan Vagner <rusya92266@gmail.com>
---
 drivers/gpu/drm/vmwgfx/ttm_object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/ttm_object.c
b/drivers/gpu/drm/vmwgfx/ttm_object.c
index f9042bafdc93..38b6a1787865 100644
--- a/drivers/gpu/drm/vmwgfx/ttm_object.c
+++ b/drivers/gpu/drm/vmwgfx/ttm_object.c
@@ -431,7 +431,7 @@ ttm_object_device_init(const struct dma_buf_ops *ops)

 	/*
 	 * Our base is at VMWGFX_NUM_MOB + 1 because we want to create
-	 * a seperate namespace for GEM handles (which are
+	 * a separate namespace for GEM handles (which are
 	 * 1..VMWGFX_NUM_MOB) and the surface handles. Some ioctl's
 	 * can take either handle as an argument so we want to
 	 * easily be able to tell whether the handle refers to a
-- 
2.54.0.windows.1
