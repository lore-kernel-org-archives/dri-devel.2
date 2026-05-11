Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE79CD4F21
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 23:56:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D219210E936;
	Mon, 11 May 2026 23:56:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="arnNQL1z";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E142710E92F
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 23:56:51 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7D4B8145C;
 Tue, 12 May 2026 01:56:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1778543803;
 bh=I5d+4K7h/aBDUFewAuRMs9MKDzFzwUrbqwk7QyJgHBE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=arnNQL1zsaigma594P+2QTqaJkNGWsYLBA7e12HKPv0qiX8A9ClS/gQr3syC5n/XD
 8drXvDtsj+pzPJYOcmTTCxtjcaLoIvNjjSixhYqjgUa/i1d7C3fEAaazWogViW2mb7
 xq8tujWeMWrn515320qsEwADsrxOAvK/oWFZ5apI=
From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To: linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: linux-renesas-soc@vger.kernel.org,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Biju Das <biju.das.jz@bp.renesas.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH 09/11] media: renesas: vsp1: Simplify iteration over format
 arrays
Date: Tue, 12 May 2026 02:56:33 +0300
Message-ID: <20260511235637.3468558-10-laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260511235637.3468558-1-laurent.pinchart+renesas@ideasonboard.com>
References: <20260511235637.3468558-1-laurent.pinchart+renesas@ideasonboard.com>
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

Introduce a vsp1_for_each_format() macro to iterate over format arrays,
to improve readability. No functional change intended.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 .../media/platform/renesas/vsp1/vsp1_pipe.c   | 36 ++++++-------------
 1 file changed, 10 insertions(+), 26 deletions(-)

diff --git a/drivers/media/platform/renesas/vsp1/vsp1_pipe.c b/drivers/media/platform/renesas/vsp1/vsp1_pipe.c
index f9c7c75a7ad0..7197f2917417 100644
--- a/drivers/media/platform/renesas/vsp1/vsp1_pipe.c
+++ b/drivers/media/platform/renesas/vsp1/vsp1_pipe.c
@@ -229,6 +229,10 @@ static const struct vsp1_format_info vsp1_video_hsit_formats[] = {
 	  1, { 32, 0, 0 }, false, false, 1, 1, false },
 };
 
+#define vsp1_for_each_format(info, formats) \
+	for (const struct vsp1_format_info *info = &formats[0]; \
+	     info < formats + ARRAY_SIZE(formats); ++info)
+
 /**
  * vsp1_get_format_info - Retrieve format information for a 4CC
  * @vsp1: the VSP1 device
@@ -240,30 +244,20 @@ static const struct vsp1_format_info vsp1_video_hsit_formats[] = {
 const struct vsp1_format_info *vsp1_get_format_info(struct vsp1_device *vsp1,
 						    u32 fourcc)
 {
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(vsp1_video_formats); ++i) {
-		const struct vsp1_format_info *info = &vsp1_video_formats[i];
-
+	vsp1_for_each_format(info, vsp1_video_formats) {
 		if (info->fourcc == fourcc)
 			return info;
 	}
 
 	if (vsp1->info->gen == 2) {
-		for (i = 0; i < ARRAY_SIZE(vsp1_video_gen2_formats); ++i) {
-			const struct vsp1_format_info *info =
-				&vsp1_video_gen2_formats[i];
-
+		vsp1_for_each_format(info, vsp1_video_gen2_formats) {
 			if (info->fourcc == fourcc)
 				return info;
 		}
 	}
 
 	if (vsp1_feature(vsp1, VSP1_HAS_HSIT)) {
-		for (i = 0; i < ARRAY_SIZE(vsp1_video_hsit_formats); ++i) {
-			const struct vsp1_format_info *info =
-				&vsp1_video_hsit_formats[i];
-
+		vsp1_for_each_format(info, vsp1_video_hsit_formats) {
 			if (info->fourcc == fourcc)
 				return info;
 		}
@@ -287,8 +281,6 @@ const struct vsp1_format_info *
 vsp1_get_format_info_by_index(struct vsp1_device *vsp1, unsigned int index,
 			      u32 code)
 {
-	unsigned int i;
-
 	if (!code) {
 		if (index < ARRAY_SIZE(vsp1_video_formats))
 			return &vsp1_video_formats[index];
@@ -308,9 +300,7 @@ vsp1_get_format_info_by_index(struct vsp1_device *vsp1, unsigned int index,
 		return NULL;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(vsp1_video_formats); ++i) {
-		const struct vsp1_format_info *info = &vsp1_video_formats[i];
-
+	vsp1_for_each_format(info, vsp1_video_formats) {
 		if (info->mbus == code) {
 			if (!index)
 				return info;
@@ -319,10 +309,7 @@ vsp1_get_format_info_by_index(struct vsp1_device *vsp1, unsigned int index,
 	}
 
 	if (vsp1->info->gen == 2) {
-		for (i = 0; i < ARRAY_SIZE(vsp1_video_gen2_formats); ++i) {
-			const struct vsp1_format_info *info =
-				&vsp1_video_gen2_formats[i];
-
+		vsp1_for_each_format(info, vsp1_video_gen2_formats) {
 			if (info->mbus == code) {
 				if (!index)
 					return info;
@@ -332,10 +319,7 @@ vsp1_get_format_info_by_index(struct vsp1_device *vsp1, unsigned int index,
 	}
 
 	if (vsp1_feature(vsp1, VSP1_HAS_HSIT)) {
-		for (i = 0; i < ARRAY_SIZE(vsp1_video_hsit_formats); ++i) {
-			const struct vsp1_format_info *info =
-				&vsp1_video_hsit_formats[i];
-
+		vsp1_for_each_format(info, vsp1_video_hsit_formats) {
 			if (info->mbus == code) {
 				if (!index)
 					return info;
-- 
Regards,

Laurent Pinchart

