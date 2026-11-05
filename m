Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92277606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=memcz5aT;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Oj5YpNvk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1A1B10E0CE;
	Thu,  5 Nov 2026 08:22:50 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7272910E0CE
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 08:22:39 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A56U5gY4139280
 for <dri-devel@lists.freedesktop.org>; Thu, 5 Nov 2026 08:22:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ix1+20DyoRCGmBOgAiA9EOhmvPdqx6nMCYqJ+YFb1H4=; b=memcz5aTefo4KGOZ
 rgWnJ/uabi3neKbmngooBNvd7gHrIpsZOx1v8gPp01TSx/0fhIHBJqOv+lwgFfCG
 47mYl3Tw62xnSS9XD1oqDXhK5a/cCwCK/aVh3WfzN4HGy183y1iKNnw34xGH7CNM
 4w8Z96I4V1sjRr/VMEsm3PlWdHTFJ0E+2oc1RrYHWy+IF57bJtBK8XPAutXx1Gnr
 5SnOA9FmmYdNboeTIRW1b2MUIOABLurLebyBAgssvIq6xdd4XnkDpyqgfFtQCrlj
 MgZaKBrrCyBTdr6m9HNGLaIGAfiZOPg0BL/B22YQa/XLqzoZV5RttPlEF0V78/Wo
 +SaTBA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrm9v0gsf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 08:22:38 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91bf35c4c78so2618446d6.0
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 00:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793866958; x=1794471758;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ix1+20DyoRCGmBOgAiA9EOhmvPdqx6nMCYqJ+YFb1H4=;
 b=Oj5YpNvkibFSJcKHAXFktcifMazslI8/niW8k42epLYz5XpWBYeHo2VmMn1TdV/VP1
 Y1FavUzaUcuOJRzOfzGu1TxaTAnFVJ9L6mEBh4RUmkCGIpPtMgxVgQNXt06Ks/i4inYs
 cYVqbFg6bGyBmW/so89G5MuyCE2fVyKJ96MlPFJNbz+eZ0rQc8QDxtz+jnmw5d3+qfhL
 ORQgeCSncb7ggvvyndbHoWDXSQM9D8wz2UwNxOqOvbwpdF9iLjuYvhkf1lVbZ/+dstrq
 kHU07JO2Rb3q8GewRd2cCMXeAyinwp78j58xcT2512B3DaaQM54NFUJSmWd5HX6PEAt/
 js/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793866958; x=1794471758;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ix1+20DyoRCGmBOgAiA9EOhmvPdqx6nMCYqJ+YFb1H4=;
 b=Uwf/WkUtGVMp1sH0mxk/FZf1x/kn612N43h5RITGsYF+nr0gEe3v8cHzW2NfOeNeJS
 eEgbuE6sawh/PCCWqas9WfLgcDwGQbOEU2CEsvDPBIsaTnuCYqAVY+gT0u4V1sil8Yi+
 TRZIeKDnatfpgVpidz2mwIDVgbDlhzmmI88fM6Urvhy4ynyi9Y7+eVAVhi64jIHzDdoj
 fn3CiXs9zAy6DKfjUAxEVMMhoxq5mpPH0EhM2vupzoXK2+xDrb/3hzU1L3wkF693M1Eh
 BOXb4FGSZYGpcyiY2rSnCzo8xNZnAOOY4tsCINCvpYHnT+jtrjJ2K9bpib0UfMK6ElJI
 EanQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy6faTNRNqACq+5eh7u1aAXihzw9x7GbR+xTMTSm0z3XSHENnLOZZt5OHj4qB32WA3IVLGErNMv9TA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+TcRXcdCPIUIMBo8ZrD9PnuW6iJW9sMb4wsyXVCq7TV7vbAkdY
 2PGQocSTRMWFaxSbbRJ7cZqtG3fyyhhoLiYgHUNBPHn1zgrhjmldWo5I/OVi5MJs5GY0oD8SdCC
 YujmSawXttLL8TOdKMTbA7K6+7IRpCCED+R9KQ/QawHM+RILCb551uVxLAfoAYmLn7atY4v0=
X-Gm-Gg: AYBFou1B0gYVysYX527hN7ODEi7PPcOZZ/c3cembXkv0EmA9Fbym3L4lUc+Oi7eP/am
 rExRTj+c3JtyN6z+4EyUheFqGVebB/2A9utTPfbBPwIK1YGMt5S7glxZU6uRk8DKXhhL/pWl585
 KXVmqBLDpcPuA1Ir4e9r1/wTOMPpIwClDiOKdxOPAGtwunLP6OGaTZ2X97e9SDxRLXxtqbmfEOt
 yodox6y5xW8RZLdblwDvBtIV8cTxwe9oDm7N50H4Cz6co1Nk9rZwpiSmgjvWSVxcaNykwp8Oo4K
 4UGDcw8CJY267WwTn/L9ctiEnZb8BvyE2QGES6GocK8MmON5Lf1qKJYsy2ykQK/e7U3xUum0u9a
 uUOWpG++vyUDkoNSG7osWQRgFjupP4fv6H6CZIg07K2x3IJ7FeEHO5kaf6+kHA6Q/kJFk
