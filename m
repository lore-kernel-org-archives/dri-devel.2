Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5837AC5DF81
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 13:17:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8ADE010E200;
	Wed, 19 Aug 2026 13:17:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dTR/FC8r";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="URcqptCM";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 869F310E200
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 13:17:57 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JD0Em8693386
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 13:17:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DHcojprWwMclTR96W1Kcp7mAYQX7rnuvUTwbQrssUdg=; b=dTR/FC8rtsTF0qmw
 JN8frrhbf2bjGgTihPM4XakQB12zomE1VpKen0fOtSgG46aHEXyCWFOTuRZKS7Rs
 ErV6+SGTMSgG3cxaldLhHs3QGPdbiyn9rNpTe7JjLbSzMfqopRCRG987PZcfAFP3
 4RMg7P2JPaJrnnQ7ssoi1uBBUtLtsd+EBKmGH2JOp3iaFEp2xOORM+hyYlcjI+LN
 uVpR0jSaAvc19aIOHICGZ4lUAbji2Hanp3LjYjHTNKhVcpF/n17pggSk2jnYp/4E
 l5I7Lf5/9XTlCfsMkCZYDby3WDNf8pXxOLhPUtjSUGqljtRZ+UaznP0NSLi1KdVB
 2EiJDg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfmbbat-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 13:17:56 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38f97b3f853so1803620a91.3
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 06:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787145475; x=1787750275;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DHcojprWwMclTR96W1Kcp7mAYQX7rnuvUTwbQrssUdg=;
 b=URcqptCMyeV/xBzBQLh+hXwijkOU3LWOs5Qm6KlicTY2e8hIP9bV2pC+Rnv3Az7t7f
 MbaAQAi8skaWi8z2bl9fIqC5/4i85wXkIKovASG3dVdZhPpHmXiy/8JfTYWJ2P8UliVq
 ryUNtWPAzodykzIHb+dATDQ/aoH2m/8/3Cl6z7RedMJaDN180V/gpSpYrKSpkZmJ6oin
 wizBqP3oDCwpbIM33eY9+YLNTqIV7zLdnJVqqIGqytFWQX4OehqS/PTnxitJdI06CNkc
 /S/V5u4gwW2HbPl5BTmDgjMVrctwOt5+CMORWSfjWXIIcJEZHotSeKNGFGbXCUrzMQLZ
 Z+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787145475; x=1787750275;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DHcojprWwMclTR96W1Kcp7mAYQX7rnuvUTwbQrssUdg=;
 b=lQEAQ/5A2eyoyf4fU719eKh2xY362vDDeLHdoiO0I9XnAnVY5z3YA4t5dojyZxnaTO
 9cFGuMEZGCXRCRWhnoWHL+OhqonhXJMlcUoDnpSrF5pYOFcKySx3WexjEvghTAmmKLlr
 G9d79ifV59REyVtyJGmxCXaXxXFIdUEeiVartO1uSQRoqg29wdxfHAeFxhoO3GlfXGQs
 D5aMfsz3Q9TqJvxsl9FY1jMfLaSlorKZHWM4zB508Wmmw58X5xI18ndVFCLtiBmGDk8w
 iHJw5VZq6Kf9go8Fx35JRaIFFMlDcV4jwIIgMFTVcS6f77dAmSCVTGnMtbKl8EvP2zqj
 /7Rg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpF8kF84hOBxkKMedWaOGDjYh73PzfpMOn3KhWsAgJ1vVmVX0D2M9dliH96gPD8NZkoDNafgaEQ9Tg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ntamY3sovFBQWaDAkEi9x4J/ReZNPyiX1ohi2uSmitSU2W0I7r
 euwSDa+6bJ7SBmTW37dJ1IlpK/JEyCp/C+I9avbHRL7CsSZTfUVSokdHlpG+CV5gRxm+269TVBr
 selz6Qk7fwPWMDvpFP4lzUjG29btJN4HB36C0TrMQwOVNFiC9bcU/DjYPNl5aFFmzwPbIAtY=
