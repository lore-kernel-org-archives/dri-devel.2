Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC1A0CA5FFC
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 15:01:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FA2910E151;
	Tue,  6 Oct 2026 15:01:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="JkpbdRIl";
	dkim-atps=neutral
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E34310E151
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 15:01:35 +0000 (UTC)
Received: from francesco-nb (unknown [81.0.251.149])
 by mail11.truemail.it (Postfix) with ESMTPA id 8823F201A2;
 Tue,  6 Oct 2026 17:01:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1791298892;
 bh=WCReoSrP+WxFLri6IhjP00i7qONfVXljIS8JO0K/5xc=; h=From:To:Subject;
 b=JkpbdRIl5EUmQEMPX+yhyJh5beUWJ8DNkXlZjBcFwxQ65VzrYfaXxO0yOc6RswYWD
 8cew4LR9ZOPNIF7TObQXGbeu97P+EcywAp2W3D1P2vDlXOXF+9mFzPXnJ5vW1fmD0g
 QEfdo3530YccdzdsPONS/pyP8lSzR8Y/7yg8O+vFGypSjXAUN28g8gCs+Aj1gEBmY/
 xPxgE6KyEC4vOThjB5El4DNQt8vt84Q9rKc9ZJy2vxxXasS4qmJH0bafn6aXRlKkkU
 aZYmxfe6bB2n/fHId+WbzUy01qYG+LZv8eg4TMb9FDCizRPmNTlH2yumBFL10I9OjP
 qj9aNKGyMBlLA==
Date: Tue, 6 Oct 2026 17:01:28 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: sashiko-reviews@lists.linux.dev
Cc: Francesco Dolcini <francesco@dolcini.it>, robh@kernel.org,
 conor+dt@kernel.org, imx@lists.linux.dev,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Frank.Li@kernel.org
Subject: Re: [PATCH v2 2/4] drm/bridge: Add THine THC63LVD827 LVDS encoder
Message-ID: <20261006150128.GA30406@francesco-nb>
References: <20261005095006.20290-1-francesco@dolcini.it>
 <20261005095006.20290-3-francesco@dolcini.it>
 <20261005100943.1A2711F000FF@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005100943.1A2711F000FF@smtp.kernel.org>
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

On Mon, Oct 05, 2026 at 10:09:42AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] drm/bridge: back-powering via GPIOs on unpowered chip

Not planning to address this feedback unless/till someone comment on it.

For what matter, the HW I have available and I tested with has always-on
power supply.

Francesco

