Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E4DC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:20:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1062610E7B5;
	Mon, 13 Jul 2026 07:20:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EuZVA2il";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BGRhDXM1";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CCE010E571
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 07:20:08 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66D6NwEm674467
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 07:20:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CCDChNA9Xvl37VAmNthtfzvgdA8yOF5Co/p3kft3pP4=; b=EuZVA2ilIJ7W9Zfq
 0SzjCDO/PcAiEsx2dRJnLfsG75isPyitJGsGwVki7RRBBvH3J6JhjaDnrfuGG/l9
 0xp1RN3OBZ6pM9pqbQGEC4oI17VutZUaKtKlZnQz8s+xho4wW42C1X3Fly/Dn7Nq
 oZGxU2E/BLHMTMF9auRqg2vehrPYQUFCDaKsOFArerxEKzFt5npuI4l4+lUYlnqq
 f65nxCgn6L7AEiNocbfcDp40Xema3Q3auYRoZa5tdp13VtQREGjM1bOAF7xAZ/4j
 EjizrQfJHdl+CW+1nUwLkFXIjUQQ8vjSu5EFXGpU+GrBXQAzQDF/EpjU7MLiyvBo
 QLBRsw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbecgmy9v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 07:20:06 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-380b630c505so3559335a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 00:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783927206; x=1784532006;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CCDChNA9Xvl37VAmNthtfzvgdA8yOF5Co/p3kft3pP4=;
 b=BGRhDXM1rGaN3jax/V0O/yZKe7pk4ykCuwYM/jgf7qQtWjf5dpK6f1HQNsHL+5E/Kc
 Mt3VD3UY9Xjum98ZPJAenmIAkchQ6lSMy1W0UAToGu1ivazHKqjxeayvhqq4KGaO0C9M
 hajPCNC1zbJCX+kM5/PFOrA74PZuqzQXRkheGm/SHKTlBKvfci3XBrdBvlRa/W9lGEfX
 5IyZ3t6zxTBNebztUk9xKdXq3rTnn2/Q00KRwUPdrVzXNvUVDY9AdSM1rN5Uf0Gu9sfQ
 iJFGV5XnTCvzz0CBIdmLqyq3MZm/dx/lOLTqFHP2n8YhzPMjyQ00P06yYwxoVGfgO/1N
 9n8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783927206; x=1784532006;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CCDChNA9Xvl37VAmNthtfzvgdA8yOF5Co/p3kft3pP4=;
 b=I/cqKe7m99xwBCqq4tSzUSuPlOUS6X7EwLg+5VqoMJOZbj7Zx7X1GxySnCR6oRc5BS
 69mYNkUUMkgzt54iUkbNaOnyDXe1VUQXXAVHTk5SpvyeR71MuzoHfR3hFuU6hHXivw6A
 32cIZToTG6RbiYENh1eg76QL1TOt1XlR6iFKMICqetcQNXU8iakKpaSIDN5G1IoqRUOv
 6uRdzEZVJi19d2osPk7JYvYsFFXlyUd1c4GnvhTvVL3Sx6axGj8+V7kLmAXWC91EhHX6
 Ji3a+FTve7wcGnrBMIcLJ6nY93UiK6RaJ7JcD81eTatJPcZmiXCqrmJQp5QktsYuSjeE
 v/7w==
X-Forwarded-Encrypted: i=1;
 AHgh+RpfTTybnPmJ+FC0xdNRvDVtNHGjQ2SKeMWV+omW9/IXXRzhg2b8RvENykJv5U/xUe2CuCFr7aRfEUk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz2wCpN8zNWan38t2+3C13WXEImCreFuwWlaKt0ba1E5iyUBprc
 dA2qbRxXlduqYfY6VVbj//JNMP/K5MTWhhPJUshw8wLqdRhKHsvbidDjtQamcnYMGVEpD8aiFk0
 tBb7BHAtmAGqS9dA3QMXO3DAl1sD+beiDP2a0KPt5FURRMX3z4PD9PSwDOah/qKIelhYqKSA=
X-Gm-Gg: AfdE7cnNHRSKrZuiqwXW8zDY8sceMWxzZpQEHoAN4G9W1nXQdav6KchPBO0pBWP+av6
 G9Rdm57Ni4QcLsXneE9PW+PPrmxeXDhR/JRpfFM4wA1A5IjdeIs3hPOUOWBGsjvjYrZn9HSzSNB
 Iz6VPeQAlIf458hAv16T6Z9HZvMpRjgbygwk6a7uuYNUBpY59UIbCS+gQ1ecSctn+BMgNedk+z5
 G5+I/20HgR/IKxkZLL3JuIJoGTUSmjdkLJ98As6ASJEcl0YqM/fKr8qafpmLJ77ozsVHH0kkNNH
 U5krfsZqF9KleGdIVWhnQnpShZQ5dRnxHEwq1SP6KWXGI6aYZujoYwWNg3BmV6HgTAXTeRDEbFd
 BDTSCmZ5mflRvRi9HwLWWGP2uwqJZx5VSJqRrRUrUX6A=
