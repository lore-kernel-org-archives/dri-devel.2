Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F51FA1FDC
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 18:45:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4BDE10E2CF;
	Wed, 22 Apr 2026 18:45:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gly+Aqw1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f9veVw+p";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9071C10E2CF
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 18:45:13 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63MG3gPk1230202
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 18:45:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=bevnJjRIR73/p4aK2qiXUzUc
 Ji2lAQcMOYywjRN3VJg=; b=Gly+Aqw1ktxlqmAekdeaT0aoOilbxDOQJMJNvIku
 WnjOK37fWMqI0CUsQlGCr7o4iGowwRjp2ZUsrJ3MJKA9/xh2kvajNHaM1SXRT+yO
 NLz8sdGftAqTJdiJMvhPbUGcS7Lf1buXnuJJV1+kIeu5PtZOEcsHjUsYUSqDBCwv
 GVSiV+e2X3NIqXYDV5zPbBE6QWCFp9qC4KVBZTy8PgYw5ia2yJbgmeEDMIIR1PB9
 k4pvEW4E+p0FbKgrNNkO+cp2nMLRFL+QiblJvsZUu3qnGctMurjj5v8ag1zgnP2N
 FWoytfjLeQSPp7IeScn4Kas0pWGdfR+KQy9uycNbW0ydVg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq1h68jme-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 18:45:12 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50fae95c82cso21038851cf.2
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 11:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776883512; x=1777488312;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bevnJjRIR73/p4aK2qiXUzUcJi2lAQcMOYywjRN3VJg=;
 b=f9veVw+pQcd6IoBHwULfdINOtqKWF8cwwIbTyXHs5/MjQWI0tF3LOxG61qr/KwDEa7
 jXw0BDn5sbk4TrXBSIGoKkiQZXwa70OZ2pmUT7Le8XYpx9tjoJI74twYDNIJFUnrxJh9
 Xa4q9El3yVMZYesdoVwS3aDvDFHUc+oklPN7atpFAAN6Bic0qZTZoznUidiNItIfbCos
 FUoCIQcsC+0ZcpIPy8NO5pecNu/pxW7ECq277ESMN6U7JLTM9Tuc4djY881KOc98SzeX
 tRuXYz4mUIeu4W44M3ssNp9iV9dHDhCnHWtaD93nshFNcJDlZVLTzR4KaWR7p/5a/001
 J+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776883512; x=1777488312;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bevnJjRIR73/p4aK2qiXUzUcJi2lAQcMOYywjRN3VJg=;
 b=ZZfO8YXEFbM0rmJuopL1pn+/YZlLcLS0Qr8Kk9XwyGsq/tFAEPl1EFLUEQ0th4G93w
 T/Y490mFL+juGjg8/j9tyGSitXzv1C0QyogUPnr7igYpZ67zy0Q7nmgr1YROXw7opzFy
 jPIcqRAy9rKDpo0dG4zXSJljGwuqyrvBsmJWb+gO+krwUqFPPzr7DeEqYoyNrRk2auZ8
 NJOLMhIh9LXnwn+raMH1VKs2jgNR5ySei1RRiplFjuZvhDFthPE7i/dysHmbUF+FHQDG
 2g5JKV+OUwE9DYaSqFAuiKQNH5q/Z7q08Ts/UwYYGcJp+O5XbqpUECbXE4XZN+hy6hzc
 K4dw==
X-Forwarded-Encrypted: i=1;
 AFNElJ953hwg0tuyM8k9ljSMhaQVFo2UeYLZarCo2j7cyzIcPWUA+kXoofVzbmOYEazF9DHBJHMwETeAUZs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzqb41SUrILLNpeS6DqWqhErUFLqGQin5OHSa0Eklz+Tn6HKjJt
 g+qKnVNr4mRCAs2v+LICpn9hQz6zV+D77OymXupXqOCFPg1q74t6W7yvc0IZCr2Tq0hnAb3c2ew
 ymDaseYSfeGvdJnxR5U1G9swFvtNdqkFLzgME1r1DmNXM2a6WxGvBK9dbCmC3W3j1pn/xJHE=
