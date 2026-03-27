Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B33310F2870
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 20:44:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FEDD10EECA;
	Fri, 27 Mar 2026 20:44:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aCTPrkcs";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Txg49pYw";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED44010EEF2
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 20:44:01 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62RI2R5s4030480
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 20:44:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZS7/E2sC1kaZB8E/dQAOcD4c7Mt+5yw7HMOSuN8HZGw=; b=aCTPrkcstZuf7IVs
 MTsiigd3Fq9L+zlA8Ceib+PDYGII/rDhLUGridApZwDV8OA6ked8ry19ldTz6ypW
 4ob0SsbkvLsO3svFvAWj4AafpMWvNyVQVauaNZtd4IY2+fiiMq+hj+W0nR92gyFu
 2iyi0BOHiwCA3yHl/w7IswBX/hftqL8nA1aM5Y+7JbrAG86ATMYxTsVj3UxxIwZE
 5tGOZjlzk/4kfkxER0pJzgl+TvrWaL8QI1kBFWJ+rLbm+V471SvuZlUhUQpIwtk2
 bqNYDMNsBTYQHUTAX9u3Cs+y+XF5tOjW7XigsHGVe/wM5p4jAgnEOOTQOuY65JCi
 tGKGXw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5v6b13sy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 20:44:01 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5093a985e21so19372501cf.3
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 13:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774644240; x=1775249040;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZS7/E2sC1kaZB8E/dQAOcD4c7Mt+5yw7HMOSuN8HZGw=;
 b=Txg49pYw77ZTCQVHQdIqB088xNwUYRLValAEBWRnIJOCDM/1HfEtYnrG1HLnXWmDhU
 eExlBGiwrKgetxuOTxkN7R5wAfTf2x5gYyN3X4AYnmhFZ0ieq2NrTOcoFX0y9NzgbUe5
 fMTLWr2+zbO+Wj1zovAUKtXH1/aPqfKenz9DGnoV7EsigEpEG5IpOk6cShEaP5wEcLDp
 5wS3bQwlK0bawZGyMYSdO5MFK0nx/Si8QYYiHmmfOV+V7D3NaHgRK/k4q7J6ozIxbv6z
 IQBOYSDFJZPkC+GztgwIGBz+hQ94xNeOlwh1dE1IEfvUs/J3cI6aOCrYXDpzMjgdMr3J
 cXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774644240; x=1775249040;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZS7/E2sC1kaZB8E/dQAOcD4c7Mt+5yw7HMOSuN8HZGw=;
 b=ib+gF3H+kM0di9ZiM4F414eM1t6aqCZcRAQe2/xTgTUNaXxljVa7jdPakQWVQQ9c6J
 hiTJOQLDH5HajBKYLgL45HVp1OznB4SF7+lM6L9Ci0Ct+/FTBBEa7hiAePaisWZEJoiZ
 GYf87/fkLyl2aSZjiLAwauAFJt2to7CcVDUUJYlGd9HIIEJoOhSUUf4XgyRIAkExnu8P
 IK2Fo7vHhu2Uqs/DD2YhoFaXyHO6TWgs8VhtJoRtmvDO3aDfu2Swns9TKIKZ1dM17gr3
 AayM6uiRXlAcnGb+quPPJswGqES6EU9xryJvEmIcBeAh7EAsfWBIkunDdO2xpq5Qn/og
 QHTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUG2edYFEsEAzmenem0xbzixBxclhRq+gITaPIXo/BuzOcYZjpGvqleH0lxh1jgifoMsZIHjy7XwFs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwQIzEIqI5YhcA4qt5FzCq74yNVylsHiYovb234GCMM0XM7mol8
 copJBm9sXr/LlFq+GOAuYoKOtMs/qInVyta+p9Hv/FGIBpKVAobWUjaRH+JUa8OQGFcf9Y+l2K3
 nsJ5P1nosyQKWbqJdEhKLlUlJmZYSjpkfGh/SqIilK/WfoE2a/9kdf3mbLvkiKDajmgmXPec=
X-Gm-Gg: ATEYQzx3gmst93bnE1LKwbrWjsqdiLz6JXDd2GxwhLAgaj+folnU89N5ILyE1qAmMcY
 Gt8blCeTkhpDS2IK+KrAGiPCZzrm8fIZSvM3aHm7Rgmho8S17pKtLLdhdVV/nAfn5gmTKKpdmFS
 DOJ/xAwtq35f3Qc0Tg2qLIUwNJ1IzfvslPnk1dgZBv830u69HJLv5U7Hs0N+AHJWjQ2WtJKV1SK
 DGKrZ9KrGp52Ie7ZCsYLHKepOs4Mjo1tRFPmE6WcFs4q4Fk6nEnU4D2XSbpm0GWKOb1E5YLTgDL
 CTndaFtwZ/L6ofWSgZj+a5my9ygI/hdF8eHcljwlrWuiS3VEm50D17bJTlOBf4X72XWf0gDS+an
 ngWSJDZoPr2winYTaT4UzsP+zaIdrqfm36B4h99ujfdGod8TeCY2UCrW7qrlbEVZv64qxV78dUD
 mauMsSEIQUfQop+kVl/UlrcG+8Vaw4jmVLVKA=
