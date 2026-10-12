Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5325DCA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 12:31:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1A1910E456;
	Mon, 12 Oct 2026 12:31:40 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEE4610F078
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:31:28 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CC0Pj22088501
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:31:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=h7qMwlSgAt+t7GkDL5quXlg8
 W4SQwFrSXsclHqg7y/4=; b=QLDoTwHGFUkmsvvtd5WYfnu9Q4F49LCyK2yvu+2i
 dGgqwc9qOdFzTCyJTYI9s2x6RwIT/tjtX1JLXVx/c9Xx1evMRgynYJnEDHzSpNqj
 sr6RaxknnrkX4aEvdeM9AC/Ac7Uq6tH4Gq4npUeycVVEtEZWL39CwcAZ3+s8HWxq
 TXPJ5IEXYem699CjJRUNc2ShJn76eiFX1cYcwRkkek8KnH/69nhf6505xMGcgojo
 qIEyzMnJ+PUP9vSW4kP4NtSWj2kOqC8gbXduOEudmDlRnl1ZWuRXy5PKJeOvGE2n
 C+/do2BFt0lpXjmCqcJr1fcJXj72gPnB8PzO96+89JZBtw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8sgu1w45-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:31:27 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93ecdc701a2so200114585a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 05:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791808287; x=1792413087;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=h7qMwlSgAt+t7GkDL5quXlg8W4SQwFrSXsclHqg7y/4=;
 b=G1OfvAWR4bRTIAGnp5D3ks0cL3Z6CAmrB0aO48vHJqTgBcQTTq5qoiIfvnmom68+Fk
 fRRZVyRbRV0j392QB9W01tYM2ZkG5EbXumocbQeKSslMTDJOauRnDxFna3YNUAp031be
 IrdPD9dcsCJyvcokVp//qau1P/MCYUlRYT5G31vX8wshwyIstBbjbmivE7M+pOex9sYL
 J/tNQnHijdztzGZ+7R+paM24dEQ9gpwOkzif/nEASuXI08QubD10xbOedy0yccTasG+h
 rlRpfxqVYxgADc82jd4ItUZPwHnfiOitZ2zun5GVzpkAJ063mlCUXL4pLliJLpPv2P7Z
 ZyUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791808287; x=1792413087;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=h7qMwlSgAt+t7GkDL5quXlg8W4SQwFrSXsclHqg7y/4=;
 b=UyHnLYpH9Pq0FYWxdMZ9hYwIZI1whtyMDGDyWmNtILQW+XRTFDa6F5HaKAI6tZwdCa
 35tVlPREWKydnJUh8yZrn8Rzb+ldTaT4+bx6hAllgRUCPKFR6fUcWXtu2jSGM3YvjpYt
 2gvKa8wxiCUQTsjlj1RB3WHZ0Zmi6G0QyM7YgGHoQOEYk5ZsEXCMjDkaRtQOWLJievoa
 myGaFA1Hs+WxblbXVjV3zqnjtRVv4Lq5KStIBU1wge0BDehKohQ3NLzUGiYrUOitFHt0
 2OLHH71zHg+yPDlVkgJ9czv0yzEVg2e6hUUvfsZ8zKexlZD/fTETh+IBnRF1yhh/vEQx
 axxA==
X-Gm-Message-State: AFq9FYJz4M0HIF5xMUqYVV3z0xNn/3/RRvKFR4nyLcD9gDhoMIwAz5cP
 mM19s9KCbGfZZDWoDhKTFvjBlFCEcybmLEga2P6WOV4uyjlHWy5hnZ0gdxiuz7tn54qEuSemENA
 Td+09PHcZS4ib+x90umGD3+cJcGyG2VQiG253wAouNRBfN1ulGqVSDj6O7qJwtVfht9nBllo=
X-Gm-Gg: AYBFou2SALwdMX4S0n8DsOicbDAyrLMc8rwITm51p/nmlw7yq73C+nmnzc0Fm2RYBWu
 RGFCHPy7wsghCrZd/Zu4D4xvYjCyh4Ofi+D4WMCOFNbRm3sxq2t4qBolpUOh2gg0ivad9kPwxKz
 Fp6nEqCmRU+C2l+c2tUR5rOjxSk657hFnOoDy8kuvACFspcPGsZ9tXyPgEjRndyW4ly4FKLPBoj
 SLmiEQAIsR/htENX2wuahLd6t7lvNXlV6DEf056PPM4taWa4TZBifBBsHRVbtapWAvS9GqdMgjv
 AKp5GZqsB5W+Dq/lj5qI3XqwLh0VeSrfN5SD+rAmHgCH7HlhNLZBDWe490D5r7UzVBunCQXXNtg
 SY+lv3MyD4DJUvrqMDbvtzyKM+n+CusLCoE0GeLcf8XXtXGDOjssvTVeBVwFixSzepugaA7IzWK
 WiStD3DGQ/BwTF
