Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB02C982D8
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 13:16:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D481510F362;
	Fri, 18 Sep 2026 13:16:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZSmR0YbS";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D515110F37F
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 13:16:27 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f6350f89so453780f8f.3
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 06:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789737386; x=1790342186; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MWU/Z4Cv9J6Gjygd5g2E8XPN0BiQe/Sbx9hToRJGZ3A=;
 b=ZSmR0YbSd/UEw6OSq+XrIAN8mXOop9FW4P/EkTCEZiG6VWSR8mvMDvVn7HT1F4491c
 AMf1gMeqRcU3dCK3o4KljlCS1RttxFUBbrXMvNHr9daHYjV3FHoYbOocPbv9xYzDxqeE
 3dxxEXtHsor78mHmCY5ynpdTORbsTZ+FX+LVGq8AihVzppDRS451DCy1881LZkHkjir7
 xslx3lIuhh4/7TDS/433a5hElq8pLcodM/oGA0CfF3m86AP1vripD5b2NW/FZbxOztoA
 +Pc+30UWcoxqvV+Qef6NTkCIeDnch/sEx2oNtRxWIOAObz6gmVrb2AnTIPXNRa7zU/i9
 gzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789737386; x=1790342186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MWU/Z4Cv9J6Gjygd5g2E8XPN0BiQe/Sbx9hToRJGZ3A=;
 b=tmwsp7K/snu8Dz9Ce4B2nXApzteu6EMs7QYqXY3VsT1n2gjDzaY3xFPS7ydPFVcLTA
 k8mj/myj3jaGl5lhKIGt0fXxpbe1BHpzXgqshc4oKK/FDVaK4a0iuaBdGahY1T+qkIbs
 qyWXd2fopXTtTfwTkEjZpRbVp8FUO5osXs+vLpKH4UfHeu9wIVpVymr8XLDaAvoLp5E7
 L8Vz0kfBam8MfcStwUKflDkY3+xq0ZZ4IhZpbCtcZdyetzEh4Wg1fpKfh5lb0rzLqGnw
 vpnu9TCa4dfu2FQjND/yYQjPpbEfl0CPnmkxvnReBsilTIX2eqa/flUloLV/KBb93CjQ
 9yig==
X-Gm-Message-State: AFuF++mAcnZZvNH9OKog7ZizZFtyjy+v/ATcJ4yxChcz5tK+DJKEIT0j
 U8o8bzyLgVytK25Ys091Mj5bHk5gNs53DaSva14izXIME1fPK9LnmRLL
X-Gm-Gg: AYBFou2GeOkdqWSiEaDGDGBTVQf+epYDcXW1tdzT/u4AbHt7ZdaiodlsAV4I2xqZoH3
 qGVujHnM8i+t8ECw3cFVWYFmFYWNa0YJTya8xv4n93CLmOP5q3TKpsmdHOKGOcuGQbJUenLJvO5
 4tbiwpZxLA+YEMA6Rnoc0KW934OIYpp/AmLYV31ljF1oH2Qo7b0eK5sloGilV+G+3sVSixY9tly
 8WpKw0f4Y+f7SbTrSnQnwi5CF6gmBO6nElqrg6Tt7YhRd9l7EIhpCXrOX9FYGwriPO4v2BOVpIA
 ogKw/aIsRklNXSOVXiKwqOInmd0m3LvlyqP8TWdhQYzl5smiR42/RWvFz1TW852MfjVRptiSxic
 9fcsj0YW7p4M+y5veG24SHLxENys7aG3Gxzkm80xEycNORuzbTieNbSJ6zr7Ymq0vVOHB1Hr7dT
 yX9y3OhA0HaGGF2VNwzFbhGknhAgn1OYXYesR++zzKKqNTqGefTzvmkEaRvEipooIyXnRb+S8aH
 4XsH6d1+dk=
X-Received: by 2002:adf:e19a:0:b0:487:35d:cb0f with SMTP id
 ffacd0b85a97d-4871e216fc4mr3566538f8f.14.1789737386045; 
 Fri, 18 Sep 2026 06:16:26 -0700 (PDT)
Received: from fra-x8664.wind3.hub ([151.16.209.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-487200829e1sm4487572f8f.34.2026.09.18.06.16.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 06:16:25 -0700 (PDT)
From: Francesco Magazzu <postadelmaga@gmail.com>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Dan Carpenter <error27@gmail.com>,
 Karol Herbst <kherbst@redhat.com>
Subject: [PATCH v3 3/4] drm/nouveau/device: don't use the pstate cursor after
 the loop
Date: Fri, 18 Sep 2026 15:16:19 +0200
Message-ID: <20260918131620.405133-4-postadelmaga@gmail.com>
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
Reviewed-by: Lyude Paul <lyude@redhat.com>
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

