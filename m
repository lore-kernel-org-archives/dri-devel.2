Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3957F532C1
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 00:23:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29EDD10E587;
	Tue, 24 Mar 2026 00:23:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="L7Ya5dZ4";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y+jpH2Sc";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 467BC10E588
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 00:23:23 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NHqqS93934910
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 00:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=I22j2VRKTTvHYNS8smPDlppo
 QxXaZzbmPUPgZxuQbd4=; b=L7Ya5dZ4AjwUupfGQ/WTZ7nBZpySTohWfgZfKC85
 PrlM7HLxCbrr4QQDUXpv9Dk0AriG5gDAklRtrIFA+otCgNsdGKddvhTD59QPUkfu
 c+OlkVJOg1qiu5GrttcE9v000g4w26+wQleONiV4UwOk0bbyWrgBOckHVdvqrZKH
 Jh7oDUCzGswSo4nYiI4pqCrciCycBGNQf+ALA/46sZ8LZcD8WBS/1ETofq2ssQrp
 jPxwlBYxsU/pO9uXnub142d0bFT19XTun9aSAosrjMou5L/mjchkkvm8CAN6IqOT
 qowx/HR0XNr3Zha/l/b99AjGcQn1ZCocdHJOn7tyZTS4ug==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d37a0hv1s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 00:23:22 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-89c4885814dso239603066d6.3
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 17:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774311802; x=1774916602;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=I22j2VRKTTvHYNS8smPDlppoQxXaZzbmPUPgZxuQbd4=;
 b=Y+jpH2ScS1e4R27+xwvOBQJxxNM1STGENpRXBHFex5wWDkcwWAGE1mgA0hxRLv2yIc
 rUJ6b7YQ2zrysznASUJyfpLKuxjclgCBw0CGxs71rCUl5e3Kcuo+DIP/ywYcBn9CGgQ9
 4IV2F/ZUABcPxkjHi/Ir2hO3wZ8eXwKbDqqPv8ss2vpp0nwxkNpF7FW5evlI0PpLUDmA
 DY8s6p8wCCLXc506SSrf0t3BQIKaiy4I4h3zXMYUW+ieWEOKAg1x/rWwkjJ1YppqiZ0k
 nx2FPWyYEKIbNN6GVrnaxeTR0qS214wjjwlcWApvqox5egCJFgH7x/vPs55TVcamEusE
 rFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774311802; x=1774916602;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I22j2VRKTTvHYNS8smPDlppoQxXaZzbmPUPgZxuQbd4=;
 b=lzqU2BYY6y1PlcoJfqRX7dNs/Zsh2CvyxVzjaVUpiemihzaU9geeryn99iCtYLdFUl
 EyC+k4GgqR+sm8aLuD1YuJutWnD0/o+PmYwMYFwlsAPB6feTEjMwUnAZ6uEwd8ur4toi
 ZL7SbulYT084opAbPOUHKwQX1m82a19vLO8P3mnMIFub6L3qNDEQfPBo0sMS7J0wqPmt
 J+LZ2bVq4zHw4t09LLhggXce4VO4FDc7l+TFIEA8G+dp8CadQKy4jGRB0mI0vV/G7N9w
 ovHp7BniqS5Cf6veUr95RXofR6tns72Wzi/1bPAuln4ZzIVAtXjIH0qiAeJv4mHidRxa
 6n2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXf59nQ6IWlWidZaMJm1dBbBQnbNSuwz39zViscvEz6OBfQFGRUR2CtoyZVDsGxOgBRyzHTKXbqHQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzQ+nvHd2q6Pq47ZUHsICP/++l/TjiMe3dF/IXZyqCbbEAR3CBv
 kYGx+LRL/2KauB67GJMuZfI0lVqm/7HNjjFC77ss9f2vPE/P3epeJ7w6b17JQhIg3YH7mwIWb12
 cOBAE95gNPGnmkXQ2qzjE/fToxuX/w/vCQ3DV2xjoqkzoC9ji/Lw+oMwwTlej9nvbnVgEswQ=
