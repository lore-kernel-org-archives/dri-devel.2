Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F721C5DF94
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 06:12:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5318B10E0A4;
	Mon, 24 Aug 2026 06:12:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bDJ9mCE8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ef7yAbXV";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A58D810E0B9
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 06:12:29 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67O5RImV1848428
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 06:12:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UEFTefeAsv2qh5vvlMQhjsN6dfN8Sm6dSGVONX8CTCI=; b=bDJ9mCE8GtJiY+1O
 1eSD2GI5q2it/1mGV1cvqkCCrnGpxYvbF8Cem+kOFSzos3lOrWWfs7n6X1elvu6G
 nk9A+ZyD48tHJ8OINfvmSkCZ3AKB3ZmuLzEigWNtGUyJQ7Dkhu1Wp3JSfkmoJMTw
 GyD0TGZlcATAGtvaJOro0dST3ENOC+58Sr8y9OR/swLbKvq/FV/gt2TQ6YMJWA5O
 aSFEJsHtyhXQ4DEDVdbvXYws13TJm/Iy761cvzYkxKCu1fmJ8WqaGx9bIjTmcKT3
 s5hygI7ZdANdDFsbn1MfTbDcFB3/GHuVxkNsVQNA9yvmrFaJYG37IcNMiKLXjTj6
 dM/Y/A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g740f5mwd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 06:12:28 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52845bd815bso6060881cf.0
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 23:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787551948; x=1788156748;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UEFTefeAsv2qh5vvlMQhjsN6dfN8Sm6dSGVONX8CTCI=;
 b=Ef7yAbXVOdJ01vDAOidjSTjqh5/XaWt5C0rtHEY5Mv5WUcQPbOQDlGtsxMKR4pGmCL
 JbPG2ooB9c/9385LIZqNw8uV4HZTw4F7oLgAum+5vDyznILmQmHmrNIaT5tz/0HkIuFG
 1U5DvWff6G5UPPbGA0TIzaY11d7ay+lnrQ8dePFgFqwAg2Xq4J47S9W+8wONzN6qrBym
 exRaHiCZkqEg+LKvr3EacriLb5oqJeiTGr77pqSNBWhVkSBm9eNEiLRR1n/dJpke1Hv/
 fsF4CoQY3gIr+pk3czVqIRDi4oAjRI43Kh33BO8eO32CXj+ZuRqfvhBY6ohMb2A3XQYw
 8BFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787551948; x=1788156748;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UEFTefeAsv2qh5vvlMQhjsN6dfN8Sm6dSGVONX8CTCI=;
 b=aoBWM58KFVmGoUj69NF8YaekP9MXeumfyK8d+2jrXgLzWzH0Fhx7hJw5zoseXkwma6
 +BuhKzbbqFLhDP/w86IO/SsD5j4QHeiMjp6x2Hmb1T/ldu2xptFOSDyh7DHkGAf7fhoo
 yCd6koAokIZos/OfHtpUWK0lAOb9VPdGZDao2gv0bilzfJWoM+KoM3kTMp2RNzVsFYx1
 e1VVQsQSgZipjMoRB91h17GApwbTG1jfcSVUJQB3OVAdKhKD9wDs6s3/jTY5ydnunVo2
 /cVc3g/nGLpXfcBP32FqkQFb8IVwdWJuPGiFr5UyvmJsx98SRK28boQYtCJcMAs6/NIi
 M0Kw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp8GLucMcGmE+2jARgHfSufBNY67alLaSto/OXwxEf0bwkIOWL68T5lViAduzncY5YPzGmtIvyUbag=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kQ7bWO4EWIJyhN6R70/0b7LBdIr6bRRIcCJFMzMWqkeRiUnQaM
 w9xnXrOpF/SA6TyOLQz8v0H0be++u3em/h59mx3P4rtXjgQXjVr71+2hth0ONPAMJQ9dtP27v0f
 2UeBGT7nj8319UEl2BmE4Xm8P8o9VgfTBiI6tI44JEGxqKv67/ElDJW1ii8IEFuu7YB4JbTY=
