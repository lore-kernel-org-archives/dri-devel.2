Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBCC6CD37B6
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 09:11:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4304D10E2FB;
	Wed, 13 May 2026 09:11:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="glTstjwH";
	dkim-atps=neutral
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com
 [209.85.167.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E7A310E2FB
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 09:11:50 +0000 (UTC)
Received: by mail-lf1-f44.google.com with SMTP id
 2adb3069b0e04-5a88a79eb3bso29e87.0
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 02:11:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778663508; cv=none;
 d=google.com; s=arc-20240605;
 b=TFa74Bo9p0COW6N5ZST0RXg21YVHgmtQZ1ptW5OZ6QMvC9GavLKPMtKQnPVkl0NpZb
 TnBYrpTuoUGkY1Tn11mnJXNQaGxJkoIPVK0RO9Vpp10AVXj8McCRdGvoRcQ3Cw8hXoaH
 lE5fO8YsRAAQQgvj0sJ1pw83pnVixIZidV+W2XzK7viJEXKyRfKzvckeInDBEV/lAzZH
 7Wh4Y+ejyoBkOslcReUBdtwxNY8spgMUHhyYTY4h4sUXjjegENBRlovjdRODMSXEfYXy
 6W8XuYEzdCYsahNvQLMjZQXOCy1PKe+tQKxEyyXCiMJQiJ5zR9BXH1sYz4cgFWtAw3uR
 0nsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=iL1VE3JAw0z9ArYGQdRAyJCMAXYUM0ge6pat/8Z8ryQ=;
 fh=C7+OswxRRGbEN5inp2BnW0KFeU5U1jfD+BR3dIpLmos=;
 b=HmJ7XRsKBU03MgRfM6O2ykR7xRPOQiYZYFnw6D4cQKQbrJNWIWTt+19YRp3on7V2b/
 K5wL43m+ZY0udJULW300s72SYV+h4q7hAr8vo3j18mkgggCpx3oEbkVoyYzbaIEd23jW
 WngknBP5jQeqY9+b68vMR/6j4IH7iCHF54Hvk90z9XQNWROdLnV1mYEuPgVdmWnvEdIC
 siRN8AdLf2RJugy8xZSHe1Uth9ZDn0N57TN37Ub1g5AwCeOZHD61sXvqqEktJicqNGVI
 XQzCmrTARPX4KIgMh1gg4Fr39L7glX3v8o2FGq036XecP8CafIXiadl26nedeRwSyjqU
 cUpw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1778663508; x=1779268308;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iL1VE3JAw0z9ArYGQdRAyJCMAXYUM0ge6pat/8Z8ryQ=;
 b=glTstjwHMFY2PNtKBSybD980VTyZ1QzvTcgg+FAlzG04VNJyoBPOr6H+WZcXMyBdWy
 NAnyAxtz0MAynFS9gSfAAYOF12p3HXwVKlDBqku/4wR5BgTn1SHBsL1AItebvOxVEOHS
 /UakHHSGyOd+yzB6o9o67L+5Krxjt2Co+uXf9ACJMMDK3k+t+qm99AlsRq/VO9kxzyao
 5lBB6Y0G59uPbd9kGra76b82zoUbKSgXmmtVTDYJbw4CTA4YUI9S9C8pMSVLkTBAXzz/
 PtdpNQA+WjmIfmx8AtQ9f97YbSXhG09+4ApVC9JBiKcVammKjcxGARHtkvCnb39w/8YG
 Zftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778663508; x=1779268308;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iL1VE3JAw0z9ArYGQdRAyJCMAXYUM0ge6pat/8Z8ryQ=;
 b=beOjdaaTKHnhN2S27mI6RIVX/a8DG63GeST9qA0meD0i2sPfubgbtzUl6anIO5uNGV
 LG13Cg9AkxdIzZ8GuipnDDZyNNnJzJUrzRAeg3HZeM/e5BtY1xzxC1TK7B3bSpEl74Ei
 fJZKWS8wOzsANnrE9aI0cYdYc0esyYpCXC7flVZKSzbjpmuOjA567FsYtL6QB+ovPT9f
 BfzMnQYdefOfycH9/lkCgLEFvcKsFvrWgY+Us6Io1ceS8tuSP1RLcqZy6Pe1ZrEthjA7
 aG/LGdsqPS422TuKacq6YeKyQRVqJepiBOiADOV2iaebFom5HJIN2pLh2eV30t9jbzxj
 p2KQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+43eSoxOaVwDzAOQwDYvZN7/F0BdDH7rsqBS/z4eokBM/oL69qL2lR37zAXEy3gQLeHkutdrjGsxQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwTQ4mErrHShWK74ikNDkbnFA0MOjedQ2rqZh+huaohY7Ucfg7F
 YgVWIb2G4aezbDcWFQJ3m83VRhaCM580Fj8uED2dwoOLmT1JBFUIH/NYUyrFJ0UkSKXHbzz42XI
 JjGMZ/IzcMWCL2jjqp3CmtxQQqLfxUlss9BIG/tjc
X-Gm-Gg: Acq92OForJfmekmx3fMupfzU/1WgUONyFMBXhJTB+gKQRnonBbJogBuV0/Z5VjhpjWX
 msImlMzAhWgBfc/744/Vq2GnsnLKEZ8Y0Sp7/A6rWpQI/uPro/4LMmhvdWfTvdU4LZO9wgLU2f+
 SVF2bxbg9RNySSYFNsSKiT8NsGYhwXYtYo8TOE43phmW7hVXiIcpy1ml3QhC8wG3ik27X+Z5zJ/
 p4JAOIeN5K4XfFB42/4ij0T/WDAg9wgBa27wOKfMrmG0iLx0rxQnVFkXe5WqJXli7aoMq3aEGei
 xTNW96NXmIwVs11R8PRcmLd3R9WGp7ntld2Srefu9qBermXu
X-Received: by 2002:a05:6512:1146:b0:5a4:462:a470 with SMTP id
 2adb3069b0e04-5a8f1a27ed7mr127165e87.7.1778663507927; Wed, 13 May 2026
 02:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260326-gfp64-v2-0-d916021cecdf@google.com>
 <DIGPS83BGEGA.5I7VLH8TV7XE@google.com>
 <20260512140532.f16379be75ab006f2cca4747@linux-foundation.org>
In-Reply-To: <20260512140532.f16379be75ab006f2cca4747@linux-foundation.org>
From: Brendan Jackman <jackmanb@google.com>
Date: Wed, 13 May 2026 11:11:34 +0200
X-Gm-Features: AVHnY4JkYKmjfMjoxQK2Kv5dUgGHN1tiwBYPl837ha0neUHazremeoJt4lAaHiI
Message-ID: <CA+i-1C0pUX33A6zPFzk-2UtiQgAZG3hss3-aNcf1RYauUuQUWA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] treewide: fixup gfp_t printks
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Stanislaw Gruszka <stf_xl@wp.pl>, Alexander Potapenko <glider@google.com>,
 Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Allison Henderson <allison.henderson@oracle.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-wireless@vger.kernel.org, kasan-dev@googlegroups.com, 
 linux-mm@kvack.org, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
 rds-devel@oss.oracle.com
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

On Tue, 12 May 2026 at 23:05, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 12 May 2026 12:58:20 +0000 Brendan Jackman <jackmanb@google.com> wrote:
>
> > On Thu Mar 26, 2026 at 12:31 PM UTC, Brendan Jackman wrote:
> > > This patchset used to be about switching gfp_t to unsigned long. That is
> > > probably not gonna happen any more but while writing it I found these
> > > cleanups that seem worthwhile regardless.
> > >
> >
> > ...
> >
> > Any chance someone can take these?
>
> [2/4] is merged into the wireless tree (I assume) and the other three
> are in mm.git's mm-unstable branch.

Oh sorry, I just checked and I did actually receive the notification
when you queued it, I guess I just didn't parse it mentally.
