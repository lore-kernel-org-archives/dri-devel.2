Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71177CC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 09:19:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C05CB10E780;
	Tue, 13 Oct 2026 09:19:12 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ED8710E780
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 09:19:00 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D8B2Da922923
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 09:19:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=uQ82qhE+xbrPharhAgsD9+NR
 Ct+bFTtwURK4hSdKntQ=; b=m+3COEDlKoRKIgnoYo8+Ib/egwZwTuGWIqvL1820
 I2EeOkYgsfW2+9Ww2MmvcNxsU3HwoM7ARx9UyGQdxP+XtKGbZv1SksVPwiPIVfeK
 VSncdCH5da4DKRUneB088gg5LtLq4ddjw3Ibmcek6fERcag6jMxbwI5t9WXkvg9t
 qsz5z6AelYxBQs10BQdiQ11QcS9mhrWF5Wd/Zs35pADw8TOH60x+6/tx+FCl54B9
 PwIugTzhc/Kj53lLHxl4VRXIqnN6P3NUhO4y7he2H+PSj29+iVXOVrgypBcy/XmE
 duAXPHcP0lUXixC+f4ymtEWCMBM/WBRXOmpL5jdzwjznyg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h98h1t5nj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 09:18:59 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93caf6c528aso481261685a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 02:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791883139; x=1792487939;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uQ82qhE+xbrPharhAgsD9+NRCt+bFTtwURK4hSdKntQ=;
 b=e9QC1UlRPCa1DMnk5fEgEojmQAE75iep52S2MEAU1SU5bLtaKeygMz0Bfw4nPOL5vj
 rxg6AqiiP385ZnGoGvYF5miZADe3Kc9fpsMWeOL0XQ765FFJ1StEcgREfh22PLvcIZm3
 376d7bKvmV09cY4+yDUXriM9VwQq5d/UBgvB9Mwvb7a01i1iKwtu+lPck6ppHpcwxECO
 i75i6CXvdOXrJxYdIOX3y4xKbJQfvGMVixP1u+rtt8ZghB8b9FdLlhZmu66JHdWJ4Tg2
 sN6AiqA2+vG9zF/+KOzhPr4S4arlNbB6K0XYV6yKwYBRwHWacDR8q3p1Wp9p25dcgMd5
 GzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791883139; x=1792487939;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uQ82qhE+xbrPharhAgsD9+NRCt+bFTtwURK4hSdKntQ=;
 b=pyLdVV7LLNe52ziOIvtOpDJXgCsvLp2kxzQAQBt2BJZIXwcNMaUpFhZwvrCHYPD8iw
 yWL9kx95LuvMA9wpGQeQh+eK37UjO5pdKP6FAsbalCCnZb+SQGPrzhKiZyamUnyC0X79
 OJKKOBgcXTN3l6vA596qxjAY+i8FDwCS/G/yHZK/o4dFmypvuBXuMQ222DyRpcB1it8G
 lYvMHzUS7vgPCmXEhjChu4k2uTjfZd77K6Eb6TKkKDbIDY+s4wZpa/NP+K/CpiCF1Q9d
 lSz9SdZg+J5Gz9vsCl6UYiuHeriodGT1rt8UIy0yH9B6oKL0XIG9TiDw9GvBNmCMix1t
 RRFA==
X-Forwarded-Encrypted: i=1;
 AKwUvByUZyMRTFNaMe3Bm23hgZRsRL1iNxqe5oKksgx9cnd276O3XbuuOdH7xMcHgYmN/lEJmGU09p0vQKA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIYoEbUH0Cz52y8EAav5gcOJ9FBfC034tSIQsSsdXn5wO/BVnrb
 ofkhxqqcKxMzWaUj6m6fLExNoU2VW3FPL8PdmnoJhSuU4okY0zswwOar117C+KsH40S+lox/W2N
 4HW/xsxKBWFV8/8euaxO1DOD2XT6MB5eQ6aB1SRi9XXyt4WN/iY27csUMIfcI7eNR8yci/0s=
