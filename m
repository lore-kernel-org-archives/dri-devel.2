Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F91C88E64
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 23:58:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB21310EA82;
	Sun, 13 Sep 2026 23:58:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FkRM+T5s";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GCUcgYK0";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5CF010E1E7
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 23:58:08 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68DNYV713283868
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 23:58:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=FDBmdktdlLUHhDlg6uE58fcH
 cyrR9lGGu3jE4lq6oo8=; b=FkRM+T5sbuz1jXUjWOTE+kewEZ6RHwSJ9mZ4QqD9
 yiakrA8NhqWb8EUsreZp3Qi+ly3i5wWSVjcwqRHts0gw2fxY4YNDO8qMDLb/CTcg
 2RIMA2SimlmBlkl+H1hl71enAnp5vf1iv4EfvLTQAaacAVWWGK30llcslfK0b62B
 zSK5K+jTYIutCamRepU7rlDPZ/jIl7BtrDGeevzwcFDUd5UlO6ABh2284EzK9GfF
 EOK6Yd9ZnfrjnPJSCMyhOlQnjq+XAE4hqyOYYqTjhVqhnHWEwo5pmRmei1jg6Odn
 /Piq0KNwXAGYy1clYyBFFRepvL82/n3WvFdwTG/PsM9XnA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gp3hsr7f9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 23:58:07 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-790376c9f8cso665658137.1
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 16:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789343887; x=1789948687;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FDBmdktdlLUHhDlg6uE58fcHcyrR9lGGu3jE4lq6oo8=;
 b=GCUcgYK0iNKGm0bPS/kyG6gWX9zrvmDihvgWj4Kla1keJRIT9XR2XCsqCyrI6usrv/
 nqYqHUYvYgyunc0eHelsaKwPcEDU4XdKm8baQ8KPryg/r6P41fmulHDJYOjURmNvvhla
 ISgfBqViOHkCl2OBCmZfLiw+2IanTCbRddprjaveVw3IG1zCVF9JzTUQILx1ZMhTn7bp
 R9jS469HKquY/X6u/qQYxTDDYY09UI/vFlRVFi5YkMa+ZebRwsixI7LHmUONCqujca1I
 +VBQsCx60Xsy+HKFbzVkDyGh2B8m1fazBk6N8wDOFx2n4wh/cWEk8IjsEVfcsxm52yRB
 5Ttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789343887; x=1789948687;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FDBmdktdlLUHhDlg6uE58fcHcyrR9lGGu3jE4lq6oo8=;
 b=j1oZ1kQNyeE5dyrjmZ9utDnYO7JQkw8fOD7xwgsmhdGSuJhUChc8+bR2QzIPor7JSb
 8ueqkdKUeSnNbygzuHRRcrLaOv6cMu0Tw28lwEU3iLMYWeZlN+N81r7a2aWqqgyLbYUP
 /YNNZa4wiMtKnBarHEDBILDaC+KUhPaFg/3zOClU6BaA/KS7SC6T8kml4VDNAVc0AJQz
 Q+l9iPeM2MWMZxL+OpQFpDGjBfyMH9ZFB402XmyPOXxkaURKyJirSULzWoOs54FDYqy/
 cZx3d6S7S8/zxVkTVReneK3Gph4/i2UCCyuiZORX/pHXFcpCJxrzXKm2JopwxOlby6HV
 Y/Ig==
X-Forwarded-Encrypted: i=1;
 AKwUvBwOYxRzBpndyM2ZMe8A2I9c1+VueAUKoEANxGyrj6sfo1WPqfn/m/lCiZlvxOFEfAFbYDc3w1FAPoo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mr1+64K7Q3X5K1zDngXcKbWSjwkoVUNrUuVM/JXwGaKoNAATkL
 /2YHpzF1yq4GRXojy8vMreQ+EylC3A+yQjjzBvorgM25OsAu8S5J+GO/nbQ56554RJPDa2UQ2MW
 /h7hPoXnfBfE0hokEzEbz4AiUOoC7FwTKXnJjyal55aHzgzKvMfosisggFA4mkBnEUt2/qxSl9S
 bUrMQ=
X-Gm-Gg: AYBFou1Rhm8jXatkF+CfHUTTJuphoyFkjQMMhOl4GCIDwwPGlAPG/xlr9fMwZXLA4bi
 HeE6+7Gf45D5UCK6oMNlZbfWJ1t7Ticxmf0zgvihcsZ/JmDXwhfT6CD8kWubboAPmJYx1RfkANY
 7ut8JVup1VWBdhkKqa/3SvDcTo47Q/LKWf2VWzOqtikmn6H4pl+FTW09pERjQW1RVEuWJCpWaGS
 FcQOb9sEcR7xdr04txiUkwqvltb1ulFdLAl9L8Et97UtfPjwCyDLuk/6rdGiMbbrzmDdu1Qo2oF
 7N9VMZ89Z23rF1UiMvs1A1miAMbKeCeNJGjFBL9GW604ojMcsU6NWdaq3cHOhrUXjHHxYYC1zUf
 H6iGtJeOyDKfkCl0gK17xStssoM73cZ7qn3qc9ln/8Kn6qycLI3AozjiF6uvU/xqGCCKY52KDNn
 k68BSdTj+Cnwoc
X-Received: by 2002:a05:6102:149c:b0:791:8f69:b802 with SMTP id
 ada2fe7eead31-79b5992c78dmr36607137.7.1789343886587; 
 Sun, 13 Sep 2026 16:58:06 -0700 (PDT)
