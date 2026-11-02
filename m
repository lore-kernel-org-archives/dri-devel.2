Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FBC606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 21:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=YKXE+JZo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FA3610E134;
	Mon,  2 Nov 2026 21:29:04 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04D7010E134
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 21:28:57 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-48e46e449e8so2136374f8f.3
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 13:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20260707; t=1793654936; x=1794259736;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zcVggVYajR4k5NgQe9pbGY6+WDVxyFxQve/L9p1a8zk=;
 b=YKXE+JZoyG1EJrlqaoTmLSdVUq0/POwQ95MgLxsVqy3KsYdldAsRIqt9oSfkJsgWEj
 ePVgJVTHv508/UW+1ApTJ1kjTeOxZvkZUbaHH2BUNzI/wVAKYOiitt2JiplAEI2r6s0w
 9MIr+YjTvL4DOLppbcDX3NJndCrfpwuS109XepTGIwMJ6A9DtDhPWRG/5TMbRAXU/C8/
 vSo4W4Lz8LQ1Qi1sCIYILx2VnxvKD5oGzn1zrs4DkMFvH3XXHmt3PsyuLJ6veGcPKGn1
 V7nylsmllvxUmCEYp/9/DVi+pYGU2xR7wcS79B79vRuTOLjacvVH8JawHrcN+APaC+ta
 PuPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793654936; x=1794259736;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zcVggVYajR4k5NgQe9pbGY6+WDVxyFxQve/L9p1a8zk=;
 b=oit1aVi/FYGJbtA4a+ko3On6OkLtnQ3JqDgTRHM8JSLKuxZyzIzW3X3x2LUiKwXPVm
 CWiPqaxbJgkzlOkJoTUKvXEhQ8m0DkRVQae509hzkpuCkRTdsiXjKM1vp01bmAN0zFkq
 Qg2LIMRGx8bVutSEpdxES/RJ5QC8RQ+MsStslbvUzRS7Ypf4oHul+f0VnVe2KC17BmNw
 N7ZPYg/J1W64Aqn6Ez7DMg6kfgYDpSB5mZJb44dR0E0CSIgmWy1B3pLTXnIBKd4uIcBV
 UGO7Y4JT+asl2erXLXRcGqZ7cQlSnJ//An1vY6TQmtpE+fnNMs84fyOvDnID2fVnEf4d
 ojRg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwXzT472GH28cRYqXY+ImZaW6xDnpHLGCBQLEXI0UZnIonmrrhb/f7Irxai5iId+SeTZglrQno3L1Y=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8IQICPLCKnXHRUyw/q7/ItU3rzXMtGhim6ckJsFofzvg8/2SX7
 ZUd24WUghSJLfcp96HnnxAmH3EhCM6dvyKTiiFe/WGQWiy7u/nBCfr6m
X-Gm-Gg: AYBFou3tASgDdvDCURfU8P9f1AzErzU7P0YU2tRBeJT85QwhesMJfxjwGmM11VXqZ1D
 JiPEUOqDZLLKp9cne+nHzICbD7ASTS7scNyHIqlzbwYabRn9eofyiBJzEqcMJGNEIQaVdBd5ogX
 RU2aCK3y+5OEw5fl5Y/g1dIK9gs5KxrD9SacDgT+MdqobyjM0redzXbQ9NAeCb/O9lfEReBFpn5
 uzwzF9HGWMIem+QdVbJ8Ut/EgaSTZRP/VtR8EH4ZH9kJ2cwNOKTGeK5zoUGnuFiQtoEt1Rc1UBD
 LxPWFwuIuWPxvCQ5/r/CA4/olmZIwZ3oDKxALUgCtp3BqCUzrCxRoKCDH+pkSo9rXlkwYApJmmy
 53PM5UyKuDW+/vnTVEsSKxiimqceBedc4O0MyBGxMEAXhLP13B1J/wO0cdyFKjPGGRyoB6Gv3o0
 D79u3Hgzu9dSxbCkIrMQGs4AUnYCn2KtWl5z/vL+HGeE2qIOTJZSQ8ZiQnx6Z2nOci/n4B5F8kl
 TSEjPXpyXThD/tFDxiTpoUcoThftASt9GrjFgVjsaBYX+OrP3Ha0QQAuYhKX8UjC9zN8UGNiRtQ
 GHHiMgXfnRRJuGWtvZQzu4YKondD5pzJNq9CVCMLn7hfShLOWy+vjaTzMOT7GvF7/KrLOhzIU4+
 OVUDRh6D9vPZjLsmdviF7pw7MPJzUmymbqhvalj4GIUV98hmYX86orT+C
