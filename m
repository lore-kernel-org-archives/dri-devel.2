Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF0FC5AC67
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 07:26:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7179E10E2D7;
	Tue, 11 Aug 2026 07:26:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oSTkiUwA";
	dkim-atps=neutral
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C337310E257
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 20:39:00 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-cbe827e3cb4so2522778a12.3
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 13:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786394340; x=1786999140; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qGxAuLzZZuFS+OONE5xJE8lS88pl+UeA90EgJEUUW6g=;
 b=oSTkiUwAnMFX654k7ytDSRcWWCUnDQxSxiNsEpAeOzNGUpSiUXoCgDnDjMgIG5OD4w
 k8LaEuFSqxnYbQJHQCIQq6DrelEcvSf1Q3mJ4zLSZaB4QcD7fDRQV/GpoM4jiMElHaUR
 7C4CiSUKGnI61SSzPcrfkgb73+ERWtBJkCc8tQ0w/jcKjwb4viS43q+ASPGx5fy/tXdd
 RuO3CBvC7vU2uBbv6BcX2pCSOtDUyXvpOYoWyWpPun7oL84me7dDVktaCMdcZLOURoRT
 +Rezp+B5lrskGaxR2ZUbA6DaekDv2xlV28uMvmej+js/DHyy4DBi6uS5PgxBQeNAmnMv
 BtCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786394340; x=1786999140;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qGxAuLzZZuFS+OONE5xJE8lS88pl+UeA90EgJEUUW6g=;
 b=lBDKyYAtOZ9/JRKSkIZRjQM646bqwiyrZtpjAwpIpLtaqCFE3hkdOL5FW5MbUjmf3G
 rTNmdm5ree97snHE9gX2oKON7jC9QK72FPJ/ekPHMRpWqLco0RxJN6uAjBg76i1jbWQ2
 EEjaqmyNRYkcfaRrr/xqrvs4xn3dQ/nrY4yjQ7n6IduiFknC72tA8qjPncwNi/Q8w51X
 K4wCgx6B6+u081fPLcZIrglkyIaDukR2e2sw54XfQh+zbMimGK5x8ZFCc7AaeUEwOhJ7
 gjri5A0h6xWA2zZPjEpWyxP8l+vwkR8XUW/FGBbw4fiF60gyWCY5qbshX7E7sipCifa9
 zTWw==
X-Gm-Message-State: AOJu0Yy9GilbPXbJB4IlysQ5fjxOPZLgRXuuKhV9WXs0rCpbe1gGvDYQ
 hghhdSFxFG0Hw+ZaBh5Fsxgmjkuv767SNrWICpuCWHphH8SoyKWQAf7S
X-Gm-Gg: AR+sD13/ELN2ewAAvKJTUe2Ud263q8sqr2qFFR9nxw5BMEArpnEo0jNct+M2afmqbxc
 9JH2Yw10lZhDqAqO7ZzdO/C5RDwuLrG+sB1TSFWJNwpyXqvPxFKxUJ7hTeuH8wOWegB0hmipBkP
 lrvPi0iV8W03Q9sHxLI4gWLV8wJvRimZcfiISWOHQpS3GsGD9rZEYPCPd5hWc0YZp0QE8fQIxMp
 mvGOZSNArCyBOrGmWYLNlOeRkuekK/e2BKOd8Fs6Xr3MuP5FSlzU2rK84W27gh1aUSG5vp/oPfX
 sajnujdH4ujhu684ZmmOpKlidVfO4+eLkLpc+SFa/CrKszTFcmlMNeqCaOjGuPKG2WWjTkV/SVu
 yU3YSC07k3/qVZJzlRx7L7zTVVaao2uPoOUGc+ixcTI6ZBkquzrAS2eB1AsGhICr6jx12zTBiKP
 hZMmg0RXedGGp09xHpPPWSHlx3b4roKsGP1NclOEi1RbuB9DMmZepm1UbKjw3eWt4bL65rYw==
X-Received: by 2002:a05:6a00:809:b0:84e:915:d7eb with SMTP id
 d2e1a72fcca58-84f9c9b2da1mr4339437b3a.37.1786394340150; 
 Mon, 10 Aug 2026 13:39:00 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.52])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84f5a553071sm4324001b3a.43.2026.08.10.13.38.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 13:38:59 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Tue, 11 Aug 2026 04:38:20 +0800
Subject: [PATCH 2/3] drm/nouveau/uvmm: fix premature region free on failed
 OP_UNMAP_SPARSE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-nouveau-uvmm-vmbind-fixes-v1-2-40df1c046b49@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786394315; l=2150;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=Os1DpKb5DvVXnV4vccSHoH512pnwHk/C+aJ0z4dVEGA=;
 b=02MtHdx4r3dcWF4OJYpzk/u7l1R5qAALQu/9EvZjdicY+x1blHF50oc+amQtWtok05bowqco2
 GB8XXhKK5NaCpHbdzLxx9r4Ic66enivHaHfyhRMZvNxhLhbx+KR24fL
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

In nouveau_uvmm_bind_job_submit()'s OP_UNMAP_SPARSE arm, op->reg is set
from nouveau_uvma_region_find(), which only looks the region up and takes
no reference; a region's sole reference is its membership in
uvmm->region_mt. Two failure paths leave op->reg set: the -ENOENT check
when the region is busy, and the drm_gpuvm_sm_unmap_ops_create() failure.
The sibling nouveau_uvmm_sm_unmap_prepare() failure just below clears
op->reg; these two do not.

unwind_continue steps back one op, so the failing op is skipped by the
unwind loop and its op->reg stays set. nouveau_uvmm_bind_job_cleanup()
then enters its if (op->reg) branch and calls nouveau_uvma_region_remove()
and nouveau_uvma_region_put() on it, dropping the tree's sole reference
and freeing a region this job never created. The comment above the
cleanup loop documents the broken invariant: op->reg must be NULL on
submit failure.

This frees a live region on an unrelated failure, reachable single-job
when drm_gpuvm_sm_unmap_ops_create() returns -ENOMEM; if another job owns
the same region, its cleanup then removes and puts the freed region, a
use-after-free. Clear op->reg on both failure paths.

Fixes: b88baab82871 ("drm/nouveau: implement new VM_BIND uAPI")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_uvmm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
index 849bf42c124e..3412200b21fd 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
@@ -1319,6 +1319,7 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job,
 							   op->va.range);
 			if (!op->reg || op->reg->dirty) {
 				ret = -ENOENT;
+				op->reg = NULL;
 				goto unwind_continue;
 			}
 
@@ -1327,6 +1328,7 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job,
 								op->va.range);
 			if (IS_ERR(op->ops)) {
 				ret = PTR_ERR(op->ops);
+				op->reg = NULL;
 				goto unwind_continue;
 			}
 

-- 
2.34.1

