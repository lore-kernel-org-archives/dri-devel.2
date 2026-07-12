Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B78FC44506
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:12:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD76D10E82B;
	Mon, 13 Jul 2026 07:11:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gd6Jxw3k";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1754610E450
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 12:37:40 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-493c52cde9eso21401335e9.3
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 05:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783859858; x=1784464658; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CJi+7sCg+GNZFhEJVD2Hmu/wR2anVVL7EeD+/Q0E5aU=;
 b=gd6Jxw3kS/XKxl0DgsthweK4b0xU3FQigz2ENF3SsZBQGKVTxJymByyWIae7If+gOE
 hZNo6o1hugpmNnbRrDZmkc2ozGEJImtMJuELKfr/x/wNu8vmpILazFj7Y2Tr8ktLjUJK
 a2Gi0gLbpXrsKT8WtH1eK62xyeu17/1RqKOdP6knzoOaV49mGkF8gGp9guQJYQgAorw8
 pcW+QsWwa+Hg8GbYagQJna8LYE88YaDCfRMF9G4DLxd+zYAmKr7+H8LHtiug4DoV14Pp
 39LYBdVDrPSD6Pj62Oo+ONikZPtxIP3ADUCxd8RCc/Gejz0n7n/DmQxU3xTIc3HvHIq1
 LS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783859858; x=1784464658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CJi+7sCg+GNZFhEJVD2Hmu/wR2anVVL7EeD+/Q0E5aU=;
 b=tROgRe539foiWEYWdW4Knbn9vRw/rmSV7YBbSUcvR5HhCi9I/N8GnxUPCUfIxlqoJc
 xGTE10maL76rf+8g2wWAAunDS7XAQxMxWUnNglWmMuj0W9lmb3Yvq2kHIHCYaWQ3guEq
 9ej9yucAzKzQ+DO29Y/jqYrNTXoOaNVDrQ07gmHFRm3LXjJW8tDEAZ0Uc8455LGWGIJw
 jPP9ve4INf/kqFLtTqEOQGsk+yp0p1kHkkTpgEXd0TC4uDdBRQcz4HkBIPjFXf65WVrp
 2jfjd7KGyOcadinEnG0pfCmR0LZJ98cvhik5VJgyNzB2DNCfdKC1UATDfl7xmMqnOFV/
 Q8NA==
X-Gm-Message-State: AOJu0Yxtit8mygO800SHDfoW42EZZjKHzTLwZhWmz7qeZPQlSCEKDwFp
 WchA5sFhB2a3nKQV1iDz/tDj5IFodW0/Tmpi/iBCO0JeP3e0bHoGvOeC
X-Gm-Gg: AfdE7clCk2Q0x8DjoajbBwK2cjQoTULLPCOUXT1qPSjQdC7nFRXzILct902yn6u9Yjs
 XcxzMl1EfDni9KbJMUBF2l55N53v9vHgA6lahL2vRrt6lqcRag7pE8gHNRKkBWB7uiSI1IQvcwW
 YHJvtFbNKXz9VIvTavDPSdvQvf+YIF5rKWWRhGpZeOS86xZBt4Gdsi2W4bgXVQ1aTwFlZmmuGkG
 Hd6wscPiLCU/Etrxu6tiEwIvhUOIVLWeuTqqcZYoi2XrAfEAi1gI4sP80rhKwcaTcEbtwDSaGid
 MnkJP3Z32I8auMqmx00q5I1Wn0/odT5S68v8zJPTVZ26EYL8IaVhuUSZvvOKXlK96UryVoNxYcJ
 LspOGDdhewS1ncP0rPaSbuD2fRPwzY1iLH1bKzMjg5HQBjYH2tt/GQE6StFtYwFf1l3eG+t2UJ4
 NDUBlZoL0gy2/fm/c=
X-Received: by 2002:a05:600c:6d48:b0:490:9588:bdb6 with SMTP id
 5b1f17b1804b1-493f88389c0mr40261455e9.33.1783859858299; 
 Sun, 12 Jul 2026 05:37:38 -0700 (PDT)
Received: from fra-x8664 ([2a01:e11:8000:43b0:96d6:566b:35c:7b8c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6f3c42sm280280485e9.1.2026.07.12.05.37.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 05:37:37 -0700 (PDT)
From: Francesco Magazzu <postadelmaga@gmail.com>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
 Karol Herbst <kherbst@redhat.com>
Subject: [PATCH v2 3/4] drm/nouveau/device: don't use the pstate cursor after
 the loop
Date: Sun, 12 Jul 2026 14:36:15 +0200
Message-ID: <20260712123616.1180830-4-postadelmaga@gmail.com>
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

nvkm_control_mthd_pstate_attr() looks up the pstate at the index supplied
by userspace by walking clk->states, and then keeps using the
list_for_each_entry cursor after the loop.  This is not triggerable today:
the function already rejects args->v0.state >= clk->state_nr before the
loop, and clk->state_nr is kept in sync with the number of entries on
clk->states, so the lookup always breaks on a real entry.

Should the loop ever run to completion, the cursor would point at the list
head rather than at a pstate, and the pstate->base.domain[] read and the
walk of pstate->list that follow would read past it.  Rather than leave
that trap in place, track whether the entry was found and return -EINVAL if
it was not, like the other lookup failures in this function.

No functional change.

Signed-off-by: Francesco Magazzu <postadelmaga@gmail.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/device/ctrl.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/ctrl.c b/drivers/gpu/drm/nouveau/nvkm/engine/device/ctrl.c
index f2e9a0626..28702741a 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/device/ctrl.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/ctrl.c
@@ -74,6 +74,7 @@ nvkm_control_mthd_pstate_attr(struct nvkm_control *ctrl, void *data, u32 size)
 	const struct nvkm_domain *domain;
 	struct nvkm_pstate *pstate;
 	struct nvkm_cstate *cstate;
+	bool found = false;
 	int i = 0, j = -1;
 	u32 lo, hi;
 	int ret = -ENOSYS;
@@ -104,10 +105,15 @@ nvkm_control_mthd_pstate_attr(struct nvkm_control *ctrl, void *data, u32 size)
 
 	if (args->v0.state != NVIF_CONTROL_PSTATE_ATTR_V0_STATE_CURRENT) {
 		list_for_each_entry(pstate, &clk->states, head) {
-			if (i++ == args->v0.state)
+			if (i++ == args->v0.state) {
+				found = true;
 				break;
+			}
 		}
 
+		if (!found)
+			return -EINVAL;
+
 		lo = pstate->base.domain[domain->name];
 		hi = lo;
 		list_for_each_entry(cstate, &pstate->list, head) {
-- 
2.55.0

