Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC5BBC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:27:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46F2110E571;
	Mon, 13 Jul 2026 07:27:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q+Jjp9n6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IJ7Zsyj+";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE84510E571
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 07:27:12 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66D6NcH5469173
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 07:27:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 b7+R+IEwGTa+tW+AFP3lb1nudfQDALMgZxFV8QusXX4=; b=Q+Jjp9n6AOakwWLd
 sZb73+z9Vlt9Hd5YTvKP1ayCn3AUxjmfoWeWhr16oqG4wcLX4wPBoQJxZ7VaPslQ
 xerjjswTr8aBuBPkj9DhvFBmdAXV7dCwx5WF9AhAdU2HGF3cv0pLwyoG38OlK3OS
 uiE6PaRNG4fMNS14+xWC4u+QKMJm7t/uaHt+p8DPmBKl9yaCBsdhZBcM2Z1pRIWI
 8lYkuMfqL7p98q7qHUcIWhx0gNLVEg254J2d+wNAiHMqrKIxrpBOA1QKEsneXqCz
 FOZyAFA3MBm1Gz3g8/N21k5HZD41WMGxyqNFNMXhZHmThEOW9yvcpIhP89ZQVF5M
 NVmJMA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbf484xd3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 07:27:12 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c88da04b719so2778669a12.2
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 00:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783927631; x=1784532431;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=b7+R+IEwGTa+tW+AFP3lb1nudfQDALMgZxFV8QusXX4=;
 b=IJ7Zsyj+imXWi43kmbD6As+n1FgaLNyrOHNfOeTgT8MLPwDx9U80B7xo8si6+ed4z6
 R9zel8DLj0jyVaFB0aiRnADrjhRgTbq5p8ScetXy6dR/N2OVzqLcwA6Pw4tQ9rwGkz7r
 jlE5gmcKKmNGDFEXX53rhh1DDwTaapqhAjmYaXwxyOKRzYmjOhUwT+U8tEIEF/gUp+wf
 rLpIl4J2KQz1LngUxwAfodTHHyv2QI/rCLo2MmpqleBDo3Gv+ej7DGFGQhXX0hkKJkdO
 64MdgxchdZhKSiSU0oEhHQb1qHp28vUhJ19Gs2tSNWArCUBf2VKYtLAmK2snJOiRXDFs
 XP9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783927631; x=1784532431;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b7+R+IEwGTa+tW+AFP3lb1nudfQDALMgZxFV8QusXX4=;
 b=Gp+pc3WTY0z89w59Tlp5O8g8f14kQwYoYrBkdB7BoDmx0So+U6uZP6QYvckLLQwO4n
 9YH0QOLAJmf3YlDTTz9ynCsF2r1X1PYah9kpzPT3PTcwdLYp11DKwrp6+jsY84aBn+kJ
 jnEtHupb9llZxuABfbDfMlAqrhTVLT8FSOnDsr/0CgtLVRXF6FfXkIkFthpiHCEsdBv4
 HfpyrP7wXgn/YeN7WukAmF/+8XEwNZuqyJgK9s2ILFM83jyGQFup8b5IuTBBgrY2MKKD
 PQbBCeJri+QNnTinCoeAd6zPxvtkJEj1VFKJkM7oftGjpz6yH418jZ02IADYEn4Gfe6Z
 sYEw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrPNQ8WlBByzoA2vTGXay+SohPLNdqmSWTWSu8If+5I8mNEG8ee/B19u+TWPuTno+c8Urm4z1wz074=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxf9OkdW9dl6ILQbB3eNd8LDppjiYLed4+6+bxl3UFj3jSjvPJ/
 eHeJ3xxEvUsuZVnLGq5mnIwai+EAUpvFLhOuAFWo/4VkEFfspi9CJz3LTljeGBGccIvAniPp4Ax
 gUvI/N/wn/uGFIEHCwlL6qpxuaSksEVMGWuTigsxHGL2DgbPTYnwJ+/f2caVEyqOEHBEXlu0=
