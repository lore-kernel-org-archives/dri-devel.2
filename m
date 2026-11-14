Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298B1606A329
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 03:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dsQQAJCE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72BB010EC8F;
	Sat, 14 Nov 2026 03:05:11 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56E9310EC8F
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 03:05:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C48C961829;
 Sat, 14 Nov 2026 03:05:03 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794625503;
 b=J8f0tNzAoeqA6bt6bZMX1Kz4qr7TR3mD3vZsT9fgK/NeyXEDiItBaHBFKtGwGExr86H4
 bpEwWpbtYD4LaJM4UT3FO9TVdB8Pmb8a7DJ+D4BWzfkkaugmgbxpfZww7XkDebAySx7nN
 hg89iKFKd/CgXe8gml5Rbja+jIyHZGUZD899nvsjeAhuXBuo7KF1ZK/HZnlbe04RmiBmP
 y3YOsSak6es828cQ4zygZ8bzIsmp0dJ8R7KYt2CzAjZWq5NBoBLg11kO5jB04teBcpBGf
 E9jn51IJnj7tJIA2aTyiAJBiROp+mVuhIkWF0Wq4f5JDw8rXrVWVQvKaB5CMqGoxZPQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794625503;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=Y9ifVyX+xXeCkYDWja+mpKNcQbBFNeS0/TBPyjUGODI=;
 b=TUKR5SiQn1sKa65JwZxWxqyXL+3B367DuvES/8qvFuw0S26wh4Sa/hCYe+bG+NggafRL
 UnnxIl+/JwnPqu4aH7Axy+FatMRtcCNlaut6H8NVZKgp+sj0vqPA5h7XABJXFlF8lcxrG
 yp1PJoUy/s3KlrKFKWCl3oyW2vVWqkEMRoU05jVW6VfpFWgieFShGM8pndKLT9m9ryvI7
 WadSTFOU1fl5CplTMeqXkP9WyQ54cVvr6ZNYdOjUWpBeWhUmcGZShLg0DJDefBTh1owYK
 cF8sysVeeiDgL3MSFZPcll7c7bWgmBURLy67Wcm+cYdIMSlOzolCl2dc47qc/qGKBPQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 02AB91F000C4;
 Sat, 14 Nov 2026 03:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794625503;
 bh=Y9ifVyX+xXeCkYDWja+mpKNcQbBFNeS0/TBPyjUGODI=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=dsQQAJCEDLc3dyY5fgIHpNPnz1Tis7BhbX43TNiWeonpHk1IrfnHn1PSaSfePq9Ng
 fO78kk+I4hkHgbciHkBZ+N5HOxtawJyoj/YBBj+IImou/30OB/oNfkfjTcrV72Rfgz
 qnxyMZJ6Te2jW7JrmBGLUpa6ZYjT8o3/qFGA3T58ANr/aQjhV+FN1DiPBudOpMMrTs
 Y+wB4acohP7OTmkFfh879F43o/bmhKg2CKkqwWB5j5vIegp84VlnpPVm/8TZCdzRQJ
 Wj8KKsEFZvdzzmoeSGODFyIjIa79wN1RxHS3DJgMmwd8cu4vLhiZXRmbe0MqM8dS54
 euGQC2G9/VEbw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 8107B49C4B;
 Sat, 14 Nov 2026 03:05:02 +0000 (UTC)
From: Haipeng Lin via B4 Relay <devnull+jimmie.lin.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 22:04:55 -0500
Subject: [PATCH] drm/panel-edp: Add LG LP129WT332166 panel
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261113-sp11-panel-lgd0779-v1-1-1020a0f2f83d@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvyJ7bsE1UOor0aFyq4UwUYhA/HvSc
 QZmCmROwhlGVSDxI1nu0IA6Bdu5hINRfGMw2lgi6jFHIoxL4Auvw2vnBlybJzLWGT1AC2PiXd5
 /Os21fq1DhhpkAAAA
X-Change-ID: 20261113-sp11-panel-lgd0779-b11311267209
To: Douglas Anderson <dianders@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Haipeng Lin <jimmie.lin@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794625502; l=2909;
 i=jimmie.lin@gmail.com; s=20261011; h=from:subject:message-id;
 bh=k1zdeOuZKmI346GK/WJs+LsEMnIwuG5UcbSu0sYIEIA=;
 b=uCgZPWh+NTVyBWtti2DSCdUFQRqqylx3b7GtGWNo+59m0mVMHyIJCudgKJMzTuzWzHB4otRsj
 zXiTBeA0L87DT8r6TKXUgiCs8lhP82U84fPepy8lJ+ET2nYdc3dVOEJ
