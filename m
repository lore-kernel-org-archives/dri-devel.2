Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CCE606A322
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 13:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CZIKp/RP;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KeCUjg2l
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F389C10E7D2;
	Fri, 30 Oct 2026 13:44:06 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED40C10E48B
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 13:43:54 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UBGUwR3130551
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 13:43:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AnxQ6PgXNPoh4AK/7SDAcUKVphAB2OZtUU8hUXH8Z94=; b=CZIKp/RPLME6DfrF
 SPE10gPeUrah2znQd69xp5oovV7pNqAryW3wJXcDH/jHIiYyPvM/fTW0VDGKEDmh
 BXneRl1ay0E8Cb9rQhEoc5WUmSJ4tL4ND/1F7gs/VYH5N9HLuqf1IZhl4cKIQPs6
 pLp9mzSWjSXEp1wkz3ZtbgeJc0MXZVfdQdM7XN3ZpwKDeqDRQm61bMvjHY4MtGLQ
 8Z1YwowZnT/Cgbz77jAG9FItePivJl7GMkaxfZ8sX9E6JlGw/t6pSANWFqILo6pV
 IKqq7GFPbtBMwChhHwU0EFz0Ut9QntRgEyKYs4G/Wq4tEQLVyq462x/mmx1e6v1o
 2vRopg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qk88w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 13:43:53 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93cac495d99so4102585a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 06:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793367833; x=1793972633;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AnxQ6PgXNPoh4AK/7SDAcUKVphAB2OZtUU8hUXH8Z94=;
 b=KeCUjg2lUB4ICVsWQxrB87sBvfWiLn8DIsr+IWBeJxdzR7ad1LzzlOj2nfLl4lAfaF
 X/YNWc5KSpokA97Lihrw8c9dYuM08NvewrjiQuTcLflusDBCRVZPNyQWFeLCHOlkO50X
 +yiY/AhWU4JiAQ3keZMcqmC34pQw0UmxI3NGRmEtJDBpa7xT0zyWpk5mG5OeZIsMhxK9
 Kl5yKepWBINhpIcGMBl3GvRbjpGiJAyN94M+64muf9IVOtWAngQXVEn6Bld+6g6R1LFl
 5cL91bFx3k0g1FD/0JYm02mXwJaNPIXvOzuOrvUWJeVjlU65rUfM80fREM0ruxb904Hb
 iblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793367833; x=1793972633;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AnxQ6PgXNPoh4AK/7SDAcUKVphAB2OZtUU8hUXH8Z94=;
 b=P7D4ICQQKaqSlfrm6D9zu2rXpe7bDQIa+F8wZ+O/R37QbN1rCuIv6MswAyqe2rkWOg
 iDXOC4KVbM2QPV4Hq98eKVPQVRTs8C5UszQ7YWY22LwGd9YzEGsAw761rnyStSQGLWMp
 go5Q/VWNjuaE5H2GnbNmKYK4ARejn00YhQdNlfQP/XgczBON3AuEdGOICWXHoZvAzuOP
 iV4XBBPHzLSsuK9GM5fXGKYoKCZZbbd7J9ckxrxLKIWUlv8u5+w8YT/j6gfu74dkK+/3
 QMhGHc8EHlE+kcxphWa99459vaASKoLJkU/7Fgh5UtMGVNzJDUWeLZz28jw8g0KWV8N8
 pdLA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwWref2lS6daHTlrhMiDLcAM18xcGT0ZRW2bSmzFJe9ZvsXOFePJ0zCQDQh1dtAWcL5nQJS/L61o2c=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI31QXs/0MWoPe99+Y6ndYEfiW3auCHom5OQwm7gTQzdhQnoErp
 M9DmpWfNz/pK9m+BLVurQfl9jPAV14Daj5CgjL2PvLCGrMM/fst1ebRx/2czGtQeJYqW6EOYTsP
 NtunryUh9PKpmcLpQU9q9Lwd/QsxSAJPj2yWa7HjPjfG8FP3Y4TaeSego+axyuYcZu9kxmtA=
