Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD17DCD6E4A
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 09:06:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6F31113E08;
	Thu,  4 Jun 2026 09:06:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mstnDBFR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31A7D113E08
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 09:06:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8FF3E601F5;
 Thu,  4 Jun 2026 09:06:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40751F00893;
 Thu,  4 Jun 2026 09:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780564000;
 bh=tkeYPWXEAPxj0AWpRR3es7QnxH79QnuybIneW2XNCYM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mstnDBFRhw4SE48d+GkRFFF76mo6KQndIOKytH1EwZCXkPL5KE3CJgCUEqAYnUxZ+
 ST/m6Ev2BYI1vLPoViEH138PCkNQzmhXnh5dIW2azHjchzQ5ANL1svWvYwQHWKPedE
 6MtNc/Qy51QY74EmlfxzHvohBK/Hm2z4AI+zS6cRAIGn689IO8tfGaDm/teANzjDOZ
 IzT04HFnk9+cdRyf9HM2sJ3xJIiPvZxoK3vHzP//UAX5Rx2oFFNMXxQhEQ6m19PwLN
 RkFCQEmemKYNI9YwIOsFXICltC5Tvj1FiQnPBFl115cGCefmquCWPrelBjVOKA+sOp
 XNRSv+DNr7ZAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/4] dt-bindings: display: bridge: analogix-dp: Add
 data-lanes support for endpoint
To: "Damon Ding" <damon.ding@rock-chips.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260604085220.2862986-2-damon.ding@rock-chips.com>
References: <20260604085220.2862986-2-damon.ding@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 09:06:37 +0000
Message-Id: <20260604090639.D40751F00893@smtp.kernel.org>
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
- [Medium] The `data-lanes` property is defined strictly for the `endpoint`=
 node name, causing schema validation to fail or miss constraints if applie=
d to valid unit-addressed nodes like `endpoint@0`.
--

commit c6792a12ea4c785878c85982c6a4537b6a1901d6
Author: Damon Ding <damon.ding@rock-chips.com>

dt-bindings: display: bridge: analogix-dp: Add data-lanes support for endpo=
int
   =20
This commit adds data-lanes property support to the port@1 endpoint in
the analogix-dp bridge binding to allow physical lane mapping configuration.
It also updates the Rockchip eDP DT node example to demonstrate its usage.

> diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,dp=
.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,dp.yaml
> index 62f0521b09245..ecf206871cdde 100644
> --- a/Documentation/devicetree/bindings/display/bridge/analogix,dp.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/analogix,dp.yaml
> @@ -42,13 +42,22 @@ properties:
>      properties:
>        port@0:

[ ... ]

>        port@1:
> -        $ref: /schemas/graph.yaml#/properties/port
> -        description:
> -          Port node with one endpoint connected to a dp-connector node.
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description: Port node with one endpoint connected to sink devic=
e node.
> +        properties:
> +          endpoint:
             ^^^^^^^^
[Severity: Medium]
Does restricting this to the exact node name 'endpoint' cause validation
issues for unit-addressed nodes?

Because JSON Schema strictly matches object keys, a node named endpoint@0
under port@1 will bypass this block, meaning the video-interfaces $ref
and data-lanes validation constraints are never applied.

Should this use patternProperties: "^endpoint(@[0-9a-f]+)?$": instead
of properties: endpoint: to ensure unit-addressed endpoint nodes don't
bypass these constraints?

> +            $ref: /schemas/media/video-interfaces.yaml#
> +            unevaluatedProperties: false
> +            properties:
> +              data-lanes:
> +                minItems: 1
> +                maxItems: 4
> +                items:
> +                  enum: [ 0, 1, 2, 3 ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604085220.2862=
986-1-damon.ding@rock-chips.com?part=3D1
