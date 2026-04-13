Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F617F34C53
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 13:59:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB24A10E491;
	Mon, 13 Apr 2026 13:59:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aPv4BJzO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MKE/Fz5O";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7970010E489
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 13:59:49 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63DAq3k12786424
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 13:59:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YP3tCk9uVMWJEI0cAi2Nc0h4779GkjDFyYbRspyGl48=; b=aPv4BJzO4sBCgjWE
 wJoI/xN0WZnbOmf2ndTeI87Y184qN16qzzpA4EhIuU5JFRVslR6LAJ/wAg3lgvfm
 6uZGnS7wZNnX55+RFw760eX1KYDYWsfZQ4uyEIwCh2CEW+bFfg9W0TYSqVo0bNPQ
 lqLuBg5IGbNjmnoDyhx43+u07bA65KIdNjWWB0Dd+3QdJaog93m48vXP9WHY9ndQ
 +8ZMTkAfEZ5MiDBMkLHGezEHRsHMOkZ9Nvnz2R3//N8z5RtDzn+eKs2eKGgxAXoE
 D0BoLIh3qts5Ni1uFVUWTXxElWTpsUZu/h+nu/Q1cveXkMKsYXVmpw6yO+J6OqCi
 4AW4tQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfjbpd93v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 13:59:48 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50b44f7b7bbso104673441cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 06:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776088787; x=1776693587;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YP3tCk9uVMWJEI0cAi2Nc0h4779GkjDFyYbRspyGl48=;
 b=MKE/Fz5OiOcP5i5aRclcLeZNiTsskRutajL1YjxwJpA1ohbB3VdOU/ipk41XXIyf6k
 U94z6vXjd1Ntsl3+gzBCmeaKGMPqyV7HmiKDVyxdGYndcLBRkRqLKnX+bYQJjLLHrw8N
 KcgV3cp88IoXHDgWnZRzhXPmEMLWIpuYnbZZet0V96ZgAx2TYo7RrtN8hfBQaKI+e/AT
 hie4UUNjz/AWrVXcyMhts/UylF8St4O8eWknTih22bvjRLDVqbv6W7aVmuQXFr/wu4/H
 GzGfXPESZCObZIZB7V3iGuAj6s/3ORLiEBVHUiFwvKfyskMqHPKBYF87LsnsVr0hwLL8
 jPNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776088787; x=1776693587;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YP3tCk9uVMWJEI0cAi2Nc0h4779GkjDFyYbRspyGl48=;
 b=hbQHyTi0icJVmyWJhncGmGEyM267vlCGyT71YaaQ49dukix9HVdA3J8fJIGKSTgbNP
 8qR1ax5lnHU1rxjwpb6wh71q3YtjyRG/4VnUPoXg3hWEgjjFTs5cgkMmYf3ZoKF2nuVR
 1R7v0p/NSK9DfzNWMqCg9mtbabmsA4D3T0CQpN3kJmYvFPUwh1fox2Yeyl14iaTWGaPY
 HW16CkYo88XgnmiBkUYwzkrDcTALlSVHgKR8N8uBMNGGGUnnJKFniXpzu31Jf0qzFr2Y
 R80YopcaeVu8c6tPG1qwDVWKIa9CvZQ+vlUESiNTjjoQnsQUydxXqfK5o2Q3dMuVEyXf
 orjg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/gMrb6m246MfCzs6oEAAGKAQpNm+uqexVh4fNooHlMekWCMRldZLUCVP9NcKNLzbCRX5dR3DM8Dqg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzo9uBHLJLhwQLh9R3XJQrQLIDDXF+x93wIHipnSSu8VsXrojX6
 SmXfELp4Vu8cCLVchalq5dM7iFx54qXHxFNoYfHrpbIiDVg1N4Q/gd9e8EKPXxYDKlyiocGEwkI
 Gb+POcnDfkm4EaTibm7HFvgZpdcvLOb+4mDnGRS3in+1/jTZJWjxK9PhuNcvvDKSr9gR4z0c=
