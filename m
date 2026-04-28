Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58809FF885D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 07:49:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9CB010EA4F;
	Tue, 28 Apr 2026 07:49:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QYu2LQAQ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B76B10EA57
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 07:49:39 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 6BEEA60154;
 Tue, 28 Apr 2026 07:49:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD74C2BCB6;
 Tue, 28 Apr 2026 07:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777362578;
 bh=3ElNfMSZSM4UEx+D4roCAQFNWHGugNmlQtBq5aXJQ8o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QYu2LQAQ2bTwVIgJMiupZ1xKfY2vpDjaxpd8EnJGy1SX/ZZa+8niTzyTrDhCd6j3s
 AlzDvAoAhWuB6Pwp0J8RMdWayozbqMlgxyqkM4Xs/ftQePufk0+a6WEFHcfzak3BMN
 tDYAUtaP3/4ZYN+kmQKDaGQvbNlRbEjFYQ1sF7ermCGfdLwp/5gE5aAncpA12ApXcx
 rxee15S0csAOCdOBIC8lC6YDePeAFd8lpnlQWfP7TOB3F784KmvosGNmlkM+3KIXri
 17+IAykFGNqqIBFq5lcp+48EIcU7HRNJqipXN95nSiCCSaFvLjl8NpQb9WAn2vZtM3
 Kt+hJiUL0zsBA==
Date: Tue, 28 Apr 2026 09:49:35 +0200
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
Subject: Re: [PATCH 3/6] dt-bindings: display: panel: document Anbernic
 TD4310 panel
Message-ID: <20260428-golden-tamarin-from-heaven-c500e8@quoll>
References: <20260427170914.5062-1-macroalpha82@gmail.com>
 <20260427170914.5062-4-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260427170914.5062-4-macroalpha82@gmail.com>
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

On Mon, Apr 27, 2026 at 12:09:11PM -0500, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> The panel used by Anbernic in the RG Vita-Pro is a DSI panel based
> on the TD4310 controller IC. It measures approximately 5.5 inches
> diagonally and is 1080x1920 in resolution.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  .../display/panel/anbernic,td4310.yaml        | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/anbernic,td4310.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/anbernic,td4310.yaml b/Documentation/devicetree/bindings/display/panel/anbernic,td4310.yaml
> new file mode 100644
> index 000000000000..2da957cd5d49
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/anbernic,td4310.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/anbernic,td4310.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Anbernic TD4310 Based Panels
> +
> +maintainers:
> +  - Chris Morgan <macromorgan@hotmail.com>
> +
> +description:
> +  Bindings for Anbernic TD4310 Based Panels, such as the RG-Vita-Pro

Description says what the bindings are for. Your description says that
bindings are for "bindings for"... Just describe the hardware.


> +  panel (a 1080x1920 5.5 inch panel).
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: anbernic,panel-vita-pro
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: Panel power supply
> +
> +required:
> +  - compatible
> +  - reg

supply as well. most likely

> +  - reset-gpios
> +  - port

Best regards,
Krzysztof

