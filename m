Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80773C5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:28:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C884710F027;
	Wed, 12 Aug 2026 14:28:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oHmaryBQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hW0RFfaV";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6130010E411
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 14:28:57 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CDcBn73950935
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 14:28:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rRTRNjqnMuQmJhIBf/iDfReXyCTGBmAaSP7mRWJ3Hb0=; b=oHmaryBQeIzxliC/
 6lwV34HNXaETyWDqwvcSZbxwQC4GEPtqZqdmaNqv1wvs5vzzbRRaWokO21Wo5TXU
 XZNtWpeGD+CmDSZBVUPfSEKmIyvFrmsbQAORZdmZr7iYKhvaTG3BjbHZye+Wa4rj
 8YrPByIsDFPx3U2a+QzmMNUDEHE/GW/HS7qDyGiTy4uuotgnMrvjXUFlRKmgzdxR
 9CYdvT0wP7MAqMwQUHe3mwANF7FH80d4xWGzhwx2TV1/m6Da3E9GpKzwet6SGW0j
 xH77C+4rNCQpXDx0PmTTqQ17VTjCAgUgPIM4ecREDSZGLvT2nInW59/KmwvgGGxe
 NdciMQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0hj2tats-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 14:28:56 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52ce3c7cb2eso18241771cf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 07:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786544936; x=1787149736;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rRTRNjqnMuQmJhIBf/iDfReXyCTGBmAaSP7mRWJ3Hb0=;
 b=hW0RFfaVqd5IJO9QtOhjpfAjvQxdm4zvZr1Lrw7JK6sfJZpxJMDrlv+YJDoZEp5c+J
 xlKyN0ijKm2O9bP9bDSEhc0Gw1b3GWF4AtkzzO9T0f82U2KzB4j8A0jX+nmSStMd1rXj
 ECTAw/xIlBps/myYIfp499yWHZ1yxREmyn5GgAaeIITV4/KmSe5zR9wkzvkTqDq7bs/x
 QoawZo2NajwVfP2+uTBp1jIbA9Ziu9nUr+4IrPFRvKgRdK/JohkCEmtn4o6JeKYCXAYj
 Ql+VK2OfrCcYkAkBp1z6ZnXCC2oBMKpxCXA2rtxEc8IGKhlhIL1OP8IYJERkb3Z7P88J
 Pf3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786544936; x=1787149736;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rRTRNjqnMuQmJhIBf/iDfReXyCTGBmAaSP7mRWJ3Hb0=;
 b=VmNuq6WUnY16bMHft3q+nyIUmyD5h+X+OZEUNc/N96lDrwvvlaf13Ss7kclszkxxFz
 fDpRYgMkz9E8bAZXafCmAzwTbQfWQDCFD8YAMT/dHUar292YVw5n6nAIoAkwYk5KaqN0
 Hix8Ki5oQxAmu8jMoxO0HqHD4F1bW3ZvigdcLUOLlu+XNmr+TqBscaZc1O82IY/FSJnV
 VAGY3Q6Y/EI/Dxe+pDnjukHafQYeQPJ0Vjrm9pYplT10nxbbxPdm/J7/bsZ+gYndO0LU
 XcemyTqtGmwgVHp4aXBniQZBNYc4oJ2IAAQX0V8NPvPD3ffaKm+x7yPR7zoLqMfqZjSy
 7ENg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqtjpIXNWoAl+kixpc1spHgIrGJBBkdzXUiyTXCurUhcG1RlF37oFo764flpAijsjba1V/kbNHXyUc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzlm/SCS9HChZUxvNYjbkslbXuo9NPEUjjqYnWKYFi4PAkrBUlD
 AsgBWlDCqbT+Skgfi74AuUgBEzD4DU+MlRLMAqklL9o5j7Dgw0RlIL+yuOXoXy5dHJ7QL94Lc9R
 EBoFYdbWPph4jzhavJOfIfFiMcuVlGu+ijrwpvTKCg/0kHCiXlKeokJhgrbLNvaDFo0XXMeo=
X-Gm-Gg: AR+sD10BpaqWfNF62N763aMLASiQZxfV7LZqgcZnmhS5Re5vc4JThee2xwXnGQ2V5w6
 ZRyZSDC9dRi1+r7j49cNXLm80QTE0j/WGVba41vBa/zvRRYeV7lMbClehy0dKuSq1jVUVzQL/Qh
 +V0aVJtS1LyR0VGUYLx/JroHiSV+Kuc18siw1iPk84+X0y02iUOMhtCimQs5Qb8CSowSpVCGAcs
 Hs3gIeROjCmf0sukafNrop5WETDYZqiwmIHFKGjw4PnNoqeLHUU8GPzKXjg7f148s/zkcHNKKWF
 ozNd+K4gW5pQ2wWRHlzbcrulWrKv2Y13HyPhf0MCr8FY10DZz6NREqgDDTDBcfKNLOI5nyQE3m9
 AhsEIBoBNFcCrrJ56TM+3wP9XwCArFeAr6CA5fwvBuRNeJhAXQfwBWLL/0aHQVmvmH/ESZl4DIZ
 wscIIiaNPQeE57
