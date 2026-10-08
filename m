Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2403CA6007
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 06:12:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25EC010FC35;
	Thu,  8 Oct 2026 06:12:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="D1eCv3Pz";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AvNmAoEf";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C624810FC35
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 06:12:22 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6984BitZ1776068
 for <dri-devel@lists.freedesktop.org>; Thu, 8 Oct 2026 06:12:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wT8kLCkAimLo6XtCMpVmTv8XBbuyjKCgfUPaBP9qFk0=; b=D1eCv3Pz/KiR4aJz
 ljFOxnwpD8ujjVEFmRhkMJJOVDMH2uesmmXaawHFNW1/QHCxRkiZbUfEku2jWqIL
 HYNt9ls1BrNYbV3iTREvMKmVnu/mZcZBvWze0zeNH8aVCoA9F4DZPgVWmqY+p1Lh
 6O9zF1Rpg+ivD0qZUCRznZZ0XReBLHENbOW5qQLKUz4Ezn920uPvIGxnTQaVRgFM
 ApM6DoUg0nozIkENTWxeH60GnNRoDenO/vn8Z9wyHIecSAlBYthJlZtXmakNAEPE
 WFJgZLf2woO+yvTdV9qEdCzy3mwqmkkRSd57KVmk6lKyMlDFyYdIkP3LLE3Xq5WV
 c9nvrQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe39bq7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 06:12:21 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3a82c7e8fcfso3575364a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 23:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791439941; x=1792044741;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wT8kLCkAimLo6XtCMpVmTv8XBbuyjKCgfUPaBP9qFk0=;
 b=AvNmAoEfagJkEDzJQLb/kyQJMLb70XOSEIROx+l7gppnyx8qdW5fYlS+nt2N+NmvbW
 ra4yD7PrGdjojhXwpcQe8yFxvinGOfa+DkgaG9FQQ4S2hEdCoJt2lzc8qzKqgMZCXl4o
 t+HvuuIAejR6jXTwF4afdnhcpqrVZooQWksUfhuLVDld1Soonl7QogTcjYnE/LDxvq+J
 IimuKXMvWcVIcKWH7Acw+iCBLxzQ0bzS1GU9+tD838jMgujobzUJNVWhzBPpOm8ZWf1U
 b+5ZOTmOf1NFdwvaC7P9w478hQPbxX/Oub8rsfPjMOWgJq83iNIVOyZV4P+31QOHPcSe
 vCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791439941; x=1792044741;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wT8kLCkAimLo6XtCMpVmTv8XBbuyjKCgfUPaBP9qFk0=;
 b=k7bnaBFEf9W8KeKAVcoFbL/woBB5pWo7WCoLnAumdoBsouV2GuDY3R7AmYxooOyZkM
 JP1mL3f0JgNpFDmzjcYZ8soMovE0qNK953n+KSFeJsZkVYJuGQHSrqDbFhYPqIvFKbjQ
 YRnYTes8ovir8gqapuGqWi+d/mS4TorgPHsuGfaF7qPLvLV+VoJpOdjPaKrr2D0vauF+
 2ii7WGPo1varl9sUAjMktQ8DUdCmb/h0rBhH6GTPUyw/YLsm7QJvqDkxunnKSWyaxiK8
 CcuvtXIJsj7wzZuCffhnsxMyvQfdM5PTvPsDIux6+s36Yf5rR0NQ9U/f68GYgrKn4XKo
 didA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxHkqPu8JtYB6KQeePtum7f8VVgkgXSelF4Hn2voU4s21vsGVXPUQuAm06MxFTYHCVJlF+9H/eEBv4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJwLuPgnPjUmqKQ+1+WR58wOUCM9pPF0YgAdh7u3WH9zQ2qluZM
 +o4QmYYC7u03+NeTNNXo0an4qVw1vzUiEzVbQBa8gtmtxlo7gXSaA56os4hC/z9w1BG+/rNAR7D
 87hiTHCBhSHTYB/W44uMmeOe9NOMmRZrymr+NLYs406yk75SZKyquSC+9sOVKS9ee/YQ/t1M=
X-Gm-Gg: AYBFou3fPEzhh1g35SjUjXWR674T3pFGBJqhHrXYn5Y7GkzCRhH/dt96Qpc7ktnG7Ab
 7Kup4+y+82VxsiIixQz41lR0xq6VJPLPfccHX14Zb2I9vZd5+UqqXHonUqKz1yJP45UWxFU7o5D
 Sw7d3djeJM+WyGKwodRhxTN90GBeAu6MTMbgHhiT4jcMaMFm99qqUCmAg6f1pO+b2c/dtlfew+5
 zpA7HQYwuxbCZHEZ2aEf7tpuwOgcUghLIY8s66qV3n59yD0UeWR7CHpTbgQMH+Af7WbqKUbCUPo
 kufslGQfDTO9foqHMRD4TLDAEruqC0cXhqKcuijGMhMoOOH9NMeaLQ0/sOEQ0TMF7QV+TOsI8OO
 3UoR2LmYOYm+84RvxBeKkDuBgHPuxfoA=
X-Received: by 2002:a17:90b:534c:b0:3a0:b312:1fbe with SMTP id
 98e67ed59e1d1-3a8a1964d47mr3525630a91.23.1791439941076; 
 Wed, 07 Oct 2026 23:12:21 -0700 (PDT)
