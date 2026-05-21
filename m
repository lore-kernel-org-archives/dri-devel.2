Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D96CD5BAB
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 22:35:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B03E10F41E;
	Thu, 21 May 2026 22:35:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="R/Fd2kn9";
	dkim-atps=neutral
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com
 [209.85.216.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1BF610F428
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 22:35:00 +0000 (UTC)
Received: by mail-pj1-f100.google.com with SMTP id
 98e67ed59e1d1-367c26471f5so4240625a91.1
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 15:35:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779402900; x=1780007700;
 h=content-transfer-encoding:mime-version:reply-to:message-id:date
 :subject:cc:to:from:dkim-signature:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nxePRALAuCuLKGdQGBAkFr6chHZ5b8o5iPVGAENbQcI=;
 b=pQ7HGQDHqc8c+zCfNFRv66nul5XCv2bVPYMs9rpryobGqsUyWzantxTYoSTD3jXYW/
 RXT3PyKlAkGcGyhtBn2ihXN5K7VDi4F0MtfkQnoodjlvoEK2nIyEGsq7V4ovFcyRsb/z
 Pj3AXeFGnNbY5OlhgccalvUoUSQJImiYiWZZ7CPXixTbxOJa2i4L7LgclpcozO4jpxWB
 MGQSCysw2fAPJmxr2x/8tWxPlbtRXkp732EnxPla2ZxX4OOl+cM0P255+WvIjpAhJLdw
 cybrdKe33H6xb8nscw+frY6aj3kBPQ/1HSCQrF/H8h24+ngvlN3Izkd2suTQgNeHBmef
 uKFQ==
X-Gm-Message-State: AOJu0YwxtnNLgXPiHSAEO4fZlSzYSVgIwrq3oLLJ6kVcE283U11Vjr4A
 xgVRhurduO8sQE9kWBsGSci/OP6am2KzRQ4sBkYkWSwDwm8Aa7WlpV1ZgXexVMnpHkQ+6qM6zOK
 fUiEL4nCF0kTbfxnTqofeTpdZyp4kZuduaIcoOGAJjcYClv77n2ipKKS9ewifMMrXvt4CFHk/rA
 NKM+Y994JmNAat+u9cXeLGjgwgjHcotlfTq0lFBZwlRG0xMO17etLjr0rUPiJFgDOypzIVwa4V/
 CqW4Hj+CZA3snDOJ64hFVRklCiY
X-Gm-Gg: Acq92OG8Ba0P2rtgIGuibYP8GV90/FdXwcwzBvltWX3Qf9aUI9uzTDGDGrMKxHqQgY4
 +tmNV/bseA/+kVOazSd1Izq34Y1t8EWHq4PsxlNniVDpNKP7LjEGIBo4eNegdPF9ucmxkFm0vn7
 AMbxplZENxVI1Gv2Yhz0KQagOS52W5evKXrnVTHxDjfbkKpNM3B7h/iAFYmOJ0ki4dA5PJd/9W8
 9r1YQHN7yPnv0MB0QjhI9FUYQS7zly/9j2fXWFDRDXkIyukSZrVfvMQ35fKa9SpBdWG2Hd1clbg
 rfvi/b3o9xHFF/xENfJDJtbnvQ6SSsxDN2eiyiUlzzfxy11EPRpGHWzW83zFnH9C0mG0MnVETzG
 sAU8z6Xrr/H4LKwhAqgeqtAXELKU+9+IDksoLZD3cRm32kyihTMFSpmYoMwzD/Y3k53cOICjeOs
 iBXxI+EDIUszk8nfDevWsZZNkdKW22xhIvT6n/mT+JkjrJF11EiceRC4obrIyYDE5y
X-Received: by 2002:a17:902:d48b:b0:2b9:cd2d:6f11 with SMTP id
 d9443c01a7336-2beb05992eemr8767825ad.18.1779402900134; 
 Thu, 21 May 2026 15:35:00 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2beb1170b13sm339315ad.51.2026.05.21.15.34.59
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 21 May 2026 15:35:00 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-516ccfa109dso19621321cf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 15:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1779402899; x=1780007699;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:reply-to:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nxePRALAuCuLKGdQGBAkFr6chHZ5b8o5iPVGAENbQcI=;
 b=R/Fd2kn93kJ+oVwoe9PsoN39VIFhsPB/UQlSHSFS6s1qZUmbftlfrIkIVAwwoNgIAw
 DMAfiQt83p1aXe+yRPfANrnExmdtDNQij+54UIdpi9uxZZkXjVzwYFS8cJ+vpTlSMbE7
 8G6bfPLpdCCbJSrdNn+f6TRSf8rdHXcga55Y4=
X-Received: by 2002:a05:622a:9:b0:50f:b9e6:e056 with SMTP id
 d75a77b69052e-516d4644e3emr20217271cf.29.1779402898879; 
 Thu, 21 May 2026 15:34:58 -0700 (PDT)
X-Received: by 2002:a05:622a:9:b0:50f:b9e6:e056 with SMTP id
 d75a77b69052e-516d4644e3emr20216951cf.29.1779402898432; 
 Thu, 21 May 2026 15:34:58 -0700 (PDT)
Received: from mombasawalam-Precision-5820-Tower.cap.broadcom.net
 ([192.19.50.250]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-516d6438582sm3351451cf.19.2026.05.21.15.34.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 15:34:57 -0700 (PDT)
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, ian.forbes@broadcom.com,
 zack.rusin@broadcom.com, Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Subject: [PATCH v4 0/4] Fix some issues from igt runs.
Date: Thu, 21 May 2026 15:37:52 -0700
Message-ID: <20260521223756.627311-1-maaz.mombasawala@broadcom.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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
Reply-To: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

I ran igt-gpu-tools with vmwgfx and fixed some issues I found.

Changes in v4:
- For ttm ref change, changed to incrementing the refcount on
the ttm base object of the dumb surface instead of holding a
ttm ref object so that it is not exposed to tfile.
- Added Fixes messages.
- Removed BO cleanup patch.

Changes in v3:
- Minor changes so series can apply cleanly on drm-misc-next.

Changes in v2:
- Changes based on Zack's comments.
- For vrefresh changes, removed stdu specific checks so that test
kms_invalid_mode@overflow-vrefresh passes with sou and ldu displays.
For ttm ref changes, fixed a ref leak in ttm_prime_fd_to_handle()
which fixes a memleak in test vmw_prime@tri-map-dmabuf and removed
release callback for dumb buffer surface since the gem buffer will
handle release of the surface.
Added commit to remove duplicate functions in vmwgfx_bo.h.


Maaz Mombasawala (4):
  drm/vmwgfx: Add some checks to vmw_cursor_plane_atomic_update
  drm/vmwgfx: Check vrefresh in drm_mode_setcrtc.
  drm/vmwgfx: Reserve ttm object before resv usage
  drm/vmwgfx: Change ttm refs for dumb buffers.

 drivers/gpu/drm/vmwgfx/ttm_object.c          |  7 +++--
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c           |  4 ++-
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c | 16 +++++++----
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h          |  1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c          | 28 ++++++++++++++++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h          |  9 +++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c         | 12 +++------
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c      | 14 +++++++++-
 drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c         | 12 +++++++++
 9 files changed, 85 insertions(+), 18 deletions(-)

-- 
2.54.0