X-Received: by 2002:a05:622a:1ba6:b0:50b:3e64:9b29 with SMTP id
 d75a77b69052e-50ba3818239mr54281631cf.14.1774644240415; 
 Fri, 27 Mar 2026 13:44:00 -0700 (PDT)
X-Received: by 2002:a05:622a:1ba6:b0:50b:3e64:9b29 with SMTP id
 d75a77b69052e-50ba3818239mr54281181cf.14.1774644239833; 
 Fri, 27 Mar 2026 13:43:59 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2b13fd743sm14355e87.21.2026.03.27.13.43.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 13:43:58 -0700 (PDT)
Date: Fri, 27 Mar 2026 22:43:56 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Bryan O'Donoghue <bod@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Wangao Wang <wangao.wang@oss.qualcomm.com>
Subject: Re: [PATCH v4 3/9] media: iris: retrieve UBWC platform configuration
Message-ID: <zin7rmeaycp2ewrlc5sgwjomey3kspqknjbkij2g6ztnawukty@66vagyozrtxx>
References: <20260125-iris-ubwc-v4-0-1ff30644ac81@oss.qualcomm.com>
 <20260125-iris-ubwc-v4-3-1ff30644ac81@oss.qualcomm.com>
 <56860faf-3f74-daeb-3d19-a35243172317@oss.qualcomm.com>
 <cshlsxb4fj6piuxadtxvxl5rgnl4aljqqrojl5wkp5oew5ynxy@ah3eo4aexe5n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cshlsxb4fj6piuxadtxvxl5rgnl4aljqqrojl5wkp5oew5ynxy@ah3eo4aexe5n>
X-Proofpoint-GUID: uSRHLK-IkJkmFYFmSy9fArtPk5Ur8Xw4
X-Proofpoint-ORIG-GUID: uSRHLK-IkJkmFYFmSy9fArtPk5Ur8Xw4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDE0NSBTYWx0ZWRfX6FszyYpzv7IT
 xaEbP18u6yI5NHhzGkznOhrV14PsXePCQqC2tGw8NFSf5ov82RlX+5R267dZ1DVshmzyI0aIhcA
 2wrjoVCTyzZgNuZoHCN1cdTO81XKN/VOyLBV8aYrz2C7BqRG910B6XeC6Za2lxc11wv9Cf+7cIE
 OFgxAuwYSz4Ut/dDpDD/NyZWrC/2GQu5DMvS4J06pm7pVoe55E2aSiPxLrj98SNNbl0/wrJiv2e
 qYHzul30VQzuleBKd/HBAKpEOPE5NTOFPM6f7PQgbH/6StdqXH+lnBHU2EZ7D+JkDnuZaHNhUV3
 Xyu3DUC+NfjifBEoI/yK6kbwx1MEty1QL4QRlJw63cHBl4rvz5qn+iS/zeh4e2JATBiBqNw7/1S
 OQg/w+sZ4vn8ZpxFuqzoD6gcM4oT+rpL3yfS4j/jEMtYOi9D/capVwfbN+DPGKhuXhJNuLIRR44
 HiJ9GCEqH4lnbyI80cA==
X-Authority-Analysis: v=2.4 cv=JLs2csKb c=1 sm=1 tr=0 ts=69c6ec11 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=W6jageyznww4trKTX_sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603270145
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

On Fri, Mar 27, 2026 at 09:42:05PM +0200, Dmitry Baryshkov wrote:
> On Thu, Mar 26, 2026 at 10:36:05AM +0530, Dikshita Agarwal wrote:
> > 
> > 
> > On 1/25/2026 5:00 PM, Dmitry Baryshkov wrote:
> > > Specifying UBWC data in each driver doesn't scale and is prone to
> > > errors. Request UBWC data from the central database in preparation to
> > > using it through the rest of the driver.
> > > 
> > > Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> > > Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > > Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
> > > Tested-by: Wangao Wang <wangao.wang@oss.qualcomm.com>
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > > ---
> > >  drivers/media/platform/qcom/iris/Kconfig      | 1 +
> > >  drivers/media/platform/qcom/iris/iris_core.h  | 4 ++++
> > >  drivers/media/platform/qcom/iris/iris_probe.c | 5 +++++
> > >  3 files changed, 10 insertions(+)
> > > 
> > > @@ -244,6 +245,10 @@ static int iris_probe(struct platform_device *pdev)
> > >  
> > >  	core->iris_platform_data = of_device_get_match_data(core->dev);
> > >  
> > > +	core->ubwc_cfg = qcom_ubwc_config_get_data();
> > > +	if (IS_ERR(core->ubwc_cfg))
> > > +		return PTR_ERR(core->ubwc_cfg);
> > 
> > Afterthought: This change assumes that the presence of a UBWC config
> > implies Iris UBWC support. However, some platforms (e.g. qcm2290) do have
> > UBWC data defined at the SoC level but do not support UBWC in the video
> > firmware, which could potentially surface during SYS_INIT if UBWC is
> > advertised unconditionally, so this might be worth double‑checking.
> 
> No, this change implies that the lack of the UBWC config is an error for
> modern platforms (which it is anyway).

And that's not to mention that Iris doesn't support Agatti / QCM2290,
nor any other UBWC-less platform at this point. Those platforms will
need additional chagnes anyway, so you might as well include a patch to
skip sending UBWC-related packets in iris_hfi_gen2_packet_sys_init().

-- 
With best wishes
Dmitry
