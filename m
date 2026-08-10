Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A711CC5CFC0
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 07:26:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E19F10EAB4;
	Tue, 11 Aug 2026 07:26:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XzPMoDu6";
	dkim-atps=neutral
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6111110E257
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 20:38:53 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-84a652535dcso1336177b3a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 13:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786394333; x=1786999133; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vyASNIeLKFmcfAoI/F9+fyrmwfgxdyCWxlnFqPLO/WQ=;
 b=XzPMoDu6I42vwejZeVoIbw+7Z9UvIRy9fZJODsVEHGGFWc2l76Xpm1h58eB4yYmJQ0
 +Nu3RSCha741DEfvOFXIN+GkGowJa1tGisnMIqJG76VO7Nmned57eYqZCHdqruc5UttN
 YBbGvb/fNCl4VB9+DB0BPirfGW1U4LTfH0COiSOcWC5V9BrG9eRvGiM9PP7YCO/j5CpE
 8QTlLSBEVIgAtCnOj+knnNZVDbg4oWByizwXHymovPQdJ0e74xTV4kuYjDEQJsrFk3lp
 AFP9TnhfQ1Iuvfjez0Z1xmj1mPdX07/XpABW8+kPPELME7m8eGgSBU6C5u8GgmQBvu00
 dRUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786394333; x=1786999133;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vyASNIeLKFmcfAoI/F9+fyrmwfgxdyCWxlnFqPLO/WQ=;
 b=ANI+pKLqw6v50+KP+4uZHRjpgsecLF2toTtpFrwLq4MHmQ709ZP/goZQvx3UCZGzLc
 iMXfoYOLxzHjFhqIR/7KNwtmdA7UKb1Vvt9M0jeexN/y2hJJFDrvWHQD54XqaAngobRz
 GON5yoUULgqjzR+ZrRkSMP6+oihmWLGzKq9C3rF17/GgiYWrgcIc4AVhKDpCzqwpUEjU
 huDSE93rwjt2LmIj7z2CvHmuPh1pUF4NNhprb25D3giBz2NXt+aPwv4FFRgS6QZuiJoR
 I06r78USH7uu4LWDLSSa+Q/yHOiPXRvNjFB+UCD4Sx+bIpJ8YsyWKzLuYJrHntV4rBy3
 Tz4A==
X-Gm-Message-State: AOJu0YykE1g7Ld99WchtqOyDoUSD69AupgTMYNMYoVFWbPZMw9t+5dGO
 OGGf7q+7i/YKoRKmLNkUrwcG7UaIks0CtYi7jChBCOIe1BiwK1Ac41eI
X-Gm-Gg: AR+sD11XDM9aGaJIOyOmVUahWSTKyKFlx95SDvKKzCyKHMZjmfiH8EhBxDHvZAQHoAB
 CxdKH7fDC4GHHgIcncd/UAqoMnqLzJwi91H0nCwJ3B8z5s83j2rauNfor0NgKiw/SccG/p7OR+w
 M/bvsEBcat8fOKenMkdM3+PDbMlwd1vNbgyZ8zsPg4qud1ZIh46z99pie1TmkPFG7rWmv1rZan0
 L9ejaQI+6sZCQoBxwiTQ7kx6nIZHSVddvN+v7rnm1Dd11JtYLVZDADVUY+ngBvfBO/5XJ18pxZj
 1X3VUjKxOZyzZAD14GpafFLXI529PG6aSoc1yQUWQwqQMtxNjCgL6RSXB5zaxGv2CP3mDSD3dLX
 9pWXbPXwxmQJ96I5090zpKcyrESfwO5AZL8dMNvZOc0ylBIFNp9F9GjGOH17baxDLwkGxfLznUq
 CfhRebhZ4KpLOzp0KushzjEoOwWKWApxwiAW1Us89ZYBXPFfU1mYqQcAXgw/Z8
X-Received: by 2002:a05:6a00:a16:b0:845:e9e8:645c with SMTP id
 d2e1a72fcca58-84f694201bemr23429295b3a.6.1786394332889; 
 Mon, 10 Aug 2026 13:38:52 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.52])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84f5a553071sm4324001b3a.43.2026.08.10.13.38.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 13:38:52 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Tue, 11 Aug 2026 04:38:19 +0800
Subject: [PATCH 1/3] drm/nouveau/uvmm: fix NULL deref unwinding an
 OP_MAP_SPARSE op
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-nouveau-uvmm-vmbind-fixes-v1-1-40df1c046b49@gmail.com>
References: <20260811-nouveau-uvmm-vmbind-fixes-v1-0-40df1c046b49@gmail.com>
In-Reply-To: <20260811-nouveau-uvmm-vmbind-fixes-v1-0-40df1c046b49@gmail.com>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Airlie <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Zhenhao Wan <whi4ed0g@gmail.com>, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786394315; l=1520;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=+VNmEkXChlpNLC2AYrdH2/Brvmpt3yR/AE4J9z9THqs=;
 b=2NVSFVBq7bbrQhlqYPoKCXTQi2womiUgrJtriPaq6KwXJpxK/aMIt6Q0SRgkjDUwQ4FsKnysG
 32+jbbJ1TuXArtF2le4b7Uu4n1tGts8GEPg7Dc/xL8VuPg1ju8U6qyn
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=
X-Mailman-Approved-At: Tue, 11 Aug 2026 07:26:09 +0000
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

Each bind_job_op is zeroed by kzalloc_obj() in bind_job_op_from_uop(),
and the OP_MAP_SPARSE case in nouveau_uvmm_bind_job_submit() only creates
a region, so op->ops stays NULL for a successfully processed sparse map.

If a later op in the same job fails, the reverse unwind loop revisits that
op and calls drm_gpuva_ops_free(&uvmm->base, op->ops) unconditionally.
drm_gpuva_ops_free() dereferences its argument right away
(list_for_each_entry_safe on &ops->list), so a NULL op->ops oopses. The
path is reachable by any render-node fd holder, since NOUVEAU_VM_BIND is
DRM_RENDER_ALLOW.

Guard the free with IS_ERR_OR_NULL(), as nouveau_uvmm_bind_job_cleanup()
already does for the identical free.

Fixes: b88baab82871 ("drm/nouveau: implement new VM_BIND uAPI")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_uvmm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
index 36445915aa58..849bf42c124e 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
@@ -1489,7 +1489,8 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job,
 			break;
 		}
 
-		drm_gpuva_ops_free(&uvmm->base, op->ops);
+		if (!IS_ERR_OR_NULL(op->ops))
+			drm_gpuva_ops_free(&uvmm->base, op->ops);
 		op->ops = NULL;
 		op->reg = NULL;
 	}

-- 
2.34.1

