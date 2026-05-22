Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5322BCD5BB3
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 07:47:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F29A10F4DF;
	Fri, 22 May 2026 07:47:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fDDYluL0";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dGmW8sx7";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D04A410F4D6
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 07:47:38 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64M3HYdP3673741
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 07:47:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HStTuWaVOAJ9glhTw5Ili583PqBxaZli5bgevCDJEdc=; b=fDDYluL0Ud6xeXny
 WL3CL8yX1+0c7XeRp/6jO4d2cgAA8afXq3PZK1oL82GZXsyAr0AblWltaFcQ9eIv
 btxrgl5TXDhhWWYT5X5jaF2SUbop6QnzI28fyVHRtdb9bXZOdiLtm9AX1oW6nsnw
 IICCCuXuIsrNOKSdJFrQhDjc3mCYKonKxtQqGvZbO8mBuqEIYMTsF7U3WbNEwIPS
 XWe7lhLmTCmBa0AWNpnJ/jvWdQaFITsTvQNbK1GU9qlFSg85dahHD59geBDyTOLL
 adAFHSe/NBYBaQ/UxT0716IYjWOgSYzM5uUaRcw0yp5hNQ+VuYvpDADG1Qh700qV
 zzPxBw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea4dc3fru-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 07:47:38 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b2e8bba2e6so97753885ad.1
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 00:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779436057; x=1780040857;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HStTuWaVOAJ9glhTw5Ili583PqBxaZli5bgevCDJEdc=;
 b=dGmW8sx7BdNtKfSQ35S/W7chcCBsMJd8kcWvrWsJNKMwgFXB2n8sSy9zFsS0kAuf4u
 9y3oNHQ8y7bhgahN/vFmb39TT9L2ErZkWRT92KSnx1V5ssts6JCexrbrEuOavIIa6Enq
 H2vGArctHprrXoVpS6f858Z2QHnMsQuNUx5ft/xp8je4QcztWdQXD6y29uJjHilpfjm5
 bnjhW2vwMHeQFCCPP16wZ0hCMxVIJJgyKJqddy6y1EezChAGLI1++EBrPGqELa+M1C8R
 6FP2pQEzburptxOP4akHJu+tUokZ3Uw39vckOtXhTgEwentzkJBsDmiv/9DFIFUSflDo
 JHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779436057; x=1780040857;
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HStTuWaVOAJ9glhTw5Ili583PqBxaZli5bgevCDJEdc=;
 b=qgro+zynErbcnUKguffXVEfC9MZ6gl6JsbQ1rvCGVslmnlFIK26ZzlJA5T2syq7yhW
 O1BGLxlR5FN4rNpcDzxIkCYBqmno571NJRP7/rSZRhMvyPfh8v/WH3b2sFfhGk63u0eF
 TlUEtY5iAyGtIOlF+5lLejsBm1wk0TRqsD7figUuN3s+asPRAYxokLXiyzrCZyZChE/Q
 fkISAQNkMnHQxKV58PMHvdmcDQMMuN2rIsaJJlaROxA9EhykkjoD4GY0AU639YnL6lTt
 27gOSqys7BCrgRpFnN2vhTQ5WMhkxEU7W743ad1F8fpT2Fk4MLbtiAlq++J+0uZeHAvL
 MooQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+G4thT8Ksi3XEq2IjOPd2GszbdwYhj5lZfRo47PqhDCrJEAAFJEvHOkGYyCUAhrbGxX4XA/PBnU+Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzX0DA18zcieWgVBzVdl3/5+7zfjlIPN5iqQHtYmxNJruNbzS0r
 jBNGpFANt8W5aP+HIhR9QNgAiM+0w9ZvQUCbta7G/k33KdBnpKDg0DyANmTUQpmb4xiGZ+Q20sD
 M1i9T46b7uXXJ68mQaiVcHoaIqfZ7oHV/Kdgjv9+11SYHxCoH8lS/aFSzpF302uA2PhvokxI=
X-Gm-Gg: Acq92OG7mQnu9kha42zRtdXu/OY/+vBYNqZCuXbBnmpF7CPXB9ccPnNvCfa42QIRhc3
 A5LxbZIcfTeH8Nl6S5bPYLf85SKpaMXEij5+/mNrsLzC1pxc6RCHnzSQHA7LaRbG6/slNK7EPAR
 NQfKqqR9Up1FWnkcGipX48irVJFtZV67la7CXPyVcTeKA/r/eg9geQ+298GTu+XbudH3vvZSLY9
 WJVWEoBZDPt3O05YRwf29HsjcavqubB3Gop7FXKB5GXcPBDCCGKwJES+6qJHIxyuwgJG25srEx3
 zUk9O77TsvCmk/Vy79KOk7yksysTR/2zlXx6nwzpPwEkZjbAbe9HEcU8kPdyNUVefwD7sOc6F/4
 PHs+cOTBE3hyJdcxfbLZqfMdZNdb7ob9gfx+4cWi/HjgxkxQmoQ4+9oTWyTEumurvS8pla7ajL9
 xTFi9oX1A0y+edTX5i1NqZeRiXgGs=