X-Gm-Gg: ATEYQzzsvTQMjZzIcN5S1LIPDkKi6kFeEEoNycb7kOBucXw/iiNE+pJ35thuJWK8RvQ
 BKqhYfpi6i+cLxe2xmfetU93vRsAJHZ1ZUCvjJQjAhGheXSHP0rhfhzGbV3/bhmhhmzf8M9WWHz
 9qP5m6wUtClEVwT+vVeNaBtVh7aRiY25FEspfAK9TlAwIZMqV3hvSmki9Foedg8B9FYpTxxW319
 Xi7OsHDci5jB6zdB8yI6jresLAzvetronxNREKsbluXj9Tfpl0/KZ6CDZDoYx6fvAkZDT/881Wn
 hROt391qzj7YcKLYDhvTxV9c7RTCmdRprHW0pnLQL30zrNbnjsj4jw5IchBJgZbUXproSyhWqkR
 r1kKOcRcACPK0myEWy3xwCgVLQ++F/pKthXeTnfpiidvTzVXAGwoV59YVCMl/W38yT93G3Rc6B2
 QGf6zmFw8RZ2rH3lRIs3HZ1YUA/nNw1d7paPM=
X-Received: by 2002:a05:622a:438e:b0:509:33b:ed6 with SMTP id
 d75a77b69052e-50b3744da05mr169013581cf.23.1774311801727; 
 Mon, 23 Mar 2026 17:23:21 -0700 (PDT)
X-Received: by 2002:a05:622a:438e:b0:509:33b:ed6 with SMTP id
 d75a77b69052e-50b3744da05mr169013281cf.23.1774311801297; 
 Mon, 23 Mar 2026 17:23:21 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38bf9750299sm30405251fa.12.2026.03.23.17.23.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 17:23:18 -0700 (PDT)
Date: Tue, 24 Mar 2026 02:23:15 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Alexander Koskovich <akoskovich@pm.me>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Marek <jonathan@marek.ca>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Pengyu Luo <mitltlatltl@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/msm/dpu: calculate data_width like downstream
Message-ID: <cn7npmmpcnztoe6t6qfjkjggt2vtrtp4zimftpiyaf57f4sjax@z4wflh6zacuf>
References: <20260322-fix-data-width-calc-v2-1-d5f28136bc4e@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260322-fix-data-width-calc-v2-1-d5f28136bc4e@pm.me>
X-Authority-Analysis: v=2.4 cv=GIIF0+NK c=1 sm=1 tr=0 ts=69c1d97a cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=-uvraK2mi3rOfbV3l6YA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDAwMSBTYWx0ZWRfXycM7Te3nsr0V
 tmzrU/EbGTK+l50IvrF/gA9ifmXmfNZV/0M27Uo1g4HTbmaV58bMaSmv+jgCvwyZPhL5m7+L6xJ
 uiosAxEYoUqWB15XPTGFpYu7cxWaVX6BUelg8ciO1bTBhOUTSXEZWcgZtWAHildep6WUitpbouN
 Ylr0/utSAm+6XgGxstOWRmouLfaX9M/QAzFgHMb69l3B7YOo4+0vxdyCaVGA2R2ukET0t0zDd1Z
 wFRS3m4twN8qBQGCl6qurzsqDWjgt7pCPbiK5dM4tyfcVYi2t/oHthfY63ryrxj/08GsmYo+nrO
 TnurDFQRKK9JHeinO7HlHDbk8hXPJoSqCdudpIkG9SfQXq+WEzjHk9G1urYssUpYNcthn2Sy+tm
 vcFzVbV2Jbqa0zZtZ50PoWisTuzXOT/aoaYdnnhjVtUHTCAiESkI78pX/8wuoDA0UqY4L8b66/U
 Jdn58FqHxtErPml0J9g==
X-Proofpoint-GUID: AnJU1ewLiz8d8zfwbaTEQEqdgazkjJu8
X-Proofpoint-ORIG-GUID: AnJU1ewLiz8d8zfwbaTEQEqdgazkjJu8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_07,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240001
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

On Sun, Mar 22, 2026 at 06:48:09PM +0000, Alexander Koskovich wrote:
> Derive INTF data_width from dce_bytes_per_line rather than
> timing->width when DSC is enabled. Use DIV_ROUND_UP to avoid
> rounding errors.
> 
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---
> Changes in v2:
> - Added back comment about DSC & DP
> - Link to v1: https://lore.kernel.org/r/20260322-fix-data-width-calc-v1-1-128880f5a067@pm.me
> ---
>  .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c   |  2 ++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c        | 26 +++++++++++++++++-----
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h        |  1 +
>  3 files changed, 24 insertions(+), 5 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
