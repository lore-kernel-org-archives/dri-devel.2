Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF21CA5FFF
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 06:12:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0711910E4AD;
	Wed,  7 Oct 2026 06:12:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JgmJTDGT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QYcJqpnB";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B4B110E23D
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 06:12:49 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6974U18r2062162
 for <dri-devel@lists.freedesktop.org>; Wed, 7 Oct 2026 06:12:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mEeWG7KO8nVXNOa5twFybh1jJy97lZB8PRaYGWiQRVk=; b=JgmJTDGTaC2kRj93
 0Fbp8P9UhNeqSgVkFr6Us1tYGfuHS2rtwiXBc96Jrj4EPeQyxhdndYJvViOTvkmd
 1ZsUb4rGIgfvFQEL6FpLZNXqtCSwHl3nry30P+wAWdDqeuw0aytv4MVn++obdiCV
 Brf3OPFbTfVHF0R8aebxh5+IbnUr8k7qChCJvyoJk+5SQzgKgTPTXFMBMIuEMByh
 RsLi8acLT+iruEA+xutpqIpge0nEe7JApFUQRpt2/TQZEom8KV88Qv+28AxEOPkk
 OzbDNDQyaNFvxILKGxJmAqC9L0DguVL4LED9lzzURaoIpJO0d7LEEBRJHrRZBqpB
 u2RqkA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5c6u0ty4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 06:12:48 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2df5a65671eso22237615ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 23:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791353568; x=1791958368;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mEeWG7KO8nVXNOa5twFybh1jJy97lZB8PRaYGWiQRVk=;
 b=QYcJqpnBuyN7sdwtvNDSuLv6t8L0HaixMLCQNqftEO7R2zh9uZjz19u77OqjeC3g3w
 zj5mjPDkfFiDug3ViwPctdLeOBjOBQtmpXwDCf6U/Qgo2wc4qBubFkyWBCeSxBgheWuX
 3Q8R2i/GxHMcl3PK3ZJlyqleoo+V4GmFiU1klzgx1vS4KUNH6O/NXq7Ev3BAEjdGvqiS
 egZu0/ZRvFBeUlvZDOHitjvaOpre2jUs1hH/cyriMPe0cocNJSDQ9zmHbQ1kqi6idzMt
 UDv5Tl4kkaDIFaQ6+u3BZnfTUbXFPHXjJKn1u/W1CPHnHu+PDFkQ36PGIQK2qNBy4u4d
 7fqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791353568; x=1791958368;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mEeWG7KO8nVXNOa5twFybh1jJy97lZB8PRaYGWiQRVk=;
 b=Fa58XW6ZMAd6bzGQCZIFVxeIkknxVv2xx84tC6Eg6WoWXCbHTbrIWmy9et5bVKDGFz
 3KEufvAQrYqCeM0J9WaQbnMiUUUDpM9uWHdHchZTkMMfy2sbNpwYkcNUrA4MM7eaQoSs
 FEP7C0HZl/56FWHLmjYLCnRkpK6bGFZoFnQQOvQKl/jisbQnGex7j64ZQJqVO+5haVk/
 4OH+BR27s3F4Bcq3J4WbGpNHD8qzmi607KwZE4Y5zwfIQVA/iMvOHILi2MF7hE6g3WyC
 ESI/C0FRbdIk+yWVf6w2fIhe4dRYu1VE/TA56cgIO3A6yHgw/pKi4CQD1BVNdF09/EiZ
 GD4Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzUZRV4G24xZsutcZfKqKM9MoXmBV/Yic8Z6V5iN5XIRDyZXHEodzGfZGIueBx7OXuYhhrgGrf/ifU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ8xuqeF0PFipltGzkjvyFd2J/qpwVG4rUqcJi66iBAE8RjN8Gj
 FWFW+fbS1EJ5JE/nQ03L6EZBYWfZSJ7UfvmALcbEtA24vlkM+Enkk1NNK0N/tEatp9wTjESzIxG
 ciFwO2obE2JLj9m0j4xp4NmiDIeLEpSPnA+P7okFrFWr/47hvGOBd1s6e78zcBJKZZLotYRQ=
