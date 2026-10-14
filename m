Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E611CC6B2D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 22:44:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F88310E4EF;
	Wed, 14 Oct 2026 22:44:07 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23A8D10E4EF
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 22:44:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CC08B43E31;
 Wed, 14 Oct 2026 22:44:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 856691F000C4;
 Wed, 14 Oct 2026 22:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792017841;
 bh=ev+Np8U5H5P2KIGI6fqSQnWfJFH2RU91Rwi1h4U0rng=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ngWuFSIq1nwHOucpBv7+KbvvaidGjfPsv4/ZSaZzE4b4TBEPurXKnRVR4KI7noSXs
 /yAxCRNY2G/+dFD3/74KvsvY1Oh/RO0y8WVL+95ll0z2iXqZ3K9GBY/BnDazEo8Vq0
 uqgSrabs71URBm8oyCxUJOxmdhuWpUMNKG/MvDRjyvsOUlOWT3usEU9SOsuLn2Wmt0
 4uNQWqv+CK+yiCmv0MNztC0GVrH/muN0F8J8gZ1UjVRo4JMsiGyx6C4IwFK6IDUzdp
 pa7gWt+3S3goOdoVZkNkGJV1ZyTV/JaZaOHZ3Dioqv0tGwLPUFaKVCkgGecfOFVdmd
 NOUd27Wf7bSig==
Message-ID: <sashiko-outbox-172002@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/amd/display: Add KUnit tests for the eDP/LVDS
 native mode fallback
To: "Hugo Sales" <hugo@hsal.es>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261014223041.171317-3-hugo@hsal.es>
References: <20261014223041.171317-1-hugo@hsal.es>
 <20261014223041.171317-3-hugo@hsal.es>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 22:44:01 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/amd/display: uninitialized stack memory read in drm_mode_cop=
y()
--

commit 852bbf13f64b2d512665604270ff18f1f920af2e
Author: Hugo Sales <hugo@hsal.es>

drm/amd/display: Add KUnit tests for the eDP/LVDS native mode fallback

Leave only a scaled mode in connector->modes and put the larger native
mode in the encoder, as a size-limited probe does. On eDP and LVDS,
create_stream_for_sink() must build a stream with the native timing and
the scaled mode as its source size. On HDMI it must keep the first mode
in the list as the timing.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connec=
tor_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connecto=
r_test.c
> index 56fd133bc4056..55e2c38499f4a 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_tes=
t.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_tes=
t.c
> @@ -4547,6 +4547,115 @@ static void dm_test_create_stream_hdmi_vsif(struc=
t kunit *test)
[ ... ]
> +static struct dc_stream_state *
> +dm_test_native_mode_pruned_stream(struct kunit *test, int connector_type)
> +{
[ ... ]
> +	stream =3D create_stream_for_sink(&ctx->aconnector->base, ctx->mode,
> +					ctx->dm_state, NULL, 8,
> +					PIXEL_ENCODING_RGB, false);

[Severity: Medium]
Does this call to create_stream_for_sink() trigger a read of uninitialized
stack memory?

In create_stream_for_sink(), the variable native_mode is declared on the
stack without initialization:

amdgpu_dm_connector.c:create_stream_for_sink() {
	...
	struct drm_display_mode native_mode;
	...
	if (!native_mode_found && aconnector && ...) {
		...
		drm_mode_copy(&native_mode, &to_amdgpu_encoder(encoder)->native_mode);
		...
	}
}

The drm_mode_copy() function begins by saving the destination's list head:

drm_modes.c:drm_mode_copy() {
	struct list_head head =3D dst->head;
	...
}

Because native_mode is uninitialized, this reads uninitialized stack memory,
which could trigger KMSAN panics on systems with memory sanitizers enabled.
Should native_mode be zero-initialized or initialized using drm_mode_init()
first?

> +
> +	drm_edid_free(ctx->aconnector->drm_edid);
> +	KUNIT_ASSERT_NOT_NULL(test, stream);
> +
> +	return stream;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014223041.1713=
17-1-hugo@hsal.es?part=3D2
