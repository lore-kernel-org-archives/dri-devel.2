Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8425C606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 19:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h52fsTYz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D42BC10E811;
	Thu, 29 Oct 2026 19:52:23 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10A5E10E811
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 19:52:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B8360437DF;
 Thu, 29 Oct 2026 19:52:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304A31F01816;
 Thu, 29 Oct 2026 19:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793303536;
 bh=0qbJjRietxHEVFz3F+hunDpmsoICZE/W8xHIere+GDw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=h52fsTYz8DHnte5+njB9dfCiduRdFbNvmNHzl3EEQNAu3NfVLVFOpsbrQ5AQqzN59
 ykAnHU5D+U4h/NRgAmYc+gFyCD9ed8kHVij2fXF8QTBdGe8VRxmQmg9zLcOe71WmvZ
 UserQK5fC8GqfrAZ1fAg9sBwj0rnqE/5CBBxPEIUjQaGKWF6q75OC88C/Xr2CbTobR
 oNMIPqba+YzvecABOxP0ad04wVYsRRrq0jFJ7Z4cM5v1o733AXay9R53FUUyVvRX4V
 eESCZMOcpso6YKcnlBU6kfyV5eXSL5YlbgDhAC7vcxFOL8K6Dl8I77qQQZJi22l+oU
 62Q7rnbG8rUyg==
Message-ID: <2c8b54e9-e4a9-4394-bec5-308adad5daff@kernel.org>
Date: Thu, 29 Oct 2026 14:52:12 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/video: Preserve the default VGA fallback for legacy
 modes
Content-Language: en-US
To: Hengyu Liang <hengyul@cs.unc.edu>, x86@kernel.org
Cc: tzimmermann@suse.de, aaron.ma@canonical.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20261029162311.3389523-1-hengyul@cs.unc.edu>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20261029162311.3389523-1-hengyul@cs.unc.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/29/26 11:23, Hengyu Liang wrote:
> Commit 596b3678326d ("x86/video: Only fall back to vga_default_device()
> without screen info") made video_is_primary_device() rely exclusively
> on screen_info resources whenever any are available.
> 
> However, screen_info_resources() also returns legacy I/O and memory
> ranges for VGA text modes. These ranges are not PCI BARs, so the resource
> lookup fails and the default VGA fallback is skipped.
> 
> On a SeaBIOS QEMU guest with bochs and VKMS, the boot VGA loses its DRM
> boot_display attribute and fbcon leaves the console on VKMS. This can
> be checked with:
> 
>      cat /sys/class/drm/card1/boot_display
>      stty -F /dev/tty1 size
> 
> Without the fix, boot_display is missing and tty1 is 48 rows by 128
> columns. With it, boot_display contains 1 and tty1 is 50 rows by 160
> columns.
> 
> Use resource-based selection only for linear framebuffers. Fall back to
> vga_default_device() for legacy display modes, while keeping EFI and
> VESA framebuffer ownership authoritative.
> 
> Fixes: 596b3678326d ("x86/video: Only fall back to vga_default_device() without screen info")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
> ---
> Tested in QEMU/KVM with identical KASAN configs: SeaBIOS VGA text mode
> (with and without VKMS), VESA, and OVMF with one and two virtual GPUs.
> All 26 guest-only helper checks pass, including EFI/VESA framebuffer
> ownership, missing framebuffer resources, and addresses above 4 GiB.
> Also build-tested x86-32 with/without CONFIG_SCREEN_INFO, and x86-64
> without CONFIG_SCREEN_INFO.
> 
>   arch/x86/video/video-common.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/video/video-common.c b/arch/x86/video/video-common.c
> index 8ed82fff7638..b8f83346dfe8 100644
> --- a/arch/x86/video/video-common.c
> +++ b/arch/x86/video/video-common.c
> @@ -45,7 +45,7 @@ bool video_is_primary_device(struct device *dev)
>   
>   #ifdef CONFIG_SCREEN_INFO
>   	numres = screen_info_resources(si, res, ARRAY_SIZE(res));
> -	if (numres > 0) {
> +	if (numres > 0 && __screen_info_has_lfb(screen_info_video_type(si))) {
>   		for (i = 0; i < numres; ++i) {
>   			if (!(res[i].flags & IORESOURCE_MEM))
>   				continue;
> 
> base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

