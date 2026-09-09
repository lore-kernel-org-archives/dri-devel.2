Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E348C79FAD
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 08:12:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C42D10EFAB;
	Wed,  9 Sep 2026 08:12:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="rBeEo0hE";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DD3C10EFAF
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 08:12:06 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 415B06020A;
 Wed,  9 Sep 2026 08:12:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D26EEC2BCFB;
 Wed,  9 Sep 2026 08:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1788941524;
 bh=747bbzzG8Xt18oHwHsXAVERRqGVsEsBiQo+MmrcQJHo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=rBeEo0hEy/fwB918Ma0v2jOtYa0PknWgnxLGx+VweSjd1EFzzwqFmnuA+Bww/SkAE
 3arsaJvvEkyMUhu47sHYS2GKpTQT+F4DWxhO9V+RzNUuG0cKSFf6S2hEl902vVH4Wd
 cURa/rQzKCV+0Kq4C1rfSt+4GsZQgyrauEoC2tzcZ5HGqHfVD9MZpb0/4M1sFGtPJW
 +zLhK0/IVf4vzxjkt1+smY1OgxLA0GlNffiFm7+voh+TArmo7gEzbKekXlDBjQUrDz
 vkOKk+b0TmA4BkNJoqPu3xi/Q/9x/tdrhU9nocRTRGANhYGEawTntJ8QB7U66Nd0Mb
 KUnhFF9wvqXlg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id B8242C79FB9;
 Wed,  9 Sep 2026 08:12:04 +0000 (UTC)
From: Joel Selvaraj via B4 Relay <devnull+foss.joelselvaraj.com@kernel.org>
Date: Wed, 09 Sep 2026 01:12:00 -0700
Subject: [PATCH 2/4] MAINTAINERS: update Joel Selvaraj's email address
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-update-email-address-v1-2-94a240f9469e@joelselvaraj.com>
References: <20260909-update-email-address-v1-0-94a240f9469e@joelselvaraj.com>
In-Reply-To: <20260909-update-email-address-v1-0-94a240f9469e@joelselvaraj.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788941524; l=744;
 i=foss@joelselvaraj.com; s=20260909; h=from:subject:message-id;
 bh=J8deV8p+5atN7V9RAY+ZWNm5S7W0BWIcfSjOFp0qHJM=;
 b=7iAatDXk6owcd/aSlf/Ltlt4ip/Wb/d7+1+ounJYLITYp+4HFka0N6bD7FDYS1kXV2H0mofKZ
 BSCR0yznXJfDAJk0dAQ2EvU/FkSIG0ZAviwkBUoD8C4g6Nu1j10M1jN
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

From: Joel Selvaraj <foss@joelselvaraj.com>

My jsfamily.in address is no longer active, switch to my current one.

Signed-off-by: Joel Selvaraj <foss@joelselvaraj.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 503b4c4586a41..29b6381d46523 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8124,7 +8124,7 @@ F:	Documentation/devicetree/bindings/display/bridge/chipone,icn6211.yaml
 F:	drivers/gpu/drm/bridge/chipone-icn6211.c
 
 DRM DRIVER FOR EBBG FT8719 PANEL
-M:	Joel Selvaraj <jo@jsfamily.in>
+M:	Joel Selvaraj <foss@joelselvaraj.com>
 S:	Maintained
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	Documentation/devicetree/bindings/display/panel/ebbg,ft8719.yaml

-- 
2.55.0


