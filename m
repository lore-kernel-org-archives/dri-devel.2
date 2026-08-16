Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F73C5DF66
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 19:43:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAD3C10E349;
	Sun, 16 Aug 2026 19:43:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S1k/7nPP";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 602CF10E347
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 19:43:15 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-38e69bdb0fcso2027249a91.1
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 12:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786909395; x=1787514195; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ydLps/ZPHHAYsp8FMI46WDrtPvUmvDidY0XGhqyT6ys=;
 b=S1k/7nPP/mUKwxzHk2pXN9olHuFieHscV9o3/fU9rqkL7ItSh+DN7jQf1L7dv4k3TF
 IWcSt9h+UBhWSEyPHGBZz8otYLLMhKU97EeqXMtMjXVi2Vy07U21g+Dh9VDf0r5WzOeN
 2nyquq9oDQqAYlFmBMhcYzhmZkm0ITHfXE2BUfepZ4X9V4IxZCiF1ghZLdSufeDZ75sz
 /er1mqMZNXd3TeKNeCw8zeMa+2kXxYfI/P7v1rBugisbiWq2SqyEM6/+WLcwsP28C81B
 RtBDl5CCCCn2XmYf/VkRBLlpGxCA1F33it0DDJ7speBn2L2+zkZX7F0Zn5tPmi0lZQiD
 ayoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786909395; x=1787514195;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ydLps/ZPHHAYsp8FMI46WDrtPvUmvDidY0XGhqyT6ys=;
 b=hOPh8e7PbvtgUhhf7YocXmvj2u0/sQW6ADeUNs/PqDgyeT3hdOSJJ2B4SEa+Ro4uZ1
 NdL6rv+i+nbbJvm9aWiy9OMNfSPutzxcRuwY2Yxf3vl29qM5OSw67+HvLt1iTfAjJxM/
 l/B92OIWqJFnxjGf6bhOG8HnBxmQ9giTxSF2clAt1RIOzMRuDbSjxYwvvaqduJa1T5tI
 GW/5b21esnceIsE+PpcjLu1ksPG2T+X07i/WxIuV1DAsARNbZ3qt5EzabNXRZGGSLNy7
 jLbnfI6tkgg4bUt+zPZBuHgQZP1xcu4QDHLDNz8Gi7JSm0q1ccWBqW2dDX/92vMq4GLc
 19OA==
X-Forwarded-Encrypted: i=1;
 AHgh+RppGtDC4eX4MCFJv7fcLUCejaV4gTOrQcOR+URBmcfWUXM4sHOLOyQsHeMaA8OM8Op8b5nVsXw77yM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw0rrRSp2WOu/dm1VSz7GwJXwf26SyX79PVf19tZaslrWSExukN
 pT+DrQwmKRU0+dMPSch2p3ut55EDuMftFIqOOkkINC3gJWkMUdpwdPqM
X-Gm-Gg: AR+sD10lwTbux9Xc7pSaUzBhBhbyCyRk1TOrtz0awNQT6irU0+JqPyo7vfWN+abY8kK
 YVRlRSGHVPj9k1jx3emyCeV3t1gmb/SYPRJjnCfCx3C9n5+zM3/ltfQA8Wu2MQql/QB548RZn3m
 QsZjepZan0ZI1Sx67kkt9s1Q6Wa1icy6UAD9Lj7oWge0wEKK9lLqWsPCO6F5F1Xo785nfGGpHsU
 +MnvAccMULWYmOo0xOWg1+tJ3SkVG5cFfLlA4h742iSe1t+NtUDBczKfevwTD1x9h/y8QojVRYC
 PaR3pF/POUjnGwzKB7P9AXVVayKq83oVVwYf+UnRN4X/LRwc6D6wh+okjYDLXTpWoCK7Sagpi3l
 6QUu8Bs+FkdzqPesNM866aJ8ibp8Pn2G81rtv3TY/rvw8pFQDVk4KgSV97UARf2IkPZoshLZNGn
 XmlgucfECW4VmEgGUncAt+Bv6K7tObA7MSEPCsbjLWqHjpBsyh2Yqwbw==
X-Received: by 2002:a17:90b:2d4c:b0:37f:f4ae:5f25 with SMTP id
 98e67ed59e1d1-3933ed3fd54mr22196582a91.20.1786909394819; 
 Sun, 16 Aug 2026 12:43:14 -0700 (PDT)
Received: from [127.0.1.1] ([1.243.227.27]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395320229f4sm2141310a91.15.2026.08.16.12.43.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 12:43:14 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
Subject: [PATCH 0/4] drm/imagination: Add async VM_BIND with sparse
 mappings
Date: Mon, 17 Aug 2026 04:42:07 +0900
Message-Id: <20260817-pvr-vm-bind-v1-0-0a0f21be7d38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI8SgmoC/zWM2wrCMBBEf6Xss4tJKUb9FfEhl61dIbFkayiU/
 ruJ4tucYeZsIJSZBK7dBpkKC79SBX3owE82PQg5VIZe9Sd11gbnkrFEdJwCak/DqC5WGzNAfcy
 ZRl6/ttv9x/J2T/JLU7SFs0Losk1+alXIESOLP/4DJloX2PcPDoj2jpgAAAA=
X-Change-ID: 20260817-pvr-vm-bind-1ce4f09a1774
To: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Matt Coster <opensource@mtcoster.net>, 
 Donald Robson <donald.robson@imgtec.com>, 
 Sarah Walker <sarah.walker@imgtec.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, Gyeyoung Baek <gye976@gmail.com>
X-Mailer: b4 0.15.1
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

Userspace MR: 
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/43794

Add DRM_IOCTL_PVR_VM_BIND for Vulkan sparse binding.

- Patch 1 is an independent fix the rest needs first.
- Patch 2 switches the GPUVM to immediate mode.
- Patch 3 adds the VM_BIND ioctl.
- Patch 4 adds sparse mappings to it.

Routing VM_MAP and VM_UNMAP through VM_BIND is left to a follow-up.

Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
Gyeyoung Baek (4):
      drm/imagination: Fix the vm_bo split mappings are linked to
      drm/imagination: Switch the GPUVM to immediate mode
      drm/imagination: Add async VM_BIND ioctl
      drm/imagination: Add sparse mappings to VM_BIND

 drivers/gpu/drm/imagination/pvr_device.h |   9 +
 drivers/gpu/drm/imagination/pvr_drv.c    | 102 ++++-
 drivers/gpu/drm/imagination/pvr_drv.h    |   5 +-
 drivers/gpu/drm/imagination/pvr_job.c    |   6 +
 drivers/gpu/drm/imagination/pvr_mmu.c    |  71 ++++
 drivers/gpu/drm/imagination/pvr_mmu.h    |   2 +
 drivers/gpu/drm/imagination/pvr_queue.c  |   3 +
 drivers/gpu/drm/imagination/pvr_vm.c     | 636 ++++++++++++++++++++++++++++---
 drivers/gpu/drm/imagination/pvr_vm.h     |  27 ++
 include/uapi/drm/pvr_drm.h               | 135 +++++++
 10 files changed, 934 insertions(+), 62 deletions(-)
---
base-commit: 09b47186a4164f3aaa3591313f80794443117342
change-id: 20260817-pvr-vm-bind-1ce4f09a1774

Best regards,
--  
Gyeyoung Baek <gye976@gmail.com>

