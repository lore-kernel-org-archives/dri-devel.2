Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 964C0EDB7FD
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 11:01:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB43B10E3E4;
	Tue,  7 Apr 2026 11:01:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OwN1oKef";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YUeo6+15";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A693310E3D8
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 11:01:49 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6376X4gi2327732
 for <dri-devel@lists.freedesktop.org>; Tue, 7 Apr 2026 11:01:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TPg48ZrFVKpUfD5wFgvADPnLL02fzhqooYDzb16tNdY=; b=OwN1oKefUvSbIOYy
 SUTDm2WbXTfHmxhx9/W9uTDnYFp5zgxbvd52fUs7n7rFxZ6nYeOMQfpd/osoky/7
 jup2fepjYeVXkEX+OpeHQcRDEp66x32IWeGAAAxnu0CziubaHUVw4Bguo3yZRp0T
 W7IlQtgfrWQc+gCtJbNV1b3sKOiIpxjbdRwpojzN4rAeopR6sKnZO+oQ7EUcvH4b
 cBrcxw/Q7SekvIti1ggoHVpBtwQXKNfHIXuLgS9dqIFtf66HVKklJYSUD9qBux4a
 X1GA9KN5f6u+Gj5q0m8E7MWvrDZ495Nrzib5E704Ae4MXMh7xHgxWfY+VKXeJtZt
 Vb+nJQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcms4tcsq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 11:01:49 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-89f548d0872so16572066d6.3
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 04:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775559708; x=1776164508;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TPg48ZrFVKpUfD5wFgvADPnLL02fzhqooYDzb16tNdY=;
 b=YUeo6+15KiO87ZG9w2VBTs9fPHpqjdf5x80BCasJAgNcCskr15YQ/XJEDZgJBZvK8O
 CO/zB3D40OPs2pku0wvKbHtWKN05sQ2bQM8lQT+E5UnW3QtuePElkvYvKOsGCSSVUPq1
 5pwO5oEWf+lXNDyJP43FWTFOEtmZ3LwFQXZj9wgThIu5B+mp2j7IxOhGhA3NrH6Z/nXw
 NzsPjpNWzntoD/Q43c3Wau2SteTMy5TOSA6Zw+b3hAXrSjbHpTmAwyGO4plifSqo3Eio
 RKDy1ivBdycHkxYgsDgpUzD/9ztqpQkT/Jj/lcmFze1R/ljHnU7Pw4AS978mTjvkv5nm
 HM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775559708; x=1776164508;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TPg48ZrFVKpUfD5wFgvADPnLL02fzhqooYDzb16tNdY=;
 b=HLh3T0LrH0dX5H7l6qxbNXYaXjP/FN8tXOiE8rMW181pVGMVVAQTeCen/SqdJI1nKF
 FUEW+ztgDujrOJi6SQD8kK1um+ju+EsOrBexl2Y3S0zFsXsKSgL9F4JCF3P+XpZjuhEG
 Oon7xkjsI1keJlIK4baUeUvhzl4TINXfjYMlvR7Y+InHFy8OiZ8m3WQT2hsmoSSiFcof
 C8IwwEreqSYdrJ4h/Z1OlH3aHyv/wAr4SE6IRERvGh2g+6hF9sgpLwspNuNrvrCMP40v
 lFqrqIcKfoS9+i/E3OAJWPaYonm1R/b3TIJ7OJulgZPUyDfzTfhY1T615N627WQBifZ0
 t0DQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiFy20jexpsbRDVJulrqKGI133RhSZRTzHcwXQJuAhlh8EkKpIj0QwePKxktJmmVYmRWGu0583tEw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx5XQSgyhyaY2n8bO3y1Z0obUY3aGrAwBsZWYTeI0RJmMy5jDvF
 Q5uSRI4FQ4LB3/pW3RleVaWn8q+9oYeqKHjY0VUaLP0lmPHzC5vWPX9HzOvoJ5YsoJ0tlIqfCER
 tRJYjUbm1j/c/1SGVcWjdSwhOZfzdrs6OWd3p7+aMNpgv0aOY/48aMfXYOoK0jcdqjurPct4=
