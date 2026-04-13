Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1ACBEBFD1E
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 09:03:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E8DB10E38D;
	Mon, 13 Apr 2026 09:03:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ryp78dd9";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PZGItUv1";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E874D10E38D
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 09:03:18 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63D4n0mu3561249
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 09:03:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oXUF1cdkbsnywS2PX3oceiMZcoIG9dLG2GjPtUBr4wg=; b=Ryp78dd989PduCH/
 DeBkaW9GFdsXXsDMpl+quFEk31zgyYSo/wNbmmZ4aSdRs69/gkbdN6l6rdsGvCQU
 OMlx7bfURuKpx2OFgSPa1rpHFIRNtClK9Dnb7UVyDDFXXu2xJCd4/ZtBKVbkJkJs
 oIaJw3TanayOPIWVFkjENuKNZiutvHAkpPHMbJyABlCeOaRhhV2b15wbr/7mUx78
 5zDPYIy/mRuPNvDsv4u8vTUjE8E2p8cSkvBOQ9Wf+0/FWZzXa1xQj6P2p0zIeoeS
 a7/H+NCbCSuPhfImD1OHv5Q8FhGBzGf1QMfvlOP1ShK3klas1LzF1z3RKoRpetNP
 tNGS2A==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dffb0mhce-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 09:03:18 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b2523e0299so98197845ad.3
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 02:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776070997; x=1776675797;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oXUF1cdkbsnywS2PX3oceiMZcoIG9dLG2GjPtUBr4wg=;
 b=PZGItUv1/TF8ocO6GWKqinyHa9uKQuHMZaP+l6CWwb+xv9xzbZkLqcyEsx5JyfOXyf
 GNDvuGX4vWeAl5/0a/7M7BBhpwBeMailRAqeEvUGHrm3zqPRMSsiD3ljICiKaLuP6Wqb
 R2AqRRHf5CZeqb5NVfTNN1XtU/Ip+Le2zAPLC+K9wAzkhRs0Dgo3y1kdFp785gWWXsZz
 MrJ35a52pv+2t05GKqs4/CtcUwBRcy7SLj9W3GpOYQCPbW7/jBGase7hTiBIk7G0vubw
 NilK7qffI5OoYeyXzbqRKWImK4eYasXAOPybTqYRUShQsI42Xl9DACi3GRvge9iTvaKV
 54Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776070997; x=1776675797;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oXUF1cdkbsnywS2PX3oceiMZcoIG9dLG2GjPtUBr4wg=;
 b=LWhDPwvD96eA9Ht3EeWlAF/2lIK+SN/GzWq0GDFomFfMZ7zV4JVxvWpP9PtIGpC0nB
 J98Ap/iPKZxZsNgblOdYbaqsfoqPR6zThZ9jkOCBTkpGU5hE5jmRSbLpQ+w3xEw7s907
 PZjLCHs3SUq3a3E4wBOzKyXx5i7MVL0qBEHHCdhxRTth+620sz1ZilYCTmJTtYokwOV7
 ecjUu8jHm7pkwWHdl69KaReG623ODvSo6FVDIQ+W9+OjtFSwPDJrcC4+9lxsSvulwyo9
 /SAb4coHpNIT7RuL973Y7QGfdcgID6JR4X3OtwS5UMYGzE04Vr0oXB73MM6EfYJhH3ni
 WA8w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9DVWz5zkwOvHqpYgu4zYUypLSn0U9GB3kH4HXpkXaDdJE7Kx2m5+oVhvDF2p0eHZnVGZ+rNT/81ic=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YziDUfpGzjpLoqKiNf9cnlxmEhXEwqKepP9UsoKD17XTgpXYr2n
 4LVA7Hvo3nzOKM2P8gSszgtGU+a9TWIlx+uMeSe2LSp/cheyI0Ue8BpkThCR1/NT0SX79DG0ozt
 nkzUmXaAsgdmIvGwFbyTHkhCJs1diWitvBr4PW27mLw5UUuKK6XywvKN03aF2Q6zEnBKdcUI=
X-Gm-Gg: AeBDietiJ5F1kZfVnMCE9F4qfSyIgwjS3rxRfZXRMXF0tQifuJRW5BQF5De8GEvwXHW
 xOKm55QqFymSSqENoRZomOb8cxLH/6XH36pAeBtdsXBF83Ri5KHEBcG9LW37O2yuFtVN7NhRbcD
 zw0n8/L1AEj3En1ej9BuTHwr7Op3kinZwXMVFxNw856e2OBVXcc2gnG4W8CukJ/EpWcAbii5Nuw
 4V0UfAn+g9ykSYqqKUORUW2i6deZtOLoqp/Suk/l8O8vmrP6AEbe//JIOZzSPRyNivuIgbWOl0D
 6gmvUyPYJDwBTKweKi//Xw3racayhqDbhAB7SFwzMp+eIr1PofeGnWYlFjGaiQYuMafclHCNRQo
 p6lLJ9QfW/gbLdetQDRpWF95KSGPLDRR0Hn1Tu/xc+IwcGIOyxuAvaw0=
X-Received: by 2002:a17:903:40ca:b0:2b2:42da:25cd with SMTP id
 d9443c01a7336-2b2d5a88d7bmr132828925ad.45.1776070997524; 
 Mon, 13 Apr 2026 02:03:17 -0700 (PDT)
X-Received: by 2002:a17:903:40ca:b0:2b2:42da:25cd with SMTP id
 d9443c01a7336-2b2d5a88d7bmr132828655ad.45.1776070997059; 
 Mon, 13 Apr 2026 02:03:17 -0700 (PDT)
