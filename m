Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B962A10F2865
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 19:47:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01C0910EE91;
	Fri, 27 Mar 2026 19:47:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="S2jqdf3R";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BY1RdHAG";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 286E410EE91
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:47:42 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62RI2aqm3659015
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:47:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aOgN7bT9dhwG5NgoHHwQkQ9JAHVz6IIhTde9ZM7+iEg=; b=S2jqdf3RFYzBUGlb
 KJ7MaUheo32Fs2SfVETqBdpsBUuwPBdc+i6/ztPYk+wgKVxAPRqftEXUWIWjuUjL
 STRIpKGSF16XcnITupA1iUNl1E5x17N1Bqiiz9gzBe7KvL/nOzns1VARno/f0uN2
 mjpBl5zJzwwQnSb4cbcQPDVYkRD6WlvTX3mLUKPG6HnMNk9auYWTC+/KmOhkKrNw
 zPQ7lM0k/hpmgfFYVxXbANKgIwbznMMFsl//z3C+lcPRmdFAB/R/J81luD1Mtljb
 xLJwuSXuIk/Cz+8ooI1IN5cJWvNndjyx53YNHoWoBJG+ERDNtKPxZI3LNzNianlm
 olcYAg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5mn12rc9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:47:40 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b6f869676so37178421cf.2
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 12:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774640860; x=1775245660;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aOgN7bT9dhwG5NgoHHwQkQ9JAHVz6IIhTde9ZM7+iEg=;
 b=BY1RdHAGQyKCqqvjTOrpZyRsunqv6qCYyzAtG0gpeYU5TGm8N3TmdY9s3XAzTHiozB
 LRZI2uC5G4inh0IugaSCsBmBVvSj3u+D90agSJ3vYDuWAPjo8ySfK5gPxghhPFg+kFpp
 BK0ZPW+c0EKL2y8cxUIKLUnSOG6AL6ud/Rw5cUhCUqdZ71JCVF6HUkkc/IrtMSlUbtnd
 wlp972DF1McLhNPyC/zYeyKjI1BwtmmN0CtSYn+d5t2tyH5Kna0CUW9fdV9Ud/FEv7kH
 9W0jsFvuyK0s39n+aFQXJ8S+0g901f9WEgOCx6kDv2woywDOdE5A8JFwMKFFulJrYL0O
 mKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774640860; x=1775245660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aOgN7bT9dhwG5NgoHHwQkQ9JAHVz6IIhTde9ZM7+iEg=;
 b=JPzUVRbZdIXQXB4tYrdN62G2Hul6GyoIHMsqAJQK0/51S0n5TCpxDJYNzMyo4r2roC
 Mt+Xx0umCA/KChNyS07HpE+2LU1r+1Va17LtRh7qWXERZceSVlh6QPrLObRAN7MrdkhR
 1acpWMcu6Tb/irk7xGWUcEMkZqGQNYyPqOxzwKZOFvmwVAKsh2WwDkcwUrtKyPRsrQJT
 l3V4LcOEHWhCwV32H55h7r9uBlM+gKBKaOaXsWbw4Dfr6FBdmiZVnKhgBi8qenhLFBKm
 dcJ9eCLLfx/vWBzMJ29dBrTPe+yh8yt/XglkW85w64gWNVejh3kfB6Tj5iUnqs3hIl42
 LIIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJcxiNHseqZcx1A8Ef9pVg65ZVW2gVWmzAnJf4so5FjndLGMJN5HtZBX7Xh+E7eCohmjW7C2aROjU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzw2lAUZ6QOGImA5wORxLa0I4WvNuks8m+nmFOjacldwo1HXG/F
 tfWptNCpxtFQo2m9MDnkj+xwuGhjhS12pEP9BbS8rpZWoV3vO3gI1/gdxOVP5nSA2uwHq8Z/Z2Q
 1AV0fUB4TCHy2LnxXjwk+w0o8w3n7SGUN4ow6eocNS/SE/rzkPV5kvxkVmlQ6TbZuKmdKSSo=
