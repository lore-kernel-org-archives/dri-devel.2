Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94CE9CA5FCE
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 06:41:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FA7510E845;
	Mon,  5 Oct 2026 06:41:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RiSLKfMu";
	dkim-atps=neutral
Received: from mail-wr2-f33.google.com (mail-wr2-f33.google.com
 [74.125.225.97])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2A6710E7A0
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 06:41:42 +0000 (UTC)
Received: by mail-wr2-f33.google.com with SMTP id
 ffacd0b85a97d-48b104f6aa3so667852f8f.0
 for <dri-devel@lists.freedesktop.org>; Sun, 04 Oct 2026 23:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791182501; x=1791787301; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vxYiwprUwInDcUC2IvTN3Wf8gv1RPqxCXCBp6IgMI3M=;
 b=RiSLKfMu5xMM0NMz1vx1BRUQo/LQ7rGV/Rr6cHVqDSLFP3zsgPGuP+tM9jrgYEPveO
 TKoJGaQXbYFIgmP1+F5zXNXWmVQ25hYtY+uDGomW24bOPj0b8GMVXPVDwmxaHiRppKw7
 QxOR7iiP8Bul9io8XbNG1Uzfwtq9FKez9KM/xJrStJjp/O90D3AGiWzuZ5lD02XJ20DC
 hqB0FTH2ghE4qqp5z5FrAJ5EyK9uH+DOPGPIcEoESnecrAabM19qFHmffPG6aeKAABs/
 vAeq7GtCDWX/1Sl8SPC3ZkWhIf2xkK1gW89szcDqil2lU1CwOB6lyahf0hMqCJejGREL
 JxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791182501; x=1791787301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vxYiwprUwInDcUC2IvTN3Wf8gv1RPqxCXCBp6IgMI3M=;
 b=adaYlYcvM9/u2ueqOKheWIFoaASuWAfjsev9HTarKMpC0N/fCpdLZzrrSZx7Z1vzdi
 B5boY6tFrX/kxLdXClMyhied3gTx3xTtYykkMjXXhUmGF7H614X7WrisYC8NL7uz7gNe
 VgJIYsgZLMoROgNf6Tr5egrblm6NVyb6Fq3840IiBLsZsRyZwjqTg4w7tdEfG7wDPkEW
 14rcd5/60+JeQs7IFKlvgI3aCQhchNaswyAFBpw3SQoZPB4FSufih3TynxvdswdGb+Gn
 c0qeiHN1/RmHX9T7yghO1sR7H4nbkgVtBMA8b0RMujNauGl27Zq5ypSq+Je/hifII+u5
 RTeg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw1ZLy7uB+d2VW3D+OBrP4sea4a6iC2uJleJ+8QitZQUC3h/CnibnGoBJEJqryvfO+W0cCgWWdjX6o=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI9crRkAKu/QkkEovpzLfddzxGfFjr0gcy+IArqFEheHT1oR1XO
 3AGzOU/0i1FLGp4hSrPd3rGEMmKWwsGMfPk2Qbag91tRLXzTixNodTwj
X-Gm-Gg: AYBFou3FSgRfjBwl3rS+GqbmfDLkDD6HhRlcf/6QW8moY4J4PnE9dZXRQDKmZdIZQkO
 3J1guUJe/sWNj1os5FAtWm1wSAnIvaHpuonNjaNMeFyIo9RHe9IicHJIlU33TaGlPH25nwuHTrd
 Mc+zzgX8RpWOUZwkLnyO9E4JbLAA/bScuIKSFOHHyMVApwukHaOFBvv5n/eV9GkE1Zs1nWuJEr1
 MEqJ4mrFlYkSGXlNoYLobYhGqxSazbcMZjD3hU51xBPzas23GHxSGKRL2cOj866FOVD7K1bgSGL
 gmaachn6fsOTJ4EGfJoCUla55RfVnqAumFmMeTxmIqrKJa27KIjmVoB/pqQYTWq3Mmuuy2vM71Z
 gUf8ukatJuyn1FWIalg5BosJ1TUJLALfnmIi5ScxygiIi4HdAySzpt8usDbfeWyFiCeqd6lZ/Jj
 YVJc81OsP4UOqbnxmyjiYr4oPNFFBzhvdr732UjGAgHiw3hPP5HbeC7a4zgwFcI7DQa8JB5XNIS
 uPbG8yVwqbqavl/wm+zJeV+H1VPrUOHbggO5g1WfyNbdLXkBrXrSf4DI4laqpYWPSShxvbNjtUc
 ptnHlD7mNXeHVj2nDEIhJUsXTvhX8YjlYeKNktfo2UHOQGXfQgZ8gEVEr7mXmP+2HSe1iam1p3a
 zuSyB499sr+c1
X-Received: by 2002:a5d:5e84:0:b0:48a:f52d:ca47 with SMTP id
 ffacd0b85a97d-48b1275c366mr16227419f8f.22.1791182500905; 
 Sun, 04 Oct 2026 23:41:40 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-b305-2001-39fa-3d24-821a-4eae.310.pool.telefonica.de.
 [2a02:3100:b305:2001:39fa:3d24:821a:4eae])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c62289b62sm1666871f8f.20.2026.10.04.23.41.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 04 Oct 2026 23:41:40 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Rob Clark <rob.clark@oss.qualcomm.com>,
 Jianfeng Liu <liujianfeng1994@gmail.com>,
 Diederik de Haas <diederik@cknow-tech.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Vinod Koul <vkoul@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/3] dma-buf: keep the DMA flags in the DMABUF_DEBUG copy
Date: Mon,  5 Oct 2026 08:41:31 +0200
Message-Id: <20261005064133.7305-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261005064133.7305-1-kmehltretter@gmail.com>
References: <20261005064133.7305-1-kmehltretter@gmail.com>
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

With DMABUF_DEBUG, dma_buf_map_attachment() hands the importer a copy
of the sg_table that keeps only sg_dma_address() and sg_dma_len(). The
dma_flags (SG_DMA_BUS_ADDRESS, SG_DMA_SWIOTLB) are dropped.

The flags describe the DMA side of an entry, which is the side
importers may use. Copy them as well.

This is not a bug fix. No importer reads the flags today. Their only
readers are dma-iommu, dma-direct and iommu_map_sg(), which are not
supposed to see an importer's copy at all. The warn mode added in the
next patch keeps its marker in dma_flags and lets importers that do
get there continue. They should then see the same flags as without
DMABUF_DEBUG.

Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---

Notes:
    Built alone on x86_64 with NEED_SG_DMA_FLAGS=y (dma-buf.o, W=1). The
    KUnit test in patch 3 checks the flags in the copy. It passes on x86_64
    under QEMU in strict and in warn mode.

 drivers/dma-buf/dma-buf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 4c9add51f9ef..b3d311acb883 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -904,6 +904,10 @@ static int dma_buf_wrap_sg_table(struct sg_table **sg_table)
 		sg_assign_page(to_sg, NULL);
 		sg_dma_address(to_sg) = sg_dma_address(from_sg);
 		sg_dma_len(to_sg) = sg_dma_len(from_sg);
+#ifdef CONFIG_NEED_SG_DMA_FLAGS
+		/* the flags describe the DMA side, e.g. SG_DMA_BUS_ADDRESS */
+		to_sg->dma_flags = from_sg->dma_flags;
+#endif
 		to_sg = sg_next(to_sg);
 	}
 
-- 
2.53.0

