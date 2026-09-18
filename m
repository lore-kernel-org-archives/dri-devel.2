Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3621EC982D2
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 08:55:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A24C610F270;
	Fri, 18 Sep 2026 08:55:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GWhxTCOn";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D4BB10F270
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 08:55:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 762C0413CB;
 Fri, 18 Sep 2026 08:55:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189461F000FF;
 Fri, 18 Sep 2026 08:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789721737;
 bh=Q3vK+hrez7Ed1fDsl2TVjNVdL2Vp9oUFESzWid8IhF0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=GWhxTCOnTtlFovIZHK2qxAQPf4EAqwRc2LiGpoMZpF80nlaiHWuvtipfLpZT5Rhkg
 h7dGte7v2M8uzKuHphGdDgxXMM1ayQHzEnUNCQSUupkayOjhAUM7lrnFJy/nwlPJVG
 +CwDXoUhoDyCp80GKNUd9GzuyUfl5xT9xi4ufKmHas+RKI9DlgBu91G4KEF7G2JWBO
 dgzyj8wjun6MW4UZFKUtMbu1eAX1UL2Ll/7rqmZZTICBslkEb+Nh40Pbw/fBmFX9mI
 hC9HuQ1jG64n1s0pW+vDTBVYM/wt5fg7YGCM7ivCI93N+6APTGbtfeWE9rByH/JG6N
 SSWCCaD5uhQPw==
Date: Fri, 18 Sep 2026 10:55:32 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>
Cc: Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Stefan Wahren <wahrenst@gmx.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
 Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/4] dt-bindings: display: bcm2835-v3d: Add an
 optional reset line
Message-ID: <20260918-nostalgic-enlightened-macaw-8f4e5a@quoll>
References: <20260915-vc4-reset-control-v2-0-cb3a25b07822@igalia.com>
 <20260915-vc4-reset-control-v2-2-cb3a25b07822@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260915-vc4-reset-control-v2-2-cb3a25b07822@igalia.com>
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

On Tue, Sep 15, 2026 at 05:51:25PM -0300, Ma=C3=ADra Canal wrote:
> The BCM2835 power management block drives a reset line for the V3D block
> that is independent of the graphics power domain, allowing the GPU to be
> reset without power-cycling the domain. Expose this reset line in the V3D
> binding.
>=20
> Keep the property optional, as devices like the Broadcom Cygnus don't have
> a reset line.
>=20
> Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> ---
>  Documentation/devicetree/bindings/display/brcm,bcm2835-v3d.yaml | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

