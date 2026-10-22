Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC8F606A31D
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MpUVWD8T
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5879112668;
	Thu, 22 Oct 2026 13:35:40 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE58F112667;
 Thu, 22 Oct 2026 13:35:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 24DEF60A6F;
 Thu, 22 Oct 2026 13:35:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1011F000C1;
 Thu, 22 Oct 2026 13:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792676133;
 bh=8msTlnzVM9G6d7FDjt5gVAJzZzx4wSTr7tyRKNMn/As=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MpUVWD8TCtRQF6PSOlcjRgt46ubid+GXo6rs7JQfPTDNf7+cd99vWlXHplSOnwcL1
 Tc9nOsltAFnuZfLQQBF/5FC8WjXT/6h04GLlEl2T3z6tknuR2mniSF0IMr0rUPu0XD
 DM8RA8g2cP0jdbFTX7S5eMu1x4XnVMkuJA2lgjSe2DZSaZHwHJVKKVhMdBclGUrrz3
 HPS9Fv0IzP2M15ccHBivPno6VeVbfTxicLA+lG7M2vJXdiKr7y14xiRCvE9TniViv4
 N/dIuPnY5tvZWvtPsf0/BAOSccGdfB18CawjKHYQiNz1jHs6OyL5kH4p5GDMrar/r2
 C4ad3lMclnNQg==
Message-ID: <sashiko-outbox-181549@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/9] drm/bridge: pass down IRQ_HPD to the drivers
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-amlogic@lists.infradead.org, neil.armstrong@linaro.org
In-Reply-To: <20261022-hpd-irq-events-v6-3-337ea3ddaa62@oss.qualcomm.com>
References: <20261022-hpd-irq-events-v6-0-337ea3ddaa62@oss.qualcomm.com>
 <20261022-hpd-irq-events-v6-3-337ea3ddaa62@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 13:35:32 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] drm/omap: unupdated hpd_notify() signature in hdmi5_bridge_hpd_noti=
fy()
--

commit 9cf55ff0f96b440ba05665e3db9e82c5372fd640
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/bridge: pass down IRQ_HPD to the drivers

This commit adds an enum drm_connector_dp_event parameter to the
drm_bridge_funcs.hpd_notify callback and updates its callers and bridge
implementations so DisplayPort bridges can handle IRQ_HPD events.

[ ... ]

> diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi4.c b/drivers/gpu/drm/omapdr=
m/dss/hdmi4.c
> index bd6c4d2dcdc86..72972a6fe989b 100644
> --- a/drivers/gpu/drm/omapdrm/dss/hdmi4.c
> +++ b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
> @@ -429,7 +429,8 @@ static void hdmi4_bridge_disable(struct drm_bridge *b=
ridge,
> =20
>  static void hdmi4_bridge_hpd_notify(struct drm_bridge *bridge,
>  				    struct drm_connector *connector,
> -				    enum drm_connector_status status)
> +				    enum drm_connector_status status,
> +				    enum drm_connector_dp_event event)
>  {
>  	struct omap_hdmi *hdmi =3D drm_bridge_to_hdmi(bridge);
> =20
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 1981d24a700d2..6382ef5f1ea28 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -509,7 +509,8 @@ struct drm_bridge_funcs {
>  	 */
>  	void (*hpd_notify)(struct drm_bridge *bridge,
>  			   struct drm_connector *connector,
> -			   enum drm_connector_status status);
> +			   enum drm_connector_status status,
> +			   enum drm_connector_dp_event event);
> =20
>  	/**
>  	 * @hpd_enable:

[Severity: Low]
While hdmi4_bridge_hpd_notify() in drivers/gpu/drm/omapdrm/dss/hdmi4.c is
updated here, it looks like hdmi5_bridge_hpd_notify() in
drivers/gpu/drm/omapdrm/dss/hdmi5.c still has the old 3-argument signature:

static void hdmi5_bridge_hpd_notify(struct drm_bridge *bridge,
				    struct drm_connector *connector,
				    enum drm_connector_status status)
{
	struct omap_hdmi *hdmi =3D drm_bridge_to_hdmi(bridge);

	hdmi_audio_hpd_notify(hdmi, status);
}
...
static const struct drm_bridge_funcs hdmi5_bridge_funcs =3D {
	...
	.hpd_notify =3D hdmi5_bridge_hpd_notify,
	.edid_read =3D hdmi5_bridge_edid_read,
};

Should hdmi5_bridge_hpd_notify() also be updated to accept enum
drm_connector_dp_event event so that builds with CONFIG_OMAP5_DSS_HDMI
enabled do not fail with an incompatible function pointer type error?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-hpd-irq-ev=
ents-v6-0-337ea3ddaa62@oss.qualcomm.com?part=3D3
