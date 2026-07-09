Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF61C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 11:59:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E472C10F538;
	Thu,  9 Jul 2026 11:59:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=robert.mader@collabora.com header.b="L3h9bteP";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E146710F538
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 11:59:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1783598358; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=DIcbuPLOUYOkxREn9/zoLZkeAnDAsONc7AxOppJkocR6gp49k5S+jxM/+kHmUvjNb7QYa6x//zAKFJgtEctvFw+iZxUmNjcNjqbYdN7UE3ez+f1XWZCU3NCIxftFvrr9Y4V4N2R0fNm9f15jquSIKRftdsDHcimkMQv6NfqN0VU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1783598358;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=qP910scTvuI9bqM8CnMasb2NwIXit9WQiNkQTP8J+hE=; 
 b=oLkpTnWvxwBjENVw2DzlkwyTIHf08knl1fyaWrCMHT4ffYwr0DVoskk/dWKKhr4hWTiVvk4K5deG0EdS2wVV6ZHZzRXzgQXAy6s4qWCi3IJwyMzguXGxbkePnz0KjCAcWQHsl6Jv7VqIusckv2gu2v/UZ9PoV6bI88aIicKefRY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=robert.mader@collabora.com;
 dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783598358; 
 s=zohomail; d=collabora.com; i=robert.mader@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=qP910scTvuI9bqM8CnMasb2NwIXit9WQiNkQTP8J+hE=;
 b=L3h9btePLFTVWKpGEPjudc6vjEeM78VtCXbJZ4dBsZAi4SJLFDA1mfVadqzSBXuc
 orR4/B+dxfWE5YTBkBmlKbtbA79kGqngyPz0ua77tYAjIqxeDusbBgB4CidWbK2tFER
 CYN+D/YxxNLklWhNXbSCBsNHvcDnK0/lbC2GUJVQ=
Received: by mx.zohomail.com with SMTPS id 1783598357143147.79055774166602;
 Thu, 9 Jul 2026 04:59:17 -0700 (PDT)
From: Robert Mader <robert.mader@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: Maxime Ripard <mripard@kernel.org>, Daniel Stone <daniels@collabora.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Jonas=20=C3=85dahl?= <jadahl@redhat.com>,
 =?UTF-8?q?Michel=20D=C3=A4nzer?= <mdaenzer@redhat.com>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Sebastian Wick <sebastian.wick@redhat.com>,
 Simon Ser <contact@emersion.fr>,
 Victoria Brekenfeld <victoria@system76.com>,
 Xaver Hugl <xaver.hugl@kde.org>, Robert Mader <robert.mader@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v1] drm/atomic: Clear plane pipeline for legacy clients
Date: Thu,  9 Jul 2026 13:58:55 +0200
Message-ID: <20260709115855.53725-1-robert.mader@collabora.com>
X-Mailer: git-send-email 2.55.0
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

Clients that do not enable DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE and try to
apply a new plane state currently have no way to unset/reset an existing
non-bypass color pipeline, resulting in unexpected behavior.

As we can be sure that such clients do not expect plane pipelines to be
set, let's reset the later for them, ensuring clean bypass-only pipeline
states.

This is a less comprehensive but more backward compatible approach compared
to a DRM_MODE_ATOMIC_RESET flag (link) that is currently being discussed.
Considering the simplicity and clearly defined behavior of this case,
this change could serve as an additional stop-gap solution to smoothen the
transition to the new APIs, resulting in less breakage on systems with
existing clients.

Link: https://lore.kernel.org/all/CAFZQkGzw2MZGivy=oyYgZE3_dmxu-z-NbDgzh9uyqSsj=MG=2w@mail.gmail.com/

Signed-off-by: Robert Mader <robert.mader@collabora.com>

---

If an approach like this was previously rejected or clearly goes against
API rules (or is unacceptable for other reason), please excuse me (and
just let me know).

The main motivation for the patch came up during testing the Weston
implementation (link) for the fixed-matrix color-ops. The test there checks
both the color pipeline and legacy property ways of offloading YCbCr
buffers and the current reset-less situation results in the legacy one
failing once the color pipeline test ran before.

Link: https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/2133
---
 drivers/gpu/drm/drm_atomic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 735ab7badc2e..581fde90dbd8 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -656,6 +656,9 @@ drm_atomic_get_plane_state(struct drm_atomic_commit *state,
 	state->planes[index].new_state = plane_state;
 	plane_state->state = state;
 
+	if (!state->plane_color_pipeline)
+		plane_state->color_pipeline = NULL;
+
 	drm_dbg_atomic(plane->dev, "Added [PLANE:%d:%s] %p state to %p\n",
 		       plane->base.id, plane->name, plane_state, state);
 
-- 
2.55.0

