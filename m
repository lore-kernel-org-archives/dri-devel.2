Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FE6606A326
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Fcooxj1/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AT6HJMCm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1933A10E59D;
	Mon,  2 Nov 2026 10:09:26 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D62AA10EC9A
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 10:09:14 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A29AQfl3440379
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 10:09:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xm99b92EcvQYiFo2BERFkDMWH8ztgzfeHS78pLE5VUs=; b=Fcooxj1/EnfnyTwT
 //vHKn83TDfpot7hVAY+bwYIcrYfAleant7bpT89zR1ne1GFlGdUmcQ1dE8WxGtT
 yzF+QX72fTvEX03D3r5nPmYKKOMLldpeuaD+NM6VM4G4VtMNQr5Ie5ZM/99IWOH+
 7WFnVcfA3cyDMmYaSHAMrpoGOHvzgoLxMCPFzRI+4VRJJ6FWqYVbS+K5q5iMLLWt
 irMjg9i5uOI80dz94zuM5alzkZfHUHBh2kCdG/G64IUiDN9v26DDI42eFU2j+l1V
 +sGC6c9/0ZEyDIFBsPgdz+wqferiq6K7sJ1W4NPtLQJDg3I0Q+OTwybI34zbJgRX
 4HGtIA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpg201tqq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 10:09:13 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ad3fc547bfso3688710a91.2
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 02:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793614153; x=1794218953;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xm99b92EcvQYiFo2BERFkDMWH8ztgzfeHS78pLE5VUs=;
 b=AT6HJMCmqvTxwqaLnL6IWXemLHJESImZh+xxlxgcUR2hvh+Mld8PJqXLrVkawmCrY6
 4IKESf3FneBsrcHVmSyahOWdx7GmZnBW+6oEJFs8uPAR/FnIlZvC6BqzhL8LD9YJJeVO
 FmQknYJE3loZGCDQbiV+AZVZ9r9GnT21NYQKdtzqTZYBVUC8i3QESF71xde0XugoCHxA
 UNuv7U8AL9/5xTVPF/1B02x2i45Cn6oJOajEtlEzNyNSSjg/Tt2sve2hmQfVH4LQHYEA
 7yHJf7nakW2Q4G5Bbdn94MrMHqaBA7SIi1inR3ATAwe2rsbCg2lhBd5Of5NoRteuUbtL
 UmTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793614153; x=1794218953;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xm99b92EcvQYiFo2BERFkDMWH8ztgzfeHS78pLE5VUs=;
 b=AH4/IuPphCnQSm2RgzZgYBnaFwdjnUlFxtMMw9c7ehT5UmDHIczZeuCE06a1kizNAV
 Jgr/Ms+mlqpwDryqaL+GG9j5DP8KKUZ7JUgD475jMvwLfq+gLKUqI7JsyjnePId4h719
 3dA0coHo82wzfbLBp5l/Z8ZuoIwflExCxoZ+Ccx7AJmNtkDtjYcBRW05NcR/4EJ05cyQ
 pz144mrFMTZnu/F3ui4mNTPTDYySqauTGMsMyk1N8+hfvwYUhZWI1SFGGCsCV1SOFK39
 AOF9B/z6B5C4hFfEUZ5ddQ9YO5FpjxMpFa/UwzSOZDmk3jkDu45M2ENrRp4Ygbe44wem
 UGxg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxNgW8DRGQIyjpOVzx/fuzVEPQGmNOqg6v7+vBXRonm5pwKcR99swaLeJ3lwegPBeI7Uza+xi9R86w=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+z8b6XtUPYKnJGYrqhwDFgfwgoFz7Zw/X2GiiLlM0F59DeSGft
 3KCiAbXcfSkPnK6eiN9Fok55fMSXYYojfoisKkmHrJfsqv9Yi5v+EgZ402fzkFpP93kRbQHUnT6
 UQ8G0nRDmp5sfclHRdQVVKGIE4LDGQxUzq7GtZiZKjuKxymTCdevKHfNNnxX6HQM80OgyvO4=
X-Gm-Gg: AYBFou26M1Cu4eKkbLnuQk1m7BIyi4KDa8fZan5HhXGjjlYKCDRgPgRRZmjWNAjMprD
 E7exgBzV2LPuvokcIVaomEioX4VmAPF9n0dxHoFxHYnKWwHANE8+cfQxYsz8Wktpza8JJUzSgK6
 eCuFj9vCPGp9n0rhWQ7PD9bgjheVwKAndtZIskBhlvs4LD7jRP/JyU/30wYlhRWklDVCRpl0fNT
 u3Vx9IToa6urzQqHXlqgJd+0RJW+GDqtHqCTM8ej5AGpvSOVOHMPGRbd/5F0PmzoopL9klfrR+y
 Z6hMmHPr6RpndSGS54OyPz/lYOuueRDRyAydSbwifrIkpJinCs5/4OIE5QrF2zioGX3z25X2j+W
 SU89yZ8Zgcwubl8NCXLE6+2mS2B+ogEwYVZvWi8BjCHvj1JApgsvNRo6AYVs5ZVg6fgNnpeCbQF
 6HGg==
