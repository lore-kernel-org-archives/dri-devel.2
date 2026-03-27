Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE8310F2867
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 19:48:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8228910EE9E;
	Fri, 27 Mar 2026 19:48:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pJNQ8bn8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PyptMazF";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3226B10EE4C
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:48:18 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62RI2ig73351656
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:48:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Nc5BQLdxMwwYUmrYYywNJDjCwfZ322iu+GCikJgAULc=; b=pJNQ8bn8/fEJnd1M
 4pvsKtWckqfiDvbsfp3Zs867WCOwlOETW+gIoFn7+pmimIUOQH+m05McVffzqgMP
 Z3cXMqFNR5+Gdtu/AWGk9riAimNg0JJTGMPtOM3HUIhtEflDGk+BxCK8V13KluTm
 2dB9Vj0hvia1f1R2yWrCwe1hAzLGjXXlKFVT801xSzbP5E3ma0N0uK26nWAWplHw
 W4e6wwSLtfZLFxU7Oh+jBsQP/t7Ccgw30ye6lBH+zAWbO0YkdcmsTFvcH5Xjj6Lf
 OpLb71+iRdEAT1jeerUqxQ6ciRAe6comHGKWd4cpBIeYXs0zSA42L1/4PUjA5XbT
 gJxBJw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5bxv4g3x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:48:17 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50b52a2d70cso69471311cf.3
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 12:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774640897; x=1775245697;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nc5BQLdxMwwYUmrYYywNJDjCwfZ322iu+GCikJgAULc=;
 b=PyptMazFEpHlPbxcYrHasG2AlolSJFpbTO9+bzI849uaCLxnZ19xSq1KfHHQ53arl0
 C4/2+yIlgUpElTHUioF8g4PGK5FUDSCJANIttipQvTzj5V/eCaUfuUs2iP5zHt5Ejeon
 nTx8UrSKWLjqBO9WII0GkBu/CrpDSiCV3uSZ/nJ3tqb55nf39eOREb2U/ORd6Qco82VT
 1ZlGDW1rsBRR9oKLs5m19iRBE3gd+sccvxz1gFfd1qYN1apS27M2M/8QaDf35Mp56Oqf
 fqkMTjUztppzlQ6eRSBt9Uhy8RpJF7gfITf+ZKIGhVdCoT1V3bqQncb0y8oaV/IVtFsq
 ADkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774640897; x=1775245697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Nc5BQLdxMwwYUmrYYywNJDjCwfZ322iu+GCikJgAULc=;
 b=oYWeBwoz/OpHoZj7g4B72wfoeJQaxXcAeSu4SezbOz35DUM7jk5+efksC9XUrSsdIS
 EF0IDw8BE5bRJe1Bd+wj+RNd0tBQhxTWRwr6OM+QT0k2unGRsy513iSXvQgVBC/vYV9g
 opBocVzRU4eMQBFc9ZWmMlbWiW5OdrqJ/zNrQm7XgCRiQ3cxYUW6LSNKgc4tC1bgTmyS
 FSL01CY2zyYBH0gdnBmSmbts7BIbcmvUHPe5ngA+8r7fJkFPmWaWkzUOuUtDT73n4wQP
 RBD21XYi7m1VIulQAdKzZv7E8CAwtneK8SJZATHPWFUNuxM7H7ccDde6sR0oDVj5QG9K
 6+9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSQhAWUOzklDSRlmCCB0+eeQvQ4GrutA5gTNtlTI/NKUVGzxcTYypIhr5aJg50N/k+l4e05zsHAS4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwjjIXSCbKcxDYPnNPrrk1K3Hs1F3M7jFpoGii1Oj5kyQvpiPxU
 Q1HJmi8aipn/WzINerlzRe8y1Fot4eWWN5I5W3qi8HJnIM+FncqmfNVO8faCXpKMPFu6HCwY+Dj
 FKFww407JHiajRrv6jn6VLUkmKqOwyuZQgbl9MmVcCrcB+QroqIRdCPU6qHngwvYrBd7p6IQ=
