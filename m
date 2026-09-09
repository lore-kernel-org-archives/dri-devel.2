Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B3ABC79F8C
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 08:12:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FF8F10EFB2;
	Wed,  9 Sep 2026 08:12:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ss1INxEA";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CE1610EFAD
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 08:12:06 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 178F6601FD;
 Wed,  9 Sep 2026 08:12:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AEA92C2BCF4;
 Wed,  9 Sep 2026 08:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1788941524;
 bh=9dMkHMleRdbFXq/Tngq9Z7Icy4JxHXPrtaDymmuML0o=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=Ss1INxEA/Y3iLRZCGK6h0OXSvCP6Gzr+RHw46OidyoUsOLuvmSGuGXtd02Ec+nBem
 nyVFk1nH30s5/NZDg/eLB36lHbnlhapKiN/5FjSKNrQHLqBpoMI0ZgYD+2XQkQZR5c
 iIrqsLXf6KR2VeWhWNIhWpRoTdnq2AS8u3dohcpuIcua0id63XRkzx7KPUmSoNlu3H
 ZqJpF3GisdnE0Ns3iAfywbPCqhJaPXx2CGHk3qLe69XPuVAtOHA2x0WGoF2jnPgsB8
 8y+bN9NQ8y1Jxfr8c+EURZtDcIHycpi7Chj/il7AFHh3S1LbVTd89gzK/2TNK71g/b
 PUnF51ILMMX5w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 9B354C79FAD;
 Wed,  9 Sep 2026 08:12:04 +0000 (UTC)
From: Joel Selvaraj via B4 Relay <devnull+foss.joelselvaraj.com@kernel.org>
Subject: [PATCH 0/4] Update my email address
Date: Wed, 09 Sep 2026 01:11:58 -0700
Message-Id: <20260909-update-email-address-v1-0-94a240f9469e@joelselvaraj.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBBG4auQWTtJwWioVzEuxvYHhiiSDhASw
 t2puvwW721kSAqjW7FRwqKmnyGjPBUUOhlasMZsqlx1dd7VPI9RJjDeoi+WGBPMGBAEj+Zy9iX
 ldExodP1t74+/bX72CNP3Rft+AOhrz7Z4AAAA
X-Change-ID: 20260908-update-email-address-eeaec9ef5391
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, Joel Selvaraj <foss@joelselvaraj.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788941524; l=985;
 i=foss@joelselvaraj.com; s=20260909; h=from:subject:message-id;
 bh=9dMkHMleRdbFXq/Tngq9Z7Icy4JxHXPrtaDymmuML0o=;
 b=jiHVWBP063DjZH2azjp48G9TpUTak2H2UEhlwqzRmb5KYIzCgfIHDAhlaCa9tVAYPf+XT+5Wk
 cQ54I+X6ziHBNNAf+ezwTiBNaAxrbOp5X0hxQUAS7kDfDUwFNviY1JQ
X-Developer-Key: i=foss@joelselvaraj.com; a=ed25519;
 pk=UUJ1v4UQJ/nljqj3NjsWt5H4mphWQ7etpQ4Z7JiR2yo=
X-Endpoint-Received: by B4 Relay for foss@joelselvaraj.com/20260909 with
 auth_id=1018
X-Original-From: Joel Selvaraj <foss@joelselvaraj.com>
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
Reply-To: foss@joelselvaraj.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

My jsfamily.in email address is no longer active, so update the kernel
tree to use my current address instead.

Signed-off-by: Joel Selvaraj <foss@joelselvaraj.com>
---
Joel Selvaraj (4):
      mailmap: update Joel Selvaraj's email address
      MAINTAINERS: update Joel Selvaraj's email address
      dt-bindings: display: panel: ebbg,ft8719: update Joel Selvaraj's email address
      drm/panel: ebbg-ft8719: update Joel Selvaraj's email address

 .mailmap                                                         | 1 +
 Documentation/devicetree/bindings/display/panel/ebbg,ft8719.yaml | 2 +-
 MAINTAINERS                                                      | 2 +-
 drivers/gpu/drm/panel/panel-ebbg-ft8719.c                        | 4 ++--
 4 files changed, 5 insertions(+), 4 deletions(-)
---
base-commit: a9d7ced84989ec05be09b4b8428759ef60450a0f
change-id: 20260908-update-email-address-eeaec9ef5391

Best regards,
--  
Joel Selvaraj <foss@joelselvaraj.com>


