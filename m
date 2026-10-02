Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39632CA5FD4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 16:53:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BD5110F92E;
	Fri,  2 Oct 2026 16:53:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oZB/ld9s";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bJeIh3u1";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A30D210F91D
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 16:53:41 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692Git0i1434994
 for <dri-devel@lists.freedesktop.org>; Fri, 2 Oct 2026 16:53:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Cfzk95m6dKF8dCIAXVUBTKT1haxHUu6c4STrvzIb9rc=; b=oZB/ld9sPAnhZnOh
 WeQ8gncIEuN7pKmOaAXsnz0KGSy4EmINbjzlXbdjGA/Qca7tYVVK+miMqCWBXDGB
 YS5tK9YZ4xyijZHIhPJ2oWZ5zF0IBQm2f1NuzsDLyIFezdillj/WLfGpi7DiSebi
 rIDj55nN9mZ4cZH6lBiHcpVHCIj/N41nZi6j/4P6rBVh6v5uMD+1JABelmQYVQTt
 uoFGQ4AyD8zvuJ/TQnrQgTYFqsQ4NoeGXVgaMG2fVeT4WddgwXag7wsYSUoctLRA
 8QrIqYOpom/gI7FFNezzdGsmC4D6KD2HP35M0zoMVR/LBwr13b3bmiaXsz2TnpLE
 GjAp8w==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2f3d8dye-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 16:53:41 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso6439927eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 09:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790960020; x=1791564820;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Cfzk95m6dKF8dCIAXVUBTKT1haxHUu6c4STrvzIb9rc=;
 b=bJeIh3u1xsvkJE/RGhIKfClf69JNn+zChKYf3+Gu2asXfh3tckCHKaxV2Nxan7VmAU
 ZXS7qOE3KrbXaSXi6ItxhwfFTW4zqag7HrLglXuLLeXi2kBEOiIfpooNqM70QbAE9Zrd
 A3yP1tZ28EdYvtZYlPuPWEVFpjUYQlzqLxrkGHaQvnUBPK9Ua+cwIdyiljpcHDTLFGvJ
 CyJokCbwltn0eatkKe5NQykaLaozbFaiFDr4qvEC6mhoWj2BnpZdt/JGguMnBH4OE4XT
 QAdZib091Qr3ip0zuH2BRe/pV2cGBkA0vUxTDhwXHmUSstLb7A3hF+SFgL0LKHnzAdZE
 TkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790960020; x=1791564820;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Cfzk95m6dKF8dCIAXVUBTKT1haxHUu6c4STrvzIb9rc=;
 b=DR8BS69hETsbSNBdQafMdxxld/vJwQNQn0nSZtQ3/sIVmihLA9/a5jS1ia2d0eGSwd
 aJ1xJ0jr2kSHEg17qPNjaLf52SPJVYXHVPbTAeAXB9wkBIykDjraZm5sREhMcx3jUBd9
 uC6gKha3nVvBDnS2XWuDufdbKn2B3o6ghG0ISJDHnfxjsXowE6CCAhhbDC867fzzfEEf
 L0o+77NVlfSjbT6KNJMNtgs2q2TFNXoIsNjeYsMhxypMdc4T7D3upEEWpFzmb7h1SZZM
 1rlKgxNmZrSkizPLMeOhGifP389JE5O0pmlyqAoKkxCbnFV7F3C+gH35W0NWRmJJqc1D
 WIag==
X-Forwarded-Encrypted: i=1;
 AKwUvBxH/9qtOoay3ebdBgscgDtB2Vi2QSl6z0BTvUUJlMhu7igI1eOh70ZK+ZqlD3YWq7fegslQIxB3oj0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mebiDKTEE2Xt/5vvl3cOn1CGgZpeMVh4PBNBQxTLoaikyKgUEA
 D+reMAQrDm+rVvCI5/i4HXLPe4TlNYCV51qTjj1yF4CWmIdYNJ2rGihtZCFhjtPyTmr0CStjFp1
 8Sipvpprtk9gtGmxtYYkrrWch9oGD7DNTL+GR8LuK5OYCPOHM7cap7TUsUAP+ssUDmu7bff4=
