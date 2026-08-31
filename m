Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 729AFC61DE2
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 09:17:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3EBC10E794;
	Mon, 31 Aug 2026 09:17:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="a6Cl4L5R";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MkhioMiG";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06CDC10E794
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 09:17:38 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V7xkQS3427539
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 09:17:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iA3QMMHVEsPmME4HCgD644tjsXU5xTSR7oKywSBS2WU=; b=a6Cl4L5R/rIQgV3u
 xDqECEQNP+XCVoTGwLkV9GI9tmjsq9eG7t7vZaHWTsdYdZFjDxKXTW+tHt8nkiI3
 2pttUj9367iZ4IuDVQP0vXPQFlzG+UEO9U7veAGZi/Rfrfmp8XLtWVwVwC6rkYQN
 UlI6/1q6BlEz+5wTESkgglCytKz/rV5u+mov+yYe0FDZ6kEq0vavPPGJ00Lci85b
 w1Jv38lVmehvnFF59h1q4TvP6Y713VldiAKGekWtX/7wxeTTLUdCiAzPjHYJu/JQ
 rw32bA3IaNKVvy3Djyi4ESRYVt/GCBCXGJTDj3Yh/Wd74uOAtL5P2Vv4XR8Xb65B
 oW6xhA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd4pm8mq6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 09:17:37 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2d0563db6bcso14220005ad.2
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 02:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788167857; x=1788772657;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iA3QMMHVEsPmME4HCgD644tjsXU5xTSR7oKywSBS2WU=;
 b=MkhioMiGcTUtRPYInt5R0sxXLcEJ7fDZsQclylorz0eBs25LIVh6aBwbWic0FySxJ6
 D3d3kMGByRVaHTd2AwsAnC071yXz3nraNpTwYTcEbketOGTwKjkNQtrZZYIIqC1xsItn
 VSd6gl9GL05dk06YIeFB20tAQaFJdgLwCR8anjGi6hoolGNCcf3jAXk8pCL/W7J1F1L5
 H94HKNXA8NcYz2oO0rDWM+thEUiVG8ClNsqj7UO9X235G//d8F9BPwh+eIteADMXrFEs
 X/ZYExhhAVD9Ax78UFm1zEeQlrVeOE9vWhtu7elYEMUEFebfovzSzd/IoZIyHaHEg45D
 VTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788167857; x=1788772657;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iA3QMMHVEsPmME4HCgD644tjsXU5xTSR7oKywSBS2WU=;
 b=JXH4lI93udezUoPHqdOSqMWV5k/79zSqIrXx4lIe+yLaASNP1lAP59nNhEa3jQniBt
 rAKn/JMhD7qBI7zljW7BStsx7oi+hhiy3iLkrOnJ7YVcC5ud9ufCIX1ZCmF6GhQ1qtfr
 sPisULxZcG4LlLnF2L84JbDjWMKXYpH/x3UAviuMvNkohf+i6YQVgIC37YZm9NevgXll
 grVuOXZNnbf+MZL+xiaeMFC7edeIH/ub1x1bJbDsziWKQPw95bdqlB0GgwJAdVO7EpP/
 3w1ibKzt0a60oHzpZ2lGAAaFEfB09DKuqUjdJpRnlZofsBJ+CYGVM6tIbWw3L+h8HquT
 2ssg==
X-Forwarded-Encrypted: i=1;
 AKwUvByvZxxmwAM2ay8WlebjyPIGphimbbWrx+iINyiBS9jU9N5JqOw7SmZxmuJ6MG8X7JW32q680NcegO8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lbShOR2cZxQtQs5LBeNUPGAZbIvYp3kbtVMo3OpEqfi8DK3uXV
 SJJpu13LWiIxMvnyev3xWU54dipHb1DP1tSTincs6oEI8e4KKxewreAY/IfJ9OUP4JKCkNwbj4g
 QbaLyNzWDCW4jcAVdigmHo11az77RF8DbYFTTgjoPCzdzR+Sqh+Kln985utZluejk6h4K7m0=
X-Gm-Gg: AYBFou3sNfmTIoUh8GohSTrGLV+reQjddx6WX1vU6p1LfyJ/C39pNvr0meJSUgwVPun
 mQK0uCmPM3lfRfjsZrzjrO4oQ4CBkCuHRKIQmjG5nex2iloRFOQ0ZaLlA8/VIu24s2blmEpxIc8
 nehX7ZU17f0anxFmaDLWNDfQwxfnEtCTHCzNXgZC6dBDhLduRfq5mlLw6fqVKK8O3P0tVBs1Xzf
 AodScJLyD9gYIEVrclClx01M6RtEJrXh5sa78mRMq2GNzqWaceKcIelFpCFo4ivdo6MWPb0SKVW
 1lwPUUVHWzZ8Yynf2oTTbHVrBM6Vz4zzPp98q7hNUlb3Lv1/+Ne8QGvQygBCUf+BhF4huKu616E
 bNd2RKQxZrHI6kaVrfUpXusdsH67RQf/bo2zUegNxoqwT9ZwyntfsagU2rUSSfhYehH1o8rTBda
 1lMIr1plWtTf3bTQKmrUpw
