Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BECF606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 23:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DHQzWozl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70BA710E70E;
	Thu, 12 Nov 2026 23:14:50 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA1F810E70E
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 23:14:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 538F4608FA;
 Thu, 12 Nov 2026 23:14:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80681F000C4;
 Thu, 12 Nov 2026 23:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794525284;
 bh=grQnEwAkV+74AsvnNHyjlJXzxHrIzcPzzIQDREY9Gr0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DHQzWozlCpjx1pcpsWvAmDXQypw+gcum8d9+ce+AsCZ8y/SxxpfFY9546RaJjftmS
 GHA3FlB357YHfYS2TS7bMQp8G07vreFxV4LlrRAgFjIf4SDtpB8gXDURGNHsWGkclT
 rVkn2BEImiDhxRXJ57Xlqv5HILsY5wUXpbCzHvnaKKc6O4ZCBpKrrArPQ8uBb719E6
 ZjMz5AnT3Wrs1+YTLvmtV93OgJjQ+bnjAVL/aIiL3iNPP/L3YBhCzBt8Y7npZ9jTIP
 0STQEIaA8qZMTeQzXwdGm5AgPvflToFJJoWskAmnWnMKTXCnsIhDsJIRmVeJPr4wd3
 HK4KHblpYrIHg==
Message-ID: <sashiko-outbox-211935@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 09/13] drm/powervr_sgx: Add the client command checks
To: "Joseph Telaak" <joseph@telaak.dev>, dri-devel@lists.freedesktop.org
Cc: media-ci@linuxtv.org
In-Reply-To: <20261112-powervr-sgx-v1-9-c69b84bac011@telaak.dev>
References: <20261112-powervr-sgx-v1-0-c69b84bac011@telaak.dev>
 <20261112-powervr-sgx-v1-9-c69b84bac011@telaak.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 23:14:43 +0000
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
- [Medium] drm/powervr_sgx: missing PDS row extents for bg_pds addresses
  in render
--

commit 2c01add46bb408f66c7c7d092a2528c557b38dee
Author: Joseph Telaak <joseph@telaak.dev>

drm/powervr_sgx: Add the client command checks

This commit adds client command copying, extension chain walking, per-field
validation tables, VM mapping checks, and cross-field rules for PowerVR SGX
commands.

> diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_cmd_defs.c b/drivers/gpu/=
drm/powervr_sgx/pvrsgx_cmd_defs.c
> new file mode 100644
> index 0000000000000..f73c80199b527
> --- /dev/null
> +++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_cmd_defs.c

[ ... ]

> +	{
> +		.name =3D "pixel_event_pds_addr",
> +		.offset =3D offsetof(struct pvrsgx_cmd_render_all, base.pixel_event_pd=
s_addr),
> +		.size =3D 8,
> +		.check =3D PVRSGX_CMD_CHECK_ADDR,
> +		.heap =3D PVRSGX_CMD_HEAP_PDS_PIXEL,
> +		.align =3D 16,
> +		.extent =3D PVRSGX_CMD_EXTENT_PDS_ROWS,
> +		.extent_field =3D offsetof(struct pvrsgx_cmd_render_all, base.pixel_ev=
ent_pds_rows),
> +	},
> +	{
> +		.name =3D "bg_pds_secondary_addr",
> +		.offset =3D offsetof(struct pvrsgx_cmd_render_all, base.bg_pds_seconda=
ry_addr),
> +		.size =3D 8,
> +		.check =3D PVRSGX_CMD_CHECK_ADDR,
> +		.heap =3D PVRSGX_CMD_HEAP_PDS_PIXEL,
> +		.align =3D 16,
> +	},
> +	{
> +		.name =3D "bg_pds_primary_addr",
> +		.offset =3D offsetof(struct pvrsgx_cmd_render_all, base.bg_pds_primary=
_addr),
> +		.size =3D 8,
> +		.check =3D PVRSGX_CMD_CHECK_ADDR,
> +		.heap =3D PVRSGX_CMD_HEAP_PDS_PIXEL,
> +		.align =3D 16,
> +	},

[Severity: Medium]
Should bg_pds_secondary_addr and bg_pds_primary_addr in sgx545_render_fields
also set .extent =3D PVRSGX_CMD_EXTENT_PDS_ROWS with .extent_field pointing=
 to
base.bg_pds_secondary_rows and base.bg_pds_primary_rows?

mapped_fields() skips address fields where f->extent is 0, so
pvrsgx_cmd_check_mapped() never checks that these background PDS program
extents are mapped in the job's VM.  A render command with an unmapped or
partially mapped background PDS address in the PDS_PIXEL heap will pass
validation and trigger a GPU page fault when executed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-powervr-sg=
x-v1-0-c69b84bac011@telaak.dev?part=3D9
