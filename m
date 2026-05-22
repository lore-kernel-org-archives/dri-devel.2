Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D9CCD5BB3
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 07:35:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDB6E10E633;
	Fri, 22 May 2026 07:35:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JfqXL8ZI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RDWC+xfO";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C389510E633
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 07:35:04 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64M2VOkU1657930
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 07:35:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2b+Kij9t1IVCxFpBqd1qEHIqo7GSLvjCvGFJYZ65lN0=; b=JfqXL8ZIUCe2Ii7p
 nwcC5qhqYp/OKR5a6KsdZICVLwTzqXeqTFKJIl2XWyrDe4BgDqGltFdpklJxJ4q8
 bwpw3iUQk1aVO0QoIS3sUbEZfHdoARUfJqJGdNNKaTFDml2M9PTCULj3Pxi62qhQ
 5fexdklrqG2E4O/OzjG4iuPeRL1OBdDrc192ghJ6g8LGKBOXKalRW4sk5aQwv+/n
 MybrvN1Pt44DJOsBJzj+kqOGaZEtVBpPfbie6vXxU+amSObaIfhLXVbwoge0+UtO
 o30L4OTNUk55Uoo1Lj8GiRyGxrOc650G9wG8Bl4zVVQgvXhCoHxfp3UDF3rFqhN6
 LY8L8g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea0dkmf28-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 07:35:04 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-367fd7b8825so7034648a91.0
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 00:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779435303; x=1780040103;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2b+Kij9t1IVCxFpBqd1qEHIqo7GSLvjCvGFJYZ65lN0=;
 b=RDWC+xfOxHTn5RjrKK95VM+gB9YiNhRCwx2zOfdGm2mn1RkJGpWTjo+gaxBnpkIZJJ
 IUpd6ZVIBhzM1Fe0UJTs9j1l7a940cPJZ/s60AMutKNYivz/hATUVTylEbeKNAQ+b/Fo
 /XL8wdC7aSZn03FLQfWXNXS4Meq7AMdRjtRW8rRuMDnYe4urIBPPncKsV4N5BXnDVyRs
 y/UnDzTWwLqscI/bp8jPlPw+gRsQb6d98s+F2ySakGI1k1za2reh1Y8w2zdE1tBSqbjk
 p6keBOXnwwZPx7Yqt2NkqaXQSDVYhQVZ35ffITiFQZq1QmUUM6WG4G7EMsEyTUt4L/yt
 ropQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779435303; x=1780040103;
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2b+Kij9t1IVCxFpBqd1qEHIqo7GSLvjCvGFJYZ65lN0=;
 b=p5LbxaccsKqoiSzihWhHMWJnJPmODNfEYQeEMNRFSfR1xsXVX+WgGM4mjZmmK823m5
 cwudTURJsYc1ggLYCoVklVLnnUJIl1k2Tc8pq01Lfp/3HDh29Cl3/UkQqVXJlRJXFwBH
 eWiZMG81dlTOU6UUAY10sfNw1nKQ/x2Q+8moGhaCn1/9B5jeWTR66t2gdgG5LMDchB6u
 JBrvKpesUTzFQLt0Hm8jMzrZ174+5oasyTH8ycqfAGqp0XtPunByZO6CTSNr6OQbc76P
 TbvmNQTsGd7mAwvvrqi9fT8dNxfGR9zcfv+5RUczKqKy7mGgeg7qWwiRcuDOMuQ/03hh
 lMKg==
X-Forwarded-Encrypted: i=1;
 AFNElJ98N8z66t1Am8JwwTh7tjrUy+sJbosDcvAlIMU6SCamUyvwrInK8U9Ok7u9KLD8uvdmgZcUtWP11jo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzAJxp/HvWfNEoE2B8Lkfh4Jei0N0gksmt2/KIJ2zGB6ivAFJ4l
 PrazRQgnHtI1jzC7p73SCvsumOpwlJ+19eLsGZDG37/dod7JNuwHs6OYs/nuruc3Pymp8V1P206
 rvq1QLR1NmgdvgQJyl1alJOp6otPg1CV7QiRuhDI1rpKAs9bd0FHLT4vgkeWI7e3b/es/Q7Y=
X-Gm-Gg: Acq92OGx/DkS4H+fNmmxOKPO0gvZNaz6RpddIkEpXtIv9b6ak7dUQc/y9jbnrxNqFCH
 vKGuP5Rq6/G+33vDQ36/Pv2zL8lsd6oqOjL+GArankEOWD57bKXTKRNmo6cSHxnNCzkmFE6SLPr
 xzMSdQMc8hQOkisZiSTq5tiFQk35Pf33d1KajzWjzsNWKdfPfvJ7+hEB2Kt7LExl1KjfI1q9IOw
 3dmowunqkf652pcWU8a0S4s8+uDgL03qaVBjkBEj/xe2AJKOsUmE0rBrs4pYPZZ7GIaxrgw0UI5
 h37wxEPhK6y6NKwaQM/6gOrvIm6MD0qdIjxN2dX6G7GaW7p1CYC+pmJ76J7TCxkK5SWNZaWwgsZ
 OhqntUKW83oX2VQTK+2lv62l3Xt01B/un3DbfBbqGYXrhOaCCmoPOglV3vGgCAuuCY0VIdRav8d
 wg8caOz3PebyV/AhQ+
