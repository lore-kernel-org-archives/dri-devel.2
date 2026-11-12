Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F9E60A2629
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 07:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=jFfhr5N5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C987E10EB48;
	Thu, 12 Nov 2026 07:48:46 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C3A810EB41
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 07:48:38 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-492f0a1b685so2687000f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 23:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794469716; x=1795074516;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Uvsa9AIYlCvfW8qBBGgVckSPRj6pPv6x4O9rD7qooSU=;
 b=jFfhr5N5+aqMlx8PHSfRZdDP9K+RQfXCK+LOs2K9ezgaAxE0BN0HM5MiiD7FDUSUXr
 vqlSgSCxa9R/fyKI8Eru5p4sq6KWGrtJ2UfwGKkf6SSh03KJqDGwaNQ9Ji8tIeVf3LHe
 SoiG2JsfOlWAPq8Av7pIUAs2KrB13S7PSvT4xEjN7Zv+6tg9Sq1YlahjowOm4igrdir1
 02cSVlLbxaa1riAefwlpTU4ZuiswUFp5CHOFPUmCkHfcRR10w5gjL5Iz+lM0LYO/6ERW
 8tLF/5UvzJprXfdl7Ullkxf6eEnqspaXT55U74j1dsv1bo6P7bSInxikuSAwpxevvKYB
 QDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794469716; x=1795074516;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Uvsa9AIYlCvfW8qBBGgVckSPRj6pPv6x4O9rD7qooSU=;
 b=sGCT8dMsgHbka+WZYUCR2k4GFRn7HXETXtfg0n2xFAAzW+xfUZVqUft5KgYqRAHxy9
 MFcI5WpDOdJOVjMd0GdIQBbmkEa2lYWGKMzKwMwbczzpANHWOhA4ot/e5+fxHlfPO9gD
 oIxHDK4gs86hx26aYUrPP7OnzA27UeW8bLj+rSv4wQhOw2+ayv6x8Dy9k/Mw36sPm7qN
 7V4tk5zoXe4z9TDVS198KjJq+ogU7IrikUY8y7fuH+zn4NP4s+MAsNCHxo9UZh4jZ8EX
 h2gEg8TcZ/Em+TBhql3E1H3FYTGxvfOWnmLVMK5EhJ4qfqIfRhO5hvQlxQCAT+RC7zwf
 b4/w==
X-Forwarded-Encrypted: i=1;
 AL+hErEp7+NwSFQAY33yMMv8ebRxpwSsXStbGJAFb2lc5xPIJWRnufxI0NQsapz86OT4WM0//Z/xdzE0Gzc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+fX/xgbRzZPaHAEcUXwpRuRDyqxi2BWvJwmNFRk8Vb+RAzyovg
 /tZPsKFy0OikV8PbaqhBMVCabe83RiLEHpWi4wrJN81Crgr5Hm2Yv/Kth3IubHAEjRE=
X-Gm-Gg: AYBFou2+m70TDfk39czkj9oWPO8pH9JNVgp2Jq8csMMvK6QDU7NgQC/TzD/++mW9gYC
 37ouZ7d8aSe9vUoouf6mTZEfZEHGrbaAogYvBo8fD+/hEsYTqljEdH63PMlHxLuYYJxpIyPbvYc
 Rk+8Zx55HPGXovsmYM/AsKVoD8JpoMrSha1aYIaerHPR4aC5uB12Fpt8fVp+SHyFa2w7C/5oB0w
 R55x8DPo8/FAn9B8TomkLuGjSy0aamnN587vX+Zp+FdMm54lHYvJY/p6jxalBGoTzLP1bM/k/k3
 5oAM5WrHvaoHM/5L014uuwxGCJJSWyxKko1ZgPpmWSskHste9DHKdCKekdr+0Z9+z1PyXVhKt0G
 yGMXRZkURacJB1lNV4SmXX2UAWHlS4YxA7sf6Jn+J8pp6AJLvz50/NDbe5zOLdztaBJ1uJEFJj9
 UnaCsElVrQ5/NFmVAJj5DqlqngnuLC/KAFM7kugIJVIHhbweoESzeCzXFSgNcrzrlTeoMWPclDH
 gyIHp590FtWExA8hqCF6fOQPzbe/oMsteVusfzn3CcncnVzvdTKb5diz6N7qEe5MVyYrLfaZkUQ
 maJZWAbMem+XZ/W5KMg8Dl4R5No2/Fni8Q==
X-Received: by 2002:a05:6000:5c5:b0:491:4e13:fdd7 with SMTP id
 ffacd0b85a97d-499c38bcc87mr7988974f8f.6.1794469716567; 
 Wed, 11 Nov 2026 23:48:36 -0800 (PST)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-4983585923bsm15630479f8f.11.2026.11.11.23.48.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 23:48:36 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 =?utf-8?q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2 1/3] drm/amdgpu: Drop unused include of <drm/drm_pciids.h>
Date: Thu, 12 Nov 2026 08:48:17 +0100
Message-ID: <cbb2644e5ab7335a805c21c9ad1e69f8d1c3ab34.1794469153.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.56.0.rc1
In-Reply-To: <cover.1794469153.git.u.kleine-koenig@baylibre.com>
References: <cover.1794469153.git.u.kleine-koenig@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=767;
 i=u.kleine-koenig@baylibre.com; h=from:subject:message-id;
 bh=AVSQJY4FGgrv4LZdFN4/wjw+AUvlP8d3u1DX2nA8mgo=;
 b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBq9W9EwS9wXQTmNnzPiUUG7IQgXSBblmAxwYJID
 oLKMH6fLnCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCavVvRAAKCRCPgPtYfRL+
 TsqeCAC4zdauy47m+/QGPbLSssiOOJP6Py42W2zhmniUuGp1ZN0w02nvVGxhFR7LK0MlimqxZRP
 l3oNxGKd7IgC42St82Xdv8eZK0mbJeoxCeMGmSL+BcuQeAT1o4AGdh9nWxoKvgJsnbNsudYiRgn
 cz2znrytUZ+K1jqp8WMByAnTxEhpANYPBE2UgVBMQQgnXVT/0J559+OUwhRGnCm6vZXM3bsesip
 4FMLn67M7bIcgvMvYoxH2/GKL8M0HQNNiaiYaJRXYygFxkgj8FxYUXyCCXGt7Nwg6GuVfIQ+cgV
 GaKV5c9Bzr4D+8l9f6LYxHwmkilZAYWUqOeb3ajuKQ+KOzSq
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp;
 fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The <drm/drm_pciids.h> header only defines radeon_PCI_IDS which isn't
used in the amdgpu driver. So drop the useless include statement.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 72b371046282..78c255bb179a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -28,7 +28,6 @@
 #include <drm/drm_fbdev_ttm.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_managed.h>
-#include <drm/drm_pciids.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_vblank.h>
 
-- 
2.56.0.rc1

