Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A1E5FEA83C
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 09:43:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E10710E210;
	Wed, 25 Mar 2026 09:43:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XBP0vsBe";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CPUIbkY8";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 750EA10E1C7
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 09:43:52 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62P4f5Bv2807987
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 09:43:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YkqxXAzJzeIBhYN3iFJb/gRp0wjXOhLvLPUgoC0UA+M=; b=XBP0vsBefmet0/vX
 j1RRWDyE9eNAM2F9LOckQO2rzRSxmDCim3Hw7PolnmkE+EJr8/xRapecWBsTOym7
 TtDa4CD0Ynoudf37bIhEtneHdN+cbZu+PZAsGO1AK8HGabV7r6Fq3bpAoWeR24vp
 YLGnOOkm8FwbnpXylj16dd7odocnpi+RD4oMFzX45QxhWuxwkmtMKatgdLeJD+Rp
 MBpBnzncrjWupiLqLqnCdAtGNNCr6LoI7HyKCiPz+o8AOfi0r7/lOP0HzmTcoSHC
 oLEjvA7n6i7PH1SLp58L9Nu9wDWJFAOtSjnsWbfziCbmI366XuT2IjYIjqzyU5Uw
 FE2a7Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3t9eme1n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 09:43:51 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50b2a1f123fso39852521cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 02:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774431831; x=1775036631;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YkqxXAzJzeIBhYN3iFJb/gRp0wjXOhLvLPUgoC0UA+M=;
 b=CPUIbkY8Ali0zcs8gJvOcOXCl31d6LGmmt6cMzUF4T5HJ5yknwkeURBnx+4lEGh2Fs
 SJxyQy3+GEV2sY9JSfbmtxTj8chAfRUibz13OIf5CC9cJ1zN8xMkmxphMP8I6F7gCh+r
 pujPUeRolJIMX1woVN35osxAuOoGu1dAwkdMSSGhkTNqIPGR6KVxaJBGRL9nC4SZz3YS
 A5shWS8MU/6e38+ZOORXPebNul5DfArbjUCD5xF8Z6y/HTF+jS5HfRejFENhVlejMfgQ
 JdjuvObqpHO2F7iSlM8s5x54wNT3Gu7wRClzzs/IEkGeEjn6dEabWtm9yk4q21FUaIPo
 vbTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774431831; x=1775036631;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YkqxXAzJzeIBhYN3iFJb/gRp0wjXOhLvLPUgoC0UA+M=;
 b=XcMEdjBnJ/tQoExFaPCEBXpmrm98yd+qJFraAZLtBKDJUATedxD46YCnTtLR7VWxjl
 ZxuXdTqlISgBnSzzYCjXFmH27O0m02KW5rrxD3FP4BRrhhaWEOKZq1xsKGOxn2e7EUiX
 1jblVOTMN/kDPKLoXEsK8sAJJDuxQZX4zXW5IIesVUNNPtAjHzg4wBIwIQxBY7LOUvV2
 sPI1LUMVSh9k64xSYg2NJjwamPUYjO8Qa86/LRl6/7vGX8XKtNIMZROqRcaLnliwdvyF
 iOdXuqrsZI/mcKw6Jr2N+uOAypCyzoJ1ZzRum1cAunVa0MkOWCMFWt1wvfS2tyGMlf15
 jwPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUx6U+atGXYS+V/LOxjW/jfe5M7XlJCxEzxV1lq2QE5R8g8XxUo+USBvQnlqrEVZJyRJVEPYgMXmMk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz77MvfNJZr9Ix4AWyVBoCbOV+fXgzyFCLiMhBnUaAEC3nTvtXO
 /Ror/QpBFwQxXw002qJ9LewYkfdqCF6rzvHU45UACSsSTDOm1CxpenD2YVbKBAKsVNvuSecdnBF
 4gTxghswj7up1A6h02Tdm+ahrWDT1ZeTbMeblP7vKKoIfcL3ZHZlcypujQvfszxvaJWC0i2Q=