X-Gm-Gg: AR+sD110hYrtnY4y6aU0l2o9Ker3tnYbGVkBILWvFe9CrGpYGEMwsk3sXEA4DOztBrc
 BzCxVV8QqJa5l7LlAr7qWNqZZtE9CgmReeCw0kncZicitI8ftVes9AH8HsXhg31ClW1fjoB4nhS
 ovN3xBEJzbIlyBofD3jB6bmfVOcc8T6n/g4tCrFaPGZxpdMHR2ww56TJNYSHduWONBKhW1eBp87
 eAMCMVmUF/rsvqGfsj+QJ5flJravEeLRv49VF3Q4cu7SorSZm6F57RXY3Rt1Dh9UhURSu+HzbsG
 andQxmgGydhX9HmAbOolIKTSDhb221xSA25wvt/bG7f3E/lxqEYIyi8bRNlALq6h1BYJH29gHaj
 RKF8+Emx9tTx3dG/IYP5/4/62
X-Received: by 2002:a05:622a:15c2:b0:51c:2101:f0 with SMTP id
 d75a77b69052e-52df56d00ebmr175961111cf.2.1787551947873; 
 Sun, 23 Aug 2026 23:12:27 -0700 (PDT)
X-Received: by 2002:a05:622a:15c2:b0:51c:2101:f0 with SMTP id
 d75a77b69052e-52df56d00ebmr175960721cf.2.1787551947423; 
 Sun, 23 Aug 2026 23:12:27 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24968ba7b6sm1031837966b.62.2026.08.23.23.12.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Aug 2026 23:12:26 -0700 (PDT)
Message-ID: <7a21f01c-288a-418c-8c7a-a57fb40e2124@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 08:12:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/adreno: Only check for PAS when a zap shader is
 present
To: Paul Hollinsky <phollinsky@holtechnik.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
 Konrad Dybcio <konradybcio@gmail.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
 cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev
References: <20260821081325.89088-1-phollinsky@holtechnik.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260821081325.89088-1-phollinsky@holtechnik.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA1MiBTYWx0ZWRfX/AMjA2SCRpFr
 +hqLcbku2feN2g7mF9eoa/ZZ1U9p52iVXY5QuPrQyjcmvqP/3TKKxRSN+1UpWkFRckRpD17SfgN
 SQWYwxHIraNfd3KCHsyCQ2GPrbNQYeWMYfnxmSZSMGbWiT/gwFVfcQx6lv0Hkx4RCcCPSfMdHQH
 3k12DfB+t4e/OYtnDfuT+7BuL9cLUelkgH+pM85zC1PWJFZTU5QjBeRIzcNgE8cfRnkk0Hwm64e
 ZGnIhPtUdmBKKLhZ3GsGYWpSzVwnRa4pUJrpV97I0Y/UsXtL7J5LBSjb9GdNOxQIWWw7F0HLP01
 3sVgF/sbWjF41JQpVmUENZkPZ+EFa2PMGgVb70YNKCFw6Q7qskZZ+i9dWbDeIIZ4Vqt5vaw1vlJ
 xI0roZ6gPGzd0n87U/g+YUZfINbGypmyeG1YCjpVkGkGqYe3SA/+yZm4ddubcpaAwLE73n/UQnl
 LRJujZ9CrRVyWEOy15A==
X-Authority-Analysis: v=2.4 cv=BZjoFLt2 c=1 sm=1 tr=0 ts=6a8be0cc cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=Bzkix8dev8cQr7rmkK0A:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA1MiBTYWx0ZWRfX0EdYJIrlmr1d
 c/FBKBwJ7zgOiJZZL37MmDQLPPDpbwoYAki+8MmxULGkddYgDkJK10lKuDqsVsFf/CK6fyeSiNQ
 xjvh5j0z8/VdbbCFbGmkBa1v8CxuBOQ=
X-Proofpoint-GUID: xZh7IVGexBrNXeIauYQQjCIV_4camqVh
X-Proofpoint-ORIG-GUID: xZh7IVGexBrNXeIauYQQjCIV_4camqVh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240052
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

On 8/21/26 10:13 AM, Paul Hollinsky wrote:
> Commit 0be72be03ca7 ("drm/msm: Switch to generic PAS TZ APIs") replaced
> the qcom_scm_is_available() check in adreno_zap_shader_load() with
> qcom_pas_is_available(). These are not equivalent: the former reports
> whether the SCM transport is up, the latter whether the TrustZone
> firmware implements the peripheral authentication service.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
