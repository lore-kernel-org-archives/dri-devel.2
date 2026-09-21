Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D174C982DE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 09:16:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D718110E379;
	Mon, 21 Sep 2026 09:16:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KeZa9kF4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64DF610E379
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 09:16:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 498D7600C8;
 Mon, 21 Sep 2026 09:16:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E7441F000FF;
 Mon, 21 Sep 2026 09:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789982160;
 bh=woltRsvOk10ngnTKMXDYD8xZgeTRov8hYNzf6xS6K/k=;
 h=From:Subject:Date:To:Cc;
 b=KeZa9kF4KNlzAJqv2zAu0PZ/qFeaV9YX3YM0jx8vdjpeAqXnBbN7MiBHtRtQ8xEmq
 c4h2qX7A/Psa3xgUyG9p9Yz96kDc4RDWqv3Is9XE/4Q0+UlmsMdjBeNB7lnkmVUTqi
 GhgjmbS81N66rkK6UGPTiAyswli1EcALcKWz6olCBS/lQm9sdbmhkDpoo0B5ivYv/D
 RHDFLRmxmqvQfSTsc0V2OYKuD8UyOm0jYZ0UXGPcjREzHQjMG22kcuKFQnVPa4uoiU
 zsa0PmvokxQDj38eRVW5jJNujaV0Q53Cc0AUZwigjsWq4vUuAOu5WZ9kclE1G30Epp
 CSu79qR3qxWlA==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH 0/2] Fix Gemini TVE200 interrupt triggering
Date: Mon, 21 Sep 2026 11:15:53 +0200
Message-Id: <20260921-gemini-tve200-fix-v1-0-8be03ac2a8f7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvxJ7bkE3Kuor0SFzrT1koSFB+Pek4
 wzMvBA5CEcYqxcCJ4ly+gK6rmDdF78xii0MpKhTA2nc+BAveCcmpdDJg7111BqmvnEGSncFLvp
 /TnPOH0FyuINjAAAA
X-Change-ID: 20260921-gemini-tve200-fix-7df25be273fb
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Hans Ulli Kroll <ulli.kroll@googlemail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
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

Rising-edge IRQ triggering can stall TVE200 interrupt delivery on the
D-Link DIR-685, causing vblank and page-flip timeouts and delayed fbcon
startup.

Set the interrupt to level-high in gemini.dtsi and correct the binding
example. The updated attached device tree supplies the correct trigger
type, leaving the DRM driver unchanged.

Level-high operation was verified on the DIR-685 with cold and warm boots.

Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Linus Walleij (2):
      dt-bindings: display: faraday,tve200: Use a level-high interrupt
      ARM: dts: gemini: Use a level-high interrupt for TVE200

 Documentation/devicetree/bindings/display/faraday,tve200.yaml | 2 +-
 arch/arm/boot/dts/gemini/gemini.dtsi                          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260921-gemini-tve200-fix-7df25be273fb

Best regards,
--  
Linus Walleij <linusw@kernel.org>

