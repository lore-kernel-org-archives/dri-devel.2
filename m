Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6993210F286C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 19:48:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D30D410EEB3;
	Fri, 27 Mar 2026 19:48:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="n8YtDxxy";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XznCYaEO";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E03D10EEA5
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:48:07 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62RI2Q121774479
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:48:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Kn1lDIgQd3VByYsW9FmcphaYaDwGxy32eDmbdbcDV4I=; b=n8YtDxxyX9cc5WRJ
 3WIvrO31j1v+syMckBhOzmD6FrHiphMb4MZ3AC8NoI0t85bTTu6fD+OqpGQW4Blk
 o9+uTmhjg861mOTBk9fk4S+RvyLfgc5IiIAWpLxuJLPF78iKrldkDDu7yKdO6sjw
 pE7aB4mEy+K0TL5XcN5JA44aJIqtYxdeXhIG9AMUUTzPTyrZnsS+JYB2Bb8LBmrm
 XwVZ7j9464js+WttMdcsGfsUa+NwKFvik+5OfIF3UKNh9XVKrBhxTUcWXPUwQGzR
 GcfyYxa/VUni3CBtp0p14bY0txPGJpHSeTw9FPdYwK/IBX8k+O4caqoRynVxsZi8
 PWv1fw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5vvv8rdw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:48:06 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50b781542c1so57739281cf.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 12:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774640886; x=1775245686;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kn1lDIgQd3VByYsW9FmcphaYaDwGxy32eDmbdbcDV4I=;
 b=XznCYaEOHZV0Lo+nnVV6EhEO6jLuNFdIDaAu69w6OqUyRaI4PpRAQ6azPKL1SxeEK5
 WFkmUMoCqRJfTpP9hISQjsdK9G+iwBq3Cl7RZx9Ga14SOiYOYLamuSSxHhRcTsROUe1Q
 HKa21nsxSc4Tq7aU0+RfN3LLE34P3nQKWBNzsroNytM/gcZGvvcV/8e6CAeKUMtfgJC4
 d4RzbtDQozFsrZxoMNDyrXD+ws7nacFfDlUtB9VVaKpNycfMfF2xrIQn0nnbBahAC4uu
 TNoY8Llg6xRLsCT7CQpsqzLUGkVe2t1av2peDqhlCCDMMN/x9StkEYY+pOfLt1sUcDsp
 +Nmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774640886; x=1775245686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Kn1lDIgQd3VByYsW9FmcphaYaDwGxy32eDmbdbcDV4I=;
 b=IK0aemmjNwpyYVcIp2eLWWtmsq38Zn8eSmRDUL4XcICJbXGUZV2h6SlZf6RwSvF3Hi
 I9KeOa1wIc/vSJtvZ8PfQegJb9lzwWXtaaHHAgXmwWwlpRZJ/VMkXWwI7d0Ge8lVDOve
 Vm7+hYV8POw6jcJlwCqeKkuLaUhFHDFT/gf+svnl0mVyMK2Vp+GglZgnQ+bO/gSOzs/a
 5dC3se0q/EkEFpJbYgJSr60FSv7IncxMVYH4GcZHbKiwyf+Ixo7EYdSy66ym5zzwvl/p
 NvwkYp4MSTgXIF2NY4iGm1TTfohGlmXtcUCV3xwrS3DonnqFha83pEw6LcBW12BKM9bk
 u+5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUf3uT33y488TPkTD6O/Y6VS1dKbTWwYN5mTrLXk5bTpKe0Y5ZnGPQ/jdlSHliLn+VEjVpbTuXmYAQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzlu9z4my1rNx2cIXeOsyctqSqpCcBzKPUMeX9RtumWCmoFNF6V
 vIm2+DkCbB200eoZmyXnVYr/COgjiHyr0rG41mGbXATsp6qraxBheSXhxGTteBObzWfsW8peRhQ
 fazdbukvLVAPmo2cMiagu29EQhwZUoJNkEiv3ME28kxyP1jBw/t6R0N37B9meRYjP3Be+ouY=
