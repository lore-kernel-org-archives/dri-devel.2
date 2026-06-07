Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A48CD8C90
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 21:46:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A0B510E5D1;
	Sun,  7 Jun 2026 21:46:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nVyz6cIr";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D65C10E5D1
 for <dri-devel@lists.freedesktop.org>; Sun,  7 Jun 2026 21:46:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E0AE1438BC;
 Sun,  7 Jun 2026 21:46:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9586A1F00893;
 Sun,  7 Jun 2026 21:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780868781;
 bh=VuceHPGmD7/jwC2bCg00E7SabTG0OPATM0gRk6Fs8Io=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nVyz6cIrQS2KMGoOeFSUV2sWnaXTt1tWpgIAxbR5XyT631FTwYxH6zaWXjQGmf7Zn
 d22Wjw9zBt1OPJote7m6yyv827GWjbfogQgeVs78UfIpx4IJmU6zEYUv9JYRtAxOAN
 akF+wwrs8MlCBq47d8tCYGnU4mcIheekToomamgAmeI77tQCkIAPDKMoqWa/sAK8ar
 HsSQ6gngdM03XIsE58u/l1zw6JhQyJktlRnr9oBS8alYnac0TW5uJoBS8or1+XykRI
 xus6UmsK40kt4PfOJhJZ5DcsXXDeNM5BVM/j2KmB6F4H/KXJFIcMW6mbOgNVeXqlrS
 mZfWnVmBEUMag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 8/8] usb: typec: ucsi: huawei-gaokun: pass down
 HPD_IRQ events
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-amlogic@lists.infradead.org, neil.armstrong@linaro.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260608-hpd-irq-events-v4-8-30b62b335487@oss.qualcomm.com>
References: <20260608-hpd-irq-events-v4-8-30b62b335487@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 21:46:21 +0000
Message-Id: <20260607214621.9586A1F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Early return misses EC hardware acknowledgement, potentially causi=
ng an interrupt storm.
- [High] Deadlock between EC threaded IRQ handler and UCSI notifier causing=
 inevitable timeout.
- [High] Out-of-bounds array access due to dynamic `num_ports` update surpa=
ssing allocated size.
- [Medium] Undefined Behavior due to shift operation with negative exponent.
--

commit 73f2964a00c46ffc80bf958e8a195aee63f9493d
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

usb: typec: ucsi: huawei-gaokun: pass down HPD_IRQ events

Pass IRQ_HPD events from the EC to the HPD bridge, letting those
to be delivered to the DisplayPort driver.

> diff --git a/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c b/drivers/usb/ty=
pec/ucsi/ucsi_huawei_gaokun.c
> --- a/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
> +++ b/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
> @@ -299,10 +299,13 @@ static void gaokun_ucsi_handle_altmode(struct gaoku=
n_ucsi_port *port)

[ ... ]

>  	/* UCSI callback .connector_status() have set orientation */
>  	if (port->bridge)
> -		drm_aux_hpd_bridge_notify(&port->bridge->dev,
> -					  port->hpd_state ?
> -					  connector_status_connected :
> -					  connector_status_disconnected);
> +		drm_aux_hpd_bridge_notify_extra(&port->bridge->dev,
> +						port->hpd_state ?
> +						connector_status_connected :
> +						connector_status_disconnected,
> +						port->hpd_irq ?
> +						DRM_CONNECTOR_DP_IRQ_HPD :
> +						DRM_CONNECTOR_NO_EXTRA_STATUS);
> =20
>  	gaokun_ec_ucsi_pan_ack(uec->ec, port->idx);

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential
issue in gaokun_ucsi_handle_altmode() regarding the early return.

If an EC event has a port index that surpasses the UCSI capability connector
bounds, the function warns and returns early.

Because the event has already been consumed by the hardware, does skipping
the gaokun_ec_ucsi_pan_ack() call here cause the EC firmware to infinitely
resend the interrupt or stall subsequent operations?

[Severity: Medium]
This is a pre-existing issue, but looking at the gaokun_ec_ucsi_pan_ack()
call at the end of this function:

drivers/platform/arm64/huawei-gaokun-ec.c:gaokun_ec_ucsi_pan_ack() {
    ...
    u8 data =3D 1 << port_id;

    if (port_id =3D=3D GAOKUN_UCSI_NO_PORT_UPDATE)
        data =3D 0;
    ...
}

When gaokun_ucsi_altmode_notify_ind() explicitly calls this with
GAOKUN_UCSI_NO_PORT_UPDATE (which equals -1), the shift operation
evaluates unconditionally before the safety check.

Does this cause undefined behavior by shifting with a negative exponent?

>  }

[Severity: High]
This is another pre-existing issue, but I noticed a potential deadlock
between the EC threaded IRQ handler and the UCSI notifier.

If the shared gaokun_ec_irq_handler() invokes gaokun_ucsi_notify() through
the blocking notifier, it can call gaokun_ucsi_handle_no_usb_event() which
waits on a completion:

drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c:gaokun_ucsi_handle_no_usb_event=
() {
    if (!wait_for_completion_timeout(&port->usb_ack, 2 * HZ)) {
        ...
    }
}

Since the single EC event thread is blocked inside the notifier chain waiti=
ng
for this completion, does this prevent the system from extracting the
upcoming EC_EVENT_USB to trigger the completion, imposing a guaranteed
timeout delay?

[Severity: High]
This isn't a bug introduced by this patch, but there might be an
out-of-bounds array access in gaokun_ucsi_refresh() when updating port
data.

During initialization, the uec->ports array is allocated based on the
initial number of ports:

drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c:gaokun_ucsi_ports_init() {
    uec->ports =3D devm_kcalloc(dev, num_ports, sizeof(*uec->ports),
                              GFP_KERNEL);
    ...
}

In gaokun_ucsi_refresh(), when an interrupt occurs, it reads the new limit
and uses it:

drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c:gaokun_ucsi_refresh() {
    uec->num_ports =3D ureg.num_ports;
    ...
    gaokun_ucsi_port_update(&uec->ports[idx], ureg.port_data);
}

If the EC dynamically reports a larger number of ports than the original
allocation, does this bypass the boundary check and overwrite unallocated
memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-hpd-irq-ev=
ents-v4-0-30b62b335487@oss.qualcomm.com?part=3D8
