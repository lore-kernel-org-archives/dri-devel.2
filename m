Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A610BFED3F2
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 17:29:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC41410F650;
	Fri, 24 Apr 2026 17:29:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IFbcKvXa";
	dkim-atps=neutral
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com
 [209.85.160.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6A0D10F5AB
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 14:08:20 +0000 (UTC)
Received: by mail-oa1-f46.google.com with SMTP id
 586e51a60fabf-42fdab683b7so1178309fac.3
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 07:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777039700; x=1777644500; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Awi4viU8NvHRlCqV4pUg2d0xyjRYURsNTCZSqlhhrUI=;
 b=IFbcKvXaihoQFRtDhH4tAzVc3IeWELWNGdThrJwq9l8J/mJtpo9tUbSEHg7kik18KY
 ueTr5bvAitQMiYXldukBjUiIGTllXXvrvazTxzSOh85qcthjCWY5pSQioCnyvrn2zkAg
 aHDpXDliYIF1heIAm8WSL13jmWne5JBTY1p6Cs8wiNhXCI027EoSMcatYpYGR6Ociv3j
 oOIEEw5D+sJo9sSYoOy6toKzb6N8URwrQwLkVQ+sc8B3zAgLE2iNEy3rYRCSMc/VVzrU
 U+fWG3kf9ixPSAbwmIFpL6JsLEVM9BpSJIWxRVXJDRQu1jr1PHzz90jSCtUV34oePREc
 D9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777039700; x=1777644500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Awi4viU8NvHRlCqV4pUg2d0xyjRYURsNTCZSqlhhrUI=;
 b=SylPaPtq/ykASVO9v0q/09sZdEDDVzOQLdQM40sKqoQrfoz/7aG2kht3BRXldv21Vt
 y82TaQK+6djhDZlZjBGy9De0FWJ2ezgdMcV3S01aFJumiIgG4LhtPrWunPmyV547ocj4
 uVNBuRb2HQgmOe9d2RKLs/45OseBa07jTgRk7MXhc2iF88u/r9DbnXabbYq8Mja0l2QH
 HgeQFGRk7by2blRro0lcvLX4lrUA3cEEDl2ldGu3B8QXDS/QMdQMlU+RiavrugBA3bux
 opBiw70d+Dawmry7w3NrJJciEcqnhUaDtMs2H3Fedz+rH4PeF2J+8IJC9ickUr46bQkM
 ELLw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+R9FsSWCBDph+SC+tnj5fcKmmYiqnjQbSpdXLzavzpdpB4WL0fdxpwPfBdumXfBAWq+9PyqBma20U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwlpXrIps0QnxMthi2va1AhWbvIRFJYNyJ83ivVM2AsVuX/1Eat
 KL0gmFK8QlTIVyIIkEAwFG2Ci54VrKybBoitrGBP4mp1lnBjzDOhtYY=
X-Gm-Gg: AeBDievOvoivGlNJ9a22BaN9BP/cZKSDzN8GN1za3vTjUOTR62AdkKlQefsNvPvjwAh
 yXpAXa2e2J5vm+R+m1cgK7OnjOmY4pdQpCW4c1+4RxaMFexEhjR6HZ0f8xJcDH7ZbJmeA+1JK9P
 yX26knHcR/wamb/bH4ml+ZuS7MUZoJPFQP8Daa5TGwUze+u6oHOlSXYFeR6n4CQZjclXKzAQjkA
 sh592vefctmV53YkTu9Ey4fdAhxnEu5AG3heWnqu4KowwXNYnccRdRoA0zB9j6q9QgW/teXC1pg
 XyIyv+DN/0c/rTZaO7O21gGeKVSJcGnwDy9t7ECpA+nRmztzAPr0kN2dSOo2VQnNoc+uA2GntuP
 449Jf+zzFZxb5plJdrdHuclxiv54gZVtQB0gPPNUX/P1oL2smIFQATEOzfrgbQ2cg+OowX3R88e
 3jJfExf78j8cZro7zmdXSF8VFgIBi4mubaKWAy1XBeQQdYpXsOIdRjtIxNfA1TgJesSFamBjUuz
 Mnx1WOiogrDkRGaASJ+vNmH54z+Fo8danA=
X-Received: by 2002:a05:6870:9109:b0:42c:f89:7555 with SMTP id
 586e51a60fabf-42c0f89783cmr10667903fac.11.1777039699909; 
 Fri, 24 Apr 2026 07:08:19 -0700 (PDT)
Received: from localhost.localdomain ([47.188.191.104])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b934a2dd1sm22228653fac.9.2026.04.24.07.08.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 07:08:19 -0700 (PDT)
From: "John B. Moore" <jbmoore61@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 airlied@gmail.com, simona@ffwll.ch, stable@vger.kernel.org,
 "John B. Moore" <jbmoore61@gmail.com>
Subject: [PATCH v2 2/2] drm/amdgpu: remove superfluous BUG_ON in
 amdgpu_cs_vm_handling
Date: Fri, 24 Apr 2026 09:08:16 -0500
Message-ID: <20260424140816.43766-3-jbmoore61@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424140816.43766-1-jbmoore61@gmail.com>
References: <20260424140816.43766-1-jbmoore61@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 24 Apr 2026 17:29:28 +0000
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

Remove the BUG_ON(!bo_va) in amdgpu_cs_vm_handling() that is
unreachable: bo_va is assigned from fpriv->csa_va on the line
directly above, inside an if (fpriv->csa_va) block, so it is
guaranteed to be non-NULL at that point.

Signed-off-by: John B. Moore <jbmoore61@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 53f537f3e..556c62948 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1137,7 +1137,6 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 
 	if (fpriv->csa_va) {
 		bo_va = fpriv->csa_va;
-		BUG_ON(!bo_va);
 		r = amdgpu_vm_bo_update(adev, bo_va, false);
 		if (r)
 			return r;
-- 
2.43.0

