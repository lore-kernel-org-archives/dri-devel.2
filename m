Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90F1606A31C
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 12:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CYU6njK7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C28610E7E2;
	Sun,  8 Nov 2026 12:44:40 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96FE810E7E2
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 12:44:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6857A40458;
 Sun,  8 Nov 2026 12:44:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084381F0089F;
 Sun,  8 Nov 2026 12:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794141874;
 bh=pCnS0pfhzpgsF5uPdMrWrRI7DodG5MhUD1yKl2G3kUg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CYU6njK7qIrCP39fs2TO3W8Rzvpq0vwO/O6NkRs9jYmWHEpG/sBA2dKcvT0jZ3cur
 +ZRB/YQVPGHqtVOrQaO6cQy6czlwWMHnfYJImxiC1hHFO2k4GkPWcJbEKY3ugVWttm
 86joXPqyovoWoVymkE2kXKsO2E0Qrd63uBQvtJjojdqldfjvLXRgInLnUpvAD8UA4Y
 9DJ7akjQpQAoOYV1hEYcQfYi+O966SBs2inUYW2MM7n8tpyIWyYPn9V3KwQwu8YQI+
 4aBcOMj66LoeW3nHbnwdznvVLpwC0oyTpvZKxGQH1JSxbBNKypwmyuu+zT2gaRBq3k
 xztZk2McslHbQ==
Message-ID: <sashiko-outbox-203744@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/10] dt-bindings: display: panel: samsung,s6e3ha8:
 Add AMB630QY01 panel
To: "David Heidelberg" <david@ixit.cz>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261108-crosshatch-panel-v3-2-87dd4ec4f7cc@ixit.cz>
References: <20261108-crosshatch-panel-v3-0-87dd4ec4f7cc@ixit.cz>
 <20261108-crosshatch-panel-v3-2-87dd4ec4f7cc@ixit.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 12:44:33 +0000
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
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Low] dt-bindings: display: panel: samsung,s6e3ha8: unwieldy
  per-compatible conditionals
- [Low] dt-bindings: display: panel: samsung,s6e3ha8: required and allOf
  before properties
- [Low] dt-bindings: display: panel: samsung,s6e3ha8: changelog omits
  supply changes
--

commit 2e2113bfd1b86858603c7b29b0786ff6036afe10
Author: David Heidelberg <david@ixit.cz>

> dt-bindings: display: panel: samsung,s6e3ha8: Add AMB630QY01 panel
>
> The Google Pixel 3 XL (crosshatch) uses a Samsung AMB630QY01 6.3"
> 1440x2960 flexible AMOLED panel.
>
> Signed-off-by: David Heidelberg <david@ixit.cz>

[Severity: Low]
Could the commit message also describe the regulator supply changes?  Beyond
adding the samsung,s6e3ha8-amb630qy01 compatible string, the patch adds
vddpos-supply and vddneg-supply for the ELVDD and ELVSS boost regulators and
makes vddr-supply vs vddpos-supply/vddneg-supply conditionally required per
panel variant.

> diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6e3=
ha8.yaml b/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha8.=
yaml
> index ca250b1b91712..dcf347fe5ca83 100644
> --- a/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha8.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha8.yaml
> @@ -12,17 +12,45 @@ description: |
> =20
>    Known panels:
>      - AMB577PX01, 5.77", Samsung Galaxy S9 (samsung,s6e3ha8-amb577px01)
> +    - AMB630QY01, 6.3", Google Pixel 3 XL (samsung,s6e3ha8-amb630qy01)
> =20
>  maintainers:
>    - Dzmitry Sankouski <dsankouski@gmail.com>
> =20
> +required:
> +  - compatible
> +  - reset-gpios
> +  - vdd3-supply
> +  - vci-supply
> +
>  allOf:

[Severity: Low]
As reported by Krzysztof Kozlowski on v2 [1], should the properties block
come before required and allOf?  Standard DT schema ordering places
properties first, followed by required, allOf, and unevaluatedProperties:
false, rather than listing required properties and allOf before properties
are defined.

>    - $ref: panel-common.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - samsung,s6e3ha8
> +              - samsung,s6e3ha8-amb577px01
> +    then:
> +      required:
> +        - vddr-supply
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: samsung,s6e3ha8-amb630qy01
> +    then:
> +      required:
> +        - vddpos-supply
> +        - vddneg-supply

[Severity: Low]
Would it be cleaner to split samsung,s6e3ha8-amb630qy01 into a separate
binding schema document instead of adding per-compatible supply conditionals
here?

samsung,s6e3ha8-amb630qy01 and samsung,s6e3ha8-amb577px01 are standalone
compatibles with no shared fallback compatible and different power supply
topologies (vddpos-supply and vddneg-supply vs vddr-supply).  Keeping both =
in
one schema requires per-compatible if-then blocks, and still leaves
vddr-supply allowed on samsung,s6e3ha8-amb630qy01 and vddpos-supply and
vddneg-supply allowed on samsung,s6e3ha8-amb577px01 unless further
constraints are added.

[1] https://lore.kernel.org/r/20260929-automatic-humorous-muskox-45bdfd@quo=
ll

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-crosshatch=
-panel-v3-0-87dd4ec4f7cc@ixit.cz?part=3D2
