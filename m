Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5761A606A331
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 01:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AovJYfEe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 881BF10ED0E;
	Sat, 14 Nov 2026 01:54:49 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1322710E565;
 Sat, 14 Nov 2026 01:54:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C0BC240B27;
 Sat, 14 Nov 2026 01:54:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72ABD1F000C4;
 Sat, 14 Nov 2026 01:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794621282;
 bh=EpRSuE2RHwTVQrgiV4SOlvaZfk61Ywiv7/i8fUuyxGU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AovJYfEeFUqSOi4aGYiLEq/x7YBRzf+p7VWPDcuOCg3guFDyPBagtT53ESNnaUMQS
 RhMiMVRVUV9GiccVje+SmHiXLXLmrXWD36qoGcMObp5ih0/3d2LA9UuNszG6WzELz/
 3UUSlqICuazPiHo516421ng/WBn2X5UsCIjYLtTpTix48wzWuEGgaNAzrG7B6sFhSG
 v1TKUYzcNwE1/3y6DpMcBnvr0SshW49XSwStQYQsEa4m+469zxr4KnpxdAwChXQSMh
 GSupkMfvQUAlkX4vMTnHOS2cbxtS5JFQH7hY3l14TOS/HG+qiDPZp485ak0NR5FlpB
 yX1JrTg2jtdeA==
Message-ID: <sashiko-outbox-214017@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/7] drm/i915/panel: Fix the pixel clock overflow in the
 VRR vtotal
To: ElXreno <elxreno@gmail.com>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261114014335.2132756-2-elxreno@gmail.com>
References: <20261114014335.2132756-1-elxreno@gmail.com>
 <20261114014335.2132756-2-elxreno@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 01:54:42 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] drm/i915/panel: commit Signed-off-by trailer uses handle
  instead of real name
--

commit a81f42546a1b676a6932361ec102d9c524823aa2
Author: ElXreno <elxreno@gmail.com>

> drm/i915/panel: Fix the pixel clock overflow in the VRR vtotal
>
> intel_panel_compute_config_vrr() multiplies the pixel clock in kHz by
> 1000 in a signed int. A 3840x2400@240 timing has a 2342.4 MHz pixel
> clock, the product overflows, and the vertical total computed for a
> refresh rate other than that of the fixed mode comes out negative.
>
> Do the multiplication in 64 bits.
>
> This needs a fixed mode above 2147 MHz, so one that uses the joiner,
> inside the VRR range of the panel, and a request for another refresh
> rate that ends up on that fixed mode, as the allow_modeset=3Dfalse path
> does for a mode that is VRR compatible with the current one.
>
> Fixes: a2da67028cd0 ("drm/i915: Allow arbitrary refresh rates with VRR eD=
P panels")
> Signed-off-by: ElXreno <elxreno@gmail.com>

[Severity: High]
Both the Author header and the Signed-off-by trailer use the single-word
handle ElXreno rather than a real full name. Documentation/process/submitti=
ng-patches.rst
requires contributors to sign off using a known real identity under the
Developer's Certificate of Origin rather than a pseudonym or handle.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114014335.2132=
756-1-elxreno@gmail.com?part=3D1
