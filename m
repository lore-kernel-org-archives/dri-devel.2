Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6504F109190B
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 18:50:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA8AB10E9C1;
	Thu, 19 Mar 2026 18:50:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="U1wjO0Xq";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ddf8Wm7T";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3564C10E9C1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 18:50:42 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62JF3bjU1898557
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 18:50:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=AEKbVxq0+305him7b5F35pLy
 V0Tx3nZX024zP7gNeRc=; b=U1wjO0XqmefWjli51IOwKGrJNCZnutIHN9VAmyyo
 f4xjAzusFjDmap4aPMe+qrCDvqiVRtNCDcJqn395O4OeKZcWdlXJOL5pvUe6BpBu
 RT221xIlfXeJx9XM4ZlufdvGAynl4wlozp/fYIayDWrrOijeqOdYbBQHmwaJRww3
 3gpqSrUtcn8pk+L0tBCoHTl9fZhQxYY3ugkGsrqTsvvytpGIPYaBd5GbGn3UgvkI
 /J0fXc1ErtgB/TJ0vW6JzkOs+P65ToRzZnnse0Njn0M1GLaEjkedsjYCs+AXSBub
 HyyUHtJapi3azFBIHilmCFdHeLSn4ggJqd/C/lyqMeehQA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cyyhgcnv8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 18:50:41 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50b3544bc7bso5719541cf.2
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 11:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773946241; x=1774551041;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AEKbVxq0+305him7b5F35pLyV0Tx3nZX024zP7gNeRc=;
 b=Ddf8Wm7TJzgpr+XoKPtS+V027zDi+ix6yjh0QJOUL33/h1J9+3qY5WLITNE/8fqVfn
 B9AuDXA1JOXm61+07SR4oG7qGmPxxyZq2gV+Bqf53QTbYfAiHPbK3Ygl3aOZKStmIYzb
 bS7Oq37JkrU6X/0IQgbylGUwlFZ0K0rfK8XuBtSqG72HCFn+FG6wGqcaltb8lhzEpjUi
 GzX4vdxrYgJf6TGFZheHNqGHMfHUcZOKOJS8BYowrrkniyAYiLppwpr6NI2AJxJI1+Cx
 JgshyHa6GoE8b0Pb5otOmEvPurx5gfryyBauzfRASHU6RWxj2nGH6wMqUB6spmPIZ0B5
 HGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773946241; x=1774551041;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AEKbVxq0+305him7b5F35pLyV0Tx3nZX024zP7gNeRc=;
 b=a6EQXL7I5+pvdL9psqgNxd/xjs6pELCHW1J4e6US4RXquS0314OK2KwLUF5jsDquW0
 1hQkZIqBzjpkb0lKFf8CBEinSrhQ3I2JtSAOHGebKjYu9BKwddqtB9mHp3uziqXULOON
 GljYGR8K9K+IZ2QbDrHWaboXgeFIiXCIMdnxKLvrdGSAibvzYBMvF6l53HAXiKX/9D3e
 LesvYqZnNWXfL1zU+Yc2XyYvqDaeKSa5NbET1P+UQnQKmBSMMGwwm8ocOqNHkd1zT7LS
 F6M6WBMmxyteOaVti/5nzTxEjZg7LXCWSbl1Sg8jfczlmasBK2hrsOAJaAGq+Hx5QG5K
 S/dA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMvL91GNvINoX6vCGlxolKTmjmijM6h8QQtavd8AdPB3bDs6t2jjuzzJ64D1Ge71/CHv3YR3o/hzY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzqt98UfFWTmDcZUCrRSwdB7MaG20r/l6bKyeAz5kDtQHoYzvZB
 DkPqxOCuSk1vM6/NLWl+l3W8PaA+9NKbSbANNTvfhb5DmyD0BylWefjyCVV2Hxik3u4msA5VkwM
 BgeiVndk2QvffhOu/rNp5JhqL5O8mVTSasqwAeKU8J0zY4BM/CWbS6xcigqudVQ4OlIsBpro=
