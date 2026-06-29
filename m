Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2400BC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 05:36:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6844D10E6BE;
	Mon, 29 Jun 2026 05:36:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mubOly6s";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6FF610E6BE
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 05:36:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 974C441367;
 Mon, 29 Jun 2026 05:36:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 336811F000E9;
 Mon, 29 Jun 2026 05:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782711360;
 bh=l9dWlbCeJC/7EwbHdFhSSobCP7BjKYpgnJ7rWN/KW50=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mubOly6s2y1gpr9i3bJRWy9/+i7ntvC1Y5EsMqYHOBX9XBEDCAHqXNFNAT5QNBLOM
 3qMcARyx2g8gZQ/1P2ccXS+1/pP3tix/sSjAt+6V6sZE8ewUuvpAi3UdtSSieAJtz5
 ORZ8IJtX5qmi+j2BScOsIOWh24ilgX34T3hKahSmaUxQBi0hH+g2KjJhDG7s5dkBCG
 kVk8FSVdT3QDoTOjBTDv8jTCwVK/OYlfRLSi8rE86xgZ9JvG0UNQxi9UfJHxQDNDCD
 6+oLidHSmByJes9T2zEhBMkc6+V+AuCHYyK/yaKCeT2rm3aOBG0B6tRinLvd6IXbVZ
 LLgcTGx58l7bQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dt-bindings: display: verisilicon,dc: make resets
 non-optional
To: "Icenowy Zheng" <zhengxingda@iscas.ac.cn>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org
In-Reply-To: <20260629053017.4050868-1-zhengxingda@iscas.ac.cn>
References: <20260629053017.4050868-1-zhengxingda@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 05:35:33 +0000
Message-Id: <20260629053600.336811F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The commit message incorrectly states that the controller requires =
'two reset lines', while the actual binding schema and examples define thre=
e reset lines ('core', 'axi', 'ahb').
--

commit 11712ddd9a2861c41656c6eb9cdbd525c93e3665
Author: Icenowy Zheng <zhengxingda@iscas.ac.cn>

dt-bindings: display: verisilicon, dc: make resets non-optional

This commit makes the resets and reset-names properties mandatory for the
DC8200 controller variant. The commit message notes that the in-tree
device tree already populates these lines and the driver handles them
gracefully if missing in other variants.

> The only variant supported by the binding now, the DC8200 controller on
> T-Head TH1520, requires two reset lines.

[Severity: Low]
Is the description of "two reset lines" accurate here?=20

Looking at the existing schema in verisilicon,dc.yaml under the resets
property, it defines three reset items (DC Core reset, DMA AXI bus reset,
and Configuration AHB bus reset). Should the commit message mention three
resets instead of two?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629053017.4050=
868-1-zhengxingda@iscas.ac.cn?part=3D1
