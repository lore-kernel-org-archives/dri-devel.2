Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8452EDB7DC
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 09:26:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1835410E394;
	Tue,  7 Apr 2026 09:26:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="nLrZWKKj";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF53710E394
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 09:26:20 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4889e045bc6so30810635e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 02:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1775553979; x=1776158779;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4JppuW+8jHhiWrz5kQ42R8XjkKGXIqfSYDySDPjjqyw=;
 b=nLrZWKKjObT0O1maRBgYvLoLWsORSPxwxaK7epJ3NZv99dgUOsCN4pww4KpDqCowUw
 bCdtxzQeIvU3gVQ3jMUxriSBhRw0WKh9l/fOjVxd23miKvDSQj3cvwrc1oNxBxMkiKko
 6WGSBMjKOAe/kIkAEeFvbrdo/lpJGXAzoynuhm0+eU23RJvTgRD3eoxC8uAlaPGxxgKG
 7VMHcRcu73TirG11HRJLOJns0tc+YIYI2D/Mc5rO9IddHoLF7QElGuKo3GuTG6vd7WhY
 V2BKJaIKGeHFh01zMKqeCr9cb02QL7PD4ZXvq8JUBsO5qL9EYSl0NtZhdHFvR8Ot5kg8
 l2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775553979; x=1776158779;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4JppuW+8jHhiWrz5kQ42R8XjkKGXIqfSYDySDPjjqyw=;
 b=YglteWwBU3QGj3fC2/gZ/O/8/1VpAulJpOxH1BZPSCh2zxwUktKpb9OyZjU3Izu/YV
 hLcJuXErfZOVQwKyqcBJV3LrsuihDmk6ZxfsBmflK3R1ov8RTbHZBstss3bjTDBrvXgE
 v97+WNpDhbo6BfdvbQTdx4U+wu8lFUmdScl0yFADoZzPrJs8xCzDwHVlWQQwJEI3LjOS
 B0TFnmrGXrZP7ianJ1xy+GoXt38horEM5OuslwnbkNkAFEEsea+7+rrGk/npuiYWek5L
 NT9kQ1OZPMDziTwQijzrVIAJdM0jGMql30KCt6uepUj6DgSx6lEofXhR/wtSEPuVwiIp
 sGUA==
X-Gm-Message-State: AOJu0YyunHupUQn5cCLur5mapH3PlIox6vfry0iBePhW6x4EPkTsvz6+
 NOoYFAveyGEkcLP1AFH1z7Y6f/oSKGFnJY/FNJFafZ7J5OQi3shdwZB0Tj/VarXUP80PbKuWY8K
 nOKuN
X-Gm-Gg: AeBDievGz6GIsfrfT2B2/uinNVQV10sFcyENIiprWGQuInvDKCFqSidVW+pKHy1cIAF
 FVB8cKagFTEYdePUw/1PnkAzvOBsylc/FH+8QczG8XKlFykioF+Tbsi3KLuxyX+RVqK25vNf0ZJ
 hzffAcss2Olkaq4BHbYaVKw0o8AaroojWuX4UJgQgy+PUSUGJ1f6FAeE1BdZ34dmW1PIbc1qU+V
 vpV11yLg5vKZrXNbptfo3/fd5vsybuFa0vCEbIJjssKzFUUmUmTQn9lw0wShSnQGc6gkWt/Kcb/
 HeLLuheY76drDHDGUAJD3/FaDNF7KltOhRVvMbMsUtJ1k1h4a971Izl7Qtk7DOCy/dHQwhoqOZO
 ix4Z4IgwIed0kg2F0BGbnRtyGFDxQBTwvstJff//YxT4FurrpcepD8A7j6Mx9c/Nl6bYOvtdctm
 hOTgj/9z2WF90fjw==
X-Received: by 2002:a05:600c:6098:b0:488:9fb7:376d with SMTP id
 5b1f17b1804b1-4889fb73b1amr196429615e9.28.1775553978818; 
 Tue, 07 Apr 2026 02:26:18 -0700 (PDT)
Received: from localhost ([85.163.81.98]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488a91686f9sm268832955e9.10.2026.04.07.02.26.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 02:26:18 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 iommu@lists.linux.dev, linux-media@vger.kernel.org
Cc: sumit.semwal@linaro.org, benjamin.gaignard@collabora.com,
 Brian.Starkey@arm.com, jstultz@google.com, tjmercier@google.com,
 christian.koenig@amd.com, m.szyprowski@samsung.com, robin.murphy@arm.com,
 jgg@ziepe.ca, leon@kernel.org, ptesarik@suse.com, catalin.marinas@arm.com,
 aneesh.kumar@kernel.org, suzuki.poulose@arm.com, steven.price@arm.com,
 thomas.lendacky@amd.com, john.allen@amd.com, ashish.kalra@amd.com,
 suravee.suthikulpanit@amd.com, linux-coco@lists.linux.dev
Subject: [PATCH v2] dma-buf: heaps: system: document system_cc_shared heap
Date: Tue,  7 Apr 2026 11:26:17 +0200
Message-ID: <20260407092617.635223-1-jiri@resnulli.us>
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
Reviewed-by: T.J.Mercier <tjmercier@google.com>
---
 Documentation/userspace-api/dma-buf-heaps.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/userspace-api/dma-buf-heaps.rst b/Documentation/userspace-api/dma-buf-heaps.rst
index 05445c83b79a..f56b743cdb36 100644
--- a/Documentation/userspace-api/dma-buf-heaps.rst
+++ b/Documentation/userspace-api/dma-buf-heaps.rst
@@ -16,6 +16,13 @@ following heaps:
 
  - The ``system`` heap allocates virtually contiguous, cacheable, buffers.
 
+ - The ``system_cc_shared`` heap allocates virtually contiguous, cacheable,
+   buffers using shared (decrypted) memory. It is only present on
+   confidential computing (CoCo) VMs where memory encryption is active
+   (e.g., AMD SEV, Intel TDX). The allocated pages have the encryption
+   bit cleared, making them accessible for device DMA without TDISP
+   support. On non-CoCo VM configurations, this heap is not registered.
+
  - The ``default_cma_region`` heap allocates physically contiguous,
    cacheable, buffers. Only present if a CMA region is present. Such a
    region is usually created either through the kernel commandline
-- 
2.51.1

