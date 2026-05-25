Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 144D8CD5BC8
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 09:45:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7103D10E0E9;
	Mon, 25 May 2026 09:45:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RuOBLe/Q";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XcOoKmwM";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D98710E0B5
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 09:45:06 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64P7iGOi1850867
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 09:45:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7SWc0cc22x9nunFWpQzihkc7nKAG+xaM6B4HBtT1Khs=; b=RuOBLe/Qc+HJi5YJ
 e47jNH2ZR7MpklJuCHi7VtAqgXSUkuA9HckGwKSfOPaatXdYKFkBCJf8x0DvgDsO
 tqkGEtB/fzRff+OQnF8LFty8HthYnp0Uoi98IdFD5JW3VC8PmnB8TcKKSUt2e5Nt
 /qmC+kTOCw6vzSkADMD09PLyWY1bSIu/7ux1kcusBtvel9eZ3f+g/KIc023UDJ7y
 9tzQf2RY0/9pkrY+IWP/3C7tsu+3GmA+MngxJZSn4MOR2K7IR/Rx3CDKjBFxcsce
 UeC8Ut2T0h5At40OW5mmKubHTreCUrH5u4u9vqfpuuyoow7mIUIuNnlHawHOQUX9
 Fk1jQg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb88w5j97-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 09:45:05 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2bd00a65673so72161585ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 02:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779702305; x=1780307105;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7SWc0cc22x9nunFWpQzihkc7nKAG+xaM6B4HBtT1Khs=;
 b=XcOoKmwMRbfoN4FJHn6QDCfSCC6r+YYZwPWfhii857jU2faMpTuUVoEpL9zN+A9qiq
 OVQ5xRWaG4T4CfgZIoHtphb/eCLSdDjP+8S//dB6MkalYc3wAAKcX6w0eKvZBLuzpttT
 ZfVmgNVz/N/LXbcQXixN5S5wmsdmnPokAZIy8Xy1Po6MwG78f5W/tLbFqEVEHSp/fYIK
 U1aSwhtUtOzp4BoleeGT3MzrweIxHFyNNSXwzCqJGNOCVDG0D2P1iNBpjYFyvCC9hCXp
 JR5WJDWaH3XdGS7907oSTBX0o1qOn7Niwc5e4WBXCRh4kMQhnSc0lwBjWCWz0XXr38o3
 hVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779702305; x=1780307105;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7SWc0cc22x9nunFWpQzihkc7nKAG+xaM6B4HBtT1Khs=;
 b=R4YjjEwMh7P2A6oaHKLtwmiIvMHyHwIcyyDR2CqaP62XRfYNQWoaHYg3yRJ/rgfqnu
 ZpZ8RUiF2Mt4SaW3gd0zLfu4OO1wBWeLDllwEG1SF98TvpfIyK21tC3YXACdY+kgBhp1
 Pp94iYOq2X94odzMr1LoCwizz2DoVcKORwj8+hMZeY3ACSjEs/9sY2KVyjbDJWKc0Uxp
 Tp/yhqd8kyu0L4dMbz3ghjoeIw7b64rNLwo2HB4Q5yJTWfrxfcgLtQFqzZIbPQtFAUDy
 Vs3d9lUuZjYzjzDo5wfbUFssXZMtAF9NBV3PBo+ZoedNIaJOcLMzWfmFRrY0BWGNVOx/
 cISQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+J8mJuUPrTmX13EwH7wLw1RB4RHlJS/MzGWdnq0yYRghDfYVzoJ43X2Tq5c2QBjvAbsDvoh/dFQHU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwrVJQn4lkYNoQtYFdH+EpUQVUtszrVVdcABWGQCj1WOdErtXVk
 pw9PvmUVy986U+zR++ucng7wnmv9uCtwRXk+bwQC/MOb8fHqrU1vUGm3DoFI85FlXx/iCQDxY2f
 Kys/gAd+0MBX5xqVtrK+VIjn3+zvjXRNkJFA9jcJ0dCwHlaIuOMBtzp1MJ8mmhXvawDuWCZg=
X-Gm-Gg: Acq92OHiGcFzveC47UPUvAZkAvu156Y61SZWDeCxVBDmGNdKKCmWexhD/R+Ue/Ipvv3
 wTlzWMaQst9o4xFf5qH6I6m0g5iEZpKDSPjvhxp7X1HTIp5EvfvJ4GNepTf1gmuoQ8EtHFSWt7A
 dgRUpwOHUIrNTIkpc5Crdss6Jnh2G+bpsBUfWpEskTkccFpAG0aNk/g8mV3AO+Q89/J/4+TjgiO
 Yi+RwRQdxmmPyvQmm/Q+btlzpP2EUzLwJ6A50r7IT8B1rsDQ51l4RnmcAmfJsR8Ebwq1s1P1FLp
 DCjVO4sL5qPX19+Bj7Ikb1J+0ru+nPOl789iBiXovCWphhDkImHlziFXRg38Yk1yZE4ZENugGaY
 2AMXsvLuYUHpWzc6nSWxEXeI4A6Ig83sVgiWm3P5jMQ/qodxQ5DxqRufGrKIV3GbaD5UYmQG73p
 RF411L7+HYbAFlGO2X
