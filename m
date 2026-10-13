Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E42CC6B0F
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 14:17:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 953B610E80E;
	Tue, 13 Oct 2026 14:17:08 +0000 (UTC)
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com
 [74.125.224.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95F1610E80E
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 14:17:02 +0000 (UTC)
Received: by mail-yx1-f53.google.com with SMTP id
 956f58d0204a3-677aec6ddfcso2469896d50.3
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 07:17:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791901021; cv=none;
 d=google.com; s=arc-20260327;
 b=fBMnp+XVD2PPhZV/DMn9hS5f/xf6AH5wD86r7acmlbLgb+y+pgiELcq01QEAldjfzI
 oBlNAF4Yesa8wDA0JqDvFjyoxWKxGDxbK3+45s/saw5deV/cW9pPKpekkAg/AV6YPXxP
 wZUC++3uuwVAsfluNHlwWDVkdXGnDp0Br6Q91fq3vhlKaRAnDwBBotq6u0q6eb5RYF6j
 YVckntBlGuxmuc/LYEAqniHdUO2EACGkvtPknn6PiimNMUjoyGg4MUy0OVORIyuy96n5
 QsvM+sVgtG3Ccvn+b8phPeDju8TK5eQ3dlHmpcZRboC4HyJ5H4xXnIROab9jWJQ4BflQ
 0x1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wNycpsWBlfQXgs2ZLPtEBzEs04amMNcoEiI5MVrXE/Y=;
 fh=uls47SBOl392Of7mq8RsrmMopEr0Jc1VpT8Sj92HnV0=;
 b=kAzZ46siHntWTjBSncHWEwLUHGo/6wSO9kqEc2NYKmXh06GRV2HTiRlQmAP1a6kwOb
 QJHlu5f5Ftr0fVwt759zchFNfnB4egeUlXN13MUptftYbYQHajY7IOc48deCkYjocruY
 DgSU8TC1vrN3H0+v0bMih2rmtvzcnYXReOcLrTvzSA0iGbvYM5+Q0JJM5eRj9WVaKU10
 ClUKdS5GqCjwvxvgIaKTMOJ0rkBwIikm3OEtcbxi9IaQg5VSs5oO2hBTnskb4C2PdFTJ
 aAhHMSwTxiKvXwpJ98wUJ/CibqexH7hW/6j/jYqba5egHgh2OxPOG5Y8FuNMe3m5uJEM
 GQBw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791901021; x=1792505821; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wNycpsWBlfQXgs2ZLPtEBzEs04amMNcoEiI5MVrXE/Y=;
 b=rLjd2unxTbXfc70cqGq0NNz7fl8sbvhsb7uYW3CR1wL58S17qb/sTd7HeZ0x1AMdXa
 coiWa3GAQ8VRvW3QXIi9BoBUW1EwDoIbw9pvkZZrfdQzrwWlBbIcipiuVxSObDKrzohM
 icVFD2GJEFvyWkZ+wknlu0cWN/mtm0omozdgSstd/9gEntqfYdLRRpGn3g8Z3ocfWxuJ
 Y5vh4SCT8R+DtuaY+oXpcBfupi369ajMH4/DSFc7D/dX3NvOIjyn8rY0Nm9odlqQm3QI
 bJ8NsXDASfuuKUU8Yed9Ll3098DLimuaOdBIkJ5YOfEmT1Vm4cXgK5umMuJ+6qye/kkY
 LDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791901021; x=1792505821;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wNycpsWBlfQXgs2ZLPtEBzEs04amMNcoEiI5MVrXE/Y=;
 b=FiDMeahlMVDGHfCHBC/Eir4ARmJJRuHINFVXQYil1ODc0zJIEYY62mmmbEyTRKpUpj
 sG+ysa2P4KhikEEOqNDX1OJQ6htE7PNcksrdfw2W97S+bAsas4VkyAYJDCa+6T/5RZFl
 e2VAInnQGrWEJ+mEB/7bZdCQTo88bwBDzvciKNn/9jfWYgzcH3bQU+ChQhARh1Q8+6Rd
 V/1Clh8/HsjXfuQ9p5U334PxRogeB8VZEPfByTp9dNH8P2v+vml+8I4UDxgjzp+aktb4
 JYeaY9QAGhtCxIBq3XD2qO0D3zDCW8fvOMQ+U5F0oDVztEOS+oxLxoNuN/ppPPwL1/zL
 Klxw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxnb3PSMPuR5VE7Dy9w7sn/neoQuDUnY2Gp9Ezff0xTDgUiw4ChMHZLIQRwVqF0d9pxOHZc/cDK/6I=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLwKVr3slIFshSjQbNX7LNz/o/PfKiid6uIrmVWpYKAqs5BEKJA
 JvpEQy9VrHY2ljBg2/3R/O0wJcuHcN5FG7PuGuubGXVLAcFXPTnMJIelR5d4sBp/2CesKtvUKqk
 4RlTDXn+QU11CBmUSlvOt/TLt7vBdXCL9Cx7xfpg0oQ==
X-Gm-Gg: AYBFou06lT7k+cysQb/Tx7vEnr+QjEjU2bHpPsedM4d7TLqDWLPBBvV5j5bJfUAbXkI
 2BKvpOfz7Zr05j4Ehb1it/Og6+35ex7q17YW4tNlVtWRTOY0q0Mr3nnXLQ/er2EPunKGA+ilIyo
 J3xAwEboPp6w6yVz9J/FtGFJyjz01wH+V4XFPjV2VQfXXzuvd1Nffg1TcXP7EYHMl3d/x4QrcFg
 6Zkc/FQBCeiM5oNc6OVDkeSVwM3QhYYTaii4xBknMNbxiO6BaD3WtF7NGN5l2HgYcd3dAgY5p2D
 R8zTWugHVigw9liTCbTZlQ+ZcvivPkSROnrEQ3Ix1oXg9E4ZHu0Nk4Do23uRTfWJ8cTyNRHg7JZ
 DtRLl7GkYANz0FPpn9mBM+ko=
X-Received: by 2002:a53:e313:0:b0:677:b7cc:210c with SMTP id
 956f58d0204a3-679362ede62mr2859896d50.163.1791901021395; Tue, 13 Oct 2026
 07:17:01 -0700 (PDT)
MIME-Version: 1.0
References: <20261005064133.7305-1-kmehltretter@gmail.com>
 <d1ef135e-1b5d-4656-9229-348c7029efbb@leemhuis.info>
 <as0r7Q4dHt9gQm_8@gmail.com>
In-Reply-To: <as0r7Q4dHt9gQm_8@gmail.com>
From: Sumit Semwal <sumit.semwal@linaro.org>
Date: Tue, 13 Oct 2026 19:46:43 +0530
X-Gm-Features: AclHuK9yOH0W7FJ5IkLpKJOcXHUnKCWcM6_hFWllx6ZiiWF7Douv1aRrjUDfUxs
Message-ID: <CAO_48GGTHcs5M0WyY6dcJLxy1kUJq6uNLh_s+221t3HcGoMxSw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] dma-buf: warn-only mode for DMABUF_DEBUG
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Jason Gunthorpe <jgg@nvidia.com>, 
 Rob Clark <rob.clark@oss.qualcomm.com>,
 Jianfeng Liu <liujianfeng1994@gmail.com>, 
 Diederik de Haas <diederik@cknow-tech.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Vinod Koul <vkoul@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 linux-kernel@vger.kernel.org, 
 Linux kernel regressions list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
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

Hi Karl,

On Tue, 13 Oct 2026 at 00:21, Karl Mehltretter <kmehltretter@gmail.com> wrote:
>
> On Mon, Oct 12, 2026 at 10:12:02AM +0100, Thorsten Leemhuis wrote:
> >
> > What's the status here given that 7.3 will likely be released in a few
> > days? Note, I can see from the discussion that this is a complex problem
> > that can't be quickly solved. That's how it is sometimes. But I wonder
> > if the current state of things is the best compromise for now or if
> > Rob's revert or some other option would be better.
> >
>
> I think reverting my commit 143755bdabaa ("dma-buf: Make DMABUF_DEBUG
> default to y on DEBUG_KERNEL kernels") is the best interim solution for
> v7.3.
>
> Christian, Sumit, could one of you apply Jianfeng's revert before the
> final release?
>
> https://lore.kernel.org/r/20260926022026.10539-1-liujianfeng1994@gmail.com/
>
> Thanks,
> Karl

I have pushed the revert to drm-misc-fixes; I'll request Dave to push
it out to Linus along with drm-fixes.

We should revisit this for the next cycle in a couple of weeks for sure.

Best,
Sumit.
