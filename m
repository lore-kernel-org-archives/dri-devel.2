Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62941606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 06:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CXGc4yo4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9500B10F367;
	Tue,  3 Nov 2026 06:36:30 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B04810F367
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 06:36:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A05FA60008;
 Tue,  3 Nov 2026 06:36:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECFA91F000C1;
 Tue,  3 Nov 2026 06:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793687783;
 bh=F+ZRkrgikRW1/CvG+6jZPeYXRBmMOp8E5R+kuubVWS8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CXGc4yo4BS99J9WnKqTDnw+GC2L3D4WzXOWnGMUFW+8YMNk28Azzic24HOl9UlThA
 6xBZDgkw918ofguX6/w+fY0bH7cwj8DTOVFGVFbsk7DTnxQs2rLVz8Vo/8lna/euNA
 CmhGXbydRF+chkTSMFSpyecrh9clBxPrg80e7wNm3N8ErH5CMq5yCpU0e6l9PI9X3u
 oGfPcgHphz3+0lFtOFvWXGS2bvxyLnjrzWxitT+aMzN1ctatESdxL/98ow23wqHjIi
 N6RLrk0f1t7fbpfj11EXppFrMBSNGJfbyESc6pzFoum+QV32XrluF9ZVtmuAEO0qLF
 8vzVmN+5PDcpA==
Message-ID: <sashiko-outbox-194645@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 08/16] drm/imx: dc: Add PRG support
To: "Liu Ying" <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20261103-imx8-dc-prefetch-v9-8-3b985e7636e2@nxp.com>
References: <20261103-imx8-dc-prefetch-v9-0-3b985e7636e2@nxp.com>
 <20261103-imx8-dc-prefetch-v9-8-3b985e7636e2@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 06:36:22 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/imx: dc-prg: unclocked MMIO and RPM underflow in dc_prg_config=
ure()
--

commit d1c395ad8b2bd23da43b9ddd3c832ab32084d33e
Author: Liu Ying <victor.liu@nxp.com>

drm/imx: dc: Add PRG support

This commit adds a platform driver for the Display Prefetch Resolve Gasket
(PRG), which sits between a Display Prefetch Resolve Channel (DPRC) and a
FetchUnit as part of the prefetch engine.

> diff --git a/drivers/gpu/drm/imx/dc/dc-prg.c b/drivers/gpu/drm/imx/dc/dc-=
prg.c
> new file mode 100644
> index 0000000000000..b80ce5e641173
> --- /dev/null
> +++ b/drivers/gpu/drm/imx/dc/dc-prg.c
> @@ -0,0 +1,317 @@

[ ... ]

> +void dc_prg_enable(struct dc_prg *prg)
> +{
> +	regmap_write(prg->reg, PRG_CTRL + CLR, BYPASS);
> +}
> +
> +void dc_prg_disable(struct dc_prg *prg)
> +{
> +	regmap_write(prg->reg, PRG_CTRL, BYPASS);
> +
> +	pm_runtime_put(prg->dev);
> +}

[ ... ]

> +void dc_prg_configure(struct dc_prg *prg,
> +		      unsigned int width, unsigned int height,
> +		      unsigned int stride, unsigned int bits_per_pixel,
> +		      dma_addr_t baddr, bool start)
> +{
> +	struct device *dev =3D prg->dev;
> +	unsigned int burst_size;
> +	u32 val;
> +	int ret;
> +
> +	if (start) {
> +		ret =3D pm_runtime_resume_and_get(dev);
> +		if (ret < 0) {
> +			dev_err(dev, "failed to get RPM: %d\n", ret);
> +			return;
> +		}
> +	}

[Severity: High]
As reported by Sashiko on v8 [1], in drivers/gpu/drm/imx/dc/dc-prg.c, what
happens if pm_runtime_resume_and_get() fails in dc_prg_configure() when sta=
rt
is true?

Because dc_prg_configure() returns void, the error is not propagated to the
caller and the PRG device remains runtime-suspended with its clocks disabled
in dc_prg_runtime_resume().

Callers that proceed after dc_prg_configure() will then call dc_prg_enable(=
),
dc_prg_reg_update(), or dc_prg_shadow_enable(), performing MMIO writes to
PRG_CTRL and PRG_REG_UPDATE while the PRG clocks are off. Subsequent updates
with start set to false will also write to the PRG registers without clocks
enabled.

Furthermore, when the plane or CRTC is later disabled, dc_prg_disable() will
write to PRG_CTRL while unclocked and call pm_runtime_put(prg->dev),
underflowing the runtime PM usage counter on prg->dev.

Should dc_prg_configure() return an error code, or track the runtime PM act=
ive
state so subsequent register accesses and pm_runtime_put() are skipped when
resume fails?

[1] https://lore.kernel.org/r/20261030-imx8-dc-prefetch-v8-7-c4f81afd4533@n=
xp.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-imx8-dc-pr=
efetch-v9-0-3b985e7636e2@nxp.com?part=3D8
