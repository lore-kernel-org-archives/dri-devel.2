Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E31CD342C
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 10:03:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F89F10E3D5;
	Mon,  4 May 2026 10:03:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="blFGahv9";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZakLLLIO";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37A4710E3D5
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 10:03:22 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6448fI5c3824004
 for <dri-devel@lists.freedesktop.org>; Mon, 4 May 2026 10:03:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dIOaP3I+69NIYahYhn7ZP8dTcKbC+Rx4d1eqqv57oN4=; b=blFGahv92s0HUYjT
 Ihj7OOX/CnOH7LuU5MlrBldveiHSlAs8JLotz5yKAVYzJHzUZNj7s+B7yxCABZQr
 MIeuOap/tRS5v53jzGhONjBC3KV+HTbV+7D6vRW/eLiAunSL1Um+B/R9wppgekbr
 MEUqeXNAyibnAYw91s8LSCwst+PaDxQLLi/30M6EKIHKDEoyTMDNR1eh+c3v0CxB
 wFIh6v4C/U9MaZmtQffoPeagpZF0l4N3OH3roV/REe8FlXEloX5t8SMrJggV/FkQ
 3AgBiYK4NzS36r3ZDhDDQ7ItYyL7R5m9fW/5iHrSm0iYokJjo0HQnTlVPGvxZXrJ
 gYLCuw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dw9g3n86u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 10:03:21 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-36514eb1194so3067821a91.2
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 03:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777889001; x=1778493801;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dIOaP3I+69NIYahYhn7ZP8dTcKbC+Rx4d1eqqv57oN4=;
 b=ZakLLLIOfqvUBWoboRRsGO08+byopKHZ1Dw4A/mQDvto3zV41EZk7mZT6uU0huks+L
 OPDiAEOs15kBfvbZAfleaWnNILaQ3L/PNxrkkxgJHzcVqd4aXoLC1LEgg3V4s8uZRgU7
 Eit/6XJo3SPUB9KyEdqqVrcpm74cbspuXYTdWKvxx73kKUlidt44Z+uqSBxdjpn8+OnR
 FiLbJwjVHhUNyCiW62hb/7QMrXPfcaM1WSXOoPnnOLwzOB+EQWGUBA9tAkkG3kl9nQyU
 qFu29sugqAMlBR5zvMut0Er5LClqfJQ4kB4YiJK/4O9omj/H/a7uNIbOj6j9kmQlx787
 BFQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777889001; x=1778493801;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dIOaP3I+69NIYahYhn7ZP8dTcKbC+Rx4d1eqqv57oN4=;
 b=OrJ3CFYL69UsGQulEHpehi75MUTkLU2+cSqALzocdQx0SCj5c2hHUDDbRFLJXxPvu2
 wTR4a4Dzd1R8iIGqn7oKuR+OqoDCG7sjsfRjpGOK2+maHEac5JV/yQABovnYXGUqwqv+
 +n6O7KIKuHjZKiVQzoD82MYpY7Qt/dll5n3pbkzMoVUxNkA2eBe9Id57hRfzZtqAYz4O
 I785mp/IvBjzaoOV53O96fy1hic+IXnviiFzYwWeI4REiWo44/0l/SzBQ0BeNqwR1L4p
 VkaPyCzkgB/aH3BsZ+ENGXk2e9b43/jlXMNxO3vdBinooie7uyY/NBhgRdZ+V+JiIhGP
 V2mQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Ls7ZQFytwDibv9RuXRZrt9GS1ifkirTAXf1YyIAnu4I06Yhes3KdUI25krEcnpRGpe5+oZmLqv4A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyZDwufwhP5ZKX51Ii8ds9KmYOTBFN7NQhaWdqokx7C4O8TLSR7
 v3AtTvzaok/647+fNMk7Ev0cIEBnP1FWFFs4Mzv/b5LLZKY+ML5Fm1anKv2nHyQBgVroYo0cmJP
 vmNRuDieW88TPz9cuIl5GWe5YCNPrPTcHLOo4QdFya2dxxILLYbBQ56eiR4Qe73QaMpmU/gk=
X-Gm-Gg: AeBDievE8x9n+JOXBr+EFnvxZCMZRlIMvHluId4mTYczlJdP/1yGxO6bkSPScSoRjT/
 QEUFaxjzxpnhmtCNOAiF8S9O+5uOEejdMSA3chifS95MT7udCrxGQdHMMkt7PgzMm3Xkv/wI9An
 OKhoz7bktcykNc9/PJ60FfZi0N7r+swlS6+CWGZ66OmNMrFxJNN/fTUt3zLwxSPiiUumOZ03Cb1
 9bPpSvm93CdLIiMpiu19iDtRYg/xuBEeXulctvKbO5M7bckzk/OKcgWaiFY/81KfY/jud+st5yW
 ZwyqtwnEI1PQ/eddoixirNH7n8o2SaD6NZ8QDZC3jHN0yf/99l35sAWBEb4FgomUAsP71oBwq7y
 Q5dC2EJZGF46zQNK41OZ3W982U46sIc4qDi/13nLy4BtDiqAXJ+nK5FDh16pzRg==
