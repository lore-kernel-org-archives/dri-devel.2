Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42915F506D2
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 14:12:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5205A10E256;
	Mon, 16 Mar 2026 14:12:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gEff0gxx";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1651310E256
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 14:12:11 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 4C65F60123;
 Mon, 16 Mar 2026 14:12:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 789C4C19425;
 Mon, 16 Mar 2026 14:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773670330;
 bh=JVbA7bJ4RaGLmmsobnfcRk7dRZ71K/szq0l3MYZW5lI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gEff0gxxcklGrJNPhLUTdbO6jlaStlXm2i6D7T+S9y3f46krN03TNR5NdPu2iafx7
 jBGsAD+CuzeQz1nm/A+revElz015tJNIbJt9kVWwvAcw9JrhzFKWnAdAyfjrCxcxll
 V6dVUnRmEihhv49jZitxOvCrmwfVCoeFkKvntWtJWzFl8HUB/PfX5q0cEdULuD+j0F
 IkUc2xVcQfamKmrQ3l0Xx6KwzcsSHZuR96rYJGEefDdoJKbIEZdenSfu9fgfg+ZjLo
 0gnnWp2ifzFh/e+JtfuVR+0fzeY1TlAjVXB9i0kfG+g4F1h8y1qXutqfocLe/AZpjm
 70hBF+lfDAO0w==
Date: Mon, 16 Mar 2026 14:12:05 +0000
From: Lee Jones <lee@kernel.org>
To: Kit Dallege <xaum.io@gmail.com>
Cc: Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] backlight: cgbc_bl: fix kernel-doc comment for
 struct cgbc_bl_data
Message-ID: <20260316141205.GA554736@google.com>
References: <20260315145802.24224-1-xaum.io@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260315145802.24224-1-xaum.io@gmail.com>
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

On Sun, 15 Mar 2026, Kit Dallege wrote:

> Add the required 'struct cgbc_bl_data -' prefix to the kernel-doc
> comment so it is properly recognized as struct documentation.
> 
> This fixes the following warning:
> 
>   drivers/video/backlight/cgbc_bl.c:29: This comment starts with '/**', but isn't a kernel-doc comment
> 
> Signed-off-by: Kit Dallege <xaum.io@gmail.com>
> Signed-off-by: kovan <xaum.io@gmail.com>

Real names please.

-- 
Lee Jones [李琼斯]
