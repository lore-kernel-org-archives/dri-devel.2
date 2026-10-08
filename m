Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E67CA6002
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 06:11:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F1F910E755;
	Thu,  8 Oct 2026 06:11:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gi3C87CH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MrujUy0k";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 693E310E755
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 06:11:10 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6984BPUt2774892
 for <dri-devel@lists.freedesktop.org>; Thu, 8 Oct 2026 06:11:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /RXALBiy38fnkP6rflCi5//J78+eNuFAEPXlah/LmVw=; b=gi3C87CH0Vzug2YX
 NUXOqQhFV1OekDb1gy4vk7kB/c8z5Z0KVTPx/DIPpDjp38qlqNDoqPyDU/752xDy
 jlU2XhfIKeBbRHHrWPUUIb9me9himBEZcPIXdQLDTqw5e5rUtYhNCjovqplV0qau
 g19wVeIgq+5YWhD2nHlVr1PBi7TDaebD1FyGIVuWlZVEsj5/Xnm6vBaxUZYTKvkx
 ydWp+P1A4QrPmiauh6oQRmRy7lwcp8UTmfA+gxDZRiHTY18BvXzZUVTnNetSJx9Z
 ldY7o7CAEZOueCZxpECObtsOp6ESJK8Gnh2WgoHSl+X+Pz65f2EZYM8/kBKT46HH
 RDJ6WA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe69dar-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 06:11:09 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2e767948f7cso8846215ad.3
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 23:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791439869; x=1792044669;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/RXALBiy38fnkP6rflCi5//J78+eNuFAEPXlah/LmVw=;
 b=MrujUy0kp0tLKNv+CnRBGHuvBeNDzxuoY5GjdPKDXr1EvHShFEHmwDz8BFhLnehyZR
 aEtLrrcew7rEw6X59G4uCX+6m+WtwtBNhkTLyuNvsSTjfrqZfdlHoeMosB0yYHzV1Lwk
 7km7uQjx/K9mYDZCLPS7Qekl/ksNitftwl1ZC33Dqm4YD22uZaSsPuWNx3gN+/1U4Mef
 GNQBivzJAS6FtEr8i8aMbaVSwMZM8w1GOL/ZQbaHfTWFxtT2RtaVsXHX0jMm8Udomj7N
 CJQ+DN0tkxodKCdfIcEnylynvW6k9UxDt3bNRkDn/Abe7CfztQiVZfVMuAO2PU/jXQ7J
 LVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791439869; x=1792044669;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/RXALBiy38fnkP6rflCi5//J78+eNuFAEPXlah/LmVw=;
 b=ajlsnif9oUBclgsg4WDihxixakHKTzkleYsEMNvNDEyINeDARk3aaLjzGAWMaEp8oV
 MLDx94au88DHS6vW32QjAQ9Yr513vH/kZ2OtewvgtfXOwfdlQBMY6FKTkjoQZkKqn5ie
 +TY6xjYE5CLyOZ16HTzb38kD0kNMifnjCXjlYDUsyGpXAqu+cO8nQhTeNUHyA5RBrkH+
 1pm9fGYs1k6FcL5866mA3uX+1MDNymeu6PvWeF09lorZSn62HGeMITMo8uUB5OPD1g43
 K6osRlDTz2X5X8K0BEDteyIKgfAjK37affRUi87WA93JUuYFAhNqh2tIT/WsWuq37Asv
 ZbaQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz9YHj1qnU8Kf7zMsQ9bHkMDt8xB2s8xaLOj42xM5m7XljIh4vLTEhsoAphZHf3Ienppj8N1tZOC+Q=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYINU08iiqaxQm3+udqxIq45gpmdyr56jpGE6Im8bXsoAaqVVR6O
 86PbAluY0rj57VqBjTcP6zjVgaXlRmI5Gqb7N3qcR+yZu+UMkVLhpJEU1reT0phJlR2cjJfXvDK
 AbPOkFF3PwK7Mh/bb0XhH8EBxjuU6kczO/ChKEdRx9PhWX8HRzpb53bcM4PvRHtsGz8pSVKk=
