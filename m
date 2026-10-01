Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE1C2CA5FB3
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 10:24:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33F5810F607;
	Thu,  1 Oct 2026 10:24:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DM236OVF";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P0AkV6v6";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D978710F601
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 10:24:53 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6916xXbN2176881
 for <dri-devel@lists.freedesktop.org>; Thu, 1 Oct 2026 10:24:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=aTRbIPT26KO7nuxbcekM6yYb
 y4TZGoFbtjjNV+dBytk=; b=DM236OVFbPuOoWtSklPM6DAj8f3VYstAB3tEKA+O
 Wjp5/uV6SoF11vqScQlDUMDepCGo/dEK2apK7bMs546CXAUUAbh3VV+APhE6aP02
 m+iuww5oWMqGVbZNeyWIrAo8ZSK70FLYqMQknJugIkbRMqRxfAYJRwGo53CFqb1N
 Y/Xn2W6o8pZhChgJMvDzZelWfJ+erZ9t/vZmODRHiJMQRvLg5tnZYKd5+UPM1naT
 bdm6TbKcLW7ZVeWvy2Ax0YF9Pjo+EC+Dudc1e79g8UrGI4I4vLfiyPnQRPhwbog/
 FbTu4NXqoNqrkszzHiN4uUvL00Mg1QyT1Lg46fRVX1TBCQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1h7nsav3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 10:24:52 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-532dc3793easo17426631cf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 03:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790850292; x=1791455092;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aTRbIPT26KO7nuxbcekM6yYby4TZGoFbtjjNV+dBytk=;
 b=P0AkV6v63bsFqvmLB/PYXAVmZkBdlmfzj7SDxFnYolNycmnEM+8sqWf6Khfabtjl1E
 /cySHJqBY3AbX3rhyLaGyjObQZBuve7TEtQ6SS95zx9kbOc/jwyMswxjY+MLxEIdZq2f
 3nKfrlIhcwyWckO51dAw0V27r1p5BEctCU8JhFPI4d86J/DppCbxvHVZJH+N/PosWH8l
 09t55DRsmbdFTW9xTqmdtEVauhdER3+7fsMw4hEdelJjrV7ziUEnOBaYEXijhtvgieY4
 mK04x/PRGhEro6Rs5dWKC6b8OTwUTLiTUTBiDfQq1ebLWyGPS4r4LJ1f07eTBUm2/Zpq
 0bhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790850292; x=1791455092;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aTRbIPT26KO7nuxbcekM6yYby4TZGoFbtjjNV+dBytk=;
 b=r/MGmLrpOLAK6D877SfxISUKzIKYOtEMFK/PxuTlI2h4xDQHxViQ/3SOTtSCF7jKRO
 nAiEfdp9u8rUfSxyUpulk/yHPTs5GBwqH4czpA/gGGppjnVFOhZJ1o00090biNtCp8Mh
 FxvaM0r9OUjkNhHeYJquSM2tyx/aOi5rzK7LHsI6CZ4QgQ0CUEk/aI7Ewz51NBBlavJ7
 akYPT+KillSyIzCJ2kwMkyifMSvPSrdWAaA84ixQhZbOa0wsNqdNQzVBiXFhudR5Izdt
 zqjS0se8WfEihBHXHUaDMNulPuqr6P32JT6Q7cxp7rKFTnGe2kpEbs8KYRJEjnWLhger
 haLA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzopE44P3Q344P+4OpN5YofgUfN8n97t4v4peWJ7C2S8Om6ZSiqbXIhxOtTkP7XWliwLIQ16b0QqG0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lnDDPgC0BTa/42rK2G7BFkEg7zBnk8drd/uRQpj1073/CKRc92
 1t5B8BHStW0o11M3K+UcKr1pG1HmzcDm0AL5rxH8H8lAduTIEJCgX1MCcQ91t7UdSp9p5PbVk6w
 vses/aTnTHRM/kD2tZ5J5hpCEcWypSJ8ktlASCBl4ZfIMkmI4lOoioQHd9x0wlAEg8+9Dy2k=
