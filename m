Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B682FF886F
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 11:53:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98DE810E66E;
	Mon,  4 May 2026 11:53:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NWLzZfQs";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K/eGlM7X";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 793C010E37D
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 11:53:12 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644B4V7O1531738
 for <dri-devel@lists.freedesktop.org>; Mon, 4 May 2026 11:53:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BuofvOz/5FZrPdq3bPa3pWgfvPCVCJgpGjMM0k7A5g4=; b=NWLzZfQs1QlELHxn
 Y1ouGGR/3tqN8ojHkqnjfLgF1IK/OIqHS5RHdcpzFyKtdwoP5X5r/DCZUZc7krRo
 TrF6mHKpb+/bJSBB9lQ75B6mueu3BTq7z5yc+c0NwZz++6Pg9yjDbFLpXpQ6Lyqf
 r3Kw9FxVBslB7ggKcIkMB5xb+WUTynpy2x7FvKofWwRAWl3/GRlbBxbZe+GgePjT
 Mbt09jiAlfiu3vQQoWVZl7M6t0MRbDk++4xk6Ve2bL7nSUXvzNszozWKA76jxQLc
 4dWBFjc97K98NkzUZTIsO2Gr4ad7xNfm6OJuVZfCAGgLHQ4pp/lKwlVCHumQ9jp0
 40+4dw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dwa1enf5b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 11:53:11 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-35641c14663so4782813a91.2
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 04:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777895591; x=1778500391;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BuofvOz/5FZrPdq3bPa3pWgfvPCVCJgpGjMM0k7A5g4=;
 b=K/eGlM7XJ6ct4rG6s1h3PI7ZJgOzL9Acq1jQ8b/rQfqDhurzYwhzKBjjFuCArj+IJr
 S+wJgUdAZt+O4fHtFOTNJoqwHtoycddYYQe3w899yU+INV9roIDhqDqEud+YttsS8juE
 gZI2g1ZZUCgR/1jQ4fVeS+B2dDflVKyfDDS02dgUNjsXQPs3m4k7r6I1SHoJt1iSJy0p
 dPzx99LiR5eSiW/POYNqviS2X+ptiNqeeMneFXT336vKIxNta+C9NJpRXDTtubcWUPn7
 JJj5aAJ2SsFzGP2PoR+la2CdArNGtDY2hSF1p4Tyjgc3rsHjo1sg9N+3ynHw4SVO/yra
 WaMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777895591; x=1778500391;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BuofvOz/5FZrPdq3bPa3pWgfvPCVCJgpGjMM0k7A5g4=;
 b=G5N+LgSl9kcJxdOelrpRxge63h8+tmiyydH5ILTixhVEkqp4Z3yRU0EnABLwvEgZNI
 ZU4Apb69ZJAjwGaA1iWPTHYaPCX55F6j/lrBbhmnS3PnckPqpKQGMly8k5+Qt2zl5J56
 mf3cONPRWzws+cNQ5ATel3N/HNYXcieQioZTtQ7VssjWav7eyHk5K6oI3GMU2ntQSCz+
 gDjZliNL0Vk3TIJtWJ3Cwbg3MZ15XXbYTjQj2DP3veqlhWmueRn6Nxjboa4l/lsyEvn6
 A8Ha4WK1YSfJXJrJt03X6BSKbcx+5tIG0hSvhIL3U/aQGoMYjF/lELPPWrI8iO7B1A5n
 VHTw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/fJdbBWTpjcgHLvrpB70v0kGG64nm3W/rkRPOFfA5Y8BslcV+ARzoLMqyYxrC5k9Ekvv2qnHSFeNM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyVexw1+ZHLKWb7eZJJkrEb7hEroT+f8XpWCXQyL91UFDWEnpY2
 xxdUWOLzzuD6VGWbv5yjaeFszSNXj3MXKojL5eUU5faFA0c0UXvBeDzhjLHkS8ZCxNd6U4pPhM/
 xOEqNHCCevEQriW43bORWE6kpV+fVWj1gwG+D4lufNpThmNxDsmISTw4UoGdwBBNngG4kciU=
X-Gm-Gg: AeBDievO0XUwx+1NBVE1m8fxyAq1g4q+r5KZor7Zg1CW+VatFcBnQgtBYABB2cokUAT
 TjxShMEUzBvSV0Ny2nfkbgTutRbN65ap6UhE+ZI4HZJxMUF0rbsbqtRuCfS4RDfJbcVnizvQmgi
 SuA2SoZmNRhRo0MPfTtzmIJsM3Rat0cd4imJCiyACdunBLgH+VTX2OzZKEgTnPXtpzkKwmitijJ
 4qsXMWABd6IOGLWe/K4EKPZ2J1+mxL5P0hNt32ihIr7yVxEwOGn+gkys/TIx4Qjzs3Dwe/kZyQ4
 OBeje/+cqZWof2DbdWD8n97pC2w2tP3CkZqdtV2sb+dQf0Qy15z4E+AStJibZ2834gvfGOjh49x
 xQ0AOtUJqqVXwsFMBiXUuAcYDh7uOwPlj8vAfMC2CMxB3Xk+t3khlOXgmdjzSayk=
X-Received: by 2002:a17:90b:4b90:b0:359:fd9a:c50c with SMTP id
 98e67ed59e1d1-3650ce4793fmr9409782a91.22.1777895591049; 
 Mon, 04 May 2026 04:53:11 -0700 (PDT)
X-Received: by 2002:a17:90b:4b90:b0:359:fd9a:c50c with SMTP id
 98e67ed59e1d1-3650ce4793fmr9409732a91.22.1777895590521; 
 Mon, 04 May 2026 04:53:10 -0700 (PDT)
