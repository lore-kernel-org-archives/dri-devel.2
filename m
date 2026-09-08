Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B3FC79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 20:45:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 289F410ED8C;
	Tue,  8 Sep 2026 20:45:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FGq9Hnzm";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4504010ED8A
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 20:45:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0E2B94147B;
 Tue,  8 Sep 2026 20:45:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5D51F00A3A;
 Tue,  8 Sep 2026 20:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788900309;
 bh=0fO0jNCzDdgYQ+m+Mnx4uE6iZxrpMVb7m/K40BKb6lc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FGq9Hnzma0sRuMFy06PQhOJtreLYfH+xlVBb0qaUU1Et0Z3jf+EL+AuLMBiCxT2rZ
 7vcomFIba5gndT/jNvd7guQTerBonsFuzeYOk6gg5xogb6acZiW5W1qLGH1Uanu2VY
 fpA6+6ZXxVCWLo/w2mTt7rebVSEbXkzgzwdEvFVlQ4aPjl72cjEfhLkCT+d5KvICGn
 IXTLhTvRSqXhLQZWSLJSCtVbyBygt20ZmM20t4shX9k5+K+JaKtkJaqNO9hxHMy05v
 /zc3G3nlGbU7leauqYtCqgbbyVcFMH6HSfg9gOVOgpsnZkEiSL/nrr+4HOr4EHlYVO
 mb+tpCIYcsYKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 38/39] mm/huge_memory: remove vma_is_special_huge()
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: kvmarm@lists.linux.dev, "Alexander Gordeev" <agordeev@linux.ibm.com>,
 bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, selinux@vger.kernel.org,
 "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-scsi@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, dri-devel@lists.freedesktop.org,
 kvm@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>, "Marc
 Zyngier" <maz@kernel.org>
In-Reply-To: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-38-dacf19cce22b@kernel.org>
References: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org>
 <20260908-b4-mmap-prepare-vma-flag-sanify-v1-38-dacf19cce22b@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 20:45:08 +0000
Message-Id: <20260908204509.2C5D51F00A3A@smtp.kernel.org>
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

> vma_is_special_huge() tests whether either the VMA_PFNMAP_BIT or
> VMA_MIXEDMAP_BIT is set (i.e. whether the VMA is a kernel-owned mapping),
> but with a DAX carve-out.
>=20
> DAX however no longer sets VMA_MIXEDMAP_BIT, so this carve-out is no long=
er
> required.
>=20
> Therefore test for vma_is_kernel_owned() instead and also drop the
> VMA_IO_BIT check, as it is now redundant since it is enforced that only
> kernel-owned mappings can set this flag.
>=20
> This also eliminates another overloaded use of 'special' within mm.
>=20
> No functional change intended.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-b4-mmap-pr=
epare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org?part=3D38