X-Gm-Gg: AYBFou3Q6gUmexpGWNwaF9oBAuOvetFVpT+J7/C99IIRMi00OySUBLf8pNOXIqNhuAB
 M8v6kJoXSlyUf7olDLmPTirtiqHi+Di0ygNj9qi48PdGWcJUrhD6obpv90L5dTgWIUSZBtvtuqj
 16wElmXwKUIeQcZaeJWBLP7wZ5uXkHV2x/wUDTZpCI9/1i9SQx1vVLeQs4VkvpQp8RHI+ORQ0j2
 2XHbXMXrgP1TG1JHXSZ7cIK8jcETQUkw3h6a56XQf8H/LFKjvv0+4k52qr8mcDXvqrwKVI0M/vA
 7s3FsH95VGq9o5pBBs6GmF/01Ojw3UGxOVNZxzRqxZp0kijX88FJ71bfLNItqNl5xWOR+I7g59l
 0+jM+nHGnmB4J1RYzx99y9AYfHNu7
X-Received: by 2002:a17:902:d54f:b0:2e6:1715:e4a6 with SMTP id
 d9443c01a7336-2e61715e821mr2275635ad.38.1791353567807; 
 Tue, 06 Oct 2026 23:12:47 -0700 (PDT)
X-Received: by 2002:a17:902:d54f:b0:2e6:1715:e4a6 with SMTP id
 d9443c01a7336-2e61715e821mr2275455ad.38.1791353567290; 
 Tue, 06 Oct 2026 23:12:47 -0700 (PDT)
Received: from [10.204.78.119] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e6046fe0e8sm5326635ad.25.2026.10.06.23.12.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2026 23:12:46 -0700 (PDT)
Message-ID: <acfba985-ac89-4769-9d9e-d2ce9ecd6383@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 11:42:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/17] phy: qcom: edp: Add Nord-specific register offsets
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
 <20260911-nord-drv-dt-v1-7-e25c073cf1b6@oss.qualcomm.com>
 <t5thwekhz7wyhmyq3nobm37kag6n7ef2z2xpuwrqikv4aqniwc@ha2pjr32ecrp>
Content-Language: en-GB
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
In-Reply-To: <t5thwekhz7wyhmyq3nobm37kag6n7ef2z2xpuwrqikv4aqniwc@ha2pjr32ecrp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAyNCBTYWx0ZWRfX5IyDGR+OJcYb
 9o+CMFQjHXcDHpapDQvZqNesHM6B+F9GXyKLEX5eCcdiod3LKwrzcSZ6msUNs2qN/Ek6Npersrb
 h/Zwieer4jh0cFyfdum+uCKYUXDrSio=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAyNCBTYWx0ZWRfX4Pj1P0ptMzec
 xVOmuQaDE5cIDzVCW62D7G6hw/NdbX9L6cPrhM8funEgNkC6o7r7u+2rT+5Scy0BdO+LbOicnt/
 xrROt2r8jcpRZLxVzMUYGSu+r+V1JQ+yoJD6TTEm9QhdHRvDedAIMqXQfGYf/j9xjilUOYmPkh1
 /VUc1hcpgI1f4sHhZsR3VM7tGWQbKN3UnBAMpImIpJD7ahtN8meNLeDR+ZDfNA+iJTrdbLqVkMY
 YXrpk9lVb/RC0rIrM8yc33lW1phbMIf8lh990gW8ZxuEjBvJmHPzUtF3bVX/pthQODBuxNSCVRW
 b3mbZoUZBgg//BZt0GT4/U2RD4Q0YKNod21f+ki2IuoSHLS4t3PbId69bNY2PWpYyzgh4mXAjWV
 6hLfFMk1OLQ6Q31PGO1PXIGRENjKBhmJwT6PeS+dWb3inXwsgWehC1i1vC07VLbzP7Zv+rGSE+s
 HNzis3T/F063LigoJ9g==
