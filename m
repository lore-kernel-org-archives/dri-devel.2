Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8187B60A260C
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 19:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TkdLZOwC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFBF510F0C2;
	Thu, 19 Nov 2026 19:01:23 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33B2210F0C2
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 19:01:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CC59D429D6;
 Thu, 19 Nov 2026 19:01:16 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795114876;
 b=mnK8h71HQLrP5svwPNGjf/vgu7Dzh60mv1mgb6P8g1j/vkZfn/Wz+7sNjsEnjhTgSeHY
 DEvx8CyN8IPgO+7jC5zLcO7SW1H5P0op7k2Nrgu4ZQ49+Bz/QbX3u9mK8gWeAjO1ZRrnG
 aNk2we+I+E+0D3Y3P/THaXPZmSLXq1WFLDggIfS0x/m6yfl0zdw3ikOoTqsePJ//x7Wvl
 lGQ3d2kDwdnmN3EPvDqMX69yg8/+Cax3SA7WKZYQdNkwmSkguLXTbvi3rCe/XO35neoAj
 Sp2GkJ6CiFUzOvreNfVCQgPP3Z9q8UjAoYYXfm+y7WRowBUlqU0vFbGKrw/OtZcY6ig==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795114876;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=/IjHNMkqCvdPyDavBH7Vr7CYFM/uCWorvyQ24nWJdos=;
 b=0aglQpXcp8BKC9Fz0Dc+eCTHx9M/BuBD0D7Kcg/uzYdlADVx5IYwzwBun68IvnbHM3g5
 fn7MOOBtRBW0NS1M58rak7mMgO+WdQWR1QzYLUPJnbtni4Tp8hN2huWWoRJJcsUakcL6Z
 2n1rU6VKuTbZoAhIYbNH5QHsb+7J6gaTvHrh1dkSZNp7tx0BdKaUooE6qMVIaeH0HVRdw
 GV0nW2HlTiLz/mBkF8LuwGM5wSVTLG+gjl6bP1haLfHe+QOvQ3Zfz8QoMpFp2kfyzjsXj
 TuuZuOp5Xtvr2aN9i05NZn+8KYHYOlTiN8l8/MSqJ1gT62lnKJtNFGajBqwcELvax7Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 1CD8C1F000C4;
 Thu, 19 Nov 2026 19:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795114876;
 bh=/IjHNMkqCvdPyDavBH7Vr7CYFM/uCWorvyQ24nWJdos=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=TkdLZOwCNkfi79qyyM9Wll8Z5Xo+x/2eSAbd49LtK9sA0BbJ6NW7f955/DbvkcmpK
 Yu05A6BcTx4grDEJy8nDFupc4Lol1xWIUc/CpH1Jwwu7mpemfmyrbsH3Af+cxAVVge
 OUEUiW38sv+8rWXNnTfq/LkVIzqWcxP3hnuZwahs/hIJtyB3QUQcxJQKtP7tuZgHlu
 MvpK71r2iV/mEVs0ZIAihP8FBCmrkwkFQyu5IUGqgW1xOtokA/fnDbwxPS8sN83cDh
 dpZ63Kp9YKXg9kyyhkb6GJQLJwKojle4WvIl1RbV6v/5Xo5qdTXsF7CcZTa3Vzy+m4
 kNqLit6J6lafA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 7CAE04B3DE;
 Thu, 19 Nov 2026 19:01:15 +0000 (UTC)
From: Nizat Mikayilli via B4 Relay <devnull+nacht.dxdmail.cc@kernel.org>
Subject: [PATCH v2 0/3] drm/panel: Add Anapass ANA38407 DDIC
Date: Thu, 19 Nov 2026 20:01:11 +0100
Message-Id: <20261119-b4-ana38407-v2-0-bddc251bd43f@dxdmail.cc>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22MOw7CMBBErxJtjZF/wYaKe6AU6w9kJUgiG1lBk
 e+OSU03b0bzNsgxUcxw6TZIsVCmeWogDx34EadHZBQag+TyJAQ3zGmGEyqrW1bi3PfondVooD2
 WFO+07rbb0Hik/J7TZ5cX8Wv/e4pgnHnrlBLatBWvYQ0vpOfRexhqrV+gOTCPpwAAAA==
X-Change-ID: 20261107-b4-ana38407-31955acb84a7
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Nizat Mikayilli <nacht@dxdmail.cc>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795114874; l=1711;
 i=nacht@dxdmail.cc; s=20261004; h=from:subject:message-id;
 bh=Gxjj1oEcl9xXswoh+L+3EaxDdop6cBisF4OLFm8PBxw=;
 b=wOSo7HJNMi7LWMB+RqmTmdSRuTNTi0AU8k/qpmErX6tCqmjxONZkL3CifLlJfs5OE4KQWC78A
 iPCbsuAkUlLCR93zJ5YVOzzYYID0vGFUdpGQeH2Kg8Y1ifvnlhQA4Tx
X-Developer-Key: i=nacht@dxdmail.cc; a=ed25519;
 pk=Kay3P3pOJq5klUD+0/I8QX8JGOh0CeQXEwRVv7CMm4k=
X-Endpoint-Received: by B4 Relay for nacht@dxdmail.cc/20261004 with
 auth_id=1111
X-Original-From: Nizat Mikayilli <nacht@dxdmail.cc>
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
Reply-To: nacht@dxdmail.cc
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds a driver for the Samsung AMSA10FA01, the 2560x1600
AMOLED panel of the Samsung Galaxy Tab S9 Wi-Fi (SM8550). It is a
command mode DSI panel with DSC, driven by an Anapass ANA38407 DDIC.
The binding and driver are named after the DDIC.

Only the 120 Hz mode of panel revision D is supported. The init
sequence comes from the vendor panel data, without the
brightness-dependent gamma, HBM and ELVSS writes. A fixed delay
replaces the vendor's wait on the TCON_RDY pin.

Tested on the tablet: cold and warm boot, hand-off from the bootloader
splash, brightness and blank/unblank. The board DT follows separately.

Signed-off-by: Nizat Mikayilli <nacht@dxdmail.cc>
---
Changes in v2:
- Dropped port from the required properties (Krzysztof)
- Added Krzysztof's Acked-by to the vendor prefix patch
- Link to v1: https://lore.kernel.org/r/20261107-b4-ana38407-v1-0-c8b33147110a@dxdmail.cc

---
Nizat Mikayilli (3):
      dt-bindings: vendor-prefixes: Add Anapass
      dt-bindings: display: panel: Document Anapass ANA38407 DDIC
      drm/panel: Add driver for Anapass ANA38407 DDIC

 .../bindings/display/panel/anapass,ana38407.yaml   |  68 +++++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 MAINTAINERS                                        |   6 +
 drivers/gpu/drm/panel/Kconfig                      |  15 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-anapass-ana38407.c     | 320 +++++++++++++++++++++
 6 files changed, 412 insertions(+)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261107-b4-ana38407-31955acb84a7

Best regards,
-- 
Nizat Mikayilli <nacht@dxdmail.cc>