X-Gm-Gg: AYBFou1nvQHgNQMWe7xQhw9rI6RlSPcfaS6XuoqWecF9Fud7QD6wlW+5U+Cke6OddPe
 nwa0RNgxODMhBUFMi1zzNf+BVO74/gPMcPncpTugJacX9s1GhIaxPN9Wp6gW7VVbvwFKJ76VS4Q
 Gt0kD8Q+BJjTpcSt0UhcjQgEiWqeecFubXeprPyAu/wCV21K2GanzRq/MoeIErTPxhhMfpcc3Ad
 cfXo1gvdOrWOVPhTd1qvmTmJBQExZEUlF2KA6qvSO/zuRwOBNX8qWxYnXggv6by2/brKnw0jJyb
 yFqe7OKvUnmP5ZShTVmy1Q3A4WO1cj175Yl3cXTqCd0sgKxofJxPYsFjo3t31hBtC3Y2Rf4rNGz
 5Eqk7+N34nqvWQybUK4Fr4TeLKo9vdGGna7fAEvPHsrfrfwGlDg==
X-Received: by 2002:a05:693c:2a04:b0:351:fab:1c50 with SMTP id
 5a478bee46e88-3510fab1fadmr573633eec.6.1790960020310; 
 Fri, 02 Oct 2026 09:53:40 -0700 (PDT)
X-Received: by 2002:a05:693c:2a04:b0:351:fab:1c50 with SMTP id
 5a478bee46e88-3510fab1fadmr573595eec.6.1790960019685; 
 Fri, 02 Oct 2026 09:53:39 -0700 (PDT)
Received: from [10.226.59.182] (Global_NAT1.qualcomm.com. [129.46.96.20])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34ef98d925csm8184315eec.0.2026.10.02.09.53.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2026 09:53:39 -0700 (PDT)
Message-ID: <a82e8399-c0f4-4d1b-a4ca-a17110f2ec91@oss.qualcomm.com>
Date: Fri, 2 Oct 2026 10:53:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Use separate flag for job timeout
To: Karol Wachowski <karol.wachowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com, dawid.osuchowski@linux.intel.com,
 Jakub Pawlak <jakub.pawlak@intel.com>
References: <20260914082800.892044-1-karol.wachowski@linux.intel.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20260914082800.892044-1-karol.wachowski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: YPraFANL3nQ8JV7UN6SqjgR7LLF8NCtd
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA2NyBTYWx0ZWRfX+2FY+/us9Hlc
 ZVBxx7BDUNN6JOBemKGotW27zw23/vh9Yjou1tLCeJ0fR3kZ4evqEuEq3ZnPI8eUjXB45+W6nex
 JEuuFsBGbuch1MaOVAuKgjIa3jgIkZ0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA2NyBTYWx0ZWRfX6AjvkVhVC4l3
 +n5BWl2P+0lxhpB0b/apZXAlqKuKcGh5OXn121Oh8SiLdBDPL2DFRGmd/r/X5jFzC78y03txh/m
 oiKp5k4dxHRv75lYuWZdmfbXwfkmMtG8enbvTWeG+ZP7SNth2EslZJ2+lasPrMc7rRFFGOnv9lp
 BJCnW25PGKzPRwuohpFgbQVHX3t6D9PANe1/cM+4VqJeM8IzkwXA8nORSfDW4HPftmSih+tvGdD
 FHl9fI7pSnm8aNb4TadV8kn7xRcDM8esYSyH4eiF43ntnvsxSMcG+dTyek6v0vHegqX/p/sjvJp
 ynfGOp7TGLgBNhYhE7XKt4OPpYDXatYNf5aIkBhJ5UPz4L+5LtI6FThvDTOcq22/zqRWVeayFKD
 2GIcphYYhWu+PVHDMBclHpzaQgDtxS92sH9ILd0+nVzkzOamuRg1gUp9F4JiIzCecXp5NRLyBFi
 vqQzJoImloPYzuK6qxQ==
X-Authority-Analysis: v=2.4 cv=L9SI0OT8 c=1 sm=1 tr=0 ts=6abfe195 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=C2Dr2CdmtRzbmYLdxgUA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: YPraFANL3nQ8JV7UN6SqjgR7LLF8NCtd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_04,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020067
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

On 9/14/2026 2:28 AM, Karol Wachowski wrote:
> From: Jakub Pawlak <jakub.pawlak@intel.com>
> 
> Use separate flag to mark a job timeout as a reason
> of starting context_abort_work. This allows to distinguish
> engine reset reason and clearly adjust reset procedure flow.
> 
> The flag is cleared in ivpu_prepare_for_reset(), which every
> recovery and suspend path already funnels through, so that the
> state is clean after recovery.
> 
> Fixes: ade00a6c903f ("accel/ivpu: Perform engine reset instead of device recovery on TDR")
> Signed-off-by: Jakub Pawlak <jakub.pawlak@intel.com>
> Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>

Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
