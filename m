Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C68EC01D4
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 12:07:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DDE110E33D;
	Mon, 23 Mar 2026 12:07:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CmgghD6H";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I17JBmh8";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2DC710E23D
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 12:07:52 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62N6lDtX3871174
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 12:07:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cbKIFS+Pc1Tan8+I8NB9EeNeQknosIAeHFs0OOQ5r9M=; b=CmgghD6HusxlT1/O
 Aw4Rmj3Kct/fWZdgGJLNRqd5Q9ESLe+Rz7b/gahS9esZoG9DB4C170yfgJdWClMu
 O8/N+8xe7s+fCGPUY9fvPRbvjtD7otWdgL7Zkb5tGvS1vm2gTYbUwsk90Nru3rdX
 zNsQcchGxXUavm9+GHN4f/52c6l3y660GeeRl4NPBUskXxu7JSMcAgCJf4omAnji
 qom9taYTol05E+qGj3yIwKLm3fqFA5XJQcgUsi/wpXkzSOje+ZRfFaR7aIGdJHJC
 yZjY9YCBws7DTgho7yu1aWVl3umdlavHio/4uL4hbwdn0uoUyczdEqWwL6eEqMW4
 vhQDVg==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d1jwvnaau-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 12:07:51 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-56ce66c736bso248035e0c.2
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 05:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774267671; x=1774872471;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cbKIFS+Pc1Tan8+I8NB9EeNeQknosIAeHFs0OOQ5r9M=;
 b=I17JBmh8Vnj9C7c8pjV13hj3EY8lbLwEJsMC+I4fq/UNMLvRseNaOXizd+vEs9U75H
 0TQzb8PLpsSO+uuARUUP+azO6iY6UsZX9xcfHeumCjvQibNLZkw7qrmsoctmUT23wPx2
 VyLELHQRyniRkcLBmhoBNvP0iZW0zL/SVF7IMmd4UAh2/bebafU33FnW4th62N3gyjph
 PnLH7ukYMxTkF64HVE9QfA7Sj9aiMpPRzux33AEQMpCx6yZYobG0HMBJuEf0PmLrFU4E
 U9aLvjTOG6OtkP75KGhO0hlGb5qw904K/Mk/dpnIqzzDhfVQ6BuQLdHaCNOjLoYrk/Kf
 13dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774267671; x=1774872471;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cbKIFS+Pc1Tan8+I8NB9EeNeQknosIAeHFs0OOQ5r9M=;
 b=O6xu2GoLTEOFeaHvhWxIh6Gn/ylTEmnPKvrEGSOuFn+o7WC6vqismSnOcXL6c1CWHA
 vyO5F3FK+E4e2taURYTnS7MCK1m2k8hSXKaim5+qcGTpaknnG96v/fEq0pT6T24GFR2/
 4RBpEe80ZFojh0S6SBZMM9j+HBOZfO/P7WfYSqHiN3vEfEwXtE1g4E0e1fBTBKUSuO4P
 lr2CoTlm4v0IIpDq0XIJ0c6kPgVoCxPOElgNJMS9mZUXgRylr4HwLgyWEuYUV5E3yDWR
 9AobzPuZ7b87AkyFGBWiI4+4BImj2Dgrm42U/gMSdmr/DIDuqwwubYuKdttgu2BGPZ4J
 8JMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcNiaO6slMR5uNIroU/q6s8cs9MTqFNjDbxcX0RwdYrqNcCDVLNyy8+/HBwojGHxYZNaLmbUD1XRY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YydvDq2TdV56vyIQwlGct5QoTcX4OWLLUky7ae4GgPgFEBulDoA
 iNXVWXZInTLbsEWWxlkiCqiK07IrUpoDcea3Y8Wdws7ejLeNMzBJIrASqmy1/+l6cqN2/ERm//W
 4nsMIsg4VlIavevsTtAQL8fr+9Q06Fg6mKn4iiB+yDsA7wuVOCshB9xhgyx2uirqlgT+nvRQ=
