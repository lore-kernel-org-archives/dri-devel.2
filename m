Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98E860A381D
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 11:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pouJluLE;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XcO+TQgk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E38D10ED37;
	Mon,  2 Nov 2026 11:40:26 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D379A10ED37
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 11:40:14 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A29A1V82466067
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 11:40:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1oVKawRBKDyLjs5yqB2d0aVUIqnYCyMBBMHbK7DDuMg=; b=pouJluLEhA5IF64z
 V38Wr3FyvWkYW+tYnSbZGssmg3Qhy4mikfe8baepwwGnShZsNe3fBACYOFH0uoB6
 1T+qW1prcu5YG9NCLLfQ+87meKc397kNT0uxbPLPnaNHX27dlKQeYoj249btCK1Z
 6H82ixLQxxyjxxn0f8lTsTpFvB8mH9Ce76/3UmeXE+MW8yIKvm4sWKcsx3OS4ZF0
 afZp5CmkYwANCdfMSc/vvOvNI8K+tkbvfjPLj1jsX6J6BJ3YbDp4rrI4i1tBTkFF
 AXBTSNH188M2F2R+pJ/01vWj6T3FrSqOPiyd9R75tF0yrN5V6+XRx2g81A6FmiAI
 +TBmkA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpk9rhkjy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 11:40:14 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-536540909e5so8497611cf.2
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 03:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793619613; x=1794224413;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1oVKawRBKDyLjs5yqB2d0aVUIqnYCyMBBMHbK7DDuMg=;
 b=XcO+TQgkMCJhH714AB3NkeoyMwbl3LL2SHTNWgav31xsoDBIUmZI4vlx2G+b+6CQG6
 IZGZPiR022Pkkd9fimnD+Sc6otjjUeHtYExgQoySZqsMMJaLlfcddn9o4OhnRWZyssgN
 u2ouPtpL99KH6YDem9a2a0bfU5Q5d9hHY7ezs9xc8HuLUuAikUkXeJnTRzLTBUGaclXG
 E8UmZxZd3lbXUZNCOBIlrnZc4CpWn4gFXIa5mi43/LmmqSm1lEfC7i02tkLyifMkffIS
 xDN2if2OUCf5WDPKQeBe/+oP61c1QggIYdFpCD81LkAEMqehUIk3mL9XAxJiuOjY0UeC
 uxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793619613; x=1794224413;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1oVKawRBKDyLjs5yqB2d0aVUIqnYCyMBBMHbK7DDuMg=;
 b=QLT5jBnxHCy0DpScCe0FdrIDa3qheeKJeLjXQor1VWkywytyMKlVl9VFgyf8Yy6kYM
 7IqxxeMmC9G9P9XH2WsEiqne8Cp0i8SxbUGRrA6wbXRyIFZ9RdXezPpX9h2DL9tWvq0j
 y/p2RLkTJdjLtmZWUtcTZKBfJMmdzLj0cRPPRaEMXRNq+fmqqfA5PCRIY+1+/eZOhFJN
 /6dpfhwVtuD6KwYuD2iEYMoPJBACGdPlSiwiBjrPlqWnHZmZ7Hddb3Z4fcdQXXE6R76K
 T7dT5j2iAmY0Z5GAeHNE5hL/a/6BWL/Bn6g1eOhdsB7ghit157qatJN3+zrxG6b9fNjX
 85qg==
X-Forwarded-Encrypted: i=1;
 AKwUvByr88Tb5JDN79HtwEAJd7/k2EbNlzzp5056bsBTsqlDIGU7bFUdsKHSPpSepkiTUpt2GcPsgSapY8A=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ4gpS4wipH+feS7JEEYsZbSva4sTxzP8imKfuhd0wdjxo30EHX
 eQ4h2DSvZ4PKG0ad5p77fs9vdcBBvjdK5nXWJwdAKLzuMVayWrfkfLdWOxoVdIWg5meerxkX4+I
 y5Qgc4Ld8A5DMcTElX28OtTO8nGe4jvV9J6AKJnMTo71vJHCBbi35BpKjLunzPD3SvBBEMG8=
