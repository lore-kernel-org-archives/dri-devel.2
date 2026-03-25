Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE0D4FEA824
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 10:06:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C15E910E702;
	Wed, 25 Mar 2026 10:06:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dz8Ko6kn";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QYNojSD3";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59DCF10E702
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 10:06:42 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62PA4YUi2932155
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 10:06:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DnteZYl88WE+xcRRZ01bTxWYQKD074y9Yod+8fGCm+o=; b=Dz8Ko6knMLo/PGKQ
 4CCNrJOnlMTeKsS5AfzgIjxPZOVJEQdM220xgUU585JfTkzEJuBraDxun7AB6e2X
 5lIxOFDs9lanGL4/UevtERKpCPg4NL6+CE4g1slMEgiMFo3tQ0zf6Lmb3cjtP64W
 bLyghq66Yxh8OP/2ejTz/3uJNaSNIJBF8Z7IkI7UNlwys740OnJjAxqnA32jP9nB
 oE7VEV4h2gUOyI1HYI25ACdSsNqTY9RMBY7aGs9MaE0KWwv0oJLKbNkrlsP4vl1q
 167zCF6hONgcfXdBA1wJnuv+IxVVUhCEqr3/YWjNt75cxZ47+r9/yUlPfvUdVx9V
 m6ralg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4dmpr09w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 10:06:41 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-89c69c8dc7bso42237926d6.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 03:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774433201; x=1775038001;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DnteZYl88WE+xcRRZ01bTxWYQKD074y9Yod+8fGCm+o=;
 b=QYNojSD3AuJz2l87hDdZhlOZu28myQsVq5FenHHkvBztvN9S89ByIO6CF6uSmKCNaP
 pdZ7QWvHHaldGoDxPVh+Su5aLRpJb/Xwvmyd82hhXhyC7+20brD+avgXjEc2tJ+Uqt53
 mEZNe7QUDLR5SfE9NvY3ftnfsfaoe5+fEdLO3xA75BS0XvQP/TGPPvAGC4goD6LdMxP+
 A2BrvkneATIZILQhMje3kkUFtIJvY1VeRtnWbcutn7KWZoVfIt21Gj0Rd1C3wZ6NDyf3
 hFXtrklW6NRBfpRdDMnXSVSNvxV14mJTPzEIyEK0jAdk89J8DXdbJWApfVo+Son4iaRz
 by0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774433201; x=1775038001;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DnteZYl88WE+xcRRZ01bTxWYQKD074y9Yod+8fGCm+o=;
 b=DlXXHxaPIG9r8up1cFtcWw38S+SwoRsrQjKljnJ3xQEcymfyY9Iehl/1l+sKh+p/ZO
 4ctwxj41OUwlMI7siPX+XSOr2UhoOIbp7b0C1KrcTOs9dcEBNYHZ+K1dfrVmKMZ0HGKJ
 wo6KJsosbYKm98o2X3I2yxE19q3/vDj9W0tHGNnYXkOISVbqieREdF+v1il5RSUKd+j5
 59Hep6SIBzd+N0EZgdbkrW9rHtVojH169bi0xR9tQxWthqdtFBfJ+vnZP4Ej0KdWN/DN
 Q+PNu4EcdBkUhlwHsGf0yzw7T0YDRuvD8rgBzelhDOphX+BdBX5ssi56h/37/HASVDfe
 HkWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgUaRu1/o3hqSK0QAt4EHeF457TH77qK4/Pu2KuXzWVmoUfmAp46v+4ios2Vrf0tQwTAQSs2LeZzI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxdBdyXrHjaHMoV9TiQOzMwVss6C3qOuVmiwfOBYaA3xEGvuZe+
 pmIZf9vAsf2PaRWJb03/iz/PFyjZEbsqZ8Ws1B0B4SsaAU60hWGszpRJRDMguMsKe/v4+yR5kJr
 1PZxKRpSZLuUJSXovxsi91ZZ3+BQn15a9OwzP8ZumNNzNZpuiL6rVTDTp9OH1diJfODVQBLs=
