Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96CE0C88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:38:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C61EE10F03F;
	Thu, 17 Sep 2026 17:38:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HFtL5ier";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80FFD10F03F
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 17:38:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6A9CB40879;
 Thu, 17 Sep 2026 17:38:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7968F1F000FF;
 Thu, 17 Sep 2026 17:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789666731;
 bh=AIgkhydL16FddHyVviB9BoApuP59gwu0nGbav0cWsGM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HFtL5ierRwZd3Zxu2oCAnwJbcTFeH9D80jmKu88eoUTDygP7ndof3oako268OgWdm
 3r2wm2p1JwhhxYPoE0iOOaVJMkqNHXx6/DMmI0g7v8j0ej8rdvPatGl5PcsnV5lZ6y
 gnWd24jEnJZzZPko9fAg+M+uJR0qjWB6lQkBD66l8Rpnsr2hs/QHizGjrGzZ6N2Qy0
 5hwestThJfO5Gejgu/aegJb9r7vXOdFZGwwTV/j5U+cIvMOs+dKoGJpa+XuveuvRHy
 CEJRXDJOs/ApI1d4SfxOSu6pQse7v5Mrz7iVOfPCWaYqkDMWRiCFpK/sV9ARc1WMOr
 lJeyIqLkBUNlg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 32/40] mm/uffd: use predicates for userfaultfd checks
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: linux-rdma@vger.kernel.org, "Marc Zyngier" <maz@kernel.org>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>,
 linux-trace-kernel@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvmarm@lists.linux.dev,
 linux-perf-users@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org,
 linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Oliver Upton" <oupton@kernel.org>,
 linux-scsi@vger.kernel.org, selinux@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-32-4583d8a23bca@kernel.org>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-32-4583d8a23bca@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 17:38:50 +0000
Message-Id: <20260917173850.7968F1F000FF@smtp.kernel.org>
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

> Rather than directly checking VMA flags, use the newly introduced
> vma_is_kernel_owned() and vma_is_persistent() helpers in userfaultfd when
> assessing VMA suitability for userfaultfd and UFFDIO_MOVE.
>=20
> Update vma_move_compatible() so it's expressed in terms of VMA
> characteristics rather than arbitrary flags.
>=20
> Additionally, update the use of the deprecated VMA flag API when checking
> VMA_SHADOW_STACK_BIT.
>=20
> A VMA_IO_BIT check is no longer required but that is fine as a hard
> invariant has been established that only kernel-owned mappings may set
> VMA_IO_BIT so the check is now redundant.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917-b4-mmap-pr=
epare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org?part=3D32

