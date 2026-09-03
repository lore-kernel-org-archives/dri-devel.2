Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85480C79F80
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:34:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 191A810F409;
	Thu,  3 Sep 2026 07:33:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="Ez1tnr+Z";
	dkim-atps=neutral
Received: from mail-244105.protonmail.ch (mail-244105.protonmail.ch
 [109.224.244.105])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2B6E10E096
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 06:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=ofgevln3gndg5pw64ndm4aaegm.protonmail; t=1788418681; x=1788677881;
 bh=xlNfBWyxLeaZeOhAjIUuyj9Pnb/osqZGOp4mRSgnE48=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=Ez1tnr+ZuDBnfVMQlsJ2SXrwbhrj6eYTjKFzw31xtzxGputQs8WXaZ5e9UYxs2+ee
 bPxX691wSOzwo9ps8ocuhUCZWw/nLECppdP8NKn8k0VfI4ZPbMNoZjbsP0bHoJTsc7
 O/gwyWBPlSOGllcpfpGJCVc7Qxxt2gpQOfhQYJO/daO3M2Ef0SJDBU0LD20TTnYSbi
 FtdsAxtHIPDrYdE1NLoeLz8bKtFiQ77JyAitXHmQVt4PuwjyyqsV8Ym90Ek1P3Nlqj
 m8OGeVubEd1Akt25BlGXWSGfjTjPsM8UVwITfeGccB4RuxYRc/y8IL2JsOQ6/QzVPL
 RQ1btGDEDnsJA==
Date: Thu, 03 Sep 2026 06:57:54 +0000
To: Thomas Zimmermann <tzimmermann@suse.de>
From: Aditya Garg <gargaditya08@proton.me>
Cc: Aditya Garg <aditya.garg@linux.dev>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 David Airlie <airlied@gmail.com>, Aditya Garg <gargaditya08@live.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] MAINTAINERS, mailmap: use Aditya Garg's linux.dev account
Message-ID: <txsiv43u7qv-Pc_dRDdbgiUHVP54rhl5g-xLzQU457o0E29MYkL9FX-zdozYxVySvTed10VduLizWQw3zNDJTGxTIfFLX71G3U_Kj3qnJao=@proton.me>
In-Reply-To: <27a31a37-688d-427b-a0ba-c3133db19c97@suse.de>
References: <20260723100136.14467-1-aditya.garg@linux.dev>
 <27a31a37-688d-427b-a0ba-c3133db19c97@suse.de>
Feedback-ID: 145777226:user:proton
X-Pm-Message-ID: bdf5f16474591009c906f0f2402f43902894299f
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 03 Sep 2026 07:33:13 +0000
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

Hi

>=20
> Am 23.07.26 um 12:01 schrieb Aditya Garg:
> > From: Aditya Garg <gargaditya08@live.com>
> >
> > Due to non standard IMAP and SMTP protocols by Proton Mail, the account
> > was giving trouble. Since my linux.dev account has been approved, all
> > communication related to Linux development shall now be done there.
> >
> > Signed-off-by: Aditya Garg <aditya.garg@linux.dev>
>=20
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

Can someone please merge this. I am still receiving mails on my old email w=
hich I do not use for dev work anymore.

>=20
> > ---
> >   .mailmap    | 3 ++-
> >   MAINTAINERS | 2 +-
> >   2 files changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/.mailmap b/.mailmap
> > index 501d858cb..baea6ba4d 100644
> > --- a/.mailmap
> > +++ b/.mailmap
> > @@ -19,7 +19,8 @@ Abhinav Kumar <quic_abhinavk@quicinc.com> <abhinavk@c=
odeaurora.org>
> >   Ahmad Masri <quic_amasri@quicinc.com> <amasri@codeaurora.org>
> >   Adam Oldham <oldhamca@gmail.com>
> >   Adam Radford <aradford@gmail.com>
> > -Aditya Garg <gargaditya08@proton.me> <gargaditya08@live.com>
> > +Aditya Garg <aditya.garg@linux.dev> <gargaditya08@live.com>
> > +Aditya Garg <aditya.garg@linux.dev> <gargaditya08@proton.me>
> >   Adriana Reus <adi.reus@gmail.com> <adriana.reus@intel.com>
> >   Adrian Bunk <bunk@stusta.de>
> >   Ajay Kaher <ajay.kaher@broadcom.com> <akaher@vmware.com>
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 1ab873685..f32e63428 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -7970,7 +7970,7 @@ F:=09drivers/gpu/drm/sun4i/sun8i*
> >
> >   DRM DRIVER FOR APPLE TOUCH BARS
> >   M:=09Aun-Ali Zaidi <admin@kodeit.net>
> > -M:=09Aditya Garg <gargaditya08@proton.me>
> > +M:=09Aditya Garg <aditya.garg@linux.dev>
> >   L:=09dri-devel@lists.freedesktop.org
> >   S:=09Maintained
> >   T:=09git https://gitlab.freedesktop.org/drm/misc/kernel.git
>=20
> --
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstr. 146, 90461 N=C3=BCrnberg, Germany, www.suse.com
> GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG N=C3=BCrnberg)

