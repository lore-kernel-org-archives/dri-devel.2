Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C712BCD98DE
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 08:47:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14F2710E2B3;
	Mon, 15 Jun 2026 08:47:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="A/L7l04q";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SQiH3gkQ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F07DB10E2B3
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 08:47:23 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65F6KukC3828083
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 08:47:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XdQz1b15fvVu+nGad87JsVN4bifqNqTlT1TALXLaWMI=; b=A/L7l04q06VnUsSS
 7fbT250j4NRZbzkSAHdTKoOvqCWWLB+Rm72im3e2CJmPfh6A0jNVEb+P4NJjFFIF
 TUgjByUM6gL6weuo5exipo6OXMhXHpayonykmb136o/iDCEI78acUvqkkQlUDpeK
 6oh4R+gTHnEOERpMgpfRbhnJyid/uBtJe72Yq0QO2EKfVhxpbL3YCD582crUfrSl
 U277hUmHxXtdQy1bfg5BivTOO+40Kp7iKszD06S+/HJqwXKB9oM4gafNirRkQ4Da
 zaYQZ5Y90yPL1xI3sYUsHa+qPOTL4d8zjZe4KIlm01H0iOrKxRqqfH3+gDp8hU1V
 h2ZSKw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ery7u6fq6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 08:47:22 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2c2d65d9773so30744875ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 01:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781513242; x=1782118042;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XdQz1b15fvVu+nGad87JsVN4bifqNqTlT1TALXLaWMI=;
 b=SQiH3gkQ6bHLyWcNFwPJ/e00xkcZTmfcINT5xqFCAner/PpYUh2hcyDPDievQB+yhF
 orV06Yddu9UmNpw3XPcRCkNYr8ba6EPpTjqKkSKA9GhWWgIzYsW1GyNE3pv4Kb0SjX39
 +QZL9/AfcRlqdtGVe/pqc//TbC0LBYTPut8Z7qcPRaSB8Ce0vA3VS4O+hrqrjV2eW9F5
 WcYpCWW7OxddW3rrTtNgwMzpfjpYPCCqrs4anwVAZyhy40CDCuyJdztny30GjwD1VK5a
 uGQEb8rSDzIoTDgXjKEr0kqfYgz9ggCJtbF/MLwWfinzeJBnnPN37VDM8fEBMexK/wNP
 2fxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781513242; x=1782118042;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XdQz1b15fvVu+nGad87JsVN4bifqNqTlT1TALXLaWMI=;
 b=kpTugx/U9MFQhCiLXPqYlTOmcxTKsEGQ6D1zwKJBlfN+e/Gsp99hYcdTaIo0YRvOmj
 Ztc68IwXpZgDioj1fsFRmnpSvs7Vhwdw47iKyNH9sXfXSwuun2OgjNOfe5j7r2aZVKdV
 AQq3eruFS93oiQdkGn8VW+20ALgSy4j5oiBBDne91NMIUvOLKIPkcmKY+o6KlJBJvjRw
 PJ8NTjcN5mQzl+dYd16rtac2rvmtkiBmXQpIYDfJU2KuOijUzWnCSs/1QMHidBnsx0Yn
 uzvJgIeIbW0PoIBE9/FSsTE+pU4rBnjdMubo04qQWRN/HqlmLVvUqr6EUoc9sBgl83Fc
 2Giw==
X-Forwarded-Encrypted: i=1;
 AFNElJ88Xw4h6ReBo8JWkSF2WCXc73sW8ofpF1l9jw/z6+NhexZG9dnNaGyFPSv+aFW1fraK7BMCaOyolE8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YykUaJM6HXBwhti6OxQ68TdHMq1nR/nrdZf44irZeUSYbB599IJ
 4u3slwfVkgGl6V66fGCvZHsBCNn9Iqd86/1T+gVMNcLNUz9VSpGUZTIJWEfLpMB+BJYdmmpoSom
 V5DXUJN2jxTfOtPdyOq7pkFDEUEPFyt2rM4INls76nBfCdcW1artA06Ljk6eP5N/40UJL9dI=
