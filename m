Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68261CD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 11:40:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D672C10F039;
	Wed, 20 May 2026 11:40:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bjaqrLMR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PeRIFbSD";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 056AF10F039
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 11:40:28 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64K9nXAZ446929
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 11:40:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NKD+goykCEWe7P3VDwM4HDQDAaDkCtngcJEhO1J07pU=; b=bjaqrLMRChx1UJAj
 B8kV6Gb1S5Me1buGmKtvQPqBHfGBXfSoV06zU6alnNvX0KF5+z23Eekr4Wrlq8iz
 Ah0vk5Uj4wsTc7cp6HxLGhQluy43lVbXKca6T7Im8cPk2avrvUuScNc5hlpzPI6q
 50PaMy0x0MhPQzfiYA9YNyNHl9QkOmn61jC2Q3xjwqSJcSK7IFYLAPp2GzawaZ2Z
 EG94rlNTD4ILMYuK5els/mADZt9F6TMjJ8G+KNTsrWO/cKzyCIAs8xrPm/GLM0Wx
 dr7e6RQSg5BE9YwgmXV+EucH1wZOlzLk+GqNfGWz6O27c9KauOBhxkKDEQVyPg5p
 HBTk1A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9anrgcy2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 11:40:27 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50da529ff48so132885501cf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 04:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779277227; x=1779882027;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NKD+goykCEWe7P3VDwM4HDQDAaDkCtngcJEhO1J07pU=;
 b=PeRIFbSD632dPRMIqqmN+Aqjxt7GZAn4ciy8cfJOTGT9OeHnv+BYVFt8Ltv5OiO/lw
 ALnovjY6oeB59XnZ7dqH60DJlzG5tvA0xOBe18mqsKlkDz+yEJ2T4/ROjmlDtOGmlq3/
 129DCc6tkcxiFgDOXG6E63qEF8wVjK4pn+kT183gwVHyrZxmSk0v89herRvOBF1g6jJs
 9HNOWVJVTZLOvY9h2Yv98kSTn9GD3bKa9w5vMJk+ULo+TzcDg2XYXoXprKUZ/XW3Z7xz
 vdWKyXeIEu6BIIgpnahoP3p+OPEtgjLwi3ZuUsDrehrw6H+ecinRaG0ctz9nxQ37Qvn2
 S1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779277227; x=1779882027;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NKD+goykCEWe7P3VDwM4HDQDAaDkCtngcJEhO1J07pU=;
 b=lS35etYglHwRWjdSfWjKEJQwKrAOePejgoPlhkVPvR/iKpaUSut1Ew30wzs0onTaXb
 IpIGOxJQQdftjWceTyTkUv0879wbd1ClsLlq4phgdUEvUTT5KnLF8di9SIEg/TynAVB+
 TcwUWWsEhblalbaka/xZC5zN+b1TZ9PYFbzNKWd7gnrkKZaK9DkcxHCsjsF6is5njGhx
 hE5/CWRseiVIn9ujnhkuV5VUOKlV2qOE9kg6LmqCHCIex4LMiMVXT5I5xc10/gA17KLb
 IfFeBViMDrpv/H75SgRE0N2El4ysRBFqed1a3tOa3FyJymEV1hzwroBhqTxnCrZO47ol
 HOzQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/fTpPM10LKb+DbfiU5H3VvJ20wp2T1WW6xka/8bNxivCglSD9MG6O7ttAc5KSrUJmhw6CbE1L0EFQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxeeHLG5sMpsrg4tmE1kEaRWxA6AC71bPad1NNui32Fuh7zR+i8
 H4xOK83mNCrePxB1iXrOMgCVUQCELWJfp4ZxtybEQPiRi6GPCCKs3S8tTbmFTBcjbx7/S1+xwXe
 Q9Uupr0gvpWuQsPtiGz6wfLnGpritHH2JNMaJk1aLlOcRvks9JC6S7cA6JrziGftWyNH7uyY=
X-Gm-Gg: Acq92OF0sqw/Vxnfp0UZy6kLFcMugWIDMA9goG8Sy/r4eKLHxv5mdCLfK+jI7YnKlAe
 WsI7PZtWvPXGXirjaa4SA1p7eVIbZ0jZnN8dH3Bw97XOliODxBGOd4kJpN8Jp8tZEknclqWCMjl
 3lrFomTgyoWJ8aRggdnYVRvj4ysyKv0lq3usT2HgYwYYIxI/cpj4uyeMgGhYAqfS4+SItSBYTF1
 xvdMudU84UacilgldTalVTv4hgcIWgSD7fGGu5tKY6DjUpxYHqz81pNcihGlv9xdE9wTI1nUYOT
 caPYUhuI/FUIUOt5DRNJVV3+xHKwJCfpmv2jbJE/0abyV6Uhfi3tCDIsjhSdBpavUXubFvA0Gj6
 g+eybgpjahiEOsTIYiL7GguTNhqa6+HgGLwnuQo953HY1Pxu3
