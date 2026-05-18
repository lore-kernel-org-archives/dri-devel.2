Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B4DBCD4F4A
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 19:01:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2B4310E338;
	Mon, 18 May 2026 19:01:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="06H5Fk1g";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7716E10E338
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 19:01:33 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7822340A2E;
 Mon, 18 May 2026 19:01:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C75C2BCB7;
 Mon, 18 May 2026 19:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1779130892;
 bh=fw+q1hdy9gHSKP+DrE9FxxvQVeReNOjpqzZgPMQeP8M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=06H5Fk1gy9y8tlQho7zcqXihtsQKHU5b3Vhhuf3NcgpQPLWOVchJQZq4J+Qb9GojJ
 VxFX5DHgKZFr5krV/VckQrU3V57wlPe64tripRkC4EhM8Rqw1bWKyl0bCfCPfqKmil
 mj/N3GUe/qCtVGZZKPHJrqWM2BrPOTvMgUAz/ePw=
Date: Mon, 18 May 2026 21:00:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: D D <dhabal123@gmail.com>
Cc: security@kernel.org, robh@kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] accel/ethosu: fix integer overflow in cmd_to_addr()
 address computation
Message-ID: <2026051812-blemish-croon-5b37@gregkh>
References: <CA+g3TbsDGcsmdPn-p70OO3DwS2Fsq0NN9v1FVYqSa13JCPvFXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+g3TbsDGcsmdPn-p70OO3DwS2Fsq0NN9v1FVYqSa13JCPvFXQ@mail.gmail.com>
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

On Mon, May 18, 2026 at 09:02:18PM +0530, D D wrote:
> In cmd_to_addr(), the expression (cmd[0] & 0xff0000) << 16 performs the
> left-shift in 32-bit arithmetic because cmd[0] is u32 and the intermediate
> result of the AND is also u32. The meaningful bits (positions 16-23) need
> to land in positions 32-39 of the result, but these positions exceed the
> 32-bit width, so they are silently discarded before the cast to u64.
> 
> This causes cmd_to_addr() to always return an address with a zeroed upper
> half, producing an incorrect DMA address for the Ethos-U NPU. The device
> may then read from or write to the wrong physical memory region, leading
> to kernel memory corruption or information disclosure.
> 
> Fix by casting to u64 before the shift so the operation is performed in
> 64-bit arithmetic and no bits are lost.
> 
> Found by manual source code audit of Linux kernel v6.19
> (drivers/accel/ethosu/ethosu_gem.c, line 157).
> Affected versions: v6.19+ (since initial Ethos-U driver merge).

Can you use a Fixes: tag properly here?

> Signed-off-by: Dhabaleshwar Das (dhabal123@gmail.com)

Does not match your From: line.

> ---
>  drivers/accel/ethosu/ethosu_gem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/ethosu/ethosu_gem.c
> b/drivers/accel/ethosu/ethosu_gem.c
> index abcdef1..1234567 100644
> --- a/drivers/accel/ethosu/ethosu_gem.c
> +++ b/drivers/accel/ethosu/ethosu_gem.c
> @@ -155,7 +155,7 @@ static u64 cmd_to_addr(u32 *cmd)
>  static u64 cmd_to_addr(u32 *cmd)
>  {
> - return ((u64)((cmd[0] & 0xff0000) << 16)) | cmd[1];
> + return (((u64)(cmd[0] & 0xff0000)) << 16) | cmd[1];
>  }

Patch is corrupted and can not be applied :(

thanks,

greg k-h
