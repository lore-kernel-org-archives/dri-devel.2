Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6DB5CD6E44
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 15:28:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EC4510F3A2;
	Thu, 28 May 2026 15:28:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="l4JSNao4";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MZW3M7oF";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7434610F3A0
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 15:28:31 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64S8vQaC1562684
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 15:28:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=DEfw1QU1zLzoap1tp5Jhi4Me
 cLeOegImq4Fgt6OMM+g=; b=l4JSNao4lUbVUP+dYFt7BkWVNPvKuZXtpfl1H1NT
 pgelLvw/FUdvH00tLdnbhSvT2BF8K4jyXn0rVhv/RUYdj2NWUHi1cftmyKsrkDq8
 JkjAJXI8VyYfqKjApuZ/KcFfg0oZPBhf7GJUq35iIsAV7O3xWE6+tJbuYSUmnJjO
 jrnmQPnYT8Hw0Ysaw7vrUEZ3MKWQq6npueW/qLjZYR4+4G4kTRD6806Q/de2f/0e
 inxOCcVHJHUgg+7Ub6TKSnAOKQ8q//wGu46ncq3yCMPUpS9PRwYArg1wpZb9WWLL
 H0NQv5+yIl4Ep75djIG0vgrc+Jm5OQ2V8pXYS/+coWrIXg==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7y2uc13-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 15:28:31 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-6314daf0053so5098134137.0
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 08:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779982110; x=1780586910;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DEfw1QU1zLzoap1tp5Jhi4MecLeOegImq4Fgt6OMM+g=;
 b=MZW3M7oFNZ0zFOe6owK9yzxWKyOkIFEZNFi7x8y/mHbjso5W5GGYiohaCT4V2TxmuA
 Rxij/gw+LQjpLPLeMg9GDpzIpx74ljXw0ACQS2kvOCX/QziiasgvuveINwIqZXpYBk9Q
 LDP84P3OzXFOXSIfJgQGRb+PlsXlKjuCx2Uph+RBgzXLMzoqgW+2id8k8Bb4rMoZXCNj
 USSvsB6xvlXvC2GwcQ0BB0e+Q3MTOmEdTCF7wnXS7mZxurD1DlFHCowI9KxbTHWFo/uU
 Qdy2v6H0hMxxr9cGqyP/RuKPfispxXvq4TMvPGZkXSqdAhg9J/xW3s47LhgWX45awvCu
 DoYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779982110; x=1780586910;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DEfw1QU1zLzoap1tp5Jhi4MecLeOegImq4Fgt6OMM+g=;
 b=d2BIlkc+M+9fvNLHAjXB1mnPCI1vcB033WAS0bryQi9svl2WI1WnRFM5X5rDHkJESJ
 fW0HXg4ZlOb8pQi2wl6N9UFW2r7rgjFwztVMGny2657LJC6E27j8RSLsAWa18zN3AZwV
 YTaXzC6+orohUv/NM1EkZdbrXuNYi93Sx1D+QAPgG4uWNkDBDKikqJrjXUgvSVhnkUET
 7eNpKRUDq2SgJnyHmIkHM9CWtYxKTBgQNPGRs8lVf1xRHM2r52M8PCsdn++Tu0m6pbBd
 yTC2ZyrOYJqn9a03JE5xKC0YdAuZn4Pd/FwBocOkc/LTSUf/BWrcsSl2E8Hp1L7Aexaz
 4g5A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/aKTJsUd9TOiexq5+/3aZ/IdFkAB5O7SDSclnjdfb1B8VYnb8gRpv4+dYFHQyXLeokp50p1oO/CKE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxeOS3Vna82kWae+TXyUuZhmpPMYzuRywgaey6pgnurFrMHAkQG
 vn29C1VzfPB3sAf/QKcazao5+QEEmth3/ejV6rvkGZdJ2LBe3AQPCrtJu0TRz2HELfV9WU1+Grz
 W3f2H2+mWYyclYZLbzllwUk23AFL0Gwgw+II2JfjHx+tosg4NJ0toMkvfhGdZBP0CzmoQg4s=
