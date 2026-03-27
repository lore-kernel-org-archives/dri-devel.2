Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02EAE10F285E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 17:24:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E0F010E08F;
	Fri, 27 Mar 2026 17:24:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DP/l1OL7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fy44rI16";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0BA610E08F
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 17:24:47 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62RDhLhg2769486
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 17:24:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RxyJzStkpJcEbJkfZenz3/xq+izSJI7BIJhAfqYYo7I=; b=DP/l1OL7qdM3E+ax
 1A9V0O8p5x6DDlraMIVou6P9yHfg7+l36XCne2TtNDyAYpXMJOzEuz9fUkNscNvr
 oyR6I+soBGezrS7Px5kbJwn3NTjjU1dnjJCHX9k3NO0Gko/PD5lSCpa08R+hh4UX
 Q5bQ+FG/nfASAPWyVS6ljifuP/dUlNY7/2yn3uttxNyijpzAaf/4IhqTjAmnODHe
 EotJbV4WdDrqmHATeTX/OFfVpTs6O5U/OwM5Iol3Lk/qNfp9BCuJBz6f1AJF7fmB
 4uX7bdyo0jSbtqlevsF+CXcXQ4KoUnDALXDv3P5DkR1DpUM6VaQhzg49kUBqQM2R
 bh5RPQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5bxv41r4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 17:24:47 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2c16233ee11so2235093eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 10:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774632287; x=1775237087;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RxyJzStkpJcEbJkfZenz3/xq+izSJI7BIJhAfqYYo7I=;
 b=fy44rI16NLIO9ds3Ujg4On5eCvEWXAtBnuZHOsAEfA0fTMvBkAddMvMcM6c1Floz/5
 BdlUSstLwd50fqZRTZBJsrENV5GLshZSt5dy/BbpDh9xjKze/Q9GaUm4mPLZ9airTx3T
 QzRCnFERuzEc3uLDdTI+HABnzKi14Mmz93lpE1qajeUV5CkPSu1EUEUV986siH8mmd/4
 KujufFYWiO081RJsguS5yyCtDBauxM6Q+H8Pn/ICMzFak/lrKXAvFv5FbXy5esOidSWD
 eWr1+nkXWoAxl2gZw01fKsP3hYbGRhwiRuUk6T5uXe3LmDUK5dcWzuqisizxd/GwKI3+
 6DEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774632287; x=1775237087;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RxyJzStkpJcEbJkfZenz3/xq+izSJI7BIJhAfqYYo7I=;
 b=obHCtqLg+G8tP8e7h8sUmVqiCgmlXgjdeBAR692Xd9ySgJURksM/Y3Fzo06FYXNyiJ
 x8rMQo8xvo0cS8r/3THg61DLdSrgMh+9ZQFmYmDRuuHlaYPp5NHBYhdt85cz7raQuFjw
 gR/tZwd5Q6XcKC2FzWYSFDDB0kA8trw3/3mf6JHG3Zxz1U3h8lYtDNlZu0xe9vOVCfFB
 kTBtYkLZDZmkcu6cp4kQRQ+6Jo8RERHJ1RtZ7V11s2+Ka9XkSeNSG42FfCs2B5kJ0BDv
 AGxpw57KfnH7BuAVy/LHVXj8MAxPIW1j2uxF8rFu0Yv2jFQ6ovopivjijMrhVI4Z0M8f
 4Y3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvQD6xIhQUlCS+xj8Yalzfz7Nxxg+vrcFSLLWMbl6FfQfcMDtmhCHPPg1AuzgoxWJ29U0z9UM5/is=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz9dOXwLIx/Rb0DuXMemTq9BFAcJNVNSSiYId+DHK3nTDUQiqUV
 +kW3k78gjH2ZNa0Br3pwnmUJAzxbcPQIKAF6aJgJ3dptv5JkbURv9J6h5qwQQ+diT5WJxuKXO6l
 F/5Uckg/LTUCI9pSq/rgXYRWzZjk0PiUlSUqUEvClWUOdyU//z0O+7Rf+JI/IWNmwPVdNvCU=
X-Gm-Gg: ATEYQzyXdYEgypUWULY22rs9krdrV1qouPOPUMokMt3n/UBX1jXIn1J6OzRS6KTLrHV
 Zk3NItcSErtmw+NGdS0zbX3TKZSb8DxBkYlOxWRk8BerEiadJ7gnU+9pCP8hqmZkQwkvfxiui+Y
 z80tV0dUHaH5aEZQeTUq2x7y5yQpR3svBe+bYfUbwPYp1N0QtnnB1tCzk/9IWHCq29ay6Lnt0Bp
 JTFheiKpebsX/ViLdCtfAm8f46uPFBEtAXnK02jNZmAwu7Yv4vHKyp0Lhryg9mFEzUh6uWkV4h2
 9npMFgr48Lr3WjbsfvVGFsy+wl+UxMAGUuOHBJeBl+cm++R3pOUQcemQrdvmrqkwCsdYJXd+1hl
 Xx47cGyzRmu3BvRU5VlDSmGEPtNZOiBmRSrUNhe1Vm8LhPmfRGAWA7VHV7jtb0ywMQSCrwCYH9X
 g=
X-Received: by 2002:a05:7300:5b89:b0:2c1:1dea:c443 with SMTP id
 5a478bee46e88-2c185e460a2mr1696315eec.19.1774632286597; 
 Fri, 27 Mar 2026 10:24:46 -0700 (PDT)
X-Received: by 2002:a05:7300:5b89:b0:2c1:1dea:c443 with SMTP id
 5a478bee46e88-2c185e460a2mr1696284eec.19.1774632285930; 
 Fri, 27 Mar 2026 10:24:45 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c16ed9f751sm5677152eec.14.2026.03.27.10.24.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2026 10:24:45 -0700 (PDT)
Message-ID: <1af00780-e291-4444-88d8-bdd1acf93193@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 11:24:44 -0600
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
X-Authority-Analysis: v=2.4 cv=A99h/qWG c=1 sm=1 tr=0 ts=69c6bd5f cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=oqBJM22TPj05MoDBPk0A:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: 3ueUDF4cNvC__CzdAuHUrk-Y87v42CmO
X-Proofpoint-GUID: 3ueUDF4cNvC__CzdAuHUrk-Y87v42CmO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEyMCBTYWx0ZWRfX/4adIB6hZebz
 zgOok8pY74SOH1h7VrWTYV+rJfUi828FwN7FLxEI0ADLJmo31ZHWSkPyhXd+pYl00XO0Zxev6iw
 B0JQpvDGr+jgZ5G+yTdV/N7dgy/gvUynFd12C4MMhda8jQVuR/0KmNSTxU0ueOfFP3syXy5uJ/N
 wXL3tJE/1CLa/QWDW9+NYvyAL5cxAm8BYXV84b/+1KjQWK7rcpRrGKqv/knBSCrVdohKHsNMZSX
 rurZ2KkquWDjbb2JjrWxJrOFzmeUta5H8Exh6hANbjIcnFoHelk4HfxKCmgxuCBQludMacc3m+s
 xXT2DgR8603g64y55Mj8LnxDYS1yyJ8/mGx3UnNTCURseG++DR1BDM0ABm2iDD+tdrJuhJFzTnc
 rJtC8pCaQz9s8uhSkGGVa0123NmpVrSMgKXD7tNlnwvZuKjU3OkcD95QoO187GeMQSFFp/9s6U7
 vjFDK2HMZWw2qESedGA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 impostorscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270120
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

Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
