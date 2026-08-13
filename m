Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5811AC5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 20:00:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF77610E4C4;
	Thu, 13 Aug 2026 20:00:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lRqSVfFA";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 184C110E4C4
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 20:00:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 386B3601DE;
 Thu, 13 Aug 2026 20:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C6B1F000E9;
 Thu, 13 Aug 2026 20:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786651223;
 bh=QiaJZv1odoPlOyxmY+lNT4TcM3zQ6uvi+7GgTHIP83w=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=lRqSVfFAKnGHJM2qTZJ82qsKiZFKAY79vTyxmRnQ4PGHOCUscCGApKjOWSEgFPY5s
 cbcOLZEPzOkDQH1QdqQzebLiPKRU0oGDnZ5mwjXQJp8aR2HcWgXE330MvkHcfH2wv0
 keDIqMfpbWmv2rpRfy+RKz4jM4lk8PTcI9ByKuAcaeo9hhWO69PYqKp3Yr8OiKZVfZ
 g9DdVq6bFRVc23qKcJdQ/870GCPkiUzbMa5hj0To85PY66yU7okulypL8mMjGRrBYq
 87H4T3TAtMYaDrDhz5+L3HJ7d374myFLh86+tcYUKfehgNQR0UA+mi6xCEH+rfKcih
 T0lkYxEVaKx6A==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Aug 2026 22:00:20 +0200
Message-Id: <DKO2ZZQU2MQ9.B0PAI47OAV0I@kernel.org>
Subject: Re: [PATCH 1/2] gpu: nova-core: gsp: retain the GSP-RM log buffers
 after unbind
Cc: "Timur Tabi" <ttabi@nvidia.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "vladazaharova2018@gmail.com"
 <vladazaharova2018@gmail.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "nova-gpu@lists.linux.dev"
 <nova-gpu@lists.linux.dev>, "aliceryhl@google.com" <aliceryhl@google.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
To: "John Hubbard" <jhubbard@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260812113752.532537-1-vladazaharova2018@gmail.com>
 <20260812113752.532537-2-vladazaharova2018@gmail.com>
 <a72edc5b-49c0-42e0-b21c-940e71909666@nvidia.com>
 <5efa940cf5271c7bc0d725b7f0df365f247f08da.camel@nvidia.com>
 <aecd067a-e308-44b5-ae46-8f9947c9b44e@nvidia.com>
In-Reply-To: <aecd067a-e308-44b5-ae46-8f9947c9b44e@nvidia.com>
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

On Thu Aug 13, 2026 at 9:30 PM CEST, John Hubbard wrote:
> On 8/13/26 9:29 AM, Timur Tabi wrote:
>> On Wed, 2026-08-12 at 15:41 -0700, John Hubbard wrote:
>>> And so should nova! (Except for the strangely worded "keep_gsp_logging"
>>> param name.) See below.
>>=20
>> The patch set that added that parameter to Nouveau was under review for =
months, and no one had
>> any complaints about it until now.  Regardless of whether it's "strange"=
, I think it's important
>
> I'm not keeping a close eye on the nouveau list.

That was back in 2024 and when I reviewed this series I wasn't paying too m=
uch
attention on the name.

That said, the name is in fact misleading as we do not keep the GSP logging=
, we
only keep the logs.

Since we're now already in the game of bikeshedding over the name, I'd like=
 to
go with "gsp_keep_logs". :)

>> that both Nouveau and Nova use the same parameter for the same functiona=
lity, so Nova should
>> also call it "keep_gsp_logging".

There's not much value in doing that, and as I've mentioned previously in a
discussion about the uAPI, I don't want to constrain nova on anything becau=
se of
how things work in nouveau.

> Completely disagree. There is no need for these disparate drivers to shar=
e
> a name, especially given that a better name is available. I'm quite
> unhappy with your continuing efforts to add artificial constraints
> along the lines of "nova must match nouveau", tbh.
>
> Nothing is stopping nouveau from adopting nova's names, if that is
> desirable from their end.

It's not.
