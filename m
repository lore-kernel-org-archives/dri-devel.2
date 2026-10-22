Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8C6606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jo2KYR/t
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A05D1112653;
	Thu, 22 Oct 2026 13:31:01 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 636D2112644;
 Thu, 22 Oct 2026 13:30:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 76F9A60261;
 Thu, 22 Oct 2026 13:30:54 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1792675854;
 b=dqLzbgoPYdh6JJ/+lVzgRiUgRhP+yNOkGpUoJ6655iYTJEDOpOkj+gIbQG1EAEFI/JBX
 Jjc8zqUKfiwSOIYlgEmTtG8xDj0paaQ1Rh0v6mc7h4rIOK9KCnvonecmBkMjJ7WY5HG88
 IDCIWbFPaKW/kaa+5vSEqaEJHQj9gahUIlzpMhu0YeIwFwxhKOHb56umlMVe1HBnDwf9/
 5g29z/3qMuBBQdhGk1BVekjh7UqJramwrbvNYPnh78HvwVuBDcRIC2SviouZR7mB1hoM9
 Dh8qXExqv8gdowTrHc/Y16Et8r7/YZBAjmE9SJB32C/dKb0ea7qfTjgqCAMlo2pNQJA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1792675854;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=+AamR2t10jwkIlhrDFzp5udX6obvpbnAT/+V6bWlyOA=;
 b=lVHMnuIGubu9z87mYxOGqkaC+0DXRjjXm2m7YUysz3vkP0KdQ+gxmHtMKcgglQbeR6HE
 b9NL5UAacC509dgHRRUNwjSZHuYoJRrSTVQAJt+/rQYNsui5YtyJY1O4FMPhDarAcIaCe
 uA9bUWEVOQTxKzoS+H5o0I4cCSbTQwqGf+wMj6KTDkCIHTI5tV82Y1qbGfY/ijh0lPGbb
 I2+bU5ZtBXoJ8rjyl6CwIm5BP2Qeu8lcdOCwMoBv+nCpintixwMRxupQ845dXr0irwAt5
 mylNFVin4Fgevj4gf8ZHJf+mAKb9NvHy7hovZwPnoDH2gtNnWQPsdgZ/tWeBU9911JQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id A8EB11F000C5;
 Thu, 22 Oct 2026 13:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792675854;
 bh=+AamR2t10jwkIlhrDFzp5udX6obvpbnAT/+V6bWlyOA=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=Jo2KYR/tUZ+dhcacoWFpIHJ8pZg/xGdIz+91/sYCy2g44n67xKF1PK244ejnJ8oSc
 MiaHPohBAGwlo0PrnGbTJ0+KAuyR4sa80JI0tjmlJnT+F5ksYCq1+ZchSYqyEteVTH
 iisLpbmpa7pxaNpg1nHq0YDIctdij/SupwRamxx3oJdziKzOy3vxIfWWl1spM0qdEh
 XSoHcgV7gugLBCil4cPNNVN608C/UR/QIwZcoX1ueMBciAabdqZC1xM2CfljyyI5dr
 Mr9dkC6J0zsSroE8azalJZ5aEWE0ElCdD6sykPlidNhK8hKI0UDRX7GARrW92EBbJ3
 F3wuHUeTTy5Mg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 03FBD43397;
 Thu, 22 Oct 2026 13:30:53 +0000 (UTC)
From: Kylie C via B4 Relay <devnull+kyliepc.proton.me@kernel.org>
Date: Thu, 22 Oct 2026 09:30:38 -0400
Subject: [PATCH] drm/amd/display: Don't select zero V_TOTAL_MIN/MAX on DCN2
 seamless boot
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261022-dcn2-seamless-vtotal-v1-1-6ceb87f98629@proton.me>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQrCMAyA4VcZOS/QRifiq8gOXZNpZHbSdEMYe
 3erHr/D/29gklUMLs0GWVY1nVOFbxuI95BugsrVQI5O3hEhx0RoEp6TmOFa5hImPHSe3ZmJx+4
 INX1lGfX92177v20ZHhLL9wX7/gE8A/SNeAAAAA==
X-Change-ID: 20261022-dcn2-seamless-vtotal-351d08d2df54
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Kylie C <kyliepc@proton.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792675851; l=1577;
 i=kyliepc@proton.me; s=20261022; h=from:subject:message-id;
 bh=E3b6PcfPUilGy4eYSVtJ/EqKpq1VZvJ1nhCA//JGxdU=;
 b=LrrKoFxk1Om3OmiLoo28vF48JCMXdd3ru7QQl5pl++6C/ufZ2XgsqRdZquDPC+Mz+7FliTljS
 bJleZsBuTJpBZSVEvjnsQC44W2F3xz+jUZhp6SP2UKYfKJSE1EcInDA
X-Developer-Key: i=kyliepc@proton.me; a=ed25519;
 pk=T/yRT5OdlaWnEmvYU6894i5NEH44SmsyRlMNTde5DDs=
X-Endpoint-Received: by B4 Relay for kyliepc@proton.me/20261022 with
 auth_id=1285
X-Original-From: Kylie C <kyliepc@proton.me>
Content-Transfer-Encoding: 7bit
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
Reply-To: kyliepc@proton.me
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Kylie C <kyliepc@proton.me>

Initialize V_TOTAL_MIN/MAX to V_TOTAL before enabling the selectors if
they are still 0, as optc1_program_timing() does without seamless boot.

Tested on Renoir (DCN 2.1) eDP with amdgpu.seamless=1.

This removes the flash between the bios logo & plymouth on my laptop.

Signed-off-by: Kylie C <kyliepc@proton.me>
---
Fixes the black screen when enabling amdgpu.seamless=1 on Renoir APU

With this plymouth smooth boot is possible on this hardware
---
 drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c
index 73cc8a713..2cdfe3d7a 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c
@@ -449,6 +449,13 @@ void optc2_lock_doublebuffer_disable(struct timing_generator *optc)
 void optc2_setup_manual_trigger(struct timing_generator *optc)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
+	uint32_t v_total, v_total_max;
+
+	REG_GET(OTG_V_TOTAL_MAX, OTG_V_TOTAL_MAX, &v_total_max);
+	if (!v_total_max) {
+		REG_GET(OTG_V_TOTAL, OTG_V_TOTAL, &v_total);
+		optc->funcs->set_vtotal_min_max(optc, v_total, v_total);
+	}
 
 	/* Set the min/max selectors unconditionally so that
 	 * DMCUB fw may change OTG timings when necessary

---
base-commit: 77f548b127c6de34ce271fa09ba270cb1ef9f2da
change-id: 20261022-dcn2-seamless-vtotal-351d08d2df54

Best regards,
--  
Kylie C <kyliepc@proton.me>


