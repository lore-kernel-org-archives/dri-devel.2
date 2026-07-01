Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF86EC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 18:44:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 403FA10F09F;
	Wed,  1 Jul 2026 18:44:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KZyLsvqd";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AA5D10F09F
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 18:44:35 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-37e1607f7faso661203a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 11:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782931475; x=1783536275; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:subject:cc:to:from:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ban9nVUuk4Kjsoscd1xTKmaJVwsIyHeDMlfeDJiaGMA=;
 b=KZyLsvqdXVG08AKKr060ahqMfO3XAH0a6w0rEebjk+8oY6f7diBSJ14sr94vfoykR/
 O4I9lB+kOTlmiqUe0147Wd/Db12fCZ334EFcMXXrjn5t3kOw1i4s83D0E+hWvTWjOzhs
 qefNjvdvB/BPA0WWDmROAKNHUDGKqlseM/tg1gHdM3Av3S4+/Bj6U6lXzVwG1em/2jMk
 BXp6nyzgj4Vm5vehWTVBhBkMxbH2bmmFGhHxm3NsQVnjg3WrDvgyFhxqLxApfGuzRaym
 zkGEyoxkuJ4GLSVJmWdxXdM3iRYfMhmPJ6M9IRmMUgNqSFWAcrIrAPmSpNtg0GdU4vVu
 TXzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782931475; x=1783536275;
 h=content-transfer-encoding:mime-version:subject:cc:to:from:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ban9nVUuk4Kjsoscd1xTKmaJVwsIyHeDMlfeDJiaGMA=;
 b=mruigyz2tkT6RlBiWns5V7XiYnSyL9b+RiuAt6VRZJlw/vTqlPBq3eS/t7i1cQLpDG
 GG/VQsHORlrO0nzZ0RZhqLwsLRIVFn+LblwCaT9mxJ6dcw1l2xso1T5A8ulv0otGjHTs
 V2BM0lEoUPZ7/aKZlFO6exVSFUXmGF7JuvbDljSlzitwezt4LCx16FZbsKLUS6Ed0E4R
 dQJU727J3KQoZ1ksmFB4+fz5Kf8ID9MPz04vlLUz0VXpx029a7gflv+GLmqHRJiZEsm1
 KulGDX2S2f5p3IoQiacg3mBC9yMqWc5he+kvsyMDoSh1gyPyFZXhlXoCFFzZ8B+qXm49
 +RIQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoN2132z+oCpE3wiVwQ3T3/LyqhwHm34i0OXyaSjKUhxVXtCuv+hODEiQM2znavezFM+pSdvOcK/ok=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzQbnOYn84havfT9tu8bZu+SSZ11y1S/7QeTI9ZE296W+u4yLHo
 /hqF1/B2tSl70Sl7Zw9EPkB0eVbAfLMYm2HPeAY+rbCJ7KO0a7f0g9yY
X-Gm-Gg: AfdE7ckQoEn2McEZPJOBreKQuSDdeSqlP0vpKNK/rAQXDvCiYb8Wtucr0FFwFoC9q9a
 UuSxkm8b2fPoaFmQTwuLjvpSXfpY5DzWwYVPPlt77Nqb/bzEUEVbAE4MCaocI1DTONbw8y6+Hd0
 UTlhN7gLcdf60Viwei3CiccXgCVBXab4OidUjz2P89F5D+f+R4FrwAxdf5msN9Z/XZJwQzcXFOZ
 gV0vaRDXc1KORa7cNODaMWskIxGyPS62e2Gv2tMcZylHsDJYs+cxtjvGXSIKGkDyvIIf9J/wc+W
 +ujcsacldknE/Vlpqr9LpeQMUgiUoCKCnb0O3swrvBnKSJQAEqvsqH7/LoDVoP0TXUxoDKyvn9o
 KBWF4gUjC70rk1D2AXbCT0lUNs94+dUy4jLxM8sCzT3IG2hn3OJ609MNGWQjZ782i56IZfoX7AW
 hlFhWEcEI7JmlBM85W5AaUQ3kbTCaBwhi9V0KHyS53RrguEPDPyP/ard4wGTB/Tj4NmXtg1Jo3x
 +BZRmLi5qXUkBfJwasT6C7yp2MxZ2WnmwJ8a6zNZdILyuPPITR/i5OcK7aL9Si1sBvl+w4JeXed
 8g7svXFS8Q==
X-Received: by 2002:a17:90a:d647:b0:369:a359:b181 with SMTP id
 98e67ed59e1d1-380aa221bf1mr2580207a91.23.1782931474540; 
 Wed, 01 Jul 2026 11:44:34 -0700 (PDT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 ([2407:1400:aa40:6780:6462:8b0c:2576:642b])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0bb843fasm393406eec.18.2026.07.01.11.44.29
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 01 Jul 2026 11:44:34 -0700 (PDT)
Message-ID: <6a456012.eb165e5c.113c2a.b71d@mx.google.com>
Date: Wed, 01 Jul 2026 11:44:34 -0700 (PDT)
From: Shuvam Pandey <shuvampandey1@gmail.com>
To: Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Donald Robson <donald.robson@imgtec.com>,
 Sarah Walker <sarah.walker@imgtec.com>,
 Alessio Belle <alessio.belle@imgtec.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2] drm/imagination: Fix user array stride in
 pvr_set_uobj_array()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

pvr_set_uobj_array() copies an array of kernel objects to a userspace
array whose element size is described by out->stride. When out->stride
is different from the kernel object size, the slow path advances the
userspace pointer by the kernel object size and the kernel pointer by the
userspace stride.

This reverses the intended layout. For larger userspace strides, later
copies read from the wrong kernel addresses. For smaller userspace
strides, later copies are written at the wrong userspace offsets. The
padding clear is also done only for the first element instead of the
padding area for each element.

Advance the userspace pointer by out->stride and the kernel pointer by
obj_size, and clear per-element padding while the current userspace
pointer is still available.

Fixes: f99f5f3ea7ef ("drm/imagination: Add GPU ID parsing and firmware loading")
Cc: stable@vger.kernel.org # v6.8+
Reviewed-by: Alessio Belle <alessio.belle@imgtec.com>
Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
---
v2:
- Fix From header to include name and email.
- Add Alessio's Reviewed-by tag.

 drivers/gpu/drm/imagination/pvr_drv.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/imagination/pvr_drv.c
index 268900464ab6..0a68a9c32361 100644
--- a/drivers/gpu/drm/imagination/pvr_drv.c
+++ b/drivers/gpu/drm/imagination/pvr_drv.c
@@ -1252,14 +1252,13 @@ pvr_set_uobj_array(const struct drm_pvr_obj_array *out, u32 min_stride, u32 obj_
 			if (copy_to_user(out_ptr, in_ptr, cpy_elem_size))
 				return -EFAULT;
 
-			out_ptr += obj_size;
-			in_ptr += out->stride;
-		}
+			if (out->stride > obj_size &&
+			    clear_user(out_ptr + cpy_elem_size, out->stride - obj_size)) {
+				return -EFAULT;
+			}
 
-		if (out->stride > obj_size &&
-		    clear_user(u64_to_user_ptr(out->array + obj_size),
-			       out->stride - obj_size)) {
-			return -EFAULT;
+			out_ptr += out->stride;
+			in_ptr += obj_size;
 		}
 	}
 
-- 
2.34.1
