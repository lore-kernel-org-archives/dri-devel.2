Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D085A606A881
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=urbMwI5H
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6118D1126A1;
	Fri, 13 Nov 2026 16:19:06 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6128710EC5F
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 16:18:51 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-c445c95d553so218628566b.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794586730; x=1795191530; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HR+1DPCwhbHFYST4j7neRHEcgr2daXj0B9N2zzcfMUo=;
 b=urbMwI5HRijGgA8JNY+PkhTKcoRN/t7BQSD9kPlJamQKzyZtbDNn/xTnGcnlwxUCM6
 vcxb/AR6SDXKo2+QD8z3Ly9wPMVelo9HngTAIPkeA65ZHW+qwex9TFh2M0bdGklymwa9
 NlZBQbXNLBhDErEcInqEXGDm2xOpAobzEab8KezUi9JaASyKSj6sSU2zSR7/FVVKZlZ9
 gbUcM+VtXf3BtOix7m55RRmjaJTULSjg8wJpnzB6sIE806Gou9eMv7oGumsWu3f/bHpG
 i/jyTRLyPQKpPgJQF9IPDaPf8BuAAv/aNabpVZeIPfNu7Sg3TXqqCpzDR8F/FoypNavg
 mMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794586730; x=1795191530;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HR+1DPCwhbHFYST4j7neRHEcgr2daXj0B9N2zzcfMUo=;
 b=PVlflbJHcO2vbSjtgC4cA4i7nnawD4plzyqIcZ88Pzan4EWDp0hOoX3vch5wpBI3Pi
 X6ThkkGRMNlP1LrolQb4jVaTU0A1eoOOUyGHVBzTf4oex51xamV26YyyCs9QJiBggnbZ
 qkGASjtySt04EQxL0UXiEr3772t9uPNV46F4Ddy9HvZslUnApqN/cMPU8OgQWCsB0ci4
 2a7DGtUexzefwPdFFUgfAMppcx6lAgpV5Yxb/76LMhvyP+scQsYx6mDAFol8w5DdWJof
 Z/qR779FCjPwHL97fNif5xKLU350MfX6xP07fPNECWKlmeA0d67lfS5VwYm8zrAEWrHv
 +NGg==
X-Forwarded-Encrypted: i=1;
 AL+hErH6hCHoWKIT+YgoxIkWP+tEveNe8SBNaEf53TS9yqOlzIC7dgaFiBKiEzphXHX2/5/ePXX0W6hiD6c=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+UNT1/zKv6C2cwdgJWjLnrRDBZskcPHykJeFbolqwebUDRw5Tm
 TLGHwRTpTJMe10KhoyqXij+Z1DSzmMK0R8n2RlPflVO7OwHudvrgpjNP
X-Gm-Gg: AYBFou3ncPSP4FxxsoGkoj89t9QOmpQedtwE1KQnxtiyh92ZA2+6EMydcLehxSTGFnm
 yzMc8HWR08MmO11I+2b0bRcu+HUzJ6SWtSlB1RUkZhI05617uBmfUrEnh+8RFe15zNMe04atc1b
 BbNGNhHm7DsLi9CRRTBIuRK/cwwLq9R5IYinZuDVyi9bQ6xqNloKIom2hmAcx6squVOtD4e4jL+
 EqHViAzh/bnmgwhVSqSf64m7HoeDci3wp6TaeQ2dP40sQhMb2bY+UbdlQcUEEFQcbAJKcL37+r/
 MlRuTUjt6toQ35AVaWrZaN2NxIufoW4dCE56sbR4fzoTc5Gb5PIRVtSJc8OS1DPknKMuptXmex9
 QQhdCCOxWnosYEQx2j+juLN9u0VQgKdbv/oN6iCc58eERicFx4kSeuqYx1YpyoCDBaaJK6SfpBP
 5EfdPYDDiTxIN9JR1N3CT5nMkuPGuuZkNFiMDDnJk5j78VwO62s31c3luuwQHda4NpL26nPrNEJ
 qHqk9yJEH1OeXmUP1zzbYTRVC0gGz+hvfm0buv+cMxas9m2BVMdT8xLB/94ie5q0m6ewLHZncdl
 gzfLyIDetjz5BE+RjBGIxVgAwr3/W8vaODab9UPKay1t/9X/6f7s2xtJ0a7nuyqOva1FGTjdSkJ
 YSc3wY2X/EA==
X-Received: by 2002:a17:907:2d1e:b0:c4d:28ba:f221 with SMTP id
 a640c23a62f3a-c50963d46dfmr252539966b.42.1794586729694; 
 Fri, 13 Nov 2026 08:18:49 -0800 (PST)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b24b88sm122297266b.16.2026.11.13.08.18.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 08:18:49 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Sowjanya Komatineni <skomatineni@nvidia.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Hans Verkuil <hverkuil+cisco@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Cong Nguyen <congnt264@gmail.com>,
 Faisal Mukhtar <mukhtarfaisal03@gmail.com>,
 Dan Carpenter <error27@gmail.com>, Hungyu Lin <dennylin0707@gmail.com>,
 Hao-Qun Huang <alvinhuang0603@gmail.com>, Yury Norov <ynorov@nvidia.com>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v1 05/10] media: tegra-video: vi: Use entity function to check
 subdev type
Date: Fri, 13 Nov 2026 18:18:14 +0200
Message-ID: <20261113161819.36847-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113161819.36847-1-clamor95@gmail.com>
References: <20261113161819.36847-1-clamor95@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The tegra_channel_get_remote_source_subdev() function relies on pad flags
to terminate the search for the initial sensor. This causes it to iterate
through devices that should be bypassed—for example, the pixel array (PA)
of the mt9m114, where the internal image signal processor (IFP) should be
the initial source instead. Switch to checking entity->function for a
sensor or ISP to terminate the search.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/media/platform/nvidia/tegra-video/vi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/nvidia/tegra-video/vi.c b/drivers/media/platform/nvidia/tegra-video/vi.c
index a96ef26af89eb..5c649e3162fe3 100644
--- a/drivers/media/platform/nvidia/tegra-video/vi.c
+++ b/drivers/media/platform/nvidia/tegra-video/vi.c
@@ -189,13 +189,12 @@ tegra_channel_get_remote_source_subdev(struct tegra_vi_channel *chan)
 
 	entity = &subdev->entity;
 
-	pad = &subdev->entity.pads[0];
-	while (!(pad->flags & MEDIA_PAD_FL_SOURCE)) {
+	while (entity->function != MEDIA_ENT_F_PROC_VIDEO_ISP &&
+	       entity->function != MEDIA_ENT_F_CAM_SENSOR) {
 		pad = media_entity_remote_source_pad_unique(entity);
 		if (!pad || !is_media_entity_v4l2_subdev(pad->entity))
 			break;
 		entity = pad->entity;
-		pad = &entity->pads[0];
 		subdev = media_entity_to_v4l2_subdev(entity);
 	}
 
-- 
2.53.0