X-Gm-Gg: AYBFou3DOIZ+L8L2CBjbfxsfwYhL0UDfPkYHeQiece+ok4Duz+zoqp4r9mfPpsTUyeQ
 WLrMhqRy11ZKssqZQdcevdhH+R8BzZnLcfwAqQWxv4LR/Kbzdm3HBPDLcm7cTLzC3OyAwcXPM2B
 zTg3dH/j+6XunNFMdC78rKBSBTvamY/3+4s24ZWByp2Jt/stSbfL+SKw/SWrmGYjP3F1HhxQVHl
 5gKcqid6fB8+W3ySoAcqfNR0pnmlcAruFBUrNNHt/+Le7Za7uyWZ2j02n8mcqNq4zjFr+bCq36P
 n+FhNAVWoRZeTz8ALQIcYgQXjHv2rNMJHn6+OMABLv37IGRDWcICxOR3a6EizZnrXIxaepev2KA
 EYNoK10bvWmO8pv7b87B7Oy6SvEH/sudgzJn7LhLYXCYuW1XnDGe5GLvVv4T5KSOX2rkx4tk=
X-Received: by 2002:a05:620a:6357:b0:93e:6d87:4f69 with SMTP id
 af79cd13be357-94421666fadmr1792076285a.3.1793619613382; 
 Mon, 02 Nov 2026 03:40:13 -0800 (PST)
X-Received: by 2002:a05:620a:6357:b0:93e:6d87:4f69 with SMTP id
 af79cd13be357-94421666fadmr1792071985a.3.1793619612874; 
 Mon, 02 Nov 2026 03:40:12 -0800 (PST)
Received: from [192.168.226.248] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4cabe93db0sm367342266b.66.2026.11.02.03.40.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 03:40:11 -0800 (PST)
Message-ID: <8c1571be-65aa-45c5-b244-d59e1b4729a0@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 12:40:08 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] drm/msm/adreno: Simplify adreno_probe()
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Neil Armstrong <neil.armstrong@linaro.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Akisaira <akisaira@outlook.com>, Vladyslav Tymoshchuk <tvlad744@gmail.com>,
 Val Packett <val@packett.cool>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20261030-gmu-sync-state-fix-v2-0-89d3082d97af@oss.qualcomm.com>
 <20261030-gmu-sync-state-fix-v2-4-89d3082d97af@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261030-gmu-sync-state-fix-v2-4-89d3082d97af@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: LMnfCp3tWGFMy9rg_No0AgcQGjjno3cu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0NiBTYWx0ZWRfX9Brba0vRAa0z
 QpgiRWBI9v3bf2FFlQfA5xPta4vy+mCae1c5xLdt6HvVoup8VT7mFfuqM93vhB88M5VH7njuzxY
 DH6vVu/efVhSKrqfGUW4egoQ7UVnh799o2MWgKymgTx3Fuj9FkzUfERhvxzTgx8nX5bgGFrG04q
 9HP16KSxidbbrG60hYLntaIgnt9GcAMjjH9HWHsaTKtI/cCOh9kPI914YoUHatnSVeRpabqL8zB
 AiyMbUPmRdUP7U+++LZ/18Cm+MoVdTym2K5Gv7TDaeloFPtSPY5o/Tf521S84jZseNWY3XIhcHX
 Mv3S8JJuUPg8WXaWtom0YjFHNLrty+i6kgAilUPEoQA7YKQLdsadX0A2FC+wT+4RC5snoEOZ9gw
 EBZMeMiA8zojg5BiPmhe2H03w0gMfwqLhaXMicj96d4pg+j+pY/a1u0TRscskxObEHdLKCJBK3Z
 obLZOZtY2zUqsbqAgcw==
X-Proofpoint-GUID: LMnfCp3tWGFMy9rg_No0AgcQGjjno3cu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0NiBTYWx0ZWRfXyMITx1ibQV9p
 agVKBAgDtm29CkFNrav5JRf1j1JZrBC625nIOCWmqQlQCqdGtW11AyQmW2VCw4ZylE2GnCJjWS9
 MZs0ZKkNSZxJd7bSkmIhoujHsynKKIc=
X-Authority-Analysis: v=2.4 cv=LvwHWXdc c=1 sm=1 tr=0 ts=6ae8769e cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=siqUYBh-qFVWGbOa984A:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020046
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

On 10/30/26 6:09 PM, Akhil P Oommen wrote:
> Now that it is possible to auto detect and create separate drm device
> for a "GPU + no display" case, drop the special check for "amd,imageon"
> compatible string in adreno_probe().
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

The remove path alteration should be included in this patch too,
otherwise we get an intermittent regression

Konrad
