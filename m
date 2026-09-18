Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61478C982DC
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 13:16:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F9E289A5D;
	Fri, 18 Sep 2026 13:16:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="n3JTp+X+";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CF1710E8C9
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 13:16:26 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4843f22dc83so502393f8f.1
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 06:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789737385; x=1790342185; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NPknZ1WGs+5VI15GYbHYggwlCsBgDjKJicFWFVELHwY=;
 b=n3JTp+X+oZScawSJX/lcq5OGmiuZ1cKXvd7+cded+hqGuA6O7NdwL0LV/Z0lF+3LI6
 A6ngQ1o5I/P+a1q0z4WVdsiS9dTIqKLCj2qSGoBPX4hiN2ZAZtNtOfiXZ06A/lciUSl4
 VlvCSEBtasqQ7vJ3AFyPvw9KpfebH1vEoOAFZ+VvAjjU7DfaiGeQtOUkVC5EWeP6Bo49
 Q7i7wqMaPMSyYxaLpe6Ey5cis/PIOk4ucpyHYh8THZXDiTNb/QYmE8kZLYN/aEOe/Y2o
 jrBEVJdY1YhIX8h4iREFlAOENsTwxlocJJ+CxG7reRI4PtYJJFvwCuryHWscYKHinYTQ
 1XIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789737385; x=1790342185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NPknZ1WGs+5VI15GYbHYggwlCsBgDjKJicFWFVELHwY=;
 b=Wv1/cE6IxhJ4hNXb+TL+vbXnXSsLEg5NMyaI4xZD9ei+3zkw+taKLPEBEp0LG4+m3o
 gGjvGalF5Q+CGf6D7p+RfqVAER3Vola3HYHm4h6YPuaQgBoUlUwul7W4BcNJ9CGIvD+q
 ufUuef/LeT6y6yXaRu9xnlw4adq2wrI8idGYqTLHu+5orDc/Wqf94Vt9sXmstEPq/bsT
 8+zfOV0qDaGoV4/aJoTQrSu34MzrVEX9Xum4RxUSOmG7hX9xZAjS5+jI+QYMnOKv++fS
 tYegmVE5F+DFbGplmJJrSsAYtguBdkU7VhVGSGrEsyqX4AByREZ892sDLLrwYvquvegl
 sZIQ==
X-Gm-Message-State: AFuF++kKolniQkNX2eDFqz51PYIsPVphXwaPG2fH9jPDZ645/UJfh1ru
 HbD4cUNqExkQi/fQafFacPQ3/W6t1Yh46jJrgHmf43v7Q4z0zKaidU+9
X-Gm-Gg: AYBFou30qBKjJ+KQopIYRB6nS+NHOkKIVzNqDdT/ec5vNxzOeR8QsntVdYtihs7unsb
 Ng1J2GJlZslzf3lBXTqGkYj8H3b42OOQiM3vc8nbL6YpMtm6XywIotvgHIN3zb685NCzMO4wvkK
 UaaOCoPSxsY0pUVW+INsuAYcjqwB9E/72rmL1S3LzQ0bvh9EJPAeP2LaC8amPL2mI1I/r/b1+Qo
 rgZcOBq4i6+JvekhP5rKIQSXCerrmYC1V2RPjwjCOwRVZH4y6nfD9EaWKnJl70SNx6SVBK+Z65p
 WSrjbSvQt6rFxxC5wvxQdpsH5etd4lAzZoBbW4XO7JBi7nMhh7RgtTNqg2CGMoF9PpvluxqI8cr
 93CgyRaJnxLKaWbRpNvoXKLMojIMR9S8hJuATJoJ7uNcqRp4HaeznIYAml9+Un/Y5XILtfa6DSM
 xMWpSi3wCX430/iivuQtAnOllvsSu+1UP+t/0HKtE0WTzjCm4ccVWdzJr3Yvd2AoJt5ljbRiAcv
 V+FRC5Pdws=
X-Received: by 2002:a05:6000:4548:b0:487:221f:a2e1 with SMTP id
 ffacd0b85a97d-487221fa2f6mr1255469f8f.55.1789737384792; 
 Fri, 18 Sep 2026 06:16:24 -0700 (PDT)
Received: from fra-x8664.wind3.hub ([151.16.209.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-487200829e1sm4487572f8f.34.2026.09.18.06.16.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 06:16:24 -0700 (PDT)
From: Francesco Magazzu <postadelmaga@gmail.com>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Dan Carpenter <error27@gmail.com>,
 Karol Herbst <kherbst@redhat.com>
Subject: [PATCH v3 2/4] drm/nouveau/clk: don't use the pstate cursor after the
 loop
Date: Fri, 18 Sep 2026 15:16:18 +0200
Message-ID: <20260918131620.405133-3-postadelmaga@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918131620.405133-1-postadelmaga@gmail.com>
References: <20260918131620.405133-1-postadelmaga@gmail.com>
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
Reviewed-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
index 5da82db71..a43246ae6 100644
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

