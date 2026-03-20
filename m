Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE3771093163
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 01:45:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DD9510E87F;
	Fri, 20 Mar 2026 01:45:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NnoABeWU";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i9l/4aMF";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FF3E10E46E
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 01:45:39 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62JFC6gI3771099
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 01:45:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CBL1764W8XUWZ4XM9UO2GrKnJG78q2fZ1dktl30bcIE=; b=NnoABeWUdrKXpEKZ
 3awbVgyFriKkyWydIJOkeZS7mJcP63+vF+NasaLpYX6bkzEMz8La0w/4n1gQZ/wy
 8Gtb8UfFOHjyk6Fg8+WcNx+Ybu/kwAoh5KA39UCzxzMWnR4ZJAJjZq9APnRtkzgq
 DUy9U1HmK1qMelU60NJQi7Lt3c1YKkZQizADv0FxKVVFAqeA9WV35UNwMjFKMbFf
 V98gQhnhvxJx8GIMQ7JUTo2wZBALUvefv0V89R6ng3uysn/3VAi/JxKVwV1ue57B
 bbdGzKx/M2HX8d4O/MK4ZF6Y4aEYQJ7kZsLzFGwj670PEFJCqVDeY4YLVNv0Fuq1
 pvNsBA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d083rby7w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 01:45:38 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50911c94db1so89381001cf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 18:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773971138; x=1774575938;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CBL1764W8XUWZ4XM9UO2GrKnJG78q2fZ1dktl30bcIE=;
 b=i9l/4aMF6Ra9Nm7OanTyjRx8bfWzqh7WERxIc9AZHkr1Zg5uFQ2rN0meSHim1HCbpR
 WmxomqZRLhg7cin0NMfNK6dTTGTvvIDUlGchmMnzfDafww6Tc4VsxUDWvYIjXDUHWyA9
 +QUMfEmHmrJsjoRAMa1JVtSrGAg3jZY4OIc0pMTNlnzZtLO1p23hGBytR5ImgOVqfyfs
 xYGAss0hg1DyIiR7J9y9r8sxNzxC0yNEFxvQCOjq9Amg6yjWVmJrcrRPhGXgRkxpSL3F
 shChkdRgo46aum+1Nqi7FFQQQXK+y5KUR0B4yEYG+8srSi46nvNb7I/SDyqmU/i3umzd
 XheQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773971138; x=1774575938;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CBL1764W8XUWZ4XM9UO2GrKnJG78q2fZ1dktl30bcIE=;
 b=IHGFfLzPUAih5ET5nrcOsAub+nCkdDo/I38w1BPnpb+PQcA/fHtBsnOmzfca05cr/W
 7u1QqseJNHyE5w/GdZd2l7C4HMJJY0wNct+eQybplQcEicAInr1PnRU51yP/Y0kQv146
 mnbjmh8a8UZ7ldWjepkQ1c+c99ZPiCPjI9EqZTo6bsltXDmZm1d6fgvauPkDjGCI3fMi
 yzoKfyb3j7+oWqertkh8OBEKBEEnpjX8R+YSvpCzRxANoZzLkpM1/GzoJpf6k2aeejfQ
 ylO/pQmXAuxnWphPPPNYwMYRuSw58A4DQPSj42dlVjuZaKpGNwXYGHZfZmTE6nY2K6rC
 yMNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVhSGt2urIP6SSQBgF26PSfymNDr9OuJHAFMrFuVB937djFTk0iDX/c3Ek0s3B+T3c0FY2aTC7P6g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyIGxy3bqyrC6crbnJr5n70GKvLMU9uMSE4mBpV3uBghFYjP7Y1
 4f0fDluLuMUGupvOYi8D3e5VCoQMJVBuiPR5saXmUc5KwdCUzeVFctQ5+Yu4lZvUzAP4tArrdVf
 2i+PM8fX7vUzkGSsdqUiNsm0MkaEy9OinikJcxQhtAg/csIw8t1pN9iq4HI4K7kLG6GX/ah8=
X-Gm-Gg: ATEYQzxBefLoKt8BhobewsKJHM+nhxN0l8oxgmKLIaylc2czWMwWvNedqQVSL/3bVV0
 fe9E3ShhAo3OnViThhzRGZeI3j5p/Fz/AXalMfZzrcmzS6wSjInCDBOwPDD8yTM5B3uNaxRJlHh
 UyGurQ8rSWHZrBaGgD32Z6GzG1yHsx+6U94MF3Ure972CI/1ndIUxCX3YXjv6oyP74Tx+NOcKHB
 SBk2bH+h4Fx9QIgGFSBfiD+6ymd2TlpeshARZ5ep/r2XaP7YBcjPeM/e6U56SE6T2f+nIPLzYkX
 4JpQA/dyi7pVucB7QULFUNxkqQp3OKkR0BVLtw/rQoQ9NuWfrZD73GgAZIIzbhDWL8vtHpCCqxG
 EjwQ2WTHgJUPZtO8T2v93udAMRlNoOhDc0K5b7aLrrwqPGnyDYjjgTiyk5Qe01G+M/lxMN/mmyl
 BIMycE14I5D13q72rDrcRAfmTGuA/cq+ximRo=
