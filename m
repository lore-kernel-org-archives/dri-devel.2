Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B2C606A324
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 14:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lglaOQhg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49A7411232B;
	Thu, 29 Oct 2026 14:13:41 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C74AA11233D
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 14:13:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 204C76012A;
 Thu, 29 Oct 2026 14:13:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884891F01825;
 Thu, 29 Oct 2026 14:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793283214;
 bh=M1aQfGDZ7Vb2nGSxetYuQ+UQaxnvNayTxfDWRbGrr0g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lglaOQhgNX70H03nnqzFN8KoOikJZ8/sJ6xJW/X1r7zuRk5OxCPbgE2d1fpfUCCL7
 VulQhXF1NlSLFFSosKROt9x+0TGwKFIXGF7Rq49aOyOT1eI3AkJnl2Ws/fNIvAlWeZ
 QFZnONQ3uilq+DVqxFdDCJkeBpnwPrG059oCk7KymZR64fcQu6CO/9fiXhHkVoorAm
 6FwzZRZgyLjYpCre05wF19ydlyBcgZunx7kSa3ZPv0LM2C2BgeGWUpkS6rpj9Zt/bH
 /L303SeaoJGMPwxcQ73zPl8ujUkfnPv9Lm2uU3R4alT0lLk+8HiywTQ1WG9Q6wFPS2
 W+POYnDTqvgPw==
Message-ID: <sashiko-outbox-189486@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 08/14] temp: add LPAC regs
To: "Anna Maniscalco" <anna.maniscalco2000@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261029-descriptive-name-lpac-upstream-v2-8-a21a5c850961@gmail.com>
References: <20261029-descriptive-name-lpac-upstream-v2-0-a21a5c850961@gmail.com>
 <20261029-descriptive-name-lpac-upstream-v2-8-a21a5c850961@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 14:13:34 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/msm: conflicting offsets and variants for LPAC regs in a6xx.=
xml
--

commit cffea449b0ea5b2e3282237ed9e0160eef7997c8
Author: Anna Maniscalco <anna.maniscalco2000@gmail.com>

temp: add LPAC regs

This commit adds LPAC and UCHE register definitions to the Adreno a6xx XML
register database.

> diff --git a/drivers/gpu/drm/msm/registers/adreno/a6xx.xml b/drivers/gpu/=
drm/msm/registers/adreno/a6xx.xml
> index 3349c01646e12..bb49f6a61a9af 100644
> --- a/drivers/gpu/drm/msm/registers/adreno/a6xx.xml
> +++ b/drivers/gpu/drm/msm/registers/adreno/a6xx.xml
> @@ -276,6 +276,11 @@ by a particular renderpass/blit.
>  		<bitfield pos=3D"1" name=3D"ACCESS_FAULT_ON_VIOL_EN" type=3D"boolean"/>
>  		<bitfield pos=3D"0" name=3D"ACCESS_PROT_EN" type=3D"boolean"/>
>  	</bitset>
> +	<reg32 offset=3D"0x0B09" name=3D"CP_LPAC_PROTECT_CNTL">
> +		<bitfield pos=3D"3" name=3D"LAST_SPAN_INF_RANGE" type=3D"boolean"/>
> +		<bitfield pos=3D"1" name=3D"ACCESS_FAULT_ON_VIOL_EN" type=3D"boolean"/>
> +		<bitfield pos=3D"0" name=3D"ACCESS_PROT_EN" type=3D"boolean"/>
> +	</reg32>
> =20
>  	<reg32 offset=3D"0x084f" name=3D"CP_PROTECT_CNTL" type=3D"a6xx_cp_prote=
ct_cntl" variants=3D"A6XX-A7XX"/>
>  	<bitset name=3D"a8xx_cp_protect_cntl" inline=3D"yes">
> @@ -333,6 +338,11 @@ by a particular renderpass/blit.
>  	<reg32 offset=3D"0x0845" name=3D"CP_CRASH_DUMP_STATUS" variants=3D"A8XX=
-"/>
>  	<reg32 offset=3D"0x0908" name=3D"CP_SQE_STAT_ADDR" variants=3D"A6XX-A7X=
X"/>
>  	<reg32 offset=3D"0x0909" name=3D"CP_SQE_STAT_DATA" variants=3D"A6XX-A7X=
X"/>
> +	<reg64 offset=3D"0x0b00" name=3D"CP_LPAC_RB_BASE" variants=3D"A7XX-"/>
> +	<reg32 offset=3D"0x0b02" name=3D"CP_LPAC_RB_CNTL" variants=3D"A7XX-"/>
> +	<reg64 offset=3D"0x0b04" name=3D"CP_LPAC_RB_RPTR_ADDR" variants=3D"A7XX=
-"/>
> +	<reg32 offset=3D"0x0b06" name=3D"CP_LPAC_RB_RPTR" variants=3D"A7XX-"/>
> +	<reg32 offset=3D"0x0b07" name=3D"CP_LPAC_RB_WPTR" variants=3D"A7XX-"/>
>  	<reg32 offset=3D"0x090a" name=3D"CP_DRAW_STATE_ADDR" variants=3D"A6XX-A=
7XX"/>
>  	<reg32 offset=3D"0x090b" name=3D"CP_DRAW_STATE_DATA" variants=3D"A6XX-A=
7XX"/>
>  	<reg32 offset=3D"0x090c" name=3D"CP_ROQ_DBG_ADDR" variants=3D"A6XX-A7XX=
"/>
> @@ -521,6 +531,7 @@ by a particular renderpass/blit.
>  	<reg32 offset=3D"0x0b29" name=3D"CP_SQE_AC_STAT_ADDR" variants=3D"A7XX"=
/>
>  	<reg32 offset=3D"0x0b2a" name=3D"CP_SQE_AC_STAT_DATA" variants=3D"A7XX"=
/>
> =20
> +	<reg32 offset=3D"0x0b30" name=3D"CP_LPAC_CHICKEN_DBG" variants=3D"A7XX-=
"/>
>  	<reg32 offset=3D"0x0b31" name=3D"CP_LPAC_APRIV_CNTL" variants=3D"A7XX"/>
>  	<reg32 offset=3D"0x0b34" name=3D"CP_LPAC_PROG_FIFO_SIZE" variants=3D"A7=
XX"/>
>  	<reg32 offset=3D"0x0b35" name=3D"CP_LPAC_ROQ_DBG_DATA" variants=3D"A7XX=
"/>
> @@ -1207,6 +1218,7 @@ by a particular renderpass/blit.
>  	<reg64 offset=3D"0x0E08" name=3D"UCHE_TRAP_BASE" variants=3D"A8XX-"/>
>  	<reg64 offset=3D"0x0E0B" name=3D"UCHE_GMEM_RANGE_MIN" variants=3D"A6XX-=
A7XX"/>
>  	<reg64 offset=3D"0x0E0D" name=3D"UCHE_GMEM_RANGE_MAX" variants=3D"A6XX-=
A7XX"/>
> +	<reg32 offset=3D"0x0E12" name=3D"UCHE_DEBUG_CNTL_1" usage=3D"cmd"/>

