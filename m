Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B054E606A321
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 14:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PRPttJRC;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WqLCHH7a
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D430010E3E1;
	Wed, 11 Nov 2026 14:47:37 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EA0310E3E1
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 14:47:26 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABEKWOl3510926
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 14:47:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=dSsjgnuER/pCSv8uH7FR/ZRv
 /e/DAvEndVD96ZB9E8Q=; b=PRPttJRCEn04/y6wsNdOgtk379xKjoNFOzGcHCWu
 qvC4QI4zmwRW9km2D2563TeifbHJFBTgZwtFB90qH2noORntULrUP2OV1Z7nexRK
 VzRqE92rVXID22WBaCnPP9HN3vD7j3+42wG1zeddxWQpCnpxIWdQ8Ze+zVjqAfnj
 z23TfpqJHcwq2U7eJcuWviKuQJ43z1EyYHjA9BFQq68qorzvna2G3LcOVPLuni0A
 zw7MG10/IvhL3H/JQHDpR3X9cGjeS6Oy0IivL9S3hd1+AoQe1PQRhbkygr37Mg23
 HXons1f6wVOrII1RWbq1XMLO2ccuKw6ncElv4FfsIfTmLA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvt1u83qb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 14:47:25 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f6f4fe531so591503785a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 06:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794408444; x=1795013244;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dSsjgnuER/pCSv8uH7FR/ZRv/e/DAvEndVD96ZB9E8Q=;
 b=WqLCHH7ahzMGv38EVNwkWQHTLvVn/SyndTcLydEbKeci2zZP+EGRFyMEo+3C5g8X9s
 nSbC/pKFKAO+bBQlj7RIBpzOL6ReNx1FILCwC9LojnX2OAmfxF3Qr2WgiyaLqK4GoIft
 KWWO+PR57tmkIONyjZ3kQDrxZoS7yQRCZBKmbYbFVQwknYRi/6SlCsuZbHMYj5TxPJBG
 TehCqZqmjDJi+wZwONBazRF+p/sNa8piOOvVffCuO+n9azDajexy1ULy4q4kBmJYUIYw
 67UTWx1dGoINRyR1gUfy13xm0Cxg2Db8nOe/gapUDZfCE8hV2fsVXLJY1av5vDg0n2//
 Z03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794408444; x=1795013244;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dSsjgnuER/pCSv8uH7FR/ZRv/e/DAvEndVD96ZB9E8Q=;
 b=YUvL6p290izIg1kMKbh1aJyCE3R2f4f2RRd0/7MiSIBAcQSytIDlWFnUKRalaEYVOW
 hFKPysrucfcAwsronMRZa0c9MvBeM2iGatIvH1TbPLIbHe9VVddmhIgnnDfA+qevEee1
 vjxKqtOhRt+qWLlJkcgt+EHUhLhNXE8lOMAyJr58rhi0lQAQstXTbFx7TuSaHJJMPlo5
 Vjua4wNZv6oXteM9yy2iGogz8DTJX/wejV8lmPivNRaI91aXTFMY13sSTVpJCbH4RCoU
 9Mjs8w0DYGYqd8KYjjFjVHI1e7vdCHzECNHjV8ZFY0zk4Hgvxx7uHHvJxK+evQlgBUzC
 3QAA==
X-Forwarded-Encrypted: i=1;
 AL+hErHdTWXQR7RX7ABMoRUk5eEeXFhiVEM4DyZMJnK32xkM62Lx8u1OBFP272ZzZKDyBtyDOW9In6Bp9Ss=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z907TBQCSqnTbm1FVsFoFyGwsDG7wywXFl2346danx1nxyRaWMn
 i7XmykfnRbX2mKLUq5hCLH7wY2JB9xTCBoxl6BCIo/G2FDWvrV8oiQGgl069NYtlzAla/tfNBpB
 4FQjXMgze6nIoq3qqQBqFy3jzGeqFefYR0ofMMPhXfzWDe5NCvKBzd/4V4e4Txc46EbBwVAU=
X-Gm-Gg: AYBFou0yQdT9gfGNAJ9e0zQI6m8n1BYqv8kZmWT2Y135HWr4tkS7lYkS0YLosg/3yTj
 Z3yUZ/q64W4bF74IH+4cdJW9VJI77jNZPUANXNMMqMopfmefs30VzjnfAps3vn1Te2s1IMXcSJ4
 b+rfzUOisnvZwtQQ3dYm6vaXvcKHuBdexSj/YpcFN9Vk+UxyiAzDLliMSj2tqPQncK5SoQSKZEj
 dFbPek05UImPLkoIVvkYktBweOSbq1ji2NyUQ7L0frtujrFA5FcPMxKr5YMW2TtnRwFkg2HUl1u
 9JfrJrvxUBjLhuTG7F694fiq+kEKOQqg8D4AZOvrqZBFQsZ5C5BM+aQZNoZUHWort6a8yT/nQIm
 R3vXTA7HRXV7Ra+xN94cDTa2ViF/c3DiBdMzFd4id0OYKqlS5IWxQI7EIAxt4PajSOd8wepKDt1
 Y49dcKbVLk2z5ApogleEdwfqrrpsU1kup6rzVZtEEDTi6jpTWMLoavc1yMJSqRwQ==
