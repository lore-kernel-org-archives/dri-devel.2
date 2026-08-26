Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12BC0C5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 11:13:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2E4210E234;
	Wed, 26 Aug 2026 11:13:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oaJG160/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jPNIeIKm";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E8B310E234
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 11:13:50 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QAHra83649651
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 11:13:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=euIV9JhfpWCNoJWpkOFao7n7
 qZnXDvRXky5kFo/TpCU=; b=oaJG160/ENZlujEiOMs+77L/zH4cPim3JQr+plPo
 8L10+18mbxyfR5SXn6Ux52rMHXpGRDZsO20D54lbxzqBCm9xL+C8KUPXsfRNsOU2
 eTjNuHjR3H+8tcMt/yOKMJ7pm55i2wOJvDtQou8Gur5mvdyXQz4EtJomKKWlVGMO
 WvJNd9nu4Mw+brtyZGn+ipBr1nF+YVSbAWXZA1lFZQftKPdLN83PdbCIFS+YF+5Q
 4weqE9SDD5zgOnJC2wu6r1p01V/eInKGqb83Voq17S1yg5S3NMPt2ghKdqRC64Nf
 QEIFZI8RAs9f8LpouinksHJMYw16rr7pZf7Ke2e8koGmvA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9uthruer-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 11:13:49 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e63df032bso167916985a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 04:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787742829; x=1788347629;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=euIV9JhfpWCNoJWpkOFao7n7qZnXDvRXky5kFo/TpCU=;
 b=jPNIeIKm09LRVEwC9dqC0f38kes0NpsYnB5dNLrd19ajLbZqujvA/TGf1h2ZVEImT+
 Fy5s0S3kqfPvO53PYGwoey56uUYyIRZN1wVOZi7cYXZXr2iD7opK2QhgIwmrdqeTUpXM
 AN8Pecaj2BrkaxuWqPPMzBp3DOGI+AYXGmlEklbspN/MPA2GLCNAvSWusi6YHHwdHO5P
 hz2t2Pn1pU/oRz0vi4T18FqtR0psIgEI5kzEpbkD5R1sQdKrHD9re09V+yohM+Z4zsrt
 agEw1PyKAMHZXDMCh/TNY4sP5YnvyUbbouyAqTGxqOPD5aVqKdXRjbN0yzV7wm+NAxUL
 +ixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787742829; x=1788347629;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=euIV9JhfpWCNoJWpkOFao7n7qZnXDvRXky5kFo/TpCU=;
 b=TJZaxA9niLahtw5iOwnUMxM/XynQoWAbfbo3OUZH7+G5rW7uwk1ldyMLAdc/UbIKqu
 UZVwS/roWfNEPvLtKy20ie4A+GzBXoUUKyJqCFcOoR5RRNDhPGzglU6h3l3gK6TaFhDz
 JR8ae450wLVFowYic+vKJ/GRvbEmg1Rdu2pKqD/vbJBzLDhqfWiLcco/1vKQRFJZ8N++
 kWpxsMFDEeMOqJsudgXIC5kY6a0c6So8pjxBcZw9lm+Wwn/MKiTCID8vDcHpEtVHN98+
 qfNkryX9OURoJDIi/Ik91TKkK5DEHwhyXyiPoLlkMbesc86HDKJZvUaiMsO1MLG1UvCf
 ddWw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrI+pihPugLcjNYStN9briaPp21XClEkBX4SAGE5FFCwfasJAwrUAhdX53s2LHigcwbzyo7O65v9J0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nPl8fn8OMlFbIR1M1H/yA4WRyYXPoGkFRkJW+aPBHWsq3HMpAS
 hm90QDhNc/4ijLUckEBgFuI4VdDlaHDONwzBXKFKEXdw1wa3eOUpMx6fc6zR5FHpUokJ/NYZgVj
 biPetCtGT52GK89dJqm+hs7LzLNgttxWw4OuXpnEQ7F8qEcZp0lXl2UTPBDt5+d7PGWAN5pY=
X-Gm-Gg: AR+sD12xo/W1M+2vxTfWOGocysyPklmgeIpA6N3bC8G9O9CddoEEX1Tr1auDbUhKKIQ
 9EG28bnO6ICIq07IVFmLeB/9xXOyO3xSTtPbsiYtys7uxk7OLcMC5xb4gZ9B3/mrhZn+YV7RaY9
 nbHMXRaud5R4cCirat8sGKplK3qHj1RCwJT3t5ecGYBHqxanGrC7yb8AA5wf+aW3aWEG0v3OYdS
 1ZfzYJ4p2NlSLF9d3ULIHWhPFKRiYRH43zfG8IbtxReQhjqfDmH+S7Y+L82YFEul38GJcwv6kxq
 XoQDnST/uo2rTkTHo6G6bKSrCR03E97ezhzl27ZDyXvxlbPwGkyrpuNmws5pov2fLgUS8LvSsM8
 7c4nWN87yltb/
