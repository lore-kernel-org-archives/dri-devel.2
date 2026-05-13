Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A4DCD4F24
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 11:23:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A38FF10EDF1;
	Wed, 13 May 2026 11:23:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ELsk7VWy";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H6jucJuH";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D5F410EDF1
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 11:23:51 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DAVtRK1393180
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 11:23:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XRL2cuykGlS3d8so7WuC8Fpb4c5xTJU7q6YYlpYpow4=; b=ELsk7VWy2qpKjICT
 FzJac0QLduBhm8lUhUCK96TeEmYcDa7pXX0C3+bljKPG4FXVoilw9SV8/DW6anM9
 Xzd1rPzYh68Q6AFGtBv4wLsfMwZOo3lH9OFYxM/f6lw9eWxA4C/Sqv3QDHzWY/NL
 1yD49wcPjOqDo5kijTJqfPgvyO3NmJh7MoAE5fNNRisWbsGEcsaVkcasB70ZxRGm
 T0q+BrcALunCOtKgShaZhyVGN9/914CbkCfED9F44Ff4N9tJs1ftE6LyeHPQTcxd
 6v40bU6C5lFoaPEWpWKQ5mBji6TBE3BPJ4a0CDMxm3fiavtR3bAR+tGV+Lwjz3XW
 JOKs2Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4k261cy8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 11:23:50 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-514ae0edeb6so92362541cf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 04:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778671430; x=1779276230;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XRL2cuykGlS3d8so7WuC8Fpb4c5xTJU7q6YYlpYpow4=;
 b=H6jucJuHjrOFMUrFeCWRB4Q/JroYQPaZvFzUJlvsSO8wRw7ns4e1GIQ1W/92+zVHn1
 oG8hVVY/SzXrYYn/i4uvahRfzShLNBHJnjXnjy7D3XP2yncYW61pxIpIAyJD7W0uv4x7
 l3jeXTyHUM+Vfui9lqFWJGgpriC9XD9trZaZ5e0sv8pC1NlAc2sVrgjfYrQRQ/r7+pcU
 LtDM02df2ZdPEjhi+11QRRmv0x1AHxy4pausFjD1ClY5qGRgziDPMHBErBn37VzWzEqc
 fIpCNSjUC3KU19aGfzEl5X5lVHVvdklvx0DWjHY3D4fsLnC6YYVAouUGHu0a2C5ILePw
 k+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778671430; x=1779276230;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XRL2cuykGlS3d8so7WuC8Fpb4c5xTJU7q6YYlpYpow4=;
 b=lBk9fW4QD3qhlKIvFVteg9aXyoVrca8SsC/Fjixz7pETdpzTzP1Ejy1aMOLstO8dvW
 0Pqzk/M6NuMB3Mw6Hwv2q94boFRhKFhQvDqP3gI2TH0DxvVRb8HqZJXkg+w5yEaDEvPj
 smZq9YEPXmeH34vtdfGTeZRKqtGIGNv73cQKtxi3mwOhEqrhutZ2eBkxM4FMUgfpCLAL
 V3RMLh3U2AelXdSBODGqvFdW4cVPt9Ny8zD9y0spIW2dc0FtKjJhFGncyUbMVe6iTx7P
 cjKc568G6opM0ADq/hKKnlTJ2ILJuZMpcZeoEbrBrvgClCcccl/IG5H9PQ6scWKVD9Bg
 pJfA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/q3VSaArOwacpF/W736BMSTBSAc81VH6xmoMRWin4QqXKAG6HSS0eOFHbqapw5mL+JPqByoQuMK3U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwJBzGcPHBUuYYskhASDjFGIP/glbbiCI82B+FAdMm4A58tt49f
 eN1IWSs+FsFb1PklftNVYCqBmJu6LsAoivNOFE8ePT6v18frg1M/wn7GXJxTuJfJT6mfLTPVb7o
 3JS/C4vpjda25zl+Xtik18VpzhZWqNDhKhvIROK/5Eg/GshE8zhYi0uepO6UBIr14ZBAUBNU=
X-Gm-Gg: Acq92OG8KSUtduvZLUWWNLgtSC8nyHVNed7O0Sb8L9bdh6rYjpWkKvLwaVO5rFXAwYs
 7tXu/Cv3kCRarGZnGorGN8/RE0eVM8KsercWxmN4MPvnCjKMZWrEMeQWidg5FD9b+kT632NB+yr
 VejVf6UB0idmjP60Rdvz64yZTJjAWW/7zantEbLbjLpuL5Wn4s+Gh7xHfkM8y82ivPy8N+mQAH+
 BClRSCNHwWD1EP9WYl6174OZ+pHLPNGQ3Ziw3Ut4Fv5X0S1Vfg3Dklg3ZOmOrtLzGGcuudFscqX
 RQRyQoUqm3R1oB7sg46zonNn1W4IbEE0vEiCnKfr9H+bJaY4P4ssy7zYUpyoERDeeDfuodJVdJ+
 kDeHlBEd+jIA0EJ+0jBUNGqlekesIYi7Mbpq/ghGuFnr0XdwgxPrFodyaA9h1O0K9BtcYD4I/uM
 FCJByu9lvqRmv8JsIoexM/Lj9HpF4pEvRSym+Hfv2nFrVHWS4IwooOvuwRT1cruw==
X-Received: by 2002:ac8:57c9:0:b0:50f:39f4:3a2b with SMTP id
 d75a77b69052e-514cf036ea9mr92135561cf.41.1778671429779; 
 Wed, 13 May 2026 04:23:49 -0700 (PDT)