X-Received: by 2002:a05:620a:4106:b0:93e:c12c:4416 with SMTP id
 af79cd13be357-947b00317e7mr403778485a.82.1794408444564; 
 Wed, 11 Nov 2026 06:47:24 -0800 (PST)
X-Received: by 2002:a05:620a:4106:b0:93e:c12c:4416 with SMTP id
 af79cd13be357-947b00317e7mr403768885a.82.1794408443781; 
 Wed, 11 Nov 2026 06:47:23 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae177150c8sm3338901fa.40.2026.11.11.06.47.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 06:47:22 -0800 (PST)
Date: Wed, 11 Nov 2026 16:47:21 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v8 07/29] drm/msm/dp: add support for MST channel slot
 allocation
Message-ID: <ycikeeqchpswkdw5aeygyyot3c67dso5vn66mhxlexcstnrnou@a2vg44y4rrfm>
References: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
 <20261110-msm-dp-mst-v8-7-d040fb33db5f@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110-msm-dp-mst-v8-7-d040fb33db5f@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1OCBTYWx0ZWRfXy4JsJJXjjRXh
 OCYkni2+zhhJ6PERWosKL56sitiDXf6E9EJE5EUeDcrBzj2cLm6+kXpYDffE5BOXD0sW/OOn/5i
 hy3y5jeSmI9ieLw/AkeMvGqf4PGKfto=
X-Proofpoint-GUID: G5DQ_zN_uW5G4I3rcZwG9EcIP7UNAygc
X-Proofpoint-ORIG-GUID: G5DQ_zN_uW5G4I3rcZwG9EcIP7UNAygc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1OCBTYWx0ZWRfX5V9Yup2gAFc4
 Rp0bfR0fXLlqA9i7fHxu5Ae3qYQmSmFoUQPpShShu413VpYt4X32KwFVhwe9W4E3FNA3PGwfM3N
 M0zgLdGm+2ycOJBZP92nPSLDjTDq71fxbKZSOmXqlOTy9C1kTQENqqJoGykRxSe8QPI6oRmCnU5
 Ha/IZTywumEDuz4TovJyo+xgCfSktI40vKwL9tdISx/Clrudugi4Q8u5GHmXpVxReujUknBq/PG
 GQsqIo500d0JJyLa29VDVzOO7YbcuIe6cvS//zBklkQ+7kGtj7GysygPlUlp38OkH7g09ecfL1W
 ztaBukXt0SQ99iCwOBDaCgI5Zc0cT0TusXA6NUml7WstgwdMmQ9xqzgliDduwmUrLwnWfx88CME
 ZslxWOdqURxOOZXNPNTptporFAEo5WRmZAillzTVu5MNn5PyaTWBYEn43LWoPpSUV8Mrv9s52lR
 ZZSyLf5f2ZF+t7KNR3Q==
X-Authority-Analysis: v=2.4 cv=LvcHWXdc c=1 sm=1 tr=0 ts=6af47ffd cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=pILL0qaYOBIALHQ4VfQA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_03,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110058
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 12:54:28PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> DP MST streams share 64 MTP slots in a time-multiplexed manner. Add
> support for calculating the rate governor, slot allocation, and slot
> reservation in the DP controller.
> 
> The per-stream slot allocation is not tracked by the driver. Callers
> pass in a msm_dp_mst_slot_info table derived from
> drm_dp_mst_topology_state::payloads, which the MST helpers keep up to
> date, and the controller only translates it into the per-stream
> timeslot registers and the rate governor inputs.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    | 147 +++++++++++++++++++++++++++++++++++-
>  drivers/gpu/drm/msm/dp/dp_ctrl.h    |   4 +-
>  drivers/gpu/drm/msm/dp/dp_display.c |   9 ++-
>  drivers/gpu/drm/msm/dp/dp_panel.h   |   6 ++
>  4 files changed, 161 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index 8a2396aec6d5e..0b34db3bd5d22 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -83,6 +83,7 @@
>  #define MR_LINK_PRBS7 0x100
>  #define MR_LINK_CUSTOM80 0x200
>  #define MR_LINK_TRAINING4  0x40
> +#define DP_MAX_TIME_SLOTS 64

Doesn't seem to be used.

>  
>  enum {
>  	DP_TRAINING_NONE,

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
