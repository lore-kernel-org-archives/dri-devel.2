Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97788CD3427
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 22:27:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A162210E1B9;
	Tue,  5 May 2026 22:27:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="AvWC5ki4";
	dkim-atps=neutral
Received: from mail-dy1-f226.google.com (mail-dy1-f226.google.com
 [74.125.82.226])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FD0210E1B9
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 22:27:48 +0000 (UTC)
Received: by mail-dy1-f226.google.com with SMTP id
 5a478bee46e88-2c15849aa2cso7849984eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 15:27:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778020067; x=1778624867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mrZNRShoG9NxgTRlEfwE7/QFVxhrzc+ecj5iGQ5Zu5U=;
 b=dWdXBPYVBzemA7kXTswcdauJMaLV7MGWN0m7FXFJLVD6FvBzYKldYYMJwvUUnycPpJ
 1kZ3uPic2TySrHrpew/sY0QOGrMZxpAR5v6WlLBw2prM/pOe2a6Otm16RGWhLC9d4AsN
 mIgeYBGUn7IKzFQsk/01rpDaRFav6ndnCJ31yUwiKXq/STXf7pCWlvbe89i9ffdCPROg
 AoqHkBqibuoKPMHo2MAQT97Ta1SGFsQs8RBAZpvJ1mOKLvbyhLvPWLrm0fID/9afJjvm
 yJwyHvhRv3gHHymY+a2/W58PlHv1iLT1kGsoooxgzNlLlq4At7Gvn2k7d1KL1LhI3JVI
 StCg==
X-Gm-Message-State: AOJu0Yxijl1yTkAs5w4PBVf8lP5onpCustteZtFoiIBNZb2jAYwAXNZq
 qPvS4vePfrO1GG7P7io3OURMLF4KZ4XNwLk7rkMbri3AMO1YlF4drdd7ornIA5ukogbZBLLOOm/
 F/6kIYL5SVJeQbaL/GCmTa4MPod+FX3M3qfM2cYAySlsP/M7xKTj6WNvQMaoeJIuSH2YaF9nf/f
 6EHtiNH4BQubfjZR9j9xyLOdtDyOxhm2+IeT4yemYoNtMgQWwYIK6Qp1BnMDnRrGpaclE1YlqSU
 5TTdpuFYGfOgF5+53Y5
X-Gm-Gg: AeBDievMz53BPIhNitaNmx2vwLOWFnRZE4Opsbw2632p6gXsYnoCZpVvAr0hIqV1dNy
 MvEsNtvty4T1ZgtK556xsHkqwdz02MtjqjAhLZWkUCvGgcDmdW6+VCe+vCnart3IR7tYoSNJb67
 Pzy97qobzCMvx1Tl7h1sxo0zaIdnZbd7q0uJIDqqN0cWeQutuQZ2HOqX+eEXrPSTLmjQ+HhApty
 DiX8j88ctahyJ9tXfOCkY0ytxg7kEJkLMkehb+jEiYM7SEec0g7QWNqZhheLWMXuM+hUGj08pnW
 gftbjFnlUfeICv+8djAwYMweG8xk0AghgON8fjQTLcaZzlizg5YmxWLwLfTQ8u9Tv4IMuqhk2JH
 nsSu7LLavgcDqkPlsuq+Ru5PmhLoP2pPc2JWsw7vEY9hhb6p/IZdyUeEROtBmVCJJT5vIw+0IvY
 WZOZKjQQ4di+6GQDs9gMEK9hHQMklaLtuFJr6vNdnZ0KHYwErwgHPDJY3VpHb8Kuwn
X-Received: by 2002:a05:7301:fa0d:b0:2d9:2b54:ea9c with SMTP id
 5a478bee46e88-2f549f7c312mr633797eec.18.1778020066965; 
 Tue, 05 May 2026 15:27:46 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
 by smtp-relay.gmail.com with ESMTPS id
 5a478bee46e88-2f56dcb66fcsm36213eec.12.2026.05.05.15.27.46
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 May 2026 15:27:46 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8b49260e3d5so43569496d6.2
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 15:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1778020064; x=1778624864;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mrZNRShoG9NxgTRlEfwE7/QFVxhrzc+ecj5iGQ5Zu5U=;
 b=AvWC5ki4T32ZgE/mB7qONQdT6zwua7M8MKstKnZqsN/gQT4/JrJJ4qlRERpmsZAo7/
 abeRZetPj8Ct2AgKHWEstC4D/swO1VrYTbzr1jPyZzU8WnriCOTuhx+5bFmcNNf6Lwr6
 dG4DTD6PXV+qIKQkDRJFx6JILAXXqB80aZbac=
X-Received: by 2002:a05:6214:246e:b0:8a6:1216:fb7d with SMTP id
 6a1803df08f44-8bc45845af7mr11077816d6.45.1778020064626; 
 Tue, 05 May 2026 15:27:44 -0700 (PDT)
X-Received: by 2002:a05:6214:246e:b0:8a6:1216:fb7d with SMTP id
 6a1803df08f44-8bc45845af7mr11077346d6.45.1778020064071; 
 Tue, 05 May 2026 15:27:44 -0700 (PDT)
Received: from vertex.localdomain
 (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b539aa6f5fsm162692886d6.21.2026.05.05.15.27.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 15:27:43 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: ian.forbes@broadcom.com, maaz.mombasawala@broadcom.com,
 Zack Rusin <zack.rusin@broadcom.com>, stable@vger.kernel.org
Subject: [PATCH 01/12] drm/vmwgfx: fix guest_memory_dirty bitfield clobbered
 as size
Date: Tue,  5 May 2026 18:22:22 -0400
Message-ID: <20260505222728.519626-2-zack.rusin@broadcom.com>
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

Two sites in vmwgfx_resource.c assign boolean literals to
res->guest_memory_size, which is an unsigned long allocation-size
field; the intended target is the adjacent res->guest_memory_dirty
bitfield.  After the assignments the field holds 0 or 1 instead of
the resource's MOB allocation size:

  - vmw_resource_release()       writes 0 (false), and
  - vmw_resource_unbind_list()   writes 1 (true).

Subsequent revalidation paths read guest_memory_size when computing
the dirty page range (vmw_bo_dirty_transfer_to_res()) and the buffer
allocation size (vmw_resource_buf_alloc()), producing zero-length
walks or wrap-around ranges that read or write past the MOB bitmap.
The dirty-tracking intent of the original code (mark the resource as
dirtied since the last sync) is also lost, since guest_memory_dirty
is never updated.

Rename both assignments to guest_memory_dirty.

Fixes: 668b206601c5 ("drm/vmwgfx: Stop using raw ttm_buffer_object's")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c b/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
index 388011696941..e3a187a2c7a1 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
@@ -136,7 +136,7 @@ static void vmw_resource_release(struct kref *kref)
 			val_buf.num_shared = 0;
 			res->func->unbind(res, false, &val_buf);
 		}
-		res->guest_memory_size = false;
+		res->guest_memory_dirty = false;
 		vmw_resource_mob_detach(res);
 		if (res->dirty)
 			res->func->dirty_free(res);
@@ -773,7 +773,7 @@ void vmw_resource_unbind_list(struct vmw_bo *vbo)
 		if (!WARN_ON_ONCE(!res->func->unbind))
 			(void) res->func->unbind(res, res->res_dirty, &val_buf);
 
-		res->guest_memory_size = true;
+		res->guest_memory_dirty = true;
 		res->res_dirty = false;
 		vmw_resource_mob_detach(res);
 	}
-- 
2.51.0

