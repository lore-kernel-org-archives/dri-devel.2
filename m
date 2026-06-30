Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 954DFC43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 12:21:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD96110E20A;
	Tue, 30 Jun 2026 12:21:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IQK1lL4o";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JyfC461u";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AAB410E1EC
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 12:21:43 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65U9nEg51590709
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 12:21:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OKA9ni/VKYiyOGZbetdw2GUFM0Wy/xcP3QxXwwJdhrk=; b=IQK1lL4oceipm8Q4
 wpDe0abCYCvbADeNXWX3gj3hyHy7jURTho8WgTcNP0wxHt9iM42a5wd1u/4ra8hi
 slQfbSxApQbzQkn8/8rw/U5Aie8gnKbUeQo73GyfSHmrz/dWJU0L41C2pCOKK+Ux
 eQKjyqY08FHK7bPN2E46E1JCFGqBqISg00TgsLFx+NiEjiPYYH01FCuafv6/DTcr
 zI2JXzR4UsSaslUZH89nqjJ+CIcWpYI258CT3uYhXgutcWX1OsKtcX3nMdwRsr1c
 6alJGvFylNA96g1H5P+qcJH/bFmFX/4BL4uCgiQv9zSHsVRPKJgbUp3dwNymm30A
 1zcuIQ==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3y9k3g5k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 12:21:42 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-96929cba004so119010241.1
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 05:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782822102; x=1783426902;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OKA9ni/VKYiyOGZbetdw2GUFM0Wy/xcP3QxXwwJdhrk=;
 b=JyfC461uYCwJN96kBL8V+p5qGM0GoTgn993Ih/guBoJU636NnSXtHQHwtCvuJvmyt0
 HKwNqbPPOKqB0MzlGVCpD6VEaxeZnKrlydpiTYMKqTYJOO1wzezWnQ2aU2wUTM/sJmDS
 GTIVrLo2QtXfPkJwRfA/0ntI6cLclKAqytuJGhwASAVBCAFlIW4xn1RWKG2K2eIDmLRQ
 U4ZViOLJeVaOa606atj2Dc+ZVe7hffTTBdhW6cnoyklExwSU4w8tXHO05+dxK2e3laFu
 eTWLy8oxppZcQCJbPmsr3ZP5quqY+K8bIcIFDHwJu9TT1dlfE4S+jdoCiYQJWBJMY9pj
 Tq0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782822102; x=1783426902;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OKA9ni/VKYiyOGZbetdw2GUFM0Wy/xcP3QxXwwJdhrk=;
 b=M43mXVBt2HbAkwlwIZr1VKd+MQr0cw6NsO91GlgXXbzUKqP+Wvi9VX/0bhTqUWFuzd
 VrLw86QkqWbhG5vsoztEZ1yJ+1LDM4IgB6t0vexJdl0FrLVLx6hY4mLdPRptLT47qGlu
 A2qqdt2Tbks9MUVLsO3uREVqvXB3xvhOXspTJxNTHmoYqmLCBAa86+Rh+f7dHEjzpdlh
 3VYoH+FRgAXpiZDdnFbvENKg2BgyUxW5GvfhY64fq9eeiZH9c3ORyQQ6Hy6EwB4ky2Im
 DFpNXXhIziwObfVY9AEKaUnfbD4YZsgf0HoLSV4oFuEG87moO/u0NWEG7cgGGayTRGB3
 09MA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp3JuSo2dWYNOvE6OEOtzIFJ5aqxBdbOU2MxgWzaxoF7Tn/pjuOyI7st+++rTyh9D4ntHwt5CdoQ7w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzrq2bvsQ1IbHN48PXKQWmXHaakANYEvQI78I91ITpykeezRI2a
 wAlZtlydQxrLAL3Fj+pVnsahJX2YKW0l5YYeCaNFkyRut/Vyl7ql1JY+QL6bKzw6GogQeYaNxYL
 /415KBQMGCYn9uzBa4TyKSwPqG/G0dG2geE5T0Dm+txBda3eszjgE2O0lE78aRu+Vud68kww=
X-Gm-Gg: AfdE7clIs3l+MO5ZGpzc2+Tp99NZA7DTT16v0LsY4XIARxXvC4l6QVbPjj5e2Ejf9Ok
 +lkHAhueU6HXZO1bwsPe8zq6EIyqzmYBw+0gQiWWQt1TUiIi/zylG4+42n5la12bohGYiCj5t73
 1+qudMiAahILcgg199zw3CjLv55ojaW2wZChil3ksP6pO33frfmQp6TOya0P+5jScOP2QdyRfsa
 viw5CLLpgam+8Cmj/KOyCai0yJYmzAsntcH2reIYJQyk0HmeU+sLyoI4qIcDwC19q2jEKPQ7mxD
 jfYxSmNdvR+wonc05WKMk0KxCUalTc5ac9uRvm9M0V8EcWfOmicbTO2ycJYbbpEhBehwKJB3Rnt
 IaA3RtwTQokW4G3Jn112kiNw3Rr7F0dqFDTA=
