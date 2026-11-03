Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5601606A818
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KnupJP/F;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PtMwVbDb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11A0110F506;
	Tue,  3 Nov 2026 11:28:39 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D81B310F506
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 11:28:27 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3AAC673161620
 for <dri-devel@lists.freedesktop.org>; Tue, 3 Nov 2026 11:28:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 n1K8gFpZzIXklkm69VHcUMsC/cRmRqUO7+6aC1hGQj0=; b=KnupJP/FW7mAWCsw
 aU1LVx4SL4IT8JWOW0VVn4IyZX9XVtf5/TByL67nDPHKbTxpTx/L/Pq5o+oMgFpf
 eUeUBFomC4sTkPQAoex78wyVeicqkBABHA1VgFCue47OdNE1T3BWBivoqbV5p6rW
 8BwSsRErapGQxFRxvMtw5q2reXZpnsAF5VYqXCH83hl3OMcAb4ph2qyxSdmsgSYg
 QRpYlHr3DA/PrOVZvweFt1Yx4hM1o3F13M/T/fsZsc9EAy9atUnOU0G71nnkZK7B
 /f4L9E/tvhYcQoZV+tdrMILWnn5oa+OfanSUWPfauXWQaEsZfm8DkEua2/wyAAjL
 TalODA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq6m9a07k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 11:28:26 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-943fffbc5dbso65963585a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 03:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793705306; x=1794310106;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=n1K8gFpZzIXklkm69VHcUMsC/cRmRqUO7+6aC1hGQj0=;
 b=PtMwVbDbEXC4rvVWE3w/XBwtrp/66o4WMccUsf4mk7i3efLnzOXTbzP5gSYOnQrTbq
 jYNJFOrYxG93bgPEPtnqd4wxU89x0JsDhz4rClNlAH9trxNwyddwpI6Yl+x4xJqyW/T0
 DWb8VRKtI6LFA/9o+9xMymrXg7dpbstj/bY/dTbc+uYi7dv4TA212m/qQldy/5uTMfgH
 iErSIWn8PPBF/kXA/Dc3/J/toGlXzLn1BkXiK9+rW/aUs3TUZ2I6Np/a4uyJgYSwj2Fe
 OkV53ZaaLkDHS/bsgM1E1lM64kY70kIoTfxvxseZi3bca1FpYZN4QXEqTB7ZvBIlYGEA
 AfAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793705306; x=1794310106;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n1K8gFpZzIXklkm69VHcUMsC/cRmRqUO7+6aC1hGQj0=;
 b=u5WEGTCK9AqtekKVSa3zqLel90qe9LCLS85Ho8knbx1S0r2Xo9/wP/WNil3TwM0Vfq
 6U0hN+nPdVmh5no7RXmfPkzVzpFwb/GG7nS+sqbl39zZLDs+d9iS6IqaMqMMnoTyTXpk
 WUbp8tkQgJTNZWFHVikEGcsI/COT8zjZcvLIsuuNe2FWEeIHJF/beMHSiGzIpSXD8y8f
 Gm27txIU4wbZ1OVNJJ5WFfmCzAopT7rcvumqwnEk+uLsrsYqoHygJB+JfwwidzWgLB3a
 BKrAjdBcRNKyxgeqdneh4HFMnYeOB/6K73o4AYYcA/3w7fGUPfjBh1HogZ6LDcZ2XrOn
 w6ow==
X-Forwarded-Encrypted: i=1;
 AKwUvBzToiSA7Os+nW0zOBhjMqlkoGJ5FZdBU5AeMZWQ45T+w04/0mN4Eb3pRERgivlugicOD+S42IqrTDg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8VY6hArMV3BaZcHaLmJTNc7Xsi1bMl8/cWLsy4DMsqWAMVzXey
 gEKHpSj9XKIdUm1JOIJPLx0e+WfQmfSlowHAewAflU46WL1KSH4Fp8YXbOsYtvW2sERD+ptxsfS
 dqcCaZs7ey79F1bvMAZMScaXnBmoqEif3EmWX3pkgI/umHyCDm8h2LD8bE/Awq/Ike+qyiDI=
