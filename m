Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5931BC5CFEB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:43:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4979110F26A;
	Thu, 13 Aug 2026 09:43:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DBMQEz3x";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F7EB10F052
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 14:57:03 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2cacf197759so21719565ad.2
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 07:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786546623; x=1787151423; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YJqzV4FfWSH2549UJL4Hdtad7cbUf0wdUKVbd4knoqE=;
 b=DBMQEz3xyWkSdPrL+k49xiENJfMQBHaYKpYRfQ07qzBbSeMksM/R3arub6XvgBuTKY
 Jy+MfFZuwgoehB4KHZ0DkCeXPVmMttSZRcmyA1DPxU3FqaOxJVWXedcqTsfbMZ7xwDy/
 6/9OFTZ2tHLsbcbUBgmif/46bB4ULTooFFR42iP3sUN6Ee+5Us5YDkaFB+lnl19SOhtR
 AkBixg3Cg45Nf72JEIBHTllxBPO+PeeFVjoc/7sOkAsyDtPdhDwk/nGEHH0lNpxe+VcW
 QHjjR5t4aagZlpHaakAA/QsUOqpvgzf+du9w2YnjyVL5sd4ahKM/NZkxkJTbZc0b2VW2
 M08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786546623; x=1787151423;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=YJqzV4FfWSH2549UJL4Hdtad7cbUf0wdUKVbd4knoqE=;
 b=PCGEVmo5MXT1RMuQ0KnckGhnnko97OPFKqX3Y57yIyiTWQSZhHu70gWza8Y3uX89yD
 TWGweOBmiHvO41GxbLy2V1tTux+vDCde/e9bfHMgpo1xXSuttkLDwNT1mH/dpCEGft3N
 TBikVK1i0LlEBmsWrowUepvr+yqdNbWC5wsy+eW5Wg7YQJ2erMMajQLyegkvkmAIe7Wu
 Ej/zI2DPFVwWSk3Y7SLIKyMMCaZqAhxoewkGFpfNGG4zVMZY96XXF+Od8UBOK/PI5AXE
 Ya3tz9x5k+VjZHpfcIgUMYvvx/a+ly+RplAyIcgzqOhd8iVqHsZL+Lhkf1jo35380P3B
 /G0A==
X-Gm-Message-State: AOJu0Yx81tHRivprQBKR/nGlyfH44zjyN4zPEaNDlMg/U+q60MbiZbh2
 DZtfR0pbjJ7k6DQlvbALMstJvETWZ/tVLsBnq16lPpQ6olL5D2yxPGWOOaT/TRT3
X-Gm-Gg: AR+sD12wtWsNs05DpDpwlno4g3yvZCe0GdjZEIUq3xh3gy4CcI8wu0xyS/zAXjYVC98
 mfj+D+C9bP9y4RXD8EXECiWoI4G09fj414eZar3PqE+j6YeezZHERAKdznC6GA7I/IS12jEAn4E
 hoSAhhz9eETm7D2N7xPtCPQPcXSsLUdB/1yZ/TUDiqzBHDeeut+KYbiAzEO8BCphnftdYwXKSEX
 dcMLpn9b2ahLYNOR6T6YeHelsyp2W+jHt9Z7BzoRjzEaz0KwK0Nr2NZbNb7aYo8T5pPB0xE7HxT
 QcKATiLwTFxgeKU0flzwK1pkSZYn6ngtr9piFottzc2kKUD/UrwyQ9iccXO3Q5Aa8z5xl6BlsMB
 H7SRAhVpSJgFzcHbQ2qt8BopFCz0I1E4kB12CkJw0LJtc2R6GedsofIT467sfJR4KKPM+ONwsLr
 EPW4FuDFnkWJijN6+kyZRavSu6q+ZnlxTcF/Ybg22BWy6FMsLDMcsIzp5fka8=
X-Received: by 2002:a17:903:324d:b0:2ca:4f33:e86f with SMTP id
 d9443c01a7336-2d3455870eamr75737575ad.12.1786546622846; 
 Wed, 12 Aug 2026 07:57:02 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.52])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d352208543sm8003165ad.60.2026.08.12.07.56.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 07:57:02 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Wed, 12 Aug 2026 22:56:46 +0800
Subject: [PATCH] drm/nouveau/uvmm: reject zero-length range in validate_range
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-nouveau-uvmm-pt-fixes-v1-1-ab3a823f946e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAK2JfGoC/yXMQQqDMBCF4avIrB1IImjrVcRFjGM7BaNkTBDEu
 5vq8uPxvwOEApNAWxwQKLHw4jN0WYD7Wv8h5DEbjDK1emmDfomJbMSY5hnXDSfeSfDdqHq02qr
 KTZDbNdA95LTrH0scfuS2/xmc5wUrhSUxeQAAAA==
X-Change-ID: 20260812-nouveau-uvmm-pt-fixes-9706da1a03cf
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Airlie <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org, Zhenhao Wan <whi4ed0g@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786546618; l=1968;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=FdyxRhhBKZiYZz3arqKV848UtUVhcBBrpdMBwG2g/dM=;
 b=ar5RYS5eT7jVtxn2WyhdU/5ZUt+UbSy5eflTkgD7wLRWZEeSTi2xLVN1+tdVDVmKDg8elm2v3
 1ZlEgthYLiQCWaVIbnBvP5OHkT64+EpC1XNJ887M4atJGbdz4l+31Wx
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=
X-Mailman-Approved-At: Thu, 13 Aug 2026 09:42:01 +0000
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

nouveau_uvmm_validate_range() rejects misaligned addresses and ranges and
defers the remaining bounds check to drm_gpuvm_range_valid(), but neither
rejects a zero range: 0 is page-aligned and addr + 0 does not overflow, so
a zero-length VM_BIND request from userspace passes validation. It then
reaches the generic GPUVA interval-tree insertion, where the node last key
is computed as addr + range - 1. With range == 0 this underflows to
addr - 1, producing an interval whose end lies below its start. The
resulting malformed node corrupts the augmented interval tree and misleads
the overlap checks of later map/unmap operations on the same VM.

drm_gpuvm_range_valid() intentionally leaves the zero-range rejection to
its callers; drm/imagination does exactly this with an explicit "size != 0"
test next to its drm_gpuvm_range_valid() call. nouveau simply omitted it.

Reject range == 0 alongside the existing alignment test.

Fixes: b88baab82871 ("drm/nouveau: implement new VM_BIND uAPI")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_uvmm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
index f5e4756b4de4..0efedd9ecc75 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
@@ -1008,7 +1008,7 @@ nouveau_uvmm_validate_range(struct nouveau_uvmm *uvmm, u64 addr, u64 range)
 	if (addr & ~PAGE_MASK)
 		return -EINVAL;
 
-	if (range & ~PAGE_MASK)
+	if (!range || range & ~PAGE_MASK)
 		return -EINVAL;
 
 	if (!drm_gpuvm_range_valid(&uvmm->base, addr, range))

---
base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
change-id: 20260812-nouveau-uvmm-pt-fixes-9706da1a03cf

Best regards,
--  
Zhenhao Wan <whi4ed0g@gmail.com>

