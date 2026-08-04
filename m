Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08838C5518F
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 08:10:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54BF010E2CC;
	Tue,  4 Aug 2026 08:10:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KQVyEfBp";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E76D10E2CC
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 08:10:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 347CA600AA;
 Tue,  4 Aug 2026 08:10:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBDC21F000E9;
 Tue,  4 Aug 2026 08:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785831001;
 bh=VrBXCN3GIeWBskfmTx6nnVtVNeo062ZuqGS8rhG0WW8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=KQVyEfBp74+IpIgyL9awrzkbnHtYGOUCLbaBFBuvaEppXK+f+KsEYfm/fPwBfk/MH
 yCAJpkVze88kLSph+kr8He4Gp7KaxnuRlYmB+Sza5aF2DymKaimGkQ3S+/lQgTjGgZ
 oQpZx61helPfdFqRyQ+wPv9Z2dTr58CdE5lrk1WSkdMD8klmy38/9lXb2Qj2mw6sHh
 j+esN1yqao68iRF0upoJxQp20UOhGAeYZMR4nFzCHxmrp80BijooAEjbp6C1lhJq2H
 ht8FBZnY4bfsHbJ7tIulnczCTnI11B2Y6fZGtZGK4bcDdzI1jnIKiL6H0XBI3BTnzB
 MJEi5b+iKUzjQ==
Date: Tue, 4 Aug 2026 10:09:58 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dawid =?utf-8?Q?Wr=C3=B3bel?= <me@dawidwrobel.com>
Cc: Jianhua Lu <lujianhua000@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: arm: qcom: add the Xiaomi Mi Pad 5 Pro 5G
Message-ID: <20260804-bison-of-good-democracy-09ce5b@quoll>
References: <20260730-sm8250-xiaomi-enuma-v1-0-ed6d8fb99668@dawidwrobel.com>
 <20260730-sm8250-xiaomi-enuma-v1-2-ed6d8fb99668@dawidwrobel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260730-sm8250-xiaomi-enuma-v1-2-ed6d8fb99668@dawidwrobel.com>
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

On Thu, Jul 30, 2026 at 11:52:01PM +0200, Dawid Wr=C3=B3bel wrote:
> The Mi Pad 5 Pro 5G (enuma) is the modem-equipped variant of the Mi Pad
> 5 Pro (elish) and shares its board design, so it falls back to the elish
> compatible.
>=20
> Signed-off-by: Dawid Wr=C3=B3bel <me@dawidwrobel.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 5 +++++
>  1 file changed, 5 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