X-Gm-Gg: AYBFou3rPswZO/3KLfxK7+s4p8g1fQmwb9mKDiRP4b0uy6fHM+eZEBl3fBXF2vSUVoL
 opcAR5FYifWEeab9JgN1vvCO2cTvtGvScgPRTaJAdetKzqfSB/0jQTTKNo5uHPkYsn39OGiKUxm
 CklCcFdXHpCikIMm37L/z619u0ZsA9p8d/nwRnVRjKcAhrzctEBSqbliXej+CcMyBYzcAYmSguf
 n1hWb4Dzo0KL9fYEzCgrmO3ACxG6hsDPDR5uDva0/aFO4JVaIw3coseqzFEF3BSzwOEBRRMbGff
 1Mitjkx9dGYzX1WV4T48VmdcroRoqnXO2WjmtyQGJ+v6SVPvJPws3uTJOnAQcOxkjs19hqIQs8q
 spLqhRH6hXKqm6XtTJm+OQFngx14JRgI/1Y6KHL7glfa7Qihr2RsCaht4IC0DP9ZhlryOVw==
X-Received: by 2002:a05:620a:124c:b0:93e:571e:94f0 with SMTP id
 af79cd13be357-94421734130mr2278427185a.3.1793705306123; 
 Tue, 03 Nov 2026 03:28:26 -0800 (PST)
X-Received: by 2002:a05:620a:124c:b0:93e:571e:94f0 with SMTP id
 af79cd13be357-94421734130mr2278423685a.3.1793705305627; 
 Tue, 03 Nov 2026 03:28:25 -0800 (PST)
Received: from [192.168.226.81] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b4eca214fdsm3956570a12.36.2026.11.03.03.28.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 03:28:24 -0800 (PST)
Message-ID: <337e7d96-d45a-48a1-9530-909a00c0d610@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 12:28:22 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] drm/msm: Inhibit IFPC for state snapshot
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Alexander Koskovich <akoskovich@pm.me>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20261102190010.720443-1-robin.clark@oss.qualcomm.com>
 <20261102190010.720443-5-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261102190010.720443-5-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: zICy9ylyiakAUJnDs5DC4VTHVFiTpS1A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA0NSBTYWx0ZWRfXyffqWuN8Qzzo
 QTjeTZqPzvBuHxxl0RvU52NNlVvWB3PO/Dhe7Ena8MF6rSvI5YGZY9T6M8VhVTBkic8fE117TQI
 1xeecgdSBed1FByl1CwAIY/LYNaJpUo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA0NSBTYWx0ZWRfXz9RFOb0rXHu3
 HldTTQogEo44JZnfdriUqmYGf9wORV7kikjNXyzYHPzl6jKG+CDiDjDp2CyXaEW0Fz5B1xDjJls
 K8L6T+eUIWgF2BWLFbug9KO+eR07CuhxaxV7KN4kPpyLkX9gu2xes3c7g301Ldf38Hbbc48hoVg
 wP7u1vvJeDhP3JFoqUx0T4+OaYbM94ZJVJiifby2/jy5l0iptwBVEEyGGJWOUt01+ybZQLg7IWg
 JBPGgZAWhkT2UVTgheBJ78x9wChe12F8lGLEaSEg/Pm/jzlugE8pdXhWDbuITgaMVNvorrMhrkx
 1wFA68Hx+lJ1X+7p1Noh3/+E8hh11XZd5vTuDOaDMoWqW9gLfNdjJQXrjhACvjh8koTndtSsmwi
 C3isQ2/BAs+0s6Eiuajkde6Dr3ci9QQWbu0uED7FDA1t2UeiBMq8m5jKCya3WahmuQ/ltJYJ+4U
 KwIXEDTBccj1RyB7/Sw==
X-Authority-Analysis: v=2.4 cv=C7B8WgP+ c=1 sm=1 tr=0 ts=6ae9c55a cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=9tEP0OE30YQ_IqY-BwIA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: zICy9ylyiakAUJnDs5DC4VTHVFiTpS1A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030045
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/26 8:00 PM, Rob Clark wrote:
> We need the GPU to stay awake for this.
> 
> Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
