Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5625606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 16:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZKxP/U8p
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24E5010ECA8;
	Tue, 24 Nov 2026 16:05:55 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2892210ECA8
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 16:05:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E95C24486C;
 Tue, 24 Nov 2026 16:05:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A75D1F000D3;
 Tue, 24 Nov 2026 16:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795536347;
 bh=Cv2LykdzoWATAdS0+UUtysQMsmJwn0R6Nob/ZJuFkeQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZKxP/U8p+DqKMZVQyV6JfLR+6D0PT6hY6l3dtxh6Yws8wy0h81FrtXi49eK8oKaRz
 ml0B+IbUTtVpIM3fE+zP1qaNsnRhhhW3I8k8T7h+IuWJtc32ZMYgt680qqaxgCswe8
 D568NoPaJhRmfuPzwCh7Ky0jAZi6+9JFr0JKSOVul6YaF91H0ScziA8nHZqgxUwvFH
 4lCGhOd9zvy12Gqn1bHwCSMmuYHht0Ll7N6DkJyxOVz28tfQfe7uFmm+B9SA7DGXjy
 PHh5w8KoWXVzxjGL0/YmrmfO1xesJmAONIqyAwLQCMcP7NIqob77wG8Z/f+kFxiVRF
 vnNYw7PQz+fXA==
Message-ID: <sashiko-outbox-231527@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 11/18] drm/bridge: inno-hdmi: Make the PHY
 configuration table optional
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261124-jh7110-clean-send-v8-11-de92635dd857@samsung.com>
References: <20261124-jh7110-clean-send-v8-0-de92635dd857@samsung.com>
 <CGME20261124155419eucas1p1be4546e9ca9aa75f3f98c9a63d7e8ae6@eucas1p1.samsung.com>
 <20261124-jh7110-clean-send-v8-11-de92635dd857@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 16:05:47 +0000
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
- [Medium] drm/bridge: inno-hdmi: unguarded integrated-PHY writes when
  phy_configs is NULL
--

commit 564121a85c49ce8805925601abb5a8678ff40505
Author: Michal Wilczynski <m.wilczynski@samsung.com>

drm/bridge: inno-hdmi: Make the PHY configuration table optional

This commit allows platforms with an external PHY to omit the integrated
PHY configuration table and skips the table lookup and PHY register writes
in inno_hdmi_power_up() and inno_hdmi_bridge_mode_valid() when the table
is absent.

> diff --git a/drivers/gpu/drm/bridge/inno-hdmi.c b/drivers/gpu/drm/bridge/=
inno-hdmi.c
> index 0932ec47f151b..19cea14d14266 100644
> --- a/drivers/gpu/drm/bridge/inno-hdmi.c
> +++ b/drivers/gpu/drm/bridge/inno-hdmi.c
> @@ -533,8 +533,14 @@ static void inno_hdmi_power_up(struct inno_hdmi *hdm=
i,
>  			       unsigned long mpixelclock)
>  {
>  	struct inno_hdmi_phy_config *phy_config;
> -	int ret =3D inno_hdmi_find_phy_config(hdmi, mpixelclock);
> +	int ret;
> +
> +	inno_hdmi_sys_power(hdmi, false);
> +
> +	if (!hdmi->plat_data->phy_configs)
> +		goto out;
> =20
> +	ret =3D inno_hdmi_find_phy_config(hdmi, mpixelclock);
>  	if (ret < 0) {
>  		phy_config =3D hdmi->plat_data->default_phy_config;
>  		DRM_DEV_ERROR(hdmi->dev,
> @@ -544,8 +550,6 @@ static void inno_hdmi_power_up(struct inno_hdmi *hdmi,
>  		phy_config =3D &hdmi->plat_data->phy_configs[ret];
>  	}
> =20
> -	inno_hdmi_sys_power(hdmi, false);
> -
>  	hdmi_writeb(hdmi, HDMI_PHY_PRE_EMPHASIS, phy_config->pre_emphasis);
>  	hdmi_writeb(hdmi, HDMI_PHY_DRIVER, phy_config->voltage_level_control);
>  	hdmi_writeb(hdmi, HDMI_PHY_SYS_CTL, 0x15);
> @@ -555,6 +559,7 @@ static void inno_hdmi_power_up(struct inno_hdmi *hdmi,
>  	hdmi_writeb(hdmi, HDMI_PHY_SYNC, 0x00);
>  	hdmi_writeb(hdmi, HDMI_PHY_SYNC, 0x01);
> =20
> +out:
>  	inno_hdmi_sys_power(hdmi, true);
>  };

[Severity: Medium]
Should inno_hdmi_standby() and inno_hdmi_config_video_timing() also skip
writing to the integrated PHY registers when hdmi->plat_data->phy_configs
is NULL?

While inno_hdmi_power_up() skips HDMI_PHY_DRIVER, HDMI_PHY_PRE_EMPHASIS,
HDMI_PHY_CHG_PWR, and HDMI_PHY_SYS_CTL, inno_hdmi_standby() still writes
to those same four registers during probe and bridge disable:

drivers/gpu/drm/bridge/inno-hdmi.c:inno_hdmi_standby() {
	inno_hdmi_sys_power(hdmi, false);

	hdmi_writeb(hdmi, HDMI_PHY_DRIVER, 0x00);
	hdmi_writeb(hdmi, HDMI_PHY_PRE_EMPHASIS, 0x00);
	hdmi_writeb(hdmi, HDMI_PHY_CHG_PWR, 0x00);
	hdmi_writeb(hdmi, HDMI_PHY_SYS_CTL, 0x15);
}

Similarly, inno_hdmi_config_video_timing() still writes to
HDMI_PHY_PRE_DIV_RATIO, HDMI_PHY_FEEDBACK_DIV_RATIO_LOW, and
HDMI_PHY_FEEDBACK_DIV_RATIO_HIGH on every modeset. If those integrated PHY
registers do not exist on platforms with a separate PHY, or if any of
offsets 0xe0..0xe3 decode to hardware state, inno_hdmi_standby() clears
them and inno_hdmi_power_up() no longer restores them.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-jh7110-cle=
an-send-v8-0-de92635dd857@samsung.com?part=3D11
