Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F6FC44500
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 10:40:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91FF610F799;
	Fri,  3 Jul 2026 10:40:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=robert.mader@collabora.com header.b="Zb7fQJCq";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B18D910F797;
 Fri,  3 Jul 2026 10:40:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1783075235; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=bW1tAVz3+SZnO11VkBpP6cuw2USeOL3SrN7WcnTPpwJ9RGJ2itiNY8aM3bnerZCqj911153kSWI31UAHiJ9kpUTODzr4TIGJi42asZsEhEa/3TI9AyEJvvGQjE88rt/n9IlSicOoVSMRHzohzTJNVNh5WrAKDKPc7NxZ8cnXJsU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1783075235;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=LaqFELq6+zCMYGQp9Kd1Ji2zee9t3LEv1UtDmaLWXOk=; 
 b=Jx84J7RMVDcv+siun06iHOT6g1xPgBGc4odfmETRSup5BqujjZ716Zgle23Zy5u2rHJ3x4bx1EP/yg1vsU4pnIG4IyDKGsJQYgq1bCXfHY8d6u70JCjEQogOME2RL9lzfG8Rg59f11DkHtOsdYIbpa+z62nqH56/DwmkqGUf0dc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=robert.mader@collabora.com;
 dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783075235; 
 s=zohomail; d=collabora.com; i=robert.mader@collabora.com;
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=LaqFELq6+zCMYGQp9Kd1Ji2zee9t3LEv1UtDmaLWXOk=;
 b=Zb7fQJCqhOhsc1RwAX1V3z9+OfViVxvb0HdiS4SWlrB6zNpBQVULlolvSIGf8sZ7
 EJB+ApIc9r5d8++4/E4XgnYPF4TA+0oixrRQTXuN6lCAAvOwm9/93786ML41OdP59Xn
 0YrYp88UsS6Qetb9LAE2I0BBTpKzOKM/Zt9zNWQ8=
Received: by mx.zohomail.com with SMTPS id 1783075234682699.133917681519;
 Fri, 3 Jul 2026 03:40:34 -0700 (PDT)
Message-ID: <eae10264-51ef-4e0b-9774-a694bc7f95b6@collabora.com>
Date: Fri, 3 Jul 2026 12:40:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/11] drm/amd/display: Set COLOR_SPACE_SRGB when fixed
 matrix colorop is bypassed
To: Harry Wentland <harry.wentland@amd.com>, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org
References: <20260623164812.81110-1-harry.wentland@amd.com>
 <20260623164812.81110-11-harry.wentland@amd.com>
Content-Language: en-US, de-DE
From: Robert Mader <robert.mader@collabora.com>
In-Reply-To: <20260623164812.81110-11-harry.wentland@amd.com>
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

Hi,

On 23.06.26 18:48, Harry Wentland wrote:
> When the fixed matrix colorop is bypassed, the color_space was set to
> COLOR_SPACE_UNKNOWN (0). In DC's DPP setup (dpp1_cnv_setup), the logic
> 'input_color_space ? input_color_space : color_space' treats 0 as
> 'not provided', causing it to fall back to the format-based default of
> COLOR_SPACE_YCBCR709 for YUV framebuffers. This results in an implicit
> YUV-to-RGB conversion via ICSC even when a color pipeline is active and
> the fixed matrix is bypassed.

shouldn't a commit with YUV framebuffer and fixed matrix set to bypass 
always fail, like it does in the VKMS implementation?

If this commit is only needed for RGB formats, somehow getting a 
YUV-to-RGB conversion applied to them otherwise, then I think the commit 
message should be clarified accordingly, no?

>
> Fix this by setting COLOR_SPACE_SRGB (1) instead. This is non-zero, so
> it overrides the format default. The SRGB entry in dpp_input_csc_matrix
> is an identity matrix, so ICSC performs no actual conversion, which is
> the correct behavior when the fixed matrix colorop is bypassed.
>
> Cc: stable@vger.kernel.org
> Fixes: 93d922f4833b ("drm/amd/display: Implement fixed matrix colorop color space mapping")
> Assisted-by: Copilot:claude-opus-4.6
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> index 561ee9a2e749..984bbfcf23f0 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> @@ -1534,7 +1534,7 @@ __set_dm_plane_colorop_fixed_matrix(struct drm_plane_state *plane_state,
>   		return -EINVAL;
>   
>   	if (colorop_state->bypass) {
> -		dc_plane_state->color_space = COLOR_SPACE_UNKNOWN;
> +		dc_plane_state->color_space = COLOR_SPACE_SRGB;
>   		return 0;
>   	}
>   

-- 
Robert Mader
Consultant Software Developer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

