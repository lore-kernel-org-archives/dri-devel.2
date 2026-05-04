Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C45CD3423
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 06:52:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A54C210E054;
	Mon,  4 May 2026 06:52:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Knhz77nu";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L/Bu5xzX";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2FFE10E054
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 06:52:36 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6446DDj13479968
 for <dri-devel@lists.freedesktop.org>; Mon, 4 May 2026 06:52:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pw+QGNnD2aXDEvze4NDnuqATbVP5Mz7Pd3Jir1xluBQ=; b=Knhz77nub5NVmsev
 r6pOeYc8F9YwhbJNYoqJK2yWTBREnLWN3p2cr8+VXj8mhmgw4TeOcwefDMnahQA2
 SKMF+rn8M7u47PZKJdg0UBEeCjMF6qSygnFJF1Vpi0HNcSrEyjQYlFs/Fz+nf12B
 xb5xZWxcnBrqZkc2nFHolu/NdWgypSyeOGwyxWW6IpAizir5uPyfdqCAFfC4Mafd
 92oByUhnGHCh9EA9I3POBhYYmxFP6HH0zAiHid5ZbHw5pnn4cIl/0p1LcszXSUaO
 ktFnufIUNGCY9IuhuZd5oh0/xwy4vbBEIF1FUi0AopxBjTW7jVP4UXS6I/G64iF9
 uTiTcQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dw9g3mmp4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 06:52:35 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b7aba0af02so37357935ad.2
 for <dri-devel@lists.freedesktop.org>; Sun, 03 May 2026 23:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777877555; x=1778482355;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pw+QGNnD2aXDEvze4NDnuqATbVP5Mz7Pd3Jir1xluBQ=;
 b=L/Bu5xzXTPuMpv3sUve1iy02CEUlKiECBQnxls/GYudkjBxU/8tkjW2K4BvWaPVGIF
 qCl34G1+UlLeDI7LXmg2pGXV2347a2Xek6hIYQjx14M+9QLvbu31lDkAs8upDagDn1sI
 fK73aaA17vRDj/XxFGjniaQSzdR0TAipJWepddRcAkBPOWi46ue0IZoOUoMs+sJ/t0rb
 uHA99nSiy5FMZjlrzrYRtvKNe6mlaAea4PcCJWH/tvwAZCTw+sVKox9NE4ZAOSErHcB7
 8hiP3xL1dJEZijDXSNsXcZ5Eq1sck1G1Hgqa4GqZpeVcT+xhn2blNpVBiVBwogoEembc
 bCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777877555; x=1778482355;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pw+QGNnD2aXDEvze4NDnuqATbVP5Mz7Pd3Jir1xluBQ=;
 b=CuWe8HbgekhhwqjEfYlkhIbmh46tGtbL7OjskQAbWG3xdT9JY0lgoXMJScEX7vmabi
 LqY9yj5cqFyPpUAAQgOnzRDreCpFLile/bRsdtvDVJsNftLEBipreq+x3TE/VojnsJYk
 AaCW1EbdeUG+rZw+/AvEQYqc+aNma1IR201gmDKc/IYFXJ4q4g+xFEkRgpOoAYlAnvDW
 8egg6DDbR/FTQefF/9Sr4N9eaVXmxKTRQ5gWghfVy6LRaCos8TMo7a59VsKtf0FMNWqa
 kLpEgEi/ue0jCNVrw13wryKRgW+Jg32sjTrNXIEPej33LckKVSiGiXCWof82majJyl3c
 UIfA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/NIQ9o9q5NZnyV9m3iWknhYzGGWYDf6Ay6fSRXQ0fITsuZp5Aiu2drKvd0aTsR8jZR1xRyANSupGo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxCfRYZ9q029GME1d5HtOW7xJqrtL9pS8aVo9gViSSw3P8pwfYo
 b1voxReiplPZ5BudCAG4y2+sfP6CZxnJv/BDJe7VOaJB0k88wvYiAt1Dh1DgVSwuYrJXmBkWV1p
 o1fVzY5egkbJl6YVt/XU9bwsOjx/hjD2kTUdykIYkSWcMm7OkkjwMgDE+uIseLMG7j5VjcQ==
