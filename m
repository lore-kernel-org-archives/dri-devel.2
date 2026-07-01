Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6BA9C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 18:16:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D856810E3E3;
	Wed,  1 Jul 2026 18:16:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Ra3F39Ti";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF04F10E3E3
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 18:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782929764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SQoEdvMv6/pXDC6SALGlSvWerPwNr5G1/PmjYcz5yCE=;
 b=Ra3F39TiGqhhX6QbHdhBIGR0QqwTTOCytwVbYmF6Po+rRJxlIL3XhRm5nsFDmVXFlU9fFt
 9eZcOf6UOn4L95M2CfxevtufBqxipn/+VApAtTe/O6jKIRRzDHuP4aNvbxvjPGuDiC+iZj
 OVHdchxts7xzW1BoauTERTxtGCGSk+Q=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-07lXfMMgP2WWzaIgWcitwg-1; Wed, 01 Jul 2026 14:16:03 -0400
X-MC-Unique: 07lXfMMgP2WWzaIgWcitwg-1
X-Mimecast-MFC-AGG-ID: 07lXfMMgP2WWzaIgWcitwg_1782929763
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1d7886cdso15919321cf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 11:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782929763; x=1783534563;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SQoEdvMv6/pXDC6SALGlSvWerPwNr5G1/PmjYcz5yCE=;
 b=NSRu2K7yjQ/KnIUTTwhoThV/JLRDAmW4zlsquoKi2DtvuSl39X+b49yNW7n4VfzK+s
 r7S8Ww2SPsf6+6oFmUA53OV1MuGaxOMbt89AVlYJaSUMSdm8/z/i3rX7/jvhsweo8n4L
 wL0gtErNKzI41RUvU62CQhhNB+aBRPRdohDEzeQgv5E3VPGm3c2ZsFiYAV+cCEYZZqeX
 oj3RzjjzaSSf6oQj2yU74JWHBWV/x1v2LDpy0ghRHSSeKgXs99GYBJRzLrpesPedZdaw
 NW052NExYdJAXTab095gW/495Vbc5o7PmLO/5zeaO27249+3/Foxm8ExRSGl3gHyFuZm
 r92g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9lk+nOe/fd29ju2Bb7RpBISGve14r9IXZHjKoiKFHRwgdZiiQHf+3dYbYCakOpdquslhF0/CAlAG4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw7BMf6N6vxyq4zjDivdF48j8RTSoWvHQFEU1e/W4VudkcWmYKm
 sSPPA2ben0oad1SoPWHN4+JNhHBW8u5wu51NevqJX01LvEW78CDGofQR0S5d+e5vhEfiQYDeVBe
 FSmFWotdVb+Wy7OwXmF9iwl2OaHRIUHIRfVNOCBXUdIq0quRRplvl1JdX/P7HSrOhP0hS9w==
X-Gm-Gg: AfdE7cmtg1ykRy31/I2U6b/dn0Qu/PYhqUENqpw1VAZXF0ssH7+Hi+A2ySwx6aBqaFH
 4U8fcxZ1PjAFUJasCz7EM5G5rFnqFZwiwD4vUDd4aPcH1l8MZiKJf8IQtjyfhuAPs4CFzJYm/Uw
 778RqzKlmzC5qUMiJvHPT8Gj4H8aOQFtv6lwU0GfsBYxrl+XWknL2GNpZ3PEF9qnGNF795IcK1n
 hOjwTNCAl+vi/5/PusadGsr3C/krjSsGHoifrt7kkY1YgGxdPqEAXrqLSP4ZDcOq35gdAScwpc2
 zqwH+O0EvBL3u83KGquSokB+qbl6H9dMIkC7XnzNf6rw8ObFaeWTN8Qs8wZsvmEqV3NAzfoFbYY
 f4LMi3RQ=
X-Received: by 2002:a05:622a:997:b0:51c:a70:5ed with SMTP id
 d75a77b69052e-51c26a7ea3fmr38528921cf.30.1782929762923; 
 Wed, 01 Jul 2026 11:16:02 -0700 (PDT)
X-Received: by 2002:a05:622a:997:b0:51c:a70:5ed with SMTP id
 d75a77b69052e-51c26a7ea3fmr38528451cf.30.1782929762509; 
 Wed, 01 Jul 2026 11:16:02 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51c10a360e0sm51905511cf.30.2026.07.01.11.16.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 11:16:01 -0700 (PDT)
Message-ID: <b23948367e3580f45c1d6d61db6e38b582f219db.camel@redhat.com>
Subject: Re: [PATCH v2 1/4] Revert "nouveau/gsp: fix suspend/resume
 regression on r570 firmware"
From: lyude@redhat.com
To: Danilo Krummrich <dakr@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Timur Tabi
 <ttabi@nvidia.com>,  Dave Airlie <airlied@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Ben Skeggs	 <bskeggs@nvidia.com>, Kees
 Cook <kees@kernel.org>, Simona Vetter <simona@ffwll.ch>,  David Airlie
 <airlied@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard
 <mripard@kernel.org>,  Mel Henning <mhenning@darkrefraction.com>
Date: Wed, 01 Jul 2026 14:16:00 -0400
In-Reply-To: <DJMIGDHFYCIA.271V0T10TID2J@kernel.org>
References: <20260629224350.2870201-1-lyude@redhat.com>
 <20260629224350.2870201-2-lyude@redhat.com>
 <akOuPQ37-zxIJWWH@ashevche-desk.local>
 <DJMIGDHFYCIA.271V0T10TID2J@kernel.org>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YcHbgpsCBYjpt6-6lZAsl9RC6FcmH4rGTZ29Z5XrTtY_1782929763
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

Sounds good to me - will update the patches with this on the next
respin, which should get sent out in a moment.

On Tue, 2026-06-30 at 18:05 +0200, Danilo Krummrich wrote:
> On Tue Jun 30, 2026 at 1:53 PM CEST, Andy Shevchenko wrote:
> > On Mon, Jun 29, 2026 at 06:42:33PM -0400, Lyude Paul wrote:
> > > This reverts commit 8302d0afeaec0bc57d951dd085e0cffe997d4d18.
> > >=20
> > > It turns out this looked like the right fix on some systems, but
> > > it's not -
> > > as this causes runtime PM to actually fail on many a laptop.
> > >=20
> > > [I have set the fixes to an older commit then the one that is
> > > reverted
> > > here, because when applied with the other patches in this series,
> > > this
> > > appears to /fully/ fix runtime PM in addition to the regression]
> >=20
> > No need to have this in the commit message, move it to the comment
> > block...
> >=20
> > > Fixes: 53dac0623853 ("drm/nouveau/gsp: add support for 570.144")
> >=20
> > I'm not sure, actually, that this is a correct approach. You can't
> > revert
> > something that never appeared (in time range between 53dac0623853
> > and
> > 8302d0afeaec). Have you consulted with the stable kernel process
> > documentation
> > and/or respective maintainers?
>=20
> I think it should be as simple as picking
>=20
> Fixes: 8302d0afeaec ("nouveau/gsp: fix suspend/resume regression on
> r570 firmware")
> Cc: <stable@vger.kernel.org> # v6.19+
>=20
> for this commit and keep patches 2, 3 and 4 as they are.
>=20
> The commit message of this revert can then explain that the commit
> that was
> attempted to fix with this revert, i.e. commit 53dac0623853
> ("drm/nouveau/gsp:
> add support for 570.144") is fixed with a different, subsequent
> approach.
>=20
> This seems correct, as reverting a bad fix does not claim to solve
> the original
> problem.
>=20
> Thanks,
> Danilo

