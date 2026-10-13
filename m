Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0DD6CC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 10:19:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60AA110F6F1;
	Tue, 13 Oct 2026 10:19:27 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 474B610F6F1
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 10:19:16 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D9WSUd174136
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 10:19:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=7Hhfq7fiw28ZkDfvmDF1BDlx
 jnaYKRw6TyjN4JrVX4g=; b=g+SsL8wG0HIRiVNkfIddsxB99Jn0oQla+0oDMREd
 rxMP5t6pwMbbuo83h6PuLoOT7kn7YDI0oK6C3XcnmZX0WGxNe305I3U+KJYc8xBj
 jBEM732rBJMa3TVw1wPuwaMus54MJa9KblXoI5u6WE1OrbwoxhTpYSCWruiu/s+n
 Z94zeoPiTilNEsFbF3f9bYFWFpyBh5heV8wzJNRFrGKJHmV6jjd2alQUPBnSXnFC
 CO7DCf2clXltf7sxLa1c5y0ur4ihe5OngyWKt/DV9TnLxaaXHLZcsHDuHTyJJo39
 9tXB9FyZoQOkAoG6dxU3GMARsIH+6Z1bAeE0/GHAxslnlA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9daqsf4d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 10:19:15 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93e834ff4d0so792713985a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 03:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791886755; x=1792491555;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7Hhfq7fiw28ZkDfvmDF1BDlxjnaYKRw6TyjN4JrVX4g=;
 b=fi+Fw6IQD4QHk0bxjN4qiwcylRy4zzi4Mw/mI0VgGurhxWmcBDf7+vER2x50m4lte4
 zvDMrdE7anomFsZDnrV+bjifHvmdiqk3jNgSIbtt6iPMnTd2Jy8IlTiRHgfqQzQcZxSe
 5qLOthrGP3mqmzDmZLuo0beItR+4iTPOjUL2ZWR3qmFqxraBLCbqCnfdpXBRhFaSlPJG
 RKjNDLOW2H7yTG+LcxLeWdi7+1GJU8LUWnY2sUgZiEN6lgCoVVZw9y6tY+iVku1gkdIf
 H38Q31REYvhF2QQxYdyxDZniWHSPv5lIvUz/aBJzwmhzdzOf/OrQxrJlCptjbqi7W4SG
 ANRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791886755; x=1792491555;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7Hhfq7fiw28ZkDfvmDF1BDlxjnaYKRw6TyjN4JrVX4g=;
 b=gNPbNWmxek+PPZfsHtDJrrtQlZWcJeRpQB03jPZVRmAIwzn9QbSI/gz9sEPT7tloLT
 ekMA8OCzEOYnRp3sZCmOhfAyl4cKMgch9a54UY0xGaXjIqkj1urQujjVl/BWNLH8ixQg
 D9mppYHrfCDVcl2dnFaYuKIO895IiJkJ8DkLEiN1lot2L01JnDhy0uAfgtG84yn8Hyne
 vGsD/8I8HEW0h0x7eSGn/7BfvG4J9GeurErbhsjNW2cA4C8GQp+PPXNQ/AicydzjD0in
 bp4R8bbOgRyIvgqmW3FHIZqo727xIW7bfjP3cSRHkjRcXKAbv1uy0EN/QD9FaRjpwP7I
 l0tQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxSYzxQMN/9ISfjnmBQg/SkcZR9YY1BskWlgyF5haqvB8gqBcC17Eq/u8T57P6v9N/47jedpgP21iI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIW4DDG6zi8VZlz15Mum+TYS5h6daGTHuPicygKJzgEtqQtagyi
 3ooWwWQz/LkgzgCpJHHAA3CMpRaw8Ikbb5+pE+pXpokE1WXYFkDmcU4FldQNWtIoMHbaX1AR3SO
 CQvp61Vwho65SmvPUMZ5IoelIqhkiC+sn3Ul1gANY3zTuS5xMBzvSvMz8PZHwVp5uosu3rjY=
X-Gm-Gg: AYBFou0AbH1Zv0In61PNIj1Xl/ghkn3gLzuYdX0b5C7tIe7k/hq+tVlbFBE/y7KIQRp
 xFwCmGxnqFkkgxY9bsPCChgsbBwEgA2JeWRCkODYK/O641yCcXDl64ftvRY2QvN1oou9h06nmAp
 MA18PkDchoQXkDeR859jzoeNmmGJhRwhvX8Wl/DaErik821j+P/+iNTHW0SImlVkN8AtdPMfcp2
 M6McKP9qlcyVQ8nx/WjUp9h6HkaZ5AL5EK/e2YVvvhTJGdUQrq1igZd+NUJ5Chzx0Xee4I/sMLz
 FazhGKUH8BLSQcpJJDyOzyUhUniKwk5oMJoeHRKuW6xokPFu8uU6Jaj3q4sB6MF1RwA8D9GnrDG
 2YAEiwCUNc55/TjytEz+sSCcYcXO4A2KJfyazOLQYTw5SJv8JzW2v1GqZ2yq3t5cReC4tGCVs7P
 6Gd5Tj098mRAAt
