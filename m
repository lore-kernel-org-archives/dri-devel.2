Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E111EC43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 12:41:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4389A10EC6C;
	Tue, 30 Jun 2026 12:41:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PZsvIHOw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kAZTKQhI";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1D3610EC6C
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 12:41:28 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65U9mnbd1541498
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 12:41:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 81yQnZbApfVfIiH8t8XJoiy0NXKJCRUaF/krfaGmans=; b=PZsvIHOwGcpw1Si8
 mjM5tSeCEW73QMW3pin7A9aNwjptzuikOdaZziRc9EWb+Lwj8nI/lcJb7cE6za6h
 cLx9tEcWyKYljPLsaJkqt1rhRwJpacz3La/f77wc05T8v2A9GTcBWr9dJtX341vN
 bUqEp5fLEOESTWBWc8CY8zeqUKgJqBiaG9dsmhBfd0CJHqYaEq/2IrW/rwR53imk
 STlC6MpL8J2CK4lIgUtWLqlG8+r4dS8XU1CHJMlU1ZY7OU5Cvf5uHI9dn6uDylJI
 C/7DwbOC/0Viob79NGAGUiYF4EqwK0c1g1SpktXNREopXQ82rQFYORYlJIwhpBe2
 jS7SEA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f44wp2fkn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 12:41:28 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e69a569ffso2748585a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 05:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782823287; x=1783428087;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=81yQnZbApfVfIiH8t8XJoiy0NXKJCRUaF/krfaGmans=;
 b=kAZTKQhIbHKMbVbdgzc5TEArrNyoROuo0joMDn+t0LV3ncY2RAsnPq7HSOEhgiN11J
 rax2HwQZG4LioJghSPxAw1vPSvwZ76dvRePlrOwL/YmutImcshLvZ7KjR5tmI0n/kyAQ
 OVMqtZ82A1nJ0UDQGj0pcNJNI8YaryhVDIWKup79l964gsFOKeliFJBFyF77mb/A0kmL
 AGjCct9FMaR1VAD+s6l2rgNNqTvIZUfhHnLDMk7wV2elV7Tfb0z0yEjQEdChgueMQ5RX
 51pGWknJFb3D/FG2gn51m442QaF58Vjyn1foN+EaAKUnYYt38dJ1ZK4wYxqPUrkqtVxJ
 1COw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782823287; x=1783428087;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=81yQnZbApfVfIiH8t8XJoiy0NXKJCRUaF/krfaGmans=;
 b=BV7hGZyRkDQrcSlJPc65VBZOmE31CVQio8cm1tLjnfBZO3/XYjoNHKcK8VgZNmE7IH
 eK2vqczyFGp646FszUgI/lL28DQeOI3Func2f4gWqkKrNH0KhPtV0GtDZhckjfCqdpqL
 Qd5WLB/9uo9EPw9SvtEGFHtzXQdc1iSd+wyZCP7xN1YwoRzFCUpskAGqbLcbirURySoP
 aPKK9PTKo+SyRZZ8b1GAvJs3HEBLZl8D2vfGrt3kyTczwCkLoi9c8cNW101KPzTIUiDm
 U/Xa2wQ/3TEgYb+u87GkKkY8BSpFObdYYqsk75+/TMSSLxagiqqKDRFnpCATmSyD6C33
 M93Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Vo3lCCOrEWJ49cJ5df7hsz+FDGAJaDWSPd0U+Fsw1dgC2jgXbGjlYHnukl2OcRvPoqQKMCatnNG4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyVp6X3iliBRF4joXSsOVf2Xx0aN1lvWApQK375eg3gPDlFGQJ+
 Mfw0vVjozO+BXwiYWVuRbByXdgfz4ToUDEqs5LCnOYOCtgKthjqYmLjH/wDlXtGy41VknOi+Kfu
 QV2Nyeru5UjQFVrY7iYjV1IP1sZwILOtjpJh1unqufswIkLeYLA14d2+YOecTKXErPsAXPws=
