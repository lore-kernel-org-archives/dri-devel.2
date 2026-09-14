Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F008EC88E7D
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 07:28:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 259D410F9F8;
	Tue, 15 Sep 2026 07:28:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=cyberprotect.ru header.i=@cyberprotect.ru header.b="IAV6QyNQ";
	dkim=permerror (0-bit key) header.d=cyberprotect.ru header.i=@cyberprotect.ru header.b="ySXOaoe0";
	dkim-atps=neutral
X-Greylist: delayed 2172 seconds by postgrey-1.36 at gabe;
 Mon, 14 Sep 2026 14:33:26 UTC
Received: from mx2.cyberprotect.ru (mx2.cyberprotect.ru [176.10.93.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A334210E2D1;
 Mon, 14 Sep 2026 14:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=cyberprotect.ru; s=dkim-r; h=MIME-Version:Date:From:Sender:Reply-To;
 bh=G7k+5ltUYjwES1HZ+tIrvRED7WHcVnAbVMsryiyMzYI=; b=IAV6QyNQXJUIg8acSVFC6THTCw
 WBHaUHAPEEMCe/djnyt516IwdSuKhD4bzNXH6J7prLpCeT0LJ6EATfTgW/2wVX4tjzeRA6Uf4jB1D
 Qf3fJfGkqhThFGfeMhdpzSb7ohUuICHI2NUQLutuxM5XvPFHLaYhF+gX/DWp6ofXVdoCjRJNL7rE4
 MGRmceJXYPRSzRg0Xsnjy/yk4E1siAoK+X7YI+MfYmhkFVusE0mPHSAEfTsgbHTmFmxwWHVHn4Nlq
 Eo6Pem+TONK6/x8WZXSPl0S7B7rmUMUyIBYaMyHSTCSGTqkDNee0aig5/3mxy9Z070t4ebVaSoCdL
 fozrA4eg==;
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
 d=cyberprotect.ru; s=dkim; h=MIME-Version:Date:From:Sender:Reply-To;
 bh=G7k+5ltUYjwES1HZ+tIrvRED7WHcVnAbVMsryiyMzYI=; b=ySXOaoe0A71bsidyk23w2to3m8
 TRsAEjiBzayhV2sFsHMPC/03gAgfyQS+K+3EK1oQf9szHwJZcS8XFVwit/Dg==;
From: Dmitriy Chumachenko <Dmitry.Chumachenko@cyberprotect.ru>
To: Alexander Deucher <alexander.deucher@amd.com>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David
 Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Hawking Zhang
 <Hawking.Zhang@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>, Dmitriy
 Chumachenko <Dmitry.Chumachenko@cyberprotect.ru>
Subject: [PATCH] drm/amdgpu: check ras and obj before dereference
Date: Mon, 14 Sep 2026 17:33:03 +0300
Message-ID: <20260914143303.90614-1-Dmitry.Chumachenko@cyberprotect.ru>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.0.30]
X-ClientProxiedBy: AIP-EXCH-1.aip.ooo (10.77.28.101) To AIP-EXCH-1.aip.ooo
 (10.77.28.101)
X-Mailman-Approved-At: Tue, 15 Sep 2026 07:27:57 +0000
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

nbio_v7_9_handle_ras_controller_intr_no_bifring() dereferences ras and obj
without checking either for NULL. Both amdgpu_ras_get_context() and 
amdgpu_ras_find_obj() can return NULL, e.g. during the window between 
adev->nbio.ras being set (early in amdgpu_ras_init(), by design, to 
enable the fatal-error interrupt as soon as possible) and the PCIE_BIF 
ras object actually being created in RAS late_init. Any interrupt in that 
window crashes in hard-IRQ context.

This is analogous to commit d190b459b2a4 ("drm/amdgpu: the warning
dereferencing obj for nbio_v7_4"), which fixed the same issue in the
nbio_v7_4 handler.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 7692e1ee2446 ("drm/amdgpu: add RAS fatal error handler for NBIO v7.9")
Signed-off-by: Dmitriy Chumachenko <Dmitry.Chumachenko@cyberprotect.ru>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index 8e401f8b2a05..2b3a1b9f8efc 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -518,7 +518,7 @@ static void nbio_v7_9_handle_ras_controller_intr_no_bifring(struct amdgpu_device
 						RAS_CNTLR_INTERRUPT_CLEAR, 1);
 		WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_DOORBELL_INT_CNTL, bif_doorbell_intr_cntl);
 
-		if (!ras->disable_ras_err_cnt_harvest) {
+		if (ras && !ras->disable_ras_err_cnt_harvest && obj) {
 			/*
 			 * clear error status after ras_controller_intr
 			 * according to hw team and count ue number
-- 
2.49.0

