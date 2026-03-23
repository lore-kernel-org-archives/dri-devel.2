Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A2AEC01A3
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 08:22:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64E0F10E288;
	Mon, 23 Mar 2026 08:22:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="bTF6ePdh";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6231210E288
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 08:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1774254132;
 bh=dXwlb6jrq7OjSUtG5esx0+6Puxpy7ODuTv1XGo58P7Y=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=bTF6ePdhTih/UbCQctmpHM86SpU7E5dC4F4VFIsPAgrs6vXUQyUREzvdijHC3cZNQ
 ayYCVM0GYZ3RUeTzqt3HitYkwADxTBUJz1Pz9BGi0l0jRZf1RogCIEGiGG56CqTCDx
 iQNmKtPiVJfGe3SuPGVmpt8VZhUZTY0RhVUck/yqBWfKw4OgNRd+N7wr45lpBI15aS
 K8zlSzb/oYr/XYk2B0v2CDqqNeaCfyhPTni77Ic8GJIgqqK5sK5ZVkGYkrP1+egevV
 9DderxvVJ36UFsjJXMgM6DdLxeRRxNRr4/9g4eKbJCLkK5XlLe/hksHJurHpkDohvs
 8X45L1wEQQreQ==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 7657717E0619;
 Mon, 23 Mar 2026 09:22:12 +0100 (CET)
Date: Mon, 23 Mar 2026 09:22:07 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Christian Hewitt <christianshewitt@gmail.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: correct firmware related messages
Message-ID: <20260323092207.7420118f@fedora>
In-Reply-To: <20260323081132.3217646-1-christianshewitt@gmail.com>
References: <20260323081132.3217646-1-christianshewitt@gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Mon, 23 Mar 2026 08:11:32 +0000
Christian Hewitt <christianshewitt@gmail.com> wrote:

> Some English language corrections to firmware messages. No
> functional changes.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panthor/panthor_fw.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index a64ec8756bed..349bb6b0e7bf 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -580,7 +580,7 @@ static int panthor_fw_load_section_entry(struct panthor_device *ptdev,
>  
>  	if (hdr.flags & CSF_FW_BINARY_IFACE_ENTRY_PROT) {
>  		drm_warn(&ptdev->base,
> -			 "Firmware protected mode entry not be supported, ignoring");
> +			 "Firmware protected mode entry is not supported, ignoring");
>  		return 0;
>  	}
>  
> @@ -749,7 +749,7 @@ static int panthor_fw_load_entry(struct panthor_device *ptdev,
>  
>  	if ((iter->offset % sizeof(u32)) ||
>  	    (CSF_FW_BINARY_ENTRY_SIZE(ehdr) % sizeof(u32))) {
> -		drm_err(&ptdev->base, "Firmware entry isn't 32 bit aligned, offset=0x%x size=0x%x\n",
> +		drm_err(&ptdev->base, "Firmware entry is not 32-bit aligned, offset=0x%x size=0x%x\n",
>  			(u32)(iter->offset - sizeof(u32)), CSF_FW_BINARY_ENTRY_SIZE(ehdr));
>  		return -EINVAL;
>  	}

