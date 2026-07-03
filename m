Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5BBAC43602
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 12:02:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52CD410E5EB;
	Fri,  3 Jul 2026 12:02:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gTdXYop0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D141910E5D6
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 12:02:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B7BA243DD9
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 12:02:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 632BB1F00A3D;
 Fri,  3 Jul 2026 12:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783080168;
 bh=sbwUCfUCjKDkKXwbClngT1PGetDEAU2shAq3+Mx2NXk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gTdXYop0wkqwLBDpntkJ7s8r/7F2ZNMYxN5MVD9KN2cn0QohnHtC37Mr+dwkoRcuj
 /cUXZBMLGAUOO3bCHuAluL6MLNTpDnKfJFUWoveqRFnnqAQouBA8ylGp1tY7+hg24y
 V46H/iLZ8673Qj2fWvY9un1lhduwkbGph6GxwDi7n3uhB1G2cbqoS7/0QI69qgrkTO
 7Nmhjzt1E0tvj/OKy7MCJKZpIRQGyA3VZ1wG6SC6nisMEqosNFTwK63sMBH5PFgBwR
 m9lHtgMp+fqv2MkP0l6rRGAIsdoEFrlFU1k2rO4Rls399ntmedGDFthe6pU7zLZeIU
 9GpTGduRUcJgg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 11/14] net: ipa: Switch to generic PAS TZ APIs
To: "Sumit Garg" <sumit.garg@kernel.org>
Cc: devicetree@vger.kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org
In-Reply-To: <20260702115835.167602-12-sumit.garg@kernel.org>
References: <20260702115835.167602-1-sumit.garg@kernel.org>
 <20260702115835.167602-12-sumit.garg@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 12:02:47 +0000
Message-Id: <20260703120248.632BB1F00A3D@smtp.kernel.org>
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
- [High] Switching to the generic PAS API breaks the hard module dependency=
 on the PAS backend driver, exposing a TOCTOU and Use-After-Free race condi=
tion against backend module unloading.
--

commit 6d60b150886ed8cbb76a8f5f11bec8a93730899c
Author: Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: net: ipa: Switch to generic PAS TZ APIs

This commit switches the IPA client driver to use the generic PAS TZ APIs.
The change allows the driver to support multiple TrustZone implementation
backends rather than being tied specifically to the QTEE based SCM PAS
service.

> diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
> --- a/drivers/net/ipa/ipa_main.c
> +++ b/drivers/net/ipa/ipa_main.c
> @@ -624,10 +624,13 @@ static int ipa_firmware_load(struct device *dev)
>  	}
> =20
>  	ret =3D qcom_mdt_load(dev, fw, path, IPA_PAS_ID, virt, phys, size, NULL=
);
> -	if (ret)
> +	if (ret) {
>  		dev_err(dev, "error %d loading \"%s\"\n", ret, path);
> -	else if ((ret =3D qcom_scm_pas_auth_and_reset(IPA_PAS_ID)))
> -		dev_err(dev, "error %d authenticating \"%s\"\n", ret, path);
> +	} else {
> +		ret =3D qcom_pas_auth_and_reset(IPA_PAS_ID);

[Severity: High]
Does switching to the generic PAS API here break the hard module dependency
on the PAS backend driver?

By removing the direct symbol dependency on qcom_scm, it appears the backend
PAS module can now be concurrently unloaded. If the backend is unloaded dur=
ing
this call, could it cause a use-after-free or NULL pointer dereference?

For example:
1. ipa_firmware_load() calls qcom_pas_auth_and_reset().
2. qcom_pas_auth_and_reset() checks if (!ops_ptr).
3. The backend PAS module is concurrently unloaded, and
   qcom_pas_ops_unregister() clears ops_ptr and frees the module memory.
4. qcom_pas_auth_and_reset() dereferences the now-freed ops_ptr memory.

Before this patch, the direct symbol call to qcom_scm_pas_auth_and_reset()
forced a strict module dependency that prevented backend removal.

> +		if (ret)
> +			dev_err(dev, "error %d authenticating \"%s\"\n", ret, path);
> +	}
> =20
>  	memunmap(virt);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702115835.1676=
02-1-sumit.garg@kernel.org?part=3D11
