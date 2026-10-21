Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7EA606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 11:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dNSbFL1D;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QxfDAv7A
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8848B10FD7E;
	Wed, 21 Oct 2026 11:24:10 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4E0710E1B9
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 11:23:58 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LAJT7X1422112
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 11:23:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uMOgubZ9POR3EPQUnP7Tc2q7GElsLYo5uPzAB2RExmQ=; b=dNSbFL1DE56q8Ruk
 R8M08kmvVdNhGeruKLN+Upj6jQNsDs+EaMp905UWYV4osNRX7NE1owPx70/BfzvJ
 Zu3We+Vsck6QDewQFRBwChkCyMNDYZTCelnthSS5YoR3RDjv4OWFt8YF7TLMtsRB
 3Daoa2V8xHSY+uS9og7zB7PueJ2vbAb7TWIqaU6F/P8U/rdHMUiiepEvx4kXHJBU
 kbVbgnw4Rx6kP0z/WcoOeKViKxLGvlULhVcR0KIb5VJ/caVdEhZuMuBd6Wd8L8xj
 pCzF12xEoNHS7Gk/6IxOWohafUvy+WcuslN9KkzEgAyjrWKIffZ17Xa/zSBxlk7Y
 f2hqTw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heuhug6s0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 11:23:58 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ab1e771632so1484512a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 04:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792581837; x=1793186637;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=uMOgubZ9POR3EPQUnP7Tc2q7GElsLYo5uPzAB2RExmQ=;
 b=QxfDAv7AxCr4Rtc7dwM0YPNkD6kDmgrvbYHhQzlN+rr82jPX4Z/bg3I+rdsRSt+hXN
 gmjIUCkgolz5niipDmmlLNG9I0poc3sAeD+pjOMWeCDgelLf05PUR4/IPN3jgCM3nkIT
 m+qZObYbd9mQiqhCXLOXzG+WbkGD++TsUtUk4XkwVMJe7eODhSpZMEFAahedOVgSLZzT
 +IrFYRflwC/9hjIF9bSyReaEZlr2kIxK/lffFe03ElKvwQNQXX5Q6+hxkSVV647kptt/
 eJImH7XpEKXcj225qEDJpJrDN0MizF5cv4RHRK/hIk5ynkTtufjIj5OPZCkjySAaqtum
 7bWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792581837; x=1793186637;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uMOgubZ9POR3EPQUnP7Tc2q7GElsLYo5uPzAB2RExmQ=;
 b=w+8sHvEtBybdVEVhlAR3n9+fg9rDMwzEITOdl5IYaSsVHvyweFu0j4UuNg0j5TRSdR
 BBUionf2w0vDJsoCDdhdl1OADGQemkd0PgTVX++HeHoa7u+9RGfB9/KXlN+sMvU8Rrc6
 9/XiGPj9Bf5p63sP3OJ35lybamJDkodc9JLgmSKidnjdhwvvYa7IQ2uHRckbJP7grL8M
 N3pUWLn6KyBK06AlDom+ZSIB4OMDz2EWt20d38dETKvfPsgVJZMb6Gc8FjL2jihgNJu1
 DHkPJ5N4EbUYTEBBfgjIPFKbCSaY3a4avbWYIYiIJIpXGRJ/CdQoTd/vyXnyfN4M/wTr
 HLMQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx2QrOkUMaBmlt/X+h7KYflwb93pPzJzhqmb/D4CB5Siz6a62hQIWKq3jMpMWWsQql98OAhOVEIr6w=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJm8d66+U9hETQqDo9//4inWb0R3AGGvhf7xgumhopC8fhIbZZt
 yQWEGsP/NVVlUmlmcIlipZZUfQGmccjOX9OWV87tCVkK/ar1JUlcMrUYWheOvBCwPqfrFZXtJ71
 4PBIywyPYj9s8RarJ//jee6Di//v7Rog4Jr/IjeHTf67xzthkSHcgZVdQymCJS/KjD/dVCfU=
X-Gm-Gg: AYBFou2dM1fRPXOSUX/rc+8YS2bKp8V5QPFjv7IdrLyPpmxKW3ssNC/jrS9RbBGe8FJ
 OiHL7Zc/COs3KkmkgN7mMaqONPPYoMCkhVyyvZUtnzxrZ5iiHUvjKNhVC1MTAFfI1GWlS2elL2B
 dFBoWMj1BAvR14Bwc2pBhZ7E9mP4GU1SDjrz7BgHije1yL7x6zoAMKx25BaOHPjf0GwdMr101+4
 93AbJ6bSiPTLoH1MiSg2g3lyer5U8khfeTZ5nTWYgi6HXYcNK3DHqTLH5x1vqwQL61gYxOtUvvY
 /PGBK8i0TBfGUj6waBr2j7byVV4EN15dcktTzkqMf+E6XADtalYEkwjWuz3xd5ltMC73SpwCIkK
 PZ+KaIBqU3CzrOsFHSx7LdXK3A/xn
X-Received: by 2002:a17:90b:2c8d:b0:3ac:7406:b49 with SMTP id
 98e67ed59e1d1-3ad86e96741mr999955a91.15.1792581837390; 
 Wed, 21 Oct 2026 04:23:57 -0700 (PDT)
X-Received: by 2002:a17:90b:2c8d:b0:3ac:7406:b49 with SMTP id
 98e67ed59e1d1-3ad86e96741mr999941a91.15.1792581836958; 
 Wed, 21 Oct 2026 04:23:56 -0700 (PDT)
