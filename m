Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 053A6C44508
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 18:07:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E23C10E216;
	Wed, 15 Jul 2026 18:07:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QG0j9kE3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IXGd/9f1";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 372C110E216
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 18:07:57 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66FHBXoS343329
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 18:07:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 owjCSr9b7MMLyEnv0fXfg5oQfeA8x1a4DWRxMp1KHH8=; b=QG0j9kE3UmnyuZrj
 W4iQ2dWKlxRnnw7FTXVk2auEnp72Uh/2ZGA7lk+BSspZMU9zm3WrT/ImHx2b8B7Y
 3DIqBChIsZ4wLPCDPt7vlBstlYgPQ92bHFz2DE6WMvu+CjSHC+4Wefiet5iXdimU
 IecgsAb5JcNUPZ6qtZHd42Dziqs8+bbRSTje/tFYlUTrUcVyT9XSVxl9gD/7U6P4
 +foflPMir01mHnNwF0Z7SvNCvMl+MbFWHXUUCmws+IvDp/MNr/uLotWBpsbfR5RE
 PWxt5v10JHpNiwo4ZoJrDM/+3GZoh2VNu8Xpue+/w+jcwHGgfW0ptv8/5WGufR8p
 Cfp7Ow==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe855a4s5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 18:07:56 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cee1ec30f2so35117555ad.3
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 11:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784138875; x=1784743675;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=owjCSr9b7MMLyEnv0fXfg5oQfeA8x1a4DWRxMp1KHH8=;
 b=IXGd/9f12TzlNh2g8xLCuYSMwJfcDT6pFqY2WUKu8qUQPvIc7acGqBt6BLNxplUsch
 0APqNYULhjdwYFmda6ZOsbD/lyMfcgUgVk2vVY1tn/yLP0eUt2cSRADLeR85H77y5t8w
 F/hav2l7XDVpsPPNnFPWTo1b3kSWssZgEutb8IHxfDh8ZjSjCj/rhWQKhZ5kzzQ5xQtI
 DpeTevUaqZetRPYpThGgnVAS+Y8f4jHO0HeLajrzLFSV0pQwLmXYXS/3/5Frbhs7CFn1
 F8Nw/aazYteKt8mdN4xcuX9pBPl2QQAL4dOS02eFF4cakRLoMa2E7RB+BMj56P7YJDGH
 dOUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784138875; x=1784743675;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=owjCSr9b7MMLyEnv0fXfg5oQfeA8x1a4DWRxMp1KHH8=;
 b=Jd7oyHwd6MfWrZINxA86lFpF7l8i8nAO9TeAhlDXV3nBtN26XK8pBjKIU211OGx0WV
 FJ2b/NTWj3PWSs37fToSByMge9RcSzFAgdqFOSLyJvIUnQ4McwE4zlZgVJGeprXX6E5o
 C+b41ifU1e4+OgArQGzsg0tsVkB1/U/TIdvFw1OgIo4pZoiMsq7MebRIN9jyKkp9QVB/
 NWOCb63eQNpnFhbJdXVPV9BO0MpxOhfUZJitv/Z/HrL3T6Kv7xPKBukyTjlNtvozaba3
 MH+AFZxgjghwx9PjCIxcsrtVGzthCe9+MNxTzLsgpBCmEn2xroleQt/nQhPQyncELwFk
 BEcg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr8dpPepJvTq4nDoaZ9Hp9bw94R7+UhaI7COcZsfzFJxw7KNgAhmuAYOlQ721OxObPIxL3hMcXL9po=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxCTGocUggadOgeXvblxSqTsHhIZyoZOTBvaa79df6LxSQi2V+m
 cm+0YhizdzVqKVlFdytUn2q2sNO7mn4709WcqS8AS/kU6n4WgTcmxgB8IfE2AVjD+SO1iEmLoY0
 JCEyHBcwEz2YDsJSaMjnOChanHFB08jWT+uKjVIdrgEG9vcgG+jzIUHH3yEPgta/xUvjd1kk=
X-Gm-Gg: AfdE7cmLaO2HbmCBHi4hJXc+wvHlKds3zE6dycArEwqCFcIGEw3P8F2Q0QH1KBH/kq8
 TpOO9MRi9w6SfpD5FA/EOD1VopHYu79a7n5kLYa+zpProO7d/8aBzJn/4Skjgwd+VDk+YyDfNVP
 o8rczoKNwgAblZEGk8lb+4pycdXRupypnG9zu5ShfHaKAwe6XqCcWZ59vicLcdLuimjMsqgNnPI
 bvOW+vgumQwb8sS/PfymztqUwgJjipwhu4dCY6JDKszxyy8XPBp8OY4vmehAQ59MiKHtlV5xet0
 RxmqxOYkJHitMSYGT56VXeMfsPoF4Bk+sb1BMs1K7L42xZDlc23Cv3AjitW04zNvQVlcnHTcTO3
 tKOk6RuLLuBEZHfuPXLLXQXrRcs9LT59r2aP4Rw1ZWp+f
