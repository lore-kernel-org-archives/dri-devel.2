Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89916606A320
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 04:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Znx8sRpk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F1AC10E2AB;
	Sun, 22 Nov 2026 04:53:42 +0000 (UTC)
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 422C510E2C4
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 04:53:25 +0000 (UTC)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-386a7af8b94so261875eec.0
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 20:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795323204; x=1795928004;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pPZfXzdtdV8nq8V6brmrCDHD0rHVJANG6b7lQmazwt0=;
 b=Znx8sRpk8TfPXFmy0HNZenZqx/zA9tljWlTpsnhMUdCpyf4Ktqd1JD0cv8ArxKTTL3
 RgcfADJfAfsY38jhU5Cl7mBNm9ZZvm74pjQ36BK3H3IHGqtX2sLJHpWx1m25cs48H7wj
 uAgQClzKSu9xK4umF2rn7nLcGBn4LdhQU9VsNQp6qAIQ3iZf0T2Xt8aWYpkI8BYGcbly
 zsl5wC+CJLYll/LeRgGIFyQZt35CF60wOojgx+OcmCkbuDHWx5Ya6YLQc4eUrtQup8I8
 XVPqnsYMFEaVPhU5wxFt8pLvo9kSaBJzb7yHQ0qkODz68WxUvT8l0fUL17OpwjwmRwG4
 IKkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795323204; x=1795928004;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pPZfXzdtdV8nq8V6brmrCDHD0rHVJANG6b7lQmazwt0=;
 b=cdl/ucNwiPP6yx/7HqPFVqSmjNmQMh8cBrpyUbyiHun4iKp55CKovrcbBvgwpJy3iT
 BPsUOsN7HAQ1Y8lRxjH+ahFfMvTucqdrKj4NecBLdY21JTTA/McPd8P9hHtjYMGKrXld
 J+lH9j359wyaroT/RoGrrhzxnAzq5aVEfdKUIB/Jt7oVyv6Ub2tVRLWpCSaUPqQ5vliY
 HNKaHlfaQeHH4akVPm17n8mC0I/eCH+0UJS0gCQSqkNn4CErqrkcyrklzKAI4Jz5+bs0
 qIgePCV+8BlhfxgeEk0k2VOOy34/8slm1AUFDy8lQzYCSQfzzTIAESrkz6yuigjfs1+N
 63mw==
X-Forwarded-Encrypted: i=1;
 AL+hErGB4qdqPYrzNrcQZHrRrZsyDvqWbBulcL3/fCte8FRomLTyvwrc0SJvrBMQk55wUgZnQeJjafNt3xs=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8he4ezOpOJfeok0bXhZrLbQG55/mwP3XNTtf8xqlpwli9Poxb0
 jgBQ9vN2H+jUEYHP0edy6PQt+iSqHUTk1L8w6ahSVVC9U2AKb9kV/CFECndI8QH60Sk/A+Zn5L1
 Smdy6xsX+IQ==
X-Received: from dycac15.prod.google.com
 ([2002:a05:7301:550f:b0:384:b800:2ab4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:1486:b0:383:6eb6:5730
 with SMTP id 5a478bee46e88-38570e24c0fmr9359658eec.32.1795323204068; Sat, 21
 Nov 2026 20:53:24 -0800 (PST)
Date: Sat, 21 Nov 2026 20:53:16 -0800
In-Reply-To: <20261122045319.18651-1-irogers@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261122045319.18651-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261122045319.18651-2-irogers@google.com>
Subject: [PATCH v2 1/2] drm/amdgpu: initialize r in amdgpu_vm_bo_update()
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

Commit bc566781845b ("drm/amdgpu: stop syncing PRT map operations") added
an 'else if (!bo)' branch in amdgpu_vm_bo_update() that does not assign
'r'. Because fpriv->prt_va has bo =3D=3D NULL and is updated on every comma=
nd
submission, userqueue validation, and KFD VM restore, calling
amdgpu_vm_bo_update(adev, fpriv->prt_va, false) when bo_va->invalids is
empty skips the mapping loop and returns uninitialized stack variable 'r'.

Set 'r =3D 0' in the 'else if (!bo)' branch.

Found via an x86_64 LLVM=3D1 (Clang 21.1.8) allyesconfig audit with
-Wconditional-uninitialized enabled; fix and changelog drafted with an AI
coding assistant. Build-tested under LLVM=3D1 W=3D1 (-Werror) and
-Wconditional-uninitialized; not runtime-tested on AMD GPU hardware.

Fixes: bc566781845b ("drm/amdgpu: stop syncing PRT map operations")
Signed-off-by: Ian Rogers <irogers@google.com>
---

Notes:
    v2:
      - Set 'r =3D 0;' in the 'else if (!bo)' branch instead of initializin=
g 'r'
        at declaration (Christian K=C3=B6nig).

 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c
index 82b9b2d5d0cf..d36ce2748f72 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1323,6 +1323,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, s=
truct amdgpu_bo_va *bo_va,
 		}
 	} else if (!bo) {
 		mem =3D NULL;
+		r =3D 0;
=20
 		/* PRT map operations don't need to sync to anything. */
=20
--=20
2.56.1.750.gf70dc682cf-goog

