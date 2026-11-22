Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B408A606A32A
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 04:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZvHnNDNP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E39C810E0BD;
	Sun, 22 Nov 2026 04:53:35 +0000 (UTC)
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32C9010E2E9
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 04:53:27 +0000 (UTC)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-386177b0516so6148291eec.1
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 20:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795323206; x=1795928006;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=R+8LakRjMdDQ9LrYjApbpVrM7y/vhgkxVS30t5HKZuE=;
 b=ZvHnNDNPNCOzZ+BNZBUr6KjmQLp4PBHwddJtzHvd1a/zXVdVNrODjqbuyHwAzkxZoK
 VcAAwKZpeHWpKsJMZ0gx9tt3KBsc6YYCQMUJvgRzUh6/66vJgkfc5//e1+r2GyOzcTkB
 W9lGJBrNAlrXJtS4bX8oqPhyskjlgsJieVlDDAmmlLsZH09CCnt1rNkzpHjTouGByqNY
 ZRABty+0JuGXueanP4n8Sg/R44NKQSYrof6iPMciEknWEr+23ClX3WkrrWDWl4dWD6/V
 M5W+E6bA370kKISiI59AvHvy7m00nAQ3Psr8qDJvWbrHjTrPEiGcCtjQ7B077Uaf71PL
 +N/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795323206; x=1795928006;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=R+8LakRjMdDQ9LrYjApbpVrM7y/vhgkxVS30t5HKZuE=;
 b=OobbETjFTdLr29rrnXc6HhKR0+qOT1Lqe7x6zzyS4aESczi5srtmiB4C0oCn+2nZ+X
 RDWoATz5/CKgmBxTyFvxXqjoU0wH3bHMjg/8fHys/DCxCvrs3Csk/XuOKwRuC8szUGQc
 qobMAkgy0PCKsuTO1UFDGjezUEhkCFbRF1VOT5QHmK3Ism8B4YyJCB8k1qXcnulwLm+I
 vpBvv12+Kr+ToWslVl0In4B8KzF6RKy04vixpBXkbNRoEZ4xzRrLj6GsKfCW8ohcgb0O
 WQhTQCoSQvIcM/KSabEvC1TALergf1q/mlqJ23e+m4vsWEPXVd3C1tMuWietYty/UHA0
 LK+g==
X-Forwarded-Encrypted: i=1;
 AL+hErFgDf7RoDwmVwkdosqjDc2rU1AIjr7Teo0BTjAtwuY2DB6WQ/RSua1HAxDKqf+VvTGyr04QdxXCQGs=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/f26mCzPn0h5lQsqbud46k57urx+IrHgxEsBFsFITpCGN0XyB5
 wR5MLtFBeRZ/a53qOkJ/EWSqoskVcAMhiCK3V+PRoeQ2W0M9Xo1rp7dCmpGPDARfAuNv8q7d7A2
 WOmQ2rvoPng==
X-Received: from dyvp7.prod.google.com ([2002:a05:693c:8847:b0:386:9ad3:91d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:fd06:b0:369:f05d:6c5c
 with SMTP id 5a478bee46e88-3856f549471mr8286070eec.28.1795323206053; Sat, 21
 Nov 2026 20:53:26 -0800 (PST)
Date: Sat, 21 Nov 2026 20:53:17 -0800
In-Reply-To: <20261122045319.18651-1-irogers@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261122045319.18651-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261122045319.18651-3-irogers@google.com>
Subject: [PATCH v2 2/2] drm/amdgpu: initialize r in amdgpu_ttm_clear_buffer()
From: Ian Rogers <irogers@google.com>
To: Alex Deucher <alexander.deucher@amd.com>, 
 "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 Elkin Cruz <elkin@google.com>, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In amdgpu_ttm_clear_buffer(), 'r' is declared uninitialized. When
consider_clear_status is true (such as AMDGPU_GEM_CREATE_VRAM_CLEARED
allocations) and all backing buddy blocks already have DRM_BUDDY_CLEARED
set, every iteration of the cursor loop hits 'continue' without assigning
'r', returning uninitialized stack memory to amdgpu_bo_create().

Set 'r =3D 0' after the cursor loop directly before the 'error:' label.

Found via an x86_64 LLVM=3D1 (Clang 21.1.8) allyesconfig audit with
-Wconditional-uninitialized enabled; fix and changelog drafted with an AI
coding assistant. Build-tested under LLVM=3D1 W=3D1 (-Werror) and
-Wconditional-uninitialized; not runtime-tested on AMD GPU hardware.

Fixes: 23bd7e67961e ("drm/amdgpu: get rid of amdgpu_ttm_clear_buffer")
Signed-off-by: Ian Rogers <irogers@google.com>
---

Notes:
    v2:
      - Set 'r =3D 0;' directly before the 'error:' label instead of
        initializing 'r' at declaration (Christian K=C3=B6nig).

 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c
index 0f86777250fc..693f25285f2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2711,6 +2711,8 @@ int amdgpu_ttm_clear_buffer(struct amdgpu_ttm_buffer_=
entity *entity,
=20
 		amdgpu_res_next(&dst, cur_size);
 	}
+	r =3D 0;
+
 error:
 	mutex_unlock(&entity->lock);
 	*out_fence =3D fence;
--=20
2.56.1.750.gf70dc682cf-goog

