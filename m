Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA30C982C1
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:04:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D13610E92B;
	Thu, 17 Sep 2026 07:04:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Lxf9+HGN";
	dkim-atps=neutral
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com
 [74.125.228.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6DBF10E8E6
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 14:23:37 +0000 (UTC)
Received: by mail-ej2-f12.google.com with SMTP id
 a640c23a62f3a-c254f56039dso149306066b.3
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 07:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789568616; x=1790173416; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=B6QT3yGLHL6iAKp7l+6TCtIqZRata/HBJzcHAfxOozE=;
 b=Lxf9+HGNhRNgHTg4S9zZx0HarFzTCbFXECgjrcPEtD5WcJmTZ99TxdocbFPxjnrdIx
 zglJtMO7LN6cFJ/IBhgxux5DRemLcYg2k4BNLlE2x4BKs4FTkEdtdj5Fp7wEpfmDW4as
 CzfopFHcf398gufO6483ukjtijMppTJtVF3rIi+3yH4Jx6nbOwxgMvLnBlzA0fEFmoPi
 uebUVo1YEYUPnvg8fgL/cs3s40EzZTUqmLpOnys75iV+e2hHUxeI3YSMAazazEoII03o
 UOaAjr6d3ukQ8ItBfLN2z34DteK3zRrAx/Bs8bzse1CpaNuGg8VWPSJHwm5/Z9+s/8co
 8COQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789568616; x=1790173416;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B6QT3yGLHL6iAKp7l+6TCtIqZRata/HBJzcHAfxOozE=;
 b=TJvZJpSKz3AiuEndWKyl9efcUzPoTtk6nHw51w71fphhuaan1sNUHDuxZKHa+Zaufq
 z5TkT3RWcH1Z2SgBLH8Mt++cer7lRKSC5RENoVoNS7TxRHDxdJZ0aQ3NBJauj2R7ilzv
 t91CPxddGbAgBlFOZc+kV7jxucT3K3tudvikZd/8GTEHQacwBuOy0QaaxnuarwFatKJE
 BXyo38cyXJwcNm85iEXpDVNUkpDg5wPTmzPYp+gyo2M4dAJkwwvDToQUE8Q3lMy/BLFh
 4jT2z/XnljvP3t7sb9MIhL2WKbdk00xwzGROpRzhpijotUf7AW4fdC2aGoSHNu0Vzcz8
 sAOA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzVEN5L7zBSB9vpySTCW4gVEW/X3AoWt+13eddq9fMHpmjLzH8TtKsMmVPRd3V1OSpXKx+1QqZha3E=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mGIYmOiffudt/E/6Su4XWyG1zriMdqgO0BTCznGNrULne2AACg
 aPwNZG+WLoUaH54DxUTnHUVVLoBOMseLTIjl36pkeIvrkxshdTYkq7Xv
X-Gm-Gg: AYBFou2x9saM05vU9ZSKwqZ5S/mta+Oz5hOq9JGWei7aOLCbKJgstVSzlaQsjPB86j7
 BOXsGs/yjIv6LFMSEIqU/w11VxKPyyWxbJFQHeBhJjI6P/6H5Wtkhlnkj9nu/tm+oIqf+UKThDm
 29LHGNA6PXGij86P/Ap2aVkE5N8h5UCcE5znsWgp1+0jCphSgetcLWqc1qS8bJeHfQvr1KgvyNp
 L/lr/gMMH0sB9a8gQhp5+BQrqQdIYLJ9AN3sfJFHvYS7aaHr7huOI1zXXsteoxVg2Z3AeckjycF
 MOqafYJi4oG75an2baUhTNIG/UeJ9Ou2Ew95JDzJ0ds3tGw29Ker5n2HZu3aXlWkDmldDniwAeZ
 HlzfTkzn3MWPthSlBNLv0TgyYFNsvRXPkSVRP7bMTMAzyIaL+DWprJytC/Ot2dANzaLIX3vMPbc
 jjlJ+zMcnK1prmuOm0CUUAkvW+fT1MLFZgT/66Lkwd6obxzltuQFGI1tEotKrMWkOwOk9JK7MDJ
 WAeVXGFgGN5/Gf1G6p5vlOU4xTjaHeszkb88Vlm32NyBpUDRLEwUo/D7I7N
X-Received: by 2002:a17:907:7241:b0:c26:19de:9138 with SMTP id
 a640c23a62f3a-c29e5351a04mr213058866b.43.1789568615501; 
 Wed, 16 Sep 2026 07:23:35 -0700 (PDT)
Received: from misharu.home
 (2a02-a463-a071-0-1562-51d1-d5f-82bb.fixed6.kpn.net.
 [2a02:a463:a071:0:1562:51d1:d5f:82bb])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c29e801cdfesm105216566b.58.2026.09.16.07.23.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 07:23:34 -0700 (PDT)
From: Hari Mishal <harimishal1@gmail.com>
To: harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: siqueira@igalia.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 airlied@gmail.com, simona@ffwll.ch, hersenxs.wu@amd.com, Jerry.Zuo@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
 Hari Mishal <harimishal1@gmail.com>, stable@vger.kernel.org
Subject: [PATCH] drm/amd/display: guard dc_sink dereferences in MST mode
 validation
Date: Wed, 16 Sep 2026 16:23:32 +0200
Message-ID: <20260916142332.10394-1-harimishal1@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 17 Sep 2026 07:04:01 +0000
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

dm_dp_mst_is_port_support_mode() reads
aconnector->dc_sink->dsc_caps... for the DSC branch-throughput check,
and get_conv_frl_bw()'s HDMI-PCON FRL-bandwidth path reads
aconnector->dc_sink->edid_caps.max_frl_rate, both without a NULL
check. dc_sink is cleared asynchronously on MST unplug, and both
functions run from paths that the driver's own comments document as
racing that teardown: the connector probe worker's ->mode_valid
callback and a compositor's atomic check, neither of which holds the
MST manager lock that the teardown path uses. The former does have an
existing dsc_aux NULL check, but dsc_aux isn't reliably cleared in
every path that clears dc_sink, so it doesn't cover this.

Fail the port-support check and skip the FRL conversion path when the
sink is already gone.

Fixes: f04d275d94e1 ("drm/amd/display: add mst port output bw check")
Fixes: 5c9b8b27a883 ("drm/amd/display: Tie FRL support into amdgpu_dm")
Cc: stable@vger.kernel.org
Assisted-by: gkh_clanker_t1000
Signed-off-by: Hari Mishal <harimishal1@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 045a7f88b754..7261317d4c0f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1231,7 +1231,8 @@ static bool get_conv_frl_bw(struct amdgpu_dm_connector *aconnector,
 	unsigned int max_sink_bw_in_kbps = 0;
 	unsigned int dsc_max_sink_bw_in_kbps = 0;
 
-	if (aconnector->dc_link->dc->caps.dp_hdmi21_pcon_support &&
+	if (aconnector->dc_sink &&
+	    aconnector->dc_link->dc->caps.dp_hdmi21_pcon_support &&
 	    aconnector->mst_downstream_port_caps.bytes.byte0.bits.DWN_STRM_PORTX_TYPE == DOWN_STREAM_DETAILED_HDMI) {
 		max_conv_bw_in_kbps = dc_link_bw_kbps_from_raw_frl_link_rate_data(
 				aconnector->dc_link->dc,
@@ -1996,6 +1997,9 @@ enum dc_status dm_dp_mst_is_port_support_mode(
 	struct dc_dsc_config_options dsc_options = {0};
 	uint32_t stream_kbps;
 
+	if (!aconnector->dc_sink)
+		return DC_FAIL_BANDWIDTH_VALIDATE;
+
 	/* DSC unnecessary case
 	 * Check if timing could be supported within end-to-end BW
 	 */
-- 
2.43.0

