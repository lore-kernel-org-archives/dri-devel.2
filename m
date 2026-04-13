Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC1E4EBFD1E
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 09:03:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6361810E391;
	Mon, 13 Apr 2026 09:03:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CITUBAp0";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fDtCzIv5";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73B5210E391
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 09:03:54 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63D7QdT7025269
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 09:03:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AYk10NAAdnCzljkbvIxpKLk40WOmplCWnYXCUOb45Dw=; b=CITUBAp09eWPDKy/
 FersKbI5gUwI4631ASffKdJlmjf0hn1b9wlx36aLpYzLbMkyDjHga4IS+3thwzj1
 xHx4e0UziD6fZWrGlmf5Unn7O7vWoIH4auZ5Wikikf2W/e+hjkDAQh34WwgfHffT
 grsmhwCUnYE7Eh6gpdYc36AHyEQdARnc2w6FSpn/e1RJV64GBNCjiLtJv0g6Gqqu
 dlJ5gWUxdl8UwY2Tj3d8xNQ4KxA8HDl9tAg8MTHD6IBEJmnblLPoqEhAbS3IinYX
 H6J2aYFFLP8MPay84OnD7D1JywKhL9o7pV8TuwPhFW62RTBNl4MB0uewoN+iopLF
 +6t2fQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfewkvmdr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 09:03:53 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b24a00d12cso42450725ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 02:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776071032; x=1776675832;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AYk10NAAdnCzljkbvIxpKLk40WOmplCWnYXCUOb45Dw=;
 b=fDtCzIv5LZnhwUQyIbyVqGvnRKwHiugMNRLedQhCyycusYYzw3CkQp6NFojweWfWor
 BVIrLaoTEQwXE7BLahf0dip7OKmNoCC6zZl+NjHHVbpoZ9eHr2EBoBxSuGnz/Os6M57q
 uUXWH11oBuRSo9A0MPBOy4bv+AbNsJBHYL0Z8TF6VOJK7Xy3999GT7SJLqzkC/oEG7Q4
 0AM7lhDEJDoUZLsQEMcV7c3q3pnIxoYqBnshPYbXH5cVpuUdm4n5MochaDjpUHlU6eSr
 E5bTMV+sB+rmOU5b+mwBZ2Gd4nR7N3fXuEzmUMMQRldqOlhX6usflF9WQcuJWvjNppml
 q5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776071032; x=1776675832;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AYk10NAAdnCzljkbvIxpKLk40WOmplCWnYXCUOb45Dw=;
 b=DYo3RgYkZWQO8L1IywqCmzpn04fkfdNIvVXQH5ESdEQHEsOr6mTWX8Tjo8UscalEmU
 MDBVuOb7HimQLlZsC5RGpDg13GtzR9aGIPC0SlgFUeHRZat86RJfEEwKh3ov8wvY2XIY
 fgTYK8Wtsb9SofdyyWUeaLip+gFJAzN5zGtVsGFTWc8ZmCa18ECv5uz2buhNb3SwRVwZ
 e36BJOWZy2k4+6k7p8mVucqsM5ne9oZ93Kb+yiOiD83I+6NWO3Ib/Snsz7sP5IqCH0wR
 fVPU5Gd2elFPksIgNvzB6/7jHF3EtNpzbun2wiA66w5egyXETVIfYbsajkYSLYkIHd7K
 culQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8iXd3xECzJ1cDLp+5PqOt/uMeZuoPLdH8Gwcwwf1/nEfJI7xRExFbpazBGEHfW7yB3cMlypUCkjCg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwZHpAHRkpjT74/f7upDh7XigP6OjB5Rml7g1XeiupcDpTouE8e
 bOM+gkVE4J9Vy0kpXBevuBLBrvwkuGGud/nG9IqR7BgjLdGouOkbhakQ1ND/FmqSTONoas+cZ5J
 gZIDTDXjelrBCf1LWLQtckrB5kmSoiMn6khrQkbZmGIsFLPK207LIIetJ5+0ENlZ+sTtvplk=
X-Gm-Gg: AeBDievVNuiSJbuq2ni3cjRtsIetkPpYYifRQvSmqWdyk2vMvhPIjAltyJqFIRWi4tu
 DvFe95RVKPy9xRw1VRPBqujoWQVAQCNxt9+bc5c9Ajyz4sU66X6k2TXMvzCmn+iKNs09xgA0Mda
 /MgEPuSTYXDjk33o8uxaCsXx7MRdi2M5BVjDtNe2pB0lQb6zuSGTJRSzX86zIeybma/EX01Bwu9
 Ix7zBCKmV6Ri536zYys3D8M12+6UuhMff2BfMQKlDZNi5GPA2ucoBCf7jeFS1IqBe/kkVIRQ5qP
 S15oYkxiy8C6okv/3XYKWR0COr09nMYwK8WdxTeJkOBd5Zgwxb31dDDDG/7KGnG3ORIQDHH+x+e
 z/6gs1Em/LvlV5rk418btanX8dFKmuRfJWqHakO2ZZtiLHUT65fATlck=