X-Received: by 2002:a17:90b:534c:b0:3a0:b312:1fbe with SMTP id
 98e67ed59e1d1-3a8a1964d47mr3525609a91.23.1791439940636; 
 Wed, 07 Oct 2026 23:12:20 -0700 (PDT)
Received: from [10.217.219.169] ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a9f1c17b63sm3393121a91.12.2026.10.07.23.12.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 23:12:20 -0700 (PDT)
Message-ID: <7127ab66-7413-4f54-837d-b773b75026e9@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 11:42:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/7] bus: mhi: Expose DDR training data via controller
 sysfs
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, mhi@lists.linux.dev
References: <20260701-sahara_protocol_new_v2-v6-0-3a78362c4741@oss.qualcomm.com>
 <20260701-sahara_protocol_new_v2-v6-7-3a78362c4741@oss.qualcomm.com>
 <n35ouuyvy25ocbfaedksryoz5d53cylk2pcsxz7f25us444gh7@7ybkifq3fbae>
 <fb34c262-5c91-4beb-a792-f00da203d1b6@oss.qualcomm.com>
 <wkuia7mvgcwtemuib4abzjffrceekzheuyksqdzrykusxzvgxe@77ggixknltoc>
Content-Language: en-US
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
In-Reply-To: <wkuia7mvgcwtemuib4abzjffrceekzheuyksqdzrykusxzvgxe@77ggixknltoc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=J4s/fwnS c=1 sm=1 tr=0 ts=6ac73446 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=J_FEIbamH7nEwTU2i4QA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAyNCBTYWx0ZWRfXx/yT6oYpigic
 BSzl8obipiDYXjEbGFSWT6z2vid/QVGQSIobdAYs4SrjE5N01H5VzmnYpkf7G4uikYuw+oSylWt
 6ywYIOM2UdOIfKamWR130jRMjZ0yBK4=
X-Proofpoint-GUID: rc-smVQ9u3IoTHuJ_gRF509sNjMiNBdb
X-Proofpoint-ORIG-GUID: rc-smVQ9u3IoTHuJ_gRF509sNjMiNBdb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAyNCBTYWx0ZWRfXzPhzhIrcpxVm
 EwpxlxDGG2IF5eof097FbXMD1VX1/F4Qkkgx0Y1qyfk1x5LebLc3ifVohux5cFv926n04wP2tXg
 oXU/3ZeqwfLYI9+KyZ+dgjb9byVIMzxsldiMlVV1TX2AZtP0evb+bia6pORMgt8f7bNVrmoNwzB
 fXVURnRgx9SN4E+h1DumeFvkhmY1Sox70byYM2SuNKsDVuoT0PgJM6RGRvSD7DX28fG2n3lT6T3
 WQPM8blCgkmGu1y7yZUJVjYIjp4avXjGegrlo2fge9PN7DxOv+gMc7S5jeAiAM6e7KYhPiMUKgz
 eCr0f2xnLVvV1nHbEL9SDayKn5SrZIT8rC0qCVWNGaN6mzXin3YHLzoYIE7Xwao+YpzCSn47RHd
 c9ealUx8sFx7KedyFuFjxdBIZePmFlAKF2zNIe/q9SYhVc86Zo7v+/r3SvArRstdQcFieM19e7H
 O8olxsaNRq6ZhWWac9A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_02,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 clxscore=1011 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0
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


On 7/13/2026 10:38 PM, Manivannan Sadhasivam wrote:
> On Mon, Jul 13, 2026 at 01:00:27PM +0530, Kishore Batta wrote:
>> On 7/9/2026 12:27 PM, Manivannan Sadhasivam wrote:
>>> On Wed, Jul 01, 2026 at 04:07:41PM +0530, Kishore Batta wrote:
>>>> DDR training data captured during Sahara command mode needs to be
>>>> accessible to userspace so it can be persisted and reused on subsequent
>>>> boots. Currently, the training data is stored internally in the driver
>>>> but has no external visibility once the Sahara channel is torn down.
>>>>
>>>> Expose the captured DDR training data via a read-only binary sysfs
>>>> attribute on the MHI controller device:
>>>>
>>>> /sys/bus/mhi/devices/<mhi_cntrl>/ddr_training_data
>>>>
>>>> The sysfs read callback serves data directly from controller scoped storage
>>>> and protects access with the controller training data lock. The attribute
>>>> lifetime is tied to the controller device via devres, allowing the data to
>>>> remain readable after Sahara channel teardown and ensuring automatic
>>>> cleanup when controller device is removed.
>>>>
>>> If this training data is RO, then what is the use of exposing it to userspace?
>>>
>>> - Mani
>> The userspace component will read this from sysfs and save it to a file
>> named mdmddr_0x<serial_no>.mbn.
>>
> You need to mention the exact file name for the read data.
>
> - Mani
The exact filename used by userspace is mdmddr0x<serial_no>.mbn. For 
example, for a device with serial number 0x12345678, userspace saves the 
data as mdmddr_0x12345678.mbn. The file is stored in the corresponding 
Sahara firmware directory. On the next boot, the driver first requests 
this serial number specific file and falls back to the default DDR 
training image if it is unavailable.
