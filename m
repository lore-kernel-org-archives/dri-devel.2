Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9331CA5FA7
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 08:23:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42AA510ED8A;
	Tue, 29 Sep 2026 08:23:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=trailofbits.com header.i=@trailofbits.com header.b="eAmmF7Br";
	dkim-atps=neutral
Received: from mail-dl2-f41.google.com (mail-dl2-f41.google.com
 [74.125.229.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CE7810E8EC
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 03:14:20 +0000 (UTC)
Received: by mail-dl2-f41.google.com with SMTP id
 a92af1059eb24-1474c6b7742so2140172c88.1
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 20:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trailofbits.com; s=google; t=1790651659; x=1791256459;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XEoH4g84gk9XFCZN7uYIcwGzkc00ec8qVmnXddCOcQw=;
 b=eAmmF7Brw7O1EoF1zaMqE2xuKtOnjODivzbpYZ2Jd0K876I8O+u4uex3GjhEXHRhHY
 0EgVzEjVFGni4uFDm477e6naN6vPGUwG1F2NAHY6T3R8gDDna+VfX1piSrwLEZ43oZ4g
 MmxyFYE/CJxHBNQVxIp8CLP6Wo2P847dXJW8H7Dpy1X//uJDuElI+HQzDtsFDL3zI71r
 nd1gUAZyl80UVnaHIca+fKjR8tu9/9FZLYitvL01VQBqszbW9hy+4456fUJRQc/pFYkh
 +7vghq6ZdMIbW4Wc/71pVJIQeq6RmCvEAwiQ0Qlr+QY+jel3sQP+KhCUjvANqPB8keW9
 UySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790651659; x=1791256459;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XEoH4g84gk9XFCZN7uYIcwGzkc00ec8qVmnXddCOcQw=;
 b=ObSCgEF1rsxIiTUF/41oibtSm7CwYDDsfsMXJaKEoOAwoZiSZpi1QZlcctuLK6X23p
 7sanbdxCaWjxGelJYjoLrWuwWRjyGUyH3LQlntkynOCkNRQIYcVCvbxJbww1AjTvRaNH
 mkMdv4Bypv8nMnDY+gFlZiCSAuM6AMYBajvY+9Pp21YaBNbOFdA5GnHz6PHN9SfdRXD+
 iDijMzwPtE6hdIAuHnYJQiwtzHCDdGcYpYRtYyWqEJ8L6nzgehALLoJHI/1UoLEFn7Cz
 KYr9G8c7hxKxaHztc9YgKqIxyWLQrXmePzG2jJqo4A2Dw8dx4CJweYm7c2ZXWoQ3C6Bv
 MMKg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx9snMaQnDBEToY5u5puRyBm4DTP5wA13Ku4eantGLp172prv4RSd7z2uAWeowZfYqT/cZs4wNifU8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kYtSo4OoArLNO1eGd1OqrTKv7SAnlZAr8FxbiiCDwKY5IW/gYU
 N85LPkbBTojZd8/CMW90ZhqODsZ7WazpokZlM1G0Y3AP+qyzKfUWT1IESTI+j6P8QW0=
X-Gm-Gg: AYBFou2kuHEScdp7VTdKK5grT2akPu31647o0WMLVMc3TIBbV8Lm9umkleDKEIBJdJm
 cTPfysMR0fum7btZm3Vl2Tev9wnA0tMXnPC4nGbE2AE8yc4uaD72AUBRI54zs2sRa3HDcaQnI0k
 80VEaRRKZ/Kk9IZqSjaStx4Ra3ilUfzoJwapCqmSZ3cPMCDhbZ4tMSzW9RPc2KOwSIszelQqfe6
 eK+KG+nZm+gkHMpdjq5xKuv8oJWdQt/fTcPUhRS12FRL7OQv/jNfw0EUlz0HXOU6wJSI/UzIpl3
 HTPfkb/AeOZ4JoGaMel1MXT9v0E50qacnVbTQrC8G2724JNKs8BVx4AdqnCajHT/SSsaExr1Ete
 Ca0+pCfRqS1O14HmYEexsG3X7DcmZWSlrDG+hwlF5mcp1y1zcgGFSdNWWggiRkYh8FGi+OhyQHD
 RiSILBqk9STJmFJTfud3cPN2Cc6+clWYOGpy21naJgdqRmG/rgmr5za6sWAhkI21PrA8XrnofKV
 WIdgZCAcnYCGpJBI+vuUzzWjdoyx0kzxq47qja7I8tzMFi9rtnwp7w5gv79Tqe0Mv6Ejvo=
X-Received: by 2002:a05:701b:42d1:10b0:143:4710:a84e with SMTP id
 a92af1059eb24-146cec4be1fmr12051694c88.15.1790651659361; 
 Mon, 28 Sep 2026 20:14:19 -0700 (PDT)
Received: from localhost.localdomain
 ([2603:8001:5f01:8bab:3481:cbb6:f339:9e4e])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14a719057e1sm7529563c88.2.2026.09.28.20.14.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 28 Sep 2026 20:14:18 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, Alex Hung <alex.hung@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Jerry Zuo <jerry.zuo@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <xinhui.pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Simona Vetter <simona@ffwll.ch>, Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 6.6.y] drm/amd/display: Check null pointers before using them
Date: Mon, 28 Sep 2026 23:14:14 -0400
Message-ID: <20260929031415.87382-1-artem@trailofbits.com>
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

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit 1ff12bcd7deaeed25efb5120433c6a45dd5504a8 ]

[WHAT & HOW]
These pointers are null checked previously in the same function,
indicating they might be null as reported by Coverity. As a result,
they need to be checked when used again.

This fixes 3 FORWARD_NULL issue reported by Coverity.

[ Backport to 6.6.y: kept the applicable dm_state and dc_link guards; the
  vulnerable acrtc loop shape is absent. ]

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and drm amd maintainers,

I am working through the small CVE backports still missing from 6.6.y.
This one addresses CVE-2024-49922. It prevents the applicable HDCP path
from dereferencing a NULL dc_link.

The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not in 6.6.y.
This fix also affects 6.1.y, which will need a separate backport; this
submission contains only the 6.6.y patch.
The target-specific adjustment is recorded in the bracketed note above.

Could you please queue it for 6.6.y?

CVE: CVE-2024-49922
Upstream: 1ff12bcd7deaeed25efb5120433c6a45dd5504a8

AI assistance: An LLM helped identify, adapt, and validate this backport; I
reviewed the resulting code and validation evidence.

Thanks,
Artem Dinaburg

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7c72caac7b4d71..702c9f5c3d006e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6630,6 +6630,9 @@ create_validate_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 	int requested_bpc = drm_state ? drm_state->max_requested_bpc : 8;
 	enum dc_status dc_result = DC_OK;
 
+	if (!dm_state)
+		return NULL;
+
 	do {
 		stream = create_stream_for_sink(aconnector, drm_mode,
 						dm_state, old_stream,
@@ -8859,9 +8862,13 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 
 			DRM_INFO("[HDCP_DM] hdcp_update_display enable_encryption = %x\n", enable_encryption);
 
-			hdcp_update_display(
-				adev->dm.hdcp_workqueue, aconnector->dc_link->link_index, aconnector,
-				new_con_state->hdcp_content_type, enable_encryption);
+			if (aconnector->dc_link)
+				hdcp_update_display(
+					adev->dm.hdcp_workqueue,
+					aconnector->dc_link->link_index,
+					aconnector,
+					new_con_state->hdcp_content_type,
+					enable_encryption);
 		}
 	}
 
-- 
2.39.5