X-Gm-Gg: AfdE7ckEy/UxdWjcxS0MD/RWXKUEhvCSkVHcRxnUg94FIBtPM7SaSIm+W1p+Mc5uPnU
 mFuv59qOTSTBwX7tqJlh/EB4k5e51k0Jb1Cls37L9WeD66UlcHHfmAs7Gj81F+DAtDFA7YCyt4I
 9tTG7G4qaM78p8a+lcD5k3Lbt1QJLLriRcpA/bk7e4eyIMSaD54yK9OCci+KqEWtfi4J5ReBcB1
 wFpgP7J4siIUFZX1jTjOy5OuHHdVdNVBSKoGyuZmjOvwWiyd7PyGC4lw9/jw8/UkQnQ+8vGswzh
 HcXE3dKnfIa9MhQhv9hZFg+ri0sXoGFSHlnc05t9t0P3+/5CGkBSmJp5oDjFxNHt3ouFmC9YzeP
 lElG5lnlDdqlX7oH8PIesjr7VJKvfPZUQXNXsVChqkE4=
X-Received: by 2002:a05:6a00:a117:b0:848:824d:aff4 with SMTP id
 d2e1a72fcca58-848896fee6fmr6817121b3a.56.1783927631531; 
 Mon, 13 Jul 2026 00:27:11 -0700 (PDT)
X-Received: by 2002:a05:6a00:a117:b0:848:824d:aff4 with SMTP id
 d2e1a72fcca58-848896fee6fmr6817067b3a.56.1783927630381; 
 Mon, 13 Jul 2026 00:27:10 -0700 (PDT)
Received: from [10.217.219.169] ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84a15e36158sm2055595b3a.47.2026.07.13.00.27.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 00:27:09 -0700 (PDT)
Message-ID: <d8d0818f-4f3b-4efa-a89e-e304be91f3cb@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 12:57:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/7] bus: mhi: Load DDR training data using device
 serial number
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, mhi@lists.linux.dev
References: <20260701-sahara_protocol_new_v2-v6-0-3a78362c4741@oss.qualcomm.com>
 <20260701-sahara_protocol_new_v2-v6-5-3a78362c4741@oss.qualcomm.com>
 <ysumvduurfx5jq7r2eaa4ik24eqk5at24frvjl3zyif4wc4ojj@2bhq4vzuqlnw>
Content-Language: en-US
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
In-Reply-To: <ysumvduurfx5jq7r2eaa4ik24eqk5at24frvjl3zyif4wc4ojj@2bhq4vzuqlnw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA3NSBTYWx0ZWRfXyaAuzjbrATMi
 pSq8D/s/MbK0tXULhCXPsECR7IBEeKwAlTngLOloNruR5DVXwAXd6GmvcDl1V3eGI1JtEL7PVz9
 HWhrsZwLtNjGRTToDna8UFz6SUKxsHE=
X-Authority-Analysis: v=2.4 cv=OsJ/DS/t c=1 sm=1 tr=0 ts=6a549350 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=BmEjwzUHSYKQsWGf9k0A:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA3NSBTYWx0ZWRfX0W+fyvhy5jWs
 aK4WmRwLO/+fV4rGgufTW0O0Jt8/OeWvx0w5j6M87PDEv8BWXT/qigoSK0eswll+sCc0yO4m842
 GHARplxtP2M0BZ3c8jMcifsntfNCk+AKWwI77Z5d4dytTCCt0UcpBXNmeZ+cTuFdKE+cV63690/
 Uy5sje15LDLLrB8ye2skecQFZeg01E4eHBpgSO+LkeqDG7LjPNXzvgXQCHMoeaj+kRrtrm9aqqc
 IE70LQ/tDFwoyU/G9/R1HjRkVlUl/orxojfogolick6bEXTwJS6gyNui89LwryzAfrrkSkFkhaN
 bXZP3XURbqB1oBb+YMeqlkRtwNHSODskWE0TkDm09j4reJ752IugzE68fKk0RkGspoC60fBtrQd
 nQdD8ps77oALqjxxITggEzWeIJQuQBrbVmoJ4pkA1auLEwfrFVF6rdn2yPMTcRO0WSNzpmhXGc4
 jgFE6DwAkbum6DEN6Qg==
