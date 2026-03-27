Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3504610ED655
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 10:37:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A73F610ED36;
	Fri, 27 Mar 2026 10:37:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gvDGaJyq";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LqeFhhP/";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBE6110ED35
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 10:37:13 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62R6w7Gg3132239
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 10:37:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KXK+Mf/ZrsGiJRXbh5eHrmVzB3+0zk0auj0U1dEWne0=; b=gvDGaJyqN1zcEZab
 FgSvh2zYseGKWm+h7p84fHOeOhCc2jNBKEbRnOu3dD52bB4B+PeNfdOffGdwKNaf
 ip5zm2EfKzPKlNRbJhTLDpNtZKnxT1JCcuUnbEDS+IzYIyuMvLg2rjCsOI2zunrQ
 ujrNwEXkKp9gqwROuM4Kr5gPHLItgUhN9sOWZsDygdOSQfdnd3gsq+GweNoVT8IS
 UpZSeev8TP3HXtok2lcdJmY5kopMlJgQgLRSGBNTGkH6wrBMBOI2cFPChyA2C8PI
 lBhiYFng2ami4F4l45Ng4rqmBi+s798nN2dOAE0xZ6rx3JcUa7x1AUPu2B/mFAqq
 eN4Jsg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d59s433au-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 10:37:12 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50b2d5e61f6so4848861cf.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 03:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774607832; x=1775212632;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KXK+Mf/ZrsGiJRXbh5eHrmVzB3+0zk0auj0U1dEWne0=;
 b=LqeFhhP/5l2GXz9h1OGYnWM0xE6kiSOHsHG2ojKttlmLVHvu0OUQCn5mKdtr4K7Tq0
 EH9zcUCoYz7RFmIeYKnoU6/i7rc1V1O2fqX0qkOzxysuywpyG9VM3Ufkb3c3hx1iXxRk
 imXm6Wt+eHcRxXUP2Ss6kWagAtMEFu/k8Ix4+wE4jC63lZ9QY0LEWOfVUcHTO+OrHRIz
 Xs/8wa/ZvyRmGpxEMfp1G4JoYTd+JuMEtRp5cFsotbvOTvZBkSCzzIs8+KTiH/JG5PUE
 Ryfbzk8bjLorcAG7uRKo6pc03XiIA5apUJsxROjFemsek+AcgA1mSU1i+VBj3rwHSzgv
 4Yow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774607832; x=1775212632;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KXK+Mf/ZrsGiJRXbh5eHrmVzB3+0zk0auj0U1dEWne0=;
 b=iGNKoA71PzkYYGBxb0GsOBy+VbcHQmeuEZGuF75IgYgATHffo6NGOH2p+3kCzoSKBK
 bdkDs/zShfMXFgcD91tF/KzCZIonZY/qW0scdoVHypNOLVhk9idIfi/gtRt+QKw8VOQ3
 C8NW8+rBNcNjJvxILQ7TXZnbcuzJEbo2seGPv5Igwl3IO0JAknIGbtUstDRCiSWoSPlX
 fgxj37JZhRunCjn3ZUEHr14ZrhKt1HhzmIfoMfXIqt+lg500uJcmcfUpbFMVrN5S+4IS
 E0H0HzkRWb62mTZE5Yf8aveAFIKwTpGRl+w5kqsiWFnhwZI6bMsFhzMjNrptwP2nnSP4
 GDpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXujs46ESzEaBdqUUhCXqt1Vl4kegT8Hy7JHfkdFJVQrzrqHfnMquPonGz/81Nakmqa0EDqKXTNWcc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyg4azdlUqwMtVZ+/G8zampy33DOIw2m7bM+BhqcwSqdsGTan3F
 Y0GjdG7usuAmcsrjj7AYJnnDo6fS13blw+ppL0Nw6qfmwhtOdhlIAtLj88pk1HxDe8QWEajmBtD
 4gDEJChQYX3pkYvZrbYbB/tFc0Q6MAZuBVQ1GFEPTSN22qr379PoJN1n0uRfY5K5KvEqIbIo=
X-Gm-Gg: ATEYQzziSCkoSZ2hXUfjfzesw/J8Kd6aGJD5JVwA8ntLB3n3GwXFVBxu/OHm+2WlJKk
 oSEM+NoBV29gNIcAYnM+w+kynconr0DJTDqRvTXxhRs6JmL1kSFvDs5IZyfsV62w7rDkNTIR6rS
 RJK/CkfR0Vlc8tH+nXnGCLKk7+blasP0gVwoLQRR21yTF+BUnQwguUxeXwE87COqSE1n1jXWDtM
 Mt707MzIXlGLIxX2ffUsMuqACE7cnZr2tnFtym9XIGsLWrAjp9YVs+oxkcy00+WXXAbXJ5oDZj9
 QG+Dbsr511LkFEwXI+g90f9KjYiFRDSe4+pFJ5N6TV+UtSE76649anKh4AMHlX8PZW97AN4yDIz
 56jHlYEwU7HA1Tb9EhDTB0feJCilvbmcSYEYw4cqKYALeIfhfgT5m16F4MI6kPRc//OCGVU4ZGZ
 p7Nfk=
