Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 901C5C5AD7B
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 09:55:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B821510E793;
	Mon, 10 Aug 2026 09:55:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HgnS7ODo";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 221A610E791
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 09:55:44 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 07747600DA;
 Mon, 10 Aug 2026 09:55:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A513EC19425;
 Mon, 10 Aug 2026 09:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1786355742;
 bh=lRKV8H74Co2qH7BGcr2cTswTqZvkze7IH7Sbt/O3Weg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=HgnS7ODoDhTe+xdr8JMh+UR7U8ZRkEyTBrtJyyKHlI9fb28qnikx4JhUmKSCvN9Oe
 A0oC3WtThVDIgNNamDH2j/ko7/4WUinlhBmczWxGY474B9AZMFo0WU8W149DA5bhj0
 yEtwS2cpT+DCF5sGSEPPdqzs3KjggbqoDZv11sdr2JrGdcf0Sck1E96ZTUgJB/gIS4
 SLeBTBnqq0tYDAepf/Ku94mbJT96Tk8PEGn1dH4QMqCN1WKu7jlUuXpXMJaj/tJFRm
 +L5slBEkQl/scsDwjA24DqwtPlWB4CNO20kdoijVjPjdDAB7bJ8R97d3IHbosraaBz
 hD8ZWoOZNw/zw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 87031C5AD4E;
 Mon, 10 Aug 2026 09:55:42 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Mon, 10 Aug 2026 11:55:37 +0200
Subject: [PATCH v2 1/2] drm/panel: lg-sw43408: do not assert reset across
 unprepare
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-fix-blueline-panel-v2-1-9344dfdbc3f9@ixit.cz>
References: <20260810-fix-blueline-panel-v2-0-9344dfdbc3f9@ixit.cz>
In-Reply-To: <20260810-fix-blueline-panel-v2-0-9344dfdbc3f9@ixit.cz>
To: Sumit Semwal <sumit.semwal@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Vinod Koul <vkoul@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2520; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=di2OzEU0PRnOGKu5XRkp3UwJDiN4YcH6Uzw5Ht/qTmo=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqeaAcmfWFxH/vXpRpVSRZ7tC+z5dEZIMfcu5sL
 pQk4pwKikOJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCanmgHAAKCRBgAj/E00kg
 cimrEACOKggloVunUqSkYEPAHQr9QpRUmDqwumRVhly4Re0KbUuKUFJp0AsDuvTWwtxd53PtnRg
 IOlbZckmFq2U/CXxSa/cPs7dlDe3dUs9PqKONnGQ793Wg+P0eTtBCVdHvYS1kivf931dtcbvkU5
 skzV5687haaSbffYyDXc9ZD6zD4NV8KZ4cmFVA2CoNVxRCbdbr8XdaC+OKdtu7k9E2OQ9iMt+Sc
 22OpDEg5Uvjxxp9wn0dDIDGKSse5okN2LPgkgbuUwc8TI33kdy8iP4fiQOc+/CLue7NWvDJXHMX
 UypepwnQXyUgtUzD0QE8JTysjFdnzexKJKvl0F1kaIxMOUm9yfkvq0mJxq+tPQGZviaTh2MpoL7
 Zojo5Nf3shniVfa1m5z6pjQl2GHQVQ/FVtL4xUeSYW9gf8rKYLlTopdIYoHcmDXCygcTFtKoq/X
 Q5KUQof/hwkyhOfhuyvEHRbn94HRhn7EOc9+eXk793a7dsPxMM2aJRhtcV7g1JcU9jDYSDrolMd
 hpbxW2dsSACH2OZ4uGKJ6WHqaPVkuXDRlJR3c7BqQtPSR28pNLI68MIWT68yL1FcRKv2VW/hB2P
 1L97kPJQ7dhxysOpb2dRrRHWWmpZw9xlX8HLHHzEhrswoGvIBUNEjRCLV37NXSn4/WXBmgzg0a/
 CUNK+ROeb9jAxzQ==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
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
Reply-To: david@ixit.cz
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: David Heidelberg <david@ixit.cz>

Asserting the reset GPIO in unprepare() and leaving it asserted puts
the DDIC into a state it never recovers from: after the following
prepare() the panel answers all DCS commands, reports display-on with
clean self-diagnostics, and its configuration registers read back
identical to a working panel, but it never lights up again.

On the Pixel 3, vddi is shared with the touchscreen controller and
remains powered while the panel is off, so with this driver the DDIC
sits in reset with its logic rail up for the whole blank period - a
state the vendor stack never creates: the vendor firmware only toggles
reset as part of a full power-on sequence, and the vendor OS never
power-cycles the panel at all (LP mode is used instead).

Leave reset alone in unprepare(); prepare() performs the regular reset
sequence anyway.

Without this, the Pixel 3 display never comes back after the first
blank/unblank cycle.

Since there isn't any other panel or device using this DDIC, this
approach seems resoanble to address the issue.

Fixes: 069a6c0e94f9 ("drm: panel: Add LG sw43408 panel driver")
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/gpu/drm/panel/panel-lg-sw43408.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-lg-sw43408.c b/drivers/gpu/drm/panel/panel-lg-sw43408.c
index 293826c5006b9..0bf8e08f10b9c 100644
--- a/drivers/gpu/drm/panel/panel-lg-sw43408.c
+++ b/drivers/gpu/drm/panel/panel-lg-sw43408.c
@@ -50,18 +50,24 @@ static int sw43408_unprepare(struct drm_panel *panel)
 	int ret;
 
 	mipi_dsi_dcs_set_display_off_multi(&ctx);
 
 	mipi_dsi_dcs_enter_sleep_mode_multi(&ctx);
 
 	mipi_dsi_msleep(&ctx, 100);
 
-	gpiod_set_value(sw43408->reset_gpio, 1);
-
+	/*
+	 * Keep reset deasserted: vddi may stay powered (it is shared with
+	 * the touchscreen on Pixel 3) and holding the DDIC in reset while
+	 * its logic rail is up puts it into a state that no init sequence
+	 * recovers from - the panel keeps answering DCS commands and
+	 * reports display-on, but never lights up again. The vendor stack
+	 * only ever toggles reset as part of a powered-up init sequence.
+	 */
 	ret = regulator_bulk_disable(ARRAY_SIZE(sw43408_supplies), sw43408->supplies);
 
 	return ret ? : ctx.accum_err;
 }
 
 static int sw43408_program(struct drm_panel *panel)
 {
 	struct sw43408_panel *sw43408 = to_panel_info(panel);

-- 
2.55.0


