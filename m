Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B23EF4EDE
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 12:40:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92BD110E1A7;
	Mon,  6 Apr 2026 12:40:11 +0000 (UTC)
X-Greylist: delayed 310 seconds by postgrey-1.36 at gabe;
 Mon, 06 Apr 2026 12:40:10 UTC
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
 by gabe.freedesktop.org (Postfix) with ESMTP id 9805210E1A7
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 12:40:10 +0000 (UTC)
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
 id 1w9jAQ-00040z-00; Mon, 06 Apr 2026 14:34:58 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
 id 9ECD8C0EB5; Mon,  6 Apr 2026 14:34:31 +0200 (CEST)
Date: Mon, 6 Apr 2026 14:34:31 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: arnd@arndb.de, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] arch/mips: Drop CONFIG_FIRMWARE_EDID from defconfig files
Message-ID: <adOoV8N5BYueZavi@alpha.franken.de>
References: <20260401082805.214198-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401082805.214198-1-tzimmermann@suse.de>
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

On Wed, Apr 01, 2026 at 10:27:57AM +0200, Thomas Zimmermann wrote:
> CONFIG_FIRMWARE_EDID=y depends on X86 or EFI_GENERIC_STUB. Neither is
> true here, so drop the lines from the defconfig files.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  arch/mips/configs/ip32_defconfig            | 1 -
>  arch/mips/configs/lemote2f_defconfig        | 1 -
>  arch/mips/configs/malta_qemu_32r6_defconfig | 1 -
>  arch/mips/configs/maltaaprp_defconfig       | 1 -
>  arch/mips/configs/maltasmvp_defconfig       | 1 -
>  arch/mips/configs/maltasmvp_eva_defconfig   | 1 -
>  arch/mips/configs/maltaup_defconfig         | 1 -
>  7 files changed, 7 deletions(-)

applied to mips-next

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
