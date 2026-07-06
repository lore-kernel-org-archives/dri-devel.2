Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 003D4C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 04:55:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 518B910E2F9;
	Mon,  6 Jul 2026 04:55:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BtuYZphI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NyXBoUap";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A413A10E2F9
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 04:55:58 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66641Sxd3616885
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 04:55:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JvLKKEyLLlv8tWw8qJtzyelBHieDthun419uycWn1Dc=; b=BtuYZphIK7UnAPPa
 qYGHPuM+VD3C6WvezTLdqIjiYVGHLzNLv6RSapQqEJ2excDEyUkD/0AEcWQjp5ej
 4HI3bMiV8UCRYHw/YXMP72BUtTB2CANb5/xl2wJKaV5lc87Ax6wEFDsEhbUsTXur
 RNx2Hm91I1sPL4Fp17l4JFxQuB37ZPnouzzUHhLqbWpMJkm6xOuGNEQuSB8vkr4v
 iHs+mInjL3lcrCXDe3aaUW3MnfspbyT4APEA3ecMXRsbeK03HAVvm7fbyNR3ckpu
 4lDTqZIfECL8APV6bvyHqU87nPrqklBdw7zS2B0zT/os5ltI50S9QbhC5yDZwUWY
 z7D7UA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6s64mh60-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 04:55:57 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3811ae55313so2040861a91.3
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 21:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783313756; x=1783918556;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JvLKKEyLLlv8tWw8qJtzyelBHieDthun419uycWn1Dc=;
 b=NyXBoUapPeOHDBrZcL3uBCff31Dv1XEO+l575CKLobQOraHXbT34Siz+BmQjynCHtk
 BcNWjg2tAKsuwWRklh9Dh3hzInnwpkUHSL1Q58086G3niMAy81NspgpCiQ1reA92uE8o
 +Nm3Pbh+z5GkMZUNN1d6usxfu2jGvexqbiV5mUqC/D1pmH8tcafDvYkvEHSg5xpq2eyl
 KpIzP4XC6nVyt6s06AA65RsNkbG4IrSk3RUz3Qado5yjyXSzDUTn7mO0mO7SDAHXWOWM
 SR6J/HvjxXvtuGL80cTWAvrvJiuOZIIkJ+D2W603C+O9YPVlFgExxqW7S9S0eiMM+8kX
 famQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783313756; x=1783918556;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JvLKKEyLLlv8tWw8qJtzyelBHieDthun419uycWn1Dc=;
 b=piYE/dkrnlIn0kETOzzIZadSgspjXKAT8EtzzXK4RSqOVgXodemA1OeOk76WaPf5AR
 F8Vw0epS30mukmx+HsBpnbSeCKosU7huYSGjiSjCdet854g+pVczaRkOl/aYle9s42W7
 e0zeTrIrUjur7duhoOMn4Juw+FfwA5x3/ud0+HCO8yaHEgogITvDfI1pjpDsXibr561E
 4Y1OWuWxa7o7BbSORtRMlTq+qT4zKhFT4fIqlyk96sDBJ97GGY562TJ3fe/CPAlmnkwU
 Bnl6tTKO9npkyi8tp6dnYQAV8zwu2XdDtPUnf2CYwCziCi9/mcgD2tQYwT+FI6sVBdCm
 1bbw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro6lOhgaC7p82uzic4R6hJNdsIlHuf7735pJcoBVMY83u/cf6aS6l9N+dgIUC/8+gLLlrfQ7c8xDnQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwgRVPKTsCLS3IzjCYGBsYZ9hQ6+im3kZn3pgnbFWbloq/OqDyg
 VcwX/eLwChP22nOfussKLGG9iJ0pExU8Scr1bsJXo8KfEXE8LYp27fo3lbNwrGBQlEdY6wKk2rr
 Eua8GdwDWb9KuM0g79oBgmYNfj7lR4OSkBUnI0zNdWXoRArMxF1ElC1SwP34jUAw2E9eo7PI=
X-Gm-Gg: AfdE7cnE2Wh04NFcsq//vtOoHH1vm7HACJEZyD6xmjU+7R6Uyxt45axRTWzv4BUHK5w
 gwErZ4JpuoIgxfw9OOodUi7/xNSqvGNfYUuRsFjCwg8GfgFa/tF8cbMnXM1VnF/mtw0l/6bvLeO
 z0CuENk/qFG23xxVNIZMaqzIcxr89mLS+JKZOht079EKtRs9eWJyHMJdz675cghqT7mabFTKTNp
 vH+JCUVvsXG4xHP0pVyiCdQY6goCNqZsrMjOK5PhdXNWUc4vHNfZIQXiZ51WhpCBglcewRgShtm
 Dd9REprRaFOo4/OJzCfncpqNYrsaILuonzcOAPFqvw4I4WyI85rRf4GibZQFmCVsqamrzrPoNHf
 gujKoHXfAJ75sJzblWbZAoTtaF7BoOZ+Itin/aFfM
