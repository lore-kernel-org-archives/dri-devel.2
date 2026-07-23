Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69831C531D0
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 22:32:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1D9110F240;
	Thu, 23 Jul 2026 22:32:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="E96NMRBT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66C7410F240
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 22:32:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6E7D360A5A;
 Thu, 23 Jul 2026 22:32:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D43A91F000E9;
 Thu, 23 Jul 2026 22:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784845943;
 bh=KlXtW69/ynJAJVl++17hBILv9XsuD02qUHSJeTdryoQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=E96NMRBTscSZEZ3+0eb4f8qYPZG7FpFhNcAsZTCsmd56+ngnV/xC2Q3j2N8qDXLMD
 77sPMY7kiAku6INe1ME1Qi02zUYmOb25FCnMTyqEpgnw9NDAKHlwaYp0vSBL+OhXaH
 5louxRIGUms9c3Oc5GG+z96+YTGOtOyZPJbSufC8dLqiHmjloZ3XQRfmFrTI7isusr
 SJIptpOaqrcwM0eyVLhLQn+V6/Fv83eDspVRLkItJxNxKL57XqModemsm7LZ19Dq1i
 P/prJIeUvf+jjfixly0DAo/Um+6akIiXLBS3pZeWqvhtbm2DMvn8dle0+kwy6E+lgV
 y+MrLd2TbHY/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/15] drm/bridge: synopsys: dw-dp: Cancel pending
 HPD work on unbind
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260724-synopsys-dw-dp-improvements-v5-2-9445c2e87441@collabora.com>
References: <20260724-synopsys-dw-dp-improvements-v5-0-9445c2e87441@collabora.com>
 <20260724-synopsys-dw-dp-improvements-v5-2-9445c2e87441@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 22:32:22 +0000
Message-Id: <20260723223222.D43A91F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] The completion `dp->complete` is not re-initialized before startin=
g a new AUX transfer, causing subsequent transfers to falsely complete imme=
diately if a previous transfer timed out.
- [High] The AUX read length calculation incorrectly subtracts 1 instead of=
 adding 1, causing all DP AUX reads to fail with `-EBUSY`.
--

--- Patch [2]: [PATCH v5 02/15] drm/bridge: synopsys: dw-dp: Cancel pending=
 HPD work on unbind ---
commit 7fd4acc667a3adf3c285f78c69b39dea1318c0a1
Author: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: drm/bridge: synopsys: dw-dp: Cancel pending HPD work on unbind

This commit fixes a race condition during device unbind where the HPD worker
thread might access invalid resources if started exactly when unbind happen=
s.
It avoids this by canceling any pending HPD work immediately after disabling
the interrupt.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> index 368e1f85e6253..21bd08571dcfe 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> @@ -2009,6 +2009,7 @@ EXPORT_SYMBOL_GPL(dw_dp_bind);
>  void dw_dp_unbind(struct dw_dp *dp)
>  {
>  	disable_irq(dp->irq);
> +	cancel_work_sync(&dp->hpd_work);
>  	phy_exit(dp->phy);
>  	drm_dp_aux_unregister(&dp->aux);
>  	drm_bridge_remove(&dp->bridge);

[Severity: High]
This isn't a bug introduced by this patch, but looking at dw_dp_aux_transfe=
r()
in drivers/gpu/drm/bridge/synopsys/dw-dp.c, it seems dp->complete is not
re-initialized before waiting for completion:

drivers/gpu/drm/bridge/synopsys/dw-dp.c:dw_dp_aux_transfer() {
    ...
    if (msg->size > 0)
        value =3D FIELD_PREP(AUX_LEN_REQ, msg->size - 1);
    ...
    regmap_write(dp->regmap, DW_DP_AUX_CMD, value);

    status =3D wait_for_completion_timeout(&dp->complete, timeout);
    ...
}

If a previous transfer timed out, the completion count would remain 0.
If the hardware eventually finishes and fires a late interrupt, the interru=
pt
handler could call complete(&dp->complete).

Could a subsequent call to dw_dp_aux_transfer() then falsely complete
immediately if wait_for_completion_timeout() consumes this stale completion?

Would adding a call to reinit_completion(&dp->complete) before writing the
command resolve this?

[Severity: High]
This is a pre-existing issue, but further down in dw_dp_aux_transfer(), is =
there
a logic error in the AUX read length calculation?

drivers/gpu/drm/bridge/synopsys/dw-dp.c:dw_dp_aux_transfer() {
    ...
    if (msg->size > 0 && msg->reply =3D=3D DP_AUX_NATIVE_REPLY_ACK) {
        if (msg->request & DP_AUX_I2C_READ) {
            size_t count =3D FIELD_GET(AUX_BYTES_READ, value) - 1;

            if (count !=3D msg->size)
                return -EBUSY;
    ...
}

Because 1 is subtracted from FIELD_GET(AUX_BYTES_READ, value) instead of be=
ing
added, count can never equal msg->size.

For example, if the hardware reports msg->size or msg->size - 1, subtractin=
g 1
guarantees count evaluates to either msg->size - 1 or msg->size - 2.

Does this cause all DP AUX reads to unconditionally fail with -EBUSY, break=
ing
EDID reading and link training?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724-synopsys-d=
w-dp-improvements-v5-0-9445c2e87441@collabora.com?part=3D2
