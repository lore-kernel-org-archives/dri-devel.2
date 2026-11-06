Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2C0606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 20:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L/lc9T0P
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28A49112FEF;
	Fri,  6 Nov 2026 20:25:58 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC188112FF8
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 20:25:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A8F85601E1;
 Fri,  6 Nov 2026 20:25:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4286C1F0089F;
 Fri,  6 Nov 2026 20:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793996751;
 bh=3GDWrEVghwa26TjJzF9HrxyCPCEHNcpJ8Nl437Jb8E8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=L/lc9T0PkvIN6vXAUl9CotrrNCTOqeu8o1Gmv4s7r+v5MHKIcQgVScfm5b+0zbso8
 KBSo/KO2pRaJ1a+Cwj6nahd8y0FjZRNFQD0JrOtbi1oe0HKxQHXLeqgxtUMVl2exFZ
 iw2Cf5j9QlVBZgHjVNDxfdeb2wZtFcd+8VpZ40ndXtt8084D+0NlfoOQVvy+4OHVH1
 QxH2xglGZuHtT/AjXFcNn6rtj9TqUi2alcXJj59kgWa0COMmGPfW8xkO5rwcDDDrKO
 +GmHgqcYfwLagT8UIaPFJLbYp9TnofEEIW2FG/akZUWge2gwgXj0DgnLDxV063NDBQ
 IaOTGZVC5eypA==
Message-ID: <sashiko-outbox-202203@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/12] vkms: properly compute gamma LUT size in
 vkms_atomic_check()
To: "Leandro Ribeiro" <leandro.ribeiro@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261106201813.129911-3-leandro.ribeiro@collabora.com>
References: <20261106201813.129911-1-leandro.ribeiro@collabora.com>
 <20261106201813.129911-3-leandro.ribeiro@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 20:25:50 +0000
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
- [Low] drm/vkms: missing Fixes trailer for LUT size fix in
  vkms_atomic_check()
--

commit ce5b5586969b38a36fc2d39e5403ee7e86059811
Author: Leandro Ribeiro <leandro.ribeiro@collabora.com>

> vkms: properly compute gamma LUT size in vkms_atomic_check()
>
> Gamma LUT size is being computed wrongly, dividing blob size by
> sizeof(struct drm_color_lut *). But the blob is an array of struct
> drm_color_lut.
>
> Replace sizeof(struct drm_color_lut *) with sizeof(struct
> drm_color_lut), properly validating the userspace gamma LUT size.
>
> Issue caught by Sashiko bot:
> https://sashiko.dev/#/patchset/20260804203351.148521-1-leandro.ribeiro@co=
llabora.com?part=3D1
>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Reviewed-by: Robert Mader <robert.mader@collabora.com>
> Tested-by: Robert Mader <robert.mader@collabora.com>
> Signed-off-by: Leandro Ribeiro <leandro.ribeiro@collabora.com>

[Severity: Low]
Since this fixes the gamma LUT size check in vkms_atomic_check(), which
rejected valid 129-to-256-entry LUTs on 32-bit architectures where
sizeof(struct drm_color_lut *) is 4 bytes instead of 8, should the commit
message include:

  Fixes: db1f254f2cfa ("drm/vkms: Add support to 1D gamma LUT")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106201813.1299=
11-1-leandro.ribeiro@collabora.com?part=3D2