X-Received: by 2002:a17:902:d2c1:b0:2bd:b6f6:3446 with SMTP id
 d9443c01a7336-2beb0633f1emr28086895ad.3.1779436057435; 
 Fri, 22 May 2026 00:47:37 -0700 (PDT)
X-Received: by 2002:a17:902:d2c1:b0:2bd:b6f6:3446 with SMTP id
 d9443c01a7336-2beb0633f1emr28086605ad.3.1779436056988; 
 Fri, 22 May 2026 00:47:36 -0700 (PDT)
Received: from [10.133.33.160] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb5924211sm7030285ad.84.2026.05.22.00.47.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 00:47:36 -0700 (PDT)
Message-ID: <fb00c836-95bc-451b-9430-2ebdf0be2630@oss.qualcomm.com>
Date: Fri, 22 May 2026 15:47:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/5] misc: fastrpc: Allocate entire reserved memory for
 Audio PD in probe
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260515124217.20723-1-jianping.li@oss.qualcomm.com>
 <20260515124217.20723-5-jianping.li@oss.qualcomm.com>
 <v3qkvvqlggrk7thn57ff4tlbilz26nt3nlma6deixlalq74i2k@nbxbqyppzwte>
Content-Language: en-US
From: Jianping Li <jianping.li@oss.qualcomm.com>
Cc: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, abelvesa@kernel.org,
 jorge.ramirez-ortiz@linaro.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, quic_chennak@quicinc.com
In-Reply-To: <v3qkvvqlggrk7thn57ff4tlbilz26nt3nlma6deixlalq74i2k@nbxbqyppzwte>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=VefH+lp9 c=1 sm=1 tr=0 ts=6a100a1a cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=gttq3t2AYlGpivilpbwA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: PbUcXRyeEuV5p8bahoc-tcY7rz6iLZbC
X-Proofpoint-ORIG-GUID: PbUcXRyeEuV5p8bahoc-tcY7rz6iLZbC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA3NiBTYWx0ZWRfX6npp9QrpIPbO
 8wA8Mh0EIrrrJ9M1LY4bVGiLS/N9SiiJYi/0jb1InzHsQE3fNYeTNKD2VNkS0Wz3wwtyyGisu9u
 LB0xObop+ecyn/7AjRSmKERDu/nD3kOm61HPh5m838xTrs4rY6h5YCdGZN5mV2VYAS0wMZmj4Su
 nBjgrMbVqAUaR+b0tb45ZXk9Sn2x6+qMlRQwEYwxYQYXyAwxhK9kBUudW0iDkSjijj/fQkTa60F
 0kaD5qoGCaAJZbHIxjBXVpq6Tvx/fuAhdLEZLFkkPeuBhyHD9tM3JZDuFf4MZr9Qre4eXS7/uvv
 8rUr8p0q6PaDPBWB8kjDOuyN8ILeAJ6i/V2Trkl8zr8aU+//GYvRiIHUqwP8eXDtwb0fytseYWt
 IZyOwD6Yg/YIgTeJgIaKAvMZQKTnXRRD9HhKJHZ92gyVqCC0p8g6inem7VM+XvhLUuegXuSMnnQ
 0P9botuuAOk+ntPwUDA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220076
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


On 5/15/2026 9:38 PM, Dmitry Baryshkov wrote:
> On Fri, May 15, 2026 at 08:42:16PM +0800, Jianping Li wrote:
>> Allocating and freeing Audio PD memory from userspace is unsafe because
>> the kernel cannot reliably determine when the DSP has finished using the
>> memory. Userspace may free buffers while they are still in use by the DSP,
>> and remote free requests cannot be safely trusted.
>>
>> Allocate the entire Audio PD reserved-memory region upfront during rpmsg
>> probe and tie its lifetime to the rpmsg channel. This avoids userspace-
>> controlled alloc/free and ensures memory is reclaimed only when the DSP
>> shuts down.
> So, is this a bugfix or not? Is it possible to make the kernel misbehave
> without this patch being applied?

Yes, this is a bug fix.
  
Because currently after the audio PD requests to grow the heap,
the current kernel does not support shrinking the heap, which will all cause memory leaks.

The current modification is to allocate in advance and release uniformly, which will avoid this error.

Thanks,
Jianping.

>
>> Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
>> ---
>>   drivers/misc/fastrpc.c | 107 +++++++++++++++++++----------------------
>>   1 file changed, 49 insertions(+), 58 deletions(-)
>>