[Severity: Medium]
Should these new register definitions specify narrower hardware variants to
avoid colliding with existing A6XX, A7XX, and A8XX registers during header
generation in drivers/gpu/drm/msm/registers/gen_header.py?

First, UCHE_DEBUG_CNTL_1 is added at offset 0x0E12 with usage=3D"cmd" and no
variants attribute, while leaving the existing definition for 0x0e12 on
A6XX-A7XX in place and overlapping with UCHE_GBIF_GX_CONFIG on A8XX-:

	<reg32 offset=3D"0x0e3a" name=3D"UCHE_GBIF_GX_CONFIG" variants=3D"A6XX-A7X=
X"/>
	<reg32 offset=3D"0x0e12" name=3D"UCHE_GBIF_GX_CONFIG" variants=3D"A8XX-"/>
	...
	<!-- always 0x03200000 ? -->
	<reg32 offset=3D"0x0e12" name=3D"UCHE_UNKNOWN_0E12" variants=3D"A6XX-A7XX"=
 usage=3D"init"/>

Because UCHE_DEBUG_CNTL_1 has no variants restriction, dump_reg_usages() in
gen_header.py emits 0x0e12 into CMD_REGS<A8XX> where that offset is
UCHE_GBIF_GX_CONFIG, and leaves duplicate definitions for 0x0e12 on
A6XX-A7XX.

Second, CP_LPAC_RB_BASE (0x0b00), CP_LPAC_RB_CNTL (0x0b02),
CP_LPAC_RB_RPTR_ADDR (0x0b04), CP_LPAC_RB_RPTR (0x0b06), CP_LPAC_RB_WPTR
(0x0b07), and CP_LPAC_CHICKEN_DBG (0x0b30) use open-ended variants=3D"A7XX-=
",
which includes A8XX. However, on A8XX- the LPAC ringbuffer registers are at
0x080b-0x0812 and offsets 0x0b00-0x0b01 are reassigned:

	<reg64 offset=3D"0x080b" name=3D"CP_RB_BASE_LPAC" variants=3D"A8XX-"/>
	<reg32 offset=3D"0x080d" name=3D"CP_RB_CNTL_LPAC" variants=3D"A8XX-"/>
	<reg32 offset=3D"0x080e" name=3D"CP_RB_RPTR_WR_LPAC" variants=3D"A8XX-"/>
	<reg64 offset=3D"0x080f" name=3D"CP_RB_RPTR_ADDR_LPAC" variants=3D"A8XX-"/>
	<reg32 offset=3D"0x0811" name=3D"CP_RB_RPTR_LPAC" variants=3D"A8XX-"/>
	<reg32 offset=3D"0x0812" name=3D"CP_RB_WPTR_LPAC" variants=3D"A8XX-"/>
	...
	<reg32 offset=3D"0x0b00" name=3D"CP_SLICE_MEM_POOL_DBG_ADDR_PIPE" variants=
=3D"A8XX-"/>
	<reg32 offset=3D"0x0b01" name=3D"CP_SLICE_MEM_POOL_DBG_DATA_PIPE" variants=
=3D"A8XX-"/>

Other A7XX LPAC registers in the 0x0b0a-0x0b40 range use variants=3D"A7XX" =
or
variants=3D"A6XX-A7XX".

Finally, CP_LPAC_PROTECT_CNTL at offset 0x0B09 omits a variants attribute
(exposing it on A8XX) and duplicates the bitfields inline instead of using
type=3D"a6xx_cp_protect_cntl" defined immediately above it:

	<bitset name=3D"a6xx_cp_protect_cntl" inline=3D"yes">
		<bitfield pos=3D"3" name=3D"LAST_SPAN_INF_RANGE" type=3D"boolean"/>
		<bitfield pos=3D"1" name=3D"ACCESS_FAULT_ON_VIOL_EN" type=3D"boolean"/>
		<bitfield pos=3D"0" name=3D"ACCESS_PROT_EN" type=3D"boolean"/>
	</bitset>

	<reg32 offset=3D"0x084f" name=3D"CP_PROTECT_CNTL" type=3D"a6xx_cp_protect_=
cntl" variants=3D"A6XX-A7XX"/>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-descriptiv=
e-name-lpac-upstream-v2-0-a21a5c850961@gmail.com?part=3D8
