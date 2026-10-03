Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20056CA5FDD
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 00:20:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C28410E6EE;
	Sat,  3 Oct 2026 00:20:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CLF+z5tS";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RxqKTEGu";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E00610E6EE
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 00:20:26 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692NeJnw2309789
 for <dri-devel@lists.freedesktop.org>; Sat, 3 Oct 2026 00:20:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=f2ZdA70TwBLUT8+duBJwyLHt
 iJMHfNP6ZQ0iT51JS3k=; b=CLF+z5tSG0fKu2HioWxaPqDeh3Mln78SV/in48ax
 59WAlfgsZjRosxCu/HfQF/FucwjhB3iBYU+U6amzIdYX7K39kSfWBnENCoyzaDnV
 +wto62eJt4yIBp+Ei0bPv061uxCqikYJ1GaA1PagTbhoFq9MnzVwvjRE2e/EP62C
 8eadC1gery4fq+4QZfzmftS/M1Z6GxWv4hISIpxl6rBMQ16Oq9cg2eyIOJoAlc5j
 n+ajfsEBq1LhDepxjD779NM1lWUFxpoNrEikx9MxzuYdUXhOCvSa9V21VnaXY0ct
 JtYnvpi4JN/k2R5pUARqD8+YSyOs854V+/zxw1ui8egndw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2f3da1vv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 00:20:25 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93ca9b53afaso32086285a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 17:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790986825; x=1791591625;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=f2ZdA70TwBLUT8+duBJwyLHtiJMHfNP6ZQ0iT51JS3k=;
 b=RxqKTEGu8Mgn/Pu4F4yirpqdjvN0SC554E+hCghIL7knpzVGlTwS3PjUc76F3x8slx
 gHhJZ138ZUFiHrRkCkjRvny0ln/4dceMLavwOeHSP73NpHhdYj0qtsSghsuVkP7bgwXm
 aUw2bwNUiGscaJLRsT4uPjcwvDl57w/tIEn1bC3VbZmtdejMr5w0LGR+2vs4VcG7cce3
 kfxKZ/GuMHMdgS8PgKVTmCtTqVjKkkE8hu9MFI9cBapeXnKu8rVTuIIGW36hLqmDtAwE
 vSStZBFlLne2Bcnl6f8PqSKti9CaU8yQ0gOtztkSgs1mzou6VqtJaB6GrpBeWDCbV0i+
 bt7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790986825; x=1791591625;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=f2ZdA70TwBLUT8+duBJwyLHtiJMHfNP6ZQ0iT51JS3k=;
 b=PKy868XAC+TriKZa/TRVQHLR4JLiepNs9KL4r2xbt9oN62v2NS5s7EZwlQpLoA/Ews
 O8BCsv7np/AxAH+o+BaXixjeL99yYaPV6HXCgcsB4jeFcQ5+W+KuYoUL9c3PV7pTEe1V
 F7hY1Sot1oqhWwFUzKp1/y5cxFT2Xnf+X+576iDbp1U09Rkz8+TcgPSXhv6DI+Yqzd3d
 05WNxuhWI/px8lY4fDOrBhUSUSOadcnwxinYLg1NMJxtTyCW5edt1MRUNoU1lcNfoljB
 NGfB8EM6MQDFbfze1SAvpTK/RU3ej3c5tC69rVvY4Ww0TzT1oc8NB5EWsgbDV01Wf8Kn
 8xAg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx6hfZzgf1Nau09mGoMShL2KkR+iOG6JziyBvXxytX6bG8HIWLUXTWZX9uH64wbR3kcxGkhW/hqrE8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k2ry2Cy2CBcm+JwD+U005bJUrSdg6spEiMhxS/9ERytcTr28ic
 9/ZpsQEtUaas1hc5rgs+r5Ec+GtCWet5P8jr3fRlPTil07nStZW7NGCiJEyVTXTJPtH3lSwbNlH
 uQa1P0bf8mfss9zMFWEOSOAl5ywAQaUjrVnrUOynlxXLrFIvj8pj4zP7sAc+ItrSDZw15r3g=
X-Gm-Gg: AYBFou1Vk0b8bqQt6uJRZ+jxZpVb2k47okT4c0tKmcVg4KnTcIeDZnOWmLgG+bAiwTC
 F1ymPjRGk2/fqgjQdFWjM/WAitxoyCCppLw/qc8T/jXmArVSYZ7zhuqEzdj7rLiln7CWMbDyOuM
 FFdmBvcRzK1Kmeg3mCRGJBtn87Jl2qpYDrZpiYmjhlYsuICG5QlNzgTI8kprHhE9M+rDv4ielqC
 PiXwwJ7J0jufxbX5M5Z9qRPxKSEg5pIzoasb0YRUR3Sg3Z4a4uYKN0ic0lTvUh03A/AAeSYNHqd
 6KELMB6D3TMPKBvSYMjTKSmKo62NVxBhD3hfCS1QSt4sRSFp2R1dCXwx/oNmSZZr6khaU1ewORR
 wxEZ/NCBc5hLNk/TlfpPCX5Wzv2V6HYR0YPgJxqR4x3N/6iYnUNONMLpn9DvD26Pb+dsR2OBxmj
 aHR4CxQlrzhzip
