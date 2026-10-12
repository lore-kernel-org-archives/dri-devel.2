Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FEB7CA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 06:18:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8671E10EEF4;
	Mon, 12 Oct 2026 06:18:21 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D944310EEF4
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 06:18:10 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C55gZb750872
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 06:18:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 U5WUPplqDfO932T8HETSyOqNnzvpg7DeYZKhN0l8jpc=; b=Cn8hUM4vWCtDpe2E
 ymdUQ8XfxpeO1hrFARUAN8PuGHifvXVHqDUGjLfgl7AzedtfJPo6rizshpP+Pqmr
 asR3YFvtMkiQlD4YA1T7zlJQttiWj1vwat/O091WKQXP4lNv5dB4n1YLKEUYMcaZ
 I6IhVWYCH0tVa61Lo2tpiJuFRNsF09P4lqrV95XgCW4b/z5TifiEWkHW+VSLjOJf
 25ngpFOT8J1xZhLRwCKruTsEbWEGu44B5WUq2V8+5TOycBrGuO7ZoSNIMuEiau/N
 FDCjqDe8R7lPexu5JtIFphsMikpZVXy2xSqKMgMPysuw9j1QsjD5DHRbQU/kcko7
 ENxPsA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7e4ecvpf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 06:18:05 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ab868fe362so1436731a91.2
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 23:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791785885; x=1792390685;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=U5WUPplqDfO932T8HETSyOqNnzvpg7DeYZKhN0l8jpc=;
 b=d9aEbEkNHUPxTAzAvRd9L0t94btNGykkGSwQeF+NUBYLRaQO69TUNSz1zGA6IlwJn5
 mIQpWlFibURUsKWFjrVj6UXRvRVGc3sRxLPe2X5mpGNq76+o0ZBDfeijl1IADclbsUTT
 WN7NgyRlZVy76I7pUR4BJMhyjNhghAO4u4/t47yyFgbcO8x64VXwYw9LOovbSp96WA/g
 82+cUmdJyQ/uIjPrvhB3FiIqJgAmCgriS3T9IayDMAwgxgAHjwrjOoRle9H1VhLyZitf
 4xU6DglgP1cXf0Xd2A1zwJyJEclbs8sLf8DLDa2wZ0Ijf4YWk2HnIxqOhiYvx1Eo7d8b
 v3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791785885; x=1792390685;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U5WUPplqDfO932T8HETSyOqNnzvpg7DeYZKhN0l8jpc=;
 b=NTxrarFYUMMyU4zDwWIi61MPGdr8XR71FOb5NoJoW21jOCi8r9ArFG+2pNyNq4M/jA
 9h9KGaSCLWH0mTYkGp47v1UxM5vSkG7fYEse5s+0KbG2nkdGgy2TetWQ/dw8NZBL/3dT
 Qe8fwYyUrDAI+Y3odf0drXApWS7qZb7qaChRyRXmnzkUF1zb8Vy6hL0HMp9/gGBOuFvH
 t4R9kAkS0P2ZwnA+oZdjZUN0I819jckQIRvUazFt64hdXHwWGJV+XhQBcUC96SrcAbIX
 7bvrhlClVvqBCwA4mZDkJnn61Ao9xmE0bRoxwWqsMNb7ZrVaJrEkYWeCSvpzEcWGAEyu
 v9oQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwwxWCfVpoakg/KK11QvQ+fBEUxVX+Pbpf3MQ/w9zrKbmYiPKvF0qrhbaNqMxhqXwz4mQUB8fbXNl0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK7iSS7WVHMwVrP3Scg3mGVz49dTasK54aDir45f0eyxVaHvx8S
 OsdVAq01duklIsGd94P2e2/DHHNOk6eeBxgitqrIPgo5nB6uCBy3CIyYPd9ZTxPMLmYHd+J1MDg
 igo8s4+F6zafG1nfPKHG4VNX2bcv8rNJ0D2Ymc04UeADXVbnYvOZ/6btSt9dXLZrIigF65yY=
X-Gm-Gg: AYBFou1ZnvTRERzLofYRwrbMlQeWOB5ehIlX3wJzeOZ7Fyxj9IonFPbwOHXQTPKMkpn
 YJ89gjIy/SvFSYnyFyNGmuwTS0PuQPeRER0j7lQ5qzmZyUZItWy1JsYbuxkNyNL5pWLNSfkWFNs
 k0wCSNQzPSHMi+qtBKJgWl7w92X4r68PcdBthMJgzVS3LmBHfyhXUAzeTOTkKA3Epvknnp5/gK8
 EuL5RrMyujxmTKDYhIRnRj6RkpT9Th/PIj1doWNbcLWnhRJeVlQE0amG3ODIejucV8OHagW+79X
 CRtc9yx3O5TYh+GnqgQT9ebGGf/Gsepjdf4CdwU5B9NooJVJQuWaR+0gEhfult57maz74Z8yRCT
 5Uf2XAbIlPzoMgYEcf1RDv/HWL5Kp2GsP2w==
