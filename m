Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D28F1C531D0
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 20:42:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18F6810E4ED;
	Mon, 27 Jul 2026 20:42:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ReHLQb+t";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9C9E10E4C8;
 Mon, 27 Jul 2026 20:42:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7667860A8D;
 Mon, 27 Jul 2026 20:42:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311BE1F000E9;
 Mon, 27 Jul 2026 20:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785184961;
 bh=IxZYhRoqemN3/PXznozCuAsbksxqgixe/3D8d9pTlaQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ReHLQb+tPn5sxscrJNPGhOb74GZKP5C/ZxC5RiFy7i5TDUPwqCfGZlgKiGd27TJYC
 lSCezZYLcNhnDsylGnf6QBo2WjpOJ2nQvpdXMrdC16zAdQaQMZ5+CnhL8eekWvg1Om
 Y/cYN8YL3/EuTGsvldLfbK/WUoEmPUiNAXTAutUz6I5iLwLPWA/ICJVg0hoXWdw/by
 HO7lh3xCpZp0oEcygADTXVehJb+DMtduTuIZbT0EfR7bjrTBk5kYfsWCBvwjucijJC
 G4OaCZM+hh2b1HX23cLsQ5fz7nyJZlPdjCaA9YaHENsb4ABuy00QnQipZD8rJikXUZ
 VjMgNmZJSRZVA==
Date: Mon, 27 Jul 2026 22:42:36 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Jun Nie <jun.nie@linaro.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Simona Vetter <simona@ffwll.ch>, Jessica Zhang <jesszhan0024@gmail.com>, 
 David Airlie <airlied@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Conor Dooley <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 linux-kernel@vger.kernel.org, Dmitry Baryshkov <lumag@kernel.org>, 
 Maxime Ripard <mripard@kernel.org>, linux-arm-msm@vger.kernel.org, 
 Marijn Suijten <marijn.suijten@somainline.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v5 5/6] dt-bindings: display: Add Synaptics R63455 panel
 support
Message-ID: <20260727-married-nifty-dalmatian-dfbe04@quoll>
References: <20260727-sm8650-7-1-bonded-dsi-v5-0-c042266b9eeb@linaro.org>
 <20260727-sm8650-7-1-bonded-dsi-v5-5-c042266b9eeb@linaro.org>
 <178514563985.1199273.4525119457881224571.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <178514563985.1199273.4525119457881224571.robh@kernel.org>
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

On Mon, Jul 27, 2026 at 04:47:19AM -0500, Rob Herring (Arm) wrote:
> 
> On Mon, 27 Jul 2026 16:08:44 +0800, Jun Nie wrote:
> > Add support for the dual-panel system found in the virtual reality device.
> > This system consists of two physical 2160x2160 panels, each connected via
> > a MIPI DSI interface. The backlight is managed through DSI link.
> > 
> > Signed-off-by: Jun Nie <jun.nie@linaro.org>
> > ---
> >  .../bindings/display/panel/synaptics,r63455.yaml   | 133 +++++++++++++++++++++
> >  1 file changed, 133 insertions(+)
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/display/panel/synaptics,r63455.yaml:26:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/panel/synaptics,r63455.yaml: properties:ports: 'anyOf' conditional failed, one must be fixed:
> 	'type' is a required property
> 	'$ref' is a required property
> 	hint: node schemas must have a type or $ref
> 	from schema $id: http://devicetree.org/meta-schemas/core.yaml

Seems nothing here was build-tested :/

Best regards,
Krzysztof

