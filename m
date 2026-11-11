Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34C7606A338
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 16:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EeAT8i9q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15E0F10FC6D;
	Wed, 11 Nov 2026 16:22:48 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1216D10FC6D
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 16:22:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BA267477A5;
 Wed, 11 Nov 2026 16:22:41 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794414161;
 b=Y5Em3jLeIrAdTmdCqY5irAgXcJucbBu61aianq2LMX70xj6oTUI6ADcf4ld6dNPcI9h1
 mbHwt6klQ1vf2NhJFCuluC2Lxwhu/j8tTUE0oykRV8ICvnaGDM/lHpkrNLa/hRWXKwDzr
 eA6S7lT2lWEn0Zcyd4ZY6J5Fht61iVtZmxLEjtzSzewrT3d8Noj15GkXGp4DhwsbT1VLt
 opZrmDulLoSR0rn+3MJe/h2Lqo5a72wLd0ljPXeY9wtuXMayA1QzBx/P9U4MlFEOfYIFI
 WssPBGagXgNggOGdBtMavZcerTZrBSCppmJDrNxWoGi6einLzZeoVpVE7Q6n0wLkL4w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794414161;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=5Fudv0OzRIv6YaL5i0QV2cvEXsQiLCG6vTYn4vGwO6g=;
 b=rv8Q5psuP2MAxt5SmHY+u4jc25DNtqoqdAIXa6h+L06mgtM4SvGmk9Ar4+Nqn+Vr5++g
 YqFNO36YRECHHL2oY8CGh6PO8bz8rJzbUCj1Xt+ytEX0a30YMYPPbGSAH3ykoqSf2F5Cy
 LQ0iiKi+h+GCdCALMLQ9p0yjYgOWWmjodIyIxhW4zaCIl4lwp2de0ElhHpq2RZrc5Q3zS
 5WSMDUaFBgDt/EeECSevvDeTyQn9oAdTwDPWv+6lQibyPCq57jyBqzBKbwj3HBHDWUie+
 9S0Cu7fBC9k9vChiAcPc43pPFKfd7zFjEI0IrLpieEskB8V+juw54blGOXwUhvyWf/w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 22CB21F00A05;
 Wed, 11 Nov 2026 16:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794414161;
 bh=5Fudv0OzRIv6YaL5i0QV2cvEXsQiLCG6vTYn4vGwO6g=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=EeAT8i9qBK9Fd7BwZyfz3E6qxbwvq/IuzzfJIZPmV4tN6kL+8ZeV4MDbOpvNOa/l1
 ptpG0KoeSHTBBsTV5IygPjGLMYSLARUwTN6hCu3TkAOSe2Ji0uddPvJIpeHeePhVUR
 +Eunk8zGP/2mh+m2wz3f8ysIyldrm0X75LpWW+s/XN+ZOOURQQ34KKnUMLw8wambYX
 GanARDGE5a0yeRZbTm5TUE6OYAboMgNc4t5cKItYu8EecmHZHYMUK2v+9/gZUsI8Ku
 jk8jVM00UpxzXReqDrPwcWcux+hHo7KeFJs4NXt+ZLUkfAhUiHKeKCmSc7Da0wzon7
 IRV4UDmk0MJxw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id A749949029;
 Wed, 11 Nov 2026 16:22:40 +0000 (UTC)
From: Michiel van Beers via B4 Relay
 <devnull+michielvanbeers.gmail.com@kernel.org>
Subject: [PATCH v2 0/2] backlight: lm3630a: Add a per-bank full-scale
 current limit
Date: Wed, 11 Nov 2026 17:21:40 +0100
Message-Id: <20261111-lm3630a-led-max-microamp-v2-0-aff11756e7be@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABSW9GoC/42NTQ6CMBBGr0K6dkx/AFNX3sOwKMMIY6glLRIM4
 e4CXsDlS973vkUkikxJXLNFRJo4cXhtoE+ZwM69WgJuNhZa6lIpeYHem9JIBz014N0MnjEG5wf
 A0hpdGGcLLMQ2HyI9eD7S9+rH6V0/Cce9txsdpzHEz/E9qd3742ZSIIHQUp6rxtYab6133J8xe
 FGt6/oFs9SgQ9IAAAA=
