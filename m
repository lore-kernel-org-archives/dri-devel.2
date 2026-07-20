Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E817C4452A
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 13:04:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D841F10E912;
	Mon, 20 Jul 2026 13:04:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="X6t28ym+";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DB2F10E912;
 Mon, 20 Jul 2026 13:04:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784552660; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ehHzSpYz0V8EqhdM6EaBEumDPGR8sGmdS4JCTGmnlybjizGiVLuY6BG48JZFwiopfrn1xAoX5nMkONF4+4GDcw8YYDC1srZoA31xKfhXN/D49sVE/KBqn69UL0JHIv/9porcqQGi+1ypeeoMnbpSsfQcHzSlBgDd5mNOLRaHlxA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784552660;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=HN6kXcysOJTr101hpnG7NcuN/66ELXnKkFR6JHIY2pk=; 
 b=cKPVZKlH/AhN7djjCHYWlH25lEpgA4afBBKsuDb6hv7wfPnIlYsyzPGzJcBEot2CJ7D1TG+ZSoEq4KF/XDd4GLpAk9JGy611AW9fnpiaL7HIaGYqz5E7LQ6f4f7TSGrA1BqOMqw8wiZtyE7GNZ35aHCOwVK/lqIz6qyRUZmRWVQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784552660; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
 bh=HN6kXcysOJTr101hpnG7NcuN/66ELXnKkFR6JHIY2pk=;
 b=X6t28ym+Q1c2Hgiw1gNAGYOUlvwWeGIMnUZgR5ERmumVio2zJYE5uusYgKFz/nR1
 VNH9sr5uv5f1nAz0MJR96qf7hIg2xFmE6m8dBHMHsJJu0DNGMPwW05noTrzFESgEeCg
 Iml1oMvyDB5i5TCDUCuFtTEdn+WTLRLUOJXLGSrY=
Received: by mx.zohomail.com with SMTPS id 1784552658856490.3691525909395;
 Mon, 20 Jul 2026 06:04:18 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 20 Jul 2026 15:03:57 +0200
Subject: [PATCH] drm/amd/display: Remove redundant AUTO color format
 handling in else
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-color-format-amdgpu-fix-v1-1-4ec896bb1531@collabora.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2NwQqDMBBEf0X23IXVgqK/UnqIyWq3NMZuYhHEf
 2+sPb5hZt4GkVU4QldsoPyRKGHKUF4KsA8zjYziMkNFVU1NRWjDKygOQb1JaLwb5wUHWZFaQ9e
 Sats6A3k9K+f493y7nxyX/sk2HXf/hvJ7ycp01qA3kbPAe0ld4dSjl2hx4jXh4UdqsKzhvu9fs
 hhtXrcAAAA=
X-Change-ID: 20260720-color-format-amdgpu-fix-09a03106c9da
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Daniel Stone <daniel@fooishbar.org>, 
 Marius Vlad <marius.vlad@collabora.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Dan Carpenter <error27@gmail.com>, 
 kernel@collabora.com, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.15.2
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

The AUTO connector color format is handled in the earlier branches for
both RGB and YUV420. The repeated check in the else branch is therefore
redundant.

Remove it to make the code less confusing to read.

Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/alCcJmDeIYEE94Eh@stanley.mountain/
Fixes: 8a0343b03b98 ("drm/amdgpu: Implement "color format" DRM property")
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 88f938a8f24f..ea277c991234 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -854,12 +854,7 @@ static void fill_stream_properties_from_drm_display_mode(
 		 * error bubbles up to userspace. This way, userspace knows it
 		 * needs to make a better choice.
 		 */
-		if (connector_state->color_format != DRM_CONNECTOR_COLOR_FORMAT_AUTO)
-			timing_out->pixel_encoding = PIXEL_ENCODING_UNDEFINED;
-		else if (drm_mode_is_420_only(info, mode_in))
-			timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
-		else
-			timing_out->pixel_encoding = PIXEL_ENCODING_RGB;
+		timing_out->pixel_encoding = PIXEL_ENCODING_UNDEFINED;
 	}
 
 	timing_out->timing_3d_format = TIMING_3D_FORMAT_NONE;

---
base-commit: e6a72e9b927165081566252d972ea1cbbee5bf28
change-id: 20260720-color-format-amdgpu-fix-09a03106c9da

Best regards,
--  
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

