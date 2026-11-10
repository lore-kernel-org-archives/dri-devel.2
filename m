Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BEB606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 21:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0ix34q0C
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B58B10E398;
	Tue, 10 Nov 2026 21:53:43 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 580E410E3A3
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 21:53:37 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-497614c95f0so1358959f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 13:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794347616; x=1794952416; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AqrPq6DInPU+YVwPB2qO7zdIo9ZkitMttG/r01QX26E=;
 b=0ix34q0CxQA7lBlgq9uQnwX2qRfsu5j675qF+zpg82FtBBdn/+sQes/Rhqcv7Y4/3X
 Job8waKI4/IXr0TW9tcSwoaSrbX8qz2IEteWGydEmFeRsflC5cTL88AHbGDDw0YggLJr
 hgTc+uR+UcgQo7L44J8p3cgHnVzOm8/3I0HoQdm9dXayMCTDMhCZ8ZT4nc8maDicwJd1
 /pYushijvzlSw662V6LgmlovbzVoY5TGOwS110EV3jyCu346s5KQqbQ20SFjFpqxgAd0
 pRKAmGii0qfW9Mx7MOE+CaKmBK4ueomwSwjbVZFZtnGC9peAEIRKCGIwznv6hCasFBNc
 S06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794347616; x=1794952416;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AqrPq6DInPU+YVwPB2qO7zdIo9ZkitMttG/r01QX26E=;
 b=IsQIn0PkeBOkeWnWamK+uf6FkSQzm8aZ35UK6kxlThzVqxkD4rtsol8Rm9ZAVQkaTl
 cpAYkyXHcSR1mHnc3jAlZHE8qC+JGkQlDOhhIxWnL62d0ilrz01+T+2FLYXBflLsHbON
 qXTmKZYOdcIN7HgV09gXdB2rTVMb25orxQj+9ViPsGj3MTPEuQz/Cdog0QKUQqgsreQ0
 ZCuSp+jy/nPFFmSx1MFrD3cx5Va0LOah68HDyOdRYSYzSGiXubcni3B+CclLSqTR+BRT
 ImFLeRnpQCpL7rqr2Zdh4ETjqhHQ5kqd9x4G2Rw9oXD9h82AXrHJUhnAUEJ0oTePK/P4
 ka4A==
X-Forwarded-Encrypted: i=1;
 AL+hErHYvlFimpFegYfGOEXYQCaPys7rjQXnksShJwpxRtH7dn6kievMtcosoPmo+WfTnvr20XUnyk6u+fc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9k7jwPQuhaH2ZDIDSrymQGOXSRla5vi5ocDdlU/VJGTbvcbHiF
 I3nAev3Hgjevpx1eg8D0+2hoOgRTzUp5/bGRff7QpIwSzqmKv0X6DuKK
X-Gm-Gg: AYBFou1VQdSSS3qtGKlzesQ4ze6rEQ7KGrQAEg06Ir72gY60yVK0Kt/qXLn37x38jsK
 WwfFB1xgMopVfzX27CnQUWcd0jDZeIH93mfjI8OUzZMsTtV7CCKw+L63o54wtrqpzNTdeO/kzcJ
 K0iWHUjGKQa3nN9VymEnNqHFueyinrkJ2tjE8w5msE7JSzmx9lxzM1ExfR12+TOkbPSxpdYB048
 5z413eBt9KB+TqmkQEj+AWzwac27w6PK/JVmbjtyO+j+g5K58PMNc90ie4wMqDIcm1zGVrYYdX5
 mWnqdqgqa2n0z8f9XHDPOqOADKvBQzZruowbcrUc+bGP1VxKZq6u05/GLhsbihmlIU5/SJj6oDf
 sEo6ewVlxVDwi7ZM2++HDHzLOHX0gYZ5TYUowwAcowGvSjMsPx3yh0sCCBl1L7PXd7mfoC0N/QT
 2+hVuv/1o0ea+VlgB6ASB5wj0U2LbadeOv9gRPRLHv/KM9tatJ0H0NuxOU5HFGIAFWp4OlO1yWa
 Vza5f23F9Ze02S7ZStOF+jcZNl+6L1IoWY7LvN7onFSzSof5ye29W3rjWxLxh7oEIhyeJCm/bB3
 W380Df3LaD2snYZi0PX1xNpn03c=
X-Received: by 2002:a05:6000:2411:b0:48e:3647:c35d with SMTP id
 ffacd0b85a97d-499c7a24acfmr395628f8f.21.1794347615587; 
 Tue, 10 Nov 2026 13:53:35 -0800 (PST)
Received: from localhost ([5.83.201.131]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4984e26f8e3sm6377221f8f.1.2026.11.10.13.53.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 13:53:35 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Austin Zheng <austin.zheng@amd.com>, Jun Lei <jun.lei@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dillon Varone <Dillon.Varone@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: remove extra trailing semicolon from a
 couple of statements
Date: Tue, 10 Nov 2026 21:53:34 +0000
Message-ID: <20261110215334.947250-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There are a couple of statements that are terminated with ;; - fix this
by removing the extra redundant semicolon.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 .../dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c   | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c
index 71d14fb8c830..5dd22003f165 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c
@@ -328,7 +328,7 @@ void dcn6_ms_calculate_writeback_bandwidth(
 		}
 	}
 
-	DML_LOG_DEBUG_2D_ARRAY_DOUBLE(outputs->WriteBandwidth, display_cfg->num_planes, DML2_MAX_WRITEBACK);;
+	DML_LOG_DEBUG_2D_ARRAY_DOUBLE(outputs->WriteBandwidth, display_cfg->num_planes, DML2_MAX_WRITEBACK);
 	DML_LOG_FUNC_EXIT();
 }
 
@@ -4255,7 +4255,7 @@ enum dml2_status dml2_core_dcn6_funcs_validate_solution(struct dml2_core_instanc
 	enum dml2_status status = DML2_STATUS_OK;
 	struct dml2_core_calculate_ms_context *calc_ms_ctx = &core->scratch.mode_support_locals.calc_ms_ctx;
 	struct dml2_calculate_mcache_allocation_in_out *calc_mcache_allocation_params =
-			&core->scratch.mode_support_locals.calc_mcache_allocation_params;;
+			&core->scratch.mode_support_locals.calc_mcache_allocation_params;
 	struct dml2_core_internal_display_mode_lib *mode_lib = &core->clean_me_up.mode_lib;
 	unsigned int i;
 
-- 
2.55.0

