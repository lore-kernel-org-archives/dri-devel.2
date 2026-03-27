Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F222D10F285F
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 17:11:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6460810ED18;
	Fri, 27 Mar 2026 17:11:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="E7oWdf+S";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WaAjxXCt";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D46210ED18
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 17:11:03 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62RFoNRb1484818
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 17:11:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JDo8erHL5bTFs5IKXSVY0JSCWDVTxNa7rvR9hgw1yNg=; b=E7oWdf+SC3FHq4BF
 GyDznWyB5ZEeEjlDN91+xQrJgtAvNN5U1sRcE49/cZE0E8GpaMX7/JLaqSnuPCIv
 0v+5T7czjMw6KrR9LGBRHLPDbQcVunQvsnUdhENiW9rizGkCuKyCYa5YMNqJN8Fl
 9mhX34tfvwQYEbZqv/7JpjPVFjy8PKNLHbbzXa5HRNryPGbXO0bxEPd8CSFEfbz0
 FhvwGafW+K9e4XB+unp9oy9SPpnT6vNLq/YKySiB3lyjp+DrTJ7yOp/V3FV9yywt
 I5snmQSXvP+sFhOy8dOUM80Duguz+xKFWiiaZBXDZ0bAzQpf5+ZpHai85IysUGU+
 IKgTNg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5vvv89h8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 17:11:02 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-128e8ac314eso389710c88.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 10:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774631461; x=1775236261;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JDo8erHL5bTFs5IKXSVY0JSCWDVTxNa7rvR9hgw1yNg=;
 b=WaAjxXCtaXLHRWjdYbuEs/f0PgR+FsE4FKPH/1wPSD46EIgYCP2XlkOlPO1FeFUENn
 kAtOamZY8KRfV4ovLZaLyIBmqcPrvCHLqCNEkt1m7OWqOONtBz/KkLO6sUdqAY19CPwX
 SVMRvUtA4iJYrP2UAwnTbZ8kdWjJuSK2OwpmO7fXIjV0nFFiDncyBX8M4GXOT8r9iFud
 vpqILGiIH5RgRmevWfi810xxjVQs2A4Se++ZLfe3YwmPyOO65SzhiBDykTZR1CLEGOHj
 +YykIPQfG5BnJpH12MZvw3QhRMcW+oK7FZTX9DyeZT9wgpJYCfOj9tpI+/tYkdmdUmGx
 FT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774631461; x=1775236261;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JDo8erHL5bTFs5IKXSVY0JSCWDVTxNa7rvR9hgw1yNg=;
 b=gw9wgY+ne67dxulm2XtTxqWtMV2f5Q5Tv+QSS7gv66LOVL//Affb6XEwtasGusGzmP
 ZvhbF6mdQ98lVQYjBrCPpBJb65eZHMtkN6hZIFadGziCu7MT7Bl4YsB2BVlA5QhdLcgm
 qWtfxpnWQd4RMTN2A+S29hVoi8SvFUIhO9Zph+sjJEvP4aodKJy/VXs2fqDet5N2mNYc
 p1ucH3w3FCMnKudbRfnIQuKOKiggML0Iyp75/uX39cZcUpN0nyqP3qEpa4+F4OGQK0RS
 IInykd+0zcN1kzP7E4p7Fp7vU+xpNYSzvPEBr9+7Xoghp8vzEOEFsKKFRVBkIeGDSJsE
 JX3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2xEBWoRiXUHsyM8sz8HxKC3oGaBzoyANCCczjwXcwJd0vuroxnU0b+2TYXvMrVcI7kA5vQM41hFM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxDJItHFdPQ5FrzzOjwC4TtmnA8BoPSm82Nt5mrfOwgWZ3YdnSU
 xGYO3kkKJkBhSH2pT8uuCFOqdpdQzJPs20lgZm04v5Ic9J1Xz9VnVnKiT9wkeoYvG6ZVmwPkgTd
 OGGpj2LCOvUic0CIkM48QUObLYrk8vTC/hyuPeL+ZMEKCWasOaVL7cRkL8eqNKw+udXFY9NQ=
