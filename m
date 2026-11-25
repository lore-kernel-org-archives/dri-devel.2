Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9E1606A33D
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 13:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JBT82xLo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8688910FBD8;
	Wed, 25 Nov 2026 13:08:38 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C39410FC1B
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 13:08:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6E6F14345F;
 Wed, 25 Nov 2026 13:08:31 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795612111;
 b=fykVc78nsD/WibQTP/FrO+p0nBltmlqmxOJR/D3fH7P0X85ZJGo0ELnj0mwjmp066I/k
 +kLDUemBZeZMs5PUw3emJLRdHosPBkKkC/NjP7YEHvxqpo2ugd9/DXhnqdxAq45AYU56z
 zMeLN69TO50aNks5l3SVDjAW9MxXqA7AAyPqhyMtC2pTTy+5evt+KODqRYq6fBptG5xbF
 uY+cJOqZ+Hqd5jeLm8ZQ+mc/yfEwG5que3PZ7q/S/hRE0H3/2Rh/7g9Pd5II9PWBXXxjf
 E9hQcOwJJmJm6xNQyxx6ciG0rQAVZ8cnUyXB01iVLDOuzXRgdOZChSdD6B5G3HlKPJA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795612111;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=aXJr4z99n0IsW5VU0Ka0thQEbMpW1cePBGzNA1i1HPQ=;
 b=iY6JnQraT8AkgPXZlfKHBPXDNsufhfudaQhaW8nUphLVhRvTUz78D4B98jfpLzBZmY6q
 HAX3c1JHGrtW8/1euT2or20PV30hbL65ffdHpMPbeEkoP0UAofdgQhp7NVvygT0tvOlR2
 g729XGUqWkwXeRyhsbu4D+A9qYiVHfSpvgdhf4TN8p05YykYUB7hIJkKTEj9q2saGbNRV
 Fqxgf3oOhIOh75erMTGvpwfUoFs/PeS/zUAzo7mYhNPVA0JF1Ak/dm86joYCqmKaZyzo1
 LdV7quS8wMrkvHTvI8FkZoFTG5dnkS3ffr6tmg++A8o3jBePMelaG5a8q9oaaxwBbIg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 700481F000D1;
 Wed, 25 Nov 2026 13:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795612111;
 bh=aXJr4z99n0IsW5VU0Ka0thQEbMpW1cePBGzNA1i1HPQ=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=JBT82xLonbXw+vz7MT1Ugz3nnS+kZsPWFM21aEpRrhQzrIBURFdTRuYZUJ3QwYLMI
 us4w4oWPNaCpkCI44119ogxmxKF4fnJAGnAGw6EPcT2LIA6aQJaI2Puqx9G2qnHNMb
 e5lJOGVWbChtcCr/C8lEXD4eh/SIph5iYlOk7vMbo9C6TZ9ArqDZ8ufKhkVkoijBBi
 2AN9licjaX/W1HY9PisJsCSswpshSz9vys20Mie7id6mlm9CzRJJw0UewyzwUbyvCi
 8ayjPJG7GNGYdILaVWHE3eBzikLD3ZhhNxezlryV0Rrd3vqC6rfgGQN0Vlag9ATWBP
 c6VRYGsU3bU5g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id C0CDE4CECD;
 Wed, 25 Nov 2026 13:08:18 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Subject: [PATCH v3 0/5] Pixel 3 display fixes
Date: Wed, 25 Nov 2026 14:08:11 +0100
Message-Id: <20261125-fix-blueline-panel-v3-0-914b4a30b73e@ixit.cz>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NTQ6CMBQE4KuQrq0pLQHrynsYF/15lWcIkhYal
 HB3W1zowricZOabhQTwCIEci4V4iBjw3qcgdgUxreqvQNGmTDjjNTswSR3OVHcTdNgDHVQPHVW
 O68bIunHckjQcPKTWhp4v7xwmfQMzZik3Wgzj3T+211jm3t+DWFJGoXFC1Rp06dQJZxz35kkyH
 /kXULKfAE+AFFVlndVGOPkB1nV9AWV5g/kFAQAA
