Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41CF606A328
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o927UZZf;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GXjs8/Fv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A95610E15D;
	Wed,  4 Nov 2026 17:42:07 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C04E10E285
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 17:41:56 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4Fiwa92210825
 for <dri-devel@lists.freedesktop.org>; Wed, 4 Nov 2026 17:41:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KBngs6PbtVtFuqOkrz/LQ/wTD1g+XR3ncd/Le9wik/M=; b=o927UZZfLTq1NF5t
 W4ZoIN10dkQ6w33wgimL4Ushe5qxy72DDqn++2Zu8dwy7utt7i8ZWJkI9LPgpwFX
 jbJvlxOm1O1LsV5IK6lHPiuBhD7odr0bPQs2Z+oJpQhZULEvmc4Mfvg2oYdkjjCm
 ArSSrLXEdkewwOBfDTQ0DJwXY7MrNTYhEYV+FowreKFbpGWLwMi/tYWAKkKOVIlf
 LCN4NuO94fvh1ElApZX7lwkZ2M4b/34vexLpfjzT4w4FNynFc5buRY9klUaKSH3H
 fucLB2BXZAUbDX267R8+1Iog+uNhmzycNZvWFpp1oMoPPeSMcdPl1jWm9bDgUMbM
 3CKjdA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr6bdrv3q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 17:41:55 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cbb92868263so629695a12.2
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 09:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793814115; x=1794418915;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=KBngs6PbtVtFuqOkrz/LQ/wTD1g+XR3ncd/Le9wik/M=;
 b=GXjs8/Fv1ONkSsI3tEAvAg+HkL4JVxNem0vLNwm3iNvkBRj2gN+5hfNveZcLqPhwKV
 p11vLaM2caf1jh3/fT1oO1YPNF/3rOs1m0H9ISVXIh6kioIkx/FveMP7wNZ5j6gu92Hi
 c2xPiFHYp6ddm9DEd+TOfBrVyLZtBQLlENHu43dBZlXDM03vpw1Bnofqp/qeeoZlUBj4
 Z295sNaiFFJmaFWTf56/rcHgZ4WagSM9+VLfA5vixaeUX4aKxGFiZIyfRq7SFEuGwhGi
 97ZRXsVEkf1K9+gYqUf+LmwMEo7ob/T5uBvjZKl6WsY0wvbfNwezx3MMDQQTO9/ZJuzP
 al9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793814115; x=1794418915;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KBngs6PbtVtFuqOkrz/LQ/wTD1g+XR3ncd/Le9wik/M=;
 b=lzmxRMKiDGX5xiufnKsHaxOnG5MgT41zFwbj3G7E6dAs7RpHqDiEtNB8WuoLNwATeb
 KMyTfqYBWXoH/OvDbgFHd5CaKq6bIkT5T7TpV0xyWQM6/EmVBdntnaDrDZgTinUo1xZh
 /dAPoC42F9eNByZUzYvAB/MOo9ojG4kcVaRSK27qURGQgCaFjj2eG5d8eMH344gPY97j
 B1B4/npyGdfRtbpyLcdjFkVorjkSHFNsc8J6cl491jsPE6JIMLUWFZhLEvLbNCb6APxA
 Osmof4eSE4i0GR/PiQlu7k/c15ONfi3BY6+J2gfq9kHg13h60t6isVchi7hJFXXbbXeJ
 DQ1g==
X-Forwarded-Encrypted: i=1;
 AKwUvBw5GoyQdLnuFXn2aKdv8SE0QVGYGkMqTF0n16uM4b22rijLeVtaWYZZzZiOi56FeLM45U7V4Lehg3I=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9aEOs61msqXUXgWwIhj3Z+hdm6wvhmFgj4pAeGbhPlOZLIP/oG
 x+tTjm6N/cxT/2Kfu/JT9r1GdNmkR4LDNf8l1Z+bVfFK9dnhKE70A/WTZQrqJdg3156pKBgYChC
 UYD1uHg7VAMG4NAXk81z9b6Fcrkkf3OV4nTLTGI1VcOjAq4Wu9EWARSC+xCcmo40XcMIK9lk=
