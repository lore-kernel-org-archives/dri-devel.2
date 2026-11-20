Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A66960A3804
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 18:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=klE1KVR4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF87F10E021;
	Fri, 20 Nov 2026 18:58:11 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2131810E021
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 18:58:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EFCC761483;
 Fri, 20 Nov 2026 18:58:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0917A1F000E1;
 Fri, 20 Nov 2026 18:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795201084;
 bh=kLa/ktQb6nF/IzsmolVfdoxy/DHth7joboUFEBOLt+4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=klE1KVR4l6PX7i/nb1eBMolzEKmELQURpJbBaGFF9PAuYBxi8go1DjZScUUv4BK6N
 mRFQDA+3C8POPEt10LPqIP1pdiTSVF2cHJ/PDrPR9JD8sOoXL6Oq9qUTd00j4cDfpm
 T7x/R3J3N1EoZR1W7KgrDrJgbVEFPrS4Uapm41fEZUFentV7SU6P3mlOtCGNrsq22z
 J5JXr+7BpUSzuqH3oO0Qi90PNttMhpKaU0XpVMCETlFzGvEdyYx2yKJDGSdxR3wSdb
 zGVY4xGp8IyB5dL38AqBOHEc33Qo0sgvMPDBUlOTGVXJbCgsIxPUrheP5Yfw9Q8QiI
 VYgQE9JQbAQ9A==
Message-ID: <sashiko-outbox-225878@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/11] pmdomain: amlogic: meson-ee-pwrc: power up
 memories for boot-enabled domains
To: "Ronald Claveau" <linux-kernel-dev@aliel.fr>
Cc: devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, conor+dt@kernel.org, neil.armstrong@linaro.org,
 vkoul@kernel.org, olteanv@gmail.com
In-Reply-To: <20261120-meson-drm-create-hdmitx-phy-v2-6-93d622d9bb07@aliel.fr>
References: <20261120-meson-drm-create-hdmitx-phy-v2-0-93d622d9bb07@aliel.fr>
 <20261120-meson-drm-create-hdmitx-phy-v2-6-93d622d9bb07@aliel.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:58:03 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] pmdomain: amlogic: duplicated memory power-up loop in
  meson_ee_pwrc_on()
--

commit a69a64ee3e13ba7f9072dbadb0f25ec3e146c336
Author: Ronald Claveau <linux-kernel-dev@aliel.fr>

pmdomain: amlogic: meson-ee-pwrc: power up memories for boot-enabled domains

This commit introduces a helper to clear the HHI memory power-down bits
for power domains that are found already enabled at probe time.

> diff --git a/drivers/pmdomain/amlogic/meson-ee-pwrc.c b/drivers/pmdomain/=
amlogic/meson-ee-pwrc.c
> index 338f70d77bf03..404af46192562 100644
> --- a/drivers/pmdomain/amlogic/meson-ee-pwrc.c
> +++ b/drivers/pmdomain/amlogic/meson-ee-pwrc.c
> @@ -428,6 +428,16 @@ static int meson_ee_pwrc_on(struct generic_pm_domain=
 *domain)
>  				       pwrc_domain->clks);
>  }
> =20
> +static void meson_ee_pwrc_mem_power_up(struct meson_ee_pwrc_domain *dom)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < dom->desc.mem_pd_count; i++)
> +		regmap_update_bits(dom->pwrc->regmap_hhi,
> +				   dom->desc.mem_pd[i].reg,
> +				   dom->desc.mem_pd[i].mask, 0);
> +}

[Severity: Low]
This isn't a bug, but meson_ee_pwrc_on() right above has the same loop:

drivers/pmdomain/amlogic/meson-ee-pwrc.c:meson_ee_pwrc_on() {
    ...
	for (i =3D 0 ; i < pwrc_domain->desc.mem_pd_count ; ++i)
		regmap_update_bits(pwrc_domain->pwrc->regmap_hhi,
				   pwrc_domain->desc.mem_pd[i].reg,
				   pwrc_domain->desc.mem_pd[i].mask, 0);
    ...
}

Could meson_ee_pwrc_mem_power_up() be defined above meson_ee_pwrc_on()
and reused there as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-meson-drm-=
create-hdmitx-phy-v2-0-93d622d9bb07@aliel.fr?part=3D6
