Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E57606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OciRNu5r;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XS7khJEn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBF3F11297A;
	Fri, 27 Nov 2026 10:07:00 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8B20112977
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:06:49 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AR7Gd6J3983889
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:06:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1cqOkOwTUiNbtXA/P+l3ub34LY3g8DzoU9NlOJ8Fz40=; b=OciRNu5r3b+4XTi9
 ROtp0BI/VNQVDPsRbs6EjwVfY+jodjX0822oS+lLznsciTOok1dBwgRMkTthHyHU
 0FuFuetkwKEjaelwBUMMOAq6ol8ush/N+k4KhmyGVXmlk43BmwKNUZKqdrw/fZUb
 ejWUz1WPGGEMunCziZLJt8NAUU7Wq43XUfuGLSjn5OxDNqNIkMiiqo0KcbyAx3xC
 ydqJP5sNTlPjMiJsD27ZLiXDpojT/nAGOTJ3CSRGKMabHbPcei90BfeexzAf5iFL
 9ZYNW7f6UDeS4IglKNGloxpTJDox0RCereWcaZfmsYmvPahtf+gVLoHoKsDc334F
 SmMefw==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6u49afha-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:06:49 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5eab0ea26afso298729e0c.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 02:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795774007; x=1796378807;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1cqOkOwTUiNbtXA/P+l3ub34LY3g8DzoU9NlOJ8Fz40=;
 b=XS7khJEnnmEBArr1Bcl6VMO4XfMU/4T/iGpTu6JZJNFP13Mok3BRCef4GZhV3tZzg8
 AnoHEDRHlxAgYuhZX+FVOYbYmbVeAI1kt5zGhr4HKeb/FWrYiHAaOL15Fq3fh+EbyPLM
 eklXEjZUc7BTpLrbWEx2ZA5oZi1BVlMK+wigw3e806Nh6DD+uFD8xBJIzlJEmg2Ny/0c
 fZae3lr8IxRsE2mW7mo2YZIUUkxI8zgoICKq2sM1MDM5ayZlquGN/Vt0Yme8sCzJeYVW
 /2iiOwsTlHI0y9G5CFmPYoG72O08v1+spFfiRk63oVHkLmEih3OJRQGqYjpA2dByoxqA
 1x/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795774007; x=1796378807;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1cqOkOwTUiNbtXA/P+l3ub34LY3g8DzoU9NlOJ8Fz40=;
 b=Px2RGGZ7cauN83OJPOzT/pOeIjR5vak3A8dFNzSpVaJJZJZ0blfZT8zR23+fKQxOT+
 LOlJNSaqtQeD3DmNUTQPj70NkIKeiaBXoU5iv0g/0/yTfr4dF9fodRNRvaIXvVwL1vx3
 Mdmz8gChKnBqVSRZIxuV+Oa1lF5qUKjwIQIiLHqiQl7vmtgafcuzmds9t3nmkKiZlwRA
 VhdTZfzKQgKSUupYS6nc2pj2ZmpTP+PHsWAoudwI/OLeUsja71+SnlvTv+3ONriWWgzR
 kNsB0iI0YaFYxC8q7D8m6nu0BvjsPABYOpEhOLH7Y4Zvsc7J1F90jdGxWZe9g38VCIFl
 Rmzw==
X-Forwarded-Encrypted: i=1;
 AL+hErEQZeB8QIrrbZAgFhsZvj7N/SelW71Pr44kzOi4T/hbz2caVgPkinm9/SWvZiH/gi42r7mpKb9KhAE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9W7r9R9L8dMJUQxHIjNNbz6kjbO/CKfKgLx+VW+bIZbp5iQ46O
 2IZqbmuSxIZPQSc5VolGnijdtsPKU3lZo/uaCbvaQe529c2ew/ybIBzf4oLNUxHgyoz+NPRUh14
 s/f1kl62v1Jvxr0hLqjr7XAQBvcKBFoG4tXZNDVWEaB3I4gR5f5v/c6Mmm4+Ii03tybM/oM8=
X-Gm-Gg: AZFdTZfmXByBDeOXh2O5ebas+O7yDt5XsPtWTR62mKAjfVc4Ka3Kmpg2M2qN7ftIvBw
 9z7akvmmCtUrIgJye1qSqlqiQhCx+aETaFf9GxMUouVkwMBjp0LOOGMvdSA3kOmhCVSEDsBo1Hn
 4RqEQtMeV7CnZoiqpuBKetJAYgHoT2EvNAPZsJlC3FYrexQdkE4uXKSx4xFxRlNxlCf6yFbi6d7
 QbjMa4/tolAwGyIO0vgmCnhdFRu/x1TL/l4gGzuIAhLeCPm34kRXSugqnb8+ZJl329kdYxRSAjv
 5RYXwYlJhQUrg2N0zjY5SXr6lMaa2VC/yeKSwdNlfxbjDy0ZxA+NUcj4TUUhSD5k2kHx9VrQ0sd
 P1x64k6YV3K/6sZFhQMz3LmZZDuLf0J7Vjv1nhlUYWKXKezFP8dNBNvzsvHSwJLcTdgzD2Cg=
