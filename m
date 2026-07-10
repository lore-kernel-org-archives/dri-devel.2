Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14EF1C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 09:28:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CB4D10E17D;
	Fri, 10 Jul 2026 09:28:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bEQZwyc8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LIodvoVn";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B427B10E17D
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 09:28:01 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A7dcZA040916
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 09:28:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ea0QguoYL7HAG5QOZUHhNnUFaa6FuT9iaUs3b0VOK4E=; b=bEQZwyc8XDMXAW5T
 oEMWxvv0TPUNE+xjii/lGQs/yn9jua4T4pq8gYMXFaVqqv3cUCllqk9RRr0FtlZs
 FW6ncGBWWy53MmpI7kIlvuWR6NXQUazvB06l2jzszG69JXWFEvdVuY3fgJ6eTA4G
 kdh9ZpYO0R2TKghzi+ltSI7N1ljdtrWw+J8S9jvXkmApG9tpzHh/L7TMc7hPjw1X
 TIAWCIOdl2RbUMUEMI4jHB5vGnw7hkUeKicM/4bxTvqg0FZHIg59pjpn+27e0m0v
 sg+BieWuHrm/sC0Y8Rz+0LwssX/yp8NpboriYdS06O3QH1fTG5W26EU1MIvGL5Zz
 Pz25Zg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeg5kshw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 09:28:00 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51ca37ce4c3so2081341cf.3
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 02:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783675680; x=1784280480;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Ea0QguoYL7HAG5QOZUHhNnUFaa6FuT9iaUs3b0VOK4E=;
 b=LIodvoVn81rTWFnXeWDCy5mKUiY3EIML1qcwB50SuC2j1BOwmk4phDZXrHagwNja96
 lFtRTJwvqLtupebcc+BCVDyaoC1TLkxHxVmIkewC/ZKgwIVh5oLOu22ZIBECl1yvxnTZ
 UcWhiODqCYl5y38dyfxWfteJJPfK9zi9QT6L9mz+//O8wxyL/JuUvq9o/5uD8hTfGd1c
 mADUeG4s4h00QZl+F7vbhgQh604eiTZc0jpWAiocvGqmu9WB5AWIDph33yocrdpcaQ3V
 9249m/XngvfTmzUtp+bK3SGFsLmcBWuOsRfd7iPY83AjYaoLj13bYe02SpoIfRAMMMYA
 0mEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783675680; x=1784280480;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ea0QguoYL7HAG5QOZUHhNnUFaa6FuT9iaUs3b0VOK4E=;
 b=UacjRCQotcP/G6CW1OsM/txf7wXvJK1fIBb/KBMw43iifra5Zy+92mmE+nreqWeddE
 t1gtrNcTuNaJKvw8OAA7EXjAfnGGE1tMmr+ZiD4+qDHVZykp/Dm589ScavPSnnCn7wu6
 Y8Vfx4dKkuv1YEsA+OXtjwSurrk1gT/kfyA5Rb5mvbsXMWHM++u6W9vCmTvFCCZ3L0j7
 WkMlI9nIkKQHWoHd/PnWVpvT/tX5NXEw0VQy/LWbRsYczpzD6lXkgaxSrhftU9oJ2pwG
 kNFtPHUC2VzqJ6keRmPL9gNI9KobTXKmU3pHCt2t8dt3zQ3XMX/DLAqMJ3FE1oNNefWj
 UV6w==
X-Forwarded-Encrypted: i=1;
 AHgh+RozmxGfd8WMvxtsScnoljNrRrS0fLfqOhqxZ7kf/bUKLzJxI+EYLdrwQ6cz3i1liAdyk1tJl0QnOf0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxqM7K25a5Y6xgkfZBMwHgxjRgjbd8PyTj24I1DP9GZJYuv1E/W
 sp4kshHiOS8eiCR+0EM0mXfX1o6YYfGCi8ItPIJ62Zqpr5dPqpxQQj1qyw8TBoNhPS0qAOEhGPN
 APoeg6EwcJhGpQmtfoj/7ccWcX85CyovPXAiTN8GWlBDpJbTfquRIsarIJueUugpTExF6eqQ=
X-Gm-Gg: AfdE7cnVdvrlO4X/X4aydzovrUDHzzK3YMz97H64u/egMcF7uhJmZoIoKTPrm08bsXo
 X2vqwY5uqyAX5EpE1zFWsW1tZ4aVS/niISQAhKThgZt3pMiTuTYWjxikMFzWoktSW4Tqpjr0Udr
 o2WWouAhfgRElKDBG2Q45p8/ddj10qI9+tJI0z9CRPjpITMVlXUmUgoW1cGlbxOnEmv3zTOpA/R
 ESYoCSBN8JuEeQHtqCJTEarB/nVCqGyw7BCVbT0Pf/4q83ss4U4Yk+ny7xL8gXIfLiFFj+m0QZk
 gBfqdPkyCiaZO8kfLp/6PaJODGdPS4wScnPdnEZ5MajlENhOHGnud70OJ9LJgPAMCEWCTXQchbN
 /I9nVb+MXiDBmv/YnGR1whMS6Via8cC96Rgs=
