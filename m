Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A88606A31F
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 10:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eXval44d
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D72210E870;
	Fri, 30 Oct 2026 10:07:01 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE2C910E870
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 10:06:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C308B60092;
 Fri, 30 Oct 2026 10:06:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F2BE1F000C1;
 Fri, 30 Oct 2026 10:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793354814;
 bh=/izgrK6v27WkW3THcSs7ChQLAe5vIDUskUWOQj+Numg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eXval44dP5XsXrc2cM3mZeVMEmZqjiiPmkq7bouFGbkdT+WNPKISCjaHiEUDx8E5J
 7mDlbh8N9jySURg6W67jqI58A233NupfRIPKGFqjnPb7eEUrQgY/i2MaKCyevuxVqg
 KP/KrA+LE9SFbYrIbV0uwKP6aVV7109EuuI83WLHRfSp/lNNklpsqJ6ADyAImnDhh9
 +PbiJceryXtQEnq3K8KhkChUIzTLiayqZim+MMgdD1hsxF+n3o63WYGyN+CXhy5iZJ
 USUKmP1pHZQEsxHCqTAxyG9lAQa8J9K0m+aIlgy92vyPSQ6I79+IULR+p0AXchzQeo
 gaiioEn4sMnHg==
Message-ID: <sashiko-outbox-190806@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 07/15] drm/imx: dc: Add PRG support
To: "Liu Ying" <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20261030-imx8-dc-prefetch-v8-7-c4f81afd4533@nxp.com>
References: <20261030-imx8-dc-prefetch-v8-0-c4f81afd4533@nxp.com>
 <20261030-imx8-dc-prefetch-v8-7-c4f81afd4533@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 10:06:53 +0000
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
- [High] drm/imx: dc-prg: unclocked MMIO and RPM underflow on dc_prg_config=
ure() error
--

commit dc9803b183fdde7606d3c14739f864581b99c2a3
Author: Liu Ying <victor.liu@nxp.com>

drm/imx: dc: Add PRG support

This commit adds a platform driver to support the Display Prefetch Resolve
Gasket (PRG), which sits between a Display Prefetch Resolve Channel (DPRC)
and a FetchUnit.

> diff --git a/drivers/gpu/drm/imx/dc/dc-prg.c b/drivers/gpu/drm/imx/dc/dc-=
prg.c
> new file mode 100644
> index 0000000000000..46108f7e09af3
> --- /dev/null
> +++ b/drivers/gpu/drm/imx/dc/dc-prg.c
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
As reported by Sashiko on v7 [1], what happens if pm_runtime_resume_and_get=
()
fails in dc_prg_configure() in drivers/gpu/drm/imx/dc/dc-prg.c when start is
true?

Because dc_prg_configure() returns void, the caller is not notified that the
PRG device remains runtime-suspended with its clocks disabled. Subsequent
calls to dc_prg_enable(), dc_prg_reg_update(), dc_prg_shadow_enable(), or
later dc_prg_configure() updates with start set to false will perform MMIO
writes to PRG registers while the hardware is unclocked and unpowered, which
can trigger a bus abort on i.MX8 SoCs.

Additionally, when the plane or CRTC is later disabled, dc_prg_disable()
writes to PRG_CTRL while unclocked and unconditionally calls
pm_runtime_put(prg->dev), underflowing the runtime PM usage counter on
prg->dev.

Should dc_prg_configure() return an error code or track the active state so
callers do not access unclocked registers or drop an unacquired runtime PM
reference?

[1] https://lore.kernel.org/r/20261026-imx8-dc-prefetch-v7-7-a0b50cc4fc65@n=
xp.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-imx8-dc-pr=
efetch-v8-0-c4f81afd4533@nxp.com?part=3D7
