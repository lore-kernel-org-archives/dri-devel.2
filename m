Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE58C88E56
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 06:32:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B359010E837;
	Sun, 13 Sep 2026 06:32:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aOTDGI9j";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A88810E837
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 06:32:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4F0B460AB1;
 Sun, 13 Sep 2026 06:32:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73D61F000FF;
 Sun, 13 Sep 2026 06:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789281164;
 bh=NZCHlCso1bQGIQGhkIvs1DEMC0Cc6rgsFmUAlTSRCvg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aOTDGI9jwMIwYpgmnovawS7fCvVe5FXIy9s2hvVBiCmZiltQX3QL9o8RUAzXp9Pba
 W0Ee0e26qvQFlG48bIm2xsMmQ5oXVgBr4RiDPsUfl17HrdymY5dZPd/iz5BgFcgLeN
 9KsGfdg0CaqqXvU6hn1QBQr6PEM8GhJcoZ6wA51MUUQYb/fPmxDb+ltv5SkwPaLrmH
 8JiXUFL1B+e/PNx5wkQdtCB+iwqlxgIdroY7eIvQewMyh3chgm4xnUCnvOVhePurHd
 Q04ijj8VL9ybivrPLXXxqNHmgibtwisnsLkP/W1ifTwxUYDVJZWVtPSP1HBbLpxucf
 QhLsjyL2XekIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/9] dt-bindings: display: novatek,nt36672a: Add 5 new
 panels
To: "Alexey Minnekhanov" <alexeymin@minlexx.ru>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260913-nt36672a-panels-v1-3-ce097402c6ea@minlexx.ru>
References: <20260913-nt36672a-panels-v1-0-ce097402c6ea@minlexx.ru>
 <20260913-nt36672a-panels-v1-3-ce097402c6ea@minlexx.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 06:32:43 +0000
Message-Id: <20260913063243.B73D61F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Incomplete Documentation Update
- [Low] Alphabetical ordering violation in compatible strings
--

commit fe459608210d248fe11d7e07e8ba300ec1c7b36a
Author: Alexey Minnekhanov <alexeymin@minlexx.ru>

dt-bindings: display: novatek,nt36672a: Add 5 new panels

This commit documents 5 new display panels that use the Novatek NT36672A
driver. These panels are used in various smartphones produced by Xiaomi
and ASUS.

> diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36=
672a.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36672=
a.yaml
> index 5d16d85117254..3671fd788a818 100644
> --- a/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.ya=
ml
> +++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.ya=
ml
> @@ -22,7 +22,12 @@ properties:
>    compatible:
>      items:
>        - enum:

[Severity: Low]
Could the main description block be updated to reflect these additions?
The top-level description property for novatek,nt36672a.yaml currently says
"Right now, support is added only for a Tianma FHD+ LCD display panel with
a resolution of 1080x2246." Since this commit adds 5 new panels to the
compatible items enum below, the description is now outdated.

> +          - shenchao,fhdplus-video
>            - tianma,fhd-video
> +          - tianma,tl060fvxs16-00
> +          - tianma,tl063fvmca01-00
> +          - tianma,tl063fvmc43-02

[Severity: Low]
Is it possible to sort these compatible strings alphabetically? In ASCII,
the character 4 comes before a, so it seems like "tianma,tl063fvmc43-02"
should precede "tianma,tl063fvmca01-00" in this enum list.

> +          - txd,txdi600yanpa-43v3
>        - const: novatek,nt36672a
>      description: This indicates the panel manufacturer of the panel that=
 is
>        in turn using the NT36672A panel driver. This compatible string

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913-nt36672a-p=
anels-v1-0-ce097402c6ea@minlexx.ru?part=3D3
