Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE41606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 15:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g6rg1+C7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 313FB10EA71;
	Fri,  6 Nov 2026 15:17:47 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2923D10FA9A
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 15:17:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 66FEA60202;
 Fri,  6 Nov 2026 15:17:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D96AF1F0089F;
 Fri,  6 Nov 2026 15:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793978259;
 bh=p/nuiejwzbuNdqG1S7CYo8b06UygXGfd6lMUU+TvJvo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=g6rg1+C705WrADK4VZpmsTxg2hbdaMPKfU1OemL6+WzzquzZCMBlbCq8NvfO8CedX
 Ey19DQPEYK0F0AE7EL7mwUz13FW9/b3vqFnhOCk6khnDIBkqN2m3LTP1JjLGRnNhti
 vMaQ0wZlydG8wcR6QajoPGB2HHs1BjhkcR5ew8epf5jxJUlUOr3UJdLUnAflvq63/Y
 OT7FFaJgXd40b2pO2fusQUv9yYKfUNAce1Qc8vT0x5Byw34VvDFctrm/hRQlrcQC/b
 pNCroRqvrodiruvJRdOxmVlVjwAq+6kJYwA1Pk+xnheiTCMqsxaUKetjHI/A29xKKY
 P/r4idWynl9ow==
Message-ID: <sashiko-outbox-201655@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 12/19] drm/bridge: inno-hdmi: Make the PHY
 configuration table optional
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261106-jh7110-clean-send-v7-12-68f7ea9913db@samsung.com>
References: <20261106-jh7110-clean-send-v7-0-68f7ea9913db@samsung.com>
 <CGME20261106135912eucas1p182016acc39d162adfbb9cb598ed7ca1c@eucas1p1.samsung.com>
 <20261106-jh7110-clean-send-v7-12-68f7ea9913db@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 15:17:38 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/bridge: inno-hdmi: unguarded integrated-PHY writes when
  phy_configs is NULL
--

commit f1f2bae7d85c6c615ff85796724277a1cd86c36d
Author: Michal Wilczynski <m.wilczynski@samsung.com>

drm/bridge: inno-hdmi: Make the PHY configuration table optional

This commit makes plat_data->phy_configs optional so platforms with a
separate PHY device skip the integrated-PHY register writes in
inno_hdmi_power_up() and the table lookup in inno_hdmi_bridge_mode_valid().

> diff --git a/drivers/gpu/drm/bridge/inno-hdmi.c b/drivers/gpu/drm/bridge/=
inno-hdmi.c
> index 3219558d6ef41..84d00ee52b732 100644
> --- a/drivers/gpu/drm/bridge/inno-hdmi.c
> +++ b/drivers/gpu/drm/bridge/inno-hdmi.c
> @@ -534,8 +534,14 @@ static void inno_hdmi_power_up(struct inno_hdmi *hdm=
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

[Severity: Medium]
Should inno_hdmi_standby() and inno_hdmi_config_video_timing() also skip
the integrated-PHY register writes when hdmi->plat_data->phy_configs is
NULL?

inno_hdmi_standby() (called from inno_hdmi_init_hw() at probe and
inno_hdmi_bridge_atomic_disable() on disable) still unconditionally writes
to the same HDMI_PHY_DRIVER, HDMI_PHY_PRE_EMPHASIS, HDMI_PHY_CHG_PWR, and
HDMI_PHY_SYS_CTL registers that inno_hdmi_power_up() now skips restoring.
inno_hdmi_config_video_timing() likewise still writes to
HDMI_PHY_PRE_DIV_RATIO, HDMI_PHY_FEEDBACK_DIV_RATIO_LOW, and
HDMI_PHY_FEEDBACK_DIV_RATIO_HIGH on modeset.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-jh7110-cle=
an-send-v7-0-68f7ea9913db@samsung.com?part=3D12
