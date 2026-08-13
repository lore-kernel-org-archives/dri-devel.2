Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7463C5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 19:38:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3641D10E4CD;
	Thu, 13 Aug 2026 19:38:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KITOZQWQ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8906D10E03F;
 Thu, 13 Aug 2026 19:38:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4C0964368F;
 Thu, 13 Aug 2026 19:38:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 586351F000E9;
 Thu, 13 Aug 2026 19:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786649927;
 bh=dICXO7+0Rud/oDHZkiYIFj47TYUXR2epDxTQFHgDpGM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=KITOZQWQIcY6An7SP/U3Ps20OvV4uGM2z2NIyyNaPDmCscBhflgTnTPXXRei/1o9H
 p5IJVxF3lJ+LJgdX5awscIHjsFzT8knBVxOFwEZ5yZbhFp19/UO4fWnaIw0CoDw51K
 tTCCdhkFdpjW1dTACsdxXgCG6MYRZ7niEbXPj/6Agvd6dxxdNKC5ok6pudIgiO+fEr
 kVMRh4OwWCKckBaYMNSfDGGBzQR7A0KqU0Ga1Bx9kYNU1EMan203FSBND2e8v2cNj3
 QRqi5Y7vrudDkN4bXlU+aK8XZtMyDN45M2t2X8CPg71MA2ZdO3u17k07WHHLZH6NlG
 XccyWdOIBvAyw==
Message-ID: <7bb4075c-4186-4f20-8006-2e414429463a@kernel.org>
Date: Thu, 13 Aug 2026 14:38:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Scale custom brightness curve from full
 range
Content-Language: en-US
To: Akhmed Zhitaev <zhitaevakh@gmail.com>, amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, alex.hung@amd.com, roman.li@amd.com,
 stable@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260813170959.22073-1-zhitaevakh@gmail.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260813170959.22073-1-zhitaevakh@gmail.com>
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



On 8/13/26 12:09, Akhmed Zhitaev wrote:
> Custom brightness curves use an 8-bit input signal.  After exporting the
> full PWM range to userspace, the curve normalizer still divides requests
> by the physical PWM span.  On panels with a nonzero minimum PWM level,
> this can produce a curve input greater than 255 and send an invalid
> backlight level to DC.
> 
> Scale the userspace [0..max] range to the curve's [0..255] range
> instead.  This retains the full advertised range and keeps the reverse
> readback conversion unchanged.
> 
> Fixes: 8dbd72cb7900 ("drm/amd/display: Export full brightness range to userspace")
> Cc: stable@vger.kernel.org
> Signed-off-by: Akhmed Zhitaev <zhitaevakh@gmail.com>

Thanks for this.

We have moved the code in amd-staging-drm-next

https://gitlab.freedesktop.org/agd5f/linux/-/commit/6c2b46e9774f13e45985f6da9f7d5f8458767b98

As your changes are trivial, I'll adjust while commiting.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 40d82a3ee..533c69f0b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5131,10 +5131,10 @@ static int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
>   	return 1;
>   }
>   
> -/* Rescale from [min..max] to [0..AMDGPU_MAX_BL_LEVEL] */
> -static inline u32 scale_input_to_fw(int min, int max, u64 input)
> +/* Rescale userspace [0..max] to the firmware curve's [0..255]. */
> +static inline u32 scale_input_to_fw(int max, u64 input)
>   {
> -	return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_BL_LEVEL, max - min);
> +	return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_BL_LEVEL, max);
>   }
>   
>   /* Rescale from [0..AMDGPU_MAX_BL_LEVEL] to [min..max] */
> @@ -5147,7 +5147,7 @@ static void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *cap
>   				      unsigned int min, unsigned int max,
>   				      uint32_t *user_brightness)
>   {
> -	u32 brightness = scale_input_to_fw(min, max, *user_brightness);
> +	u32 brightness = scale_input_to_fw(max, *user_brightness);
>   	u8 lower_signal, upper_signal, upper_lum, lower_lum, lum;
>   	int left, right;
>   