Received: from [192.168.29.116] ([49.37.150.129])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364ec02ab2fsm11431599a91.14.2026.05.04.04.52.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2026 04:53:10 -0700 (PDT)
Message-ID: <6515558f-99c5-43c4-9141-4bd4a2be6317@oss.qualcomm.com>
Date: Mon, 4 May 2026 17:22:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/15] firmware: qcom: Add a PAS TEE service
To: Sumit Garg <sumit.garg@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
 akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
 dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org,
 elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jjohnson@kernel.org, mathieu.poirier@linaro.org,
 trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com,
 pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com,
 tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com,
 srinivas.kandagatla@oss.qualcomm.com,
 amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org,
 apurupa@qti.qualcomm.com, skare@qti.qualcomm.com,
 linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-5-sumit.garg@kernel.org>
 <ab4b5257-92df-4201-ab04-436ab77b2fd8@oss.qualcomm.com>
 <afiCrIYSm8AK9xn9@sumit-xelite>
Content-Language: en-US
From: Harshal Dev <harshal.dev@oss.qualcomm.com>
In-Reply-To: <afiCrIYSm8AK9xn9@sumit-xelite>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 1bkuJ2Tks2ykS9gLWBqQrIUmS_36Q7WX
X-Proofpoint-GUID: 1bkuJ2Tks2ykS9gLWBqQrIUmS_36Q7WX
X-Authority-Analysis: v=2.4 cv=e7U2j6p/ c=1 sm=1 tr=0 ts=69f888a7 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fKl8XJY0368M7tBUixYpxw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=w6fE4RYvq4DoGGcOsJAA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDEyNiBTYWx0ZWRfX6ajB/R4cfUUT
 D7lEJR5jHNj9Ow370+Gj8OQzffyjkzRx6MimUOni9X4XLk53ooTQ/8FEdQY6lEUxWba7cQN/lko
 Pu0o+xZxUUHJX+/zZYYbjz+xyOhm0ov9+QAWC3aeQHQ9grj/oKkgQCopekDg80Z1aOGRibpuQ5z
 hltuSXKFv3qcX/v+mHMSiaNHjuJYDajcIDZjr+7Ojd1me3AD4p929qrznbTMAWbyiBHHe1l3KCP
 HSOw80vncdwSMmt+lEU9NTp4dwjd7BVoin0TEwcBBnBpDuEUOHfjPHsIj+uOkU7AuyfoKbCCyyJ
 HEODhpF7objjB03q7OPrujUYpM2Z7jdGuAH5FTvXTNCOpVZkrgTGMgPpSM8x/Z4ssZCzJ9bKxOI
 B7R8QRmbn3CfdWG9YfERTrkpvC9RpJDsm6reHChxU0LalT24h3SdV821LJb4cs0XeoLO6xb1aFq
 SGZdLCNe6JI28EqrNCw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040126
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



On 5/4/2026 4:57 PM, Sumit Garg wrote:
> On Mon, May 04, 2026 at 03:33:06PM +0530, Harshal Dev wrote:
>> Hi Sumit,
>>
>> On 4/27/2026 3:25 PM, Sumit Garg via OP-TEE wrote:
>>> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
>>>
>>> Add support for Peripheral Authentication Service (PAS) driver based
>>> on TEE bus with OP-TEE providing the backend PAS service implementation.
>>>
>>> The TEE PAS service ABI is designed to be extensible with additional API
>>> as PTA_QCOM_PAS_CAPABILITIES. This allows to accommodate any future
>>> extensions of the PAS service needed while still maintaining backwards
>>> compatibility.
>>>
>>> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
>>> ---
>>>  drivers/firmware/qcom/Kconfig        |  10 +
>>>  drivers/firmware/qcom/Makefile       |   1 +
>>>  drivers/firmware/qcom/qcom_pas_tee.c | 479 +++++++++++++++++++++++++++
>>>  3 files changed, 490 insertions(+)
>>>  create mode 100644 drivers/firmware/qcom/qcom_pas_tee.c
>>
>> [...]
>>
>>> diff --git a/drivers/firmware/qcom/qcom_pas_tee.c b/drivers/firmware/qcom/qcom_pas_tee.c
>>
>>> +static int qcom_pas_tee_mem_setup(struct device *dev, u32 pas_id,
>>> +				  phys_addr_t addr, phys_addr_t size)
>>> +{
>>
>> [...]
>>
>>> +
>>> +	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
>>> +	if (ret < 0 || inv_arg.ret != 0) {
>>> +		dev_err(dev, "PAS mem setup failed, pas_id: %d, ret: %d, err: 0x%x\n",
>>> +			pas_id, ret, inv_arg.ret);
>>> +		return ret ?: -EINVAL;
>>
>> Following the example from qcom_scm_pas_mem_setup() here:
>> https://elixir.bootlin.com/linux/v7.0.1/source/drivers/firmware/qcom/qcom_scm.c#L778
>>
>> I think it should be:
>> return ret ?: inv_arg.ret;
> 
> inv_arg.ret return a GP TEE error code which doesn't map 1:1 to kernel
> error codes. The client drivers won't benefit without having a way to
> decode those errors. So just printing here can help the user to debug
> any issues.
> 
>>
>> This way the client (say mdt_loader) knows what error OPTEE PAS service returned.
>> I can see that is tries to print this error:
>> https://elixir.bootlin.com/linux/v7.0.1/source/drivers/soc/qcom/mdt_loader.c#L286
>>
>> With that,
>> Reviewed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
>>
> 
> Thanks, I hope with above I can keep your tag.
> 

Alright sure, makes sense. Please keep the tag.

Regards,
Harshal

> -Sumit