X-Received: by 2002:ac8:57c9:0:b0:50f:39f4:3a2b with SMTP id
 d75a77b69052e-514cf036ea9mr92135221cf.41.1778671429293; 
 Wed, 13 May 2026 04:23:49 -0700 (PDT)
Received: from ?IPV6:2001:99a:252:3300:d706:9b57:5996:15b4?
 (n2i9bzmlzk2z87merp0-1.v6.elisa-laajakaista.fi.
 [2001:99a:252:3300:d706:9b57:5996:15b4])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8a956b325sm3888437e87.79.2026.05.13.04.23.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2026 04:23:48 -0700 (PDT)
Message-ID: <b951a99a-bddf-4fe7-8ed0-4861d93aaf4e@oss.qualcomm.com>
Date: Wed, 13 May 2026 14:23:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] dt-bindings: bridge: Add Lontium LT9611C(EX/UXD)
 MIPI DSI to HDMI driver
To: Sunyun Yang <syyang@lontium.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 maarten.lankhorst@linux.intel.com, rfoss@kernel.org,
 mripard@kernel.org, Laurent.pinchart@ideasonboard.com,
 tzimmermann@suse.de, jonas@kwiboo.se, jernej.skrabec@gmail.com,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, xmzhu@lontium.corp-partner.google.com,
 xmzhu@lontium.com, rlyu@lontium.com, xbpeng@lontium.com
References: <20260508142500.4922-1-syyang@lontium.com>
 <CAFQXuNYq5QYAXRzcUBnyvVh5ofPBVYONCs1dM6qPgK0BDja5Ow@mail.gmail.com>
 <vly3gbft3k76mrcztcn6vxuqadz647hsaz2q7qpmpofowofodb@nnxrr2cdueru>
 <CAFQXuNZKoahwq0zoWg860Z-amTKEefBFuen2fDG1htKjzE7ymw@mail.gmail.com>
 <0636aa3c-5240-44a7-a551-4740956ba5cd@oss.qualcomm.com>
 <CAFQXuNb8w-+xEYeDSxaqK-2hxdu5ADo_Vtvy4iVBzSgNzRmSuw@mail.gmail.com>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <CAFQXuNb8w-+xEYeDSxaqK-2hxdu5ADo_Vtvy4iVBzSgNzRmSuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=M/l97Sws c=1 sm=1 tr=0 ts=6a045f46 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=Kz8-B0t5AAAA:8 a=VwQbUJbxAAAA:8 a=H94J8E7gSZs0rZod3-MA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDExOSBTYWx0ZWRfXzrBMmdVs+OBA
 PRhBj3vESFXEELitLAEaJg6AGLeL4+DqKHL4M9aTaOHSdWYEHN3//3dolbhGRFb7H6uEfciOuL1
 NRMgkqxik/MW08ysdMRLPLQZG5J0U16ct4e98Re3koCbGrIgPdxBz9QZhrZNaKuYybm5o+9PStu
 4KHxgweSligBkLPHspvcyWijlJYimR7P/M+sQxR44w0SWwBSsn/Iu+FIqaa1b6l4AFP8yda+W0e
 IZoFrXAb97E/dw6ElOuTT7snCBnBAbDtOxwv62PID+kuEBW3sLDQSJ90YTsqrM5xQ8qNK2OVetT
 4JyWLvax4f4rJa9Q7gZZDmHs+n7Bfd5o7OVKDy0wynpxRBcmj4OLmvFEGaPX7ZA+OaQ3OPKDcha
 5knyoQK/FP7wZ5nydIPkp+fQzYPbUuLEy58dWVla///JmmCBy3BM9ABCaNbV7kOvD2JLkekjzX9
 k/mvyYzKICzZ72J0gtQ==
X-Proofpoint-ORIG-GUID: ExhoweDvf7NUSKVIyBMXLQOLZulxV3FW
X-Proofpoint-GUID: ExhoweDvf7NUSKVIyBMXLQOLZulxV3FW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130119
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

On 13/05/2026 14:22, Sunyun Yang wrote:
> Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> 于2026年5月13日周三 19:10写道：
>>
>> On 13/05/2026 14:07, Sunyun Yang wrote:
>>> Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> 于2026年5月13日周三 18:24写道：
>>>>
>>>> On Mon, May 11, 2026 at 11:28:06AM +0800, Sunyun Yang wrote:
>>>>> <syyang@lontium.com> 于2026年5月8日周五 22:25写道：
>>>>>>
>>>>>> From: Sunyun Yang <syyang@lontium.com>
>>>>>
>>>>> Gentle ping.
>>>>> Thanks.
>>>>
>>>> You've posted the bindings on May 8th. Please give maintainers some time
>>>> to react. Not to mention that you posting the bindings 4 times in a row
>>>> (once together with the driver and other 3 times separately) doesn't
>>>> help maintainers.
>>>>
>>> Sorry, when I submitted the patch on May 8th, I received bounce
>>> notifications from devicetree@vger.kernel.org and conor+dt@kernel.org,
>>> which is why I sent the patch again.
>>
>> And some patch trackers will now have incomplete series, others will
>> have duplicate entries, etc.
>>
>> In future please use `b4 --resend` to resend the whole series at once.
>>
> 
> Isn't it recommended not to use 'git send-email' ?

The 'b4' tool is generally recommended over raw usage of 'git 
send-email'. It saves you from some of the troubles and catches several 
typical errors.

-- 
With best wishes
Dmitry