X-Received: by 2002:a17:903:228a:b0:2cb:2b50:d9da with SMTP id
 d9443c01a7336-2d74df53523mr206037075ad.3.1788167856712; 
 Mon, 31 Aug 2026 02:17:36 -0700 (PDT)
X-Received: by 2002:a17:903:228a:b0:2cb:2b50:d9da with SMTP id
 d9443c01a7336-2d74df53523mr206036655ad.3.1788167856110; 
 Mon, 31 Aug 2026 02:17:36 -0700 (PDT)
Received: from hu-vishsain-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3286f784857sm28142921eec.3.2026.08.31.02.17.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 02:17:35 -0700 (PDT)
Date: Mon, 31 Aug 2026 14:47:31 +0530
From: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v7 2/2] drm/bridge: add support for lontium lt9211c bridge
Message-ID: <apVGq9dlMTDTgOkR@hu-vishsain-blr.qualcomm.com>
References: <20260822-add-lt9211c-bridge-v7-0-7dcf567d57c4@oss.qualcomm.com>
 <20260822-add-lt9211c-bridge-v7-2-7dcf567d57c4@oss.qualcomm.com>
 <20260822171512.3A3391F000E9@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260822171512.3A3391F000E9@smtp.kernel.org>
X-Proofpoint-ORIG-GUID: BlxzBEs6E8zNd6gPUigLdYkM1HySf9i8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA3OSBTYWx0ZWRfX5UIv6EHqihox
 yKPolEdnRIx9xsvT698+Z/3A1Bnd/okosTYpGJ/sb7ojsW+VaowHya5VFK0P4vkwSl1tsTkex7o
 pzofyuYoxbCGSRRMd667IRicREMkDNCWloOIn1CVIgIQlMZO9bCXhF0pT2QDG5YHZlOjxtZXfsn
 LeSS4AR8Sedni1c9RBQer2JNb45ostMEBT5regqR1YnWM9dDSxQxzaHuY94XDb8FkKCYyxqAa4L
 6Zj9wv0J0XoDOHNW+PX5Qh7JkRQhKt77f5Dk4QYQ2rOjDNjEBsPJc+GzxedOrgXrMvayfsQE247
 Hhg3OXfz9NFvAi0e1bbdiwTmUjYdduQmH8UhTzvzU7XWe3nWejTR1ES6VgmZxKJ3qVwsMdPsjUN
 LwNHhKTZhkOI4fL5ZwOHGk3KR6vA3aNAgvKZp9gMRYAszR5RxBZs6cdNFqM1pnFkO2lrtchhnQQ
 /4wZwGgXjYZPPFNy0dQ==
X-Proofpoint-GUID: BlxzBEs6E8zNd6gPUigLdYkM1HySf9i8
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA3OSBTYWx0ZWRfXwoowp1QtYz3D
 RGJGRC52FsXxRqHEwWW6yO3mJdWZOyIAsgpGQKvvx2TSduoEnClbqv667diEbOBAzy4TX7sqzKJ
 qstl/pQOb5uNKS1Pk0kelMgodnZSdQM=
X-Authority-Analysis: v=2.4 cv=GbQnWwXL c=1 sm=1 tr=0 ts=6a9546b1 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=8nJEP1OIZ-IA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=c92rfblmAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=RqoEFDNdqNvBIBNZC6gA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310079
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

