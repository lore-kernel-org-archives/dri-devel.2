Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C76310F286A
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 19:48:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C59B310EEB2;
	Fri, 27 Mar 2026 19:48:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NRxfgf8D";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AM8qA6/4";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62AED10EEAA
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:48:15 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62RI38Uu1010744
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:48:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CX8uk/deE+IttTZxxFSYHlKc9P9/qNs109M1AeIX5jc=; b=NRxfgf8D3HxsVLSL
 F7JpJ8+IXoXAjY3zyAym9VLW22xZdM0qWzFwF1RNjjLZClCcVgRbp85nbBrA0iD5
 j5yNnz7ZDFL4z8nAFFnvFoguyfHX54IiJqqsilE7wvW1yCNcJbfnp4p6L2xOI+3E
 0N/mmmk/domQan0v8suk9zlRv3CD3VPwoe4SO98aG21dZb83JMIuJ1EVwAXHtsTf
 P5jwKyVYNfEjmhXRHmfrgo0GRPSJBF/9FsJZRlbhXidlhOOHrKl2QEUFkuN+yJXf
 ZCQXVqBS2Kz8B+9CHi23AgiX/rvpYHhpaTUPPq9Xui7/E1UiEPoa4snvtEWjkr1r
 J6nSDQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5hapuhkb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:48:14 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b274f94f8so2975661cf.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 12:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774640894; x=1775245694;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CX8uk/deE+IttTZxxFSYHlKc9P9/qNs109M1AeIX5jc=;
 b=AM8qA6/4Mgw7JczcsGXXqXJ1U40L8+H8j5lgmBXyyDxKJHQonNoWeBcfu/OFCzM3s/
 7y59b8JHAey4CEnLeeFQW9tPvPaIYwMeUOgULlnzQvnYhfg56yTwGxRZk5cYMT4HoUW8
 /qUsPT/T6WtRwtsSFChtwVzgr22M1qRNtQYqHNQ5iHDMcdOGUMekXhoUwNIG5jB0Y5A/
 o61YDXVCsUZxP0AbaXWk+xs00C4DyLsczUbSPXvN1he6/ZumRhPdn7jVvgQ4PS2ov4Ze
 5VWc8RzeZt4IosgtLDPLDf0Z2WIKakDgXN0nw+xEDmsoUVUatqo+P03Sw1OFcbVQoNn5
 fl3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774640894; x=1775245694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CX8uk/deE+IttTZxxFSYHlKc9P9/qNs109M1AeIX5jc=;
 b=mZh73r9MmNI64E5XDXsNjZPG/BongjZwqmocfLDEjKdSqdSvxBSyOSht398dvYbUfz
 lFAif38N5cy4s5w6wjSwEpTyWWW87Hyvy15Hlu/d72RguZxmHxqFU/Vcr+oIUhP2PHFg
 HQurRt//5eQcSuBZGTZ6I1tDWFovIxXFuXY26WrmB1Zv2oL3VGP/gioijtR11ZPxwFSI
 693WoOr5p5oLyX5JQRv69G9OaM0R/XmKNSnAogQYNog5BbGsCnW/W+iyR4AswtjDU79P
 /QG9XlcWzMFvMrsnlnLqEwDSTfdpfMD9LsCbERLxcMeciDUbQPTN022bTRdP/DM8RElK
 tzDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVGvmpQZZUiEdYpmfRfKAhB3KuxPNno9aSDhT4A9w4S6V3jlVYPhLY9rAy2joQsp422v3wlaskWCE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzb0Y/m9PkEdZG0PO21LOYApnqZUzr3U75ENiM62887F8iyXyma
 Kii74XcPTXs3/328STtdVITCBqkZh7ZSrNUCWvhTRumcB4liOIb23V5PZZyBH2sLRmsWLkgJhVa
 LG6jVXeaaZjmmLWFfnl2bFpwlwujJJ6pA4ip+93gtl8ksreirzMdM/WX8zX7cNZPemSwggzY=
X-Gm-Gg: ATEYQzwZ+c3ZtV50jTvQu399uH7C9GNMzddNwxkTQYyfPYQIJtKA6lE3mEFmkOljriN
 paxAqA69nA5RTUrwagwDt/ZfRT4oxbLFHTLW5vdHa9SszMJknLKmwQ48Nc/JvqNvag46CW6Gbpi
 1r09gDAWGTLab0kjSIFguSfy1ZcU6uOhhmXowkiro3mnnOXb+yDqWsU1aP2CW16CYOm3E5A5l4y
 R6BOIZtprMTZ0gzhiGl5bbfGSyKNov86F4p5RmzjH4I6h1BzLSRoAptWCsA3RB2PKhLb3f38E6I
 JyZaFWFTg3g7orUvqLGZROA4/F5v2vNerOaUW2PAP5ErzZhf3UFWyD6mBAN9AYiwioOvFsOU80K
 q6jHVFWcFtcxKCn2dJj46jousbQrxiN7GAHp5m04U3S5HPZxhki30MEvGHbuzp1dwx000vfmmf+
 fy/ewU1vAzvQYavS75gumDsAQ/qPi6LFh/