X-Proofpoint-ORIG-GUID: UDzYuxJsC7meoLA94iVUQxCbtFRy8OZF
X-Authority-Analysis: v=2.4 cv=T5EZ3PKQ c=1 sm=1 tr=0 ts=6ac5e2e0 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=ws4HDfdl8TRdMr_wlFsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: UDzYuxJsC7meoLA94iVUQxCbtFRy8OZF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_02,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070024
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


On 9/14/2026 5:28 AM, Dmitry Baryshkov wrote:
> On Fri, Sep 11, 2026 at 09:06:38PM +0530, Nabige Aala wrote:
>> From: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
>>
>> Nord relocates several DP PHY and QSERDES v8 COM registers relative
>> to existing SoCs.  Add Nord-specific defines for the relocated and
>> new-only registers in phy-qcom-qmp-qserdes-dp-com-v8.h and
>> phy-qcom-edp.c so Nord sequences can reference them by name.
> If the registers are reallocated it usually means that there are other
> registers being inserted (or deleted). Are those the only registers
> being changed?
Yes, only few register offset is changed that is taken care in this change.
>> Signed-off-by: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
>> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
>> ---
>>   drivers/phy/qualcomm/phy-qcom-edp.c                   | 10 ++++++++++
>>   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-dp-com-v8.h |  3 +++
>>   2 files changed, 13 insertions(+)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
>> index a3c893f72908..bf8a17336c7e 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-edp.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-edp.c
>> @@ -41,9 +41,19 @@
>>   
>>   #define DP_PHY_VCO_DIV                          0x0074
>>   #define DP_PHY_TX0_TX1_LANE_CTL                 0x007c
>> +/* Nord uses a different register layout; non-Nord value is 0x00a0 */
>>   #define DP_PHY_TX2_TX3_LANE_CTL                 0x00a0
>> +#define DP_PHY_TX2_TX3_LANE_CTL_NORD            0x00c0
>>   
>> +/* Nord uses a different register layout; non-Nord value is 0x00e0 */
>>   #define DP_PHY_STATUS                           0x00e0
>> +#define DP_PHY_STATUS_NORD                      0x0110
>> +#define DP_PHY_LDO_CFG                          0x00f0
> Why does it not have a _NORD suffix?

Ack, I will add  _NORD suffix in the next revision.

Thanks

>
>> +
>> +/* Nord-specific TX lane registers */
>> +#define DP_PHY_TX_LN0_DRV_LVL_NORD             0x00e4
>> +#define DP_PHY_TX_LN1_DRV_LVL_NORD             0x00e8
>> +#define TXn_TX_BAND_NORD                        0x0024
>>   
>>   /* LANE_TXn registers */
>>   #define TXn_CLKBUF_ENABLE                       0x0000
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-dp-com-v8.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-dp-com-v8.h
>> index 93edabb830af..008b17222a8d 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-dp-com-v8.h
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-dp-com-v8.h
>> @@ -48,5 +48,8 @@
>>   #define DP_QSERDES_V8_COM_CLK_FWD_CONFIG_1		0x2f4
>>   #define DP_QSERDES_V8_COM_CMN_STATUS			0x314
>>   #define DP_QSERDES_V8_COM_C_READY_STATUS		0x33c
>> +#define DP_QSERDES_V8_COM_SVS_MODE_CLK_SEL_NORD		0x17c
>> +#define DP_QSERDES_V8_COM_CMN_STATUS_NORD		0x1d0
>> +#define DP_QSERDES_V8_COM_C_READY_STATUS_NORD		0x1f8
>>   
>>   #endif
>>
>> -- 
>> 2.34.1
>>
