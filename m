Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 323A0C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 14:56:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C0B510E3B1;
	Mon,  6 Jul 2026 14:56:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="i6y/FVT1";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45BE110E3B1
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 14:56:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EB74E438CA;
 Mon,  6 Jul 2026 14:56:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF4A1F00A3A;
 Mon,  6 Jul 2026 14:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783349816;
 bh=RnUV+5JtK3IbjcIFiZiNvZB4i78USW5dvpi3K58oPIg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=i6y/FVT1PNLNmSVonW+crtYJwgfcA0Ol4cNW07SQNOoVmVa38WTdWdhHjvhoIMq9L
 FbDeEkDkiprIHrkW7L4/wVjxkwKNkvipufXWlpEZzzJy6hQDjG4y5Uip5rOOHbk5kj
 eKkVEUxTJgYatdPAbLjYMJNMQpLFLSBGjbkODA7sEkBIazG3VCYOZ0l3BFkIE+FMvL
 nIGik6I662pzoWYcLjw7mVpWBoi1pW9HNvS90+JyQfK4m+GnweOpTCuv8Hj/oLwLVF
 z1CE4DnornAs+POT9yM668bBW3XeRzU8XaNIOjT6fEMgVIOPUAUUQFZ+YiSaywGxVe
 QMGSQzKUjWjAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/amd/display: fix HDCP workqueue use-after-free
 on destroy
To: "Fan Wu" <fanwu01@zju.edu.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260706143548.136979-1-fanwu01@zju.edu.cn>
References: <20260706143548.136979-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 14:56:55 +0000
Message-Id: <20260706145656.ACF4A1F00A3A@smtp.kernel.org>
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
- [Critical] Out-of-bounds array access due to using DRM connector index in=
stead of hardware link index.
- [High] Lockless access to `hdcp_work->aconnector` leading to Use-After-Fr=
ee of a DRM connector.
- [High] Out-of-bounds array access on `hdcp_w->aconnector` using the unbou=
nded DRM connector index.
--

commit 378fa8b96a79b8b40551c4d1a03ff5b822a7c73b
Author: Fan Wu <fanwu01@zju.edu.cn>

drm/amd/display: fix HDCP workqueue use-after-free on destroy

hdcp_destroy() cancels callback_dwork, watchdog_timer_dwork and
property_validate_dwork, but leaves cpirq_work and property_update_work
queued. These works are queued with schedule_work(), recover struct
hdcp_workqueue through container_of(), and dereference it.

Cc: stable@vger.kernel.org

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/dri=
vers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> index 039f6516085c8..e060d45f8229b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c

[ ... ]

> @@ -361,7 +364,10 @@ void hdcp_handle_cpirq(struct hdcp_workqueue *hdcp_w=
ork, unsigned int link_index
>  {
>  	struct hdcp_workqueue *hdcp_w =3D &hdcp_work[link_index];

[Severity: Critical]
This isn't a bug introduced by this patch, but can this out-of-bounds array
access occur?

When a DisplayPort CP_IRQ occurs, handle_hpd_rx_irq() passes the global
DRM connector index instead of the physical link index:

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c:handle_hpd_rx_irq() {
    ...
    hdcp_handle_cpirq(adev->dm.hdcp_workqueue, aconnector->base.index);
    ...
}

Because base.index increments for dynamically created MST displays, it can
exceed max_links. Would this cause hdcp_work[link_index] to evaluate out of
bounds here?

> -	schedule_work(&hdcp_w->cpirq_work);
> +	mutex_lock(&hdcp_w->mutex);
> +	if (!hdcp_w->teardown)
> +		schedule_work(&hdcp_w->cpirq_work);
> +	mutex_unlock(&hdcp_w->mutex);
>  }

[ ... ]

[Severity: High]
This is a pre-existing issue, but does this lockless access risk a
use-after-free of the drm_connector?

In event_property_update(), the connector is accessed without holding
hdcp_work->mutex:

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c:event_property_updat=
e() {
    ...
    aconnector =3D hdcp_work->aconnector[conn_index];
    if (!aconnector)
        continue;
    connector =3D &aconnector->base;
    if (connector->status !=3D connector_status_connected)
    ...
}

If this races with hdcp_remove_display() which takes the mutex and drops
the connector reference:

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c:hdcp_remove_display(=
) {
    ...
    if (hdcp_w->aconnector[conn_index]) {
        drm_connector_put(&hdcp_w->aconnector[conn_index]->base);
        hdcp_w->aconnector[conn_index] =3D NULL;
    }
    ...
}

Could event_property_update() dereference a freed connector if it reads
the pointer just before hdcp_remove_display() runs?


[Severity: High]
This is a pre-existing issue, but does this code overflow the
hdcp_w->aconnector[] array?

Functions like hdcp_update_display() and hdcp_remove_display() use the
unbounded DRM connector index to access the array:

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c:hdcp_update_display(=
) {
    ...
    unsigned int conn_index =3D aconnector->base.index;
    ...
    hdcp_w->aconnector[conn_index] =3D aconnector;
    ...
}

Since hdcp_w->aconnector is hardcoded to AMDGPU_DM_MAX_DISPLAY_INDEX (31),
and DRM connector indices are allocated globally, could connecting a large
DisplayPort MST topology cause base.index to exceed 31 and overwrite
adjacent memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706143548.1369=
79-1-fanwu01@zju.edu.cn?part=3D1
