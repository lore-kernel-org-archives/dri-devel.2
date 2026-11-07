Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA56606A32C
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 19:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U5zwHv3D
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68EEB10E663;
	Sat,  7 Nov 2026 19:47:46 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC6EB10E158
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 19:47:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 97FED43C15;
 Sat,  7 Nov 2026 19:47:29 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794080849;
 b=pjbBnA9Vt/Af1MZeQlTDwLpVaxZ5G57JRaEjd297RR3TWohEPe5yvABMv0auuV87U41D
 NFMUmhEBQIEtn6eeJRG82lrylc/s2RR2g+JXWmT/9kcBH1kExfUtl7Fq2PCjX+koc9mPY
 wibb/xMEhueKYmF3F2hbkvgGGw+KWdSA0CGK+0TnbRLHYvvR0CB4mwkFBVg0EljIGrGMy
 SmTSkaarwAmOJwu/4GAWDRCj1Ve4aWjX5Qvl3OHY+KzsgX7P46UlngmNB1ps9VqXG2iCB
 YSsz4TTZYiKUwPw3zhael+sEGkCtxCKVCJ3fD34HVHaEbOuPZ2kMw0plNf7SPQzmo3A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794080849;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=bEPkd/NSpRuaRi/OEaFNuOHic9TakWzDDBa0Ce16DH0=;
 b=PVXuSwzfZnnK3CAdMrPtebU3Re8fy2aQg+o5hFzoIveP98/qjAdqVZWrYzcqmn7Osz07
 U1puxqYlLx8VBXIUBfqPx99tuLQrlk6k7CSKYv8HVBRwEr1jcZ/jLLML4mo9JlfdlEMb8
 0hGz4sGjkh2Njcnv8+oA84v3+T26iL9Eh/Rbep/Wvs07/JH1z5sYorDMwDkd6HWehij6b
 sqSJVv9rmJ9vEMzGF9d1gqaPTV7iZ4Io9vqtLkyS9te87ikcIpDMqIBh1gUSf2SMv8Jd7
 hopn9rN//s6bC3S3ORMwW8Pc32u7DPaU7/cauEhENHGXlPqKyATPx/TpGNkZpyOiivQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 6FF251F0089F;
 Sat,  7 Nov 2026 19:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794080849;
 bh=bEPkd/NSpRuaRi/OEaFNuOHic9TakWzDDBa0Ce16DH0=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=U5zwHv3D+E/M5H8XFTdnunNxxrqFYWZrY9YnQ9jdzSdDbxT8wlZQYFc0XVrv5/gjF
 jKIhNcprJi95SUJTyMrkImQeCdRbJQYiV7MdFAK9SUbDX7VuXoMYCviWM8NoaORhRR
 ZVrSH1xVU6/kGTsZ4s9RLdH1h0Z7EmSMHCfiONw0RZh+N0rT61Fh7c4pKPC8+0dY0M
 /+pTLh2UCgQABUkNKIwWfs3lYfAaRmlznQtg9U54PC7zmt9wIFCejzLSZZczr8N7LS
 w8gIUrZEG7iSZr9d2nCCA6xny7m/u7TlNZG9wK9IxFlBODwK89AYiMBvxyLWMDc9rX
 evPnMH7NLizTg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id C6BFB47CD0;
 Sat,  7 Nov 2026 19:47:27 +0000 (UTC)
From: Nizat Mikayilli via B4 Relay <devnull+nacht.dxdmail.cc@kernel.org>
Subject: [PATCH 0/3] drm/panel: Add Anapass ANA38407 DDIC
Date: Sat, 07 Nov 2026 20:47:23 +0100
Message-Id: <20261107-b4-ana38407-v1-0-c8b33147110a@dxdmail.cc>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQwNz3SQT3cS8RGMLEyDb2NDS1DQxOcnCJNFcCaijoCg1LbMCbFp0bG0
 tAHtflIJdAAAA
X-Change-ID: 20261107-b4-ana38407-31955acb84a7
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Nizat Mikayilli <nacht@dxdmail.cc>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794080847; l=1483;
 i=nacht@dxdmail.cc; s=20261004; h=from:subject:message-id;
 bh=5iANZuthwhrnKNfy6tUcJAQYLWP1DzL0/22RNTTPIDI=;
 b=ot3qalUVbAQfEck7pHOOwZs4nwbYCpivVlB68oj5ZnOnsJjfRqBpHwVmdi2i1sqTTmfALx5GK
 G8sZFJ7dKqVC6vDLFX2lnQ0qB5NV8hWgJjNJBUXVSJ6r+xuSCaJS4qu
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
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
Nizat Mikayilli (3):
      dt-bindings: vendor-prefixes: Add Anapass
      dt-bindings: display: panel: Document Anapass ANA38407 DDIC
      drm/panel: Add driver for Anapass ANA38407 DDIC

 .../bindings/display/panel/anapass,ana38407.yaml   |  69 +++++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 MAINTAINERS                                        |   6 +
 drivers/gpu/drm/panel/Kconfig                      |  15 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-anapass-ana38407.c     | 320 +++++++++++++++++++++
 6 files changed, 413 insertions(+)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261107-b4-ana38407-31955acb84a7

Best regards,
-- 
Nizat Mikayilli <nacht@dxdmail.cc>


