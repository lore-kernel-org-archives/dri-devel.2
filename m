Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043A2606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 08:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=startmail.com header.i=@startmail.com header.a=rsa-sha256 header.s=2020-07 header.b=AJAMsJcg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C85AB10EC85;
	Mon, 26 Oct 2026 08:37:24 +0000 (UTC)
Received: from mx-out1.startmail.com (mx-out1.startmail.com [145.131.90.139])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1FCB10E1E4
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 13:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
 s=2020-07; t=1792935513;
 bh=pqxz8tLX7ebcqdkF46g3geLYrBK/2IZj+ZWtkgQ9FzU=;
 h=From:To:Subject:Date:Message-ID:Mime-Version:
 Content-Transfer-Encoding:From:Subject:To:Date:Sender:Content-Type:
 Content-Transfer-Encoding:Content-Disposition:Mime-Version:
 Reply-To:In-Reply-To:References:Message-Id:Autocrypt;
 b=AJAMsJcgPl4OLWUGrz4u1lLJx7RAfxQ7x4CSU5eqkK0IwEUnXFflyuFRIu5FjzmQM
 oTLnq22Iw1vmCvgXatNSMb0dVsaQqUpISn4Y1Nuioi8IAKMT7KyYMnZ4PEwuoUP1ot
 0sSbkxfetJMZBeUi2gaUnHCkuIJ3aPMDxMiq/KWec0lhSp0IU8FT6Cuk06k0Mviafa
 Zj0n1AcrGmp7tVwJR6HGeIM+BjslQu/IdTAQ91OyAkaDxqhamo+oibY/FjiOygujI6
 E5RLHrEmXq0nTWc32/ZZE6XdxaqX6b5Yq7F3kWy2Zsz+kz20xwqTvvS5bk+UYpCs0L
 LngjnJkX8ed2A==
From: Jacob Pyke <jacob@pyk.ee>
To: neil.armstrong@linaro.org
Cc: jesszhan0024@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, teguh@sobir.in,
 Andrew.liu@moorechip.net, Jacob Pyke <jacob@pyk.ee>
Subject: [PATCH 0/2] drm/panel: Add IL97680A panels for Retroid Pocket Nova
 and Duo
Date: Sun, 25 Oct 2026 23:37:39 +1000
Message-ID: <20261025133741.100490-1-jacob@pyk.ee>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 26 Oct 2026 08:36:44 +0000
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
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds bindings and a driver for the Ilitek IL97680A panels
in the Retroid Pocket Nova and the bottom display of the Retroid Pocket
Duo. Both are 1280x960, four-lane RGB888 command-mode panels supporting
60 Hz and 120 Hz, with DCS brightness control.

The driver is based on Teguh Sobirin's RetroidPocket implementation.
Display operation at both refresh rates, brightness adjustment and panel
recovery after suspend/resume were tested on both devices.

Testing on these Qualcomm DPU systems also used Teguh's command-mode
MERGE_3D fix [1], which is not included in this series. Board Devicetree
changes are outside the scope of this series.

[1] https://github.com/RetroidPocket/linux/commit/b547718c91dbaf8fe27745afced8de00d1f7415b

Teguh Sobirin (2):
  dt-bindings: display: panel: Add Retroid Pocket IL97680A panels
  drm/panel: Add Ilitek IL97680A panels for Retroid Pocket Nova and Duo

 .../display/panel/ilitek,il97680a.yaml        | 121 +++++
 MAINTAINERS                                   |   7 +
 drivers/gpu/drm/panel/Kconfig                 |  11 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-ilitek-il97680a.c | 433 ++++++++++++++++++
 5 files changed, 573 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,il97680a.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-ilitek-il97680a.c

base-commit: 17bb0e2f6c8043f70a693a5f3797471cbed354c8