X-Received: by 2002:a17:90b:4b8a:b0:3ac:9259:122c with SMTP id
 98e67ed59e1d1-3ae8977737emr7207179a91.40.1793614152665; 
 Mon, 02 Nov 2026 02:09:12 -0800 (PST)
X-Received: by 2002:a17:90b:4b8a:b0:3ac:9259:122c with SMTP id
 98e67ed59e1d1-3ae8977737emr7207161a91.40.1793614151969; 
 Mon, 02 Nov 2026 02:09:11 -0800 (PST)
Received: from [10.219.57.104] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae6e98f888sm18169303a91.13.2026.11.02.02.09.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 02:09:10 -0800 (PST)
Message-ID: <26ca5c66-a2ff-4aaf-9c9d-724ac66480eb@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 15:38:58 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/25] accel/qda: Qualcomm DSP Accelerator driver
To: Krzysztof Kozlowski <krzk@kernel.org>, Oded Gabbay <ogabbay@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Srinivas Kandagatla
 <srini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>, dmitry.baryshkov@oss.qualcomm.com,
 andersson@kernel.org, rob.clark@oss.qualcomm.com, jgg@ziepe.ca
Cc: lingtong@qti.qualcomm.com, cacar@qti.qualcomm.com,
 sandheep@qti.qualcomm.com, Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 Ekansh Gupta <ekangupt@qti.qualcomm.com>
References: <20261102-v4-v4-0-88f2f24a5f0b@qti.qualcomm.com>
 <a97fb0b0-e4e1-4b25-a5ac-60777941c574@kernel.org>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <a97fb0b0-e4e1-4b25-a5ac-60777941c574@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: m70o7ldLbZojg49XOYmZ0Zvyq79GhZP8
X-Authority-Analysis: v=2.4 cv=fZY4WEQF c=1 sm=1 tr=0 ts=6ae86149 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=PkZpfZOK-p4hLHj_r-EA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: m70o7ldLbZojg49XOYmZ0Zvyq79GhZP8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0MCBTYWx0ZWRfX7x6+n+bl2NBd
 +etVlgex8Fah2p1wB73tdeA1+RwrkiSbETloTDZTEWak7ElkUjdyvllefSGOp6stk1LC+zhnp89
 dF6QOJd6rUhFIlMB0zjHeDlTkiunTM9WGCROrgsTdGWezOVBZDuzgFmwBt1UP1dmuLb7oWW2yTa
 NyMaoeTgvtW3sizK3IJ4kusj1PrjYGXtMhyc5GXCSrRK5qt81nrXmtxq60QtV1ZeGVhUz0JLv0c
 o6PS/jxy3W8duTBp/5RZh0j+KFHlxV41A2OcewyvzsKyhIi9YYHTX3SW7XQcYEUOczyBeKUGv6y
 mFanHbI+cOc9NYDMO+Sc2EzwFME9IyWd8TyOLxCFUcQwDfPIG3EvAZRy/az09/OTXDugXfVfMCa
 eIMmMd+MBSGEqFVRtwMf9MfrmZ7IjEdB8fDjXWxGFR0Iled97vmrc9n7CCkswOsYvF21OcmyXIP
 U6xsQYW2/KRWMbhHJNA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0MCBTYWx0ZWRfX863ioRBK41pS
 sejvMapNV95paeozzuIgmQTtGZwGKMAn31qEroQ29+xcBjoWeFH/hYbaY7f8CiqZP8tYwvjF2Y+
 RP5Wu6XDFOyXcACA/EHq6lSpW1iyDHw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020040
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 02-11-2026 14:23, Krzysztof Kozlowski wrote:
> On 01/11/2026 23:21, Ekansh Gupta wrote:
>>  drivers/accel/qda/qda_soc.c            |   66 ++
>>  drivers/accel/qda/qda_soc.h            |   61 ++
>>  drivers/misc/Kconfig                   |    1 +
>>  include/uapi/drm/qda_accel.h           |  282 +++++++
>>  33 files changed, 5877 insertions(+), 1 deletion(-)
>> ---
>> base-commit: 7649ba73f9e7e1e04d0b46213e39c79ae09dd55c
>> change-id: 20261102-v4-e8feb321263f
> 
> What is happening here? How are we supposed to work with this?
> 
> v1: 20260223-qda-firstpost-4ab05249e2cc
> v2: 20260519-qda-series-78c2bf0ed78b
> v2 again: 20260817-qda-v2-78e2d1f10529
> 
> And now completely different one?
> 
> This makes the change id completely unusable. b4 diff obviously does not
> work. Any tracking of this does not work.
> 
> NAK, really, I already complained internally months ago about such
> practice, so apparently not enough.
> 
> Best regards,
> Krzysztof

Sorry about this. I lost the original b4 branch and re-enrolled the
series for v4, which generated a new change-id. I should have carried
the existing one over.

I have restored the v3 change-id (20260817-qda-v2-78e2d1f10529) on the
branch, and it will stay fixed for all future revisions of this series.
v5 will use it.

Note that v4 is a substantial rework of v3 (the custom bus and iommu
patches are gone, the legacy shim is new and the series is reordered),
so a range-diff against v3 would be of limited use; the "Changes in v4"
section in the cover letter lists what changed and why.

//Ekansh
