Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C963910F285E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 17:31:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3185C10EF23;
	Fri, 27 Mar 2026 17:31:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PahHv61T";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y0QbRM/f";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EECC10EF23
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 17:31:07 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62RDhFtn3084656
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 17:31:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pLOcGXIpoI92dPoTocEEyelLMfOcJ/l+Kn64KbaT2iA=; b=PahHv61Tql8wMOut
 rJ99wXUhLiXZ1vJzC6/D3QpP/U4RJiqmi26hDWTKQOujHtjYm+qSo+cg+g125T0I
 jDYcQhcfQVhm6FndAFPpW7h+ckDi21aBCafu6h3PomV1umSPRhhiUJ+PjMFtGMq/
 OX+3HnSDroMl5vzRjeYQ4sjh9x9aG8Imlo27Al2bUQP/cZjrqzK+Cwtdbz5ee8Xy
 l2+Zd+hl1L1vOmON5n0s50vFgDm69/vKpmdocNN1RtU1UKiyphSj1qu62/W/Q37x
 Zy7YeP9Ho26MtbJYV6+DDZY7PoZwsgY1ql4l2r6LGh3Dwx3NMODIvxAULWpJia4U
 3VUwfg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5mn12b8q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 17:31:06 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2c189594f54so4180944eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 10:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774632665; x=1775237465;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pLOcGXIpoI92dPoTocEEyelLMfOcJ/l+Kn64KbaT2iA=;
 b=Y0QbRM/fN/ngQ3pRC2ZTnKgiQIttS8wCsoIGkgWEh2AK2/Qp/1HXyVrzCAVqIHsA3N
 xzwuVS1OuYZYdFziXaPvqwj97gv5OOi36fKY7WBjUnLYOUVveArDBM+ICCc1Hs/7e/jE
 nCOGSpDqk0hu+mfTF7QapvGq2pkIV7wKhU1ZF7jt0IoIUtGwwfzIu7RwJoPYnHv/CUu+
 ye1h7T3tgJOmYoZ5XH/434m8an8Ye0tmQC5gRfEXYwYKVuPbve9cXzqv87J8yTaRgfzM
 1r41gqbj5VR2KfKgqmkhTKOIcRzhuIBaSMVYfWi157xrT0t7wB4ismUAsGG2iE3C03mL
 zbGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774632665; x=1775237465;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pLOcGXIpoI92dPoTocEEyelLMfOcJ/l+Kn64KbaT2iA=;
 b=lRXtiqTeWJosjvUe3wnztSZMUqXQnv2zklvsP5tJkOTBuDRLyLhL/T3eeIJ1sE9YCB
 ehBjETqu5DjDf9haxbcNPoCpLl1UZxvs4Su7akTxeyjFPsK0xRywIF5X67VAoLrastk8
 +MyFNyLW1lCPIhGBuSgSidDuS/diNIDhpTtD18aA7CSJHgXuLvZt7cs5X+6DKW6+RdhT
 i1JDfu5Mdoo2cjMTdvp+71483l7GZO0KQx4AYsfLmygFSMJENE9/9ucBG0BewbJ+RQC2
 /P/+w74RpWU2px7aUh8x0jWCnWYvM/21IAKtFjwAVHswXuPlDx+QDgM4GIHTW08NgFj0
 Wmbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHRT0YPi3jCSngWw2y9oEtc/LJHeAeH7xWUxAXzQ7sskzimDionnaLwicjH8pPQa73LAKM21d0SLc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwqanwPysldjAZXWLsnVyOfD+8b84WoXJjtNYJACFpC0Mt+HMif
 o4e7fQWDsbmPBRQnLEtAoqn5Z1y6ov4AKdEsd2LJkVRz/lDDT0GPQHX275C3HLGlQvMKPFAHlpB
 ryUqs0hdIqUEJJA4vIslRMUmoi/qnmgc/R4uepQy/NHs0lI0Scz5pzaEtKLG7IctYDK/eL18=
