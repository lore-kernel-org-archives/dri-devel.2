Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FBF4F46441
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 10:08:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB67610E39B;
	Mon, 16 Mar 2026 10:08:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NDh2WZx/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cm4MQfeH";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04B2410E39C
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 10:08:05 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62G652Ow1068051
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 10:08:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jCKxTdgkdhUfhMWVS3bqu1wMEwzKvP/Qe5TgTlQaWwI=; b=NDh2WZx/rg9oCG3+
 rKpsQ9IW5iKg3abY7aAEIGITLM0KxtNekaJQVZz2ueZUyGBfNTaj0KSme3ZBLXkv
 asbB/C8OMNZD/zYenZLU26hULxRUQErIb0MZQ4KZ4RokZ4OFx31KISOJrmxy7w9d
 5eawRa0ZpdhJzV9JGifJhVXfm7RhqorehiG7mbSbBlycAASZUa0pdS98GU5QOurC
 +kIROciR7fgvKUDSJBQ1QEPwzJdS3/sT515te7IxXBqXyAEd9HncdNQ1VbRktmmJ
 TTT6BZ7fexIhtNVV/1j9uz2XvGQUy2KElp1INJCT8QVPgMef7oWYOfZpIrv7c/HE
 AsGJRg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw027d726-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 10:08:04 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8cb39de5c54so285725585a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 03:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773655684; x=1774260484;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jCKxTdgkdhUfhMWVS3bqu1wMEwzKvP/Qe5TgTlQaWwI=;
 b=cm4MQfeHmyPIUO6JyFxqrEc6Kxdg+A8UiyPvLgyJrGM7diHw61VoCe7c6D/J/LZfl0
 XsUAshQyhE5D/2UwR2wexEoEV4Hh8Q19l9weO2kHTOMP1hJRPamYg3sXk+qRM0PyYJtV
 C9mPfRJsCy5ZdEOaaRMLRgI/6fFkgQ77Mu4UdEjqflV7BUI1jutc3ZFlMQCVbxenPjOy
 duvOpGzOi2pNTpv7bQ+X5ks7KDXN2WlsF8GIS2hNDYmlnoTxjzHwrlI3GBqNaLF1bEdh
 L4UtiLEBQAeGmC25rjx7yMOxvsoquS31pyFVMxbs5qrYeL0AEbxO/FhMZRrPmEShTLJ/
 W11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773655684; x=1774260484;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jCKxTdgkdhUfhMWVS3bqu1wMEwzKvP/Qe5TgTlQaWwI=;
 b=X8fv6pWP6xA88VhVLDT7nHD2d3kjiCPL7WRjzO1HCzsEo0G5JihBDE1a/HlLtXLM0c
 umN9sYmXlhg/Ielsqp6LzTjphY6mjJb5Sd5xxAGrMNGN8YE7rdRb07TXzIM5JmijLSgi
 w4qVbaj+S9pXsvZFywTXL17zC3pl6mGiXQvNJt2oD+TEZUaLgV1c2NqRZk8mwYYeUNxe
 PW8Qs9z2SScumaRJWl9Y0wb4lNLn8nxUJ51+LQ5mfQ1gDNPQkcy6fQunc2hMMZb+XSyM
 OLLdJXqUtjvbBKZE8bySrfajBpZ10QkdqOTpuAkZs+pZ+6x2KcK/c0KrztzTJJLiikvk
 aoqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbTuVycYn3u6OPLQ43iFJMBWO/Fu3BIPe1AX0ott+OdTTbMO2WyvzSRAjPrKf8wRDSKNPHZKFvRUo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzzYpaP1TvBFGGtS64fbRv/bTFMmsBWU+XghNdvpAGHNSlUtdal
 Icfdinkp7ewHrXzpED+IPcWT05R2DBNJRR2ghq6y/IbE+5bzS9WhBb4wfKdX+Upmql8PRCCsmMI
 lS9DfMEwHpbygXZSLDaGf9JcnYLeU15cqfN+EeFJJ8w8L3jRkiM+Gh2Kvs/yPOK4iDLjGEyo=
X-Gm-Gg: ATEYQzwrt8jR9TUuo01i6UUb3vYxdUT0Cm+4gzBsZsy3YFz4ZX3Mzl27cGL5SoggtfQ
 X0U+PNYnIqpElewdt4WKA8kzJjVe7AJKzVWreby8syJKuK0On2/lCvucAbYGnkNKAibYWlzqHl3
 0NK7qEXghztttNqGcdZr2MiAIuQo4KtAEcPfkEQrhVlrFDOhJON3HWJiZzhu9qi+T9oiisDu9YM
 qmB3PztQgKs/8NFAGrJ2SsFpTS1tU6tRsy8+EDweWih/8qh4tj4fFeU/6P+DWOfBMlv5OA/4tbG
 Rcapm04IQjC5XrRjBzI1SeQz4Ra9LGzYQhRr6MLkWcz2xsXuQvpZNLE8Bh2hRuYJvn5w2ABRgtc
 yCc+C6Z958KWKgcT51yTh59AmQbRAuegSEZocxaLTpjKieZjzsErdbShhUzTZizgDAqUKTG4Ish
 ld6UA=