X-Gm-Gg: AfdE7cl7ueUXihdNlJaXfYGSiDYWwSsZCjf0wquUl9wzAWq5Ny1YKnxIDB5ZyJw6sX3
 BhywhAG4y9B8JRTKGX0e1qKB1GLeVNeQKjovcosSue2fAcAyPqGA06gHIRVMelyr7r2zdlda3BH
 oxbr0zMzQqmm0KybUrdSB9WqKNXypraZfIQywVZ5NL1ymRUMDvRSp3Et/RbSjudiic/l/+d7oh1
 KQPe/G5uXb720llWwVv85SQes8M4oAqktv0Y3HKun1gYMqQ9+iLh3Obe2LtLXSUjNbUkgqNcxnK
 A4T9EbO3YxNAOLJFRyQl5CmCDx3x0UbJd19CQLCzc1PJidpM4w/MM6sY7tkCNjUxhS4vc0ka55b
 v51XLyrj22qp78YpNlsYkGLI7vHWHkDK2MHQ=
X-Received: by 2002:a05:620a:8813:b0:915:4ca0:1210 with SMTP id
 af79cd13be357-92e62689c4amr349006185a.3.1782823287466; 
 Tue, 30 Jun 2026 05:41:27 -0700 (PDT)
X-Received: by 2002:a05:620a:8813:b0:915:4ca0:1210 with SMTP id
 af79cd13be357-92e62689c4amr348998285a.3.1782823286896; 
 Tue, 30 Jun 2026 05:41:26 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1288d18735sm121211466b.6.2026.06.30.05.41.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 05:41:25 -0700 (PDT)
Message-ID: <ba22eda5-bc7b-4ac3-92e8-c14c4dc13483@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:41:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 09/14] media: qcom: Switch to generic PAS TZ APIs
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
 Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-10-sumit.garg@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260626133440.692849-10-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: RzDv7HWjwASNanSeStVolX4eDs7Ce_2S
X-Authority-Analysis: v=2.4 cv=AtDeGu9P c=1 sm=1 tr=0 ts=6a43b978 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=GN6ll2GKXf5L_uNS5a4A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: RzDv7HWjwASNanSeStVolX4eDs7Ce_2S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDExNiBTYWx0ZWRfX0k3Lge0A693Q
 qJx7GHAkkiJ3XmH42jvPhkUjFAeApKs3Mj67e2OS5LC7oJmeb5ix5GxukMKMmE4kmxgs4XoylJp
 jMLnG7oTggUqlGP9IGGpyPQtcwidPWq2Mn8WOqNQwwUlsHTxy5EBn4KKc4HyLmDW8HzN32WaEal
 eOADpB3PxX20CuYwdikj30uHWIiSH70BqwSYrtBp4vtES1U7dQdfyY/QlGBy1XPZWOJGQgLBLXb
 rddolD5IBctPQlRFZ1jAVziCOC+yINbAy7H9xvnc99X7Dk10doIRVjxUyXmTgU7cKZWTSl2f6VM
 ra+D4amOxgghqdM9G6sD85rQbyUQ0XAGUA0tAtbEq09DX5j1smbvKumgXUESaZIkFC9C7smF9PA
 a7AO6KxC++A/hG4uZOi0cL13gY9etzm2VPiu/dunELvBXUf9csCU8CoosRcek9nAwvsW94gdVwV
 CJ0H3k4NXwg6ARDd4ng==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDExNiBTYWx0ZWRfX3X33sF3uQqmx
 zJiRwaeTMccRowL8Ezpmhrnthyt3AHA2HzKDgF3kN4VPYS+JMB8MY2qBiIuKolhYWLvaHHTHO9v
 /33WOxz7LYT/I/BMqQ6ueIgLJvaCPjU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300116
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
> Switch qcom media client drivers over to generic PAS TZ APIs. Generic PAS
> TZ service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.
> 
> Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---

[...]

>  config VIDEO_QCOM_IRIS
> -        tristate "Qualcomm iris V4L2 decoder driver"
> -        depends on VIDEO_DEV
> -        depends on ARCH_QCOM || COMPILE_TEST
> -        select V4L2_MEM2MEM_DEV
> -        select QCOM_MDT_LOADER
> -        select QCOM_SCM
> -        select QCOM_UBWC_CONFIG
> -        select VIDEOBUF2_DMA_CONTIG
> -        help
> -          This is a V4L2 driver for Qualcomm iris video accelerator
> -          hardware. It accelerates decoding operations on various
> -          Qualcomm SoCs.
> -          To compile this driver as a module choose m here.
> +	tristate "Qualcomm iris V4L2 decoder driver"
> +	depends on VIDEO_DEV
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	select V4L2_MEM2MEM_DEV
> +	select QCOM_MDT_LOADER
> +	select QCOM_SCM
> +	select QCOM_PAS

Hidden NOP addition

otherwise

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

