Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD390606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 02:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kKrcJN8G
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 436CB10F993;
	Wed, 25 Nov 2026 02:18:41 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB0C410F993
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 02:18:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EE9C861149;
 Wed, 25 Nov 2026 02:18:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E52B1F000C6;
 Wed, 25 Nov 2026 02:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795573113;
 bh=BY7jhoBznX/Z+xbEb2Jgn24xN/yDLFB6MkklmkFq36I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kKrcJN8Gt1rjlZr11omE/IGaVyzWdt94IPbMINgYD0Bbg0FKpNK3rIibFE/dVRQw7
 b57vpxVdTlnl9d/t0qC91alpIKKe3W5WMqhnH0xjyi9dx1nP3b5t/WceMyzPvGcu6k
 884YW/x6pakRq7Y57iqa2weQ/RkByR7Pun1PfRKoLvkV1ja6NEr1gH8tmWoorBy5qt
 gn/BNFwXY7ILFxvIJ8IvjFb8H3/DbxCXMwxGKNB9Sb8as9QovIX/4hT+jAVqn1P5AP
 MBwbWjWXWxe2BbbBgJbnQHkunAee/BPUEwFRTKNH8VxoVHVsNY0lm00Xzo0+MSHZCX
 noepOhefoLfUA==
Message-ID: <sashiko-outbox-232400@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/6] dt-bindings: display: add VIEWE JD9365TX panel
 binding
To: Hefei <3066883572@qq.com>, dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <tencent_A3BF23A8B6E3691F0D567ADF8B84194F4408@qq.com>
References: <20261125021127.1430-1-3066883572@qq.com>
 <tencent_A3BF23A8B6E3691F0D567ADF8B84194F4408@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 02:18:32 +0000
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

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [Medium] dt-bindings: display: undocumented vendor prefix viewe in
  viewe,7kf82
- [Low] dt-bindings: display: filename viewe,jd9365tx.yaml mismatches
  viewe,7kf82
- [Low] dt-bindings: display: ineffective unevaluatedProperties with
  panel-common
- [Low] dt-bindings: display: redundant word binding in subject and
  empty changelog
--

commit a9b7d0a0eec32791c0cd039ed3f37fff50e2bf3a
Author: Hefei <3066883572@qq.com>

> dt-bindings: display: add VIEWE JD9365TX panel binding
>
> Signed-off-by: Hefei <3066883572@qq.com>

[Severity: Low]
The "dt-bindings:" prefix already indicates that this adds a binding, so
"binding" at the end of the subject line is redundant.  Could you also add a
commit description explaining the VIEWE 7KF82 panel module and its hardware
interface?

> diff --git a/Documentation/devicetree/bindings/display/panel/viewe,jd9365=
tx.yaml b/Documentation/devicetree/bindings/display/panel/viewe,jd9365tx.ya=
ml
> new file mode 100644
> index 0000000000000..1043f93623c00
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/viewe,jd9365tx.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/viewe,jd9365tx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: VIEWE 7.0" 720x1280 Jadard JD9365TX MIPI-DSI in-cell panel
> +
> +maintainers:
> +  - Hefei <3066883572@qq.com>
> +
> +description: |
> +  The VIEWE 7KF82 module is a 720x1280 RGB888 video-mode MIPI-DSI panel
> +  based on Jadard JD9365TX. It uses two DSI data lanes and exposes in-ce=
ll
> +  touch over I2C on the same FPC.
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: viewe,7kf82

[Severity: Medium]
Is the "viewe" vendor prefix documented in
Documentation/devicetree/bindings/vendor-prefixes.yaml?  Without a vendor
prefix entry there, both make dt_binding_check and checkpatch.pl fail on
"viewe,7kf82".

[Severity: Low]
Should the schema filename and $id match the compatible string?  The file a=
nd
$id are named viewe,jd9365tx.yaml, whereas the compatible string is
"viewe,7kf82".

> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: Panel VDD supply, usually 3.3V
> +
> +  iovcc-supply:
> +    description: Panel IO voltage supply, usually 3.3V
> +
> +  reset-gpios:
> +    description: Optional panel reset GPIO (omit if board uses POR only).
> +    maxItems: 1
> +
> +  backlight: true
> +  rotation: true
> +  port: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +  - iovcc-supply
> +  - port
> +
> +unevaluatedProperties: false

[Severity: Low]
Does using unevaluatedProperties: false with panel-common.yaml# allow every
property from panel-common.yaml (such as power-supply, enable-gpios, and
panel-timing) instead of restricting the binding to the subset listed here?
Using additionalProperties: false along with reset-gpios: true would enforce
that subset and avoid restating the maxItems: 1 constraint and optionality
already defined in panel-common.yaml.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_A3BF23A8B6E=
3691F0D567ADF8B84194F4408@qq.com?part=3D1
