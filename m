Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABF2C44512
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 16:38:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD4DD10E228;
	Thu, 16 Jul 2026 16:38:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vy/VHk/3";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2944C10E228
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 16:38:00 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-38e42560ebcso507990a91.1
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 09:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784219879; x=1784824679; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rgThJIHDvKsal8KFo6FMAaZQfGc1Wy8tJlIMPT0McxA=;
 b=Vy/VHk/32K7pr1U8dkogSC9iuItucBDN5JfnNkRVECJEy3FlLjNOPOWnUKz9u2sBv3
 DXRdlBOtxmF4ga0VB9jm4a3ediYrbi3bc5VtiKWJlWULkE8v4hh92BPlNW/Gol11/vRW
 vkg000hWQ+5MlT274arlnw+UfczCwFPXzp0moRfeZXn6dQWYElINCFpk7qglegGc98Ng
 ktP8j/+7O73xSJiZluRSQESsbORm0vaRgly6K4TeDZfnDpZTnVyv0Bkn8m3sWsfXJiOq
 BUKGmI2N9svqaMH6wCtY+bT2J+bKzjZ5oGO4/BeAFfImWaHtw//hhCUhR2uOf1DNa/Mb
 550Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784219879; x=1784824679;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rgThJIHDvKsal8KFo6FMAaZQfGc1Wy8tJlIMPT0McxA=;
 b=GUbCZFzCIyn3lRGgUB77jn1DNoQrl4U/jiT3kMU8pEhffS1IYwpvUO+ElfF51ifu7u
 gVDtANZMm3+S6oYGq8hdVBKi30lrHhx1G8e1YhorvrsmqhTGCsy7l80OdU/EjMDoALiD
 smHDYvfqOGVtY7+jWURd7fCgTEEAeLz6gSxQkDYqfp2GZJq2QMzTWCXpdLaDTGW2stw9
 B+s1aDWZcyjdhYEyHlJIq+RMGxHad9N/Bgkix1PdzNQBCreZvUY9BW4mRrsg+wO33pX9
 vuOJ8UFsdXQtQV5PONe459pJlqY8NIPkk9liAmxOJxb9igpZjT0dMcrC3KoExqREa2Pi
 B2GA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrD8OHa/MjFfl3+mRpfPX1A7SnL7rT8rN1Y35yMHtb/DPpIvytzNNWGzBz/VpV09XnIRKicREZq7PM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwCojfe+QVD9Ybrd2DcB7Qwsn2OFPfaVmv34kmvVGxXkdaQ7Iie
 cLU43j/7jXhrMVG2BB7JZqsQXZQLnxdDNWHl+L0tRbU/GqNtk7tIWV6T5/R1dCSd
X-Gm-Gg: AfdE7clDakt68NeB1f7rnlFG+7tr89yG+YwMx+OHZkcpcmd8Ilr6qY7iZXGuzqidSeS
 WJjj/V08AxAISMFD4KTekW3+7a4BZrLzlsPRvjoJuqNCBmdlNV7/5R5vW9/a40ZKiQ0/IXFiXha
 2vkedMeRh8WSSV1KqGSlN3tTYucpQNsaLPLfFSJzNCSokiCu/Ol1o815Qt//C3XitgqgmaP3OGT
 p3c84cxzKQpRWnWDCyRfUfyE5+nFGEJ2OXnx70M2hBe7SSU7la4qTLgLX7LopigTHZwxkSYzSRy
 UFTkCk8s2N7/lK6KS1pT1K1UEap9P9cORfwMsbEkqeUFVSEi2/hnZqIZjTPqBDSnFreiVCqUbvR
 b29qXuBTshll5jEJakwY/HFTaPFmzkdxmYXMbA0RKX+0oi/ruosudI+d155okYAYP9rY/ZDfcGN
 EXUu2L0F7nMEljdb9wY51aIumWgHKY775UbLT7m7iErpDS
