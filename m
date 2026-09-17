Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A79C88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:17:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF27610EFEF;
	Thu, 17 Sep 2026 17:17:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MZJxF3Wz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5644910EFEF
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 17:17:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BA63143944;
 Thu, 17 Sep 2026 17:17:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A951F00893;
 Thu, 17 Sep 2026 17:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789665468;
 bh=GXU1PpBZQU7XTDspOvSDjd7AoHPZBrsRywyurj0JQa0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MZJxF3WzCdmEKrSNZq6ufHzbYKXFys9mgiz424mlCWhuLbBplBoktOtdqal/mTtZQ
 S1SAnOKNEhpnQA64qmusKYCQ5ziVEgV11vjNg4iRpg1bO+TKZRBoiZbNUFiIetPi1O
 h5M348t2IvQk38TQL5rKaQJtWPCo6b11gwQMTGrkp3/6Z0yvJ+hphY0qhV+1JTvy3/
 CDpWIVUmHRjJ8AyrGFJQYAh61D5y10d5UAiWKSAdtI22k/VRzl7mNkMlotPcppe5NJ
 GwagQw+/NeeGH+CHlahKniQkYFat1gDIWm0Ozv3F0xLEeVwomFyNuQ9W2RXo5uUxeX
 959p27pqHefZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/40] mm/vma: tidy up map kernel pages enum values
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, selinux@vger.kernel.org,
 linux-perf-users@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>, "Vasily Gorbik" <gor@linux.ibm.com>,
 linux-rdma@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org,
 "Heiko Carstens" <hca@linux.ibm.com>, dri-devel@lists.freedesktop.org,
 linux-s390@vger.kernel.org, bpf@vger.kernel.org, linux-scsi@vger.kernel.org,
 kvmarm@lists.linux.dev, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Oliver Upton" <oupton@kernel.org>
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-7-4583d8a23bca@kernel.org>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-7-4583d8a23bca@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 17:17:47 +0000
Message-Id: <20260917171747.C0A951F00893@smtp.kernel.org>
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

> MMAP_MAP_KERNEL_PAGES is a mouthful, discard the MAP_ as that's implied by
> MMAP.
>=20
> Also while we're here delete useless comments for mmap actions whose names
> clearly indicate what they are for.
>=20
> Also update the userland VMA tests to reflect this change.
>=20
> No functional change intended.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917-b4-mmap-pr=
epare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org?part=3D7

