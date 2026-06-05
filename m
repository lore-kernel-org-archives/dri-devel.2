Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EADB1CD6E6E
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 01:25:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49D8410E418;
	Fri,  5 Jun 2026 01:25:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mZkbP46t";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 197D110E418
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 01:25:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E3FCB43B26
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 01:25:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FCD01F00893;
 Fri,  5 Jun 2026 01:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780622747;
 bh=MRcAdPq45Uj3Wg+dUKQj/KcwHsWVC2Q4hZgvHNHEWn0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mZkbP46tOfA16+E8ayYwKM5zJN/+owE0z7f+VufmrDqc1NdeqA6hfUiOA9j2TGQjG
 /EpUp9uMuaUymDkYa/Y6kv/jYrNu57lTxlXD8F/FinpInq+zVdo5Cw+LM74PKhgsM+
 VHduTE7UrLtmYlxP94FdXoRLN6Doi2NBJuG43/NQaFSgC90GQ6o1Igw+WN6rohs6iU
 0e05PeJZiM0/y8vO19EQ5NNf0LjKZ/EzGhs8qxydVfGXABXsevtx0Nuw8Ko+F+kwcN
 lSP1LCPZwiqwvxS4P8c0fBN6sn30OiAVLhDrweUN/PKcrA1TF51Ydc5UzUJrwMRE9y
 Yjz6XJPhCYzqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amd/display: Shorten hdmi_frl_status_polling_workqueue
To: "Nathan Chancellor" <nathan@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260604-amdgpu-fix-wq_name_len-warning-v1-1-eb5415b45b27@kernel.org>
References: <20260604-amdgpu-fix-wq_name_len-warning-v1-1-eb5415b45b27@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 01:25:47 +0000
Message-Id: <20260605012547.9FCD01F00893@smtp.kernel.org>
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
- [High] Resource leak of hdmi_frl_status_polling_wq during module teardown=
 or initialization failure.
- [High] NULL pointer dereference if hdmi_frl_status_polling_wq allocation =
fails.
--

commit b8f83563decd99d69977bc64fe3e67736687cb49
Author: Nathan Chancellor <nathan@kernel.org>
drm/amd/display: Shorten hdmi_frl_status_polling_workqueue

This commit shortens the name of the hdmi_frl_status_polling_wq workqueue
to prevent warnings about exceeding the maximum workqueue name length.

Fixes: 5c9b8b27a883 ("drm/amd/display: Tie FRL support into amdgpu_dm")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 8f80420e9f0b8..3cde7a456858c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2259,9 +2259,9 @@ static int amdgpu_dm_init(struct amdgpu_device *ade=
v)
>  	}
>  	if (adev->dm.dc->caps.max_links > 0) {
>  		adev->dm.hdmi_frl_status_polling_wq =3D
> -			create_singlethread_workqueue("hdmi_frl_status_polling_workqueue");
> +			create_singlethread_workqueue("hdmi_frl_status_polling_wq");

[Severity: High]
This isn't a bug introduced by this patch, but does this workqueue get
leaked on driver unload?

Looking at amdgpu_dm_fini(), there doesn't seem to be a corresponding
destroy_workqueue() call for this specific workqueue. Does this mean every
time the driver is unloaded or initialization fails after this point, the
workqueue struct and its internal resources are leaked?

>  		if (!adev->dm.hdmi_frl_status_polling_wq)
> -			drm_err(adev_to_drm(adev), "failed to initialize hdmi_frl_status_poll=
ing_workqueue\n");
> +			drm_err(adev_to_drm(adev), "failed to initialize hdmi_frl_status_poll=
ing_wq\n");

[Severity: High]
This is also a pre-existing issue, but can an allocation failure here
cause a NULL pointer dereference later on?

Unlike other workqueues in this function that use a goto error path when
allocation fails, this just logs the error and continues. If it returns
NULL, wouldn't amdgpu_dm_commit_streams() trigger a kernel panic when it
subsequently calls queue_delayed_work() using this NULL pointer?

>  		adev->dm.hdmi_frl_status_polling_delay_ms =3D 200;
>  		INIT_DELAYED_WORK(&adev->dm.hdmi_frl_status_polling_work, hdmi_frl_sta=
tus_polling_work);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604-amdgpu-fix=
-wq_name_len-warning-v1-1-eb5415b45b27@kernel.org?part=3D1
