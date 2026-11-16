Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE8D60A5BCB
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 07:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S33Won6r
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7133E10E7AD;
	Mon, 16 Nov 2026 07:40:20 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 408A610E218
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 07:40:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E966345ED9;
 Mon, 16 Nov 2026 07:40:13 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794814813;
 b=mpyrZPx8heiuGQ1zUNuS5J9HVjT5jB5q0J8pnqJRAMW0dTNnXWPy2Jo6YhP78humiSOD
 qsAchx8/aSpP7HxWGJQgznYF+02Qj12m8+U7DmE0PkS5GehjfhH6yNDkqe1Dmgg32VnCT
 lWVQufK2UJelmc82Li8qhALJuXiTXcXRmCEZbGfhUJ10XiW/8JYI2YeX1Uwl29gy7dB2H
 gjUa66bnCTWQCuMNbhs5VS1Y2d3w+QuLOF3CKVWYrZfLhpFxZ/pzxl4GAwS65SNcXAlmy
 zjzGe6U7dKHs9P01yi0dq/7TnTLrIl78VTSmrvwczEPTSG2QYquxTgpv2QgtrFKW52g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794814813;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=cRltgXr2LU/w5oqVp8n0WjSpdcPYjvRrDoPS0to9cPE=;
 b=pz5EIPZkiWqvmKKjT3XqgDrIlUoy+cWusi+e1zl358ogKv9A50i2KQoHf8BbjNFyuZb/
 NmHQ8L20Ymk/n7y6x7U6aGuJCz+pVA5tAXOFBZkPw3kOrIeh7twL7IgYvm7NyTui/1DdP
 IeJndxufrnwqHzH5IELyjufBJsXr0A9ccm7O9V5u3pdRTetzMPIE4DGzaDHoHlKcXJsfq
 TuJWRz3Su3vl2goW+QBIOvpwMDJz6CrRgcItBXnfVrPg4RIfpmBlQXMLJmmyno9+MEG9r
 dsJJo/7PDunvXA3AQ+Wcdy3o97ccqs3tMut4Rvy5zdjU2sIpax7xOAJHMA8Z7eJ7UFg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 4CCDF1F000D4;
 Mon, 16 Nov 2026 07:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794814813;
 bh=cRltgXr2LU/w5oqVp8n0WjSpdcPYjvRrDoPS0to9cPE=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=S33Won6rHyRXTq+mnBDuihbgoNjpp3gLFM8s06WRW8ZQ1FHSLIQG0CbhYbW9+S0xc
 34BFGjH5bjywspvc9SWlHxczZqjqiUnFM3mSM6LQBlgYMIM4RHukL/vm0GuR/CXJ28
 5IP4IpQz/02fpIhncYY/BdvSdhFR4XZO8egXsno4h/p+zE+UefaZX8lURvCd3p4N9Z
 U47Ih1VObhOKoaS0qrYmo+p1wVyJ8yxboxcSEdzuTtXSBuJqYYVB0gITIiXqz7KcDV
 F07IKJDcI8w3HK8RDYW0C5rKXjihT7MDQtPkzYLv9ff9EHA4blBA7AKttsXXOZYgxv
 CFDHpUkW/EOFA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id D02274A37C;
 Mon, 16 Nov 2026 07:40:12 +0000 (UTC)
From: Venkat Yadlapati via B4 Relay
 <devnull+venkat.yadlapati.yahoo.com@kernel.org>
Subject: [PATCH v2 0/2] Add support for the BOE ILI97680A AMOLED panel of
 the Motorola Signature
Date: Mon, 16 Nov 2026 13:10:11 +0530
Message-Id: <20261116-vantage-panel-v2-0-e2ab48645e2c@yahoo.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNQQ7CIBREr9L8tRhASlJX3sN08Wm/FqPQABKbp
 ncX6trlm8y8WSFSsBTh3KwQKNtovSsgDw0ME7o7MTsWBsmlFkJoltElLPGMjp6sM1q2CpGjklA
 2c6Cb/ey+a//j+DYPGlKV1MZkY/Jh2Q+zqL1/7iwYZyduutaMqpNCXxacvD8O/gX9tm1fPIqnK
 rwAAAA=
X-Change-ID: 20261116-vantage-panel-9b6254aa0a42
To: Venkat Yadlapati <venkat.yadlapati@yahoo.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794814811; l=1949;
 i=venkat.yadlapati@yahoo.com; s=20261023; h=from:subject:message-id;
 bh=8ZaUQLu3CSlV2D2wl6s2Z6g9bA3Qymqgd8aSrdWtrqU=;
 b=ddZgpxcYoUiC6iWTgh1UxYw/wtjG1pa3EKFWXDlgytu8Y5qdEmqdNfN1fdQruopRKVOY1Os9v
 fDEDDaF6hjuBwVJhS2KUpW2DGa6pAe7s3FhQ7807GB5NEQc+QJzG30Q
X-Developer-Key: i=venkat.yadlapati@yahoo.com; a=ed25519;
 pk=e8KStCtEMvUP1Se/riB/KVnDAQFEVR2Dw2PcuA8/eME=
X-Endpoint-Received: by B4 Relay for venkat.yadlapati@yahoo.com/20261023
 with auth_id=1303
X-Original-From: Venkat Yadlapati <venkat.yadlapati@yahoo.com>
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
Reply-To: venkat.yadlapati@yahoo.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FORGED_MSGID_YAHOO,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Motorola Signature uses a 1264x2780 BOE AMOLED panel driven by an
Ilitek ILI97680A. It is a MIPI DSI command mode panel with DSC 1.2
compression on four lanes. This series adds the devicetree binding and a
driver for it.

Two things are specific to this panel. The DSC picture parameter set is
written to a vendor register on command page 7 instead of being sent as a
standard PPS packet, and the brightness range is 0 to 16180 over DCS.

Tested on a Motorola Signature with the msm DRM driver: the panel lights
up at its native resolution and Phosh renders on it.

I used an LLM (Claude) to help write these patches and their commit
messages. I reviewed all of them and tested the result on the device.

---
Changes in v2:
- Give the panel its own compatible, "motorola,vantage-boe-ili97680a",
  with "ilitek,ili97680a" as fallback: the mode, DSC settings and
  initialization sequence belong to this BOE panel, not to every
  ILI97680A panel. BOE's part number is not known, so the name follows
  the "<device>-<glass vendor>-<controller>" style of the Xiaomi and
  Lenovo NT36523 panels.
- Driver: match the panel compatible.
- Link to v1: https://patch.msgid.link/20261116-vantage-panel-v1-0-30b95bd49216@yahoo.com

---
Venkat Yadlapati (2):
      dt-bindings: display: panel: Add Ilitek ILI97680A
      drm/panel: Add Ilitek ILI97680A DSC command mode panel driver

 .../bindings/display/panel/ilitek,ili97680a.yaml   |  75 ++++
 MAINTAINERS                                        |   6 +
 drivers/gpu/drm/panel/Kconfig                      |  16 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-ilitek-ili97680a.c     | 494 +++++++++++++++++++++
 5 files changed, 592 insertions(+)
---
base-commit: 39e407b553ec15d4a233b651531ad431ed7542be
change-id: 20261116-vantage-panel-9b6254aa0a42

Best regards,
--  
Venkat Yadlapati <venkat.yadlapati@yahoo.com>


