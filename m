Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B588C44508
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 15:55:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA16810E1FA;
	Wed, 15 Jul 2026 15:55:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ocQo6Ofu";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B049110F10B;
 Wed, 15 Jul 2026 15:54:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 34E0E42A3E;
 Wed, 15 Jul 2026 15:54:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6DA11F000E9;
 Wed, 15 Jul 2026 15:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784130898;
 bh=/4je5v4Zc6foYfwF22j5/Y0sxbqqutXc3dxRqcgRIFQ=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=ocQo6OfuCAGy9CbCU8jZO8bqxs3VCUC7UGkA6+1qW4pB7dfnvZwPl16bCqt1P0JK3
 04lGRPsWduj7NXGdZiuEISgwzhSP4QmFbl3BPHM0L3UDwkiKTwBQETnRf40eVS6KlX
 DaHuSx9LOnLIjQMTMIfHvTcejI+98lJzUcB3e4dFCMqc9x8Gqx36ZbPnrGvS00sjdd
 0p9PVefoSlIGmrEkECCWBopH4/fdwDgichvQ7yAK2dAK9hab2wlW3aAfhS7Sbee1cR
 +O8DYzTXTi1Xl5NUt8hucc7DV9JwjM7t2ahSLzgrgoQXu/gzdZjiSwtD1r0MT7rpJw
 rPpoB+Efr9gAA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Jul 2026 17:54:53 +0200
Message-Id: <DJZ9M9BXQ30B.281L7YHD2MMAV@kernel.org>
Subject: Re: [PATCH v7 3/4] driver core: platform: unify release path
Cc: "Maximilian Luz" <luzmaximilian@gmail.com>, "Hans de Goede"
 <hansg@kernel.org>, =?utf-8?q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, "Matthew Brost" <matthew.brost@intel.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Rodrigo Vivi" <rodrigo.vivi@intel.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, <platform-driver-x86@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <driver-core@lists.linux.dev>, "Bartosz
 Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
To: "Bartosz Golaszewski" <brgl@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260713-swnode-remove-on-dev-unreg-v7-0-6d6bc448427a@oss.qualcomm.com>
 <20260713-swnode-remove-on-dev-unreg-v7-3-6d6bc448427a@oss.qualcomm.com>
 <DJXNZLE3L756.K5DYSTKM1UHT@kernel.org>
 <CAMRc=MfOipGdiGXNgVrJVO8QOivQ-=8k3sX-nMfTS0DvdZcFnw@mail.gmail.com>
 <CAMRc=MeXwaRSDJYKeoM6PfqWqRPh9KCMF8HATFvaTWUf6N6GYA@mail.gmail.com>
 <DJZ8VG4H46XC.36XXT1A34B0TK@kernel.org>
 <CAMRc=MdKgadBrcBG=Rp68WfLzL2PCUMhmcma85BY=DYqUmt0kg@mail.gmail.com>
In-Reply-To: <CAMRc=MdKgadBrcBG=Rp68WfLzL2PCUMhmcma85BY=DYqUmt0kg@mail.gmail.com>
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

On Wed Jul 15, 2026 at 5:25 PM CEST, Bartosz Golaszewski wrote:
> While at it: the other dependency of this series is:
>
>   https://lore.kernel.org/all/20260713-swnode-fw-devlink-v4-0-d4f2dee27ad=
9@oss.qualcomm.com/
>
> It's been reviewed and I think it's ready. It shouldn't conflict with the=
 other
> dependency that Greg already queued. Would you mind picking patches 1-4 f=
rom
> that series into an immutable branch based on v7.2-rc1 and taking them th=
rough
> the driver core tree and I'd queue patch 5 through the GPIO tree after fi=
xing
> conflicts with other GPIO kunit tests I already picked up?

Yeah, I have that series on my list to follow-up on, will do.

Thanks,
Danilo
