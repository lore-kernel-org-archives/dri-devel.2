Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B6DC88E72
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 17:57:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FF3910F0B0;
	Mon, 14 Sep 2026 17:57:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YKrMGe5Z";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47A5E10F0AD
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 17:57:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5196260142;
 Mon, 14 Sep 2026 17:57:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39AD51F000FF;
 Mon, 14 Sep 2026 17:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789408631;
 bh=WHAxO356QeI65K8FMrnonWX56V/LH6e9elTcvnVoWlk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YKrMGe5ZrWmP2IYG3Jun3Vjv9FUR6gAckPZkcC30ml3mPYXnemCGJsVKf8Rj7xUCt
 z4HCL01q2Sfc71umZWC9p2shEG3xynK6qLlUh6CKbWOG66pOX8aXmAUsU4vOBhiRZt
 BIi0VKSvMtbAgUoX2/QIzysb9RwzR4VD8nK0XSfGxN1JGBW9VhUQhuBuXQbTuirMmI
 8S4QA52ZZvArZd802IgOlbMjNd27ZilDOXu3ch4olD2riPGArhTDLQZyfeNpPPx/5q
 NkDUJlXLMSo+Gfj4AIYvEquiv0K/WoBuM9/B5gUHhW3hLuDRvAWftvUI1ZCBf02mQD
 G2o1wLs4yXxOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/40] selinux: reject writable opens of policy file,
 drop mmap shared/write check
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: kvmarm@lists.linux.dev, "Alexander Gordeev" <agordeev@linux.ibm.com>,
 dri-devel@lists.freedesktop.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>,
 linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-scsi@vger.kernel.org, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, selinux@vger.kernel.org,
 "Vasily Gorbik" <gor@linux.ibm.com>, bpf@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>
In-Reply-To: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-12-7d9781ed5361@kernel.org>
References: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org>
 <20260914-b4-mmap-prepare-vma-flag-sanify-v2-12-7d9781ed5361@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 17:57:09 +0000
Message-Id: <20260914175710.39AD51F000FF@smtp.kernel.org>
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

> The policy file has no write method and is exposed read-only (S_IRUGO in
> selinux_files[]), yet sel_open_policy() performs no open mode check, so a
> CAP_DAC_OVERRIDE caller can open it O_RDWR. Reject FMODE_WRITE at open, as
> kernfs does.
>=20
> The file can then never be mapped with FMODE_WRITE, so do_mmap() always
> clears VM_MAYWRITE and VM_SHARED for MAP_SHARED mappings and the VM_SHARED
> check in sel_mmap_policy() cannot be reached. Remove it.
>=20
> This also stops sel_mmap_policy() clearing VM_MAYWRITE on a mapping that =
is
> neither a PFN map nor a mixed map, ahead of the core enforcing that only
> such mappings may do so.
>=20
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Reviewed-by: Jann Horn <jannh@google.com>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914-b4-mmap-pr=
epare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org?part=3D12