X-Received: by 2002:a05:622a:17c7:b0:50b:3489:5495 with SMTP id
 d75a77b69052e-50ba3ab19bcmr16602661cf.8.1774607832097; 
 Fri, 27 Mar 2026 03:37:12 -0700 (PDT)
X-Received: by 2002:a05:622a:17c7:b0:50b:3489:5495 with SMTP id
 d75a77b69052e-50ba3ab19bcmr16602371cf.8.1774607831654; 
 Fri, 27 Mar 2026 03:37:11 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9b2044274dsm226449466b.59.2026.03.27.03.37.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2026 03:37:10 -0700 (PDT)
Message-ID: <4a55d9c0-4138-4905-a736-01b966670a9b@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 11:37:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/16] drm/msm/a6xx: Update HFI definitions
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Connor Abbott <cwabbott0@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
References: <20260324-a8xx-gpu-batch2-v1-0-fc95b8d9c017@oss.qualcomm.com>
 <20260324-a8xx-gpu-batch2-v1-8-fc95b8d9c017@oss.qualcomm.com>
 <30a4cdad-47c0-43f0-9327-04c28eac52ae@oss.qualcomm.com>
 <acea56a0-f854-4415-b4b2-2e320934b6c7@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <acea56a0-f854-4415-b4b2-2e320934b6c7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: TviJzTK87bezCDSsfZaXi7Znng6bkEXJ
X-Proofpoint-GUID: TviJzTK87bezCDSsfZaXi7Znng6bkEXJ
X-Authority-Analysis: v=2.4 cv=CoGys34D c=1 sm=1 tr=0 ts=69c65dd8 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=oNxwg4Oaq7jLDjx2sdcA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDA3NiBTYWx0ZWRfX1bsQ5QQBAKVc
 0nnEY/G//wFDf9uGuyHG0A/ie+xG2oFVylINcPhXz5NkIcy/ziNsLOApCkuEjF8wuR8wEM8HTvA
 kJlNdPCnaMIVAN0KZOmKfYVUnaGuzOTyCp5W/8h+cEo9ua60yFuM+JMNT+HWODazoGFjv94WAFp
 /PyHJbklZBK9g8l3Jr0lf4G4AwJn4TgFUlOfmp1/dhWXaNTjdyCP3tedq6fMQ3f8x+Ko+GOp9p4
 Kw62CaMjIYfD5O27Uhy/phJz+tEmNMr2PeacdmQQA/aIkybgdljokE++7RnBkyRdL1CFE0f5lCT
 tCdJ4ivZQXkrmL3cZ3Jkcus75cI0Fjkx+cOchQXg0x6ksFvdkhWu7LYqwVCkuO0ykrzjhqz+Blv
 c0x8X7yzhrgBA91+0ytBcMlqhESY2IqiEgMdSHMwdcR26rDBVmhxXAczPF9coEZFN02Oez3Tbgi
 8TG7yJxLOiGUJqOem4w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603270076
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

On 3/26/26 6:47 PM, Akhil P Oommen wrote:
> On 3/24/2026 3:30 PM, Konrad Dybcio wrote:
>> On 3/23/26 9:12 PM, Akhil P Oommen wrote:
>>> Update the HFI definitions to support additional GMU based power
>>> features.
>>>
>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>> ---
>>
>> [...]
>>
>>> +#define CLX_DATA(irated, num_phases, clx_path, extd_intf) \
>>> +	((extd_intf << 29) |				  \
>>> +	 (clx_path << 28) |				  \
>>> +	 (num_phases << 22) |				  \
>>> +	 (irated << 16))
>>> +
>>> +struct a6xx_hfi_clx_domain_v2 {
>>> +	/**
>>> +	 * @data: BITS[0:15]  Migration time
>>> +	 *        BITS[16:21] Current rating
>>> +	 *        BITS[22:27] Phases for domain
>>> +	 *        BITS[28:28] Path notification
>>> +	 *        BITS[29:31] Extra features
>>> +	 */
>>
>> My first thought would be to define these as bitfields, i.e.
>> u16 mitigation_time
>> u8 current_rating : 6;
>> u8 num_phases : 6;
>> u8 path_notification : 1;
>> u8 extra_features : 3;
>>
> 
> I am unsure if the compiler would mess with the ordering. Aside from the
> fact that this is an ABI with the firmware, what make this piece of data
> very risk is that, these are power related configurations where the
> issues due to misconfiguration won't be immediately obvious.

These are two fully equivalent ways of representing the same data.
The compiler won't reorder them, since data in structs is.. stuctured..

In any case, either of them is fine. The struct definition would be more
convenient to work with if the data was provided in C code, whereas I can
see the simple-u32 being more convenient if it's going to be pulled from
the DTS

Konrad
