Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F08C4451C
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 07:12:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19BFF10EC93;
	Wed, 22 Jul 2026 07:12:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mGb3/FY0";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47A7710EC93
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 07:12:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 86F2E60A67;
 Wed, 22 Jul 2026 07:12:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136891F000E9;
 Wed, 22 Jul 2026 07:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784704357;
 bh=XJpg/hkFlEkKNd6o4gJUED1yRb4CiuEy7nBn3sPIAN4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mGb3/FY0+ETtz2bt5QU+d+OLfI/IcjlsTxwhrUiC80VzzHyzDleYC5hS9SgySSEKa
 SkfXRzHx5Gr8MOL4B1PDVCQjoWceUWyw7eVdXBn6O0rOnWGIaVBFIBJlFq1WWvW+mU
 kFMyvX4UV39KMwcW2f34uugYy+eoDnFfRLS0OfCRmQ2qVJNVdF2piripnW4A51lRdM
 ZYa1KaH63AbskHjmTrmIPD6/0S9KjHW2THPpCx4H1q5fwNrF/b1DJxJVAq6sjQVeuB
 MTlGbdVVVGJcAIVmeqOF8GHNfXoLnTh/wfroljbvKV4GnuV0xReBtaHNyriwFog3qT
 YR6ZWu3ugC8Kg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 22/24] drm/msm/dp: stop storing the connector in struct
 msm_dp
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260722-drm-msm-display-interface-v1-22-368c10fe62fd@oss.qualcomm.com>
References: <20260722-drm-msm-display-interface-v1-0-368c10fe62fd@oss.qualcomm.com>
 <20260722-drm-msm-display-interface-v1-22-368c10fe62fd@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 07:12:36 +0000
Message-Id: <20260722071237.136891F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] msm_dp_display_get_connector() returns a connector pointer witho=
ut holding a reference, violating the DRM iterator API.

Pre-existing issues:
- [High] Missing assignment of `debug->connector` leads to a guaranteed NUL=
L pointer dereference when reading debugfs files.
--

--- Patch [22]: [PATCH 22/24] drm/msm/dp: stop storing the connector in str=
uct msm_dp ---
commit 6517fb125f3c91df434e357450ad362fc4f2fec3
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/msm/dp: stop storing the connector in struct msm_dp

This commit removes the cached drm_connector from struct msm_dp. Instead of
storing the connector, consumers are updated to obtain it from their calling
context, the atomic state, or by looking it up from the encoder.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
[ ... ]
> @@ -1329,6 +1341,25 @@ bool msm_dp_wide_bus_available(const struct msm_dp=
 *msm_dp_display)
>  	return dp->wide_bus_supported;
>  }
> =20
> +static struct drm_connector *
> +msm_dp_display_get_connector(struct msm_dp *msm_dp_display)
> +{
> +	struct drm_encoder *encoder =3D msm_dp_display->bridge->encoder;
> +	struct drm_connector_list_iter conn_iter;
> +	struct drm_connector *connector, *found =3D NULL;
> +
> +	drm_connector_list_iter_begin(msm_dp_display->drm_dev, &conn_iter);
> +	drm_for_each_connector_iter(connector, &conn_iter) {
> +		if (drm_connector_has_possible_encoder(connector, encoder)) {
> +			found =3D connector;
> +			break;
> +		}
> +	}
> +	drm_connector_list_iter_end(&conn_iter);
> +
> +	return found;
> +}

[Severity: Medium]
When the loop breaks, drm_connector_list_iter_end() automatically drops the
reference on the current iterator connector. Since drm_connector_get() is n=
ot
called on found before returning, does this return a raw pointer without an
elevated reference count?

> +
>  void msm_dp_display_debugfs_init(struct msm_dp *msm_dp_display, struct d=
entry *root, bool is_edp)
>  {
>  	struct msm_dp_display_private *dp;
> @@ -1338,7 +1369,9 @@ void msm_dp_display_debugfs_init(struct msm_dp *msm=
_dp_display, struct dentry *r
>  	dp =3D container_of(msm_dp_display, struct msm_dp_display_private, msm_=
dp_display);
>  	dev =3D &dp->msm_dp_display.pdev->dev;
> =20
> -	rc =3D msm_dp_debug_init(dev, dp->panel, dp->link, dp->msm_dp_display.c=
onnector, root, is_edp);
> +	rc =3D msm_dp_debug_init(dev, dp->panel, dp->link,
> +			       msm_dp_display_get_connector(msm_dp_display),
> +			       root, is_edp);

[Severity: High]
This is a pre-existing issue, but I noticed that msm_dp_debug_init() in
dp_debug.c accepts the connector argument but never assigns it to the
allocated debug structure (missing debug->connector =3D connector).

Later, when a user reads from debugfs nodes like dp_test_active, the show
handlers dereference debug->connector. Since it remains NULL from the
devm_kzalloc() allocation, will reading these debugfs files cause a NULL
pointer dereference?

>  	if (rc)
>  		DRM_ERROR("failed to initialize debug, rc =3D %d\n", rc);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722-drm-msm-di=
splay-interface-v1-0-368c10fe62fd@oss.qualcomm.com?part=3D22
