Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04804606A32A
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 12:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=punrYVcr;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TLAZXjyZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6162610FA95;
	Wed, 21 Oct 2026 12:13:11 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBD2110E269
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 12:12:59 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LBg49m325099
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 12:12:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aXcvh625bjwiF0YJvjLteYVFkzEmw/+Lbr5Sgxf40Ag=; b=punrYVcrXe+hI5F+
 u73h3hYEP5tY0mkcm9+Z0emKtuJvzIxuDJeTjVSpSaN3AofayUURPQYCABs0LwqZ
 GvZjU1wXn/tAABVsInW1QCpwEoJCkh9hCgi7pKhACAVsj/S0Ppf3EFvZzWt/gUhK
 V1gX7copJ93B1cH89r9gFJFbO82qaomtkHtHKlcGc+BVweLEmFWyMyVV6mO9BWN2
 rE2g9zFeXzcjshkcA0XNqjwlDNUE56wU8A07F/Wm16Nt0AiORY5NhdPpQwb8pv0J
 1jSf4tgtFjsVKtIqUhgg3ZaJBVnVSQ+TwLpMdOpHAQaG8Lh7SMmxuNtS+7l5/hl2
 eocV2A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hed9v3uw4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 12:12:58 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93edac5877bso20570085a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 05:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792584778; x=1793189578;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=aXcvh625bjwiF0YJvjLteYVFkzEmw/+Lbr5Sgxf40Ag=;
 b=TLAZXjyZuZOa7ZESBSiWxypgwqWjSA6RrzY0I1WYpO8PAkGNpkgmiKM82b6D40WB50
 FUxOThsP9gMP7pXhQJCNsKioZ67UQl8HIQ7fE4PU6wAJnQbhu3n61pYX7hV6dYtyqyOs
 /VH62ayEqgsDMlR7du4TTTGAbxwMv3wsXjxfFqunl43Rx6N6Z29ZBuLwB8xjNKXzTf6O
 hKj2s14Jg/5IBMGjuAKMezxLD8iStlQIq3DEO7ZXjZrmj5P++/zwOcprsXVPpqfmhWyP
 vJrmYC+QiR0De9IN//l9vsLW3GMleJgwB+ldjuJ/upTV/Ykg0w2QOwqgqrq3XMZohDza
 h3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792584778; x=1793189578;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aXcvh625bjwiF0YJvjLteYVFkzEmw/+Lbr5Sgxf40Ag=;
 b=fz4i5p+cKPa+IzWolxGLZNC/UsiV7/pQrFzpyNmJTjwUboX/mRTxJcmQzNyD001Nrk
 hOES33OdHQXbuk5f7bgUwYnDrAaqDwyuGDAvr5E5cIBjsXkO16ESFkK3ykFBJ6aUzGkt
 /Ez9dlM5feuYKkshiWQ0ZIjplQb7e3AEELM8rJV/0kLgMK5XY/HwotkqIKpeTF/iP99q
 rtEaz6eKn1QnYKv8uUGtQAH2/GF0eqvV2+zFNmoA/Dzo7gFfxb2/bqNIS0xr2uBAvrJJ
 1dBMdz6uKQkqGCK5cTML4jrysZbeihP9FwCW++MVMVzRtdlRbp21W70fFyUkDHAxO701
 /Q1A==
X-Forwarded-Encrypted: i=1;
 AKwUvByLPjUGhRtzkGA8tlMrq0R73dfNlgGPjJUxXZRmoJxtIy47Z9dBZp4OmwthuAVcb65o2SvJwsQ5Wbg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIjvPMJBBAOeUqQq0eT5tN2X+CLgIASdU3jHvKg+W/0KnFI8zlm
 os8s4vFcQGVzZP4sVXJDSvaI2ccQVYMCyedILSb6KXr82Qlh1zo/qKSx4ApDvwzK/4YLmkRX8uy
 cvITPovFJmgM2mWOdiDHdgHqhY1x+zQXSZLR/aXCtY46rC9n4LqjxXmMh/HJObCHtO1BeHMw=
X-Gm-Gg: AYBFou1oNM3bSnx8fdb/j1O2bh0l3s8ileCcjRPizuWRpiA8wLh7OgBeQBcLVyjAprY
 LStxfGUEebL5gA9ncplW0TjrodHIZBxkCX3bs7SA7nxI99uc0FPf52AsrYJUrY6WoP2uq/xrbYu
 c8q0x98aeIhSLN6I165QRYZL2CPVHtqFhliJnPHVi5vnrW3UvGaFUhQXRhGZcfIEW3MXUGL5OHL
 SpQV+SSJSgSgdU/IDI69N1wGpqcepX/jDayOXbEDNleZcNY4uGUSdKh6I6zcE5EAxRjiZ2c25b3
 JFuJLQzRi+iQq+2kRL724QFnxFI+3wjRYdqtqfFM+IPRhkHOj+8Nh/R/MQzqm6XYYA3Vnd+nX8c
 ZNmPMfQuxsmXIBEsUEGakrw==
