Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0FD3FF60EF
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 09:30:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25C7E10E7EB;
	Tue, 31 Mar 2026 09:30:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="Vir7KZxG";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D3D110E7EB
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 09:30:22 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62V3lvsP843933; Tue, 31 Mar 2026 09:30:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TmoIBAO5s8eHJUXNquiDQcv8swr1DwETqh/JT6rdfM4=; b=Vir7KZxGrIQa6l9n
 NmgLQ7kdq62yeahfVVLW3jEWxVGJEBkcL57A4AmfVBCV3+dxm6pZK389EnIA6Qrc
 /JlDEcdHDlvJbwxZnQQDtj1o5gR+17L2zqGWOakKqtm5TTlYl4bewuLuwU4i+TJt
 14Otmn8hc3GbpnASM2SIoWJBlTAwV1/m9tzl1SSUCUJxFJTjQaBuL9KohGawh9H1
 ImaaqYbR1rfjEmUDZBnOwZCJvdYy0OdZZXgqvjdGq2RJDc6kzvOfNXMMeRZ7gyh8
 ZlIlbWXJiynmTMTmzt9ruQsBKv9kShYy+AROcWIikdvZG0Gxi3ZwkLcIhLIbF6AK
 V5UErg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d86nt9ax5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 31 Mar 2026 09:30:17 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com
 [10.45.79.139])
 by NASANPPMTA03.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTPS id 62V9UGOm006250
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 31 Mar 2026 09:30:16 GMT
Received: from [10.217.219.207] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 31 Mar
 2026 02:30:13 -0700
Message-ID: <74629a8f-b813-485f-ad5f-e4d4fe7335b9@quicinc.com>
Date: Tue, 31 Mar 2026 15:00:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] i2c: qcom-geni: Skip extra TX DMA TRE for single read
 message in GPI mode
To: Aniket RANDIVE <aniket.randive@oss.qualcomm.com>, Mukesh Kumar Savaliya
 <mukesh.savaliya@oss.qualcomm.com>, Viken Dadhaniya
 <viken.dadhaniya@oss.qualcomm.com>, Andi Shyti <andi.shyti@kernel.org>,
 "Sumit Semwal" <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>
CC: <linux-i2c@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linaro-mm-sig@lists.linaro.org>,
 Maramaina Naresh <naresh.maramaina@oss.qualcomm.com>
References: <20260326-skip_extra_dma_tre-v1-1-deef018895dc@oss.qualcomm.com>
 <341f2f06-eae0-44b1-b513-61a4a129bae2@quicinc.com>
 <e850f14e-a938-41cb-80fe-fb92f647fc31@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
In-Reply-To: <e850f14e-a938-41cb-80fe-fb92f647fc31@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-GUID: K5lw6drVi_QMYHJZDk15G6HHCo4SXdvK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDA5MCBTYWx0ZWRfXxtqmfuIzxQmk
 0lezQbq+E5VtMBPupfew48pgoGi0TY87alaqhPLa8jv7PkQgAFzlSHRO7ReZ3lPNQqcGjN63XAN
 bUBPhcoTAGfzRBTKXBKGfwjvnVC2tRefvLk/XzXPYqDYqIuMcvmSGb754DNGStjfzO/eDOhUO01
 4kha1wARqhsm0lL32U7pooRrlQmelr5+0uVUW+v8i/7yjr4wK0xc1RefvGZ40OwO8AGBSok3jDQ
 /Nm+/rSSBGYWiiWoAbDsG+MYbS34ula3ly4eL5a+RaEhQKd+1ohChdz439lwKXLfk7lI678oBtP
 ZxrkXbXYW1Fjoh5L7aoHr0CgNlU092J0hpMxF1o12XIhOumpxNb3Q9l0rJm48kW/1TfCxp9edQV
 X9WfIYqiL04Us/CXNKhP7c+9tOPE+5iGRDzi6LFh3mNwQGMtwMoT1AlV2L4nNzFBa6UQ8/8ewke
 ys84f1uYwfpstg9cFnw==
X-Authority-Analysis: v=2.4 cv=IswTsb/g c=1 sm=1 tr=0 ts=69cb9429 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=RwGkIONyzb2M8aXW5wsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: K5lw6drVi_QMYHJZDk15G6HHCo4SXdvK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310090
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



On 3/27/2026 3:37 PM, Aniket RANDIVE wrote:
> 
> 
> On 3/27/2026 11:51 AM, Mukesh Kumar Savaliya wrote:
>>
>>
>> On 3/26/2026 10:01 AM, Aniket Randive wrote:
>>> In GPI mode, the I2C GENI driver incorrectly generates an extra TX DMA
>>> TRE on the TX channel during single read message transfer. This results
>> What's the impact of this extra DMA TRE ? do you see failure/timeout, 
>> anything ?
> 
> This write operation is unnecessary. For a 1‑byte read operation, only 
> the CONFIG, GO and RX DMA TRE are required. However, an additional TX 
> DMA TRE is currently being added. In addition to being redundant, this 
> also results in unnecessary DMA buffer mapping for the TX DMA TRE.
> 
Ok, makes sense.
>>> in an unnecessary write operation on the I2C bus, which is not required.
>>>
>>> Update the logic to avoid generating the extra TX DMA TRE for single
>>> read message, ensuring correct behavior and preventing redundant
>>> transfers.
>>>
>> So for read, we do unwanted write too ? if so, please write it 
>> accordingly.  Correct behavior needs to be justified against wrong.
> 
> Yes. Currently, the driver performs an unnecessary write as part of a 
> read transaction. For a single‑byte read operation, the correct behavior 
> is to issue only the CONFIG, GO command, and an RX DMA TRE. This TX DMA 
> TRE does not contribute to the read operation and results in an 
> unintended write and redundant DMA buffer mapping. Hence, the current 
> behavior is incorrect and should be fixed to align with the required 
> hardware transaction sequence.
> 
Makes sense, please add such details in the commit log of next patch to 
make it clear against the problem and solution. Rest of the changes 
looks good.

