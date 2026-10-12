Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A1DCA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 18:12:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C716E10E00E;
	Mon, 12 Oct 2026 18:12:48 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A03C410E00E
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 18:12:37 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CHugPW2722710
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 18:12:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 218J+j7wE8PIduGE71lICGhFvQKcwEnxX938pBY/Ais=; b=YNSM7lB4JH/yNGny
 CkiKnKe2Q/7w9vBoMyHJg/uLWTnONhHn5J+/1bsPsEAs9AUyIxXShnRefFp3lNN7
 5hqZyXp2gMfq9tjuyE4TlUWUQ2IW36U8gheCFvniVwXnJy8RETjpu0u0qjqWUgGI
 7iZCLRvwUy6/ZpMWCRXTEj27D6TzlX9+IdQh4vawLxl+t8yNoEDxfGJ6xvpRLVcR
 Ao/FfP1gSDZgFLvTgU9lCXKYwsPWi32FZmAd9aBiB1Sam2FeWMfCtsKkyphgXDSI
 IN1E8sbVGedTsfCtjh7QWbRGXiG03Oc5S/YOd6iBR3krdFZcDZIV7mNW+5wlBPPr
 wxa4/A==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h940w064e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 18:12:36 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-351788121cfso15087eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 11:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791828755; x=1792433555;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=218J+j7wE8PIduGE71lICGhFvQKcwEnxX938pBY/Ais=;
 b=Etf+etrg0UcHGSGLF36yAQsdUccYiJknqY17bcVhbF6ruLZw5EnwtfjN+eJy28cnbT
 bXhzmRIH+B5vZVigjdoxNe+A95iWQr5mrBlp1an1H8PpMTVzc/pfBTL5Ex5OdCwAkLZE
 0/NUHSGkWg2qovXp13GMTpYsPRE/aJKOe62RkFmwtA3i6ODucE4kgO8qaiox+4K0scWZ
 I4jCD4Nj52Ie5eyC+hBwGeU5fV1vLWvA2Q4trtqno6fZSd1C85pwdOMo73ZCyP4FZKo9
 Dvk0j+GfWnaQzFTvYsPz+Y1Haod4/Rjj5nOR//dk/OsZtmRvHNsxfLOcL174bWiIcr8N
 cZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791828755; x=1792433555;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=218J+j7wE8PIduGE71lICGhFvQKcwEnxX938pBY/Ais=;
 b=WPIeCiIsa/cHRtrji72YFvkVygREkS5B2L736+HWYc54S5UIdcC64HU0S3NjCSNUSs
 kUg4G6LlYpvQH65fdZ6Sc1k0vNyjcpWHRF+wLgRJW1O5FVaWsmkhHcqFKqWw479Pe0Wb
 aBkc54g9uJlwW6Ra/i4SUqOzsBEHw6TH2WVlTgkxuPLIvc9RY/O70lZIrK21ywYvTj6w
 gETiUDVfYt3Q23GV0evXj8+v2Jo84ZHOaTlxc8gU5tV/K+5eH7SpV9LTArTvOFxaq5CZ
 If7h06J8z4hUNFIbuB08bfmEc/DckhbbYgoS2XnCOe+26duKao72ZDDMGgefEKgnRoQH
 bXdg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwgTkoD7MTzzeiKyE5axTFWETorECwFBwWbgWaM7gBWMR5Yx4ldVkWqBsVMfSoNzxZtJ6ba20IMeP0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLaX4ghbhQ6w1FN5gbY14CCqFZLEUCL5Chf3g128fiuV5Z6Zfrx
 vVjco3uEtxyBGR3Yf4CqrK7+uotcEw+NQsBrAU35Sq1WGQ3iCWjwvQz9cKTZtcSzwaJRvOIevyy
 QIBIlhuuZ+0uN8gdcxwwxYY1vXWHGUzvWYKzuwUOhprtabdQNW8Or+jjMJKWHQAfoQ8pDlpRkRE
 65cTQ=
X-Gm-Gg: AYBFou1HYcp+0Npmou6q4AoyM7CJbaiY/ylPp6pKZzAznCEyuy96iNPrn0u9qmFesIl
 /vr1Qz6bI/hWqmes1LCFiM6XfpAsJohHhHaabKahMGoLHXILWisrLdYV/bI3es71caI4HsNBJMZ
 dnnJsvEyKB9CBZgShR1UiC/uhVeVFS6ZolO/3V6J/QlFpvL91BUroKbWjSUdojx1BktT2PQWsxH
 E9W2ZD//zyggrLNPBQ+vBTL0hFIVwvhtqbABCA40e2hqW97YilmWOvaZz14F6fuMGCbLEoiqpJd
 CdiQHPWwHBSn/jqSSaCPmeyhEOOkfVu2CY1/K8CL19QVv31DpBOc5r+AvdjQciy3/hNmyo3smQv
 vdht4SjC3LCvUk4dMT7wkoOKojbku4Iw=
X-Received: by 2002:a05:7300:6822:b0:35b:bb89:231e with SMTP id
 5a478bee46e88-35bbb892336mr1842433eec.29.1791828755004; 
 Mon, 12 Oct 2026 11:12:35 -0700 (PDT)
X-Received: by 2002:a05:7300:6822:b0:35b:bb89:231e with SMTP id
 5a478bee46e88-35bbb892336mr1842396eec.29.1791828754450; 
 Mon, 12 Oct 2026 11:12:34 -0700 (PDT)