X-Gm-Gg: AYBFou1QWTCcLkIvQ8AU+tzs9W92SlmqUma89RJkxLl3ScJtQ+8ygWsBwEFWazuHhPu
 KUZWUAzG/PbwtlfB5IyP5VBDC96YW++Px0UZtGXj2OuHxmyOWMj2oE0pQsFVRELsbrDkkpRuceD
 6mavj396I15mUiI/Wl/jlbbQFGoFFqJePwwJVMIGLw2Qkr/7G0/o7sTPYTlcefzmd2gLcyfOt7C
 PiIZeQbdnnJQjfAqKCQ4HOKj0K2ubJsXCSnRFsTCNZ+GKxZyaeEBFXDhH4LsmeMBbW/7WsIK7we
 oX4WqOKV+HSuMn4NmODBGsk/xMMGbTm1jIvcyrhhtnmuFXpmmRSzFDPy6jr1KG1bkrLbKC01twa
 bgjif4FHdPKQ1jV5//hcV9cVnj6EtHH0oxNCwZ1vTF2RW674Cpt6jdqtkWZkt+71NadeG2eQY
X-Received: by 2002:a05:620a:cd8:b0:944:12fe:c8f1 with SMTP id
 af79cd13be357-94421367ed6mr377828185a.0.1793367833382; 
 Fri, 30 Oct 2026 06:43:53 -0700 (PDT)
X-Received: by 2002:a05:620a:cd8:b0:944:12fe:c8f1 with SMTP id
 af79cd13be357-94421367ed6mr377824985a.0.1793367832943; 
 Fri, 30 Oct 2026 06:43:52 -0700 (PDT)
Received: from [192.168.226.248] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4cabc1920csm67290566b.5.2026.10.30.06.43.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 06:43:51 -0700 (PDT)
Message-ID: <0103e15d-42e0-4e8c-9f6e-ebd0b56bf3cf@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 14:43:48 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/16] drm/msm/a8xx: Stop getting GMEM_PROTECT from
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
References: <20261029201730.151754-1-robin.clark@oss.qualcomm.com>
 <20261029201730.151754-8-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261029201730.151754-8-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: x5bH9muydZLfqoeJAUjMHGiVaOKZwsrF
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1NCBTYWx0ZWRfX4oepht1PNEb5
 Ddyb/YCCUK5SjlCg4wEqCy61QhQqlACevO0vLTXJVGKyhCdfyw5ErL60J1IDBMTIiD8laVfqPxg
 sew2Cqj+yaQaQ5wZ7Xuyu/AUOjhNuIY=
X-Authority-Analysis: v=2.4 cv=DfSCOftW c=1 sm=1 tr=0 ts=6ae49f19 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=4AcCgV8_PMtU11i7fXYA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: x5bH9muydZLfqoeJAUjMHGiVaOKZwsrF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1NCBTYWx0ZWRfX3Em5B1VDQpCF
 vM+wmW+U0/Rg8nf/WcuizlnIdktvooHGN8X9sSC3MR5l62Ue8MVxyg70/8AYRdstbYRqSwr+yYh
 +QvmhEajZqKct2yIjGXTSCLGgC1F1Of7JRfxlj9Ym9Rgu/QAhTWP+Y9GDGR624+0j1oCyOZIO0v
 0eLrv2KqCXVJ95KE1McuUuRMcZURXVV5QxMt1OzUkBT1WbQxUpxclugDkDpTwRpKQGm8H2u+mLC
 mDcLYApyTo+Z/2/bOue6IUFF8DchB2K4GLDUMVkPZYC/8+FTR6eAOJnem9k0bXtECFjneKYkoTP
 GNiETUDN12TLlmz8+rPvg3/kizFsgxnXSDccz9CitSEIUOaPD9DIAUfdgp21orF7ZWpdZ2+Q84N
 lJUrodzUlmb+LHRGLc4ezeGCQk4iwURDX7Liziy3RixhVcN2gTRPoPVAojIWjwhZtbDGWhndt3F
 MeLX2LragU1jvOrkrRg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300054
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

On 10/29/26 9:16 PM, Rob Clark wrote:
> We can just simplify things and calculate the value, instead of manually
> adding it to the nonctx list.
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---

Should we drop the entry from nonctxt tables then?

Konrad