X-Gm-Gg: Acq92OEnKF1Gsf0G3HEVpolboLPbj4i7Lsn0ta/PFxJ/O2gAzGHooUkIH0gq04FP7hE
 +Itk3Nk9uTgkZrmZlNa/kZ6I37wPrpaBwnlzgcJQZOROj0hFhwX6L/UFswtJxR8JcQfXE6QTcM+
 zDQDGwtaTVbf8oFIiTRA3fAbnFn/a/qw8lZv8VTNLzWaT52S5QCvLHt03rZCRobvNnmhoWwcXyR
 9gJbaMtP28sB+XFCzd2V34dK/CLcNa1bacTTnOPUqh4R/ieeKu5sKhFXQI38PYweS5Kmgtz6cAg
 qmaJNqf6FcJKY1wpH9PwRmpw4J1r0hV/1SUExI8NvwMVgbx4vcitHRIHEr28IWn/NEsP5vZguzr
 EElpIod69z1AYzvl0VKUiWVvBc60uy/0N+/z5PthBWb1s4dYXHQECBL/Zyp+J88QW2T+sNpsanK
 +EYmSrwmFh7zupL9frVw==
X-Received: by 2002:a05:6a21:3cc2:b0:3b3:1951:489b with SMTP id
 adf61e73a8af0-3b78409e4c0mr14916134637.45.1781513241954; 
 Mon, 15 Jun 2026 01:47:21 -0700 (PDT)
X-Received: by 2002:a05:6a21:3cc2:b0:3b3:1951:489b with SMTP id
 adf61e73a8af0-3b78409e4c0mr14916108637.45.1781513241514; 
 Mon, 15 Jun 2026 01:47:21 -0700 (PDT)
Received: from [10.133.33.122] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8661b5ccafsm8502219a12.2.2026.06.15.01.47.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 01:47:21 -0700 (PDT)
Message-ID: <df14ba01-7f60-4d4f-b3f2-b74c9db98c97@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 16:47:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 28/39] drm/msm/dp: Mark the SST bridge disconnected
 when mst is active
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-28-b20518dea8de@oss.qualcomm.com>
 <ge2bgx7rn4vcyptf4cd7hnodnycrg7gdjceqq5zdncmdmmnjlu@2cuu3lcotxeb>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <ge2bgx7rn4vcyptf4cd7hnodnycrg7gdjceqq5zdncmdmmnjlu@2cuu3lcotxeb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=F8BnsKhN c=1 sm=1 tr=0 ts=6a2fbc1a cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=qtCM4fGR6xh4bEnU-0UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: zGyjLJor3J60mi5BIV0z3s_gEQSKLHMi
X-Proofpoint-ORIG-GUID: zGyjLJor3J60mi5BIV0z3s_gEQSKLHMi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA5MSBTYWx0ZWRfXy6kQt7pgST6F
 SzFM7v1zeQr2NVO3mSm0lhEMtoE3nLmBQHiz8N0sfyV/pY5oX7pLIVbvTY46f4mcuP/DbrHQb23
 SBc8jBklBi5GjoqX8fdoN1uGehFeAXLgdWcfgW8O6OYBHe+gFFioX2amIpJYDYn33HtIRKVFG7K
 MNSGkVsgf+v4l1SV1WDTUy54q3LXFuP1rnbBBZSCcsth/bZw13N2poMbBFiFVuMif67BXI03Tta
 IjVA4kDz/u2afEfoqZ4A3dMityAAlC0X0nzjtlAFlVl5ZnhdKm6hcsL+LwKLQxJv+/LOjz9YM9G
 dOSvi06+de0CawgYBAwX1i3XUMusHNAFY51IP3Yzjy6oC5mXqn2UplP2fuqG3XKU1Sx+I5j4n47
 ZwlhqUeAGzfq0T2CvJofvVLGte4Dx165gzXBuNcTx3ItEvpvNjve0F4R0RSp1xE0cr3xZ5VJPcC
 e23085SCqd8jUHzoLvw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA5MSBTYWx0ZWRfXwqDmOeXeFFth
 W5UWw1dXEOdpOJex9tAkh7lepxd0GJu5JPhhzbUNzMgO0S9C6qGvFWF7XS4UlJRTz+q8AOQyDxm
 w2Bp60v8+6rUoaTDefDKJuXNo638//8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150091
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



On 4/12/2026 8:11 AM, Dmitry Baryshkov wrote:
> On Fri, Apr 10, 2026 at 05:34:03PM +0800, Yongxing Mou wrote:
>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>
>> The bridge detect function is only applicable for SST. In MST mode,
>> connector detection is handled by MST bridges. This patch skips
>> detection for the SST bridge when MST is active.
> 
> "This patch"
> 
Sorry, I missed that earlier. I’ve fixed it in this version.
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_display.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
> 

