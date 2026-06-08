Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23485CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 06:29:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6789110ED72;
	Mon,  8 Jun 2026 06:29:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YyMHghlU";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZS0BZUap";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1548610ED73
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 06:29:22 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6586Ovqs2833010
 for <dri-devel@lists.freedesktop.org>; Mon, 8 Jun 2026 06:29:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 esF80riE2NJ0vmPT5A+P8qHkNdHWZ6xrNpQUTG/GXy8=; b=YyMHghlUQB6i4X3I
 t2CdX9EqHomm1RojV74wx7KJVpRMi0IdJFIRis8T5jGaoDgfZ5V13tQTCeDocDFf
 Bx18eRat3LK2Tg1bE69t56Ze+hPivF/DU7Az3ibicAG1tPO+btBLtXWMzFsTuPQZ
 9Ty5tec2uT5DWrfprsj/FS4vx+dUvLaA8Fr5QhejKVN+9tk0KbwPrbkM0xVLIcMU
 4syqDRA0+EHO4hXKAjhPQRyUuqzblypBYnOi0t9h4xB2U8SO2U+9O/XalNvK4ohC
 qZWrLB34aE3jLbVlYnk/z86kxyP2BSN+chiQI8dMZDNSB5g7/9OahZus69KYxUkB
 dgedbg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4embmreakh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 06:29:21 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2c0c36f4b76so41619925ad.3
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 23:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780900160; x=1781504960;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=esF80riE2NJ0vmPT5A+P8qHkNdHWZ6xrNpQUTG/GXy8=;
 b=ZS0BZUappb90Jk3XxZTm3ODUsx5gY1m+EhXq8jbLvIiZlKClWd69fPXCFMCkV30eCZ
 No8gP5AB/CqI3S14rklJniiXmTfBpQuN81BHe7muKn5OA7f11lFtLPN1Gm6lxalt3Evt
 vmw0vS56p8KCWeu0HGfv1jhG0QE4f3q+qvIPohnQ02365QRnAwo89PDAj/1wvrliLAdj
 KRxYcCI7KOpXU8SLOFy2npXZYny1/HDHVQeUvDYGYdnO4EfoSFqF3Iu+ejGx0xaIQZBL
 F8P0RSWq4iaosSbeF+cyWFpzvO1SlEwJpX1NG6jtDqcL7xowFocT9CMJMeWCmHCnQgma
 46RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780900160; x=1781504960;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=esF80riE2NJ0vmPT5A+P8qHkNdHWZ6xrNpQUTG/GXy8=;
 b=GZmIKpGR6/uiKSoixqsyehGtJa0TMp0jjHfF+NdqTUtSGjnzPPiefx5MkdE9jm2/Yr
 K6bu614LT+dEUKo8mojN9MR90rdA5AZ/EFX6wR93ZNWUkhO2xlHPUAl6LWjkwaFy2dt4
 jzEGSp4U58DrbSYda47qA656CwrVSX3JvXDchD0yxB/pINP20TXTEmQ3NKZm0fExt0r+
 PESgoFD9Kjwr3vrc4WRXAPWjGHb7ZlEBT6S1ezq3VBiDGjQ8DrF/WMNQuDjiH2L0udsl
 r9uNLVcuZzyrBje2g1FMu2fZNwkIh215VIJAMbLUlCilOQNAMXJzneMSBdfjz3rU2Sai
 PElQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8FSV3wajgvhXg9pQk3HNLFUUl0lHcpXvmWm53rUZL1IIClG+HDio4itCCCfh/NVoV8SwPzgFmgkcM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzOi8ap4D4pRlqOGcHl62caSnTOwHR6YDZ2AUlrhYpjaSKGPxGd
 /q2u957Prn5s9IVDN1QYHdJOdR0i3why2l8YQ4sSFnukIhGo76wKpydENW8hMa+jcL77WEhJKkI
 dkqh+oJxNbXopqtmoq9osL/NIx3J/iv3u/RFmi9rhcxRPPtm6hSUd8uofXnhQIbXperFDIG0=
X-Gm-Gg: Acq92OGT4eRAQ7a9gMKUe9MMPwzbhYt2GlKIKV1v5LQs/2Mz2BuKlDe5PCiV6170KPR
 Ex59em604HaN+4muq90MV4hmFuUhXGSUDa8Ssu3iHxmXKaMpVtEyKhW89gj7s8ic5CCfOwdlAyG
 VHPTnBSNsF1lmrqawyeTvvW5UDfp2Pq71WBX75ekP3ejiKCQiD1Td2zRbabNF9Zid41l3rXNCx9
 cAsFklSMFPaISThT8yiomlIkKYJwToS3RHj1QzaPGbiSeqLTuDbBPfgz5Lei4hBtva7Uo6gumRQ
 bJhHqoWaXNxlp/DJ+Du3WlF7l/fxYCSh4bUf1iEsxbxaYovPz9tY6FBcPqfkk3Q24E7o5lcIaqN
 CeOqOKbADsZJ7WwGc2JbWSqKFNJQbBEbCGl9YVU+qSUbrYDVnxHwGeqaaTRmjf/YoEGVmvMbsmW
 9xFKq44IgAVGqHB0P55MX3Qjaf50k=
