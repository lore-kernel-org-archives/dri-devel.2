Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5ADCC61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 04:47:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA70310E387;
	Thu, 27 Aug 2026 04:47:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gf3UuhA4";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P9AatOkb";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C5CF10E387
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 04:47:49 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67R3J6b12632701
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 04:47:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uPlz28rXtMlg1Kp2h9H4NYbLW5TAfnVvvysMiDKahTA=; b=Gf3UuhA4ULhWE2wa
 2YJyp4xIk5U9wNTxxpSsPW8uyPyuR4Rod35TI1+avd20ATKdQrTPXMnS8FE44uFt
 ycxiIU3Xvc8FNGFOOOuAzHc+t5xsJVJ14mbEWse9Vm2u/uXC6wV9sF/T9HQ/tISp
 +oCU/kXLjxorO4VwIG6cg5K0v8StoVWMn5aGoqU/DKKNp/oLj/JMG+W6OBcDUdWN
 E1xp1z6hoqwHVCO5RHbxT1ZEeAZIcI0lLKRADA6LlDDnwQ3K+YTytGgFdbWezrm0
 eGwE/hLVM7WwyyJXhQYPRMBGg5VqwiLP9l5CC6YgTKHRDp3pDl2xOPHebRnuPDED
 sV8bVw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga03ab7k4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 04:47:47 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-39512608fb1so4087289a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 21:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787806067; x=1788410867;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=uPlz28rXtMlg1Kp2h9H4NYbLW5TAfnVvvysMiDKahTA=;
 b=P9AatOkbEOQiXu4UdIKaVCmSnf+TlS2Di/XkjzNtGMGPoc7BmKqJ5P6gPHCuxED7lQ
 XUqHYlVNQpH6Otcq5Rksa+oF2j0dgYsQJS0+hkf9DWbzPf5rfgL3aJNQbP5PoQrf/C6n
 XS+DI7rz89ujp56C8FknSHRayyAinn+gR3RtRNcwTGu/KuDLufOr8DrVLktkKbOnLAP2
 odNt7H0hVsyfiCQY4qYHVHnP9tZCpjG8aIB+adMehFMK0nOspeuZYgqXJTZ+nlsY37qR
 AY2V4vsi+4GVQ1nanZcfWUhHnpxC7j6ESbEWj/q9OyWrKlg2f++Vr4o+1CLhF9Yhomky
 PGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787806067; x=1788410867;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uPlz28rXtMlg1Kp2h9H4NYbLW5TAfnVvvysMiDKahTA=;
 b=TCTAHDUNScPTlzKu2JJAlhQxGNc8dHNA6OBnVbp1KF1W8CL9CF6Iz0HC2Wz9ftyQb1
 vrvcs9HLEwZVGvaXU1dp7Jl7I1YbfSI2Bt3Jagqzc8DcuUk2fTZrFPHhyrV885Z3WsBS
 8U6caPyZg3d4hbnHp7G/vXneGRtNrLCjMn02mY4DBTTqR/SjuhiaDy1ps0t85XsgHJpg
 5s2V+tk3tm6mBvkfGZm36eEJmIGqVDK6LHa/PJ8uGs4G20pddoq4x6AM4ncGwhboShIf
 /TnI826fH9sG7S7glmjRNNJylIW0f+Av+EjxgTfUIAbzZGa4XCrPPUkOE/gADU7KOj3E
 KUWg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqhCkHnHn8t3qD5yssis/emG6SeWwTYgDMSvv7FgOvYMZGG1igveJO3U52abXKxIX+L8vshkOfvNSY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lFDbwJedRgjka5ha3njsYhV9VDxagYxsBN4+8YltFsj+ozIYJG
 3Khugf9vNfetUpbxtncbjY2f0Pp5Ta7MOiJf8y51TzibDQEN47NqRN+5Ze/HqgYFU97HS7DBpKc
 truLLPgPQg6UK9VicxR/EsLMqfulB2vIP+QUDK0OrcJrY1AusmOAlLVlwimaNau2L0z/UgTs=
