Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E01CCD98DE
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 05:07:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F91710EC01;
	Thu, 18 Jun 2026 05:07:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aLblJfly";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01D7710EC01
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 05:07:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3025060008
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 05:07:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8101C1F000E9;
 Thu, 18 Jun 2026 05:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781759237;
 bh=VtoFkjQ72jcgGKCMeeCMx+/0yn8W4bXsMpFdpVKr/mg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aLblJflyiBqE/VJ8xg6Gidd3rAJ9VwrjfzMMQk4PECzQ5nV3f900N/HnXunvxDQbx
 3PBMIHGl440DuAVItPQMB57sKYZ/X5l7/lS0mFGXyO7A6m5Yb3ROYvvb4+xP2zhcXF
 RK9d8B39E0kC9rk4z/lKn5vnS8dKs0/EjswTZRaGAqDqU+MFsygRG00KeciBSYPZ5x
 RjVqFKNMie4gPef9yULUbgJeCvn0/bUkXelnc2TKVsfgKFUVb2YfqQtpcWpV6icgj7
 OV4FIuoLJ5dPTy8vlfuAfiSPe/PQfpDG6iL6CnlojL76OI2aXcpLfgwVpBGdT1UhAO
 qP9tE0GhVEPog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/11] dt-bindings: power: Convert Ux500 PM domains to
 schema
To: "Linus Walleij" <linusw@kernel.org>
Cc: devicetree@vger.kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org,
 vkoul@kernel.org, dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 robh@kernel.org
In-Reply-To: <20260618-ux500-power-domains-v7-1-v1-1-eb5e50b1a588@kernel.org>
References: <20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org>
 <20260618-ux500-power-domains-v7-1-v1-1-eb5e50b1a588@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 05:07:17 +0000
Message-Id: <20260618050717.8101C1F000E9@smtp.kernel.org>
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
- [Low] The example consumer node `sdi0_per1@80126000` will fail `dt_bindin=
g_check` validation due to missing required properties and will trigger a `=
dtc` warning.
--

commit b98e3bf1a2da87a6966744348740e230bb97bdfd
Author: Linus Walleij <linusw@kernel.org>

dt-bindings: power: Convert Ux500 PM domains to schema

This commit converts the legacy Ux500 power domain text binding to YAML.
It moves the binding under bindings/power and updates the MAINTAINERS file
accordingly.

> diff --git a/Documentation/devicetree/bindings/power/stericsson,ux500-pm-=
domains.yaml b/Documentation/devicetree/bindings/power/stericsson,ux500-pm-=
domains.yaml
> new file mode 100644
> index 0000000000000..72c39c083efbf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/stericsson,ux500-pm-domains=
.yaml

[ ... ]

> +examples:
> +  - |
> +    #include <dt-bindings/arm/ux500_pm_domains.h>
> +
> +    pm_domains: power-controller {
> +        compatible =3D "stericsson,ux500-pm-domains";
> +        #power-domain-cells =3D <1>;
> +    };
> +
> +    sdi0_per1@80126000 {
> +        compatible =3D "arm,pl18x", "arm,primecell";
> +        power-domains =3D <&pm_domains DOMAIN_VAPE>;
> +    };

[Severity: Low]
Will this example consumer node trigger warnings during dt_binding_check?

The node is matched against the arm,pl18x.yaml schema, which requires both
the reg and interrupts properties. Since they are missing here, dt-schema
will likely report validation errors.

Additionally, because the node includes a unit address (@80126000) but lacks
a reg property, does this cause dtc to emit a unit_address_vs_reg warning?
Should dummy reg and interrupts properties be added to the example to
satisfy the schema validation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-ux500-powe=
r-domains-v7-1-v1-0-eb5e50b1a588@kernel.org?part=3D1
