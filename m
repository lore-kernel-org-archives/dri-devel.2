Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80549CA5FCB
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 15:11:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D59B110F6DE;
	Thu,  1 Oct 2026 15:11:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Uk2LgLKX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cTVB2f6T";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CD5310F6DE
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 15:11:24 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691DjsB41304109
 for <dri-devel@lists.freedesktop.org>; Thu, 1 Oct 2026 15:11:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iYBzGParazZeDHgmm6OmKxdz2ZT6O24nTmp5HoaQ7xc=; b=Uk2LgLKXwlosQNrL
 lM/U1nQlnjCv68l4yxb7IIXVi+aCxd94Hedfj1kJCkEm3sEeJMdW6hAOTNDntS2T
 HyF65uzhOjFf3/ZeZN3vD2DltxF0a9h6EWOjXVAloPl0DkKi0F6ch6u7T9zH2HId
 7JrEBWlKC4r/zZ5hALYb4wnIvCzsB1Pa10kzvEEpPsTlxgJMXI1qiAPgpnllDG6D
 g1919t7U7hCj2xftOqOnf33sPsnBQ9PLoIINTMY0LUariHvvhzBb5xaImxsb8+z/
 WaEk5JeVzpdun1n/FwfvIZENjTwmQOZD5VSWtVeGheI1/RK3ep/GHSr8BD5CI7sb
 pkzn/A==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1bh5cg1s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 15:11:23 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-97e9b747ad1so68512241.1
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 08:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790867482; x=1791472282;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=iYBzGParazZeDHgmm6OmKxdz2ZT6O24nTmp5HoaQ7xc=;
 b=cTVB2f6Tmjgy8Rzx0y1h63U2jgx6Jc2GHCjTLqrk4lsRD0uiKS2/6kdJHAtkTecZJx
 YrNpRdiFfZ0FIkhlfukftoD6JuejxrF6eNnKHkM3vId3TOPp46ibXsKsQdC+PjS37bNF
 Mp1+Bqaa9AIdeZYVgHpM9hHQlI/Trow2BZK5g1Wg1L2saC1/edJVCcgjKIvCXOydkjWN
 hvQbnuQms0xf8fpDp1dlaIGyWfJl052k4OBqXnDVVTSjM/o9tveSQzUjoGP3XZl7HGgB
 p1hs9jtai8kiU+OhEuBedjFHdpMztpSqKpCt9VhbLgPjHPJxRayF5dgS3AT7N6aat2ri
 QT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790867482; x=1791472282;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iYBzGParazZeDHgmm6OmKxdz2ZT6O24nTmp5HoaQ7xc=;
 b=XheQWDSirCwpxrQHR196P2lUo1OxLxFuracKlU6GcSglxuUz7Ri76x8e3/Dw+ucrmg
 rgyP56ENN9MEF6Q72EziNewcSQK36mys4hLBsbAwZB4B9by0xme5MtieL9u6TUjuuzfM
 rRQLcXkdn2q2AUZ4UFTkjVFiOfGo03cBuqsP9ocoPL309wUXLNUyHmOF5QtQdek2btUH
 lEdL0LYXrM6BjDv393lIKHPZAGtDirMfek7hRKlBBza0cSlJPFY73tgDRJ0H+PA/RTPk
 C6sv9iHoJnHMMzbq7aNj9WfCZKaJU1Absv9zOaNkfUvt3YWvduBUlqe2EoL3VxQ14fSe
 kRsg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzt2lBEGZgfyOHxlHZJDZ1YjMgJPpm3sX7qgGVTlAb8DTcx43qx+yKdpXUQtp80o9+c7YTgoaliliA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKAaubz12rBcB8ZqMXcG1b5Z9x8PWyUKc/EwjiQsU0Z9YaT9Xcr
 7tP7GsJoSeUF1b9eYMzqdVGyduxnOi0BTHc8JFzo+xrUP3PoFgJz98EDr9Rtrc319gQqCu5rsoE
 wZS1P5zJRbEs7ELwDJsL/wq4MpHqiiUg07mXFeHNZ/muoO2b6oxMzZqGcjxn+mpnZovV4sKJRxH
 SfXCE=
