Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A64ED10F285D
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 17:06:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E27C410E1A8;
	Fri, 27 Mar 2026 17:06:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="I11pTHtg";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VKp0g9AU";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0D6B10E1A8
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 17:06:41 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62RDhqBF430604
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 17:06:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GS3LQj3VklJFNld8YXX5bejvQKGlCpBHnctE0eLJaNk=; b=I11pTHtgrwNXubLD
 SSQy9vUKUI1LhTno95dPghfjqs/D9qHmjZIJal923GJrfzmnRtLRn2+qMlJoq8gU
 DwmGRIgi7idDh9uLvyfnvl3mRtE20oRTtKBSEkpUYEztkZoDJube85RhbDG/i8+w
 GG3YBrItEu7t4N3EzHUajoSigJ0KkHiei23rX8DLfWI6UML0rprc2fx0wdK4aW1p
 AqMCvv406aVfJJVbLhUlwjnu9IHmZ1VFLRdpOuIYgKhjvbSslV4Q52as9Nwd4MXQ
 4ju9r7phDp5iJYR1n4qC79fMhB04NO4mzhR/PXSc+JZFQH96N8X67JQ56Gy6s4F/
 xv70AA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5hapu1fw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 17:06:41 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2c18175fc54so578429eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 10:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774631200; x=1775236000;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GS3LQj3VklJFNld8YXX5bejvQKGlCpBHnctE0eLJaNk=;
 b=VKp0g9AUYd8o3h8+FqstXRsHXeNU00V1aTj63n8lDRKZc0bHshXKjhCqqVS3ssJl+t
 WgPDBX/1p3F58Cx4lBn94w8T8LhNemOhpfKE0BbVIXCgt0Z5J3GU95u05zUMq2ST1Dne
 JE2fK/o6M6vLTM6DWL1qRV48V+K7zLTz/fdXTJjWE5A63LnL/GlHZEiCjbvTE3tJBFGd
 w1PNPdVbsAcQCJmp/Gd0iuAMKBlGMwRtnWpuiniH854oPJh5DSGpZ1G2uysMpcH086lh
 AwwMoasNcUpLuCb3zw9Q84T0cbg/sVFZxUQRiIBPpJE9kAjBNTnkNzmArBnSIIbRXU/u
 sK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774631200; x=1775236000;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GS3LQj3VklJFNld8YXX5bejvQKGlCpBHnctE0eLJaNk=;
 b=EosqX9DvlEitL9QfWENTaXeAciaDKZbtUFZrsKmN63N7xgvyFI5N7hafHXaYFPmZ9H
 PBMON1W6xnsHzERWVdG9YV1DeF33jF1r3Stx9vWuNS12i0hF5u8kfyezlkIJuxdJuDNk
 q+n8/pvuCGFNskLa4JAucW4VranlzxW9zEI1Xd7VRiqY/4XeV9WCqbPE+SvCgLAyOJfY
 QfkGjzMfYhEQzG0XFpIYs1b/j1jUHshqiHmqwVVqTgVWJ9izrO7RI9H1uf9ng/XSTLQ0
 TlwmHVLS3zrCaTBnem8uNNvz4Rvvr5rKI2wjxyHv9KkiiTPnCu5ImOSaoRWDJVLImFci
 7DSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVa9WmyNUuCM7nLSLAW3h+cdzpiccKHnK+dVL5NthVIKzv5ERx9P+iVU07XLE55Q0fBDan1CQyi/aE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz0ShRtZ/CeUk3i9OkeWxHwzzswcOLuzW8KfKM7JT8gb20iKPUm
 /lMq4QsCWVlSLCr5rgoSRCXRdhxGr6RW2/hqRVmsj7re5j14eD6EmuA/FgSlzkxJd48Aqb6npTS
 DUen3768jzH8zMv0WHNh+heqCJerSTZzoUU6X3jDHYgw5Y1fI3XKP34SKkQF07XJfnyEPI2h+sn
 41ips=