On Sat, Aug 22, 2026 at 05:15:11PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> 
> New issues:
> - [High] Deferring LT9211C bridge configuration to an asynchronous workqueue breaks the DRM display pipeline enablement sequence and introduces race conditions.
> - [High] Signed integer overflow in pixel clock calculations leads to undefined behavior.
> - [High] Unchecked division by `mode->clock` can cause a kernel panic (divide-by-zero).
> - [Medium] Chip ID detection succeeds for either hardware variant but ignores device tree mismatch, leading to incorrect hardware initialization.
> 
> Pre-existing issues:
> - [High] Unbinding the device via sysfs frees the bridge context while it is still referenced by the DRM pipeline (Use-After-Free).
> --
> 
> --- Patch [2]: [PATCH v7 2/2] drm/bridge: add support for lontium lt9211c bridge ---
> commit 8d2ec0de9ed01158cbba906a0bfbb93f7fab90c7
> Author: Yi Zhang <zhanyi@qti.qualcomm.com>
> Subject: drm/bridge: add support for lontium lt9211c bridge
> 
> This commit extends the lontium-lt9211 driver to support DSI-to-LVDS
> bridge configuration for both LT9211 and LT9211C variants. It detects
> chip IDs, provides per-chip configuration, and implements an asynchronous
> initialization sequence for the LT9211C.
> 
> > diff --git a/drivers/gpu/drm/bridge/lontium-lt9211.c b/drivers/gpu/drm/bridge/lontium-lt9211.c
> > --- a/drivers/gpu/drm/bridge/lontium-lt9211.c
> > +++ b/drivers/gpu/drm/bridge/lontium-lt9211.c
> [ ... ]
> > @@ -120,14 +209,23 @@ static int lt9211_read_chipid(struct lt9211 *ctx)
> >  		return ret;
> >  	}
> >  
> > -	/* Test for known Chip ID. */
> > -	if (chipid[0] != REG_CHIPID0_VALUE || chipid[1] != REG_CHIPID1_VALUE) {
> > -		dev_err(ctx->dev, "Unknown Chip ID: 0x%02x 0x%02x 0x%02x\n",
> > -			chipid[0], chipid[1], chipid[2]);
> > -		return -EINVAL;
> > +	/* Test for LT9211 Chip ID. */
> > +	if (chipid[0] == REG_CHIPID0_VALUE && chipid[1] == REG_CHIPID1_VALUE) {
> > +		dev_dbg(ctx->dev, "Detected LT9211 chip\n");
> > +		return 0;
> >  	}
> >  
> > -	return 0;
> > +	/* Test for LT9211C Chip ID. */
> > +	if (chipid[0] == REG_CHIPID0_LT9211C_VALUE &&
> > +	    chipid[1] == REG_CHIPID1_LT9211C_VALUE &&
> > +	    chipid[2] == REG_CHIPID2_LT9211C_VALUE) {
> > +		dev_dbg(ctx->dev, "Detected LT9211C chip\n");
> > +		return 0;
> > +	}
> 
> [Severity: Medium]
> Does this chip ID validation check the physically detected chip against the
> expected configuration? Since it returns 0 for both variants without checking
> ctx->chip_data->chip_type (which comes from the device tree compatible
> string), could an incorrectly configured device tree allow the driver to
> proceed with the wrong initialization sequence?
will fix this in next revision.
 
> [ ... ]
> > @@ -454,6 +552,657 @@ static int lt9211_configure_tx(struct lt9211 *ctx, bool jeida,
> [ ... ]
> > +static int lt9211c_configure_tx(struct lt9211 *ctx, bool jeida, bool bpp24,
> > +				bool de, const struct drm_display_mode *mode)
> > +{
> [ ... ]
> > +	if (ctx->lvds_dual_link)
> > +		phy_clk = (u32)(mode->clock * 7 / 2);
> > +	else
> > +		phy_clk = (u32)(mode->clock * 7);
> 
> [Severity: High]
> Could this pixel clock calculation overflow? Since mode->clock is a signed
> 32-bit integer, multiplying it by 7 could overflow INT_MAX for high pixel
> clocks (like a 4K resolution at ~594,000 kHz) before the result is cast to
> u32.
> 
> Without a mode_valid or atomic_check callback to restrict the maximum
> supported pixel clock, could this cause incorrect hardware initialization or
> undefined behavior?
False positive -- the driver does implement mode_valid: lt9211_mode_valid()
(lt9211.c:1342, wired into lt9211_funcs for both LT9211 and LT9211C) clamps
mode->clock to the 25000-176000 kHz LVDS range before any mode reaches
atomic_enable(). 176000 * 7 = 1,232,000, well under INT_MAX.
No overflow is reachable through the DRM mode-selection path.
 
> [ ... ]
> > +	/*
> > +	 * 0x8233: pix_mux sel & pix_div sel
> > +	 * To avoid floating point operations, The pixclk_div is enlarged by 10 times
> > +	 */
> > +	if (mode->clock > 150000) {
> > +		val = 0x04;
> > +		pixclk_div = 35;
> > +	} else {
> > +		pixclk_div =
> > +			(u8)((phy_clk * sericlk_div * 10) / (mode->clock * 7));
> 
> [Severity: High]
> Does this division need to ensure mode->clock is non-zero? If userspace
> provides a malformed mode with a clock of 0, could this trigger a
> divide-by-zero exception and kernel panic? 
> 
> Given the driver doesn't implement mode_valid or atomic_check callbacks,
> there appears to be no filtering of custom modes before this calculation,
> or the similar division below at:
> div_set = (u8)(phy_clk * sericlk_div / mode->clock / pre_div)
False positive -- lt9211_mode_valid() rejects any mode with
clock < 25000 (kHz) before it can reach this code, so mode->clock is
never 0 here. No mode bypasses mode_valid() on this path (DRM core calls
bridge mode_valid for every candidate mode during connector probe).


> [ ... ]
> > @@ -523,6 +1272,21 @@ static void lt9211_atomic_enable(struct drm_bridge *bridge,
> >  	if (ret)
> >  		return;
> >  
> > +	if (ctx->chip_data->chip_type == LT9211C) {
> > +		drm_mode_copy(&ctx->lt9211c_mode, mode);
> > +		ctx->lt9211c_bpp24 = lvds_format_24bpp;
> > +		ctx->lt9211c_jeida = lvds_format_jeida;
> > +		ctx->lt9211c_de_high = !!(bus_flags & DRM_BUS_FLAG_DE_HIGH);
> > +		ctx->lt9211c_crtc = crtc;
> > +
> > +		/*
> > +		 * Needs a live DSI stream to auto-detect RX resolution/format;
> > +		 * defer bridge configuration until after vblank.
> > +		 */
> > +		queue_delayed_work(ctx->wq, &ctx->lt9211_dw, 0);
> > +		return;
> > +	}
> 
> [Severity: High]
> Does deferring the bridge configuration to an asynchronous workqueue break the
> DRM atomic enablement sequence? 
> 
> By returning immediately from atomic_enable(), downstream bridges like the
> panel might be activated before the LT9211C has configured its RX, PLLs, and
> TX output.
> 
> Additionally, if the CRTC relies on the bridge being active to generate
> vblanks, could drm_crtc_wait_one_vblank() in lt9211_delayed_work_func()
> cause a deadlock? If the pipeline is disabled while the work is running,
> could cancel_delayed_work_sync() block indefinitely or cause a
> use-after-free?
This is a known, intentional tradeoff and was discussed in the
v6->v7 review, bridge fails to read RX width/height/format because the
stream isn't live yet at that point in the pipeline.
The delayed work + drm_crtc_wait_one_vblank() defers just far enough to guarantee a live stream.
On the specific concerns:
   - drm_crtc_wait_one_vblank() has its own internal timeout and will not
     block indefinitely if vblank IRQs stop arriving.
   - cancel_delayed_work_sync() in lt9211_atomic_disable() is therefore
     also bounded -- it can wait at most one vblank-wait timeout plus the
     remaining init sequence, not forever.
 
> [ ... ]
> > @@ -748,45 +1517,48 @@ static int lt9211_probe(struct i2c_client *client)
> [ ... ]
> > -	ctx->bridge.of_node = dev->of_node;
> > -	drm_bridge_add(&ctx->bridge);
> > -
> > -	ret = lt9211_host_attach(ctx);
> > +	ctx->bridge.of_node = dev->of_node;
> > +	ret = devm_drm_bridge_add(dev, &ctx->bridge);
> >  	if (ret)
> > -		drm_bridge_remove(&ctx->bridge);
> > -
> > -	return ret;
> > -}
> > -
> > -static void lt9211_remove(struct i2c_client *client)
> > -{
> > -	struct lt9211 *ctx = i2c_get_clientdata(client);
> > +		return ret;
> >  
> > -	drm_bridge_remove(&ctx->bridge);
> > +	return lt9211_host_attach(ctx);
> >  }
> 
> [Severity: High]
> This is a pre-existing issue, but does tying the bridge context to the device
> lifetime (via devm_drm_bridge_alloc and devm_drm_bridge_add) instead of the
> DRM object lifetime leave the module vulnerable?
> 
> If the device is unbound via sysfs while the display is active, the devres
> cleanup frees the context memory. Since the DRM core doesn't synchronously
> tear down active displays on bridge removal, would subsequent calls by the DRM
> core to functions like lt9211_atomic_disable() on the freed pointer result in
> a use-after-free?

This is pre-existing issue.
The upstream-provided fix for exactly this class of bug is
drm_bridge_unplug()/drm_bridge_enter()/drm_bridge_exit()
Its only current adopter is drivers/gpu/drm/bridge/ti-sn65dsi83.c (d2e8d1bc840b).
Applying it here would mean reintroducing an explicit .remove() callback calling
drm_bridge_unplug(), which is a partial, deliberate reversal of this
series' own "drm/bridge: lt9211: use devm_drm_bridge_add and drop
lt9211_remove" change from v7 -- devm_drm_bridge_add()'s automatic
drm_bridge_remove() on unbind has no "unplug" signal equivalent.

 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260822-add-lt9211c-bridge-v7-0-7dcf567d57c4@oss.qualcomm.com?part=2