X-Gm-Gg: AeBDievmyCRSOykDEsZ8RBUvte+xKzn3wE4tc06pgMy+0j/JOhXZ+ZrE7NtDOKjJSJy
 Kj5GocipZZiCpvnOSl5ClkP3hXrCjxUvaWy+v0pDmYKlnDP03Lb3KQUYXHKYpNfZDevYfhFYQMG
 laHRP/9QTCA+Uht8966gPuxKzBNAOVPIzA7mE9Idjek7w0Tb9aS5dyCSKR7AttNFf1Q2ErkvT25
 0AEMAwes3L77BLBg/qjkR9zMNsHwPZ5DNi3IT7e03m1PexLbHWgbo9gaw9stP1TKT041+2/muIn
 r8CyI4cmHukbpdeWqRd3QChrGssnVJwNoWOQquM6DDvE5DuyCKNowJsLbmplecwer51ro/I6k7K
 VuYm2cnV2yxdGB/XggoBn0ZABWeS7Ih0LDhmEwjPBx5oILKlidLjWxm6g5ExAy1zJB/InT1+vF/
 k6w5H/WT1gBx1grXjXHaAdlGdsEUAUM+vnL5P+wd0vJcK4XA==
X-Received: by 2002:a05:622a:5914:b0:50d:aa29:2b67 with SMTP id
 d75a77b69052e-50e36c748edmr360301761cf.49.1776883511833; 
 Wed, 22 Apr 2026 11:45:11 -0700 (PDT)
X-Received: by 2002:a05:622a:5914:b0:50d:aa29:2b67 with SMTP id
 d75a77b69052e-50e36c748edmr360300761cf.49.1776883511190; 
 Wed, 22 Apr 2026 11:45:11 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4187ebf9bsm4643342e87.81.2026.04.22.11.45.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 11:45:10 -0700 (PDT)
Date: Wed, 22 Apr 2026 21:45:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Biju <biju.das.au@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Subject: Re: [PATCH 3/3] drm: renesas: rz-du: Add support for RZ/G3L LVDS
 encoder
Message-ID: <j3w7jjnlms57kt75xrugj27wzielpnbl4j6imw45avi4bfi2p3@4l72u2ylswme>
References: <20260417175235.224809-1-biju.das.jz@bp.renesas.com>
 <20260417175235.224809-4-biju.das.jz@bp.renesas.com>
 <td55nrjrchomtatyx5phbojvjipwh64gnlnydqame5xakviafp@ixzaju2lnkpm>
 <9523bd97-2730-4b99-b3d0-6accc7622478@tuxon.dev>
 <m225f2xw3xkzacscycaifnc4hb3mv3o6ezaxjyhtphnjo5cfw3@6smswij3txnc>
 <d087c4f0-024d-480d-8711-5a47610b99b4@tuxon.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d087c4f0-024d-480d-8711-5a47610b99b4@tuxon.dev>
X-Authority-Analysis: v=2.4 cv=f4Z4wuyM c=1 sm=1 tr=0 ts=69e91738 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=yC-0_ovQAAAA:8
 a=ymOM-fvVj_9TNphksOoA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE4MiBTYWx0ZWRfX09uk9D/a9FDB
 FtP6co/+nz9+JWv3h0qR6HuQVnEfsLAUuhtctTOW+DQBhafr3DSR13db5aqeT6rmstFyhIdTXBF
 f6cWKGtNs16LsYscvkVMaQxBWsy9NKfJK9amUMcxJvFBrnlnFpYVQc/bnjLA5FqpzO33tPhtwyU
 DSdvYzy6+FrwlmAefjV0QmDnNXoArPuChB9W7Qx9K648Qt/Vc9TrKOS2ebWqcQjNATxcVVI+7z5
 ocAseVvgQphA+MBfgZHlD+d+bHGGO3kWiOOgqVHOqpPRPRI+ZIEg1JKkYQt5lz+yneOUYZ+RmQs
 zAIz9P7Ww9f+DdkASeHG8l0PDd0m/ge6Cw0/TCkcsxP2OWDkO6ky8N0MsppS5MUL8RPdR+7Dv1O
 FSdPU5s05/OCcHBdRU/CQ8iojMrXLAObrjzNH/YZE1QuTY961aqKtlnfThfsciaHNKHMn8O6Iyc
 0vBjbcHY+IKT2QfiLtw==
X-Proofpoint-GUID: Xl3-Ty4nHwI4qAMWBgaQKxIBRbPPXvqs
X-Proofpoint-ORIG-GUID: Xl3-Ty4nHwI4qAMWBgaQKxIBRbPPXvqs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220182
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

