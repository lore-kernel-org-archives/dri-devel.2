Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3301F3ED5C
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 19:01:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36FB110E231;
	Sat, 11 Apr 2026 19:01:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OP1m3gjg";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FwFy/ig3";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6156C10E230
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 19:01:03 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63B4Ble0653374
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 19:01:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=8lAecCydU/DEIXarx6eFr/Hq
 1NW583jqB5z4aHiYQvQ=; b=OP1m3gjgVAaf1Yv2CQ4FXPdmg07m+l77vT6lX6tK
 muCdax8rr4ZU65ZaEefWZJ/uVvTvVoWrDnJ3MOAseZD8Lzeq9VQr7CdATCeW/GeB
 f++qlBddk2BRhZcYJ/3EL/UjKo5xZtY2nkVnMLCfaGfWiGFwPdSH1uYE96DKmf3F
 GrMAm3TY3k0Arv423IgqhBjxDJx5qBE9JeOq+3No+KfMdbbTElAjsLGDz4TIJXUR
 qRxeY0aUHU746OsSZoySQ1Xk0Nbbwkiz++3Wpk0gcmlLcqJv8zKUWFRKUPJ4Qlv6
 rPsvHxWnrz0SpGpDOcwyKjV6pPO5IHw+f8/rn+AA8t++NA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dff2b97k1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 19:01:02 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50b31cff27fso27049641cf.3
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775934061; x=1776538861;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8lAecCydU/DEIXarx6eFr/Hq1NW583jqB5z4aHiYQvQ=;
 b=FwFy/ig3DEv6J3OgH5zXOPakBs45a6tU+gdKi2TXkuHkdGjnAbrgQz6CaJYLnzrNKq
 M4oyfOuM3GRna1upVJXyy6glNFmc2f8NlAtBgxdbM4na4FpmxOqnt2be2R2dGys6KAyY
 SY9hpZ/kkZlHadPHu3F2rYmrd3d6LrXQIV9tPyoa8Bj4BAV0vWgFS1pf+m347KcJPzya
 wzOkqhGKTzrIs+9TWD8A9/xtLPbV1HiQ2CqGp2GN/SuSpGBkCrzHMugddjbI91vOW6qn
 PJSlBKrCgfWbEK1Ca+l7tC0zuuviUF4lOTCgV0PzmiPgLUsoIZNJYRq3xfX+W7P2S8UV
 eoTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775934061; x=1776538861;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8lAecCydU/DEIXarx6eFr/Hq1NW583jqB5z4aHiYQvQ=;
 b=GLtSWWQRG95NJPVQjeWaVuGqzugxMm/oAzjq8wcMZMgtgeK5qHDNspllgCEotO6hsU
 ZINUlRBQYa13nk4GfGR1onxYjdO3zV1mKDO5q5XE7uj/87/SNuASPGerxFXXktRB36YG
 blJITWaxg3r/LO89UMUFkwMpG4PGNwOgIPDHduTVVx2Y2I7H/vxaNB0AuvJsOzg5JFuj
 VtKRZQs8/AhmxXxbKkrXwCE5SUTyxfvKHcfTPn/8qJz6Hs6+9E/vWvIVetvx3Rq9RPN8
 VRv8H15CM0CmD7bOWQJMjal+tysof7yMuDpstZ2q8b6KEdmPXtMLmjbKdsH1e3qkJk69
 n5lQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3LCi3Dtu5HHi8mjWD74+dGrmpgFykZEi+mpbeBSr1xChOBiXOLChehZ8Bcf46PrLU1Kz4NR72TVk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzDupXMgpntMuE55YluTx8aNcWG0MYpkUC7thGj+Z0z9Ox6x1pU
 GIXfRhzPcGNUSqwOjfugV/cOOVAxxjKN0hHBnfGfotkeGY4fdDgbgpd+xOlklDC3KAWqESy7tiv
 PooiGRZvHS1+SPOabD8thSC/iF8u1BNkK0lNWuYKEpl5HMGcASmFaR6+DQZUDTrySlN7dolg=