X-Received: by 2002:a05:620a:6405:b0:93d:e031:5ad with SMTP id
 af79cd13be357-93ebd224911mr1904655985a.17.1791886754617; 
 Tue, 13 Oct 2026 03:19:14 -0700 (PDT)
X-Received: by 2002:a05:620a:6405:b0:93d:e031:5ad with SMTP id
 af79cd13be357-93ebd224911mr1904649885a.17.1791886753984; 
 Tue, 13 Oct 2026 03:19:13 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bcf282952dsm1594993e87.7.2026.10.13.03.19.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 03:19:12 -0700 (PDT)
Date: Tue, 13 Oct 2026 13:19:10 +0300
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
Subject: Re: [PATCH v2 07/13] phy: qcom: edp: Add Nord-specific register
 offsets
Message-ID: <q7riz5qxge3gqjqz23xz5aecfhlg7bry5w3wzgblnyozm7ac7y@b5s3z7vk2k2w>
References: <20261012-nord-drv-dt-v2-0-a2ab9af954d2@oss.qualcomm.com>
 <20261012-nord-drv-dt-v2-7-a2ab9af954d2@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012-nord-drv-dt-v2-7-a2ab9af954d2@oss.qualcomm.com>
X-Proofpoint-GUID: YxKJHIx2ArmBvfK8xL7SwDFR6Ep14e-O
X-Authority-Analysis: v=2.4 cv=FZuiV5+6 c=1 sm=1 tr=0 ts=6ace05a3 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=zGc1Ob07GAFFi9FfrWcA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0MCBTYWx0ZWRfXxzpcFqWyrR3H
 0nh16+vIf4QyuYXtXS2u7PNX7/smSnXsGzd+0sZOM9O9o7aKfpgnVFZsOXLd7+MPqmbIsRVnirZ
 VjPdA+nBSc8PXFaPoKN4KMADaL2kWHo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0MCBTYWx0ZWRfXwMILmVUxMjW9
 ebsPv/jZ2TCnRABVEscVtnTQmmx0+AdTEgP7ZrjkUGGz2wnzvF5wcrigJlmQ7WvokVOmVkPbbbq
 3nwqNkAHdbPd5ZghO/Chm67UD9c+j8nEHy+CvrjsZnBaNbsUu2TEKXNBhyt2kfqQ6YCD2EEBMii
 iML6OnBB5zPQBWadbFiCkLy0VbHLDZlDU3Wz5GAj4R7JmPOtKqevd7iQ4eXR5alZNAGpKNqjeq0
 8Lj5/y6sf+GMH2G7ylISQtv4kpjezTRmEAAUEmCtCql86Fgj8BmBWCYl8A7bS3UCHaTlAye3oT3
 QpPKikijtRCQoTuA6f3e46Ffr/7AuXT69QI2iEZDveulufWiPMAnIre9rWR69NRCq6bxw+z5nTp
 B4nFL1QlUGzVZnRKCSKeuMGIR1cG+iN2BIe5jEI5ukV3fO3V/MRVf5r4HqdPqY3rkpuEiTYahIG
 VJepJUv4S0xphTaYL/Q==
X-Proofpoint-ORIG-GUID: YxKJHIx2ArmBvfK8xL7SwDFR6Ep14e-O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 impostorscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130040
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

On Mon, Oct 12, 2026 at 07:02:17PM +0530, Nabige Aala wrote:
> From: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
> 
> Nord relocates several DP PHY and QSERDES v8 COM registers relative
> to existing SoCs.

Why?

> Add Nord-specific defines for the relocated and
> new-only registers in phy-qcom-qmp-qserdes-dp-com-v8.h and
> phy-qcom-edp.c so Nord sequences can reference them by name.

Typically we don't do it, If something differs, it should get its own
set of headers, describing all necessary offsets (especially for the
QSERDES). Otherwise it's not obvious if other regs (without the _NORD
counterpart) are valid or not.

> 
> Assisted-by: LLM
> Signed-off-by: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-edp.c                   | 7 +++++++
>  drivers/phy/qualcomm/phy-qcom-qmp-qserdes-dp-com-v8.h | 3 +++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
> index a3c893f72908..d5c6835b6c70 100644
> --- a/drivers/phy/qualcomm/phy-qcom-edp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-edp.c
> @@ -42,8 +42,15 @@
>  #define DP_PHY_VCO_DIV                          0x0074
>  #define DP_PHY_TX0_TX1_LANE_CTL                 0x007c
>  #define DP_PHY_TX2_TX3_LANE_CTL                 0x00a0
> +#define DP_PHY_TX2_TX3_LANE_CTL_NORD            0x00c0
>  
>  #define DP_PHY_STATUS                           0x00e0
> +#define DP_PHY_STATUS_NORD                      0x0110
> +#define DP_PHY_LDO_CFG_NORD                     0x00f0
> +
> +#define DP_PHY_TX_LN0_DRV_LVL_NORD             0x00e4
> +#define DP_PHY_TX_LN1_DRV_LVL_NORD             0x00e8
> +#define TXn_TX_BAND_NORD                        0x0024
>  
>  /* LANE_TXn registers */
>  #define TXn_CLKBUF_ENABLE                       0x0000

I'd suggest adding these together with the actual users.

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
