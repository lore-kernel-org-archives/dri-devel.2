Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAF8606A326
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iaxwUrVW;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LNRNwcq+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E8E610EC24;
	Mon,  2 Nov 2026 08:40:30 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40E0510EC24
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 08:40:19 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A26pfwd3120947
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 08:40:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 K6ogSbk0YvyUylVZr4CzNwW3Kja2pbrugfWzt4tBuZc=; b=iaxwUrVWDGpR9G7m
 KHrqIv193A+yxzKN5AoZy5ZAyieB9I3E3lhWPp54Bt/8yTSYgjpB6jAXJJkIGz1z
 cHcN5gA1XljRc8by1OyBzW3IYw2FREqbSCq5JUG8CmG0xYbKSkmkKwwnrLpfyzWU
 FQGMt3CCKtsSytSMlHH+OI+acTFa87WlaEjn+cENDPlTAe8lSEecgYm2vzHMUnUC
 R11sqpT/n8E/Y2wdjbi8BlODrDOP8f8rRf4k+hk7GHCZEDHrfGv23OwUH6xiXpWa
 GO5ETvKb/VqiVkNXoLpgCFcx6O8hnR3M8goN1Emz478V1HBkpUHPAOYPezYhR1Ul
 fKibnA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpnmerd0m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 08:40:17 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5476f5bd009so1402111cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 00:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793608817; x=1794213617;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=K6ogSbk0YvyUylVZr4CzNwW3Kja2pbrugfWzt4tBuZc=;
 b=LNRNwcq+3IqRtCFxrFkVJoQlQMEwNuIe+R73NgrL9Ou92qrYM/yZpzbr0E3JoCtku7
 SEUv99yjErLMDNZy0wJzg7/8esRlQdlI5z6FRj099McpYFm7kYIfRWYR1aNHGACR5IGQ
 AfZBqunf9b1pk4vThAAzlX+ZXb6uY34XT483dWrULfRLQKp+AJoRE1iO/jk8Sf1PuP2N
 vs9Y26BMT2gWRSqH5BVwk380xPfs7VPihT+6XfqY25yZz74SNtIP1M7DsEqagogjphh4
 E4zDuB2Cde38kGUH0fmw/3UHrSxN1JQfp4SCgBzfD6U2VnX7hhsx5hxV3/dGvT5IFlww
 CEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793608817; x=1794213617;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K6ogSbk0YvyUylVZr4CzNwW3Kja2pbrugfWzt4tBuZc=;
 b=Nwp7C11c8I5oHyWvCXwSCpP7cZDYymn5o9cQxvCmXAVuEiQKwV+1pZzK441szCwKf2
 SEFrHRRtrQbJP8TuKL7NbTK9VKABBt65+97r2LF5fPu1tqvR/JuHktTLPbDdAcB/a/Kx
 oMlluv9hqrPqy7hnJTYNhgMKNI/cDp6SuAYFiCyKC5V4kdrWCs82akObk0cqFkLHEZuF
 NVEiLra7hr2C+zYvqhxgXjyhwgT4AzDv3o2fQgPi0Oxd2BWeSFckbYtarBbI914jelZc
 9mPJzS3XS85dYobEWAucoHJI53FKbOacSeIqLV5zQwvNvcFriP8rddoLrcW4ixGkWPxN
 RSKg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy7qLRCiLsv5zFjOjbrzKrpo3hkBAH0KIYVzvKz1GqcOub5w5ZY/mPG69fy9LrFwmj3vriFLEAxShE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKIJncr09tolfZSc+8RAQg98lVM26wcKm9y5NR8h2I0S0XWC37y
 TWm5td1sPqtHZ31MfW8xuPj+vkVmqTVdDYG6wt+F7BZs4ErhW72P4WZ3TxBeJe/1bWV1zcHBd+X
 IlsAbAOIfs2Nb3zyHKzhDoq8NKyIcLcM4soINxt0Jo4aljySwacx584pZ/FWgGEro85TonoQ=
X-Gm-Gg: AYBFou040WYHCJRlzZi6fqKyu4ou84P1fqgWAlUfkmBWmytR+mukaSsoehEo5IGJRNz
 XJY7WM4ui+DWWcmA3HXjSpwHKAgk7atISB/8gKdRVQZX6eZotWpVnMts/cNX0NoZmKvWr4uTjY7
 oC/JgQoyYpcYEdwMDJO5xlWF0PY3EWcQ0veco/Osms44ir08ea6BKtWTLk6ZFR7bFSlTi12J2zB
 E6MF+iuS0iIoK3vhFSQF+821Yj5tgmA6XgZFMNjr60BeJlLT/dvV1GQTbfbOJtrLu1BDKK2oa4H
 MuOYCRoLIjaJ79vL9/xxSH77UXWg74K4EI7Ed1eBfIbhhjVdXcvk3WF0V9r6+7VBdkYEl38eZVs
 Mfjo8KeoKJLgZrLYY5jVs9MYlSaN4f5+1HroAvtlhkSaTFP1sRv6MDPjNQbS4/uP88IwbPLI=