X-Gm-Gg: AeBDietz/RDgmFZV21CTSsesCGRHElTlM/E9X6y2qQn+BN3Em23QTlc0QXXnuZEW7gu
 3V+01Qr6bqWi9Mephr8mBxlaXjfb/F9tpQNHy8IraexZ9bQJhU4MP9iDWs7IEppBYzNRyZEIETP
 E6ZxGJ4FMAGlhziNbNclvBVQSthMZ88RG+hi5eCBf8pYe8mAvQ36La8zgga/WKdv1t0z7/6gXia
 urF/Io2YIzGUpo+dXEPaDir/W7DgcnLF8CWL+SD4FycHnug7XSn2Dbh9a/EnG5NxTBnqvFlSV2k
 a3b7GF7k6ohk2KOA+pPqlYYTiUOpfpNK9ZtfHs0Q8uiMx3E0IuB+2CwrPYVpKKSio6pCltIb11L
 zKT2F95IMAjMXxu9LLJiLbi9uHbgdf/iGAdvWt88IFMHjjCFpQfo9y856Rz7kBWF9snd+vCBKmC
 ThJLmD1injRb5SQR26i8PP8r057FBeZB+ZwnQ=
X-Received: by 2002:a05:622a:568c:b0:50b:48a6:6ba4 with SMTP id
 d75a77b69052e-50dd5bdb955mr88685051cf.48.1775934060428; 
 Sat, 11 Apr 2026 12:01:00 -0700 (PDT)
X-Received: by 2002:a05:622a:568c:b0:50b:48a6:6ba4 with SMTP id
 d75a77b69052e-50dd5bdb955mr88684381cf.48.1775934059916; 
 Sat, 11 Apr 2026 12:00:59 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38e55804ab7sm8921471fa.30.2026.04.11.12.00.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 12:00:58 -0700 (PDT)
Date: Sat, 11 Apr 2026 22:00:57 +0300
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
Subject: Re: [PATCH v4 20/39] drm/msm/dp: no need to update tu calculation
 for mst
Message-ID: <gicn27nkkqtlipetgwguqrobf34einjyqywpab5r5qdlnuya7w@tvlzlanzzg55>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-20-b20518dea8de@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-msm-dp-mst-v4-20-b20518dea8de@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDE3MCBTYWx0ZWRfXzshFOn2rHhr4
 vRW9m0Gb1Zk2m/JAJk5EpnBm/Qd05DE9+n+i+6byRaVvj2THb8a9dFkrWELTiXQHFDzQ5hZdLql
 /nL5D0VBzp2e5QSehpDp+h1EMIC8Omv3d6MAzoCwlXtBCTUjo6NqmEWjEuUXND+spcX13Ni0JJO
 4YzGY5WrvYhnD+kshhs9tJS8n8JaC5lR3qLbk7JzwszaeK9tEdsEj/on9XW5x5P5uUgF+Sw4h0q
 jDafoNnvQHmUioshOel+2tnuQt8HdDwALcekszymr9l9rOgu0iaNRHWYvljVxtgRmKHnA0Iy9bL
 A8W6ru//K5LBLUJHxAxDBhRm2xv0/EKoXeeZ9iNgdA69VR1tQxbnNnKE7qkSUgfGmv1b/EXjoNd
 1Jn/XcsNo9YdD+sHktrT7UTm0YjzE96VRjLoIDJlO4QsFJQZFktwcQ04+zoKp3sdYMF3i9DzZm8
 yiNow05NbKH1sByZglA==
X-Proofpoint-GUID: wXllVb9OhWzEGBwqZNeia0oETH6fIC7c
X-Proofpoint-ORIG-GUID: wXllVb9OhWzEGBwqZNeia0oETH6fIC7c
X-Authority-Analysis: v=2.4 cv=W4gIkxWk c=1 sm=1 tr=0 ts=69da9a6e cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=u993n8tJM2PNW2rZaDkA:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_05,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 clxscore=1015 phishscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604110170
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

On Fri, Apr 10, 2026 at 05:33:55PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> DP stream is transmitted in transfer units only for SST
> case, there is no need to calculate and program TU parameters
> for MST case. Skip the TU programming for MST cases.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
