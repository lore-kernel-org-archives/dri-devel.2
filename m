Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB4EFCA5FBA
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 12:13:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA77310F35B;
	Wed, 30 Sep 2026 12:12:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="jsjvCGou";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A28D110E8B4
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 02:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:MIME-Version:Content-Type:
 Message-Id:Date; bh=ngyVwzlsuinhFCEe3hVM9MZeEyarwngLyBlfTxiJEC8=;
 b=jsjvCGoueL3koUTM7pGvXEPSMkEetmxKofViAd1ozOBr6uRHgZ9yU268xxoOFs
 OHoBDqnjFT6i3GQ+MZYYBMvCogp1iafwiFE8hVzRJyU1Hpg3i7DsMqM65Fc2qOKn
 FV5ve7hZjQviDpKUhNRWbWUtsRtAaoOcZ88Pi7cSvlS34=
From: Chaosheng Qu <quchaosheng000406@163.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Eduard Bostina <egbostina@gmail.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: ti,
 tpd12s015: Convert to DT schema
In-Reply-To: <20260929121235.GF171869@killaraus.ideasonboard.com>
References: <20260929121235.GF171869@killaraus.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3J8zTcrxqxa_hBg--.51069S2
Message-Id: <6ABC72D3.0795AD.00008@m16.mail.163.com>
X-Coremail-Antispam: 1Uf129KBjvJXoW7KrWDWr15WF47tF1kXFWfAFb_yoW8uryrpa
 y3t3WIkrn5GF4Yy3WIvr40vaySvFs5KFW5JryFkry8u398Jr4xtrZFyF4j9a4DK3s3uw1j
 vFsI9w1ktF4YvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRsFxUUUUUU=
Date: Wed, 30 Sep 2026 10:24:20 +0800 (CST)
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC5BOaEGq8ctOW9AAA3o
X-Mailman-Approved-At: Wed, 30 Sep 2026 12:12:40 +0000
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

Hi Laurent,

Thank you for taking the time.  Two of the three points came from the v1
posting, one of them is a real miss on my side, and there is a fourth
thing I should have found before posting at all -- I get to that below.

The message you replied to is the 09-15 posting.  v3 went out on 09-16:

  <20260916123210.107841-1-quchaosheng000406@163.com>

and it rewrote the commit message to give the rationale you are missing:
why "ti,tpd12s016" can only be a fallback of "ti,tpd12s015" (the driver
matches on "ti,tpd12s015" alone, so a board using the 016 has to list
both), and why gpios has to take three to five entries.  The v2 version
of that description had capped gpios at three, which broke dtbs_check for
omap5-igep0050.dts -- that board passes the three control/HPD lines plus
the DDC SCL and SDA lines.  Rob Herring gave v3 his Reviewed-by on 09-24.

The Assisted-by tag is a fair hit, and it applies to v3 as well: v3 does
not carry one either.  That is my oversight and I will add it.

Your third point also stands for v3.  The conversion and the gpios
semantics change are still one patch.  Splitting them is right.

Now the part I should have caught myself.  This conversion is not new
work.  Eduard Bostina posted the same conversion on 2026-07-30:

  <20260730092245.52034-1-egbostina@gmail.com>

That series makes the same two binding changes -- the "ti,tpd12s016"
fallback compatible and gpios up to five entries -- and its 2/2 renames
the same tpd12s015 endpoint nodes that mine does.  Rob reviewed it on
08-03.  It did not land: there is no ti,tpd12s015.yaml in mainline, v6.18,
v6.17 or linux-next, and the .txt is still in all of them.  I did not find
it before posting mine, and I have cc'd Eduard here.

I would rather ask than add a fourth revision to the pile.  Which would
you prefer:

  - a v4 of mine, split into a pure conversion plus a separate semantics
    patch, or
  - for me to drop mine and leave this to Eduard's series?

Either way I will not repost the current form.  If there is a reason the
Bostina series stalled that I should not repeat, I would be glad to hear
it.

Thanks,
Chaosheng Qu

