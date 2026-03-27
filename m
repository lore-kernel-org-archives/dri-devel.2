Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72CB110F286C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 19:48:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47F4010EEBF;
	Fri, 27 Mar 2026 19:48:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="d7nzaB4A";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RIMWbgfr";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A64A10EEA3
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:48:23 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62RI2R4v2217739
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:48:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 r1QLyXRj27MaMY6pBuRQygN0tKb2Zs4NcBhaEDM99mg=; b=d7nzaB4AbDk0Rzpa
 JRoDoBNm30Oj/luOHWNJZNL2r+wCc2h8OBNx30pUOScmTR59RxS/ZzcEbUJZzSEe
 aaWRt+PWdd4hWAMSa+Ioo1towrlWsj/jgd+sn60Qxqr79Sr/DX4u1NcMJ3JGG+5V
 O3/d7m2cbOwx2ix5ZYbGjiPtW6draey/gAbPy2WADocNzMP49gH2wjtHmUSwNLbT
 agm9/uRBBkgreGZ1ssyUZGf1VirDWlbBhOUbOE/4UHStbLBO+dnKzhVZgqSUsAkk
 6MC8OnAxso7Dny3P8w9ZXNMOkbv4bW52KzcsGsrbgiTdj+xOQp5jCW3hMPg+Z9Ta
 FSpDZw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5w30rqwq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:48:22 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50b323c43fdso16142561cf.2
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 12:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774640901; x=1775245701;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r1QLyXRj27MaMY6pBuRQygN0tKb2Zs4NcBhaEDM99mg=;
 b=RIMWbgfrU+HuNWhWnpz1a9X4YbfGnN773gJijLOv/VYjzz3rMbhtvBI78J6ydOl8Mm
 5K6g4Nk0+yk3b9YXRfCfbJG+lRz+7WTof1IGUo7+5Os4e5o0sjto/x8xBX09PVuuaRhm
 /eJTzGd7mZ9PmaNe7K9Ypihe2OxTY6KuVpeQDw2yMqCBLeqyI1tkqaxTxIVGssT6zZ12
 VU8t0v9t4GFjP6k/Ceyj3w6FeRH7rgpCWbpEfRhoMPldZAi65R0eu6Nb9bDM3PaTjmRr
 3n0pz9BIf9Pm5/O2vYv+wL98lt1b+c3A1w2MtpUIazPGL9NuZ/J3QUXGtRVugzmXUP+j
 jO3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774640901; x=1775245701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r1QLyXRj27MaMY6pBuRQygN0tKb2Zs4NcBhaEDM99mg=;
 b=ON+8/JGp2sMeCgQjDMUxyfMZvdjE9n/XMvTxzm73YNW/UHWVVY8Ouuzx9DII6E4Tzq
 9bAq0pYfmx3vA3GTBPC86OJHRq9Sim71DQtoEGvkhffcRElnDNtAhzUehKGYiYfNPgoS
 WeNvirnUp20HBc8gf+xBDNXKzjhDbMUC2eq1wzDvXzfgbPYMR6AHN5KwMKmDsfX+HqY4
 ZOo0xkN1tgs+3nkVgEEsf9GuI39mhVbRIKJG1FAXaYaFQpP15ZjS9hRcSyxL84oN8EkG
 wukVN/C7popn89ypE7Ioo1h8GHGCcMFmcxQEA7qm2zrd5dgOojEW2JRQwvd9ENPhUZ9x
 kMJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwBS/jxXjdLGoNW2lEaU3MULLk27JP1YNRRBUTAKYJfoqrPH5pPQR0lb5U85lzD6ERiOWswXk+bsM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw7qFrH56B3/avjAaIcY/Tb86/tYzc+HVgpG5TKok2mWMj/nZiH
 KkTmn2CpnmWLjyzcPWc2BlzjUr3cPIc6rOJMO2PF6Ol60xW7RezNP8Y6yth/lKXIQfuoeiAuVVi
 u6rILDzy4xD/nK1L+T0FsxHYr8qiIlyAX7qLzYRZAK8iMEqyoLxXtuZu5nqBtIp7kNPii9dVKKU
 DfEQg=