X-Received: by 2002:a17:903:1b66:b0:2ad:9b86:ddc2 with SMTP id
 d9443c01a7336-2b2d5a18e13mr122848945ad.22.1776071032508; 
 Mon, 13 Apr 2026 02:03:52 -0700 (PDT)
X-Received: by 2002:a17:903:1b66:b0:2ad:9b86:ddc2 with SMTP id
 d9443c01a7336-2b2d5a18e13mr122848585ad.22.1776071032011; 
 Mon, 13 Apr 2026 02:03:52 -0700 (PDT)
Received: from [192.168.0.215] ([49.205.244.213])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2d4db198asm109169895ad.3.2026.04.13.02.03.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 02:03:51 -0700 (PDT)
Message-ID: <31afe536-a963-4dc8-b2ab-96ed7ebb1531@oss.qualcomm.com>
Date: Mon, 13 Apr 2026 14:33:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/9] bus: mhi: Match devices exposing the protocol on
 the SAHARA channel
To: Jeff Hugo <jeff.hugo@oss.qualcomm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, andersson@kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mhi@lists.linux.dev
References: <20260319-sahara_protocol_new_v2-v4-0-47ad79308762@oss.qualcomm.com>
 <20260319-sahara_protocol_new_v2-v4-3-47ad79308762@oss.qualcomm.com>
 <7aeeed43-b458-4c68-98b0-e857f1ed791d@oss.qualcomm.com>
Content-Language: en-US
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
In-Reply-To: <7aeeed43-b458-4c68-98b0-e857f1ed791d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=bcFbluPB c=1 sm=1 tr=0 ts=69dcb179 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=KtsNJ/6bKgz7QsArn2OSsQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=nb3vwdu8Oqwsy-ELd6cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDA4OCBTYWx0ZWRfX07OTi8VPjxr5
 TAdrhluy6UyjLQfWBQLXPbPIq8qbFvaWo45myYp44uFMv8O1NG5s3PfiKYb8hXrgpexwL/lB8jY
 H1oy+74nlVxRUsoAgRwxLoFQ5netnvf1yS4wMtOSAHrImMvp28SU8QKRvLJ4+44ZL/dMmsi7SPq
 Qc9p9KUS9n4bp7oxeOs4VfvH8l5KkFhCF6cK1b32ysyYl1MEJxmfiJOvYZlUism+IG2qiLNIItz
 KezAiG+6C8AnUbvWI1GiX92PZKzb+j61l6zb+vWbJkgdZnWA1FJWAgZ1yFBa+SY0sOt7G/rsfhf
 9Ncymn9E6lC5zB7hemEw66SSjGR6YFF8sENzZ/TGcbstyb7MywsZ0t8gKF4p/FIj07s6SLDuJpV
 A4DM0B+OB4/2iRlUrKTl5jYKUZ1hFSUzgxFthc4p3kESd/FlgdyuxRc+TflfkJ/4X4226m/ROSh
 TasRnnhKimnBdhgt5Tw==
X-Proofpoint-ORIG-GUID: flC561OIOnfdeK1GXLIOVBCB45c1utnW
X-Proofpoint-GUID: flC561OIOnfdeK1GXLIOVBCB45c1utnW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604130088
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


On 4/10/2026 1:53 AM, Jeff Hugo wrote:
> On 3/19/2026 12:31 AM, Kishore Batta wrote:
>> Some Qualcomm devices expose the Sahara protocol on a generic SAHARA MHI
>> channel rather than a QAIC specific channel name. As a result, the 
>> sahara
>
> "Sahara"

ACK. I will correct in next version.
>
>> driver does not currently bind to such devices and never probes.
>>
>> Extend the MHI device ID match table to also match the SAHARA channel
>> name. This allows the Sahara protocol driver to bind to devices that
>> expose the protocol directly on a standard sahara MHI channel.
>
> "Sahara"

ACK. I will correct in next version.
>
>>
>> Signed-off-by: Kishore Batta <kishore.batta@oss.qualcomm.com>
>> ---
>>   drivers/bus/mhi/sahara/sahara.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/bus/mhi/sahara/sahara.c 
>> b/drivers/bus/mhi/sahara/sahara.c
>> index 
>> 8ff7b6425ac5423ef8f32117151dca10397686a8..e3499977e7c6b53bc624a8eb00d0636f2ea63307 
>> 100644
>> --- a/drivers/bus/mhi/sahara/sahara.c
>> +++ b/drivers/bus/mhi/sahara/sahara.c
>> @@ -911,8 +911,10 @@ static void sahara_mhi_dl_xfer_cb(struct 
>> mhi_device *mhi_dev, struct mhi_result
>>     static const struct mhi_device_id sahara_mhi_match_table[] = {
>>       { .chan = "QAIC_SAHARA", },
>> +    { .chan = "SAHARA"},
>
> This doesn't work and breaks bisect. At this point Sahara will bind to 
> QDU100, ath12k, or something else but not know how to drive one of 
> those devices.
>
> Just add this when you add QDU100 support, which looks to be patch 5.

ACK. I will add this in patch 5.
>
>>       {},
>>   };
>> +MODULE_DEVICE_TABLE(mhi, sahara_mhi_match_table);
>>     static struct mhi_driver sahara_mhi_driver = {
>>       .id_table = sahara_mhi_match_table,
>>
>