X-Gm-Gg: ATEYQzxPo2kv0OeLYdgb+uM2udzl6KOfM6/c3lZWq8w7Y17e5tIxrtLpgtmJ1eErlwQ
 fZS40kL0acULQ9z2RWsZjasB6vsgUSyi2ZND3Ium0yc8uOX33rVrS+GmDGazZiLAyLeNTWy9f0S
 9FFMeQiV73l52uc1fVNkvgg4brlxbEyK/As4DunJV2VoAfn9Oc7ZZmVi37SedzcNZrtJTWRmXwc
 feqgUzE/j1XPmTE6z8B0pJQKdXcindzqwoguoOovxhXfy4Kara9OJzQ0eGArgTRxfEtKAEFnmSC
 mxPTjt24HAG/P9FAzU1NfECLwSrj7pO0Jt+omVgOKbuxGr9pe78o7TO2B7lEUcxW+kDhnl8fNT5
 9WSRy0bkm5bFkvT86YfO7J4PDMgV2uVguXdGkFgqYlvLOHg2uplE0hr/G2SX7jmRo/IUfBcGfeu
 HgpA0=
X-Received: by 2002:a05:6122:2218:b0:56a:9e65:3e30 with SMTP id
 71dfb90a1353d-56cde44e950mr3237481e0c.3.1774267671256; 
 Mon, 23 Mar 2026 05:07:51 -0700 (PDT)
X-Received: by 2002:a05:6122:2218:b0:56a:9e65:3e30 with SMTP id
 71dfb90a1353d-56cde44e950mr3237457e0c.3.1774267670762; 
 Mon, 23 Mar 2026 05:07:50 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9832f42c8fsm480101066b.9.2026.03.23.05.07.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2026 05:07:49 -0700 (PDT)
Message-ID: <2c8fcd53-a9d7-4278-9b08-fc8014714e01@oss.qualcomm.com>
Date: Mon, 23 Mar 2026 13:07:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/4] phy: qualcomm: add MSM8974 HDMI PHY support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-phy@lists.infradead.org,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20260319-fd-hdmi-phy-v6-0-cefc08a55470@oss.qualcomm.com>
 <20260319-fd-hdmi-phy-v6-4-cefc08a55470@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260319-fd-hdmi-phy-v6-4-cefc08a55470@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA5NCBTYWx0ZWRfX2EHUeHHuyAPD
 SusEkqrAcn2SOZsVUxJHNpaPrispQ9Tkfr7whf4pnULIwsb+ZYa5rB/YNRX++IsvKfw2hWvWM7r
 fyK7pDdBi08BUU62RgbVc9YJdSA+5hoMzWdxS3B/b1QgrcaaxwLLOhLj+S+jE0v13V+mTITeaxY
 g8yG7LWtRl18IAeM/ZFF/WmyRUK2PbKBXQAisLXtBU1WGpryichREYOJMaf7AtinSKFEOAQk4L+
 sMO09bkgzcIncXb8/Q+qymTRLVn0/Xa+uRYIalaiU52Hr13NSeBhMHQH0/coZjwrrW36CaZiY7e
 8u8IDApCRlR9GP9jNeIq/U0YBzI21B7Hh93V7G4IiEnow79YoUHbsCD2/ibDUEIiPYWp438664T
 QsI1yVMZDvmnYilF27/cuUTMZn4baWX8d6usNddtsg6SOWo/F6Im3gMY2oS+MqFB6GQDnQBpMNQ
 6/c1g/nn6MD6zhPz2BA==
X-Authority-Analysis: v=2.4 cv=bcdmkePB c=1 sm=1 tr=0 ts=69c12d17 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Eu74y9pB3kvqzmodUKoA:9 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: Aki2A_3ESgQL6fFKTcVG4fl65QznvOCv
X-Proofpoint-GUID: Aki2A_3ESgQL6fFKTcVG4fl65QznvOCv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230094
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

On 3/19/26 4:48 AM, Dmitry Baryshkov wrote:
> From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Add support for HDMI PHY on Qualcomm MSM8974 / APQ8074 platforms.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

I don't have much insight, but the code looks alright..

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
