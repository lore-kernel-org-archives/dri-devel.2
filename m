Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16BBFCA5FB3
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 07:56:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E21010E074;
	Thu,  1 Oct 2026 07:56:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JFcliw0R";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="esshXIkf";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DB7B10E074
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 07:56:09 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6916xacV962458
 for <dri-devel@lists.freedesktop.org>; Thu, 1 Oct 2026 07:56:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZGUAnE4LAxdJYburvBSyFauCmovjGgE6tI7LIQQqL/U=; b=JFcliw0RaRQ61F0K
 w7WoNUOTStg3sb95mI495SNogaW6XoIYyt7wihQ1v3kIoQsxfTGlk/q/sayk+cqN
 KjkTJMP3rAQbo+/IritbIaqn1fxtUA5dUpFTswL5b2tYsTdGv6PA9fw8cpoH9ckt
 YXIYX9Y6FMhoo2SaHLcbzWy3hXZ7X9xtrh+OMMUQxLf+VTiOdbvos0pebzcTHtIR
 IfNQ8FQvwfcCYQPcoJ7JyV7cKnt/pXrHycVugC3hgpKHNeHwsJi3tZ9FmjLX0oJR
 rp2Ws7fggwQOznVyl4VM/luLUAEWQbvdD0quPI+nG/zDCAU3xJtyh5y7pHf+E7U/
 azRGLQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h16wctwgw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 07:56:07 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-934a8cd3a8bso83577885a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 00:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790841365; x=1791446165;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZGUAnE4LAxdJYburvBSyFauCmovjGgE6tI7LIQQqL/U=;
 b=esshXIkfu3Y8CYGcoQwFbTd3iNoRXF6/PgTZ3NcB4PNsgDg79qpQP7orCN9oSG1fOl
 sjSbXJF43nuX4kAHK/X15Mg0CN2MHf1BBTvZ2Ho5B3d+OHNWnIKN+n8F6U1b5k6O7faS
 QuZq7y7fcWdWp8aVLiOJD3/VbJ/qhoCxID2I4CvrmgucM5EyG4v3uOiOcwe4+ho7GG0E
 2anlZcSML7Qk/hkaggLtdOMJFun4Lf8dYWCsYdPya1Sj3pQ2P06cHpWlI/s6RfbpnLod
 cyYWTY0mN41y2YPuyx/yhex0wB0trogXFgpDy4QI6EkB7spfqoT9pHGzmywC3uAKFr6T
 ACJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790841365; x=1791446165;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZGUAnE4LAxdJYburvBSyFauCmovjGgE6tI7LIQQqL/U=;
 b=m2Q806Ax5whli1z4tbijcu7srcXUeZBrtaUBmpGdfW5jLdgpnTjlLKYz7dJTRCSCkZ
 OpTHVk5ywSsMA8yENqh8xa4wQi4UGTuXxBW5ico9AxfjmyeLLxqjsb7nDExvIjUwY6n7
 O/WU46Fc8p0PXsdu2PuYN1Dyn8rPnzh8Nn6CgosSIbXhPdjdgcbKVL+R3+QOYrgVSZNS
 BrvWtwt4WsO37kSbFr/ptYO5d/yqiG85Jb6NtfgHvG9nhraoIHa7J/A3c0WrjmixMiP2
 APVk/uyVkutRtoiRx+ghQO+4x6us0qE3h6GTvLksRQC+grI+jVpPLOBihb+2qZnAFhXI
 sB/w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwDzg+BisklzLyqOC/HXip3p8DPeDGrtx2f2ie9LbB6nnIgumdUW9tzqpVJmxtMUzZ9d5IjgxkjDNU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lAUmmFdmN04zhmh7QL+0fM90xPepr20WWAGd+gFZTNFrSpRUGI
 aR/c5lPRx8MFhrE8MHFtss4Y7JPXboGiFhoh4+UPiSwlfcUjWB4sPqlGMwU7wUW1PoqOgVheJCV
 od+kIS474+LcreQ5+JkELVgQ5pP0E1VxkGAhleVsXLcI+io6rkY8AuFdRoGemm3wCLY0BCmM=
