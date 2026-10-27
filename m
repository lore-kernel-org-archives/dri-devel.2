Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78AB60A381F
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 12:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XlEtH5aB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4715C10F41A;
	Tue, 27 Oct 2026 12:02:01 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4147010F41F
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 12:01:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 84D4860232;
 Tue, 27 Oct 2026 12:01:51 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793102511;
 b=u7TS03UhmkoK5z0qffu3vDcXH5qwoOdX3UMCWlJMW8cgGBAW+h5ZWQErrDu0j94SUpoS
 eBTBRSteyYvI6BlwNC3cEftVKSx8J4/bzSEL+x6axRPU4TgpvEIK0WCo/8ox8ssgbtl4v
 5g+S1lhOAlB2eUMywpbBP39TantL5/+K/ZybkuE8mNeO7sWjhnQzTQYAh+icA2vQ4hBrG
 9aP7IB13aeZD+y4DuLBYad1c5Qd2EkSZ+xCuGHUDcqn1AngMnbjtJ+CmY9E78EjXZsm2f
 kzIJaSDe8L9JZscl+40qZ2XClpj2y077mLkAUWj3j71uSqlmz1li/4C87JfetE4lKNQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793102511;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=9PKoT2dIlJjvHTGxbwsQtrc6PkpA5XS+xE62DA1tMf8=;
 b=eUuDoWn21FvOTmLsdsLn/kaS3RD08/U+hrcuO5E+8FvvGAhbjSajaJL3wEQno5RKeoB5
 FVGpo5CoyO4lWCnjDL2Unr4vpW1Zs87YPac8XV+zEhDkrc7s5gZ14M1LPvblVbTBCZRIq
 42figRPtgVUp6X+FiX+N/A0FO8Nlk1nwdsiNrz026PrmMnTU35fkTEBuu7vwwbUbq5GAK
 JAiyNXuYeh8UwZLLhmFb6EWuitqBBLztBYQ9AtYxSjeIxGIAoAQkA4C7NBNDnTDoGZzjO
 45enb+MkOYgd+uNwy/FOjItCB8VZPjgreg0s6nPfsas6MfZxx+42XByC6YQJLIYQ7SA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 8DD881F01244;
 Tue, 27 Oct 2026 12:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793102511;
 bh=9PKoT2dIlJjvHTGxbwsQtrc6PkpA5XS+xE62DA1tMf8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=XlEtH5aBTOcIcxQsLqDWZ60DYPqcIzCiM2EzxX0ul8hkxGKe91qKNVAmkXRtzrafD
 c7MYncU6sKdPCMMG+OmdVB6Q9iiNXwSufwPmqowb8PbM6BY4luQ58majTAptmV8Nff
 o1rIIhecgr+pHaxQikYg5Zn2sCluc3x9eRbQZLUQYnIGFOhDam+u/NqKo65jdwu1Am
 sZXIVPa4vSr5Q5KvpF/wNGE19652DuysTTVAtWlqEWK23L3EknWoaItmIKi9ffIWW2
 3/82edMSeqKJcRmCBx8ZWYlk0NYnuNGjIU0XY/lkZeZq7XufdPGRbnDr9unOebiUP9
 vORj1VZShRSiw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 19A3A450C0;
 Tue, 27 Oct 2026 12:01:49 +0000 (UTC)
From: Alexandre Marquet via B4 Relay <devnull+tb.a-marquet.fr@kernel.org>
Date: Tue, 27 Oct 2026 13:01:44 +0100
Subject: [PATCH 3/3] drm/panel_edp: Add SEC LTL101DL02-002 panel
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261027-drm-misc-next-manta-auxbus-v1-3-3a45c3cf531d@a-marquet.fr>
References: <20261027-drm-misc-next-manta-auxbus-v1-0-3a45c3cf531d@a-marquet.fr>
In-Reply-To: <20261027-drm-misc-next-manta-auxbus-v1-0-3a45c3cf531d@a-marquet.fr>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jingoo Han <jingoohan1@gmail.com>, Inki Dae <inki.dae@samsung.com>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Douglas Anderson <dianders@chromium.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 Lukas Timmermann <linux@timmermann.space>, 
 Henrik Grimler <henrik@grimler.se>, Hendrik Noack <hendrik-noack@gmx.de>, 
 Alexandre Marquet <tb@a-marquet.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793102508; l=1407;
 i=tb@a-marquet.fr; s=20261023; h=from:subject:message-id;
 bh=4fctdAPZww1iVpPpwL2XCKsDWQyA0MaebiMf6gEsHbQ=;
 b=o3A1Ojwx5Tfs8ZqshJEniFaiuo4fpm96yAtfpomYTagxOiFN/Aj/7xsp+e0gp6OkNJjnZ7YW9
 ED3dMu2pOFfA+VHKoZ0ZfcyGqxEBS+XvTS8mz7I2OZfGQwjbqBh1wcq
X-Developer-Key: i=tb@a-marquet.fr; a=ed25519;
 pk=zVRSO6FDK46rqmeA2GuzAhM24eFlUq1QpmXi9/KCFyk=
X-Endpoint-Received: by B4 Relay for tb@a-marquet.fr/20261023 with auth_id=1334
X-Original-From: Alexandre Marquet <tb@a-marquet.fr>
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
Reply-To: tb@a-marquet.fr
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alexandre Marquet <tb@a-marquet.fr>

Add an entry for the eDP SEC LTL101DL02-002 panel used in
google-manta.

Raw EDID dump:

00 ff ff ff ff ff ff 00 4c a3 0f 9c 00 00 00 00
05 0e 01 03 80 21 19 78 0a 87 fe 98 57 51 8c 27
21 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 14 69 00 a0 a0 40 2e 60 30 20
36 00 1e d6 10 00 00 19 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 9e

Signed-off-by: Alexandre Marquet <tb@a-marquet.fr>
---
 drivers/gpu/drm/panel/panel-edp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 94bc54c3833a..c92985363093 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -2198,6 +2198,8 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('L', 'G', 'D', 0x0778, &delay_200_500_e200_d200, "134WT1"),
 	EDP_PANEL_ENTRY('L', 'G', 'D', 0x07fe, &delay_200_500_e200_d200, "LP116WHA-SPB1"),
 
+	EDP_PANEL_ENTRY('S', 'E', 'C', 0x9c0f, &delay_200_500_e50, "LTL101DL02-002"),
+
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x1511, &delay_200_500_e50, "LQ140M1JW48"),
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x1523, &delay_80_500_e50, "LQ140M1JW46"),
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x153a, &delay_200_500_e50, "LQ140T1JH01"),

-- 
2.43.0


