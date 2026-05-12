Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 094BFCD4F24
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 16:48:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C3E710E0F9;
	Tue, 12 May 2026 16:48:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kOt0rcTT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AfqSrKAC";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9EAA10E0F9
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 16:48:49 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CBcpqR075277
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 16:48:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZB0D2+zzw1ZhGJQXpB+1LvzU47GEZERdOV01X12Jqmg=; b=kOt0rcTTTxD+fOW/
 paNXKsSqMO3QgHoRK7KknyMqqpOKKGCuPKCLQwS+qoRRQ/qQ7IqfzIxiNYkMej+A
 DuAhfFoH0J8BBm4OG9GPbXSSpoNEXiOSB3iRZvGIHlBzhzTZufNG13OT0NnDXETX
 5JGWJUp8ZrS5K4qaERUI3CB75tUppEsZ6vNORO5xzODcEH3fODf6vyh06oxG4/x/
 UytRWRDXwWU1r17fUSpgEx1SrmDMH6pwsIxT//QxTflCfRFkLawXoNA/7MJn0bxS
 1K5NkL8aKIE1XskYqYsPg3tWYkUeFi/e5OjHjUAB9jxGHUhHYyJh/+Tayi0EbGAh
 MbM8sA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e43gyhd7f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 16:48:48 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1306c2f7037so5877711c88.0
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 09:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778604528; x=1779209328;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZB0D2+zzw1ZhGJQXpB+1LvzU47GEZERdOV01X12Jqmg=;
 b=AfqSrKAC8Ttx6DY8BS9lT+z7AA1C2vJrMKlfcsJK6PkNj7ARcMB8EcgNF8O32cu9Er
 s0kNQIpTsGLR9/SK6I/SCIB+OlZ+eHqP0EMTmAnbhSGfOCoQdEM7TtvV0ZIXeIo0+Ycs
 zY7oVoo2Ds5x6nKVcajW7AMjrZHFjfFcgDDZ1gaIHY6IRoDMo6CZqxR/gjE9GnGtHPRk
 cCmikdLkuSUE24w6esARdmsxqWQTEnxYvkt4yAnShezXB3aprzcxJgEg40HhUTG/C+9V
 yZ3j1JFbK7qfY94NqgaHm6C2HprOwphPYF7SWI41h7tc+QpNUM0jxDL0OMa2RU1BJx9L
 VG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778604528; x=1779209328;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZB0D2+zzw1ZhGJQXpB+1LvzU47GEZERdOV01X12Jqmg=;
 b=Qy4VHh5A3PCKY2GkQ6CpoOSVGYUaEhPJqshtQ2PPJH0ADMbkto3ChHYet15gZgmBCx
 ZdeshChAZq0Xn3P0V20d/KcuWv1LyZkuyWU67equbv5a/R4IszgRroth0TOfZo1DDhFW
 iOeZPlLAiGbb+RJ6T1dMG10jUz56ZiP/VCLf2XHe6YiIzEJBSoJobFAIFqgLbuByYO3w
 L34KHAvV9QnkMEnS3SMorRZMTocoIzKqNjGiaZn8mmrH1k/BKof+r40HBge2PbzH/XiS
 +lOZpEdxvpnnx/g7yTXD1PsP/hbuMp3/RZPo5Ownr8MU5OBlVDFcmG2IhM6F2g7N/ma7
 visA==
X-Forwarded-Encrypted: i=1;
 AFNElJ98i1fT6p+i+HOujaUAelR3Op0xg41Tf6kGbYTL65vrfmgJ6eBzUPFEcSb1F6KTRHOgJcYYkjZFjnY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwFGswHZX5CP/oqLD+SzmZcfr3VP8su4nuiOgtLb9+ng6c7/EPd
 i1AYfXFQ/tmkldaQRMtf/0fYoMKt8ICVndSsmvt2VTsyuX4q2GfKgn/90FszajlK6rvzjlZaQOg
 5DnTWIYD6lWmIfUausGnPQAbQaXJ3qNAEyYtqEOQyFcDPKBBITkpkLyKGgBI3SmNbUDiTC9g=
