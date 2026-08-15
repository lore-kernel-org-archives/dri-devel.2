Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06830C5DF70
	for <dri-devel@archiver.kernel.org>; Sat, 15 Aug 2026 17:31:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C48F810E222;
	Sat, 15 Aug 2026 17:31:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SOMxxLTe";
	dkim-atps=neutral
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com
 [209.85.161.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4438510E0F8
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 17:31:04 +0000 (UTC)
Received: by mail-oo1-f49.google.com with SMTP id
 006d021491bc7-6acc88b9c5fso1073608eaf.2
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 10:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786815063; x=1787419863; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9eBdlB/mya9lLTAlc5ou5OAcHoUR69Q2TaK5PmrsA1I=;
 b=SOMxxLTeAMzIo81JaFV+EJVHEnRL5u5dKQ0z+aACqFp54k5kmQMvZk/rL3fit1v9K+
 zsyzgNaoxZzT8qkqfPUgI569MAHKKr2LuYungVW2Ogh//7+OPqiJznaryoJCimhTQnqC
 iBGqqvs6vLPEvKlAL7uVI31Y5XCsenc5tqXJW2z8rYt4ziPD6lLMp0RMHWZTiiPHNZLS
 irhTx4PyR00cnq1E/0SVSEW9bwF3WCq3S78P1uR503sRa1D1Vxm7iJyCRevOAluSbsFA
 +If24aaSxIdjVp6ryq9AXGGqWCHc5GnTPabyQ/cpP/8g2LZDaj4UqTlCphOQqOw24lKX
 4SZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786815063; x=1787419863;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9eBdlB/mya9lLTAlc5ou5OAcHoUR69Q2TaK5PmrsA1I=;
 b=SbbvZAq7v4wavy8k20vGIV/AwxPlqzcXEBgdARHanSsLvq8b+RtaW4xFXgHI9lwOvG
 psnYAmaViJ84x/7hI/lmdLF3XWHBu38AMJMfJFpws2iYc0ZVOWuPXsknR0d77m2f20Pk
 Jo/xolrE/USExHcSUX5lwQ26O24C1ESDJp6I/G3gtTvXASfvhrnoNXFzk1oVzo2pjogL
 LZuBcLafXcbX2qOm/eFMxIxUHZI/XMjE5dFh0M+nk8HOCOtVuC6d2Ag26gazNsc+LYAB
 svuk4CjPeOwam4nPis2BtY4puUY2CDDBFuvvb/SIMiMApG3K2UD+IWp1Y2KrEklTFMLo
 uUjA==
X-Gm-Message-State: AOJu0YxXaaQeUnjM5TRHHxQNKJ4utuSJ+7niInhLlraCE9gd3DX8C8Em
 4w7arElnw9ucfh28v+duv2nN+kI720HB2sp4tqi2StmMPlyv6yl8wI2DDgC3E5Ev
X-Gm-Gg: AR+sD119flEu4V3lF5jjRlRegvJgcFqbap3p25q5HOa2tWBM4HbZH8I8LBvCvBqzc5Q
 pDGozSGHRvAkTd3viCTI3Ll2K6aHKeIAsO4VCgh5QQ81Rg4zxV3MB2gOXi9jlf/zy+W8lLnYWq9
 Iq2c9XqIdZ1UUNUWp7JUfHlcy1haaWKfjgLU7DjwHLr/WY1s6vMwZNzX5cZKhnHRj1tb1BiVZX2
 gRfVnUKw7nxg8t/6Fq/SBEJZyz0I1rlI7a19FXS/vixLw7MTS2+U7E2wcXzixo535js1IUIr44/
 69ZjNNulR8M5ccAFsxLkg8VqFqPXZxI4i13uChEgWn2W7RvX4MSWM+9UnsgIF6nrieLqhgvJx6o
 wFu1mPbfUunvX1HB9TPUzBQiA0TRls6Mb9WBNxHDLvO14aaAaLF7GI+IdUIclyqoHhguBhuM5g5
 qCLWvIhj3leb6odJ2+/dzom2h6ZS8w6muvQFhavyEWZJ2WAxzDicAQJV+BuOERJKEhv4+oOKHMs
 uC0++JM0Eg+6ghSbcA3HxMLXXDmir8O2xvM7B5k+Ozv4Kiqvg2L3DPdOLtrCccYspJulR1jD5n8
 he2NJPFLQL7DKjirBUc=
X-Received: by 2002:a05:6820:198c:b0:6ac:a45e:ff84 with SMTP id
 006d021491bc7-6b0d6178f68mr12492143eaf.13.1786815063400; 
 Sat, 15 Aug 2026 10:31:03 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 46e09a7af769-7f3e86686c4sm4029328a34.23.2026.08.15.10.31.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 10:31:02 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Sat, 15 Aug 2026 11:30:52 -0600
Subject: [PATCH 1/2] drm/nouveau: Fix NULL pointer dereferences in GETPARAM
 ioctl
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260815-null-fixes-v1-1-0df9dda951fb@gmail.com>
References: <20260815-null-fixes-v1-0-0df9dda951fb@gmail.com>
In-Reply-To: <20260815-null-fixes-v1-0-0df9dda951fb@gmail.com>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786815060; l=2757;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=MVZDrr9AdB0Vo7KRedm1n4U4GInx5SVFnRzNS1+N+Zo=;
 b=7UtxmLGZFzvMkY6BMZrEvXFUjeGPkc4RBlhqbpixxTBpEjYL4ZS4ob1Nv7UkTpsJorw7B6qKD
 7bNy0uHZI5LBKqx/0worjGBZzN0LRsOe6yk1r3TwhKZosmYiYY6NdZF
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
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

When hardware or firmware initialization fails, the graphics engine
(gr) or device functions may remain NULL. Attempting to access these
during the GETPARAM ioctl (e.g., NOUVEAU_GETPARAM_GRAPH_UNITS) results
in a kernel NULL pointer dereference, causing a crash when userspace
(GNOME/Mesa) attempts to probe the device.

Add safety checks for 'gr', 'gr->func', and 'nvkm_device->func' in the
ioctl handler. Return -ENODEV to signal the missing hardware state to
userspace, and use NV_ERROR_ONCE to provide diagnostic proof in the
kernel log without risking a console flood.

RFC:

These crashes may not be repeatable, they happened while I was trying
to build nouveau as a builtin module, with binary blobs in the kernel
image, on a laptop with an encrypted disk.  Gemini tells me this won't
work, so I punted.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_abi16.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_abi16.c b/drivers/gpu/drm/nouveau/nouveau_abi16.c
index 291203121f0c..c9270c5b0fac 100644
--- a/drivers/gpu/drm/nouveau/nouveau_abi16.c
+++ b/drivers/gpu/drm/nouveau/nouveau_abi16.c
@@ -306,7 +306,12 @@ nouveau_abi16_ioctl_getparam(ABI16_IOCTL_ARGS)
 		getparam->value = 1;
 		break;
 	case NOUVEAU_GETPARAM_GRAPH_UNITS:
-		getparam->value = nvkm_gr_units(gr);
+		if (gr && gr->func) {
+			getparam->value = nvkm_gr_units(gr);
+		} else {
+			NV_ERROR_ONCE(drm, "GETPARAM_GRAPH_UNITS: no gr engine or func\n");
+			return -ENODEV;
+		}
 		break;
 	case NOUVEAU_GETPARAM_EXEC_PUSH_MAX: {
 		int ib_max = getparam_dma_ib_max(device);
@@ -315,11 +320,23 @@ nouveau_abi16_ioctl_getparam(ABI16_IOCTL_ARGS)
 		break;
 	}
 	case NOUVEAU_GETPARAM_VRAM_BAR_SIZE:
-		getparam->value = nvkm_device->func->resource_size(nvkm_device, NVKM_BAR1_FB);
+		if (nvkm_device && nvkm_device->func && nvkm_device->func->resource_size) {
+			getparam->value =
+				nvkm_device->func->resource_size(nvkm_device, NVKM_BAR1_FB);
+		} else {
+			NV_ERROR_ONCE(drm, "GETPARAM_VRAM_BAR_SIZE: no device func\n");
+			return -ENODEV;
+		}
 		break;
 	case NOUVEAU_GETPARAM_VRAM_USED: {
-		struct ttm_resource_manager *vram_mgr = ttm_manager_type(&drm->ttm.bdev, TTM_PL_VRAM);
-		getparam->value = (u64)ttm_resource_manager_usage(vram_mgr);
+		struct ttm_resource_manager *vram_mgr =
+			ttm_manager_type(&drm->ttm.bdev, TTM_PL_VRAM);
+		if (vram_mgr) {
+			getparam->value = (u64)ttm_resource_manager_usage(vram_mgr);
+		} else {
+			NV_ERROR_ONCE(drm, "GETPARAM_VRAM_USED: no vram mgr\n");
+			return -ENODEV;
+		}
 		break;
 	}
 	case NOUVEAU_GETPARAM_HAS_VMA_TILEMODE:

-- 
2.55.0

