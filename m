Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D3EC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 15:15:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9751010F457;
	Thu,  2 Jul 2026 15:15:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Rtj/HXIK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10F9910F457
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 15:15:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D6AD8411CF;
 Thu,  2 Jul 2026 15:15:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E14D1F000E9;
 Thu,  2 Jul 2026 15:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783005350;
 bh=cBtiecSpWEHkGClA8d3sH0mil7nTA0SRFAQYGr7pl1k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Rtj/HXIKlzEa7fPk41TggRLKD0tsCm5iHJA/ce1avH/YLC3w5j4tGKjLfkSwXOteU
 mGSsdPqpzwg5u0KdqFV83xrY4PkHPzw4Zxe7yvuLGuKhuHmQgUNhU6rTMxWnPjUrip
 WaFFIGM5i+iF7uFxA/qa4NDnh85iqqoWtGydU8o3WrwVPt003uultdheZWCpGtUSRA
 l31W1p5idO1uq2F009qV/Z5z0WjzuBWr/LUQwxGrLN62EtqFpJIuwlsXqmj9WliuMM
 PAUEvRWKTEyT94Z5jXua/vYt1S+cYQRwynJ+gUqOYfaeOme9EFtu0f9JDwmqWzvGl0
 aO+YVSOeCOZkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 27/39] drm/rockchip: dw_hdmi_qp: Use
 dw_hdmi_qp_hpd_notify() for HPD reports
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260702-dw-hdmi-qp-scramb-v8-27-d79890d00b6a@collabora.com>
References: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
 <20260702-dw-hdmi-qp-scramb-v8-27-d79890d00b6a@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 15:15:49 +0000
Message-Id: <20260702151550.8E14D1F000E9@smtp.kernel.org>
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

New issues:
- [High] Unprotected access to `hdmi->curr_conn` in `dw_hdmi_qp_hpd_notify(=
)` can lead to a TOCTOU NULL pointer dereference.

Pre-existing issues:
- [High] System PM suspend/resume callbacks unconditionally dereference `de=
v_get_drvdata()`, which can be NULL if component bind hasn't completed.
- [High] Missing `disable_irq()` in `unbind` allows the hotplug interrupt t=
o fire after the DRM master is unbound, leading to a Use-After-Free.
- [High] Using devm_* functions in component bind() ties resources to the p=
latform device's lifetime rather than the component's lifetime, causing res=
ource leaks and permanent bind failures on retries.
--

commit 71c4a3386d116454bc66b990f1d692e5daa00ba8
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: drm/rockchip: dw_hdmi_qp: Use dw_hdmi_qp_hpd_notify() for HPD repo=
rts

This commit updates the HPD reporting to notify only the affected connector
instead of polling all of them. It also ensures the detection context runs
on reconnect to properly recover the SCDC state.

> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu=
/drm/rockchip/dw_hdmi_qp-rockchip.c
> --- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c

[ ... ]

> @@ -354,14 +353,8 @@ static void dw_hdmi_qp_rk3588_hpd_work(struct work_s=
truct *work)
>  	struct rockchip_hdmi_qp *hdmi =3D container_of(work,
>  						     struct rockchip_hdmi_qp,
>  						     hpd_work.work);
> -	struct drm_device *drm =3D hdmi->encoder.encoder.dev;
> -	bool changed;
> =20
> -	if (drm) {
> -		changed =3D drm_helper_hpd_irq_event(drm);
> -		if (changed)
> -			dev_dbg(hdmi->dev, "connector status changed\n");
> -	}
> +	dw_hdmi_qp_hpd_notify(hdmi->hdmi);
>  }

[Severity: High]
Could this call introduce a time-of-check to time-of-use race condition?

In dw_hdmi_qp_hpd_notify(), we evaluate hdmi->curr_conn without locks:

	if (hdmi->curr_conn && status =3D=3D connector_status_connected)
		drm_connector_helper_hpd_irq_event(hdmi->curr_conn);

If a concurrent atomic modeset (triggered by userspace or hotplug) invokes
atomic_post_disable() between the condition evaluation and the dereference
in drm_connector_helper_hpd_irq_event(), hdmi->curr_conn could be set to
NULL.

A compiler might emit two separate memory reads here, which could lead
to passing a NULL pointer to the helper and causing a kernel crash.=20

Would it be better to use a local variable with READ_ONCE() to ensure the
pointer remains valid across the check and the call?

[ ... ]

> @@ -738,8 +731,7 @@ static int __maybe_unused dw_hdmi_qp_rockchip_resume(=
struct device *dev)
> =20
>  	dw_hdmi_qp_resume(dev, hdmi->hdmi);
> =20
> -	if (hdmi->encoder.encoder.dev)
> -		drm_helper_hpd_irq_event(hdmi->encoder.encoder.dev);
> +	dw_hdmi_qp_hpd_notify(hdmi->hdmi);
> =20
>  	return 0;
>  }

[Severity: High]
This is a pre-existing issue, but does this function safely handle a NULL
hdmi pointer?

The resume callback fetches the hdmi struct via dev_get_drvdata(dev).

However, if the system suspends before the component framework calls the
bind callback (for instance, during a deferred probe waiting for the VOP),
dev_get_drvdata() will return NULL.

Since dw_hdmi_qp_rockchip_resume() unconditionally accesses hdmi->ctrl_ops
and hdmi->hdmi, wouldn't this cause a kernel panic on system resume?

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for the
HPD interrupt to fire after the DRM master is unbound?

In dw_hdmi_qp_rockchip_unbind(), cancel_delayed_work_sync() is called,
but the IRQ itself is never disabled.=20

Because the IRQ was requested using devm_request_threaded_irq() on the
platform device, it remains active until the platform device itself
is removed.

If an HPD event occurs after the component unbinds (which frees the
drmm_kzalloc'd hdmi struct), the IRQ handler will schedule the HPD
work which accesses freed memory, leading to a use-after-free crash.

Should disable_irq() be called during unbind to prevent this?

[Severity: High]
This is a pre-existing issue, but are we at risk of leaking resources
and permanently failing initialization on bind retries?

In dw_hdmi_qp_rockchip_bind(), several devm_ functions like
devm_request_threaded_irq() and devm_clk_get() are used on the platform
device.

Because the component framework allows bind() to fail and be retried,
any failure mid-way through bind() means these resources are not freed,
as the platform device remains active.=20

On subsequent retries, devm_request_threaded_irq() will return -EBUSY,
permanently breaking the HDMI port initialization until the platform module
is unloaded.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-dw-hdmi-qp=
-scramb-v8-0-d79890d00b6a@collabora.com?part=3D27
