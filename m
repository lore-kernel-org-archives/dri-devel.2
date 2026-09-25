Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C0EC9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 19:52:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0A8510E0E6;
	Fri, 25 Sep 2026 19:52:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="N/ZYWroD";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=valla.it header.i=@valla.it header.b="QJx4pD3h";
	dkim-atps=neutral
X-Greylist: delayed 1232 seconds by postgrey-1.36 at gabe;
 Fri, 25 Sep 2026 19:52:43 UTC
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C897510E0E6
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 19:52:43 +0000 (UTC)
ARC-Seal: i=1; cv=none; a=rsa-sha256;
 d=outgoing.instance-europe-west4-0jng.prod.antispam.mailspamprotection.com;
 s=arckey; t=1790365963; 
 b=r1bg+JDvluBZDTFWBvfLswoZYLh7IQMZY3Gbji7LIBIiXx27goVStVdrVyLIWuJRcen4/ur7/C
 43A0tBvDeUB5jxdy8V+bG/gsfVSVX9+JqXPqdDqSHBYpVwDytPxLOwD5RxtSTdFXnt8B8cvopM
 aBdIdRtRz3cBUCwpF/tcRQFyL13ogzhI5xq90ojyPqLCx6pW7hK0yMW7Gsfe2iSHJqQaqXrhrx
 0aDVS6f21wxhU1QjpDlU0NqacPsgYr0T1bAmZOkeqWZx2trOi+qa8KW8woAgokpw8y6XK0L+QG
 zZnKJ7k7h+5tRqExhOdp2TJRjCF9MpxQ+2gZb+yoxFPgTQ==;
ARC-Authentication-Results: i=1;
 outgoing.instance-europe-west4-0jng.prod.antispam.mailspamprotection.com;
 smtp.remote-ip=35.214.173.214; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed;
 d=outgoing.instance-europe-west4-0jng.prod.antispam.mailspamprotection.com;
 s=arckey; t=1790365963; 
 bh=oN779mH9tBNwuA7d/NdNWDGQm450ycX3DX6zJkalp1I=;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:DKIM-Signature:DKIM-Signature;
 b=JIUKfDRINNaM7FhQB26Kt04+KGSfwspy0qS/hfLrLXYxEsxYTkV4lSb9b2Md3ykF/irGY5USKG
 RThQ3tZliLrFM6XXHtzJypxbzpEJKqZb1ku7sejt8z2RYhQmfWTMQDKIUMmrFoqhk9ypiH4CK7
 uziAX5HXtDwHHEF5RY9HvUmgc6MFogMl3Cv/iSx6DUih1yytN/w7HNMyRCxg+KYVqhlkA33TgA
 DQQz3isVlQME2pkNG1k9mkk5/fmsqjWpkxaL7hoTUzq99vRd+4i9xIKsz6AOUlxvpdUBasq/F6
 MpB1/s/8umEY5tKZIUMX+TYxZ2YTJ86nfUxB9cF8a25acg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Subject:Cc:To
 :From:Date:Reply-To:List-Unsubscribe;
 bh=yvE3X9fHZurwYk916e+LX2mNqDb/QFApCbGFkhBpWsI=; b=N/ZYWroDCu66Qe9k9RN68/m9L+
 F+wqXASRmB9HcjXLKK3uxGBDAQ0NkOjHExkrtKlz/74fGoYCHb+xNAyx7/YMjBHOSWnlx1kcSE93F
 93wohbCI7uQ8gNcAD3eGWfb7dz5BYANek+Mwz0mhSTaIWYmja6kiJHnnC/buWB+GNQv4=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-0jng.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <francesco@valla.it>) id 1xABeS-00000006ZRx-1ydM
 for dri-devel@lists.freedesktop.org; Fri, 25 Sep 2026 19:32:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=yvE3X9fHZurwYk916e+LX2mNqDb/QFApCbGFkhBpWsI=; b=QJx4pD3h5WMfaRo9W0EvTF6goY
 BapWrz5179rvyOrHL6dOengJgj79GvD7dKfyewvov+Nugo+OfX96ypdaC3dlJTBXc+fIntYohkNaQ
 yqV/99qP3sCHq4vcZKBQ2bzgfS+dcQ0cKhD4RQb9qDIAOqhvvJWwEYmxQVBxzaNbHnMk=;