X-Gm-Gg: ATEYQzxrAlbIwQq9DyxfniHALn8MLJVNyyR4MdOjP3P4o5mCD7Q+q0VMCr2fr+dLU9Z
 jRFCJ34Z5FaAWvhoUe0p4Ne7Ug8+pqVHlE8o7wNRj2Am+G2yd97CJq2tkso3gMpOnbjWQufnCRt
 d+TWApGxEPOEc6gU7kek/2+T2dAYpmNkoDN7oysAXHNwCqFZt4ISIAYk1CCEUk8z83RuTMgxmGO
 jIJ6hkzPoo+XRgsdktpCRvZdk4ANlU9AjRrRFAzoAWqCnzN60XdRSYYTBKubrVB0NphxeKQifOz
 2gd2ayIp0rRLJJG9fx5QOirwlCac7vecgjB7LAL9miKJ12EM6aYSZypeQhpQxOzYjKTj/e7Q3lp
 dncedglAKNAYLHU21Yo8LLfvwucEFcAkN/pfgWcHNGBPpOWna9IJ/W8cML+yeRDVha4b75su+g8
 NLlVjTSU05L8cYDo1lqep+P+taE/4spvSS
X-Received: by 2002:a05:622a:2593:b0:509:1a72:e332 with SMTP id
 d75a77b69052e-50ba37f5c80mr60821511cf.16.1774640886024; 
 Fri, 27 Mar 2026 12:48:06 -0700 (PDT)
X-Received: by 2002:a05:622a:2593:b0:509:1a72:e332 with SMTP id
 d75a77b69052e-50ba37f5c80mr60821171cf.16.1774640885520; 
 Fri, 27 Mar 2026 12:48:05 -0700 (PDT)
Received: from umbar..
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38c837130basm275211fa.12.2026.03.27.12.48.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 12:48:02 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Abhinav Kumar <abhinav.kumar@linux.dev>,
 Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Jun Nie <jun.nie@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v19 0/4] drm/msm/dpu: Support quad pipe with dual-interface
Date: Fri, 27 Mar 2026 21:47:45 +0200
Message-ID: <177463970774.3488980.2908819740590107753.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260312-msm-next-quad-pipe-split-v19-0-4ffa2b06c996@linaro.org>
References: <20260312-msm-next-quad-pipe-split-v19-0-4ffa2b06c996@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ToLn_s9h1J3rpcwetV6FjFOCd33bq6aB
X-Proofpoint-GUID: ToLn_s9h1J3rpcwetV6FjFOCd33bq6aB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEzOCBTYWx0ZWRfX+4dm47+AllRw
 NyLMUVG3PGVC432oZdfbR609EbMN5i1BT7va83PSyC/BJVDtNLMaV81Cj4SCNXlWRNkffiZZaim
 TWjOPvcFnWVORT0OM/Mk5gsLmnKt3+aR4AfJmKMGIdvOnVuauov09JA4jUjN2vaQGw0ebLA2NIG
 M0ICPA8iV6DUXB7Q0HNxYdjGijE+zKEVEBjobI1jMVH9kwMAouZkdmZZVcG/ngcHayphgxBTIs1
 Cg2UWnZMaFJSHlPsdYSCHwn0r5Rr+UryHhxpCugyvejDklLM/qVx07fw5roKJZ2wN9QrQwV8FyM
 24NcVjvU7PeD5m19gf9kpXi+tWC96kw1y1OYCrkFQlCeOZOwh0KUiuwzLzvPLEMjPYQI/hHibwb
 mI5EWa2VbDRkZFYMS5W7Aue6P7kDqdM6kOA6tvKjhIQdRMGgDBvVnSaLDeEYCtWmcVLDzXHH20W
 SxBZQklVUEG5ibK3JRw==
X-Authority-Analysis: v=2.4 cv=PL0COPqC c=1 sm=1 tr=0 ts=69c6def6 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=e5mUnYsNAAAA:8
 a=pWIBXgJe2REoKf9fSU8A:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603270138
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

On Thu, 12 Mar 2026 16:28:09 +0800, Jun Nie wrote:
> 2 or more SSPPs and dual-DSI interface are need for super wide panel.
> And 4 DSC are preferred for power optimal in this case due to width
> limitation of SSPP and MDP clock rate constrain. This patch set
> extends number of pipes to 4 and revise related mixer blending logic
> to support quad pipe. All these changes depends on the virtual plane
> feature to split a super wide drm plane horizontally into 2 or more sub
> clip. Thus DMA of multiple SSPPs can share the effort of fetching the
> whole drm plane.
> 
> [...]

Applied to msm-next, thanks!

[1/4] drm/msm/dpu: Extract plane splitting into a dedicated function
      https://gitlab.freedesktop.org/lumag/msm/-/commit/febcd37fec12
[2/4] drm/msm/dpu: Defer SSPP allocation until CRTC check
      https://gitlab.freedesktop.org/lumag/msm/-/commit/25ee10927752
[3/4] drm/msm/dpu: support plane splitting in quad-pipe case
      https://gitlab.freedesktop.org/lumag/msm/-/commit/9c171c36d83a

Best regards,
-- 
With best wishes
Dmitry


