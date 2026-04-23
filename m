Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F0CF99352
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 08:37:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFF3D10EFAB;
	Thu, 23 Apr 2026 08:37:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="c+tVaFRc";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="avK8m7xA";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C166210EFAB
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 08:37:31 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63N5jvJN3796409
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 08:37:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jhRntaser1eVzeCOhXjlHkYnbt+wCG8FqFTGxoVYfmc=; b=c+tVaFRchVP8LYhx
 jG2ZJxHIb2ri2zlr/V0Q3HvIk1m/mlEI6XODj5f/adjlbQqLy/CTmIl5pUqKk7WN
 WcLHbDDXcsVd8NguauSXTEuZwAAySdkTKcy5YuRTVOuxYKfjTfoEC5+ZYaP7t5VZ
 V5Q/KK4cl9rQ1x0OUzzxytICrlN0v/N/7xxIxmw3h73o+Yn+aBVa4iyFws/AcmY0
 HiZMdW5CWBD/9LxP3SGjpD2xUe6clvI3PI5lb/zcMmaZcbHsM5XhiuOwEgyUFJub
 0Semb3Bw6xXm1M1Obd9HB5rgKD2coaRKuNHnWzfc5Xj+nxVUPMwroRYYydkJ1y/u
 INbWHA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqdjm0kpa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 08:37:31 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b258636d16so65211885ad.2
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 01:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776933450; x=1777538250;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jhRntaser1eVzeCOhXjlHkYnbt+wCG8FqFTGxoVYfmc=;
 b=avK8m7xA08MN0PfnX8XpNPl+yQmHgkzyGcwDRLgwNdwkv5YWP9DPmeux6JUB59igEz
 ZlCvCfKIdLIIOf2c+uDydIQbczY2/2tl9uVY5w8k7PAAtXsIuQlG7uvRkpK5Qqp/SVJ0
 5aObW8S/dyXsDpuH+v4Mv9z9P9kJUksNt1XDCbKehJTIK70RJGfdpXwC0x965LbS0CGJ
 MWDVsEad2sAdmQE49smN2kk8ENspJHCnDZG9GXohNlUlew0LkeqW5F6zSVzgmFA4xyvJ
 oAQXHsliKzu6Tn5BVOLWHbnE9/07RMoQysGJhSRid+jH/nBNaMiaBHp+NkP9jVMj6KQB
 0azw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776933450; x=1777538250;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jhRntaser1eVzeCOhXjlHkYnbt+wCG8FqFTGxoVYfmc=;
 b=Em7jjZGLxbrqm8C/S8CPavoapAAjDs30v34vb5jeXpWkFyTvqnewxxLrPryeyYUZU4
 KbrW08j1ZsJ0qdvGuQAow0EPg0eWCDidMZhrhHnM5A8JbBPNCF/JBn0sAyclYiCfZpPO
 FlC7bhEyLsT1RONazupc6njcLfmYTyMZFbgkNQikRNwBbFuHrTcdiB5cGp7ZnK+Yz5Zr
 8PSBpxTlTpwutUM68wRplz9RSww0LGrf4cDWH1CvKD/X+nk9q8xNoxsmBgBd3jpHw5oN
 N5Mv/EmWLzKqv6mV66omQ2JxzgJlmS/3J4y9A7NjWKa1rry6VNMtW7J3vYWfMAv0o0sI
 0nvw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9n5l43oQnRlCossJpDWk65Wy7KrCLtSCbWFNYjj6xJ0RzVywtqckJX5BW1eZYrxJUN9LLQJTDYD24=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywze0/m9Q5RXFtJMdYorUz96DXM0jo8QaJOpcUEVNPL9MHQQCtM
 DjXIp6K1PEkznRM5OpH5334iZB9eqEkLfx+VfhOqgzXLVv68BkPmPSn2xCvw2mPZTDv9VbW21ci
 fOB7p7DJmIdx9eIKhva2+PmxJHJEkB9YDOLSnrXiQxd0b5ZaR/DoN3AEP2e164lB/BptHPrrRzh
 QM8TLVqA==
X-Gm-Gg: AeBDiesSFfLkfnk0WN3E0aH8CUP0GbTRpI07cJ8Zb6qJShQHUFUHQdm3gBCfeUhV5rp
 dmERhmbg7pnT/CsLV19+ec5Auug0flw3LOuDQ15NL5w0jkb3j4zCjT4vrJCZ/A/Td6AFNL1J5EX
 tChhrxtZgV8UXjGosFAW334dBvm5uT1wvFWYiv24r7c2uxUATDM/ZU26ZaSAfNM6Ph+FyZLVe32
 FZpE7wKnirz3KzPXQgmLKutktUAN/ZSsFnXeZC+yVKFKkg7hPAv8r+g3nZxYrez45tnaGQE4Bcj
 ggFA3qsCftXErvcxr2ZlCF/jlKKzYYTmnJ13Z8irJgqIeHQctjbrrk8HJ2EOFbvLk7QMMGEoXw6
 Z6fJkXmuYpGy1pXYPHN1s2fcprnmxXaCe/SfG3FEdHYn1lx4XaF2ugT8aUD/D
X-Received: by 2002:a17:90b:384e:b0:35b:952c:43b9 with SMTP id
 98e67ed59e1d1-3614040b2c7mr27613886a91.10.1776933449642; 
 Thu, 23 Apr 2026 01:37:29 -0700 (PDT)
