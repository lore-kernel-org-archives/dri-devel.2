Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B12BC88E63
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:53:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D54F510E9C4;
	Sun, 13 Sep 2026 20:53:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PPwdjBBN";
	dkim-atps=neutral
Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com
 [74.125.229.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6EF310E9BE
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 20:13:14 +0000 (UTC)
Received: by mail-lf2-f12.google.com with SMTP id
 2adb3069b0e04-5b899413537so2364261e87.1
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 13:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789330393; x=1789935193; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aI63pWsfdSJI20sdD0vd+vtSvoq1goZ0P9ovwMMqD68=;
 b=PPwdjBBNdJZxtq9sMbIUklT9ViYmnw45aWtaPOfr1O8r5K2VJe9j5v5fwHRalE+TD2
 2LVBcXFMZHGeXWmNR6ffjLLfkG+ZJJWbS4vR6Rm+FXW7DSUTfbH4pAMlIq56/nVe9DA0
 c/iPk3Cpel5J2E677XQHSOdSmsanIdivs0TLy0lYqOhpC8rOcbBiNf98wqH2gwh+iO68
 T1mYrXZyYa6SRCntjOGk0/ZJQBQGXzCpYLijcLi3iKKzppM1+gOhlL+i9hEXng/bSXEA
 OOCH9rtUvepgX3hm5i+9hXgNSBOKmdVL2obdvb0C+qT/fKX6MHq5kjISB9kHtbUE86r+
 2jGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789330393; x=1789935193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aI63pWsfdSJI20sdD0vd+vtSvoq1goZ0P9ovwMMqD68=;
 b=BXZogH8diQxU9FFoKvX2XURtL36sdA331mb64RKSvP7gNpYw4Y6GvmEpPhOIC/NOB2
 2QxZ321FQyMfBoTijNxt0HmDE6gEggIvo3tg29+enibCsyBL8DZnPD7XP/8zOrQ6RXVJ
 pTT6BoOTWSqWQPleAWOdbEkpLSgzjCy6miBzWaEo080uKyHeCH3Gow3IRxrxna9aK4LB
 SQfn86R1N8HZJw+bx6ju88Ap9Bx3cxpcuAuMqGmPdqIgxo9TlX7QTPch8XdiRwmtBUiv
 OT7azALnckixEQt56TN51tOFM9c39DtSrN6WP1XQBr/VV6ZVpsIjvLQAOpIMtpZtPnnW
 DQiw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwIshVkpzqnVU53tiT10zyyXMticHSukx3gK2JlFvwEDXc82wDrNvGNaD6tihTpBxG7VZWN8e0UmFE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ngDkujfz19T9pKM2Maly/nU+XiACe9gdG+8xHsDjkBzYWFtalz
 f2J/nDjgfWFQaeX0631xVXV6geVvsCmtsRFzArimDip+8xmOZY9yFv0q
X-Gm-Gg: AYBFou3Zi5WtPgFdSixLuDE0YCa0JY23K4pxBVYmvyTBEgqvR8be/91p1Ba3nOpIkoE
 0iyFMg8kUiwu1qMZY202l9VWU4jvSIrHQiGfau7LkptyjF3iMoujmn+NSkZxBUaRRIgu6s/cCBm
 Ymw/1bQP7mVxF3TLXNtnODYN4BA/vhVUFfkUjP4ZE8AcIkgULZEpeH8Tju7Ix6m69jFpCpvb4+j
 576BAj+FBXdVL8kOpnG3Rd3MizcE6W04xxNheWpRPLkiaKuPWEPtpa5FQwMvmM/TXLjmstTw7Yv
 rtd+JdKis+8dfpxwb4t6SMmaAPTDO/C3Fa0xicIj4F5Tq7cqktVLqiwlVI1Cor1SJuyZIXjzAsk
 XdehMgmuXthGVc6eR6v7PZWZVEtuQmOA/CVIvYlN8R/t/emg3E65027ygbIfwmpK8mcP5oMNfPm
 LD2yZmws1RFS/9UekbjJTbWvHWjns0ZRc9BshwItrozBVBIJT2fn+3JAyv4MwUJPt8Ff9mIMjw+
 oitFv38+HOyfDxGjcLgwvg51EdfAjFpcSfHcyynDQAs
X-Received: by 2002:a05:6512:114b:b0:5b4:ac27:6bb8 with SMTP id
 2adb3069b0e04-5b8a0299d52mr3093358e87.12.1789330392669; 
 Sun, 13 Sep 2026 13:13:12 -0700 (PDT)
Received: from tallipc.shacknet.nu (91-157-240-22.elisa-laajakaista.fi.
 [91.157.240.22]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8a03a85cesm2003345e87.1.2026.09.13.13.13.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 13:13:12 -0700 (PDT)
From: Risto Pajula <or.pajula@gmail.com>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Risto Pajula <or.pajula@gmail.com>
Subject: [PATCH 1/2] drm/nouveau/fifo/gk104: fix legacy video engine context
 mappings
Date: Sun, 13 Sep 2026 23:12:24 +0300
Message-ID: <20260913201225.5975-2-or.pajula@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260913201225.5975-1-or.pajula@gmail.com>
References: <20260913201225.5975-1-or.pajula@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 13 Sep 2026 20:53:15 +0000
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

Commit 8ab849d6dd4c ("drm/nouveau/fifo: add new engine context handling")
made gk104_ectx_ctor() map engine contexts privileged by default.

On GK107, mapping the legacy MSVLD, MSPDEC and MSPPP video engine
contexts privileged causes FIFO PRIV_VIOLATION faults and kills the
channel during VDPAU decoding.

These engines require non-privileged engine context mappings. Keep
privileged mappings for the other engines, but clear the privileged
flag for the legacy video engines.

Fixes: 8ab849d6dd4c ("drm/nouveau/fifo: add new engine context handling")
Assisted-by: LLM
Signed-off-by: Risto Pajula <or.pajula@gmail.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c
index 5655eda52..bbeb33cd9 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c
@@ -180,6 +180,20 @@ gk104_ectx_ctor(struct nvkm_engn *engn, struct nvkm_vctx *vctx)
 	struct gf100_vmm_map_v0 args = { .priv = 1 };
 	int ret;
 
+	/*
+	 * Legacy video engines access their engine contexts through
+	 * non-privileged MMU requests.
+	 */
+	switch (engn->engine->subdev.type) {
+	case NVKM_ENGINE_MSPDEC:
+	case NVKM_ENGINE_MSPPP:
+	case NVKM_ENGINE_MSVLD:
+		args.priv = 0;
+		break;
+	default:
+		break;
+	}
+
 	ret = nvkm_vmm_get(vctx->vmm, 12, vctx->inst->size, &vctx->vma);
 	if (ret)
 		return ret;
-- 
2.47.3

