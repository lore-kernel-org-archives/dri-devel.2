Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13ED4606A331
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 10:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JPNvVh4I
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DBCA112713;
	Fri, 30 Oct 2026 10:28:14 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28FEE112713
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 10:28:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0902043F98;
 Fri, 30 Oct 2026 10:28:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605B01F00A16;
 Fri, 30 Oct 2026 10:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793356084;
 bh=JWUMgHIC9UGBSIolOL6GZvlgSz5q9pcFRnOxAnmCYII=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=JPNvVh4Ih/ELqgxdbt6v3NVNaVs1vG0gq2S0vJetMR3B99MMA6c6s+inDSo1EPlzh
 d9GF7NtOIQI/dhET8QoPqiuvxii8vskFBPwGmdGZi7YwiAyPT2abmb/UOxLZAIpzSk
 Umtujd6f4nA0WDEFWyiAv2OBAO2/C5Uo6Cc/VOHsLsG4w9/irbnyQSMRSJiuGyAoKH
 qPtbqdwb8GVBGUiMYuR+5w5Fb1khlDk1hXhdyMpZUcMqyrqFTHAYzmCsHoHptPcgx3
 e8HKXOmU+OmWPEfWtqtAst0iCQCyDDWY7QkW49xos/Dbz6rzHZn4DqNWQJDQHkm8by
 v6+l2b2VOU3BQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 30 Oct 2026 11:27:37 +0100
Subject: [PATCH v7 05/16] drm/atomic: Use __GFP_ZERO instead of explicit
 memset in drm_atomic_get_connector_state()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-drm-reset-state-flag-v7-5-4e55eaeae683@kernel.org>
References: <20261030-drm-reset-state-flag-v7-0-4e55eaeae683@kernel.org>
In-Reply-To: <20261030-drm-reset-state-flag-v7-0-4e55eaeae683@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Louis Chauvet <louis.chauvet@bootlin.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>
Cc: Daniel Stone <daniels@collabora.com>, 
 Harry Wentland <harry.wentland@amd.com>, 
 Jocelyn Falempe <jfalempe@redhat.com>, 
 =?utf-8?q?Jonas_=C3=85dahl?= <jadahl@redhat.com>, 
 =?utf-8?q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>, 
 Sebastian Wick <sebastian.wick@redhat.com>, Simon Ser <contact@emersion.fr>, 
 Victoria Brekenfeld <victoria@system76.com>, 
 Xaver Hugl <xaver.hugl@kde.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1374; i=mripard@kernel.org;
 h=from:subject:message-id; bh=LZbtPHVlMICiFBeZpJ8LPAkCVdWnWToVa7ZsZD+t1oo=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlPCiXt1kp9mP5uppHHV9E5GrvXuzjoiP9/axli2ZP87
 svyB+tOdExlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJOLcyNqzx+9qYmyH93/zo
 Boe7C3JSqgLnflrtZecic3P/8Zk3Lpefmfri3cESAxE1yR9L55sk/GJsWPdu7qxmuRDPIidt7Y2
 rNaSDFtx9mzdjf+7m5Bj+2E/pHaHHFu89uOS/TfyhwBXNUUWVAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The drm_atomic_get_connector_state() function grows the connectors array
with krealloc_array() when the requested connector index exceeds the
current allocation, then zeroes the new entries with a separate memset()
call.

Since krealloc_array() supports the __GFP_ZERO flag to zero newly
allocated memory, the explicit memset() is unnecessary.

Pass __GFP_ZERO to krealloc_array() and drop the manual memset().

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Daniel Stone <daniels@collabora.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 43b58e9b25e4..80436adcfb7f 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -1391,12 +1391,9 @@ drm_atomic_get_connector_state(struct drm_atomic_commit *state,
 
 		c = krealloc_array(state->connectors, alloc,
-				   sizeof(*state->connectors), GFP_KERNEL);
+				   sizeof(*state->connectors), GFP_KERNEL | __GFP_ZERO);
 		if (!c)
 			return ERR_PTR(-ENOMEM);
 
 		state->connectors = c;
-		memset(&state->connectors[state->num_connector], 0,
-		       sizeof(*state->connectors) * (alloc - state->num_connector));
-
 		state->num_connector = alloc;
 	}

-- 
2.55.0

