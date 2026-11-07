Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D439606A32C
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 12:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QOqHCVQ+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9520B10E03F;
	Sat,  7 Nov 2026 12:14:28 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A883210E03F
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 12:14:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0FB1043DC4;
 Sat,  7 Nov 2026 12:14:22 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794053661;
 b=npzWmNUNZ34R5cch8soqqYmAWqAemV+Z8A7HrckI1CHrj05UQEA5mYoIp+RfQ5nonoFo
 veq5gEtgYcA0zwR2J/mYJQwjDnzrL2d3tye2s5PqSwPb4nCt13kGHLJRM1X8PnrB6bPep
 2xrwP36bUwSRCEvDe9KwoP+Fwzca6siCPhAqgzDXeiwmcFCqy5AO/oEjuYgfO7MagXuU8
 w+9MkehByJebPpxjNVh16Me4ILh4GdtBqWRMEBI0LiM1tRDQDZZBxF6zF7ee8UP8LUeUr
 O5B8tB0T9Thi2tl8WVru1ecKnCQK73d6RrMjhICqi0I01psqlzv8LDpYqDx6u+1v0Mw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794053661;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=a/Ht/DPx0vhE05XCnItYI6wUb3xXda/qEMJVR7xN6iU=;
 b=QvhzJ39vd4gdxUPNA9hrU9qaI/J47ceNT/TnSZWs91HfrpuEzPDt0u5868fxYDJwjJOR
 qqonj5KSRxfmhN1ndtzPYJpBnmmdes4BdZGs40SE0he45gusiIzpH8stFLweoloRNPiKc
 LciWTInM2pzStBC4LQJwBwZk9boza/Fvx4YA1VknWWGDCNT3nQR+LEjVM7XlFsuMKC/Ee
 KJ3ZYutR4DPjEe6tPYu1rSO++xEaBKrUrqfmU3TwuvqMTQL2M1CC+UxK1UtzFJtZGUUMQ
 U5w5/vlU+8W4IPVNWm7/r3WY41L/Wp3LNtwaEg5O8uwbgy5S9288PrQ7lM0yKE3zEdA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 11F0F1F008A4;
 Sat,  7 Nov 2026 12:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794053661;
 bh=a/Ht/DPx0vhE05XCnItYI6wUb3xXda/qEMJVR7xN6iU=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=QOqHCVQ+twrDCxhQsMidPPRDJschDUnXnTrejWWTCoDrRcs/fB7kZhraWRFzBc70a
 NRWO+VYtuQk8bRpUeNOZmuog+lTZy2Kzx6whyA4+NsXLXGeOIACSNzyfWRyJt7B4Rp
 cD8dtzokqUFfqobuyORaw3fSwZq99zlsdzOVA6mdSWxobwRNKS6eT5upodSysQKebN
 I/mbtE3vrFDX3eSlrrXqWxYEOpdWJPRYX4vD6hy4Z7y75PmG1wRs1mKaIsUKA5YLiX
 v/7yYtaYix4pki6kNJjI8FZzKl8JeJMADIDB9AIKH5Q1Mw3ZBoJsqGKofqlCO6vd/4
 hn8XkMxpNwBMQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 62BCE47BCF;
 Sat,  7 Nov 2026 12:14:20 +0000 (UTC)
From: Michiel van Beers via B4 Relay
 <devnull+michielvanbeers.gmail.com@kernel.org>
Subject: [PATCH 0/2] backlight: lm3630a: Add a per-bank full-scale current
 limit
Date: Sat, 07 Nov 2026 13:13:53 +0100
Message-Id: <20261107-lm3630a-led-max-microamp-v1-0-ec9e441d9b2c@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAEW72oC/yXMTQ6CMBBA4auQWTtJf9IavIpxMQ6jjqFAWjQkh
 LtbZPkt3luhSFYpcGlWyPLVouNQYU8N8IuGp6B21eCMi9aaM/bJR28Ie+kw0YJJOY+UJuTYehc
 8tYED1HzK8tDlv77eDpfP/S087z/Yth88vuKufAAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794053659; l=2212;
 i=michielvanbeers@gmail.com; s=20261107; h=from:subject:message-id;
 bh=M8fM/pimHRx8tpjVsk5Qa5piBItoVw829MhvZQytYiY=;
 b=Gp+M1tpl6Uxw25mEvIymG6qpZ0SfxBhMKPsshgAvw8ZW14OheuknsDPXJOABSPArSVTpM3oNI
 5E8agsqLbrHCkhDIvs1z+fbyG3B5uPxRpD5UocdI741zOZmoIoQbDI9
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
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
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
Michiel van Beers (2):
      dt-bindings: backlight: lm3630a: Add led-max-microamp
      backlight: lm3630a: Allow setting the full-scale current per bank

 .../bindings/leds/backlight/lm3630a-backlight.yaml |  9 +++++
 drivers/video/backlight/lm3630a_bl.c               | 40 +++++++++++++++++++---
 include/linux/platform_data/lm3630a_bl.h           |  4 +++
 3 files changed, 49 insertions(+), 4 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261107-lm3630a-led-max-microamp-c693253a95c5

Best regards,
--  
Michiel van Beers <michielvanbeers@gmail.com>


