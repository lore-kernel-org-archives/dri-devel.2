Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA93CD37AC
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 13:37:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95BB910E256;
	Sun, 17 May 2026 13:37:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gSAmk0mc";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0D0A10E256
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 13:37:05 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 0FC5E60125;
 Sun, 17 May 2026 13:37:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E60C2BCB0;
 Sun, 17 May 2026 13:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1779025024;
 bh=XBItQR0vR94Zuh6EpUQrFpcBYPbzjlIph/0Y4+O2+nU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gSAmk0mcD4gK5XKJKWTZVWTP8XZPHH57TsuOLwS9FMq1t3AIWQQ5ifH111yDYxs3g
 oUWICt8t+oHtJUJ9H5CJGJFPxA2m5O/qRt3KI4duwbflJ6UCFZXpkn2lq45Mg3/jmn
 LMiKsvpfD+p632v6M8FG8QrXpupTVrY/C0Q4h/zI=
Date: Sun, 17 May 2026 15:37:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Berkant Koc <me@berkoc.com>
Cc: security@kernel.org, Zack Rusin <zack.rusin@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [REPORT] drm/vmwgfx: vmw_cmd_draw header.size lower-bound
 missing - guest-local OOB-read/write
Message-ID: <2026051743-genre-cacti-bdf3@gregkh>
References: <20260517-vmwgfx-uaf-report@berkoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517-vmwgfx-uaf-report@berkoc.com>
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

On Sun, May 17, 2026 at 03:00:00PM +0200, Berkant Koc wrote:
> Happy to follow your standard timeline per Documentation/process/security-bugs.rst
> (typically <=7 days post-fix-merge).

You sent this to a public list, there is no "timeline" needed.

Just submit a fix for this now please.

thanks,

greg k-h
