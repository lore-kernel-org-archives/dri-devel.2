Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 781D9107BCD0
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 17:56:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDEE810ECEB;
	Fri, 13 Mar 2026 17:56:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TU7NFTRa";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GIeJEnuc";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 718A810E080
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 17:56:17 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62DAmoow2389981
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 17:56:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=T0nHSm5dsiHf9m2n8csKq+6K
 k0/f9mLZIr/QYD6IAjs=; b=TU7NFTRaXxTGeooj91AXOvvZRNc4WKrBy5JMOfMv
 gsaoFFJ/kjqHGtV/RemvQcr4ZnOUmtUMBzWrfnE+DWhH1KjbzVt8CWLLimS1+uHl
 u7N6FrvYzwJ5cKAhWqZXYsC2KPjEqvtWH1EmJr51M2ElChTcV+aoMWL6hw3J9v2+
 qZL/TS1QDiTPRzFe+g+eLK2d96knaztGQqYhzblpB8odfY0hHjRZ+Tdk2VdZAd5P
 eEsNuQtMA5Qm1f4oJ3hDNEkp+qtv+mjbtlOQ8f9W4opAhNIa8EJ50KQJi2eOXese
 va6vv4csSTgd9B/CutefaXI+Fk5Wx6O/iRYLcWow7GRYTw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvh5m9eb9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 17:56:16 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-94e9d49f7c7so24277673241.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 10:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773424576; x=1774029376;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=T0nHSm5dsiHf9m2n8csKq+6Kk0/f9mLZIr/QYD6IAjs=;
 b=GIeJEnucEj2BiI1mrDDWi4f/dosvDH6qerybmWD7U4PoSP5gVef9Y/ZJaBEe6Ko1/c
 g+aY5Wx+GRndDiXrKEZJ9WrRkNA0NR2MvnE96FwNoNcc2WVaFl5TNKczqQFlMsUz7pwO
 kByVK9Zrr+PdgEYpQd/UpimVaYnmTqgcIFc1z0wpYA2RQ+CrsH7s4SddRVi7Jhk9ePTu
 NINpnT3UQKQmwg5iUpaSILPa90pLC2J3fY7o4lmw9+3sQCM4+yeAy4jZr/3N6qUzF/Th
 3n8snxQkkKIzbfmySL1wmAaM2HE1pkmR6sEXwDZeVGtDsUPRQ4y+QuuzKVkTdMoEp+l7
 VJKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773424576; x=1774029376;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T0nHSm5dsiHf9m2n8csKq+6Kk0/f9mLZIr/QYD6IAjs=;
 b=sp2oYCHIw+slcJIyKtqGw6Muoq08Y3UYOEuXkaCx58K231w4syo61hY72wfhhY9TrX
 KwBeba23Nry92yWzOo1gXkYJbVc6clKVcWDyfqnimpwfs8P352M7KdW58u5o7E041Kyc
 /qsEaRBczfYi3YMRbJ2uPeLDS72Kf9OtgV3WuSgvdwZ/1QCubgnvDaFBsL/EWoLOLC4h
 buKrowEsP5k3Fgj4vKMCnyJ/NDRtyaqezs3JrVv02g87SwXslri2vSZZd8mQ7XojEN3A
 0k3HHbrDBiqQpiU+b3mOOAuu2RW+DzU1PoGoepaVTQ0fUsWQE80CTRi0l9u/tZyz7Z9k
 YMvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaJtlj80tSSOTh5CHiyZ2vp5XiEMcurj830wjmTbq6ppUXekgbKp6qLjnAKDHaajs/SBOY9lJdyPM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxV3ff8RZrkU87KPIpd/HXo4SSgCxxBXhDPqvQHzoW8icFJ6Hqe
 Za2CsuJo/UJwENUay7amt2fCZBtRzAz/yhKxPwUtOc2ODGKwNCBuFBVwuicRcZrT7ueKPebIPgo
 Cn+pgrvTcb5fgdYKvFl95FkDax2XhPia8Pp9HEpaYAEXQNDOBLSEI56+XeY4Qv/OxoXdxPb4=