X-Change-ID: 20261107-lm3630a-led-max-microamp-c693253a95c5
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, 
 Griffin Kroah-Hartman <griffin@kroah.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, Michiel van Beers <michielvanbeers@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794414160; l=2412;
 i=michielvanbeers@gmail.com; s=20261107; h=from:subject:message-id;
 bh=M9hBpT4MU3HGwwOvZOZkX2+eRbE95B0Ckdvhl25nIHw=;
 b=NbVP5964O0uRfIoPM7KNrt3JXDt0Zso+PDJcuKUxXOJKdh4pglDmpklTNOQUexAmVeGbN0GLL
 yjRQJ6E5DcaAF83UeKzqE7PJl2aCcOiw1CyERwixGrjY8K8TZ5j0EE3
X-Developer-Key: i=michielvanbeers@gmail.com; a=ed25519;
 pk=C+lOje7u3+2x3o2NLMXrwz2veP2++eXfIi9MtYsUo4k=
X-Endpoint-Received: by B4 Relay for michielvanbeers@gmail.com/20261107
 with auth_id=1444
X-Original-From: Michiel van Beers <michielvanbeers@gmail.com>
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
Reply-To: michielvanbeers@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The LM3630A driver always programs the full-scale current of both
control banks to the chip maximum of 28.25 mA. This series adds the
common led-max-microamp property to the binding and makes the driver
program it, so boards whose LEDs are rated for less can set a lower
limit.

My use case is the frontlight of the Onyx Boox Leaf e-reader (SDM636),
where Onyx's Android kernel sets the full-scale current of both banks
to 12.5 mA. The board devicetree is not upstream yet.

Patch 1 documents the property, patch 2 implements it. Both are meant
to go through the backlight tree.

Testing:
- Onyx Boox Leaf, 7.2.y kernel (sdm660-mainline) with patch 2 applied:
  led-max-microamp = <12500> on both banks reads back as code 0x0a in
  both full-scale registers, and the frontlight works normally. 5000
  and 28250 give codes 0x00 and 0x1f, with bank A visibly dimmer at
  5 mA; 28500 makes probe fail with -EINVAL. The driver in 7.4-rc1
  differs from 7.2.y only by an unrelated change in lm3630a_remove().
- dt_binding_check, and dtbs_check of all in-tree boards with an
  LM3630A (rk3566-pinenote, the i.MX6 Kobo and Tolino e-readers,
  Nexus 5, OnePlus One): no warnings for this binding.
- arm64 build with W=1 and sparse: no new warnings.

AI disclosure: I prepared this series with Claude Code (Anthropic,
Claude Opus 5.5). It drafted the driver change and the commit messages
from my description of the problem and the datasheet, and proposed the
checks above; I ran the checks and the hardware test, reviewed every
line, and take responsibility for the patches.

---
Changes in v2:
- Patch 1: reference leds/common.yaml from the led@[01] node (Krzysztof)
- Link to v1: https://patch.msgid.link/20261107-lm3630a-led-max-microamp-v1-0-ec9e441d9b2c@gmail.com

---
Michiel van Beers (2):
      dt-bindings: backlight: lm3630a: Add led-max-microamp
      backlight: lm3630a: Allow setting the full-scale current per bank

 .../bindings/leds/backlight/lm3630a-backlight.yaml | 10 ++++++
 drivers/video/backlight/lm3630a_bl.c               | 40 +++++++++++++++++++---
 include/linux/platform_data/lm3630a_bl.h           |  4 +++
 3 files changed, 50 insertions(+), 4 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261107-lm3630a-led-max-microamp-c693253a95c5

Best regards,
--  
Michiel van Beers <michielvanbeers@gmail.com>