X-Received: by 2002:a17:90b:4c02:b0:37f:e326:6557 with SMTP id
 98e67ed59e1d1-38dc74c4b29mr7787326a91.4.1783927205733; 
 Mon, 13 Jul 2026 00:20:05 -0700 (PDT)
X-Received: by 2002:a17:90b:4c02:b0:37f:e326:6557 with SMTP id
 98e67ed59e1d1-38dc74c4b29mr7787302a91.4.1783927205229; 
 Mon, 13 Jul 2026 00:20:05 -0700 (PDT)
Received: from [10.217.219.169] ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38a583a16c2sm6071162a91.13.2026.07.13.00.20.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 00:20:04 -0700 (PDT)
Message-ID: <05af9d4f-ac6a-4a7d-bb7a-41fd50fc9935@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 12:50:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/7] Add documentation for Sahara protocol
To: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mhi@lists.linux.dev
References: <20260701-sahara_protocol_new_v2-v6-0-3a78362c4741@oss.qualcomm.com>
 <20260701-sahara_protocol_new_v2-v6-1-3a78362c4741@oss.qualcomm.com>
 <699644e7-2fc2-41b5-9e02-7f4dbc2aa3a7@infradead.org>
Content-Language: en-US
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
In-Reply-To: <699644e7-2fc2-41b5-9e02-7f4dbc2aa3a7@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA3NCBTYWx0ZWRfX2ISfHDMS5378
 hi+JW6HAjRwfOFTyD3v2qx9NF+vIvMvw5qTTemlIHF7OUksMysUTyEo45Tgwu/daMttUGEVoocY
 mRrca7dhtYD5VbqAW35/QyfoelmvVWM=
X-Proofpoint-ORIG-GUID: omO7RyGpHGPIs3pHRjUXEbM9lzMzyiGu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA3NCBTYWx0ZWRfX780rc/j05z3b
 Hrw+viAYFw2IbNaNUvUrIeciQsn5OHIM0AdiyT3c708LLw0nPcNNWW3F2M0DijhrIV+hoPgvo2T
 OdeLs7AxDPu4jkOB/Skw4j/a35gTTrQbMctDT9UkDT6/4juzc3HWoueciHA+UABd1FcwBBHQEBi
 He23oc4YLHRq+6Q0YKkNz9i1neWvW57iFjHVgVYcPxpr2mGbpk1OMp5v14V+iVH/LXMVdsnLxqs
 eJ/u7oddTAEvBUwdl5KromfOM7WzN37CsiQT9J/PZPG32vVUqdnq7nOC7XxYBEXQsgAoKXRXaMo
 az9J9/lzIoTs9y+NgXTV8Dw9JFByqdQG7e2OGk50KwscWVph0mc6MDAUfiYuN/EZB3oUuYSkSKY
 esrR3En05J9WjjPRigVGR/QqHWl+9Ce1NBFo7VCqaRWYxblelYNNnec//kWPaafpszBcFYzhXvE
 jiMtctkNgCa96b/HjUw==
X-Proofpoint-GUID: omO7RyGpHGPIs3pHRjUXEbM9lzMzyiGu
X-Authority-Analysis: v=2.4 cv=KM9qylFo c=1 sm=1 tr=0 ts=6a5491a6 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=s-wG5dvStlP9jbJ101gA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130074
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


