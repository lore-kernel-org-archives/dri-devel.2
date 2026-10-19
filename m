Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503BA6083410
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 15:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nep6+ffM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACF6410E43C;
	Mon, 19 Oct 2026 15:06:58 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA6B910E43C
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 15:06:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C5A3D601FD
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 15:06:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B5D1F000C5;
 Mon, 19 Oct 2026 15:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792422410;
 bh=SMU5ouf2J5xJhtLpN9DwwMPbZ2j9gWdDb7XNbzkS4II=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Nep6+ffMHIICSOyo3yBh4uggxnquIe6aqyiBI/U6zUJ17qCYPEVwIdiyDV1QbUnPu
 ECTu95nqKofC2NWV3OMCn9fqBsSTRVNcMyWzgw/KSRRLl1WLoCbDM+2G7feSef7qjY
 1zF5mLUlmXMHBqiJW90MHHNuykcHN3NbcVCqFZGcs5KXzbl8ZiHaRqx8tleHDR1fPc
 KbaDBmlIoj9y98eLs8OTP96V1AIr4v7l4scRVDq99YlvRFG3mhJbPYeqItM9Cl7WAS
 UenN5Dv2dRwNyEGbSxzkcAE9AFbrC335Fpgx6+gfplW9eQTyCDmvUXk1bOI3aCzArV
 pGHfwSbFymrWQ==
Message-ID: <sashiko-outbox-177614@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-5.10] drm/rockchip: dw_hdmi: Use
 resume_early pm ops for system suspend
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261019135441.1420968-349-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-349-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 15:06:49 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_ZEN_BLOCKED_OPENDNS,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/rockchip: dw_hdmi: UAF in dw_hdmi_rockchip_resume_early() on s=
tale drvdata
--

commit c6209b9cde57945de5a9c2033ae8339d9c3026b8
Author: Jonas Karlman <jonas@kwiboo.se>

drm/rockchip: dw_hdmi: Use resume_early pm ops for system suspend

This commit switches the dw-hdmi Rockchip glue driver to use the
resume_early PM callback so that dw_hdmi_resume() runs before
rockchip_drm_sys_resume() during system resume. It also adds a NULL check on
the driver data pointer in dw_hdmi_rockchip_resume_early().

Link: https://patch.msgid.link/20260518193748.2482823-12-jonas@kwiboo.se

> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/dr=
m/rockchip/dw_hdmi-rockchip.c
> index 727cdf768161a..ff34aeef3a6ff 100644
> --- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> @@ -635,17 +635,18 @@ static void dw_hdmi_rockchip_remove(struct platform=
_device *pdev)
>  	component_del(&pdev->dev, &dw_hdmi_rockchip_ops);
>  }
> =20
> -static int __maybe_unused dw_hdmi_rockchip_resume(struct device *dev)
> +static int __maybe_unused dw_hdmi_rockchip_resume_early(struct device *d=
ev)
>  {
>  	struct rockchip_hdmi *hdmi =3D dev_get_drvdata(dev);
> =20
> -	dw_hdmi_resume(hdmi->hdmi);
> +	if (hdmi)
> +		dw_hdmi_resume(hdmi->hdmi);

[Severity: High]
Is checking if (hdmi) sufficient to guarantee that hdmi and hdmi->hdmi are
valid here?

In drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c, hdmi is allocated with
devm_kzalloc() inside dw_hdmi_rockchip_bind(), which runs inside the
component devres group opened by component_bind().

dw_hdmi_rockchip_bind() sets the driver data before calling dw_hdmi_bind(),
and does not clear it on failure:

	platform_set_drvdata(pdev, hdmi);

	hdmi->hdmi =3D dw_hdmi_bind(pdev, encoder, plat_data);

	if (IS_ERR(hdmi->hdmi)) {
		ret =3D PTR_ERR(hdmi->hdmi);
		goto err_bind;
	}

	return 0;

err_bind:
	drm_encoder_cleanup(encoder);

	return ret;

When dw_hdmi_bind() fails (for example with -EPROBE_DEFER when the DDC I2C
adapter is not ready), component_bind() calls devres_release_group(), which
frees hdmi and disables the devm-managed clocks and regulators while leaving
dev->driver_data as a non-NULL dangling pointer.

Similarly, dw_hdmi_rockchip_unbind() does not clear dev->driver_data before
component_unbind() calls devres_release_group():

static void dw_hdmi_rockchip_unbind(struct device *dev, struct device *mast=
er,
				    void *data)
{
	struct rockchip_hdmi *hdmi =3D dev_get_drvdata(dev);

	dw_hdmi_unbind(hdmi->hdmi);
	drm_encoder_cleanup(&hdmi->encoder.encoder);
}

If a system suspend/resume occurs after a failed bind or after component
unbind, wouldn't dev_get_drvdata(dev) in dw_hdmi_rockchip_resume_early()
return a non-NULL dangling pointer and pass a freed or ERR_PTR hdmi->hdmi to
dw_hdmi_resume() while the HDMI clocks and regulators are disabled?

> =20
>  	return 0;
>  }
> =20
>  static const struct dev_pm_ops dw_hdmi_rockchip_pm =3D {
> -	SET_SYSTEM_SLEEP_PM_OPS(NULL, dw_hdmi_rockchip_resume)
> +	SET_LATE_SYSTEM_SLEEP_PM_OPS(NULL, dw_hdmi_rockchip_resume_early)
>  };
> =20
>  struct platform_driver dw_hdmi_rockchip_pltfm_driver =3D {

=E0=B4=A8=E0=B5=87=E0=B4=B0=E0=B4=BF=E0=B4=9F=E0=B5=8D=E0=B4=9F=E0=B5=8D

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-349-sashal@kernel.org?part=3D1
