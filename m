Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79569606C941
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 12:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dmPWVoyC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 569EA10F41E;
	Tue, 27 Oct 2026 12:02:07 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BCBB10F41A
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 12:01:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 500A46021D;
 Tue, 27 Oct 2026 12:01:50 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793102510;
 b=3WBQYccgjVrqwevOvCQ5TnU9AnyD9gpqaeiK/SGVP/kfO10plY/6G/Hi5ZTKkUsD913s
 AIFpdcD8ktOF/VGvh0KfaiXP3OMvaggVtiHt68g/RZllbztVoaiywIgcM1CywVTiTp6ow
 xkxw5wL9E2y7vv88rtVupTHNtXQO2G+SbsZccStn3vXekBJHGWu/eeTPVdQmbVAGLni1C
 iPrMy9bc6Qg5MZuFm4hit2wMQlPIeNw/PB/DjKi237X6O6E2tVC2ww18BtJ70gST7n1kL
 6UUue8o7ic3nbqKCfQlzgZp/z9X0UD4WElCCU6vyLBgjRdjMFcX9UUoSH6OsYMkvKYQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793102510;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=7L8M1iP1QH6iutHY0JulFrTECdA08ORV1N5WHofrpBc=;
 b=aFKyp9f48LWpzM1Iwj5VMmWSce9DzX6N1UHtVsKBb3b5o91YWFpsyBTOSk3UklfC4k4r
 iH1Glegahv3tGK4mFLlYx1iLL3C+m4vkWYbQ1An0nsgD9+cWMXXzldz4ihmURu/JZ7UEC
 yawhc0n7vX1qzdNJlUMwClm905J5bcD4x8dPH8bF0On5K0zOik2xCamyuPjPVl5xita7L
 G+HuI78qWLASCoaiOka82MUpRfqdyAcAQhB+4yiT17aSyOy4errltgHJgjtnT6L7hIGQp
 LvNrlClj62mdWgPJ//YUweHUsKJI5iY+zIR07gq4TigiXGQovnLNOGzFt2r9lkY6PXg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 6F0BA1F01240;
 Tue, 27 Oct 2026 12:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793102510;
 bh=7L8M1iP1QH6iutHY0JulFrTECdA08ORV1N5WHofrpBc=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=dmPWVoyCg38cMuvYN/x0mUrO9j72CBtuBZFjJWNpwDlcPj+It4A33L6fpdxd3+qjI
 tkcbmS/wuCpmyJsQQpQcSyzbpnoqnIjRhMCe+x8goEBcrRd0U5nAivq52VPIN6AVva
 pdjLgAAEcAoDXcYT0LJCjLNlSRcieZGmxlN0RlpHQqNXvVvqUTgayJdAJjNxdCDLFN
 ZpbEgElD1JWJIfnOaqdscYhM1mY11cQYDrCRl6w0vep7X4Qln1uegDvPYi4QbG4NdY
 s4Q0wGD4wvUw+oR1/r3Kg1PNYVuyVPmxmJeTx738pZii9QN8eRdYfc1+VyhWVQjSAs
 qPz/qBQ7oFm2A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id E42D1450B8;
 Tue, 27 Oct 2026 12:01:48 +0000 (UTC)
From: Alexandre Marquet via B4 Relay <devnull+tb.a-marquet.fr@kernel.org>
Subject: [PATCH 0/3] DRM Google Nexus 10 display support
Date: Tue, 27 Oct 2026 13:01:41 +0100
Message-Id: <20261027-drm-misc-next-manta-auxbus-v1-0-3a45c3cf531d@a-marquet.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKWS4GoC/yXMSw7CIBAA0Ks0s3YSSuP3KqaLAaY6JqBhwJA0v
 buoy7d5KyhnYYXLsELmt6g8U8e4G8DfKd0YJXSDNfYwGjthyBGjqMfErWCkVAipNlcVj27vzBL
 OZKYT9OCVeZH2y6/z31rdg335jrBtHzB4lBJ+AAAA
X-Change-ID: 20261023-drm-misc-next-manta-auxbus-7b5b0fd9a038
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793102508; l=1681;
 i=tb@a-marquet.fr; s=20261023; h=from:subject:message-id;
 bh=f1oj+Wwd1+MToNnaYOltu8jkeNrOGt2+b4GvKUkx/kE=;
 b=Q0u6yl+Xldh8lvEwFZiCC6j8shd8C4WEjiYDtBxaeb0XJroPskxBtvIJTcwV/EGuT4XB09eLL
 r+xuM9wpOfMA+j1X2uFV2iSJPDad00KP9+96VeELoZoM+EysL0shsAK
X-Developer-Key: i=tb@a-marquet.fr; a=ed25519;
 pk=zVRSO6FDK46rqmeA2GuzAhM24eFlUq1QpmXi9/KCFyk=
X-Endpoint-Received: by B4 Relay for tb@a-marquet.fr/20261023 with auth_id=1334
X-Original-From: Alexandre Marquet <tb@a-marquet.fr>
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

This series proposes to add an entry in panel_edp for the panel used in
the Google Nexus 10, as well as two modifications in analogix_dp and exynos_dp,
which allow to effectively enable the use of aux-bus on the platform.

It is actually a follow up of [1], with only the drm patches kept, as suggested
in [2].

I preferred not to label this series as v2, and opted to change the title
instead. Indeed, this series contains only drm patches, which are actually all
new with respect to [1], following the guidance received to use aux-bus if
possible (in [3]), which it is, building upon recent work on analogix_dp, and
after applying the patches of this series.

[1] https://lore.kernel.org/all/20260423-manta-display-v1-0-196f80c5673a@timmermann.space/
[2] https://lore.kernel.org/all/20260425-uncovered-otter-of-sunshine-d00ed0@quoll/
[3] https://lore.kernel.org/all/CAD=FV=VNvPtG_f1W942SKJfM4ptK8Wvd-nZs4geBCG3bO_A0BA@mail.gmail.com/

Signed-off-by: Alexandre Marquet <tb@a-marquet.fr>
---
Alexandre Marquet (3):
      drm/bridge: analogix_dp: deassert DP_PHY_PD on power-on for exynos
      drm/exynos: exynos_dp: change poweron/off to encoder enable/disable
      drm/panel_edp: Add SEC LTL101DL02-002 panel

 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c | 19 +++++++----
 drivers/gpu/drm/exynos/exynos_dp.c                | 40 ++++++++---------------
 drivers/gpu/drm/panel/panel-edp.c                 |  2 ++
 3 files changed, 28 insertions(+), 33 deletions(-)
---
base-commit: cf61bef3801c3c9d0d8c39026b7b2fb242898a3a
change-id: 20261023-drm-misc-next-manta-auxbus-7b5b0fd9a038

Best regards,
--  
Alexandre Marquet <tb@a-marquet.fr>


