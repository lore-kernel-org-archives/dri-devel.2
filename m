Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9599BCD3427
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 22:27:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBB0410E489;
	Tue,  5 May 2026 22:27:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="NkxMmuOt";
	dkim-atps=neutral
Received: from mail-yx1-f98.google.com (mail-yx1-f98.google.com
 [74.125.224.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28A4E10E489
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 22:27:55 +0000 (UTC)
Received: by mail-yx1-f98.google.com with SMTP id
 956f58d0204a3-651bc8f864fso4057520d50.1
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 15:27:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778020074; x=1778624874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9QJ6qduHbEic2dYqxfK+F1VSZSIA1R8upDR4GV0g4G4=;
 b=YZmI5+voEgJNg8Tc8x9z19cD0I08eJxHXLkk18PBo+VZxWHVPoA/jTLD6FLItmwajX
 w0HNrHR1ZMSdpgmC41Kgls12lNZoNmCLavFBXlCOCUyRgGqtDpCzIzCT5FbyBfw5xHrI
 l44gloUp4Q35cuj6s4t8ZVKXJU9BiAgcJxsTNhbKZh80rs68HpdwlcBA3GTeBxnd55Qm
 PevtP2Knp6O35pB6b3PLj/uLZEnzqscMiqCvqtFng2ZY0dHuLHl1eXmrNp7S0nG1odeg
 ObQSBmK0737ag6PboJ1510etpK65wi/8nJmUliC7mNF1BnA12QdJ6z6E2fk4booMJEMo
 r75Q==
X-Gm-Message-State: AOJu0YxzaBta+jjCOe/X9EtSAiUZWph5O4hf05FcWPE+STW9tXkrwVWm
 FYVj1ZiM3aMujfNUkgnPd1rL1LHYiY9luhi63NR/k2VbwmuHptXOfGVgkShhYKPFueqCxWzR9gP
 I9cj1DmCJ8VEA+zvs8nhaMUhKc6XgwcjvuRjLYi+N0Jnil+Snopv+p+Ddx+igsDpPst9fs2nqgv
 MHyfzIYQTJeryhGoZG0Osgv4fwDJAoTLKoozrdP+73H16B6DMgLzHzAkVXt4LCrfso90Ee84kVc
 Yp2/AOc3tZM1ontOV75
X-Gm-Gg: AeBDiesSA86gXsyT/JzK15ioo43yXJ/ljaUR7nlEX86cpRlKV4NgfMSLK0Ml3suuPo4
 fX3Coitl11tBclq5p7grqIO4Kanqps1I9A9iiTIogRjfNEJVcHyyHbzhU7lL4Ax1tju8Qbzc4bJ
 6S15hypI5OBbpbVT5Ge/fEuM5U/2Mat9mdc5xASNrFyg8LpnGXEJWPDFISlHhVI0/mZ2CkKN/ji
 L2yHYFc7f681rx+bjeD8lGA0sbOmc15hJ2JXvpes0IGpfr2yVg0tLAw0TM3cBysn2Wtbj6yx1BO
 0jNUy+n16fVL7vWRjdxA0R6vPebrT3AZrn6xeVDF/JwowONlFopIBBKMhK4vl7H7E7glA+QDaut
 3BDV6K7Hl5BhsKjdAdcnOHzBZNg0qmkCwsvBC1NBCNH4lBHFS2pxBFp6VCHw87+vW66X5eTGBiq
 x/0z3GOSCJDUEj
X-Received: by 2002:a05:690e:d5b:b0:65c:6f79:1de7 with SMTP id
 956f58d0204a3-65c796e1ed0mr1535495d50.0.1778020073901; 
 Tue, 05 May 2026 15:27:53 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 ([144.49.247.127]) by smtp-relay.gmail.com with ESMTPS id
 956f58d0204a3-65c7ae227cdsm24632d50.9.2026.05.05.15.27.53
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 May 2026 15:27:53 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8b7105dfb5eso79631586d6.2
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 15:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1778020072; x=1778624872;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9QJ6qduHbEic2dYqxfK+F1VSZSIA1R8upDR4GV0g4G4=;
 b=NkxMmuOtJlv++DTws5xPvPiJCdZvtjvudAH3KtBF+rtSGfZDUis3eCerulRxh/wQA0
 l4WfjY4tyD9InCfJPeA/7DwDjaiPJZu818Vy/s2nJ1Rn+frIwuqCLmsiS5YQD8TZf6xV
 Qowp4LQQWac3FSrxAX629hW552V/4fmFlg8Nk=
X-Received: by 2002:a05:6214:e84:b0:8b8:88a0:1061 with SMTP id
 6a1803df08f44-8bc467e0d04mr10605676d6.36.1778020072169; 
 Tue, 05 May 2026 15:27:52 -0700 (PDT)
X-Received: by 2002:a05:6214:e84:b0:8b8:88a0:1061 with SMTP id
 6a1803df08f44-8bc467e0d04mr10605016d6.36.1778020071436; 
 Tue, 05 May 2026 15:27:51 -0700 (PDT)
Received: from vertex.localdomain
 (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b539aa6f5fsm162692886d6.21.2026.05.05.15.27.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 15:27:48 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: ian.forbes@broadcom.com, maaz.mombasawala@broadcom.com,
 Zack Rusin <zack.rusin@broadcom.com>, stable@vger.kernel.org
Subject: [PATCH 05/12] drm/vmwgfx: drop dma_buf reference on foreign-fd prime
 import
Date: Tue,  5 May 2026 18:22:26 -0400
Message-ID: <20260505222728.519626-6-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260505222728.519626-1-zack.rusin@broadcom.com>
References: <20260505222728.519626-1-zack.rusin@broadcom.com>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

ttm_prime_fd_to_handle() returns -ENOSYS when the imported fd's
dma_buf->ops do not match the ttm_object_device's ops, but does so
without releasing the reference acquired by dma_buf_get().  Any
unprivileged renderD client passing a non-vmwgfx prime fd through the
DRM_VMW_GB_SURFACE_REF{,_EXT} path leaks one dma_buf reference per
call and indefinitely pins the foreign exporter's GEM resources.

Funnel the error path through the existing dma_buf_put() so the
reference is always dropped.

Fixes: 65981f7681ab ("drm/ttm: Add a minimal prime implementation for ttm base objects")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/ttm_object.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/ttm_object.c b/drivers/gpu/drm/vmwgfx/ttm_object.c
index 2421b0dd057c..f9042bafdc93 100644
--- a/drivers/gpu/drm/vmwgfx/ttm_object.c
+++ b/drivers/gpu/drm/vmwgfx/ttm_object.c
@@ -547,14 +547,17 @@ int ttm_prime_fd_to_handle(struct ttm_object_file *tfile,
 	if (IS_ERR(dma_buf))
 		return PTR_ERR(dma_buf);
 
-	if (dma_buf->ops != &tdev->ops)
-		return -ENOSYS;
+	if (dma_buf->ops != &tdev->ops) {
+		ret = -ENOSYS;
+		goto out;
+	}
 
 	prime = (struct ttm_prime_object *) dma_buf->priv;
 	base = &prime->base;
 	*handle = base->handle;
 	ret = ttm_ref_object_add(tfile, base, NULL, false);
 
+out:
 	dma_buf_put(dma_buf);
 
 	return ret;
-- 
2.51.0