Received: from [79.45.60.29] (port=62784 helo=bywater)
 by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.100.1) (envelope-from <francesco@valla.it>)
 id 1xABeI-00000000BOp-0kv1; Fri, 25 Sep 2026 19:31:58 +0000
Date: Fri, 25 Sep 2026 21:31:56 +0200
From: Francesco Valla <francesco@valla.it>
To: =?utf-8?B?TcOgeGlt?= Pedraza Padilla <maximpedraza@gmail.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Helge Deller <deller@gmx.de>, 
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Maxime Ripard <mripard@kernel.org>, linux-fbdev@vger.kernel.org,
 devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] Boot logo supplied by the device tree
Message-ID: <arbLHvCBqxG7zcf_@bywater>
References: <20260923201035.51007-1-maximpedraza@gmail.com>
 <64e273d4-2660-437d-8871-e2bfa3c377c9@suse.de>
 <CAEUXW=G2a=Qz-9P_2+EFe-GiW4WqdOjtSCxoO4P15u_J48nP9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEUXW=G2a=Qz-9P_2+EFe-GiW4WqdOjtSCxoO4P15u_J48nP9g@mail.gmail.com>
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.freedesktop.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 03a0908a9906a86d61499e46ecdb2f87
X-AntiAbuse: ID - 03a0908a9906a86d61499e46ecdb2f87
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xABeS-00000006ZRx-1ydM-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-0jng.prod.antispam.mailspamprotection.com; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
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

Hi Màxim,

On Fri, Sep 25, 2026 at 10:48:31AM +0200, Màxim Pedraza Padilla wrote:
> Hi Thomas,
> 
> > the whole Linux logo on the console is somewhat gimmicky and IMHO should
> > not be further extended. Also fbdev as a whole has realistically run its
> > course. We fix bugs and occasionally clean up the code, but it is
> > questionable whether new feature make much sense. Even more so as the
> > drivers your system uses appear to be DRM ones.
> 
> They are, it is tilcdc. Understood, I will drop the fbdev side, which
> also settles your comment on patch 1.
> 
> > There is a proposal for a DRM splash screen at [1]. It retrieves the
> > device vendor's logo from the firmware and displays it at the given
> > coordinates. IMHO you should start with this series and add DT support
> > there.
> 
> Agreed. I have been following Francesco's series since Sam pointed me
> at it, and it is where the DRM follow-up I mentioned in the cover letter
> belongs, rather than in a client of my own.
> 
> A device tree source fits next to the BGRT one. The BGRT is the firmware
> handing the kernel an image and where to put it, and a DT system has no
> such table. The BMP loaded as firmware only helps if the file is built
> into the kernel, or if a filesystem is already there when the display
> comes up. With U-Boot's Falcon mode, the device tree is the only thing
> that reaches the kernel.
> 
> So the plan would be a node under /chosen carrying a BMP, either in the
> node itself or in a reserved memory region the bootloader loaded it
> into, with the placement properties from this series. The region is the
> same memremap() the BGRT source already does, only with the address
> coming from the device tree.
> 
> Rotation too: the client skips a BGRT image with the orientation bits
> set today, and it could turn it instead. I will ask Rob separately how
> he wants the image described, since that is what the binding hinges on.
> 
> Francesco, is a v4 on the way? Would you take a DT source as patches on
> top of your series, or would you rather I wait until it lands?
> 

v4 is planned but has been preempted by other activities - I am not able
to give you an ETA at the moment. If you have capacity, feel free to
take over.

> Max
> 

Regards,
Francesco

