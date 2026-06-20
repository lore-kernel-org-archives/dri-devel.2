Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F4FCD98E4
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 16:52:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B796710E1AA;
	Sat, 20 Jun 2026 16:52:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QabmGs2Q";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F57810E1AA
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 16:52:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 86DDF601E2;
 Sat, 20 Jun 2026 16:52:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8C61F000E9;
 Sat, 20 Jun 2026 16:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781974368;
 bh=wcYU0AFTW+xncKm5k5J8JjTFYk7WbPBX6yf/KqMiojM=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=QabmGs2QiHgLYdzUfnzECqKAJR10bla50VIIqBzEyEqGBsLOs98eNgJk0nH9FlqzX
 6n4zx583pcsgvhxKzD2jhUTFOXlz6HCLbn6ythGMm7perAYR5V2YvEbJ/x6N/ALNZ0
 7jcUhb5kHMIcIOu9ePGdw+XN3Ik0ipKRO3qQ/uUUfk2OBH/Ss2l9FQg1uVnlSRNI83
 jTKJpHXPL01ooslM8pYruPqv2UbCjOTS5pxPRnKMTlL1DOQ5HKLn4FgjImcclbM1Yi
 QMzbA3WtxviA87V8cLMBItU3+Qpw6TOSo5sVDl0OTf6itIC3ztAr436omuCXaUytIv
 sLHwIFkmUk2OQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 20 Jun 2026 18:52:42 +0200
Message-Id: <DJE16WZZK36J.2JINX1VTNW24G@kernel.org>
Subject: Re: [PATCH v3 00/13] rust: drm: Higher-Ranked Lifetime private data
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
To: <aliceryhl@google.com>, <daniel.almeida@collabora.com>,
 <acourbot@nvidia.com>, <ecourtney@nvidia.com>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <deborah.brouwer@collabora.com>, <boris.brezillon@collabora.com>,
 <lyude@redhat.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260620005431.1562115-1-dakr@kernel.org>
In-Reply-To: <20260620005431.1562115-1-dakr@kernel.org>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Sat Jun 20, 2026 at 2:51 AM CEST, Danilo Krummrich wrote:
>   rust: drm: Add RegistrationGuard for drm_dev_enter/exit critical
>     sections

As also pointed out by Sashiko, I forgot to consider that constructing a
RegistrationGuard still requires that the drm::Device has been registered a=
t
some point.

Theoretically, this could be addressed in a way that it is still valid to
construct a RegistrationGuard from a drm::Device<Normal> (e.g. by leveragin=
g
dev->unplugged with corresponding synchronization), but other than from IOC=
TLs
there is no use-case for this guard. Since IOCTLs already carry the require=
d
invariant implicitly, I went with a separate Ioctl typestate.

This and the fact that we can't let drivers infer any other typestate than
Normal before the RegistrationGuard is in place, results in a few changes t=
hat
are worth considering for review, so I decided to resend early.
