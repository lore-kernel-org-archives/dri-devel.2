Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D84E606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 02:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=laJsSoAm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3620C10E16E;
	Mon, 23 Nov 2026 02:55:44 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B6A010E16E
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 02:55:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0DE1F43047;
 Mon, 23 Nov 2026 02:55:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93DB1F000C0;
 Mon, 23 Nov 2026 02:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795402537;
 bh=MkHpwsvOELaYT7+/y1zNuSUxwVP+fJwbBJeLBDDa+z0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=laJsSoAmlCcmMURPBFFCGj3tFusQ6wpvH5qoW8JJ/ck6y+pbpXN8T8t06W2b8NTfx
 hz/f0SEmuX67GIhtDj5XAdcA9EgdXe+1ZeZhdC3xyiJ/dstdkpE+JSnEZV77VHaVMM
 J+NzJzRaY5aroftozjUvBO3bL2v0y+ODqR0T4oioGdvU3y3OIDpr1LZ4Q3/x2FwaJ3
 tKYbsFob0VKkV0wXZ5O3Wxk26YWhGe0P4EhKeug2Nuns+Da6nvz6wAtKOk8IkWH58d
 /PjuFEOwOpcdGDjlbt80M3eVXVLlnIPXtzsnDDDxEgNCR9Z07Nbn5eI8drLTe+xI7F
 nDwvmQ1jXwFpw==
Message-ID: <sashiko-outbox-228572@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] nova-core: only bind to GPUs when explicitly
 requested
To: "Dave Airlie" <airlied@redhat.com>, "Lyude Paul" <lyude@redhat.com>,
 "Danilo
 Krummrich" <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev
In-Reply-To: <20261123-nova-nouveau-gsp-v2-3-5e8c27aa8555@redhat.com>
References: <20261123-nova-nouveau-gsp-v2-0-5e8c27aa8555@redhat.com>
 <20261123-nova-nouveau-gsp-v2-3-5e8c27aa8555@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 02:55:36 +0000
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
- [High] nova-core: missing Signed-off-by trailer in commit message
--

commit 5f7cc6c15454e28a85afc162fef5c8d7a26c0ba8
Author: Dave Airlie <airlied@redhat.com>

> nova-core: only bind to GPUs when explicitly requested
>
> nova-core currently binds to every NVIDIA GPU it supports
> (GSP-capable, Turing and later GPUs), competing with nouveau for the
> same devices.
>
> Add the NOVA_CORE_BIND_GSP Kconfig option (default n) and a bind_gsp
> module parameter, defaulting to the Kconfig value and able to override
> it in both directions. Unless one of them requests binding, probe()
> rejects the GPU with -ENODEV and leaves the device to other drivers,
> such as nouveau. The PCI driver still registers, so module autoloading
> via modalias keeps working when binding is disabled.
>
> As nova-core is work in progress, the default is to not bind at all.
> Developers can enable binding with CONFIG_NOVA_CORE_BIND_GSP=3Dy, or
> nova-core.bind_gsp=3D1 on the kernel command line, combined with
> nouveau.bind_gsp=3D0 (or CONFIG_DRM_NOUVEAU_BIND_GSP=3Dn) so that nouveau
> yields the GSP-capable GPUs.

[Severity: High]
The commit message is missing a Signed-off-by: trailer, which is required
under the Developer Certificate of Origin
(Documentation/process/submitting-patches.rst).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-nova-nouve=
au-gsp-v2-0-5e8c27aa8555@redhat.com?part=3D3
