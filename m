Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D48CA5FC5
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 02:09:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A18210F54A;
	Thu,  1 Oct 2026 02:09:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OZzb4Frw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BKZWgw8u";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEF8410F54A
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 02:09:12 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6910jtPn2099097
 for <dri-devel@lists.freedesktop.org>; Thu, 1 Oct 2026 02:09:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=L7hGipuSz64raDNfiC6PIsng
 qaOE5pky0NmA3MYUwQk=; b=OZzb4FrwPNf2OywrAVYsZB6vxvz3pJi1NNLoQqwk
 RRVfZtXMRG4fgl5MFBRznl0LZAB8iW348pV+5hl3ZWICV2EE4D2lMoNrleAhfjxx
 Z61huDEcHt4gApuk9PXcq1X/tKYDyRqkeOWBVrlH6D6tacmrbTay3eXVzhCuvZ9A
 +8Y/WIODkdC9kSdSlf13JDqf/c4GYqAR797WoeLuOBlqsimiLG9ztHl63/0y5dDy
 5kA6xyGpgh2nRCkfPaRai2hsmOnw4gBcliwLmt0qqhROGXm8m6vxdeZ9YnzEpKBn
 4TPUErMMJs75+Ph2qQwCNYBL0hTNX0E4vnwm6EtO90oslQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h136tjyc3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 02:09:12 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93cab33cb20so201636685a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 19:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790820551; x=1791425351;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=L7hGipuSz64raDNfiC6PIsngqaOE5pky0NmA3MYUwQk=;
 b=BKZWgw8u+ZaVkEeqFr8he0dSCJufsFqnpfhw7QSldIkp5S5e4lyiefjrG8B1yAKBLd
 NSUSY1H5EibQ046bM9Vv6ZyG3Q7WXd6RlkJARBxpjY5X2f38/kVPTCjoADSWBbUBuxq/
 tRDtb15UwkCOMV2qQHdktH6R5tWa0jEdqylZtl49chWnG1ooORHjBcgQmonkHprkJGKC
 o/j3+mjEm65hwfnyMoeRgpIhh5syDkHzGi6qMYha9Ah0l3V/VXfM+s6noBXAmJYWlYvR
 wQ5+7tuumLTiAoLeqvBm0xp+3ZLco/Q330WX+OsuBsUV1XiW3vb9ZIq+E/8nCOmDh2Rt
 CJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790820551; x=1791425351;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L7hGipuSz64raDNfiC6PIsngqaOE5pky0NmA3MYUwQk=;
 b=aIbtX+qzVpQ3Nrc2w5dzc8N0/aW+0KOkazYaI1rlh8HMhwZMIVSIN202O48lwrx4ET
 NJHkFJS9xPagId2XnvzXEyKumlJwzBNHWXvKUOiLFE1n0XZQPIcHPTwT0MZ7P73W4pp/
 k8NBxSXzsXj+Hx4RHvwBr2j72PcK/S0cIKjsFZqtIJdCm/gb/yJQKd4acQc4Hs2WXbba
 +Fk9hg4lgpZG0CYlp3jmhkdeaBKzu5a3Ha302uPAp44UGaTOjxeU18kgaDqG64KYtV2V
 oD13666reVCcBdhUiKus5fFqs9lKAXOiutahSXZCYAYpBDzrRl1G+8KNP6W3cwMkQXKK
 mrGw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy/8GfU32QbdGnzMW5BejL9aiKDxfX5e5eYQ0HTj9X83FSk9tkM/SA/jnJ2M+no7eG2ccgjlXaA7Tk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kzlhSC4wbyWZkzuYEpVSEzqQpI7Yi9V8hkwmzsOYODWoIPrEKJ
 4hEKE/ugZOjNyV3xeV+ujJA5kwPO+b7bqI1thH3MR8yAVMK9oBZqkyJGyIpHBAWMcm0CREHpTP+
 X7QYnnbeanaxt+y9+rs18XjyOF5bS3DNqgp9Q0P/OO9t/kkNxypmoDC+6BUOkC5I5oK9iBck=