X-Gm-Gg: AYBFou0R9OKRia6ybFvnUDJubxsS2ww0SAzl2eJ3a0rwx/7iplWZTYYi99P0RezV0y8
 ebVTP9b5nPvmKh+7WoW+iiGYMNg9A0IRB+2zq1/ZNEGir3TJS+vmhHnH++2SB/nPDH0eWlvAQ+L
 bFH2fgXoNx9dfsNDFdjnIfReML00hkK8nZhq39GDKJ2MTz2cQnx884U19tRG8pyvOiYpgYWOtGB
 lvwtD//YOBn9+fAQky17xrSTRCB2qQ4yAAre/gShLmtIrpfY3aVKzqTSU38hLvJQQh2+uNiaNcH
 wEUmuvHpPVTrE9J0AR4uKPM2K6rgiMOcqscnj8HDnvd/BHOQpzvVeiW364aEaFvM4MHOxvDZ65O
 85nQ6R7uJLbE8IAV4T6ND+g==
X-Received: by 2002:a05:6102:6a8b:b0:7ae:544d:b50b with SMTP id
 ada2fe7eead31-7be72cb1e6emr1260208137.3.1790867482147; 
 Thu, 01 Oct 2026 08:11:22 -0700 (PDT)
X-Received: by 2002:a05:6102:6a8b:b0:7ae:544d:b50b with SMTP id
 ada2fe7eead31-7be72cb1e6emr1260203137.3.1790867481730; 
 Thu, 01 Oct 2026 08:11:21 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2e31ce3ea9sm187363566b.32.2026.10.01.08.11.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 08:11:21 -0700 (PDT)
Message-ID: <20cfacef-2238-4967-a7f6-eff0e883df00@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 17:11:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] misc: fastrpc: map ADSP remote heap into remoteproc
 IOMMU domain
To: Anandu Krishnan E <anandu.e@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, quic_bkumar@quicinc.com,
 quic_chennak@quicinc.com
References: <20261001-fastrpc-kvm-iommu-v2-v2-1-6c32ad6f662f@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261001-fastrpc-kvm-iommu-v2-v2-1-6c32ad6f662f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA2MCBTYWx0ZWRfX3V0NU8heIldw
 0nfaE0db8VK/Xn/rMyh1B9awkmCEBJd3ercH60PJRSU/xPjSXs/Y+YAMwHjVTZU/pdb41a2RjnE
 oKL/sMMm2T7gQXyCj848pl24Wb+1dVBtLruNW8Bc+NBtaPEM9ut9Aud/eOnLGDbIhf/KthTr62a
 sbh/p1+T+pJugbn3LikPKc0WRrnBoeVC0RgAFDICmLQByacQD6zSwV9Jdsb8BVNQHSJVnXTxNUy
 pXkG6wq/FjSJts92jKTXiT2/SuxOatAhZWtRwXLIpoC+qWQSyC9m8MjjcdAT9AM1E6kqCTgcxa2
 XiZ9U48e8MNR1e9HeSslFHkKHKkruyqz/Rh+NxcVtyBQjHbo1tTt4z1XRVWd06YVxdVcFo0VpP4
 X8prw4iz3N6pHnhoDewOQQ+qCLVK9izSDGYHZT31yE+lWC4ZFR7X5W7Vw09FTsgO6OQRn5tX5cE
 +6ql4IzRJmgPz75FU7Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA2MCBTYWx0ZWRfX6NYhil1koEDt
 KLTgkphOkQQVRvP50wGxHu1+ne8hOj/xlJyPaVqZK4I2iUdjYpQoNpFXe59Xi2OTMt2fPlCSD74
 2tpC6UcftdcRAskv/z5xk5X7lvN8IuI=
X-Proofpoint-ORIG-GUID: YSchmf5yGh9JnpLSnPpAh6MIN-0T5mCE
X-Proofpoint-GUID: YSchmf5yGh9JnpLSnPpAh6MIN-0T5mCE
X-Authority-Analysis: v=2.4 cv=NrJE4MdJ c=1 sm=1 tr=0 ts=6abe781b cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=JJHmHs2BdlmLsZ1y3_4A:9 a=QEXdDO2ut3YA:10 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010060
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

On 10/1/26 5:00 PM, Anandu Krishnan E wrote:
> On KVM-based targets the kernel runs at EL2 without a separate

"On Qualcomm platforms without Gunyah/QHEE"

Konrad
