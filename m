Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6888C61DE8
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 05:48:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE6D410E60B;
	Mon, 31 Aug 2026 05:48:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lr+BFI9P";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B7A210E605
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 05:48:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C3F6840283;
 Mon, 31 Aug 2026 05:48:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254AC1F000E9;
 Mon, 31 Aug 2026 05:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1788155325;
 bh=2IzguYBaGHJrEbcQ6FGsHCrrRCuT3Z1+IowBs9KVDCE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Lr+BFI9P67qwYhc3fFJ+jIztr9OijPdIY52YidjuKz0yARTC20RhwsgLG0sZllZsi
 lGaG4lZZLGNMZcM+FtRZIStBqDGoyNMFDHyo8weEhZme2JGMrLgWtyKbHlGCpCrkW9
 3ZCN/kyCyEwiMQ5rCqIFbLnPKmjpvNPB+Cg5RRxA=
Date: Mon, 31 Aug 2026 07:47:02 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: anshika <anshikajain196872@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Dan Carpenter <error27@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: fbtft: name the no-op endian modifier in
 define_fbtft_write_reg()
Message-ID: <2026083121-suspend-constable-9e1a@gregkh>
References: <20260830161529.14500-1-anshikajain196872@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260830161529.14500-1-anshikajain196872@gmail.com>
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

On Sun, Aug 30, 2026 at 09:45:29PM +0530, anshika wrote:
> Two of the three define_fbtft_write_reg() instantiations pass an empty
> modifier argument, which checkpatch flags as a fragile empty macro
> argument. Give the no-op case an explicit name instead of leaving it
> blank.

Checkpatch is wrong.

> No functional change.
> 
> Link: https://lkml.iu.edu/hypermail/linux/kernel/2602.0/01917.html
> 
> Signed-off-by: anshika <anshikajain196872@gmail.com>

We would need a full name anyway.

Just leave this as-is please, it's fine.

thanks,

greg k-h
