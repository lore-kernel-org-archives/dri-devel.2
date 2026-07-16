Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A61C4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 13:22:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B189D10F308;
	Thu, 16 Jul 2026 13:21:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EP5nlmqv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF66510F308;
 Thu, 16 Jul 2026 13:21:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 71F5D40777;
 Thu, 16 Jul 2026 13:21:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91671F000E9;
 Thu, 16 Jul 2026 13:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784208118;
 bh=C4ER0ARPZVqrIt9/HEi4s0ywOJQD5VxpjcYpqQLDuD8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=EP5nlmqvYqmgjIUmzbo/Jqeuw9KrIKm17s8DXd3gEQ75mUqG3s4gUX3lzlsSVbIJk
 dy5Xg92dMwdTgmzSZo3dng7MAVF3yo4CJGNC2uwsbdTu7P3C8mJsy8aH4jvVlqlr3P
 GOdPigKbi/S0iiZR/nE3WyCLuNQQcmhvnNiFKpnqthP+DMaAX6+Tf9RXuXnzLFQH96
 RTH/mKgOFJUPT6IYqTuB+z8Y3xBshGBpMTNLH7G1A8wvaqKL0WG9dfBUaI5170D0Uy
 XBq4n/b4zG3rdrZ52umF6i3sHRplTKlodw35PZa/jtsPmfoywuMwCYF4jDx8gPOSMr
 eHSeqONjox0fw==
Message-ID: <bd453dfb-c69f-44e5-80bb-f26f87135d9c@kernel.org>
Date: Thu, 16 Jul 2026 08:21:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/radeon: Only define radeon_acpi_vfct_match when
 actually used
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260716123646.1933293-2-u.kleine-koenig@baylibre.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260716123646.1933293-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



On 7/16/26 07:36, Uwe Kleine-König wrote:
> This fixes the build failure
> 
> drivers/gpu/drm/radeon/radeon_bios.c:614:12: error: ‘radeon_acpi_vfct_match’ defined but not used [-Werror=unused-function]
>    614 | static int radeon_acpi_vfct_match(struct radeon_device *rdev,
>        |            ^~~~~~~~~~~~~~~~~~~~~~
> 
> for builds with CONFIG_ACPI unset.
> 
> Fixes: 33a18ecd2fbf ("drm/radeon: Fix VFCT bus number matching with soft filter")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

> ---
> Hello,
> 
> 33a18ecd2fbf is currently in next via
> 
> 	https://gitlab.freedesktop.org/agd5f/linux.git drm-next
> 
> .
> 
> Best regards
> Uwe
> 
>   drivers/gpu/drm/radeon/radeon_bios.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/radeon/radeon_bios.c b/drivers/gpu/drm/radeon/radeon_bios.c
> index cc10880af096..cd7a5d458157 100644
> --- a/drivers/gpu/drm/radeon/radeon_bios.c
> +++ b/drivers/gpu/drm/radeon/radeon_bios.c
> @@ -596,6 +596,7 @@ static bool radeon_read_disabled_bios(struct radeon_device *rdev)
>   		return legacy_read_disabled_bios(rdev);
>   }
>   
> +#ifdef CONFIG_ACPI
>   /**
>    * radeon_acpi_vfct_match() - Check if a VFCT entry matches the device
>    * @rdev: Radeon device
> @@ -635,7 +636,6 @@ static int radeon_acpi_vfct_match(struct radeon_device *rdev,
>   	return 0;
>   }
>   
> -#ifdef CONFIG_ACPI
>   static bool radeon_acpi_vfct_bios(struct radeon_device *rdev)
>   {
>   	struct acpi_table_header *hdr;
> 
> base-commit: 33a18ecd2fbf6bcbf803836e94eb31c26f4c7f41

