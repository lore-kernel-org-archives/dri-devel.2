Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EBCCC5B560
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:38:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAF4210E649;
	Mon, 10 Aug 2026 06:38:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VRt/31eJ";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D86510E10B
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 08:49:53 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-38deea72eebso869895a91.1
 for <dri-devel@lists.freedesktop.org>; Sun, 09 Aug 2026 01:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786265392; x=1786870192; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yOuPd/8nIM02AL24kWbQs53dFhNPEGw5UKtvK4sm+fI=;
 b=VRt/31eJLPC7bcox77zRXJbfN6aSnEwOWUUCLKcAQ8KBqPFWUxbt7iJvdfgUkeBWc3
 pwwJBaH10dVa0ANrPbbKldbibihVkz4z2gndC8UDQeZGL+O6HxFiZLm68ty9eBC0KJHV
 XX9simOJUasRkDkA12aMwblpFY3F08bzaA3LDQ76vAd6WAC898IPHxBUu46hxmRBcr+2
 oyjZmjbHdBiiCRbmQe/EU8durzlyX7yWK0h3OGpswfGcl/7gG9rX55JrW/omPTrSnnXx
 y46TJm1/YX+3IhE/C0JMmFP1tIP9GosVAvzEPrjJSFdj97hLmwOt8XewdxWINIiuHUbm
 Dz2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786265392; x=1786870192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yOuPd/8nIM02AL24kWbQs53dFhNPEGw5UKtvK4sm+fI=;
 b=VsdPrTasNRp3Gmwm6G28YcRcARa+Js5xYffl35iPEM5/RDqbRK3svsCge0nd/o6u1U
 JGwrwgnAbGlTyyNG8JrPnPxvosOA+Sf3dprh4Cq9F3w5sl+b02TuVzM4hzzqhYWAEZMY
 1mF7e4t6SSrhYlqf9rNL2JuvnxRPoPzdDsDtvwrO3K7lHjgcPP4oZU/t8IG6XIBt2cki
 RI9hCk3bJWq+mD8OCtCH02YVw3fxDgVZgJ8K+0s4xIXPUpm0YwjAAUm1pItRUlXF4KTJ
 vkYvCbcwZ169DKnrALLTF6/ouVlCOnMKI0Y31XirpAV9OjucMspNz12P52E87JrMIuJi
 rf6A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq7H1uY8PHSM/+3aGZeLOAQ2uuwhFOQoWMoB5i1TSMfHz/KK6g/lI/cfRss6e+9oay8WKC2GcIi/7c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw+Dy7b5BvYdZepuk9aIoW4azi7xlyeMQQcWfObWrqoFoJE3+99
 +EJ3Fx/SY1wzXRzt+cFAaLQIL2DgMYp1T9wCxYcYKRwUIlvR04ZFZHqv
X-Gm-Gg: AR+sD11qYNH+8vDR451lvcNhMtQNkR/DeBF6ror5LsELsc7WGssa+Wour3dtrHMnWA1
 jKBNpez+bbu3NDU+x5t8h1kBULU0qsWQju5s39ugAqbeFZ5j+Y5egdorqm016ilU/v0sMhZ9QJJ
 hEHlV7Cz08tIPe5gdtI9clXlr0KsVP0ElMtK5OFCAXSRn1L7NhLnw2pC79B0H33yd+L+Zcnfs6U
 zC3K/yF7fd4BPzNtO+kVKn9CXw6F8J4721WW9I3jR/cxm2ewBDmf41dvMJ8KXVK68J+AtyP9+Ps
 a1Gfxe/nG4hhaZ/5hyoBFsQVgSSjSqp5n/Jt7kBJ6TvrjaRMCRxJccmILZ3Md7fcPpo1N+PM0RS
 1RelAs8YRFOSOPetZbsGXh4Ecz++MDPssKhLhhKBC/4f5c8yZXqkvzqqzXRqVrSlArqmw0HlVmi
 vITCMUd54riv/X4Jlu+FpNk9LUeayc5UFR5g9pB2jFwGXg0KRI0fOFJCaeyCFsnhW5z2rvOpQZr
 3S3uKuW5yE=
X-Received: by 2002:a05:6a20:1602:b0:3b1:cce5:9140 with SMTP id
 adf61e73a8af0-3cbce98a610mr14359456637.33.1786265392386; 
 Sun, 09 Aug 2026 01:49:52 -0700 (PDT)
Received: from localhost.localdomain ([103.178.205.91])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be86fc7bsm28800025eec.1.2026.08.09.01.49.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 01:49:51 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH v4 4/6] drm/amdgpu/aca: Add missing NULL check for banks
 parameter in aca_banks_add_bank
Date: Sun,  9 Aug 2026 08:47:33 +0000
Message-ID: <20260809084735.9743-5-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260809084735.9743-1-sreekuttan2156239@gmail.com>
References: <20260809084735.9743-1-sreekuttan2156239@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:37:47 +0000
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

aca_banks_add_bank() verified that the 'bank' parameter was non-NULL,
but passed 'banks' directly into list_add_tail(&node->node, &banks->list)
and incremented 'banks->nr_banks' without validating whether 'banks' was
NULL.

Add a NULL check for 'banks' to prevent a kernel NULL pointer
dereference if an invalid pointer is passed by a caller.

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index c35f6be2ef77..dcddeb381628 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -49,7 +49,7 @@ static int aca_banks_add_bank(struct aca_banks *banks, struct aca_bank *bank)
 {
 	struct aca_bank_node *node;
 
-	if (!bank)
+	if (!banks || !bank)
 		return -EINVAL;
 
 	node = kvzalloc_obj(*node);
-- 
2.54.0

