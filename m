Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BFEEC54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 14:52:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A75DD10E087;
	Wed, 29 Jul 2026 14:52:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="vGEDjAwi";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 1438810E087
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 14:52:23 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 271A81684;
 Wed, 29 Jul 2026 07:52:19 -0700 (PDT)
Received: from [10.57.87.210] (unknown [10.57.87.210])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2EFEA3F66F;
 Wed, 29 Jul 2026 07:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1785336743; bh=5dyhrCn4RqDuHCMYrqO4tULIXM6lcP98/g+tCfcUi6Q=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=vGEDjAwi89aRlUzQ3mfiWbSWNlrGmUv/7IGhSBWUFYI6OWksy8jsREfF2YO7DtbNy
 unPQBWRKfowbM2L23xRKkqV/gDUw4Yca7eEF2Qpz/08C5CNV6skwFyJK4HRrxMNno/
 DKoTa7F5L6XPhl2GeZaun5VmQqo1WT+2OBwcbFro=
Message-ID: <f1ba920e-a5a8-4e70-a107-297ac3b6bfd1@arm.com>
Date: Wed, 29 Jul 2026 15:52:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panthor: harden firmware build-info bounds checks
To: Osama Abdelkader <osama.abdelkader@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heiko Stuebner <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260720113212.11981-1-osama.abdelkader@gmail.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260720113212.11981-1-osama.abdelkader@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On 20/07/2026 12:32, Osama Abdelkader wrote:
> panthor_fw_read_build_info() checks whether the metadata range fits in the
> firmware image with hdr.meta_start + hdr.meta_size. Both fields are u32, so
> the addition can wrap and let an out-of-bounds range pass validation.
> 
> The function also reads the "git_sha: " prefix without first checking that
> the metadata is long enough, and meta_size == 0 can underflow the NULL
> terminator index.
> 
> Use subtraction-based bounds checking and reject metadata that is too short
> to contain the expected prefix and trailing NULL byte.
> 
> Fixes: 2718d91816ee ("drm/panthor: Add the FW logical block")
> Cc: stable@vger.kernel.org
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

Reviewed-by: Steven Price <steven.price@arm.com>

I'll push this to drm-misc-fixes.

Thanks,
Steve

> ---
>  drivers/gpu/drm/panthor/panthor_fw.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index 6335893d3f16..9d0e1fafdce2 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -709,7 +709,8 @@ static int panthor_fw_read_build_info(struct panthor_device *ptdev,
>  		return ret;
>  
>  	if (hdr.meta_start > fw->size ||
> -	    hdr.meta_start + hdr.meta_size > fw->size) {
> +	    hdr.meta_size > fw->size - hdr.meta_start ||
> +	    hdr.meta_size <= header_len) {
>  		drm_err(&ptdev->base, "Firmware build info corrupt\n");
>  		/* We don't need the build info, so continue */
>  		return 0;

