Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89258C5CFEB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 07:08:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C150710E02F;
	Thu, 13 Aug 2026 07:08:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UXqRtasL";
	dkim-atps=neutral
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com
 [209.85.160.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 286B410E02F
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 07:08:16 +0000 (UTC)
Received: by mail-qt1-f181.google.com with SMTP id
 d75a77b69052e-51c0c45c580so11887021cf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 00:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786604895; x=1787209695; darn=lists.freedesktop.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=SSbJwX3mVENBYQLVT50jOp9wDyIPziduBiZzfCOk5ZY=;
 b=UXqRtasLg8rocl+uOXuvl/avZ1zzbdf8iZEy1iGbv6EQBelQEjFgzYvGFkx5j2oApv
 hzkrtNJKYgQEra/g63ft1u37bowwPCqeZVF+J35rfJEOmhEdWOivKhJgFscR4D33f+Va
 n3gXof+1RNVOzn8RUbkW2xb2uydWowzLxw/6BJJ/MyieAAbh8CpeRMDVyIBYQoUjWqnA
 QfFl6jRoBdJeCitukfcRqkiANZXLA+lBZm1isz2FKBxoChEZIaXhT3syQZULT+si8VPQ
 rCUfk0eEgTPd1/yEkUcBaFnA8R45f7Ff+WHANUoebRt4BF5jFS2S4uR6M/Pftnp7MWyz
 bY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786604895; x=1787209695;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SSbJwX3mVENBYQLVT50jOp9wDyIPziduBiZzfCOk5ZY=;
 b=AGUor/UduyDxQ6Y8IXSWXPOztaC4djxgMHMt1MKP+DVPdclVeP6/5RSm0baV/6oyi5
 2ssTy22+WGEhW4R+Iuw628VSMX3GJ7lrhqT/RA2eeY0IV2DZn/yudBa5B4UiKmee0yTD
 K+va1CR1AHwUPqVWmm0EdJdnWEIkpWIbmx2rNIWe5W/0nWqPqzfD4fgrV8q2TSZQjFJ/
 BaKb7mQnipTvxgM1+V8VG8xdowQ8ItgR05xnnjC/xNF+q39DXRTs8vRI6VghLVvzmQ3n
 d/0pwkR4GzjZNCFtRy/JycmesLJ0vAEKdEuh697Rev1VyxNguiYZ6V93kUoPPKbVeqdW
 iibQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrI5Qs2dGcSl301PTCkZI4VzXeDXVnDTrUdW3hwemSNtSag7BnoRiTRNjRmqjoqu5t9i3nNxmCdNwg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyIDA8R5AVt5yhgmEVmFL0gSaYZnm/rypo1dhsg1BdfyBaoXsS6
 Xk+z1zoJ9EyuU3vc0xNctzV62bpKE2SepUEWGZyWSIkKJbPQ/hZy6624
X-Gm-Gg: AR+sD13HrL+kRfdDgnU/kWCYn0HFM58jW9dSVO4u5crjqTnNL6LMJEUUS07JlG3uCpy
 zoCMF/zCGZxOY9vWzUriN7T/SHDOAmIBVEjh7bqfVzYHl+A4JICDpicP87az6mJWdNYxotcyNMe
 TAvt5qjG/yFBuKtX3NJxqO9SZDM4GkdYdvxxoUkkYpGHd62hm8D0fdbo0HxqwL9Apg1fezsfXcf
 rifnZvRPHok0zfoqldTLXV1HehdzB1GnBV9nhi/8d7rqRiwcoQ1D2c1UgDMsoclwQRDKHu48JzO
 0EV0ur93jiDWUxaVdQ87pE9DU5PqsKepqSKHHwb+1/XqITmmEPp+fLDpZhlPD9O2gjn/FHDAN4s
 2p17EYupHScAK1K7eXjSsv2YBR6mZPQMRscESDGmUJl/fNHTHvel4zETo9An/AueMo9nbAXH4Is
 HAiS6mILVEqT8IFw3lTjxUU1WiK8kIBi7q2XUkIpKLhWLTa5xZ18G59iAxw5WD9JQ=
X-Received: by 2002:ac8:7d0f:0:b0:519:8b76:2ce0 with SMTP id
 d75a77b69052e-52d73e0144cmr31264241cf.37.1786604894953; 
 Thu, 13 Aug 2026 00:08:14 -0700 (PDT)
Received: from localhost ([37.19.206.57]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52d73dfaf51sm11432531cf.6.2026.08.13.00.08.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 00:08:14 -0700 (PDT)
Date: Thu, 13 Aug 2026 10:08:09 +0300
From: Dan Carpenter <error27@gmail.com>
To: Dave Airlie <airlied@gmail.com>
Cc: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/virtio: Fix a NULL vs ERR_PTR() bug in
 virtio_gpu_user_framebuffer_create()
Message-ID: <an1tWfHIHwtXd9SO@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
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

Smatch complains that returning a NULL here will lead to a NULL pointer
dereference in drm_mode_addfb2().  Return an error pointer instead.

Fixes: dc5698e80cf7 ("Add virtio gpu driver.")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
This code is obviously over a decade old.  I think this patch is correct.
None of the other implementations return NULL, but I haven't tested it.
---
 drivers/gpu/drm/virtio/virtgpu_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index 44ffffec550f..85ea252c658e 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -344,7 +344,7 @@ virtio_gpu_user_framebuffer_create(struct drm_device *dev,
 	if (ret) {
 		kfree(virtio_gpu_fb);
 		drm_gem_object_put(obj);
-		return NULL;
+		return ERR_PTR(ret);
 	}
 
 	return &virtio_gpu_fb->base;
-- 
2.53.0

