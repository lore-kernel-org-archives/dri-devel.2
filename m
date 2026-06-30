Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 208F3C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 07:03:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B633B10EDE9;
	Wed,  1 Jul 2026 07:03:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=139.com header.i=@139.com header.b="VIcaokEu";
	dkim-atps=neutral
X-Greylist: delayed 552 seconds by postgrey-1.36 at gabe;
 Tue, 30 Jun 2026 15:09:52 UTC
Received: from n169-113.mail.139.com (n169-113.mail.139.com [120.232.169.113])
 by gabe.freedesktop.org (Postfix) with ESMTP id 6EAE710E06B;
 Tue, 30 Jun 2026 15:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=139.com; s=dkim; l=0;
 h=from:subject:message-id:to:cc:mime-version;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=VIcaokEuiOIFYvtdM48QKVnsxwG2kkrmSLbyDxYqtAGXRcYVFgbt30lU1YJ37wO9T86QTK2lae+uA
 lJares/U6mm3pae0kau4OqH7BRnBt3voSE8so0jC1LQF9Mf/dirufMdgji2tfCnN4Y4SD2SazAllpF
 ByPYHPn6/5XytH1w=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM: 
X-RM-SPAM-FLAG: 00000000
Received: from yoga-Yoga-Pro-7-15ASH11..
 (unknown[2409:8A00:7882:4A80:26A:22CB:C855:10DC])
 by rmsmtp-lg-appmail-34-12048 (RichMail) with SMTP id 2f106a43d9f90a9-020d0;
 Tue, 30 Jun 2026 23:00:22 +0800 (CST)
X-RM-TRANSID: 2f106a43d9f90a9-020d0
From: Jackie Dong <xy-jackie@139.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, alex.hung@amd.com, ivan.lipski@amd.com,
 wenjing.liu@amd.com, robin.chen@amd.com, superm1@kernel.org,
 meenakshikumar.somasundaram@amd.com, Derek.Lai@amd.com,
 wei-guang.li@amd.com, gaghik.khachatrian@amd.com, jack.chang@amd.com,
 Duncan.Ma@amd.com, PeiChen.Huang@amd.com, aurabindo.pillai@amd.com,
 zhao.xichao@vivo.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Jackie Dong <xy-jackie@139.com>
Subject: [PATCH] drm/amd/display:Check dp_128b_132b_supported_link_rates.raw
 before link_rate setting
Date: Tue, 30 Jun 2026 22:59:55 +0800
Message-ID: <20260630145955.13994-1-xy-jackie@139.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 01 Jul 2026 07:03:11 +0000
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

[WHY]
In the evolution of displays from DP 1.4 to DP 2.0, due to considerations 
some factors,such as cost, some displays support 128b/132b encoding but 
do not support UHBR rate transmission. The values can be read from DPCD 
register address as below.

0x00006 is 03
0x02215 is 00

For such displays, the current kernel reports the following error message.

[drm:dp_retrieve_lttpr_cap [amdgpu]] *ERROR* retrieve_link_cap: Invalid RX 
128b_132b_supported_link_rates

[HOW]
Add new judgment: if all bits in dp_128b_132b_supported_link_rates.raw 
are non-zero, then further determine the specific UHBR type; otherwise, 
determine that the display does not support UHBR.

Signed-off-by: Jackie Dong <xy-jackie@139.com>
---
 .../gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 47abb4066709..58cbb7ac8f9e 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -2079,7 +2079,8 @@ static bool retrieve_link_cap(struct dc_link *link)
 	if (!dpcd_read_sink_ext_caps(link))
 		link->dpcd_sink_ext_caps.raw = 0;
 
-	if (link->dpcd_caps.channel_coding_cap.bits.DP_128b_132b_SUPPORTED) {
+	if (link->dpcd_caps.channel_coding_cap.bits.DP_128b_132b_SUPPORTED &&
+			link->dpcd_caps.dp_128b_132b_supported_link_rates.raw) {
 		DC_LOG_DP2("128b/132b encoding is supported at link %d", link->link_index);
 
 		/* Read 128b/132b suppoerted link rates */
-- 
2.43.0