X-Received: by 2002:a05:620a:a8d5:20b0:93f:1eb0:88bc with SMTP id
 af79cd13be357-944214c4e2dmr1550671185a.1.1793608817414; 
 Mon, 02 Nov 2026 00:40:17 -0800 (PST)
X-Received: by 2002:a05:620a:a8d5:20b0:93f:1eb0:88bc with SMTP id
 af79cd13be357-944214c4e2dmr1550670185a.1.1793608817034; 
 Mon, 02 Nov 2026 00:40:17 -0800 (PST)
Received: from [192.168.226.248] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b4ec9fcd6fsm2945801a12.21.2026.11.02.00.40.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 00:40:16 -0800 (PST)
Message-ID: <719ca9f8-85c2-4d91-863c-849d38559447@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 09:40:13 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/a6xx: fall back to MX when gmxc.lvl has no levels
To: Tyler Baker <tyler.baker@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>
Cc: Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261030192014.694393-1-tyler.baker@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261030192014.694393-1-tyler.baker@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KZ1HIgYD c=1 sm=1 tr=0 ts=6ae84c72 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=nSTmtbGWhtfu_40JH2gA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzNCBTYWx0ZWRfX5uYPykm1XPMR
 a1aKWY0EE6VkFpBBk7Y4YsVq+Fri/8WuIeoW17uN5nzGduFBDgUeWxYKEKl35E2sdyZCHgr4SX5
 mRRza3z7UtlbgGKdvpPJfefmvrZkfOfQn6UG3fmwkDH1M1AKOsyAfEJ1vF4xPsvR7Jl8pe+ubl1
 zzgkCNPBQJp8ZzvjJ60fSPuqI8CRjJ6OO9gf6anKhcaqkfsKGp6bBfbFnApY4Z/sonXfpIS/ajL
 AWPqIHCrzAXPaYv7wn074ouyONcKpPg+ftuKpVRzgNBvBQutG5pUDlY9mlaQbtZYu4lUaION/OJ
 iUbzdyO/NPfVkWnrNJEDWTkD/y7Ed+a4gckbsyDuUenZpCSL4oUJGfPO5daloS9tQXftZYAsUY6
 RNAzp2qNLkU0qChqzQX73T06Vr73wPIGrGy68U4s5blmlmOGmHh3l00yyer8xxT95Mk6xvfli9N
 C8M9UWXXh8yQNivRfDg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzNCBTYWx0ZWRfX9e/zgyKZtz2i
 CwtSo1qukRy/pBI+Oy06aYIMi2DGHlRwvtzzrf5YHi9GHXEB0yn1lhd9nAuwXoxz5o0TtuSHpJn
 1xOhlYcb2OAqsQt/vCzid6SnWjQeO5M=
X-Proofpoint-ORIG-GUID: 6DkfMqEO1_GmLtrp--i6q-S44qZlieWc
X-Proofpoint-GUID: 6DkfMqEO1_GmLtrp--i6q-S44qZlieWc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020034
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

On 10/30/26 8:20 PM, Tyler Baker wrote:
> Eliza's command DB has a gmxc.lvl entry with an all-zero level table,
> though Eliza does not use a GMxC rail. a6xx_gmu_rpmh_votes_init() picks
> any gmxc.lvl entry as the GX secondary rail, so building the GX votes
> fails, a6xx_gmu_init() ignores the error and the GMU gets a zeroed GX
> vote table. On the A722 the first GX_BW_PERF_VOTE HFI then times out
> and the GPU stops responding. Before a6xx_gmu_rpmh_read_arc() began
> trimming trailing zero levels, every GX vote silently used level 0.
> 
> Read gmxc.lvl with a6xx_gmu_rpmh_read_arc(), which rejects an entry
> without levels, so the GX votes fall back to mx.lvl.
> 
> Fixes: b5269bf0e1ad ("drm/msm/a6xx: Factor out RPMh arc-vote helpers")
> Signed-off-by: Tyler Baker <tyler.baker@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
