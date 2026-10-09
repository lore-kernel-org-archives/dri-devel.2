Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF3CCA601F
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 18:40:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BAB110EB02;
	Fri,  9 Oct 2026 18:40:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lBeBICam";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5ED710EB02
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 18:40:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CD94040720;
 Fri,  9 Oct 2026 18:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF2331F000FF;
 Fri,  9 Oct 2026 18:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791571220;
 bh=U27k8sTfi+MHXeRUlWtLWw96IcybaMLRrGiJ4U+m5kA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lBeBICamTmNtr6V3chNxzXHmj/oSPxBK7MWKA4eSg4lEhCRI5itetpP42AMR/u+Jf
 a6ywcWRoAEbsIYoDoTMo1ocQl5iHn8RjmXSjwjGAGCOFW3/rb5R2mJMlhC+yUTjO5b
 Gyw9E1SQOI6WMYUHs5LObkDZsNwAax8kbaHbQGKsz16hslIkkxVm8Gk1YqDJwWJKAX
 yu2gyT2neJ0FRAnrZJdcYdNne8r0Z17NOazRQXmBO9eHoIT60HezCrmtzEyCiQA0B+
 xensWe9c1YcWxUDO/tNb/K0t4Z8KuEa3cmJKoLpaNNDW31xZVPnPMhnCqYusFUJZB5
 gMMmaGoKpBZpQ==
Message-ID: <sashiko-outbox-165960@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 27/38] mm: rename is_vm_hugetlb_page() to
 vma_is_hugetlb()
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 linux-usb@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-rdma@vger.kernel.org, linux-perf-users@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>,
 selinux@vger.kernel.org, linux-scsi@vger.kernel.org, kvmarm@lists.linux.dev,
 "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org,
 "Marc Zyngier" <maz@kernel.org>, "Oliver
 Upton" <oupton@kernel.org>, linux-s390@vger.kernel.org, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261009-b4-mmap-prepare-vma-flag-sanify-v5-27-923b70125b1e@kernel.org>
References: <20261009-b4-mmap-prepare-vma-flag-sanify-v5-0-923b70125b1e@kernel.org>
 <20261009-b4-mmap-prepare-vma-flag-sanify-v5-27-923b70125b1e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 18:40:19 +0000
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

> The is_vm_hugetlb_page() predicate is badly named - the mapping can span
> more than a page and it is inconsistent with other VMA predicates that
> typically are prefixed by vma_.
>=20
> Rename to vma_is_hugetlb() for consistency, and while we're here update
> some VM_BUG_ON_VMA() to VM_WARN_ON_ONCE_VMA() as to avoid unnecessary
> oopses.
>=20
> No functional change intended.
>=20
> Acked-by: Marc Zyngier <maz@kernel.org>
> Acked-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Acked-by: Anup Patel <anup@brainfault.org>
> Acked-by: Zi Yan <ziy@nvidia.com>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-b4-mmap-pr=
epare-vma-flag-sanify-v5-0-923b70125b1e@kernel.org?part=3D27