X-Gm-Gg: AeBDiev/Wt/LhN7l8vR+HGVckT46O9ZHw8LI/QRuCdkzfLkU5ZnpJADF8moPLwtbJhw
 kyVeMNHA3CKKsbPEUqSpY2/+Q5lYvQHPZ3UtTfsvDcMHmMzGj/H5iL0pF0XVURDJd+TPRc6ygFe
 AfZJOoiWR8BV6sKR2pSeo8HrkTUjgPzQ5oh1IC/3ACdHrl+ECobROhKEGoBFB2I8nd9ESd1pVNQ
 HoMuQ0f4hIQBQ4t9E+be9EiCF7iAYhsdqy8S6iKKQ9p3NIuTIR99GsoJcKEA5msfCWCr9dmBjKR
 9JOVHh6qxCLI3L+QMg9Eqz6ZXW3bwwcUIKLA3Hi2E+MoP3EPcKWJVTtUU0LI+tLF46cz/3w2tev
 LTVDIkp+qYCr0y2MR6pqjD9bkp2du2Llk8la6SSPadN0yBJehGtGORGDAfB8aGXTIDX3fFooyJ7
 WHF90MwHmPb2tlPTlLeeL2tXtm8D1EJZuxZCE=
X-Received: by 2002:a05:622a:40c3:b0:50d:8050:a358 with SMTP id
 d75a77b69052e-50dd5bc32edmr180026131cf.47.1776088787101; 
 Mon, 13 Apr 2026 06:59:47 -0700 (PDT)
X-Received: by 2002:a05:622a:40c3:b0:50d:8050:a358 with SMTP id
 d75a77b69052e-50dd5bc32edmr180025641cf.47.1776088786538; 
 Mon, 13 Apr 2026 06:59:46 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38e83bc1b49sm3349781fa.40.2026.04.13.06.59.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 06:59:45 -0700 (PDT)
Date: Mon, 13 Apr 2026 16:59:43 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dave Airlie <airlied@redhat.com>,
 Jesse Barnes <jbarnes@virtuousgeek.org>, Eric Anholt <eric@anholt.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Chris Wilson <chris@chris-wilson.co.uk>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Mark Yacoub <markyacoub@google.com>, Sean Paul <seanpaul@google.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Simona Vetter <simona.vetter@ffwll.ch>
Subject: Re: [PATCH RFC 09/12] drm: Introduce drmm_connector_dp_init() with
 link training state properties
Message-ID: <bwgzwwlmvlbtnl7qnmnjrkzjaifeyrhllnbjxh7txrd2o24aqi@2ykn2gwyatcx>
References: <20260409-feat_link_cap-v1-0-7069e8199ce2@bootlin.com>
 <20260409-feat_link_cap-v1-9-7069e8199ce2@bootlin.com>
 <gmaxonri7y3k43pxsnxfnd23mydgrwsw2322v6m4yjoksqm7aj@4ehgvhzg2ubb>
 <20260413145930.140ba461@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260413145930.140ba461@kmaincent-XPS-13-7390>
X-Authority-Analysis: v=2.4 cv=PuijqQM3 c=1 sm=1 tr=0 ts=69dcf6d4 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=P-IC7800AAAA:8
 a=EUspDBNiAAAA:8 a=Z4SpDY1sp9IGsGPUEqoA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=dawVfQjAaf238kedN5IG:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: ktNouZBZBqtjZhx7TLmoyzdE_bZZVvgD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDEzNyBTYWx0ZWRfX8ri22tRn8QgI
 FdS+jGzQg38uZKkJeAdThKXHIWTwLFIUQuvLNJbkwR9MzxAUMHet+Rpzo3MKHwXanwebgOq5nJt
 0LFI0hMjQoyMB440B0ZcP31k0J7ysDGdyGkBQecc8CIytoJ2vYBlGksWUiYBr+9C252GRdZoTEx
 B3QCXd2B06oCVRkCjggzdwApwDn9bXq5JugYdw4lt2ocf8dnMC8vLdeZk0vUPYJgNgsFa4/c0pE
 CkIiRPZTlaDfeA965dibtYtEgP6mBSWjVHgim4RtQj6H0NAC8fwkIv8RFWhhbwI49D0HFWoFbAc
 sNG92PrpSGmJunrVJwai4nLFtDiR5rRJxnWZcrqqwRMwHm4YKGpGoIcWWT/rw3MULmK6XM0mwqT
 K7dLyEzNhBK7+Jws5sVK1QUFugUrOPH09zuNX8z7da+OZ/C5RKeNPGz+C55TAp4aE+lrmjRrNLx
 1sysXWA4sSnC34KCcpA==
