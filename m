Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 203CFC44507
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:12:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FDF310E824;
	Mon, 13 Jul 2026 07:11:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Its3AQtB";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B9BB10E45A
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 12:37:33 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-493f60208a5so17976355e9.3
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 05:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783859852; x=1784464652; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x7IitsXdpTEQRJSq8p+rIrB3s36tgZetIRvXFPP7irs=;
 b=Its3AQtB3W6/LOfqU/6dMlR2Qo0WNqgsbCQkeCqB6CMrGAX52SQquMNc9soht98K1l
 fzalEmiAlT2YhYvn1Ty0srjzqAojTXtLV1ypE5ClPiji8625bfUonP4RrEoet2hD8u/H
 Q9rgKQ8P56140FDG70s1rhOhVqGEKLVTp7iHtfUrfXpeflGepXENFv83lIPQVll1okN6
 4HDvbEGAmfEdg8tkR7c/3h7SjeSrIWSrW68SHdCpgTsy6Qg8HdoIw4R7em0x0Xt6zXIA
 WoMIr4z2WvzhkeWFt8zL50QgMku01QhFyacX3mtbuRViUCjPF5Uk4sXWWo5jsAoVBwbp
 Trgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783859852; x=1784464652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=x7IitsXdpTEQRJSq8p+rIrB3s36tgZetIRvXFPP7irs=;
 b=RirYGOdC1kYbS38GONu5KB3uP6JhRsdn5wRyQis7b4wzJlfvYEXAZ4xVCSMldUysgC
 HM8y44dmzHgeqkXf33NuPWf7TpIblxqxzoEl3GWXq3YgvjYVyrRbfGI5Km/xyv5dwK4g
 GZ6kNWmo1ftZhnco1/tWy7+KDS1JFjtFVGO2xfM46ZYJa8pKAddt0c6r/gHwRs9n8HSp
 aCER7gxhR94QPQxe/3KNN2clJDHXrN24R7tVBmaJtwuRA/MfXknB14Yvj9nSDvhM3Axx
 00Eqoq+xsDAN0vfxgaXJKnucg4qodaQQi8m487oO3EsJURkWN7bi4KesLXMTUhF6/qal
 Pqyg==
X-Gm-Message-State: AOJu0Yznftkr6iDboH2Khz6W1aHq7CUhvOwGL1/oQR0hfBwU21jbYCCb
 isQxIbUbTtGW1j1ZY5snsmXCt3MWhXXa0xZIiULw36eyuKCfGHFOXK1o
X-Gm-Gg: AfdE7ckxJptrJV0Dp6BlNLLoPLsz1UgyKpHef+ExU4KF9yIuEhxevR3hRKUG1JvUL3C
 WixElFjnq/5ZL6pm8OdfiyHqCX7CO27SVu7DzdtE2fwfS5pALQmtbZFaWSAqi3PVSnE2q2OE996
 56J3OzKg0MVgH3u8LoIFCwLCVfNbDmfaJdmafwdUr16xNLwXlYD5jgspJbyk1qniop2GDNW7pzh
 7Q93IGEKMNXtDOybI+kd2dFklA7cbXpa/AIxwOzXTIJgmrQGOl/dUa4hqnOF7KPyF9DHCbwPnMe
 Ypc/lA6y4bfeYSCpp38BEhHAjNEqF4L8wsw49iOhvBA3aM3e8x+NoGJ8BXt0QzGDYbeel/K8l+g
 R9CkS4AfEmt89Rjwv29s+OyCQdXnpbSGIW3WI2cjrjMOALVIfKl4zhJsg0YGLZWlEDR38+/dMOY
 wKjyBcGkAhUlF/q6Q=
X-Received: by 2002:a05:600c:1386:b0:490:5057:f5f7 with SMTP id
 5b1f17b1804b1-493f87e5164mr54882405e9.11.1783859851424; 
 Sun, 12 Jul 2026 05:37:31 -0700 (PDT)
Received: from fra-x8664 ([2a01:e11:8000:43b0:96d6:566b:35c:7b8c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6f3c42sm280280485e9.1.2026.07.12.05.37.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 05:37:30 -0700 (PDT)
From: Francesco Magazzu <postadelmaga@gmail.com>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
 Karol Herbst <kherbst@redhat.com>
Subject: [PATCH v2 1/4] drm/nouveau/clk: fix list cursor use after loop in
 nvkm_clk_ustate_update
Date: Sun, 12 Jul 2026 14:36:13 +0200
Message-ID: <20260712123616.1180830-2-postadelmaga@gmail.com>
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

If the requested pstate id is not present in the state list (or the
list is empty, e.g. broken/missing perf tables), the list_for_each_entry
cursor runs off the end of the list and the subsequent
pstate->pstate != req check dereferences the list head cast to a
struct nvkm_pstate, which is an out-of-bounds read.

Track whether the entry was actually found instead of inspecting the
cursor after the loop.

Fixes: 7c8565220697 ("drm/nouveau/clk: implement power state and engine clock control in core")
Signed-off-by: Francesco Magazzu <postadelmaga@gmail.com>
---
Note: essentially the same fix was posted by Dan Carpenter in 2022 and
never picked up; the bug is still present in drm-misc-next.  Credit for
spotting it goes to him.
Link: https://lore.kernel.org/dri-devel/YvSkKAdk8Pe0g2K9@kili/

 drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
index 572e63846..42f3709e0 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
@@ -479,13 +479,17 @@ nvkm_clk_ustate_update(struct nvkm_clk *clk, int req)
 		return -ENOSYS;
 
 	if (req != -1 && req != -2) {
+		bool found = false;
+
 		list_for_each_entry(pstate, &clk->states, head) {
-			if (pstate->pstate == req)
+			if (pstate->pstate == req) {
+				found = true;
 				break;
+			}
 			i++;
 		}
 
-		if (pstate->pstate != req)
+		if (!found)
 			return -EINVAL;
 		req = i;
 	}
-- 
2.55.0