Received: from [192.168.0.215] ([49.205.115.55])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537c841648sm40504487eec.3.2026.10.12.11.12.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2026 11:12:34 -0700 (PDT)
Message-ID: <1997618b-1350-4b67-9168-794be3e40683@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 23:42:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/7] Qualcomm Sahara protocol enhancements
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, mhi@lists.linux.dev
References: <20261008-sahara_protocol_new_v2-v7-0-90d278bd7414@oss.qualcomm.com>
 <asu5x72z9-p0U8G0@debian>
Content-Language: en-US
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
In-Reply-To: <asu5x72z9-p0U8G0@debian>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: HRv11HTXy6vm4BXaZFwrGJv6ex7H7nUI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA3MiBTYWx0ZWRfX7DZ/qHBS8Txu
 qFBHMhE5klqlSiInhaUOAjWNIUV7tKsg6mKGi9wVHxGJ8QfNSkjABx7X+m/xqdQi/XEBSGe8Ebp
 o9k5VWJpLdtSvtsfykEEhCJMmK4E3gEg13M78hzLbzOA5mg3KFgdP5qtfEPYw8igccDfu1PunNh
 a7uTIVSmkeQBhDd9QhCoK6BPcOMbFqIK0qwefH4GHE4ERAH9OICOSN1Fjz3g02o2/jMHN1a8ph0
 lkjK4tq5KZIg6ozI7QJ7C9AVVnFmA3iBue9uXA9aztPiR4JapnMqspYCMo+81j9dbZ+zzHQPbxJ
 uN99pirxbqSheisqVR3yBWsb9Pz0eaa8434tuJeYBFuwcRYJV58emfY+fQcoh+e/ydb00zes9a0
 +n7KRPSt/vclKIRBDgUqHEXVgAi818RaFUpnWd1CcuzMyHjaMLVRbCuvvZ0bK2+RlbQa2jmJ+Sm
 EXXc2t104CecWw+rYiQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA3MiBTYWx0ZWRfX83BpEVdDY8gm
 ViCrY6KBuwKhPYT59Ek9f0v0vUoPHJvWjF490QtZyPVTTrQ8/uyMwiJY09vZsXBEgV8l2br0EaA
 mrwiDE5FhOiCR0W87Q1byKwd993LaXI=
X-Authority-Analysis: v=2.4 cv=ftZJ914f c=1 sm=1 tr=0 ts=6acd2314 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=rMnsrh5NOwviKPWndHUBiA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=YvxDvPKW4DV_tE5yJ3MA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: HRv11HTXy6vm4BXaZFwrGJv6ex7H7nUI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120072
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


On 10/11/2026 10:03 PM, Manivannan Sadhasivam wrote:
> On Thu, Oct 08, 2026 at 11:53:44AM +0530, Kishore Batta wrote:
>> Hi All,
>>
>> This series reworks the Sahara protocol driver to make it reusable for
>> multiple MHI based devices and adds support for capturing, restoring and
>> exposing DDR training data using the Sahara command mode.
>>
>> The Sahara protocol is transported over the MHI bus and is used by multiple
>> flashless devices to transfer firmware images, retrieve memory dumps and
>> exchange command mode data during early boot. However, the current
>> implementation lives under the QAIC accelerator driver and contains
>> device-specific assumptions that limit reuse.
>>
>> Some MHI devices (for example, QDU100) expose the sahara protocol directly
>> on a "SAHARA" MHI channel and rely on command mode to exchange DDR training
>> data with the host. The existing driver does not bind to such devices and
>> ignores Sahara command mode packets, causing training data to be dropped.
>>
>> This series addresses these issues by relocating the Sahara driver to the
>> MHI subsystem, centralizing device specific configuration and adding command
>> mode handling for DDR training data.
>>
>> Overview of the changes in this series -
>> 1. Move Sahara under the MHI subsystem:
>>     a. Relocate the sahara protocol driver from QAIC accelerator tree to
>>        drivers/bus/mhi/host/clients directory.
>>     b. Register Sahara as an independent MHI protocol driver.
>>
>> 2. Generalize device matching and configuration
>>     a. Allow the driver to bind to devices exposing the protocol on a
>>        SAHARA MHI channel.
>>     b. Centralize firmware image table selection at probe time using a variant
>>        table, instead of scattered conditionals.
>>     c. Preserve existing behavior on AIC devices.
>>
>> 3. Add QDU100 firmware image table support
>>     a. Add a QDU100 image table and select it based on the matched MHI channel.
>>     b. No separate client driver or registration mechanism is required.
>>
>> 4. Add Sahara command mode support for DDR training.
>>     a. Handle command mode packets(CMD_READY, EXECUTE, EXECUTE_DATA).
>>     b. Query supported commands and retrieve DDR training data from the device.
>>     c. Allocate receive buffers based on the reported payload size and copy
>>        raw data from the MHI DL.
>>     d. Store training data in controller-scoped memory using devres so it
>>        survives sahara channel teardown.
>>
>> 5. Expose DDR training data to userspace
>>     a. Add a read-only binary sysfs attribute under the MHI controller device.
>>     b. The attribute reads directly from controller-scoped storage and remains
>>        available after the Sahara channel device is removed.
>>     c. Cleanup is handled automatically via device-managed resources.
>>
>> 6. Document the sysfs ABI
>>     a. Add ABI documentation describing the DDR training data sysfs node.
>>
>> Signed-off-by: Kishore Batta <kishore.batta@oss.qualcomm.com>
> Series fails to apply to mhi-next branch. Please rebase and resend. Since I'm
> about to send the PR for v7.4, this will miss the upcoming cycle. But I can
> queue it once v7.4-rc1 is released.
>
> - Mani


Sure Mani. I'll rebase the series onto the current mhi-next branch and 
resend it in v8 version.