X-Gm-Gg: ATEYQzyxCg/PVZYJi20e7dQIB18BKmd+q8jn/h1cIr36TydbH2IUOEUSb+hzcsvazhq
 YgsWKO1DPZk51pvQSB2ORfYhFkv5A4ZxQfOKtBOe2i8eJto3ZSxH3UTVqGM0BIJRX5+BrgQLBNT
 QDLmWRf6PuXLvVlO5iwKjTOe8k6nK3TF3KhEYdaUBGAJCWlS6uZ5Ml6NwwgEW0sxj2U4YMPBbtW
 HZp8zW4+QS3Kgv7SXgagpwg5qIBqpsCwVGGlTk0DXI+ouGZn2z9dfx0rkvLXZW5pwqLPyvlV9YK
 2ttEeh0QyVbE9Y1mD7XA1bR9NiHEv6P7LUSlbwKABk77Gfum7F3O/AsvHcYiTRTvPwd9+17AZNx
 ze0v9bO+BkWVoxBtEcYZptxnSW1D5PGZ3gY8huhWR8GyjT0pypVzzCwDEMjtnI7Cl4gUrB2FbXg
 LqekM=
X-Received: by 2002:a05:622a:5915:b0:50b:8ccc:a41f with SMTP id
 d75a77b69052e-50b8cccaab4mr3610481cf.6.1774431830924; 
 Wed, 25 Mar 2026 02:43:50 -0700 (PDT)
X-Received: by 2002:a05:622a:5915:b0:50b:8ccc:a41f with SMTP id
 d75a77b69052e-50b8cccaab4mr3610151cf.6.1774431830456; 
 Wed, 25 Mar 2026 02:43:50 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9832f8ef74sm745883066b.25.2026.03.25.02.43.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 02:43:49 -0700 (PDT)
Message-ID: <9d4a019d-0714-43cd-9ffa-5351195c45b1@oss.qualcomm.com>
Date: Wed, 25 Mar 2026 10:43:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/dpu: drop INTF_0 on MSM8953
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260325-drop-8953-intf-v1-1-d80e214a1a75@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260325-drop-8953-intf-v1-1-d80e214a1a75@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: rEHYH8aOVDW97nYJ8iFdCishClKkgc-f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA2OCBTYWx0ZWRfX6sxzbycUQMhN
 bGESkWvraoQR1ZJUZnJ8nfoehWqfcNBztNgywKf0M0XRx8Qh8F5Wc6a5rGeVE0DO2iXNIVqWrth
 kNZQAvekXooBwZ+pY8TbQH0GiylxLfd41PCEj1cKYhVzxngRwc/s0GEeefzR4TJOKbovEx+LhFp
 FKEk9K3aNs7/9AMzvm41PuDTYGsRN0rEuvSpQVQ3ONc8FLpI8t8VdAGeYAotUocvdAx13BdbNfV
 94OmYPl9dvf0SITY+Ek+1tT/KTOFjgCRBbxBpzbYdEsu1ND/jrqjHRcmIl5zZir6G9p+QQahYaC
 WKNMpLswPnpBLhr/5JjNW2GQDIMNd532OtZyBGAbe00pp/krgVDsr4E1q/2tTW1t5v1SkvETN+2
 dRRI04xCxvlb19vML/LLUU6tSV6xU0QAACKvy9/H0eXbSqV8HyUHO1wCnFmFVWU1O+1Z2oku4kE
 wt2nvsyKRjTQMiS2IVA==
X-Authority-Analysis: v=2.4 cv=DdAaa/tW c=1 sm=1 tr=0 ts=69c3ae57 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=hk87uI6hEoqpmA19PHYA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: rEHYH8aOVDW97nYJ8iFdCishClKkgc-f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250068
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

On 3/25/26 6:35 AM, Dmitry Baryshkov wrote:
> There is no INTF_0 on MSM8953. Currently catalog lists dummy INTF_NONE
> entry for it. Drop it from the catalog.
> 
> Fixes: 7a6109ce1c2c ("drm/msm/dpu: Add support for MSM8953")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