On Wed, Apr 22, 2026 at 11:55:37AM +0300, Claudiu Beznea wrote:
> 
> 
> On 4/21/26 14:22, Dmitry Baryshkov wrote:
> > On Tue, Apr 21, 2026 at 12:11:28PM +0300, Claudiu Beznea wrote:
> > > Hi,
> > > 
> > > On 4/19/26 18:58, Dmitry Baryshkov wrote:
> > > > On Fri, Apr 17, 2026 at 06:52:30PM +0100, Biju wrote:
> > > > > From: Biju Das <biju.das.jz@bp.renesas.com>
> > > > > 
> > > > > Add support for the RZ/G3L LVDS encoder driver. It operates in single-link
> > > > > mode with 4 lanes (Data) + 1 lane (Clock) and supports pixel clock rates
> > > > > from 25 to 87 MHz. The LVDS module cannot be used at the same time as
> > > > > MIPI-DSI. However, LVDS and the DSI interface share a peripheral clock and
> > > > > the MIPI_DSI_PRESET_N reset signal. Also, the MIPI_DSI_CMN_RSTB and
> > > > > MIPI_DSI_ARESET_N reset signals must be asserted before using the LVDS
> > > > > module.
> > > > > 
> > > > > Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > > > ---
> > > 
> > > [ ...]
> > > 
> > > > > +/* -----------------------------------------------------------------------------
> > > > > + * Bridge
> > > > > + */
> > > > > +static void rzg3l_lvds_atomic_enable(struct drm_bridge *bridge,
> > > > > +				     struct drm_atomic_state *state)
> > > > > +{
> > > > > +	struct rzg3l_lvds *lvds = bridge_to_rzg3l_lvds(bridge);
> > > > > +	const struct drm_bridge_state *bridge_state;
> > > > > +	int ret;
> > > > > +	u32 fmt;
> > > > > +
> > > > > +	/* Get the LVDS format from the bridge state. */
> > > > > +	bridge_state = drm_atomic_get_new_bridge_state(state, bridge);
> > > > > +	if (!bridge_state) {
> > > > > +		dev_err(lvds->dev, "failed to get bridge state\n");
> > > > > +		return;
> > > > > +	}
> > > > > +
> > > > > +	switch (bridge_state->output_bus_cfg.format) {
> > > > > +	case MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA:
> > > > > +		fmt = RZG3L_LVDS_MODE_JEIDA;
> > > > > +		break;
> > > > > +	case MEDIA_BUS_FMT_RGB888_1X7X4_SPWG:
> > > > > +		fmt = RZG3L_LVDS_MODE_VESA;
> > > > > +		break;
> > > > > +	default:
> > > > > +		fmt = RZG3L_LVDS_MODE_VESA;
> > > > > +		dev_warn(lvds->dev, "Unsupported bus fmt 0x%04x\n",
> > > > > +			 bridge_state->output_bus_cfg.format);
> > > > > +		break;
> > > > > +	}
> > > > > +
> > > > > +	ret = pm_runtime_resume_and_get(lvds->dev);
> > > > 
> > > > If this  fails for any reason, the atomic_disable() would still be
> > > > called and it will decrement the counter, potentially undeflowing it.
> > > > Consider switching to pm_runtime_get_sync(), which suits better here.
> > > 
> > > AFAIK, the clocks of this HW blocks have MSTOP functionality. HW manual of
> > > RZ/G3S [1] (should be the same for RZ/G3L as well) mentions the following in
> > > the chapter 41.2.1. "If the master accesses a module that has the clock
> > > stopped and the MSTOP bit set, a bus error will occur". [1]
> > > MSTOP is set though the clock enable/disable APIs.
> > > 
> > > The clocks on RZ/G3L are part of clock power domains. If the
> > > pm_runtime_resume_and_get() fails (or any runtime PM resume calls), the
> > > clocks will be off and MSTOP set. In this case, calling atomic_disable() or
> > > any API setting HW registers will lead to sync aborts.
> > 
> > Then you've identified a bug in the code. The atomic_enable() doesn't
> > fail, so for each enable there always will be an atomic_disable() call.
> > 
> 
> Is this something that should be solved by individual drivers providing
> struct drm_bridge_funcs to the upper layers or by the subsystem itself?
> 
> Accessing HW w/o its power being on (whatever power means here, e.g. clocks,
> resets, regulators) seems odd and may lead to critical failures.

The major problem is that atomic_enable() can't fail for the design
reasons. So, yes, currently this needs to be handled by the driver which
calls pm_resume in the atomic_enable() path.

> 
> On some Renesas SoCs this used to work previously but it is not anymore with
> the addition of the so called MSTOP functionality.
> 
> Thank you,
> Claudiu

-- 
With best wishes
Dmitry
