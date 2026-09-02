Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47703C624DD
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:33:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 929D710F3E6;
	Thu,  3 Sep 2026 07:33:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e/KiSgrG";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 301D210F1A1
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 12:33:37 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-38ec1402b05so906366a91.2
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 05:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788352417; x=1788957217; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=khFd/jDnlTA/XKPvSSegUBessMbx5oK9ggDT+W0TX84=;
 b=e/KiSgrGQ4lL3/2XOcN0SlyXDSaua0167Qk71AaKZMjQYavvlfvea6wqX5Fh3rTf8n
 cIPaCE8+ch+i2dhG9+3mjzLxBt87uX0qKeCERxapOymARBjTXmQWtHgp5s1u22HhDbvO
 jK5xJZzIi4H0+2KK/F1LNSie3ePxf7c3/g5VT6s/lCm+iKrdMMVfMbBhhHi5IQVGeG5z
 c4lbNtosnweIgv6+GFEYFrHoXAkb8OXI8ftgKwJjX6+q2ghXYTTNJUd+FhSOGwuou5yP
 j9tWBaVPcBBzIi/XvM7RT/FaZ+dMjb1i811SgS0+F7IkXFO6XMyNyOEjUFwRrhfErM3v
 Om9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788352417; x=1788957217;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=khFd/jDnlTA/XKPvSSegUBessMbx5oK9ggDT+W0TX84=;
 b=B/FLDO6iWWHKqpDYRePKobMvcAUc3ipMvDo6TJjSqBwUto4sjr8Q1VDbO9yG4YAQIM
 MTLCKVJZctPdAz5aamIY5nxQLZS2CJMN32dj5IhpLpTZfnuc6seobcXA8oG3D91YO0nZ
 KbLChkPSubQyIlt2D472UfCvhfjblrPr+eE/lEedgVn3ILP1qgJMYN3rThRgXRPHaGlV
 gDtKtHshzme3ALY8Ik9OCjlmdvHyRJAeoTc22Mo9gGCIknq77f0Ja8Drak8E0pXSJ7vc
 MxNTiiBUbZRF9hWNaS1Vztfp5aUi+Ybk7RJYPt1FAx/H9paIo5PXAKzRj+VBUX/VYpay
 xnpg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxBqUyqm6Z3mHuuW+pHVyUeyvhHJqoI5aDZEPT8XLrFGTiwLrENjERk4mZFKe20P/oJE9bzK9cN4+U=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kKhjVKIUvu/KNNZgUoxMfeOavmdpswcc+f7dW8iMADC8oF50Xx
 lgoRIkIePOUabQBb8saIcaJQYY2vVWvwfYAK4ouUrYECntnm6cEDrWNQ
X-Gm-Gg: AYBFou11sB716DeAMfxa6LVyEwPrIMEySVHJ2fXMR9CsX/gzGwIDNge273cke0b27DO
 LrRnCkZcm1arjCDmyYTVemSBCm0827r8MG6WdCdTucUIhh9F88C5s5lODRitJHnK0xd5H7i5Fo7
 Zv/LWS1GW3/dH4BKbAo1WBXqUx9E6BoT2J/A7ddBK9pFFFd1vJy0yLZG6wTHEO6Y+8QGYFfLEih
 8oo/5ayRL0QR4qBVdxt1c6WfkGodWSmmctoEYvaEvf36fGeALmaPYMLseU7QKHHIxbJ1hX+PIFK
 CpqRtn6A/UXZI8PdDpAXurTPoARIqnaDhpBaeQEe0BEB5oSPPb0/0atPEZHaqolVyt7pyEFdMsP
 NhTAEwQnaKUh4M1MS+Zfj4fYejcU8yziCYzbh1bQJBwx4XBKEECvlwQm121eTVwfmUOp2em63LV
 upPhs1cvQzCJJctK1wjE/c5cB6Qj2BbOa7oaKZ9haE3V6D7xWx40qdg1RB9UixHg==
X-Received: by 2002:a17:90b:390e:b0:398:9be9:ab8e with SMTP id
 98e67ed59e1d1-39aee124474mr5272135a91.19.1788352416561; 
 Wed, 02 Sep 2026 05:33:36 -0700 (PDT)
Received: from fedora ([223.184.183.166]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3990d4a1732sm11343190a91.7.2026.09.02.05.33.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 05:33:36 -0700 (PDT)
From: Sajal Gupta <sajal2005gupta@gmail.com>
To: rubenru09@aol.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, noralf@tronnes.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Sajal Gupta <sajal2005gupta@gmail.com>, Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH] drm/gud: fix out-of-bounds write in gud_plane_atomic_check()
Date: Wed,  2 Sep 2026 18:00:57 +0530
Message-ID: <20260902123254.36987-1-sajal2005gupta@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 03 Sep 2026 07:33:13 +0000
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

The plane property loop uses req->properties[num_properties + i] as write
index while simultaneously incrementing `num_properties` inside the loop.
At iteration i, num_properties has also incremented by i, so the write
is done at `initial_num_properties + 2*i`, skipping every other index and
advancing by 2 per iteration.

With just 2 connector and 32 plane properties the last write happens at
index 64, one slot past the end of the 64-slot (indices 0–63)
allocation. A USB device can trigger OOB by advertising the maximum
number of properties.

Fix by dropping the redundant `+ i`; num_properties is already the correct
running index, as gud_connector_fill_properties() fills the preceding
slots.

Fixes: 40e1a70b4aed ("drm: Add GUD USB Display driver")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260821071812.16500-1-sajal2005gupta%40gmail.com?part=1
Signed-off-by: Sajal Gupta <sajal2005gupta@gmail.com>
---

Verified with KASAN using a raw-gadget fake GUD device reporting 2
connector properties and 32 plane properties:

  BUG: KASAN: slab-out-of-bounds in gud_plane_atomic_check+0x1352/0x1ba0
  Write of size 2 at addr ffff88800d029a9a by task temm/270

  Call Trace:
   <TASK>
   kasan_report+0xfa/0x120
   gud_plane_atomic_check+0x1352/0x1ba0
   drm_atomic_helper_check_planes+0x2f2/0x9b0
   drm_atomic_helper_check+0x72/0x140
   drm_atomic_check_only+0x127b/0x3420
   drm_atomic_commit+0x124/0x2e0
   drm_atomic_helper_set_config+0xd9/0x130
   drm_mode_setcrtc+0xcfd/0x1b20
   drm_ioctl_kernel+0x167/0x2d0
   drm_ioctl+0x53f/0xbe0
   __x64_sys_ioctl+0x137/0x1c0
   do_syscall_64+0xde/0x4b0
   </TASK>

  The buggy address is located 0 bytes to the right of
  allocated 666-byte region [ffff88800d029800, ffff88800d029a9a)


 drivers/gpu/drm/gud/gud_pipe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pipe.c
index 5ef887d8485a..54adc401bc1b 100644
--- a/drivers/gpu/drm/gud/gud_pipe.c
+++ b/drivers/gpu/drm/gud/gud_pipe.c
@@ -562,8 +562,8 @@ int gud_plane_atomic_check(struct drm_plane *plane,
 			goto out;
 		}

-		req->properties[num_properties + i].prop = cpu_to_le16(prop);
-		req->properties[num_properties + i].val = cpu_to_le64(val);
+		req->properties[num_properties].prop = cpu_to_le16(prop);
+		req->properties[num_properties].val = cpu_to_le64(val);
 		num_properties++;
 	}

--
2.55.0

