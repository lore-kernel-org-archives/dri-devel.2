Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9E0606A324
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 22:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=yYt9/FjE;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=df24bgxE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9611710E47E;
	Wed, 11 Nov 2026 22:10:13 +0000 (UTC)
X-Greylist: delayed 804 seconds by postgrey-1.36 at gabe;
 Wed, 11 Nov 2026 22:10:02 UTC
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EAC510E47E
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 22:10:02 +0000 (UTC)
ARC-Seal: i=1; cv=none; a=rsa-sha256;
 d=outgoing.instance-europe-west4-c9nw.prod.antispam.mailspamprotection.com;
 s=arckey; t=1794435002; 
 b=WKnGjHwKS6XmMlK8Mgwn7RtdA0vJ4rMdXU215tzu1q+0QOo8o6djDl85HRPltPbW8FhO9IwWyn
 fJKqfjONtCilwyuYdh2f6n2/RTkSphR7j1aJS9XTSTVSteubbpYSu1xEvIblbs6atF1JGLOwmZ
 yAe/CJBPlveDjPYb9+XjN5WSQm4Dc5HdWGNEF46p7uOjOr880oNacOo63jHHFxSve2Eie2dWhQ
 aF38T8kqGjiJeO3jB5+0LRDV4j7mNQp3c2G8+lo54sWCD/fafTZoJQ2xSCTihn1la5Lt0V7TPw
 odxNt/uUpNT4Pxcsk/uv+75CHCHXPuyt4eWBJMBDw9MKNA==;
ARC-Authentication-Results: i=1;
 outgoing.instance-europe-west4-c9nw.prod.antispam.mailspamprotection.com;
 smtp.remote-ip=35.214.173.214; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed;
 d=outgoing.instance-europe-west4-c9nw.prod.antispam.mailspamprotection.com;
 s=arckey; t=1794435002; 
 bh=ZWHYAXJh8M23GgTHS9F/68nHKMuIi5pIeMMp0ENqHgI=;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:DKIM-Signature:DKIM-Signature;
 b=OUfW6iDpsySyhKoz/sB2HCAYfBg5ZlcHWm9/AY1CFLyNM3W1isvKJpxmZ1OocBs549o/TrZNQd
 Sz5c5zxWIxGZ+tEwq9kmUFg2qRyqhenvRUzCS3BIh1hDnVTKL+lWquo2D1qREN9OoxxM/FkKJg
 aubKZgsHZ4uw3XnaVt6nKVBStEuQpiu+MeaBJ9SrkdQvTZTT1kGDt3b0xLdqHIQ80IgyoMIvoP
 RCmwkDWdYCU7DCn4gLZ5i4rieqGkiWGLpZKfcvm2ekbjwFvBhOwH/sn2aRnGuVjNCwHa1z/jyp
 MLLlIGA/bNYSI/pV37leEBWASG0lM8pVZNcmjFWgtTEh4Q==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Subject:Cc:To
 :From:Date:Reply-To:List-Unsubscribe;
 bh=dJgiLhwnxl07OmJUhfJ5CpoeivoNNwCPag679Wtgjv0=; b=yYt9/FjEvNWNPAeBq2x6TCtLY8
 i8pWUxGVNhf6CmEs2ejHcF7qFdi3NXw9Y7hizXtfFlpuNSDcNiTtfkKlAADdiwOeT6aLjE2G4QKgu
 TsrKrJpl9x3WHEkWjQBNRJ8+++vFxHB8MPU8PzZxAnzqDFID62DH3l9GX8zBWbiu3b+I=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-c9nw.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <francesco@valla.it>) id 1xRGJ2-0000000H9Mr-0tmk
 for dri-devel@lists.freedesktop.org; Wed, 11 Nov 2026 21:56:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=dJgiLhwnxl07OmJUhfJ5CpoeivoNNwCPag679Wtgjv0=; b=df24bgxEnOqCeuhgE5/Vkt7aYo
 NqMMrcKi2X0+MPYvvdEA0l97DuzRosc+bZCoNUxVo+/HXKbeAjRI+DthEMN0VJGE9pJu2Bf5zBWHf
 3b1JA1B2t61gBHNDk6N2At/yfb9+GePnBCmJTdpKBhvEqfCSddqPd/rtIfIgv14ZgF8k=;
Received: from [79.17.15.196] (port=60109 helo=bywater)
 by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.100.1) (envelope-from <francesco@valla.it>)
 id 1xRGIe-00000000J0c-38Lm; Wed, 11 Nov 2026 21:56:12 +0000
Date: Wed, 11 Nov 2026 22:56:10 +0100
From: Francesco Valla <francesco@valla.it>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: =?utf-8?B?TcOgeGlt?= Pedraza Padilla <maximpedraza@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Ard Biesheuvel <ardb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Helge Deller <deller@gmx.de>, 
 Peter Jones <pjones@redhat.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
 Mario Limonciello <mario.limonciello@amd.com>,
 Javier Martinez Canillas <javierm@redhat.com>, 
 Jocelyn Falempe <jfalempe@redhat.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, 
 linux-efi@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-doc@vger.kernel.org, 
 linux-embedded@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 05/15] MAINTAINERS: add entry for DRM splash client
Message-ID: <avTjrfIEPgyvPDti@bywater>
References: <20261027135342.2003632-1-maximpedraza@gmail.com>
 <20261027135342.2003632-6-maximpedraza@gmail.com>
 <ed28619d-6ca7-46aa-82c0-c83f30a836e3@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed28619d-6ca7-46aa-82c0-c83f30a836e3@suse.de>
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.freedesktop.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: ea84ef1a134848d52f388e099e885f13
X-AntiAbuse: ID - ea84ef1a134848d52f388e099e885f13
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xRGJ2-0000000H9Mr-0tmk-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-c9nw.prod.antispam.mailspamprotection.com; 
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
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Wed, Nov 11, 2026 at 02:31:51PM +0100, Thomas Zimmermann wrote:
> Hi
> 
> Am 27.10.26 um 14:53 schrieb Màxim Pedraza Padilla:
> > From: Francesco Valla <francesco@valla.it>
> > 
> > Add myself as maintainer for the DRM splash client.
> > 
> > Signed-off-by: Francesco Valla <francesco@valla.it>
> > [Màxim: add myself as co-maintainer]
> > Signed-off-by: Màxim Pedraza Padilla <maximpedraza@gmail.com>
> > ---
> >   MAINTAINERS | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index a08087fb6e67..321ecb9f5b5b 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -9168,6 +9168,14 @@ F:	Documentation/gpu/drm-ras.rst
> >   F:	drivers/gpu/drm/drm_ras*
> >   F:	include/drm/drm_ras*
> > +DRM SPLASH
> > +M:	Francesco Valla <francesco@valla.it>
> > +M:	Màxim Pedraza Padilla <maximpedraza@gmail.com>
> 
> I don't think Francesco should be listed here. Although he wrote the initial
> implementation, it's yours now.  Maybe list him as R: if you want to.
> 

I agree with Thomas here, you definitely did most of the work and
deserve to be the maintainer. Feel free to keep me as a reviewer though,
I'll be happy to help!

> 
> > +L:	dri-devel@lists.freedesktop.org
> > +S:	Maintained
> > +T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
> > +F:	drivers/gpu/drm/clients/drm_splash.c
> 
> This patch should be merged with the one that added drm_splash.c.
> 
> Best regards
> Thomas
>

Regards,
Francesco

