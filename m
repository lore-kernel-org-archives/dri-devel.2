Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBB3606A327
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JWs4TEsS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75A2D10EC98;
	Sat, 14 Nov 2026 16:17:56 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 209FB10E328;
 Sat, 14 Nov 2026 16:17:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 53608623A4;
 Sat, 14 Nov 2026 16:17:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6CC91F000C6;
 Sat, 14 Nov 2026 16:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794673069;
 bh=Wr0YDk2NIO72Qi+lObtIXD2n/bb8N256RnBpGouW3is=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JWs4TEsSGe0kyFleCxiyTr9cmPMMMoJW+emYWQfEtMThHeFR2D1CbpqZH0DFgR9wC
 PKqxusV3O51mlC71Q4IdtNtqnTgaVINHEvzpSWGtLk7JGnJlv+Ze5EFuPAAz15yjlj
 l6VT+f9Zqc1DLd5orZo/9qfCka/dnew1L77IUgxebAW96KM+wc2wJb8s5yDLpJfYJj
 iP4T2z0B72YAdNRgPYt0vlZgFRNf0Ja1aDeE6vECDUD/1ZnBxmipo4Xz0brgdTOI3a
 zbXIk6N94oCYiREbEm3zibUn3qXlsdBl0g9bqx9eTP7oGGLhcIp0ZMCwcXudkoD0Rp
 ymevyRYgnYQhA==
Message-ID: <sashiko-outbox-214740@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/12] platform/apple-gmux: Fix MMIO interface
To: "Atharva Tiwari" <atharvatiwarilinuxdev@gmail.com>
Cc: =?utf-8?b?b3BlbiBsaXN0OlBDSSBTVUJTWVNURU0=?= <linux-pci@vger.kernel.org>, 
 =?utf-8?b?b3BlbiBsaXN0OlJBREVPTiBhbmQgQU1ER1BVIERSTSBEUklWRVJT?=
 <amd-gfx@lists.freedesktop.org>, 
 =?utf-8?b?b3BlbiBsaXN0OkRSTSBEUklWRVJT?= <dri-devel@lists.freedesktop.org>
In-Reply-To: <20261114160731.3756-4-atharvatiwarilinuxdev@gmail.com>
References: <20261114160731.3756-1-atharvatiwarilinuxdev@gmail.com>
 <20261114160731.3756-4-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 16:17:48 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] platform/x86: apple-gmux: missing Fixes trailer for commit
  0c18184de990
--

commit b19f0c98a4551005b56d57291e3256d29b977707
Author: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

> platform/apple-gmux: Fix MMIO interface
>
> This patch brings a lot of fixes to MMIO interface such as:
> 1. Using 1ms waits instead of 100us.
> 2. Checking if Timed out before reading and writing
> 3. Adding missing wait before gmux_mmio_write32
>
> Tested-by: Sebastian Zygadlo <szgit@icloud.com>
> Tested-by: Yossef Osman <yossef.osman@proton.me>
> Co-developed-by: Andre Eikmeyer <dev@deq.rocks>
> Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
> Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

[Severity: Low]
This fixes the Apple T2 MMIO gmux wait logic, timeout checks, and the
missing pre-write wait in gmux_mmio_write32().  Should this include:

  Fixes: 0c18184de990 ("platform/x86: apple-gmux: support MMIO gmux on T2 M=
acs")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114160731.3756=
-1-atharvatiwarilinuxdev@gmail.com?part=3D3
