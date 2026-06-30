Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F4BC43327
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 12:26:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4526410E1F4;
	Tue, 30 Jun 2026 12:26:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kEQp0xcl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EaDLLhpX";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6886010E1EC
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 12:26:33 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65U9mlKw1602542
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 12:26:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Em4j1rjfTFXHEN5Lun83H7ijLdbaGF+xPI/HxI4Nw7k=; b=kEQp0xcloYmwQX4c
 kvEzpYrN1l5EVudiD7/Ekt1BdyifNskaaBNsuAayUDPXO09VfiZH3G9rkoNG/8nF
 W4/BwOAxCCgx3DbwpAchJG4MMTgpLsVPEbFPIPRLs2Cd0Rnf6XipGK9EutlPEc6V
 JIHMdAD8LSjmwjJfDtDtObrtEv2erqSfEgSdt0e7alfCGwS+PKE35UXxWJRKTloH
 pPJCM0IvNj4byRf/eUq5bFvN9q4FlvKbOO7lvX2ExBviaM+TU1onx7PIrbIURsdZ
 8/7ws8eoOAKm+tTQvmWPQoxGjl8N+jV0zu4N7hNqI8EQbch0h2TQuauam303UYl5
 ZjQcig==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4avprv6b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 12:26:32 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e661ce1dcso15868985a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 05:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782822391; x=1783427191;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Em4j1rjfTFXHEN5Lun83H7ijLdbaGF+xPI/HxI4Nw7k=;
 b=EaDLLhpXotSKyO5somdRygizKHSbWtJ6eOBZHiBFr08DZEU1Bxnr4Lu66efPGponks
 97uSv2yab/8Q0JXQU1rZ325ipWz9eGYc6Pdm27o+GEA3hgwgufZWpoD0/TYytRsCVy1G
 TARmujrww2MkkA48CPnKJZfH/8u3MOCj6c49hoVw6mKAgwg3iRQ7mEZf3LPOpBskrMdH
 9lECbR3XmlsYnbPt8fQLNf8+15vj790Ewokl3hXgG4Fr8o2zSEuoSM9vleYoBEjfm66g
 EZhkEIIiHOep/AzwxOdk8xlTLBq4Nrc+ijnGdySUffbcdZvotj4fdcZSbHKuzA3UBGnw
 i0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782822391; x=1783427191;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Em4j1rjfTFXHEN5Lun83H7ijLdbaGF+xPI/HxI4Nw7k=;
 b=p7LAn/PVdby3jdx+8L61GT99UUuDUoGBSWN00j3xDlBxDfSTx6mgD/g+/UNRCE509i
 EK/4VRm0VoWHGv8PNgUOQQQnLyjdZfbELsJH/avIOlhwWpPFgvDpz+iFqAk/2WLHpWbG
 WsLYOTh73EQgmu0orevxvQOtXmPKSrmkr8lQtmhv2X5/9eTBMTQwuzEDRbssPK11hNGB
 GiaHVu0ciiXnZJRCUh9TUrOn37jmy1wfjpLceLHp7PWfbEQQQ+zs1sMrzIgOmP3IPv52
 vYnXV8/WA+1RtJuB+KpUFfZrF2F5udmFgyEf53V43ozpOrRJ8OjZl9ITE2jiv+501EXw
 Ih9g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8lILTDwDjusbFtagcdG3isBW9itXMPmkyEo4cztGwTLMHZxdRhNxbZ+mDisnraQXxiACSzaL4EMNM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz1yv+7x5ddJcQhMGm8xdWf06JPlp6x5StfuYaTqYrDUlfN9hUw
 sXfdDcPqlD/Zav49wge8Cz8049XtZ5nZnBHkRCIB1Mi7dD5iDe+iytvuyB/nkbxdPqu2UVVsvZb
 D9lwhg7kWDNndlgSqG+ovTR56VyRvzqe/irZ48taXHOrtyQgTjNnXcRT9lec8DWYvdf1Pb+4jmz
 v7OLk=
X-Gm-Gg: AfdE7cl2rgiCrjPdzbFc+RyxUOf0PmMBFv/C2ERYZy0UVWYIn5rj3bP0qhDqX5gyY1M
 zXniWHTiA0DoGgxEhzJSqn5Av2X8hBv+XnZdv2k0V+pUmwjQSaC/6QRWGRHRhug414orm+XOBpl
 9ISihMGFoWQNvMF3oQJ2YkCFFj8Tmu5VaZhGEamDkOSxWPLpMpV/nSR2IVeTv7IKh8dR0nYnOV1
 jI+xLjRsisZAHYCW/bJKk2YzsG1zpta6q2viVrrz4yhKo0SU8Olvl+jKTOgwXSzNnzuljMemxJT
 80G+wAocT5F+dtDjlr5dQmsHttN++nhZzT064BM+YfadvOI8TTcFvsQWcSPxsdQPcAb3fdX6Vyb
 U15me6FXoVuYrHd1bwsY2KUy3cQxUzaXA008=
