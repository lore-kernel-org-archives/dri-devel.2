Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB46DCA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:18:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F10810EA01;
	Wed, 30 Sep 2026 07:18:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Pzf0dyAq";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3DA610EA01
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 07:17:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A197740B0F;
 Wed, 30 Sep 2026 07:17:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA8D1F000FF;
 Wed, 30 Sep 2026 07:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790752679;
 bh=sVlPijSGwS/YJsioGWYavvm+inL7noio4yizPKHD384=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Pzf0dyAqIRTs15tk1DTWoLXllzel6UV++jSc404qWn5OrSFbjpYFfoPVLkphL20qN
 EI2onN3FmLmHX+SXmies0zLTQyYa6sqhkh284LKLr7WMWFBPyjW1t4EeR6LfZHl2IW
 kP+butbKHqi4W0R+7Cqtg7g/DThxa1C+oQ8k2/+ry23gOSlo7LrtyRDfCf2T6bwbBc
 3jKKxN5l6geosCIXThxHn3brMZcGGg6q8Zftu/M/8cVSae8ffsDjvq0rj/s3kEpO0W
 R2mebFLwRD3N+FZ/kNM4K++XLkY7bmztFed5rAcegk4pSKfixDw+4zIgvaCxcoGRZS
 /eQz71u0jIbGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 5/6] dt-bindings: display: panel: Document Hitachi
 TX10D07VM0BAA and LG LH400WV3 panels
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260930070535.47130-6-clamor95@gmail.com>
References: <20260930070535.47130-1-clamor95@gmail.com>
 <20260930070535.47130-6-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 07:17:58 +0000
Message-Id: <20260930071759.2FA8D1F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] dt-bindings: display: panel: hit,tx10d07vm0baa: additionalProper=
ties: false breaks schema references
- [Medium] dt-bindings: display: panel: hit,tx10d07vm0baa: missing mandator=
y properties in required list
- [Low] dt-bindings: display: panel: hit,tx10d07vm0baa: non-standard avci-s=
upply property
--

commit 2cbee11e4ba06826f435f0f2b5e954558da48338
Author: Svyatoslav Ryhel <clamor95@gmail.com>

dt-bindings: display: panel: Document Hitachi TX10D07VM0BAA and LG LH400WV3=
 panels

This commit documents the device tree bindings for the Hitachi TX10D07VM0BAA
and LG LH400WV3 MIPI DBI 4" WVGA panels.

> diff --git a/Documentation/devicetree/bindings/display/panel/hit,tx10d07v=
m0baa.yaml b/Documentation/devicetree/bindings/display/panel/hit,tx10d07vm0=
baa.yaml
> new file mode 100644
> index 0000000000000..ab839d9e4e111
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/hit,tx10d07vm0baa.y=
aml
[ ... ]
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - hit,tx10d07vm0baa
> +          - lg,lh400wv3-sd04
> +
> +  avci-supply: true

[Severity: Low]
Is it intentional to use "avci-supply" here? In MIPI DBI/DSI displays, the
standard terminology for the analog/core voltage is usually "vci-supply" or
"avdd-supply". Using "avci-supply" might introduce a typoed or non-standard
name into the stable device tree ABI that drivers will be forced to support.

> +  iovcc-supply: true
> +
> +  reset-gpios: true
> +
> +  backlight: true
> +  port: true
> +
> +required:
> +  - compatible

[Severity: Medium]
Does this list omit mandatory hardware constraints?

Since the panel driver unconditionally requires the power supplies and the =
port
node, device trees omitting "avci-supply", "iovcc-supply", or "port" will
pass schema validation but fail at runtime. Specifically,
devm_regulator_bulk_get_const requires the power supplies, and
of_graph_get_remote_node in panel_dbi_prepare() returns -ENODEV if the port
node is missing.

> +
> +additionalProperties: false

[Severity: Medium]
Could this strict constraint cause valid device trees to fail schema valida=
tion?

Because this schema inherits from panel-common.yaml via a $ref, using
additionalProperties: false instead of unevaluatedProperties: false will
strictly forbid standard panel properties (like rotation, width-mm, or
height-mm) that aren't explicitly listed in this local properties block.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930070535.4713=
0-1-clamor95@gmail.com?part=3D5