X-Received: by 2002:a17:90b:384e:b0:35b:952c:43b9 with SMTP id
 98e67ed59e1d1-3614040b2c7mr27613871a91.10.1776933449143; 
 Thu, 23 Apr 2026 01:37:29 -0700 (PDT)
Received: from [10.204.79.66] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36143b0dc2fsm19089888a91.3.2026.04.23.01.37.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 01:37:28 -0700 (PDT)
Message-ID: <52aa6442-7e0e-423d-beef-0ef2a6c06884@oss.qualcomm.com>
Date: Thu, 23 Apr 2026 14:07:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/4] misc: fastrpc: Add polling mode support for
 fastRPC driver
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: srini@kernel.org, linux-arm-msm@vger.kernel.org,
 gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de, ltuikov89@gmail.com,
 konrad.dybcio@oss.qualcomm.com, andersson@kernel.org
References: <20260422092409.4107093-1-ekansh.gupta@oss.qualcomm.com>
 <20260422092409.4107093-5-ekansh.gupta@oss.qualcomm.com>
 <jqehwyeoda5t5kabxjouc4kgpnebndotkr2a4tuuiypzqcck42@dv3vu7wbq6nh>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <jqehwyeoda5t5kabxjouc4kgpnebndotkr2a4tuuiypzqcck42@dv3vu7wbq6nh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EZn4hvmC c=1 sm=1 tr=0 ts=69e9da4b cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=G4waM6_Fef8mLlXZwtoA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: CKXqOEg67vXi9fKo8-OgFNEQ52n22Lsx
X-Proofpoint-ORIG-GUID: CKXqOEg67vXi9fKo8-OgFNEQ52n22Lsx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDA4MyBTYWx0ZWRfXzP+S9gGJj8gj
 d/EGS37dEvCuOn6XywtD9HF8Lz6KR5AND0YHJqMuwJhSicvptWNS3c172sjOve+sSg2ruvW957x
 t+V0Vdh4PWeavUyCq1H1cCOFkuqRFzqUWEOFQ0FRbG9M0DKGKdKdUly4uTf5o2cmXIGQOazLUM+
 5279wG2ldPrkjiyryKnhUDDsUMPowLm6T++C2ddQ9KMm1qiM44WzMsOoG4vJXU4ogUs7cQ7fWxZ
 O0eTxKKjBbI3RTOprzTSguf8eTnolnXUeLWDGJ+Na/wohfsPuLqulbENsVBdRf+Do14V600UlIp
 o9/vIUh7L4qn3fNT+hihl5S5ZnyibI3iUX+YQbjJvFSzLoPbFg4SP34LIrOwqdAyEP1ttTPVOZt
 BQzVfOB8/ip1ILJXXYT7+irF0rfHG5jl+eD/j/6fOADR9g5C6bJR87zBFEOWqzPDeveqG4OCoCh
 8WNuyYtqkLXUDXcAXxg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230083
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

On 22-04-2026 21:17, Dmitry Baryshkov wrote:
> On Wed, Apr 22, 2026 at 02:54:09PM +0530, Ekansh Gupta wrote:
>> For any remote call to DSP, after sending an invocation message,
>> fastRPC driver waits for glink response and during this time the
>> CPU can go into low power modes. This adds latency to overall fastrpc
>> call as CPU wakeup and scheduling latencies are included. Add polling
>> mode support with which fastRPC driver will poll continuously on a
>> memory after sending a message to remote subsystem which will eliminate
>> CPU wakeup and scheduling latencies and reduce fastRPC overhead. In case
>> poll timeout happens, the call will fallback to normal RPC mode.  Poll
>> mode can be enabled by user by using FASTRPC_IOCTL_SET_OPTION ioctl
>> request with FASTRPC_POLL_MODE request id.
>>
>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>> ---
>>  drivers/misc/fastrpc.c      | 148 ++++++++++++++++++++++++++++++++++--
>>  include/uapi/misc/fastrpc.h |  25 ++++++
>>  2 files changed, 166 insertions(+), 7 deletions(-)
>>
>> @@ -2331,6 +2446,22 @@ static const struct fastrpc_soc_data default_soc_data = {
>>  	.dma_addr_bits_default = 32,
>>  };
>>  
>> +/*
>> + * Older platforms that use default_soc_data but whose DSP firmware
>> + * supports the FastRPC polling mode.
> 
> There should be a comment, "don't add more platforms to this list".
What if in future any platform is enabled that is based on older archs,
i.e. doesn't use kaanapali compatible but supports polling mode. In that
case this list might require an addition.
> 
>> + */
>> +static const struct of_device_id fastrpc_poll_supported_machines[] __maybe_unused = {
>> +	{ .compatible = "qcom,qcs8300" },
>> +	{ .compatible = "qcom,qcs9100" },
> 
> Use qcom,sa8775p instead. See sa8775p-ride boards.
> What about qcom,sar2130p?
> qcom,sc8280xp?
> qcom,milos?
I'm checking for these platforms also. Will add if these are supporting
polling mode.

//Ekansh
> 
>> +	{ .compatible = "qcom,sm8450" },
>> +	{ .compatible = "qcom,sm8550" },
>> +	{ .compatible = "qcom,sm8650" },
>> +	{ .compatible = "qcom,sm8750" },
>> +	{ .compatible = "qcom,x1e80100" },
>> +	{ .compatible = "qcom,x1p42100" },
>> +	{},
>> +};
>> +
>>  static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>>  {
>>  	struct device *rdev = &rpdev->dev;
> 

