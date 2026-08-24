Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F26C5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 19:24:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3071810E085;
	Mon, 24 Aug 2026 19:24:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ua2hD11N";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9391010E085
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 19:24:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 120A640B1C;
 Mon, 24 Aug 2026 19:24:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B091F000E9;
 Mon, 24 Aug 2026 19:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787599451;
 bh=G9QoI4+ym/7LyUWEV2yKR+PgnLxJt8QRpoDvSKD//hM=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=Ua2hD11NT1IrtaTLNIHoHhM/Mio61JgVNEJn443df2pVvyrNnjqvYt0frTSIKZ3fw
 RW6GTO7N9qF8bmPosIMvs+VcBNVxJBE+mqvPHypL2EXO61LRyS3M/PMMytAANCwQHX
 uIbVLyUmvf1zey94nbUHWtrXKCmSEuB2yaZHciRCsZJqROt4mKyPh0ik4kJU6P07Ii
 T2sW8qSTVG1f0Rhy/KyvdcvTJOB10iu31S0rHYUHt+vOHYkV+c2v8U7M9XgdtiDb9r
 VyHJU1jmLB76RBLBiMqOgs0PgPawNcQm8VcyMcrW0ImcxZQz1ZQzAg4lTSYtiEQ8YU
 if0BBnKHiiI5w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Aug 2026 21:24:07 +0200
Message-Id: <DKXF49DF656E.XB24SXGL3RLE@kernel.org>
Subject: Re: [PATCH v4 3/7] drm: nova: Add chipid enum to nova-drm UAPI
Cc: "Alistair Popple" <apopple@nvidia.com>, "nova-gpu"
 <nova-gpu@lists.linux.dev>, "Alice Ryhl" <aliceryhl@google.com>, "David
 Airlie" <airlied@gmail.com>, "Alexandre Courbot" <acourbot@nvidia.com>,
 "Benno Lossin" <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Eliot
 Courtney" <ecourtney@nvidia.com>, "John Hubbard" <jhubbard@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
To: "M Henning" <mhenning@darkrefraction.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260811050657.646799-1-apopple@nvidia.com>
 <20260811050657.646799-4-apopple@nvidia.com>
 <CAAgWFh0VvY4D=-Se+bVO1YonRNFEa28nc7+ZbxEbv6en7oPaDw@mail.gmail.com>
In-Reply-To: <CAAgWFh0VvY4D=-Se+bVO1YonRNFEa28nc7+ZbxEbv6en7oPaDw@mail.gmail.com>
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

On Mon Aug 24, 2026 at 4:49 PM CEST, M Henning wrote:
> On Tue, Aug 11, 2026 at 1:12=E2=80=AFAM Alistair Popple <apopple@nvidia.c=
om> wrote:
>> +/*
>> + * Opaque chipids. These may be used to determine what chip a particula=
r GPU is
>> + * based on the identifier but the values themselves should not be assu=
med to
>> + * carry any particular meaning.
>> + */
>
> You say this is opaque, but the userspace MR you posted already treats
> the values as non-opaque in eg. sm_for_chipset.
> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/43352/diffs?com=
mit_id=3D945a8e7c51939577526974b342c8dc6bafc3372f
> So, I guess my question is, is is opaque or not?

The PR is outdated and goes back to the first version of this patch series;
what's written here is correct.

> I don't see much of a reason to make it opaque since the chipset has
> had the same structure on the hardware level for 30 years, so I don't
> expect it to change too often. Truly treating this as opaque would
> likely require a small refactor on the userspace side without much
> value. (I realize this has already been discussed a bit on the
> previous version.)

I don't see much value in having userspace decode this value (again) after =
the
kernel did it already and can easily provide the required information witho=
ut
making userspace commit to some encoding in the hardware (even though I do =
agree
that it is unlikely).

OTH, the way chip IDs are derived has changed over the years (BOOT_0 / BOOT=
_42
with different register layouts), and I'd rather not have userspace commit =
to
any particular encoding when the kernel already provides the decoded
information.

Regarding the refactor in mesa, the Nova uAPI won't follow nouveau anyway, =
so I
don't want to limit ourselfs here.