X-Proofpoint-GUID: qxEznYQF9z_juu498jL3dwlHMyVtSm-U
X-Proofpoint-ORIG-GUID: qxEznYQF9z_juu498jL3dwlHMyVtSm-U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130075
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


On 7/9/2026 11:51 AM, Manivannan Sadhasivam wrote:
> On Wed, Jul 01, 2026 at 04:07:39PM +0530, Kishore Batta wrote:
>> Devices may provide device specific DDR training data that can be reused
>> across boot to avoid retraining and reduce boot time. The Sahara driver
>> currently always falls back to the default DDR training image, even when
>> serial specific training data is available.
>>
>> Extend the firmware loading logic for the DDR training image to first
>> attempt loading a per-device image dervied from the device serial number.
>> If the serial-specific image is not present, fall back to the existing
>> default image, preserving current behavior.
>>
>> This allows reuse of previously generated DDR training data when available,
>> while keeping the existing training flow unchanged for devices without
>> saved data or for all other firmware images.
>>
>> Signed-off-by: Kishore Batta <kishore.batta@oss.qualcomm.com>
>> ---
>>   drivers/bus/mhi/host/clients/sahara/sahara.c | 25 ++++++++++++++++++++++++-
>>   1 file changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/bus/mhi/host/clients/sahara/sahara.c b/drivers/bus/mhi/host/clients/sahara/sahara.c
>> index 9adbd84859073d8024ba2a5fcfa33897439d6759..b5ca6353540dc3815db6539e7424afdb749fd3f6 100644
>> --- a/drivers/bus/mhi/host/clients/sahara/sahara.c
>> +++ b/drivers/bus/mhi/host/clients/sahara/sahara.c
>> @@ -59,6 +59,7 @@
>>   #define SAHARA_RESET_LENGTH		0x8
>>   #define SAHARA_MEM_DEBUG64_LENGTH	0x18
>>   #define SAHARA_MEM_READ64_LENGTH	0x18
>> +#define SAHARA_DDR_TRAINING_IMG_ID	34
>>   
>>   struct sahara_packet {
>>   	__le32 cmd;
>> @@ -226,6 +227,27 @@ static int sahara_find_image(struct sahara_context *context, u32 image_id)
>>   		return 0;
>>   	}
>>   
>> +	/* DDR training special case: Try per-serial number file first */
>> +	if (image_id == SAHARA_DDR_TRAINING_IMG_ID && context->fw_folder) {
>> +		u32 serial_num = context->mhi_dev->mhi_cntrl->serial_number;
>> +
>> +		fw_path = kasprintf(GFP_KERNEL,
>> +				    "qcom/%s/mdmddr_0x%x.mbn",
>> +				    context->fw_folder, serial_num);
>> +		if (!fw_path)
>> +			return -ENOMEM;
>> +
>> +		ret = firmware_request_nowarn(&context->firmware,
>> +					      fw_path,
>> +					      &context->mhi_dev->dev);
>> +		kfree(fw_path);
>> +
>> +		if (!ret) {
>> +			context->active_image_id = image_id;
>> +			return 0;
>> +		}
>> +	}
>> +
>>   	/*
>>   	 * This image might be optional. The device may continue without it.
>>   	 * Only the device knows. Suppress error messages that could suggest an
>> @@ -235,7 +257,8 @@ static int sahara_find_image(struct sahara_context *context, u32 image_id)
>>   				      context->image_table[image_id],
>>   				      &context->mhi_dev->dev);
>>   	if (ret) {
>> -		dev_dbg(&context->mhi_dev->dev, "request for image id %d / file %s failed %d\n",
>> +		dev_dbg(&context->mhi_dev->dev,
>> +			"request for image id %d / file %s failed %d\n",
> Spurious change.
>
> - Mani

ACK. Will remove it in next version.