X-Received: by 2002:a05:6000:2dc5:b0:48d:ef0e:b791 with SMTP id
 ffacd0b85a97d-48e6e52c720mr25066663f8f.54.1793654936073; 
 Mon, 02 Nov 2026 13:28:56 -0800 (PST)
Received: from blackbox
 (dynamic-2a02-3100-b1d0-8200-f22f-74ff-fe21-0725.310.pool.telefonica.de.
 [2a02:3100:b1d0:8200:f22f:74ff:fe21:725])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-48e71b725a2sm20540521f8f.13.2026.11.02.13.28.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 13:28:55 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, neil.armstrong@linaro.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH re-send] drm/meson: add support for higher bandwidth HDMI DTDs
Date: Mon,  2 Nov 2026 22:28:43 +0100
Message-ID: <20261102212843.1213021-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

There's a report from a user with a DELL U3415W monitor and a Khadas
VIM3 stating that 3440x1440@50Hz works but 3440x1440@60Hz doesn't.
edid-decode Detailed Timing Descriptor (DTD) extract of that mode:
  DTD 1:  3440x1440   59.972616 Hz  43:18    88.819 kHz    319.750000 MHz
               Hfront   80 Hsync  32 Hback   48 Hpol P
               Vfront   28 Vsync  10 Vback    3 Vpol N

Those high clock rates are currently not supported by the meson_vclk
code as it limits the PLL OD (output divider) to a minimum of 2. The
formula to calculate the clock internally is (ignoring fractional
dividers):
  319.750MHz * 10 * od = 24MHz * m

With od = 2 this results in m = 266, which is outside the supported
range of the PLL on G12A SoCs (the driver limits m to 106..247).
Using od = 2 results in m = 133, which is supported.

Allow the driver to pick OD = 1 to gain support for modes such as
3440x1440@60Hz.

Link: https://forum.khadas.com/t/can-not-set-display-resolution-to-3440x1440-for-dell-monitor/26271/12
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
Re-send of [0] which seems to have slipped through.


[0] https://lore.kernel.org/linux-amlogic/20260109204836.790096-1-martin.blumenstingl@googlemail.com/


 drivers/gpu/drm/meson/meson_vclk.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_vclk.c b/drivers/gpu/drm/meson/meson_vclk.c
index dfe0c28a0f05..c0be0b7655bf 100644
--- a/drivers/gpu/drm/meson/meson_vclk.c
+++ b/drivers/gpu/drm/meson/meson_vclk.c
@@ -700,8 +700,8 @@ static bool meson_hdmi_pll_find_params(struct meson_drm *priv,
 				       unsigned int *frac,
 				       unsigned int *od)
 {
-	/* Cycle from /16 to /2 */
-	for (*od = 16 ; *od > 1 ; *od >>= 1) {
+	/* Cycle from /16 to /1 */
+	for (*od = 16 ; *od > 0 ; *od >>= 1) {
 		*m = meson_hdmi_pll_get_m(priv, freq * *od);
 		if (!*m)
 			continue;
@@ -750,7 +750,7 @@ static void meson_hdmi_pll_generic_set(struct meson_drm *priv,
 		/* OD2 goes to the PHY, and needs to be *10, so keep OD3=1 */
 		od3 = 1;
 		if (od < 4) {
-			od1 = 2;
+			od1 = od;
 			od2 = 1;
 		} else {
 			od2 = od / 4;
-- 
2.56.0

