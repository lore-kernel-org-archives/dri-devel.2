Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF71460A2618
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nw9Gr7iH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2806B1126BB;
	Fri, 13 Nov 2026 16:39:19 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23BC61126BB
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 16:39:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C582A4664C;
 Fri, 13 Nov 2026 16:39:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60AA61F000C4;
 Fri, 13 Nov 2026 16:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794587952;
 bh=jrEE3irQnpf1CHKBngSKK8l4q118MI1MJ+JFAJTGwgg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nw9Gr7iHgY5awVYoQTH+LrervxJQB6O/bbroPakdFhanHGC5psanRV59pNNc0WHPr
 +h7Dphi2uvVIu0V0Zs3D/zUwfrynxrHRukfxnyJZDvk2MwvKqbIoGzgAh+JC+XLQva
 soQYYJCgmCqDCv+5RgOHlOCmZ1f2HFdlzdy27f5bxP0vV1s1GzksQ5qoP9B1rJ3MHD
 Zg0rOjvIheacxHlE5C8jznQixhDxLPlQO+k1nG2oMeB7xBZznYLx/wxRSB7HDnM/rx
 7deAlbliY8sXB0rPy4XqYlkktj2aTGdIUOoBtjg3IdPJTgEMeVoDMg4C01441Sop/Z
 UgWTWyGTu+Q6w==
Message-ID: <sashiko-outbox-213214@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 04/10] media: tegra-video: vi: Switch to
 media_entity_remote_source_pad_unique() helper
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org, media-ci@linuxtv.org
In-Reply-To: <20261113161819.36847-5-clamor95@gmail.com>
References: <20261113161819.36847-1-clamor95@gmail.com>
 <20261113161819.36847-5-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 16:39:11 +0000
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
- [High] media: tegra-video: ERR_PTR deref in
  tegra_channel_get_remote_source_subdev()
--

commit e0cde12330277b56d30a1de11e5da15a2551007a
Author: Svyatoslav Ryhel <clamor95@gmail.com>

media: tegra-video: vi: Switch to media_entity_remote_source_pad_unique() h=
elper

This commit replaces media_pad_remote_pad_first() with
media_entity_remote_source_pad_unique() in
tegra_channel_get_remote_source_subdev() so multi-pad entities do not assume
pad 0 is the remote source pad.

> diff --git a/drivers/media/platform/nvidia/tegra-video/vi.c b/drivers/med=
ia/platform/nvidia/tegra-video/vi.c
> index 12eaa89304e84..a96ef26af89eb 100644
> --- a/drivers/media/platform/nvidia/tegra-video/vi.c
> +++ b/drivers/media/platform/nvidia/tegra-video/vi.c
> @@ -187,9 +187,11 @@ tegra_channel_get_remote_source_subdev(struct tegra_=
vi_channel *chan)
>  	if (!subdev)
>  		return NULL;
> =20
> +	entity =3D &subdev->entity;
> +
>  	pad =3D &subdev->entity.pads[0];
>  	while (!(pad->flags & MEDIA_PAD_FL_SOURCE)) {
> -		pad =3D media_pad_remote_pad_first(pad);
> +		pad =3D media_entity_remote_source_pad_unique(entity);
>  		if (!pad || !is_media_entity_v4l2_subdev(pad->entity))
>  			break;
>  		entity =3D pad->entity;

[Severity: High]
Can this dereference an error pointer at pad->entity?

Unlike media_pad_remote_pad_first(), which returns NULL when no enabled
link is found, media_entity_remote_source_pad_unique() wraps
media_entity_remote_pad_unique() and returns ERR_PTR(-ENOLINK) or
ERR_PTR(-ENOTUNIQ) on failure.  If the upstream link is disabled or
missing, !pad is false and pad->entity faults.  Should the check use
IS_ERR(pad) instead of !pad?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113161819.3684=
7-1-clamor95@gmail.com?part=3D4