X-Change-ID: 20260809-fix-blueline-panel-af2b7c967f2d
To: Abel Vesa <abelvesa@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Maxime Ripard <mripard@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Vinod Koul <vkoul@kernel.org>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1515; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=hS+2R1WEEhHdtFJdBzf8GuRaPhYVXr3NowJRCDOllIQ=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBrBt3BGEprGvWIkV5M/UhQEk9sj1jUQjrHcBET+
 OWocuRD5+yJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCawbdwQAKCRBgAj/E00kg
 cmrQEACDRepoXdI68OrR5HOo24wWyUqB069HLm4YtObpmSfgE1jxgVPVm/a7wvsK5GNTkU9fxDp
 5nnME1zxQoncc0mW/nFuEDaxQoXUBb6+n3vX9Qw7r88eT1KiUYv+jgyEIS8wMaKfO19/+L3B3UQ
 +du2GUGCz8KNKmZKMp2n/6FJlB7FLxc3PeJ8FFta7kMHhtxiqPFn92I5EHcxbUzj8MH7ez5A07N
 PU2kqQCCb/NZKeka+f6klGZwi5cZV71NmE4KWaD+vU+ZbcNGum0xl6FbVg+PQEOiUTdJSoiIV1x
 CJ02bWUudOgkbiMuWxkZWlkhQ/SGpGI2AagdQ6rj0vnuspHJIK2F6EUOBeYzzb4fBPMyExxfoBF
 X6l0bUlNCyYNwmEO366RXTCNWjXY9WHoIVf1jXRj6N0fiDCXQ4UrKb+Ap/GlIW04Z0s6ZRLATOm
 bOS0wGLhmILX8qaKAhUpbfjU7gRKRe4LotDsfqsfefstgO1LhGBqmbFtP3VvV/5h0Aq7K4Nsb/K
 9D6WEmJX6tsPTogO9cCOeVzE107Md7ea3ePxtIt8MJM3ZfaN7LtsYtOlDtzYRagtPyXQG0x8Esd
 KIVoLkGXyey1jC4fhv47XJIJ+LoOiG+dS91y10Sqxg74fdUjpXOfDR3+ETBD3UpRgOE99BZwVP/
 NvTWN9rnvWeDY6g==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
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
Reply-To: david@ixit.cz
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

1. Update backlight intensity up to what vendor use for production
   phones.

2. Keep panel power supplies in sync so panel can recover from blanking.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
Changes in v3:
- Properly fix the panel driver power-on/off cycle.
- Vendor in later downstream kernel commits increased BL limit to 900.
- Link to v2: https://patch.msgid.link/20260810-fix-blueline-panel-v2-0-9344dfdbc3f9@ixit.cz

Changes in v2:
- Unintended change 255 -> 256 for default brigtness. Drop it.
- Added R-bs.
- Link to v1: https://patch.msgid.link/20260809-fix-blueline-panel-v1-0-e7f3a6beb1fa@ixit.cz

---
David Heidelberg (5):
      drm/panel: lg-sw43408: use the full DCS brightness range
      drm/panel: lg-sw43408: skip backlight updates when unprepared
      drm/panel: lg-sw43408: split enable/disable from prepare/unprepare
      drm/panel: lg-sw43408: keep VPNL paired with VDDI and reset deasserted
      arm64: dts: qcom: sdm845-google: drop panel regulator-always-on

 .../arm64/boot/dts/qcom/sdm845-google-blueline.dts |   2 +
 arch/arm64/boot/dts/qcom/sdm845-google-common.dtsi |  10 --
 .../boot/dts/qcom/sdm845-google-crosshatch.dts     |   3 +
 drivers/gpu/drm/panel/panel-lg-sw43408.c           | 153 ++++++++++++++++++---
 4 files changed, 138 insertions(+), 30 deletions(-)
---
base-commit: 909ef7a9a30fa139e69e555e3606680f5cca7726
change-id: 20260809-fix-blueline-panel-af2b7c967f2d

Best regards,
--  
David Heidelberg <david@ixit.cz>