X-Gm-Gg: ATEYQzyTETrodLeaQzAwU/vgi8CYds1JuM6p8hdkRyc1OvNgIrwQG8RfzeDyxhW2dVv
 c95r2bZpLGbhH7wpFjRmwdiNGJfe41aMnQ4x9hvCNtztje7owucQxsDjZTAWE8qGooG4Ge0blKY
 f9uUrYeDVbgwyZI1wZhM2WiER23vgPNrE3UTurmXBqPMi2iMpoOrXVcwvyd8uXxsx/jPGlYylJR
 mHBFqZ/G7OEfgJWyaTbZUblBJ+T1OvHocdh+UGJ8bhGF5iKaA6e3lanTEkzHCS8vY9hMmNYBh7l
 J7WoOHbPpAuVNMaYya7kvWU/+KSBT2aOcjdz/QEmWAKAYx/T92ZzkFiV9Gnuo6tsfpRiysZLKmD
 C2tCAKRxgphAT3vujRhgYXbUAxoIZ6/bvQHlNmOwF6gSKu6Ywwvom5xRrl4t8x5vQH1o2528UMD
 ZQXpFbybc6r0lvlAb+fZ+2iZPoZJFcKuyHxu8=
X-Received: by 2002:a05:6102:509e:b0:5ef:248b:d533 with SMTP id
 ada2fe7eead31-6020e92248bmr2053219137.31.1773424575893; 
 Fri, 13 Mar 2026 10:56:15 -0700 (PDT)
X-Received: by 2002:a05:6102:509e:b0:5ef:248b:d533 with SMTP id
 ada2fe7eead31-6020e92248bmr2053198137.31.1773424575497; 
 Fri, 13 Mar 2026 10:56:15 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38a67e5ebc5sm16479621fa.26.2026.03.13.10.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 10:56:14 -0700 (PDT)
Date: Fri, 13 Mar 2026 19:56:12 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Pengyu Luo <mitltlatltl@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 kernel test robot <lkp@intel.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dsi: add the missing parameter description
Message-ID: <shzdpuesjea5lmkmzu6cnem7xv4adeuk5icp6bkxtxw5jrggag@6aqab5iiqes4>
References: <20260309100254.877801-1-mitltlatltl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309100254.877801-1-mitltlatltl@gmail.com>
X-Proofpoint-ORIG-GUID: GthTICXz0OPOLvI4ug40K7qaqPqCF56V
X-Proofpoint-GUID: GthTICXz0OPOLvI4ug40K7qaqPqCF56V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDE0MiBTYWx0ZWRfX3+DyRTJfJWkE
 d0hMMrO4dd8EFLupNabzVjt7dTHWUHevOpEFsAU7Y7yJ467JvTJPR4pa/pxcXNb+/62KVe1V2TM
 YHhEdYmHqMcQ5sQce0schJE7O4vPk4/U7UMBtPunlrFHii3ijhrAfcHg5HQHAYbOpzwAbFwNAdH
 QnWe0O96fUyHxP1LWUqyvfygp0Oq2gMSZlCgnHB1lC4ddYj/v4f3j1q2IhGsJ2Bs9PrCElJ7MTS
 J/JlsrYVy2fqEv9YykqdEr/S4ozUCjmA80yGsWM6W14hGdWCKA2Fqq4kBvGv4Qo89vZso+XiQ5h
 tS9A//4sBQCBZ0pnduzPIwGPz3nYxEVU4Q1yesf1/wVolwM5c9XdSa76OsUhIRpZGTucTQxw7Os
 r6qKswakVDwpuFs9Ix1DgpCPv15AZQj6lyku03Gh8jWX6ny+mpdeRhHQdDLoGaHM8h9J2Lk2lie
 RvB1mg0/GOZFGRPEg8g==
X-Authority-Analysis: v=2.4 cv=S6TUAYsP c=1 sm=1 tr=0 ts=69b44fc0 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=LJNnJWuWgWF8sx2EOesA:9
 a=CjuIK1q_8ugA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130142
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

On Mon, Mar 09, 2026 at 06:02:53PM +0800, Pengyu Luo wrote:
> Add a description for is_bonded_dsi in dsi_adjust_pclk_for_compression
> to match the existing kernel-doc comment.
> 
> Fixes: e4eb11b34d6c ("drm/msm/dsi: fix pclk rate calculation for bonded dsi")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202603080314.XeqyRZ7A-lkp@intel.com/
> Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