X-Received: by 2002:a05:622a:4d8e:b0:51c:257c:8166 with SMTP id
 d75a77b69052e-52d6482e3d6mr47451131cf.33.1786544935645; 
 Wed, 12 Aug 2026 07:28:55 -0700 (PDT)
X-Received: by 2002:a05:622a:4d8e:b0:51c:257c:8166 with SMTP id
 d75a77b69052e-52d6482e3d6mr47448981cf.33.1786544933971; 
 Wed, 12 Aug 2026 07:28:53 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a107d20977sm5067671fa.15.2026.08.12.07.28.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 07:28:52 -0700 (PDT)
Date: Wed, 12 Aug 2026 17:28:50 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-phy@lists.infradead.org
Subject: Re: [PATCH v9 2/5] phy: qualcomm: hdmi-28lpm: provide dynamic
 configuration
Message-ID: <w6mq6a63mjzhjirvvgetcdptutkq3upa5v5kmdcezjke6rhkm3@lctdutlbnbud>
References: <20260513-fd-hdmi-phy-v9-0-ca98c72f1f9f@oss.qualcomm.com>
 <20260513-fd-hdmi-phy-v9-2-ca98c72f1f9f@oss.qualcomm.com>
 <qxuzipnza3tzoig7xp3653vcqwgubf6zerzbgdmx5h6acof7zm@quy7xzjml7kn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <qxuzipnza3tzoig7xp3653vcqwgubf6zerzbgdmx5h6acof7zm@quy7xzjml7kn>
X-Authority-Analysis: v=2.4 cv=a8EAM0SF c=1 sm=1 tr=0 ts=6a7c8328 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=eL-OflJxe-d9IbCPJmsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: nTz1-XIx-p1x_sAEeoEwBlwgNHFm5xOM
X-Proofpoint-GUID: nTz1-XIx-p1x_sAEeoEwBlwgNHFm5xOM
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDExOCBTYWx0ZWRfX6G93n0CNpYAl
 Rn+/WyDWOVSP2u/BAlQzW+MMq3pr3E/OvPLN6e8H3KLgFeWyjMTXyZYrbMQLRUn6kd0OiXKUEWr
 zqi6JldKVMD0zQQQnTMmYg6BfJfbr1I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDExOCBTYWx0ZWRfX0Vy8Zd8V9HRC
 yZH/WxG/u1wSiEDU1JFz0EDczmPTG9jj25WIpKChCr62Jj6BHgRCN0O2pfiBDOg0CY4/F9zZkZy
 xuqJtTxcnm0Qwlg5gtbCotqIcc8UIvYfeKjdLPFvsLowNwXXaMGFcZzI+PhLl8Ac1Cep6nWA+hi
 W+1Alr+qCx6Nzp6eHgxmI7cyljevZPQZTVMvn840st2LSotrZuS6SyNiRtRTf5/yAyNUFOWa/1/
 lIIF3LGXZpUy/Ci0yGSNvwAzj32OYE038du8Qaz2r495nnAZycswQQEhSgCou6qFL43g7hkKvt+
 G5yYXNA/MqRUp1IbgQhoL6qJcHlajCirbtnx4uAJIX81eYVXaD4GjIu//Z+G3WypqIHZHGROlb5
 OB7WbKQyfnUY0RWXnxTe29uk+89rKr6Eby/8PfucFFtR6TThU+L7ZjaIM1MddO3nBSItvgjYTix
 lrPUyOpMSYpWwV1EFeg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120118
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

On Wed, Aug 12, 2026 at 03:51:16PM +0200, Manivannan Sadhasivam wrote:
> On Wed, May 13, 2026 at 09:14:05PM +0300, Dmitry Baryshkov wrote:
> > Replace fixed value configuration tables with the values calculated at
> > the runtime. In some cases the values might differ from the original
> > values. Those were validated on the IFC6410 board.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> 
> One nit below. With that fixed,
> 
> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> > ---
> >  drivers/phy/qualcomm/phy-qcom-hdmi-28lpm.c | 325 +++++++++--------------------
> >  1 file changed, 104 insertions(+), 221 deletions(-)
> > 
> > -static const struct pll_rate *qcom_hdmi_8960_pll_find_rate(unsigned long rate)
> > +static inline void write16(u16 val, void __iomem *reg)
> 
> No 'inline' keyword in .c files please.

Why?

> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்

-- 
With best wishes
Dmitry
