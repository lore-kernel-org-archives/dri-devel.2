Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E60DBF532D5
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 05:01:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2939710E0CB;
	Tue, 24 Mar 2026 05:01:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=icenowy.me header.i=uwu@icenowy.me header.b="QO3gOIdd";
	dkim-atps=neutral
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0264110E0CB
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 05:01:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1774328469; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=YHBTEQtHEDApLWuvXVC6MWyBi/WOgXdKAPcvfaeZyVFqX+4Vlbyvi61FEwoNt09Su6Sn/wjpiizrNfzz8osKiWHNF/kiSrFDe81B5fpvzF0iZhL4Wi7iXnbdhaXu1R+ScIhoY8xthZqItI+NfBqqxX8YXTgMnMlXdQhqDhkQdM0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1774328469;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=hZWh6xyRbNCs76Wh2OdrPFxD1uv9eHLqfhkYHPs9Rtg=; 
 b=ceNMdTohWHIwBheDZ+KehmtP2qLqKfszrY+cFzyN/M2VkNTEnUS8JI1xznUT17xhYBiu9p1ktFodoHQLNsBklT37D1XKO3IiUoRICejauh+ak2Nuvphbyc7dj9C3Cb1dVCqvaM87EtZWDfprFTS6/l1957QnFx5HOPmh/R50hy8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=icenowy.me;
 spf=pass  smtp.mailfrom=uwu@icenowy.me;
 dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774328469; 
 s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
 h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
 bh=hZWh6xyRbNCs76Wh2OdrPFxD1uv9eHLqfhkYHPs9Rtg=;
 b=QO3gOIddoqC1SlYd2bFrEYhTKIB0CIHNhuKraoi1y2pVeq9B1sjnV3J8GqEA6pNb
 JJP1zeD2nh2nCrnsQAZrZwp3B/7sRYVdfCKUGSjTo0R2ZPc7ehlqaYdzXusXYFAB3zg
 7/Nyl9L4XDE4INcOWnSj0jI4Sr/dz1Bt5Smv24RdgOPHQsyrc5RyGxpYYZrV5MdQedS
 /5BKbMZoRT7Ji9hGeSVVV2mjOyomHafCu6pwVJzkTHURz9eLgo9ghyXqxf1pXre1dET
 Rdr6WPDc3/0imwpam2ewwQBugu6kV9y+vkSwytbSmIJcG+KurTfFT3RAvoeU512QnH7
 hoawa2ddzA==
Received: by mx.zohomail.com with SMTPS id 1774328465635251.53187886622527;
 Mon, 23 Mar 2026 22:01:05 -0700 (PDT)
Message-ID: <a5d3a7dfeb5188c72313008c9f9cb019244b118e.camel@icenowy.me>
Subject: Re: [PATCH drm-misc-next v3 0/4] drm: verisilicon: convert
 drm_format to vs_format in atomic_check
From: Icenowy Zheng <uwu@icenowy.me>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard	
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Tue, 24 Mar 2026 13:00:58 +0800
In-Reply-To: <20260305153817.157841-1-zhengxingda@iscas.ac.cn>
References: <20260305153817.157841-1-zhengxingda@iscas.ac.cn>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-ZohoMailClient: External
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

=E5=9C=A8 2026-03-05=E5=9B=9B=E7=9A=84 23:38 +0800=EF=BC=8CIcenowy Zheng=E5=
=86=99=E9=81=93=EF=BC=9A
> This patchset tries to move the process of converting drm_format to
> vs_format into plane's atomic_check callback (instead of the
> atomic_commit one, which the process currently sits) for more proper
> error handling (because atomic_commit cannot fail).
>=20
> In addition, because of the original flow of primary plane's
> atomic_check seems to be flawed, it's also updated before filling
> vs_format is added there.

Ping. It looks like this patchset didn't get a review, maybe it's
buried in the heavy flow of dri-devel?

Thanks,
Icenowy

>=20
> Icenowy Zheng (4):
> =C2=A0 drm: verisilicon: make vs_format conversion function return int
> =C2=A0 drm: verisilicon: subclass drm_plane_state
> =C2=A0 drm: verisilicon: call atomic helper's plane state check even if n=
o
> =C2=A0=C2=A0=C2=A0 CRTC
> =C2=A0 drm: verisilicon: fill plane's vs_format in atomic_check
>=20
> =C2=A0drivers/gpu/drm/verisilicon/vs_plane.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 53
> ++++++++++++++++++-
> =C2=A0drivers/gpu/drm/verisilicon/vs_plane.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 18 ++++++-
> =C2=A0.../gpu/drm/verisilicon/vs_primary_plane.c=C2=A0=C2=A0=C2=A0 | 53 +=
++++++++++------
> --
> =C2=A03 files changed, 99 insertions(+), 25 deletions(-)