X-Received: by 2002:a17:90b:164b:b0:3aa:fc22:8ab4 with SMTP id
 98e67ed59e1d1-3ab3a97eb66mr6399550a91.29.1791785885202; 
 Sun, 11 Oct 2026 23:18:05 -0700 (PDT)
X-Received: by 2002:a17:90b:164b:b0:3aa:fc22:8ab4 with SMTP id
 98e67ed59e1d1-3ab3a97eb66mr6399515a91.29.1791785884714; 
 Sun, 11 Oct 2026 23:18:04 -0700 (PDT)
Received: from [10.204.78.217] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab38f4863esm17543736a91.11.2026.10.11.23.17.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Oct 2026 23:18:04 -0700 (PDT)
Message-ID: <926167d5-e912-42b5-a040-be2bf220adbc@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 11:47:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] arm64: dts: qcom: kaanapali-mtp: Enable USB headset
 and Type-C accessory mode
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261005-kaanapali_dp-v1-0-6faeac3a6d59@oss.qualcomm.com>
 <20261005-kaanapali_dp-v1-4-6faeac3a6d59@oss.qualcomm.com>
 <ytqzmngqzb2ear5ovqexrzcw63t7plac7hvsbh3ce32krt4mfd@e3yyzs6y5anq>
Content-Language: en-US
From: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
In-Reply-To: <ytqzmngqzb2ear5ovqexrzcw63t7plac7hvsbh3ce32krt4mfd@e3yyzs6y5anq>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAyNCBTYWx0ZWRfXxsq3wGFtee2u
 D2lQ9spG8rV2E/HzWMGCeKyTrsK16HswsztCikzh2g9oI7VnTaAzq68C3QNNsnmFgfOj0S9i8kt
 i8GWtZJ+dXXQqCNSpUgkTkhGQjiCD0tnMidlYA4VdsWmB6u4hVQes1JCR7DvxCBDx8g8ADXJLkP
 TvinoUWKjS2Y24/kkB4DzEsekmCE5Bmq+Bidr96N4a6dTIOt9fySwKA89sq8vPheMxI1ILtWJe6
 pL7bbHqJTghv9iaCfRcSbm7CVoNO+JbD1atx+3LwdF0TKYlHJswsqC7DrwHqb4DaEsbUoWIuk+Y
 IeCxymbR775NYFX9hddqEvVIC26wl+K/Vu976ccgAozWD9DhQqUDrK8JN0SFjRcg2stS5lhyEYe
 pJ+STzCm/OVPhO1vvpJ3rQDMXx7Qaw==
X-Proofpoint-ORIG-GUID: pSmxvg5KEuIIk-q7z48FfidagU4aHK5u
X-Proofpoint-GUID: pSmxvg5KEuIIk-q7z48FfidagU4aHK5u
X-Authority-Analysis: v=2.4 cv=W5utxhWk c=1 sm=1 tr=0 ts=6acc7b9d cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=84AGO2jvVljra0sjFOsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAyNCBTYWx0ZWRfX7gNcOrE+f0fK
 4xiXxzJ8Ma6bkiy0ZefEfEzoRq8CnqYDHlUhyI0Vn6MIMhVIXW4ZGVUa2RNNd5FK5LY3xN78m/C
 AEuJIZIHTVFx3FPYihPnj1SIZWl+UB0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610080000 definitions=main-2610120024
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


On 09-10-2026 02:04 pm, Dmitry Baryshkov wrote:
> On Mon, Oct 05, 2026 at 12:54:29PM +0530, Balaji Kalkonda wrote:
>> MTP does not have audio jack connected and relies on USB mux (WCD9395).
>> Add necessary nodes for proper audio headset support along with USB
>> Type-C accessory mode and orientation.
>>
>> Signed-off-by: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/kaanapali-mtp.dts | 51 ++++++++++++++++++++++++++++++
>>  1 file changed, 51 insertions(+)
>>
>> @@ -916,6 +926,42 @@ &gpu_zap_shader {
>>  	firmware-name = "qcom/kaanapali/gen80200_zap.mbn";
>>  };
>>  
>> +&i2c3 {
> No clock-frequency?
>
>> +	status = "okay";
>> +
>> +	wcd_usbss: typec-mux@e {

Hi Dmitry,

The default I2C bus frequency for i2c3 is 100 kHz as configured by the controller driver. That is sufficient for the WCD9395 USB Type‑C mux use case, so an explicit clock-frequency property is not needed here.

Thanks and regards,

Balaji

