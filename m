Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1786CC43602
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 18:05:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C53410E042;
	Wed,  1 Jul 2026 18:05:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="XLqsbGBN";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BF3610F0A3
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 18:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782929112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OODTaDnvsDCSyQDqhi+9lLSiHjNYGjnSHMMEy2JQgew=;
 b=XLqsbGBNNYxz8/xVpUxAIwaANxaCcg3BI9XebbIyfd9vsaR0aKwIdmbotrN2Q/U2pUwpWE
 rtNl0H4247LX85Q3V26J4F/SPRx6tkB4/sxPhuMGLKUc9FytZqZeKTvouJXAci8qIGD2P4
 kWmVOaWBympPAo8zc6uZX/QQVn3aJgk=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-TofXNON7PMSFweFpq1tVCw-1; Wed, 01 Jul 2026 14:05:09 -0400
X-MC-Unique: TofXNON7PMSFweFpq1tVCw-1
X-Mimecast-MFC-AGG-ID: TofXNON7PMSFweFpq1tVCw_1782929109
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-9674fae89e9so66564241.3
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 11:05:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782929109; x=1783533909;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OODTaDnvsDCSyQDqhi+9lLSiHjNYGjnSHMMEy2JQgew=;
 b=KkiBG9X/1bxN8PjGkvliWKjGLLXqu+LpJeGsY0fSBpIDG1GTuzY83RxvxTyYC4X8da
 9COezLDTZWHvr0s5RrN3Mo0y7PM9oXjjKqFkJEEu2kC1v1gx8k04lblM2kYT9LUp+nuY
 WJkMMlLWxPNirb/P/GvOigdxMG7yxURc6Zd/9W6+E6egz/D0PVAxeJKZ9Oe7sJUh8oQJ
 vpVMootpPwGqNUA84loY3RZS0hK9xDB+sQ7dgD2qf5/gh7eepUG5j/yB4HwOPCd8RWiZ
 01fMgTxM8XA3PVUiYBr4wSL4/gqNQ7SKR9gnm445dOvebvWVOo3tk6EEJJgiTYE1ycqK
 mYug==
X-Forwarded-Encrypted: i=1;
 AHgh+RoNujhAvO6gMGZ5hG3EXh/90ElZlMjp4erOlUX8lxvYAsAtOtnNRmJCJqcN8w1tVh0GmKaNAZcupiY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxOLUndj3xTEBahCJ3eRUwodHBaNknKvlfTGoLVmGszu5sfIWhQ
 vTQJXuAwLl65d2aHrkTm2U8xxPO/GmqnnSKGVcigjlOI0uQ/QaZmGHOT54GCNvXCWSmooynXsQZ
 XYqK1x6PfwKVB+mWgVgl0IgYfo9EcA2YDsCHKTz/3xkn5vCS+vfFP42pPg5AeizRcMgioIA==
X-Gm-Gg: AfdE7clwF8r393tJfnkqU+uY335Avk8rwtufMU1lI9dNKX3zrvEWUL6ZJwvyayexDN9
 ykpZnDF0DOND1haKGgoEIzU62/ID4kz3L1MSy7YLqGsh5P2SgL/81CXb3OK79F7PC9Mfx6IafAn
 QPyICpG8jQuN0engUMh1O82VtRAdH8IfK6YnDXPME2f9X/UnZHhrXPhxDHNfa2U2rA5bgpU4Ooj
 v/G0zt/lgzDauicxufSezidhI241jUxpi1BwcqNMBJ6lVO1LBxUcjgbOhJm1Z9o/kuHYPMgZX2l
 jHid/Wvc0o0rvmb7DzIOC/E3ei+2grBDsPGdfB81dcR0QeF5GzalWWMcPWcWY9FeQLy+A1vcpbg
 6RNPjv7M=
X-Received: by 2002:a05:6102:161e:b0:739:8c52:f2b with SMTP id
 ada2fe7eead31-73dab0e55b1mr1293971137.18.1782929109020; 
 Wed, 01 Jul 2026 11:05:09 -0700 (PDT)
X-Received: by 2002:a05:6102:161e:b0:739:8c52:f2b with SMTP id
 ada2fe7eead31-73dab0e55b1mr1293859137.18.1782929108349; 
 Wed, 01 Jul 2026 11:05:08 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f46e371bdfsm3587256d6.1.2026.07.01.11.05.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 11:05:07 -0700 (PDT)
Message-ID: <a364263867ac16831a93e3ca3a5e4125da347c91.camel@redhat.com>
Subject: Re: [PATCH v2 0/4] drm/nouveau/gsp/r570: Fix runtime PM
From: lyude@redhat.com
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Timur Tabi <ttabi@nvidia.com>, Dave Airlie	
 <airlied@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Ben Skeggs <bskeggs@nvidia.com>, Kees
 Cook <kees@kernel.org>, Simona Vetter <simona@ffwll.ch>, David Airlie
 <airlied@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard
 <mripard@kernel.org>, Mel Henning <mhenning@darkrefraction.com>, Danilo
 Krummrich <dakr@kernel.org>
Date: Wed, 01 Jul 2026 14:05:06 -0400
In-Reply-To: <akOthKT6XeaUnhH6@ashevche-desk.local>
References: <20260629224350.2870201-1-lyude@redhat.com>
 <akOthKT6XeaUnhH6@ashevche-desk.local>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jreMsJffU7VI68CVi94RBq0zQkrTNmvEPLcucxbTDyY_1782929109
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

I forgot to link to the previous series:

https://patchwork.freedesktop.org/series/169227/

I also thought i hadn't sent a cover letter for it, but apparently I
did - I would have reused that if I realized, whoops.

Regardless: I'll be sending out a V3 today, since after doing a lot of
testing I came to the conclusion we should drop the change from LEVEL_3
to LEVEL_4 but keep pretty much everything else for now.

On Tue, 2026-06-30 at 14:50 +0300, Andy Shevchenko wrote:
> On Mon, Jun 29, 2026 at 06:42:32PM -0400, Lyude Paul wrote:
> > Runtime PM has been kind of unreliable with GSP for a while. It
> > works
> > well enough to shut the GPU off and turn it back on, but more often
> > then
> > not it ends up leaving the GPU in a broken state on resume - which
> > makes
> > it impossible to really do anything else with it.
> >=20
> > Recently however, I discovered that it's been failing much harder
> > on
> > some ampere systems. This lead me down a rabbit hole that lead me
> > to
> > figure out one of our previous fixes for runtime PM wasn't correct.
> > After fixing that and combining it with some fixes we had tried in
> > the
> > past without success, I finally managed to get nouveau to handle
> > runtime
> > PM with the GSP perfectly. These are those fixes.
> >=20
> > Tested on a Lenovo P16 G1 (100 runtime PM cycles!), and RTX4000.
>=20
> This is v2, and no changelog. What's going on?