X-Gm-Gg: Acq92OH9aOd0YjhyoWFkNdGcXtdux/pqjmVEcfJOAP09tiN6mToIMA/FSl6+O/SGwsr
 HGuSKKqku3sd/wpMMfL2GBQI41KJcQ8wG0A1R2i4ISefjbeLw13K8wk973zMCY3G8b1Gyfk3Q1f
 RA9+z0M5Xfuc0nDyc+UI83+fqOxI5WwjTFLp6k3GMsqCmS19YLJoM8Ql/e5Bj0LsZ36N/MarmoY
 M5D3iRgVM7wpavRuyDbF4TVJyChoPW060rTF3S9WDPIWpP8JDXH6DeoBcaTOPuC2Ssuvv3c/g5O
 /9Vf7+pnE6GiSTc4EdwNSuFXTrN456UTYtDDynnZfIOXTt6PInwHPNHkcT3Xbsf5kolj+eDuW+e
 dZVZtVH7thc1x7YKDPTUjEZA2GXA5RYRTZ73jPrVQl6f4tqooeoAbVI9rYYjyORVWo4lbkHYVmq
 mehViFH7Xy8rks14aKMmVLMVETeX+dC9KMdIxAE+7iUrfkkQ==
X-Received: by 2002:a05:6102:5813:b0:632:c69c:fbea with SMTP id
 ada2fe7eead31-67c80d6682dmr11492414137.19.1779982110125; 
 Thu, 28 May 2026 08:28:30 -0700 (PDT)
X-Received: by 2002:a05:6102:5813:b0:632:c69c:fbea with SMTP id
 ada2fe7eead31-67c80d6682dmr11492394137.19.1779982109692; 
 Thu, 28 May 2026 08:28:29 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa4aaa8f1esm1359828e87.26.2026.05.28.08.28.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 08:28:28 -0700 (PDT)
Date: Thu, 28 May 2026 18:28:26 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 15/15] drm/msm/dp: pass panel to display
 enable/disable helpers
Message-ID: <y324daiszlubxda7u3sob424qkm2ggtcijymk722gktnxk4jzz@qysobwgu7523>
References: <20260528-dp_mstclean-v5-0-a9221c1f1f3b@oss.qualcomm.com>
 <20260528-dp_mstclean-v5-15-a9221c1f1f3b@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528-dp_mstclean-v5-15-a9221c1f1f3b@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=VeXH+lp9 c=1 sm=1 tr=0 ts=6a185f1f cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=1hnY2tqY8zy_tLQCQi4A:9 a=CjuIK1q_8ugA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE1NiBTYWx0ZWRfXyS0T1ej72Ri7
 d8zBPNE4VwKXZE1ifVoVPdjQQr4Za8chwBh/Uz477jIicasJgS8Uu6O3DOlT+faYa28EsInxf3u
 6Ttf6XT8YNpWTZ0jHJ8BO8NKONMVr4iN7E4Jy9RDUZpauzWmHoX572yduZI9r6P006c8atpnyM9
 9pM2ZE5geat/HGGLe/W3S5DtPMgUSNFF9f8cV02BB+5WSXF6b5nmNxgWYLbaVmANZ6FmoA7KImK
 Qf8rdKJQ+l1rptQWda/wSk604uG0Aex0DhnhPFuHlk0XkGJm0xmtaBrmQuq5m0/RkBiaBYncB2x
 dyRjAm1Gdtqz3eQE9/7XzgL9llW7xp+WuDlR8rY9KhIETRevciaXHhdNZtpqqURYXntKDwapemQ
 eCCdcwfxOL9a/Jq7kILiY5n9fC2yxQ==
X-Proofpoint-GUID: cWC92Q8rrkGLCdyvyDHcTcyqkn0yBYK2
X-Proofpoint-ORIG-GUID: cWC92Q8rrkGLCdyvyDHcTcyqkn0yBYK2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2605210000 definitions=main-2605280156
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

On Thu, May 28, 2026 at 06:40:36PM +0800, Yongxing Mou wrote:
> Pass struct msm_dp_panel to the display enable/disable helpers to make
> them easier to reuse for MST stream handling.
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
