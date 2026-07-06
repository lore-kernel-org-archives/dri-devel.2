Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E1FCC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 09:43:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C36010E846;
	Mon,  6 Jul 2026 09:43:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HvIHF54C";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E99F710E846
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 09:43:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E667E60018;
 Mon,  6 Jul 2026 09:43:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E7B1F000E9;
 Mon,  6 Jul 2026 09:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783330997;
 bh=Y3Mg1O9XrrCW1PmILfZWCapMYSsLSpNEsEd8fuBm8yA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HvIHF54CF4v6RXAMpxvswY5aWmY2Uk6m9QmY7cm9ViFP4c0W7c3YuD/NbzLOLCekl
 mOCXzF3wPO1AqrsYSmCmVqMalOEf2x+secCAN9KD7lrdQlIag5kAl2fPdHWmytwcDs
 /tEnIswec9n9qgjw2gAGhW4C/avLTeILLUAAxxTcNQ2ObgjZT6N6AekizDL/pKQTI6
 1sdeMQCPWLEKSN5CwnBgoJV+mCju+v/B/RJvaVF6unJVM/5VioJOu4Lodu4nn57lnR
 3d4cgSGcq5p1dWHA5Q23CmqH2GB0DEhYWdDjounTCFUA9vrxYfaDYJbdDBAYvatNJO
 WSEuAQX+HeDYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amd/display: fix HDCP workqueue use-after-free on
 destroy
To: "Fan Wu" <fanwu01@zju.edu.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260706092417.2953792-1-fanwu01@zju.edu.cn>
References: <20260706092417.2953792-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 09:43:16 +0000
Message-Id: <20260706094317.26E7B1F000E9@smtp.kernel.org>
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
- [High] The patch adds a teardown flag to prevent internal requeuing of wo=
rks in `hdcp_destroy()`, but fails to prevent `cpirq_work` from being exter=
nally requeued by the HPD RX IRQ handler. During driver teardown, `hdcp_des=
troy()` frees `adev->dm.hdcp_workqueue`. However, `delayed_hpd_wq` and `hpd=
_rx_offload_wq` are not destroyed/flushed until later in `amdgpu_dm_fini()`=
. If the DP RX IRQ handler `handle_hpd_rx_irq()` runs concurrently on one o=
f these workqueues, it checks `adev->dm.hdcp_workqueue` locklessly, which m=
ay still be non-NULL. It then calls `hdcp_handle_cpirq()`, which executes `=
schedule_work()` on the already freed memory, causing workqueue corruption =
and a Use-After-Free.
- [High] Preexisting lockless access to the shared `hdcp_work->aconnector` =
array leads to a potential Use-After-Free. `event_property_update` fetches =
the `aconnector` pointer locklessly and dereferences it to read its status =
(`connector->status` and `aconnector->base.state`). Concurrently, a display=
 unplug event can trigger `hdcp_remove_display()`, which acquires the mutex=
, clears the array slot, and drops the DRM reference via `drm_connector_put=
()`. For dynamically managed MST connectors, dropping this reference can re=
sult in the memory being freed immediately. The locklessly executing `event=
_property_update` will then access the freed connector memory.
--

commit efb12556c957ec71a3ffe14ba50df873396200c3
Author: Fan Wu <fanwu01@zju.edu.cn>
Date:   Mon Jul 6 09:24:17 2026 +0000

    drm/amd/display: fix HDCP workqueue use-after-free on destroy

    This commit fixes a use-after-free issue during HDCP workqueue destruct=
ion.
    It adds a teardown flag to prevent internal callbacks from requeuing wo=
rk
    after the destruction process has started, and cancels all queued work
    synchronously before freeing the memory.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/dri=
vers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> index 039f6516085c8..b7219928d9052 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c

[ ... ]

> @@ -528,9 +531,21 @@ void hdcp_destroy(struct kobject *kobj, struct hdcp_=
workqueue *hdcp_work)
>  	int i =3D 0;
> =20
>  	for (i =3D 0; i < hdcp_work->max_link; i++) {
> +		/*
> +		 * process_output() can requeue the HDCP works. Set teardown
> +		 * under the callback mutex first so no callback can requeue
> +		 * work after destroy starts, then drain any work already
> +		 * queued.
> +		 */
> +		mutex_lock(&hdcp_work[i].mutex);
> +		hdcp_work[i].teardown =3D true;
> +		mutex_unlock(&hdcp_work[i].mutex);
> +
> +		cancel_work_sync(&hdcp_work[i].cpirq_work);

[Severity: High]
This is a pre-existing issue, but can the DP RX IRQ handler still queue
cpirq_work after this teardown flag is set?

During driver teardown, amdgpu_dm_fini() calls hdcp_destroy() and nullifies
adev->dm.hdcp_workqueue before delayed_hpd_wq and hpd_rx_offload_wq are
flushed. If the IRQ handler runs concurrently, it could read the workqueue
pointer locklessly and blindly queue work on the freed memory:

amdgpu_dm_irq.c:handle_hpd_rx_irq() {
    if (adev->dm.hdcp_workqueue)
        hdcp_handle_cpirq(adev->dm.hdcp_workqueue, ...);
}

amdgpu_dm_hdcp.c:hdcp_handle_cpirq() {
    schedule_work(&hdcp_w->cpirq_work);
}

Does hdcp_handle_cpirq() need to check the new teardown flag or take the
mutex before scheduling the work?

>  		cancel_delayed_work_sync(&hdcp_work[i].callback_dwork);
>  		cancel_delayed_work_sync(&hdcp_work[i].watchdog_timer_dwork);
>  		cancel_delayed_work_sync(&hdcp_work[i].property_validate_dwork);
> +		cancel_work_sync(&hdcp_work[i].property_update_work);

[Severity: High]
This is a pre-existing issue, but is there a race condition between
property_update_work and dynamic display unplug?

In event_property_update(), the connector is fetched locklessly from the
hdcp_work->aconnector array and dereferenced to read its status:

amdgpu_dm_hdcp.c:event_property_update() {
    aconnector =3D hdcp_work->aconnector[conn_index];
    if (!aconnector)
        continue;
    connector =3D &aconnector->base;
    if (connector->status !=3D connector_status_connected)
        continue;
}

Concurrently, a display unplug event might trigger hdcp_remove_display(),
which drops the DRM reference:

amdgpu_dm_hdcp.c:hdcp_remove_display() {
    if (hdcp_w->aconnector[conn_index]) {
        drm_connector_put(&hdcp_w->aconnector[conn_index]->base);
        hdcp_w->aconnector[conn_index] =3D NULL;
    }
}

If the connector memory is freed when the reference is dropped, could
event_property_update() access freed memory when it reads connector->status?

>  	}
> =20
>  	sysfs_remove_bin_file(kobj, &hdcp_work[0].attr);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706092417.2953=
792-1-fanwu01@zju.edu.cn?part=3D1
