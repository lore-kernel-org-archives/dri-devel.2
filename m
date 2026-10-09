Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38843CA9EBD
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 18:33:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D6C210EAE0;
	Fri,  9 Oct 2026 18:33:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nwwBPEuO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32BC710EAE0
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 18:33:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F087F43274;
 Fri,  9 Oct 2026 18:33:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ABF01F000FF;
 Fri,  9 Oct 2026 18:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791570835;
 bh=xkooYtsuVAkQrEBEYuW+eOExdD7O8DWUyq4mMnL2MuU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nwwBPEuOkW4GWjitpf8Zm2Ohvg2267+y0Cd9lr+Tzjiv5g0sSo38K6uiaK/3+QJQm
 foR3DeCkaGBeYV7ixqfBSVV9xXKJrorYbejxDDMyT81suTY7/ckWDgiaAY0dDHmENx
 1o8PpT2K+FyYd9MQ4O9Dq5C/Z3HgZVYOWy5Gb9xPSc54+LMA2WtboCEGjOHwTblfsh
 qaf3tV4iRN35f93TXtZbFlbY01XxAiOn8ToCF7avkOVJ/HA4dP9J7UtKu9jRz/JcCB
 YRj5ewab+r9e4EUkQx0V5+4cI4JE4AX5shfy7smqOS2B8iWsjjCxDF51Wy8YveJP6d
 s3U88woecfatQ==
Message-ID: <sashiko-outbox-165952@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/38] mm: consistently validate VMA state after
 mmap[_prepare] hooks
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-usb@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org,
 dri-devel@lists.freedesktop.org, selinux@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Marc
 Zyngier" <maz@kernel.org>, linux-perf-users@vger.kernel.org,
 "Vasily Gorbik" <gor@linux.ibm.com>, kvmarm@lists.linux.dev,
 linux-scsi@vger.kernel.org, "Oliver Upton" <oupton@kernel.org>
In-Reply-To: <20261009-b4-mmap-prepare-vma-flag-sanify-v5-3-923b70125b1e@kernel.org>
References: <20261009-b4-mmap-prepare-vma-flag-sanify-v5-0-923b70125b1e@kernel.org>
 <20261009-b4-mmap-prepare-vma-flag-sanify-v5-3-923b70125b1e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 18:33:54 +0000
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

> When the f_op->mmap_prepare or deprecated f_op->mmap hooks are invoked, t=
he
> driver might have done something crazy that is not permitted by the kerne=
l.
>=20
> Currently we check for three such cases in __mmap_new_file_vma(), but only
> if the legacy f_op->mmap hook is used:
>=20
> * Did sparc ADI result in invalid flags?
>=20
> * Did the driver alter vma->vm_start?
>=20
> * Did the driver make a file-backed mapping on a read-only file writable?
>=20
> Generalise these checks for both mmap_prepare and mmap and apply to all
> invocations of mmap_file(), the f_op->mmap and f_op->mmap_prepare handling
> in the core VMA code and the mmap_prepare compatibility layer.
> [ ... ]
>=20
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-b4-mmap-pr=
epare-vma-flag-sanify-v5-0-923b70125b1e@kernel.org?part=3D3

