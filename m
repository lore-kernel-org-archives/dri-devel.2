Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D496CA6007
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 06:10:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48B5910E748;
	Thu,  8 Oct 2026 06:10:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dc4000Si";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cEjjVUK3";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38AA010E748
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 06:10:53 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6984BUl72895417
 for <dri-devel@lists.freedesktop.org>; Thu, 8 Oct 2026 06:10:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zjPDQNHaNCvR8SSMd/7nciKslGSKiJYIqMIIEsRJhtg=; b=Dc4000SimgsXN83I
 YITP31k18mKS8yvh2N0PkMiaGpEDdJ1SJkyWtWR8nd8dNsK08a+3gMNEiOkvWil+
 f4ghUYYHSZSMorWYDYWU8JFLvLgghY3cIyOyKguNn6rcz3Yn4Tjok5whiWbOjXgK
 H39+T5pc/gsps0BY71Vgfx8/2brr0pASt9UhMIwoE1GPgzE+RaYBSDajq2qrBMar
 jR7f8c46nQwVFeP773jhNDSL1xmLKrNZ4awcU+2uSweWbNuFELm494VU06PrkbIY
 nWzcf5O5T6yCObzS7izBeZhsxeUjQ/qExP79TwM8XwWujinvUluVIagcz+I2I3UU
 gbeEew==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h60sg8ydk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 06:10:52 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3a4b70941efso4143277a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 23:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791439852; x=1792044652;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zjPDQNHaNCvR8SSMd/7nciKslGSKiJYIqMIIEsRJhtg=;
 b=cEjjVUK3FAktb2Tp0UiTR+ll6HNKhm8a7aRSqJEfa57jfBAY1FO09jIMV+SL2SLKaz
 j5Wfk1N0noFnhkh7MfaS8jZPwifZn7IiWNvGazLzPgHK0rQ4DFT65ZhnrAwTUwUCTWTi
 2W828q4MERZnD09ogXWPSWDyJr0dYEyecTWd5Z0pmTsQIIhDOOIURuF3VkftbHemvmh0
 8jz1fbnNJfXFWdLpvMTQsp6+ZzB4abf59oGlUdgw5O7bMlDBCyIhP3D6WM9s4BRBB2jV
 Kidq/7EGmWGPjI+ErgMylxnYxqtV/wibWJ5XPy5I1z5hmxwrhQCCGacz+1RyYtk89fkp
 bsRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791439852; x=1792044652;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zjPDQNHaNCvR8SSMd/7nciKslGSKiJYIqMIIEsRJhtg=;
 b=g2fZXe0hhDCTTTe89zkQ4yAdLySKqr1R7pYcDrrvu9UxTvaNolPCmyLIiITwR75lc5
 OTHVlO9CNd21tGmfhE1xE6LWFGW5fSIsooMPZxpA/gp/z5hnc1Tofifi2rQWfESbPRbP
 VCgU75GHq2HqJnELvebLSb8GUdDFid3MtMZq9kawlzMcVaGbSl+jktE5bAIfv0E6vpjK
 MDTEZRb6MzNVrO9PBPvbQ+gTJ722uF5HfdZ5hHSCkraMXHFOBNbuWOM+nOl/oP745N2q
 9DCl00JitBsmTNRE8/MelOOVFO51WUWEI/1LM3WlgANkCGht+ewat3tJFasF/c5khtmL
 nTJQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwpf4MRQxCx0TOSSlpTrgcthkk0Tifm9YBd5IhhjSoL+HlxDNHwLq0/Zre1kcPeiMFeRl8NcRnw0D8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK3kOQxhH5ThXwKUT3ut6zM5SFlquHShCMaYToLbZ//nS8b5nuU
 khThuyyRLv6wXlBeo1QxTN9ffJZvvUyEksuUC4wZTcXv2nHHeKGPVyLKDIE+Si0UogmHW+u9vQ8
 48PB3jGlg+CILzlWm0xy9p9xkcimR3LT7t3LXIH0PzBdPWO9g+5Qfb9EVPpkeBJw466zGhkU74n
 yzQRk=
