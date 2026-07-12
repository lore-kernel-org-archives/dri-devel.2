Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A109C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:12:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E89410E832;
	Mon, 13 Jul 2026 07:11:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lNWkNWM1";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E97D10E461
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 12:37:37 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-493f25d47dcso17329175e9.1
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 05:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783859856; x=1784464656; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yZa2enwSIIgLldRkiC8kJq5D8PtsumlenYqYmwQU3wk=;
 b=lNWkNWM11UkiHsmRhKcwZnFFxfTZg2w1QAFe0E6nVyXKEp/j/NbWBoiYz+lhG2UvZP
 /zWV4H1qD5jnePosKdEAW2s1IHGbgZgAKfSjTbQB1df9J/R1zIrq3GTpZKXMrIYGvaBC
 zk5LxUwn+5iGA4ILPtHBeJWuUUa17Yu4YSur9Lc26k04Sk8BEuvY5zIfDQ22WACsh0V3
 /YsHio2WX4K1VjV/GVBCfkzyVK4U81VAzpXXdYow+7RMyPTQNqrMQ3BfrmbrLapt54YS
 QFkztzaDTgHB4iNa0AFN0QcLlyO0VazcK/d0h2MyNY+6GS4knMXOXHvk5ebuqdJ2P2Lq
 1aLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783859856; x=1784464656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yZa2enwSIIgLldRkiC8kJq5D8PtsumlenYqYmwQU3wk=;
 b=Ej2Je1yRzCYrmXMMQPGcgRuOMqLmgVLkAm11dztLYfrqqKYJBc3nX9hf8HrkUwFZN2
 mjygcfzRTh+e9NUuob2Kls5Xhulftj3AjrSdGK/JtDR+KrRNTr5cz+iobvxayUNTjwjr
 L8/IKMdvuVu/wCQZ8MENymU4Or+AB/4CMSy1PAG5NAT+3U87nbz88U+gesQTYs8Sil6r
 tYCFRJSuBH4U6f6Rq4DVJmk4Hfs/IFdduM1UKid++r+ZuJkmWE04zOZ20i2P8M9qN5v5
 OEMPGtKa8Ca/NzMi40xO3M6OcdozmNrQlBKhgDUDY7AW0a5uKBJ4E4tWXaXm1M4hVq8I
 HLIQ==
X-Gm-Message-State: AOJu0YyO5rz7vWKRKEd0EWRmLhA4iXzwqShGpss+yk9f/TdBhd2Qvgch
 OqN2P5VQM8zElZPKtVVLgJpssxkeFhTVirlannzAF4eiKF+vl+5YB1i3
X-Gm-Gg: AfdE7cncT5efx1eJ+yoB4pylO859K+1xhtvPN9DgPuHzkmTa8LL3Fo/kmgCuhp1Wxb5
 q2WQdpcJImZk1mdxcFqpSVg4aFhYxTL9GQMtDQeSi8p3Wp4oPXxGOo8rh5R1M0IJz6RjR+Y60mL
 WDBouC6cs1cvODpTe6BUUaN0wmWU/sFOyMz6ICUVx6ZSrB+HEDLn0fsW7PD9d1QLk3zGiLFN0sR
 vESarhUUHMK/EX17LhZX5QP7lnN6lIkkAt6jBDQI6517S7JO0WzdzKABs2ErU6zXmP2dyzrIyU4
 t6wdMLikhmu8TgGUZpT7077C/HKpUYP2j3/UtXNuY/gmv6pGODt8VEdtuVYP+750DJocvr5I0jx
 7Op2a0D6OVyEZCZV+e9esOADRnUhqbDjPtCAyNTsOxvj+UYVoKHb0rvLTPcb2dk5eRCrsUp/H5l
 6gX7zBBX7wXJQyQnQ=
X-Received: by 2002:a05:600c:80c5:b0:493:a570:df7d with SMTP id
 5b1f17b1804b1-493f881d20fmr37660025e9.20.1783859855726; 
 Sun, 12 Jul 2026 05:37:35 -0700 (PDT)
Received: from fra-x8664 ([2a01:e11:8000:43b0:96d6:566b:35c:7b8c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6f3c42sm280280485e9.1.2026.07.12.05.37.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 05:37:35 -0700 (PDT)
From: Francesco Magazzu <postadelmaga@gmail.com>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
 Karol Herbst <kherbst@redhat.com>
Subject: [PATCH v2 2/4] drm/nouveau/clk: don't use the pstate cursor after the
 loop
Date: Sun, 12 Jul 2026 14:36:14 +0200
Message-ID: <20260712123616.1180830-3-postadelmaga@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260712123616.1180830-1-postadelmaga@gmail.com>
References: <20260712123616.1180830-1-postadelmaga@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 13 Jul 2026 07:11:31 +0000
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

nvkm_pstate_prog() walks clk->states looking for the entry at index
'pstatei' and then keeps using the list_for_each_entry cursor after the
loop.  This is not triggerable today: every caller clamps the index
against clk->state_nr before calling, so the loop always breaks on a real
entry.  It is safe by virtue of what the callers happen to do, not by
anything the function itself checks.

Should a caller ever pass an index that is not on the list, the cursor
would point at the list head rather than at a pstate, and the
pstate->base.domain[] and pstate->fanspeed accesses that follow would read
past it.  Rather than leave that trap in place for the next caller, track
whether the entry was found and return -EINVAL if it was not.

No functional change.

Signed-off-by: Francesco Magazzu <postadelmaga@gmail.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
index 42f3709e0..4d546b07f 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
@@ -270,13 +270,19 @@ nvkm_pstate_prog(struct nvkm_clk *clk, int pstatei)
 	struct nvkm_fb *fb = subdev->device->fb;
 	struct nvkm_pci *pci = subdev->device->pci;
 	struct nvkm_pstate *pstate;
+	bool found = false;
 	int ret, idx = 0;
 
 	list_for_each_entry(pstate, &clk->states, head) {
-		if (idx++ == pstatei)
+		if (idx++ == pstatei) {
+			found = true;
 			break;
+		}
 	}
 
+	if (!found)
+		return -EINVAL;
+
 	nvkm_debug(subdev, "setting performance state %d\n", pstatei);
 	clk->pstate = pstatei;
 
-- 
2.55.0