X-Gm-Gg: AR+sD12gcCqwO9SMJcqQEXQCIj9gNQZ3YrKmOwH3BpJmWYjNQ+0dOoUr5hVJPM2mzP3
 py5Dx3b7+T++UPp7nkCSqY2LM1iWpiTG0pZzJmHcPtd5o13pGEQcjiL4ysO5IYZLUm63vGcRLcS
 T7dhctwt2+g8MdOS6+ndBcNCu/F3yZ9U6Qg1V0X4l/7K6vWqKcRg9i+EL4i3NOFJlTNQIImn+rN
 x6ofxEu6dyJNadimtpZ8dNliu3Mo3QXClc4Uq9pFXuLr4NwkqIgP6kCOov/IpvClMBiw6vEOX8z
 LwJHwttzI3Hz+FLovPNvo3wLgj9Q4YO8b1P9J08XYzSNUPh0OSvvhc/Sj7/DAmyagHYRHEbm32c
 PyzGKZOdFWfDWaiplNWER1rN1kJ6lxA==
X-Received: by 2002:a17:90b:57cc:b0:381:a766:efcc with SMTP id
 98e67ed59e1d1-395810e93a0mr8967627a91.14.1787145475182; 
 Wed, 19 Aug 2026 06:17:55 -0700 (PDT)
X-Received: by 2002:a17:90b:57cc:b0:381:a766:efcc with SMTP id
 98e67ed59e1d1-395810e93a0mr8967481a91.14.1787145474636; 
 Wed, 19 Aug 2026 06:17:54 -0700 (PDT)
Received: from [10.219.56.166] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3957f7c962csm2756751a91.0.2026.08.19.06.17.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 06:17:54 -0700 (PDT)
Message-ID: <3476b5c3-7983-4994-a901-3d7d8bd75255@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 18:47:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/15] accel/qda: Add initial QDA DRM accelerator driver
To: Krzysztof Kozlowski <krzk@kernel.org>, Oded Gabbay <ogabbay@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 srinivas.kandagatla@oss.qualcomm.com,
 dmitry.baryshkov@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
 iommu@lists.linux.dev, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <20260817-qda-v2-v2-3-69a02e9090d4@oss.qualcomm.com>
 <81708487-89ce-4cd5-b39a-2989bdce6088@kernel.org>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <81708487-89ce-4cd5-b39a-2989bdce6088@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: RojllCyiLwJVusOHfBx2Ni-dzOWeYxRn
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEwMyBTYWx0ZWRfX4Hn8X8kZZI9C
 FU5XFrlbGAQ81VvsNJkAZT9CDmpPCO/Wf0mj7TZg5N6uPvEzlK6meg3xxhuYr2UYQ7JmAEjPGv2
 AI6+aRC7WVgpVaZknEAU67afcLHMvkE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEwMyBTYWx0ZWRfX6EiADgvayW55
 hPuN/93GyVlq7D1C7gFlme7zltQC6P9eUVrCY3jHDzAL21FU0lmdijezSspyVU7/QsV7SluyOXt
 DcyM+4MjGWb44SGrr84iHR/U80E7vgYz32Shh+vC4Kny7Wow0QUZv+G1QBWCU1vlRSPYRrbnSwv
 Ug30UuLscniPUeGF3LCcGdwSb+VCTiOIvYM/l9V7M+UWRU93m8ObOBDXwxeihMX/4LJCqIiQvpd
 1LCE/5XOgeQjM0ZnVLqq1SBUI4xfsH/F8bDpvfw27sFYheOwarwLYreApcrU/vQKtAxYpsTOqB8
 MWd13G7sBP25uMSQJs60HaolLB/r3LmBrevmpcLa+FL6yVVPXS6lw4cG/bhFjiXre0pg9mqmwwX
 XIwxx0YMQL6Qq41pchqcA/M8Tsob/7EGgHZY9S/3ICnYyiVvNczeFMn+6rVQNxQLP5RaORkv7q6
 nw9RiI5IXx/meymbjCA==
X-Authority-Analysis: v=2.4 cv=aNrAb79m c=1 sm=1 tr=0 ts=6a85ad04 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=D19gQVrFAAAA:8 a=EUspDBNiAAAA:8 a=fiCeWNywFvmbcpy1l9YA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=W4TVW4IDbPiebHqcZpNg:22
X-Proofpoint-GUID: RojllCyiLwJVusOHfBx2Ni-dzOWeYxRn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190103
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