X-Received: by 2002:ac8:5713:0:b0:509:49cf:cb07 with SMTP id
 d75a77b69052e-50b374b1806mr20881941cf.33.1773971137768; 
 Thu, 19 Mar 2026 18:45:37 -0700 (PDT)
X-Received: by 2002:ac8:5713:0:b0:509:49cf:cb07 with SMTP id
 d75a77b69052e-50b374b1806mr20881561cf.33.1773971137194; 
 Thu, 19 Mar 2026 18:45:37 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38bf9753c7dsm2623321fa.13.2026.03.19.18.45.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 18:45:34 -0700 (PDT)
Date: Fri, 20 Mar 2026 03:45:31 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jonathan Marek <jonathan@marek.ca>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Alexander Koskovich <akoskovich@pm.me>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH v3 4/4] drm/msm/dpu: fix video mode DSC INTF timing width
 calculation
Message-ID: <oihbfczsj5cg7qfjjt6jvyodjnjbezyrv6f32vmg444g5bx6ow@r54epj7ilsyt>
References: <20260319-dsi-rgb101010-support-v3-0-85b99df2d090@pm.me>
 <20260319-dsi-rgb101010-support-v3-4-85b99df2d090@pm.me>
 <1360a31d-669e-48df-a1be-f0af4a253cd7@linaro.org>
 <3gLK4s97giqqXagfHKhfiIHbfbl2snwfOj9dcTNGPUYi10w9-1EdATqzz1LPCVTpz4bLFYOm8u_Fl8PfC7t5yabows4UCzRKVwjraEWW6hc=@pm.me>
 <3f8763af-aad2-4d92-90c8-cfd290212503@linaro.org>
 <7fb9dd9d-13f9-7bba-93d1-08f42dd6ee38@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7fb9dd9d-13f9-7bba-93d1-08f42dd6ee38@marek.ca>
X-Proofpoint-GUID: XDcyFlMWAI4GNRf4jSaSV4aaI7GEFgFx
X-Proofpoint-ORIG-GUID: XDcyFlMWAI4GNRf4jSaSV4aaI7GEFgFx
X-Authority-Analysis: v=2.4 cv=ApTjHe9P c=1 sm=1 tr=0 ts=69bca6c2 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=KKAkSRfTAAAA:8
 a=SUsfgI6VF5ffP_QSSRUA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDAxMiBTYWx0ZWRfX07sX6UTZppp3
 vYx01iJ4CpovSdCpXGPbt6XVR8feQ2aiiBg7l84ZZ3f/s2goWWsrdPCQ8Sz7hDDOu6hAIcMtC6d
 ASCVFx6Rcm/wgm5TOXKf1d8D+8oVW7oxb1ye/hbujZ5APU8CBHvBAVKVJBZ4OtO1DYfO5yD+hRD
 MDEuCP3PfMbQqbwJyp0+SCQUH73JgXVIYZQmzNkI/PV+r43HkwaNZbAmdFnfOhs17jllWBQ3S+V
 MK9bOhXxGfTqb1Q/PuzJ8kRZqmSrqZCX1D+pT2U1Wy8ddQQ9TnZVLgFcl7ViVAwcubzlBTTCIGd
 gwv1ngFLtL27LDV7O1q0ZeFGPYUNiUI4ZX8GgwD7abF1+YnAY2CTiJ3vx3Gmqxd2EQSWu+hnUrH
 hggcdoNyYZSHjBMlBj88d12fPyGM+hEHeRrMK3io9LIEYA85PGzjavwoSTjrH085U+kfX3A+72v
 AMEERfGngzQT4ZTZ8jQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_04,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200012
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

