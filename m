Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46882CA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 18:30:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8718610EAD8;
	Fri,  9 Oct 2026 18:30:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="f2/FWM0x";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8E6710EAD8
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 18:30:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8EBC541968;
 Fri,  9 Oct 2026 18:30:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB331F000FF;
 Fri,  9 Oct 2026 18:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791570650;
 bh=ragqmZy1lTdfRRXyYL4oyabZhQWrFuqNRc66/eF209w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=f2/FWM0xQpYl/078U73bA1nv4M+lo+SUnBFC9mpDB/lgDQnRAJFifjNJ5X8zsV4QX
 6MnZZCi1SIt/RuCJpZLDdbL/8E8mIGiLf2weDmHZ4m9KusO27AR5lNbsj5QGBOJBHu
 ezRuaY04ZzA1Y3tU1pT8IWYSrPLSg359EfgGhNRqLXBkMaxhkuqnv1U0MZ6WcyF1+7
 9jFGwxe7EWAOAAvCJen+IcX8MuX/m/AfRQjKshMQX8oW0applhb/e6fCNSMs4+a3Z4
 3UEzk7ZodUCYb8w+yidhCppZFevfAMRf9ipuuL0QUdMsBrFdaaxc00KIr+iC7M5XJl
 7KjdLrxaqae3Q==
Message-ID: <sashiko-outbox-165949@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 13/38] bpf: arena: mark arena_map_mmap() mappings
 VM_MIXEDMAP
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
 selinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-scsi@vger.kernel.org, bpf@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>,
 "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, kvmarm@lists.linux.dev,
 linux-perf-users@vger.kernel.org, linux-rdma@vger.kernel.org,
 kvm@vger.kernel.org, linux-usb@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>
In-Reply-To: <20261009-b4-mmap-prepare-vma-flag-sanify-v5-13-923b70125b1e@kernel.org>
References: <20261009-b4-mmap-prepare-vma-flag-sanify-v5-0-923b70125b1e@kernel.org>
 <20261009-b4-mmap-prepare-vma-flag-sanify-v5-13-923b70125b1e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 18:30:49 +0000
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

> The bpf_map->ops->map_mmap callback invoked by bpf_map_mmap() can be set =
to
> one of ringbuf_map_mmap_kern(), ringbuf_map_mmap_user(), array_map_mmap()
> or arena_map_mmap().
>=20
> It is convention in mm to mark mappings whose pages the kernel manages
> itself with VM_MIXEDMAP, so core mm knows not to treat them as ordinary
> page cache or anonymous memory.
>=20
> The map_mmap callbacks ringbuf_map_mmap_kern() and ringbuf_map_mmap_user()
> use remap_vmalloc_range(), which ultimately invokes vm_insert_page() and =
so
> marks the ranges VM_MIXEDMAP, and array_map_mmap() sets VM_MIXEDMAP
> explicitly.
>=20
> However, the exception to this is arena_map_mmap(), which doesn't set the
> flag.
> [ ... ]
> in bpf_map_mmap().
>=20
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-b4-mmap-pr=
epare-vma-flag-sanify-v5-0-923b70125b1e@kernel.org?part=3D13

