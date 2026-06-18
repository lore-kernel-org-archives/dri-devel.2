Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE72FCD98ED
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 17:01:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2085210EEB0;
	Thu, 18 Jun 2026 17:01:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EMarM7Gz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7C6710F389
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 17:01:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7107B443D7
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 17:01:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3882C1F00A3A;
 Thu, 18 Jun 2026 17:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781802092;
 bh=CsPJWM69j1PIdDJEwbWJM/c3bg8VV08SuITIZuosQX8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EMarM7GzxgFj1Fi7zJY6gBtpV2dw9HgGqiscfuC1k1XYmla4ZzMtYQ0nIZTiRzUvn
 7z2rw+0mp3LRcwOC6gsm+eucQi8XHlfVgTTxWJ1mQMlNeh27qih/2tvmt0XpL2Ui3C
 PGz/neGRa5WLdb/tkGFJ503nUYM9CyXjB5kpistkwmXAnpCtAQlxyMI81p08sx/3rV
 owFl8GXZHx+IWbG5+vnSIAZS20e1zWVhMV4AG2yxbKpyx1fI4yufk7aqOb4WSSn7xn
 k8UF/CtQxas9Zb5GkUsa9hAjV7QvIL1YDfrEN12xntg5btH3R8wR0P/zzvMJsQD1Mw
 rx2nGNDZtRpiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/amd/display: Shorten
 hdmi_frl_status_polling_workqueue
To: "Nathan Chancellor" <nathan@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260618-amdgpu-fix-wq_name_len-warning-v2-1-ef0e2e6f5be7@kernel.org>
References: <20260618-amdgpu-fix-wq_name_len-warning-v2-1-ef0e2e6f5be7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 17:01:31 +0000
Message-Id: <20260618170132.3882C1F00A3A@smtp.kernel.org>
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
- [High] Missing error handling for `hdmi_frl_status_polling_wq` allocation=
 failure allows initialization to continue, leading to a NULL pointer deref=
erence when the workqueue is used.
- [High] The `hdmi_frl_status_polling_wq` workqueue and its delayed work ar=
e never cleaned up, causing memory/thread leaks and potential use-after-fre=
e panics during driver unload.
- [High] The shared `dm->hdmi_frl_status_polling_work` is unconditionally r=
e-initialized for every connector, potentially corrupting active workqueue =
state and causing kernel panics.
--

commit e498c7d6a60373b991eca0c000447c24090d3740
Author: Nathan Chancellor <nathan@kernel.org>

drm/amd/display: Shorten hdmi_frl_status_polling_workqueue

This commit shortens the name of the hdmi_frl_status_polling_wq workqueue.
It prevents a kernel warning that the name exceeds WQ_NAME_LEN.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 2e74ff94dcacc..881626f0f258e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -834,9 +834,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>  	}
>  	if (adev->dm.dc->caps.max_links > 0) {
>  		adev->dm.hdmi_frl_status_polling_wq =3D
> -			create_singlethread_workqueue("hdmi_frl_status_polling_workqueue");
> +			create_singlethread_workqueue("hdmi_frl_status_polling_wq");
>  		if (!adev->dm.hdmi_frl_status_polling_wq)
> -			drm_err(adev_to_drm(adev), "failed to initialize hdmi_frl_status_poll=
ing_workqueue\n");
> +			drm_err(adev_to_drm(adev), "failed to initialize hdmi_frl_status_poll=
ing_wq\n");

[Severity: High]
This isn't a bug introduced by this patch, but is it safe to continue driver
initialization if create_singlethread_workqueue() fails?

If adev->dm.hdmi_frl_status_polling_wq fails to allocate, it returns NULL a=
nd
we log an error here, but we don't jump to the error path (unlike failures
for hpd_rx_offload_wq).

Later, in amdgpu_dm_atomic_commit_tail() or hdmi_frl_status_polling_work(),
queue_delayed_work() is called with this potentially NULL workqueue pointer:

	if (queue_delayed_work(dm->hdmi_frl_status_polling_wq,
			       &dm->hdmi_frl_status_polling_work, ...))

The kernel's workqueue API unconditionally dereferences the wq pointer in
__queue_delayed_work(), so wouldn't this cause a NULL pointer dereference
kernel panic?

[Severity: High]
This is a pre-existing issue, but is this workqueue ever cleaned up?

Looking at amdgpu_dm_fini(), there appears to be no destroy_workqueue() or
cancel_delayed_work_sync() for hdmi_frl_status_polling_wq and its delayed
work.

Could this leak the workqueue structure and its backing thread when the
driver is unbound, or cause a use-after-free panic if the delayed work timer
fires after the driver module has been unloaded?

[Severity: High]
This is another pre-existing issue, but does
amdgpu_dm_connector_init_helper() corrupt the active workqueue state?

In drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c,
amdgpu_dm_connector_init_helper() unconditionally calls:

    INIT_DELAYED_WORK(&dm->hdmi_frl_status_polling_work,
                      hdmi_frl_status_polling_work);

This helper is executed for every connector, including dynamically when
DisplayPort MST connectors are hotplugged via dm_dp_add_mst_connector()
in drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c.

Because the delayed_work structure belongs to the shared global
amdgpu_display_manager (dm), won't re-initializing it when an HDMI FRL
stream is already actively polling overwrite the active work_struct's
internal linked list pointers and timer state?

>  	}
>  	if (dc_is_dmub_outbox_supported(adev->dm.dc)) {
>  		init_completion(&adev->dm.dmub_aux_transfer_done);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-amdgpu-fix=
-wq_name_len-warning-v2-1-ef0e2e6f5be7@kernel.org?part=3D1
