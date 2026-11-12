Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052A3606A323
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 10:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HYoQxsDw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60C0B10FFEA;
	Thu, 12 Nov 2026 10:29:48 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DD4F10FFE4
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 10:29:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1823D4147D;
 Thu, 12 Nov 2026 10:29:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14C31F00A05;
 Thu, 12 Nov 2026 10:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794479381;
 bh=Hsxurt0PlapmVQI+3/rw92ozy6OCcwjRX4zDkKeWZ0U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HYoQxsDwE9WJXryCmsM2Ohqj0H1aqDTYFgLPgJba5GNHC7f4dghMz4qWlHnCi68hK
 PU+keO1lagYnzWtnGurQoV89DkRgO5B5v3wn687YzKX+1pjtj1PXmNutdcVTQ9w3Wd
 eCaIQwtFpS/2lbo7Idf8QBOmPENEsinfkXI/Sr+BLE7xlLB7jWwZtlWhA73dwnlqGB
 qI2HVYWyQQr1hJ5fVAaJe+qWcrYoQ2SBjwqCxQW98Lz9qDB4gpVOm8Rg8girZayyBk
 vO68d/cQ7Ngwmgidokc4llMev8IGg2xWJ7nhhcYtCsURWr4GJ8x+FvbZ3uPu1ovAkp
 3v5iQS8G7WYGQ==
Message-ID: <sashiko-outbox-210943@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7] drm/bridge: dw-hdmi-qp: serialize HDMI audio
 callbacks with PHY enable/disable
To: "Frank Zhang" <rmxpzlb@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261112101155.47777-1-rmxpzlb@gmail.com>
References: <20261112101155.47777-1-rmxpzlb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 10:29:40 +0000
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
- [Medium] drm/bridge: dw-hdmi-qp: unbalanced PHY disable on init
  failure
--

commit 964bd3d6c9dd93511a7cc0697725f1d96d4a0a68
Author: Frank Zhang <rmxpzlb@gmail.com>

drm/bridge: dw-hdmi-qp: serialize HDMI audio callbacks with PHY enable/disa=
ble

This commit adds a mutex and an enabled flag to struct dw_hdmi_qp's phy
sub-structure to serialize HDMI audio and infoframe callbacks against PHY
initialization and disablement.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/d=
rm/bridge/synopsys/dw-hdmi-qp.c
> index 62835485d66a1..ef5ccf0f609ce 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c

[ ... ]

> @@ -572,10 +597,25 @@ static void dw_hdmi_qp_bridge_atomic_enable(struct =
drm_bridge *bridge,
>  	scoped_guard(mutex, &hdmi->mutex)
>  		hdmi->curr_conn =3D connector;
> =20
> -	hdmi->phy.ops->init(hdmi, hdmi->phy.data);
> +	ret =3D hdmi->phy.ops->init(hdmi, hdmi->phy.data);
> +	if (unlikely(ret)) {
> +		dev_err(hdmi->dev, "failed to initialize PHY: %d\n", ret);
> +		scoped_guard(mutex, &hdmi->mutex) {
> +			drm_connector_put(hdmi->curr_conn);
> +			hdmi->curr_conn =3D NULL;
> +		}
> +
> +		hdmi->phy.enabled =3D false;
> +		hdmi->tmds_char_rate =3D 0;
> +
> +		mutex_unlock(&hdmi->phy.lock);
> +		return;
> +	}
> +	hdmi->phy.enabled =3D true;
> =20
>  	dw_hdmi_qp_mod(hdmi, HDCP2_BYPASS, HDCP2_BYPASS, HDCP2LOGIC_CONFIG0);
>  	dw_hdmi_qp_mod(hdmi, op_mode, OPMODE_DVI, LINK_CONFIG0);
> +	mutex_unlock(&hdmi->phy.lock);
> =20
>  	drm_atomic_helper_connector_hdmi_update_infoframes(connector, state);
>  }
> @@ -593,12 +633,14 @@ static void dw_hdmi_qp_bridge_atomic_disable(struct=
 drm_bridge *bridge,
>  		}
>  	}
> =20
> +	guard(mutex)(&hdmi->phy.lock);
>  	hdmi->tmds_char_rate =3D 0;
> =20
>  	connector =3D drm_atomic_get_old_connector_for_encoder(state, bridge->e=
ncoder);
>  	drm_connector_hdmi_disable_scrambling(connector);
> =20
>  	hdmi->phy.ops->disable(hdmi, hdmi->phy.data);
> +	hdmi->phy.enabled =3D false;
>  }

[Severity: Medium]
If hdmi->phy.ops->init() fails in dw_hdmi_qp_bridge_atomic_enable(), can
the subsequent dw_hdmi_qp_bridge_atomic_disable() call
hdmi->phy.ops->disable() on a PHY that was never enabled?

Because atomic_enable returns void, the DRM atomic state still considers
the bridge enabled and will call dw_hdmi_qp_bridge_atomic_disable() on the
next modeset disable.  In the Rockchip glue driver, init() and disable()
wrap phy_power_on() and phy_power_off().  An unbalanced phy_power_off()
underflows phy->power_count from 0 to -1, which causes the next
phy_power_on() to increment phy->power_count back to 0 and return 0
without powering on the hardware; dw_hdmi_qp_bridge_atomic_enable() then
sets hdmi->phy.enabled =3D true and accesses controller registers with the
PHY off, triggering an SError panic.

In addition, the error path in dw_hdmi_qp_bridge_atomic_enable() returns
without calling drm_connector_hdmi_disable_scrambling(connector) to undo
the earlier drm_connector_hdmi_enable_scrambling() call and cancel
connector->hdmi.scdc_work.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112101155.4777=
7-1-rmxpzlb@gmail.com?part=3D1
