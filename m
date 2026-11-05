Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD48606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 08:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=a8LwHb4Z;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VFFD7Izi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 554A910E106;
	Thu,  5 Nov 2026 08:11:56 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5ECB10E1BA
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 08:11:44 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A56Tocd3223016
 for <dri-devel@lists.freedesktop.org>; Thu, 5 Nov 2026 08:11:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mIPALp95eM3AkXFlvFAPjNiT6Aysu1euG/w9XR+z1kc=; b=a8LwHb4ZHdGn4MsJ
 20ov9kOlvbDvIQg0LABhso9DtRcQp9puWNQq18Ru1K6N0sJEiArvwPTGJaFrRozj
 khU8WPF049wZiIAsEJj/hAIT39GPXKalNdUrp1/EeOsaj9peDHIVkEVprYWY9drA
 l3z+XTvUcKqSsq3x8upVQPSQtbooBJta092cmY47+kBicyWl1KAOMtAxSAiW7Bl5
 PwoWNjVqm4tUPYx4yPpBf4Wlkwe6J5dEOFBf8Yy6BfF3T5W5sYlNcFvm7P6Ke2Sr
 5DvkxPkb2gVR1XA1seH38HhLXvDcReeBJq0r/hRYFWt1iTHaz/3Idcf8mNomwj8U
 SoYuZw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrj43h0gy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 08:11:44 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91e7c9ca738so3601496d6.3
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 00:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793866303; x=1794471103;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mIPALp95eM3AkXFlvFAPjNiT6Aysu1euG/w9XR+z1kc=;
 b=VFFD7IzimqA3nEA1Iz0ZCTN+uch96xkHukUjeRJuYACQMCKhL24w8xv3YAPRdp0Hqo
 /0JhGpCc/2mRjgK9Huxb/EsQriKawECFgm8kt+74hc79x/FEXEBdXz4HPh6zhk9gUOyd
 fT4b5QcaulX4oue0EMRAAywt9oX96jB7qYPlbDAiQC6N+LipAopxDe1LTWLSbCVm0AYx
 BI+aaMsPN3q81fSth/mLlN0UXULdErWVw8c/wsRQDLRPlfp16apByyHIOV5Le8r6n/7u
 3omns/aeMS8e2uBwRfLVkI4GseUY+YN3ljeLkBpQapbsg/eksbChvmsC59GYB7kNuBuT
 TGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793866303; x=1794471103;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mIPALp95eM3AkXFlvFAPjNiT6Aysu1euG/w9XR+z1kc=;
 b=Su65l/xOwkqcKUy1qvruwLwU6MFVoIOxvfamJTE9Ldp5HnAI4NTu7zbPhFlymPYbhg
 8f4CwyNVY7DWiP3UFSUKJps4/TSV14l0kQZNY2tGSVdLiRUDsxcw/GmJQwzGkjCXSzHr
 fE53NUKkDsok1ith8WUWx0bDNCf21Vnfp7rO8iXEZEVC9yDBkUM0WLRabhyNWOCNEsrW
 3ewmb5PNxG0UyBtOIh3M50MjFQZJou5oaMPq3mpA2tojgmUL66EW8df2F3ZGNcVQO/6K
 MeVYucHQ87BCHFnYVQTcOegwndhm/MPREZqdiTUetViGpXB+f+bqzFsZXSaKp4iowZBs
 29hg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxWG7LYKdLm1wc4rvSkEwLAGDS9EMdWVrHVMuwgwTUs1J2izgvdcBwopn5jvPNkM/BrnUSRbLseKV4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8N11s3+poeWMeujfPC4VpUFWv62hRcFiWec6TkxHmmGk9J/a/+
 5HnTzOZRMTyWd4t2SzA/zvXAiLPXIf4s5ea6XRrjOxBlBYlVsIhBsnJVxPS6iEij7Z9kr6ceLhR
 iBIKbQjExiDUAcaZhx+0lQm7Akws14h59FVko7ImgJ176ZgFsUXHvL8FtlOspRhd0plae9+M=
X-Gm-Gg: AYBFou08Ufikq4mxSA2Lxie3cv5/QrR9B6fZdWGMmpd4GNjs9s2rhWI8zY7fNhWNcG5
 QF9sXBdd0w7BZyR2R3ojtXcVus00w6T0zzXphngbEYYLw6cNl1Suc8j0xBQ97AESmt2lB5sEGn9
 eAS5PLKQwnQwLz6QNgjVZjZyf7g6wawed8FCsT62MPMkcdBKZpSSOjeELMOHguU8lW70BDpxcHf
 hka3cd90BVYo47e77wWlHcxb8SNJ/3GfgYxXWz8fQ+8f8fZn/vc3UJodc92V/m71RfjxGBlQvi4
 eLXpkeBtQaaAsx1NHOXJaaPJ4xhggP+HXA/1Wwq9oInF2OLy3b0+v6tPpYEPjxUSb7qSy3r46hJ
 lbB573T4rJ2E/RKg8FoHPm5m7+FVMZKlZfgsdXYGbTNZvx372K7OfC7hSudlKIcHu533P