X-Gm-Gg: ATEYQzwRqju8Smt/E4PxRXB7kGj/HGuRshG4z7zuHxl4dMiCIM81Nm6YPBDH2PEc7eN
 N7iflB2cd347ppNbJ869qC+f6OS+PRKNEd+mL7eg4X5BqBF9hcuJGCSAvNKt5QEIqcroxp6fsyQ
 7IGLYbzQ6Sh43xmOS78zL9TI/awJ8F55RIjkan0jmoVvFiG0wJrxKgdEq3j9MSg+aT+YQfZbHK5
 4wsPfFTNtqTdW33bLg1Svwpc8wvGTeKmrx696CaHlytOMJEtStEW49sbmXTXRd5E9duO21nTAPy
 4HvwAyt8XiVnus23huEWHVMf60ro4Ci9qFIYYfyaJnWAxdSLGh/Agz6PrOQxI+0Dp9CA62seipl
 VZeR3frbKa3nWoGeI/lBo9fxQv2YV0o4Vnb3pWMkCJjmugqq67+wnRvSHuywNTAKlpKbMQiqNk0
 k=
X-Received: by 2002:a05:7022:eacd:b0:128:d219:e169 with SMTP id
 a92af1059eb24-12ab286e527mr2008638c88.10.1774631461381; 
 Fri, 27 Mar 2026 10:11:01 -0700 (PDT)
X-Received: by 2002:a05:7022:eacd:b0:128:d219:e169 with SMTP id
 a92af1059eb24-12ab286e527mr2008613c88.10.1774631460802; 
 Fri, 27 Mar 2026 10:11:00 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c16ee39627sm5555001eec.30.2026.03.27.10.10.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2026 10:11:00 -0700 (PDT)
Message-ID: <0e330202-0fd3-4169-a5d5-414235535774@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 11:10:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/qaic: Simplify bootlog line handling
To: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>,
 carl.vanderlip@oss.qualcomm.com, troy.hanson@oss.qualcomm.com,
 zachary.mckevitt@oss.qualcomm.com
Cc: ogabbay@kernel.org, lizhi.hou@amd.com, karol.wachowski@linux.intel.com,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20251223170226.2275812-1-youssef.abdulrahman@oss.qualcomm.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20251223170226.2275812-1-youssef.abdulrahman@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: pVZCRoqie3OedXErQTYt1W2_csYiWzyM
X-Proofpoint-GUID: pVZCRoqie3OedXErQTYt1W2_csYiWzyM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDExOSBTYWx0ZWRfX0bfjz1/eGIWy
 JSB0eGER53KIWlOCZsZhT5pBem/PWCsYEU16rT3hI26niAkJBNv4hnFzANOGkn3Jo8iQT+UK0Kf
 CjbjvhRWF2HNE8EM3jyza7a/GBtEnSaQWX0GJ4XgudxKzJRrE5b0yz13LXEpCunzklUhIkgBMPH
 2d8ZuJAChhNEKxUZxe3ebTad96Bf0hcYftZe2DIErM7V+lSMbe409latwfZ2Yxd/6PXbDqH+o67
 iJSI5CJ+z8UuvmE8zm4tr+aLv8fXCy6K+Hx6va9rpUx7Xf8K7GLVz3zQrh46J8ocD4DNXuHotJd
 ms+d81AdGityr72RwS8kRdhFayCZ5TJKzkNTbI9ZJFTuTdCmiUcbihGeSXTpbdQh0JJiPNpmjOU
 Tistq8K81lhSC463DN4SLfJz60JN2MigAhxPXVd/UUWWkmYFWc7sIgTy0ZqbPv6saOghlSCncsA
 PsBKfqsYBrvsv6zjg5g==
X-Authority-Analysis: v=2.4 cv=PL0COPqC c=1 sm=1 tr=0 ts=69c6ba26 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=ZUs9zOJhT6POFn0piIgA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603270119
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

On 12/23/2025 10:02 AM, Youssef Samir wrote:
> From: Troy Hanson <thanson@qti.qualcomm.com>
> 
> Instead of storing and emitting bootlogs as individual null-terminated
> lines, concatenate them, and later emit them to debugfs in a single call.
> 
> Do not insert a null terminator on messages received from the device.
> Instead use the message length when subsequently storing the message.
> 
> Exclude trailing nulls to normalize AIC100 and AIC200 bootlog lines.
> 
> Signed-off-by: Troy Hanson <thanson@qti.qualcomm.com>
> Signed-off-by: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>

Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
