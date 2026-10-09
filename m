Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D42ECA601F
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 18:30:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CB1110EAD9;
	Fri,  9 Oct 2026 18:30:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DPi2tokp";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10D9010EAD8
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 18:30:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ED07A41A84;
 Fri,  9 Oct 2026 18:30:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04381F00893;
 Fri,  9 Oct 2026 18:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791570651;
 bh=cpHIMphgw62XFR7fvZZkJ920KR9jdrtpSZVH5YIU8XE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DPi2tokpdYsbPOLJoVW1SuN1eU3QNA+exL2AxM2HV35PBVj3cY0H+Fb2oIGJ2dxBL
 FgOFz8BT1nFJIQaduPwRoKbNxibYcTBOHIEyjKogiizmlLHlWhW6O3NmLeSiLn8SOL
 CsUoAS5XnX/kDZICsh8NFtJhmHvU5VeFwfrpPdLhZ9uhspdKDOaCdIIDrAWopvCUJs
 D+iCWogbtChHs1u4dS9DfXhC5rHDrz5Td9Id3dad+1AzEaingK5opKNGgx4hJK5/ko
 ox+tZTp7LziRZlm4IVwXIH1cJOzLXmEz9+igkKuZo+DPZ8VtYzL2vgQR1AVcv8Te0N
 cx345Dx4MxZRQ==
Message-ID: <sashiko-outbox-165950@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/38] infiniband: update hfi1 to use
 remap_vmalloc_range()
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: dri-devel@lists.freedesktop.org, bpf@vger.kernel.org,
 "Marc Zyngier" <maz@kernel.org>, linux-scsi@vger.kernel.org,
 kvmarm@lists.linux.dev, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-rdma@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-perf-users@vger.kernel.org,
 linux-usb@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-trace-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, selinux@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>
In-Reply-To: <20261009-b4-mmap-prepare-vma-flag-sanify-v5-10-923b70125b1e@kernel.org>
References: <20261009-b4-mmap-prepare-vma-flag-sanify-v5-0-923b70125b1e@kernel.org>
 <20261009-b4-mmap-prepare-vma-flag-sanify-v5-10-923b70125b1e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 18:30:50 +0000
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

> In cases which map chip memory from vmalloc()'d ranges, the hfi1 infiniba=
nd
> drivers currently installs a fault handler, and then smuggles the kernel
> virtual address of this range in vma->vm_pgoff.
>=20
> This is exposing KASLR-sensitive internal kernel state in the VMA, and is
> entirely unnecessary.
>=20
> Instead, use remap_vmalloc_range() to remap the VMA to the span, and
> eliminate the fault handler altogether.
>=20
> remap_vmalloc_range() checks that the VMA does not extend beyond the
> vmalloc area, and the driver already requires the VMA to exactly match the
> span of the memory being mapped, so this has no impact.
>=20
> The memory is all preallocated so not having a fault handler has no impact
> [ ... ]
> There is a change in behaviour in that pages mapped using
> remap_vmalloc_range() will now have normal GUP-able pages, however this
> should have no impact as there is no reason not to allow this.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-b4-mmap-pr=
epare-vma-flag-sanify-v5-0-923b70125b1e@kernel.org?part=3D10