X-Received: by 2002:a05:620a:6018:b0:920:798b:e290 with SMTP id
 af79cd13be357-92e62873bb7mr367986785a.7.1782822391304; 
 Tue, 30 Jun 2026 05:26:31 -0700 (PDT)
X-Received: by 2002:a05:620a:6018:b0:920:798b:e290 with SMTP id
 af79cd13be357-92e62873bb7mr367979785a.7.1782822390742; 
 Tue, 30 Jun 2026 05:26:30 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1288f4c19esm116380066b.51.2026.06.30.05.26.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 05:26:29 -0700 (PDT)
Message-ID: <e372e66d-7df6-49f2-9530-0c61ad43a18e@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:26:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/14] firmware: qcom_scm: Migrate to generic PAS
 service
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
 <20260626133440.692849-3-sumit.garg@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260626133440.692849-3-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: AWftWe7IYUXaVQhgZbUNfs1sp32RrT98
X-Authority-Analysis: v=2.4 cv=KqJ9H2WN c=1 sm=1 tr=0 ts=6a43b5f8 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=TJYwRQMSshrBWr6rMVAA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDExNSBTYWx0ZWRfX0i8HFUSlJgaV
 19yB2+CdOS3hNVF0MEXbPjTN66vD31iZezxQ+kSEEChoFsZi2YrtQxgiV+gBFmJFqz5IQxp1/h6
 QYc1cAIwDaLQUT0hmhdtkv38YBakdIRzRojJ6RnbXiHFEg7Q2Q0SDjrPitNeXR72m2SDv+PXNgv
 F926YTw6kseRE6cBYgw+HFPy8rxrOxoZJQ1JJ/+huM44Zv+W1a3xYsfMh6d2kAMJtQ9BYdxMyir
 aFTq/TNyJogbJxDOForO3IWlVK7Xt9TZqYt8H+hG7GPq16bjL+HbuXSWCXK/DrgtBa7fq+n+2RC
 TKsShWNezx64tbrxYZUx1ZZbG3nlEJSVtKSbzqcSZdlLs+jkIqbjCWCRMNfJYvufNVwIGyb5CRu
 suOhr9HIZeL/6pGECcfgfFcP9q7OZcyVnaB2aTgXzoNT3GzlzbzkmjOHqkzmnrnKfpT+CJOQ737
 XJaKQA5IZBl5K8fuSFA==
X-Proofpoint-ORIG-GUID: AWftWe7IYUXaVQhgZbUNfs1sp32RrT98
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDExNSBTYWx0ZWRfX/CtO2mPARVIu
 UoTIMCtjuf/uOkdafMqk/4w5m/ivbR804Z6yfOv27KTZB4k2eSxOS7dKjfmfycoFkv0dzHigGJR
 ijjW4x/0kzuU9a+uPKSSgYd2aL9hvJw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300115
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
> With the availability of generic PAS service, let's add SCM calls as
> a backend to keep supporting legacy QTEE interfaces. The exported
> qcom_scm* wrappers will get dropped once all the client drivers get
> migrated as part of future patches.
> 
> Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
> Reviewed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
> Tested-by: Vignesh Viswanathan <vignesh.viswanathan@oss.qualcomm.com> # IPQ9650
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---

[...]

>  struct qcom_scm_pas_context *devm_qcom_scm_pas_context_alloc(struct device *dev,
>  							     u32 pas_id,
>  							     phys_addr_t mem_phys,
>  							     size_t mem_size)
>  {
> -	struct qcom_scm_pas_context *ctx;
> +	struct qcom_pas_context *ctx;
>  
>  	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
>  	if (!ctx)
> @@ -600,11 +569,12 @@ struct qcom_scm_pas_context *devm_qcom_scm_pas_context_alloc(struct device *dev,
>  	ctx->mem_phys = mem_phys;
>  	ctx->mem_size = mem_size;
>  
> -	return ctx;
> +	return (struct qcom_scm_pas_context *)ctx;

"please don't explode"

otherwise

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

