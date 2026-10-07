Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 033F5CA5FFF
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 06:38:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E5E910E504;
	Wed,  7 Oct 2026 06:38:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="A+fkf6Zw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Fqyrfr5H";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C78C110E4F0
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 06:38:45 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6976V0wN3649263
 for <dri-devel@lists.freedesktop.org>; Wed, 7 Oct 2026 06:38:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8ACzqyHWtdt0fC2Pj9BbXxAGnwUR8TgCimh4uH8dmHU=; b=A+fkf6ZwKdcZqsQB
 R5sqmyDRCWMhhL6Kk5TJNPUsv4X4Muz9ttlYFFzsmQYceKrnW9DoTjwS54/XrXiV
 QhZdm8GYApm29GXjrRnLMZWd/ucrRMZONkWbdiscyaKKb0cbxCpzq1DqnqcZALge
 rL+kw+9gITbWt6EtG8soeH0khhOWMwH5gPAPGLV++oQtZuK0RuBW6vpOA0gvG5wA
 154KDLYhvLuZzw1jy5kSDXDh7DP6GkZSi9MPmePE38IBbDCJRVws+Sr2gEN3DLde
 cztO4G/h3L9aXRrrhhSG9tX1NIRWS1xAyWFwHadAQ3gkEMdtqy7ERtbknCXvsXxz
 omi3QQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5gvrr0wr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 06:38:44 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2e5dcd82b26so13625145ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 23:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791355123; x=1791959923;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8ACzqyHWtdt0fC2Pj9BbXxAGnwUR8TgCimh4uH8dmHU=;
 b=Fqyrfr5Hcb+VrZ1M8yptXAt+8vb8dIvLK2cnBHCeBQvPPbP/ovpPjJ2QB3ULY4lbJF
 FMFq2QDuh0+h6U8PYthWWts8p2Cv0iEDM1+l0KiSBANr/jUntunajDQnsgZhcu85djGr
 /az4caESSZfUgIM50dODFj+OZBoF0eASLFPqpdM84hTaQi4u+WNj+sasOVV7wvfp0iqn
 yMRVdjmX++na8nuvKNCpKtcG7GUecO2JYjKYch/ZSgNYJWYTXx7Wr0yzmGWMsEU7yFpi
 mYICtofrVg3kQlDApX++hRvnY2LyAy5fp09Cmp4dLi4rhB895MgXVbaI7I2WU5IeSyHM
 /wCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791355123; x=1791959923;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8ACzqyHWtdt0fC2Pj9BbXxAGnwUR8TgCimh4uH8dmHU=;
 b=YnVl58Z4eCtaQyST5KZacl6jhTwGT8udzkfid8JMupezrMuvVJdfDxQqwja46s4ZJa
 8+MiUQ7zCZxH8EDUM2FdTQGp5epvONkXvVMSjAkyV1uoHB1rRbIzSG2mnw4Ba6HINGCK
 ZouClYom6jyT3OyexiLt3SQYN+XL7oUtYgv+cQ6LIjhG039ehdwweF5i09TkMOSkzMnq
 xKmHavg2FUzvtlH3tPATpPXR/cf5SCTLAxEZ6LjVeRZ9ZcdxF0SsAKdjLJ2b/eRVZItt
 rWR70x5YzlHBWNrOBXVv4bDnpP5g67UX+BydxUwvJ7S1QHQz7Iq5XqOdjoEh3jW6J8BY
 Lcfw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzllY9Vybu7VLfn4tnUXYEFumBYWqL9FXK5SpV/LQUFHhiym4GHD7bTYo073SsqeFl0uaKi0hMQkCE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJKmGmyjTrINW/730mDOw35ChT/k7Pu1/s3bKjHZgNRRt2v7ES4
 Uj2baAeLmWRM4yHVAtDdDnJQ4Eqv4M50Gi7zlXxsBBLv1vK8wz2wlAiwJqB/hMGoMyegI4iQFxU
 JXMJxafjwqmhNjL+cxkoj5D2T8177zjl5XwFYWzmC/9GHDqQcRf1oL4oBGLOaf7Z7PgL8OoQ=
X-Gm-Gg: AYBFou0CKYp8qso8QjBJmZHEiN11WxOq0YpuFhfbAgwcJxv9F45MDO+hLQMsQlXvty5
 M7PT7fzY3OGzTp9V0gq99rqcEF4A2tZpVTNW3809zRpQpMJdLVpPNtpLLOD5ejbXB2semlwvVZv
 GGlu1HpFGNfDfzIMAe5s5iMCCKtauh7FzXcgo20TADV+CJhtuU1G2K/ECpe6yYtrdo7QL22ifpp
 A9GEyLDA2O+3ExUCN8ePKWMwdIWvToO+028kADsraxU2MuHp+8EY0lXm0EO5dhDYZ6UPuE0x+SC
 7rDlUhCVk9WhB9YNEYlWkHm6cLD2gdL0XLtNRI9xcgW/PeKc22RLIkQMt8jrEunUu6Aohy46MMD
 osuYHii3M1ZhQThssqD6APRS7Q+kA
X-Received: by 2002:a17:903:184b:b0:2df:a608:27d5 with SMTP id
 d9443c01a7336-2e6003b5d8cmr13570955ad.12.1791355123220; 
 Tue, 06 Oct 2026 23:38:43 -0700 (PDT)
X-Received: by 2002:a17:903:184b:b0:2df:a608:27d5 with SMTP id
 d9443c01a7336-2e6003b5d8cmr13570745ad.12.1791355122781; 
 Tue, 06 Oct 2026 23:38:42 -0700 (PDT)
