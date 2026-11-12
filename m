Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1238C606A321
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 01:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hjuJv76u
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4290610FF04;
	Thu, 12 Nov 2026 01:53:13 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B4F510EAFF;
 Thu, 12 Nov 2026 01:53:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6139641161;
 Thu, 12 Nov 2026 01:53:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EEFB1F00A05;
 Thu, 12 Nov 2026 01:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794448386;
 bh=12eowVmbI2aFuR7YFj3pNxbd8AiTyeblOtwffmB07cQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hjuJv76uWD+iYwu/vxIOBlWpll74zG2AroToqLpgVRMflsh05Jv+UAiZwwE8jHMMz
 zNyngW473Ye1IwufaQ0r/B14F91Om5F4S68pBOifWoPsCGUBgS0bRuj0I8Orr2rwRp
 xg+lVG5qVvg7vPF0JRETpCRvjvK5LT06htf7MjyLsq+kCon3h6gwCiccm8V2AScPSe
 DlCGayGmmTV/a9UYXorj+mQKa8u8d0VB9YmEpEZSfS0rHU8IBiRB44yw2tZSoaWoLM
 MnM8kP8z6FiCJ8jDtxL10UxrbwuMRpKBHM8xKPI/B9vL2SuJ3VtRPsuRb5xrxTk20y
 lmvHrEIVMWPzQ==
Message-ID: <sashiko-outbox-210108@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/19] drm/amd/display/amdgpu_dm: Finish DC accessor
 migration for non-test code
To: "Dave Airlie" <airlied@redhat.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261112-amdgpu-dc-cleanup-v1-11-0fae41718ad2@redhat.com>
References: <20261112-amdgpu-dc-cleanup-v1-0-0fae41718ad2@redhat.com>
 <20261112-amdgpu-dc-cleanup-v1-11-0fae41718ad2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 01:53:05 +0000
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
- [High] drm/amd/display: uninitialized stack memory read in
  get_conv_frl_bw() [1]
--

commit 7d52238d02a453de3c024a3c4edfc5cc756f0bed
Author: Dave Airlie <airlied@redhat.com>

drm/amd/display/amdgpu_dm: Finish DC accessor migration for non-test code

This commit converts the remaining struct dc member dereferences in
amdgpu_dm production code to use accessor functions and moves the
PERFORMANCE_TRACE_START and PERFORMANCE_TRACE_END macros into
dc/dm_services.h.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index a3877ef767eca..2cbe08298706a 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -1239,7 +1239,7 @@ STATIC_IFN_KUNIT bool get_conv_frl_bw(struct amdgpu=
_dm_connector *aconnector,
>  	unsigned int dsc_max_sink_bw_in_kbps =3D 0;
> =20
>  	if (aconnector->dc_sink &&
> -	    aconnector->dc_link->dc->caps.dp_hdmi21_pcon_support &&
> +	    dc_get_caps(aconnector->dc_link->dc)->dp_hdmi21_pcon_support &&
>  	    aconnector->mst_downstream_port_caps.bytes.byte0.bits.DWN_STRM_PORT=
X_TYPE =3D=3D DOWN_STREAM_DETAILED_HDMI) {
>  		max_conv_bw_in_kbps =3D dc_link_bw_kbps_from_raw_frl_link_rate_data(
>  				aconnector->dc_link->dc,

[Severity: High]
This problem wasn't introduced by this patch, but can get_conv_frl_bw()
read uninitialized stack memory from *bw_in_kbps [1]?

compute_mst_dsc_configs_for_link() declares frl_conv_bw_in_kbps and
frl_conv_dsc_bw_in_kbps on the stack without initializing them and passes
them to get_conv_frl_bw():

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c:get_conv_frl_bw=
() {
	if (aconnector->dc_sink &&
	    dc_get_caps(aconnector->dc_link->dc)->dp_hdmi21_pcon_support &&
	    aconnector->mst_downstream_port_caps.bytes.byte0.bits.DWN_STRM_PORTX_T=
YPE =3D=3D DOWN_STREAM_DETAILED_HDMI) {
		...
		if (aconnector->dc_sink->edid_caps.max_frl_rate && max_conv_bw_in_kbps) {
			...
			*bw_in_kbps =3D min(max_conv_bw_in_kbps, max_sink_bw_in_kbps);
			*dsc_bw_in_kbps =3D min(*bw_in_kbps, dsc_max_sink_bw_in_kbps);
		}
	}

	return *bw_in_kbps > 0; // Frl endpoint is detected
}

When the downstream port is not HDMI 2.1 PCON or max_frl_rate is 0,
neither output pointer is written before *bw_in_kbps > 0 is evaluated.
If stack contents make *bw_in_kbps non-zero, get_conv_frl_bw() returns
true and compute_mst_dsc_configs_for_link() passes the uninitialized
frl_conv_dsc_bw_in_kbps into build_frl_mst_dsc_params().

[1] https://sashiko.dev/#/bug/linux-04300f5e-3be1-4eaf-ab02-d1aa2df32bb9

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-amdgpu-dc-=
cleanup-v1-0-0fae41718ad2@redhat.com?part=3D11