X-Gm-Gg: AR+sD10R5k2+dnx6s9rkXCUV6P92xJ+tUlTtXPHtLdUhn/RBRj6GMBelc4msl5AfGPF
 RSLg5PFkSgTkqCzLtxFs7y930YSpYqkQUBoI0XPn9lLMOrT23ozrW13cNNQVnOlWdLsev3VfE7K
 WMoUY/FaCs9lFJlSZ4PyWjUYmQ3wxwxf4zFPtwof4xfTc4ciDh314YZs2WfYyX4oNKx49phY/u8
 F3X+h1KCzFXVCd0biUbJk8r1SABPTek2W5MTdqbJfg0l7curtuPYVmeUA5TrbO9Cf9M9/6xdLVB
 Ym5Uy4WGrWFwv9Qr8cS9OSEz4lfQ9FWKGc8g7DPlFy/cw1OwNr0oZaDUg6Chq5ecs9qkH6R0Oui
 xyrBlVe0eq+p79EWz68zZDF1x+EUl5Q==
X-Received: by 2002:a17:90b:520f:b0:38f:26c7:165e with SMTP id
 98e67ed59e1d1-3966d5f8f84mr25950783a91.9.1787806067060; 
 Wed, 26 Aug 2026 21:47:47 -0700 (PDT)
X-Received: by 2002:a17:90b:520f:b0:38f:26c7:165e with SMTP id
 98e67ed59e1d1-3966d5f8f84mr25950680a91.9.1787806066524; 
 Wed, 26 Aug 2026 21:47:46 -0700 (PDT)
Received: from [10.219.57.226] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3283d886256sm15864903eec.16.2026.08.26.21.47.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 21:47:46 -0700 (PDT)
Message-ID: <3ed4cd48-d54f-4bc7-82c8-2c2143f8a211@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 10:17:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fastrpc: Reduce log level for DSP info and reserved
 memory messages
To: Jianping Li <jianping.li@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>, amahesh@qti.qualcomm.com,
 arnd@arndb.de, Greg KH <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260514062825.50172-1-jianping.li@oss.qualcomm.com>
 <dcf8d925-cf9e-47d8-ad79-0b5e641529ee@oss.qualcomm.com>
 <f78bf297-e676-48f9-b2e8-565a8758ac6e@oss.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <f78bf297-e676-48f9-b2e8-565a8758ac6e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: sBimvZx4yitgNrznLfXUFhOFSmiENHBh
X-Authority-Analysis: v=2.4 cv=VdLH+lp9 c=1 sm=1 tr=0 ts=6a8fc173 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=oM1uivv5cwll7WPlF90A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: sBimvZx4yitgNrznLfXUFhOFSmiENHBh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDAzNyBTYWx0ZWRfX/Lz5FtVNoVzH
 mxhGcEnKIkRdeSg01lC3cW5eTeEGFAjQqAOkBb3UPF5PGFeMJmS+Kk/IaxT0BxDPa9o85/gatNE
 cUO531fOSAGKGSuSt5HJ2UlDZTpXCp7E9pzCf9/EBjuKOWAuRUpETDbJpJsvZVqyTUH4hvmMpfs
 mctI/nG2SVrMCmAoWkTjMZOT75CL8nwMugXLPO/qphUPnxUSqmnBl6EyN0k8LRuZamjdm8Rdlt4
 rVoI/VufEIQ6vKokDtFdpcAAMfDpOTe1/XlH85cXfvLmJSXKvR4MwlJZxl805+MaiuK2cr7Ppay
 t2qMuLshQ+9Qb0Fm0TIcbnP+gf2Co5SuZSxMVAKIZhz8rvYRA19w95PQzJlRJjStYyMgQApK1gd
 oLDa4/2EEEnHXKCKCSWKUTBfII8S8ceK+JBGGHS85jg3gtLJC883PwpdFbUoR9RF7inSQ7J1OEy
 tHL0wj2pLOWziA+4nfA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDAzNyBTYWx0ZWRfX1wjuKhcooqW+
 o5Qw3u0RYpx8KWHEZHiXovOcZMlOV+qX3Za3dzenASwGwPktXu7g/QcB0SGISQJ7wGZSnH+i1cS
 bzvn9JRkttLPQfm3YXBXl+gOCQC2UI0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_02,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608270037
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

