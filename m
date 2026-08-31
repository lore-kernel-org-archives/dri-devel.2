Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C69C624CE
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 13:40:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2199510E875;
	Mon, 31 Aug 2026 13:40:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GuBlutvf";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D749310E875
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 13:40:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BF520409F7;
 Mon, 31 Aug 2026 13:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD9F1F00ADF;
 Mon, 31 Aug 2026 13:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788183616;
 bh=qUcjZ5+YMNO1PHUGhauPMhWUrZrLi8iHa+h+leRfEGE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=GuBlutvfT5gXF/DzJKCYlVDadTaINa/qBmZtovCQcpsuhK/NIF42lNaaxkAzGCUYR
 77hdoU6EUWkX+mznWvHUjmAbqVwaDzDalJLAb+HX3xCZ1OwlMfTzFVt6JjkOPsApei
 GJK9R9DhZMOifSFFQLkcOXDaRPeAhc4LNMDK0tKqVJO4SJ0SgTokVDTLbll56SEp+V
 f0DO4bDWkZe/PpKnYv+0ZvRtq1czP80BBbFza2XnYy0OaMzOCIwauD+8UfEji0vWMO
 2+8lAlamxgEITaiqfMSuvJJ2BLiPUVsdgusMnydlpMXQVE+BzTWn+3CC1WqlNulDwt
 4MtDfASIk9FpQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>,
 Douglas Anderson <dianders@chromium.org>, Sasha Levin <sashal@kernel.org>,
 neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18] drm/panel-edp: Add CSW PNB601LS1-2 and LGD
 LP116WHA-SPB1
Date: Mon, 31 Aug 2026 09:23:48 -0400
Message-ID: <20260831133314.4125787-200-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831133314.4125787-1-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.48
Content-Type: text/plain; charset=UTF-8
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

From: Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>

[ Upstream commit e88b5cc6d6e5b1ba257f00e5c186ba137e6e8bc3 ]

The raw EDIDs for each panel:

CSW
- PNB601LS1-2
00 ff ff ff ff ff ff 00 0e 77 0a 11 00 00 00 00
30 23 01 04 a5 1a 0e 78 03 a1 35 9b 5e 58 91 25
1c 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 09 1e 56 dc 50 00 28 30 30 20
36 00 00 90 10 00 00 1a 06 14 56 dc 50 00 28 30
30 20 36 00 00 90 10 00 00 1a 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
00 0c 3d ff 0c 3c 7d 0e 0b 17 7d 00 00 00 00 e8

LGD
- LP116WHA-SPB1
00 ff ff ff ff ff ff 00 30 e4 fe 07 01 01 00 00
00 24 01 04 a5 1a 0e 78 03 72 e5 9c 5e 5b 94 27
19 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 d5 21 56 a0 50 00 b2 30 30 20
f8 0c 00 90 10 00 00 1a 8e 16 56 a0 50 00 b2 30
30 20 f8 0c 00 90 10 00 00 1a 00 00 00 fd 00 28
3c 39 39 09 01 0a 20 20 20 20 20 20 00 00 00 02
00 0f 3d ff 0f 3c 7d 0d 0a 15 7d 00 00 00 01 da

70 20 79 02 00 25 00 09 57 52 01 57 52 01 28 3c
80 81 00 15 74 1a 00 00 03 01 28 3c 00 00 4a 5a
4a 5a 3c 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 ef 90

Signed-off-by: Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Link: https://patch.msgid.link/20260324061444.242917-1-terry_hsiao@compal.corp-partner.google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

The background searches finished and match the earlier analysis:

- **Git history:** No commit for `PNB601LS1-2` or `LP116WHA-SPB1` in
  this tree. Related CSW entries (`MNB601LS1-3`, `MNB601LS1-4`) are
  present, so the missing panels are a gap, not a duplicate fix.
- **b4 dig:** Returned nothing — the commit isn’t in this checkout, so
  the lore thread couldn’t be resolved that way.

That doesn’t change the verdict: for **6.18.43**, this is a small,
reviewed panel-ID addition that applies cleanly and is appropriate for
stable.

**YES**

 drivers/gpu/drm/panel/panel-edp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index d1e68c464e308..be827729c4fb7 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -2029,6 +2029,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1100, &delay_200_500_e80_d50, "MNB601LS1-1"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1103, &delay_200_500_e80_d50, "MNB601LS1-3"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1104, &delay_200_500_e50_d100, "MNB601LS1-4"),
+	EDP_PANEL_ENTRY('C', 'S', 'W', 0x110a, &delay_200_500_e50, "PNB601LS1-2"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x143f, &delay_200_500_e50, "MNE007QS3-6"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1448, &delay_200_500_e50, "MNE007QS3-7"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1457, &delay_80_500_e80_p2e200, "MNE007QS3-8"),
@@ -2070,6 +2071,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('L', 'G', 'D', 0x05af, &delay_200_500_e200_d200, "Unknown"),
 	EDP_PANEL_ENTRY('L', 'G', 'D', 0x05f1, &delay_200_500_e200_d200, "Unknown"),
 	EDP_PANEL_ENTRY('L', 'G', 'D', 0x0778, &delay_200_500_e200_d200, "134WT1"),
+	EDP_PANEL_ENTRY('L', 'G', 'D', 0x07fe, &delay_200_500_e200_d200, "LP116WHA-SPB1"),
 
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x1511, &delay_200_500_e50, "LQ140M1JW48"),
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x1523, &delay_80_500_e50, "LQ140M1JW46"),
-- 
2.53.0

