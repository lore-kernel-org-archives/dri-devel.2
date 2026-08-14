Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F25C5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 19:11:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96F3C10E094;
	Fri, 14 Aug 2026 19:11:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aUMRL2p2";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UY5Rjpvd";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF5D810E094
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 19:11:51 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67EGi7K02608546
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 19:11:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SohSU0/9k/ZRs0kvdJIY0QMI2ZHWYJ650KSj2jQWXnE=; b=aUMRL2p2KrH9Lln6
 YWgnODYNOSTHKwJk4s0D+Q9T9QBJd/0Et5NsQH4vXvyLaNcWcjDsUjSVjEko3Nct
 aUoBqJ3lzVXyEfRdRAMLfbJiJh8U1SmMrgvtyuAdEBVWc+tGJYGbwYX04aBBJRw1
 3MpReoDBtYWnJKVNqdJh5ERpbyCXiOvpxMN/qMgp9lXhUHhxnZ6HNfYJQtTyGPBO
 AHVQntelMqHjQLysqwl13XZ7vKZ++K51NVq9txc+GHDQ1ZmhFwjxCj6zSgH4C2+y
 3agKuVpXftELbHWi36C68kkIsL5XCVybaIIsSNa7BLHgjCwNKmCVXRvyKScIKpOO
 zOTCBw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g26j6gmsj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 19:11:50 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cbedf6e8a42so1539029a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 12:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786734709; x=1787339509;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=SohSU0/9k/ZRs0kvdJIY0QMI2ZHWYJ650KSj2jQWXnE=;
 b=UY5RjpvdinEyfCZABWpXLEsMKnF2smAMar9KVAQxN7L1g95jqk3W2fKoU9T12Y1OA6
 5JyV+UOV2JBNuj0OxsEC4JdX4h1wytHFQDjLF1J8bAlg/EG2tCPf7bD9s2kXq/hAApBE
 /2sHmrZ3b5QbDw/2G464oWo33NaOROH2MCoUlZHJ13VuekN6Dwt9q0Gr2rGd65wLG98L
 DsI/8rYK9INTJGM1zEzFDeYHWfz1qNsZXkOR9BFjU6Ieubu6RspBlID+Hjo+zmDsn6QG
 OSgIpqbbdWlBWiAlnJ0MRPadagUw9Z602jb3NCqRKkGGYcK1jIP5Ni2H9WhT1YNfwlm7
 oa0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786734709; x=1787339509;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SohSU0/9k/ZRs0kvdJIY0QMI2ZHWYJ650KSj2jQWXnE=;
 b=M63WQ5kLg0/92G139gLZKyd96bymK5lBjZSpcz+8f/OKB4ImpksQOLWY44BucQ7GnZ
 BASN1bHZgeIrz83o6xXx0PqrW2uxKziTl/1jT/GEWsQ8OXXkJM4HvqNFImMFT4tidjhI
 lQUbX5hc9ZQmPuFNel0F6avkliVbsvxFFzP4YToeAfcPZkb5e+xEU1iSshxLqzFIMCAf
 X2i33MMTc785FtcoiK0JrlbO92w4DTn4C9Zu0u3QdB9gBkCzkgKTXlskhweeSvZ/isCP
 xtWYC6O563qv2ApYlry750D2b/e3iHY6nVhjJrqnLqWDhYVyfMnfIywXGJxIFbo2p8kK
 6GGQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro7TkQAN/aD1Yts14KIgIgFpQ1WmrYf28BxXg+ZuNcEQCwFdkQu4bopVhto1fhjxdcD9H1p6ucvmWE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw18HP40WWDuEZ2xWAg9gQYSs+HqLdEHe2kwVfk4DRdDUneyg0Z
 HNus4ucIhLO8pzPMODJGZfPaI6MGjwUw8mk9qK4JNJwCT1imrNfxbL830lghlHFrRneFfccdt47
 SyCyi7UBiQpDfW4z+NVzuR5yN0TYWgxKEJZKWuAsAHr2buqkVjM0A7o04U4kmzpclZ7sDpAQ=
X-Gm-Gg: AR+sD12Ud8gBZdDwyDJ+nkkEm1to32WW+mZHReVcpDsJ4QK5iOAd6U0MhWgRSZisjT7
 EUD62FePH6EmIBctr2ZJGEunQZujwbLmEMUzaB/CA9xvKe2hTMonoPhyM4xtwlEHMyV6AHe8Hws
 LLZMLBiryh2ahRzTxG+qLuYLZZdoPAbaMePktprmAbMPYWqGADpD8mQrk2CBERZoRwLExTsMps/
 xNXbFwhg3pOFRQV3xR8cr4xS8qWI6OxsOfyOzm+0St1h/1lSdd3BZ9BX+tRUvr818vZ+ScUFBLK
 0VBmR3np0VPesXpZVrbGgmlUvnLFhxJzck2CFdE8crpfawg6eorXJetw4x7CF+8fwX1lDJgNTWh
 m6Xj4sYb4gF/it2512aPAYNuZwT+lF4nWufiE6sn7ADTmr2EnLMcyZQ==