X-Gm-Gg: ATEYQzxFUifEmMLnivrLSNrQYFX8IlnQtJTopyQD6jLX8iKU+8wgA650aT2YC230jji
 OlQVQKtCaDxDn/ExLsWzL0PLGzn3lZl3UaTOqI0etq5eLbTh5Spt98jBmQBOeusy3k6HCaIzUrX
 fQw4NgbKcPtd4oX+W8YNaSgeNDiiDRAnzu5ntNtD4+Shm38Y0fGBA8xeFrzezkqazcw1tBUPDWc
 Ejj4JaWry2IMiC2PdkVU6QE03WpwnMXNrS5mrwPNz2iBeyQoftneILfn7OFNDjr6Cuo+8bsNERa
 oGx7wJ+hl/JTR1Fi+VY/hwEUOV2x9OJ2YxLlabJuO/CgWI5XIqB5mRHb4letW9vVjp0OJCf5zqE
 2j3tl9Lr2uSPSNhwn7PypJlOuxbq3CaO2BbxXiwIc7lGGUR2+01v0TB7XfD3U2MAr+ry4HbDNh9
 L8TBaeIHnuCwOmA6D1D59+j4f3pdHfWF4vl+o=
X-Received: by 2002:a05:622a:424b:b0:509:1e69:9843 with SMTP id
 d75a77b69052e-50b37460c7cmr4401971cf.31.1773946240658; 
 Thu, 19 Mar 2026 11:50:40 -0700 (PDT)
X-Received: by 2002:a05:622a:424b:b0:509:1e69:9843 with SMTP id
 d75a77b69052e-50b37460c7cmr4401631cf.31.1773946240049; 
 Thu, 19 Mar 2026 11:50:40 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a285207449sm68555e87.44.2026.03.19.11.50.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 11:50:37 -0700 (PDT)
Date: Thu, 19 Mar 2026 20:50:36 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Alexander Koskovich <akoskovich@pm.me>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH v3 2/4] drm/msm/dsi: add DSI version >= comparison helper
Message-ID: <xq4kzhi3eatjnrpcb3oy46lt76hlv4zxo4bopt4emzctlmm4dp@ke2onr24eha3>
References: <20260319-dsi-rgb101010-support-v3-0-85b99df2d090@pm.me>
 <20260319-dsi-rgb101010-support-v3-2-85b99df2d090@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319-dsi-rgb101010-support-v3-2-85b99df2d090@pm.me>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDE1MSBTYWx0ZWRfXx93R7HO2dYPR
 yqEaVvgZ+q1C/wx46qokq2Y3UnLYK/X37M61h4HD0e+yAV/YoJLyH+qlyWG2Geuyrvl4RteXZWN
 /ec5hEs/U2rC2tunH06k+2rbsg8cN32cPMU/PkUJ+EisV7zE35lqzwRVh91+qeZyJRJ47s07Li3
 OcGh4PPbNSXd6l8Wr0HikVsbxWLbbwWjsBlE64Zh/r6YU2jXKEtUOZoBXCam7PH3OiBI4+jI/Ht
 M/M85djYkZY97/df/GMxDrfappc4fN1+iAA1HC3EKeSsKTZPJyhR65WLZjyymJbuAiGs5Ytj+Zl
 uQe/h52UXXOiiDW5uX0yS74xIaUH4nRmcknEu9gHGS0ctAaa0waDLgiTgTtAWe18b2tIDaIEcIV
 CdCwbhPq1eQOgoingoIZeEfFSKxY9iU/qpY6qZfh+qrCcttuS04/Yx6H4UjoiaEPFEwH9VP+opT
 YToG1lfmhl6wOW0/F8w==
X-Proofpoint-ORIG-GUID: FoGEOaHPjrF7F3rG-DmvdjoHUafy4jBR
X-Authority-Analysis: v=2.4 cv=IbSKmGqa c=1 sm=1 tr=0 ts=69bc4581 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=5JqAs6KO3f-WYDA_-g0A:9 a=CjuIK1q_8ugA:10 a=zgiPjhLxNE0A:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: FoGEOaHPjrF7F3rG-DmvdjoHUafy4jBR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_03,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 clxscore=1015 adultscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190151
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

On Thu, Mar 19, 2026 at 11:57:52AM +0000, Alexander Koskovich wrote:
> Add a helper for checking if the DSI hardware version is greater
> than or equal to a given version, for use in a future change.
> 
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
