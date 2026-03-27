Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6812D10F2865
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 19:47:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE4E110EE60;
	Fri, 27 Mar 2026 19:47:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hmxaaId9";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IfY9EN0G";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53CE710EEA2
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:47:53 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62RI2q4m083479
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:47:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Iw9a7IqTzcAiavmSNpX6Z8ng1GGVOGXu1X0ZTTn1f1k=; b=hmxaaId98+aTaVfI
 36WMHyR9/ICk5G08qIQS84xprwjKP9N60n19S0yjQs9J3eLOcHeYkzMJUSBTNXT3
 YqJaTwm6VMdqeQUVgEGtTk+UkGDAwENiMoyUU0DNhGBrc+8TkhD+tDwN3u/nw1HM
 Vjcgl4+fZ2s3LwpDzy0eDWWbgxUizQt9AIXKAUG1SNQ28yzVEX8woGYQ8brUkOWg
 uSkqN35k/4kXEopmKezAYLNdXMsx/qDat34V75nn8JH75wJiQ5UKfYCiuoz1c2Yf
 j1Uz5uRKJpJ/bzIDRI+YGmOWolZYy1uaf4qdvvjFwBe2dJgTaxVsvSwkq+6P2+Fn
 NNjmqg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5jcx39s2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:47:52 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5094ba09affso69388921cf.2
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 12:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774640872; x=1775245672;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Iw9a7IqTzcAiavmSNpX6Z8ng1GGVOGXu1X0ZTTn1f1k=;
 b=IfY9EN0GmDlhTo15rJHpnJDGFBFSnnE1+AKZQ0L9zenplgQ8FIFlXBRCf8RN1mjmoO
 1w6PLWT8BRax4Ww3XWZ5XfclGB6jix2MxIL4VQSeDBv0tze5PtsI0N/z8F08v0ltIGbB
 KBi+AvH8vJZ+kax4J3/KQ3ANFTTE6PUn7X3lw+XSxJFImc0EiMrSwCkok4wKv4Kbz3Uh
 Wwe1/cwHyA0YFloV+ne44BToM94r+Yw0xJ29bYWW67nO0N7kvI83iw2wMbxsdoJnJpkn
 KOkP/RbiO+WSKVkvUVNdajVzgcnQfI07WnOtwk5toNOAkGkgG0xPO6cji/sZFlnK6Ihv
 032w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774640872; x=1775245672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Iw9a7IqTzcAiavmSNpX6Z8ng1GGVOGXu1X0ZTTn1f1k=;
 b=PjNFeOF80N5SwfehlBywITi5CT9M+7zaNP+zaAgQB3xh/rvp8i/tUZd42TqxCJYJYu
 iisTq2xr+XKwTGMg8nNvIhFmf14hDTymXDzff5JWP8yhqJOvszUzi+GUtcvpL0Gi9Ynp
 HXeLg2eai/PGsspn1f2scWAhcTE4mPl4JdkkEZyjLY2w0SfW1NC66EFedjhL7KNNYHQq
 PQaghF4p4WO66tOB4AGXKDMdAUdiz8/JD8D+hmgDqGSxNDSbjd1QFLMqlfhT+fxt9ZVR
 s7zk5MnHU4Gr9IDbBRtn0gARPt2ceCI0artsmyWf2HYnPWWwdYsf1LresDHiYCPpvTYC
 2OtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPugSlED2ozl8yx+tts4nKQ2pQLa+kJf64ZUrXS5ZZEJt/OsFnOiJ3YyecEN8dTSwzJ3CmhAbT2bA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywws4fRtlKlBg3s84PoG7KoO3o5ZE8zdXbhmwtgEB0z4n34/+rU
 2iEjHgCAMD9czAMdB366ZoUVe9hS1woBpHrmhfM8ZqFNplTF7waukcy4pi8XZUlNG+li/rHfirA
 f/UmX75znaZNJf7Nx4kkkyMiKGiKCcRMNvOY5UmAwHhQ4ysga2a3qnUGYxsxwcZNQo8lLwxI=
X-Gm-Gg: ATEYQzzdLltkOdux2AznqjG4kJmqvbiI2RZ3Rw3dde1hRSYY6yDrhJWQGzEkSIZO2NY
 zdtaGZZ9W2r6tuojpUKGpcUKh/EPJnpD3mDSPAMIPkfwrcLLg6CX1GgbvrbuoqWfviSfBNBlkKZ
 3PNzDsq2+bq0xKxIe0lBm+BH5svNMZfFWhA4pwBXMXMGxgVAqZF9N6BAhRnatqmIb5h3L5O1Urk
 X2SWB2eQCfoUfpOd1os1El9KiqddILQ3Io8kmjmKknTEs7KPl/kZIlmsgmMIdPpRn6J47jlXwSy
 ScNJFjTYMXL7d78oozvP525co7C2ACUNb+RaQPEg7sGrfhGXr/2rPuas4boUnElBUK6qirGGAyp
 tXTxIGWO96hdMOHsJIV/hhrfvxOSGzCVsxVPcZFb7JX85nrynN6Ly1W5EsXHiuSaAwefqKctYDP
 7Jy+BkPU6DOnGboU85xKhPcA2kCNWNg9wY