X-Received: by 2002:a05:620a:4113:b0:93c:6507:a6e2 with SMTP id
 af79cd13be357-93cf1a62b30mr751647285a.65.1790986824884; 
 Fri, 02 Oct 2026 17:20:24 -0700 (PDT)
X-Received: by 2002:a05:620a:4113:b0:93c:6507:a6e2 with SMTP id
 af79cd13be357-93cf1a62b30mr751644085a.65.1790986824308; 
 Fri, 02 Oct 2026 17:20:24 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a87e2f7dc8sm13737291fa.6.2026.10.02.17.20.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 17:20:22 -0700 (PDT)
Date: Sat, 3 Oct 2026 03:20:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jun Nie <jun.nie@linaro.org>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>,
 Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v21] drm/msm/dpu: Enable quad-pipe for DSC and dual-DSI
 case
Message-ID: <olwdkzm3nefubm7j37se3vmmpkfyxdfkrmgyiytbiv4jdz2w2q@op7vykeopdi2>
References: <20260727-msm-next-quad-pipe-split-v21-1-965dfa5b669e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727-msm-next-quad-pipe-split-v21-1-965dfa5b669e@linaro.org>
X-Proofpoint-GUID: VbnbBiv-buaj-1OY1ZT4xTGTD8oI6zhT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDAwMSBTYWx0ZWRfX08VgZMQIYU1Z
 A1/YSHIMGP3UcJDa4CiSAi6sZoddHoGYopGoELv9brpdinoHt96syar1ZR7+fkZ1icGfl+2bKxQ
 pPx8kk+Y+/jl34HhSWjZMtl4U+oYKGY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDAwMSBTYWx0ZWRfX5wV0C54bTghW
 KwwEpIODyY0VCTVmJPdrt/jz6V+hELdmsA1AT3lwdeo3Jypit1GbTOVHSuZ9LTw9I5Y7nbR4tVd
 YX+6LGIRLACXR2MdrjS7TCjx+UKtBB+Rfy5YiwAIVMI4/0zJ8nToRKd6L4V8cSUdIBHTFf7YQTP
 wpKjPR63W5QbPfog2FZ8Y+mcFZeCOmRlPQyfrW+aoafTZMgR8egMd3YO4bj2+yDya9BXCyIkf/g
 ccAgwY2uBDN6zXDxP/jvuG+nbtBFzf0TGAo6HCCE22lxi1VvmY3XLRh/qn7G7n0EdHemiSTW+ao
 5oZEbKd+WEiIKPrqt0Ty8vmuNX5wcS8Z6JADX519ifvw3vTJy9ISjapWqzpcM467gVE/LF3aKkm
 zE2wUInnBJCaNNcuMEJS1ayuNvkqSzj3Rxa0kP/zT6VY76+B2YfH7Eack1OLOc1bR6GfDbSzJ5z
 up81bzgN+ggTDjVN2rw==
X-Authority-Analysis: v=2.4 cv=L9SI0OT8 c=1 sm=1 tr=0 ts=6ac04a49 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=e5mUnYsNAAAA:8
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=DT45myXMZceectMb0b8A:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=Vxmtnl_E_bksehYqCbjh:22 a=cvBusfyB2V15izCimMoJ:22
 a=FO4_E8m0qiDe52t0p3_H:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: VbnbBiv-buaj-1OY1ZT4xTGTD8oI6zhT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610030001
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

On Mon, Jul 27, 2026 at 05:33:26PM +0800, Jun Nie wrote:
> To support high-resolution cases that exceed the width constrain
> or scenarios that surpass the maximum MDP clock rate, additional
> pipes are necessary to enable parallel data processing within
> the width constraints and MDP clock rate.
> 
> Expand pipe array size to 4. Request 4 mixers and 4 DSCs for
> high-resolution cases where dual interfaces are enabled for virtual
> plane case. More use cases can be incorporated later if quad-pipe
> capabilities are required.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> Patchwork: https://patchwork.freedesktop.org/patch/675418/
> Link: https://lore.kernel.org/r/20250918-v6-16-rc2-quad-pipe-upstream-4-v16-10-ff6232e3472f@linaro.org
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Jun, thanks for your work and your efforts. I hope you don't mind me
taking your patch, testing it thoroughly and finally polishing the LM
allocation conditions. I can say that without your energy and
persistency the series had no chance of being implemented and landed.

I've posted the (hopefully) final bits at [1]. I will run them through
the CI and if everything works, it will land in 7.4.

[1] https://patch.msgid.link/20261003-dpu-quad-pipe-fixed-v1-0-6a6a00917b71@oss.qualcomm.com

-- 
With best wishes
Dmitry