X-Received: by 2002:a05:620a:800c:b0:93e:5a3f:ac13 with SMTP id
 af79cd13be357-93f57dbbb66mr435410485a.0.1792584777694; 
 Wed, 21 Oct 2026 05:12:57 -0700 (PDT)
X-Received: by 2002:a05:620a:800c:b0:93e:5a3f:ac13 with SMTP id
 af79cd13be357-93f57dbbb66mr435406285a.0.1792584777265; 
 Wed, 21 Oct 2026 05:12:57 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b402f2be12sm819079a12.2.2026.10.21.05.12.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 05:12:56 -0700 (PDT)
Message-ID: <70c9b4de-6403-46ba-a125-9e792d4f63c8@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 14:12:52 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/adreno: Leave the GPU RSC awake for system
 poweroff
To: Michael Burch <me@michaelburch.net>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>
Cc: Shivam Rawat <shivrawa@qti.qualcomm.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261003193518.13811-1-me@michaelburch.net>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261003193518.13811-1-me@michaelburch.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA0OCBTYWx0ZWRfX2OM2E/eiqDcQ
 K7lu0oILC/dpx0mLMYOULuyDgx5VWeQ9yzlxIHdKTpeC6FVqfCcTQqUgL49JBgpJL962uSRKppM
 Ica7HFats3voM/YW2O96RVrtCJnybJA=
X-Proofpoint-ORIG-GUID: njdN5K2ivNljJVNAPvmGnb7_urSevvTb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA0OCBTYWx0ZWRfX3yxA61n24aD1
 CzxjJmFIWb0xSo+f3720GcdiDMlBLA1VjIpQjJrJCKod06YPXJm1NJnekbcnnNov0r2HdvBo1Wp
 yMREIGuiHG0qKv2pZFAH/cNZElVzxOacEstg4rAe21tuFvcYu8WWzOmcdfCiqBl2wT1TjedkD6x
 e0oJ/DmEQV0i4rc4XzltzHi+JQVMpltIHL38tTvt3MXKOjyu597clchqp1om/7N4XvPjHbEu3or
 XOrZEYyLI/Q9oFvbN3vo+z4Q+IcguHWTwZFw7OcapyXO1rUJqyy7hAuluNMvdnuh/kEpRZ8Irey
 AOU+KrqLFLFqCYMRXuzGqxpNKgQwGKWaxE/F6zL7vfDDAj6rPfe+CKXKPqdX7BG4OGVc1Ra5LaS
 ZLP4hU6jRpRB6HOLIVZUTqXClUXRuSzmDGuttd2HSiLwk4udRwxcsckwo0QaHUTr069ljYfAiTV
 ogChEiyTIigATiicUIw==
X-Authority-Analysis: v=2.4 cv=I6zw19gg c=1 sm=1 tr=0 ts=6ad8ac4a cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=OZ7Xlw-yAAAA:8 a=jfroN63_7_ZKNpzpi8AA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=qwMvOfr3u-Fs83Rmfh-C:22
X-Proofpoint-GUID: njdN5K2ivNljJVNAPvmGnb7_urSevvTb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210048
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

On 10/3/26 9:35 PM, Michael Burch wrote:
> On X1E80100 (Dell XPS 13 9345), commit d9108bfdb746 ("drm/msm/a6xx: Fix
> stale rpmh votes after suspend") appears to turn poweroff into a reboot.
> It seems to happen when the GPU RSC/PDC is asleep at system off, i.e.
> when the GPU was idle before shutdown. Keeping the GPU awake until
> shutdown avoids it.
> 
> Resume the GPU in adreno_shutdown() and skip the RSC sleep in the final
> stop. Suspend and runtime suspend are unchanged.
> 
> Tested on X1E80100 only: poweroff and reboot on AC and battery, and
> deep suspend still drops the GPU votes.
> 
> Fixes: d9108bfdb746 ("drm/msm/a6xx: Fix stale rpmh votes after suspend")
> Signed-off-by: Michael Burch <me@michaelburch.net>
> ---

This is odd - did you test it precisely with and without this patch
and no other changes?

Konrad
