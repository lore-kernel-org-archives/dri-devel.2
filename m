Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0F4C88E72
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 17:07:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FF6C10EF61;
	Mon, 14 Sep 2026 17:07:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Y4g1lfq0";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A9E110EF61
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 17:07:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C68D460142;
 Mon, 14 Sep 2026 17:07:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43831F00893;
 Mon, 14 Sep 2026 17:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789405622;
 bh=MQcF/CGomkZ3dEdeDHD/Q95+yW149OLQeArDbXHiVzM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Y4g1lfq0JkHgBsnAfOst9SbKIjIZ5eXXb66KG0e2Yzqvdz+Cl4Y57fLx0V9X2FgCo
 6LhaDOo0cVFhfcCo6AosnHH5/nOczsnngTf6yaLcm703B1BKF/hjMr30KP1GTcZzAP
 ELB/DpSA2qc26i9gtDkVwG6uhp9dgnZ8XdrstmJyt/fIFoy1BO5ANukQ0L6wiPzNhi
 qHg2KQIBtbkrdYeXm2ZHXELJS1RigduVviWUXmP9oeGsHEHXfFe4l4TdQdJTsvqCma
 sIRsBN0k3YPcLUm8OmrHFVXo0MgdsfzsGRkyXcEB+VuLmM1aX5KxVguLC459oj8K7m
 NDhJMBEMKsgLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/40] docs: filesystems: update mmap_prepare docs
 for discontig kernel pgs
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org,
 "Oliver Upton" <oupton@kernel.org>, linux-trace-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, selinux@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>, linux-s390@vger.kernel.org,
 dri-devel@lists.freedesktop.org, kvmarm@lists.linux.dev,
 linux-perf-users@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>,
 bpf@vger.kernel.org, linux-scsi@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-9-7d9781ed5361@kernel.org>
References: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org>
 <20260914-b4-mmap-prepare-vma-flag-sanify-v2-9-7d9781ed5361@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 17:07:01 +0000
Message-Id: <20260914170701.E43831F00893@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914-b4-mmap-pr=
epare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org?part=3D9