X-Gm-Gg: AeBDietghKYBlSiE89Py52/a0FXDdzLYjFxGQJRYdnUwCBs3uMMlfcOu5/9zX9ZmNfc
 04uyaQ5zjZA90cYaaUi2REU1Zkneo6MoHuEpfXyw5Wcw89fX/LrQhQ+gUsIBbwD3NX1njZTbt6U
 3RzX+S/bnYoJ0+fZhaxHuQex/lJfgWAHiQAMYTiCtfQqRs6/7rfVMfYUHvZX5mxnYExoL43sztI
 GIjspe5KTrhf7LpMzS8nsBE+29/eZ/F9c1rQXMXIoQPgAf9/JaUqsy011D8/TGCcaSEig1CEdkn
 diiNvv4ml2AkmC84kP5hPW/HU4V6nXWIl0kIjYny6/igcyZzvILU3KDRawDtJUIjVS1CuYxeiV9
 r4U8p6seqwzdEQV+bVN0Zvv9QwzKQExxXGgVh/ymNpsNFAI8JND6bTPQ2v3ONWf1AMSCf5dQzRU
 dZVS4=
X-Received: by 2002:a05:6214:226d:b0:89a:46fd:3001 with SMTP id
 6a1803df08f44-8a6ff3c492fmr183299576d6.0.1775559708049; 
 Tue, 07 Apr 2026 04:01:48 -0700 (PDT)
X-Received: by 2002:a05:6214:226d:b0:89a:46fd:3001 with SMTP id
 6a1803df08f44-8a6ff3c492fmr183298836d6.0.1775559707102; 
 Tue, 07 Apr 2026 04:01:47 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9c3c9721b6sm532205366b.10.2026.04.07.04.01.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 04:01:46 -0700 (PDT)
Message-ID: <8f5ffecc-007e-4a8a-9c5e-9994e7841659@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 13:01:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] drm/msm/a6xx: Limit GXPD votes to recovery in A8x
To: Taniya Das <taniya.das@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
 Imran Shaik <imran.shaik@oss.qualcomm.com>,
 Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org
References: <20260407-gfx-clk-fixes-v1-0-4bb5583a5054@oss.qualcomm.com>
 <20260407-gfx-clk-fixes-v1-6-4bb5583a5054@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260407-gfx-clk-fixes-v1-6-4bb5583a5054@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEwMyBTYWx0ZWRfX/840UCXyI861
 n+rBvtM2qBm1TJ0deaOhqch/Jf0u4+uvN+pRopLziwzC0omMwtPJJGnv/lwfnbefntvu9aeWnEh
 tWZ1k4X5mDz5RaBujqJFBjyOAs5IyxGxGwBgeGrgJ36flWqKiRWWko2QZyyYI6uviEq5s5704GF
 D0bcVH1qna21fNVRiL7sIwWuIowbXbQRRzES/LVp1mTmpLyDKhvs8UV1057p5Ey9B7oh1GybmW5
 ao+YRcr/ReVfAxSkmJOANaOhyii7bkHPw5ad/wBnrChMK4Eh2BMZ0HtSp4vTkrv///FNhUtOBT6
 zJDyNstQwesgkTPoC9BWex0+btNYD/7txI7SeG9Nvz4qxFLUZeCXZJWpg2efzL4UTmeMngLPbKR
 9JSwzuh7V7IBnY5ctnYX/4ZVR0Gy4ciBXWiamtU8h1ZYuf6Rt6EeG+gEdvWH4FIfpQL+q4E7vUQ
 NorJr4OHrdhif//TNsQ==
X-Proofpoint-ORIG-GUID: 8feA7q2tXc-EqKrLowvSdXN7RHFiy0uB
X-Authority-Analysis: v=2.4 cv=WNZPmHsR c=1 sm=1 tr=0 ts=69d4e41d cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=eR-y9ft8gFT6PtJfczAA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: 8feA7q2tXc-EqKrLowvSdXN7RHFiy0uB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070103
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

On 4/7/26 11:30 AM, Taniya Das wrote:
> From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> 
> In A8x GPUs, the GX GDSC is moved to a separate block called GXCLKCTL
> which is under the GX power domain. Due to the way the support for this
> block is implemented in its driver, pm_runtime votes result in a vote on
> GX/GMxC/MxC rails from the APPS RSC. This is against the Adreno
> architecture which require GMU to be the sole voter of these collapsible
> rails on behalf of GPU, except during the GPU/GMU recovery.
> 
> To align with this architectural requirement and to realize the power
> benefits of the IFPC feature, remove the GXPD votes during gmu resume
> and suspend. And during the recovery sequence, enable/disable the GXPD
> along with the 'synced_poweroff' genpd hint to force collapse this GDSC.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> ---

Can we simply make this change unconditional on the gen, so as not to
maintain 2 separate code paths that try to achieve mostly the same thing?

Konrad
