Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3390C5CFEB
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 07:08:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BC8F10EE6B;
	Wed, 12 Aug 2026 07:08:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="r8sq8LUs";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B70410E240
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 08:47:15 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-38e88b60121so2430472a91.3
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 01:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786438035; x=1787042835; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KkN28cbnuxaTZnJUJR8D84k2R0Wy2RMXuquI0epiuqE=;
 b=r8sq8LUs6xw7K+cF3IQIrCMrZyINzE3Tr74pCX+UljnueSsKq1Kjx0qRta72yq2jS+
 mikq9exIlwEOcz0Q32EgsziPpWb10PWx3raUmlW1DzsoXzQ5xQrp4BFW6G6pzyTAz+tC
 JovWXc4O4yLYOSyM96NXb3mGLs3jq7UlRKOzZiRrzE4yPkj7+rEbJXiTnlhjmC+58JAD
 clAcWxtA8v2Dibm1fOW+esWS10qSbrCGPKbB3BW65sWdlFwt3YNkaO80dv5vNB051pQw
 MGu3x3AAH4mW/toaoxDmiWLamWAhE49nFet7I9ypYLhkfsaDSi4nTXxHfzPk++061i1G
 FRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786438035; x=1787042835;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KkN28cbnuxaTZnJUJR8D84k2R0Wy2RMXuquI0epiuqE=;
 b=ntSYdJtUr/aHGnNJlRGfYDt90BPXCjX27Vha5Suw9YsuY9lTkdph9vpx5LA9NULzOA
 aoo0H2rpYoXJy8jt5DpMXi1RKtGYkQJ2tlvr4G8ZmWwNvv7kTEQl750zbq+ituWnV4dH
 PGl7fmj/mgj7b3uq2Q0HOkqmU8Nc3LkcZ9eP229lkkZhns7G1rSdBdvU5/cFIJBOHf0H
 rmV44Z2H6X22XlMEp56muLoWHnSklCPTo32zNoXkOuPlQR9Cca/wychjexol+ZmUqkk3
 ogWHxjCz+83quY89ABRuROSoZbGoG68AwUtgpzcVFnBUAzsAvi8BUwPeTHVTGaizYT0r
 xVzg==
X-Gm-Message-State: AOJu0YwwF8FJDA4bAXAtYFK5QhfCdlzBvL7vRor9S5v/AAhNwlIHgeAS
 ozKMvjW1nUIrZMNchHBu9Yn/XoS39V75RJ2/8a+p4Vpg1yW/XTochxXJzpw15WjxAcU=
X-Gm-Gg: AR+sD11sTwIPFRyGy4P4Y9EdPWh87z2+pujGiNEvc8cpl13qMohORC893Pb+L+ui+xZ
 qV8PoXX1eKDVPBc0CbCtoAl7YG8+ZUwCKBnY/3cPB/a1/+9LaFWT1hof8t0QT9u1MACShKvwNnq
 CqdZH0nsvkZocOkHOHSzD+xCkSeADKGqi2XyEAtotkG7fWVDBVv2IySqcENrwrALPtBHQeI1nQ7
 d1WMaXQoq9mBiDlti6NEkGBEfT27Wmn9sk3YVJkFpCrcchGJWq4i9kvMRPGvEj9xbp+IBiPJaty
 lUBjZeA8575LUGHsvpGZDRnM9+Cjiuh8lZ/MY1ozaqazLnLAzJDroBh/OW5dQBwmiNeKO1C+B6x
 +pO7GPevvX6g+qYwgV3t/pl5dQQAFvh7ldHiCBL8rLacx3/OyD7XKT54Lpsu5GWroXuYbqiH+pd
 wYio6YVAF/a6W0OX51yYSpqRZnIqCuQbrp6OMCJJJHXuwhnxXM7S7NCG97vy+30wpaAg5/Rw==
X-Received: by 2002:a17:90b:4c85:b0:381:c500:b0d1 with SMTP id
 98e67ed59e1d1-392ec721e34mr1597056a91.20.1786438034735; 
 Tue, 11 Aug 2026 01:47:14 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.52])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-392e58a94aasm633058a91.4.2026.08.11.01.46.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 01:47:14 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Tue, 11 Aug 2026 16:46:28 +0800
Subject: [PATCH v2 1/3] drm/nouveau/uvmm: fix NULL deref unwinding an
 OP_MAP_SPARSE op
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-nouveau-uvmm-vmbind-fixes-v2-1-aaee4b395d04@gmail.com>
References: <20260811-nouveau-uvmm-vmbind-fixes-v2-0-aaee4b395d04@gmail.com>
In-Reply-To: <20260811-nouveau-uvmm-vmbind-fixes-v2-0-aaee4b395d04@gmail.com>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Airlie <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Zhenhao Wan <whi4ed0g@gmail.com>, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786438000; l=1555;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=aTMGC8jjrMAmwoT5PX4XMFYEw8rXZ5oYEJn7jPDkksQ=;
 b=09+Yjqqdood4dmBPaNI3zbuyE6yGr25iSeGlJ5xSWwhUElspOvJ/vCMx+lzUAZY2pEewE1dB5
 vJ9nHlmaFQyCawnfpg4WkYn3EBEqRGtDwKFngsk5epJfxu5IZAgYp4B
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=
X-Mailman-Approved-At: Wed, 12 Aug 2026 07:08:20 +0000
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
Assisted-by: Claude:claude-opus-5
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