X-Proofpoint-GUID: ktNouZBZBqtjZhx7TLmoyzdE_bZZVvgD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130137
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

On Mon, Apr 13, 2026 at 02:59:30PM +0200, Kory Maincent wrote:
> On Fri, 10 Apr 2026 00:53:08 +0300
> Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> wrote:
> 
> > On Thu, Apr 09, 2026 at 07:08:25PM +0200, Kory Maincent wrote:
> > > Add a managed DisplayPort connector initialization helper,
> > > drmm_connector_dp_init(), modeled after the existing HDMI counterpart
> > > drmm_connector_hdmi_init(). Cleanup is handled automatically via a
> > > DRM-managed action.
> > > 
> > > The helper creates the following immutable connector properties to expose
> > > DP link training capabilities and state to userspace:
> > > 
> > >   - num_lanes: bitmask of supported lane counts (1, 2, 4)
> > >   - link_rate: Array of supported link rates.
> > >   - dsc_en: Display Stream Compression supported
> > >   - voltage_swingN: per-lane voltage swing level bitmask
> > >   - pre-emphasisN: per-lane pre-emphasis level bitmask
> > > 
> > > Link rates are passed by the driver in deca-kbps, following the DRM
> > > convention, but exposed to userspace in kbps for clarity.
> > > 
> > > Two additional helpers are provided to update and reset those properties
> > > at runtime:
> > >   - drm_connector_dp_set_link_train_properties()
> > >   - drm_connector_dp_reset_link_train_properties()
> > > 
> 
> ...
> 
> > > +/**
> > > + * struct drm_connector_dp_link_train - DRM DisplayPort link training
> > > + * information report
> > > + */
> > > +struct drm_connector_dp_link_train {  
> > 
> > THese define the current DP state. As such, they definitely make sense
> > to be a part of the drm_connector.
> > > +	/**
> > > +	 * @nlanes: The number of lanes used
> > > +	 */
> > > +	u8 nlanes;
> > > +
> > > +	/**
> > > +	 * @rates: Link rate value selected in deca-kbps
> > > +	 */
> > > +	u32 rate;
> > > +
> > > +	/**
> > > +	 * @dsc: Display Stream Compression enabled
> > > +	 */
> > > +	bool dsc_en;
> > > +
> > > +	/**
> > > +	 * @v_swings: Array listing the bitmask voltage swing level per
> > > lanes
> > > +	 */
> > > +	u8 v_swing[4];
> > > +
> > > +	/**
> > > +	 * @pre_emph: Array listing the bitmask pre-emphasis level per
> > > lanes
> > > +	 */
> > > +	u8 pre_emph[4];  
> > 
> > Please consider following struct phy_configure_opts_dp (or using it as
> > is). Overall, please refer the talk and (more important) the lightning
> > resumee at this XDC. I have some bits and pieces ready in spite of that
> > proposal, but I didn't have time to finish it.
> 
> I didn't know this phy_configure_opts_dp struct. This indeed could make sense
> to reuse and modify that structure for our needs.

Why would you want to modify it? It is an interface for the PHY drivers.
Is there anything that you miss there?

> About your XDC talk. What were the developments you were talking about? Could I
> have a look at them?

I've posted an RFC just before the XDC. Currently I'm looking at the
link training generification. Overall, you don't have to wait for that
job to be completed, just take some of the notes in account (like reuse
of the PHY config structures).

> 
> Regards,
> -- 
> Köry Maincent, Bootlin
> Embedded Linux and kernel engineering
> https://bootlin.com

-- 
With best wishes
Dmitry