X-Received: by 2002:a17:90b:35cf:b0:381:9b7b:35e5 with SMTP id
 98e67ed59e1d1-382800d1a6emr8328709a91.4.1783313756484; 
 Sun, 05 Jul 2026 21:55:56 -0700 (PDT)
X-Received: by 2002:a17:90b:35cf:b0:381:9b7b:35e5 with SMTP id
 98e67ed59e1d1-382800d1a6emr8328696a91.4.1783313755987; 
 Sun, 05 Jul 2026 21:55:55 -0700 (PDT)
Received: from [10.204.78.130] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3114fe08b1bsm12946548eec.26.2026.07.05.21.55.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Jul 2026 21:55:55 -0700 (PDT)
Message-ID: <95e8281c-91e9-4444-8b83-ea87243122c9@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 10:25:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 40/42] misc: fastrpc: Use
 devm_of_reserved_mem_device_init()
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-mmc@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, openbmc@lists.ozlabs.org,
 sound-open-firmware@alsa-project.org,
 Srinivas Kandagatla <srini@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
 <20260705194019.2565498-8-mukesh.ojha@oss.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20260705194019.2565498-8-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA0NSBTYWx0ZWRfX3++eqo5Abeqy
 Flmygfx2GIYfmxgB6PhoCNbIfbav3z9am4SMYxjtdc1WarhBayDQEJUOyNkAfL8h5ekAPCr4fPq
 k1fttBGa2PZ8NEZFVmJui2S2hbgqIB50x9BsI42CiBEtwekDOlMNR6Kw907b14Qi1HxqDRoi4VI
 mXHdiFhqzOCyc1IcyU5MZEnnJjN/qjOiRRQZ6w0DqRv+hw4FqBFSjsLL5RFMNKWUR9RSVPhCY1q
 IIPR5UZp3gt0ki2zY66BwnSRAL/1VF2ehM0K4GMIsWfRr0iIhNVzk/rVkuifUVrKFMtjLnkUToU
 NQ3TvmgxEzyUrMvBWOsHirMVDMMi9xQqcR/3zfkWCTTgU/nSgPHecfXC6e98NNV2hYYXz/kebfq
 AqBIREGIAWt6QOS8cvi6akrew+M8U59Hbv0Hu5GuwOTbmY8fo/He1bd3fXQCJS284ldLq/Mtr36
 H0wwjRJ6yu6ck91HFAQ==
X-Authority-Analysis: v=2.4 cv=VvITxe2n c=1 sm=1 tr=0 ts=6a4b355d cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=ee02QKOXNWxg8IJ2rEsA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: s_tGYxaXVdznL5rrxYmQLw_qN7rQv6By
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA0NSBTYWx0ZWRfXw2YmeA/31ar7
 DpBdmRGx+13I2reDlbqKiBc54jdW1U0PBP0fFo/YP3xlWn3Y3QKLmIhjSqGXJkqORwdXFn0A+VL
 m/mGbgD7KiuajS5jekURWsjLnyKG/2A=
X-Proofpoint-GUID: s_tGYxaXVdznL5rrxYmQLw_qN7rQv6By
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060045
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

On 06-07-2026 01:10, Mukesh Ojha wrote:
> Use the devres-managed devm_of_reserved_mem_device_init() to ensure
> the reserved memory region is released on device removal, fixing a
> missing of_reserved_mem_device_release() in fastrpc_rpmsg_remove().
nit: I see this change is also fixing fastrpc_rpmsg_probe() early
failure leaks as well as -EPROBE_DEFER retry paths which could be added
to the commit message.

Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---
>  drivers/misc/fastrpc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index d86e79134c68..c4e05b0db527 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -2396,7 +2396,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  		return -EINVAL;
>  	}
>  
> -	if (of_reserved_mem_device_init_by_idx(rdev, rdev->of_node, 0))
> +	if (devm_of_reserved_mem_device_init(rdev))
>  		dev_info(rdev, "no reserved DMA memory for FASTRPC\n");
>  
>  	vmcount = of_property_read_variable_u32_array(rdev->of_node,

