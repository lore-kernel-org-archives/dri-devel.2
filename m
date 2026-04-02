Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C96CC6B00
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 06:32:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC89110F122;
	Thu,  2 Apr 2026 06:32:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mZZQtqxA";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB3D610F122
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 06:32:52 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E5D496185D;
 Thu,  2 Apr 2026 06:32:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01699C19423;
 Thu,  2 Apr 2026 06:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1775111571;
 bh=IbrsCewlRMx8yPHGJ6f9rRG1sosTeQU+3FvY0dtbDRg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mZZQtqxAzvVUrl92eeN0he1CcuMgqn8Uck1btP4e2NX6Mxu5sC1LalOJgYN/+yvCV
 E9gQCvrHJtdFBD15ykeykdFlqIqEs74AlqzDBQG5ItGwWwySu3oWhwFRigbkJ3LXYO
 WAe4KbbmsWhd0kZpnu0k/FaIF0FtJAf7A0zzeKrY=
Date: Thu, 2 Apr 2026 08:32:24 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 stable <stable@kernel.org>
Subject: Re: [PATCH] drm/ioc32: stop speculation on the drm_compat_ioctl path
Message-ID: <2026040200-cuddly-macaw-8474@gregkh>
References: <2026032451-playing-rummage-8fa2@gregkh>
 <3f43bc40-58a9-43b2-b21d-7487fb180b57@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f43bc40-58a9-43b2-b21d-7487fb180b57@suse.de>
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

On Thu, Apr 02, 2026 at 08:20:27AM +0200, Thomas Zimmermann wrote:
> 
> 
> Am 24.03.26 um 17:42 schrieb Greg Kroah-Hartman:
> > The drm compat ioctl path takes a user controlled pointer, and then
> > dereferences it into a table of function pointers, the signature method
> > of spectre problems.  Fix this up by calling array_index_nospec() on the
> > index to the function pointer list.
> > 
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Simona Vetter <simona@ffwll.ch>
> > Cc: stable <stable@kernel.org>
> > Assisted-by: gkh_clanker_2000
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Also acked by Sima and Maxime via IRC
> 
> https://people.freedesktop.org/~cbrill/dri-log/?channel=dri-devel&highlight_names=&date=2026-04-01&show_html=true
> 
> Acked-by: Maxime Ripard <mripard@kernel.org>
> Reviewed-by: Simona Vetter <simona@ffwll.ch>

Great, thanks, I'm assuming some drm developer can pick this up then?

greg k-h
