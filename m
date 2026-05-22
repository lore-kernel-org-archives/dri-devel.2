Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 873EACD5BB5
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 14:43:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A93E10F66A;
	Fri, 22 May 2026 14:42:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jfihpSb1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h4VQhaD/";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC93C10E222
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 14:41:16 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MCCZss778849
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 14:41:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sSMMxHxRNCis+0TVEZjUEI9IKPS7rPdh57bkRY+Mtv0=; b=jfihpSb1ajNXjtB1
 e+9hkWsNCDpF+XqTyA21VxoqCMeTq6TuOjMMZsUuYVi6U2GVLGY/LkzW5lDy066w
 Jey79YVI9wUY1+DzdCGa6rNMbIOWlszIfpVaxM31ASXMPhgN1h1Q+TC8CzHh+b9n
 WUw+Vo5n+PL1Vk6SR05lQn2OD1vbWgyjaiwyCHk+vMS6vIFHsBFYoJP1sx0nWjoj
 KkhILSPd+5x8E88YdaE5sOgsBDq1I4yhvNtAIXLDhg4uxpPXMbEDoGpini9DWu8X
 wd4XUmUUNMLm7QNcIyfNwzvizpNFt7C6EskD+awiG9XFcvW89jXeAyYPqoSl4fp0
 vWi6SA==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eac7au6w1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 14:41:15 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-95687296dbcso323674241.1
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 07:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779460875; x=1780065675;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sSMMxHxRNCis+0TVEZjUEI9IKPS7rPdh57bkRY+Mtv0=;
 b=h4VQhaD/nji2vdQrkyIPIjOLEk7jEK8xqbCED7852KyI1oiNHUoINZtixI6vvONLC4
 oQj2tNMlWmr6gP1JAIpfQwoutF0be1ZZfTw8RFIn6OJryqheNWURZwIGfpIOCKrFUTCT
 JU/Mu+9rPjIfUfJQi9sKKAvKFHae8MIBXxK7wBWXrMKMrjgJAC26C0fYobNpoDI2RgeP
 LRcrGucckuTvmc6IG4daBBk+evNh9JxTIhorzzmu56BBLA2qZio6dhRw9aqKS+X/+QtW
 JreLm3lI74anbxn74yn4Ylu8MvkMvXi5KaZGabYkIF7pllfAFQ6sYlijwpVZE15f3SAg
 0dvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779460875; x=1780065675;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sSMMxHxRNCis+0TVEZjUEI9IKPS7rPdh57bkRY+Mtv0=;
 b=oXrPEuwTIccmL2vi2EIoGkRYjXKNwKpgTT4e7BAjNOz5cgIbA0AollssROlMEl8qxI
 /DotVQ36TCTUfQBGlZ3CEMwqS2pNCx4HhNnvNQpgpsrM/8h6RldAvXIgUjIkhaKy35+u
 15pATOvxFi/S+aPD6yHO6JVDExbnANDNueEmyh7bRcl8xN1RUp+GhZnbjn3//l0fyWM7
 N3CFfAtAjJjRfFH+Cj9/nVF8K8rFj8wACISVDI99Ex4o0P8fhVlDU5MMHEOcmLl8qhcx
 rN6Oo0wKNldJ2YEIO+ruMO2T/LJ67kLxV1bDTE13v3EoZ7e+4ZHbEYwg8O+i4fEKzyCN
 Fg1g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/RB+Ly/qScBK3OtnX1ZGJGlUXlKz7EEh+zyvJ0IzkEKeweYLW1KNRwHw/VBXPHsx9P3MYwX0pJKb0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyqcsaenSx0V37HxYqwaDffQWfrr4TWhb4eMJK0LYbJKyojiMVc
 Mlru/2sa1gl/sylWGeph3P9XNwiaj5q2Zi2j8rP+X+LFLkc1hxycyHSfX6vqGB9dCUz0tZhIv+t
 jjjGXGsLOsI7avIRgEiAxxvFpucV9GUN8AmYiyZ4yuaL30UI22co3qwG8eDBuBK1p/kPLvuc=
