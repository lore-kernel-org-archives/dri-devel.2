Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94943C53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 18:34:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED2C210E9C9;
	Tue, 28 Jul 2026 18:34:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WrBVrJ+T";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CFE910E9C2
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 18:34:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A93B960AA8;
 Tue, 28 Jul 2026 18:34:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 112AB1F00A3A;
 Tue, 28 Jul 2026 18:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785263652;
 bh=KUnYNM4EcT1EcztmtmOsGV/aFPsN8JQgJ+zixAcde54=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WrBVrJ+TmQED8PSIHVdqHZo7qWsmQyzWKvflOFEsd4KXlh0+t6HljlpjwnXOW/zWr
 iVrPQez2w4nhVkSDSpxtzqU0qi1PF3J+PIkTyNplzgNEVRtlryA/3LhBmDAGebo5cB
 7XIiddZ/ow8puVbxmi5etWm+dPHvzrV/PoX1JpZhPC1KRqm5C1CXluGa3Khc0ZILCK
 d8CtZ0Tm7QD2sc7g+3VzqIoojnhJcL+5BL9RQ73Urd+kKQ88jC61xVaSQSjyk7NYfU
 +EGrFmcsHHMiRNXImVXvoWYAQR1/2LYa+Vu0do3Ij5Um0sEVfJnw1NHFxJhYPOd8Zv
 hF5sIbuGK4ZEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 04/18] drm/bridge: synopsys: dw-dp: Add missing
 reinit_completion
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260728-synopsys-dw-dp-improvements-v7-4-b7640fa8cf48@collabora.com>
References: <20260728-synopsys-dw-dp-improvements-v7-0-b7640fa8cf48@collabora.com>
 <20260728-synopsys-dw-dp-improvements-v7-4-b7640fa8cf48@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 18:34:11 +0000
Message-Id: <20260728183412.112AB1F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] The addition of `reinit_completion()` introduces a data race on `c=
omplete.done` and incorrectly mitigates spurious IRQs, causing a TOCTOU win=
dow due to threaded IRQ scheduling delays.

Pre-existing issues:
- [High] Lifecycle ordering bug: the AUX I2C interface is exposed to usersp=
ace before hardware is initialized, and unregistered after hardware is torn=
 down.
- [High] A divide-by-zero vulnerability exists in dw_dp_video_enable when p=
rocessing a display mode with a clock value of 1.
- [High] I2C-over-AUX reply status (NACK/DEFER) is silently discarded, caus=
ing deferred I2C transactions to falsely succeed and return garbage data.
- [High] dw_dp_aux_transfer improperly rejects short AUX reads by returning=
 -EBUSY.
- [High] dw_dp_aux_transfer accesses the AUX hardware without ensuring the =
PHY is powered on.
--

--- Patch [4]: [PATCH v7 04/18] drm/bridge: synopsys: dw-dp: Add missing re=
init_completion ---
commit e066df83b1559151eb45281e1a32fbe600503fc1
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/bridge: synopsys: dw-dp: Add missing reinit_completion

The DP AUX transfer method uses a completion triggered by an interrupt,
which can timeout. If the function runs into the timeout and the
interrupt fires afterwards, the following DP aux transfer completion
would trigger immediately without waiting for the interrupt. This in
turn means the next one would also be broken and so on.

Fix this potential issue by re-initializing the completion before
sending the AUX command.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> index ca7ff544d243a..951f1e280e478 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> @@ -1465,6 +1465,8 @@ static ssize_t dw_dp_aux_transfer(struct drm_dp_aux=
 *aux,
>  	if (WARN_ON(msg->size > 16))
>  		return -E2BIG;
> =20
> +	reinit_completion(&dp->complete);
> +

[Severity: High]
Does this lockless modification of the completion state race with the
threaded interrupt handler?

If an AUX transfer times out, an AUX_REPLY_EVENT interrupt follows, and
Linux schedules the threaded IRQ handler. If a new AUX transfer is initiated
concurrently, it will call reinit_completion() and start the hardware.

The delayed IRQ handler might then execute:

dw_dp_irq() {
    ...
    complete(&dp->complete);
}

Could this immediately satisfy the wait for the new transfer before the
hardware finishes, causing the new transfer to proceed with a stale or
intermediate status? Should we drain or synchronize with the IRQ thread
before issuing a new hardware command?

[Severity: High]
This is a pre-existing issue, but does dw_dp_aux_transfer() access the AUX
hardware without ensuring the PHY is powered on?

Later in dw_dp_aux_transfer():

dw_dp_aux_transfer() {
    ...
    regmap_write(dp->regmap, DW_DP_AUX_CMD, value);
    status =3D wait_for_completion_timeout(&dp->complete, timeout);
}

If userspace tools query an inactive monitor while the PHY is powered off,
could these hardware register writes cause timeouts or bus hangs? Should
there be a phy_power_on() block surrounding this transfer?

[Severity: High]
This is a pre-existing issue, but are we silently discarding the
I2C-over-AUX reply status?

Also in dw_dp_aux_transfer():

dw_dp_aux_transfer() {
    ...
    msg->reply =3D FIELD_GET(AUX_STATUS, value);
}

Because AUX_STATUS masks bits 7..4 and shifts them down, the resulting
value lacks the original bits 4 and 5. The DRM core mask
DP_AUX_I2C_REPLY_MASK expects these bits in their original positions.

Since the value will be at most 0xF, applying the 0x30 mask will extract 0
(DP_AUX_I2C_REPLY_ACK). Does this cause deferred I2C transactions or NACKs
to falsely succeed and return garbage data?

[Severity: High]
This is a pre-existing issue, but does dw_dp_aux_transfer() improperly
reject short reads?

dw_dp_aux_transfer() {
    ...
    if (count !=3D msg->size)
        return -EBUSY;
}

If a DP sink returns fewer bytes than requested, the DRM DP helper expects
the actual number of bytes transferred so it can adjust the offset. By
returning -EBUSY, drm_dp_i2c_do_msg() will retry the exact same sized
transfer instead. Could this cause a complete failure to read EDID data
from sinks that restrict reply lengths?

[Severity: High]
This is a pre-existing issue, but does the driver expose the AUX I2C
interface to userspace before the hardware is fully initialized?

Looking at dw_dp_bind(), it registers the interface:

dw_dp_bind() {
    ...
    ret =3D drm_dp_aux_register(&dp->aux);
}

If userspace opens the device node and issues an ioctl before phy_init() is
called, could this lead to bus hangs or synchronous aborts when accessing
uninitialized DP registers?

Similarly, dw_dp_unbind() unregisters the AUX interface after the hardware
is torn down:

dw_dp_unbind() {
    ...
    phy_exit(dp->phy);
    drm_dp_aux_unregister(&dp->aux);
}

[Severity: High]
This is a pre-existing issue, but is there a potential divide-by-zero here?

In dw_dp_video_enable(), when configuring the threshold:

dw_dp_video_enable() {
    ...
    if (color_format =3D=3D DRM_OUTPUT_COLOR_FORMAT_YCBCR420)
        t2 =3D (link->rate / 4) * 1000 / (mode->clock / 2);
}

If a local user configures a custom DRM mode with a clock value of 1,
(mode->clock / 2) evaluates to 0. Since drm_mode_convert_umode() does not
reject clock values of 1, could this trigger a kernel panic?

>  	switch (msg->request & ~DP_AUX_I2C_MOT) {
>  	case DP_AUX_NATIVE_WRITE:
>  	case DP_AUX_I2C_WRITE:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728-synopsys-d=
w-dp-improvements-v7-0-b7640fa8cf48@collabora.com?part=3D4
