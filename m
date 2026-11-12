Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAFB606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 02:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xfgr29rW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F1D110EAEA;
	Thu, 12 Nov 2026 02:02:41 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE7A010EAEA;
 Thu, 12 Nov 2026 02:02:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6D11344F13;
 Thu, 12 Nov 2026 02:02:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7C21F00A05;
 Thu, 12 Nov 2026 02:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794448955;
 bh=Hl9FfWZxSN47ZaDl1iP+gCK2yL870GPt+1Xq06zTmn8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Xfgr29rWYYFUPaAuuPm5LSq18Pe67v1Bry5lUxzIVvQq/xyMBaIWf5j4WaOrwHmiI
 Pqk8HzKov4meDtPH6Z2Nz1VO0U2wMEEQL2wKVOAqgs6Ja34VRwr5VBADTK2ifectrX
 APTGin5xpjaXaBy54Ie6rsSYajcw9ok98LzeGbym/HzCDWT1Y2p3Txaz9l/6LM4c2k
 W3Lz+yicDVw73QBUdqYNIqNqe2GL0i6sgxOPw8naS6yS3b5gIfYfkE6xFliUR7GT6w
 OCkamuoSh+fHUZQ9PGcSrqYFRg5XhFMLbdBD19FbRaaApkd3GBfcIpDJIVFLViYhgu
 i6wui2wDLdXBA==
Message-ID: <sashiko-outbox-210138@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/19] drm/amd/display: Add dc_force_max_dramclk for the
 DP compliance workaround
To: "Dave Airlie" <airlied@redhat.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261112-amdgpu-dc-cleanup-v1-15-0fae41718ad2@redhat.com>
References: <20261112-amdgpu-dc-cleanup-v1-0-0fae41718ad2@redhat.com>
 <20261112-amdgpu-dc-cleanup-v1-15-0fae41718ad2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 02:02:34 +0000
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
- [High] drm/amd/display: NULL pointer dereference in
  dc_force_max_dramclk()
--

commit b8f4fd55c6e73f430098a070c075751210c4007a
Author: Dave Airlie <airlied@redhat.com>

drm/amd/display: Add dc_force_max_dramclk for the DP compliance workaround

This commit moves the DP compliance test pattern memory clock workaround fr=
om
dm_helpers_dp_handle_test_pattern_request() into a new dc_force_max_dramclk=
()
helper in DC and removes the dc_get_clk_mgr() accessor.

> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/a=
md/display/dc/core/dc.c
> index 8344d821d2e87..15379b186a91f 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -7357,6 +7357,29 @@ void dc_set_edp_power(const struct dc *dc, struct =
dc_link *edp_link,
>  	edp_link->dc->link_srv->edp_set_panel_power(edp_link, powerOn);
>  }
> =20
> +/**
> + * dc_force_max_dramclk() - raise the memory clock for DP compliance tes=
ts
> + * @dc: Current DC state
> + * @context: The state whose clocks are programmed
> + *
> + * Temporary workaround for DP compliance test failures: disallow p-state
> + * switching for the given state, raise the memory clock to the maximum
> + * supported level and apply the resulting clocks immediately.
> + */
> +void dc_force_max_dramclk(struct dc *dc, struct dc_state *context)
> +{
> +	context->bw_ctx.bw.dcn.clk.p_state_change_support =3D false;
> +	context->bw_ctx.bw.dcn.clk.dramclk_khz =3D
> +			dc->clk_mgr->dc_mode_softmax_enabled ?
> +			dc->clk_mgr->bw_params->dc_mode_softmax_memclk :
> +			dc->clk_mgr->bw_params->max_memclk_mhz;
> +	context->bw_ctx.bw.dcn.clk.idle_dramclk_khz =3D
> +			context->bw_ctx.bw.dcn.clk.dramclk_khz;
> +
> +	if (dc->clk_mgr && dc->clk_mgr->funcs->update_clocks)
> +		dc->clk_mgr->funcs->update_clocks(dc->clk_mgr, context, false);
> +}

[Severity: High]
Can this dereference a NULL dc->clk_mgr or dc->clk_mgr->bw_params?

dc->clk_mgr is dereferenced before the NULL check on dc->clk_mgr below, and
dc->clk_mgr->bw_params is not checked at all.  In dc_clk_mgr_create(),
bw_params is only populated on DCN 2.1 and DCN 3.0+ and remains NULL on DCE,
DCN 1.0, and DCN 2.0/2.01 (which is why dc_refresh_memclk_states() in this
file checks both !dc->clk_mgr and !dc->clk_mgr->bw_params).  A DP link test
pattern request via dm_helpers_dp_handle_test_pattern_request() on those
ASICs will crash with a NULL pointer dereference.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-amdgpu-dc-=
cleanup-v1-0-0fae41718ad2@redhat.com?part=3D15