X-Gm-Gg: AeBDiev0uo4gJKcsT7sQmqlm1wbNyUta/bsfPsIdHQy5hHhK9daR7eA3xNFS0a6ApoC
 /c5tmN2eyU/+Q1WtzlBeZv3oJIkTazJxPrJxbYMUInYDqWubAykOKaJU5Iw7rD9XOwE/gLlTwzN
 /fO1D9dtWHRT8/R+JdJ/bR9X53O+S6r3gfYWQlrUun2M8gjY1m6tcTvvpZbKa8GWWbOWQQVfm3N
 TwPPIhr62a0F2iqpq4RS56kNsKhCz6rFxxiHjxZgw5bJ3nK5F68qH1WUCGvcnBKKUAHwPPCOdGB
 t9iADMy05DuM8m2JE0I7emE1KU9xVM/QbYdneme53a5bfskCsW6dFP62Tbh+3nBcaYVeuXHm9tc
 V7U++TcNgqfE5TM5w5fvkZfBOUnLgNhsIlOFG+KKpGqcqqJMylQCurggsy+9R/vhUgGFy76mQHB
 7UK9lqeATQGnhE5tYBLXmbE4yampNj7g==
X-Received: by 2002:a17:902:ce08:b0:2aa:d5e5:b136 with SMTP id
 d9443c01a7336-2b9f284e08dmr89328765ad.38.1777877555138; 
 Sun, 03 May 2026 23:52:35 -0700 (PDT)
X-Received: by 2002:a17:902:ce08:b0:2aa:d5e5:b136 with SMTP id
 d9443c01a7336-2b9f284e08dmr89328255ad.38.1777877554527; 
 Sun, 03 May 2026 23:52:34 -0700 (PDT)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au.
 [1.41.240.65]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b9caa7e791sm93849295ad.7.2026.05.03.23.52.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 May 2026 23:52:33 -0700 (PDT)
Message-ID: <e73bc74f-ede9-484e-b171-a7bbdb2c7c21@oss.qualcomm.com>
Date: Mon, 4 May 2026 16:52:24 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 08/11] tee: add Qualcomm TEE driver
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Jens Wiklander <jens.wiklander@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Apurupa Pattapu <quic_apurupa@quicinc.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org,
 op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20250910-qcom-tee-using-tee-ss-without-mem-obj-v11-0-520e867b3d74@oss.qualcomm.com>
 <20250910-qcom-tee-using-tee-ss-without-mem-obj-v11-8-520e867b3d74@oss.qualcomm.com>
 <ljfhoo5o45m3t5fsqypg75c46qohvszd5azcqxyjdcr5unx7ob@vcgip4yzkmmn>
Content-Language: en-US
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
In-Reply-To: <ljfhoo5o45m3t5fsqypg75c46qohvszd5azcqxyjdcr5unx7ob@vcgip4yzkmmn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDA3MiBTYWx0ZWRfX+ihz6Fsz4O4W
 Bm2RwvGXUmxgEJDlFxCBKz/S5vVA2udqDW4xWomUabGK3BPS5C+QJLCAYvTDNyArBiIiS/TMND3
 BAlUwj9g4nCo95Yc4Sx6NpJmhqj8AXPIlbnCvlrt3i1EuTtTHqrSQbWI8FAgslEf54LzQD5aDvw
 91jplrAEOSah6J8cnxliLPUdq0UZa1ANG3PxdcW40OPjWQL5KgNs9qWBFt614yo9zPqiMvUlmwb
 i5Y9ZUGrl+rbxFwLphuS+L88uXM4tTqUMU0i2zz9vKNMdrniNsPm0Gc2nz1qLmkeHwc9M8/7MUA
 1oEZN8JHSidGt8D/M8zYIYHPFciNncWVZi8jQdJuhQHP9FGbPsCLP2bv+9pQFUh7ipbdF8ONiFo
 Z+uZNa+uvCMcUgAAjkNyIILWCJBVtZ7OnqHs0TNHNSwjpojRHVJWDulkEw73U7nhHYJezs5tIaW
 Sb2McK7rezbSMBgvupw==
