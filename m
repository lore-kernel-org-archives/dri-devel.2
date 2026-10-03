Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD12FCA5FED
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:56:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10A6310E947;
	Sat,  3 Oct 2026 17:56:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ew+G5Nlh";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B129B10E947
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 17:56:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 98F1E44858;
 Sat,  3 Oct 2026 17:56:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD6AE1F0089D;
 Sat,  3 Oct 2026 17:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791050195;
 bh=Ihh78CSduPBZvC+R/H8Na4GX+aBSwRY3bPQsZRmhkKU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ew+G5NlhkpDvMqnP6aqx9NV91Irlh2ZBpWiHT7tMhRE+5QgmS8HEq+Pj3RDyQH5kI
 Uk7OmzIYk5HsHD8H+NVVfEKUG2iRLjDuqyIthBg/5+qa3B+uaLNT/G1xoc+rmNuFjx
 SLmQeYv3yxpJNJwiGCCDxZNtngJ0/2IxVNKzuDdD7JYw2jiyu4nEHVQDeNbGREZvUd
 NNsGd9ch6S18IWFYaQmsFaUk3YvjK0ErX7cP5OF8dU/pCa7NeGqku8CfDEZlH/WiKd
 7lLihS6/Y7qIm4trjzd+LfbCyPT6iO1CF88favrXULXMfeZ9sxEVcT6jAWQLlfoDgT
 BtHAOiWCQVANg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/38] docs: filesystems: update mmap_prepare docs
 for discontig kernel pgs
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org,
 "Oliver Upton" <oupton@kernel.org>, "Vasily Gorbik" <gor@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 linux-perf-users@vger.kernel.org, selinux@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, bpf@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "Marc
 Zyngier" <maz@kernel.org>, "Alexander Gordeev" <agordeev@linux.ibm.com>,
 kvm@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kvmarm@lists.linux.dev
In-Reply-To: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-8-a1f052500fd7@kernel.org>
References: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org>
 <20261003-b4-mmap-prepare-vma-flag-sanify-v4-8-a1f052500fd7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 17:56:34 +0000
Message-Id: <20261003175634.AD6AE1F0089D@smtp.kernel.org>
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

> Describe the newly introduced discontiguous kernel page mapping mechanism,
> detailing how to use it sensibly and how the API looks.
>=20
> Explicitly detail the various discontiguous actions available and how to
> use them.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003-b4-mmap-pr=
epare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org?part=3D8