X-Received: by 2002:a17:903:4b50:b0:2bc:b80f:6782 with SMTP id
 d9443c01a7336-2c1e821dd0bmr141753745ad.11.1780900160072; 
 Sun, 07 Jun 2026 23:29:20 -0700 (PDT)
X-Received: by 2002:a17:903:4b50:b0:2bc:b80f:6782 with SMTP id
 d9443c01a7336-2c1e821dd0bmr141753315ad.11.1780900159601; 
 Sun, 07 Jun 2026 23:29:19 -0700 (PDT)
Received: from [10.133.33.209] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f6dc92sm157118725ad.13.2026.06.07.23.29.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Jun 2026 23:29:19 -0700 (PDT)
Message-ID: <ddeff296-abc0-4e1b-a721-761e2cbd331d@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 14:29:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/5] misc: fastrpc: Fail Audio PD init when reserved
 memory is missing
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260602071750.526-1-jianping.li@oss.qualcomm.com>
 <20260602071750.526-4-jianping.li@oss.qualcomm.com>
 <bcm2eufawifaq65i5qlqmbam4wtv2du5re6c54tiamdbynmras@lbfd44kjb6da>
Content-Language: en-US
Cc: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
 Greg KH <gregkh@linuxfoundation.org>, abelvesa@kernel.org,
 jorge.ramirez@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, quic_chennak@quicinc.com,
 stable@kernel.org
From: Jianping Li <jianping.li@oss.qualcomm.com>
In-Reply-To: <bcm2eufawifaq65i5qlqmbam4wtv2du5re6c54tiamdbynmras@lbfd44kjb6da>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA1NiBTYWx0ZWRfXxjXyTRvJT0ZI
 DcGhrR9pD/icbLoVm+zAHjNXhACh9jZl1g41owoYNRj6FapEVf3cCvNwCgNmxxYfTcuHkZ0SC35
 douzZjWsrEr/Px2u/GLh0N1euAI9OWxWWIiid1J2spqhy8RXefriZTpyVj2z1npjNqyTipAFHE4
 Ns1HegHlBctnIe1q6UXVMXQOsY9nFjul41ColemFC8DixeyAFJmO3SuRgRqJYBr32JjRzHHx1tr
 9fvh/v3OR26Q97RrwTg57epD3U10IsFbw73skRqcfxkfYDLePGgJ/ukGfVRPSVasfpXLsN+T3Wg
 2n8AAv/3Qkcs9uOdAS9H2BISGQ8LPhrdBr92pSGYynJstMXr7d+oZ7uu8iJIgr9shR3l4BVvo3j
 vIbF9D0U3330fPj8PDjMzwZgr8gCvwKiGlYQEhnIJ6Agutt/cUNrqbEZCui+ts0BV6bdQmBmXDe
 i83Y9dlbqBwmWasyJ/A==
X-Authority-Analysis: v=2.4 cv=B5eJFutM c=1 sm=1 tr=0 ts=6a266141 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=np7A-RzQJBVldtc5gtwA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: Afian6s5CnuPKCjBA82gAY-ekZY_mHn7
X-Proofpoint-ORIG-GUID: Afian6s5CnuPKCjBA82gAY-ekZY_mHn7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080056
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


On 6/8/2026 2:11 PM, Dmitry Baryshkov wrote:
> On Tue, Jun 02, 2026 at 03:17:48PM +0800, Jianping Li wrote:
>> Audio PD static process creation assumes that a reserved-memory
>> region is defined in DT and exposed via cctx->remote_heap.
>>
>> If reserved-memory is missing or incomplete, the driver may pass
>> invalid address/size information to the DSP, leading to undefined
>> behavior or crashes.
>>
>> Add explicit validation for remote_heap presence and size before
>> sending the memory to DSP, and fail early if the configuration is
>> invalid.
>>
>> Fixes: 0871561055e66 ("misc: fastrpc: Add support for audiopd")
>> Cc: stable@kernel.org
>> Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
>> ---
>>   drivers/misc/fastrpc.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>> index a8a58f889d07..f46a8f53970d 100644
>> --- a/drivers/misc/fastrpc.c
>> +++ b/drivers/misc/fastrpc.c
>> @@ -1354,6 +1354,13 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>>   	} inbuf;
>>   	u32 sc;
>>   
>> +	if (!fl->cctx->remote_heap ||
>> +	    !fl->cctx->remote_heap->dma_addr ||
>> +	    !fl->cctx->remote_heap->size) {
>> +		err = -ENOMEM;
>> +		dev_dbg(fl->sctx->dev, "remote heap memory region is not added\n");
>> +		return err;
>> +	}
> Won't this check without the next commit break the kernel? I don't see
> where else the remote heap is being allocated.

Yes, this check depends on remote_heap being populated during rpmsg
probe from the reserved-memory region, introduced in a subsequent
patch in this series.

If there is no dependency on the next series, the remote_heap allocation here after the if check.
The logic will be wrong.

>
>>   	args = kzalloc_objs(*args, FASTRPC_CREATE_STATIC_PROCESS_NARGS);
>>   	if (!args)
>>   		return -ENOMEM;
>> -- 
>> 2.43.0
>>
