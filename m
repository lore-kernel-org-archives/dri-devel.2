Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9071606A31D
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 06:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BhhcVGK6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D9001129A1;
	Fri, 23 Oct 2026 06:48:45 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76B0910E555
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 06:48:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2BFF640495;
 Fri, 23 Oct 2026 06:48:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE771F01825;
 Fri, 23 Oct 2026 06:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792738119;
 bh=GpLptWW92IMOqnJfqsUQVTAGi7mCp/+VkMLIYZrEKkw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BhhcVGK62HR6OrFrm16NlRTWKLsRftudx9e3iW/afbX2RqEkyLbCQZoT9e+OvRIht
 tRpNyk/80RmJJ3T7jdqA5m7snYSq1txxQOTgEuPh0NRZTuS4Z4pqf+mJwq9sg+Pow7
 2vUhnSP72NZICBC/FCsZuhD87ephtEB5kYRoqOOICg5Z24eTWJgOynDD9G/hqL3dxL
 /q+XYAYv/+9P4kklYfALh+sLCS2D0ISe31ouw/yyVfVqV34UmZ0zpcx4r+un5NdcvA
 Fss40uX9nPfxd2OPzRN2G6qucWcOJYhQ4OEmi/LCdIEwLtj6RcGoHprwxSa3FKtP4q
 5PA3MOyLjABGw==
Message-ID: <sashiko-outbox-182363@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/16] dt-bindings: remoteproc: k3-dsp: Allow
 referencing the timers' power domains
To: "Tomeu Vizoso" <tomeu.vizoso@gmail.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, conor+dt@kernel.org, media-ci@linuxtv.org
In-Reply-To: <20261023-thames-v3-3-3ab40aa17157@tomeuvizoso.net>
References: <20261023-thames-v3-0-3ab40aa17157@tomeuvizoso.net>
 <20261023-thames-v3-3-3ab40aa17157@tomeuvizoso.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 06:48:38 +0000
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
- [Medium] dt-bindings: remoteproc: k3-dsp: misuse of power-domains for ext=
ernal timers
--

commit aa9adcac4a1bc9840a117c81a03e4ac0dade71bd
Author: Tomeu Vizoso <tomeu.vizoso@gmail.com>

dt-bindings: remoteproc: k3-dsp: Allow referencing the timers' power domains

This commit adds optional power-domains and power-domain-names properties
to the TI K3 DSP remoteproc binding so a client driver can hold the power
domains of two SoC timers used by the running firmware.

> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc=
.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
> index d6319c8e96f8c..80eaef0a19b8d 100644
> --- a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
> @@ -76,6 +76,23 @@ properties:
>  # Optional properties:
>  # --------------------
> =20
> +  power-domains:
> +    description: |
> +      Power domains of the SoC timers the running firmware ticks on and
> +      times its work out with. The firmware programs these timers itself
> +      and makes no power request for them, and the timers' own nodes are
> +      reserved for it, so nothing else requests their power; a client
> +      driver of the firmware holds them on while it drives the processor.
> +      The processor's own power is managed through ti,sci-dev-id, not he=
re.
> +    items:
> +      - description: power domain of the first timer
> +      - description: power domain of the second timer
> +
> +  power-domain-names:
> +    items:
> +      - const: timer1
> +      - const: timer2

[Severity: Medium]
Should the standard power-domains property on the DSP node be used to
describe the power domains of external SoC timer peripherals rather than
the DSP device's own power domain?

In device tree bindings, power-domains on a device node specifies the power
domain(s) to which that device itself belongs. On TI K3 SoCs, the timer
peripherals already have their own device tree nodes (such as main_timer1
and main_timer2 in arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi)
which declare their own power-domains, clocks, and assigned-clocks.
Duplicating the timers' power-domains phandles onto the DSP node prevents
the binding from using power-domains for the processor's own power domain
(as done in ti,k3-r5f-rproc.yaml) and encodes a firmware-specific
workaround instead of referencing the timer nodes via phandles (similar to
ti,timers in ti,omap-remoteproc.yaml).

Additionally, requiring two fixed entries (timer1 and timer2) per DSP node
even when a single core only drives one timer appears to be shaped around
Linux's genpd_dev_pm_attach() behavior: as noted in the device tree patch
(arch/arm64/boot/dts/ti/k3-j722s-ti-ipc-firmware.dtsi), specifying two
entries keeps the platform bus from automatically attaching a single domain
to the K3 remoteproc device during platform_probe(), which would otherwise
set core->dev->pm_domain and cause dev_pm_domain_attach_list() in
thames_core_get_timers() (drivers/accel/thames/thames_core.c) to fail with
-EEXIST.

Could the binding reference the timer nodes via a phandle property instead
of repurposing power-domains on the DSP node around Linux genpd attachment
semantics?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023-thames-v3-=
0-3ab40aa17157@tomeuvizoso.net?part=3D3
