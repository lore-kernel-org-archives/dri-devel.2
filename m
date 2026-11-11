Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED45606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 11:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IkQXCnRw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B9C810FADA;
	Wed, 11 Nov 2026 11:03:59 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3643510FADA
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 11:03:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5302063BC7;
 Wed, 11 Nov 2026 11:03:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B42671F00A05;
 Wed, 11 Nov 2026 11:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794395032;
 bh=KqBFL7Ix6GHgsHw2p6gDHfdCLUWUgkEp8o91cTzPD+Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IkQXCnRwcCSgMdO6qrqylEuXODfdZqhz1z/LpcdoMnFIgNQ10U7+jR+tyzntPTmIQ
 eiR2tsO+FdSK5rpEzVw6dvo3LIF1TxvfiEba3n4LK3iGqoh13dcEfedU9VYg3lDotr
 Ih4PEzeK0oOXf1fP6TU5fe/A6jEEr+6HKyHLpEzfrCDTW0MNKn5gJvikV0PQCmr8KK
 NwRN5Amsf5UfY1rFWidPH95t48ABR5+P2zkwni1xAT3gOCO8F1rVirpfRblopuMEcj
 sEjH3dUx3/9Scu/Hc+IyrfahWNIH4n9BMLMfVB28CZEiW+q5xUMmXbyeWwW7KzHm2w
 HVWctWGoLeEqg==
Message-ID: <sashiko-outbox-208844@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] phy: qcom: qmp-combo: delay Type-C mux switch
 while DP PHY is initializing
To: "naidu nama" <naidu.nama@oss.qualcomm.com>
Cc: linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org,
 vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com
In-Reply-To: <20261111104434.2222182-2-naidu.nama@oss.qualcomm.com>
References: <20261111104434.2222182-1-naidu.nama@oss.qualcomm.com>
 <20261111104434.2222182-2-naidu.nama@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 11:03:51 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] phy: qcom: qmp-combo: qmp_combo_typec_mux_set() drops valid
  mode switches
- [Medium] phy: qcom: qmp-combo: commit message confuses orientation and
  mode callbacks
--

commit de650bdad284e255575480f09852006eb78a904a
Author: Saurabh Anand <saurabh.anand@oss.qualcomm.com>

phy: qcom: qmp-combo: delay Type-C mux switch while DP PHY is initializing

This commit extends the guard in qmp_combo_typec_mux_set() to return early
when qmp->dp_init_count is non-zero.

> The Type-C mux switch guard only checked dp_powered_on, which is set in
> qmp_combo_dp_power_on(). However there is a race window between
> qmp_combo_dp_init() and qmp_combo_dp_power_on() during which dp_init_count
> is non-zero but dp_powered_on is still false. A Type-C orientation change
> arriving in this window would proceed with the mux switch while the DP PHY
> is mid-initialization, corrupting the PHY state.

[Severity: Medium]
Does the commit message confuse Type-C orientation changes with mode
changes?

Type-C orientation changes are handled by qmp_combo_typec_switch_set(),
which does not check qmp->dp_powered_on or qmp->dp_init_count before
resetting the common block.  qmp_combo_typec_mux_set() only handles
Type-C mode and SVID transitions.

> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qual=
comm/phy-qcom-qmp-combo.c
> index 61d8b7a5ce8f9..3f93043f94e5c 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> @@ -5163,7 +5163,8 @@ static int qmp_combo_typec_mux_set(struct typec_mux=
_dev *mux, struct typec_mux_s
>  		return 0;
>  	}
> =20
> -	if (qmp->qmpphy_mode !=3D QMPPHY_MODE_USB3_ONLY && qmp->dp_powered_on) {
> +	if (qmp->qmpphy_mode !=3D QMPPHY_MODE_USB3_ONLY &&
> +	    (qmp->dp_powered_on || qmp->dp_init_count)) {
>  		dev_dbg(qmp->dev, "typec_mux_set: DP PHY is still in use, delaying swi=
tch\n");
>  		return 0;
>  	}

[Severity: High]
Does bailing out when qmp->dp_init_count is non-zero cause regression by
dropping valid Type-C mode switches?

qmp_combo_typec_mux_set() discards new_mode on this path and nothing
replays it when the DP PHY later exits.  Meanwhile,
qmp_combo_reconfigure_phy() already handles reconfiguring the PHY while
qmp->dp_init_count is non-zero and qmp->dp_powered_on is false by powering
down DP AUX, resetting COM with new_mode, and re-running
qmp->cfg->dp_aux_init(qmp):

drivers/phy/qualcomm/phy-qcom-qmp-combo.c:qmp_combo_reconfigure_phy() {
	...
	if (qmp->dp_init_count)
		writel(DP_PHY_PD_CTL_PSR_PWRDN, qmp->dp_dp_phy + QSERDES_DP_PHY_PD_CTL);

	qmp_combo_com_exit(qmp, true);

	qmp->qmpphy_mode =3D new_mode;

	/* Now everything's powered down, power up the right PHYs */
	qmp_combo_com_init(qmp, true);

	if ((qmp->usb_init_count || qmp->usb4_init_count) &&
	    new_mode !=3D QMPPHY_MODE_DP_ONLY)
		qmp_combo_usb_power_on(qmp->usb_phy);

	if ((new_mode =3D=3D QMPPHY_MODE_USB3DP || new_mode =3D=3D QMPPHY_MODE_DP_=
ONLY) &&
	    qmp->dp_init_count)
		qmp->cfg->dp_aux_init(qmp);
}

During 4-lane DisplayPort Altmode entry, dp_altmode_configured() signals
drm_connector_oob_hotplug_event() before calling dp_altmode_notify() ->
typec_mux_set().  The hotplug event synchronously runs
msm_dp_hpd_plug_handle() -> phy_init(), setting qmp->dp_init_count =3D 1
while qmp->qmpphy_mode is QMPPHY_MODE_USB3DP.  When typec_mux_set() then
requests QMPPHY_MODE_DP_ONLY, this guard drops the switch and leaves 4-lane
DP broken.

Similarly, on cable unplug in pmic_glink_altmode_worker(),
pmic_glink_altmode_safe() calls typec_mux_set() before
drm_aux_hpd_bridge_notify() triggers phy_exit(), so the transition back to
QMPPHY_MODE_USB3_ONLY is also dropped.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111104434.2222=
182-1-naidu.nama@oss.qualcomm.com?part=3D1
