Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F221F532C3
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 01:11:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7885310E2AB;
	Tue, 24 Mar 2026 01:11:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gQ1Lq8CX";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6328D10E2AB
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 01:11:47 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9A16B600C4;
 Tue, 24 Mar 2026 01:11:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D41BC4CEF7;
 Tue, 24 Mar 2026 01:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774314706;
 bh=E9cCMGjU8K/dZwwXBy/xpq2fkGmeV9HMWGks3FqOKNI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gQ1Lq8CX51IIxGWUqO11sOlbruLXVao0SZGoZNySK9vJ6XwePjpA4KDCDLAs1j2bp
 1mFtRYrkIYb2lCfwKFHcla3OkyR30bsASk2+PyJsdJfIHk327coc/tv2E9qhEje9Gl
 s3c+bB0ftwqgTMkXK6WCbKY5g6E/qsb6Hh0TggtVqC3zxIjTItg1ZlucwLF2WpXYJh
 CUkdtahcKgWBVNCuN7ImriXsSvrf7fTVm7L4zrAqy/ktbZnIUmdGPTT6fFTwd0BH53
 XEuakGprR/gt4xf/B10L629e2GjanTSmS661xug+IA/zuAn7c5Q0LPAWKLEnaRwsMk
 TGlKjOeLjzRdQ==
Date: Mon, 23 Mar 2026 20:11:45 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Pengyu Luo <mitltlatltl@gmail.com>
Cc: devicetree@vger.kernel.org, Simona Vetter <simona@ffwll.ch>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v4 1/2] dt-bindings: display: panel: Add Himax HX83121A
Message-ID: <177431470438.1869567.10359365187485586761.robh@kernel.org>
References: <20260316084040.728106-1-mitltlatltl@gmail.com>
 <20260316084040.728106-2-mitltlatltl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316084040.728106-2-mitltlatltl@gmail.com>
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


On Mon, 16 Mar 2026 16:40:39 +0800, Pengyu Luo wrote:
> HX83121A is a driver IC used to drive MIPI-DSI panels. It is found
> in HUAWEI Matebook E Go series (Gaokun2/3) with BOE or CSOT panels.
> 
> Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
> ---
> v4:
> - use v2 as the base since v3 was using v1 as the base by mistake
> - remove '|' from description (Krzysztof)
> - drop description for reset-gpios (Krzysztof)
> 
> v3:
> - remove '|' from description (Krzysztof)
> - drop description for reset-gpios (Krzysztof)
> ---
>  .../display/panel/himax,hx83121a.yaml         | 91 +++++++++++++++++++
>  1 file changed, 91 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/himax,hx83121a.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