X-Received: by 2002:a05:6122:8882:b0:5ea:d67f:fd39 with SMTP id
 71dfb90a1353d-5ee8af92398mr15166726e0c.5.1795774007248; 
 Fri, 27 Nov 2026 02:06:47 -0800 (PST)
X-Received: by 2002:a05:6122:8882:b0:5ea:d67f:fd39 with SMTP id
 71dfb90a1353d-5ee8af92398mr15166706e0c.5.1795774006772; 
 Fri, 27 Nov 2026 02:06:46 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513acfe25asm850414766b.11.2026.11.27.02.06.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Nov 2026 02:06:46 -0800 (PST)
Message-ID: <cb4d9a71-ac2a-4b36-8a73-eb7dc500796a@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 11:06:44 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] misc: fastrpc: expose unsigned PD node for
 compute-capable ADSP
To: Anandu Krishnan E <anandu.e@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 quic_bkumar@quicinc.com, quic_chennak@quicinc.com,
 dmitry.baryshkov@oss.qualcomm.com
References: <20261127-master-v1-0-f998ec22497b@oss.qualcomm.com>
 <20261127-master-v1-2-f998ec22497b@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261127-master-v1-2-f998ec22497b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 4POTwh267NQKG2tuafPyOBGqeolNrGQh
X-Proofpoint-ORIG-GUID: 4POTwh267NQKG2tuafPyOBGqeolNrGQh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA0MCBTYWx0ZWRfX+HQVZ49NQvgJ
 qeM2K4IaVO8RcrQgFG7yPqIN1iyH+qZrSrxIAYFMmJobJVj5E6p3gN1MIlxkufPpj13Yydib98+
 G8Zbm+greTz+3JFgQy57J3bURDGQ4uk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA0MCBTYWx0ZWRfX/8MvHcURqCjz
 7FtTphQLe9hOC7PdJXXxkDal3gM7CVAZWPxIPN1I3b8SL5FMQG29JrYWvzpxC1eSFHfsVsvl2KT
 Rrddfd6C0r8ko9cGiRfG93A2ZHi7LwICDndvB0McV21hnOIcQh4RZG0uC93op0Ny5kqxXREnTHV
 PCNvcG4aIFo6G83mt03J2IEtpUkhV9Io65VGDBNd+vQq4y0UgqVPt/Mgx4R9wD4uWBK6khq2wnK
 fv0BPM9TuyQ2YjhhrSmKb8WLfjMM+3tIO1nCjq4ssEcP8o/c1tCedSJ7TUjRyNGdpq2UpqOyteo
 u2vCRQwE+4vQf9kM+4r6aA55n/rusEgyAs6Z5pqX39GK/DhQKSiHC/1LIZa1FYqLRR+GFa1csxa
 nsHpXSiAiWjpkI8zxV7H15bMA7+53TO/sGKjZf7H+LmIieAaoyWUYFK6iz16DcfqFiWWOcHBjGG
 BrFH9fcLJNjBGCQY9vQ==
X-Authority-Analysis: v=2.4 cv=A875rKWG c=1 sm=1 tr=0 ts=6b095639 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=Rq7bUKYEei89WYC7L_QA:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_01,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270040
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/27/26 10:56 AM, Anandu Krishnan E wrote:
> ADSP running a compute-capable firmware image needs an additional
> unsigned PD device node, same as CDSP/GDSP, instead of only the
> signed node it gets today. The probe-time capability query now
> caches the DSP's attributes before device nodes are registered, so
> fastrpc_register_devices() can check DSP_IMAGE_CONFIG_ATTR_IDX and
> fall through to the CDSP/GDSP unsigned+signed registration path when
> the queried ADSP reports FASTRPC_DSP_COMPUTE_LITE.
> 
> Signed-off-by: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
> ---

[...]

> @@ -2621,8 +2629,17 @@ static int fastrpc_register_devices(struct fastrpc_channel_ctx *cctx,
>  				    struct rpmsg_device *rpdev)
>  {
>  	struct device *rdev = &rpdev->dev;
> +	bool compute_capable = false;
>  	int err, i;
>  
> +	/*
> +	 * ADSP running a compute-capable firmware image also needs an
> +	 * unsigned PD node, same as CDSP/GDSP.
> +	 */
> +	if (cctx->domain_id == ADSP_DOMAIN_ID && cctx->valid_attributes &&
> +	    cctx->dsp_attributes[DSP_IMAGE_CONFIG_ATTR_IDX] == FASTRPC_DSP_COMPUTE_LITE)
> +		compute_capable = true;
> +
>  	/*
>  	 * Duplicate the ADSP sessions before any device node is registered
>  	 * below: misc_register() lets userspace open() and allocate a
> @@ -2647,6 +2664,9 @@ static int fastrpc_register_devices(struct fastrpc_channel_ctx *cctx,
>  
>  	switch (cctx->domain_id) {
>  	case ADSP_DOMAIN_ID:

With capability discovery in place, can we drop the domain_id
handling from the driver altogether?

Konrad
