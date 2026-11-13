Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D39C606A881
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oH5wWr2r
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 061A41126A0;
	Fri, 13 Nov 2026 16:19:06 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A544610EC47
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 16:18:49 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-c40f29667e6so273645266b.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794586728; x=1795191528; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wB38b6je5TukLZG4QeKQmlwzA/Ycxh9nT5Bea008608=;
 b=oH5wWr2rlzFmb49SEjIW3azj3bDGWb3SLcEoT4N+whkY97sqLalsWx9uyC3SQiziwu
 n4s4UYkApXPS7/Fr0wjc5f/lQTY9qNUTVZC/gGE18cwz8XJL63adDPXhUY7XLSl0gFRk
 t7lJ+0XvxnDEVSUJUK9ziepqw192tpgzKsfNxU7IBJ8NLrWhsJ/ftcI1zZIg74a718Mu
 r7orSXoFsFn1IXPbCotrJ2Lnb3UD4wqHDBg0gqPhkg8MKZTUXInwLQZ7bV0qF/oWLfny
 IEz8KFOfHME1r8ukhdE6yAq5oL3mttIrN2qXu/kJyAkfrubVOQDUekCRrNh3lubHw/bD
 zKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794586728; x=1795191528;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wB38b6je5TukLZG4QeKQmlwzA/Ycxh9nT5Bea008608=;
 b=j3JV7AlcEt5WPvPILOL8PgDblPxyi8wQ4ZUZUy+61NXY3qpq/Xx2Fbnyne5+/oLDza
 j7GuMCyVG1KBLAdJxcBHIcUiv2A98EfzoYYOJ96Se43TqQwxk6G95XW/agouGBRNHiuf
 3l+O0nZZA626ZB6XrxmlyGC3s/KuTjYGXGY3wLxg9rhSQVEwo/NP+PDeFVl1im01avEi
 mmVSdwIF18T5CldfDYSsHhrwOPbJtsGKkUPdsmdIeX6ZIzHAxRU9GAHq0M4LqGE3Ftqw
 QugK3ldl308fud03XkR0GvxKr4klUgsbPOq1MwVhD6l3nxPXyORQO6BDLSSffdwREJDI
 Sibg==
X-Forwarded-Encrypted: i=1;
 AL+hErE5y41VMW3qgoCq+dg5boSdUGDoVQKMsO8xeQ43j31A/LcwCAQoADg5651G/7K6MzQsLTgxzjxZXaA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z97GmmpZ7NOWR/cd3oyhqDds2nlyhmG9D1a2aShEDyiGDulvocE
 994mOK9chbGDjfhiwHFGSkKMw/wgBzlsuiQ1dgtTodeoYfx1KvtiOWga
X-Gm-Gg: AYBFou3/1G8Pg+9cTZEXrxnNA03Om8W027NwbXaK2ZKxs5k8dAc9xYBoDdp4zMe04YL
 E40DXSnxOpjtjs2mMoY+rynaH/DDI69EpoVa4YCyoiC5f1GEVKnr2G4vMMXGJVjNi6hTkZq7WBu
 KeakyTRd+cET1J45ee8CNnKTX27DUS6xYs+yYsxdTPSm8Tny7n3WnHu2vdZiwGlmSlolq9YnsMa
 L0quUIEPOWcCCoFwZMMsE421DgTBSuFoNO7ajlmF2bWSAm/FdX/MtABy91LNdeRpMICv+pvgXU7
 vMmWFTsP9wc81fiUG4G45E5O4w+i/+SlZlHx/0tolMFnAyEe8A/wDQvDxV4C5R9MZOsGoRL2pHO
 1s8djUm16j7Ms/pt2/ZH7T4M/oY5joDp8+0epSh9x6oLTEAIgDmlLDHFsnKu9Hc7QZxvday2Pyj
 JZVw/O+8SNt2+dHG4QJzFIJU6bkdAJcy+PtyolAwGjDjaLzPLON9O6qGJzZDPsjlhnwTkX1CiyQ
 zXbXhN0YqikgcUvi+ia6OPEBRbexmb4HZBENdpxH7KrBExG/Zl+uTzzEmUgPRgsqeRrUqeMB0eA
 hkcFXS0TTk/HuLPxJ5vj5FwBgmQgUJlw9nFFI2w4PlMTS2WfVj1edoLq8h8hPIv/AS6coT4QaMD
 YZHWksVaIRA==
X-Received: by 2002:a17:907:c09:b0:c49:9231:5518 with SMTP id
 a640c23a62f3a-c50963d4f29mr272520066b.21.1794586727949; 
 Fri, 13 Nov 2026 08:18:47 -0800 (PST)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b24b88sm122297266b.16.2026.11.13.08.18.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 08:18:47 -0800 (PST)
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
Subject: [PATCH v1 04/10] media: tegra-video: vi: Switch to
 media_entity_remote_source_pad_unique() helper
Date: Fri, 13 Nov 2026 18:18:13 +0200
Message-ID: <20261113161819.36847-5-clamor95@gmail.com>
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

The tegra_channel_get_remote_source_subdev() helper walks up the chain
to the initial source. It blindly uses pad 0, assuming it will always be
the remote source pad. This may not be the case for more complex multipad
devices — for example, the mt9m114 camera sensor with a built-in IFP,
where the source pad is 1. Switch to
media_entity_remote_source_pad_unique() to specifically retrieve the
remote source pad.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/media/platform/nvidia/tegra-video/vi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/nvidia/tegra-video/vi.c b/drivers/media/platform/nvidia/tegra-video/vi.c
index 12eaa89304e84..a96ef26af89eb 100644
--- a/drivers/media/platform/nvidia/tegra-video/vi.c
+++ b/drivers/media/platform/nvidia/tegra-video/vi.c
@@ -187,9 +187,11 @@ tegra_channel_get_remote_source_subdev(struct tegra_vi_channel *chan)
 	if (!subdev)
 		return NULL;
 
+	entity = &subdev->entity;
+
 	pad = &subdev->entity.pads[0];
 	while (!(pad->flags & MEDIA_PAD_FL_SOURCE)) {
-		pad = media_pad_remote_pad_first(pad);
+		pad = media_entity_remote_source_pad_unique(entity);
 		if (!pad || !is_media_entity_v4l2_subdev(pad->entity))
 			break;
 		entity = pad->entity;
-- 
2.53.0

