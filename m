Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A39C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 09:49:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9455910F28D;
	Thu,  2 Jul 2026 09:49:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OZ6YuWqR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E18C10F28F
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 09:49:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 86FDF416C8;
 Thu,  2 Jul 2026 09:49:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC7D1F00A3D;
 Thu,  2 Jul 2026 09:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782985761;
 bh=/v+CunAD9v1LG3x0CSGUKrfAIyVu2CPBbGUmx3CagcA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OZ6YuWqRXdKrbQEiOLVh5C3PmeyNLpqfm8zTOLWgqk75SmEJunWFMeUcVf/P7C6i8
 k8KOmCw5+uYVFgtGySK85f30ePwK+6zf8l6/qm2zhlG7vyshUwlpwzyg+KxVWPzW8I
 FJjyR/yNLE+ssV1WzhzXHO+IDrXuJjBD1mSG3WbdE3O3WxWPrHdvUgKXKOSkyQCdD9
 Qo5WTuZTALWJBt/8l1kAykcoHfojwbZqnAZsAEc8oP84oTr8hNtmexXDHIr6U9NAnf
 FLra+/sRm3bm0++I92EZ6Oc5JhmSntp/TEcFrQiVImeu3LC+wfphJju9v1K3BdIgUf
 JnvvKFj6xwcUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] drm/msm/hdmi_bridge: Simplify register bit updates
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260702-drm-msm-hdmi-cleanup-v2-1-a4a4f0e8895b@oss.qualcomm.com>
References: <20260702-drm-msm-hdmi-cleanup-v2-0-a4a4f0e8895b@oss.qualcomm.com>
 <20260702-drm-msm-hdmi-cleanup-v2-1-a4a4f0e8895b@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 09:49:20 +0000
Message-Id: <20260702094921.3DC7D1F00A3D@smtp.kernel.org>
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
- [Low] hdmi_update_bits() is incorrectly called with the update value as t=
he mask argument for multi-bit fields, defeating the purpose of the API.
--

commit 21923da02c72e54abf3a47df112e97f9d67ce903
Author: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

drm/msm/hdmi_bridge: Simplify register bit updates

This commit introduces wrapper functions to simplify register updates by
using read-apply-mask-write steps. It updates multiple infoframe setup
functions to use these new helpers to prevent reading and writing to
different registers.

> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm=
/hdmi/hdmi_bridge.c
> --- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
> +++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c

[ ... ]

> @@ -231,11 +217,10 @@ static int msm_hdmi_bridge_write_spd_infoframe(stru=
ct drm_bridge *bridge,
>  	for (i =3D 0; i < ARRAY_SIZE(buf); i++)
>  		hdmi_write(hdmi, REG_HDMI_GENERIC1(i), buf[i]);
> =20
> -	val =3D hdmi_read(hdmi, REG_HDMI_GEN_PKT_CTRL);
> -	val |=3D HDMI_GEN_PKT_CTRL_GENERIC1_SEND |
> -		 HDMI_GEN_PKT_CTRL_GENERIC1_CONT |
> -		 HDMI_GEN_PKT_CTRL_GENERIC1_LINE(SPD_IFRAME_LINE_NUMBER);
> -	hdmi_write(hdmi, REG_HDMI_GEN_PKT_CTRL, val);
> +	val =3D HDMI_GEN_PKT_CTRL_GENERIC1_SEND |
> +	      HDMI_GEN_PKT_CTRL_GENERIC1_CONT |
> +	      HDMI_GEN_PKT_CTRL_GENERIC1_LINE(SPD_IFRAME_LINE_NUMBER);
> +	hdmi_update_bits(hdmi, REG_HDMI_GEN_PKT_CTRL, val, val);

[Severity: Low]
Is val intended to be passed as the mask argument here?

Because HDMI_GEN_PKT_CTRL_GENERIC1_LINE() generates a multi-bit field,
passing the data value as the mask means any zero bits in the computed
value will not be cleared from the register during the update.

This works in the current code because the register is cleared earlier
in msm_hdmi_bridge_clear_spd_infoframe(), but does passing the data as
the mask defeat the purpose of the hdmi_update_bits API?

[ ... ]

> @@ -269,12 +254,11 @@ static int msm_hdmi_bridge_write_hdmi_infoframe(str=
uct drm_bridge *bridge,
>  	for (i =3D 0; i < ARRAY_SIZE(buf); i++)
>  		hdmi_write(hdmi, REG_HDMI_GENERIC0(i), buf[i]);
> =20
> -	val =3D hdmi_read(hdmi, REG_HDMI_GEN_PKT_CTRL);
> -	val |=3D HDMI_GEN_PKT_CTRL_GENERIC0_SEND |
> -		 HDMI_GEN_PKT_CTRL_GENERIC0_CONT |
> -		 HDMI_GEN_PKT_CTRL_GENERIC0_UPDATE |
> -		 HDMI_GEN_PKT_CTRL_GENERIC0_LINE(VENSPEC_IFRAME_LINE_NUMBER);
> -	hdmi_write(hdmi, REG_HDMI_GEN_PKT_CTRL, val);
> +	val =3D HDMI_GEN_PKT_CTRL_GENERIC0_SEND |
> +	      HDMI_GEN_PKT_CTRL_GENERIC0_CONT |
> +	      HDMI_GEN_PKT_CTRL_GENERIC0_UPDATE |
> +	      HDMI_GEN_PKT_CTRL_GENERIC0_LINE(VENSPEC_IFRAME_LINE_NUMBER);
> +	hdmi_update_bits(hdmi, REG_HDMI_GEN_PKT_CTRL, val, val);

[Severity: Low]
Similarly, does this code misuse the API by passing the data value as
the mask argument instead of using HDMI_GEN_PKT_CTRL_GENERIC0_LINE__MASK?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-drm-msm-hd=
mi-cleanup-v2-0-a4a4f0e8895b@oss.qualcomm.com?part=3D1
