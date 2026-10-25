Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96242606A31A
	for <dri-devel@archiver.kernel.org>; Sun, 25 Oct 2026 06:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z84HQXUy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD01810E21D;
	Sun, 25 Oct 2026 06:56:37 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3B1E10E21D
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 06:56:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2CF5B40A8F;
 Sun, 25 Oct 2026 06:56:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C07B11F01825;
 Sun, 25 Oct 2026 06:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792911391;
 bh=0ezsd3nRAc1ZdSjbShWOpXeUqPu76DzysMbu8VG82ew=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Z84HQXUyKfjkbOnq+6kmxAtWsVbpgQUElAO8vBlc353DH+a2hYZv1McwdBq2Nr4rG
 eRmbLkJTj7UwLRVO4g67shJ4QDzLS6ee0zRxnNyU/Z3i/fLIf0HEDlVdimoZfXHlra
 lYxOrlF4xggclCsepWaF1HbzLiV+OmWylvCJhBdWdyONtuP36reYLGalr+hfXCPJGF
 t/SYPTdUWaj71v1OtgqLDlzDR4q7sZI4cARflkz2wO+uMAPMDKzKmSHjiGHfEj9HKQ
 4xk2lRaRH8JG4dInAw54ieE1c4bMUescS2cs+4Vv4I5uicjp1I8EB9WWUJAFfTDEmR
 qeJzeU6Q8+9pg==
Message-ID: <sashiko-outbox-184104@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dt-bindings: display: panel: ilitek,ili7807s: Allow
 backlight property
To: "Vishnu Saini" <vishnu.saini@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261025-dlc_backlight-v1-1-1d1c49c3e101@oss.qualcomm.com>
References: <20261025-dlc_backlight-v1-1-1d1c49c3e101@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 06:56:30 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] dt-bindings: display: panel: ilitek,ili7807s: redundant backlight p=
roperty
--

commit dfbb23459fc3c8847cb20a8c363e813da0ef5bc0
Author: Vishnu Saini <vishnu.saini@oss.qualcomm.com>

dt-bindings: display: panel: ilitek,ili7807s: Allow backlight property

This commit adds the backlight property to the Ilitek ILI7807S DSI panel
devicetree binding schema.

> diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili78=
07s.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili7807s.=
yaml
> index ba8c5bbf8ffc4..46b941c18565d 100644
> --- a/Documentation/devicetree/bindings/display/panel/ilitek,ili7807s.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili7807s.yaml
> @@ -23,6 +23,8 @@ properties:
>      maxItems: 1
>      description: DSI virtual channel
> =20
> +  backlight: true

[Severity: Low]
Is this declaration needed in
Documentation/devicetree/bindings/display/panel/ilitek,ili7807s.yaml?

This binding schema already references panel-common.yaml and uses
unevaluatedProperties: false:

allOf:
  - $ref: panel-common.yaml#
...
unevaluatedProperties: false

Because Documentation/devicetree/bindings/display/panel/panel-common.yaml
already defines the backlight property:

  backlight:
    $ref: /schemas/types.yaml#/definitions/phandle
    description:
      For panels whose backlight is controlled by an external backlight
      controller, this property contains a phandle that references the
      controller.

unevaluatedProperties: false automatically permits all properties defined in
panel-common.yaml without re-listing them under properties (just as
reset-gpios and port are used in this schema without being listed under
properties).

Commit 72cfe73347fac6 ("dt-bindings: display: panel: Drop redundant
properties") previously removed redundant backlight: true entries from panel
bindings that reference panel-common.yaml and use unevaluatedProperties:
false. Unless the intent was to add backlight to the required list, could
this change be dropped?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025-dlc_backli=
ght-v1-1-1d1c49c3e101@oss.qualcomm.com?part=3D1
