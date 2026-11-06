Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EABB606A32C
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 14:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W0jAzO7h
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F22310EB69;
	Sat,  7 Nov 2026 14:28:21 +0000 (UTC)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7E05112C81
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 09:20:30 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-36ff9c9da34so360181eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 01:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793956830; x=1794561630; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ggqU2z0JBuwwyOOBFpelvoLoHdUUbWw3FkHf6dtYia8=;
 b=W0jAzO7hm9xdSSHpHLn5B8+hXW1mwrO5PFW39KYJvMyQr4ruKRAWWlhiQPGBw+vr4r
 irD1ZQCJZj/5FqEpeILNnVAKWxLwehPU2IS9FD0p+Q/ND8axy0wVQ7GhTx5n+lcCeRjv
 1l8r2bVwXEtjuP6GpZ6WVooMcBt9+LDXJqzEuzDQR2y+/DhBxVpmTAmX/r+YmX2TL8aW
 XsiybQ1Zw7ce7LRTBAR+ONbJ8JF05TR59GEctGGdPKvIoD2TJWy0B6AlAc4WJjXyLhvq
 g1T593nRsEJRS/caHKpWIdkFeGstUDGe2a5C7+j6Rcj277Vvvtz/XRfAMdEGyLZfHG4w
 V9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793956830; x=1794561630;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ggqU2z0JBuwwyOOBFpelvoLoHdUUbWw3FkHf6dtYia8=;
 b=Uh2F0niqLFJFFz1CP698rVSzVoAclwyCowQjOHV9uNdLpx0d7D+Eu9FTIlTTraxiOQ
 2PXI4Jd8/7GqS/Fw7J+vRt+sqNIU70chmFHLyNhh6attA5Oi2nkU0M+ZJLv+rB01GjzZ
 aUaU3rZH/T0I/Mhmbg92ADC0NYmgKhp74rrw9mHGkzDeZfrOXdfRx3UCIAhCFwylLwlE
 9Pc1RTNIBimwzUJQ+6hR4o8Ti1QAft0zySssjm+oSBkouTau8TOSBHoqC1jeM/3WaqTc
 26w4POML0oDSKykWXJEoR+XxpNlkqwpBmONi0DRL1K+UJctsGqUT8Ghco5te0ujaafaO
 wuJA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwOalASZ72QGB620twbtMoUbyjBLqJgfWhttLLrmr5q/tCUsSKUC2QqGqh+mE2RfbJX6Dy4I4k/qWo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z914BSOXJWF47q2TkW7GZjMZC/V5sOc4o/nXFCRe3EwfXZcfCqp
 sbb1UkcseYAY5IN4qWv6pSVz5DspSx7+Ic6fZFCH4BFw2x8rP9DYH2w=
X-Gm-Gg: AYBFou02Nfko1Agf65NpRov/tMGFXkQMrObE6/wZjffXPb0aeReLKgpw0SUmGbHFpiV
 UJf+kod8RtinfjmpfffKNlRiXSnZ8qYhx9GyTiXoMmgIGu6RgNlwdvWZM4GAJ2y7lXztb+1zqo7
 G8AJZZ3ylfV6x2C4dmTA/gPW7OKSFjYSUeawtN2/GR+4RC7xsBtVN/c1AxEu2h3eDfP71PDB9dM
 LItIabWu91EKXINPojwII0Wu43EJeRJsiVyBCsuGjAm0WFvhkTaTt3/lNNS/UTmfpLSD632R9zz
 SR+GGCbGAEu22gE77kmd/aRNrD7uaE6ToI4iCyc00XJzMj4gbWwy/CUNvscAPAi6vE3csaGNE46
 m6Nx8Po1iIuA3VvmTfkaA2oP3iKd3NOnvrelJz+ygTvWdvDHMLa+lhLzMvtWeUtzupWz1sYu8Jo
 R8jWCOWaNkUyrwY0Kojw+emXOiNSV36wx8oG5Z90OLWNjF67DGPiub49YSCHqzGc+2oRos2T2nC
 10FuxRCdD4X52wJz2uyql/IKzIqXCPnRYbRXbc93mBx1XkmCFTwV9LlVMQjRjpATfWLYBCnlqQI
 lZt/w4GBnGHdO/M+5rA5rzXKGHtU2YpHOhsJnn9nfRMKliuj12dM0QNp
X-Received: by 2002:a05:701b:4507:20b0:1b0:f0f5:e38f with SMTP id
 a92af1059eb24-1b25d346c12mr2313612c88.34.1793956829858; 
 Fri, 06 Nov 2026 01:20:29 -0800 (PST)
Received: from localhost.localdomain ([155.69.103.70])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b25e4a610fsm3783796c88.11.2026.11.06.01.20.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Nov 2026 01:20:29 -0800 (PST)
From: Yige Jiang <yigejiang86@gmail.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Yige Jiang <yigejiang86@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 stable@vger.kernel.org
Subject: [PATCH] drm/mediatek: Keep the mutex node reference across deferred
 binds
Date: Fri,  6 Nov 2026 17:20:23 +0800
Message-ID: <confirmed-20261105-38-2e09963f1b23@gmail.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 07 Nov 2026 14:27:39 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

mtk_drm_probe() acquires private->mutex_node and releases that reference
on probe failure or in mtk_drm_remove(). The component bind callback does
not acquire another reference, so it must not put the node when the mutex
platform device is not available.

If this bind failure propagates through component_master_add_with_match(),
the probe error path puts the same reference again. A bind attempted after
probe has returned can also leave the stored node without its reference
for a later bind or remove.

Remove the bind-time put and leave the node reference with its probe/remove
owner.

Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC MT8173.")
Cc: stable@vger.kernel.org
Signed-off-by: Yige Jiang <yigejiang86@gmail.com>
---
AI assistance was used for analysis and patch preparation.

Based on next-20261104 (8b7179210b22).
Compile-tested: arm64, GCC 14.2.0, W=1, drivers/gpu/drm/mediatek/mtk_drm_drv.o;
baseline and patched objects built with no warnings.
Static source review; no hardware, boot, or KASAN test was performed.

 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index dc8e3e917dd771b950167d04c1ab87c14dbabf72..64c912ba95899128bfb1a41765579d9d70979a27 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -630,7 +630,6 @@ static int mtk_drm_bind(struct device *dev)
 	if (!pdev) {
 		dev_err(dev, "Waiting for disp-mutex device %pOF\n",
 			private->mutex_node);
-		of_node_put(private->mutex_node);
 		return -EPROBE_DEFER;
 	}

base-commit: 8b7179210b22f8e48a82c5ceacb9d56a9c4cfec4