X-Proofpoint-GUID: Srb-acgdyduiorJ-RPeKkmY-lEKQMbUo
X-Authority-Analysis: v=2.4 cv=Ge4nWwXL c=1 sm=1 tr=0 ts=69f84233 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=NEAV23lmAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=t0CO8BxZkIs7AVVQ4zsA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: Srb-acgdyduiorJ-RPeKkmY-lEKQMbUo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040072
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

Hi,

On 4/28/2026 7:21 PM, Dmitry Baryshkov wrote:
> On Wed, Sep 10, 2025 at 08:41:21PM -0700, Amirreza Zarrabi wrote:
>> Introduce qcomtee_object, which represents an object in both QTEE and
>> the kernel. QTEE clients can invoke an instance of qcomtee_object to
>> access QTEE services. If this invocation produces a new object in QTEE,
>> an instance of qcomtee_object will be returned.
>>
>> Similarly, QTEE can request services from by issuing a callback
>> request, which invokes an instance of qcomtee_object.
>>
>> Implement initial support for exporting qcomtee_object to userspace
>> and QTEE, enabling the invocation of objects hosted in QTEE and userspace
>> through the TEE subsystem.
>>
>> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
>> Tested-by: Harshal Dev <quic_hdev@quicinc.com>
>> Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
>> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>> ---
>>  MAINTAINERS                          |   6 +
>>  drivers/tee/Kconfig                  |   1 +
>>  drivers/tee/Makefile                 |   1 +
>>  drivers/tee/qcomtee/Kconfig          |  12 +
>>  drivers/tee/qcomtee/Makefile         |   7 +
>>  drivers/tee/qcomtee/async.c          | 182 +++++++
>>  drivers/tee/qcomtee/call.c           | 813 +++++++++++++++++++++++++++++++
>>  drivers/tee/qcomtee/core.c           | 906 +++++++++++++++++++++++++++++++++++
>>  drivers/tee/qcomtee/qcomtee.h        | 143 ++++++
>>  drivers/tee/qcomtee/qcomtee_msg.h    | 304 ++++++++++++
>>  drivers/tee/qcomtee/qcomtee_object.h | 316 ++++++++++++
>>  drivers/tee/qcomtee/shm.c            | 153 ++++++
>>  drivers/tee/qcomtee/user_obj.c       | 692 ++++++++++++++++++++++++++
>>  include/uapi/linux/tee.h             |   1 +
>>  14 files changed, 3537 insertions(+)
>>
>> +
>> +static int
>> +qcomtee_object_invoke_ctx_invoke(struct qcomtee_object_invoke_ctx *oic,
>> +				 int *result, u64 *res_type)
>> +{
>> +	phys_addr_t out_msg_paddr;
>> +	phys_addr_t in_msg_paddr;
>> +	int ret;
>> +	u64 res;
>> +
>> +	tee_shm_get_pa(oic->out_shm, 0, &out_msg_paddr);
>> +	tee_shm_get_pa(oic->in_shm, 0, &in_msg_paddr);
>> +	if (!(oic->flags & QCOMTEE_OIC_FLAG_BUSY))
>> +		ret = qcom_scm_qtee_invoke_smc(in_msg_paddr, oic->in_msg.size,
>> +					       out_msg_paddr, oic->out_msg.size,
>> +					       &res, res_type);
>> +	else
>> +		ret = qcom_scm_qtee_callback_response(out_msg_paddr,
>> +						      oic->out_msg.size,
>> +						      &res, res_type);
>> +
>> +	if (ret)
>> +		pr_err("QTEE returned with %d.\n", ret);
>> +	else
>> +		*result = (int)res;
> 
> After enablign QCOMTEE driver, I observe the following error during the
> bootup on RB3 Gen2:
> 
> [    4.720777] qcomtee: QTEE returned with -22.
> [    4.725251] qcomtee: QTEE version 0.0.0
> 
> 

We are using the RB3 Gen2, and it successfully reports 5.2.0 as the version
number. However, seeing 0.0.0 is not necessarily a problem. What TZ build
are you using?

It's possible that the service responsible for returning the version number
is not available on your device, even though the object invocation itself is
supported.

Are you able to make any object-invoke calls from userspace? A simple test -
such as running the TA diagnostics tool - can help verify this:
https://github.com/quic/quic-teec

Regards,
Amir

>> +
>> +	return ret;
>> +}
>> +
> 

