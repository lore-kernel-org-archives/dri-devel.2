Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB59D3942C
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 14:11:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F29C10EF7A;
	Thu,  2 Apr 2026 14:11:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="EXq7Vuka";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D97810EF7A
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 14:11:06 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-486fc4725f0so9690355e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Apr 2026 07:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1775139064; x=1775743864;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=x+ekjncP59XWcpI8woAJDAw1Fg3HF0fV5kIcIgDAtdU=;
 b=EXq7Vuka5n+VubWx9yZ06SPngRanxozAdjDc7hPEvZF2rq+XdnyGmLZXFatATnIp6G
 SNE++AH5XBkIRsoBC39AzGbBLNZJfR7vHMnV+K2u5QNrhhxrUYJn04tOPjQoJ50OGThl
 z4e0Ht5+I0vnPEIP6zPNs3WleOk0bWwt9SA/kqgDIpOA+OyiB1BIP4ZWqRffUYMpoQ8C
 qsuIBvYMK40N4D0mjT8DwL9W4DD2gGJ1ydFIiXamRQv4GZS7xcHn1q3/VovSZKbspwv+
 Wbc4dQ1T9rgzg2qbfkM2QYrQBQ0sgF0O1m7L2/muxr87wmFavyDPItuGsgbRCrB8RjmE
 m+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775139064; x=1775743864;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x+ekjncP59XWcpI8woAJDAw1Fg3HF0fV5kIcIgDAtdU=;
 b=PWtYPzluSJFHmcg1P0imUqs7eEAu35AloyuynFhPBJaFUZpCYFI1kCmqoDKZXEUbjb
 oGLxsYm7qU0yawhfrMKvPIrig01zV89sJeU5Ys8sxMWAOG2Yn6BidaXkYGU7Rz78kt9v
 8eXRpGXbTrl536YFDSOMtr2JJZ3SGWljsZliwH2cASoHeddoeRbhLeHljQJ0HRLvhPlr
 SMMWRmoYefFXvVBGhJLQmEr1/hfpwkJ/VIm+GadXSvU60Vy2z9qdSp/TQKsIt8ekLSQD
 msVvePVvvo6KeqJjMj5+jAsvpvq5csigfYC8rurYzzFpSaJmDznixrEZZ4urbCGwDKv4
 KmqA==
X-Gm-Message-State: AOJu0YyQBzNebUWg/4nbcJAcbv4y7jbFjmblpQLSfupf8Ox93OmNW9vc
 ZGQiONmT78k+4Kd47h/j4LSt64uVKZgfEPKksUxRSVc8MKAIXCqxZdDv++4+4YkXwfz59Js08S7
 bJ3tu
X-Gm-Gg: ATEYQzyBHdFGbmbXR47fGgDoVI+NiZdl4G2WGKAbqlnp2yei1sHOTXelwW+4DWCBuBT
 VrEdQppGYKmVnku1u/ci7KwcX2a+v0MBrRF4biOJdv/pRgWI1E+DPctR2VhUVEf4cIF0zIISQJA
 LpswfYH/I9G4qljXwkQMlTxam7ZgSUxeMiawEHElKiHb4IjgtX2JfQRlcPyG1KtoKGCWOrnKftP
 wxE2x5dQq9+wmdBxbrbxU9ZQXHT2Y+z9ytPujsSeaMneziM/GEiUZluFOoCP1SZDwfVxfKXHT6v
 QH0+OrWg8RaAD6u3VDIUztYQV6GH43LAtBx6ikwlffCeTJnj5MzPBmbCmbi0HzUZYsbNSWdNjhb
 wvDAEoUxj4peo49uNoPmffZpLDvO2RuwWS2x/ePEvL7yESK2u8ToIfoILFSNRGelcK4PifzBxpr
 CfK/CJX457gP/4Ng==
X-Received: by 2002:a05:600c:8708:b0:486:fe83:861c with SMTP id
 5b1f17b1804b1-4888e064a89mr45823005e9.7.1775139064484; 
 Thu, 02 Apr 2026 07:11:04 -0700 (PDT)
Received: from localhost ([85.163.81.98]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48891d5437fsm20447355e9.5.2026.04.02.07.11.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 07:11:04 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 iommu@lists.linux.dev, linux-media@vger.kernel.org
Cc: sumit.semwal@linaro.org, benjamin.gaignard@collabora.com,
 Brian.Starkey@arm.com, jstultz@google.com, tjmercier@google.com,
 christian.koenig@amd.com, m.szyprowski@samsung.com, robin.murphy@arm.com,
 jgg@ziepe.ca, leon@kernel.org, sean.anderson@linux.dev, ptesarik@suse.com,
 catalin.marinas@arm.com, aneesh.kumar@kernel.org, suzuki.poulose@arm.com,
 steven.price@arm.com, thomas.lendacky@amd.com, john.allen@amd.com,
 ashish.kalra@amd.com, suravee.suthikulpanit@amd.com,
 linux-coco@lists.linux.dev
Subject: [PATCH] dma-buf: heaps: system: document system_cc_shared heap
Date: Thu,  2 Apr 2026 16:11:03 +0200
Message-ID: <20260402141103.598495-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
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

From: Jiri Pirko <jiri@nvidia.com>

Document the system_cc_shared dma-buf heap that was introduced
recently. Describe its purpose, availability conditions and
relation to confidential computing VMs.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 Documentation/userspace-api/dma-buf-heaps.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/userspace-api/dma-buf-heaps.rst b/Documentation/userspace-api/dma-buf-heaps.rst
index 05445c83b79a..591732393e7d 100644
--- a/Documentation/userspace-api/dma-buf-heaps.rst
+++ b/Documentation/userspace-api/dma-buf-heaps.rst
@@ -16,6 +16,14 @@ following heaps:
 
  - The ``system`` heap allocates virtually contiguous, cacheable, buffers.
 
+ - The ``system_cc_shared`` heap allocates virtually contiguous, cacheable,
+   buffers using shared (decrypted) memory. It is only present on
+   confidential computing (CoCo) VMs where memory encryption is active
+   (e.g., AMD SEV, Intel TDX). The allocated pages have the encryption
+   bit cleared, making them accessible for device DMA without TDISP
+   support. On non-CoCo VMs configurations, this heap is
+   not registered.
+
  - The ``default_cma_region`` heap allocates physically contiguous,
    cacheable, buffers. Only present if a CMA region is present. Such a
    region is usually created either through the kernel commandline
-- 
2.51.1

