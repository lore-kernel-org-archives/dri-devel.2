Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CAFBCD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 09:59:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7009910E078;
	Fri,  8 May 2026 09:59:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mWL3Eum8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZclNG3Ti";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 182EE10E319
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 09:59:21 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64872cap1062071
 for <dri-devel@lists.freedesktop.org>; Fri, 8 May 2026 09:59:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Qn0u2rVFSmOsPw9dKW2MjjRKtDspoihKo23AtaIa+f8=; b=mWL3Eum8QSKgmA0e
 M147kIoPilIPbnVJNQlUEC4gIRzkgPbuU0u3fckW5lsWkJ8Spz/FeQNmOeFJCgUh
 O4GQuO5Jd1DvybTdiUtsQ4Tf16rMifr5DX14yVjkH3CRM4v3bQm2SsEwOukVAbw6
 lz+IUUurCJUaL67TjQaeD+kc2L9jMArNTJefNT+VvISKw30mzwGqCZnhuoUI9KTk
 xZIKg76qQsaMpEb6PugiixNsFwcMjfuKhgYfiZFQhCxO5zN18rCGagZXWb1zhcQg
 e2Xpx644gilT7k1QLpY5psHyNWTUOx6HLypVQmJ0Cb31hbpJKj7lX9HNpmy6irF+
 /BqtWg==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1b3fgnup-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 08 May 2026 09:59:20 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5751831fe6dso207937e0c.1
 for <dri-devel@lists.freedesktop.org>; Fri, 08 May 2026 02:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778234359; x=1778839159;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qn0u2rVFSmOsPw9dKW2MjjRKtDspoihKo23AtaIa+f8=;
 b=ZclNG3TiQ04aiqTuAjL1Bpz8R42Q2Yf30seSSbj/aoR6RIEpNg8T1n/lXHTp7vUKIP
 O2XPjhoXUBRHDQn+MQ52JdESakiZk4PNGgFIjdvqBrjLxZq0IbEyRoopd0dAZD5LpGVo
 uI7v4ggL+DAxQtkUxl4g/5K8mcVmtvBH7l4DcuafJ8IsKHN72wr3EjuqQk6EGl/Eca0Y
 wYUz0d+tUfdAr5SWtmNFOm9fsHxw9pXhWTvDnBR6rtxPZYP8p4dRCKkCBf7keJaV48Wj
 0BUrc9Ag0tzUU4/TO4onxTCQzcprTBqhIJanFTATIFeyeif1m9BDTjtzLUZvKLEbHNbJ
 B8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778234359; x=1778839159;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qn0u2rVFSmOsPw9dKW2MjjRKtDspoihKo23AtaIa+f8=;
 b=ERkO8Jjy5+Qoo3QLX8ih9khah3JgoSk6oN49qM18G3CWHzMBW9t00M9zeG54E5oQSr
 dBUhgQ9UzTmREU3+vYrDDQFqooh3oTBvetkLXCjl1N3sCzowrzStUbGr2ynurh75sWSW
 X/79KH0XcOzsGVvT2r1VgrZUpGTeaf4EoN7RAAnRrbyIRHVzyq7foLOZN9t+3hoQCob+
 3uHHV3Tyvdiih6J1btMb+BJ0MVntKJI/pAlhqfZWta1GWgpZMbdgjsjT8injFjBxNoPf
 IUsSnTDlmXwERvDgzpb7Oa5roklzfyfG11Q8RCritBFrQW6TukQVJMtyMaD465C/zGuf
 EVpA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8a80zUYRR4lUaM0JkRkykkCiHa9rJ4SblUkr6DcEHgSB2L6cI/vwQDSBNfOiy6z1Na9xHU0dTy17A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxbg5idI6MQQPHl5lpFPcGw/iIHbfv9+q07x53x3hsPAm345udA
 aIKKi7/E/YPpz3zWS17iFplLBICQbMYyBWMd5OQzNj9y2tIy+iWYV/scABWL1zv8OPYARliDoWK
 ORfk+rzlkNYgOwCms78hTEDo7ASrEEDmX47UpAYXN9fGuehUF5ctFr5/irf7T5BNSrN5CdQY=
