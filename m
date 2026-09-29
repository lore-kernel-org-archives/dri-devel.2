Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D82CA5FAB
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 00:27:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 120D410E1A1;
	Tue, 29 Sep 2026 00:27:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ESq97FFa";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1290D10E1A1
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 00:27:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D4A60447A1
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 00:27:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B671F000FF
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 00:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790641666;
 bh=APJhL/UXcBCjjwICTLFT+qLin1KDXiRR0y2N5bPp8T8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=ESq97FFaS8q6O+WGq8mTMUSToYKUb+XzvsNnBGTw4Yfq//3liXu2B3bAv7bcygdli
 EcHwpI4uM9pG+PUVngoWR6FzLO0tgC/0cKz935SPY0E8pLtZbxVA2GkK9LZprUpqw2
 kp586WFL9UgLZZQwTNyhbLUWzYUgkY8T2hW91Gxa2Jj7QLSxcnI/egjRJOFsyE6zTH
 MQitmOsQu/01PuHkjjIBs3OQA+lJn8aPHg151owirTWk+5lo2DtlA/4bwfsWrrPey4
 MOb1YDPRUwN4TweCY78GvrHPfK0ZNR7urK4fizgTgf4M+q8ttD/pIntwgzWSW9hTmc
 eAfxlQdMmxqdg==
Received: by mail-ej2-f42.google.com with SMTP id
 a640c23a62f3a-c2b40e4744eso343117966b.2
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 17:27:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBzh42OllRyzsJy/WfnET71BgGoaR3sgtOnhL40p3quS+3Z4tkZcy6DFgQkhJIXUGzeTeof9F0DeZZo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mrwOTQYrD2Q+aXtdy0h8jyQbIPR/5/mSw9jS+kZ44guzU5A+4J
 lpq+I4UsKVql3Kx2lNaOUUbWPaW7vNgbL0Sz3vS7C+qIOtHaE1vNnnBFeIp+BkB5zy0kzYyxL1F
 hK3L/V7qgDXKIQH9c1fSoTXguF8ADq/1CGIOa9pY7NQ==
X-Received: by 2002:a17:907:a909:b0:c26:1649:47b4 with SMTP id
 a640c23a62f3a-c2ac53fbdb4mr1170576266b.42.1790641665270; Mon, 28 Sep 2026
 17:27:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260926045517.3458413-1-matthias.goergens@gmail.com>
 <CACePvbWM8kMjtJbH4vc6Qt=TBZQ-0d-Yj9NOtkepZmtNN3wd9w@mail.gmail.com>
 <20260928151924.2686290-1-matthias.goergens@gmail.com>
In-Reply-To: <20260928151924.2686290-1-matthias.goergens@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 28 Sep 2026 14:27:33 -1000
X-Gmail-Original-Message-ID: <CACePvbW=fZ3G1JwnbiRo+_qsteN2smbbf3jX0UPFmhVyWA5_6A@mail.gmail.com>
X-Gm-Features: AclHuK_oifA42INPrgsCc_iqlMTCQtFcDVPMyqJSWfGYorE6tGAaJtv8iXHRTRc
Message-ID: <CACePvbW=fZ3G1JwnbiRo+_qsteN2smbbf3jX0UPFmhVyWA5_6A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/4] mm/swap: reserve swap areas for deliberate
 offload
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kairui Song <kasong@tencent.com>,
 Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@kernel.org>,
 Michal Hocko <mhocko@kernel.org>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosry@kernel.org>, 
 Youngjun Park <youngjun.park@lge.com>, Baoquan He <baoquan.he@linux.dev>, 
 Barry Song <baohua@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, 
 cgroups@vger.kernel.org, linux-api@vger.kernel.org, 
 Alejandro Colomar <alx@kernel.org>, linux-man@vger.kernel.org,
 Karel Zak <kzak@redhat.com>, 
 util-linux@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, intel-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, "Rafael J . Wysocki" <rafael@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, linux-pm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org
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

On Mon, Sep 28, 2026 at 5:19=E2=80=AFAM Matthias Goergens
<matthias.goergens@gmail.com> wrote:
>
> Hi Chris,
>
> Thanks for resolving the conflicts yourself and reviewing it.
>
> > What is the high-level user-visible impact of this series?
>
> Being able to use more interesting swap backends and logic when the
> machine is not under memory pressure.  It is much easier to write a
> swap backend that may occasionally allocate memory than one that is
> guaranteed never to, so today such backends are either unsafe as swap

I actually don't know of a swap backend that absolutely will not
allocate memory on swap out yet. Some backends allocate more than
others. Because the proactive reclaim can write to the non-offloaded
swap backend. That brings me back to my original question, in what way
this series helps.

So the answer seems to be that previously, some backends were unusable
by swap, due to possible memory allocation. With this series, those
back ends are usable for the proactive reclaim now. It is a 0 to 0.5
improvement because direct reclaim can't use it yet.


> or ruled out (btrfs, for example, refuses swapfiles that are
> copy-on-write, checksummed or compressed).
>
> > I am curious: if we never run out of swap file space on the
> > non-offload swap area, does that mean we don't need this patch series?
>
> No: running out of conventional swap isn't the point.  Without the
> series, any active swap area may be written under pressure, so a
> backend that may allocate can't be used as swap at all, however much
> conventional swap there is next to it.

But proactive reclaim can also use the non-offload swap area. So if we
have plenty of non-offload swap area, both proactive reclaim and
direct reclaim can use that non-offload area. The value of this series
isn't apparent. If you don't have a traditional swap-capable backend,
then your non-offload area is zero.  That is considered a special case
of running out of non-offload swap area: never having a traditional
swap area in the first place.

>
> > However, direct reclaim can use both types of swap areas.
>
> In v2 it can't: only memory.reclaim, per-node reclaim and MGLRU's

Sorry I meant proactive reclaim can use both types, nothing constrains
proactive reclaim.

> debugfs eviction may write new data to an offload-only area; direct
> reclaim, kswapd, MADV_PAGEOUT and DAMON reclaim may not.  But I think
> your suggestion to flip it round is closer to what I want: mark the

Flipping it around might provide additional benefit. I know some users
maintain off tree patches to turn off zswap on the direct reclaim path
exactly because zswap might allocate more memory before it can free
some. If the kernel can be smart about it. It provides additional
value to the status quo.

> areas whose writes may allocate, and keep pressure reclaim away from
> those, rather than tying it to what started the reclaim.  I'll work
> that into v3, together with Kairui's suggestion to build on the swap
> tiers work.

Yes, I feel that cluster-level marking might not be needed, you can
remember which si has the offload flag. However the per cpu cache
needs to know which context might require using a different cached
cluster. That is the trickiest part. The rest of the patch is just
enough plumbing to preserve whether the swap-out context is proactive
or not.

Chris
