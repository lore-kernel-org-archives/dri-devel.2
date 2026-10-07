Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1497DCA5FFF
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 05:19:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D81310E49D;
	Wed,  7 Oct 2026 05:19:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jtV1kCHM";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B306D10E448
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 05:19:33 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a021c809e3so14160415e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 22:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791350372; x=1791955172; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pEBGEIuvQXUOhw2qs60K5A3Yyo97btH1M39qmx8g1LA=;
 b=jtV1kCHMmJipHS2m6T7GdAJpcezMXt39ock5wH/G1ew8w6W0KS2TFCsC5VGWAw2y6/
 /UUAfxEQbl9Fuqnwd4MeYHmlkAa44e402LXy4BchMiFG6xN8ZQzaPJ9cgH4MWz4al2iq
 nMulZsJs+laQuU5b3iDo4bvuD/l73Aj7vI0LApYAV2eNbATeWuw+wekMOZX/NO/mLsJ6
 GBaOjr4W6TPSn6QnpSMRPQzbR/dmdLGzG7cq6jeqy++bC+lK2vqionLtmOMYkOpXZ6rg
 OzaVt6fj8QTDLmr5l3zC3k+0VrD+pITBaiuBiSXmiL++ZiJw5yzFqx580xTZDpEUg+ID
 rqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791350372; x=1791955172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pEBGEIuvQXUOhw2qs60K5A3Yyo97btH1M39qmx8g1LA=;
 b=KrFFheViWI3m7pQD7LKx1vjzSdsRLCzer1fJrhncqMC+H+nW9gxJeurNv8QvsFk3Jg
 TQ4w81v92lrdVg5gAc8PgUNfC6jQXsr4ypwIIMd/ER/BM2b+83Xu93wn4F1aY9a+VskZ
 cY5OnHt+9ezPwkAJxMB6EFTSgAwNXfqv8aatUpuACUEKW12xSq0Yb1dk3fnuQdDQwloj
 E6Um0+BmFC7ZKL9TprYrNi1XWTFE4oZW73E61L0wnTt0mG2WeV1r/iTtKUbhRnem1Xff
 5Xv04EkENaJxPp2tOCa0vtEE5eOYswevls38nxwLSPnw6sc5CqVU0ijsvoHvWseOFnqP
 MG6g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxYplXQ/bkiJ52mmjn3KeiGyOF23SDOYqaawpaaFZHHk+G7qcxb4MrN2oz3KQMfx7o3Hm+7pm2fhGM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n+lpWAgpXTIYYYe7D2eehnj8h126efOy2fUhCawfeOQaEgaeSa
 tVJm/iJPZ+Xtnsvaj1CvnChSy7SiBk1Xm/VfEMC50yHvewVXb0o9Eovd
X-Gm-Gg: AYBFou2iSLy80d36ntgXisqPYCpu7gFzTFVQ0P4dPTJVhieIB9K0X16SRr6qEWRaapV
 vR9pLauj30Khe4HmXLsUV0jdwK5IKs32aSI8VcCohuwr+YzbttDb74F3vFU889ZEr+siGnmsaPn
 jDyWVPgfpwcHYJeheMyB4C6jcTlL01OpjUBXR0Whnp98RVfqtuFHbs7n4NXWTOKd/emdkdlbsnW
 rwVfXa66Ca33my+tQXNC4UjePiNVgiLx4rIJoBLns87FfF1G1pXF/iVk/c6g0OBVPfQ4bMDAA3M
 JU3QfbLTO34ra+t23gdkeHYtmS6xt/LhqGASie7pcBnznWWGpy8Tbr6J0eJs8fBvBfb0Vn65DoR
 bM8hrY7RopOtUWCNLHUplJNWJs2TBObuw0kRtUs46nvSfdjg4ijwUc8XoLlkeyov4m+6KJ/wWzT
 s99/h71ggjEhOOYJg5RrG2F8e1J1I1GBf8+UeSdnE5itzY+yoOkOLjhzl2MPxQtlLFFMx6tebX3
 9KFdLfL24EGr13LW23JrAgjnC0LF/9CrUDCH2f3JFnwqFrIW4sxdQ0jVR6SIWT8vEre55g/KBWg
 bghrwlYdp57IfmWFGdAFGEv2tSkwBDL9v6gF2CSxyW2GwubA5hDihfpG4Lwa6BnodW5ox2+JCVu
 xb/6vFBE=
X-Received: by 2002:a05:600c:8105:b0:4a0:20c7:6d4c with SMTP id
 5b1f17b1804b1-4a180085f90mr13193475e9.0.1791350371849; 
 Tue, 06 Oct 2026 22:19:31 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-a1e1-2201-60f4-32e0-4d59-5772.310.pool.telefonica.de.
 [2a02:3100:a1e1:2201:60f4:32e0:4d59:5772])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a178a175aesm156822265e9.2.2026.10.06.22.19.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Oct 2026 22:19:31 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, sashiko-bot@kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Jianfeng Liu <liujianfeng1994@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
Subject: Re: [RFT 3/5] drm/msm: Extract out map/unmap helpers
Date: Wed,  7 Oct 2026 07:19:24 +0200
Message-Id: <20261007051924.39963-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261006131920.6870D1F000FF@smtp.kernel.org>
References: <20261006131000.81501-1-robin.clark@oss.qualcomm.com>
 <20261006131000.81501-4-robin.clark@oss.qualcomm.com>
 <20261006131920.6870D1F000FF@smtp.kernel.org>
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

> Does this error path miss an IOTLB flush?

Yes. msm_iommu_pagetable_unmap() called iommu_flush_iotlb_all() after
rollback. __do_map() now calls __do_unmap() directly and loses that
flush.

An arm64 QEMU/SMMUv3 test:

- mapped one 4 KiB page,
- hit -EEXIST on the second page, and
- verified that rollback removed the first PTE.

No stale translation was observed because the device had not accessed
the mapping. This tested the low-level IOMMU sequence, not the MSM driver
or Qualcomm hardware.

Restoring iommu_flush_iotlb_all() on this error path preserves the old
behavior.

Karl
