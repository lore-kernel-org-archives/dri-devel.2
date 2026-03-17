Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D38FEDA1C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 19:49:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A9B910E255;
	Tue, 17 Mar 2026 19:49:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="GEVHPlTV";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C883410E1CD;
 Tue, 17 Mar 2026 19:49:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1773776956; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=l6DHBX9OpXYx2XB4ahJu3nwGnmoTwJam6cKnRAFzGTaQcSM98cMNmNBISrvJ+k6FjatQyPJ1owo0waUt47F6M7hsnFp2GnRqte1o/3MZsUGDmaEYmfBi7F4S13oM8OU/nhgf1cejCg3aLoGk0EF+c3cBXDqF8S37TZmC/H4R2E0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1773776956;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=qivz7z5qDkBFkveJZY7JZdTDWy+EWa/y0vLvNrlAvYg=; 
 b=mDXdFPf/AHuN1pa1DMWNXURU3m/WOYGDdkz7paN8U/PV5llbqcy7xoBVaC4d2Qaa89oGVpKBW37tdBvBb5ZVA+VRYNw8hLnqbVayedaUB8VZYK1lTaijjVkZR6BNhpckj14Lrfc+pjjvYqjwJpFdOxD3Y6iJ+iLKRvpkyW9vrj0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773776956; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
 bh=qivz7z5qDkBFkveJZY7JZdTDWy+EWa/y0vLvNrlAvYg=;
 b=GEVHPlTVrYZDZ661G1DbPwdt/YWYF4U0fV0BRj22+t762Alt06x3gFn5pHrIV6vU
 0ZxnSF9aruXsJGKU4EytbL1eUd82Br2BKfBiGFe4hln8VTrQOBOkLD9B1YKzobANtcK
 kx9vhVv8ejlfUbZI8qpYjDbNCTwYlo0S0014voLI=
Received: by mx.zohomail.com with SMTPS id 1773776953256295.04566668878033;
 Tue, 17 Mar 2026 12:49:13 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [RFC PATCH 02/12] drm/dep: Add DRM dependency queue layer
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <abmaDElHmbQkYy57@lstrano-desk.jf.intel.com>
Date: Tue, 17 Mar 2026 16:48:53 -0300
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?utf-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org,
 Sami Tolvanen <samitolvanen@google.com>,
 Jeffrey Vander Stoep <jeffv@google.com>, Alice Ryhl <aliceryhl@google.com>,
 Daniel Stone <daniels@collabora.com>,
 Alexandre Courbot <acourbot@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, shashanks@nvidia.com,
 jajones@nvidia.com, Eliot Courtney <ecourtney@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>,
 rust-for-linux <rust-for-linux@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CC600DA5-968C-440B-8B4F-4E56576C7D5A@collabora.com>
References: <20260316043255.226352-1-matthew.brost@intel.com>
 <20260316043255.226352-3-matthew.brost@intel.com>
 <7A8108C7-7CF0-4EA4-95ED-8003502DC35A@collabora.com>
 <abjqfXERS6Xk4FAQ@lstrano-desk.jf.intel.com>
 <abmaDElHmbQkYy57@lstrano-desk.jf.intel.com>
To: Matthew Brost <matthew.brost@intel.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External
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

I still need to digest your answers above, there's quite a bit of =
information.
Thanks for that. I'll do a pass on it tomorrow.

>>> By the way:
>>>=20
>>> I invite you to have a look at this implementation [0]. It currently =
works in real
>>> hardware i.e.: our downstream "Tyr" driver for Arm Mali is using =
that at the
>>> moment. It is a mere prototype that we=E2=80=99ve put together to =
test different
>>> approaches, so it=E2=80=99s not meant to be a =E2=80=9Csolution=E2=80=9D=
 at all. It=E2=80=99s a mere data point
>>> for further discussion.
>=20
> I think some of the things I pointed out=E2=80=94async teardown, =
bypass paths,
> and dropping job refs in IRQ context=E2=80=94would still need to be =
added,
> though.

That=E2=80=99s ok, I suppose we can find a way to add these things if =
they=E2=80=99re
needed in order to support other FW scheduling GPUs (i.e.: other than =
Mali,
which is the only thing I tested on, and Nova, which I assume has very =
similar
requirements).

>=20
>>>=20
>>> Philip Stanner is working on this =E2=80=9CJob Queue=E2=80=9D =
concept too, but from an upstream
>>> perspective.
>>>=20
>>> [0]: =
https://gitlab.freedesktop.org/panfrost/linux/-/merge_requests/61
>=20
> I scanned [0], it looks signicantly better than the post upstream. Let
> me dig in a bit more.
>=20
> Matt
> Matt

One thing that is missing is that, at the moment, submit() is fallible =
and
there is no preallocation. This can be added to the current design =
rather
easily (i.e. by splitting into two different steps, a fallible prepare() =
where
rollback is possible, and an infallible commit(), or whatever names get
chosen).

Perhaps we can also split this into two types too, AtomicJobQueue and =
JobQueue,
where only the first one allows refs to be dropped in IRQ context; i.e.: =
since
we do not need this in Tyr, and not allowing this makes the design of =
the
"non-atomic" version much simpler. Or perhaps we can figure out a way to =
ensure
that we don't drop the last ref in IRQ context. I am just brainstorming =
some
ideas at this point, and again, I still need to go through your =
explanations above.

=E2=80=94 Daniel

