Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 246D1CD8C85
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 23:35:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4175910E8D6;
	Sat,  6 Jun 2026 23:35:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="h4qDeUmS";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="javUVi9o";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9979B10E8D6
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 23:35:19 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 656NNY712746851
 for <dri-devel@lists.freedesktop.org>; Sat, 6 Jun 2026 23:35:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rXJNFsH8aL86MjkObeWsqWpUSltJWzxFedx2j+xmyvI=; b=h4qDeUmSqd9a3p3f
 aclEinjnodrcQ+/BXxEWU3g+oypXSYxEMKeRJR4Oh0/Z4hif997HWcGkiUQqfJwV
 joJ+P2+El0f1HAhgud9vEwcxz900VmsOnqLlAjdiF4xPb/MTWyZHhpL33/OgW6fe
 7lKkyk/ipiboRDKwOJ+4nRAGs9xoq4T0/erolFqYJo6lrKGeKLEE8Uxu5LCNxJHs
 sGJKMpSG0dUMsJ3GCtgHGnknfYCHavNwHid/qvdL+SaSJoe1iTGMWvszijz8e1ZZ
 jByk7T3XiFnuL4xSjeS1XWSJIo1ebM/BMo/j1f+E70Gbm9uaBr3rN0XOe78QAF7N
 aah99Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emagraqg2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 06 Jun 2026 23:35:18 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5178fc89b1bso37313311cf.1
 for <dri-devel@lists.freedesktop.org>; Sat, 06 Jun 2026 16:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780788918; x=1781393718;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rXJNFsH8aL86MjkObeWsqWpUSltJWzxFedx2j+xmyvI=;
 b=javUVi9oJbimOKppfzZM+XqypFCbmWPBz480Z+ehkQ0bimDs4PhjNbyLelgLelgBTO
 kMGn/d3IoWVVEvEhG201GQEq+LThP3+PPqg1smaqytUBlq6KVj8DrZFz907l0IvdwWD1
 y6WsEPiwbARmHf/3+n+2/zXg8AL9SyFvpAd1bkLCnOLnuMb5DFNL1659FVronNmo4JC3
 sCsgmkVoCgBcpNfQ2Sm505NlGp9hm1te4zY7cTCUuTfk2lkUbbB3QJlKCl0hDuRDZdIa
 31Qbz7KLUqfQseNHkhxUqLsgX3dOuzgr0tP11J3HT6XTVj+RbPlYluXaqdvYnMP1VXV/
 qTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780788918; x=1781393718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rXJNFsH8aL86MjkObeWsqWpUSltJWzxFedx2j+xmyvI=;
 b=YSjAnlA2vWxBZu9J79RNQFblg2dBA11G30rVsOWN0NdvXXIhtq11fpeZ0qArSOLYs1
 pDzfJpTZmC97lyYQkuCUzJgWzgx8X6poV2su0vV9H00i9D238rz3J6wO4p2myaBXNt2l
 C2m2mz282isjL5ZOKSJjLfqODfbo8GNPrntAjbqQgw6tGyvqqaXowrlrYHSJUXN/g2+8
 dBbhomEAiMhjyOqB1fIj2aI8wD4w0W+q/4C3Uo2/OUdD+UXGP7b7JAYw5ECEAmUEcXhG
 YB4IDwxa7ltf3qwWPOD/Kp1Yqp9R5NcNZMxBkrRhBEgDlNLdMbbCovK6pd8KeDJvFMVW
 pfYg==
X-Gm-Message-State: AOJu0YyaxzQHEQFDkAnujD6qvAoyuRrfCqtvLRkY46kf9k4b5wIvnpc8
 nWN8wlG/AIV6mFMVJ8DponK+t8u9Z3FHjwTrm4SLY/gAGlI/fIpnP0kMnFzpeVW7rNMZuv5OCcA
 HmZxkW2jGv1E5KhHpeJvHUJLm9KNg8K3g3mDmD6n872xjsQWltg/0kpfBi6mFy4EJTU9f6EM=