On Thu, Mar 19, 2026 at 01:23:03PM -0400, Jonathan Marek wrote:
> On 3/19/26 10:54 AM, Neil Armstrong wrote:
> > On 3/19/26 15:40, Alexander Koskovich wrote:
> > > On Thursday, March 19th, 2026 at 10:13 AM, Neil Armstrong
> > > <neil.armstrong@linaro.org> wrote:
> > > 
> > > > Hi,
> > > > 
> > > > On 3/19/26 12:58, Alexander Koskovich wrote:
> > > > > Using bits_per_component * 3 as the divisor for the compressed INTF
> > > > > timing width produces constant FIFO errors for the BOE BF068MWM-TD0
> > > > > panel due to bits_per_component being 10 which results in a divisor
> > > > > of 30 instead of 24.
> > > > > 
> > > > > Regardless of the compression ratio and pixel depth, 24 bits of
> > > > > compressed data are transferred per pclk, so the divisor should
> > > > > always be 24.
> > > > 
> > > > Not true with widebus, specify why 24 and because DSI widebus is
> > > > not implemented yet.
> > > > 
> 
> DSI widebus is implemented, and always used when available. The adjustment
> for DSI widebus just doesn't happen in this function.
> 
> > > > > 
> > > > > Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> > > > > ---
> > > > >    drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c | 9 ++++-----
> > > > >    1 file changed, 4 insertions(+), 5 deletions(-)
> > > > > 
> > > > > diff --git
> > > > > a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> > > > > b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> > > > > index 0ba777bda253..5419ef0be137 100644
> > > > > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> > > > > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> > > > > @@ -122,19 +122,18 @@ static void drm_mode_to_intf_timing_params(
> > > > >        }
> > > > > 
> > > > >        /*
> > > > > -     * for DSI, if compression is enabled, then divide the
> > > > > horizonal active
> > > > > -     * timing parameters by compression ratio. bits of 3
> > > > > components(R/G/B)
> > > > > -     * is compressed into bits of 1 pixel.
> > > > > +     * For DSI, if DSC is enabled, 24 bits of compressed data are
> > > > > +     * transferred per pclk regardless of the source pixel depth.
> > > > >         */
> > > > >        if (phys_enc->hw_intf->cap->type != INTF_DP &&
> > > > > timing->compression_en) {
> > > > >            struct drm_dsc_config *dsc =
> > > > >                   dpu_encoder_get_dsc_config(phys_enc->parent);
> > > > > +
> > > > Drop this change
> > > > 
> > > > >            /*
> > > > >             * TODO: replace drm_dsc_get_bpp_int with logic to handle
> > > > >             * fractional part if there is fraction
> > > > >             */
> > > > > -        timing->width = timing->width * drm_dsc_get_bpp_int(dsc) /
> > > > > -                (dsc->bits_per_component * 3);
> > > > > +        timing->width = timing->width * drm_dsc_get_bpp_int(dsc) / 24;
> > > > 
> > > > It would be helpful to somehow show that 24 is 8 * 3, 8 being
> > > > the byte width and 3 the compression ratio.
> > > 
> > > Can you clarify what the 3 represents? My panel should have a 3.75:1
> > > compression
> > > ratio (30/8) so the final divisor of 24 would be wrong for my panel
> > > if its the
> > > compression ratio?
> > 
> > So my guess is that while the exact ratio on the DSI lanes is 3.75:1,
> > the ratio
> > used to calculate the INTF timings is 3, then the DSC encoder probably
> > does the
> > magic to feed 10bpp into a 3.75:1 ratio over the DSI lanes.
> > 
> 
> That's not how it works. INTF (which feeds DSI) is after DSC compression.
> 
> INTF timings are always in RGB888 (24-bit) units. Ignoring widebus details,
> the INTF timing should match what is programmed on the DSI side (hdisplay,
> which is calculated as bytes per line / 3).
> 
> (fwiw, the current "timing->width = ..." calculation here blames to me, but
> what I wrote originally was just "timing->width = timing->width / 3" with a
> comment about being incomplete.)
> 
Okay. After reading the docs (sorry, it took a while).

- When widebus is not enabled, the transfer is always 24 bit of
  compressed data. Thus if it is not in play, pclk and timing->width
  should be scaled by source_pixel_depth / compression_ratio / 24. In
  case of the code it is 'drm_dsc_get_bpp_int(dsc) / 24'.

  For RGB101010 / 8bpp DSC this should result in the PCLK being lowered
  by the factor of 3 (= 24 / (30 / 3.75))

- When widebus is in play (MDSS 6.x+, DSI 2.4+), the transfer takes
  more than 24 bits. In this case the PCLK and timing->width should be
  scaled exactly by the DSC compression ratio, which is
  'drm_dsc_get_bpp_int(dsc) / (3 * dsc->bits_per_component).

So, this piece of code needs to be adjusted to check for the widebus
being enabled or not.

> > In dsi_adjust_pclk_for_compression, the pclk is adjusted to take in
> > account bits_per_component,
> > so I presume the actual DSI pclk _is_  timing->width *
> > drm_dsc_get_bpp_int(dsc) / (dsc->bits_per_component * 3),
> > which is your 3.75:1, but the INTF needs to generate timing->width *
> > drm_dsc_get_bpp_int(dsc) / (8 * 3) pixels
> > to the DSC encoder which will emit timing->width *
> > drm_dsc_get_bpp_int(dsc) / (dsc->bits_per_component * 3) pixels.
> > 
> 
> The hdisplay calculation in dsi_adjust_pclk_for_compression (which only
> affects the clock rate) seems to be wrong, and I think Alexander's panel
> must be running at a 20% lower clock because of it. dsi_timing_setup has the
> right hdisplay adjustment.

That function also needs to be adjusted accordingly. I think only the
dsi_timing_setup() is correct at this point. Note, widebus / not-widebus
cases should be handled separately.

> > In any case, 24 _is_ 3 * 8, 3 being the DSC compression ratio on the
> > INTF side.

In this case DSC compression ratio is 3.75, so it's not true.

-- 
With best wishes
Dmitry