X-Received: by 2002:a17:903:11c9:b0:2b0:506b:e6f8 with SMTP id
 d9443c01a7336-2bea20a2d54mr159277435ad.5.1779702304965; 
 Mon, 25 May 2026 02:45:04 -0700 (PDT)
X-Received: by 2002:a17:903:11c9:b0:2b0:506b:e6f8 with SMTP id
 d9443c01a7336-2bea20a2d54mr159277205ad.5.1779702304487; 
 Mon, 25 May 2026 02:45:04 -0700 (PDT)
Received: from [10.133.33.215] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb5695c40sm84634895ad.5.2026.05.25.02.45.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2026 02:45:04 -0700 (PDT)
Message-ID: <be6c9ceb-32b1-4cd3-8811-39248ad1345c@oss.qualcomm.com>
Date: Mon, 25 May 2026 17:44:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/5] misc: fastrpc: Allocate entire reserved memory for
 Audio PD in probe
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260515124217.20723-1-jianping.li@oss.qualcomm.com>
 <20260515124217.20723-5-jianping.li@oss.qualcomm.com>
 <v3qkvvqlggrk7thn57ff4tlbilz26nt3nlma6deixlalq74i2k@nbxbqyppzwte>
 <fb00c836-95bc-451b-9430-2ebdf0be2630@oss.qualcomm.com>
 <lpsvrgw7spxt34rdvfakxm3trdjybv5lyq2pitnso5k2bfkrmy@7a62dvbmf4r5>
Content-Language: en-US
Cc: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
 Greg KH <gregkh@linuxfoundation.org>, abelvesa@kernel.org,
 jorge.ramirez-ortiz@linaro.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, quic_chennak@quicinc.com
From: Jianping Li <jianping.li@oss.qualcomm.com>
In-Reply-To: <lpsvrgw7spxt34rdvfakxm3trdjybv5lyq2pitnso5k2bfkrmy@7a62dvbmf4r5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=S/jpBosP c=1 sm=1 tr=0 ts=6a141a21 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=gttq3t2AYlGpivilpbwA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA5OSBTYWx0ZWRfX2t9vty/uNUwd
 v/xniTC+VSt5BlIMmjoLBEE5yBZI15Kn0r9igb3nA7uBZwZzjqXGu3Q6Ns54ylibVMseUByfibs
 /wxA8Q5AOFsjrZL31rRpqQCnnc6YaslZ05yKdWhEXT7lAGIWbhvqaF+IySV1qt9KCCYWpo4a9cO
 M3oefbe5k7m5TitC7uFgCkuhLHIQFcFOoAUvZCh+D+NienU1qEMlqu552l89LUV5YJ+iJZPGusp
 zpTx6Cs9S4LqLRUZvqVOV+e9nokpJ61hAJW+7656YjCSYHAit/e4OJACNQNyv9bypw+GxZiFJsl
 qJITHHzrfUc82fL4aD1BQFDnVvy139HpeXs6ayqjZh6MVHW/+6CSwcsskl47Kb9hVeI4+BcxxpH
 3Q3Ctg/GT1W8W/vHkhn1e5fI0zydJdmVczAo9EcdQDbGhVfSqgNDAnzqkRaj6TzfLxRETyQmqPN
 BQnFAKLYms+5mG1q5gw==
X-Proofpoint-ORIG-GUID: ZbQlOy4r4JDDMk9IspdhY6WvZn-ycbot
X-Proofpoint-GUID: ZbQlOy4r4JDDMk9IspdhY6WvZn-ycbot
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605250099
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


On 5/25/2026 4:32 PM, Dmitry Baryshkov wrote:
> On Fri, May 22, 2026 at 03:47:31PM +0800, Jianping Li wrote:
>> On 5/15/2026 9:38 PM, Dmitry Baryshkov wrote:
>>> On Fri, May 15, 2026 at 08:42:16PM +0800, Jianping Li wrote:
>>>> Allocating and freeing Audio PD memory from userspace is unsafe because
>>>> the kernel cannot reliably determine when the DSP has finished using the
>>>> memory. Userspace may free buffers while they are still in use by the DSP,
>>>> and remote free requests cannot be safely trusted.
>>>>
>>>> Allocate the entire Audio PD reserved-memory region upfront during rpmsg
>>>> probe and tie its lifetime to the rpmsg channel. This avoids userspace-
>>>> controlled alloc/free and ensures memory is reclaimed only when the DSP
>>>> shuts down.
>>> So, is this a bugfix or not? Is it possible to make the kernel misbehave
>>> without this patch being applied?
>> Yes, this is a bug fix.
> The tag, cc:stable, clear description as the bugfix? How would anybody
> guess if the patch is to be backported to earlier kernels or not?

When userspace repeatedly grows the heap, the kernel does not
support shrinking it, leading to unbounded memory usage.
This can eventually cause memory leak.

I will mention this point in the commit message.

Thanks,
Jianping.

>
>> Because currently after the audio PD requests to grow the heap,
>> the current kernel does not support shrinking the heap, which will all cause memory leaks.
>>
>> The current modification is to allocate in advance and release uniformly, which will avoid this error.
>>
>> Thanks,
>> Jianping.
>>
>>>> Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
>>>> ---
>>>>    drivers/misc/fastrpc.c | 107 +++++++++++++++++++----------------------
>>>>    1 file changed, 49 insertions(+), 58 deletions(-)
>>>>
