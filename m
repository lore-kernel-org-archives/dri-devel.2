Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04193CD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 07:44:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CBA210E0F8;
	Wed, 27 May 2026 07:44:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r3nWNzFe";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D221410E0F8
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 07:44:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A7680600AB;
 Wed, 27 May 2026 07:44:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C532D1F000E9;
 Wed, 27 May 2026 07:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1779867847;
 bh=tfFS6/3RtinD24WiePqqDtA2dthvYf7JUJpWHhbHy0s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=r3nWNzFe1x+FWlwqe8M7wuYoo9hPuxTQStSeyFR81qINvTbkDupz+mF2jtNKN/9cA
 qYvfO54MnLIVJgJBXbrGMmDM7LgBDICf+2ljcKw5O9q1tbGua7+Dp8gN7tqI9iPp8K
 2hhGnfSYHchxguk3YqOTIlPJQNPoDnKIy11FcTLA=
Date: Wed, 27 May 2026 09:43:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: xlabai <xlabai@tencent.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, security@kernel.org, dri-devel@lists.freedesktop.org,
 =?utf-8?B?eGxhYihNSUflronlhajlrp7pqozlrqQp?= <xlab@tencent.com>
Subject: Re: Security: handle_count underflow in drm_gem_change_handle_ioctl, 
 leading to use-after-free
Message-ID: <2026052754-remarry-garbage-1396@gregkh>
References: <61E60951F9DE2D29+59E7E080-B725-486B-83F2-5F3398F8FE80@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61E60951F9DE2D29+59E7E080-B725-486B-83F2-5F3398F8FE80@tencent.com>
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

On Tue, May 26, 2026 at 05:02:45PM +0800, xlabai wrote:
> CVE and credits are preferred.

<formletter>

Please see:
        https://www.kernel.org/doc/html/latest/process/cve.html
for how kernel CVEs are assigned.

</formletter>
