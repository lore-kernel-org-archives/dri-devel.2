Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC23CD98D2
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 12:06:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A02D010EEC3;
	Thu, 11 Jun 2026 12:06:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="j5S4pfgy";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01B3910EEC3;
 Thu, 11 Jun 2026 12:06:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 369766001D;
 Thu, 11 Jun 2026 12:06:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6BA1F00893;
 Thu, 11 Jun 2026 12:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781179586;
 bh=vcsE+Ll4t6tOK0zqdhAk30KTSJNudRT/Tk/a1RVLDDw=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=j5S4pfgy1wTzVXarkvRi9GoSaldgH2pdXFoAaPR8hHN+mZ0G4LkNezvYKDuiufKey
 iy74qmeGvmGgZcLb8vDjpJE8qv7lbN+Rx83wc7oWdoeVsSH//4tEUTCp9bwR6S0DsJ
 kAF/FD1e3BiDyIyTHo1/HXbO0N5sS9IAmShv8NZLq56bOKknMMiZ3wuqlEU8NmgGbf
 MqrHiYJDZDugg+pcZaOi8BI+FPSiryJb7wrU4gTwid89+e6YyS45ZuaPwEIPEbXvrQ
 SOMM+nl2R5xy6KFnPVGttNmZox3lr8VH57pxHXGoAA5bv3wKd7iQW+xXdTJ2n52Fyu
 dPULNCiXLWWvg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Jun 2026 14:06:20 +0200
Message-Id: <DJ67GR3JEXOK.1ZSB4X97BV0MM@kernel.org>
Subject: Re: [PATCH v20 0/4] Rust bindings for gem shmem
Cc: <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, <driver-core@lists.linux.dev>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Alice Ryhl" <aliceryhl@google.com>,
 "Simona Vetter" <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>, "Sumit
 Semwal" <sumit.semwal@linaro.org>, <linux-media@vger.kernel.org>, "Rafael J
 . Wysocki" <rafael@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Maxime Ripard" <mripard@kernel.org>, "David Airlie" <airlied@gmail.com>,
 "Benno Lossin" <lossin@kernel.org>, <linaro-mm-sig@lists.linaro.org>,
 "Mukesh Kumar Chaurasiya" <mkchauras@gmail.com>, "Asahi Lina"
 <lina+kernel@asahilina.net>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>
To: "Lyude Paul" <lyude@redhat.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260610162433.923550-1-lyude@redhat.com>
In-Reply-To: <20260610162433.923550-1-lyude@redhat.com>
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

On Wed Jun 10, 2026 at 6:21 PM CEST, Lyude Paul wrote:
> Lyude Paul (4):
>   rust: drm: gem: shmem: Add DmaResvGuard helper
>   rust: drm: gem: shmem: Add vmap functions
>   rust: faux: Allow retrieving a bound Device
>   rust: drm: gem: Introduce shmem::Object::sg_table()

Acked-by: Danilo Krummrich <dakr@kernel.org>