X-Received: by 2002:a05:622a:5c9a:b0:50d:8056:da41 with SMTP id
 d75a77b69052e-5165a002bd4mr327620101cf.2.1779277227249; 
 Wed, 20 May 2026 04:40:27 -0700 (PDT)
X-Received: by 2002:a05:622a:5c9a:b0:50d:8056:da41 with SMTP id
 d75a77b69052e-5165a002bd4mr327619641cf.2.1779277226827; 
 Wed, 20 May 2026 04:40:26 -0700 (PDT)
Received: from [192.168.68.125] ([5.133.47.210])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-48fe537c788sm372948175e9.12.2026.05.20.04.40.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 04:40:25 -0700 (PDT)
Message-ID: <83a1cb82-add9-4896-8fa2-8550822b795a@oss.qualcomm.com>
Date: Wed, 20 May 2026 12:40:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 5/5] arm64: dts: qcom: glymur-crd: add Audio sound card
 node
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>, robh@kernel.org,
 srini@kernel.org, amahesh@qti.qualcomm.com, krzk+dt@kernel.org,
 conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20260325035338.1393287-1-sibi.sankar@oss.qualcomm.com>
 <20260325035338.1393287-6-sibi.sankar@oss.qualcomm.com>
 <f097c75a-0c33-499b-9910-b23182d4472b@kernel.org>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <f097c75a-0c33-499b-9910-b23182d4472b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: CdGtoNn-zN8Q2MI_Aas6EZY1uMGpphCh
X-Proofpoint-ORIG-GUID: CdGtoNn-zN8Q2MI_Aas6EZY1uMGpphCh
X-Authority-Analysis: v=2.4 cv=UuJT8ewB c=1 sm=1 tr=0 ts=6a0d9dab cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=7MBKnE05AAAA:20 a=EUspDBNiAAAA:8 a=Wz4qH61WVlOTaqajxdAA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDExMiBTYWx0ZWRfX7xkCYmWxel3V
 +Ntc0T2mrk5XlNDMpgFQ57tPO4788AKaDNNQOpnBqhUKHEUgAfIEeSfmKsJQjjeNr1Y3B8cqtE/
 04qnsEPdvLJoFevnuEXcMpRFl2Qa28TAoRkIa+JeYlTis9pKKqdog2ZcihgT3650xT2qVFi2HZ4
 FuID+8NADEwEY/9w1K3UnP9GwFeskr9NzBPBiVNPsxxdB/Y23+NtGl2sHypgmvjZkOmLHYpDnFg
 t8YT+q/FrkrhdSizvkSnu39QXbn70LDZ/5udaN22ISq/NrRnxWsOuEblLkS4d3vd3sUuwdOXZ+f
 AMRC2m+/PmDBlI2GY9n3aPNOuFYKM6dBQ0OSoq9s1N8ZhmJm0bGu0IlskVei+pZ5E0CKX+HUG1t
 mgB0xS95CtXgnos9tMddPAXucTQyBikGZFDuss72azmcsjgIS5LKabn5QzKdZsUAVY8IyDfFRcJ
 pOgPzYRjo0Gb9ntvQkw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200112
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



On 5/20/26 12:29 PM, Krzysztof Kozlowski wrote:
> On 25/03/2026 04:53, Sibi Sankar wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
>>
>> Add the sound card of Glymur-crd board with the routing for speakers.
>>
>> Add device nodes for the sound support with WSA884x smart speakers
>> and playback via speakers and recording via DMIC microphones.
>>
>> Co-developed-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
>> Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/glymur-crd.dtsi | 110 +++++++++++++++++++++++
>>  1 file changed, 110 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/glymur-crd.dtsi b/arch/arm64/boot/dts/qcom/glymur-crd.dtsi
>> index 690b90e3d6ce..88a5c63e8ac2 100644
>> --- a/arch/arm64/boot/dts/qcom/glymur-crd.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/glymur-crd.dtsi
>> @@ -118,6 +118,54 @@ vreg_wwan: regulator-wwan {
>>  		pinctrl-0 = <&wwan_reg_en>;
>>  		pinctrl-names = "default";
>>  	};
>> +
>> +	sound {
>> +		compatible = "qcom,glymur-sndcard";
>> +		model = "glymur-crd";
> 
> That's not the name which was already used in Audioreach topology and
> maybe other places.
I agree this should be GLYMUR-CRD as per
https://github.com/linux-msm/audioreach-topology/blob/main/CMakeLists.txt#L24

--srini
> 
> While it is fine to use whatever case you wish, please also fix that
> users of this name.
> 
> Best regards,
> Krzysztof