X-Received: by 2002:a05:6214:5284:b0:914:521e:7da5 with SMTP id
 6a1803df08f44-91ca49e1e07mr371652946d6.1.1793866957748; 
 Thu, 05 Nov 2026 00:22:37 -0800 (PST)
X-Received: by 2002:a05:6214:5284:b0:914:521e:7da5 with SMTP id
 6a1803df08f44-91ca49e1e07mr371652436d6.1.1793866957143; 
 Thu, 05 Nov 2026 00:22:37 -0800 (PST)
Received: from [192.168.226.1] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b57e26b0ffsm438510a12.32.2026.11.05.00.22.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 00:22:35 -0800 (PST)
Message-ID: <2711cffc-81b0-4078-b3a4-decad4969e33@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 09:22:32 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] backlight: qcom-wled: Avoid AB-BA deadlock in
 wled_module_enable()
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 Kiran Gunda <quic_kgunda@quicinc.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, David Heidelberg <david@ixit.cz>
References: <20261104183935.1214630-1-lee@kernel.org>
 <20261104183935.1214630-7-lee@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261104183935.1214630-7-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAzMyBTYWx0ZWRfX+/oE8R2s4Kwv
 UlpwNrFVbMJkzssqnEedny1HYKG14MIhPF1A6Hg6Z1drni08/BrRteeNzy8FTNjq6d6U0cQda37
 GXMluM25QhJnv9RCQBOUOnE1Po9BiFY=
X-Authority-Analysis: v=2.4 cv=KrHYSmWN c=1 sm=1 tr=0 ts=6aec3cce cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=cyDCuRFuYf_2H7WJZrMA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAzMyBTYWx0ZWRfX8KOXIbqVDhZO
 IgvfmfJk3zS4Q8ZwzS39UgINc4XsZq+yJ68h3rdxRYkAPMcHYti4LL5/QL+Wv9BC6qSSvhsPCPb
 x9tdnnEZnCivHv3DJhJryaJCvE1QuRRhaJRkXcZpYozCH0Vsu14a7YF/+AMu6lq5N6hwwqxRktk
 wFy6JXHnuf+dvgXsyVDlsh+2702KL9SvjMaJsRkfb9bcx+kjv3WLnJNj3I/SI+RbD97kHK2Btas
 HLuuPZS9/mbDjeLfKOpha2HHrsxCMaBVqyJMI9eYg53ZWFzU63OdlfcWstDrT14bfo7R11ZKB9z
 uP2FzlexkSiS7jmqb+b4qbvUmQsDmJocqKBLod55uQgaQRtI16dPYrrtk6i3jhptfpOPunPNmw6
 kd45No2bVLqF1RwCeHp0ijEo5yN8XAqn4L+39bqq1aNDiLXxtlvHvFEuU1qoK6MnyMv1Q6v0x+8
 +SksqJE9W+d7Xn0sbGw==
X-Proofpoint-GUID: N1obUSQtG5cyJOgEch-hG4nc6vuvMox5
X-Proofpoint-ORIG-GUID: N1obUSQtG5cyJOgEch-hG4nc6vuvMox5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 phishscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050033
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
> When disabling the WLED module (for example from wled_update_status() or
> wled_short_irq_handler()), the caller holds wled->lock and invokes
> wled_module_enable(wled, false), which calls disable_irq(wled->ovp_irq)
> and blocks waiting for any executing OVP threaded interrupt handler to
> complete.
> 
> If wled_ovp_irq_handler() is concurrently executing, it attempts to
> acquire wled->lock before running wled_auto_string_detection(),
> resulting in an AB-BA deadlock between wled->lock and IRQ completion.
> 
> Use disable_irq_nosync() instead of disable_irq() in
> wled_module_enable() so that the OVP interrupt is masked without
> synchronously waiting for the threaded handler while holding wled->lock.
> Because wled_ovp_irq_handler() may already be waiting on wled->lock when
> the module is disabled, verify under wled->lock that the module is still
> enabled and not disabled by a short before running
> wled_auto_string_detection().
> 
> Fixes: 8663c188beea ("backlight: qcom-wled: Add auto string detection logic")
> Closes: https://sashiko.dev/#/bug/linux-3afa151c-7b8f-432c-8f85-8c43a83b964a
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
