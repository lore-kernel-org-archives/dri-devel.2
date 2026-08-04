Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A5FC55172
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 08:10:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8555110E8B2;
	Tue,  4 Aug 2026 08:10:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="X76+43/P";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0D7210E8B2
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 08:10:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 39F19600AA;
 Tue,  4 Aug 2026 08:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58F91F000E9;
 Tue,  4 Aug 2026 08:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785831020;
 bh=HK2mOEFu5c1wB4tY1bP/40iRB3Ii0SZiaq+PZXMRqlQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=X76+43/PbPHDl32te8uRj5u/CH1ysfJwAAwJRMB8ycZtOwuCqZQJULGxvfXSSSTh8
 /ketg4WOTnBGaAx5PnJc1LRybShTZrIVfs471/HD+4SmQ/mSyw0KqzF1w7f5A2o6dG
 sqhg/FdxQr7YhaenUBw32SOFOyftNTuODrwRp/F3cZy4OxOuHWnKilQSntsqHT6qNJ
 8Ie6EXbA5TTRMFDQvB92RFbaTEFuHuq4HLweWrK/NfdtCvMGdMRMQ8wKDGP25/GSy0
 fW7vTNB5xOzdqUHs6v1bghN1iDuYEDaFtX3ZeGTGqBcfrAmR8ExB7+MhTC3n1Yk+jl
 HtYpqeMfDUBRg==
Date: Tue, 4 Aug 2026 10:10:17 +0200
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
Subject: Re: [PATCH 1/4] dt-bindings: display: panel: novatek,nt36523: add
 the Mi Pad 5 Pro 5G panel
Message-ID: <20260804-dazzling-swallow-of-saturation-696eac@quoll>
References: <20260730-sm8250-xiaomi-enuma-v1-0-ed6d8fb99668@dawidwrobel.com>
 <20260730-sm8250-xiaomi-enuma-v1-1-ed6d8fb99668@dawidwrobel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260730-sm8250-xiaomi-enuma-v1-1-ed6d8fb99668@dawidwrobel.com>
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

On Thu, Jul 30, 2026 at 11:52:00PM +0200, Dawid Wr=C3=B3bel wrote:
> The Xiaomi Mi Pad 5 Pro 5G (enuma) ships the same CSOT panel as the Mi
> Pad 5 Pro (elish), so it falls back to the elish compatible. Give it a
> device-specific one in front, so a later difference does not need a
> device tree change.
>=20
> Signed-off-by: Dawid Wr=C3=B3bel <me@dawidwrobel.com>
> ---
>  Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml | 4=
 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

