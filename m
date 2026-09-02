Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F852C61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 19:42:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58F1310F32A;
	Wed,  2 Sep 2026 19:42:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IM2qHrmV";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A299D10E6DF
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 19:42:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5D936418E4;
 Wed,  2 Sep 2026 19:42:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA31D1F000E9;
 Wed,  2 Sep 2026 19:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788378153;
 bh=QI6DSgZHTMO2ZGXb0zdh14O9QI0CO32Juv51tWt/9y8=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=IM2qHrmV+36puV+WA/mObf99k1bRtgeJzU4sYcMCtLvFoH71rdiin537e4m0y0MhH
 9Dwgctfpz1cZm+bdvg12gr/3RhGOsCVSVIz5BXp/T9qH/KirZtF9KIm4ghrl+VMa6f
 aIGZ5c0bwPIbSYcarHubZfnK+7Cu94t1EwbHHI8gNKl8kwUHVtjP5MAnKUJhJLjn5x
 Khpj5XipvsklrSmk5edKhzGd3rcT/i0NkIS8TZm9WEQVEh8Y3WLhINd9xydnWoVdh+
 IZBIyObnCuQUI+ZFX6rmHxO5lyFiS4+HyG1whsljG3GUJ57s1iROfa3DAWc5+Zqo35
 hQm5l+4WitM+A==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 02 Sep 2026 21:42:29 +0200
Message-Id: <DL5357XTUJUG.R3WHR5BJY4X9@kernel.org>
Subject: Re: [PATCH v5 05/11] drm: nova: Add an info ioctl
Cc: "Alistair Popple" <apopple@nvidia.com>, "nova-gpu"
 <nova-gpu@lists.linux.dev>, "M Henning" <mhenning@darkrefraction.com>,
 "Alice Ryhl" <aliceryhl@google.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, "Eliot Courtney" <ecourtney@nvidia.com>, "John Hubbard"
 <jhubbard@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>
To: "Dave Airlie" <airlied@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260828033531.1117754-1-apopple@nvidia.com>
 <20260828033531.1117754-6-apopple@nvidia.com>
 <DL373JA1ZANX.21L51RTEUQ2UG@kernel.org>
 <apZCTUYiN5FHCkCm@nvdebian.thelocal>
 <CAPM=9twQxnx5DDkjwXWi-vXM4kqUQQdPaL+=1ASS0tpf2GmnYw@mail.gmail.com>
 <apZbKc5xMQ1yTBTu@nvdebian.thelocal>
 <DL3SXIIA4FID.2V3K5YC91RM3V@kernel.org>
 <apetgjQ9zWpJATj3@nvdebian.thelocal> <apfJhtr6BpMosz1q@nvdebian.thelocal>
 <DL52TB47MFFY.CICXD0XQ3T5K@kernel.org>
 <CAPM=9tyXx=BVy9E6PZNwYwab0SWWpFOFgX2jktqPVumiqY2viw@mail.gmail.com>
In-Reply-To: <CAPM=9tyXx=BVy9E6PZNwYwab0SWWpFOFgX2jktqPVumiqY2viw@mail.gmail.com>
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

On Wed Sep 2, 2026 at 9:38 PM CEST, Dave Airlie wrote:
> On Thu, 3 Sept 2026 at 05:27, Danilo Krummrich <dakr@kernel.org> wrote:
>>
>> On Wed Sep 2, 2026 at 9:05 AM CEST, Alistair Popple wrote:
>> > On 2026-09-02 at 15:21 +1000, Alistair Popple <apopple@nvidia.com> wro=
te...
>> >> Ok, so just to double check are you happy with an accessor to return
>> >> gsp_static_info as well?
>> >
>> > Still interested in your thoughts here though, just to avoid churn bec=
ause I'll
>> > probably pick the wrong answer :-)
>>
>> Yeah, exposing that for gpu_name() seems fine.
>
> Though userspace doesn't probably need this, but we could I suppose.

Yeah, it shouldn't be needed for anything, but I also don't think it hurts =
and
it could be nice to be consistent about the name throughout the different
layers.
