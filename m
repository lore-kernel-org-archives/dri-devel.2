Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD30CFF885A
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 07:48:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 538E410EA4D;
	Tue, 28 Apr 2026 07:48:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="s6UkoYPr";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D701410EA4D
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 07:48:20 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0C6B3447B8;
 Tue, 28 Apr 2026 07:48:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417F1C2BCAF;
 Tue, 28 Apr 2026 07:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777362496;
 bh=ft9oi09v7e6MaGktTxeycnqTmmPuYqwjGTgoOgQE+Ow=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=s6UkoYPrXiTQxDUl4bAQiXStQr+Bh9R0gc3d4IMmW8E102PEGQWk6t84EZ/S9R4YD
 jZoKh7msf0blhF2IEbox08mZKBwat/WQyHJdW34XjqPWmVDwMR5pbiTwzoSGUwj6vy
 r6GZKn1YqdNrhkTZXmDhzOt29qh9WL17jyQ/SxPlknnGH0AouF0TmNYEibvTEs4mOa
 Vrw6bkNwXohgH1hcK2Sdb4fDCpXjrRTuwLedtrWvopNz/2W9MncfUna+8AyRriFDHH
 /GtTIEk5GxSrntSDuXmxYcI7bjFlbH7LgARBt/KwQ89lBam12gUx6OrQsl3AFqlmM4
 CUb9hBkz3HrUA==
Date: Tue, 28 Apr 2026 09:48:14 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, xsf@rock-chips.com,
 sre@kernel.org, 
 simona@ffwll.ch, airlied@gmail.com, tzimmermann@suse.de, mripard@kernel.org, 
 maarten.lankhorst@linux.intel.com, jesszhan0024@gmail.com,
 neil.armstrong@linaro.org, 
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org, 
 Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH 5/6] dt-bindings: arm: rockchip: Add Anbernic RG Vita-Pro
Message-ID: <20260428-vigilant-grebe-of-tempering-0b5e14@quoll>
References: <20260427170914.5062-1-macroalpha82@gmail.com>
 <20260427170914.5062-6-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260427170914.5062-6-macroalpha82@gmail.com>
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

On Mon, Apr 27, 2026 at 12:09:13PM -0500, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add compatible string for the Anbernic RG Vita-Pro.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>

You combined three completely independent subsystems into one patchset.
Usually that's unnecessary burden on our mailboxes and instead of simple
shazam of entire patchset maintainers need to pick up individual bits.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

