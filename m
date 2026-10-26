Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02FC606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 05:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Po056Kel;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=E2wA3v08
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22E6810E928;
	Mon, 26 Oct 2026 05:33:16 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 558C810E921
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 05:33:05 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q4b79b1907968
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 05:33:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fw3YBDnl2JEKQGYwhV1bigEwA0pD9yqTO6oVKeScAcI=; b=Po056Kele6m1al/C
 bHUihIf1InO6MSspmTFZcYBqxJq37uAFUxQaiCbE7L5kGRsIvgTHoUUEYMwAP8cK
 oV5VxVzJ2XEwZPoAodrIsg/BhHq67s+yTAV2t0tvHrq5kvFwgzeRpLZXd6XB+PjA
 nyorGltDu4kFjH4QhIpUpe7fC1noEfs+6w1OJYcJWvjodWrzpuj9x6MD7rUPgvfw
 4loEg7ogFIgwKxhKcHv8AYAkeRScK9mk/s5dPcHnNH1B36u+Y70c+wrKpzsqnPzN
 nbch5FYzA+yskFFeEqzczxRCZ0WqTzx+MmAvFNcYsgdY9f7+DZx9jsG219+4HVCV
 GPQEyw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgm0gmyhc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 05:33:04 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2e9572e892dso21567085ad.1
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 22:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792992783; x=1793597583;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fw3YBDnl2JEKQGYwhV1bigEwA0pD9yqTO6oVKeScAcI=;
 b=E2wA3v08QlZqTM04+nTDXDrgvHjb231V8dqzKCg2dq3ON8c5m00RVQrXlWoAoOTmLW
 fZg/VL+RoSdD/ikt5TyNHHaGRpIqAQ6hxgAwpsu4pwtFb1P3tn2YmBDqLwZi9hDsLnBF
 bXlqP5GJes/ENvhUFa+umomKAMJBW5P+FvjdEAS4jnGbEEcEUz/Gg6imDEVXU9p77Jcq
 vjMQqGW1PLAxuJ9GRgD8X3QUAvJCbl1xpzQLpxlbn8mvi3iY6dZTpdIWgae1+T1KvoBc
 oRH8iS2Wm/7wdUzqgCXS8ZlGjR6ROUq/spCoW99n9Fisc3pVkdqptKQrxXyk93YuHW1b
 K5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792992783; x=1793597583;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fw3YBDnl2JEKQGYwhV1bigEwA0pD9yqTO6oVKeScAcI=;
 b=V8TvHRuHIv99QbjI87CzWbo5+hUTSQdeMNA6euFlEu/AGpuYEgQN6VJ9j25OZdMm1A
 RZIrn5gd8TD5cD5TjLkIa/WC6wJr3V+3/XSoWePZipIJsCCDwot257Wz/cqbxYr9jYv9
 R7aUkp9wOrBQGk4jpmL3lwBrIXR2+mvhfFSfGYGfRet5JzIod7p6lNpRa5g4AmwNRciD
 HME/aYJz6E44gEx5LORBBk/9eed3Zunwgodf19vteFYgUfLcRRWXgyReiL7HYGaAd1NV
 9CXMDR0UdbhuoSPZVeF3JWVfuUjGZ/F+jnPzosKuQjGs7R+0yF0aioLXUVFLeLXfGooz
 XISw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx1wLstfoFOVP2n+qAgTFs4QNiT7y6ty1xY/LTF2i4wPvtTxPvgvHZZBMgFwZ6lW7K5Dr/rnxdRYGY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJC0dvrEXID79roPb++wNKU2t7hs4KkIX0M355cge+iPZPu44lg
 yDeMsC9DepHDZKXjz0vghl1dHiufewpCUl/sU+/TtBkyyXJyiWLtkEH2JaCanmZwXzUxowxgI3i
 fMw1INQb2E3rvKcwLhQW48eJwnEJbZRFl4Ndj9yLRIDDyMELuVtmaZt6/72rvz3wJ8tyA5N0=
