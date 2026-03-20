Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA1D1099B49
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 22:32:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C52210EB45;
	Fri, 20 Mar 2026 22:32:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="vFq6emCH";
	dkim-atps=neutral
Received: from mail-10696.protonmail.ch (mail-10696.protonmail.ch
 [79.135.106.96])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF40410EB45
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 22:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1774045944; x=1774305144;
 bh=QyU3KziqZxd9HOhx4Gs65M6cMH9dTEoOjkIOFlgjlAc=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=vFq6emCHQOyQdgP2aUob/id6mm+oqQrrLlZ0+Br2YAZCJIfE+0p1PO7CNZqeL+S8O
 Ce0CGIzI/T+aWIqq175gvxn67Pf0xf/y4YEm1qunOk8NApn8xoZkrWdlYZ09ZuRr22
 AUqFDNDwaJ8aOFkXGRq9XVelRMOBbwl/FEWkWZ3x5V181w54WtNeaoS3plf0VrhrA+
 wbHiMiCviLIUboZpHG0lX/KDlaB9e1jriYoIAjgVOmTuxPVvvNDNrKXuxTn7G5gQuB
 xgN1Hqo1XNX3uw8q+CqX+d6qHf25GkpYKu5Q5R9TEmN/5Fs6Dn/ZxZ4BuQT/FzyHh7
 XDemqkqBxICHQ==
Date: Fri, 20 Mar 2026 22:32:18 +0000
To: Krzysztof Kozlowski <krzk@kernel.org>
From: cristian_ci <cristian_ci@protonmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: display: panel: Add Novatek NT35532
 LCD DSI
Message-ID: <oMTrCB7euJojLz1EUHDhHCq071GQWD0g7-sqwahA62CnM-sVw08UCNhKdgHX2NrEN3H8iRhc0suejuq5JZ39UA2nEfKhRq9qwYJWSxCrAtc=@protonmail.com>
In-Reply-To: <20260319-amorphous-pastoral-turtle-851af9@quoll>
References: <20260318-rimob-new-features-v2-0-c1bf8917449e@protonmail.com>
 <20260318-rimob-new-features-v2-1-c1bf8917449e@protonmail.com>
 <20260319-amorphous-pastoral-turtle-851af9@quoll>
Feedback-ID: 27475468:user:proton
X-Pm-Message-ID: aa5d67d40f9ced9875dfeb1b6597c0c1dad3b0c0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Thursday, March 19th, 2026 at 10:09, Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:

> On Wed, Mar 18, 2026 at 11:28:09PM +0100, Cristian Cozzolino wrote:
> > +  avdd-supply:
> > +    description: positive boost supply regulator
> > +
> > +  avee-supply:
> > +    description: negative boost supply regulator
> > +
> > +  vci-supply:
> > +    description: regulator that supplies the analog voltage
> > +
> > +  vddam-supply:
> > +    description: power supply for MIPI interface
> > +
> > +  vddi-supply:
> > +    description: regulator that supplies the I/O voltage
> > +
> > +  port: true
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reset-gpios
> > +  - avdd-supply
> > +  - avee-supply
> > +  - vci-supply
>=20
> Only VDDI is required according to datasheet (see page 11 and page 16).

Just to be sure, are you mentioning the part saying there are multiple=20
power modes (2-1PWR, 2-2PWR, 3=C3=A9WR and 4PWR) related to NT35532?=20

> Others are needed only in specific configurations, which I would ignore
> for the simplicity of the binding. Drop these three.
>=20
> Previous discussion point was about this - write bindings based on
> datasheet, since it is available.

I've removed avdd, avee and vci supplies from 'required' properties=20
and I've also tested the new bindings (just for completeness). Now,=20
I'm going to reintroduce again the issue already raised previously=20
(for which I received no replies in v1): should I submit a v3=20
series including my new changes or I've to stick with v2 here, in=20
order to address review concerns about binding, first?

> > +  - vddi-supply
> > +  - port
> > +
> > +additionalProperties: false
>=20
> Best regards,
> Krzysztof
>=20
> 
