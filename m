Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 725DB106ACE4
	for <dri-devel@archiver.kernel.org>; Thu, 12 Mar 2026 20:37:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71B5D10EAB2;
	Thu, 12 Mar 2026 20:37:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="C/QLezoJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A86410EAAC;
 Thu, 12 Mar 2026 20:37:46 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 251C943EF8;
 Thu, 12 Mar 2026 20:37:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA7CC4CEF7;
 Thu, 12 Mar 2026 20:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773347866;
 bh=Hlj3wUVDqV3lGFj/UpEgAg7uNK/MNg5jI7SSa9ZuiSI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=C/QLezoJFTZ2W1UxtqdQN5LK1EmIN7m6I0wcGmma+62apeVCvv6OTk8lUKDGL9Bck
 SKtnnR1IeNSiM4EoGP43LJ4XmGA9laBiUxLUl3a0vYozZtSUyfotxBycyYLq1pTKrA
 sceSRw3irBaavRL6Nb6Ut9H8v6XADlw1FEmMrdgAXHRwtgoo+NRsY1TdTWkOgYX/Sf
 X153gd+D+ZnSA02cvaPWrLunOnHMqfkQaGnT/3jvubTyanCyFBUa/kbSS/GaCft+Ua
 Ztr0K958uKpOlUYe3bLsvCPDteIR8aJbKle7G7BBINtEkDbXFNvsoYLZ2wFMbmAdlz
 jljSLSlzkgQ4g==
Date: Thu, 12 Mar 2026 13:37:40 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Calvin Owens <calvin@wbinvd.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Charlene Liu <charlene.liu@amd.com>,
 Ovidiu Bunea <ovidiu.bunea@amd.com>, Alex Hung <alex.hung@amd.com>,
 Dan Wheeler <daniel.wheeler@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Christian Koenig <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 llvm@lists.linux.dev
Subject: Re: [PATCH v2] drm/amd/display: Fix uninitialized variable use which
 breaks full LTO
Message-ID: <20260312203740.GA2747807@ax162>
References: <ef7266eb7802ce6d68ebd9356477e9671f0c94e0.1773116305.git.calvin@wbinvd.org>
 <abL0PlD1FDnfrX4o@mozart.vkv.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abL0PlD1FDnfrX4o@mozart.vkv.me>
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

On Thu, Mar 12, 2026 at 10:13:34AM -0700, Calvin Owens wrote:
> Commit e1b385726f7f ("drm/amd/display: Add additional checks for PSP
> footer size") introduced a use of an uninitialized stack variable
> in dm_dmub_sw_init() (region_params.bss_data_size).
> 
> Interestingly, this seems to cause no issue on normal kernels. But when
> full LTO is enabled, it causes the compiler to "optimize" out huge
> swaths of amdgpu initialization code, and the driver is unusable:
> 
>     amdgpu 0000:03:00.0: [drm] Loading DMUB firmware via PSP: version=0x07002F00
>     amdgpu 0000:03:00.0: sw_init of IP block <dm> failed 5
>     amdgpu 0000:03:00.0: amdgpu_device_ip_init failed
>     amdgpu 0000:03:00.0: Fatal error during GPU init
> 
> It surprises me that neither gcc nor clang emit a warning about this: I
> only found it by bisecting the LTO breakage.
> 
> Fix by using the bss_data_size field from fw_meta_info_params, as was
> presumably intended.
> 
> Fixes: e1b385726f7f ("drm/amd/display: Add additional checks for PSP footer size")
> Signed-off-by: Calvin Owens <calvin@wbinvd.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> Changes in v2:
> * Use fw_meta_info_params.bss_data_size instead of repeating the load
>   from the payload header field [Nathan]
> 
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index b3d6f2cd8ab6..0d1c772ef713 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2553,9 +2553,9 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
>  	fw_meta_info_params.bss_data_size = le32_to_cpu(hdr->bss_data_bytes);
>  	fw_meta_info_params.fw_inst_const = adev->dm.dmub_fw->data +
>  					    le32_to_cpu(hdr->header.ucode_array_offset_bytes) +
>  					    PSP_HEADER_BYTES_256;
> -	fw_meta_info_params.fw_bss_data = region_params.bss_data_size ? adev->dm.dmub_fw->data +
> +	fw_meta_info_params.fw_bss_data = fw_meta_info_params.bss_data_size ? adev->dm.dmub_fw->data +
>  					  le32_to_cpu(hdr->header.ucode_array_offset_bytes) +
>  					  le32_to_cpu(hdr->inst_const_bytes) : NULL;
>  	fw_meta_info_params.custom_psp_footer_size = 0;
>  
> -- 
> 2.47.3
> 
> 