X-Gm-Gg: ATEYQzx/LQnIzLqAb0fxCWQrhRsMbAYV8NaJYI2knvNFqS2wBIDcqdLHsHZJPhB15qF
 1HmT1SekmXeCynJk5N2FGPEeGPexjilT6Uhu890CrTJ2k48B1dI1mdNSCQe28Ze7OTPuXdiRQFq
 ORiaewCN/rwrurls2I3zTQvf/I7yVVu1ZpZjQiOtI8CZW8ieLyIzDpLdp9T83whIUDW6k7mpeN2
 v1s11t2POdq3c/lBqse7yDEDMM9i4XxIPBf8UjUAYvQuoRUVEiwajgkQM/yoQ71tiH0Kp59qAxA
 mkMWklsdYWeEC7Dk5hqG/h8Y9l/5tEQnaRlmF+FzYlqpiJKbhZ3R+WvQQVhKq6m1NYefX9tynGw
 IDQMlftTUbMIDVo9gUWEK82g0lFU6qv0JPShUCkc8/YtavS5gZVOqqxK9guWumBU3sBZ8GIwJaf
 s=
X-Received: by 2002:a05:7300:6d22:b0:2c0:c775:a46b with SMTP id
 5a478bee46e88-2c185dd2556mr2172476eec.8.1774631200312; 
 Fri, 27 Mar 2026 10:06:40 -0700 (PDT)
X-Received: by 2002:a05:7300:6d22:b0:2c0:c775:a46b with SMTP id
 5a478bee46e88-2c185dd2556mr2172452eec.8.1774631199783; 
 Fri, 27 Mar 2026 10:06:39 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c16ec26651sm5879753eec.2.2026.03.27.10.06.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2026 10:06:39 -0700 (PDT)
Message-ID: <157a2052-2a1f-4fe6-a079-4b764438d0e9@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 11:06:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/qaic: Update copyright headers to yearless format
To: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>,
 carl.vanderlip@oss.qualcomm.com, troy.hanson@oss.qualcomm.com,
 zachary.mckevitt@oss.qualcomm.com
Cc: ogabbay@kernel.org, lizhi.hou@amd.com, karol.wachowski@linux.intel.com,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20251223172425.2283978-1-youssef.abdulrahman@oss.qualcomm.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20251223172425.2283978-1-youssef.abdulrahman@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TqnrRTXh c=1 sm=1 tr=0 ts=69c6b921 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=IWQDTU_h8YkQ2KHlyqYA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDExOCBTYWx0ZWRfX8ayBRE4xK21i
 R2UluRoA2aw8ZN9OUv9xIGVRlhT7AySiY6xJm2YOeNQJiuqCx1X3Pzsjhas873/g8DIu6M4Ew4+
 S+5yeRvjemGWHrcMo8VFj/MECoX97grbFhxu6w1CGY69aWZWP4/qM8wmnvFvB3JgxYMME7zkHQW
 TgsVxHDsjxgL9ZNdnNKt3E/26PdF8maUUtt8nTMUI2PnGVb75qMAIuC95DJ5mgDvnvxqdXo0qpt
 0eBppVooThGNNBm8a9B5uLMEUd/j0nj4hrywcaMB78JRRZD+vhDtdWuIE7GQpaXB7/xVpWloTPq
 dpDkAw08U36O3bqVdFAccxFWSHqGOFpR1VF0S9kFukVzhAJCaHtgYdBoy/yP6i8HjcFrx8baWse
 rHCAq08/mJz8JXcmmWoLKroyziwYIo0FMt7kpr/Fm28wSZNRywRoAjN5Ws78TfmR4SLhhCDTesj
 tw8OyvpOgcRIAVN2rEw==
X-Proofpoint-GUID: yGMPGB7uhyRHw1_pFflb5_kxBgsDChSc
X-Proofpoint-ORIG-GUID: yGMPGB7uhyRHw1_pFflb5_kxBgsDChSc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270118
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

On 12/23/2025 10:24 AM, Youssef Samir wrote:
> From: Zack McKevitt <zmckevit@qti.qualcomm.com>
> 
> Update copyright headers in accordance with Qualcomm's current
> legal policy.
> 
> Signed-off-by: Zack McKevitt <zmckevit@qti.qualcomm.com>
> Signed-off-by: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>

Pushed to drm-misc-next.

-Jeff