X-Received: by 2002:a05:6a21:1798:b0:3c0:9c1a:8952 with SMTP id
 adf61e73a8af0-3c110b35019mr19226590637.74.1784138875486; 
 Wed, 15 Jul 2026 11:07:55 -0700 (PDT)
X-Received: by 2002:a05:6a21:1798:b0:3c0:9c1a:8952 with SMTP id
 adf61e73a8af0-3c110b35019mr19226551637.74.1784138874931; 
 Wed, 15 Jul 2026 11:07:54 -0700 (PDT)
Received: from [192.168.1.9] ([106.222.231.43])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13cd432f1cesm5187074c88.11.2026.07.15.11.07.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jul 2026 11:07:54 -0700 (PDT)
Message-ID: <312315da-699f-48c6-8331-6dce3abb899c@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 23:37:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5] i2c: qcom-geni: Add dynamic transfer timeout based on
 transfer length and frequency
To: Dmitry Guzman <Dmitry.Guzman@mobileye.com>,
 Aniket Randive <aniket.randive@oss.qualcomm.com>
Cc: viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org,
 sumit.semwal@linaro.org, christian.koenig@amd.com,
 linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 naresh.maramaina@oss.qualcomm.com
References: <20260715101805.3615166-1-aniket.randive@oss.qualcomm.com>
 <20260715144558.abf5078829bfd2a0973019a9@mobileye.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260715144558.abf5078829bfd2a0973019a9@mobileye.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: PhFiohn8lO85Rn6irO9cV5_hS3dJHU2Q
X-Authority-Analysis: v=2.4 cv=KOlqylFo c=1 sm=1 tr=0 ts=6a57cc7c cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=OlrBKP18NtReKxGUJ9moaA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=SU41Sc21RSR5G0VrqPMA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDE4MCBTYWx0ZWRfX0xjSE8zCzss4
 w36FlPnXdGwe9631Lhq+k84Fwd5Jhf7uGnuRmmwTbvrwC7ewBmgnTTv2yUhSMCgtgZX/sVnRniW
 MS0DnHs5koyaCNCQDd735ajZBTcTdJDwuLhoqevnTnQyLAI9stAKOpCyLi8o2DyNzfiCrEkrnik
 7FqidHLqUv2V9PgrNaWnYteVSOwLNNCbCzU5PvTzVtOo/Vf0MlarGHVIEhTy8j/ZGt+iyZ/KACa
 wV3JKqd2jwctSZRJ987zv2AsC0F2fKi6/L05zcvoa9tkH5r0XFanzcIxVvItJcGVd5jLHzUW5fy
 6lGGOhz+63mjpmcw/C5SZHQLChqpJq8ogwFits4WXWfnDEUnkUN/ApqOL20gXjsVoio08lLpFdu
 h+H9pW8+81Uhc785AfmkIlxupS9cb9nJ5HR91y/z4wmeVGkV05/J8g0LjoUD9aKwspGO5PzXlQy
 szU3mGA3sxtw23b/xhw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDE4MCBTYWx0ZWRfX79W5AfXY2deI
 mHvxIMNY4pU8tlYEO8fbx+I97e0ptFSY/v4B7yV4rWYM/yP0Trk+CmRdlKrk1jioInHx7CLWRZ0
 a10dNtmfdWvZXNO+njHM8VyTHlVtO+M=
X-Proofpoint-ORIG-GUID: PhFiohn8lO85Rn6irO9cV5_hS3dJHU2Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607150180
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



On 7/15/2026 5:15 PM, Dmitry Guzman wrote:
> On Wed, 15 Jul 2026 15:48:05 +0530
> Aniket Randive <aniket.randive@oss.qualcomm.com> wrote:
> 
>> This replaces the fixed 1-second timeout with a transfer-specific
>> timeout while preserving sufficient margin for software overheads and
>> bus-level delays.
>>
> 
> The dynamic timeout may be useful for any I2C bus controller, not only
> for qcom-geni. Structure i2c_adapter already has field "timeout". Isn't
This is good, thanks for pointing. For geni driver, please review 
gi2c->adap.timeout (client->adapter->timeout) can be used and you may 
explore retries also in case you want to retry.
> it worth to move the timeout calculation to i2c-core, so that the core
> updates the timeout field in i2c_adapter structure, and the controller
> driver just uses this value, instead of duplicating the calculation in
> every driver that will use this feature?
> 
> Also, such parameters as I2C_TIMEOUT_SAFETY_COEFFICIENT and
> I2C_TIMEOUT_MIN_USEC may be configurable by user (for example, in
> device tree) for more flexibility.
> 
I think it's good to keep it within driver, not to expose as 
configurable. This would keep changing per user/system load, but ideal 
timing is theoretical + some offset, hence can be better managed by driver.

> Best regards,