X-Gm-Gg: ATEYQzyyY/STv348Jo+Ggy2GLdn7niHqBJmygcaOiXyUs/k9SXXEkIqSwmy3K2yZ1FO
 EX+K6Rur6gN/vKautYD/lRhuwwVl/ItlJkzNMcxhodR8jvFsXtZ4eWwC+MFlmJwTACHxSqkUsnr
 CCNDhlRCeWZzHuWZV7h8y8rhWi1Y2PWp600+6N03hwOEDaAzOLSefLZWc1VCSJOhUDZG3po/DpJ
 yAkDSyfL/6D4bgBN8SseAugcb9jyAyPGwQbZS+STmOCsizsl5GO4v20j8esDNzNPX8GmMhsaGir
 iYpwUcemsLwYxoPCy+cairNMwgNNGbrP+Qlnn5HskEI+25HT8ALA0aeqH4nZB4FCqcwU4R9QqZW
 KIixIIH8gxG4rsqLN6u8MMJRbXTIU+89H+cUOfgi5jHjnRiXIZUlqrCuBXRJO4hPl2eVnm+npT/
 o6C54uMHGPsHeSrLIXeORGf4PnXOwuFAmV
X-Received: by 2002:ac8:7d4b:0:b0:509:3d06:96a with SMTP id
 d75a77b69052e-50ba397b630mr47748811cf.53.1774640896758; 
 Fri, 27 Mar 2026 12:48:16 -0700 (PDT)
X-Received: by 2002:ac8:7d4b:0:b0:509:3d06:96a with SMTP id
 d75a77b69052e-50ba397b630mr47748431cf.53.1774640896323; 
 Fri, 27 Mar 2026 12:48:16 -0700 (PDT)
Received: from umbar..
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38c837130basm275211fa.12.2026.03.27.12.48.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 12:48:15 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maxime Ripard <mripard@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] drm/msm/hdmi: Fix wrong CTRL1 register used in writing
 info frames
Date: Fri, 27 Mar 2026 21:47:49 +0200
Message-ID: <177463970801.3488980.2533820588503538950.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260311191620.245394-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260311191620.245394-2-krzysztof.kozlowski@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=A99h/qWG c=1 sm=1 tr=0 ts=69c6df01 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=e5mUnYsNAAAA:8
 a=s7uc8e38FLtQ-qa--o4A:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: wZWF2LDA0cXWX46is3Jj8PHqiT_rmIpk
X-Proofpoint-GUID: wZWF2LDA0cXWX46is3Jj8PHqiT_rmIpk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEzOCBTYWx0ZWRfXxF6+d+j/4q1e
 Sg1Jj3wNRvqk8cK0Afgp/sPmiJrOiZCj0cUIKxhJ7cCuQEwPbktUPB4AT0RY3n78vdMBvzsFFOf
 bdtaFNw4mcffrWHHD90/PQ6rkpmCJkgAuw+VYIWkPoIDQbrbAXsmxygelkJBZs76r/xYjB1gnGi
 AFcYpw+OTlptd7g87e2NqQHSUk7LqSbUoQSxymTssIayE9+80VGfwTrvFB77FFZ8DlsjHyM+kvo
 5tAPjZSCJBBWwv5peyW9WYHTCnXPgvhEgpUWVJdkQjaDOJ1o96BjA4+XdGeas2DsaPHzamR3wH5
 WkMdTGSLfK9Qr0GLre3Wztx8qR1e3P8m6Z4LWtxQzD15MyfZUs4Y/IItdoAIIeob/Lm55cgtpQV
 +fpOkdzsC8wULcaqYylkKdRSDQyuiJKJvLlViOvup/vYQPMOJqE0JHpKCSc5kLzahGVjWJt+WP7
 tn22WjkeLnap3kJETGA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 impostorscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270138
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

On Wed, 11 Mar 2026 20:16:21 +0100, Krzysztof Kozlowski wrote:
> Commit 384d2b03d0a1 ("drm/msm/hdmi: make use of the drm_connector_hdmi
> framework") changed the unconditional register writes in few places to
> updates: read, apply mask, write.  The new code reads
> REG_HDMI_INFOFRAME_CTRL1 register, applies fields/mask for
> HDMI_INFOFRAME_CTRL0 register and finally writes to
> HDMI_INFOFRAME_CTRL0.  This difference between CTRL1 and CTRL0 looks
> unintended and may result in wrong data being written to HDMI bridge
> registers.
> 
> [...]

Applied to msm-next, thanks!

[1/1] drm/msm/hdmi: Fix wrong CTRL1 register used in writing info frames
      https://gitlab.freedesktop.org/lumag/msm/-/commit/8c6c93b7db42

Best regards,
-- 
With best wishes
Dmitry