X-Received: by 2002:a05:620a:290e:b0:8c9:eee0:dba6 with SMTP id
 af79cd13be357-8cdb5b7617bmr1240588985a.7.1773655684313; 
 Mon, 16 Mar 2026 03:08:04 -0700 (PDT)
X-Received: by 2002:a05:620a:290e:b0:8c9:eee0:dba6 with SMTP id
 af79cd13be357-8cdb5b7617bmr1240587685a.7.1773655683933; 
 Mon, 16 Mar 2026 03:08:03 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b97cb0d2df2sm49348266b.54.2026.03.16.03.08.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2026 03:08:03 -0700 (PDT)
Message-ID: <fe151ffe-aea2-429d-a725-4697381c4a93@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 11:08:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/27] drm/msm/mdss: use new helper to set amsbc
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260312-ubwc-rework-v3-0-b7e8f800176a@oss.qualcomm.com>
 <20260312-ubwc-rework-v3-17-b7e8f800176a@oss.qualcomm.com>
 <19b36a86-12c7-4710-8f80-5e27c9c00e3c@oss.qualcomm.com>
 <uahvm7kvu2vi6o6mwznn5eqzqqscxmfetl4c3q3xa2eryg6ode@ltxfpjmqbrrt>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <uahvm7kvu2vi6o6mwznn5eqzqqscxmfetl4c3q3xa2eryg6ode@ltxfpjmqbrrt>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: E4cItEY87UhhhNxSqsCm19_elm1CF8p4
X-Proofpoint-ORIG-GUID: E4cItEY87UhhhNxSqsCm19_elm1CF8p4
X-Authority-Analysis: v=2.4 cv=AqXjHe9P c=1 sm=1 tr=0 ts=69b7d684 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=Nnq6w86PQWoF-9HhF-wA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA3NyBTYWx0ZWRfX5ave/Xfy9v5n
 uLrwZ0gJpRXqAYyQnpAyUfyl3OWMDa2B2Vm04igvwN+Hg/2zmIxcO3nizsldPgmIarnSiRRjMgg
 d80mw/8s5SgpDDa8zJ1Mx/v7HitbJSML0oEnzwxo6aOI731V/u+yeeqFLKiN7LWCDVRfHiZpECU
 i2PTRlyZDFv5E5kZff4RHfJvMkVtx1IkFoKSypskQTFMA+DVwbqGvgheNFckbLEGblYCHUFMqCA
 IHRJLNVh0wawXj7NcgP5G9gBAJ/G5v//WURt1eyKygemVj9XzhK78ED0OJHdnod6aox960u8gfc
 FAxa1RicMkgShwhi7Xj3q9ABqH3hDrZBcGDppdOvTzlZJtXkLJ8yGihpjtZEjxQWGxhuJvc8upf
 /O/ZK6rvdftb8bJSWKCAeFPziMjYtsfAa8DgTwk4oqxPyRgTcBPllaNU/PJd0YI0ccOwNThVcXH
 6M82vrC7XFJ8QAlbVTA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0
 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160077
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

On 3/13/26 3:26 PM, Dmitry Baryshkov wrote:
> On Fri, Mar 13, 2026 at 11:19:59AM +0100, Konrad Dybcio wrote:
>> On 3/12/26 2:29 PM, Dmitry Baryshkov wrote:
>>> Use freshly defined helper instead of checking the UBWC version
>>> directly.
>>>
>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>>> ---
>>>  drivers/gpu/drm/msm/msm_mdss.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
>>> index ca59bcdde7b2..04efc29f38cd 100644
>>> --- a/drivers/gpu/drm/msm/msm_mdss.c
>>> +++ b/drivers/gpu/drm/msm/msm_mdss.c
>>> @@ -188,7 +188,7 @@ static void msm_mdss_5x_setup_ubwc(struct msm_mdss *msm_mdss)
>>>  	if (qcom_ubwc_macrotile_mode(data))
>>>  		value |= MDSS_UBWC_STATIC_MACROTILE_MODE;
>>>  
>>> -	if (data->ubwc_enc_version == UBWC_3_0)
>>> +	if (qcom_ubwc_enable_amsbc(data))
>>>  		value |= MDSS_UBWC_STATIC_UBWC_AMSBC;
>>
>> I know it's already there, but fwiw downstream doesn't seem to be
>> concerned with toggling AMSBC in MDSS (perhaps incorrectly?)
> 
> Downstream enables it only for the cases where encoder and decoder
> use exactly UBWC 3.0. This is not completely correct as the bit doesn't
> exist for MDSS 6.x+. For 5.x this is equivalent to the code from the
> patch: enable AMSBC if targeting UBWC >= 3.0 (because MDSS 5.x don't
> support UBWC 4.0 or higher).

Right, this seems to indeed be the case

While trying to confirm that, I noticed that some lower-end MDSS 5.x
chips (like Talos) report UBWC3 in the register, but the MDSS docs say
they're UBWC2 - any idea?

Konrad