On 19-08-2026 00:40, Krzysztof Kozlowski wrote:
> On 17/08/2026 06:47, Ekansh Gupta wrote:
>> Add the skeleton of the Qualcomm DSP Accelerator (QDA) driver, a DRM
>> accel driver for the Hexagon DSPs found on Qualcomm SoCs.
>>
>> This patch registers a DRM accel device, exposing a /dev/accel/accelN
>> character device node, and binds it to the RPMsg channel used to reach
>> the DSP. Buffer management, IOMMU context banks and the FastRPC
>> protocol are added by later patches in this series.
>>
>> qda_drv.c / qda_drv.h define the drm_driver ops table, the per-file
>> private state (qda_file_priv) and the main device structure (qda_dev),
>> which embeds drm_device so that it can be recovered with container_of().
>>
>> qda_rpmsg.c binds to the "qcom,fastrpc" compatible via
>> module_rpmsg_driver(), reads the DSP domain name from the "label"
>> device-tree property, and registers the DRM device.
>>
>> Assisted-by: Claude:claude-sonnet-5
>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>> ---
>> Changes in v2:
>> - Use module_rpmsg_driver() and drop the qda_rpmsg_register()/
>>   _unregister() wrappers, module_init()/module_exit() and
>>   qda_rpmsg.h entirely (Dmitry Baryshkov)
>> - Read the "label" property directly into qdev->dsp_name (Dmitry Baryshkov)
>> - Drop the probe/remove/init log messages (Dmitry Baryshkov)
>> - Return the result of qda_register_device() directly (Dmitry Baryshkov)
>> - Clarify the Kconfig help text (Dmitry Baryshkov)
>> ---
>>  drivers/accel/Kconfig         |  1 +
>>  drivers/accel/Makefile        |  1 +
>>  drivers/accel/qda/Kconfig     | 30 ++++++++++++++++
>>  drivers/accel/qda/Makefile    | 10 ++++++
>>  drivers/accel/qda/qda_drv.c   | 71 ++++++++++++++++++++++++++++++++++++++
>>  drivers/accel/qda/qda_drv.h   | 61 +++++++++++++++++++++++++++++++++
>>  drivers/accel/qda/qda_rpmsg.c | 79 +++++++++++++++++++++++++++++++++++++++++++
>>  7 files changed, 253 insertions(+)
>>
>> diff --git a/drivers/accel/Kconfig b/drivers/accel/Kconfig
>> index bdf48ccafcf2..74ac0f71bc9d 100644
>> --- a/drivers/accel/Kconfig
>> +++ b/drivers/accel/Kconfig
>> @@ -29,6 +29,7 @@ source "drivers/accel/ethosu/Kconfig"
>>  source "drivers/accel/habanalabs/Kconfig"
>>  source "drivers/accel/ivpu/Kconfig"
>>  source "drivers/accel/qaic/Kconfig"
>> +source "drivers/accel/qda/Kconfig"
>>  source "drivers/accel/rocket/Kconfig"
>>  
>>  endif
>> diff --git a/drivers/accel/Makefile b/drivers/accel/Makefile
>> index 1d3a7251b950..58c08dd5f389 100644
>> --- a/drivers/accel/Makefile
>> +++ b/drivers/accel/Makefile
>> @@ -5,4 +5,5 @@ obj-$(CONFIG_DRM_ACCEL_ARM_ETHOSU)	+= ethosu/
>>  obj-$(CONFIG_DRM_ACCEL_HABANALABS)	+= habanalabs/
>>  obj-$(CONFIG_DRM_ACCEL_IVPU)		+= ivpu/
>>  obj-$(CONFIG_DRM_ACCEL_QAIC)		+= qaic/
>> +obj-$(CONFIG_DRM_ACCEL_QDA)		+= qda/
>>  obj-$(CONFIG_DRM_ACCEL_ROCKET)		+= rocket/
>> \ No newline at end of file
> 
> You have trivial patch errors.
newline problem was already there, wasn't introduced as part of this
patch series, so I wasn't sure to fix it here. I can fix this in v3.>
> ...
> 
>> +}
>> +
>> +static const struct of_device_id qda_rpmsg_id_table[] = {
>> +	{ .compatible = "qcom,fastrpc" },
>> +	{},
> 
> Device node with this compatible is already populated, so this looks
> simply wrong or you are adding a duplicated driver.
> 
> That's a no-go, you are supposed to work with existing drivers and grow
> them.
I'll bring the discussion again here, there was a discussion to move the
driver to accel subsystem if we want to support new features/uAPI
changes. Please read [1],[2] threads. The intention is to replace
fastrpc driver with QDA eventually.

Do you suggest adding a different compatible, say "qcom,qda" for this
driver?

Let me know if you have a better suggestion to proceed here.

[1] https://lkml.org/lkml/2024/6/24/479
[2] https://lkml.org/lkml/2024/6/21/1252>
> 
> Best regards,
> Krzysztof

