Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47839C5AE5D
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:38:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15EF510E668;
	Mon, 10 Aug 2026 06:38:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MpwAuXci";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 016FB10E0E5
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 00:26:42 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-38e08baf860so665567a91.2
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 17:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786235202; x=1786840002; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EgyjptlT6DdPuhzR18wm1dZCjjUWW4FZP2FThtl49rY=;
 b=MpwAuXciRWCQ8OAmjTpfPcqqEkc4KrNxgoZuPdus2COqG8IQG1s/b6A+LwfzKgAPKo
 9iJ2Dwus4UW84A0HIQ03haWDKEQAOplzIPHgwyRB/2+wqjNnD8Ir6lMw/bBz9sPsRtov
 yWBfk1nGN2T4chJedPceZJ3xiimpl244DlKDdBLywxQxQmBHH5/6BLA8LX6uwv3nTKUR
 2nel81jouBDKzx1U1HWz1CPeHTigX4TCjXPIJK+NcN846mLt10wSIp6qbAoFej5/co95
 1oEDTbbAyifMACPz3FaXu7SMF2zi3N+5I4tGIwqp2k8EQRnZn5dt+j0nGZn1MdJ5EORG
 vc4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786235202; x=1786840002;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EgyjptlT6DdPuhzR18wm1dZCjjUWW4FZP2FThtl49rY=;
 b=ZYep+V9ntAmVtSAI0EHqM3Sjfjl2MFxsJAJ4jbjXZVAGwceu8yVyFocB2U6w0JtSsp
 O5/ODTKpydcAXdDaIDr5o2BzkRRYjp/On5Z0baqH/fBYy3zP48EG1Uz5hI73mNixjiaY
 w6fGBfOYtR4Mpi7MY1S1FadlE8xcN3DhYdu/bWNUl4GephHcCGq7L2AmkOMzqY1COS8F
 Ks33u8pMyCc+exetOoRfU5TXWxVrsb2+TN8neRUnWVCO+R9XnHR0vTTgfhrOI0aU60Ph
 GSOrbRViTBkbpFTIMQ9WD5Ub8maQZDOA9dql04X8K1l9kKhwLouA9PE3C3ad90tu+Ccs
 4DfA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrBoW3mMN6sBx/rN8MVN9JONfLf2B6E1oupj9WydCkTH9U9Lo+ECNvnSHQ2yhOR/rID/inFDO1DDW8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywqu3aA+OzyHIWvIRhmxJswgEkhrT+RlxED846Up2nGxUB5Yf4b
 EwVQOxBedaxCol3oNSNB8qAbZMoZLaz0+CjDacKIjsGwmUnHZmht8I8U
X-Gm-Gg: AR+sD13UMSOKQKGrknaTKcShcHT+qjwERAili5uw33J/OiAr3JS/Q2Z45JpdNYEW5IN
 twfJwWBGSKp7q9lzh5x37K8HF+Ib0gMS7haSpPkzPGP7ZaTAIBxa17NXFlrv/btpU+yu9UM6Aep
 fnKcSYPfqbsCTWmImt+xJnPHabmd8JEiMvOD1NExRzPm+kAPOh+sp4exEnxUiOtw6t7JR7BVedg
 QkGRZJe1H8nU3kqhmBkEb+WCTgTKMLjT+FK6t9KgKePxgbdW46rHQU4TCFnRd8JTyZ8gZmfE8Ny
 SBEv1MYT17Vfjsx8qSPaAhq6nUVtax7hWHUMx4QfaXreXdpH0YUykBMKbHfJJdEd1Fb0umLbioL
 s/u0CgRITQ2HSpY8vPFFrZ1IafTCrag55NIBSINPEZl7A5jhdj+oFfA5VgM2Xj10LKJKZeBT+5R
 sK8HXyYZnY6vnqVhkS4P3nrcb2ovLUFXdDDWKyS7RwPT/x4eNmZTisiCvvdh2o8LM=
X-Received: by 2002:a17:90b:1843:b0:37f:bfa2:1887 with SMTP id
 98e67ed59e1d1-3903c53639amr35887499a91.8.1786235202259; 
 Sat, 08 Aug 2026 17:26:42 -0700 (PDT)
Received: from beelink.. ([186.22.57.86]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315beb8844fsm25270201eec.16.2026.08.08.17.26.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 17:26:41 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Dave Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, virtualization@lists.linux.dev,
 spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v2] drm/qxl: fix 32-bit overflow in the ALLOC_SURF size
 computation
Date: Sat,  8 Aug 2026 21:26:21 -0300
Message-ID: <20260809002621.122832-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:37:47 +0000
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

qxl_alloc_surf_ioctl() works out the backing size of a surface with

	actual_stride = param->stride < 0 ? -param->stride : param->stride;
	size = actual_stride * param->height + actual_stride;

where size and actual_stride are int and param->height is __u32.  Every
operand comes straight from userspace through DRM_IOCTL_QXL_ALLOC_SURF,
which is DRM_AUTH, and the expression is evaluated modulo 2^32 with no
overflow check.

The wrapped value is what reaches qxl_bo_create(), which only rounds it
up to a page.  The original width, height and stride are kept verbatim
in bo->surf and are later handed to the device by qxl_hw_surface_alloc()
together with the address of that undersized allocation, so the driver
tells the host about a surface far larger than the memory backing it.

For example stride=4096, height=1048576 gives
4096 * (1048576 + 1) = 0x1_0000_1000, which truncates to 4096: a
one-page buffer object described to the device as a 4 GiB surface.
Measured on 6.12.101 by probing mmap() lengths against the resulting
GEM object, the backing is 4096 bytes while the surface declared to the
device is 4294967296 bytes.

Two smaller problems are fixed at the same time.  Negating param->stride
is undefined for INT_MIN, and unlike QXL_ALLOC there is no rejection of
a zero-sized request.

Compute the size in u64, which cannot wrap for the u32 inputs, reject
INT_MIN and zero dimensions, and bound the result so it still fits the
int parameter of qxl_gem_object_create().

Fixes: f64122c1f6ad ("drm: add new QXL driver. (v1.4)")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
v2: compute the size in u64 instead of size_t, so the (height + 1)
    addition cannot wrap on 32-bit either (reported by Sashiko AI review);
    the v1 <linux/overflow.h> include is no longer needed.

 drivers/gpu/drm/qxl/qxl_ioctl.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_ioctl.c
index cd1901d5c7c0..75abfc1db0f5 100644
--- a/drivers/gpu/drm/qxl/qxl_ioctl.c
+++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
@@ -385,12 +385,24 @@ int qxl_alloc_surf_ioctl(struct drm_device *dev, void *data, struct drm_file *fi
 	struct drm_qxl_alloc_surf *param = data;
 	int handle;
 	int ret;
-	int size, actual_stride;
+	int actual_stride;
+	u64 size;
 	struct qxl_surface surf;
 
 	/* work out size allocate bo with handle */
+	if (param->stride == INT_MIN)
+		return -EINVAL;
 	actual_stride = param->stride < 0 ? -param->stride : param->stride;
-	size = actual_stride * param->height + actual_stride;
+	if (!actual_stride || !param->width || !param->height)
+		return -EINVAL;
+	/*
+	 * size = actual_stride * (height + 1), computed in u64 so it cannot
+	 * wrap on any architecture, then bounded so it still fits the int
+	 * parameter of qxl_gem_object_create().
+	 */
+	size = (u64)actual_stride * ((u64)param->height + 1);
+	if (size > INT_MAX)
+		return -EINVAL;
 
 	surf.format = param->format;
 	surf.width = param->width;
-- 
2.43.0