X-Gm-Gg: AYBFou2D//heNqsxrDE7FKCZjFfZzUiWUkpUO2amB8X8N6bjqEP1uXAe67KXgN9PMbD
 WbKF9eogJ1b0OX9+ZlW1BrrM70/hP+5ogn+FVA0ZVAbjpGxRz5Knr/EDa12asM7Bzk7Tz61q3jh
 d1YCSKScq9jddnGLQHpkfp77M68XaujCSwyeZAyIcqZXn7IzXr52RRQcPEuibADvc51jICIQiZj
 UqgmOJcNOCycJrVExhpGYDUayIW9GFO9cykj1J4Ml7nP8GW9nw0WoFO2ncKF6wiUFHgfGf8yBxi
 JCQxMspsW4C69en8577tN6jFGXiK8Y3jZOfeqhUM7Gd6qcaHoB7td+2hCmnkTWIrLSHaQdYiofo
 U/FrZRZzKB/oy8oYBhl7JLX+ZuIyEEvMZqkz1O1M3+KsqUArYKh4PHNItULt6iUUQ+qC3uDevA3
 S/UxJkCaIXiLSx
X-Received: by 2002:a05:620a:7085:b0:93c:56a8:a0a1 with SMTP id
 af79cd13be357-93ca97db266mr609701285a.58.1790820551435; 
 Wed, 30 Sep 2026 19:09:11 -0700 (PDT)
X-Received: by 2002:a05:620a:7085:b0:93c:56a8:a0a1 with SMTP id
 af79cd13be357-93ca97db266mr609698785a.58.1790820551043; 
 Wed, 30 Sep 2026 19:09:11 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ba42fbf388sm348995e87.75.2026.09.30.19.09.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 19:09:08 -0700 (PDT)
Date: Thu, 1 Oct 2026 05:09:04 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Roman Demidov <roman.demidov.nn@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
Subject: Re: [PATCH v2 2/2] drm/msm/a6xx: check pm_runtime_resume_and_get
 during resume
Message-ID: <oitetu2hyrg554hq7gzwfmtardpbaqpsipthukh5mqu4sr2zfu@rkab3aekdzlw>
References: <20260929142103.81854-1-roman.demidov.nn@gmail.com>
 <20260929142103.81854-2-roman.demidov.nn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929142103.81854-2-roman.demidov.nn@gmail.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAwOCBTYWx0ZWRfXx1Qp4Jj5eKpd
 sEesn0gFNnpAAH9x7xyXCvFmq0B3iA9u+OffNpVUDHZBXW2wU+7YsicylZo6yuSd2bCbU+Ywik/
 0xzGTuaBCdF/fWJf9dvN+Jn2YLHuROs=
X-Authority-Analysis: v=2.4 cv=aPFlOr9m c=1 sm=1 tr=0 ts=6abdc0c8 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=HH5vDtPzAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=8WuSQyhVeKmarUdqJEgA:9 a=CjuIK1q_8ugA:10
 a=zgiPjhLxNE0A:10 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=QM_-zKB-Ew0MsOlNKMB5:22
X-Proofpoint-ORIG-GUID: OEcXSksJ4iq1TcAHdtUOR1M47jobPmVT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAwOCBTYWx0ZWRfXy0jVJCwMN27z
 B1hiVBZtTs1ek+jNXxmJN1zbFTqN0FnjG22HP+W0UowoEzPeLRE5bQmOLITpOn2OC99LO4JDs/w
 d7hhs7gqfbK6pvNHqSae+JxCJCrd3eO5qn/WNLxS4nd37ISwE+JhdYQMfxTtHOh4kbLpZs+crm5
 tbS2MLYjE3yaZyxz7qo2xrFpSqqdwrn93jQSShrns2Z+kcGg4DRnzeaIwvehMzM/kl9n2ah3SfC
 u20YwWT3BUzPj/XI1L++pVd2O3kUAltut2wflyXGqi2mzr0BzuDU4KyT3dL/OmWXIRiTmnJZKFy
 WhFWtPhZfp4jbdjIZd6HJGdfSvcX35G661DTJcpjZ/eVBoZuMBH/laIDda2jQ2CptXkmUqEPPIJ
 pHWy5sDFMKhZbtlEy7xnmkV9SLzGTsve5wanH+4VKbImQ+59fVV8nrqUNiP7+aqBGbiB+qXVaaY
 QxzmApDMECvHkK7pQ9Q==
X-Proofpoint-GUID: OEcXSksJ4iq1TcAHdtUOR1M47jobPmVT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 spamscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010008
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

On Tue, Sep 29, 2026 at 05:20:59PM +0300, Roman Demidov wrote:
> The return values of pm_runtime_resume_and_get() calls in a6xx_pm_resume()
> are not checked, which can lead to hardware access on suspended devices
> and PM reference underflows.
> 
> Fix this by checking the return value of each pm_runtime_resume_and_get()
> call and properly unwinding the previously acquired resources on failure.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 5a903a44a984 ("drm/msm/a6xx: Introduce GMU wrapper support")
> Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 38 +++++++++++++++------------
>  1 file changed, 21 insertions(+), 17 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
