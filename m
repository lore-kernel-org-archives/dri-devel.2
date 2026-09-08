Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38CE5C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 20:36:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B58010ED72;
	Tue,  8 Sep 2026 20:36:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="F+6XI0RL";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CF1210E53F
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 20:36:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1EB58415D1;
 Tue,  8 Sep 2026 20:36:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397921F00A3A;
 Tue,  8 Sep 2026 20:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788899778;
 bh=E/wOJJaiN86yA6C+CnI8JxBGKVbnXnR8Q05fxWG5SNY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=F+6XI0RLwgUtgRuWhZf/pCBWO0VMC6KyA+v47Wtby5K7oj0fOfra4NSugp/25gBj+
 J0h+5saCtRVkXQlbg1l6Hhasq83eAChqqN6aADJoSQ6KNNvmhDp9AktWvznNsTTh5x
 0nNDewgPoFwHJNZYNEkM4ml0fZsMF3Gs5b21W4pB6PN9k1CR5XEAqzUkyIQY+U4vC7
 Hxl4DoIc16Uv+JIHNakHLd/GpMAKlki1GXihpu3ftx9AOw/20ro5Pl2jsy9n+veVzd
 m/I4i8572VH4N5JnA8fpTmTvBodoXdqnqJ5ohQ9bzw7OjDOnsKdtUNe5rRiOG8603d
 pB2nPzq+43jbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/39] selinux: reject writable opens of policy file,
 drop mmap shared/write check
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
 "Alexander Gordeev" <agordeev@linux.ibm.com>, selinux@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
 "Heiko Carstens" <hca@linux.ibm.com>, linux-scsi@vger.kernel.org,
 "Oliver Upton" <oupton@kernel.org>, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, kvmarm@lists.linux.dev,
 "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-11-dacf19cce22b@kernel.org>
References: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org>
 <20260908-b4-mmap-prepare-vma-flag-sanify-v1-11-dacf19cce22b@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 20:36:16 +0000
Message-Id: <20260908203617.397921F00A3A@smtp.kernel.org>
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
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-b4-mmap-pr=
epare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org?part=3D11

