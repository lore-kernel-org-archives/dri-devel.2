Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0489AC9830E
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 05:53:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3533210E5AC;
	Wed, 30 Sep 2026 05:53:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.b="bjfaviDB";
	dkim-atps=neutral
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20B0F10E5AC
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 05:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org; 
 s=smtpauto.stravinsky;
 h=X-Debian-User:Content-Transfer-Encoding:Content-Type
 :Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
 Reply-To:Content-ID:Content-Description;
 bh=HOfe6eGDXWWjbg16M03Zk0OLLSQFcWlNyWNgDc1U1cw=; b=bjfaviDBFHWVxeZ6pMpxtnv8Sx
 0Vz3JjbyRuT6RnU+pFdwhMcvBDa7lQbk71QYnp6xe4+lCtYnRo8osNnuUu+uNYRzhksl7Dkfv/dWx
 HBNGnEReIvhjsBI9EgV9XgFNOXkFhrthn0rDrFpqKHprTb5W/BFVJCo18IXvrtAR9SqrLU3EU9XxW
 Qd3bh2GMG0yzll0ODJmpEZIZuXdc/0jSRa5K6NW/CSZgegddaQsbMTTMI5A2F0pHReOCzk9uNTC8e
 UxkK5PxATb9id/2zQN9Wv8mPuWaUO5IhkCaIjPSJdmQjcDjKVlip+aO9IJE9SKp+XLuV9Yu1q51OH
 6AXY68DQ==;
Received: from authenticated-user by stravinsky.debian.org with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
 (Exim 4.96) (envelope-from <domibel@debian.org>) id 1xBnFh-008yCi-1e
 for dri-devel@lists.freedesktop.org; Wed, 30 Sep 2026 05:53:14 +0000
Received: by mail-pz2-f42.google.com with SMTP id
 d2e1a72fcca58-86dd69a1b15so1044700b3a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 22:53:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBzXK8qgJL77oi2sJ0iygD22b6G9ADNGi4PJtz2IfRVjier524j735RcTQmtpcY4JbbI3XKHgYv2rd8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mYBCNYYSYZWyLkDmodPv0hWljrJxoriMniOd16Cxp4HhjTM1rO
 52X8aQ4ujxYm+d4sx3kNoUz/aRW2bGcWio8h/XHL+++X/R8zHRPPBhXha+ju7z3UxPjrgsocrfm
 piWG201TxSYKbv6F/dnLjffFPs3OR1HQ=
X-Received: by 2002:a05:6a21:1f8c:b0:3dd:65a5:a33 with SMTP id
 adf61e73a8af0-3de9ef4e6e0mr252959637.10.1790747589916; Tue, 29 Sep 2026
 22:53:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260505042631.1916555-1-domibel@debian.org>
 <8d1e3735c40b452f7ab89228ad5a0040f5f41b35.camel@iscas.ac.cn>
 <CAAvaLCy7jC-jFM5ZpPVeg7gKpweAW4nPKn4HXR+xpqUHD2soXQ@mail.gmail.com>
 <84e4511ea8e3e6bdff72ce2038bf3a3272744619.camel@iscas.ac.cn>
In-Reply-To: <84e4511ea8e3e6bdff72ce2038bf3a3272744619.camel@iscas.ac.cn>
From: Dominique Belhachemi <domibel@debian.org>
Date: Wed, 30 Sep 2026 01:52:58 -0400
X-Gmail-Original-Message-ID: <CAAvaLCw1ZPBAAURvCR02zxoDrTSxiHaqDp8cjqHsyL7MsTr=Sw@mail.gmail.com>
X-Gm-Features: AclHuK9-oOR0f56IMuemEpm996PDXvOYEpnJvgiFTYENcHWnCYFGQ9svkIM_Dn0
Message-ID: <CAAvaLCw1ZPBAAURvCR02zxoDrTSxiHaqDp8cjqHsyL7MsTr=Sw@mail.gmail.com>
Subject: Re: [PATCH] drm: verisilicon: support non-coherent DMA framebuffers
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: Maxime Ripard <mripard@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Simona Vetter <simona@ffwll.ch>, Paul Cercueil <paul@crapouillou.net>,
 Michal Wilczynski <m.wilczynski@samsung.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, ganboing@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Debian-User: domibel
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

On Tue, Sep 29, 2026 at 3:27=E2=80=AFAM Icenowy Zheng <zhengxingda@iscas.ac=
.cn> wrote:
>
> =E5=9C=A8 2026-09-28=E4=B8=80=E7=9A=84 01:21 -0400=EF=BC=8CDominique Belh=
achemi=E5=86=99=E9=81=93=EF=BC=9A
> > On Fri, Sep 11, 2026 at 11:33=E2=80=AFAM Icenowy Zheng
> > <zhengxingda@iscas.ac.cn> wrote:
> > >
> > > I am still thinking how to decide whether to use dirty-tracking-
> > > based
> > > cache coherent maintenance or writecombine/uncached mapping.
> > >
> > Hi Icenowy,
> >
> > I looked into this again and writecombine/uncached mapping is the way
> > to go.
>
> I think drm/imagination really requires it (because the correspoding
> userspace driver advertises only one memory type with
> `HOST_COHERENT_BIT` set), however in the future it could also add cache
> maintenance support for performance reasons.
>
> > I used Bo Gan's XPbmtUC series and Michal Wilczynski's jh7110 display
> > series and finally got the integrated BXE-4-32 GPU to work.
>
> The XPbmtUC series is problematic -- it "supports EIC7700" "with a
> hypervisor", which means it cannot run on EIC7700 natively. This
> severely restricts its usage.
>
> Samuel Holland from SiFive is working on patching the PTE on-the-fly,
> but that will change all code accessing PTE in the kernel and thus is a
> heavy work.
>
> P.S. For the JH7110 rascal+dust power issue, I did a try-and-error hack
> at [1]. The basical register definition of this register (called
> RGX_CR_POWER_EVENT) is available in their KM volcanic part (but it
> seems to apply for rogue too), but the individual bits for domains are
> undocumented, and the highest 8-bit seems to be some kind of multi-core
> mask on Rogue.
>
>
> [1]
> https://github.com/Icenowy/linux/commit/09db317c9c229ef359e35463f8c08efd3=
e23c685
>
Wow, thanks for sharing this. It works reliably and helped me get rid
of the double-insmod for powervr.
I integrated it into my branch with updated #defines.

Best
-Dominique

> >
> > https://lore.kernel.org/all/20260316060328.1173634-1-ganboing@gmail.com=
/
> > https://lore.kernel.org/all/20260915-jh7110-clean-send-v4-0-f0e4fd6f2cc=
8@samsung.com/
> > https://github.com/domibel/visionfive2_gpu_bringup
> >