X-Received: by 2002:a05:620a:a405:20b0:93e:c12c:fbd6 with SMTP id
 af79cd13be357-93ec12d07c6mr986750485a.82.1791808287032; 
 Mon, 12 Oct 2026 05:31:27 -0700 (PDT)
X-Received: by 2002:a05:620a:a405:20b0:93e:c12c:fbd6 with SMTP id
 af79cd13be357-93ec12d07c6mr986745585a.82.1791808286386; 
 Mon, 12 Oct 2026 05:31:26 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a9c3cdd958sm28225451fa.35.2026.10.12.05.31.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 05:31:25 -0700 (PDT)
Date: Mon, 12 Oct 2026 15:31:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] drm/msm/a6xx: Split out a7xx/a8xx device tables
Message-ID: <a74ijgv3bfpgd5gqokwlyf72wxgzsc3642obj53m2jjpxg3g6b@loenpurcl62h>
References: <20261010154125.726149-1-robin.clark@oss.qualcomm.com>
 <20261010154125.726149-3-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261010154125.726149-3-robin.clark@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=QdzzLcbv c=1 sm=1 tr=0 ts=6accd31f cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=ysDuX-smLMpIrN7MedEA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0OSBTYWx0ZWRfX4RBZlfdZpVbM
 cI0sLZkPUUrshhDTum4nHe+XCZfnzVTI0x93E12FSa77ArXw3NDfvBkm5L4RxalZ8ik1+r9SxWN
 m/zFkPns9tYNHNKs/RF+81g0ZbWGmBm8lons1juYJpvsgNJWlq1INLsnLpKdubqCQQhmN4X0p4w
 1SBAZmYB3ZvaUKBQv4534TwA6lmpzCDW7lpInZ3oTAeJoVA5EJ1SLsZcSGDuu6E6ADxO7kJqsiX
 GN5CQ8oRGx1hrTi9WLJsSDnwkhtxziJnQLMkWEYjuLSLnriZs6CD8U9PMCKLng7TaByPmuizLmM
 PbXhzNq3qCR8fubTYSYThvtQt2atFEmTeEZrRJUwPAmtqIp5s+X9qOBaNsFKVctmfFJhEtT8piq
 pfmpJJz5lPh57DLZZr9W/Xks/iJGxVWXHaRO4FiQL6NSlO5dDleg4kauIH0mpuoyoxwyPlzgp31
 svcPDTgp3fa6jzit3QQ==
X-Proofpoint-ORIG-GUID: eGJOuWGeO_DhX2Fvq27XhZO1KAVWMvlf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0OSBTYWx0ZWRfX5p9SoLEyctn7
 OJd4/TEElJGIW/g0W4ZdXlGdICZ6+dW5PO/iwYUuve0vTCALBat3A+sXXS3vlltb45wlJ035Wcm
 aGGbleBb5AWHuGYTCUQ4pPLTzya1ZTk=
X-Proofpoint-GUID: eGJOuWGeO_DhX2Fvq27XhZO1KAVWMvlf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120049
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

On Sat, Oct 10, 2026 at 08:41:20AM -0700, Rob Clark wrote:
> This way we can start including generated tables for a8xx GPU snapshot
> in the device table (without having conflicts with earlier gens if we
> eventually try to retrofit this approach, or later gens in the future).
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/Makefile              |    2 +
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 2310 ---------------------
>  drivers/gpu/drm/msm/adreno/a7xx_catalog.c |  502 +++++
>  drivers/gpu/drm/msm/adreno/a8xx_catalog.c | 1846 ++++++++++++++++
>  4 files changed, 2350 insertions(+), 2310 deletions(-)
>  create mode 100644 drivers/gpu/drm/msm/adreno/a7xx_catalog.c
>  create mode 100644 drivers/gpu/drm/msm/adreno/a8xx_catalog.c
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