X-Gm-Gg: Acq92OHcQfqXqC8L2KvZE90jb3Sb/uxGnrelxz+ATcNOW0W1dIYRfwDEKJnhyVw+aHO
 6RiLJVPt1FGK4pcTxtuSCJFxoODau7N1qKzcmxkpbWjt1r/30uAARWULMHVtW1oD1MKRUIcPpoC
 MG+FgLv7SCJYGOYLwVEE5pfUnlofIgBhR6ri9HoG+sZrQRoW5WpRuLJmReblIgS0uKM/EBXMnqA
 K0PJ/ylgH2NC6E9DrxaRU+nSQOpF7ln0XjoLOec7h5frzcZ2DrWVMbfR1G3Ru3fTPFsW4emkt7h
 V+j7NZB2FrzOmBilRThEuHfic91xoSqG2JzhSwJ9dkJ/m02nXUQ+qwlCCtHKwH06GYnzdUu3Fuk
 GKd2VBt9uA3V3QARuH7y+UeifvAtXws0v9CiuKNYdDAcMY3vdmnPcl2ajXOPKZyyiADEQtV3vUd
 t990aTyAQl8km+Fgapb0S3RyOIS3uoMk2Ex+ugGroN4TcdQg==
X-Received: by 2002:ac8:4809:0:b0:517:905d:dc78 with SMTP id
 d75a77b69052e-51795bbf697mr92469051cf.37.1780788917787; 
 Sat, 06 Jun 2026 16:35:17 -0700 (PDT)
X-Received: by 2002:ac8:4809:0:b0:517:905d:dc78 with SMTP id
 d75a77b69052e-51795bbf697mr92468731cf.37.1780788917355; 
 Sat, 06 Jun 2026 16:35:17 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-396ac2be00dsm33444051fa.24.2026.06.06.16.35.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jun 2026 16:35:14 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Alexander Koskovich <akoskovich@pm.me>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Jonathan Marek <jonathan@marek.ca>
Subject: Re: [PATCH v2 0/2] drm/msm/dsi: support multiple DSC slices per packet
Date: Sun,  7 Jun 2026 02:35:11 +0300
Message-ID: <178078881776.3945820.15306822216752040775.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260318-dsi-dsc-slice-per-pkt-v2-0-0a1b316f8250@pm.me>
References: <20260318-dsi-dsc-slice-per-pkt-v2-0-0a1b316f8250@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDI0MiBTYWx0ZWRfXyiLCpOet/aZd
 rZTyxy/pjOtpIT/8C8AroseVKTwSLl5spa5V9Qnllq+xypyf9V+iQI9ysak7R/lmAJ0IDtvHjqU
 tKuFxc8G/aHK1xqr7IPdfsEVjJQdhhgowc/WUULY2VBYnJBongZ0XMqNJVbqkhLJEt63lGInBoS
 xhSlz05SQOAUFHA5sIv/T4MXl7FTKSj7USDN89EcqFTI+tZNZ2HOBY0Je2u+zJk78zIi9GvyYOx
 jBMVAVm6loZ6tGqCHo5zC1HokSB94hYnzFieGO/9XybVB6gOm0ZK161b8/1nS6/4Wn5Fkp6mAQc
 VIhHBNiSY3RyjK05RVcL+SqorRlDc6oeex23F7dx77KrF/+RUDuqAHcYv/EsUSiIQ7xh/o96qqh
 cVHhXcbgoCy6DK3jX02uOVf23Oq+ZKVYJjdbDo1NWpsEDU+Il5MnPeamMT5B0KAUemzQJML0+kW
 t1ZreuxIukMMWdJ7SKg==
X-Authority-Analysis: v=2.4 cv=G/4s1dk5 c=1 sm=1 tr=0 ts=6a24aeb6 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=_DFlpnaH-P38sxYvpb0A:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: PKTPujHYtZPRlXqST5qIhxviwwwhZkKI
X-Proofpoint-GUID: PKTPujHYtZPRlXqST5qIhxviwwwhZkKI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_05,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606060242
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

On Wed, 18 Mar 2026 09:53:59 +0000, Alexander Koskovich wrote:
> This series adds support for sending multiple DSC slices in a single
> DSI packet, which is required by some panels such as the JDI LPM026M648C.
> 
> The MSM DRM change was originally authored by Jonathan Marek [1], changed to
> use an 'all slices in packet' flag which derives slice_per_pkt from slice_count
> instead of manually specifying the number of slices per packet.
> 
> [...]

Applied to drm-misc-next, thanks!

Alexander, it won't get into v7.2, sorry, but on the other hand you can submit
patch drivers using this flag with the change of everything landing in 7.3.

[1/2] drm/mipi-dsi: add flag for sending all DSC slices in one packet
      commit: ffa88de8ddb64067df49e4d9f253d09a9c247059
[2/2] drm/msm/dsi: support DSC configurations with slice_per_pkt > 1
      commit: ce73a5db44e3d5f9c0c061f0868ae209b59605f1

Best regards,
-- 
With best wishes
Dmitry

