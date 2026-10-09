Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6645CA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 18:38:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2951710EAFC;
	Fri,  9 Oct 2026 18:38:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fPHU9jLb";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19A9410EAFC
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 18:38:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0DBCB60267;
 Fri,  9 Oct 2026 18:38:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D2E1F000FF;
 Fri,  9 Oct 2026 18:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791571118;
 bh=bqkQD/zP3J/tsQX0wRYaRbA+6NDUvRGYQYgejR63mTI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fPHU9jLbul+/4priEHwM5cMJmSkp5TZOvUXZjyQ+rggeFCpFZAxMCYjacDkttnhzZ
 TUkupONBhkz/nHkXc1/a6ayr2NQnBn0P2Pz8PPE26E5zQnk6TPl3sAHJKDYahBzxK0
 rmtDbReGqteyF2CFU0N9+64i8Mf6omg0B7YH7vMcIzJVTt3yOcXmJ7HVz0nHlbBYlh
 Rk+yTQIaUoHB3V0wTNK0tawgq4mpzrUViS9KEueG5lJJTjSboRIF8goqzxjDZbor1e
 Zxp/3CR5lo/4kr3azciAZKZYzCZNmxIAS4n10gYSLfd9Jsl4kSjteakazHk/LmvtCO
 /5AXw98F1+Erw==
Message-ID: <sashiko-outbox-165957@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 12/38] ALSA: pcm: use vm_insert_page() to map PCM
 status page
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: linux-usb@vger.kernel.org,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org, "Oliver
 Upton" <oupton@kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>,
 linux-scsi@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>, linux-perf-users@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvmarm@lists.linux.dev,
 selinux@vger.kernel.org
In-Reply-To: <20261009-b4-mmap-prepare-vma-flag-sanify-v5-12-923b70125b1e@kernel.org>
References: <20261009-b4-mmap-prepare-vma-flag-sanify-v5-0-923b70125b1e@kernel.org>
 <20261009-b4-mmap-prepare-vma-flag-sanify-v5-12-923b70125b1e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 18:38:37 +0000
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

> There's no need to keep a fault handler around for this, instead map on
> mmap.
>=20
> While we're here, rename area to vma to be consistent.
>=20
> This correctly makes the mapping a mixed map mapping.
>=20
> This works towards establishing the invariant that only PFN mapped or mix=
ed
> map mappings may clear the VM_MAYWRITE flag. The status page mapping clea=
rs
> VM_MAYWRITE, so it must not be mm-managed; the control page mapping remai=
ns
> writable and is left fault-based.
>=20
> The assumption is made that the struct pcm_mmap_status structure is at mo=
st
> a page in size, which is asserted as a build bug.
>=20
> This is safe to assume, as the size of the structure is 56 bytes at most.
>=20
> Acked-by: Takashi Iwai <tiwai@suse.de>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-b4-mmap-pr=
epare-vma-flag-sanify-v5-0-923b70125b1e@kernel.org?part=3D12