X-Gm-Gg: AYBFou0mazb2AF94AugWGHieYlClTtL3ry4aRZ8DBq85XyfPO5IPvLYgPZ6vrzyp/nX
 MUqV3mT8U34ZdCE5WmnR3/XTennqfoDj5vog99y6zaDE87RMcPbWp7J6Z8+Fc6iDXFFRhcQieMW
 oYGdzh5PLUsAre8Ht/dTAuzmYZcjBYohwSml5SxcVPgieyoUf1qeMrrgLmRIA9nabPohNv1YCur
 2dNQ2bj0aGOVjmBWYbwFRqSFdSXn8WCKnAmqaLOFiwoJ4h1FmjA4M4OPYWm+bfVrCDk6XdkZvox
 JqyAXQuAGO7BE7q/sRBDp0qNvEyib3UxZZwTigPa2bwAu2yF5mNCMGRjY9meSZPl9XM+9Y2IiMe
 oYHP+QtBdx0wRihEWDIb4vCUrySJVvGdrjCwZAwKNW/MOJnYGRkD08JHklKwD8SgAsj6QXNmCYc
 7igaqVsT4RafYqHSzsS9r1Rg==
X-Received: by 2002:a17:902:dac2:b0:2e2:c84b:43e9 with SMTP id
 d9443c01a7336-2eb363965ccmr154301305ad.1.1793814114736; 
 Wed, 04 Nov 2026 09:41:54 -0800 (PST)
X-Received: by 2002:a17:902:dac2:b0:2e2:c84b:43e9 with SMTP id
 d9443c01a7336-2eb363965ccmr154301125ad.1.1793814114233; 
 Wed, 04 Nov 2026 09:41:54 -0800 (PST)
Received: from [10.226.59.182] (Global_NAT1.qualcomm.com. [129.46.96.20])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ed091f35cesm10509085ad.71.2026.11.04.09.41.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 09:41:53 -0800 (PST)
Message-ID: <c7f834be-ab48-41f4-a860-2978eeadb225@oss.qualcomm.com>
Date: Wed, 4 Nov 2026 10:41:52 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Limit SSIDs to 128 on all generations
To: Karol Wachowski <karol.wachowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com, dawid.osuchowski@linux.intel.com
References: <20261104082920.859706-1-karol.wachowski@linux.intel.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20261104082920.859706-1-karol.wachowski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA3MCBTYWx0ZWRfX2eb3dvToRGJd
 uo20to+6mUQByPMX+aKrJ2Jo2dZTA/TXj5efsCVlNrNqRpbbJ7zvduOHZQyaUydKBGtId/c2c2a
 eVSt0vK0gQx0MALS6Ee7M8a1ItfqGI8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA3MCBTYWx0ZWRfX1a/bCPlFK9kG
 1i/bTcU4+Q2Hzye0hbXXlH2JTQdG32b/xEgb8r4+Ok/YoOMQmn7dzZQtmQUeAeOIF4/UimVBNZM
 UL4dBCiRyEvj+UT7BTRAH0pfml/nMd3KLTYxLOkUFjurCUQS8+sUPH5dteyOxhyyl2RXRptbSpS
 9ns1z77h1xH2t3dCr2LDxLsoXF90knzcHeudn3f4b3pqWwoBQLSlkbieSymKnLTyTtWI39AgjBI
 jdKYyBVw+zL1XkavEp8SFWUU6RqN4teGTHaUgA/HvfY5C5of01dAxgAmaAbkVHzkNr2Os0rpYqR
 Jc6BQUOZcN3vZYK8ht0UrSt5FdG0RBVuZjmDRZI4rC+zfTktKhbX0GZ4vgZPL/SA8itdb0QRL8L
 GL2pLMVNunw6kE/f012Ha5Wraokg65ZNcZ0LjXTmW/e3Vkd6PBztuogHAp8RMk+nMx3TMPFahNi
 vABJuUuFqZjS3lbN2cA==
X-Proofpoint-ORIG-GUID: 5ZjBmmvkGoBziPZC_-KcL6nTKc0rDNfU
X-Authority-Analysis: v=2.4 cv=D4XSufRj c=1 sm=1 tr=0 ts=6aeb6e63 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=QyXUC8HyAAAA:8 a=LJ-tXWopy49rKMvsrL4A:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: 5ZjBmmvkGoBziPZC_-KcL6nTKc0rDNfU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040070
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
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/4/2026 1:29 AM, Karol Wachowski wrote:
> Some generations support only 128 SSIDs, while the KMD configured 256
> CD table entries and allowed user contexts up to SSID 130. Align the
> limit across all generations.

When I read this, I have the question, why limit to 128 for all 
generations when I assume some generations support more than 128. Would 
that not be a handicap for users on the gen(s) which can utilize more? 
It seems like the justification for applying this lowest common 
denominator across everything is not quite clear to an outsider.

> Limit the CD table to 128 entries and the user SSID range to 2-127, so
> root can create 126 contexts and non-root users 64. Also fix the off by
> one SSID bounds checks against the CD table size.
> 
> Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>