X-Received: by 2002:a05:6a21:e081:b0:3c3:7f8f:88cc with SMTP id
 adf61e73a8af0-3c37f8f9302mr5411998637.46.1784219879218; 
 Thu, 16 Jul 2026 09:37:59 -0700 (PDT)
Received: from skinsburskii (c-98-225-44-182.hsd1.wa.comcast.net.
 [98.225.44.182]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cb258ff4402sm2078703a12.25.2026.07.16.09.37.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 09:37:58 -0700 (PDT)
Date: Thu, 16 Jul 2026 09:37:56 -0700
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, airlied@gmail.com,
 akhilesh@ee.iitb.ac.in, corbet@lwn.net, dakr@kernel.org,
 jgg@ziepe.ca, kees@kernel.org, leon@kernel.org, liam@infradead.org,
 lizhi.hou@amd.com, lyude@redhat.com,
 maarten.lankhorst@linux.intel.com, mamin506@gmail.com,
 mhocko@suse.com, mripard@kernel.org, nouveau@lists.freedesktop.org,
 ogabbay@kernel.org, oleg@redhat.com, rppt@kernel.org,
 shuah@kernel.org, simona@ffwll.ch, skhan@linuxfoundation.org,
 surenb@google.com, tzimmermann@suse.de, vbabka@kernel.org,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 0/4] mm/hmm: Clarify notifier retry state and scope
 HMM timeouts
Message-ID: <alkI5JLYPW211Ep7@skinsburskii>
References: <178406760622.1106335.2379450382728057793.stgit@skinsburskii>
 <4300f09b-8f93-4605-b072-7c09a82cb16e@kernel.org>
 <alecaJ1FUso39D9k@skinsburskii> <alet21wLwM6P_Km2@lucifer>
 <ale3ydkx1xt6ruuP@skinsburskii>
 <20260715101432.99957d2d33203fafe4af2e1c@linux-foundation.org>
 <e9d0ade4-cf87-4e8d-90ec-50ddb5249b24@kernel.org>
 <aligdOKNwoOtD4io@lucifer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aligdOKNwoOtD4io@lucifer>
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

On Thu, Jul 16, 2026 at 10:12:56AM +0100, Lorenzo Stoakes (ARM) wrote:
> On Thu, Jul 16, 2026 at 10:59:56AM +0200, David Hildenbrand (Arm) wrote:
> > On 7/15/26 19:14, Andrew Morton wrote:
> > > On Wed, 15 Jul 2026 09:39:37 -0700 Stanislav Kinsburskii <skinsburskii@gmail.com> wrote:
> > >
> > >>>
> > >>> Please don't do this, this is completely impossible to track for review :)
> > >>>
> > >>> mm review is currently very difficult based on volumes, it'll become impossible
> > >>> to manage if people sound fragments of series.
> > >>>
> > >>> Please just resend the whole thing at this point.
> > >>>
> > >>
> > >> Well, I followed the guidance provided by Andrew, and I believe he
> > >> applied all of the changes, including these, to the `mm` tree.
> > >>
> > >> Do you still want me to send v9 under these circumstances?
> > >
> > > Sure, if that's what reviewers prefer.
> > >
> > > This is a bit unfriendly to people who have already reviewed the code.
> > > Which is one of the reasons why I respond to a new version with a
> > > single diff showing reviewers (and the author, and myself) what changed
> > > since the previous version.
> >
> > As much as I dislike fixup patches, I tolerate them in reply to the existing series.
> >
> > But having some random fixup series is just crazy, really.
> >
> > --
> > Cheers,
> >
> > David
> 
> Yes.
> 
> Stanislav - also see Jason's suggestion - if you give a base commit then sashiko
> seems to work better. Maybe look at using b4 which does all of this for you
> automatically?
> 

Sure. Thank you all for the suggestions. I'll use b4 next time.

Thanks,
Stanislav

> Thanks, Lorenzo
