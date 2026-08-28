Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04321C61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 02:01:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0AE110E444;
	Fri, 28 Aug 2026 02:01:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="STkjJRUW";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F74E10E444
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 02:01:08 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-482e1bfcc63so286522f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 19:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787882467; x=1788487267; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KOcOnSph4R/SK6vbv+B+XNx7SuiY0RM+MECJyRf8erk=;
 b=STkjJRUWdC0XdNbmRXjrAPkAPEauRCcIRreaoizz7QXf8WaYhSABJCCTl2fQTj7fdN
 8ikIpGAt2CD6dyjJfg+K1oCbFkf1EjvRQ2lpvBQf1rpk89JWRsRKdoUsHQ+ioMe67mgV
 ocNUgTg5mqA98VACJHQQR8VE6Mur+QINawmlxtF8PaUHgBZJ1QyKZENcS4ndT1k3Raiv
 xk/MM1X1H1gRA/1+WFKDEboy5MiHcke45CXq5gcK6xE/SYh7D6gFhekzmfvIXGvuBp/Q
 JTzMaQAKLqCQAdmPW4viSbVk7QJb3B410UJ8Ya7+i/tTdhlLymciNXj7ULs0M42hjeul
 Mz/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787882467; x=1788487267;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KOcOnSph4R/SK6vbv+B+XNx7SuiY0RM+MECJyRf8erk=;
 b=jAaOb+p5492x0+US+84gpbOe/TVB6wi2QM59EKzPlBk38Jt90wgc0DZ/QCkBTVUQoM
 Kbs5CKOEFLH1oQOgA2o2+WA/nybSv2zPQes39MZWyYv7mpw/mNrEtxeWAZhrPeudZXiq
 ZoJ0jlodQm7RP7cWMbiLbabuK+3FSSUYtBAzaYufagfW+5XxRoLFFs62KJUHvwQONS5a
 +ziC+BOAG+KQGXF+zVmOEwtzBuytPeW9PChn0u6Gyj9GGWIQz3ZwpOPJLouClERDcKhd
 FoKP5obsPprBdqXdmXHLq0LNks9BF98vxNkUnzzAmLCcFq4FFaRpm7RfwCb0a0iIUDEP
 4a7Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RqJFtlSSkZmIHn3ScpmT30gs8QsdtBncaJtVinSizAolP1VrxMd/ISgvRRVZyz/GxhSnnuixyWfXWU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kf08VyIcaX+YYUOeep9AKamAJ6uyIUNnHiXvNDEXuqsf6ceC4N
 Cwy0IZfy4EEm5us3y4xjr2oQEsWoaD6o1uO9evUI4jSBEM/UuGeE9al2
X-Gm-Gg: AR+sD13eK5F0nIcPUDcXORC8dstdo4cXww6LkwxOWvGFsC9+SnyyJEMmRoBw8L0EE9z
 h7iERnuZMMx4KVR3eE4rjch+3TWV69D62DYehhziIP8FHysMQHKLsuBlkMZnzma7E3WlFxw4V3c
 ly58T366Wuyih+tQk/lZtk7cQu/wRvNJegsA3XjXPLyesl5cvVuDyTjOhOBwMqdMW+NZgtFwc8l
 U971nKbqqNedg+VaNyENGSXgJwMCwtlCnBz9pe0KRNLx06jnC4ptYBZLuTMKXxDqidYCZpf7zk7
 K3c4hZCzo4v4LSwbDfRqmGgCCmhtrKfdvRwCgmPHgebjczhjcab2hZcmmfcoVpHsmH488cRtCx7
 YWGud5mELuXfywxxqCgKWeOM3pIktqjLFHIl2cpfd/+nlYE8EthIyEQs9M7s+upTJPf4dg1673j
 7VIkRL64T+qyWEDLnw2yKd7xqnu/Xx3UEw3P3WK4L3aUMdk1rXC5V2sx/xMQ==
X-Received: by 2002:a05:6000:2608:b0:482:b823:cc3a with SMTP id
 ffacd0b85a97d-482eaba7efamr16934016f8f.12.1787882466615; 
 Thu, 27 Aug 2026 19:01:06 -0700 (PDT)
Received: from 192.168.10.52 ([39.41.155.162])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb20122sm362758f8f.20.2026.08.27.19.01.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 19:01:05 -0700 (PDT)
From: Saim Shujah <saimzst@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Paloma Arellano <quic_parellan@quicinc.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Saim Shujah <saimzst@gmail.com>
Subject: [PATCH] drm/msm/dpu: clear pending peripheral flush state
Date: Fri, 28 Aug 2026 11:54:40 +0500
Message-ID: <20260828065440.140410-1-saimzst@gmail.com>
X-Mailer: git-send-email 2.55.0
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

dpu_hw_ctl_clear_pending_flush() resets the cached per-block state after a
flush transaction, but misses pending_periph_flush_mask.

The peripheral flush updater accumulates interface bits in this mask. A
later transaction which sets the top-level peripheral flush bit can write
stale interface bits to CTL_PERIPH_FLUSH together with the current state.

Peripheral flush support was added after the helper started clearing every
individual pending flush mask. Clear the peripheral mask together with the
other cached child masks.

Fixes: 64f7b81f0358 ("drm/msm/dpu: add support of new peripheral flush mechanism")
Cc: stable@vger.kernel.org
Signed-off-by: Saim Shujah <saimzst@gmail.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
index 36a497f1d6c1..e8729fe1cfef 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
@@ -118,6 +118,7 @@ static inline void dpu_hw_ctl_clear_pending_flush(struct dpu_hw_ctl *ctx)
 	ctx->pending_intf_flush_mask = 0;
 	ctx->pending_wb_flush_mask = 0;
 	ctx->pending_cwb_flush_mask = 0;
+	ctx->pending_periph_flush_mask = 0;
 	ctx->pending_merge_3d_flush_mask = 0;
 	ctx->pending_dsc_flush_mask = 0;
 	ctx->pending_cdm_flush_mask = 0;
-- 
2.55.0