X-Received: by 2002:a05:6a20:3d11:b0:3a1:76d3:c1b0 with SMTP id
 adf61e73a8af0-3a7f1cb3fc7mr9308966637.22.1777889000709; 
 Mon, 04 May 2026 03:03:20 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d11:b0:3a1:76d3:c1b0 with SMTP id
 adf61e73a8af0-3a7f1cb3fc7mr9308931637.22.1777889000200; 
 Mon, 04 May 2026 03:03:20 -0700 (PDT)
Received: from [10.217.223.121] ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7ffbba8fefsm8933909a12.7.2026.05.04.03.03.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2026 03:03:19 -0700 (PDT)
Message-ID: <ab4b5257-92df-4201-ab04-436ab77b2fd8@oss.qualcomm.com>
Date: Mon, 4 May 2026 15:33:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/15] firmware: qcom: Add a PAS TEE service
To: Sumit Garg <sumit.garg@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
 akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
 dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org,
 elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jjohnson@kernel.org, mathieu.poirier@linaro.org,
 trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com,
 pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com,
 tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com,
 srinivas.kandagatla@oss.qualcomm.com,
 amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org,
 apurupa@qti.qualcomm.com, skare@qti.qualcomm.com,
 linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-5-sumit.garg@kernel.org>
Content-Language: en-US
From: Harshal Dev <harshal.dev@oss.qualcomm.com>
In-Reply-To: <20260427095603.1157963-5-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDEwNSBTYWx0ZWRfX1aC/Po5jAtHL
 XX0SnKTTTmmqNkdtf8KG5ji60rwuxdPbYrGZaXk579jKavOkMfMYHLpKyx96xDjH+ZlQatySZGg
 vBBhwOqRYhCuRzQy3wzhl82lJmJnq97NN/8g/8qPIYWl+hwkkLa+TW23HMlUfceIVDgf2k0e2Km
 OUiMLnevmWW285p2uZy+mehYrq7jdq6RLyYJEPdVF4xVecDlT62SaVK4cHU5bxBYHLg9KyY9Psl
 eNEKgiXV/FfwJHJN3ZwPHSy8qssI6KCLMI1UN6Pnvp4pRKu2LpNEtu6v9jM/EU6Y/U9wQjmjA4T
 NwKl6ISrn0L9c5JrEjCWzW/yHG3W0LIYe0WkAke/4gw30oQEV537FUZORqM3EcHh7MJB3ToE3Mk
 kWga5+6LQNECBfRmkF87HhcPPS5hBlusb5KCW5sbIzWh3A1jWHnffHCRbvGNNj46z01JJEbQjUe
 PLxIVsqK+uqgXo08hjQ==
X-Proofpoint-GUID: vX_VhvFDBUhrtH8pnfRiX6v5an8cBA4V
X-Authority-Analysis: v=2.4 cv=Ge4nWwXL c=1 sm=1 tr=0 ts=69f86ee9 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=6olnGIjaqZ5DSDVW89IA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: vX_VhvFDBUhrtH8pnfRiX6v5an8cBA4V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040105
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

Hi Sumit,

On 4/27/2026 3:25 PM, Sumit Garg via OP-TEE wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Add support for Peripheral Authentication Service (PAS) driver based
> on TEE bus with OP-TEE providing the backend PAS service implementation.
> 
> The TEE PAS service ABI is designed to be extensible with additional API
> as PTA_QCOM_PAS_CAPABILITIES. This allows to accommodate any future
> extensions of the PAS service needed while still maintaining backwards
> compatibility.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/firmware/qcom/Kconfig        |  10 +
>  drivers/firmware/qcom/Makefile       |   1 +
>  drivers/firmware/qcom/qcom_pas_tee.c | 479 +++++++++++++++++++++++++++
>  3 files changed, 490 insertions(+)
>  create mode 100644 drivers/firmware/qcom/qcom_pas_tee.c

[...]

> diff --git a/drivers/firmware/qcom/qcom_pas_tee.c b/drivers/firmware/qcom/qcom_pas_tee.c

> +static int qcom_pas_tee_mem_setup(struct device *dev, u32 pas_id,
> +				  phys_addr_t addr, phys_addr_t size)
> +{

[...]

> +
> +	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(dev, "PAS mem setup failed, pas_id: %d, ret: %d, err: 0x%x\n",
> +			pas_id, ret, inv_arg.ret);
> +		return ret ?: -EINVAL;

Following the example from qcom_scm_pas_mem_setup() here:
https://elixir.bootlin.com/linux/v7.0.1/source/drivers/firmware/qcom/qcom_scm.c#L778

I think it should be:
return ret ?: inv_arg.ret;

This way the client (say mdt_loader) knows what error OPTEE PAS service returned.
I can see that is tries to print this error:
https://elixir.bootlin.com/linux/v7.0.1/source/drivers/soc/qcom/mdt_loader.c#L286

With that,
Reviewed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>

Regards,
Harshal