X-Gm-Gg: Acq92OH2IOyIFJMzwFJjTfXzXtvW8KgHZ1Y/Y8JYcR72mppWHBIiBh5aeF1ZcVMgFMJ
 CI5ZQKjUoIsy71a37HRUX4XCews5YzawDAjniSJYiSX49GJ6YIHYAsFGjDVhzenECxLsunlBkw5
 p/6DK7KwjqWwVc1eVD1QUIc84PQQoW31IOPyR5CapoIlHVNoxTMi4WnGDG/qRTOK6dI9UGPwBZH
 GPfFKAxDyNmtu3V2J1YxOEEoEMNp4GpfU4BCO3AKnbjK+kBaOe+pT3B08ryfZ941mMroJk5N6BP
 +KHWbNFN7HyleWNNYZ5Gocm4xqWD+X8fbSpZDXjsojazN7F/hL6X8wid9bwdWAa98U8rkgxnRVd
 F2LJNKLd1OvZqteyZVH/VM5/gbrx2+RQ9ZO/aFl8XqZJGPGHUqcXaT2OtTO8kdUNKJmXKFkIybN
 A=
X-Received: by 2002:a05:7022:f212:b0:12d:f0b1:75de with SMTP id
 a92af1059eb24-1319cf56178mr14141877c88.22.1778604527751; 
 Tue, 12 May 2026 09:48:47 -0700 (PDT)
X-Received: by 2002:a05:7022:f212:b0:12d:f0b1:75de with SMTP id
 a92af1059eb24-1319cf56178mr14141853c88.22.1778604527254; 
 Tue, 12 May 2026 09:48:47 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1327821fc59sm21912668c88.7.2026.05.12.09.48.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 09:48:46 -0700 (PDT)
Message-ID: <b60143ca-e090-4a81-98ed-d6affaede97e@oss.qualcomm.com>
Date: Tue, 12 May 2026 10:48:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] accel/qaic: Add overflow check to remap_pfn_range
 during mmap
To: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
 youssef.abdulrahman@oss.qualcomm.com, carl.vanderlip@oss.qualcomm.com,
 troy.hanson@oss.qualcomm.com
Cc: ogabbay@kernel.org, lizhi.hou@amd.com, karol.wachowski@linux.intel.com,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Lukas Maar <lukas.maar@tugraz.at>
References: <20260430193858.1178641-1-zachary.mckevitt@oss.qualcomm.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20260430193858.1178641-1-zachary.mckevitt@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=fMAJG5ae c=1 sm=1 tr=0 ts=6a0359f0 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=ixu4JsPXSrMzd3x0NycA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-ORIG-GUID: yjoTM-0fzEsfehlmHTSWR46lr4WOQV9q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE3NCBTYWx0ZWRfXw4NX8dYwuBUE
 iTXQb/fbGdjYwm3eBz2ousd/smWTvpHThptp+eQnmwyWQ87/bBU/xksXabWs48HmOGXxGPOWYuQ
 hr5dfdJU7cdSxWqEu5ZFDVCHy3oiPMmus7qIXHXQyJ5iP6k39Rh+YGnjZrQ41vyaABCH3y8uPz8
 q6IDNeOG+BDabFo4e4xlrAmO6FeVhSRNvARj5V6vQSn1Z6SGSHb+756RD18D4WVJRCg5/zmz8Dh
 FX8z9wGgwuNNDRBKITKd0NGBXSsv56Ej0s5zUGyjsOk4gzkQ6KBoK071qPvci8MQrhheY9/Cjkl
 FzB/Spiqvr++QWqaGD5ciWG9M3UcbZ9i49vA/vKpZs6ATz79zsjZhoqPCUQc8z1ngQBVymkZEjg
 M2q4ydMyXg4aJf+rtyPhuZ9CGoFGHaAKcxBi1N7O5T2ulkXEI0FfMcJ68HGR/chuVcvKrBh3hUY
 3PWFG7NKJ3CUJ0+Hecw==
X-Proofpoint-GUID: yjoTM-0fzEsfehlmHTSWR46lr4WOQV9q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120174
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

On 4/30/2026 1:39 PM, Zack McKevitt wrote:
> The call to remap_pfn_range in qaic_gem_object_mmap is susceptible to
> (re)mapping beyond the VMA if the BO is too large. This can cause use
> after free issues when munmap() unmaps only the VMA region and not the
> additional mappings. To prevent this, check the remaining size of the
> VMA before remapping and truncate the remapped length if sg->length is
> too large.
> 
> Reported-by: Lukas Maar <lukas.maar@tugraz.at>
> Fixes: ff13be830333 ("accel/qaic: Add datapath")
> Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>
> Signed-off-by: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>

Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
