Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDB8C54F4C
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 08:07:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D0B510E807;
	Tue, 28 Jul 2026 08:07:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ibKaJtCs";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1525910E807
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 08:07:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B1FF4411AB;
 Tue, 28 Jul 2026 08:07:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D17D1F00A3A;
 Tue, 28 Jul 2026 08:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785226069;
 bh=5tUbDStS0GQHCB8UWlXzniMXPIvID1g2YNoMDc83vHg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ibKaJtCs/Qd5j69W9sTrfRdHt2aqYwhpM13lzbZurR679wG5biaM6HF6vj8PpT4Bl
 7cRJEMKJG77s1/T/242kV67r1MeEfhLBT/UDmNakaOid+m123sxDa+wElTdxQ/oX/j
 Nts9AUb2hhxPGuW7ei+eXtgeDYNf/2S2pIwL3ynlLyJN0leG4nJUzAZlZFKauXRwOJ
 PgABLe65zTF3lDWd3YkPxz51vZistWQxkiGExxRc9fQUOHeVQxgHhWeVSIibIhyttu
 fL+UZbnz9xk12CzKrPPTvQQfR/FcWAtuhcNf8nb1AHTatH2WN9pSHk6Z3jrlTi8Als
 z+8EsaSs6cpHA==
Date: Tue, 28 Jul 2026 10:07:45 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sterling-Ash <liangbaihui@linux.spacemit.com>
Cc: Frank Binns <frank.binns@imgtec.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Yixun Lan <dlan@kernel.org>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Subject: Re: [PATCH v3 1/2] dt-bindings: gpu: img,powervr-rogue: add
 spacemit,k3-gpu
Message-ID: <20260728-proud-coyote-of-happiness-e99c24@quoll>
References: <75c9382d2bda766aa459b00321153d715254d1a4.camel@imgtec.com>
 <20260728010513.1627950-1-liangbaihui@linux.spacemit.com>
 <20260728010513.1627950-2-liangbaihui@linux.spacemit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260728010513.1627950-2-liangbaihui@linux.spacemit.com>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Tue, Jul 28, 2026 at 09:05:12AM +0800, Sterling-Ash wrote:
> Add a compatible string for the IMG BXM-4-64 GPU integrated into the
> SpacemiT K3 SoC. It shares the same core as thead,th1520-gpu but is
> kept as a separate compatible entry, since the K3 integration differs
> from TH1520 in its clock and power-domain requirements: K3 has a
> single "core" clock rather than three, and its GPU power domain is
> enabled by the bootloader before Linux boots rather than being
> modelled and switched by Linux, so no power-domains property is
> required for this platform (unlike the other img,img-bxm-4-64 user).
> 
> spacemit,k3-gpu is added to the existing ti,am62-gpu/ti,am62p-gpu/
> ti,j721s2-gpu "if" block that restricts clocks to a single entry,
> since K3 has the same single-clock requirement. It does not match any
> "if" block that constrains power-domains, so that property falls back

I don't get this explanation. Are you explaining what the patch is doing
or explaining WHY you did this that way?

> to this schema's general constraints, where it is optional. This
> leaves room for a power-domains provider to be added later without a
> further binding change, should one ever be modelled in Linux for this
> SoC.

No, you need to provide constraints now. Please read carefully
writing-bindings.

> 
> Signed-off-by: Sterling-Ash <liangbaihui@linux.spacemit.com>
> ---

Do not attach (thread) your patchsets to some other threads (unrelated
or older versions). This buries them deep in the mailbox and might
interfere with applying entire sets. See also:
https://elixir.bootlin.com/linux/v6.16-rc2/source/Documentation/process/submitting-patches.rst#L830

> v3: also add spacemit,k3-gpu to the existing ti,am62-gpu/ti,am62p-gpu/
>     ti,j721s2-gpu "if" block restricting clocks to a single entry --
>     previously it fell back to this schema's general clocks constraint
>     (1-3 items), which would have let an invalid DT with 2 or 3 clocks
>     pass validation (found by automated review on v2).
> 
>  .../devicetree/bindings/gpu/img,powervr-rogue.yaml          | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> index a1f54dbae3f3..d29f0d163b91 100644
> --- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> +++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> @@ -38,6 +38,11 @@ properties:
>                - thead,th1520-gpu
>            - const: img,img-bxm-4-64
>            - const: img,img-rogue
> +      - items:
> +          - enum:
> +              - spacemit,k3-gpu

Why isn't this part of other enum (and remember about the alphabetical
order of entries)?

Best regards,
Krzysztof

