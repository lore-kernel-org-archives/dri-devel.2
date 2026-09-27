Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0EAEC9832F
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 16:40:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE3D510E02B;
	Sun, 27 Sep 2026 16:40:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ObR+bLCN";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70FC310E02B
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 16:40:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 78356601F7;
 Sun, 27 Sep 2026 16:40:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DFC71F000FF;
 Sun, 27 Sep 2026 16:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1790527208;
 bh=QVOQ34sr18ixV7r32sVe/ehF+3x2MfGvdAz1mNuDkgo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ObR+bLCNpIwVDuYFB6Yp+nLHdXusXw8YzDu0btdpUPKvtS4eYAOhuvBG8vTUxArTP
 1UDYUqqk3imKBQn9dnOpOD7rGnFZxB8VbTKluAMq+/WYkkMJqfri4qbxVFohqrGu/F
 zsladJGT0KjzkPcYhcotTsuZmWf4O1Crmgm7GBVA=
Date: Sun, 27 Sep 2026 18:40:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: krishnanand G <krishnanandgeetheswaran@gmail.com>
Cc: andy@kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: fbtft: fix spacing in macro calls
Message-ID: <2026092736-problem-crayon-031b@gregkh>
References: <CAG_41BL-nu7tDFjGgehz9Bf+KKPty8kR6A0RUUUfpepJu4doHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_41BL-nu7tDFjGgehz9Bf+KKPty8kR6A0RUUUfpepJu4doHQ@mail.gmail.com>
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

On Sun, Sep 27, 2026 at 02:48:40AM -0700, krishnanand G wrote:
> >From 5473fd52eeda7ab1f608c414e386dad0ea40bef4 Mon Sep 17 00:00:00 2001
> From: Krishnanand G <118352827+Krishnanand-G@users.noreply.github.com>
> Date: Sat, 26 Sep 2026 19:41:06 +0530
> Subject: [PATCH] staging: fbtft: fix spacing in macro calls
> 
> The two calls to define_fbtft_write_reg() that use the default
> modifier have a space before the closing parenthesis. This triggers
> two checkpatch.pl errors.
> 
> Add an inline comment for the intentionally empty modifier argument.
> It satisfies the spacing check without changing the macro expansion.
> 
> Tests: scripts/checkpatch.pl --no-tree -f --terse --strict
>   drivers/staging/fbtft/fbtft-bus.c
> Signed-off-by: Krishnanand G <118352827+Krishnanand-G@users.noreply.github.com>
> Assisted-by: LLM

Please read the email archives for why both this will not work, AND why
you can not use LLMs on this part of the kernel.

Also, your email address isn't valid :(
