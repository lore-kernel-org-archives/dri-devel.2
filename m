Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1714BC88E72
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 22:19:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E32A10E236;
	Mon, 14 Sep 2026 22:19:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mMm/Ui1q";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE0B910E236
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 22:19:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 64CF960252;
 Mon, 14 Sep 2026 22:19:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4018B1F000FF;
 Mon, 14 Sep 2026 22:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789424353;
 bh=ZMreeLGZXd1a0gHBZICLTBw5/fHg1G2tHuRz1UXG1HU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mMm/Ui1qEue4J65cMUHYcoQbb032A+jJjWk3BF1cweAjtspH2Xj/LPmSZ9nTgE3gJ
 aTjG22CVqZYrffds+j8TrrCWhr6wtS2HlA2+SQ/m5kN1p6y2XjAmxEQNLxBZh8p4s7
 PAbcPLuGAsZU9mvGaGZtzvClvXWKSyhGPbk5amXpeNc8v1OgyHTnc4MMXvf5k0RCgh
 n1wtPA13dqaQCSpPe5b+zChW4WLrmFWpHNZzLkiJkSyPP66BBAz81Fzy5Q0FTEtVdq
 gEA/nqsBZjrt/qRTk8h+zt3apaVZsYuuTfqVPPeZ9btsxZgZnHLRUZFDxGKOPqxCEJ
 a1w53x0K4+zyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 37/40] mm: eliminate VM_SPECIAL, VMA_SPECIAL_FLAGS
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org,
 bpf@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, "Vasily Gorbik" <gor@linux.ibm.com>,
 linux-trace-kernel@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, dri-devel@lists.freedesktop.org,
 linux-s390@vger.kernel.org, kvmarm@lists.linux.dev, "Marc
 Zyngier" <maz@kernel.org>, linux-rdma@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-perf-users@vger.kernel.org,
 selinux@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-37-7d9781ed5361@kernel.org>
References: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org>
 <20260914-b4-mmap-prepare-vma-flag-sanify-v2-37-7d9781ed5361@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 22:19:11 +0000
Message-Id: <20260914221912.4018B1F000FF@smtp.kernel.org>
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

> Every user of the VM_SPECIAL or VMA_SPECIAL_FLAGS has now been converted =
to
> predicates which explicitly express what is actually being checked for
> rather than the nebulous concept of possessing 'special' VMA flags.
>=20
> In any case 'special' is not so special a term of art in mm - it includes
> VDSO/VVAR mappings, special in the sense of vm_normal_folio() and probably
> other cases too.
>=20
> Therefore make things less special by eliminating these now unused flags.
>=20
> No functional change intended.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914-b4-mmap-pr=
epare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org?part=3D37

