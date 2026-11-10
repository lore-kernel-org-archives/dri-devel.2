Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1F7606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 05:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O2e5LXiv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FF5710EDD6;
	Tue, 10 Nov 2026 05:38:42 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDF5310EDD6
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 05:38:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E8E98609F6;
 Tue, 10 Nov 2026 05:38:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 799781F008A1;
 Tue, 10 Nov 2026 05:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794289115;
 bh=dfCgp8GPTEWAbyFw7bGhZ1iyym6z8YK5+bD3Zi7Rlqo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=O2e5LXivdlZXv/b4WUDO6fWl10Mtsgqt86U1/JsaQuG8d/q4qpK5Afp+nWLy3ZDtA
 C0CyXaACUPsT7MOD2NlBSWph20Wwl3xTiQtG30pW2as6Scrdd/Ucoj6pJGqf0rAp2S
 d1qiKJ/8Z8ourDleBTRziHaMoFCqnSQ7Fs2OyU4RAt02KuLgGF4g+4G+V+DCpzxZmP
 5HKwHcR2PiM0gkHfRO29nlksBHyRI/Jad/DQTOMYtlQT8T05wNaE8exE/+spoVdSO1
 aQ2koF7JbRcL15jfw+ynSiunBJI4Koc5BSczG6q6engnlp4t/J7SfSjEwztto5RZMN
 druWaRgTNT1Rg==
Message-ID: <sashiko-outbox-206319@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 20/29] drm/bridge_connector: avoid detect-based HPD
 notifications for DisplayPort
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261110-msm-dp-mst-v8-20-d040fb33db5f@oss.qualcomm.com>
References: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
 <20261110-msm-dp-mst-v8-20-d040fb33db5f@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 05:38:35 +0000
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

commit 04bf0f44e3eb4437286f57eb3ea7a63feed9cedc
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
Should this check detect->type rather than connector->connector_type?

In drm_bridge_connector_init(), connector->connector_type is taken from the
last bridge in the chain:

drivers/gpu/drm/display/drm_bridge_connector.c:drm_bridge_connector_init() {
	...
		if (drm_bridge_is_last(bridge))
			connector_type =3D bridge->type;
	...
}

On DisplayPort pipelines where msm_dp is followed by a terminal Type-C HPD
bridge (such as acer-aspire1-ec setting bridge.type to
DRM_MODE_CONNECTOR_USB) or a DP-to-HDMI branch bridge and hdmi-connector
(DRM_MODE_CONNECTOR_HDMIA), detect is the DisplayPort bridge while
connector->connector_type is not DRM_MODE_CONNECTOR_DisplayPort.  When
detect->funcs->detect() returns connector_status_disconnected while the DP
link is active, drm_bridge_connector_detect_ctx() will still send a
disconnected HPD notification that tears down the active DP link and MST
topology.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-msm-dp-mst=
-v8-0-d040fb33db5f@oss.qualcomm.com?part=3D20