X-Gm-Gg: Acq92OHCnFqP0ORN8OwWGyoxvRo1WQ1q/bbvBxfrb9XmdwY0b+GObFyo6N+0t/cryQr
 uNbGiy63rU6bVV0k5VbwdSiRQoYurozmC8Aoe8ZFi9TcExCMggCFMnqgyqxHZoLu5CEMO5Hj6Yv
 pNBGHP/UMbNRBhbB0/QMcsZdvj949YuyHjwXdtnbHAPzyHA3NLCZnWmIXLpgqX5RFZWFMhJcIW0
 Qpzh9IpiUvSiMddpFxrXIJ4vqjwI7Fbcpq/+85zojNruPv+pLZMKYitFbuTJ5lm2rrG3UyktHBI
 zA89EQU6g0RDTmNRvc/mJ2oPQgk9AsQg8rO6eCnediAjHx8xNw2XGa/ywhRbwGMejTj5bjAdSy3
 /Cme/3z/AVpS6p+OJDCKNDeoDcjoJO04aJaF6xTDp2g3SwhdW7vxcldb00Ve56CTNK+0gRSWbUJ
 R3pXvQZgWmNdulkA==
X-Received: by 2002:a05:6122:32c8:b0:575:1954:4396 with SMTP id
 71dfb90a1353d-5755cdfee8amr2625428e0c.2.1778234359606; 
 Fri, 08 May 2026 02:59:19 -0700 (PDT)
X-Received: by 2002:a05:6122:32c8:b0:575:1954:4396 with SMTP id
 71dfb90a1353d-5755cdfee8amr2625412e0c.2.1778234359209; 
 Fri, 08 May 2026 02:59:19 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bcac398b017sm58092266b.38.2026.05.08.02.59.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 02:59:18 -0700 (PDT)
Message-ID: <9e1f0853-21ff-4d81-a653-f3cabf254190@oss.qualcomm.com>
Date: Fri, 8 May 2026 11:59:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 20/29] drm/msm/mdss: use new helper to set amsbc
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260507-ubwc-rework-v4-0-c19593d20c1d@oss.qualcomm.com>
 <20260507-ubwc-rework-v4-20-c19593d20c1d@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260507-ubwc-rework-v4-20-c19593d20c1d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ElyGyoNZrc29n_4VHGSzYJ5vm8zPrY8J
X-Authority-Analysis: v=2.4 cv=YMOvDxGx c=1 sm=1 tr=0 ts=69fdb3f8 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=vz_rfR1X6w8aG-yi8FgA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-ORIG-GUID: ElyGyoNZrc29n_4VHGSzYJ5vm8zPrY8J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEwMiBTYWx0ZWRfX8ZfarmDdo6G4
 JrXkxeVAhJzlSxsJBVfgoOMmA3j5l5Av5cwfx+4tAMk/oO7wius1k354NhDw+GPO8ZI2hHxvtyb
 503O6vnRKP+WMMFCTmjYSg1BDRQv5ps8TGbyWe4HAjzZHwY2O1tDJBdEtXbmTh4U4SjhUHT2BZh
 8QopMWg0S+7rB+kHpA+BW3Hl9nbtzyc+q4hI+NXzSpZeAXyYjYdl8QJr9Dxxl0tW4YCCDMt3Xdy
 feuzljkySDllJqJHpoaJgVXKHTClRJDbaY7lu8/5w//4L+jy2Gr4JUhpeono7RqbF0ldPGNGDal
 UMLtZXYrNTNy2h7JY1GAQb3UhpltZ/QhkOlf4fnOHFb/j+MiEnmMd7XCkeMDHH9sdV5GN+vyHFX
 FtI3Ow7/MHmMPVHE+vd86mqhiISOeZAqyRVJA6nagJhvxQOldEUTMgZ586fN9MnV6IOtCuzTR9U
 GCwQl/6yBqETU1gqxfg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080102
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

On 5/7/26 3:03 PM, Dmitry Baryshkov wrote:
> Use freshly defined helper instead of checking the UBWC version
> directly.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
