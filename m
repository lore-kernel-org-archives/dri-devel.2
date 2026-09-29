Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 174F9C9832A
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 08:22:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D85F610ED71;
	Tue, 29 Sep 2026 08:22:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=trailofbits.com header.i=@trailofbits.com header.b="VOdijnhC";
	dkim-atps=neutral
Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com
 [74.125.229.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14FD710EC69
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 03:09:41 +0000 (UTC)
Received: by mail-dy2-f41.google.com with SMTP id
 5a478bee46e88-34b590a5b5eso156264eec.2
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 20:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trailofbits.com; s=google; t=1790651380; x=1791256180;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ovbpo2QnHvH7arny/3o7azxV9+me2emF/sy5+OVOXY4=;
 b=VOdijnhCVDH0h0lmQYCmD+SN2njGXJUt5fU12ENfBS7Aq3Ric6EhbY2QGwZbbvqtoi
 Ofz6NmcnWTRifWGiyMWkTe2pK2bhl8zURabdjfZn0eE78/7S1bwZR4jf7uJH+Tp31gZf
 n5prL2hiAvk0X0XSBKL+GuP5LRAOVnsw1hz9jyoBXh2wVw+7NEGaPqxCp46C/OJeiiKQ
 QxbUX9NoPSbuZjx8hdinElYlnw8Ta9rEjj73xSAZt+nStCqUiUy7sA36+gmd4ElsswbR
 s76+neYuuiY9PHV6KOYv5aPZIt4eMzhcayBb0mZKNpuL2LC3jRE7hQRNiJccXAUOxPbC
 UPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790651380; x=1791256180;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ovbpo2QnHvH7arny/3o7azxV9+me2emF/sy5+OVOXY4=;
 b=V+H0y3OVOQncLT7T0mR+qKjJ1F7GPrpIfbNcUpqHguF05FYEmjeHxEkJoo2ydvGdfu
 UUeK9lTIqKlikUqrQtSw2pJEGee04UF0IpZASsXJJ6X1SvG+XG18+KIJBHQMxMQPeJKQ
 95X+mHZ3bwlBnPbrpcPG/Mz2z4sN+9dsqWuXHs1o0dowGjG9PEmLukEJlRsa1q+Q6OCr
 1ci4YPAg7S94wHeAnB+kY6e2zcO6eWiUjxwHWO7hGWz9Yig13ByT8i8aFze4fAjgs+sX
 9XIIvtv4lsLF7O4If/jxiXJE6S9CUz9p8HwEiPSiwTmqZJnvHi/DOHxBYjpkQg5LF26/
 npfA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz78XKDKjSzU5qqqNxSWDCB2T0URMqOKczZsyHqJSo/LKb3bRJ7v91WzoKPQrO5MWly/KVv60YZEyU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJWFiNUmJy9fU85xd7+fWSbozLuSa8m5fnM0TdNKjSv8xZjf9Xl
 uN9TLPcDVWBJjQRMxrMpf4dJEZTxkrtAaCdLg2rYsM+uep52YlMnTkvFy4cVs1aVyZY=
X-Gm-Gg: AYBFou1AG0x9u1YbwRCxObn94kLjCOsy4oqzBHz4uqOGh31NGYWjwXJ/ZyaZWURk+/i
 HDCJ80pLVPzor48sUPP4C2zOc87Ym99ihuncZNHR4ETzp8M7GqV2LQkL5XH1SfNA7C1ZtVM/SRA
 c8yrU73hW+RErWy307SLFjKMmT2lGATbRteohboVMF7kzz8/QtgCCykyyMom9ASvMETo05EcERt
 9BmRCVXqwpUZW+quhvzEWMer3E+vxWeDd8SmiEdH/jvScHnoQ96KEo64E4qbODuj6Y18VQKVGKx
 4Bu7BDvDkZzMiFyGE0H8ZZ8nhIogGQ/fYdngaWtZNqpINYuPUpdPxrO8gnP9fMWjedSWguvbLVw
 3UHZTpra38xN67R8CbskDs/VNWattGtnhu8hmqbdBtSBCA988bU0FLy5AOPzK7ucD7ZSkkUlBbW
 5a3J6H7Dg8AuPiFB/mCFcI6JwWbOi9XPjXJXllfADL/CQPsIha10Tz3xn+FnjtjU5by9X297wVU
 CuMBZ9q48ttPq6EEwS5KExm8eUqYRu3Jc+EEAxd4Sqgi6R+PiZOcEim5RZ8QxtYxVP1XJRD5+Pb
 l8P4Mg==
X-Received: by 2002:a05:693c:8955:20b0:341:225b:d6f with SMTP id
 5a478bee46e88-34739c07f1emr6241228eec.19.1790651380153; 
 Mon, 28 Sep 2026 20:09:40 -0700 (PDT)
Received: from localhost.localdomain
 ([2603:8001:5f01:8bab:3481:cbb6:f339:9e4e])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34b580fc50asm927881eec.14.2026.09.28.20.09.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 28 Sep 2026 20:09:39 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, Allen Pan <allen.pan@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Charlene Liu <charlene.liu@amd.com>, Alex Hung <alex.hung@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <xinhui.pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Simona Vetter <simona@ffwll.ch>, Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 6.6.y] drm/amd/display: Add a dc_state NULL check in
 dc_state_release
Date: Mon, 28 Sep 2026 23:09:34 -0400
Message-ID: <20260929030936.86941-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 29 Sep 2026 08:22:37 +0000
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

From: Allen Pan <allen.pan@amd.com>

[ Upstream commit 334b56cea5d9df5989be6cf1a5898114fa70ad98 ]

[How]
Check wheather state is NULL before releasing it.

[ Backport to 6.6.y: implemented the same guard in older
  dc_release_state() in dc.c rather than dc_state_release() in
  dc_state.c. ]

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Allen Pan <allen.pan@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and drm amd maintainers,

I am working through the small CVE backports still missing from 6.6.y.
This one addresses CVE-2024-26948. It adds upstream's NULL guard to the
older display-state release helper.

The helper is used by display-state cleanup paths and currently
dereferences its argument unconditionally. The patch makes the helper
NULL-safe.

The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not in 6.6.y.
This fix also affects 6.1.y, which will need a separate backport; this
submission contains only the 6.6.y patch.
The target-specific adjustment is recorded in the bracketed note above.

Could you please queue it for 6.6.y?

CVE: CVE-2024-26948
Upstream: 334b56cea5d9df5989be6cf1a5898114fa70ad98

AI assistance: An LLM helped identify, adapt, and validate this backport; I
reviewed the resulting code and validation evidence.

Thanks,
Artem Dinaburg

 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index bea18f450ac9c7..6ba67a20eb4846 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2302,7 +2302,8 @@ static void dc_state_free(struct kref *kref)
 
 void dc_release_state(struct dc_state *context)
 {
-	kref_put(&context->refcount, dc_state_free);
+	if (context != NULL)
+		kref_put(&context->refcount, dc_state_free);
 }
 
 bool dc_set_generic_gpio_for_stereo(bool enable,
-- 
2.39.5
