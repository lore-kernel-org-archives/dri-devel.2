Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F88CD98CE
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 21:46:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7889210E65B;
	Mon, 15 Jun 2026 21:46:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mDQLCYuG";
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 555A010E73E
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 21:46:17 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-c858b5de728so2438389a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 14:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781559977; x=1782164777; darn=lists.freedesktop.org;
 h=mime-version:content-transfer-encoding:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vz6stOMSk3vpFUFzv+jJpjA2EoqJIkxHHZXo5ER0nFI=;
 b=mDQLCYuG6UH0FvBVVXeuwqRGdj1oi8lEN5sPvSAfrchgI/dNb6lzCOKqCBvvmv3fmQ
 BtljOGnv0tJEMCMixTGVtHHLUEFrP+dsnekg2bPzXByd8Yn2PhVxnX74g3KFlKfz/4Ep
 x873TDqS+aHmJSm+c6EIPPOb8NPEx+QPZQkzUK52N7bx5dhwm7aoKI+2pnWudYOaY+Xx
 mEx1dszAx2oDRXqEiLjAT8qsYAWk+Mh4y8PUu8SyCUrYnSHyyHaNW5+o6DKJDgpj5hPB
 ibp/pjCUwnjfKrDVtAlJFGAcGl5MKROsW1D4hq1ofRTP1gfvTxiMNY5MAb2lydXvWsDZ
 n7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781559977; x=1782164777;
 h=mime-version:content-transfer-encoding:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vz6stOMSk3vpFUFzv+jJpjA2EoqJIkxHHZXo5ER0nFI=;
 b=hy1zAj3SjfEmJl6hlKMUcuHNv5MSqNc8aLlwNZe5nqRVh3qMYNa6ewlODpf5dUZl9j
 v0OIaYQ7Qc/yRjINFF9w4FB78eRsB+p1D6JxM7va9EGQ9GwrSBlEVfzryMUT/WAXutnQ
 jEIMUwIDsLEHZTEn9RTL9X7sv+GmvGzjyHe66KHRNP7dB8P5fIYPJN2VmpAiiEoJ6NjL
 p6eY16/DlC32ZKjCA1cSrtdsCBPmXA6Benle/sqOvBd5KxJk0UkDZRaXywUhB95sK7Hx
 hc8B4TIYOH75L1CmaQyet/sPa9c7kRMj19R9+Rl0ltWfQ6xDAp+Rxql/X25r/EeDPYFT
 xooA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9I+YNKMXq5XicYl9+oVe9jqRO5o7NGNOF8BoCrywEQUlPktXttpohrLIvbv6lAr2tlISuC9rE1Z2c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzLi55nbnzb2lh4+FtFozOSUB0zpaZkLtJOPo+M842nnTKztNvM
 90BoZ7iljM3dODeqVEHo6P+4PcQJQ+sTsVwS2j0o6F3owaq+LCNCPc+j
X-Gm-Gg: Acq92OFQf1epW6ZpGq5pgMB7M1RjDvO05/702hSwNcBJM++SKwLJQs/TUDPuqx3XHo3
 CRP7TlNtlPnE7Ji438oaEODX3v1nr3CIgbhDfAwIZLOzKw+UKLFlrJnSAdsl4+r/Acn7H2SUsLH
 vs1SR4g4sY5qUgYScHSSVfOjteR2GtvIn10h9Zcn80fA42u2jWdQa5qJ5lKZm5aRfnPFjvYty5S
 2PzTO7I3s4LBm/BKzrBIW2Br8JFygDblnX161rJFBwV90M1Hlq/GuB1GF4OOjyVVJqbq1NYyKP6
 8wEFGGTq99eXplmz74yTtiIPCcBmgiyQFriE8C+HKx8rEqo7jgslM/0XMhZKAlUoeSs6+RE53Ad
 6k69fO9HqgLJbOI14MqIunR+Sh4+FI7bo+taGSJJVcsQ+Btc3QIDX07RpeJ9cPz9rCczX1buQdn
 TuPdaneiW/deXKLxceNubcWkqL3s1NzDKhwH6dGL/QGv69puo/m6EqFHFw10wd6yOmvnPO7uCcE
 uQbBBZRhNfkiXFCaBK3e0ZMrlzgmw==
X-Received: by 2002:a05:6a20:748a:b0:3b4:7aae:1ee8 with SMTP id
 adf61e73a8af0-3b79624cb18mr14017944637.14.1781559976818; 
 Mon, 15 Jun 2026 14:46:16 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([103.129.135.168])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8661b5e509sm9835799a12.3.2026.06.15.14.46.12
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 15 Jun 2026 14:46:16 -0700 (PDT)
From: shuvampandey1@gmail.com
To: Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Donald Robson <donald.robson@imgtec.com>,
 Sarah Walker <sarah.walker@imgtec.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] drm/imagination: Fix user array stride in pvr_set_uobj_array()
Date: Tue, 16 Jun 2026 03:31:09 +0545
Message-ID: <178155996993.4848.8618351576278880213@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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

Fixes: f99f5f3ea7ef ("drm/imagination: Add GPU ID parsing and firmware loadin=
g")
Cc: stable@vger.kernel.org # v6.8+
Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
---
 drivers/gpu/drm/imagination/pvr_drv.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/imaginat=
ion/pvr_drv.c
index 268900464ab6..0a68a9c32361 100644
--- a/drivers/gpu/drm/imagination/pvr_drv.c
+++ b/drivers/gpu/drm/imagination/pvr_drv.c
@@ -1252,14 +1252,13 @@ pvr_set_uobj_array(const struct drm_pvr_obj_array *ou=
t, u32 min_stride, u32 obj_
 			if (copy_to_user(out_ptr, in_ptr, cpy_elem_size))
 				return -EFAULT;
=20
-			out_ptr +=3D obj_size;
-			in_ptr +=3D out->stride;
-		}
+			if (out->stride > obj_size &&
+			    clear_user(out_ptr + cpy_elem_size, out->stride - obj_size)) {
+				return -EFAULT;
+			}
=20
-		if (out->stride > obj_size &&
-		    clear_user(u64_to_user_ptr(out->array + obj_size),
-			       out->stride - obj_size)) {
-			return -EFAULT;
+			out_ptr +=3D out->stride;
+			in_ptr +=3D obj_size;
 		}
 	}
=20
