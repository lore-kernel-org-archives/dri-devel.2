Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93817606A321
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 02:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=flaCjsmb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F40CC10F990;
	Wed, 25 Nov 2026 02:18:08 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF77A10F990
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 02:18:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A73B2455EF;
 Wed, 25 Nov 2026 02:18:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFEA31F000D1;
 Wed, 25 Nov 2026 02:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795573082;
 bh=krOqh55AbJ8Xq9vKnQT57fVEqt0Zmhd76IvPCZtU+ZI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=flaCjsmbEfawxVY/gZkpS6d4V+CdMXHCQzw5fHWpNSQ/LNnFCvzA0Ci4g10ZYifn7
 MNHDIUixS6iFVe2RTvFcHlbLGqX9IDuZDb8yIQzhVsgGth6kwyNtZkEeqCR26/kH3O
 98De1owhqI3sppaaP+6JMxDG2QkFAmQ8rSCEBFf8pPgFDkvOLrAz5073ShserQfeZr
 9DFYiiVugxj1bAbUC6KmczsmOHud8CLDiCavkvCY5oZhbMiIpiTKvRXPzaY3UOcM1k
 vTbOAWpJiIfkmim9tMHJaSM0BEEbD+3H7bpQGYEx8h/6//F2XrYSi0aD5hXt/AWdNn
 3mtfWHBi9ToPw==
Message-ID: <sashiko-outbox-232399@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/6] dt-bindings: input: add Jadard JD9365TX
 touchscreen binding
To: Hefei <3066883572@qq.com>, dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <tencent_4AB695D7B71661EC93DAAF0E2AEDF8EEC706@qq.com>
References: <20261125020944.137-1-3066883572@qq.com>
 <tencent_4AB695D7B71661EC93DAAF0E2AEDF8EEC706@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 02:18:01 +0000
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
- [Low] dt-bindings: input: redundant binding in subject and invalid
  commit message
- [Low] dt-bindings: input: jadard,jd9365tx missing interrupts and
  supply mismatch
--

commit 5025f445b383095ff3ce67c95d18c172670d9482
Author: Hefei <3066883572@qq.com>

> dt-bindings: input: add Jadard JD9365TX touchscreen binding
>
> Signed-off-by: Hefei <3066883572@qq.com>
> Co-authored-by: Cursor <cursoragent@cursor.com>

[Severity: Low]
Under DT binding conventions, the "dt-bindings:" prefix already indicates
that the patch adds a binding, so the trailing word "binding" in the
subject is redundant (for example, "dt-bindings: input: touchscreen: add
Jadard JD9365TX").

The commit also lacks a changelog body describing the hardware and why the
binding is being added, and uses a non-standard Co-authored-by: trailer for
an AI tool, both of which trigger checkpatch.pl warnings.  Per
Documentation/process/coding-assistants.rst, AI coding assistants cannot
certify the Developer Certificate of Origin as co-authors and should be
disclosed in the changelog or with an Assisted-by: trailer instead.

> diff --git a/Documentation/devicetree/bindings/input/touchscreen/jadard,j=
d9365tx.yaml b/Documentation/devicetree/bindings/input/touchscreen/jadard,j=
d9365tx.yaml
> new file mode 100644
> index 0000000000000..aaf2a7e00ff04
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/jadard,jd9365tx=
.yaml
> @@ -0,0 +1,64 @@

[ ... ]

> +description: |
> +  In-cell touch integrated with Jadard JD9365TX DSI panels. The module F=
PC
> +  often exposes only I2C (no interrupt GPIO); the driver polls coordinate
> +  reports. The touch controller is commonly powered from the same rails =
as
> +  the panel; those supplies should still be described here when dedicated
> +  regulators exist.
> +
> +allOf:
> +  - $ref: touchscreen.yaml#
> +
> +properties:
> +  compatible:
> +    const: jadard,jd9365tx
> +
> +  reg:
> +    maxItems: 1
> +
> +  poll-interval: true
> +
> +  vdd-supply:
> +    description: Analog / touch power supply
> +
> +  iovcc-supply:
> +    description: Digital I/O power supply
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +  - iovcc-supply
> +
> +unevaluatedProperties: false

[Severity: Low]
Should this schema allow an optional interrupts property and reconcile the
power supply requirements with the description?

The description notes that module FPCs "often" omit the interrupt GPIO and
that the driver polls, but DT bindings describe hardware capabilities
rather than a specific Linux driver implementation or single module FPC.
With unevaluatedProperties: false and no interrupts property, any board
that wires the JD9365TX interrupt line will fail dt_binding_check.

In addition, the description states that the supplies should be described
"when dedicated regulators exist", whereas the required list demands
vdd-supply and iovcc-supply unconditionally.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_EE81D0ED29E=
97716D56BDCF1A3C5AAE35B05@qq.com?part=3D2
