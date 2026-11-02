Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D2B606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 11:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C3fmvZ8d
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 726B010ECE9;
	Mon,  2 Nov 2026 11:03:36 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 516BA10ECE9
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 11:03:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B00C560618;
 Mon,  2 Nov 2026 11:03:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378571F00A17;
 Mon,  2 Nov 2026 11:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793617409;
 bh=mh3z9noCE6ZdoU5gFlYQzP62zXwNFZoh5XtwaNvSP3E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=C3fmvZ8d3sD4RUV+K6BtpLL3QKZ2KIpPx+UvupT3djtUKxSS840CB7w7R/IJpZr0n
 y/HSP9VoM5oO6ICNcEIzqWWv2ftdUYOtLCAysKul+7idqm91UBqL9iG1VJiNbepl6e
 2jCORx88ELEkXrY1DXmKMnTEWQp1S6lqBLn9pwJE9JvTeViub5wLkfaKBXPJeed2GY
 xSZQwPtaBDxslM7EXzlDaneZ62RS7thXfDrWj8Xt37URN6PQcJTAxUAVqFE83wFyxF
 UyTPCe1PSoAW7xlygZGDJmCwK8WofOnPpxIC0Ex4vPbTS12Z4zUDASq07or7TXbV2A
 2ZKZ5HrDmigUQ==
Message-ID: <sashiko-outbox-193311@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/13] gpu: drm: exynos: call
 cec_notifier_phys_addr_invalidate if no EDID
To: "Hans Verkuil" <hverkuil+cisco@kernel.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <727792a5e9eb05c3c0abd5930bb53ed8cd7d3724.1793615824.git.hverkuil+cisco@kernel.org>
References: <cover.1793615824.git.hverkuil+cisco@kernel.org>
 <727792a5e9eb05c3c0abd5930bb53ed8cd7d3724.1793615824.git.hverkuil+cisco@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 11:03:28 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/exynos: hdmi_get_modes() calls cec_notifier_set_phys_addr() =
when no EDID
--

commit 66acd3ff42feaf8689b6b9eff4b13a5139f4e6bb
Author: Hans Verkuil <hverkuil+cisco@kernel.org>

gpu: drm: exynos: call cec_notifier_phys_addr_invalidate if no EDID

This commit updates hdmi_detect() in the Exynos HDMI driver to call
cec_notifier_phys_addr_invalidate() instead of cec_notifier_set_phys_addr()
with CEC_PHYS_ADDR_INVALID when the connector is disconnected.

> diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exyno=
s/exynos_hdmi.c
> index 055dc04f9b3e5..d03f4e531e05e 100644
> --- a/drivers/gpu/drm/exynos/exynos_hdmi.c
> +++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
> @@ -857,7 +857,7 @@ static enum drm_connector_status hdmi_detect(struct d=
rm_connector *connector,
>  	if (gpiod_get_value(hdata->hpd_gpio))
>  		return connector_status_connected;
> =20
> -	cec_notifier_set_phys_addr(hdata->notifier, CEC_PHYS_ADDR_INVALID);
> +	cec_notifier_phys_addr_invalidate(hdata->notifier);

[Severity: Medium]
The commit message notes that if an EDID is present, the driver should call
cec_notifier_set_phys_addr(), and if not, it should call
cec_notifier_phys_addr_invalidate().

However, this patch only updates the HPD disconnect path in hdmi_detect().
When HPD is asserted (or probing is forced) and
drm_helper_probe_single_connector_modes() calls hdmi_get_modes(), if reading
the EDID via drm_edid_read_ddc() returns NULL, drm_edid_connector_update()
sets info->source_physical_address to CEC_PHYS_ADDR_INVALID and
hdmi_get_modes() still calls cec_notifier_set_phys_addr() before checking
drm_edid:

drivers/gpu/drm/exynos/exynos_hdmi.c:hdmi_get_modes() {
	...
	drm_edid =3D drm_edid_read_ddc(connector, hdata->ddc_adpt);

	ret =3D drm_edid_connector_update(connector, drm_edid);
	if (ret)
		return 0;

	cec_notifier_set_phys_addr(hdata->notifier, info->source_physical_address);

	if (!drm_edid)
		goto no_edid;
	...
no_edid:
	return drm_add_modes_noedid(connector, 640, 480);
}

Should hdmi_get_modes() also be updated so that cec_notifier_set_phys_addr()
is only called when drm_edid is non-NULL, and
cec_notifier_phys_addr_invalidate() is called in the no_edid path when no
EDID could be read?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793615824.gi=
t.hverkuil+cisco@kernel.org?part=3D2