X-Gm-Gg: ATEYQzxdyIZzXh+UhVjJY+5jxicE4c7wNyFKbKpp5Z3d1btTlZt6I/NKpqbX7QPqBvG
 X8/Zi47SWSUuKah+kDoTwLXsXWQe8cdJ5Nl7dzCCkMzk9su2Pp2XuCk/dVLLlvCvzKdYeAYtpgp
 8qSTVNP670jtOqvpJOCKtYBEt4RZLvceSJm4eK8FVp480y3t4ttOv/ZaOjGnAc2GyVrUz8HRBCP
 KGoKlfavyX8GMdmsCYYnVC1mydrgybaBECzQ7T8wmgxOxOyQhcdMGyLlWP3a/MrLGbVsQkRBsRC
 qtu8W9nWO473+K0TIhsXzyuscT/ONI/pfiMogUUeCW4ltJmyYHXkU2p44wDSNABXG0ZjwsIBNUl
 PxiKBfxrO6O5yvf0Rw4aYWQH56dTpPnzB4xh6J3kUbqe9JUUhQHCnAbCrFAtu7FKfKigDBH3cWp
 M=
X-Received: by 2002:a05:7301:578e:b0:2bd:b961:7e8b with SMTP id
 5a478bee46e88-2c185e2b73emr1557854eec.24.1774632665259; 
 Fri, 27 Mar 2026 10:31:05 -0700 (PDT)
X-Received: by 2002:a05:7301:578e:b0:2bd:b961:7e8b with SMTP id
 5a478bee46e88-2c185e2b73emr1557832eec.24.1774632664661; 
 Fri, 27 Mar 2026 10:31:04 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c16ee01674sm6293658eec.27.2026.03.27.10.31.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2026 10:31:04 -0700 (PDT)
Message-ID: <c269de7e-511e-4b54-b432-f36da6dbf3ab@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 11:31:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/qaic: Retain bootlogs that overflow
To: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>,
 carl.vanderlip@oss.qualcomm.com, troy.hanson@oss.qualcomm.com,
 zachary.mckevitt@oss.qualcomm.com
Cc: ogabbay@kernel.org, lizhi.hou@amd.com, karol.wachowski@linux.intel.com,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20251223170511.2277302-1-youssef.abdulrahman@oss.qualcomm.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20251223170511.2277302-1-youssef.abdulrahman@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEyMSBTYWx0ZWRfX+ozaOVyP18Wd
 dbDdwIOBKQOtuLP2vYnttct3tG8x+PDp3oMkNSNDolx3Amf+32xznGP2ytRAmrZlpk3s2sM/tLz
 hkjWu18p4z14TmqWy831JF5Zhs6AMNzFS/2TkLLF0xG2NT63EVtGUdgvFG4Nf6Zho7OthMGADuU
 A2J11b7eiBtGhqbk67B/l2BuuLyIjrg/c7s+D9aGy71D0fNpB/UBuYODbI78aiVf7JRcHXtfKDq
 QvF7nuSb9Nwcl3xxfgummwCZ1NP45uXN/55QzAyD/W+PfhTlPRzsc/2uR9mSSDkSho70SmL7qBy
 ZkHEui7SlvOJIt6i6J3C06aEg0TIoRL2/0ds0gfxKsK8CwpCBmhbIcA1Nw5XfU/XecA2qm1ZJRT
 P4ZbxoEkmjACAP55O9M4S4aV6YmUAXbDnI6nOuG8MXsegBFlEPFvcUBUNom8tko7JjrJYaLWNiK
 6WCuH5Syri07qFoK60w==
X-Authority-Analysis: v=2.4 cv=CcwFJbrl c=1 sm=1 tr=0 ts=69c6beda cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=oqBJM22TPj05MoDBPk0A:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: Lj3sbYUYT8LzkBpCWEieb1t9V6F5iztk
X-Proofpoint-GUID: Lj3sbYUYT8LzkBpCWEieb1t9V6F5iztk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270121
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

On 12/23/2025 10:05 AM, Youssef Samir wrote:
> From: Zack McKevitt <zmckevit@qti.qualcomm.com>
> 
> When a bootlog requires multiple MHI messages to transfer fully, the
> messages prior to the final message may have MHI overflow status set.
> Preserve these log messages in the accumulating bootlog. Do not treat
> overflow as an error.
> 
> Signed-off-by: Zack McKevitt <zmckevit@qti.qualcomm.com>
> Signed-off-by: Troy Hanson <thanson@qti.qualcomm.com>
> Signed-off-by: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>

Pushed to drm-misc-next.

-Jeff
