Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B39D606A32D
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=T6Y9zr5j;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iqyCq6BV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8DB110ECC8;
	Mon,  2 Nov 2026 10:30:50 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E768710ECC7
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 10:30:39 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A299xnR3430281
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 10:30:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NzHFCCrQzGLsKI8/KQW7VhRBUvifYGel9dhS3AdJCd8=; b=T6Y9zr5jzNmeahze
 Vk3VgX6HlfKPD0egTiQ+7G23C+ONdR5ejKOm4byHnPcPcdpaUIRJ5spqS2+kLqtk
 ieYaf4jOa2l/80Zb2YrBFIPoqRVwWTbi98LM9843sBEzbA3ElA4jMZHpcr74dxa5
 6PIyfMjTzQp5sNLUDJ1JHFvCYMehZbvVBRToC36VwFDUsncz4WvGSQEGhaERLzq2
 AJ3QiwSCGHblV11dK5oewoUoD6L2sSDz7x54aLg+AJX1pvj/p064Ey1l2qsWeR1Q
 xf+xeuVJc3N8AhZvl+D1tai07PnwLQW5Zn10hOwem3m4UTUxzrUK798omWAPwfj7
 w6syfg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpnmerut7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 10:30:38 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93ea6b66e53so53905085a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 02:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793615438; x=1794220238;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NzHFCCrQzGLsKI8/KQW7VhRBUvifYGel9dhS3AdJCd8=;
 b=iqyCq6BVL5SoNE/s/txageeiE3JZp4wUYDkp9WK0D3TVdCQKmnOczDgFU4NSPS2VAc
 xJ8v5d7/54kyGlP5wql2Nl78dEArSD/41wOjsRkE6fmhVJNeUY7huy+KGsDJlJThNjU8
 a8/c62ZhllZUYpRz7mKV+maV74MRkDBUcdw/paND5oeCQ9ks79HcoubVUS8b995rMccH
 CarIy7rGapoPsVWcDq3K3HcE4+me3SBQndUeuJf+dgggKGKCyhns8tgxHL7pAZ2zDxgk
 30f2wVEyZXwMA0w4joph3WZ+sAfisvvOIqOb8xZ56AjumFZgsZNAYdWqKI/seWCzBINk
 bBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793615438; x=1794220238;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NzHFCCrQzGLsKI8/KQW7VhRBUvifYGel9dhS3AdJCd8=;
 b=K3ozHGyf+macbiNnB6WTrJYrMicJlibz4HOsPwKXgyYPgBdglLhJqAFM/oWI3H00v9
 F4a7lKc4oTiJmnplJFXEz8OdJDoswxjq1RaTiC7SZtX0eMxl3/dggg3gGppHJ0k/ldtO
 otZh+p4YJeQVfDawvRX7jFqf6nwQY8c4DN/MurCSol+2KYzLuJR15/cSNr1jL9L3rnfv
 Cu0kmSz0qiNFOutDb7AzG7R3ScvrTipWgxvqZRHkMkrVNM7crzLNg1n1MEE38Rm4kdNq
 vQ2BgSsB33vRJndvK7K1y6hWWtrJPrUbsi5UXKhQ9xaOWNSafUiUN/Nrzr0Zp10qso9V
 lB4g==
X-Forwarded-Encrypted: i=1;
 AKwUvBycShH1oLF6pbdBwkV8pKvZYh+aKoWjIon3GZ9h4X0VvtnoscDO5D6UpDO0OM6cVTkPplUozn+WU7I=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJeaYW3R/Hz+HZJqlAzQZN5ICcR/vOcqXlfKB64198vzWSKrvTv
 vSL92gawZ7N5Phd6Pd8qpdtJ12SpMDhJK3puuT9lN8RQnB5PzkliKYsIgBz4MaDobhGd93gkFU+
 69VCzJD/Khe4LuenVfrxnC89LwjSXqAKiaj165QEdfgBUUWurHeSQAMohHjrK1U9CjkMpqfM=
