Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F20C43602
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 01:07:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 262ED10E545;
	Fri,  3 Jul 2026 01:07:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BW45mtE4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B54910E545;
 Fri,  3 Jul 2026 01:07:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 23D534359C;
 Fri,  3 Jul 2026 01:07:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3791F000E9;
 Fri,  3 Jul 2026 01:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783040845;
 bh=xxk4IRdkdS80Y7ozvEETiJ30SiAsseLRUpsNlm+4sOY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=BW45mtE4H5s0tpJqRXcyn5jti6mOh3VdEy1DFWMHoNWR63ueooW7yTWytN1dGndU3
 kj8Sbn2QJFBva87+DL+kUGCfJDO6IdG8HdJDFG0slK0rDhq32B9n5r7LnpVi/dDlRG
 2WIGwHPa4V+udlDj8GZ+88tWi6+4fR3VXZpnNeHOfnfR+QURBy6RNcaWSQ8RwBuO30
 UgyaElCenY1qVny99hWD2Gwhtlj5gv+Wsm2hJhIq3JRybonx6svogQ8lyJsjfDRIv+
 4I3DjP/4KHYMxmXg4L87U/vTJt6JuXbGjDPX/olGUVyo8MJeUk6S0rRPbKRPQGYIiv
 o701+E6kAtK6w==
Date: Thu, 2 Jul 2026 18:07:20 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Alex Hung <alex.hung@amd.com>
Subject: Re: [PATCH v2] drm/amd/display: Shorten
 hdmi_frl_status_polling_workqueue
Message-ID: <20260703010720.GA2950778@ax162>
References: <20260618-amdgpu-fix-wq_name_len-warning-v2-1-ef0e2e6f5be7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618-amdgpu-fix-wq_name_len-warning-v2-1-ef0e2e6f5be7@kernel.org>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Ping? This is an obvious fix. Is this being ignored because of the
Sashiko comments?

On Thu, Jun 18, 2026 at 09:52:14AM -0700, Nathan Chancellor wrote:
> There is a warning when creating the hdmi_frl_status_polling_wq
> workqueue because "hdmi_frl_status_polling_workqueue" excceds
> WQ_NAME_LEN:
> 
>   workqueue: name exceeds WQ_NAME_LEN. Truncating to: hdmi_frl_status_polling_workque
> 
> Shorten the workqueue name to "hdmi_frl_status_polling_wq" like the
> structure member to avoid the warning.
> 
> Fixes: 5c9b8b27a883 ("drm/amd/display: Tie FRL support into amdgpu_dm")
> Reviewed-by: Alex Hung <alex.hung@amd.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> Changes in v2:
> - Rebase to solve conflicts with 0e967e086e75 ("drm/amd/display: Extract
>   connector and encoder code to amdgpu_dm_connector").
> - Pick up Alex's Reviewed-by.
> - Link to v1: https://patch.msgid.link/20260604-amdgpu-fix-wq_name_len-warning-v1-1-eb5415b45b27@kernel.org
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 2e74ff94dcac..881626f0f258 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -834,9 +834,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>  	}
>  	if (adev->dm.dc->caps.max_links > 0) {
>  		adev->dm.hdmi_frl_status_polling_wq =
> -			create_singlethread_workqueue("hdmi_frl_status_polling_workqueue");
> +			create_singlethread_workqueue("hdmi_frl_status_polling_wq");
>  		if (!adev->dm.hdmi_frl_status_polling_wq)
> -			drm_err(adev_to_drm(adev), "failed to initialize hdmi_frl_status_polling_workqueue\n");
> +			drm_err(adev_to_drm(adev), "failed to initialize hdmi_frl_status_polling_wq\n");
>  	}
>  	if (dc_is_dmub_outbox_supported(adev->dm.dc)) {
>  		init_completion(&adev->dm.dmub_aux_transfer_done);
> 
> ---
> base-commit: 991fd2cb908bf5d35a496760519442d6e9f8763d
> change-id: 20260604-amdgpu-fix-wq_name_len-warning-63c8012e0c2b
> 
> Best regards,
> --  
> Cheers,
> Nathan
> 

-- 
Cheers,
Nathan