Received: from [10.204.78.119] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad811c515fsm3765832a91.9.2026.10.21.04.23.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 04:23:56 -0700 (PDT)
Message-ID: <e127d06a-2c1f-463f-a30d-ee7815fe4a75@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 16:53:46 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/13] phy: qcom: edp: Add Nord-specific register
 offsets
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
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Shawn Guo <shengchao.guo@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
References: <20261012-nord-drv-dt-v2-0-a2ab9af954d2@oss.qualcomm.com>
 <20261012-nord-drv-dt-v2-7-a2ab9af954d2@oss.qualcomm.com>
 <q7riz5qxge3gqjqz23xz5aecfhlg7bry5w3wzgblnyozm7ac7y@b5s3z7vk2k2w>
Content-Language: en-GB
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
In-Reply-To: <q7riz5qxge3gqjqz23xz5aecfhlg7bry5w3wzgblnyozm7ac7y@b5s3z7vk2k2w>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=d4JgWhjE c=1 sm=1 tr=0 ts=6ad8a0ce cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=YZ6MeopCirwGMcWCqvsA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA0NSBTYWx0ZWRfXyGTFR5vxnZ8U
 bB1ZF1Kl81y76KpScocLi4whd5Cb7yHEtsT1ZJ7L3Mon3+9tmuTJyu2QU8A7bcNAVK5UKarLutl
 8ZT5MxqLxeEgZWqbptIPyN5Ude6N6Xk=
X-Proofpoint-GUID: 17YA8CY2zlpbt3DUrYZ8No3_xMZWtoYO
X-Proofpoint-ORIG-GUID: 17YA8CY2zlpbt3DUrYZ8No3_xMZWtoYO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA0NSBTYWx0ZWRfX2VVFYHgstWeI
 GMfsNH6Ufoo4ha3wAahZ9DFR2mj7+oO233ycYp8NqXrE8or7WOepmw+UN2I+i95gpIPWb7CPaaH
 F8ciDEkTpuDnP5G/pssqo3CifbG1CV39SsFHTLfIcuFWhn4d18h7qkyrwwPGX5UR5y8hD14BsOd
 zlT+hi3/IJgU/fNfhBY/yjQWa7kV55gNbddYjRRE4C5/MjZK1NXOYyIdFskd2+Po6rfEAXXr0bM
 38cd4x0779nnAaAkTPF23+a/2uQMSKrTMjF0kxbQofqxSt1EygbOo75qaS0p0jqhF1usP5KaWDS
 +iJneeXM60M9sgTfVIPbIhqurs0ZOwvGgNA/GWLos2as92HwTq0w/D07gwGdlkUevUrqHcwHetG
 hvgc6WWb1lmgxihRGuczLCCt9dOBNDVfVtoKVm1GcsLLJqACktWjqSEPTnhjmHxSQeQVOG/tdF2
 7hSLN4yqHnJfBkTuRfQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210045
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/13/2026 3:49 PM, Dmitry Baryshkov wrote:
> On Mon, Oct 12, 2026 at 07:02:17PM +0530, Nabige Aala wrote:
>> From: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
>>
>> Nord relocates several DP PHY and QSERDES v8 COM registers relative
>> to existing SoCs.
> Why?
>
>> Add Nord-specific defines for the relocated and
>> new-only registers in phy-qcom-qmp-qserdes-dp-com-v8.h and
>> phy-qcom-edp.c so Nord sequences can reference them by name.
> Typically we don't do it, If something differs, it should get its own
> set of headers, describing all necessary offsets (especially for the
> QSERDES). Otherwise it's not obvious if other regs (without the _NORD
> counterpart) are valid or not.

Ack,

Are you suggesting that we introduce a new header file for QSERDES?
If so, we're currently using the v8 header. What naming convention 
should we follow for the new header file?

>
>> Assisted-by: LLM
>> Signed-off-by: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
>> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
>> ---
>>   drivers/phy/qualcomm/phy-qcom-edp.c                   | 7 +++++++
>>   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-dp-com-v8.h | 3 +++
>>   2 files changed, 10 insertions(+)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
>> index a3c893f72908..d5c6835b6c70 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-edp.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-edp.c
>> @@ -42,8 +42,15 @@
>>   #define DP_PHY_VCO_DIV                          0x0074
>>   #define DP_PHY_TX0_TX1_LANE_CTL                 0x007c
>>   #define DP_PHY_TX2_TX3_LANE_CTL                 0x00a0
>> +#define DP_PHY_TX2_TX3_LANE_CTL_NORD            0x00c0
>>   
>>   #define DP_PHY_STATUS                           0x00e0
>> +#define DP_PHY_STATUS_NORD                      0x0110
>> +#define DP_PHY_LDO_CFG_NORD                     0x00f0
>> +
>> +#define DP_PHY_TX_LN0_DRV_LVL_NORD             0x00e4
>> +#define DP_PHY_TX_LN1_DRV_LVL_NORD             0x00e8
>> +#define TXn_TX_BAND_NORD                        0x0024
>>   
>>   /* LANE_TXn registers */
>>   #define TXn_CLKBUF_ENABLE                       0x0000
> I'd suggest adding these together with the actual users.

Ack, I will update in the next revision.

Thanks,

Nabige

>
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