On 26-08-2026 14:11, Jianping Li wrote:
> 
> On 8/25/2026 2:47 PM, Ekansh Gupta wrote:
>> On 14-05-2026 11:58, Jianping Li wrote:
>>> On some platforms (e.g. QCS615 Talos), fastrpc may temporarily fail
>>> to retrieve DSP attributes during boot, resulting in repeated
>>> "Error: dsp information is incorrect" messages printed on the
>>> console.
>>>
>>> These messages are observed continuously during boot when metadata
>>> flashing is enabled as part of RC releases, causing unnecessary
>>> log noise.
>>>
>>> Similarly, the absence of reserved DMA memory is a valid
>>> configuration and does not represent an error condition.
>>>
>>> Since these scenarios are expected and do not indicate a failure,
>>> downgrade the log level from dev_err/dev_info to dev_dbg to avoid
>>> flooding the console.
>>>
>>> No functional change intended.
>> misc: fastrpc: >
> 
> ACK.
> 
>>> Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
>>> ---
>>>   drivers/misc/fastrpc.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>>> index 1080f9acf70a..05ec14c07fd0 100644
>>> --- a/drivers/misc/fastrpc.c
>>> +++ b/drivers/misc/fastrpc.c
>>> @@ -1802,7 +1802,7 @@ static int fastrpc_get_info_from_kernel(struct
>>> fastrpc_ioctl_capability *cap,
>>>           kfree(dsp_attributes);
>>>           return -EOPNOTSUPP;
>>>       } else if (err) {
>>> -        dev_err(&cctx->rpdev->dev, "Error: dsp information is
>>> incorrect err: %d\n", err);
>>> +        dev_dbg(&cctx->rpdev->dev, "Error: dsp information is
>>> incorrect err: %d\n", err);
>>>           kfree(dsp_attributes);
>>>           return err;
>>>       }
>>> @@ -2361,7 +2361,7 @@ static int fastrpc_rpmsg_probe(struct
>>> rpmsg_device *rpdev)
>>>       }
>>>         if (of_reserved_mem_device_init_by_idx(rdev, rdev->of_node, 0))
>>> -        dev_info(rdev, "no reserved DMA memory for FASTRPC\n");
>>> +        dev_dbg(rdev, "no reserved DMA memory for FASTRPC\n");
>>>         vmcount = of_property_read_variable_u32_array(rdev->of_node,
>>>                   "qcom,vmids", &vmids[0], 0, FASTRPC_MAX_VMIDS);
>> Can you also move this log[1] to debug level/rate-limit? This can cause
>> dmesg flooding in case all the session are already getting used by
>> processes. Some discussion around the same happened here[2].
>>
>> [1]
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/
>> tree/drivers/misc/fastrpc.c#n1786
>> [2] https://github.com/qualcomm/fastrpc/issues/383
> 
> Thanks for the pointer.
> 
> Agreed, that log can flood dmesg when the session pool is exhausted.
> However, unlike the two messages in this patch, "No session available"
> reflects a real failure — fastrpc_device_open() returns -EBUSY to
> userspace on that path. Lowering it all the way to dev_dbg would hide a
> genuine session-exhaustion condition from the default log, making such
> issues harder to diagnose in the field.
> 
> So I'd prefer dev_err_ratelimited() here: it caps the flooding while
> still surfacing the error. I'll fold this into the same series in v2.
sounds good to me, thanks!>
> Thanks,
> Jianping
> 
>>