X-Received: by 2002:ac8:5dc7:0:b0:517:146d:2cb5 with SMTP id
 d75a77b69052e-52e2ed58474mr122045461cf.20.1787742828600; 
 Wed, 26 Aug 2026 04:13:48 -0700 (PDT)
X-Received: by 2002:ac8:5dc7:0:b0:517:146d:2cb5 with SMTP id
 d75a77b69052e-52e2ed58474mr122045101cf.20.1787742828038; 
 Wed, 26 Aug 2026 04:13:48 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.13])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a9b2817sm448707066b.53.2026.08.26.04.13.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 04:13:46 -0700 (PDT)
Date: Wed, 26 Aug 2026 14:13:44 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Junjie Cao <junjie.cao@linux.dev>, jesszhan0024@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
 mitltlatltl@gmail.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] drm/panel: Add Novatek NT36532 panel driver
Message-ID: <pwpccpcrackei3zuybgog64vhafzkqdgdnp377lygksp4w63nc@6zzxwzttqidl>
References: <20260804073419.84727-1-junjie.cao@linux.dev>
 <20260804074233.85629-1-junjie.cao@linux.dev>
 <b7cf1b71-874d-45ba-8779-0eedc0e21f73@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7cf1b71-874d-45ba-8779-0eedc0e21f73@linaro.org>
X-Authority-Analysis: v=2.4 cv=EMA2FVZC c=1 sm=1 tr=0 ts=6a8eca6d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=clBUptZa5v5FR042Ey+sjA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=1JJ5fdCZbPhp8c8Mo1gA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: tSXe8VPaJuqmZJ1rFnJwDgTKv3GZHBXR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA5MyBTYWx0ZWRfXzfyi4b40Y1C5
 WsCUPAMtS8AttFBFTQ9bJfLhiMRmsRReOdnMeiGFFGrmPdlvYcnj8bVFOrL83TCMuoVueTkFKc0
 QeVgSmCTQHle4LObd8Dz7jVJ1iqIX0igvAvnz0Sf0S+J8S4+xlIWf4n4Y2nBhuNkp3HXlLSWWek
 MuSuU+J27tgY+y68LuFVO4xwYALaHhxFR+/WLVqmbd4lF1/gZytSVWAFj+/1Kh0AVq85vL9GCoH
 VxCHeJf7stX+050gwgGxU8andH8N+gPZePUBrY+Ept4yF5AlllJtnAjsB8B8k0Jjilc0hIfpwM+
 bv4DvYL9cB9lxEWV/9znimtsWpwDqskXPAdCkk0tyDvR15qEyEoX/0JEwLHk6vd5Z3DqNfSc1pA
 JeK4/ogCeJmCdr7/zob6nJB24XA+LwqY0xxR/etonBukWG7qRpbfWUttiqfkXUnWZNfQhgYIDQk
 IcRr5+hdMwf37yjw4OQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA5MyBTYWx0ZWRfXw+VZG/21oyie
 fk84f5FVuaj5wp7urG+/6heX2y9YfL/H64/fuBhQ9asmnWm/YUDLMssETJ47Mdcwf/RpGKu5P7+
 Fjdro1FHMwelMsyh/t1DEy4Ddy92poo=
X-Proofpoint-GUID: tSXe8VPaJuqmZJ1rFnJwDgTKv3GZHBXR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260093
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

On 26-08-26 12:00:46, neil.armstrong@linaro.org wrote:
> On 8/4/26 09:42, Junjie Cao wrote:
> > Add a driver for panels using the Novatek NT36532 Display Driver IC,
> > including support for the CSOT PPC100HB1-1, found in the OnePlus Pad 2
> > tablets.
> > 
> > It has been tested on the OnePlus Pad 2: the panel comes up in its native
> > 3000x2120 mode at 120Hz over dual-DSI in bonded mode with DSC, and
> > displays a stable image.
> > 
> > Signed-off-by: Junjie Cao <junjie.cao@linux.dev>

[...]

> > +
> > +static struct mipi_dsi_driver nt36532_driver = {
> > +	.probe = nt36532_probe,
> > +	.driver = {
> > +		.name = "panel-novatek-nt36532",
> > +		.of_match_table = nt36532_of_match,
> > +	},
> > +};
> > +module_mipi_dsi_driver(nt36532_driver);
> > +
> > +MODULE_AUTHOR("Junjie Cao <junjie.cao@linux.dev>");
> > +MODULE_DESCRIPTION("DRM driver for Novatek NT36532 based MIPI DSI panels");
> > +MODULE_LICENSE("GPL");
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Please trim your replies.

Scrolling all the way down for an R-b tag is not fun. :-)