X-Gm-Gg: AYBFou169jsV+hdJvZjFR9+wxOdV7iiKb3YeNG7PmG9OrVxMPj5IBS41GDUo51RlK0E
 r0wfetCbzoNg9KbSfGiw0TceX4jiIuaGdTv8AJ66fHu8tXC+O1AEXZuVVsx+Gsbu0VEyN1sCm/2
 RvEZ4Sex/y90zy07mbeiCIEEkGneCz76dgHFF6enXxVO7U4eYzXgsSPR5d7t4kEb0BdjEq5cm6z
 Q3kNu6/q/qNytX9iJkS4m6beoFCBrN2/kFjsiaO0qWCWgWKTuCu6yDqq+uMgjBqWQRd24dVK4zE
 UzOA00+81zYx9o/irIybCugw6TzCvvqrSsxE8LL+IohjH/EHT7umVmkN5LXrhpDPPlOo8kiVivt
 1CGcK8fplXAVlMuIOP5dQFuxXkaC8V2OJ3Ru6oA4wettKSkGue4av3KqejpBOyO/5ZUOy48Q=
X-Received: by 2002:a05:620a:85c:b0:93f:977:5d9 with SMTP id
 af79cd13be357-94421404364mr1648769685a.0.1793615438320; 
 Mon, 02 Nov 2026 02:30:38 -0800 (PST)
X-Received: by 2002:a05:620a:85c:b0:93f:977:5d9 with SMTP id
 af79cd13be357-94421404364mr1648765585a.0.1793615437867; 
 Mon, 02 Nov 2026 02:30:37 -0800 (PST)
Received: from [192.168.226.248] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4cabc174c0sm366006266b.8.2026.11.02.02.30.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 02:30:37 -0800 (PST)
Message-ID: <dd0d1941-485d-4eff-9fc0-6dc900d198d9@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 11:30:34 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/19] drm/msm/a8xx: Stop getting GMEM_PROTECT from
 nonctx list
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20261030211928.45761-1-robin.clark@oss.qualcomm.com>
 <20261030211928.45761-8-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261030211928.45761-8-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KZ1HIgYD c=1 sm=1 tr=0 ts=6ae8664e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=9tEP0OE30YQ_IqY-BwIA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0MSBTYWx0ZWRfXxy7I8zYFfIEL
 psZt0e7u88fRAQKJHBr3qcvRddevFkyIQUdsoaM3ll3lfR1MKP15rVyRxAVz+/+litDAxvgypB5
 BaPYBMr5eiPlrJhLOI745793fHRKTHfND3/TB8n96INlylZz1ZHJl6/EmJvUwKuSyQZNuwfBHR+
 f+xDIWZjr6rfzaJ9d//QA/uMHdfTTv9LBrCSuq9LalaK8sIWmFd9zyPWXESPtx1hVZbk93sdIWZ
 ye5MZtRDl0idP4k36ICDRf+Pe4q+KrndlZQhHZZfSpBO3txG760GfmsSZ+4P3sw9iEm/LMCFQ3N
 ktXQYjqVdULebWwov1RwB3n6ENcTzOb3EnX/niGaLGFUbS4z2eRYvSHfGNd/DAye2p0VNgwehcH
 id/RzuyBtHdAXuGw4+szeSz2SHKTT74resY3YJK1N5ljzky7ECzAoBb8YKsi6TA9yP0haMxjsu1
 6TuIrI4bUIlU0GmjXOw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0MSBTYWx0ZWRfX/5EC5BQkmM3B
 UEDuz/x0MTlTZcZYjsMlMVY/E44c1PEZMMvKMxav6DDCXMDrdptBtoyQHMTAoQQb/0t7n7r/Wol
 4mnilP7GWP0DMjRzYOzwAFrXkb3cP7s=
X-Proofpoint-ORIG-GUID: UAbWANU1uvNtNQhd6iRpAhnRFpAi2fEn
X-Proofpoint-GUID: UAbWANU1uvNtNQhd6iRpAhnRFpAi2fEn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020041
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

On 10/30/26 10:18 PM, Rob Clark wrote:
> We can just simplify things and calculate the value, instead of manually
> adding it to the nonctx list.
> 
> Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
