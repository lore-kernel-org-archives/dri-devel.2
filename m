Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E5C0C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 09:23:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF5EE10EC23;
	Tue,  7 Jul 2026 09:23:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZQ80bHMs";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32FDD10EC10
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 09:23:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D984D439A9;
 Tue,  7 Jul 2026 09:23:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43BBE1F000E9;
 Tue,  7 Jul 2026 09:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1783416180;
 bh=UaQwlQnyCdvbuPHBNAIA3OiyxH9sx25jbkvaRh2ZHk0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ZQ80bHMsCyg2muDZI/f5f3lWDTOQarmhBBYNYcWNWGkgQpA2MnsDVscSOO+/VxBNI
 Kq35GnqvQI3fMN837+PxAKRnvaJefGuicPbN/ZRmDe8SNb6PwAcyRPw7Ynd1AuP8fl
 ZL1CWcZkNR7ETjaE9sU5PROwnjXnL+SiKtuMaw+U=
Date: Tue, 7 Jul 2026 11:22:58 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Keefe Reeves <reeveskeefe@gmail.com>
Cc: andy@kernel.org, abdun.nihaal@gmail.com, error27@gmail.com,
 chintanlike@gmail.com, namcao@linutronix.de,
 niejianglei2021@163.com, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: fbtft: use %pe for backlight errors
Message-ID: <2026070747-skype-exit-5962@gregkh>
References: <20260614201551.20542-1-reeveskeefe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260614201551.20542-1-reeveskeefe@gmail.com>
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

On Sun, Jun 14, 2026 at 05:15:51PM -0300, Keefe Reeves wrote:
> Coccinelle found two places where backlight registration errors are
> printed by passing PTR_ERR() to dev_err().
> 
> Use %pe instead so the error pointer can be printed directly. This keeps
> the behavior the same and just makes the error printing cleaner.
> 
> Signed-off-by: Keefe Reeves <reeveskeefe@gmail.com>
> ---
> Changes in v2:
> - Use reachable Gmail address for author and Signed-off-by.

Does not apply to my tree :(
