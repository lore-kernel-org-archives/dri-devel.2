Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 240F4C61DBD
	for <dri-devel@archiver.kernel.org>; Sat, 29 Aug 2026 00:59:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C0C510E077;
	Sat, 29 Aug 2026 00:59:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RncsQP6G";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CCC710E077
 for <dri-devel@lists.freedesktop.org>; Sat, 29 Aug 2026 00:59:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5D61A43A5D;
 Sat, 29 Aug 2026 00:59:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FEC41F000E9;
 Sat, 29 Aug 2026 00:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787965171;
 bh=lIPyszJ+2KeuQnui1M417EfCRPjeMVYE/sQRuQNuiVY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RncsQP6Gvmv+bIr4p4M/NpsQE8/eT4P09cAM3SFDUQe5meIjj38PAAa532QYhFzLC
 hoVWijkvKINmajcwUsBa3nkdIHq0ICV0irnU5U0eAW41ksRn8VyHPvp/Ms8Qoths08
 muS/UhIcyR2ZbXeQdRrNItLqXhebdCJJTy4gi2pCE31+RAF8hRt/LIJCfPAXFmuijG
 5fCzpJ7zUtKjAeZHtGeMbTAyTAAfRUBTeGd28CAc8A7SelIhLmGoy0mwOsn+4NdD4n
 0p8esK7z8WcWOL2ypdFWCX8vy1sMaEufQeAMylAikZA2x5AOas8r9BZxQp/Ib1/g7U
 kMd+qIFriWn4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amd/display: add missing CRC1 window registers and
 masks for DCN3.2
To: "Mikhail Gavrilov" <mikhail.v.gavrilov@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260829004608.25252-1-mikhail.v.gavrilov@gmail.com>
References: <20260829004608.25252-1-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 29 Aug 2026 00:59:30 +0000
Message-Id: <20260829005931.1FEC41F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] The patch adds CRC1 window control registers for DCN3.2 but comple=
tely omits the corresponding CRC1 data registers (`OTG_CRC1_DATA_RG`, `OTG_=
CRC1_DATA_B`) and their bitfield masks, leading to silent readout failures =
on engine 1.
--

commit 62dcf31f49526ec3cc11096d84f1d9181eb2d9a3
Author: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

drm/amd/display: add missing CRC1 window registers and masks for DCN3.2

This commit adds missing CRC1 window registers and masks for DCN3.2 to avoid
a WARN triggered by generic_reg_update_ex() asserting on zero masks. It
supplies the SRI_ARR and SF entries for the OTG_CRC1_WINDOWA/B_X/Y_CONTROL
registers.

> diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h b/dri=
vers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h
> index 60c01ec28b653..f696e4ee3bc63 100644
> --- a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h
> +++ b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h
> @@ -146,6 +146,14 @@
>  	SF(OTG0_OTG_CRC0_WINDOWB_X_CONTROL, OTG_CRC0_WINDOWB_X_END, mask_sh),\
>  	SF(OTG0_OTG_CRC0_WINDOWB_Y_CONTROL, OTG_CRC0_WINDOWB_Y_START, mask_sh),\
>  	SF(OTG0_OTG_CRC0_WINDOWB_Y_CONTROL, OTG_CRC0_WINDOWB_Y_END, mask_sh),\
> +	SF(OTG0_OTG_CRC1_WINDOWA_X_CONTROL, OTG_CRC1_WINDOWA_X_START, mask_sh),\
> +	SF(OTG0_OTG_CRC1_WINDOWA_X_CONTROL, OTG_CRC1_WINDOWA_X_END, mask_sh),\
> +	SF(OTG0_OTG_CRC1_WINDOWA_Y_CONTROL, OTG_CRC1_WINDOWA_Y_START, mask_sh),\
> +	SF(OTG0_OTG_CRC1_WINDOWA_Y_CONTROL, OTG_CRC1_WINDOWA_Y_END, mask_sh),\
> +	SF(OTG0_OTG_CRC1_WINDOWB_X_CONTROL, OTG_CRC1_WINDOWB_X_START, mask_sh),\
> +	SF(OTG0_OTG_CRC1_WINDOWB_X_CONTROL, OTG_CRC1_WINDOWB_X_END, mask_sh),\
> +	SF(OTG0_OTG_CRC1_WINDOWB_Y_CONTROL, OTG_CRC1_WINDOWB_Y_START, mask_sh),\
> +	SF(OTG0_OTG_CRC1_WINDOWB_Y_CONTROL, OTG_CRC1_WINDOWB_Y_END, mask_sh),\

[Severity: High]
This is a pre-existing issue, but by adding the missing CRC1 window masks
here in OPTC_COMMON_MASK_SH_LIST_DCN3_2, the CRC1 data masks (CRC1_R_CR,
CRC1_G_Y, CRC1_B_CB) still appear to be missing.

When dc_stream_get_crc() is called with crc_window =3D 1 (such as when Secu=
re
Display enables a second ROI), it calls into optc1_get_crc() which relies on
these missing definitions:

drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c:optc1_get_crc() {
    ...
		REG_GET_2(OTG_CRC1_DATA_RG,
			  CRC1_R_CR, r_cr,
			  CRC1_G_Y, g_y);
    ...
}

Should the corresponding SF masks for OTG_CRC1_DATA_RG and OTG_CRC1_DATA_B
also be added to fully restore the functional behavior of engine 1?

>  	SF(OTG0_OTG_TRIGA_MANUAL_TRIG, OTG_TRIGA_MANUAL_TRIG, mask_sh),\
>  	SF(GSL_SOURCE_SELECT, GSL0_READY_SOURCE_SEL, mask_sh),\
>  	SF(GSL_SOURCE_SELECT, GSL1_READY_SOURCE_SEL, mask_sh),\
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource=
.h b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
> index 68e7140f1505d..30878aed61e12 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
> @@ -1054,6 +1054,10 @@ unsigned int dcn32_get_max_hw_cursor_size(const st=
ruct dc *dc,
>        SRI_ARR(OTG_CRC0_WINDOWA_Y_CONTROL, OTG, inst),                   =
       \
>        SRI_ARR(OTG_CRC0_WINDOWB_X_CONTROL, OTG, inst),                   =
       \
>        SRI_ARR(OTG_CRC0_WINDOWB_Y_CONTROL, OTG, inst),                   =
       \
> +      SRI_ARR(OTG_CRC1_WINDOWA_X_CONTROL, OTG, inst),                   =
       \
> +      SRI_ARR(OTG_CRC1_WINDOWA_Y_CONTROL, OTG, inst),                   =
       \
> +      SRI_ARR(OTG_CRC1_WINDOWB_X_CONTROL, OTG, inst),                   =
       \
> +      SRI_ARR(OTG_CRC1_WINDOWB_Y_CONTROL, OTG, inst),                   =
       \

[Severity: High]
This is a pre-existing issue, but similar to the missing masks, the data
registers for engine 1 appear to be completely omitted from REG_STRUCT.

Without the definitions for OTG_CRC1_DATA_RG and OTG_CRC1_DATA_B, attempting
to read from these registers in optc1_get_crc() will silently read from MMIO
offset 0 and return 0, which breaks CRC data readout for engine 1.

Should SRI_ARR entries for OTG_CRC1_DATA_RG and OTG_CRC1_DATA_B also be
added here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260829004608.2525=
2-1-mikhail.v.gavrilov@gmail.com?part=3D1