X-Gm-Gg: AYBFou14q1ZBrxLwKK715RvGZILqMP1osxIIVOdDriWErcbrkGpEDypjQxEMXpIdoBI
 ZkaVdXJpIy1ZxrdaXfkcXTOZ4jZpzn1cJLNBfMw/QLv2v5pfVXdSkZz8nrtrhDS2LQ9pusFTS8V
 SVlr++lsXmUw+ir2WqPH8s4oU//I2+wYgcntrpVOI5MB1CLtx4bKbJGiXaV5yICmBbvcqCUrNfp
 ybT8J6rKCXZsSLVked22SbWuUuYMAa8M1+qllzuMavSQPbq8vfs1N0X26W5bTzvD+qh2digulmo
 w8lzubmEM28hgiaVGMarc3XVKonOcR43FxQr9IHjlitgiqXYPqSi0+5zwr2nJI1uZANAltoiWWI
 USKm5fHnGhNbV6/AOK+fXR2OkRxAIeAw=
X-Received: by 2002:a17:903:41c8:b0:2e8:1910:e398 with SMTP id
 d9443c01a7336-2e81910e5f5mr4465035ad.9.1791439869201; 
 Wed, 07 Oct 2026 23:11:09 -0700 (PDT)
X-Received: by 2002:a17:903:41c8:b0:2e8:1910:e398 with SMTP id
 d9443c01a7336-2e81910e5f5mr4464795ad.9.1791439868756; 
 Wed, 07 Oct 2026 23:11:08 -0700 (PDT)
Received: from [10.217.219.169] ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e60483067bsm20446625ad.53.2026.10.07.23.11.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 23:11:08 -0700 (PDT)
Message-ID: <7e47ab9c-68e5-42ae-9c40-47c5c16fcbbc@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 11:41:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/7] bus: mhi: Add QDU100 Sahara variant and firmware
 fallback
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, mhi@lists.linux.dev
References: <20260701-sahara_protocol_new_v2-v6-0-3a78362c4741@oss.qualcomm.com>
 <20260701-sahara_protocol_new_v2-v6-4-3a78362c4741@oss.qualcomm.com>
 <n45ii7ekxeefuxw2ydwzsx7lqlfczbgg6obrzmzpytl2fin7j5@vbhmrptcjvcb>
 <21867efc-b5a8-4ed9-92b4-059a020731a6@oss.qualcomm.com>
 <kwq7tajvlnm5sesmthseleenbah6d5kuj5d2msyspme7je6o2h@rx3dbqyqeywh>
Content-Language: en-US
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
In-Reply-To: <kwq7tajvlnm5sesmthseleenbah6d5kuj5d2msyspme7je6o2h@rx3dbqyqeywh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: jtOEN9BTTB_89S_4HSzMjTc2BoKeDns5
X-Authority-Analysis: v=2.4 cv=HcWB3SE8 c=1 sm=1 tr=0 ts=6ac733fd cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=g8PKBf0Eg_Ulicni5CIA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: jtOEN9BTTB_89S_4HSzMjTc2BoKeDns5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAyNCBTYWx0ZWRfX/1nPK3yE2er0
 KLjr1sdiId0V0/eEoPUkKbKfUd3QPAOQpxk0jCWZQqysbPFKNsc0UqC8x4dQwTtcSSnmNoVKRSA
 LGfXGjxJkbMKCml9eCaIMbEsu0Cz4Xqv/cztATfJTOgCBM52VCnpR+uDVTAYKLf9VZT+Z3widAq
 p975/7Ljv0Nmh4AZpcl+9+DehPkJXpaO5z/r1Tf/SNxJIUpSc0bBlKSvIyRXQdmiNgCMhwnNO6E
 dYftPPiSNIYuI90CjW6JkAqKVBMmI/BWrAIfaF/XqJ43pDR7ZyjvhLmy5v7oB2KiwstA1Hj1cdm
 KI9iwv1tnm6YYq9x0LwMhL7Qu4y6nrVVHUn4qwu5h8XEi4ugcX3SjhsFEAxofFM7TpZXk5eP7N2
 Aesb+X6+7dzV89WNrhcYIQA63ANNeWe3sHghH9eJvUZPNfvUvA/MYLGi+EM3LpKMWwq9AvZCwpb
 0aYUOBr6ndn/56VdfHw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAyNCBTYWx0ZWRfXxL95dXJQzeUJ
 DVdJk7799UFT2b68WqALmQ7d/4UAgYWW7/UDk72ocIx+P91v9gjkHMC/fgHXGv9uJUkDYPhA6pv
 cTOrDL/IvRYMZiTHJgl7ER+I9PPIR58=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_02,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610080024
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