X-Gm-Gg: Acq92OHRYmU0HqU7movi3GkFtailmEGS45m+jc7Rbc1G2uUbdVRh5L3I6dzIfde37L9
 0ncpPZqrRlo2Ei0xz04zKjwpXRt8vhgvW6Rh2YZTStc+mYhSs93oPj/p5iCoGp7Sy9aJohzALrR
 1lIBbEDJOWwRcFK32DaWPapAK+at1WJlAlhZg0JKjm+mjOT2ZfOB0OohGn8eebgQFle7xozTkfH
 T3bAl/4J+ou63gK2gDhlNpX0IAvZzvowHmQ/LdjR6hp+NcFR3/6ejLXW9upTsA/6/3Jm7D91PQT
 t6F5PFRHu53rxuYR/XABZ2jRxRzgE+AU+tOYetLwFiVo87rMRKcPwBMEoOAcWHVuRb6rQQaYoNH
 4hGpKujIHhPXefFuxdKyvRrvP7UZ0UB7O/mHDI+u/z68rtQ==
X-Received: by 2002:a67:fd4e:0:b0:65b:c17:7052 with SMTP id
 ada2fe7eead31-67c5ff1dab4mr640210137.0.1779460874688; 
 Fri, 22 May 2026 07:41:14 -0700 (PDT)
X-Received: by 2002:a67:fd4e:0:b0:65b:c17:7052 with SMTP id
 ada2fe7eead31-67c5ff1dab4mr640187137.0.1779460874270; 
 Fri, 22 May 2026 07:41:14 -0700 (PDT)
Received: from [192.168.119.254] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bddc3652b34sm60566866b.28.2026.05.22.07.41.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 07:41:13 -0700 (PDT)
Message-ID: <f1d191cd-22a7-415d-8ab7-9c0948b9e30a@oss.qualcomm.com>
Date: Fri, 22 May 2026 16:41:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/10] drm/msm/dp: Read DPCD and sink count in bridge
 detect()
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260314-hpd-refactor-v5-0-0c8450737d64@oss.qualcomm.com>
 <20260314-hpd-refactor-v5-3-0c8450737d64@oss.qualcomm.com>
 <c67ee441-83d7-4b66-ab19-c2c282c1b354@oss.qualcomm.com>
 <q3wtsw3djk47izq7za5p425wuxoykfsejpm5hs72jtbytnrgpn@in2o4iza7svk>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <q3wtsw3djk47izq7za5p425wuxoykfsejpm5hs72jtbytnrgpn@in2o4iza7svk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: cCy4BOLWR3H1lSK5H3Bj5RxJuENiQRs2
X-Authority-Analysis: v=2.4 cv=JrbBas4C c=1 sm=1 tr=0 ts=6a106b0b cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=FAVcj_sHJixdwfoHFuYA:9 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-GUID: cCy4BOLWR3H1lSK5H3Bj5RxJuENiQRs2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE0NSBTYWx0ZWRfX0dGRepyT9row
 ug1Bo3W8e64WeD3uurrb5CtoXvQ19qPlExhyePpA8kKFUGZKQ2IhidI3W53UmzDirJQx9ToOvCG
 1eggce51YmxsgKtEiby9/6DWfuXUpfSCQCArV6yHpoW1v0mznM9BjMuZ1KTdGFX2TyUQBGPkhu/
 UqYv4y3B0atYmD7jNCLdIurtb5H3U1mEuyRYpj8RQBA0QjxG8sJijNnNEFFaBWBn+iUbzaaLsGE
 Ocek575Hq2o9tT+zhPZ1yEZhDONSUq1frZ5Ht7l7yaoTM/C8jFK7oN+R3lPQPJfDNW/b6hGTD4f
 rJGbliaEhY5WNqAtSsgrlMwoHvp9y3vVFEEzSHV3ejXudyjJs5ZFGhWJlArLlIrs5kwN/HTd1cI
 0Hkr/d/82KvV5NO6xpxnEM+DEUUChMowzAPPSA6D31Nb1pIPLgDR2SAAjhBTdV1SXVnOVNOK0w0
 6QiqAhAMWLqFIil576Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220145
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

On 5/22/26 4:38 PM, Dmitry Baryshkov wrote:
> On Fri, May 22, 2026 at 01:30:54PM +0200, Konrad Dybcio wrote:
>> On 3/14/26 2:09 AM, Dmitry Baryshkov wrote:
>>> From: Jessica Zhang <jesszhan0024@gmail.com>
>>>
>>> Instead of relying on the link_ready flag to specify if DP is connected,
>>> read the DPCD bits and get the sink count to accurately detect if DP is
>>> connected.
>>>
>>> Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>>> ---
>>
>> There's still some trailing style/documentation feedback here from v3
> 
> I'll correct most of the feedback from both you and Bjorn. I'll leave pm
> calls as is, without using ACQUIRE macros. I will think about using them
> for the whole driver rather than just a single function.

Sounds good

Konrad