X-Received: by 2002:a05:6102:5986:b0:739:b7cc:3ce7 with SMTP id
 ada2fe7eead31-73a3934de72mr535064137.7.1782822101832; 
 Tue, 30 Jun 2026 05:21:41 -0700 (PDT)
X-Received: by 2002:a05:6102:5986:b0:739:b7cc:3ce7 with SMTP id
 ada2fe7eead31-73a3934de72mr535050137.7.1782822101431; 
 Tue, 30 Jun 2026 05:21:41 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6987c9503f5sm1104309a12.20.2026.06.30.05.21.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 05:21:40 -0700 (PDT)
Message-ID: <bd4080da-0c15-4142-aca0-21bdeaf9eb33@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:21:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/14] firmware: qcom: Add a generic PAS service
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
 konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
 akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
 bod@kernel.org, mchehab@kernel.org, elder@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org,
 mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com,
 mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
 jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com,
 vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com,
 amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
 op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
 skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Harshal Dev <harshal.dev@oss.qualcomm.com>
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-2-sumit.garg@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260626133440.692849-2-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDExNCBTYWx0ZWRfX25ZleeXJfTpD
 izNAU9iaRWTbe44t66kXMIqxF7d3pd3KZYH2kl58OyU8tLb0FLd3Z8xWNUNEXEAUNxOI1Y9ycyZ
 WKbMeOD6uoZ3QeVcL4V4rSqanUnjLpM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDExNCBTYWx0ZWRfX9vcBCuHZ8MkA
 Nw7LnoolNtsD7evFDGqv0/VGmx7BBeLdIagraX6jivXZcur9+kuM3svOolNWcZqH9FgKbZaJWPP
 Wte9Xf1HNzz3DYrl+OlrUrjs8KwqJoHA9WinHmfMobsrFew5dfflfSo7BL1H0Y94kO05f4GK40U
 DIvIERSRL+YU6t+Ol713hmGuA8Vrhbhg2lxw2MywKMtl+ao0EXq/WbIdv0kPVt95jLOTsnXeCdU
 4l5S1gnxcsRv/iqQ8Y5wMfmSWS+1TCUAfUcHT3kNeDrhZJoDAU5wnleVOPHmY1VUV2SGsgMLvRH
 h3XGgVdw/eIOwDiiUR/q2SzXvBopH1qNSdRSphiHZFxLSWIBu4W+YVp3BZZqALi8Xhu0utA8EX0
 wl9f9vB01Y6TUxouetZ2LC74Fx11u/OmjeV1O76JFPdySgnwASCTsjuZrX+KQvDexgAqP1TLZDQ
 WEWLjdEh2kwTnEeLALw==
X-Proofpoint-ORIG-GUID: KKkCx1Tb1VCWlsEvZifJxGetRX7XHuCM
X-Authority-Analysis: v=2.4 cv=TeqmcxQh c=1 sm=1 tr=0 ts=6a43b4d6 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=DWWpLck2SfFL7czMIZ0A:9 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-GUID: KKkCx1Tb1VCWlsEvZifJxGetRX7XHuCM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300114
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

On 6/26/26 3:34 PM, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Qcom platforms has the legacy of using non-standard SCM calls
> splintered over the various kernel drivers. These SCM calls aren't
> compliant with the standard SMC calling conventions which is a
> prerequisite to enable migration to the FF-A specifications from Arm.
> 
> OP-TEE as an alternative trusted OS to Qualcomm TEE (QTEE) can't
> support these non-standard SCM calls. And even for newer architectures
> using S-EL2 with Hafnium support, QTEE won't be able to support SCM
> calls either with FF-A requirements coming in. And with both OP-TEE
> and QTEE drivers well integrated in the TEE subsystem, it makes further
> sense to reuse the TEE bus client drivers infrastructure.
> 
> The added benefit of TEE bus infrastructure is that there is support
> for discoverable/enumerable services. With that client drivers don't
> have to manually invoke a special SCM call to know the service status.
> 
> So enable the generic Peripheral Authentication Service (PAS) provided
> by the firmware. It acts as the common layer with different TZ
> backends plugged in whether it's an SCM implementation or a proper
> TEE bus based PAS service implementation.
> 
> Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
> Reviewed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
> Tested-by: Vignesh Viswanathan <vignesh.viswanathan@oss.qualcomm.com> # IPQ9650
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---

[...]

> +struct qcom_pas_context {
> +	struct device *dev;
> +	u32 pas_id;
> +	phys_addr_t mem_phys;
> +	size_t mem_size;
> +	void *ptr;
> +	dma_addr_t phys;
> +	ssize_t size;
> +	bool use_tzmem;
> +};

Redefining this instead of moving the definition (this is a cross-
subsystem merge anyway) makes things more difficult, as there are
patches from another team touching this struct.. hopefully no kaboom..

Konrad
