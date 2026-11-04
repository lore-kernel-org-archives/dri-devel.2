Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0B7606A331
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 10:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=VxKD2Pgz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A88110FB01;
	Wed,  4 Nov 2026 10:31:30 +0000 (UTC)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80A3310FAF0;
 Wed,  4 Nov 2026 10:31:22 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jKMDS6dQjz8vml;
 Wed, 04 Nov 2026 11:31:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1793788281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kt4A2moSSMHBdVYG/DfUXk+E7oSRQu7Jl+4l68B7FGs=;
 b=VxKD2PgzivlYhIvazn2lqcbaV/nSI4lvCBbJrruMLAyiW9pDN34UFUKMZRFGgQybED7Uyz
 DL3GUw4ktO3boWJuoO8XdAHU4UaZxNi3vdd/2bqxxlvbzfGRPt62ZO+0si2CHcmvRiNMhx
 T4VZI3sA1mCU3/2UC6FQazVh6qm10wLPu6Jq+NNhuv+Gli3Th7l4vxNpEXBCJHLK5Fm+1t
 c/ZARmegzkxA34SJav8verEJzUgUJ8Z64X4PePsPEldXOI+rBAlte5MbxlZbjtzpYfA09A
 V65gochFBJFIXGF8oFOkJF6sHEitrtDz+YJY6HvlBHcOx75SxX54fjwioJvNpg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates
 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=hugo@hsal.es
From: Hugo Sales <hugo@hsal.es>
To: harry.wentland@amd.com, siqueira@igalia.com, amd-gfx@lists.freedesktop.org,
 sunpeng.li@amd.com, alexander.deucher@amd.com
Cc: Hugo Sales <hugo@hsal.es>, mario.limonciello@amd.com,
 christian.koenig@amd.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, simona@ffwll.ch, alex.hung@amd.com,
 airlied@gmail.com
Subject: [PATCH RFC 3/3] drm/amd/display: Warn about an invalid ATIF backlight
 signal range
Date: Wed,  4 Nov 2026 10:31:12 +0000
Message-ID: <20261104-backlight-curve-validate-v1-3-10c688880e85@hsal.es>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104-backlight-curve-validate-v1-0-10c688880e85@hsal.es>
References: <20261104-backlight-curve-validate-v1-0-10c688880e85@hsal.es>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1536; i=hugo@hsal.es;
 h=from:subject:message-id; bh=qvMO4nsj48351hz80XkDZ1i6fw6G7SXA7BRR+oQTCIE=;
 b=owJ4nJvAy8zAJVbLU7f+5A3TBYyn1ZIYsl5zFrRei54Q/JfPNamlNPa6o5r3hn1SZ6XctKWXK
 GkYHtzMqNJRysIgxsUgK6bIonvDk4Fl4uSZOUXPl8DMYWUCGcLAxSkAE3m+h+GfcvKb7faWL0/4
 rugpzTHt5+qcsPr0265Ce8HdwXdKUlTUGBnuC0V2NbgLCd3fnCHzSv/voo4tj+M+KXgs/9I4MbV
 O5QEzAPh2SB8=
X-Developer-Key: i=hugo@hsal.es; a=openpgp;
 fpr=193D095149CF7E8737B39064D912B0DB205A91C1
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jKMDS6dQjz8vml
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When the ATIF signal range is out of bounds or narrower than
AMDGPU_DM_MIN_SPREAD, amdgpu_dm_validate_backlight_caps() drops the
firmware caps and the driver falls back to a range of 12-255. It only
says so with drm_dbg_kms(), so a user whose brightness range changed
finds nothing in dmesg to report

Make it a drm_warn() with FW_BUG, like the custom curve warnings

Signed-off-by: Hugo Sales <hugo@hsal.es>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
index 3a27fb956627a..68b34654fca02 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
@@ -104,8 +104,10 @@ void amdgpu_dm_validate_backlight_caps(struct amdgpu_display_manager *dm, int bl
 	    caps->min_input_signal < 0 ||
 	    spread > AMDGPU_DM_DEFAULT_MAX_BACKLIGHT ||
 	    spread < AMDGPU_DM_MIN_SPREAD) {
-		drm_dbg_kms(adev_to_drm(dm->adev), "DM: Invalid backlight caps: min=%d, max=%d\n",
-			    caps->min_input_signal, caps->max_input_signal);
+		drm_warn(adev_to_drm(dm->adev), FW_BUG
+			 "ATIF: backlight signal range %d to %d is invalid, using %d to %d\n",
+			 caps->min_input_signal, caps->max_input_signal,
+			 AMDGPU_DM_DEFAULT_MIN_BACKLIGHT, AMDGPU_DM_DEFAULT_MAX_BACKLIGHT);
 		caps->caps_valid = false;
 	}
 

-- 
2.56.0