X-Gm-Gg: AYBFou0oTvUaQXRlLKjVONNxvc5CEd2NNWxH9lCaK+3C+AwXwN7PzKCzEzno+K7bIKV
 C6iHR+rl/oE8yE+S5ldNhd41B2tsu0W7hBo4rXJJz9BatEVUCsHu6O7ZQwQx5S625Bh2eWITWkz
 FiHyoPJ0vU820z6S2cVqmxRn/XnJuwmLRSp0DlnTwXxwd65kqckgeThgm3zaO5qs2Zs0FASqJoN
 RJaloAea4da5fN+UxQBF2u5CfResNLYHy6NxB69XOEGTY1xP3N3rhuVRbzeiBbrhr+82LFFHc+r
 /qpNOlV+QjU000t76VCOGks1WMrgMy0gBbzCG6dwo8s7YFSo/24QsYE4bOT59Of03j38Pwu6cOx
 64PwVN1QyGP0HPS6CVx6djl5WxIWTL1vSyWaZlMUsjqF0a8dFns+vEGckSzsPcqz2vP4JoRb04Y
 oZdJU/Uh5hB/S3
X-Received: by 2002:a05:620a:6601:b0:93e:7192:191c with SMTP id
 af79cd13be357-93ebd1e0044mr1950631485a.17.1791883138866; 
 Tue, 13 Oct 2026 02:18:58 -0700 (PDT)
X-Received: by 2002:a05:620a:6601:b0:93e:7192:191c with SMTP id
 af79cd13be357-93ebd1e0044mr1950626285a.17.1791883138276; 
 Tue, 13 Oct 2026 02:18:58 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bcf8a3970asm1038505e87.79.2026.10.13.02.18.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 02:18:57 -0700 (PDT)
Date: Tue, 13 Oct 2026 12:18:55 +0300
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
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Shawn Guo <shengchao.guo@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
Subject: Re: [PATCH v2 06/13] drm/msm/dp: Add support for DP controllers on
 Nord
Message-ID: <gmsyzeugteg67h5vwzf2y2e7k56eg6aicbonzjl72etgedd5oe@vlizd2npwtn6>
References: <20261012-nord-drv-dt-v2-0-a2ab9af954d2@oss.qualcomm.com>
 <20261012-nord-drv-dt-v2-6-a2ab9af954d2@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012-nord-drv-dt-v2-6-a2ab9af954d2@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=VqC2kO2n c=1 sm=1 tr=0 ts=6acdf783 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=rMXm0_BZOgqvqhzNPSsA:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: KTQsG0HfFSPr3QgyoZHTdQtOHddSJpMP
X-Proofpoint-ORIG-GUID: KTQsG0HfFSPr3QgyoZHTdQtOHddSJpMP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAzNiBTYWx0ZWRfXygplEKlXyfvX
 PbrQhFay/X6Gd5dVGgSWSFGWMhCWnDpxGuME2QH0B2WF6UlepUtXTPswjURmD3yCSmxz0WoIohK
 9NzOV572coQ6XU8zrtcCF716vUOIDIU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAzNiBTYWx0ZWRfX0Mp7Sd2jop87
 NNt7A0b0miwMI9qTW1a0seURrIOrp5SKOsm87dRosj89a4/DEnSAH1gamp0Q2uVfAu5gQlp0A+r
 e5HojVMFdUIqAbOXEMrpwNq6P9lGGnaGKss8DIIwCyYF4+DTJgKH+lNEF6fpDWJ0hIN/Bn2w4Pq
 sI5TjKE2+aaYQEy7/ENh3cXs1emnk1ghb5mn8oVjnu8ejlpvAcNbNfuqSZbtZ6wvFln/tH0KjIM
 vCgr1Iyb4X/3VBv5wAsZnhH2f9SA08pRlq47lPeT+qMkivdFAWap22MO0Sm1r+UE19nI89mxnLt
 vfH8HtD+Cn5g4uOE+qq9bIMZb2J7UG7PvQqMErocc+/9a5t8cPLNB0UUDHDRy/Z8qMgztCWCipH
 9nNZWoECo6mKEA7B5BXA8ctn5jexPgeQfbG+kYnlSvbzNHl0VLp+19Hq5D8VwNijU9sK/VLgbN4
 JO/lrs0pyUWn4SiQSYg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130036
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

On Mon, Oct 12, 2026 at 07:02:16PM +0530, Nabige Aala wrote:
> From: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> 
> Add the Nord DP desc and compatible. Nord is supporting the
> four DP cotnrollers, two per MDSS instance.
> 
> Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Why are they not a part of the existing entries? Is it a newer core?

-- 
With best wishes
Dmitry
