Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762DA606A332
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 12:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bYC/PfWG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C34A10F6C7;
	Tue, 17 Nov 2026 12:47:34 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94ED489C68
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 12:47:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B637B63487;
 Tue, 17 Nov 2026 12:47:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33B11F000C8;
 Tue, 17 Nov 2026 12:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794919647;
 bh=L4CuJ/U6jBRxqbp2KP8YKiaenuPUuuIlyYrCtnXO1z0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bYC/PfWGXJucbpdFYe0lMasv9xm6Wmw8RNzAp8HSd33c5FZt7mId33boPRthhHcb2
 dGerJ1LFGRqOvDlvjN5evjMuEkp+mC32EgFMAWqJnmf1SVrUXVJcQrcLiTLT697lJQ
 0apwHitK/o7u0okcXHRGL/8rnOQ+QQb0uDQcRDkLUruvzl29g16tnGZeQUQaY4CgVQ
 AEvnSMVF4sdX7ZpkdAqJyMrK5CQVdXTfS4hGuUHrIBdOP7IFohABGz6LQA3O/npHCf
 uBzgpbd8nQrZ+bN/9ARvQRBGus9ePC7bFAVIr7GXMMozwTro1kBDbywIy7rjXKVFSk
 lKVXSnYQ5R1Vg==
Message-ID: <sashiko-outbox-218789@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 01/11] dt-bindings: arm: qcom: add LG V60 ThinQ 5G
 (timelm)
To: rofikkerneldev <rofikcoga@gmail.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 dmitry.torokhov@gmail.com
In-Reply-To: <20261117123946.668557-2-rofikcoga@gmail.com>
References: <20261117123946.668557-1-rofikcoga@gmail.com>
 <20261117123946.668557-2-rofikcoga@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 12:47:24 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] dt-bindings: arm: qcom: username in Signed-off-by instead of
  real name
- [Low] dt-bindings: arm: qcom: duplicate lge vendor prefix instead of
  lg
--

commit 3057431969983ea736dadadbf8f06be7752765b6
Author: rofikkerneldev <rofikcoga@gmail.com>

> dt-bindings: arm: qcom: add LG V60 ThinQ 5G (timelm)
>
> Document the compatible for the LG V60 ThinQ 5G (timelm), based on
> SM8250, and register the LG Electronics vendor prefix.
>
> Signed-off-by: rofikkerneldev <rofikcoga@gmail.com>

[Severity: High]
The Author header and Signed-off-by trailer use a handle (rofikkerneldev)
instead of a known real human name, which is required by the Developer's
Certificate of Origin in Documentation/process/submitting-patches.rst.

> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentat=
ion/devicetree/bindings/arm/qcom.yaml
> index 121ca557ce1ef..f8b34109171d0 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -1139,6 +1139,7 @@ properties:
> =20
>        - items:
>            - enum:
> +              - lge,timelm
>                - qcom,qrb5165-rb5
>                - qcom,sm8250-hdk
>                - qcom,sm8250-mtp
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
> index 5471a06f93f10..fa50a81880f0b 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -971,6 +971,8 @@ patternProperties:
>      description: Lenovo Group Ltd.
>    "^lg,.*":
>      description: LG Corporation
> +  "^lge,.*":
> +    description: LG Electronics
>    "^lgphilips,.*":
>      description: LG Display
>    "^libretech,.*":

[Severity: Low]
Should this use the existing "lg" vendor prefix (lg,timelm) instead of
adding a duplicate "lge" prefix?

Documentation/devicetree/bindings/vendor-prefixes.yaml already defines
"^lg,.*" for LG Corporation, and commit 5e4aac2caf12 ("dt-bindings: arm:
qcom: rename vendor of apq8026-lenok") replaced "lge" with "lg" in
Documentation/devicetree/bindings/arm/qcom.yaml to avoid separate vendor
prefixes for internal divisions of LG.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117123946.6685=
57-1-rofikcoga@gmail.com?part=3D1
