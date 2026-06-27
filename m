Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F334C43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 13:42:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C634B10E17E;
	Sat, 27 Jun 2026 13:42:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oiy3gjgr";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8C5510E17E
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 13:42:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C2BD843BE1
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 13:42:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 735EF1F000E9;
 Sat, 27 Jun 2026 13:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782567746;
 bh=kG5rcQLZLV6vNnp+cKsDOLPDFjLzZTxQfFFHYKDHt4o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oiy3gjgrvDXAl2Jsj9K4UubQVKSbyYp2AshOGoPWdi7RHVrbj3513XA9LK158bTnp
 MzrYIyXaJtJZ9kdq06Fbqi0q4aF5JqJobLEn8YNhoLkJ048QC45E1V7jOlXrdNwUea
 BhdpVMxEn/UFguMS5PTXtD/sUoEW9XncHriptauMJUrx0x02M15tA/899jAR2ujjYS
 nT4Z6EYl4xDFIYSk5HRarSnBCtztIiuxyaujI0xu0zIHLUhN9WpwMOuFxjO2a2Gl2S
 GN94Gsp0i+1rQt0URaC5HE+fDAuBxYSfTgPa3b7ZkUAIfR/edVe5VuaDJvPYMdezEt
 r+rfHQED7EWKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 11/14] net: ipa: Switch to generic PAS TZ APIs
To: "Sumit Garg" <sumit.garg@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260626133440.692849-12-sumit.garg@kernel.org>
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-12-sumit.garg@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 13:42:26 +0000
Message-Id: <20260627134226.735EF1F000E9@smtp.kernel.org>
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
- [High] Switching to the generic PAS API exposes the IPA driver to a Time-=
of-Check to Time-of-Use (TOCTOU) race condition and Use-After-Free due to l=
ockless access to the global `ops_ptr`.
--

commit dccc0e82eb171fead953bff95c97cce60f8a1717
Author: Sumit Garg <sumit.garg@oss.qualcomm.com>

net: ipa: Switch to generic PAS TZ APIs

This commit switches the ipa client driver to use the generic PAS TZ APIs
instead of the scm-specific implementation. This allows supporting multiple
TZ implementation backends.

> diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
> index 788dd99af2a4d..3cd9e44680e9f 100644
> --- a/drivers/net/ipa/ipa_main.c
> +++ b/drivers/net/ipa/ipa_main.c
[ ... ]
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
Does switching to qcom_pas_auth_and_reset() expose the driver to a race
condition if the PAS backend is unbound concurrently?

Looking at the underlying qcom_pas_auth_and_reset() implementation in
drivers/firmware/qcom/qcom_pas.c, it performs a lockless check:

    if (!ops_ptr)
        return -ENODEV;

    return ops_ptr->auth_and_reset(ops_ptr->dev, pas_id);

If a privileged user unbinds the PAS backend or unloads its module after
ops_ptr is checked but before it is dereferenced, ops_ptr could be set to
NULL or the backend module memory could be freed.

Since qcom_pas.c doesn't appear to use synchronization or module reference
counting (like try_module_get()) to protect ops_ptr, could this result in
a NULL pointer dereference or a use-after-free by executing freed module te=
xt
when the dereference occurs?

> +		if (ret)
> +			dev_err(dev, "error %d authenticating \"%s\"\n", ret, path);
> +	}
> =20
>  	memunmap(virt);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626133440.6928=
49-1-sumit.garg@kernel.org?part=3D11