X-Received: by 2002:a05:622a:148f:b0:50b:6d63:6a2b with SMTP id
 d75a77b69052e-50b9938f7c0mr83369751cf.2.1774640893894; 
 Fri, 27 Mar 2026 12:48:13 -0700 (PDT)
X-Received: by 2002:a05:622a:148f:b0:50b:6d63:6a2b with SMTP id
 d75a77b69052e-50b9938f7c0mr83369321cf.2.1774640893378; 
 Fri, 27 Mar 2026 12:48:13 -0700 (PDT)
Received: from umbar..
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38c837130basm275211fa.12.2026.03.27.12.48.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 12:48:12 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] drm/msm/hdmi: Simplify the code
Date: Fri, 27 Mar 2026 21:47:48 +0200
Message-ID: <177463970797.3488980.14162026767517145036.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260311-drm-msm-hdmi-cleanup-v1-0-c5535245f6de@oss.qualcomm.com>
References: <20260311-drm-msm-hdmi-cleanup-v1-0-c5535245f6de@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TqnrRTXh c=1 sm=1 tr=0 ts=69c6defe cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=e5mUnYsNAAAA:8 a=3TOqmCBAsYJkxzvhossA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=a_PwQJl-kcHnX1M80qC6:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEzOCBTYWx0ZWRfX03SAzhK2qNpe
 OQCelnKcI2wrA4t7XrsyOsybMjMBp12368alPvPVmZsG7jXa98GZn9FffB5EDk0ZX16Wc8N1IP/
 3+TyVaTshZJMfWD6olenFFrHxj4MVKhNnKDRuLpGcxvWKKDeWoUUinAebbwPwoluKqptsKPiY+G
 DPcIqih0y/06Th3Kmhv0kx93k7IQNO8JpRi7F5WA4n/EFUXPSWtPrEgle2km6mYRXJNzEkYsoH1
 ZTgp7PmJjRrCYoNdtVanZEF3SCX7ZZvyLPl4q30p4xihb9lyt1eVJGSP5N75qnXF2A5rzWVc0UZ
 3YGAKikquSecNfdSTG18XMZwx7w+wzCqlnsEf6NqvlwBogA5L+545HxS/awXv88iEpIoxtHSOyR
 A5nrl6mv4H6vr8IHkM3f+VOYk12uBs9qjmik/CFVwDcrOKMEWya/ZOEVs6cx+OeXfmvYa1R613+
 HHFFop8M5FEXkMqGXcQ==
X-Proofpoint-GUID: s5Znqd4CJsu5DBD8pc1Byghh3wvk_qAo
X-Proofpoint-ORIG-GUID: s5Znqd4CJsu5DBD8pc1Byghh3wvk_qAo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501
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

On Wed, 11 Mar 2026 21:17:24 +0100, Krzysztof Kozlowski wrote:
> Few code simplifications, without functional impact.
> 
> Context based (dependency) on:
> https://lore.kernel.org/all/20260311191620.245394-2-krzysztof.kozlowski@oss.qualcomm.com/
> 
> Best regards,
> Krzysztof
> 
> [...]

Applied to msm-next, thanks!

[1/7] drm/msm/hdmi: Simplify with dev_of_node()
      https://gitlab.freedesktop.org/lumag/msm/-/commit/5a9a712b0b00
[2/7] drm/msm/hdmi: Avoid double error print on msm_hdmi_get_phy() failure
      https://gitlab.freedesktop.org/lumag/msm/-/commit/ae505afd62f3
[3/7] drm/msm/hdmi: Simplify with local 'dev' variable
      https://gitlab.freedesktop.org/lumag/msm/-/commit/69c68ab38d67
[4/7] drm/msm/hdmi: Consistently use u32 instead of uint32_t
      https://gitlab.freedesktop.org/lumag/msm/-/commit/bc11794cfe00
[5/7] drm/msm/hdmi: Drop redundant 'int' for longs
      https://gitlab.freedesktop.org/lumag/msm/-/commit/536d2eb2bf87

Best regards,
-- 
With best wishes
Dmitry


