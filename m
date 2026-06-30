Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D6BC43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 16:05:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6414210ECCE;
	Tue, 30 Jun 2026 16:05:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ox1lSUs8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 005DB10ECC5;
 Tue, 30 Jun 2026 16:05:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 476CE600BB;
 Tue, 30 Jun 2026 16:05:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F352A1F000E9;
 Tue, 30 Jun 2026 16:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782835547;
 bh=GRs8WjcQhEYPcY1IkD3TxIAylDmbtFFFSwtcXiK+ZfU=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=Ox1lSUs8APxIsUyMFvQd0DXXHeogkAi4cBq7Nizl0YA0oJsHLXSZrXSDjaUxbf1J7
 VFdM3rKwRi7eEN9eli1d/LEEGUB/m01MbJEtntsSfXM3plXu7HfFSxaBX6Kaw5eKDC
 zhRTylalba619x60GkyfjhkL21ZLJRsTAnvKZe137Ed4OVHcBkyEk6wfR2YqOg+JCW
 9AyXSMhByZlMFpix4KMGX12NfZXZmy1KNndWd0gUt18ZCZYYhve92toImNVQKaDAHX
 08kQELCc79R8VkaNWXTzXpIFb7diJSou5D9IfOTxeFVu1xTL/EpLnPVKdxS3I2Wlkd
 /DOnQRMPtcXtQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jun 2026 18:05:42 +0200
Message-Id: <DJMIGDHFYCIA.271V0T10TID2J@kernel.org>
Subject: Re: [PATCH v2 1/4] Revert "nouveau/gsp: fix suspend/resume
 regression on r570 firmware"
Cc: <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, "Timur Tabi"
 <ttabi@nvidia.com>, "Dave Airlie" <airlied@redhat.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Ben Skeggs" <bskeggs@nvidia.com>,
 "Kees Cook" <kees@kernel.org>, "Simona Vetter" <simona@ffwll.ch>, "David
 Airlie" <airlied@gmail.com>, "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Maxime Ripard" <mripard@kernel.org>, "Mel Henning"
 <mhenning@darkrefraction.com>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>, "Lyude Paul"
 <lyude@redhat.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260629224350.2870201-1-lyude@redhat.com>
 <20260629224350.2870201-2-lyude@redhat.com>
 <akOuPQ37-zxIJWWH@ashevche-desk.local>
In-Reply-To: <akOuPQ37-zxIJWWH@ashevche-desk.local>
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

On Tue Jun 30, 2026 at 1:53 PM CEST, Andy Shevchenko wrote:
> On Mon, Jun 29, 2026 at 06:42:33PM -0400, Lyude Paul wrote:
>> This reverts commit 8302d0afeaec0bc57d951dd085e0cffe997d4d18.
>>=20
>> It turns out this looked like the right fix on some systems, but it's no=
t -
>> as this causes runtime PM to actually fail on many a laptop.
>>=20
>> [I have set the fixes to an older commit then the one that is reverted
>> here, because when applied with the other patches in this series, this
>> appears to /fully/ fix runtime PM in addition to the regression]
>
> No need to have this in the commit message, move it to the comment block.=
..
>
>> Fixes: 53dac0623853 ("drm/nouveau/gsp: add support for 570.144")
>
> I'm not sure, actually, that this is a correct approach. You can't revert
> something that never appeared (in time range between 53dac0623853 and
> 8302d0afeaec). Have you consulted with the stable kernel process document=
ation
> and/or respective maintainers?

I think it should be as simple as picking

Fixes: 8302d0afeaec ("nouveau/gsp: fix suspend/resume regression on r570 fi=
rmware")
Cc: <stable@vger.kernel.org> # v6.19+

for this commit and keep patches 2, 3 and 4 as they are.

The commit message of this revert can then explain that the commit that was
attempted to fix with this revert, i.e. commit 53dac0623853 ("drm/nouveau/g=
sp:
add support for 570.144") is fixed with a different, subsequent approach.

This seems correct, as reverting a bad fix does not claim to solve the orig=
inal
problem.

Thanks,
Danilo