X-Gm-Gg: AYBFou1KaOcKBC1PLG07PZh8kmz8Wh2utYCgnEbj0iTNefxu3Oxj2nydOFjvuSVtYXc
 EIrUz14QjfYGgk+21WUzdR2OlqQUXLuGm39s6v0O7oCMsHYnyuyllzz66bVFiAhW8go6VGjNRYT
 4e5RRmgwJdkPPaaHT4Ym93tWdZNnPOOdN32agvJsrILXHCuPMNQGhs3jQ6WeDx7hk2SlMEias9M
 MuJ2FDw0cHNSm9P3nui+ye+xScA+DHW1e+6HS31Wz3k0bUKM8zeQZ+QuueJIub7NISaSdMTlK6e
 3cpjmG1KioMQBXeCKhAAgDPjHGA40BplBkwBjk2k11X4jJ3RdCBPAUnRsUbuNVDnToz3PCG5gb9
 f8f0QtgSmdatp6b7TKuLET1kpbNgq2AIEYquA/WzXZsD9f6U5g5NXR+GEE9KsdmldbNjS1RavwQ
 8I6fr9IBiUoLxI
X-Received: by 2002:a05:620a:2956:b0:93c:6e1d:96b0 with SMTP id
 af79cd13be357-93cb5abb8bemr429728185a.17.1790850292249; 
 Thu, 01 Oct 2026 03:24:52 -0700 (PDT)
X-Received: by 2002:a05:620a:2956:b0:93c:6e1d:96b0 with SMTP id
 af79cd13be357-93cb5abb8bemr429726085a.17.1790850291808; 
 Thu, 01 Oct 2026 03:24:51 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a7717f21bfsm14647511fa.18.2026.10.01.03.24.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 03:24:50 -0700 (PDT)
Date: Thu, 1 Oct 2026 13:24:49 +0300
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
Subject: Re: [PATCH v7 05/35] drm/msm/dp: add support for programming
 p1/p2/p3 register blocks
Message-ID: <r7j2cphnlfyt4txpqaxg4lfe6bpf54bvevilywdycuhlzgep4s@ri33yjg6lf3s>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
 <20260929-msm-dp-mst-v7-5-4b81473185e7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929-msm-dp-mst-v7-5-4b81473185e7@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=OI6yTiaB c=1 sm=1 tr=0 ts=6abe34f4 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=IwpLNRGHtxrvbpQtwQUA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MSBTYWx0ZWRfX2ZN7iyMbJkFm
 MmYm5OkbNzHSe8zYCdEtA/URdSAFMD4LJtiwClviaucv53OuYMuk24QqL2o5QJgB3KyssAf4lz0
 ntc8RXijUUav3u3T0JRBE6jZxy0RxFE=
X-Proofpoint-ORIG-GUID: MCq5x9KtRippIyx06EFg0J7sytZ4u7bh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MSBTYWx0ZWRfXz7P/90iaBUNK
 01f+VuzH6oplFyhvVc5yuiE84Z8EiPNT6iPMtLUfWArgPwgT8tIW5owjKFdh+YaoKXTD9NP1pA4
 vV36SmIIZthJPlzItAERJlAozKWOL1rDAL4z49g9xrAxllfmquM2HpXeNWLNAQoGeOPCdot7VWK
 p8VMsSI6l1hJa8isQqc6K9hHWElEvUPoX8OnMmS/hFjR9SJv9OPtv7dS9EtTGvfiUm+5MRHSJae
 BSzEXoU6b4ZAzyuEtBR+gXbSJyVibMUuLBzUVIcrgaSU05LtHkkPpZg6kxnXPF+uZpzVfpFY2Ly
 9O9EPF9GQxDuPas9yWqjbXZ8b6EM5sz79l6dYhP+TMBOQpLFDi4mt597RL1iNotqFEYNe5MNvls
 p9qkRDeDEvHeOqKBlzw0ICMVtE3k/L6uYvf39IOQ03qVV+i9WAiiWIqHak2GO4iDSpXzEhZXaXb
 DH3AuZHBzrv9gvLCYkQ==
X-Proofpoint-GUID: MCq5x9KtRippIyx06EFg0J7sytZ4u7bh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010041
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

On Tue, Sep 29, 2026 at 12:25:29PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> Each MST stream uses its own pixel register block. Extend pixel
> register access beyond p0 to support up to four streams.
> 
> Not all controllers provide all four blocks. Check for optional
> resources before mapping them to avoid misleading probe errors when
> they are absent, while propagating mapping failures for resources
> that are present.
> 
> Track each block's size separately so register snapshots use the
> size of the corresponding resource.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    | 10 +++++
>  drivers/gpu/drm/msm/dp/dp_ctrl.h    |  2 +
>  drivers/gpu/drm/msm/dp/dp_display.c | 56 ++++++++++++++++++-----
>  drivers/gpu/drm/msm/dp/dp_panel.c   | 90 ++++++++++++++++++-------------------
>  drivers/gpu/drm/msm/dp/dp_panel.h   |  2 +-
>  5 files changed, 103 insertions(+), 57 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
