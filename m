Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7BF60A6F57
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 17:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gMR4thZQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33E9411267A;
	Thu, 19 Nov 2026 17:10:51 +0000 (UTC)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40E9211267A
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 17:10:45 +0000 (UTC)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3b167bc8e16so32268a91.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 09:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795108245; x=1795713045;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Wf/5Oq5mchrTyiDMKcWORLhQhELf6w7llq5mVEibG3E=;
 b=gMR4thZQAHOc9hNq56O7aoNFGVCcUmXtO4zb5txifHhviWfhZs895R0NS78CRCGQUk
 Aiad9uJtWPx0UcM7jnEkjb9lx20i6iw/IEnbXRHeJRIFUe3neUIlmEjZGs5vVn3JEsoS
 Rx7TTqoJakdpz79gBrP8ktrfwlCFZlj7qBj1epEwa0GF51uouM4SFJMqrhCpbkbZqwq6
 rzIWMActBn9n38oViS2fl1npnUEWaIz6Af05FKX/czp+Jldh9J35FSea0Ei8qVNumGcW
 jBGiieGBSkKft5Wmeu6jryRcNRwpTZfhh4yhYlgo/iYyqj9DHBGBQR3PqRYteSOIPpHj
 32Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795108245; x=1795713045;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Wf/5Oq5mchrTyiDMKcWORLhQhELf6w7llq5mVEibG3E=;
 b=VOMWXTBhAb598d+7OpBiIYL2xmzuRjUHc0hSPu5ZcPgGW1nQhdeCAASIbYi3m1C50G
 raNNGlWnnzf/FNIhzanGs1KgB+e51o5f5yA2j79It7xPsgOuTiBMzMtj2zNPxNzUZ7CL
 IaaAOs2Yhv38rYNgEkM1yXRj/4cHYkxBNqy4+LQBY1TVj0ieGA5jEzaCxHqEHaAIHRlT
 FypC1c/IxgsIreccaQgl9V+V+BvhJMrlZohPqf9LvVqbQngZVshLZYUfVUnERbwLXVVs
 6vcq9EQmKfdT45yQZR4TEGTizRoL6iLaqfgRFDG2p0Bd1gqiZZt4h/UECRZu3/UKG8Uu
 vKqA==
X-Gm-Message-State: APuU4Z9L8MuIRONu0KqNRU1zpREnRSmrOJ2U3PmGInUWhEs4z/XQVcMl
 9bfd7UAUXd52K6VxeHQu+5omY5dk3S5yqQJr0MLPgBMkubyDxgTCwohPowpf91uBIdXoP15NACF
 iFOxjncVQ2A==
X-Received: from pgfv9-n1.prod.google.com
 ([2002:a05:6a02:8749:10b0:cd8:5a84:95f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4d10:b0:3ac:a1c7:20fd
 with SMTP id 98e67ed59e1d1-3b41c7ac351mr40117a91.4.1795108244548; Thu, 19 Nov
 2026 09:10:44 -0800 (PST)
Date: Thu, 19 Nov 2026 09:10:41 -0800
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261119171041.1536322-1-irogers@google.com>
Subject: [PATCH] drm/tidss: Return drm_mode_status values from
 tidss_oldi_mode_valid()
From: Ian Rogers <irogers@google.com>
To: Jyri Sarha <jyri.sarha@iki.fi>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Elkin Cruz <elkin@google.com>,
 Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
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
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

tidss_oldi_mode_valid() has return type enum drm_mode_status, but
returns -EINVAL (-22) when the rounded serial clock differs by more
than 5% and 0 otherwise. When drm_mode_prune_invalid() logs rejected
modes via drm_get_mode_status_name(), status == -22 computes a
negative table index (-19) and triggers a WARN_ON().

Return MODE_CLOCK_RANGE and MODE_OK instead, matching
dispc_vp_mode_valid().

Found via Clang -Wimplicit-int-enum-cast on an x86_64 allyesconfig
build. Verified by building drivers/gpu/drm/tidss/tidss_oldi.o with
LLVM=1 W=1 (-Werror) and -Wimplicit-int-enum-cast, and with a
standalone C reproducer; not runtime-tested on TI DSS OLDI hardware.

Fixes: 86db652fc22f ("drm/tidss: Move OLDI mode validation to OLDI bridge mode_valid hook")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/gpu/drm/tidss/tidss_oldi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_oldi.c b/drivers/gpu/drm/tidss/tidss_oldi.c
index 62c9780f7855..3b5046628642 100644
--- a/drivers/gpu/drm/tidss/tidss_oldi.c
+++ b/drivers/gpu/drm/tidss/tidss_oldi.c
@@ -322,9 +322,9 @@ tidss_oldi_mode_valid(struct drm_bridge *bridge,
 	 * we use the same 5% check here.
 	 */
 	if (dispc_pclk_diff(mode->clock * 7 * 1000, round_clock) > 5)
-		return -EINVAL;
+		return MODE_CLOCK_RANGE;
 
-	return 0;
+	return MODE_OK;
 }
 
 static const struct drm_bridge_funcs tidss_oldi_bridge_funcs = {
-- 
2.56.1.708.g77570a6a1d-goog

