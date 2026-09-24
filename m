Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E90EC9830D
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:31:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F39AC10F91A;
	Fri, 25 Sep 2026 07:30:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="tAsUNG7t";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C44EA10E960
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 06:44:37 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-398beb616f5so709793a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 23:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790232277; x=1790837077; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=umxBSp7tBrSSHgI3ytYK5kk1etwT5sOaqeI9/AKYgrI=;
 b=tAsUNG7tUD2YQ1Je7FFnn2Xawb1CT1ef3+qtSLnY1igmKmCHECIJws0uwsI2OtFGlI
 dMgLrDd1lq9QXYNqu14zxSO1DuK/D8CVhuwol4pZkcYVpzCvIRarFBSwaw73zKN741hC
 Xpm0abQFzrD+Nz8tDvMjBSC7d+SxDVj+mPt+v2CesqlBgBpeEvTdKcPgTKmqvZQsWSt0
 Fer6nPyLpBJn6oca+E3ynTdLTVC2WAyIqbtfVnpZzheBgCVJ5asVQp94OMWEePMPebfe
 ZkQAzrJfOb4Np03OS//UQf2WU6CPid9RJxjuX2oAYB2Q96oxKuJJAE6egyIikfbYRCWD
 6EHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790232277; x=1790837077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=umxBSp7tBrSSHgI3ytYK5kk1etwT5sOaqeI9/AKYgrI=;
 b=efXplhb8xYaPyEhssDwC520GKBNX+kLHBBw4oc/SIdZ9xgEF4lxx4WKTPIjzECPHZZ
 MHw7z9rcVDqKgpmQoUzgpsRaaRvgrDxpsrd/m9EqZ6pke8JGBhoK5fS4Y63qTaHBT3MK
 3sR5xXBchDp7sDgYh0/28psZQyTQQqT20eUzAsbWZ80AnBuXzYFOI6zHsVx743S2w1zj
 bw/qNgSenSEILhsPhqOW6qGJBIsX1545NMYiVcCDBWBKtiw+81+YPCIEEJtWCaOeMpBD
 CZae6qI46pJgjo1Fv8PgG03lo9OIsva76bIgQ0eZ553GvYsHlFJhjNMugIlvRs6gEpma
 rXXA==
X-Gm-Message-State: AFuF++l9gqO4YuIAa1e7GIrlBsX+G42+YiqzcETbaB5rKJF1aSPf319m
 znzMHEcLBT/ILIzPU3Dm/qs301+Rz4S/z7/dexSXxRz0XWcphrcAmxFe
X-Gm-Gg: AYBFou2QesQK95kZ22ZluEMPDYr8cMvhEs9z1LkU1lutPsEIks983xP+pdB+7te+C25
 FM27RQwa6H0ZsXR9v/kXRAnsz6OjBhJ1msD7bFmUXuKxY6jKo8LKXOFuQ71N3y8Yfp1CMgviwUl
 QeIoK3QQ6LfetJBb9VAUnKZjs3i/B5WLLpn8s5kMP4qa4/UYfwlZ/yxJWPyQXrXQaHGZCTjn0Wu
 6ZPkIJkrjct+4Wt1bfndCGhlN0bL4qpWTFzYBhTtBA9p+BT4QNSBidpwjhRNrr6LiB3Mw+w4slF
 7XNhZJfYDBAoZhAtk95mZs+zdJemBe9gL7272bpJORNcBg//UdKxe3/Wu1W+6FyMvNMbyd/RQvz
 cOXjXlo1DvE+a8Y2qVfmKjjPTt1RfRYwH0ggt+Xq4ZzIFfKbBTG/2EVvBJnsPGa428WTaIRNIki
 Oho6hfUYW9WGp6fntX+o5oX6FzJD9K/RtrGehOnVwAgk5s3sGXoC4rqd89vi0elN7X0/YDx/1J2
 LqH1KFzgswQYoSgkiGxISsVjnOll1SX0mX7+eqW1LGx+63QbGpvaKWobUx3f8vIvOsSLs1aLn+B
 bv20RiYGnQ==
X-Received: by 2002:a17:90b:564d:b0:39e:6c66:cbdd with SMTP id
 98e67ed59e1d1-3a098acb900mr888044a91.21.1790232277226; 
 Wed, 23 Sep 2026 23:44:37 -0700 (PDT)
Received: from phui-2.c.googlers.com.com
 (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0972efa0bsm2960830a91.8.2026.09.23.23.44.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 23:44:36 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: jani.nikula@linux.intel.com, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Hui Peng <benquike@gmail.com>
Subject: [PATCH v2 2/2] drm/udl: clean up USB resources if drm_dev_register()
 fails
Date: Thu, 24 Sep 2026 06:44:34 +0000
Message-ID: <20260924064434.2541959-3-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
In-Reply-To: <20260924064434.2541959-1-benquike@gmail.com>
References: <20260919223511.3889061-1-benquike@gmail.com>
 <20260924064434.2541959-1-benquike@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 25 Sep 2026 07:30:44 +0000
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

In udl_usb_probe(), udl_driver_create() calls udl_init(udl), which
allocates USB URBs and DMA buffers via udl_alloc_urb_list() that are
normally freed by udl_drop_usb() in udl_usb_disconnect(). If
drm_dev_register() fails in udl_usb_probe(), udl_usb_probe() returns
without calling udl_drop_usb(udl), leaking the allocated URB list and DMA
buffers because udl_usb_disconnect() is not called when probe fails.

Call udl_drop_usb(udl) when drm_dev_register() fails in udl_usb_probe().

Tested in QEMU against Linux 7.3.0-rc3 using dummy_hcd by simulating
a registration error in drm_dev_register(): on the unfixed kernel,
udl_usb_probe() returned an error without calling udl_drop_usb(udl),
leaking 8 allocated URBs and DMA buffers; whereas with this fix applied,
udl_drop_usb(udl) is called on error, freeing all URB and DMA
allocations.

Fixes: 5320918b9a87 ("drm/udl: initial UDL driver (v4)")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Split out as patch 2/2 as requested by Jani Nikula.
- Added testing details in QEMU on drm_dev_register() failure cleanup.

 drivers/gpu/drm/udl/udl_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/udl/udl_drv.c b/drivers/gpu/drm/udl/udl_drv.c
index 1922988625eb..239a6983f49f 100644
--- a/drivers/gpu/drm/udl/udl_drv.c
+++ b/drivers/gpu/drm/udl/udl_drv.c
@@ -97,8 +97,10 @@ static int udl_usb_probe(struct usb_interface *interface,
 		return PTR_ERR(udl);
 
 	r = drm_dev_register(&udl->drm, 0);
-	if (r)
+	if (r) {
+		udl_drop_usb(udl);
 		return r;
+	}
 
 	DRM_INFO("Initialized udl on minor %d\n", udl->drm.primary->index);
 