X-Developer-Key: i=jimmie.lin@gmail.com; a=ed25519;
 pk=3KDRF1RQ/9A7ZUVTdRVEZnVrGltdmq1bRocsOYeXezI=
X-Endpoint-Received: by B4 Relay for jimmie.lin@gmail.com/20261011 with
 auth_id=1164
X-Original-From: Haipeng Lin <jimmie.lin@gmail.com>
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
Reply-To: jimmie.lin@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Haipeng Lin <jimmie.lin@gmail.com>

Add an entry for the eDP LG LP129WT332166 panel used in the Microsoft
Surface Pro 11 (LCD variant).

No datasheet available. Delays were not derived from ACPI or firmware
tables. delay_200_500_e200_d200 was copied from the entry for the
closely related LG LP129WT232166 (LGD 0x06b2, Surface Pro 9 5G) which
most LGD entries also use.

Tested on Surface Pro 11 with ftrace (function_graph on
msm_dp_wait_hpd_asserted and gpio events for panel power).
Tested 22 cycles DPMS off/on, suspend/resume successfully with no prep-
are retries. HPD asserts 179-182 ms after panel power-on within the
200 ms hpd_absent.

Cross-checked that the Windows display driver qcdxkmext8380_DENidp.bin
waits 500 ms after power-off, which agrees with the 500 ms unprepare
delay.

edid-decode (hex):

00 ff ff ff ff ff ff 00 30 e4 79 07 a1 21 00 12
00 21 01 04 b5 1b 12 78 03 f0 70 aa 50 4e a8 26
0e 4f 53 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 fd 00 18 78 f0
f0 48 01 0a 20 20 20 20 20 20 00 00 00 fe 00 4c
47 44 5f 44 56 31 2e 30 5f 0a 20 20 00 00 00 fe
00 4c 50 31 32 39 57 54 33 33 32 31 36 36 01 48

70 20 79 02 00 20 00 19 3c e6 24 79 07 a1 21 00
12 00 17 0d 4c 50 31 32 39 57 54 33 33 32 31 36
36 21 00 1d b4 0a 26 07 40 0b 80 07 00 ac aa 50
e1 f4 a7 62 e2 0e f2 f4 52 b0 60 b0 60 99 35 13
78 26 00 09 06 00 00 00 00 00 40 00 00 22 00 28
c0 e9 0a 84 3f 0b 63 00 07 80 1f 00 7f 07 4f 00
41 00 07 00 c0 e9 0a 04 3f 0b 63 00 07 80 1f 00
7f 07 1f 08 41 00 07 00 00 00 00 00 00 00 d1 90

Assisted-by: LLM
Signed-off-by: Haipeng Lin <jimmie.lin@gmail.com>
---
This adds LGD 0x0779 panel based on similar entries for the SP9 LCD
panel (the datasheet is unavailable) and live testing based on a
v7.2.11 downstream kernel for the Surface Pro 11 with this patch.

Thanks,
---
 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 3e0bdae8e272..6b9cc771e88e 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -2200,6 +2200,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('L', 'G', 'D', 0x05f1, &delay_200_500_e200_d200, "Unknown"),
 	EDP_PANEL_ENTRY('L', 'G', 'D', 0x06b2, &delay_200_500_e200_d200, "LP129WT232166"),
 	EDP_PANEL_ENTRY('L', 'G', 'D', 0x0778, &delay_200_500_e200_d200, "134WT1"),
+	EDP_PANEL_ENTRY('L', 'G', 'D', 0x0779, &delay_200_500_e200_d200, "LP129WT332166"),
 	EDP_PANEL_ENTRY('L', 'G', 'D', 0x07fe, &delay_200_500_e200_d200, "LP116WHA-SPB1"),
 
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x1511, &delay_200_500_e50, "LQ140M1JW48"),

---
base-commit: fc72cd52fb284f3707fa36a68ea5a22543a51d71
change-id: 20261113-sp11-panel-lgd0779-b11311267209

Best regards,
-- 
Haipeng Lin <jimmie.lin@gmail.com>