X-Received: by 2002:a05:6102:149c:b0:791:8f69:b802 with SMTP id
 ada2fe7eead31-79b5992c78dmr36574137.7.1789343886082; 
 Sun, 13 Sep 2026 16:58:06 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a5a33263c7sm21510611fa.21.2026.09.13.16.58.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 16:58:04 -0700 (PDT)
Date: Mon, 14 Sep 2026 02:58:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nabige Aala <nabige.aala@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org,
 Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
Subject: Re: [PATCH 07/17] phy: qcom: edp: Add Nord-specific register offsets
Message-ID: <t5thwekhz7wyhmyq3nobm37kag6n7ef2z2xpuwrqikv4aqniwc@ha2pjr32ecrp>
References: <20260911-nord-drv-dt-v1-0-e25c073cf1b6@oss.qualcomm.com>
 <20260911-nord-drv-dt-v1-7-e25c073cf1b6@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911-nord-drv-dt-v1-7-e25c073cf1b6@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDM0MyBTYWx0ZWRfXyF1w8MRHp0M3
 j3+9yu+jJN0y5l7u5Gd2EJ+Eyqh0yBsA3a17DOz+mkc5p2IzGsmPeDFA3V3Laa6E5sF4XSADfgv
 SzPbuliQ+Z3FFMqPbhL/TU/+AFJ5HBDDLQQVWJ5d3mVgoMkz0Ie/CykHBYCuXPSsu170wdylV60
 J6CfsaF8aqOMjZ96jr4OMXWq58VsdGjZw2bpgghSoXGH+Z7sIZ31F2XtY2tWZ4FKTay5nMTW8Xa
 dlNNUaMzyP3PirhYzuisIUgvJUE+dMoS77/RrgNcg4tzZC88gIXOg7PB+pkamG+gecjKQCU61l1
 d7cyNGxdvZ8zEkX6GUYy4da1kFM8noGTxNkGkT+OQqGTgse8i9haDczw/4jl3Ils0eUDJbbH5Eq
 N5H0laaom4JxFiicCEwuUDlP9wUZfEYaC36Y8hrhPNP4ratBkKgTs4tmzjg7k35cVK9IXTkPfwA
 HDXojAPuaVVy95csQ0Q==
X-Authority-Analysis: v=2.4 cv=IZwSymqa c=1 sm=1 tr=0 ts=6aa7388f cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=y1iHI6lx7uGyBqjubtwA:9 a=CjuIK1q_8ugA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: o0hJx1b40WQOMYh46gIr0vv8fPX1ZGu9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDM0MyBTYWx0ZWRfX+hHxrw43srWv
 TJ621RKDMphjDxEFhQtRzbkIB95VqLyqC3wZgkMcBVVeUaMvSbOtEeDb73qoF+x8cf9KzmSSEUI
 2i/DmtB3hAx2128FMxUVlGklR9yNPic=
X-Proofpoint-ORIG-GUID: o0hJx1b40WQOMYh46gIr0vv8fPX1ZGu9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_07,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609130343
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

On Fri, Sep 11, 2026 at 09:06:38PM +0530, Nabige Aala wrote:
> From: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
> 
> Nord relocates several DP PHY and QSERDES v8 COM registers relative
> to existing SoCs.  Add Nord-specific defines for the relocated and
> new-only registers in phy-qcom-qmp-qserdes-dp-com-v8.h and
> phy-qcom-edp.c so Nord sequences can reference them by name.

If the registers are reallocated it usually means that there are other
registers being inserted (or deleted). Are those the only registers
being changed?

> 
> Signed-off-by: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-edp.c                   | 10 ++++++++++
>  drivers/phy/qualcomm/phy-qcom-qmp-qserdes-dp-com-v8.h |  3 +++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
> index a3c893f72908..bf8a17336c7e 100644
> --- a/drivers/phy/qualcomm/phy-qcom-edp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-edp.c
> @@ -41,9 +41,19 @@
>  
>  #define DP_PHY_VCO_DIV                          0x0074
>  #define DP_PHY_TX0_TX1_LANE_CTL                 0x007c
> +/* Nord uses a different register layout; non-Nord value is 0x00a0 */
>  #define DP_PHY_TX2_TX3_LANE_CTL                 0x00a0
> +#define DP_PHY_TX2_TX3_LANE_CTL_NORD            0x00c0
>  
> +/* Nord uses a different register layout; non-Nord value is 0x00e0 */
>  #define DP_PHY_STATUS                           0x00e0
> +#define DP_PHY_STATUS_NORD                      0x0110
> +#define DP_PHY_LDO_CFG                          0x00f0

Why does it not have a _NORD suffix?

> +
> +/* Nord-specific TX lane registers */
> +#define DP_PHY_TX_LN0_DRV_LVL_NORD             0x00e4
> +#define DP_PHY_TX_LN1_DRV_LVL_NORD             0x00e8
> +#define TXn_TX_BAND_NORD                        0x0024
>  
>  /* LANE_TXn registers */
>  #define TXn_CLKBUF_ENABLE                       0x0000
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-dp-com-v8.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-dp-com-v8.h
> index 93edabb830af..008b17222a8d 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-dp-com-v8.h
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-dp-com-v8.h
> @@ -48,5 +48,8 @@
>  #define DP_QSERDES_V8_COM_CLK_FWD_CONFIG_1		0x2f4
>  #define DP_QSERDES_V8_COM_CMN_STATUS			0x314
>  #define DP_QSERDES_V8_COM_C_READY_STATUS		0x33c
> +#define DP_QSERDES_V8_COM_SVS_MODE_CLK_SEL_NORD		0x17c
> +#define DP_QSERDES_V8_COM_CMN_STATUS_NORD		0x1d0
> +#define DP_QSERDES_V8_COM_C_READY_STATUS_NORD		0x1f8
>  
>  #endif
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
