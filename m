Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA087106FD9B
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 08:13:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECD5810EB0B;
	Fri, 13 Mar 2026 08:13:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Fk8FfzDh";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC03210EB16
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 08:13:36 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E45416012B;
 Fri, 13 Mar 2026 08:13:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171B9C19421;
 Fri, 13 Mar 2026 08:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773389615;
 bh=UrYSt37MGAER+9Ep72XoXGzY0mFLVlfAzzNxX+EpPbE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Fk8FfzDhYUKL6M5W5CRY1o66y9enM5SZq67F+91bPq0gZfEca7/vXJZucNlrikRNi
 UHrHTIwUxzgEMrT+5+A27HPViBxdLDXkPEsqiGawYrs3kdFxvbCO8H1pn/zaD9KvWn
 h7a0Psx9wtKSvbBbcCI211DuKl/5Cnf+Y1wG4Df0k6MUaWZarrm9n5zuasedO3HAKJ
 4BBHsgaN0pGX1efbUsMYzLL6Nfjn0AHbyDNhWLZqPbnzw62U9J3+zWOwe092TS6iuT
 +ANMb7PKDv+bexAmhiamaPzAJEfg0ksoo5jzasp8U4g5fX1shGcTQ/AOCY8O202INJ
 de4aMnvufw58Q==
Date: Fri, 13 Mar 2026 09:13:33 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yedaya Katsman <yedaya.ka@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>,
 Kamil =?utf-8?B?R2/FgmRh?= <kamil.golda@protonmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: display: panel: Add Samsung
 S6E8FCO-M1906F9
Message-ID: <20260313-lurking-acoustic-angelfish-c1343d@quoll>
References: <20260312-panel-patches-v3-0-6ed8c006d0be@gmail.com>
 <20260312-panel-patches-v3-1-6ed8c006d0be@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260312-panel-patches-v3-1-6ed8c006d0be@gmail.com>
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

On Thu, Mar 12, 2026 at 01:55:08PM +0200, Yedaya Katsman wrote:
> Document Samsung S6E8FCO DTS binding used with the M1906F9 6.09" 720x1560
> panel found in the Xiaomi Mi A3 smartphone.
>=20
> Co-developed-by: Kamil Go=C5=82da <kamil.golda@protonmail.com>
> Signed-off-by: Kamil Go=C5=82da <kamil.golda@protonmail.com>
> Signed-off-by: Yedaya Katsman <yedaya.ka@gmail.com>
> ---
>  .../display/panel/samsung,s6e8fco-m1906f9.yaml     | 63 ++++++++++++++++=
++++++
>  MAINTAINERS                                        |  5 ++
>  2 files changed, 68 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6e8=
fco-m1906f9.yaml b/Documentation/devicetree/bindings/display/panel/samsung,=
s6e8fco-m1906f9.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..927d170793dcd49c19ebe3532=
68980710ad4b5b2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/samsung,s6e8fco-m19=
06f9.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/samsung,s6e8fco-m1906f9=
=2Eyaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung S6E8FCO DSI for the Samsung M1906F9 AMOLED Panel
> +
> +maintainers:
> +  - Yedaya Katsman <yedaya.ka@gmail.com>
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: samsung,s6e8fco-m1906f9
> +
> +  reg:
> +    maxItems: 1
> +
> +  vddi-supply:
> +    description: VDDI regulator
> +  vci-supply:
> +    description: VCI regulator

I pointed out last time to other schemas and after changes you should
notice that it is the same as other bindings. Or almost the same. See:
samsung,s6e88a0-ams452ef01
samsung,s6e88a0-ams427ap24
samsung,s6e8aa5x01-ams561ra01

so should be added there - to the last one - instead of having one more
file. On mentioned schematics I did not see the panel, thus the pin
supply does not need to be named VDDI, just because output of the PMIC
is called like that.

Best regards,
Krzysztof