X-Gm-Gg: ATEYQzyjOUKqxbImI7OSGL04u//v/bjWsmSyrC8kzdY5SNKDVSvkfU6EszIxskYQhS8
 j39OXggZP+lOa03QWdLQ59Py5MrtO5va2x7MOUAi5eqvNePieSiFH5TBGS1pl7BiIGh89L7v4dd
 S1x28hiU/G29yosFqxWmC7H+sCAHVeAUY/wIHUR4p2Y4Nmw50JCMh8b7+N1Q074QzEqekRhoCiB
 Zf0zMhMajWJkIl3CL8HQlp4sW6it3EAbyar/Xn3JUBuKWA6geIr7KfKT9bwpmmLMUS5//SbF+hQ
 d35lkdMC0uyJzaqW6AgzxZEeBsf5gxPddtiAv+8NwHNOwgk5xt34SjxS1Ql5U7+oB9eMqYt5/LL
 bxpTmY7KodsL4PnO1txdwHza40XSRKyoIvj0IsNcJPTrxDssPqmN+IODs7QrVnHRJjJpasuDEAr
 gVKhw=
X-Received: by 2002:a05:6214:29e8:b0:89a:7d14:66cb with SMTP id
 6a1803df08f44-89cc4aeabf6mr32763896d6.5.1774433200682; 
 Wed, 25 Mar 2026 03:06:40 -0700 (PDT)
X-Received: by 2002:a05:6214:29e8:b0:89a:7d14:66cb with SMTP id
 6a1803df08f44-89cc4aeabf6mr32763496d6.5.1774433200099; 
 Wed, 25 Mar 2026 03:06:40 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b98b20c8c7bsm187771166b.63.2026.03.25.03.06.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 03:06:38 -0700 (PDT)
Message-ID: <c55d6b2f-c849-46fb-90e5-28c5bbb369f0@oss.qualcomm.com>
Date: Wed, 25 Mar 2026 11:06:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/mdp5: drop single flush support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260325-mdp5-drop-single-flush-v1-1-862a38b4d2ec@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260325-mdp5-drop-single-flush-v1-1-862a38b4d2ec@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA3MSBTYWx0ZWRfX4Hzl6S/W9e4S
 1NJ0FbC6Nkcpd3WJDeA0/m0jEB1J+erv16YWmuyP+zdUoexpIYhkI5wO/PubHXOt6JDQhKvAJSS
 yyxgp+Hu3np2dyqAROjLk1b4eOKlvHF9u908IjR9tYRDgjSL/da1YhADAMMvsrWahpUJ/Ep7UTB
 xkdFOejWC+JzvF8sSUkQMpR3qdN/BZNysNBsMYtyiDq/8i2zHWbD5jM0qxemAiN31+lVus5aEYD
 D8wzj7yOAHrM1YYNEeK1jO8cUeqo5K0rvmG4wTq3FFMtdTm0m0/HFKUkIbYraG0yn5FFxRUBuX3
 fdXoAyN7gVC/1JR3BlKn+kMoMypeldXcX3RCWSn/FC65MkAkA/w3REB05sT1/sZiDdMV2Sz9pIy
 j5ZaxFQfQLKLE7Tjv/XsBdxHrScfjnzIICYQZ635Kxr4O53p/TC/nZKw4+Ns6vVjHiMF5V/hfMr
 B+4YlRzQIjSK1di4bcg==
X-Proofpoint-GUID: L3YQJqhgnUT_Msi4Bq05FpWc1aGjyUvH
X-Proofpoint-ORIG-GUID: L3YQJqhgnUT_Msi4Bq05FpWc1aGjyUvH
X-Authority-Analysis: v=2.4 cv=O7w0fR9W c=1 sm=1 tr=0 ts=69c3b3b1 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=KHC-20qT3CjjWnE2qcMA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250071
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

On 3/25/26 3:59 AM, Dmitry Baryshkov wrote:
> Support for using a single CTL for flushing both interfaces was not in
> use since the MDP5 driver dropped support for dual DSI configurations in
> the commit df3c7899946c ("drm/msm/mdp5: drop split display support").
> Having the MDP 3.x support migrated to the DPU driver the single CTL
> flush is applicable to the platforms suspproted by the MDP5 driver. Drop
          ^ "no longer"?

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