Received: from [192.168.0.215] ([49.205.244.213])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b462830bc5sm16069325ad.50.2026.04.13.02.03.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 02:03:16 -0700 (PDT)
Message-ID: <65e37364-f721-4e86-a105-1058d6267121@oss.qualcomm.com>
Date: Mon, 13 Apr 2026 14:33:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/9] Add documentation for Sahara protocol.
To: Jeff Hugo <jeff.hugo@oss.qualcomm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, andersson@kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mhi@lists.linux.dev
References: <20260319-sahara_protocol_new_v2-v4-0-47ad79308762@oss.qualcomm.com>
 <20260319-sahara_protocol_new_v2-v4-1-47ad79308762@oss.qualcomm.com>
 <a793d256-f0e6-4a95-943d-e5d85c781428@oss.qualcomm.com>
Content-Language: en-US
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
In-Reply-To: <a793d256-f0e6-4a95-943d-e5d85c781428@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YfmNIQRf c=1 sm=1 tr=0 ts=69dcb156 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=KtsNJ/6bKgz7QsArn2OSsQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=05GiTeiPTPDWsqTu57sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDA4OCBTYWx0ZWRfX8+rMWaP0ByiF
 WFkh+m3mHFOo9jTsCL8Z+yV6LJWOGmdeys26/0ZNBQqwCVvizFkrcMLIsSwsGlZRkRm3HDiPSl6
 fct4bkjJHeuFbt0X/U82ajeGQPhpWbL4fdoVzV36hNOMcqrMUwRwu+lCTcz/eNIVGOBPIzP7D4H
 3iRMHRKnF+PH8J5LMjM7sm0c2nQpMQnJ86FFu7R7sczmsPV9yH1Kmd+tfV/B3mIpmNdjqhWBMSn
 VcZLDHY81a6lbovEBpAiM9oahsQWTt04/H+kETMQegK2AoV1E2WoirPOm8Tpzk2+bUb0AAjYW9P
 Ou3gSyEPdHWr61HH7HbtPFkuPutoSXtJ1Rr9RaStdPsR2PQMxASTq9qO1kRbV3U4WZqVxKA0c6x
 vdvI+NpMM2PnqkKG/Y984klST155S9HIy+MiPkiIn/9VaWEaZ7IUA4UbkX+y0pnB84TmvCSLSJ3
 smBQZfdS6dFOhFfASQQ==
X-Proofpoint-ORIG-GUID: KTXK4XvdFwGWR7omJ28H_fhcm-L9v9Fh
X-Proofpoint-GUID: KTXK4XvdFwGWR7omJ28H_fhcm-L9v9Fh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0 malwarescore=0
 spamscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130088
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


On 4/10/2026 1:17 AM, Jeff Hugo wrote:
> $SUBJECT is not a complete sentence.  You should drop the full stop ".".
Sure. I will drop in the next patch.
>
> On 3/19/2026 12:31 AM, Kishore Batta wrote:
>> Introduce documentation for the Sahara protocol, describing its
>> operational modes and their respective functions. The image transfer 
>> mode
>> enables firmware transfer from host to device. The memory debug mode
>> allows extraction of device memory contents to host. The command mode
>> facilitates retrieval of DDR training data from the device and also
>> to restore the training data back to device in subsequent boot of device
>> to save boot time.
>
> Thank you for the documentation.
>
>>
>> Signed-off-by: Kishore Batta <kishore.batta@oss.qualcomm.com>
>> ---
>>   Documentation/sahara/index.rst           |   14 +
>>   Documentation/sahara/sahara_protocol.rst | 1241 
>> ++++++++++++++++++++++++++++++
>
> I see from the cover letter that the sahara implementation is moving 
> under MHI. I expect to have more about that move later in the series, 
> but MHI already has a documentation directory. I don't see why Sahara 
> should be at the top level if it is considered to be coupled to MHI.
>
Okay. I have shared comments later in the series. Once its concluded, I 
will move the documentation to the right directory.
>>   2 files changed, 1255 insertions(+)
>>
>> diff --git a/Documentation/sahara/index.rst 
>> b/Documentation/sahara/index.rst
>> new file mode 100644
>> index 
>> 0000000000000000000000000000000000000000..073002c15a203344524e258b2aa0a6ce839e064b
>> --- /dev/null
>> +++ b/Documentation/sahara/index.rst
>> @@ -0,0 +1,14 @@
>> +.. SPDX-License-Identifier: GPL-2.0-only
>> +
>> +========================
>> +Qualcomm Sahara protocol
>> +========================
>> +
>> +The Sahara protocol transfers data to and from memory and describes 
>> packet
>> +structures, packet flows, and their usage.
>> +
>> +.. toctree::
>> +   :maxdepth: 2
>> +   :caption: Contents
>> +
>> +   sahara_protocol
>> diff --git a/Documentation/sahara/sahara_protocol.rst 
>> b/Documentation/sahara/sahara_protocol.rst
>> new file mode 100644
>> index 
>> 0000000000000000000000000000000000000000..91204bb7d170be4fc4c85f142b8f0b93d3c421a0
>> --- /dev/null
>> +++ b/Documentation/sahara/sahara_protocol.rst
>> @@ -0,0 +1,1241 @@
>> +.. SPDX-License-Identifier: GPL-2.0-only
>> +
>> +
>> +=============================
>> +Sahara protocol Specification
>> +=============================
>> +
>> +The Qualcomm Sahara protocol driver is primarily designed for 
>> transferring
>> +software images from a host device to a target device using a 
>> simplified data
>> +transfer mechanism over a link. However, the sahara protocol does 
>> not support
>
> "Sahara" should be capital "S" everywhere in this patch.


Sure. I will make changes accordingly.

