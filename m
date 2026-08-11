Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B59C5AC67
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 05:52:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2579A10E2C6;
	Tue, 11 Aug 2026 05:52:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RGL7KalY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D79F010E2C6
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 05:52:42 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C86006001D;
 Tue, 11 Aug 2026 05:52:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C1D8C2BCC7;
 Tue, 11 Aug 2026 05:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1786427561;
 bh=VnBFGa4EyeTs0i/DZjjSshOWY9ZN8a+HoVYsbHsIWds=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=RGL7KalYG2dfyzXsnw+OgQaR5s59ofmOLBADiaf+k/EMGXPhgDAR5Hbuo9iTtG3dB
 rr2GCUW6a1+WePMkFxi1BI01u/gWH2I7OIkHnEye5TsKGoKSKB47CRnivKO7eQmwrG
 cQofJJXQGeWqNR9FpgjVjFh3ud3eJxDlgVREc9mNJHsyDOcTNzfaf/MYEUvZ2osN6s
 j3X9r2F3uPbXXOE/Ypdp1wi76Cdouv1G+ksk20aQPHKXlW1SMXNm+t2++2UCqZH3X9
 ww/6UksdQKo6HpwkM6wNBJQoCi6KVm6uqP45jK6q8+UVXhVc6GNbCaVVAtOKpgMvrK
 dR8CIKsKuew3A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 48F2CC5AC67;
 Tue, 11 Aug 2026 05:52:41 +0000 (UTC)
From: Esteban Urrutia via B4 Relay <devnull+esteuwu.proton.me@kernel.org>
Subject: [PATCH 0/2] Add panel driver for Novatek NT37703
Date: Tue, 11 Aug 2026 01:52:32 -0400
Message-Id: <20260811-nt37703-bup-v1-0-34ad42b064a3@proton.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBBA0avIrDWpNmlxFbEwNRiLkhaRiLsrl
 m/x/wWRAlOEOrsg0MGRF59Q5Bm4qfMjCe6TQUllpFVG+E1bK7XAfRVlh4hWV8YZglSsgQY+v1v
 T/o47zuS2dwH3/QDyeLAmbwAAAA==
X-Change-ID: 20260726-nt37703-bup-8abbb7396c6e
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org, 
 Esteban Urrutia <esteuwu@proton.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786427559; l=1257;
 i=esteuwu@proton.me; s=20260622; h=from:subject:message-id;
 bh=VnBFGa4EyeTs0i/DZjjSshOWY9ZN8a+HoVYsbHsIWds=;
 b=BEaOBS/j9sREN5fLM7EsF6azUtpvnMDsvsU10EN6WHpIraO3NhGztIQ3sgDDmT2RrcthgoD5D
 JE1Dy+97geSBWs3/AWGIE5lpz49h+HI9o02awYYKipOzscFjdOqhUuG
X-Developer-Key: i=esteuwu@proton.me; a=ed25519;
 pk=wToFt4mOAWkzbqb15Ye1hrhevI13vK9BcMUFiQ/me1M=
X-Endpoint-Received: by B4 Relay for esteuwu@proton.me/20260622 with
 auth_id=835
X-Original-From: Esteban Urrutia <esteuwu@proton.me>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: esteuwu@proton.me
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

This series adds a driver and bindings for panels based on this display
driver IC.
Initial support is added for the Tianma "v2" panel found in the Motorola
ThinkPhone by motorola.
This panel has no model number and is only identified with versions.
There seem to exist three versions of Tianma panels: v0 (no version), v1
and v2.
Only v2 has been able to be tested.
The added driver should in theory make it fairly easy to add new panels
in the future.
I tried to be as careful as possible with that.

Signed-off-by: Esteban Urrutia <esteuwu@proton.me>
---
Esteban Urrutia (2):
      dt-bindings: display: panel: Add bindings for Novatek NT37703
      drm/panel: Add driver for Novatek NT37703 based panels

 .../bindings/display/panel/novatek,nt37703.yaml    |  78 ++++
 MAINTAINERS                                        |   6 +
 drivers/gpu/drm/panel/Kconfig                      |  13 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-novatek-nt37703.c      | 467 +++++++++++++++++++++
 5 files changed, 565 insertions(+)
---
base-commit: 3d08ff75a47a3e7e2ab45a3bcab6723b4d906422
change-id: 20260726-nt37703-bup-8abbb7396c6e

Best regards,
--  
Esteban Urrutia <esteuwu@proton.me>


