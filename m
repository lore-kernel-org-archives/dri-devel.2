Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE0B606A331
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VrSQrjOq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C69910E7F1;
	Wed, 18 Nov 2026 12:27:07 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45A0810E7F1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 12:27:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EC2114391B;
 Wed, 18 Nov 2026 12:26:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C97D1F000C4;
 Wed, 18 Nov 2026 12:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795004819;
 bh=Nq6nHtcQPov6ng/GWbkcWdOEm4htQT9mHmFTo86WOlM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VrSQrjOq0nmUymOLLSCiUHOsQN/TLXPfgsyaCQFA8P5f9O6PZV2HvPy7tPM4A6QN7
 RD1YWdG79mV0HJwAJPdd28In/P+cRD+rxlruKAjjJCHsOd8frG1IU179eKm8xAO9fW
 udRisRAaGIMA0h0BP1IuuShD8B+hOnvPLJECTf7vHnBOo2o1snVjQ0uru+ZC7y964D
 kTaMG8O2Hhpgn9xCuvJT2iN0f37hdYbQe+wRn8QHId5LQ4xK6/6KxbcU1bhpxyMGAe
 o/fHTEo7e93rehvurXz0mNyDbfmThjBsbnuTMBDIL/Qp2oRSpQarKGce2YTxznva9U
 EaJ7O/+jW2ojw==
Message-ID: <sashiko-outbox-220911@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/10] arm64: dts: qcom: sm8250-lg-timelm: enable
 SW43103 panel
To: "Abdur Rofik" <rofikcoga@gmail.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 dmitry.torokhov@gmail.com
In-Reply-To: <20261118120714.31505-8-rofikcoga@gmail.com>
References: <20261118120714.31505-1-rofikcoga@gmail.com>
 <20261118120714.31505-8-rofikcoga@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 12:26:59 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] arm64: dts: qcom: unused dt-bindings/phy/phy.h include in
  sm8250-lg-timelm.dts
--

commit 374b6a1bedb56450ce91de89b10571b27d001468
Author: Abdur Rofik <rofikcoga@gmail.com>

arm64: dts: qcom: sm8250-lg-timelm: enable SW43103 panel

This commit enables MDSS, DSI0, and its PHY, and attaches the LG SW43103
panel in the sm8250-lg-timelm device tree.

> diff --git a/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts b/arch/arm64/b=
oot/dts/qcom/sm8250-lg-timelm.dts
> index 1b2b67486fee7..d307a52cd0e62 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
> @@ -8,6 +8,7 @@
> =20
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
> +#include <dt-bindings/phy/phy.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  #include "sm8250.dtsi"
>  #include "pm8150.dtsi"

[Severity: Low]
Is <dt-bindings/phy/phy.h> needed here?  None of its macros are used in
sm8250-lg-timelm.dts.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118120714.3150=
5-1-rofikcoga@gmail.com?part=3D7