X-Received: by 2002:a05:6214:20ac:b0:91c:7831:f4af with SMTP id
 6a1803df08f44-91ca4b63f0dmr405782996d6.4.1793866303172; 
 Thu, 05 Nov 2026 00:11:43 -0800 (PST)
X-Received: by 2002:a05:6214:20ac:b0:91c:7831:f4af with SMTP id
 6a1803df08f44-91ca4b63f0dmr405782466d6.4.1793866302702; 
 Thu, 05 Nov 2026 00:11:42 -0800 (PST)
Received: from [192.168.226.1] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d0e4a49fasm146003566b.82.2026.11.05.00.11.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 00:11:41 -0800 (PST)
Message-ID: <cd587c31-9e78-4957-aa41-53d568547654@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 09:11:39 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] backlight: qcom-wled: Cancel delayed work on probe
 failure
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 Kiran Gunda <quic_kgunda@quicinc.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, David Heidelberg <david@ixit.cz>
References: <20261104183935.1214630-1-lee@kernel.org>
 <20261104183935.1214630-4-lee@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261104183935.1214630-4-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: BqSXQdWCxx_2PhHZeowxS6OBvBFsV4--
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAzMiBTYWx0ZWRfX4mDcTj66uVNz
 5DsGydQfZK43rhFopMGHN0dwCPQ7QdGIIj4Wzdj3nlD6HXBgENA1wgvbLY/vauyQYbsocqMsHFL
 HOjf4re1SiCnN2/kKLfKZsMNFfWHLVgKAiRDBfzbKBVa5rdSbKz49fqqsPc/7N3e/K4hhflGgYB
 wnoAY/un5JlzoyTm10shQK859w2mB7kVE02QCWOgvQJiEK08ZzZXQMfbPBu9NzY99FyF6JWPHYb
 9W0e9DFQdqFg/HYfomsgmnGNopzFhJxdV+jFSkb35kmUh2ZzhDWoHRZe1Z24yRfuIv6xv9rogAP
 jb6DKC3DdCiDMlk5REA5FkMBoGuer2QrBySHDiSpawumckOR8IcbzicDxfjq4IJtxg67zLIF+4r
 FRqMFg5P51ehxm7q5MH7UgbHnOlGlubI8Q0NINCRQG+rIkpbl8T9MUVVUTQdYgNwG1cj7Bv5pQv
 YM0kuyPgfqB9KSJYELg==
X-Proofpoint-GUID: BqSXQdWCxx_2PhHZeowxS6OBvBFsV4--
X-Authority-Analysis: v=2.4 cv=SZdi5fRu c=1 sm=1 tr=0 ts=6aec3a40 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bK3wT2hOXHs123jOQ6gA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAzMiBTYWx0ZWRfX6w+t7EiUi+1h
 ZX4GPjvpuEkabgsDUENLEt3iHazYxxNl62g58AnW9u5H2vJYlieoEAvrKjA6arwFYGughVMm1J5
 Pis2lLb3OPguugavln5GYwAwqBXHLJ8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050032
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/4/26 7:39 PM, Lee Jones wrote:
> If a short interrupt fires after wled_configure_short_irq() has
> registered the interrupt handler, wled_short_irq_handler() calls
> wled_module_enable(), which schedules wled->ovp_work.
> 
> If wled_probe() subsequently fails during
> devm_backlight_device_register(), devres frees the wled structure while
> wled->ovp_work remains pending, leading to a use-after-free when
> wled_ovp_work() executes.
> 
> Configure the OVP interrupt first, then initialise wled->ovp_work via
> devm_delayed_work_autocancel() before requesting the short interrupt.
> This ensures that on teardown devres frees the short interrupt first,
> cancels any pending wled->ovp_work while wled->ovp_irq is still valid,
> and finally frees the OVP interrupt and wled structure.
> 
> Fixes: 8663c188beea ("backlight: qcom-wled: Add auto string detection logic")
> Closes: https://sashiko.dev/#/bug/linux-ca2e48a2-f511-44b8-a7d4-866f360bf107
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