X-Gm-Gg: AYBFou3+VvC0Bpesz0oUub7FZRsUdPSvLPJHKtmPbs/FiQ6qmNohXIgAgVdDz5pq/Mk
 I3h0ohoxySy0lpKSaR/AhSrivkyX33UXsj0FxE7ZYThGd4LnWjPTl9BlQ1NHeGLHsc/ZmrAgf5y
 /Nqbi+ibXAS/95nmhg0Q3wRpab6ywDU0yVGg/x6bb37HTR9Vu+xoiC2+jZpmb+w+rwp0exwDgef
 32BmvcTktx3yz+h8Ee6a8B4RkjL3mpP/mUAlk+Uh/ZzzKllvqexUIGFmqHDb0RrrM5ypfv4enNE
 K6hHXRFZvKMENMi1w8JSvhyegazzGE5DC4FFXJNnnMP6RARiKgRofpMHqc0gvnf/UxuBROisuKQ
 IBtLX2gLHiUeDKLwaMWdNn4GcjyZlJw==
X-Received: by 2002:a17:903:1103:b0:2e8:3e5d:b2b7 with SMTP id
 d9443c01a7336-2ea9c8754e2mr48634125ad.40.1792992783518; 
 Sun, 25 Oct 2026 22:33:03 -0700 (PDT)
X-Received: by 2002:a17:903:1103:b0:2e8:3e5d:b2b7 with SMTP id
 d9443c01a7336-2ea9c8754e2mr48633935ad.40.1792992783091; 
 Sun, 25 Oct 2026 22:33:03 -0700 (PDT)
Received: from [10.219.57.104] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ea9b1dfee1sm11154465ad.64.2026.10.25.22.32.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Oct 2026 22:33:02 -0700 (PDT)
Message-ID: <520a64f8-db87-48f7-bff6-08a4bf6fa2e8@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 11:02:58 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] arm64: dts: qcom: msm8996: Remove FastRPC compute
 CB9 entry
To: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>,
 srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de, stable@vger.kernel.org
References: <20261023090308.2898683-1-abhinav.parihar@oss.qualcomm.com>
 <20261023090308.2898683-7-abhinav.parihar@oss.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20261023090308.2898683-7-abhinav.parihar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Haw6EYMXIFdqoJUXX0l7-W9t9Y5cX5MI
X-Authority-Analysis: v=2.4 cv=UfTE26SN c=1 sm=1 tr=0 ts=6adee610 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=jtUn83jyyIc8HPFL8BgA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: Haw6EYMXIFdqoJUXX0l7-W9t9Y5cX5MI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyMSBTYWx0ZWRfX/WxveCtL1tG3
 I4JGIuT+Z5EheRAiq2IXd+2yd9nmeQfD+3C7uAZLfKt4S1SaG5gxhZceMSlmA+tuGnVcdr62tm6
 CNqGCEsq3hZ+bBvvCjDBnMXKhvIKVn0iDhW+eiAkqhawR3Xbbov/SdlFijcig0Lf+5rvFpZujaa
 oVgdjnQ6e00lA1z4GAWO2UEHPWe4kHnmWQUiNfnqxzLVqyDIOsRRXVCbTECTzQgC4cExnL/q+fx
 HaskA8+MXQ0o7hrlrI4LDnxKob+NIeaxaKzLh2D7pG3jtumqXkPXFSM0ps6xlbnd7/bUyAVOLB+
 65hqf8vHNUoohMR2l7tZwxiiLg1SZlLTiwIA/LU3bjyvZF5oH1yJV5DWk0YwkFjpDVE+lN5ZMN4
 lUpMOwiJpbr+A5XfrPVR9lIzBCvP/RJqk7oHRBQXXnxJKvrysnyjgNsKcQnNEV0WgUUcgvweM75
 YItjZIgkEP6x+rnuJcA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyMSBTYWx0ZWRfXzZImxVPgOiQ0
 Jtz1IZiTezFdipaMh9t9muuJDI1Hi95Uf1sTXUqNozu07yIYgHrgcqAkt9iHQazK8P4DZVO9urA
 6fdPKLcS8F8d8y+p6WRZEZuUtNkCes8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260021
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
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 23-10-2026 14:33, Abhinav Parihar wrote:
> Remove the compute-cb@9 nodes from msm8996 device tree to
> prevent clients from selecting a secure context bank for normal FastRPC
> workloads.
> 
> Secure use case support is not currently implemented upstream.
> 
> Fixes: 1b80b83f893d ("arm64: dts: qcom: msm8996: add fastrpc nodes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>

Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
