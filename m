Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A13DCF9EDF8
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 15:15:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 089A810E2C7;
	Wed, 22 Apr 2026 15:15:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="JOKazJ6Q";
	dkim-atps=neutral
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37F1D10E04D;
 Wed, 22 Apr 2026 15:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1776870922; x=1777130122;
 bh=l6+PqlJB6HASuTZjBIQFQZe3Akfa9hmumLUXf6H6UhU=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=JOKazJ6Qrt3IcKfOCJ2R+puLhsuG0PS9wbKU6oiY83W/8/iZQf0287hjj7TlFSrJe
 popq7DENBYUch/7vHE4uR4G9UFTmt6uRkYXkLbTEvEf13bQpiALW8WVrDcZF5o4rZT
 QiaG5yd7FNm184NDVWJMNl2lr5GRPH4jfnNC+4je50SjZB6N6YkoYNXnzUMCKwzYGH
 8OGy3N/FAveAzRZauHeJdRHJ8Uk8cboZS8Eo1yU0zGJywuMydVc9ike5Iu6X5t/eD6
 pVYHvOPmZBJahqtVQexPpUR+B0zRFiOqDymaRTFUQexgpNDacVD2mgrXoZsD0Xs+gu
 3YDspHvM5QvrQ==
Date: Wed, 22 Apr 2026 15:15:17 +0000
To: Alexander Koskovich <akoskovich@pm.me>
From: Alexander Koskovich <akoskovich@pm.me>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/2] drm/mipi-dsi: add flag for sending all DSC slices
 in one packet
Message-ID: <9vOWCBGQu4kqkzUaF1cAimiRnCHzd7NAjB98ZcmVygN9kNr7G2H-UzhkQfyiDlaj7G6wxWqKlGvAprsMtVE-P2erdkutRN7LuO1GQBOSzH8=@pm.me>
In-Reply-To: <20260318-dsi-dsc-slice-per-pkt-v2-1-0a1b316f8250@pm.me>
References: <20260318-dsi-dsc-slice-per-pkt-v2-0-0a1b316f8250@pm.me>
 <20260318-dsi-dsc-slice-per-pkt-v2-1-0a1b316f8250@pm.me>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: fd442c31505b96e580cd2d83842a4670e0592a66
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Wednesday, March 18th, 2026 at 5:58 AM, Alexander Koskovich <akoskovich@=
pm.me> wrote:

> The MIPI DSI v1.3 spec defines two modes for transporting compressed
> pixel data: one slice per packet or multiple slice widths in a single
> packet (Section 8.8.24 Figure 40).
>=20
> Add a MIPI_DSI_MODE_DSC_ALL_SLICES_IN_PKT flag that panel drivers can
> set to indicate that all DSC slices for a line should be packed into a
> single packet. When unset should default to 1 slice per packet.
>=20
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---
>  include/drm/drm_mipi_dsi.h | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
> index 3aba7b380c8d..d3ad8c5d3ebe 100644
> --- a/include/drm/drm_mipi_dsi.h
> +++ b/include/drm/drm_mipi_dsi.h
> @@ -138,6 +138,8 @@ struct mipi_dsi_host *of_find_mipi_dsi_host_by_node(s=
truct device_node *node);
>  #define MIPI_DSI_MODE_LPM=09=09BIT(11)
>  /* transmit data ending at the same time for all lanes within one hsync =
*/
>  #define MIPI_DSI_HS_PKT_END_ALIGNED=09BIT(12)
> +/* pack all DSC slices for a line into a single packet */
> +#define MIPI_DSI_MODE_DSC_ALL_SLICES_IN_PKT=09BIT(13)
>=20
>  enum mipi_dsi_pixel_format {
>  =09MIPI_DSI_FMT_RGB888,
>=20
> --
> 2.53.0
>=20

If there are no objections, could this be merged?

Thanks,
Alex