X-Gm-Gg: AYBFou2/jUzp91hjyUpMJkZc3U602R3QLnkts5Aix6nG293IjnasLqommNzENMKZxww
 PUGf/3wTLyWF9nrVhVCF7BmWyEcZ5A1nA5/zvD4wZdiA2cn1C4UHj0nkf0gTLr8azS/jfw6CkcT
 keHyX4hRHBY46uodSaNmI+bT3tSRP7jVEcfjTVoAhmH+uFAGIkQpczV7STCyWo87qHnclO96PnZ
 Q97zeNH20dDIYFVjUhiUO9mfPvZkPoz+SBw2BQ7A/fuB5BIPCUl/1Vpd/ybCMlqSbJFmNKJeCrE
 Vu6bQEL74I6AFDcEQ9JLjl54E0ykZzIM4gXic+rgTBRpoysJMP/nQIcGn0GCYgfVNFBNHAX5lo3
 ove2sLRAZsTCQautNh4cJVaPBGaczY88=
X-Received: by 2002:a17:90a:da84:b0:3a6:fec5:c179 with SMTP id
 98e67ed59e1d1-3a8a1b49b4fmr3492325a91.41.1791439851891; 
 Wed, 07 Oct 2026 23:10:51 -0700 (PDT)
X-Received: by 2002:a17:90a:da84:b0:3a6:fec5:c179 with SMTP id
 98e67ed59e1d1-3a8a1b49b4fmr3492280a91.41.1791439850602; 
 Wed, 07 Oct 2026 23:10:50 -0700 (PDT)
Received: from [10.217.219.169] ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3aa0cbc6e23sm2785258a91.14.2026.10.07.23.10.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 23:10:50 -0700 (PDT)
Message-ID: <f69b350a-63a6-4a66-afc7-8421ab86877b@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 11:40:45 +0530
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
X-Proofpoint-GUID: b-2Ig3xVL0hwpjxP04lOBDwXlGdEnA0b
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAyNCBTYWx0ZWRfX0xC44OEpnrsS
 +7eHSQNpU6LPj3e2p11v3TUqHzkl4nBpcdUEPzo4/Ifd+KmrprAFig4BMYhSb8vY+krGo6yMPRr
 NViVco6PKegKlqbGRFBeOD5LNl6JImQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAyNCBTYWx0ZWRfX2eK9Hz8B4tPQ
 ld95IqhBSHeHi9cNMfz5fHfwSgxn2W2MwKTRMbMq0i4XJ/7gD/OwBd3/8Ii1aLn3A8WwMynlIMt
 nZ/11uUhlHL6zxP9EdzGLsio+Tnk3KjhKgRlel0BleDunmZsyLnuTqWVbUb53bPmaLT+2+A54PD
 xvfSzXLPIJwL5eK/92KxVbWvMeCdui1VAUDgWhBshjxS1sy1YnJ+oqHAJhs7Tpi1xgfUKkCB/cw
 2GQHPYZoq+9vXgnE/UIkiymR28I/+NpgxGHUAXecqqLhWoaxVOPRXTkEDax0KZ695tYzzIp7VAW
 tiKNkLgFoCA4dAcqZ2cJnI0pUonDtfegRtR0x16x2cTzAGo1OpdXxOWcaO3ulUCnOmLd/OX3tgH
 PWIOL9eovens5QR6xvkb2/mTX42oijEJpay92Leo8qgzgyW22gAfQlV2XCHGJ47IQKMIg78I/5z
 wXfdi7RnUHqQNN5FuhA==
X-Authority-Analysis: v=2.4 cv=DfWCOftW c=1 sm=1 tr=0 ts=6ac733ec cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=QPSRtYdQVBWiSw6D44AA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: b-2Ig3xVL0hwpjxP04lOBDwXlGdEnA0b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_02,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 clxscore=1011
 priorityscore=1501 suspectscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080024
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
ACK. will correct in next version.
>> +1. The target sends the hello packet to the host to initiate the protocol
>> +   with the mode set to image transfer pending.
