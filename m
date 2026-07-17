Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35DB4C44520
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 12:00:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8963710E439;
	Fri, 17 Jul 2026 12:00:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dA+muxMG";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF50210E43D
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 12:00:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2655460204;
 Fri, 17 Jul 2026 12:00:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823961F000E9;
 Fri, 17 Jul 2026 12:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784289647;
 bh=6OjQfTP33hkSylU6VMkvni+3HFCnjPx+AlTJM2kSMOI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dA+muxMGtODJNMR7FnKgzkgYkxrbTL0uPbVaJ70PYtRjSsH8vltU6v0PLRz2oZ4uv
 FglsNXti5FotO0mLH/g7kt79PbuhCmV8wlN8/TYSbxhudROasnGTb5b7HI3YjC0Otq
 IPIpqSr6bu8UVmTq/aQv25re7BlgSZzGik5eAxDkr6229qwHGtbVt9ZNk6sCBUPOxb
 BHXReC2dmv77L+rxlV19MRipPXjpLwJ44gEwL9o/JOBQ9omZq3exctgUYu6ZR22Nom
 KSMNEwTTQRtBiOy1mThxQPgjU292xJa5k1LAkFbo3gQOv9Uo8vdbAOa41BWtUeFOQQ
 RsAo4270gBh5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/3] dt-bindings: display: sn65dsi83: Add output
 data-lanes property
To: "Wojciech Dubowik" <wojciech.dubowik@mt.com>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260717115002.308035-3-wojciech.dubowik@mt.com>
References: <20260717115002.308035-1-wojciech.dubowik@mt.com>
 <20260717115002.308035-3-wojciech.dubowik@mt.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 12:00:46 +0000
Message-Id: <20260717120047.823961F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Redefining `endpoint` with `unevaluatedProperties: false` locall=
y masks properties evaluated by the sibling `$ref: '#/$defs/lvds-port'`, ca=
using valid TI-specific LVDS properties to be improperly rejected.
--

--- Patch [2]: [PATCH v5 2/3] dt-bindings: display: sn65dsi83: Add output d=
ata-lanes property ---
commit c64bd236e14a70bf7062c9fee49e33ef3475908b
Author: Wojciech Dubowik <Wojciech.Dubowik@mt.com>

dt-bindings: display: sn65dsi83: Add output data-lanes property

Add an optional output LVDS data lanes property with two allowed values
for standard and reversed layouts. The reversed layout informs the driver
that the reverse LVDS config option must be set for the respective output
channel.

> diff --git a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi8=
3.yaml b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
> index e69b6343a8ebb..4000bf0b13709 100644
> --- a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
> @@ -86,10 +86,54 @@ properties:
>          description: Video port for LVDS Channel-A output (panel or brid=
ge).
>          $ref: '#/$defs/lvds-port'
> =20
> +        properties:
> +          endpoint:
> +            $ref: /schemas/media/video-interfaces.yaml#
> +            unevaluatedProperties: false

[Severity: Medium]
Will this unevaluatedProperties constraint cause valid properties inherited
from the sibling '$ref: '#/$defs/lvds-port'' reference to be improperly
rejected?

Since unevaluatedProperties is scoped only to this inline schema, it cannot
see annotations from the lvds-port definition. If a device tree file defines
port@2 with both data-lanes and properties like ti,lvds-termination-ohms,
could this result in a validation failure when running make dtbs_check?

[ ... ]

>        port@3:
>          description: Video port for LVDS Channel-B output (panel or brid=
ge).
>          $ref: '#/$defs/lvds-port'
> =20
> +        properties:
> +          endpoint:
> +            $ref: /schemas/media/video-interfaces.yaml#
> +            unevaluatedProperties: false

[Severity: Medium]
Similar to port@2 above, could this locally scoped unevaluatedProperties: f=
alse
block reject valid properties inherited from the lvds-port definition on
port@3?

> +
> +            properties:
> +              data-lanes:
> +                $ref: /schemas/types.yaml#/definitions/uint32-array

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717115002.3080=
35-1-wojciech.dubowik@mt.com?part=3D2