X-Gm-Gg: ATEYQzzTD5SCOtWWtEnU75+NYtyoTMXbR+BzAf76eNDi3XYOSan+KSQ27GWCMPz9eBf
 kltkQ0ZPZuKrL0Mg1oeZX9xoYGUbOLySWTcjyJfGsDUOM2xtLmwu8jaQziA8+JeZ1MvpPEiKG5Z
 4dAjDQG+nmJFuGclte+nE17PcJwP3fkfb90akrITmisViSJ5O4tTv2jIx1cWz7tjkoX5loZx992
 xeq96RlViTl/tgiqeOk3e4JmAyflp4hsHViNNFemfdm7+M+Cmy/FSFQvMIllnilmUcSM0opyQmg
 D+ulZcMxO49x40jQwKpDJWlzJ6dKnMHtx6Fclj5xAMUafYkyH/QdmZJ35ygLwWla7HbWoWAXRRL
 v9BJHg/Bzp7yeVlFtYxflGo4fmM0V5OfmhoPVaNPLDJ5SFrs80vBGz59+/mVzt3SsYCkWhSDWkc
 Ij46mjKiqJjht9jZwsFtghSUpRCypztSh+
X-Received: by 2002:a05:622a:1c0d:b0:50b:9024:53bd with SMTP id
 d75a77b69052e-50ba3818262mr50765111cf.6.1774640860304; 
 Fri, 27 Mar 2026 12:47:40 -0700 (PDT)
X-Received: by 2002:a05:622a:1c0d:b0:50b:9024:53bd with SMTP id
 d75a77b69052e-50ba3818262mr50764731cf.6.1774640859839; 
 Fri, 27 Mar 2026 12:47:39 -0700 (PDT)
Received: from umbar..
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38c837130basm275211fa.12.2026.03.27.12.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 12:47:38 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alexander Koskovich <akoskovich@pm.me>
Cc: Jonathan Marek <jonathan@marek.ca>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Pengyu Luo <mitltlatltl@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/msm/dpu: calculate data_width like downstream
Date: Fri, 27 Mar 2026 21:47:36 +0200
Message-ID: <177463970779.3488980.7047844927903667944.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260322-fix-data-width-calc-v2-1-d5f28136bc4e@pm.me>
References: <20260322-fix-data-width-calc-v2-1-d5f28136bc4e@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEzOCBTYWx0ZWRfX6eM5lCs+CoES
 mgXHyBNKn9Q9nlEdv/wPrqv6ZiqG26m6ArboB8Vckr4jrLUcAVDxzGK+y9YX86Po4kw/DXuAUBz
 TJ5Mv9B00horOpax9fnVq4cibVCUD35Lc9QL279m8nON2U3FVAAnShLPLbe4hxvQiRnMU16cnit
 Pw1Vmtr2JsNUaP7OlMiz82Jy7xXOF8z46DsPymkZBR3gdphtKwEFcU+p53gmvciaP2LWmH6XWxf
 t6ZTEhS7MHRGUn9EKJt5eBxr9JDkZbhy2NfTnWM5Vmfi5lmV7fYQminIlMkgx4JLfGaUNiyaEgK
 QDAYdYNgeqhT3rvxxWCp9Zw1Tt5kNhbzgcBmYQKe+geWvfGz9MLAPOqq0QAyPtrsOjZSAyUkqev
 5TCIKtVM8Xegg7mr9J20G0zm9haqC6ByubFgc5HmlATk0kUXz6HPLCV0WFpIBrTYEEFjRfvt+ns
 s+AZFMaRdjvzMaJjO2A==
X-Authority-Analysis: v=2.4 cv=CcwFJbrl c=1 sm=1 tr=0 ts=69c6dedc cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=e5mUnYsNAAAA:8
 a=-uvraK2mi3rOfbV3l6YA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: bQHT7jdblzHMjjBtK3sYjOK0O_OxEcC0
X-Proofpoint-GUID: bQHT7jdblzHMjjBtK3sYjOK0O_OxEcC0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 phishscore=0
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

On Sun, 22 Mar 2026 18:48:09 +0000, Alexander Koskovich wrote:
> Derive INTF data_width from dce_bytes_per_line rather than
> timing->width when DSC is enabled. Use DIV_ROUND_UP to avoid
> rounding errors.

Applied to msm-next, thanks!

[1/1] drm/msm/dpu: calculate data_width like downstream
      https://gitlab.freedesktop.org/lumag/msm/-/commit/3bd3d4999f6f

Best regards,
-- 
With best wishes
Dmitry