X-Received: by 2002:ac8:7f0d:0:b0:50b:3be7:afd with SMTP id
 d75a77b69052e-50ba39fffe4mr52322151cf.65.1774640871813; 
 Fri, 27 Mar 2026 12:47:51 -0700 (PDT)
X-Received: by 2002:ac8:7f0d:0:b0:50b:3be7:afd with SMTP id
 d75a77b69052e-50ba39fffe4mr52321671cf.65.1774640871315; 
 Fri, 27 Mar 2026 12:47:51 -0700 (PDT)
Received: from umbar..
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38c837130basm275211fa.12.2026.03.27.12.47.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 12:47:48 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 0/7] drm/msm/dpu: simplify VBIF handling
Date: Fri, 27 Mar 2026 21:47:40 +0200
Message-ID: <177463970781.3488980.8775074187981709314.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260227-drop-vbif-nrt-v1-0-2b97d0438182@oss.qualcomm.com>
References: <20260227-drop-vbif-nrt-v1-0-2b97d0438182@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=NfTrFmD4 c=1 sm=1 tr=0 ts=69c6dee8 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=e5mUnYsNAAAA:8
 a=83z7iYTKtPZY2SJc0qIA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: jsgRZzzZ_k1W7YHWX9xzBm7ZlRGTpGje
X-Proofpoint-ORIG-GUID: jsgRZzzZ_k1W7YHWX9xzBm7ZlRGTpGje
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEzOCBTYWx0ZWRfXx6b/GROBrq69
 dyKUglMdU71jeGoo721X+C+2uEh6Z63XDeDRBwW90sPyEPp9MkPkz8xBQMcoF911UZ59YfYGiG5
 W4RkVGktpqGY+rQqN58R9wSjxOj2b2i2zUo2nzh2SZdGhstHfqmm5zw6U81jGgctCQCa+A+28lH
 E1ZJkuRk+NJ25Mkr5+Etyijwe7JN1SHlOEpzDxi0WnqufxnNVpfnp2h1HwBXLQibF7V/MIe5YNP
 G+/gz6ElwLtAzIGuCTIBSz2/B78mg5V3fbirWpQROLEEbhTmuXU6KtUPa4KxUrqQdmPj38wff2H
 IcRF3SJwiUsbMaDABHT6xDhAghzplprj8djChVLO1l6/qx3j6/GK6SvClgIll4i9mAJoxHA2SGq
 r71DbSCiZ3JVURDb37sUsnT634NE3SEpT3DWOFCAO/WfwYvYTcNSs/9yDezMy528uu33jdf74vZ
 HsM2XBW3X1DqspTZFCQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 spamscore=0 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
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

On Fri, 27 Feb 2026 20:36:39 +0200, Dmitry Baryshkov wrote:
> Once Konrad asked, what is the use for VBIF_NRT. Answering to his
> question revealed that it's not actually used by the DPU driver.
> 
> There are two VBIF interfaces two memory, VBIF_RT and VBIF_NRT with
> VBIF_NRT being used only for the offscreen rotator, a separate block
> performing writeback operation with the optional 90 degree rotation.
> This block will require a separate isntance of the DPU driver, and it is
> not supported at this point.
> 
> [...]

Applied to msm-next, thanks!

[1/7] drm/msm/dpu: drop VBIF_NRT handling
      https://gitlab.freedesktop.org/lumag/msm/-/commit/cfb64b092617
[2/7] drm/msm/dpu: stop declaring VBIFs as an array in catalog
      https://gitlab.freedesktop.org/lumag/msm/-/commit/2c0c3d9d95ca
[3/7] drm/msm/dpu: replace VBIF-related array with bare pointers
      https://gitlab.freedesktop.org/lumag/msm/-/commit/014390e30a74
[4/7] drm/msm/dpu: drop VBIF id, base and name from the catalog
      https://gitlab.freedesktop.org/lumag/msm/-/commit/b26bfb5bf1aa
[5/7] drm/msm/dpu: drop vbif_idx from WB configuration
      https://gitlab.freedesktop.org/lumag/msm/-/commit/021fd8ca0cdc
[6/7] drm/msm/dpu: drop VBIF index from the VBIF params
      https://gitlab.freedesktop.org/lumag/msm/-/commit/1ce61688875d
[7/7] drm/msm/dpu: drop VBIF index from the struct dpu_hw_vbif
      https://gitlab.freedesktop.org/lumag/msm/-/commit/7c5166fd79fc

Best regards,
-- 
With best wishes
Dmitry