>>> Co-developed-by: Maramaina Naresh <naresh.maramaina@oss.qualcomm.com>
>>> Signed-off-by: Maramaina Naresh <naresh.maramaina@oss.qualcomm.com>
>>> Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
>>> ---
>>>   drivers/i2c/busses/i2c-qcom-geni.c | 18 +++++++++++++-----
>>>   1 file changed, 13 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/ 
>>> i2c-qcom-geni.c
>>> index a4acb78fafb6..2706309bbebb 100644
>>> --- a/drivers/i2c/busses/i2c-qcom-geni.c
>>> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
>>> @@ -625,8 +625,8 @@ static int geni_i2c_gpi(struct geni_i2c_dev 
>>> *gi2c, struct i2c_msg msgs[],
>>>   {
>>>       struct gpi_i2c_config *peripheral;
>>>       unsigned int flags;
>>> -    void *dma_buf;
>>> -    dma_addr_t addr;
>>> +    void *dma_buf = NULL;
>>> +    dma_addr_t addr = 0;
>>>       enum dma_data_direction map_dirn;
>>>       enum dma_transfer_direction dma_dirn;
>>>       struct dma_async_tx_descriptor *desc;
>>> @@ -639,6 +639,11 @@ static int geni_i2c_gpi(struct geni_i2c_dev 
>>> *gi2c, struct i2c_msg msgs[],
>>>       gi2c_gpi_xfer = &gi2c->i2c_multi_desc_config;
>>>       msg_idx = gi2c_gpi_xfer->msg_idx_cnt;
>>> +    if (op == I2C_WRITE && msgs[msg_idx].flags & I2C_M_RD) {
>>> +        peripheral->multi_msg = true;
>> what's the actual meaning of multi_msg here ? IIUC, this multi_msg is 
>> set to true for single transfer  ? any better name if so ? Yes, need 
>> to change it out of this patch.
> 
> In the GPI driver, a DMA TRE is created only when either the operation 
> is a read or when multi_msg is set to false. This is controlled by the 
> following check during I2C TRE construction,
> 
>      if (i2c->op == I2C_READ || i2c->multi_msg == false) {
>          /* create the DMA TRE */
>          tre = &desc->tre[tre_idx];
> 
> Previously, when dmaengine_prep_slave_single() was invoked for a write 
> operation, this condition evaluated to true and a TX DMA TRE was created 
> on the TX channel. With the recent change, the flag is explicitly set, 
> which correctly prevents creation of a TX DMA TRE. I agree the variable 
> name can be improved for clarity and propose addressing that in a 
> follow‑up patch to keep this change minimal and focused.
> 
Right, that was my intent too. I think the variable name is misleading.

>>> +        goto skip_dma;
>>> +    }
>>> +
>>>       dma_buf = i2c_get_dma_safe_msg_buf(&msgs[msg_idx], 1);
>>>       if (!dma_buf) {
>>>           ret = -ENOMEM;
>>> @@ -668,6 +673,7 @@ static int geni_i2c_gpi(struct geni_i2c_dev 
>>> *gi2c, struct i2c_msg msgs[],
>>>           flags = DMA_PREP_INTERRUPT | DMA_CTRL_ACK;
>>>       }
>>> +skip_dma:
>>>       /* set the length as message for rx txn */
>>>       peripheral->rx_len = msgs[msg_idx].len;
>>>       peripheral->op = op;
>>> @@ -740,9 +746,11 @@ static int geni_i2c_gpi(struct geni_i2c_dev 
>>> *gi2c, struct i2c_msg msgs[],
>>>       return 0;
>>>   err_config:
>>> -    dma_unmap_single(gi2c->se.dev->parent, addr,
>>> -             msgs[msg_idx].len, map_dirn);
>>> -    i2c_put_dma_safe_msg_buf(dma_buf, &msgs[msg_idx], false);
>>> +    if (op == I2C_WRITE && (msgs[msg_idx].flags & I2C_M_RD)) {
>>> +        dma_unmap_single(gi2c->se.dev->parent, addr,
>>> +                 msgs[msg_idx].len, map_dirn);
>>> +        i2c_put_dma_safe_msg_buf(dma_buf, &msgs[msg_idx], false);
>>> +    }
>>>   out:
>>>       gi2c->err = ret;
>>>
>>> ---
>>> base-commit: 785f0eb2f85decbe7c1ef9ae922931f0194ffc2e
>>> change-id: 20260325-skip_extra_dma_tre-a3cf22f81d9b
>>>
>>> Best regards,
>>> -- 
>>> Aniket Randive <aniket.randive@oss.qualcomm.com>
>>>
>>>
>>
> 