On 7/13/2026 9:49 PM, Manivannan Sadhasivam wrote:
> On Mon, Jul 13, 2026 at 07:46:02PM +0530, Kishore Batta wrote:
>> On 7/9/2026 11:49 AM, Manivannan Sadhasivam wrote:
>>> On Wed, Jul 01, 2026 at 04:07:38PM +0530, Kishore Batta wrote:
>>>> The Sahara driver currently selects a firmware image table based on the
>>>> attached device, but it does not recognize QDU100 devices that expose the
>>>> protocol on the SAHARA MHI channel. As a result, the host cannot associate
>>>> QDU100 devices with the correct firmware namespace during image transfer.
>>>>
>>>> Extend the probe time variant selection to match the SAHARA MHI channel and
>>>> associate it with the QDU100 firmware folder. Add a firmware lookup
>>>> fallback for cases where an image does not have an explicit entry in the
>>>> device's firmware table. This allows required images to be provisioned by
>>>> the platform.
>>>>
>>>> This change only affects devices matched on the SAHARA MHI channel and
>>>> does not change behavior for existing AIC100 and AIC200 devices.
>>>>
>>>> Signed-off-by: Kishore Batta <kishore.batta@oss.qualcomm.com>
>>>> ---
>>>>    drivers/bus/mhi/host/clients/sahara/sahara.c | 27 +++++++++++++++--
>>>>    drivers/bus/mhi/host/pci_generic.c           | 45 ++++++++++++++++++++++++++++
>>>>    2 files changed, 70 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/bus/mhi/host/clients/sahara/sahara.c b/drivers/bus/mhi/host/clients/sahara/sahara.c
>>>> index e339c67e236af271645ca81cc517efd9eead87e4..9adbd84859073d8024ba2a5fcfa33897439d6759 100644
>>>> --- a/drivers/bus/mhi/host/clients/sahara/sahara.c
>>>> +++ b/drivers/bus/mhi/host/clients/sahara/sahara.c
>>>> @@ -189,6 +189,7 @@ static bool is_streaming(struct sahara_context *context)
>>>>    static int sahara_find_image(struct sahara_context *context, u32 image_id)
>>>>    {
>>>> +	char *fw_path;
>>>>    	int ret;
>>>>    	if (image_id == context->active_image_id)
>>>> @@ -201,8 +202,28 @@ static int sahara_find_image(struct sahara_context *context, u32 image_id)
>>>>    	}
>>>>    	if (image_id >= context->table_size || !context->image_table[image_id]) {
>>>> -		dev_err(&context->mhi_dev->dev, "request for unknown image: %d\n", image_id);
>>>> -		return -EINVAL;
>>>> +		if (!context->fw_folder) {
>>>> +			dev_err(&context->mhi_dev->dev,
>>>> +				"Request for unknown image: %u (no fw folder)\n", image_id);
>>>> +			return -EINVAL;
>>>> +		}
>>>> +
>>>> +		fw_path = kasprintf(GFP_KERNEL, "qcom/%s/%u",
>>>> +				    context->fw_folder, image_id);
>>>> +		if (!fw_path)
>>>> +			return -ENOMEM;
>>>> +
>>>> +		ret = firmware_request_nowarn(&context->firmware,
>>>> +					      fw_path,
>>>> +					      &context->mhi_dev->dev);
>>>> +		kfree(fw_path);
>>>> +		if (ret) {
>>>> +			dev_err(&context->mhi_dev->dev,
>>>> +				"request for unknown image: %d\n", image_id);
>>>> +			return -EINVAL;
>>>> +		}
>>>> +		context->active_image_id = image_id;
>>>> +		return 0;
>>>>    	}
>>>>    	/*
>>>> @@ -870,8 +891,10 @@ static void sahara_mhi_dl_xfer_cb(struct mhi_device *mhi_dev, struct mhi_result
>>>>    static const struct mhi_device_id sahara_mhi_match_table[] = {
>>>>    	{ .chan = "QAIC_SAHARA", },
>>>> +	{ .chan = "SAHARA"},
>>>>    	{},
>>>>    };
>>>> +MODULE_DEVICE_TABLE(mhi, sahara_mhi_match_table);
>>> This change should belong to a separate patch.
>>>
>>>>    static struct mhi_driver sahara_mhi_driver = {
>>>>    	.id_table = sahara_mhi_match_table,
>>>> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
>>>> index 391ab146f501c6ce1c81f6138f7c491a49c2f264..82e41632afc555a53dec3d8395558ae039b33bbd 100644
>>>> --- a/drivers/bus/mhi/host/pci_generic.c
>>>> +++ b/drivers/bus/mhi/host/pci_generic.c
>>>> @@ -300,6 +300,43 @@ static const struct mhi_pci_dev_info mhi_qcom_qdu100_info = {
>>>>    	.reset_on_remove = true,
>>>>    };
>>>> +static const char * const qdu100_image_table[] = {
>>>> +	[5] = "qcom/qdu100/uefi.elf",
>>>> +	[8] = "qcom/qdu100/qdsp6sw.mbn",
>>>> +	[16] = "qcom/qdu100/efs1.bin",
>>>> +	[17] = "qcom/qdu100/efs2.bin",
>>>> +	[20] = "qcom/qdu100/efs3.bin",
>>>> +	[23] = "qcom/qdu100/aop.mbn",
>>>> +	[25] = "qcom/qdu100/tz.mbn",
>>>> +	[29] = "qcom/qdu100/zeros_1sector.bin",
>>>> +	[33] = "qcom/qdu100/hypvm.mbn",
>>>> +	[34] = "qcom/qdu100/mdmddr.mbn",
>>>> +	[36] = "qcom/qdu100/multi_image_qti.mbn",
>>>> +	[37] = "qcom/qdu100/multi_image.mbn",
>>>> +	[38] = "qcom/qdu100/xbl_config.elf",
>>>> +	[39] = "qcom/qdu100/abl_userdebug.elf",
>>>> +	[40] = "qcom/qdu100/zeros_1sector.bin",
>>>> +	[41] = "qcom/qdu100/devcfg.mbn",
>>>> +	[42] = "qcom/qdu100/zeros_1sector.bin",
>>>> +	[45] = "qcom/qdu100/tools_l.elf",
>>>> +	[46] = "qcom/qdu100/Quantum.elf",
>>>> +	[47] = "qcom/qdu100/quest.elf",
>>>> +	[48] = "qcom/qdu100/xbl_ramdump.elf",
>>>> +	[49] = "qcom/qdu100/shrm.elf",
>>>> +	[50] = "qcom/qdu100/cpucp.elf",
>>>> +	[51] = "qcom/qdu100/aop_devcfg.mbn",
>>>> +	[52] = "qcom/qdu100/fw_csm_gsi_3.0.elf",
>>>> +	[53] = "qcom/qdu100/qdsp6sw_dtbs.elf",
>>>> +	[54] = "qcom/qdu100/qupv3fw.elf",
>>>> +};
>>>> +
>>>> +static const struct mhi_sahara_fw_table qdu100_sahara_fw = {
>>>> +	.image_table = qdu100_image_table,
>>>> +	.table_size = ARRAY_SIZE(qdu100_image_table),
>>>> +	.fw_folder = "qdu100",
>>>> +	.non_streaming = false,
>>>> +};
>>>> +
>>>>    static const struct mhi_channel_config mhi_qcom_sa8775p_channels[] = {
>>>>    	MHI_CHANNEL_CONFIG_UL(46, "IP_SW0", 2048, 1),
>>>>    	MHI_CHANNEL_CONFIG_DL(47, "IP_SW0", 2048, 2),
>>>> @@ -1399,6 +1436,14 @@ static int mhi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>>>    	pci_set_drvdata(pdev, mhi_pdev);
>>>> +	/*
>>>> +	 * Provide Sahara firmware mapping. Sahara consumes it via
>>>> +	 * mhi_dev->mhi_cntrl->sahara_fw at probe time.
>>>> +	 */
>>>> +	if (info == &mhi_qcom_qdu100_info ||
>>>> +	    (info->name && !strcmp(info->name, "qcom-qdu100")))
>>>> +		mhi_cntrl->sahara_fw = &qdu100_sahara_fw;
>>>> +
>>> Why are you adding QAIC MHI controller config in pci_generic driver? This driver
>>> only handles Modem devices.
>>>
>>> - Mani
>>
>> Hi Mani, Above one is for QDU100 device. QAIC is not added in this file.
>>
> Sorry, my bad. But anyhow, you should provide this mapping table pointer via
> 'struct mhi_pci_dev_info'.
>
> - Mani
ACK. I made required changes and will publish in v7 patch set.