X-Received: by 2002:a05:6a21:7d02:b0:3bf:ba48:ca88 with SMTP id
 adf61e73a8af0-3cc71bbf3d4mr10521396637.15.1786734709537; 
 Fri, 14 Aug 2026 12:11:49 -0700 (PDT)
X-Received: by 2002:a05:6a21:7d02:b0:3bf:ba48:ca88 with SMTP id
 adf61e73a8af0-3cc71bbf3d4mr10521306637.15.1786734708928; 
 Fri, 14 Aug 2026 12:11:48 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-320c6be7f6fsm8152663eec.0.2026.08.14.12.11.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2026 12:11:48 -0700 (PDT)
Message-ID: <96e73102-eced-4937-a622-6f2cb5a32ec1@oss.qualcomm.com>
Date: Fri, 14 Aug 2026 13:11:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] accel/qaic: Address potential out-of-bounds read in
 resp_worker()
To: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>,
 carl.vanderlip@oss.qualcomm.com, troy.hanson@oss.qualcomm.com,
 zachary.mckevitt@oss.qualcomm.com
Cc: ogabbay@kernel.org, lizhi.hou@amd.com, karol.wachowski@linux.intel.com,
 ruikai@pwno.io, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20260731152344.1905882-1-youssef.abdulrahman@oss.qualcomm.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20260731152344.1905882-1-youssef.abdulrahman@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: pt3OkLauHqqJ_CiFx70Rzi_voT55XgB_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDE0NyBTYWx0ZWRfX1uTuhAO+/LjL
 uxXnzY71cSwJ8uAuxEHPWNdS5/fcFDIjucoPTuFsvPSSoULtMf4Vywrm9iUbjB+zgjpqw/Ve221
 3anVNt9tjvEqHAgi/V1a5GZAolsTfuVHAj8fqX60RueD58XjJF2/XrKQWV5ryhxPLw8DKnqPpJE
 R0n1heevRxvsb+tdl44gPoAdmHhavSHMJUwHgE0ms6xJJ2GTbBtqUuufGwA1X0Je+x7i1UCBKnA
 TjVK0jz2PZCyqfuahkVYbdsIg7oAWeUHE+jdnRhl+ojg1ITfPVc8oFgYGaWLd6u75g7XZmJbZ13
 MNV1IT2p2nDNev5/9HVy9uwJ9g8B8kbELZi828ufImeAvhr99gZSnqhLE5YpWDXkCFtn6U3lm6o
 OE1uurDuVtLZoigdmQgYma351I7qdToQD++61T2+j2p48n2XMyJQ4BHpZgPX8P5s1YIZ4h0UPsY
 aPTI3i5hh1ggvoBe1eQ==
X-Authority-Analysis: v=2.4 cv=ZbMt8MVA c=1 sm=1 tr=0 ts=6a7f6876 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=zd2uoN0lAAAA:8 a=DeEPClqeKu6msZ13zAcA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: pt3OkLauHqqJ_CiFx70Rzi_voT55XgB_
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDE0NyBTYWx0ZWRfX6DxCKWKkHr/d
 TGDObvKT6EG5GGyM3fJ5ujFjwfS2paNbeOrqYks2cU7DyFpLrRPNgQvg/dNPpsmK2FOOxKbEJRf
 nx7ueqkKBhF3i9UIA/MQfZsU3+WUn74=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140147
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

On 7/31/2026 9:23 AM, Youssef Samir wrote:
> Although 'commit 2feec5ae5df7 ("accel/qaic: Handle DBC deactivation if the
> owner went away")' fixes the scenario it was intended for by walking the
> message and only decoding QAIC_TRANS_DEACTIVATE_FROM_DEV, if present, it
> skipped over the bounds checking code that is included in decode_message().
> This could lead to issues such as reading past the slab allocation's end,
> infinite loops or kernel panics. For those issues to happen, a malformed
> wire message is needed to be sent from the device.
> 
> Instead of duplicating the bounds checking code already present in
> decode_message(), use the function inside resp_worker().
> 
> Reported-by: Ruikai Peng <ruikai@pwno.io>
> Fixes: 2feec5ae5df7 ("accel/qaic: Handle DBC deactivation if the owner went away")
> Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
> Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
> Signed-off-by: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>

Applied to drm-misc-fixes.

-Jeff