X-Gm-Gg: AYBFou131nHrzcjQpkLAuLuRb5HfxOChe/D42tX3nmr9lBQmEZM9BR2grknPzOgakd7
 NXk6lzYdhMJhixvj9rOD/ZqTyNhOgEysSnNCsGu+3yg3dVtGAdr2Hul6xO6wHr+XMVZPLrHQ3Mo
 zRIyijCVivF+I0CFcYdVJjP5Cy29FDqkW2Gw9DekL8sO+1k+L0+aK7vbH67cPt+P6Oi83lpHetZ
 MhXsyY0tomWxatLREFsReoOpLkw0zoz0vsYlcvHxEm/JzANk8qicqozJigIAMGfDwLsENVzJSK4
 3n3BA67807lPrUSeqcvL7+G5rUxYUf+tLl/nu0J1M6sAFjSspdhhqofiYosZZdKkT8v+1lOxEH1
 R0q7hhKCWC0KfOrp/kJ+SOw==
X-Received: by 2002:a05:620a:6506:b0:936:2f59:dfe4 with SMTP id
 af79cd13be357-93ca9418c15mr666240885a.0.1790841364847; 
 Thu, 01 Oct 2026 00:56:04 -0700 (PDT)
X-Received: by 2002:a05:620a:6506:b0:936:2f59:dfe4 with SMTP id
 af79cd13be357-93ca9418c15mr666237885a.0.1790841364372; 
 Thu, 01 Oct 2026 00:56:04 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ae5ca74c84sm613066a12.29.2026.10.01.00.56.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 00:56:03 -0700 (PDT)
Message-ID: <45c87199-c98f-4f77-93fa-1c3ecc1e6eee@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 09:56:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/msm/a6xx: fix use-after-free of OPP in
 a6xx_pm_resume
To: Roman Demidov <roman.demidov.nn@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>
Cc: Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20260929142103.81854-1-roman.demidov.nn@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260929142103.81854-1-roman.demidov.nn@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAzMSBTYWx0ZWRfX/XoQpeTJo80M
 NBi04KGMccCUJ1olaOQG11pntQmCMbMetUatkaaZw5hpJE/uBhCroEmt9D1vDmgtkUa0F5R1rwm
 vIu/RJuQVg7Cwy9GC7QnvrxUzV2kXUy2Ns9PKvOaVdDG7HdLsXoXfuf4vUEDZBbFi4waeFHE0q8
 Hnfe+kmd7mUA+nI5ibc6oNgQTYuR9zpujmUecDK2Q8kbBIeh6wfM067lG5OGT0+0QJll6/NqrYe
 DpOC6CkRzCS6QyFGbKOiUtldhSslkymMh0tYeGhy26EQywnvGXlRn/mSuz/vn6Zv8zcxBJCUfLz
 DR9/HPEMewtyu9w5ODqGrbxJdMSyvLgqlH+OY0YhKH2Pk79kbUPmukC5u/8iBxESTiTShtH7G9a
 p01t5GAXS4qolZyXOx8LeHXAHlZTXEINqbmK1C9VZuNJjjnPCDeESkQx4d00DBto6B4KKwmPgMA
 ztBt+SmO4goCQ3IEV3Q==
X-Proofpoint-GUID: QmmZFYvHWDIvyTtLVFU9Ac5iZ0ECRtna
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAzMSBTYWx0ZWRfX3AxaGMi1Ap+g
 TO08vfecaOdJLbZdZqv9L8qGvckVRsO69HgK6oo5kDBIQaDKZxNf+CLpg0nXpC//avWUEedF02x
 Gaw92jtiElGiQ91+aKGlz2iax1phYTM=
X-Authority-Analysis: v=2.4 cv=S51MU4sP c=1 sm=1 tr=0 ts=6abe1217 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=YTtnF9t6jTAegt3XP7wA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: QmmZFYvHWDIvyTtLVFU9Ac5iZ0ECRtna
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010031
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

On 9/29/26 4:20 PM, Roman Demidov wrote:
> The OPP reference obtained via dev_pm_opp_find_freq_ceil() is dropped
> with dev_pm_opp_put() before being passed to dev_pm_opp_set_opp(). If
> the reference count reaches zero, the OPP object may be freed, leading
> to a use-after-free when dev_pm_opp_set_opp() dereferences it.
> 
> Fix the order of calls: first use the OPP to set the required
> performance state, then release the reference.
> 
> Fixes: 5a903a44a984 ("drm/msm/a6xx: Introduce GMU wrapper support")
> Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