X-Received: by 2002:ac8:5acd:0:b0:51a:8c9c:7de1 with SMTP id
 d75a77b69052e-51c9684058emr68768721cf.11.1783675679872; 
 Fri, 10 Jul 2026 02:27:59 -0700 (PDT)
X-Received: by 2002:ac8:5acd:0:b0:51a:8c9c:7de1 with SMTP id
 d75a77b69052e-51c9684058emr68768501cf.11.1783675679321; 
 Fri, 10 Jul 2026 02:27:59 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15cfac0f76sm402966166b.33.2026.07.10.02.27.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 02:27:58 -0700 (PDT)
Message-ID: <82326bd4-59f0-45b6-8f06-38896cf9f9bb@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 11:27:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i2c: qcom-geni: Add dynamic transfer timeout based on
 transfer length and frequency
To: Aniket RANDIVE <aniket.randive@oss.qualcomm.com>,
 mukesh.savaliya@oss.qualcomm.com, viken.dadhaniya@oss.qualcomm.com,
 andi.shyti@kernel.org, sumit.semwal@linaro.org, christian.koenig@amd.com
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 naresh.maramaina@oss.qualcomm.com
References: <20260705135739.4038826-1-aniket.randive@oss.qualcomm.com>
 <4f865aaf-a400-4dc6-acaa-80dc22a36af7@oss.qualcomm.com>
 <6b53fa97-0fae-4ba2-a774-ae8df2c2ad4e@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <6b53fa97-0fae-4ba2-a774-ae8df2c2ad4e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=FN8rAeos c=1 sm=1 tr=0 ts=6a50bb20 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=7-yhJlWS37sO_0-qT9EA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA5MSBTYWx0ZWRfX+O+RSOJBMXk4
 RIDOLPktDrboTK062U3Iz8Tt2nqEeAFUxP+VkG+UPGPdqwhwQhEE9dFFNQBcJAK0A/Z4owMmrL8
 NKC+7HXzP+ydq1yAxUGeCCYCYSvGJsI=
X-Proofpoint-ORIG-GUID: 39spUkmBNg3VWQLL45w0ZA39dQaxakvV
X-Proofpoint-GUID: 39spUkmBNg3VWQLL45w0ZA39dQaxakvV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA5MSBTYWx0ZWRfX9Jto3qdcUZgL
 4snuzyVVgT3QsJx0qYNekkig6e/ap/0IoBMx7xSWoNbR/q3m8H/gEn3N8I/lEp00/pC+78PixVO
 F2tbDiAnz4gH/IFkgoFmFVKcUT76YwrZEEmrUQ0UhM3x/NM7eixa3QjFl6vxQD6vJlvbFEa8jKz
 gn+1DkV5c4dDaFenLfguprNQ9GOiJ2plFdbIWKiAU+lGDQW3CRUloAQ3GGhqB28RD5ZaOnArBDE
 nV86yGq8SXXfy3GHL1miPDT/qkx95n5mph76pCSwOseKfugTnvzDroBe1FUJqktndAY5deXPJ6f
 tC/epmIH+k3Hzpc6fR95+nWebqcwUVJyTqs+0fmgF6by9YTm/F9Uu4wM0mqsNphpd7aNmc5hIJA
 96qF9JVMWKQgr/ZnNPwqe+/xOcszHtkjn3usT0VSk8vTgqwxA3biILVxrPqx+BnAduKk7mKYgwP
 5cH34RfYNhVqIb4thmg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100091
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

On 7/9/26 8:28 AM, Aniket RANDIVE wrote:
> Thanks Konrad for the review.
> 
> Sorry, I missed your comments on the v2 patch and ended up posting v3. I'm happy to post a v4 incorporating your feedback once the discussion concludes.
> 
> On 7/6/2026 5:11 PM, Konrad Dybcio wrote:
>> On 7/5/26 3:57 PM, Aniket Randive wrote:
>>> The driver uses a static XFER_TIMEOUT of HZ (1 second) for all transfers
>>> regardless of message length or bus frequency, causing unnecessary
>>> delays on error paths.
>>>
>>> Compute the timeout dynamically from message length and bus frequency
>>> with a 10x safety margin over the theoretical wire time and a 300ms
>>> floor. For GPI multi-descriptor transfers, use the maximum message
>>> length across all queued messages as the per-completion timeout.
>>
>> What's the reason for a 0.3 s floor?
> 
> The floor accounts for I2C clock stretching. The spec allows slaves to hold SCL low indefinitely during internal processing. A dynamically computed xfer time alone gives no time for that.
> 300ms value covers worst-case stretching while still detecting real hangs 3x faster than the old 1s static timeout.

Please put that in the commit message and possibly in the code as a comment

> 
> Thanks,
> Aniket
> 
>>
>> Why a 10x safety margin specifically?
>>
>> [...]
> 
> The multiplier covers the gap between theoretical xfer time and actual completion time (DMA descriptor setup, interrupt latency, and scheduling jitter on a loaded system)
> Without it, short transfers would have almost no extra time before a spurious timeout.

Likewise

(Should there be a constant safety margin added to account for all
that? Keep in mind this driver will run on a turbofast Glymur and on
a notsofast Agatti so any numbers that depend on the processor's
speed must be reasonable for both)

Konrad
