Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6227FF885E
	for <dri-devel@archiver.kernel.org>; Sun, 26 Apr 2026 08:22:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 525F910E196;
	Sun, 26 Apr 2026 08:22:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jo3ehBd0";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E9C610E196
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 08:22:55 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2ad21f437eeso59324945ad.0
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 01:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777191775; x=1777796575; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5X1fF5hQULGKVZ4Sp8pVMxUoUy4e3HU84f9TuloiPvw=;
 b=Jo3ehBd0qVyc35ekFOALUj03yxtAWQiPzNSpg194a4i7Du3ctPEMGuVb/QhH7WE+oJ
 rfTs5UZ6YtRWYg1x4N99MaVp2Jqd7COsS/tZjjf8HRlpGfg2QJmyKdzyB2fBdX0ly/5b
 y8wl+xenB97LI808+CX5qTP7uv4mZVrzOKEhvoE37IPim5FdhLMgMTOiDIFnGmqKaQFP
 O3m7UgEhfXe4neGnA2fFsXi4amyGcUR8XCtaIWr6aRlHZtXB1m6UsarD6+qLH5icLPsZ
 NHhlU6oPDQkE5s8ixOeWofZ7AER9fs8pnzExjmja2fqmEkMEWbXjmO0JuGLrKwCyzfCA
 JwIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777191775; x=1777796575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5X1fF5hQULGKVZ4Sp8pVMxUoUy4e3HU84f9TuloiPvw=;
 b=HgiDrSQDHfjY1CciabIGa8WszrN5F9QionIZGFgzP7gnu9RfbELgoDMZzz7WlQ5nat
 +qHt3XvZhPYDsKM8hH4WPs821A/srJ/oEyj9kFDflsstazIS9RLmHMq1MObRpr1jYAkG
 jFd42qTQR5iNXMpdmPPBTHpJlCvn53rukGVPQIaCZIAyLI9OTzaNK6nvs2u49hMggJar
 i3SkhpD3AScE7PVL13oOzt4lu16Zz+cMKPMRUUkL2cl/RgZ6Xq7RRXmVwWvyhsSTG18A
 l/+VNdM8UptfGDwsDtkgMKHLuw1bbEuiDYlbVIuKxBED+zkQIBheTVxnN2nuFjfyeM2t
 50cA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+JK6Bi9mVkkTZrUlhwZpeY5wuPb//SxTKabtgAkHT0JI5QtpVOLqC0YGionYgUlrl0F1oIDPUIDew=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyDQaS7KV+P/KCZiC5ufv+W+EUZmd7Ch0BOyOTmA9T4GdF5kPR2
 IEj+FzIDSYh1s1rl8EwnFLDKPlE8w9w/jav08OyG/GsvHuCk+lSb3IPi
X-Gm-Gg: AeBDieuxTF+9biCFJGyjtKdSR/PSNJhA5yqGSk8ikQ8LQ1xd+vMsBIOVAIVYjbiQaaA
 v2g3ONE/T84PHej6js1Gn808aB5XN4vgNII/a4JalGTobOeeI5+e9V+1EYOnG6o32jHArE9d4zm
 zz1W/rKC+YM1brrBKuYrY7LtWys4eVD4HX7CCmlwrcb/ylqWgejRMA9TupmetVCpCXdXxX6tlMw
 OYqTsKduQzohTope0wXI4J4p/+2CpMGPV8eM/CwNpnIC4ey26qSnytqvH4BP31NoelMAFBqZ5RZ
 srM6Fd5zMiYQwMT8vE5MqT9rtVt5pMfQWRO57bDnurtQO/HNZaaoCILLj/efAqxwsTp4zCFs+Q7
 vMVewKNo655ODRDDSkhrP5+dIKaj4uNolv+lHoQPB5OOv9954Oh6z6dsbilrelc+EJQfmJAtAHC
 VMOIUWG85rH4hU94cjCfRBvPnB/RUznMK/U1Q1DdD36ZtAYMaPkKoRrSGiW2w+4q1iOHTpoJYnI
 +lhCOmjbH+wrhc=
X-Received: by 2002:a17:903:bd0:b0:2b0:4f16:22f7 with SMTP id
 d9443c01a7336-2b5f9e8d873mr243196255ad.16.1777191774559; 
 Sun, 26 Apr 2026 01:22:54 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com
 ([106.51.164.157]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0dafcsm284770165ad.52.2026.04.26.01.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 01:22:54 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, dakr@kernel.org, aliceryhl@google.com,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, daniel.almeida@collabora.com, lina+kernel@asahilina.net,
 j@jananu.net, mkchauras@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: [PATCH V1 1/2] rust/drm: import ARef from sync crate
Date: Sun, 26 Apr 2026 13:52:33 +0530
Message-ID: <20260426082234.2026908-2-mkchauras@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260426082234.2026908-1-mkchauras@gmail.com>
References: <20260426082234.2026908-1-mkchauras@gmail.com>
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

ARef is defined in sync and is getting used from types causing the
build to fail.

Fix this by using ARef from sync crate.

Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
 rust/kernel/drm/gem/shmem.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/drm/gem/shmem.rs b/rust/kernel/drm/gem/shmem.rs
index d025fb035195..50aa57bf78ca 100644
--- a/rust/kernel/drm/gem/shmem.rs
+++ b/rust/kernel/drm/gem/shmem.rs
@@ -19,8 +19,8 @@
     },
     error::to_result,
     prelude::*,
+    sync::aref::ARef,
     types::{
-        ARef,
         Opaque, //
     }, //
 };
-- 
2.53.0

