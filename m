Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BBF606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 07:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TQyy/9tN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20EBC10E7B9;
	Tue,  3 Nov 2026 07:50:14 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 603FC10E7B9
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 07:50:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2B024411F6;
 Tue,  3 Nov 2026 07:50:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC21B1F00919;
 Tue,  3 Nov 2026 07:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793692208;
 bh=zaiQFFHftDTuAFLRvSE784kBT9g2ULnTDOZCe9FE6hw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TQyy/9tNKk8y+Gquj/dDtg0L6KTJwg8nENJmetpV7qN1GufF9oM6NIf1hw5Pbi8lf
 SGNYy9z84izPBETG98qwakO7KWm9cnH+WX6WILwRpXwhP4/1Yo1s86bobE0T0h4Ff3
 13Q7Tzoq8fdRDz9kgnWuY1OE2MoRgY0ZYB/p96MxA0suaS2VH+Hn+bYEhsRv2+tkx9
 uPH0etjswd4OgSbEiTNeVlaRO+XtcSkvYtZJYnrIqzHij9dZM4ES/4UNnSW4IJ6D5u
 c0bMsJxf8hrnVu+RHQCQC0J0m1o8Oe/YL0KAaCZHj+ypPaLHIVfbTZtgRPmwqmxJ1/
 lHMwP1BdEpneg==
Message-ID: <sashiko-outbox-194747@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2 02/13] gpu: drm: exynos: call
 cec_notifier_phys_addr_invalidate if no EDID
To: "Hans Verkuil" <hverkuil+cisco@kernel.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <80b02c6057f32dd8be8b4de95d1cd27352cdddc8.1793691124.git.hverkuil+cisco@kernel.org>
References: <cover.1793691124.git.hverkuil+cisco@kernel.org>
 <80b02c6057f32dd8be8b4de95d1cd27352cdddc8.1793691124.git.hverkuil+cisco@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 07:50:07 +0000
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
with no EDID
--

commit f0dacf81d55b2fd1b8fee4812c0ecf88da4b0a39
Author: Hans Verkuil <hverkuil+cisco@kernel.org>

gpu: drm: exynos: call cec_notifier_phys_addr_invalidate if no EDID

This commit updates hdmi_detect() in exynos_hdmi to call
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
The commit message notes that cec_notifier_set_phys_addr() should be called=
 if
an EDID is present and cec_notifier_phys_addr_invalidate() if not, so the C=
EC
framework can distinguish between CEC_PHYS_ADDR_INVALID due to a missing ED=
ID
versus an EDID without a physical address.

While this updates the disconnect path in hdmi_detect(), hdmi_get_modes() in
drivers/gpu/drm/exynos/exynos_hdmi.c still calls cec_notifier_set_phys_addr=
()
before checking whether drm_edid is NULL:

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
}

When drm_edid_read_ddc() returns NULL during mode probing via
drm_helper_probe_single_connector_modes() -> hdmi_get_modes(),
drm_edid_connector_update() resets info->source_physical_address to
CEC_PHYS_ADDR_INVALID, and hdmi_get_modes() passes that to
cec_notifier_set_phys_addr() even though no EDID was read.

Should hdmi_get_modes() also check for a NULL drm_edid first and call
cec_notifier_phys_addr_invalidate(hdata->notifier) on the no_edid path inst=
ead
of cec_notifier_set_phys_addr()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/80b02c6057f32dd8be8=
b4de95d1cd27352cdddc8.1793691124.git.hverkuil+cisco@kernel.org?part=3D1
