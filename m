Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967E360A3802
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 20:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wentdjmb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4F3010E310;
	Sun, 15 Nov 2026 20:20:28 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E827B10E310
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 20:20:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A813E4363D;
 Sun, 15 Nov 2026 20:20:22 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794774022;
 b=p5JmxAcfCstBFDblYgD61UDTZDf78WXTeXxrV/eEXvWJ4LOw0+D0I77TFbDSwVl4CFeY
 EfMCykciB3Vhl/TnAJ3SMdVYJ6GTInQVmF/gngRViOoc9VcxVJti1oZqwzM+UF2D7IlZW
 JCEKtxGMMhnUkuTioMFeRiJshVURkudNh9UnYVhqWLnCsy9dqZTaTGkx/VHESRsQZ+Eco
 OzIm2bWTHVYLm50GqSmHIzeH2aMH9yrJ/8vSiP7SnPn1qGSFdvsTXcNlUdItNRDPDniHi
 R/E1vtlN0+cwbARyMYdWEpkTVHJG/O3tbr0h3+CF7+r2ZnFeHORtD8xdhkaWCO7WpeQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794774022;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=NI2Aa3pimgsmQW040pmBmvZ4owNqThW5Ki9g7BD9Ro8=;
 b=E1BrdFRCkPClIsmJIFZbMTPKpO3wB2knJrB4f4zAa4n/rphl07KXc6YT6rus/E5uN3B/
 YKKNuOBWgs6U8vlSvHq3Y+9LIPR5Vv2+1XR8bHa2x3i3kTvTN4THV1+9IBrVg2pqh2ajU
 aVNjYnn0pcyftrQnTHAMQIAS9oJuA1Lk5y6RxGghnPmpRkt0lRdqL8QhKn6Kd339z4bLQ
 uC5CdcqPApzH3EjAzo59rZOrHG90u/7iAkOKyo5eK0S5Oj2swZF6zCc7420eL+j7c9Qp9
 PWgwz1eYWwxtcmxSZbxyZfezz8dIHUROBti3k4rMdBLLmTbprN7RbHehqZeix/un9vA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 18C3B1F000C5;
 Sun, 15 Nov 2026 20:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794774022;
 bh=NI2Aa3pimgsmQW040pmBmvZ4owNqThW5Ki9g7BD9Ro8=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=Wentdjmbq6BhErm3xtmZVavktHm/37+pTxkubK8oTm9k0TrDquzs20p7cKv6/cRJA
 THiVQW/WIDhXJ5IN14HkzF6XNCYDmPqHu5sAW1ssHlN724eZ+9rL+/gMDv6H4ByGWn
 YR1lx4jlnfhMt99Eyr/3teS1m8n4KMyEnwSfd7Wq0DX9HxqEwH4fDbI4YdBeSd5ewM
 nBaeDftFPSQ9wnbA7+mANm9XyjAc0zqBgZ5kq5XYTVSkHsGLZiNoAqKxJ4gW8iyyWk
 CYN96UTdINjKGr+VNczIj0esHJpj2Z4/N89GnFFA1Z5B2wMjjLe7jW/ZbbhLDUXRm+
 Rfs9lRYzQb/uw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 9E18D4A1A2;
 Sun, 15 Nov 2026 20:20:21 +0000 (UTC)
From: Venkat Yadlapati via B4 Relay
 <devnull+venkat.yadlapati.yahoo.com@kernel.org>
Subject: [PATCH 0/2] Add support for the BOE ILI97680A AMOLED panel of the
 Motorola Signature
Date: Mon, 16 Nov 2026 01:50:20 +0530
Message-Id: <20261116-vantage-panel-v1-0-30b95bd49216@yahoo.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM0QpAMBTG8VdZ59rKFiteRS6OOTjSaBspeXfD5
 e+r739BIM8UoBYXeDo48OoSVCbATuhGktwng861UUoZeaCLmOYNHS2y6owuC8QcCw3ps3ka+Px
 6Tfs77N1MNr4RuO8HSWa8b3EAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794774020; l=1422;
 i=venkat.yadlapati@yahoo.com; s=20261023; h=from:subject:message-id;
 bh=KQjjdkBwQ6+2i8+eBdXH5aAGDT7OhKlPtqt4R3BsY5g=;
 b=ejJ6ZaTaQUZI4fGanN319Tuz3hrXmYLxTAEG/DwdOoVn1j/i3x252I00pV4uqEVZ7xTMv1JYI
 +oHkJ/z909GBblpPtC3OoDvVyFnicdwp8njYNG0RDtpUIPDB98ulDg7
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
Venkat Yadlapati (2):
      dt-bindings: display: panel: Add Ilitek ILI97680A
      drm/panel: Add Ilitek ILI97680A DSC command mode panel driver

 .../bindings/display/panel/ilitek,ili97680a.yaml   |  70 +++
 MAINTAINERS                                        |   6 +
 drivers/gpu/drm/panel/Kconfig                      |  16 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-ilitek-ili97680a.c     | 494 +++++++++++++++++++++
 5 files changed, 587 insertions(+)
---
base-commit: 39e407b553ec15d4a233b651531ad431ed7542be
change-id: 20261116-vantage-panel-9b6254aa0a42

Best regards,
--  
Venkat Yadlapati <venkat.yadlapati@yahoo.com>


