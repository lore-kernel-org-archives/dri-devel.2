Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B06F606A326
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 18:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CpkjCXX1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06CF910E0E0;
	Sat,  7 Nov 2026 18:19:04 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BD8D10E0E0
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 18:18:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BC710605C9;
 Sat,  7 Nov 2026 18:18:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55CD11F0089F;
 Sat,  7 Nov 2026 18:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794075536;
 bh=iSQGeQlRfrvsDao/c77t2xsbZnmsS2H+SoTAjuJQY7w=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=CpkjCXX1hKNOBlKTzZU5Cx2UfcRr61NqqQuoRGwSa6voyaPUfR/+sRyfNJdpx3Bcb
 /OWBLXaSC7SLR791C0hWPEfgkwExJ+vs3zT6tvgztCD0bwUaXPs6uTYdO7JSywLGlU
 shMXpIEGL+HjuHohnQ7jjzmd1BOp8Yn5UAh2D7yvY6jzH3Vz4bjo2D8bHjOD1b3rzm
 xKCjIF3sklN80gA6HLrYtayjx2f4jNP1txXEmpfOcwqolnpqJ/771/P95JA8h4fIy3
 JetU3q5vrl1jpagoRZoozbh4qkbdIKu8yJR2QSpOAE6/dFKI1or35lyWYwp6BGK6ao
 SUsE0GGazHEHQ==
Message-ID: <sashiko-outbox-203162@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] drm/drm_ras: Remove admin-perm flag from
 list-nodes operation
To: "Zack McKevitt" <zachary.mckevitt@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261106181225.3333260-2-zachary.mckevitt@oss.qualcomm.com>
References: <20261106181225.3333260-1-zachary.mckevitt@oss.qualcomm.com>
 <20261106181225.3333260-2-zachary.mckevitt@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 18:18:55 +0000
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
- [Low] drm/drm_ras: missing Fixes tag for
  drm_ras_nl_list_nodes_dumpit() init fix
--

commit 9457b6b1f3039e9c4f6cd72731d15ae7fe2a5454
Author: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>

> drm/drm_ras: Remove admin-perm flag from list-nodes operation
>
> Drivers may want to avoid requiring CAP_NET_ADMIN for subsequent
> drm-ras operations. However, userspace must still be able to access
> the list of RAS nodes to determine the node IDs. So, drop the
> CAP_NET_ADMIN requirement for dumping RAS nodes so that drivers
> with different permission requirements are still able to use the
> interface.
>
> Additionally, initialize the return value to zero in
> drm_ras_nl_list_nodes_dumpit to avoid leaking uninitialized kernel
> memory (especially now that this function no longer requires admin
> permissions).
>
> This prepares the interface to be used for telemetry by the qaic
> driver.
>
> Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
> Signed-off-by: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>

[Severity: Low]
Since this also fixes an uninitialized return value in
drm_ras_nl_list_nodes_dumpit() when xa_for_each_start() runs zero
iterations, should it include:

  Fixes: c36218dc49f5 ("drm/ras: Introduce the DRM RAS infrastructure over =
generic netlink")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106181225.3333=
260-1-zachary.mckevitt@oss.qualcomm.com?part=3D1
