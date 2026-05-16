Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE49CD4F25
	for <dri-devel@archiver.kernel.org>; Sat, 16 May 2026 10:10:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C42BA10E06B;
	Sat, 16 May 2026 10:10:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YgCmL5Bm";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1285C10E06B
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 10:10:45 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 46F5F601E5;
 Sat, 16 May 2026 10:10:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6886BC2BCC7;
 Sat, 16 May 2026 10:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778926244;
 bh=1qvLF+Zqi75df4aB2OVRCs7kHbPNN8nrk32CUkEYElk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YgCmL5BmnQv6t1PCS9Ixh+uGJu+zHYaCC956+X4QQEwklkQaN6XBpH9i7w3V1eivo
 aNmDZougxQazSBdQ5XtWLR6Z3hihax05oLgszwI6FKgtgDxz7sFpRzmG17CQuKVklA
 0ywYaKtBLScEsDTIIL4vMwZTxUtZmShcWwzM64CRWvxOfmt3UpSkS4XL6L+yd2XGW4
 kmUvW6z6a1s0UFKHw2Bm3qSMAukMpMmb3xzWNAkUoaBcL1O3GVKYJuT0ayok02KdHt
 nLaYjO8mZZxxtZjGrpElYVPrbB+tmXNzDoZZQW3Fiovo6xcaJdGjcE4AKuQrthXkTx
 zR36C89fxi1rw==
Date: Sat, 16 May 2026 12:10:41 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Frank.Li@oss.nxp.com
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
 Sam Ravnborg <sam@ravnborg.org>,
 "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>, 
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 1/1] dt-bindings: display: simple: add avic,tm097tdh02
 panel
Message-ID: <20260516-gigantic-enchanted-lyrebird-f39fce@quoll>
References: <20260515195935.2415466-1-Frank.Li@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260515195935.2415466-1-Frank.Li@oss.nxp.com>
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

On Fri, May 15, 2026 at 03:59:34PM -0400, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Add compatilbe string avic,tm097tdh02 for AVIC Optoelectronics 9.7".

Please stop with these single liners without any explanation.

Best regards,
Krzysztof

