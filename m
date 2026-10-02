Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F06CA5FF0
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 17:18:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E05C10EABC;
	Sun,  4 Oct 2026 17:18:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=trailofbits.com header.i=@trailofbits.com header.b="Kx1HqEmr";
	dkim-atps=neutral
Received: from mail-dy2-f34.google.com (mail-dy2-f34.google.com
 [74.125.229.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8558510E00A
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 19:44:18 +0000 (UTC)
Received: by mail-dy2-f34.google.com with SMTP id
 5a478bee46e88-33be7dfcfc1so10225142eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 12:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trailofbits.com; s=google; t=1790970258; x=1791575058;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Rko1U6OoJC3n7W8qpIuhWiCDlnVmuYaiccHeKEGfF6U=;
 b=Kx1HqEmrOgecvWuMEQVB3ecU7OOJK34YvzLRsnqBH+YigwAfxbsHkdEZV+7FDDp5LI
 DRC+dZHhepWeRoEr/WjicrZOsAs4Gjqhvvl61IxWMCzc4Z1/X8GDUHSfwbZS6ilKdtKb
 u8GMDYXY0YL0R8n+4sTkh6WaRPFpRJV/L/u7+wp+L7Y1V8xkVn5h9VdWMHcTtUlg9Jmh
 zFgwNzfYkPaDe1R8xsEgnGfpKchGF+6bYtxGQF06A9Soo449G1p1IAPufKwsdokhxvLW
 nZJ820C3j7mEy94T7+Y3t3yd7sjIaDPVwwgPmDo/uKxlTm3OdqyU6SYNonh0aPVuAlNq
 gFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790970258; x=1791575058;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Rko1U6OoJC3n7W8qpIuhWiCDlnVmuYaiccHeKEGfF6U=;
 b=2q0fLW37zgnwGAR41CKaEpsIt3X5Zl3b2xg1SFQ9wpShN6S/ncVmF9XzKihIoACJr6
 RZS+4+3dYCtRq0vkG4MvUE/tSgmxGiBK5FXzfw9wDepWbMxlYYmkLXnbaJcZIdrk+XGM
 Uo3VgbjuMLGSuXjBeiEvz7Ie/jHaxbx+bfVTUmXerbtD9Tpn2pG1xSd/Boy1cnUSJlS7
 3iOFLlZCazcDRpSNLQSy3iFM4c2G0tn2xyy0kqe5ZJRUnQT1KaOz8CryCNnB3k4TWOtF
 o9pKi4pjejc9v+nlycwEEdNgQSdvjrbfIewdKcXmv5pIzQR22bAKFNjOpyTBIvtMMzXg
 m6GA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy/YMeY6fXWc+ueEzT0Uucq+wN3JR3nNq1cxrB2A3n4scdQsL2M/CLGFqNOUtDw7B3o1wOorqPSnBQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++niKT8yEnaHvoe/llIAFCvFrp5pc3pl4/YuSqSg9DMq4y4fkYDI
 WEx2MgzIK6g/kk9r3Ux+ifNWODwRx523q2DYQSWDTwmAoYMpjSvfcV4ERJwD+c7NIp0=
X-Gm-Gg: AYBFou2Fz+hMTNjcl7wmsRdtonxxRhSeDwOvnvBQ65UDvskKJm7FGZUdTbp/DjA5nB5
 MbeongtgO8oI5O0I28zJ+XsoKsmLE398VjzSyfebcDS9UDLgfjmq8q2Vbf/KYB+OanWT3MCA8Em
 bmQNTxaFa2ZQIZBB0VsOWXxEczn2qEQ3t6OfAVajUyMFmLZH+Sm4Dfu5WJY3gi2nkvXmeSjmOkk
 jkab9ONyT+X5KAEyZqvxQkv6KDNyERPWtt7tseBhYum4x4O3VUYLYeXCEKK7GkZ56EJq1FCrYT7
 TmyD1FAd7xhO4zxOnrc3XwFFdfEpAiVqR/hqZ1Mwpe5HwknNziB2SOq6xtBNePg5zFLb1yLGZ8X
 O08x0wc58dNG/vqk03nhA4AnYrKsr77YzD3YZgnydP6E4mmCHudALOzHLHdgkdGBqON0PdaV5S5
 JPDesSkNvkyAywsUs4nbhlxoeZgwjotYRzT9tLnnNJ62wgdpef2cBy3Acfhd3LDd3XehTtygV/j
 9jca8LYrIrEaYxEk5dBN4rQFC3o8fuyBmGX1TaiYBR+6qVhGqJlvyt1hIp5XUkOAe7lpSs=
X-Received: by 2002:a05:7301:4545:b0:342:94b:aa28 with SMTP id
 5a478bee46e88-34f219610a0mr4295623eec.27.1790970257502; 
 Fri, 02 Oct 2026 12:44:17 -0700 (PDT)
Received: from localhost.localdomain
 ([2603:8001:5f01:8bab:bcf9:6140:24a9:d1e7])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34f14fcd065sm7236803eec.19.2026.10.02.12.44.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 02 Oct 2026 12:44:17 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 CK Hu <ck.hu@mediatek.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Simona Vetter <simona@ffwll.ch>, jason-jh.lin@mediatek.com
Subject: [PATCH 6.1.y] drm/mediatek: Fix potential NULL dereference in
 mtk_crtc_destroy()
Date: Fri,  2 Oct 2026 15:44:12 -0400
Message-ID: <20261002194413.20810-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 04 Oct 2026 17:18:49 +0000
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

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 4018651ba5c409034149f297d3dd3328b91561fd ]

In mtk_crtc_create(), if the call to mbox_request_channel() fails then we
set the "mtk_crtc->cmdq_client.chan" pointer to NULL.  In that situation,
we do not call cmdq_pkt_create().

During the cleanup, we need to check if the "mtk_crtc->cmdq_client.chan"
is NULL first before calling cmdq_pkt_destroy().  Calling
cmdq_pkt_destroy() is unnecessary if we didn't call cmdq_pkt_create() and
it will result in a NULL pointer dereference.

[ Backport to 6.1.y: used the older Mediatek CRTC file and helper names. ]

Fixes: 7627122fd1c0 ("drm/mediatek: Add cmdq_handle in mtk_crtc")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Link: https://patchwork.kernel.org/project/dri-devel/patch/cc537bd6-837f-4c85-a37b-1a007e268310@stanley.mountain/
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and drm mediatek maintainers,

I am working through the small CVE backports still missing from 6.1.y.
This one addresses CVE-2024-53056. It skips command-packet destruction when
channel setup failed before packet creation.

The corresponding 6.6.y backport is already in the 6.6.y stable queue.
The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not
in 6.1.y.
The target-specific adjustment is recorded in the bracketed note above.

Could you please queue it for 6.1.y?

CVE: CVE-2024-53056
Upstream: 4018651ba5c409034149f297d3dd3328b91561fd

AI assistance: An LLM helped identify, adapt, and validate this backport; I
reviewed the resulting code and validation evidence.

Thanks,
Artem Dinaburg

 drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index 59b310f7327c86..8e72b3bb51eb94 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -161,9 +161,8 @@ static void mtk_drm_crtc_destroy(struct drm_crtc *crtc)
 
 	mtk_mutex_put(mtk_crtc->mutex);
 #if IS_REACHABLE(CONFIG_MTK_CMDQ)
-	mtk_drm_cmdq_pkt_destroy(&mtk_crtc->cmdq_handle);
-
 	if (mtk_crtc->cmdq_client.chan) {
+		mtk_drm_cmdq_pkt_destroy(&mtk_crtc->cmdq_handle);
 		mbox_free_channel(mtk_crtc->cmdq_client.chan);
 		mtk_crtc->cmdq_client.chan = NULL;
 	}
-- 
2.39.5

