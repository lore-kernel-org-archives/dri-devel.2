Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B60D2C5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:44:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF2E510E758;
	Mon, 24 Aug 2026 11:44:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FoJ/GwLC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9998210E758
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:44:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 63628401FA;
 Mon, 24 Aug 2026 11:44:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128B01F00A3D;
 Mon, 24 Aug 2026 11:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787571842;
 bh=FNjUI1xb/mI1XLPALLA6UhvSP4BLItEmo52d5RUEXzo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FoJ/GwLChuqQmg1pbQqmhgSnU1YW5zfUgBDDZDI5b4p/LX8vapXV7CYT2CD1rCHUn
 N1juf8sGEzxcy6zUHJhnlJ3eqElMDzDWXUsAJeQA8UxT5S4LwD/4WE8+UzwmrdWFbm
 nCyXqj+bxS1K8XrQf0Vq9H/LX8CPW2Z6XknoLQU7R4wswBi+Wy67MsJehSiFjyMq/a
 nlFwl0N91WvQjYM6PWBsSMHVJVoUgv93Due7b8Ilu+w3H91HMSp7zt7nCq6NJOdjjy
 x3llgHbkYOJhxjC1ikYTqKjrkb1nLhEY5eB8HoGv5vMDf76ZL+UUr5G7f8djFlNXtx
 NrN1qzoEFQilg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] phy: qcom: qmp-combo: delay Type-C mux switch while
 DP PHY is initializing
To: "Saurabh Anand" <saurabh.anand@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, vkoul@kernel.org,
 neil.armstrong@linaro.org, linux-phy@lists.infradead.org, olteanv@gmail.com
In-Reply-To: <20260824-qcom-dp-typec-reconnect-fixes-v1-1-2825e5bf8a96@oss.qualcomm.com>
References: <20260824-qcom-dp-typec-reconnect-fixes-v1-0-2825e5bf8a96@oss.qualcomm.com>
 <20260824-qcom-dp-typec-reconnect-fixes-v1-1-2825e5bf8a96@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 11:44:01 +0000
Message-Id: <20260824114402.128B01F00A3D@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete fix for DP PHY state corruption during Type-C orientati=
on changes.
- [High] Type-C mux state updates are silently dropped when DP PHY is activ=
e, breaking dynamic pin assignment.
- [High] Integer underflow of `usb_init_count` breaks USB PHY state trackin=
g.
--

--- Patch [1]: [PATCH 1/4] phy: qcom: qmp-combo: delay Type-C mux switch wh=
ile DP PHY is initializing ---
commit 35456fff470c94d1e75b9f16c438e1e8cf5df40f
Author: Saurabh Anand <saurabh.anand@oss.qualcomm.com>

phy: qcom: qmp-combo: delay Type-C mux switch while DP PHY is initializing

This commit extends the Type-C mux switch guard to check dp_init_count in
addition to dp_powered_on. This prevents a race window during DP PHY
initialization where a Type-C orientation change could corrupt the PHY stat=
e.

> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qual=
comm/phy-qcom-qmp-combo.c
> index c39ced168d035..f23aff79ca08f 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> @@ -4842,7 +4842,8 @@ static int qmp_combo_typec_mux_set(struct typec_mux=
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
This is a pre-existing issue, but does this early return cause the driver to
silently drop legitimate mux state updates?

When the Type-C framework negotiates a dynamic pin assignment and calls
qmp_combo_typec_mux_set(), returning 0 here without saving the requested
mode to qmp->qmpphy_mode or queuing it means the hardware could remain
stuck in the old lane configuration, causing subsequent DRM link
retraining to fail.

[Severity: High]
This is a pre-existing issue, but is a similar guard needed in
qmp_combo_typec_switch_set()?

The current patch fixes the race in qmp_combo_typec_mux_set(), but a
Type-C orientation change also triggers qmp_combo_typec_switch_set().
If DP is active or initializing, qmp_combo_typec_switch_set() forcefully
resets the COM block:

drivers/phy/qualcomm/phy-qcom-qmp-combo.c:qmp_combo_typec_switch_set() {
        ...
        qmp_combo_com_exit(qmp, true);
        qmp_combo_com_init(qmp, true);
        ...
}

Does this hardware reset wipe out the DP PHY lane and link rate
configurations applied by qmp_combo_dp_power_on(), leaving the
software state (dp_powered_on) desynchronized from the hardware?

[Severity: High]
This is a pre-existing issue, but is there a risk of an integer
underflow with usb_init_count if the USB subsystem also decrements it?

When the Type-C mux switches to QMPPHY_MODE_DP_ONLY,
qmp_combo_typec_mux_set() manually decrements the counter:

drivers/phy/qualcomm/phy-qcom-qmp-combo.c:qmp_combo_typec_mux_set() {
        ...
        if (qmp->usb_init_count)
                qmp->usb_init_count--;
        ...
}

If the USB controller later undergoes a suspend or role switch and
calls phy_exit(), qmp_combo_usb_exit() will decrement it again:

drivers/phy/qualcomm/phy-qcom-qmp-combo.c:qmp_combo_usb_exit() {
        ...
        qmp->usb_init_count--;
        ...
}

Could this underflow usb_init_count to UINT_MAX, causing a subsequent
Type-C orientation flip to fail to power the USB PHY back on?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824-qcom-dp-ty=
pec-reconnect-fixes-v1-0-2825e5bf8a96@oss.qualcomm.com?part=3D1
