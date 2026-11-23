Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCAF606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 02:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MXehL8ub
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F30B510E1F2;
	Mon, 23 Nov 2026 02:58:39 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4420710E1F2
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 02:58:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EB7FF40E0D;
 Mon, 23 Nov 2026 02:58:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF601F000C0;
 Mon, 23 Nov 2026 02:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795402712;
 bh=DL2rPmDlpHl0AQC4KjuB+rd+0hIrDyOK98A2P9tM2Cg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MXehL8ub7yZpKXjGcJ3Y/+tP1fYCjeD9LFGqcDj14ciP6aPu5R+5ypIH8DB6DCnhM
 rw+9n4P9b9iAIGZgYiWe34LRB9VbywIY2J7NWnK/S8yLts+wX5aZ0twe+LeHBmkh2R
 I9l8WiJuFsKIXlABPxdlVZEP4vfusa3djLAEki3CHmhXSMEfe1FB9cerlquAWCIcz/
 WoHxzfCCDh1n3/BcW3f9YcglgNqSAOHuBE+yD2NFFpfBnaLv/WQpe66LqCKOUp2Jq0
 LuvqNhPU6rhWp+7F8bVABaqzp4eRx3UDd312ythsZ9dyB/HHzHpHVn5QdoA4PL88f4
 T28Iqqk8mGHOA==
Message-ID: <sashiko-outbox-228575@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] drm/nouveau: add option to leave GSP-capable
 GPUs to other drivers
To: "Dave Airlie" <airlied@redhat.com>, "Lyude Paul" <lyude@redhat.com>,
 "Danilo
 Krummrich" <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev
In-Reply-To: <20261123-nova-nouveau-gsp-v2-2-5e8c27aa8555@redhat.com>
References: <20261123-nova-nouveau-gsp-v2-0-5e8c27aa8555@redhat.com>
 <20261123-nova-nouveau-gsp-v2-2-5e8c27aa8555@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 02:58:29 +0000
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
- [High] drm/nouveau: missing Signed-off-by trailer in commit message
--

commit f8a48aaf87bee63f3410b9230037e0818c036931
Author: Dave Airlie <airlied@redhat.com>

> drm/nouveau: add option to leave GSP-capable GPUs to other drivers
>
> nouveau currently binds to every NVIDIA GPU it encounters. The
> nova-core driver is being written for GSP-capable (Turing and later)
> GPUs, so the two drivers compete for the same devices, with whichever
> registers first winning.
>
> Add the DRM_NOUVEAU_BIND_GSP Kconfig option (default y) and a bind_gsp
> module parameter, defaulting to the Kconfig value and able to override
> it in both directions, controlling whether nouveau claims GSP-capable
> GPUs.
>
> Distributions that want nova-core to be the default driver for
> GSP-capable GPUs can set CONFIG_DRM_NOUVEAU_BIND_GSP=3Dn; the
> nouveau.bind_gsp=3D0 kernel command line parameter switches it at boot
> time.

[Severity: High]
This commit is missing a Signed-off-by: trailer in the commit message.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-nova-nouve=
au-gsp-v2-0-5e8c27aa8555@redhat.com?part=3D2