X-Gm-Gg: ATEYQzys9LGQnoa0kaKwIIq9Mx+l3n7ekN8W+RlKGs5UZzc3eLCC6P3pT3J1yamJ28w
 QCHVjntAvqpDo0rYmR2zI7huITg/aC8+ViVDaq2QUnUeR/tVZRmpUkSMOVr+bwzDRBtNsIb2hFK
 FSYkbWK+Dhivb8k+EGR2KbjL3mB8Td7x97EN7U2pdykm/m2jHe2jJcIx6aFLQNxcdJcWn47/R57
 VqAguP0uiXQMIIxpXdpACr1OEzT1NhsaZ+6xqz8Mz2nCOb5hyllyUKic/zfHv1V8x6mi4BzTpf1
 7lovr8lYKWo75tDCsocePpAodNVjzEP9dikonPrYMEk1Xg8QY/POhtePVxDQS6rfm2/XW1PNYqM
 aQfCvKzy9cqLSIaqF5m0gTXqkbbRN2lbYyvigfEdmbTbP5dQ7DxToUsaXUOvnlkAHALde4g0vgV
 w/cIIjHz7rvC2vD6RPaLOxsthS76f8Y32k
X-Received: by 2002:a05:622a:1919:b0:50b:5258:28da with SMTP id
 d75a77b69052e-50ba37d16c0mr50594711cf.5.1774640901514; 
 Fri, 27 Mar 2026 12:48:21 -0700 (PDT)
X-Received: by 2002:a05:622a:1919:b0:50b:5258:28da with SMTP id
 d75a77b69052e-50ba37d16c0mr50594291cf.5.1774640900974; 
 Fri, 27 Mar 2026 12:48:20 -0700 (PDT)
Received: from umbar..
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38c837130basm275211fa.12.2026.03.27.12.48.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 12:48:19 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Pengyu Luo <mitltlatltl@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] drm/msm/dsi/phy: fix hardware revision
Date: Fri, 27 Mar 2026 21:47:51 +0200
Message-ID: <177463970858.3488980.8156966621888309065.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260226122958.22555-1-mitltlatltl@gmail.com>
References: <20260226122958.22555-1-mitltlatltl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Dq58NEyLxAj-ukCUsZqcei8ivGjkElFA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEzOCBTYWx0ZWRfX4+ZNbcKYRlao
 VJEnEVuwaIMDvGSLj8Le0V6es44d4JsseU3VuTBlKuYqbKJvIi5hNPrqPw7lNHtz3R9F5VYi6qC
 5e/vT7E75BPegzPYveWHrbXYexJMQugETV2/3o5kZ2e+gYYjHh8hth9rRC538NB9n10J4ECqPOB
 xS3lKbK4dOVsOlU32PcJ/+H6MyjvLvF+qvWcsGLPEa4ZUHdrBtbW5MQcq2uFcv+a6ZJ4AKV9Uuk
 gMilSgJ0N8PNVU8TA5/e2NhW1BHec6hBgzqHlswTWxkuM/lVr+UbMQlWfaoE4pjgyiWfZrvYenz
 z4zFTL1OtMPWm9MYc0BlAAkDV+A/6q55LUplPzpyGsH7lsB+ENt++NSU+Wr2Dl3x2QAFwTz4M60
 vWLuUtOgI7XuwIYaBJ5rkf1p+PMLV6ZOcLXZzHTYCMptyTwWTRsInUmdFMqlHj4NnY6cT6l0kV4
 j9eJQl9HaRMMOCqyHgw==
X-Proofpoint-GUID: Dq58NEyLxAj-ukCUsZqcei8ivGjkElFA
X-Authority-Analysis: v=2.4 cv=F9dat6hN c=1 sm=1 tr=0 ts=69c6df06 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=e5mUnYsNAAAA:8
 a=aYwKvdfGOulTxFBWdnYA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
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

On Thu, 26 Feb 2026 20:29:56 +0800, Pengyu Luo wrote:
> This series fixes hardware revision for DSI PHY. No functional change.
> 
> Pengyu Luo (2):
>   drm/msm/dsi/phy: fix hardware version
>   drm/msm/dsi/phy: rename DSI_PHY_7NM_QUIRK_PRE_V4_1 to
>     DSI_PHY_7NM_QUIRK_V4_0
> 
> [...]

Applied to msm-next, thanks!

[2/2] drm/msm/dsi/phy: rename DSI_PHY_7NM_QUIRK_PRE_V4_1 to DSI_PHY_7NM_QUIRK_V4_0
      https://gitlab.freedesktop.org/lumag/msm/-/commit/18417122d6a4

Best regards,
-- 
With best wishes
Dmitry