X-Received: by 2002:a17:90b:1b47:b0:366:3517:1aa2 with SMTP id
 98e67ed59e1d1-36a671e9069mr2466563a91.0.1779435303375; 
 Fri, 22 May 2026 00:35:03 -0700 (PDT)
X-Received: by 2002:a17:90b:1b47:b0:366:3517:1aa2 with SMTP id
 98e67ed59e1d1-36a671e9069mr2466542a91.0.1779435302884; 
 Fri, 22 May 2026 00:35:02 -0700 (PDT)
Received: from [10.133.33.160] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a67c4afc6sm579351a91.5.2026.05.22.00.34.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 00:35:02 -0700 (PDT)
Message-ID: <01407473-1fa6-45ca-83c7-090c0c935684@oss.qualcomm.com>
Date: Fri, 22 May 2026 15:34:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] misc: fastrpc: Fail Audio PD init when reserved
 memory is missing
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260515124217.20723-1-jianping.li@oss.qualcomm.com>
 <20260515124217.20723-4-jianping.li@oss.qualcomm.com>
 <5rpyaoyx3dsf3c7llnt57uukeaef2qgget42itfc45tura5esy@b4cwvazm42uo>
Content-Language: en-US
From: Jianping Li <jianping.li@oss.qualcomm.com>
Cc: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, abelvesa@kernel.org,
 jorge.ramirez-ortiz@linaro.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, stable@kernel.org,
 quic_chennak@quicinc.com
In-Reply-To: <5rpyaoyx3dsf3c7llnt57uukeaef2qgget42itfc45tura5esy@b4cwvazm42uo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA3MyBTYWx0ZWRfX8G1PtJEzO58D
 fUOJ7+qT3aFMWtpUl5I94yjottn0GSqpmnZradCn6Dh9EmcnBRs+BgKeEwZRiP5EkT8H70lbjSB
 +v+SncLEHg0DAnpQgNpzOwXGy/sLovaowkBB3XHb//UvhqVTrPUZvvKMPDb1oZrgO8yxTQQEHQn
 vTcnwxYhHoCrf1gB8lXDV5+iKg4plY1sp4VysO/W91Zn+oYiyojOnXm6urfi4oRuvkTnzdbU++/
 tyK7qH5mW5y5iaAW+7WZxd0z3qQzbXv1pK1rX2IGhVRPEO0UUck5tyG8JL5XBGJ4Bf84Vo8dM97
 yHa7o3QmjlGPoDb9mUvBCs9pW6tVYJAv1Uf1pfMdXwijsj6KfQMs79MFnrRbyV+nUmOco0z7HtR
 VlBh/jM6XkAmsrjNmwYJw7M7V9W60VbbYoFBNfE6gDUBpVgxBSJuR7jRARb7z/0d8W5pn2Yz1nb
 zBowG7EBuBjJNP3e41Q==
X-Authority-Analysis: v=2.4 cv=aueCzyZV c=1 sm=1 tr=0 ts=6a100728 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=uBSpvLV6fhDO0Xk4A2gA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: GidarL6dfBpntlxIhZhn5w29MRL9uAjI
X-Proofpoint-ORIG-GUID: GidarL6dfBpntlxIhZhn5w29MRL9uAjI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220073
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


On 5/15/2026 9:37 PM, Dmitry Baryshkov wrote:
> On Fri, May 15, 2026 at 08:42:15PM +0800, Jianping Li wrote:
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
>>   drivers/misc/fastrpc.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>> index 3c7c3b410d7d..a0337cce77f3 100644
>> --- a/drivers/misc/fastrpc.c
>> +++ b/drivers/misc/fastrpc.c
>> @@ -1363,6 +1363,12 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>>   	args[1].length = inbuf.namelen;
>>   	args[1].fd = -1;
>>   
>> +	if (!fl->cctx->remote_heap ||
>> +	    !fl->cctx->remote_heap->dma_addr ||
>> +	    !fl->cctx->remote_heap->size) {
> I guess that !dma_addr || !size should fail much earlier than here.

ACK

>
>> +		err = -ENOMEM;
>> +		goto err;
>> +	}
>>   	pages[0].addr = fl->cctx->remote_heap->dma_addr;
>>   	pages[0].size = fl->cctx->remote_heap->size;
>>   
>> -- 
>> 2.43.0
>>
