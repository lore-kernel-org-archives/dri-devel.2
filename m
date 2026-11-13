Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB7C606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 00:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=EKlCtyFR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0C3110E72B;
	Fri, 13 Nov 2026 00:27:47 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87BF410E72B;
 Fri, 13 Nov 2026 00:27:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 140BD601CB;
 Fri, 13 Nov 2026 00:27:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3FF91F000C4;
 Fri, 13 Nov 2026 00:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=korg; t=1794529659;
 bh=J4uyCKwoU2ZUCtJEnB2UmwB5w4/Naib62nyhZDy72sc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=EKlCtyFR0G3LjMnWtYrdKkTgBAehi0VR4yOuK+2aRnoodEo+e1zmWIfkZTHLjYB1P
 pMSxyfyQ0J0Ri07DLyGs/JZxFILKGtIY+BkEeQRW7wJpPeGqeemXoa8tbeg0Wce32L
 dyK4nVN/Bzh+LcPW6JZ9e5fRVWKngprMwyRK+Xp0=
Date: Thu, 12 Nov 2026 16:27:38 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Mika =?ISO-8859-1?Q?Penttil=E4?= <mpenttil@redhat.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Alexandru Elisei
 <alexandru.elisei@arm.com>, linux-mm@kvack.org,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, David Hildenbrand <david@kernel.org>, Leon
 Romanovsky <leonro@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Balbir Singh <balbirs@nvidia.com>, Zi Yan <ziy@nvidia.com>, Matthew Brost
 <matthew.brost@intel.com>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Lyude Paul <lyude@redhat.com>, Danilo
 Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v17 00/12] migrate on fault for device pages
Message-Id: <20261112162738.d689b46268e077ac06f41d91@linux-foundation.org>
In-Reply-To: <ec4431f1-e70d-477c-b09a-eedc35d97691@redhat.com>
References: <20261103061629.972669-1-mpenttil@redhat.com>
 <avWpWBl1nPcRVmpQ@raptor>
 <79f33ab0-2e43-4efb-94d0-addaf40745ec@redhat.com>
 <avXoJSGh5xjGFgod@raptor> <20261112164752.GA3692174@nvidia.com>
 <ec4431f1-e70d-477c-b09a-eedc35d97691@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 12 Nov 2026 19:01:58 +0200 Mika Penttil=E4 <mpenttil@redhat.com> wr=
ote:

>=20
> On 11/12/26 18:47, Jason Gunthorpe wrote:
> > On Thu, Nov 12, 2026 at 04:24:05PM +0000, Alexandru Elisei wrote:
> >> Hi Mika,
> >>
> >> On Thu, Nov 12, 2026 at 04:00:09PM +0200, Mika Penttil=E4 wrote:
> >>> Hi Alexandru!
> >>>
> >>> On 11/12/26 13:56, Alexandru Elisei wrote:
> >>>> Hi Mika,
> >>>>
> >>>> I want to help getting this series merged, and I've been familiarizi=
ng myself
> >>>> with hmm and device migration, please bare with me if the questions =
I'm asking
> >>>> are obvious or downright silly.
> >>> Thanks for the interest and willing to help! I am preparing a v18 of =
the
> >>> series and plan to post it early next week.
> >> The series is big, and as far as I can tell the MM people are hard at =
work
> >> reviewing bug fixes. It might be better to wait a while, to give peopl=
e a
> >> chance to have a look? I know that if I see a series being reposted of=
ten,
> >> I am less inclined to review the patches since probably a new iteration
> >> will be posted soon. But I can only speak for myself, you know best.
> > It is at v17 and it is still getting high severity sashiko errors
> v14 was first that sashiko managed to review. There was a regression in
> last posting, but also false potsitives, and sashiko reports same issue
> then 3-4 times, so the reality is not that bad.=A0

Pining for the days when all we had to deal with was checkpatch. =20


Mika, afaict the entire patchset is a performance optimization, yet you
say "I don't have a benchmark showing a gain".

Recipients look at patchsets wondering "why should I spend time on
this", especially in these times.  It's best to answer this question
right there in the first sentence of the [0/N].  That means numbers,
and the better they are, the more attention the patchset will get.

>  Documentation/mm/hmm.rst               |   45 +
>  drivers/gpu/drm/nouveau/nouveau_dmem.c |  402 ++++++++-
>  drivers/gpu/drm/nouveau/nouveau_dmem.h |   12 +
>  drivers/gpu/drm/nouveau/nouveau_svm.c  |  155 ++--
>  drivers/gpu/drm/nouveau/nouveau_svm.h  |    5 +
>  include/linux/hmm.h                    |   51 +-
>  include/linux/migrate.h                |   59 +-
>  lib/test_hmm.c                         |  174 +++-
>  lib/test_hmm_uapi.h                    |   21 +-
>  mm/Kconfig                             |    1 +
>  mm/hmm.c                               | 1075 ++++++++++++++++++++++--
>  mm/migrate_device.c                    |  618 +++-----------
>  tools/testing/selftests/mm/hmm-tests.c |   56 ++
>  13 files changed, 1984 insertions(+), 690 deletions(-)

also, yikes!
