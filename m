Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE66E606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 06:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dVwHVfxk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32FC710E610;
	Thu, 26 Nov 2026 06:40:40 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BB1310E610
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:40:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9A4E26281D;
 Thu, 26 Nov 2026 06:40:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 114551F000D2;
 Thu, 26 Nov 2026 06:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795675232;
 bh=blq4xNLREr8k88dpzUX5hBq/oGQ1KO/MNO42Ak7DyLo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dVwHVfxkPblGWq/fxQgHF8+ok/jj2G2xA+15RX/eShDo2G2xNJLBNJ6eHEl5QOMkC
 olUk2ljeguMxpRElddLtA504vuUD5HFp8Evhrx/+6cHXpmjnwTi5uOzXJlxrE7jm3j
 9YyKVQCcclZMDCIFncqrAokOEYivQv9sXRtgWyVVpY4qSLPka6tenUJdTNAjfFUPt8
 egWjtO2abHVKCg/lV9+/K41nKyFpigd6PWd7act3ZDhR0ScyrbF+O1d0zCj6BEERIA
 qLELg/nF42zblksyvzcQdHtD3gockxG92qtLaMX0yiQgV5slYiwOO7vr57UJ6wO5FG
 2tq83P8KDUb4A==
Message-ID: <sashiko-outbox-234874@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/21] drm/msm/dcp: Add HFI panel definitions
To: "Jayant Shekhar" <jayant.shekhar@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org, media-ci@linuxtv.org
In-Reply-To: <20261126-jshekhar-v3-dcp-v3-5-f1e9d7505039@oss.qualcomm.com>
References: <20261126-jshekhar-v3-dcp-v3-0-f1e9d7505039@oss.qualcomm.com>
 <20261126-jshekhar-v3-dcp-v3-5-f1e9d7505039@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 06:40:31 +0000
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
- [Medium] drm/msm/dcp: decimal values prefixed with 0x in
  hfi_panel_dcs_command_type
--

commit d279d718168d7206eea3327b3e453bdfb0781ec8
Author: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>

drm/msm/dcp: Add HFI panel definitions

This commit adds HFI panel command IDs, property identifiers, and panel
configuration structures for DSI panel initialization and DCS transfers
through DCP firmware.

> diff --git a/drivers/gpu/drm/msm/dcp/hfi/hfi_defs_panel.h b/drivers/gpu/d=
rm/msm/dcp/hfi/hfi_defs_panel.h
> new file mode 100644
> index 0000000000000..a38d778898b2d
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dcp/hfi/hfi_defs_panel.h
[ ... ]
> +enum hfi_panel_dcs_command_type {
> +	HFI_DCS_CMD_PRE_ON                      =3D 0x00000000,
> +	HFI_DCS_CMD_ON                          =3D 0x00000001,
> +	HFI_DCS_CMD_VIDEO_ON                    =3D 0x00000002,
> +	HFI_DCS_CMD_COMMAND_ON                  =3D 0x00000003,
> +	HFI_DCS_CMD_POST_PANEL_ON               =3D 0x00000004,
> +	HFI_DCS_CMD_PRE_OFF                     =3D 0x00000005,
> +	HFI_DCS_CMD_OFF                         =3D 0x00000006,
> +	HFI_DCS_CMD_POST_OFF                    =3D 0x00000007,
> +	HFI_DCS_CMD_PRE_RES_SWITCH              =3D 0x00000008,
> +	HFI_DCS_CMD_RES_SWITCH                  =3D 0x0000009,
> +	HFI_DCS_CMD_POST_RES_SWITCH             =3D 0x00000010,
> +	HFI_DCS_CMD_VIDEO_MODE_SWITCH_INS       =3D 0x00000011,
> +	HFI_DCS_CMD_VIDEO_MODE_SWITCH_OUTS      =3D 0x00000012,
> +	HFI_DCS_CMD_COMMAND_MODE_SWITCH_INS     =3D 0x00000013,
> +	HFI_DCS_CMD_COMMAND_MODE_SWITCH_OUTS    =3D 0x00000014,
> +	HFI_DCS_CMD_PANEL_STATUS                =3D 0x00000015,
> +	HFI_DCS_CMD_LP1                         =3D 0x00000016,
> +	HFI_DCS_CMD_LP2                         =3D 0x00000017,
> +	HFI_DCS_CMD_NOLP                        =3D 0x00000018,
> +	HFI_DCS_CMD_PPS                         =3D 0x00000019,
> +	HFI_DCS_CMD_ROI                         =3D 0x00000020,
> +	HFI_DCS_CMD_TIMING_SWITCH               =3D 0x00000021,
> +	HFI_DCS_CMD_POST_MODE_SWITCH_ON         =3D 0x00000022,
> +	HFI_DCS_CMD_QSYNC_ONS                   =3D 0x00000023,
> +	HFI_DCS_CMD_QSYNC_OFFS                  =3D 0x00000024,
> +	HFI_DCS_CMD_MAX                         =3D 0x00000025
> +};

[Severity: Medium]
Were the decimal values 9 through 25 in enum hfi_panel_dcs_command_type
prefixed with 0x000000 by mistake?

This skips 0x0a..0x0f and 0x1a..0x1f, shifting every command ID from
HFI_DCS_CMD_POST_RES_SWITCH onward and setting HFI_DCS_CMD_MAX to 0x25
(37) instead of 0x19 (25).  Beyond sending wrong command IDs, sizing a
HFI_PROPERTY_PANEL_DCS_CMD_INFO array of struct
hfi_panel_dcs_cmd_buffer_info (8 u32 words each) by HFI_DCS_CMD_MAX would
produce 296 u32 words, overflowing the 8-bit word-count field in
HFI_PACK_KEY().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-jshekhar-v=
3-dcp-v3-0-f1e9d7505039@oss.qualcomm.com?part=3D5
