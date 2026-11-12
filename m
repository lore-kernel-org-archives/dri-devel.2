Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65373606A324
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 01:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=acNwuxVF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8421B10FF0E;
	Thu, 12 Nov 2026 01:59:44 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AA2610FF0E;
 Thu, 12 Nov 2026 01:59:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 30F0C412E7;
 Thu, 12 Nov 2026 01:59:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8BC1F00A07;
 Thu, 12 Nov 2026 01:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794448778;
 bh=1797Hpx9XaIlv48ViwjDqvIVjSI1RRnqGpuk0+m34TY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=acNwuxVF9TbmC/kKAXWMkpkm4kRThRu7Co+MsuRFSPPrlvO5iVqiH6D4c22crRGCm
 SbmklMgZowEG/2/rjKRONMa0v0YsNcr0bQ2tgZ/VN6CRiQ/ZAB44V57jkjP/msQDDX
 Bae7D2CdEKvgWkJoGQD81a78x60jGuodal7a1Vb+NDkdpb2ov/dhFaABJxSn9qJ+gn
 sGbsdvXZA0NGVSpajuHzzvTNmblbNqdGJ3CCkBrquwikuHNj0ZuTjxlSEagLFq36od
 ZPsOFZF1C3n1ddsILoqyfzwrrAJ+XC4ianWK1m+JKLK4HMadNxk31SVKUrwW6Mjzig
 4sw5jafVOgJtA==
Message-ID: <sashiko-outbox-210129@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/19] drm/amd/display: Migrate amdgpu_dm KUnit tests
 off struct dc internals
To: "Dave Airlie" <airlied@redhat.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261112-amdgpu-dc-cleanup-v1-12-0fae41718ad2@redhat.com>
References: <20261112-amdgpu-dc-cleanup-v1-0-0fae41718ad2@redhat.com>
 <20261112-amdgpu-dc-cleanup-v1-12-0fae41718ad2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 01:59:37 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/amd/display: CFI violation and unchecked kunit_add_action()
  in dm_kunit_alloc_dc()
--

commit 3e7024f14775977bb5d35f97fcb673f3cd943908
Author: Dave Airlie <airlied@redhat.com>

drm/amd/display: Migrate amdgpu_dm KUnit tests off struct dc internals

This commit adds a KUnit test double API for struct dc and converts the
amdgpu_dm KUnit tests to use it instead of accessing struct dc fields
directly.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_=
helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_hel=
pers.c
> index f844b644bb776..9954cbab65416 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers=
.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers=
.c
> @@ -47,18 +48,29 @@ struct dc_link *dm_kunit_alloc_link(struct kunit *tes=
t)
>  }
>  EXPORT_SYMBOL(dm_kunit_alloc_link);
> =20
> +struct dc *dm_kunit_alloc_dc(struct kunit *test)
> +{
> +	struct dc *dc;
> +
> +	dc =3D dc_test_create();
> +	KUNIT_ASSERT_NOT_NULL(test, dc);
> +	kunit_add_action(test, (kunit_action_t *)dc_test_destroy, dc);

[Severity: Low]
Does casting dc_test_destroy() (which takes struct dc *) to kunit_action_t *
(void (*)(void *)) trigger a KCFI failure on test teardown when built with
CONFIG_CFI_CLANG?  Also, kunit_add_action() can fail and leak dc if its
return value is not checked, whereas KUNIT_DEFINE_ACTION_WRAPPER() with
kunit_add_action_or_reset() avoids both issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-amdgpu-dc-=
cleanup-v1-0-0fae41718ad2@redhat.com?part=3D12
