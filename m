Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FBF6CD98C5
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 05:40:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F7AF10E1DA;
	Mon, 15 Jun 2026 05:40:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="abhgOm2o";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29B3410E1C2
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 05:40:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1152540270;
 Mon, 15 Jun 2026 05:40:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 357E61F000E9;
 Mon, 15 Jun 2026 05:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781502042;
 bh=dDVcmZyuekvrV/bG465ak3v4VzU5afIIbXurQUsiLRc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=abhgOm2ormq9i5VHIdfl5jLbLsiHoTSn2RzNPGRI4t7IzJYHyTZo+A4/hN19oOWSy
 GoX1d41wlOuDMv8YuXS1KMCBBxDkN8eCcVCJa1W3tzHTZY5jMwcVMeIxCNrMeJM6P4
 B+f02rwAv2dmFt3p/3tbHE2JLjlvswSYeuxJTL5rY7stIG8Pz66SvoOZKwzxD2aU/f
 TflxzGZQzRQarXKcxfoi9D1yvdIjcXymtw45L4ZCjtAR63oZy9HLgS5XoEihxRwWSJ
 is3dHbkuWbNlH6DsoBbunrapeVBRiMBQyBit+N2bpTK9+V0gMBpDn5XQb5HLVGZXql
 FudBEJJjUdRVQ==
Date: Mon, 15 Jun 2026 07:40:38 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Paul Sajna <sajattack@postmarketos.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, David Heidelberg <david@ixit.cz>,
 phone-devel@vger.kernel.org, Amir Dahan <system64fumo@tuta.io>
Subject: Re: [PATCH v3 1/4] drm: panel: Add LG LH609QH1 Panel with SW49410
 controller
Message-ID: <20260615-purring-shrew-of-defense-5a19fe@quoll>
References: <20260614-judyln-panel-v3-0-07f4134441bd@postmarketos.org>
 <20260614-judyln-panel-v3-1-07f4134441bd@postmarketos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260614-judyln-panel-v3-1-07f4134441bd@postmarketos.org>
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

On Sun, Jun 14, 2026 at 05:07:58PM -0700, Paul Sajna wrote:
> From: Amir Dahan <system64fumo@tuta.io>
> 
> Add panel driver used by LG G7 ThinQ (judyln)
> 
> Signed-off-by: Amir Dahan <system64fumo@tuta.io>
> Co-developed-by: Paul Sajna <sajattack@postmarketos.org>
> Signed-off-by: Paul Sajna <sajattack@postmarketos.org>
> ---

Please organize the patch documenting the compatible (DT bindings)
before the patch using that compatible.
See also: https://elixir.bootlin.com/linux/v6.14-rc6/source/Documentation/devicetree/bindings/submitting-patches.rst#L46

Best regards,
Krzysztof

