Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F23C982D2
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:32:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 900EE10F01D;
	Thu, 17 Sep 2026 17:32:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hEKvOEmF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A869E10F01D
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 17:32:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9155540393;
 Thu, 17 Sep 2026 17:32:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9751F00893;
 Thu, 17 Sep 2026 17:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789666328;
 bh=GAO9KibmnfrQxgnwITWH7iMqVZyTj9/wfGKSkT64HXs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hEKvOEmFJhLn++y+Qg8OnPolhsNIJt+Pm8hxkX4/PGTmCd3lib+Qc/LpyNb0fD/0Z
 Z+VpCnoE2DeLrvwZBLJ1tD0v326OR9V68XFbyr3ix7fR615dBofSoIcDuIsP7oWeBO
 6lHjdUyIi7m3k7HPUBQPniQJpu9N7taSKVjRS3RUZ5e5H4lc0YXseD0JxCjfHsIDV4
 Id9NsuVU0A2H7/czKG20OApcysu6FW+xI+oKWHJZHkcaa8JLvAdiLxTnRcEHoZQHd5
 T5uqs7nBx2JW5u2mJfX0aGV+e38PW0aLru9Ywkco5D9Di7uh18zRPeFWs87n88iSuR
 AIkXBG6v8IQag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/40] mm/vma: ensure mmap_prepare doesn't set
 actions on a mergeable vma
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Marc Zyngier" <maz@kernel.org>, "Oliver Upton" <oupton@kernel.org>,
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-rdma@vger.kernel.org,
 "Heiko Carstens" <hca@linux.ibm.com>, dri-devel@lists.freedesktop.org,
 linux-trace-kernel@vger.kernel.org, selinux@vger.kernel.org,
 linux-perf-users@vger.kernel.org, kvmarm@lists.linux.dev, kvm@vger.kernel.org,
 bpf@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-5-4583d8a23bca@kernel.org>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-5-4583d8a23bca@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 17:32:07 +0000
Message-Id: <20260917173207.DA9751F00893@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

> When a user requests an mmap_action be performed in mmap_prepare, this
> involves populating the VMA range with data.
>=20
> However, if the VMA is mergeable, it might then mistakenly be merged with
> another VMA without having populated the range.
>=20
> Every mmap action currently available sets VMA flags such that the VMA
> cannot be merged.
>=20
> However, to ensure that no future mmap action falls foul of this, assert
> that this is the case upon mmap_prepare validation.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917-b4-mmap-pr=
epare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org?part=3D5

