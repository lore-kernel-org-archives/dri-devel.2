Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED55EC55822
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 07:27:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 425B610ED32;
	Wed,  5 Aug 2026 07:27:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Kmp3dKrW";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1BA110ED32
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 07:27:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E2A8A600AE;
 Wed,  5 Aug 2026 07:27:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A121F000E9;
 Wed,  5 Aug 2026 07:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785914849;
 bh=RRccaX1H44lv9wd4FtNsO6xk209xvOOtVd/Wd9QfG2Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Kmp3dKrWD11ukmGoaYFBnZXfTek7LVTLT3VzewEb18mx1aMCLcxF3lFFkXgI3uWEK
 mVEJloYeTb66F5kOBCu48okLXTw2+GK/PphwhOb0DeZ2Nq6pIddrh2v+4m3YiFuGeX
 JAxqvfkNc9nyeGN+Xqx7WJS69gy59O+643Hir5OVnbB80+31jxsRNwTT2X6ng2+K1I
 wn4TXD5jBOd65+qOzbcI8fWp/KkcllgmDe1riYYcf2j6NQ8Sx3hhE6tW2kGFTLAOb1
 VIVGTPF2b3onJ43trn0bcDuxvdE+P2Z/ss6hgkotLp0x4qwnfydFK2z0qYo9IZpUMu
 JC+RYlzZh66fQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v5 v5 5/8] pmdomain/rockchip: cycle optional
 power-domain resets on power-on
To: "Jiaxing Hu" <gahing@gahingwoo.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org
In-Reply-To: <20260805063826.95682-6-gahing@gahingwoo.com>
References: <20260805063826.95682-1-gahing@gahingwoo.com>
 <20260805063826.95682-6-gahing@gahingwoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 07:27:28 +0000
Message-Id: <20260805072729.56A121F000E9@smtp.kernel.org>
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
- [Medium] Using dev_err() instead of dev_err_probe() for reset acquisition=
 leads to spurious boot warnings.
--

--- Patch [5]: [RFC PATCH v5 v5 5/8] pmdomain/rockchip: cycle optional powe=
r-domain resets on power-on ---
commit a3723842ac037cc5513c93510e6b54bd305213be
Author: Jiaxing Hu <gahing@gahingwoo.com>

pmdomain/rockchip: cycle optional power-domain resets on power-on

This commit cycles the resets for Rockchip power domains when they are powe=
red
on. This clears undefined bus interface states that can cause hangs on devi=
ces
like the RK3576 NPU on the first access after a cold power-on.

> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/ro=
ckchip/pm-domains.c
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c

[ ... ]

> @@ -857,6 +866,14 @@ static int rockchip_pm_add_one_domain(struct rockchi=
p_pmu *pmu,
>  	if (error)
>  		goto err_put_clocks;
> =20
> +	pd->resets =3D of_reset_control_array_get_optional_exclusive(node);
> +	if (IS_ERR(pd->resets)) {
> +		error =3D PTR_ERR(pd->resets);
> +		dev_err(pmu->dev, "%pOFn: failed to get resets: %d\n", node, error);

[Severity: Medium]
Could this cause spurious boot warnings if the reset controller hasn't prob=
ed
yet?

When of_reset_control_array_get_optional_exclusive() returns -EPROBE_DEFER,
dev_err() will log an unconditional error instead of handling the deferral
silently. Should this use dev_err_probe() to cleanly handle deferred probes
without adding spam to the kernel log?

> +		pd->resets =3D NULL;
> +		goto err_unprepare_clocks;
> +	}
> +
>  	pd->num_qos =3D of_count_phandle_with_args(node, "pm_qos",
>  						 NULL);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805063826.9568=
2-1-gahing@gahingwoo.com?part=3D5
