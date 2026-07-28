Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D415DC531F9
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 16:03:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D16110E5B5;
	Tue, 28 Jul 2026 16:03:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=robert.mader@collabora.com header.b="G9BBn3JV";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3285410E5B5;
 Tue, 28 Jul 2026 16:03:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785254622; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=F4LQdTSU+BknabVCsX8DDtu+xk1jYFM6/71rGdZ+qD0Tzm5BJEW9WdN9Y0gQuF1SfgiZf6JNwuNATD76x+g4OhsFgMmfmDsi3v4CxV6Ig2vJCB9k6QIDh5XMzt/exIvt9bWD/AqUArDR4M29eMW7C7J2mYUrVC5dhwQDXa6Y+V4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785254622;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=8JrGWwitL6uxKFeuf7zq3J6bb+2oz1OL3E6nYXIcSIg=; 
 b=YZrbTKUOOYlmxUy/VeDxI9A0Ih3W2UYGSxYWBzVUO7rc7TFgrLSwHYr/vbYrqQljucp9buEPcD99M+V2unoOTGX+bV48oPwd9esL+IYH9JIFUdQU3J3SDhgfSjRyZaVv4EheZ0MqWnGpWWnRxB4rs/AwajVbHjWtbbY57dryvxQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=robert.mader@collabora.com;
 dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785254622; 
 s=zohomail; d=collabora.com; i=robert.mader@collabora.com;
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=8JrGWwitL6uxKFeuf7zq3J6bb+2oz1OL3E6nYXIcSIg=;
 b=G9BBn3JVCfdjQpzckryh4YvyfCd0qFq/70Xm6g0u+GS4SZFkp5QdXq/0o+704edc
 NdU1ciZbqtQuPX0iPsOcaaJKEQmvKHoDYe/uYiJ0EIRimvkOCC6DWQDIJAUOtqoYnbo
 coLueqUIC+h48wqShiw4FIdPKGGGypc6Vs+HRwH0=
Received: by mx.zohomail.com with SMTPS id 1785254620610945.8192608395595;
 Tue, 28 Jul 2026 09:03:40 -0700 (PDT)
Message-ID: <ddaf4eb2-79db-4159-a311-9ecd585083d3@collabora.com>
Date: Tue, 28 Jul 2026 18:03:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/11] drm/amd/display: Set color_space to plane_infos
To: Harry Wentland <harry.wentland@amd.com>, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
Cc: Alex Hung <alex.hung@amd.com>
References: <20260722134607.136293-1-harry.wentland@amd.com>
 <20260722134607.136293-11-harry.wentland@amd.com>
Content-Language: en-US, de-DE
From: Robert Mader <robert.mader@collabora.com>
In-Reply-To: <20260722134607.136293-11-harry.wentland@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Tested-by: Robert Mader <robert.mader@collabora.com>

On 22.07.26 15:46, Harry Wentland wrote:
> DC looks at plane_info structs.
>
> For legacy drm_plane COLOR_ENCODING and COLOR_RANGE this was
> done in fill_dc_plane_info_and_addr's call to
> fill_plane_color_attributes.
>
> Assisted-by: Claude:claude-sonnet-4.5
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> Reviewed-by: Alex Hung <alex.hung@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index b7d815997753..f5515ba64ca0 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4234,6 +4234,8 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
>   			&bundle->flip_addrs[planes_count].address,
>   			afb->tmz_surface);
>   
> +		bundle->plane_infos[planes_count].color_space = dc_plane->color_space;
> +
>   		drm_dbg_state(state->dev, "plane: id=%d dcc_en=%d\n",
>   				 new_plane_state->plane->index,
>   				 bundle->plane_infos[planes_count].dcc.enable);

-- 
Robert Mader
Consultant Software Developer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

