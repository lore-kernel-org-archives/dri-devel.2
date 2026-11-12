Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536E4606A321
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 02:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R33D0Pon
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 702D810EB2A;
	Thu, 12 Nov 2026 02:14:39 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37FBB10EB0B;
 Thu, 12 Nov 2026 02:14:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 029A0414BF;
 Thu, 12 Nov 2026 02:14:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A661A1F00A05;
 Thu, 12 Nov 2026 02:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794449667;
 bh=1VBWPNYKskHGG1wL/sXbsG+RNAi7iV20qxUG1uj8gaM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=R33D0Pon8C0N3ZwpJq8yAtBGWKk7vYc/85BIBrmBjv46xKxhTHXM8I26Y5LZzmggD
 /LcdFkTJ/B/MuaLi/5nLZQ7uFvWUj2S2MhBSLV8Z7SeGV64x6BQYTvz+ih9v9lBcDX
 Jigt0eT2iprK1YxSZZogcibHZP1vJhwBWQrT9knNjRlDyqzf22QaUnfOMOaGOcZy/f
 oCGkFpKohU3L6eV+or4xY8z4ky4nrz2BTAFu4dPZR3WKS1G/dlfCpDmgrjuZUzc/iq
 EeHQYfvvKtJxd5b0hhcZvta+8yI/Evc3GluD2tXRfYC7ziCNsKZPdQUlLZDLxd5A2q
 g15p2sgdmxlmw==
Message-ID: <sashiko-outbox-210166@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 19/19] drm/amd/display: Replace dc_get_caps with
 purpose-built capability queries
To: "Dave Airlie" <airlied@redhat.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261112-amdgpu-dc-cleanup-v1-19-0fae41718ad2@redhat.com>
References: <20261112-amdgpu-dc-cleanup-v1-0-0fae41718ad2@redhat.com>
 <20261112-amdgpu-dc-cleanup-v1-19-0fae41718ad2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 02:14:27 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] drm/amd/display: missing fused_io and hdcp_lc_force_fw_enable
  checks in dc_is_dmub_outbox_supported() [1]
--

commit c8a21aad95119e6c5fca592bbd2394b8b1a780d9
Author: Dave Airlie <airlied@redhat.com>

drm/amd/display: Replace dc_get_caps with purpose-built capability queries

This commit replaces the dc_get_caps() view accessor with dedicated
capability query functions so callers outside DC no longer access struct
dc_caps directly.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/dri=
vers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> index 73b56e078cbed..c71adc10c67ee 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
[ ... ]
> @@ -677,7 +677,7 @@ void update_config(void *handle, struct cp_psp_stream=
_config *config)
>  	link->adjust.retry_limit =3D MAX_NUM_OF_ATTEMPTS;
>  	link->adjust.hdcp1.disable =3D 0;
>  	link->adjust.hdcp2.use_fw_locality_check =3D
> -		(dc_get_caps(dc)->fused_io_supported ||
> +		(dc_get_fused_io_support(dc) ||
>  		 dc_get_debug_options(dc)->hdcp_lc_force_fw_enable);
>  	link->adjust.hdcp2.use_sw_locality_fallback =3D
>  		dc_get_debug_options(dc)->hdcp_lc_enable_sw_fallback;

[Severity: High]
This problem wasn't introduced by this patch, but can enabling
use_fw_locality_check here cause a NULL pointer dereference in
execute_fused_io() [1]?

amdgpu_dm_init() only initializes adev->dm.fused_io[].replied and enables
the DMUB outbox when dc_is_dmub_outbox_supported() returns true:

drivers/gpu/drm/amd/display/dc/core/dc.c:dc_is_dmub_outbox_supported() {
	if (!dc->caps.dmcub_support)
		return false;

	switch (dc->ctx->asic_id.chip_family) {
	...
	}

	/* dmub aux needs dmub notifications to be enabled */
	return dc->debug.enable_dmub_aux_for_legacy_ddc;
}

Because dc_is_dmub_outbox_supported() does not check fused_io_supported or
hdcp_lc_force_fw_enable, it returns false on ASICs such as
AMDGPU_FAMILY_GC_13_0_1 where Fused IO is supported without DPIA or legacy
DDC DMUB AUX notifications. When an HDCP2 locality check runs,
execute_fused_io() calls wait_for_completion_timeout() on the
uninitialized completion.

[1] https://sashiko.dev/#/bug/linux-dc486f6b-5c5b-43d8-842b-cdc1ed0770b0

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-amdgpu-dc-=
cleanup-v1-0-0fae41718ad2@redhat.com?part=3D19
