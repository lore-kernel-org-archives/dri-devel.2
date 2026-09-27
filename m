Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 789B0C98328
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 00:03:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8009210E197;
	Sun, 27 Sep 2026 00:03:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iOIJTaat";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 761B710E197
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 00:03:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EF10C6057A
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 00:03:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71EF1F0089B
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 00:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790467407;
 bh=dM60/lQJZNJbWoteFqu6uPH785ljbJ4v68GljKAZeM0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=iOIJTaatkNJ/Rx0KAosWsEwaSeM1/VzOcFaAXAR27F0Tghc6tEkwXrLZLSxZEofLE
 r2Dx50NWbwE+0HSrIyUzc2guH3dCCZXbEqPI7RuyOdOfnKMteagodLQPrevjon41v9
 Dtf9Lxy4aPDYrhMWgQCZIUG/QmvbX27bI1HhTmKKiBkbNRiXvNAyEHiEKg+u2C0EHs
 gt5HUb5YZUq5D/Ka+Dd0RKLqtVNKcts0c9yYCa/iClMmie/d+ZbfkHElnsovKJu0dt
 yvJoCqBPz82kyHXp7mVgU9FH9lw9/lV7+e8letvdUnQkAqw46bQ4ZX/sT/j4L+KY9D
 Urf6jZIxQuU3Q==
Received: by mail-ej2-f22.google.com with SMTP id
 a640c23a62f3a-c2afd63c3e0so153463966b.0
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 17:03:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBzS2lzw1Lfmkfa26ovUiwx66tIj/175keTOluiwsS8G1mwJ4smfwDX97ONEjIHv0oEL1X8iiOSkYog=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mL3zGmh63V4f3z+YzeAg+mre5fM3yd59mH1hyfWNOId0+7vh0S
 Pe7DltNHhuH3b/IxxkTU+bobITE4Z/pG/JJ5Zx+lPLUfqjEo+7SStaF7AM44Z1/IZj9QCz6zV07
 8RXZJmaGtXKIQtR+DPfI+c974EsJF1+2ZvSAvfKrHkA==
X-Received: by 2002:a17:907:970f:b0:c28:e01d:1d08 with SMTP id
 a640c23a62f3a-c2ac268a3b6mr767904866b.49.1790467402757; Sat, 26 Sep 2026
 17:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260926045517.3458413-1-matthias.goergens@gmail.com>
 <CACePvbWPLegjMtF4jYN4+_1ZeoEuBHwZuwNyMpYwPZaA0edO5A@mail.gmail.com>
In-Reply-To: <CACePvbWPLegjMtF4jYN4+_1ZeoEuBHwZuwNyMpYwPZaA0edO5A@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Sat, 26 Sep 2026 14:03:11 -1000
X-Gmail-Original-Message-ID: <CACePvbU_6o_9fEFU6TJ9VaZ=4yBsDG5qXcxFkrGHBSD69m5ZXQ@mail.gmail.com>
X-Gm-Features: AclHuK-ZyMX3KOF420HwXlAK4cpZeFQwMK0gQ_EG8K18s67LKRQ8CucrkEWbQU8
Message-ID: <CACePvbU_6o_9fEFU6TJ9VaZ=4yBsDG5qXcxFkrGHBSD69m5ZXQ@mail.gmail.com>
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

On Sat, Sep 26, 2026 at 1:32=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> On Fri, Sep 25, 2026 at 6:55=E2=80=AFPM Matthias Goergens
> <matthias.goergens@gmail.com> wrote:
> > The series fixes zram selftest device tracking and error reporting, add=
s
> > the swap policy with DRM eligibility checks, and tests routing, working=
set
> > activation and retained-entry write refusal. It is based on mm-new at
> > 995829088503.
>
> Hi Matthias,
>
> I can't find mm-new 995829088503 anymore.
>
> Your patch does not apply cleanly to the current tip of mm-new
> mm-unstable, or mm-stable branches.
> Do you have a git repo with your patch applied?

Never mind, I have the conflict resolved on mm-unstable.

Sorry I usually need to have the patch appliable to use my own review scrip=
ts.

Chris