On 7/8/2026 10:16 AM, Randy Dunlap wrote:
> On 7/1/26 3:37 AM, Kishore Batta wrote:
>> +The packet flow sequence is as follows :
>> +
>> +1. The target sends the hello packet to the host to initiate the protocol
>> +   with the mode set to image transfer pending.
>> +
>> +2. The host sends a hello response packet with a success status and sets the
>> +   mode to image transfer pending after it receives the hello packet and
>> +   validates the protocol version running on the target.
>> +
>> +3. After the target receives the hello response, it initiates the data
>> +   transfer by requesting the size of DDR training/calibration data.
>> +
>> +4. The host sends back the DDR training/calibration data to the target.
>> +
>> +5. The target decodes the training data and does not find valid DDR
>> +   calibration data, target sends END_IMAGE_TX to interrupt the transfer.
>> +
>> +6. The host sends DONE after receives END_IMAGE_TX.
>> +
>> +7. The target sends DONE_RESP with mode = IMAGE_TX_PENDING because it has
>> +   not received all images.
>> +
>> +8. The target executes DDR training process to generate valid DDR calibration
>> +   data and prepares to push back to host.
>> +
>> +9. The target initiates protocol by sending a hello packet with COMMAND_MODE
>> +   to the host.
>> +
>> +10. The host sends a hello response packet with a success status and sets the
>> +    mode to COMMAND_MODE.
>> +
>> +11. The target sends CMD_READY to the host.
>> +
>> +12. The host receives CMD_READY and starts to get command IDs to be executed.
>> +
>> +13. The target sends CMD_ID = 9 to push DDR calibration data to host.
>> +
>> +14. The host executes CMD_ID = 9 to get DDR calibration data from the target.
>> +
>> +15. The target sends RAW_DATA with the payload which contains DDR calibration
>> +    data to host.
>> +
>> +16. The host saves training data in the kernel buffer and exposes to userspace
>> +    via the sysfs entry. The host sends CMD_SWITCH_MODE with the mode set to
>> +    IMAGE_TX_PENDING to continue booting.
>> +
>> +17. After the target receives the CMD_SWITCH_MODE command, it sends HELLO to
>> +    the host with the mode set to IMAGE_TX_PENDING. The target and the host
>> +    repeat the packet flow for image transfer to get all booting-required
>> +    images.
>> +
>> +18. Upon successful transfer of all images, the target sends an END_IMAGE_TX
>> +    packet with a success status to the host.
>> +
>> +19. The host sends DONE after it receives END_IMAGE_TX.
>> +
>> +20. The target sends DONE_RESP with the mode set to IMAGE_TX_COMPLETE because
>> +    it has received all images. The process has been completed after the host
>> +    receives DONE_RESP with the mode set to IMAGE_TX_COMPLETE.
>> +
>> +Subsequent boot scenario with valid DDR calibration data
>> +--------------------------------------------------------
>> +
>> +The below firgure shows the subsequent boot scenario with valid DDR calibration
>> +data process being loaded from host to target.
>> +
>> +.. code-block:: text
>> +
>> +                        Host                       Target
>> +                          |          HELLO            |
>> +                          |   (mode = image transfer) |
>> +                          |<--------------------------|
>> +                          |                           |
>> +                          |         HELLO RESP        |
>> +                          |   (mode = image transfer) |
>> +                          |-------------------------->|
>> +                          |                           |
>> +                          |         READ_DATA         |
>> +                          |   (img ID:34, 0, offset,  |
>> +                          | size of DDR training data)|
>> +                          |<--------------------------|
>> +                          |                           |
>> +                          |         RAW_DATA          |
>> +                          |(size of DDR training data)|
>> +                          |-------------------------->|
>> +                          |                           |
>> +                          |                           |
>> +                          |       END_IMAGE_TX        |
>> +                          |<--------------------------|
>> +                          |                           |
>> +                          |                           |
>> +                          |          DONE             |
>> +                          |-------------------------->|
>> +                          |                           |
>> +                          |                           |
>> +                          |         DONE_RESP         |
>> +                          | (mode = IMAGE_TX_PENDING) |
>> +                          |<--------------------------|
>> +                          |                           |
>> +                          | Subsequent boot scenario  |
>> +                          | (valid calibration data)  |
>> +                          | DDR driver configures DDR |
>> +                          | using valid calibration   |
>> +                          | data                      |
>> +                          |                           |
>> +                          |                           |
>> +                          |          HELLO            |
>> +                          | (mode = IMAGE_TX_PENDING) |
>> +                          |<--------------------------|
>> +                          |                           |
>> +                          |         HELLO RESP        |
>> +                          | (mode = IMAGE_TX_PENDING) |
>> +                          |-------------------------->|
>> +                          |                           |
>> +                          | Boot/Load rest of the     |
>> +                          |    images....             |
>> +                          |                           |
>> +                          |       END_IMAGE_TX        |
>> +                          |<--------------------------|
>> +                          |                           |
>> +                          |                           |
>> +                          |          DONE             |
>> +                          |-------------------------->|
>> +                          |                           |
>> +                          |                           |
>> +                          |         DONE_RESP         |
>> +                          |(mode = IMAGE_TX_COMPLETE) |
>> +                          |<--------------------------|
>> +                          |                           |
>> +
>> +The packet flow is as follows :
>> +
> s/as follows :/as follows:/
> in 2 places.


ACK. I'll remove the extra space before the colon in both places in the 
next version.


>
>> +1. The target sends the hello packet to the host to initiate the protocol
>> +   with the mode set to image transfer pending.