Received: from [10.204.78.119] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e6046fdbcasm5501515ad.13.2026.10.06.23.38.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2026 23:38:42 -0700 (PDT)
Message-ID: <8e7ac84c-5ac0-4e62-9aff-f1151eda5def@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 12:08:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/17] phy: qcom: edp: Add Nord AUX channel and VCO
 divider configuration tables
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, Ritesh Kumar
 <ritesh.kumar@oss.qualcomm.com>, Mahadevan P <mahadevan.p@oss.qualcomm.com>
References: <20260911-nord-drv-dt-v1-0-e25c073cf1b6@oss.qualcomm.com>
 <20260911-nord-drv-dt-v1-9-e25c073cf1b6@oss.qualcomm.com>
 <clxbpw3awcpispcixwrvwj7hocvoag6fhhp7d4azamxghk5x5o@ar3infqpcy56>
Content-Language: en-GB
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
In-Reply-To: <clxbpw3awcpispcixwrvwj7hocvoag6fhhp7d4azamxghk5x5o@ar3infqpcy56>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=W66txhWk c=1 sm=1 tr=0 ts=6ac5e8f4 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=jUuSjYW6OROygl6o7qcA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: IokjWv105zTEvla-UqXrA-h2Bn2HdoLS
X-Proofpoint-GUID: IokjWv105zTEvla-UqXrA-h2Bn2HdoLS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAyNiBTYWx0ZWRfX438sZ3VXwCzp
 uFhVblYY6XRXqImImvdHl1hUqgMSXVveyeEM9b493hiZwlEb/L9WXYjbOYUJJ5sdio1bp+r+q4G
 OwFWoSAJTV5K7nHiVD7v2WhHsIzYk2Fh3SxVzrKp1qbeXJGrZ6mkJ8p91xpQjc/BpwSCowGraYy
 pgZedmoOGTnDAw3Z+JYD5YOPr5DBXyrwtLOyzkfdzIQX9Pi919RpZYbk2x0/NntlkEqIUrai3IF
 z8cSKU8MNeC3BeXLRW4ja/hnPYOpgXemJeUT131UbwS9S7VnpKvjKXNlE35R0EFH4N3c834QQSr
 hVgbiFuz6FGq/2H+hxbzUGaB8u8UuXDvrN7F2kLfrrx6mZ4JRXVCc8LVwdxBRIoAHhtwTkWrCVZ
 Nvee/owTyhAs/P81cODD1Ig8s+Uc8BkMx/BU40zqXXwBsGU1GBs6ydmZYq2NpzUOZKBXoN27xIB
 ZnJ3eyVjfo7sVvGjZZw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAyNiBTYWx0ZWRfX4btTy+330KYS
 dY4PJTNlYysuIKaFCXuWuSNVTPrBfqbNlXBkj0FqQ3rFLAkzO1ohYQWp3uHlJz+Is1PVGSpSNsD
 RkhBMTJWaVV/XJQ4bqlDRBh0Pcse7co=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_02,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070026
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


On 9/14/2026 5:33 AM, Dmitry Baryshkov wrote:
> On Fri, Sep 11, 2026 at 09:06:40PM +0530, Nabige Aala wrote:
>> From: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
>>
>> Nord requires different AUX channel and VCO divider settings compared
>> to existing SoCs.  Add edp_phy_aux_cfg_nord and edp_phy_vco_div_cfg_nord
>> with values sourced from HPG Tables 2-1-a and 2-1-b respectively.
>>
>> Signed-off-by: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
>> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
>> ---
>>   drivers/phy/qualcomm/phy-qcom-edp.c | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
>> index 373f13b3d6d5..ee0d7f1a90fe 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-edp.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-edp.c
>> @@ -1508,6 +1508,25 @@ static int qcom_edp_phy_probe(struct platform_device *pdev)
>>   	return PTR_ERR_OR_ZERO(phy_provider);
>>   }
>>   
>> +/*
>> + * nord AUX config (eDP mode).
>> + * From HPG Table 2-1-a: edp_phy_aux_bist.csv
>> + * Index:  0     1     2     3     4     5     6     7     8     9    10    11    12
> Drop useless comments.
Ack
>
>> + */
>> +static const u8 edp_phy_aux_cfg_nord[DP_AUX_CFG_SIZE] = {
>> +	0x00, 0x13, 0xa4, 0x00, 0x0a, 0x26, 0x0a, 0x03, 0x37, 0x03, 0x02, 0x02, 0x04,
> So, it's the same as edp_phy_aux_cfg_v5, except for the last register?

Yes, it is same as edp_phy_aux_cfg_v5 except for the last register.

you want to use the "edp_phy_aux_cfg_v5" for nord also?

>
>> +};
>> +
>> +/*
>> + * nord VCO_DIV config for eDP mode.
>> + * From HPG Table 2-1-b AUX Clock Settings (eDP mode) - Nominal/Turbo column.
>> + * Indices: [0]=1620, [1]=2700, [2]=5400, [3]=8100
> :-(
>
> If it's AI, fix the AI prompt, please.

Sorry about that, that's on me. The AI-generated comments are a bit 
excessive here. I will trim them down from all over the patch series.

Thanks,

Nabige

>
>> + */
>> +static const u8 edp_phy_vco_div_cfg_nord[4] = {
>> +	0x00, 0x00, 0x02, 0x01,
>> +};
>> +
>> +
>>   static const struct of_device_id qcom_edp_phy_match_table[] = {
>>   	{ .compatible = "qcom,glymur-dp-phy", .data = &glymur_phy_cfg, },
>>   	{ .compatible = "qcom,sa8775p-edp-phy", .data = &sa8775p_dp_phy_cfg, },
>>
>> -- 
>> 2.34.1
>>
