Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E38FDCA600E
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 07:42:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F60810FCD9;
	Thu,  8 Oct 2026 07:42:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="e/aJHkPZ";
	dkim-atps=neutral
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
 [208.88.110.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF65A10E6BD
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 20:19:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by mail.savoirfairelinux.com (Postfix) with ESMTP id 318FC3D81851;
 Wed,  7 Oct 2026 16:19:05 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id oEEistIXMrW8; Wed,  7 Oct 2026 16:19:03 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.savoirfairelinux.com (Postfix) with ESMTP id B45473D8187E;
 Wed,  7 Oct 2026 16:19:03 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com B45473D8187E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
 t=1791404343; bh=smx0DskrKC46rYvmhES7EUHN2vwiKNJHN3tiZFLC92A=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=e/aJHkPZ4PF9yV0VaFrpGeGLOVUpOuNkIcUg05oQsp80cocAY2zRQ10RLDy8/IVJq
 wJ5uGJkX9GAyUkpaG6SY5bbD4pddYchHACbPwmF0fq6U8MF8O1Yx2n7tMFhReJysgX
 j9hQKyKIsmH35L9ph6gdHRm/R9ZRUFc/Zr0mCDo4fx53J5v+hIVfpH5jyh+4ERFhNM
 XOi371VZr+YqiyKDWqbWtat1I9k8P8jOtQsUFVJbxpA95c13Ez2tyfXFdiDgWAfR+O
 qg9OI/HlPK7Xx1rcpI0qfuvRaLhMypYYeT13D9sHiAgu1cLl2I42sitf4Wylr0lhEe
 9H0h2op55MOnA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id kx2w-qYr-YC6; Wed,  7 Oct 2026 16:19:03 -0400 (EDT)
Received: from localhost (unknown [192.168.51.254])
 by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 502453D8182D;
 Wed,  7 Oct 2026 16:19:03 -0400 (EDT)
From: Marc-Olivier Champagne <marc-olivier.champagne@savoirfairelinux.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
Cc: Ondrej Jirman <megi@xff.cz>, Purism Kernel Team <kernel@puri.sm>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Marc-Olivier Champagne <marc-olivier.champagne@savoirfairelinux.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Jerome Oufella <jerome.oufella@savoirfairelinux.com>,
 Felix Boucher <felix.boucher@savoirfairelinux.com>,
 Quentin Lehoux <quentin.lehoux@savoirfairelinux.com>
Subject: [PATCH 3/4] dt-bindings: display: panel: add compatible for DCLTek
 300248 10.25in panel
Date: Wed,  7 Oct 2026 16:18:58 -0400
Message-Id: <20261007201859.3709656-4-marc-olivier.champagne@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261007201859.3709656-1-marc-olivier.champagne@savoirfairelinux.com>
References: <20261007201859.3709656-1-marc-olivier.champagne@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 08 Oct 2026 07:42:48 +0000
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

The DCLTek dt300248 is a panel using the Sitronix ST7703 controller.
Add a new compatible for it.

Suggested-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Signed-off-by: Marc-Olivier Champagne <marc-olivier.champagne@savoirfaire=
linux.com>
---
 .../devicetree/bindings/display/panel/rocktech,jh057n00900.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/rocktech,jh0=
57n00900.yaml b/Documentation/devicetree/bindings/display/panel/rocktech,=
jh057n00900.yaml
index 91e06d6a6819..b05f3e8cfcd4 100644
--- a/Documentation/devicetree/bindings/display/panel/rocktech,jh057n0090=
0.yaml
+++ b/Documentation/devicetree/bindings/display/panel/rocktech,jh057n0090=
0.yaml
@@ -24,6 +24,8 @@ properties:
       - anbernic,rg353v-panel-v2
       # AYANEO Pocket DS lower 5.0" 1024x768 IPS LCD panel
       - ayaneo,pocket-ds-lower-panel
+      # DCLTek DT300248 10.25" 440x1920 LCD panel
+      - dcltek,dt300248
       # GameForce Chi 3.5" 640x480 TFT LCD panel
       - gameforce,chi-panel
       # Powkiddy RGB10MAX3 5.0" 720x1280 TFT LCD panel
--=20
2.34.1

