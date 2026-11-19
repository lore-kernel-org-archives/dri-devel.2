Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B002606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k35bZQQn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B23FB112195;
	Thu, 19 Nov 2026 08:46:06 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52FB2112195
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:46:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 70C8B6228D;
 Thu, 19 Nov 2026 08:46:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE151F000C4;
 Thu, 19 Nov 2026 08:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795077960;
 bh=RNoLj4vRV9rtiIve3Nj9O1aBPK6jxMm0GF/j5FT/iKc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=k35bZQQntsSamfV0k3LHbKJiplMoJYfZF44lCtw81VXrq6/id2/WElUpSBrBhzyUa
 x+t9/qauI/28y+lW8ENlAWOHc6/42zn0cXd8oFAS8chgG6jpa8DSS5PcIYVKiTRVrU
 aXBqzVF1UBk/bfvrB5lDJHZF8eVsvTpe9tYjaGYD7ygxFxW9Iqsa5TKpoJUzHW9cL3
 uARDfTq8WXyDStnGUxfpKwoRXlqAB2s4VIrFja6Lg5LGqJsBnvGbT+4AchGmz9YC+K
 5U1fIE+Sm4dEsEvktCktNbNpI0qgSKkVvHAW1mD5YTLIA768+1RhEt8QxyMTCKzgR9
 7rZg3aYd55f7w==
Message-ID: <sashiko-outbox-222706@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 20/29] drm/bridge_connector: avoid detect-based HPD
 notifications for DisplayPort
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261119-msm-dp-mst-v9-20-ca61be4edfc3@oss.qualcomm.com>
References: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
 <20261119-msm-dp-mst-v9-20-ca61be4edfc3@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 08:45:59 +0000
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
- [Medium] drm/bridge_connector: check detect->type in
  drm_bridge_connector_detect_ctx()
--

commit c94cf087c06da031558bf281d88106d6134140dc
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

drm/bridge_connector: avoid detect-based HPD notifications for DisplayPort

This commit skips calling drm_bridge_connector_hpd_notify() from
drm_bridge_connector_detect_ctx() for DisplayPort connectors that have an
HPD bridge.

> diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu=
/drm/display/drm_bridge_connector.c
> index 1d4502126bff3..dbe874d26911b 100644
> --- a/drivers/gpu/drm/display/drm_bridge_connector.c
> +++ b/drivers/gpu/drm/display/drm_bridge_connector.c
> @@ -315,7 +315,10 @@ static int drm_bridge_connector_detect_ctx(struct dr=
m_connector *connector,
>  				return ret;
>  		}
> =20
> -		drm_bridge_connector_hpd_notify(connector, status, DRM_CONNECTOR_NO_EX=
TRA_STATUS);
> +		if (connector->connector_type !=3D DRM_MODE_CONNECTOR_DisplayPort ||
> +		    !bridge_connector->bridge_hpd)
> +			drm_bridge_connector_hpd_notify(connector, status,
> +							DRM_CONNECTOR_NO_EXTRA_STATUS);

[Severity: Medium]
Should this check detect->type !=3D DRM_MODE_CONNECTOR_DisplayPort instead =
of
connector->connector_type?

In drm_bridge_connector_init(), connector->connector_type is taken from the
last bridge in the chain rather than bridge_connector->bridge_detect.  When
msm_dp_bridge (detect->type =3D=3D DRM_MODE_CONNECTOR_DisplayPort) is follo=
wed
by a Type-C HPD bridge that sets bridge.type =3D DRM_MODE_CONNECTOR_USB (su=
ch
as drivers/platform/arm64/acer-aspire1-ec.c), connector->connector_type is
DRM_MODE_CONNECTOR_USB.  When msm_dp_bridge_detect() returns
connector_status_disconnected (for example while MST is active),
drm_bridge_connector_detect_ctx() will still notify the bridge chain and
tear down the active DP link.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-msm-dp-mst=
-v9-0-ca61be4edfc3@oss.qualcomm.com?part=3D20
