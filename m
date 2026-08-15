Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37621C5DF6A
	for <dri-devel@archiver.kernel.org>; Sat, 15 Aug 2026 19:54:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70A4A10E5FE;
	Sat, 15 Aug 2026 19:54:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AJmWT0e/";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A630210E613
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 19:54:32 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4995df974b3so1084545e9.0
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 12:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786823671; x=1787428471; darn=lists.freedesktop.org;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LRzhc3yRX4X2M0pP9m+t3D39cWjJJWO0zjbMTBO7W2E=;
 b=AJmWT0e/X8gYukuiyWRCWhhhwj1HlHXqdFDaGuFZCC7gi+f1IjAAUKKpONgie04XZl
 SbPrn/f1RC0P/vc5pShPEkJwcpQtXVDvq5KQokojZNRUATXpYS++cpwFIUUUt2Phiz1G
 IvZMXsi/3UvSK0/mKUhwAcKcnxbs8Daek0Y6D7OmXAjOgQ3y4BrxIS8xy8ILJsPSzZif
 zI/Gj1xRRUccRc9tdPRZRRhNXneU490w6BiSyZQLiFMTzvs2Xs9HLvwKt7gSGrK1KmCs
 BxJDadQNTfWv4maKjtyfEvYMr8o9CQ8YZFaARSuOptcsUIkDP1qaCBDuqPfW31HmcDkx
 mVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786823671; x=1787428471;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LRzhc3yRX4X2M0pP9m+t3D39cWjJJWO0zjbMTBO7W2E=;
 b=J5/nM8Ne8JoYdO/p/jfofFzqFoLCsLMUf9zQq3g/kz0WhK1QqAgJDVE0Et69FCVZdA
 nX+tXigdLhZpbXLJHrJYoxhQUxoo0FhijBa2ZUZJ+KRNEKlcsswwgyA7kehJeMxNwdCU
 3W6VrpeAgq5Cp+PoEDHPeSS256bwoXvJuPURKMOCTlsVi7pwtOVcoHtW+27K+scYK1q0
 rZ1qAIJkDJu/GU8R0oZve7ugM7VFkC5vz2WC7VuRmC/fQeocKCA5IAfL2miGQxSCoG+s
 1T1LJFU6A0yijD72Gbpnp2ZLuihNidkpuoQ5WM4XN2lMRrGCIGfNiUhbnCESnXOCu7Va
 97cQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpI6zpjuDJIIgYemqgQwTBChUHBV+Y7tdPDLNPqDwDlonpPoWeS1fP8b9YJpGKCTH+jNIzGW3aoQRM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz/3IlP50wX+AbBdH+O4ie6Sc6fws8WWwXcN2n/RQlWmrH9/iai
 KWV7nm4ey3XO3ogtq5o24jJJOdTZaa6lQ8KWhP8653RX73PP2SqknmqK
X-Gm-Gg: AR+sD10WKOiKYvPcmZhSJHE7tYubqBCTqd38g+A3uKvKxWl8NLSew/vO70z400mloLW
 ep9YAqeHcYVaGCGoARGWvxXjHMxuJVxbhYr00g79jLw05yWxGzaxBmFH3Ug34rlRGhH8CyXHpOF
 7sKoLwJEU0xNcFRhrGUSSod8761t5uSC51QPPTAcZTduQiD7+xStqccz3qF6qnq8zyT04Se+M20
 5uriTZX5ypn/N7MHDO5eqoTgAuvIpm6G/fWWWHBmdhHiEiPat8d8q37PEWYPB79T1cPnswk0MMD
 UGK2wwgI23L8AJyfuF9Sclp/aW0PdsQ5UmlSVAibSMZa91SRxTIl/Rjschx+xKfYaZGOggH0NVO
 8rmL1BmyVJttkD4rpem3vcR4aqULITHgn1oKI3hMV3H2wLOUZXm1faIPKHKjX6apKddos13+4au
 pZgX2VhCL9JaR7riu38tOTEh7+FNXzLx5kzbtYACuxEIJSh9zrbYqrsdAMSLBCezEnNfM1zUBsr
 kfm7mIPn4BiyZkuQfL0BPmMmX11thgEoPJjbW4y4g==
X-Received: by 2002:a05:600c:1c05:b0:492:4a7a:e415 with SMTP id
 5b1f17b1804b1-4998795db2bmr142400025e9.2.1786823670870; 
 Sat, 15 Aug 2026 12:54:30 -0700 (PDT)
Received: from [127.0.0.1] (ip-109-193-028-127.um39.pools.vodafone-ip.de.
 [109.193.28.127]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499899bff2csm133743775e9.7.2026.08.15.12.54.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 12:54:30 -0700 (PDT)
From: Marek Czernohous <mczernohous@gmail.com>
To: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>,
 Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH 3/3] drm/nouveau: don't dereference outp before checking it in
 nouveau_dp_irq
Date: Sat, 15 Aug 2026 21:54:20 +0200
Message-ID: <178682366004.3748010.14933649768375463967@gmail.com>
X-Mailer: python-smtplib
In-Reply-To: <178682366001.3748010.7798811159846779765@gmail.com>
References: <178682366001.3748010.7798811159846779765@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
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

From: Marek Czernohous <marek@czernohous.de>

nouveau_dp_irq() looks the encoder up and dereferences it in the same
breath, five lines before testing it:

	struct nouveau_encoder *outp = find_encoder(connector, DCB_OUTPUT_DP);
	struct nouveau_drm *drm = nouveau_drm(outp->base.base.dev);
	...
	if (!outp)
		return;

find_encoder() walks the connector's possible encoders and returns NULL
when none of them matches the requested type, so the NULL test is not
decoration: it is the author saying this can happen. The initialiser
above it dereferences the same pointer regardless.

The NULL test predates the dereference. commit 773eb04d14a1
("drm/nouveau/disp: expose conn event class") turned nouveau_dp_irq()
into a work callback, and since the drm pointer was no longer passed in
as an argument it was recovered from the encoder in the declaration
block, which put the dereference above the existing test.

Move the drm lookup below the test. No functional change when outp is
non-NULL.

Fixes: 773eb04d14a1 ("drm/nouveau/disp: expose conn event class")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Marek Czernohous <marek@czernohous.de>
---
 drivers/gpu/drm/nouveau/nouveau_dp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dp.c b/drivers/gpu/drm/nouveau/nouveau_dp.c
index 55691ec44aba..738802358d85 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dp.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dp.c
@@ -486,7 +486,7 @@ nouveau_dp_irq(struct work_struct *work)
 		container_of(work, typeof(*nv_connector), irq_work);
 	struct drm_connector *connector = &nv_connector->base;
 	struct nouveau_encoder *outp = find_encoder(connector, DCB_OUTPUT_DP);
-	struct nouveau_drm *drm = nouveau_drm(outp->base.base.dev);
+	struct nouveau_drm *drm;
 	struct nv50_mstm *mstm;
 	u64 hpd = 0;
 	int ret;
@@ -494,6 +494,8 @@ nouveau_dp_irq(struct work_struct *work)
 	if (!outp)
 		return;
 
+	drm = nouveau_drm(outp->base.base.dev);
+
 	mstm = outp->dp.mstm;
 	NV_DEBUG(drm, "service %s\n", connector->name);
 
-- 
2.54.0

