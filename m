Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D9B6CA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 07:40:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77F6210E521;
	Mon, 12 Oct 2026 07:40:13 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2DA710E502
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 07:40:01 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C55oql1339374
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 07:40:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9o+UI71Fufpadx+8Ere4q7SEF6HwD4TGoTdoxZf8oeQ=; b=CCm/7qkgDiqZhDeN
 pdIqhE+GVeINyJNi1cQ5ukn7EGhl+SccPieeUnBO1W1N94dqwkAUfwknt/WLfLjT
 V01K/O2ppSimqZYdaay19XsLsNyYMSjiSVlgsoPj+Up79N9974cw1Z132LsQ5b5p
 fgD5GKMV3Fe12nHYXY3pHi3Kv4utbUCl/gixiDA3bLJp4NXsWFDIlL0ALU8xfly8
 k0Hj+OsRt5dY6Su5xIAahstAcSyhCEPgPqhrkzyxGJoD6uUdcSPX8NlnYhzfzxL7
 GomQaOwcrKS0u03JiB8ot3vTkz+jxfwydyMqBNRtToYD4kzXe3Qqh1K377y6D0Eq
 MSTIKw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7dk25e6b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 07:40:01 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93ea8a9cfe6so10853385a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 00:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791790800; x=1792395600;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9o+UI71Fufpadx+8Ere4q7SEF6HwD4TGoTdoxZf8oeQ=;
 b=GMlnQdaj/fM+cbpkEdClSF3leasXJV51oGI9ll/N4y4Ft7dJGdTQN5i3Dzv41f1UUk
 Uiy3EJXw16jdF9VaeAvgY4Kl8V7QDC24kroEqOa4bN5J0CQHFNFSrNBXXWou418PrWFS
 fWuyoKKpHNfJZfwOZAjHrEZ6/yL5H4+C5t+e/KtetaM8YTWM9HpnhFZH7j2wIKLbD/c+
 T8OpOxyfEsCpbtzT9Qs3EDacbmlIjfGJiwBNl0fKIKKCTOKQYYUIHmr+UzBd3LOR9h01
 w9TCQQeytinDzQq75Ufwy7i9FdQWU0+VQReS/3PLOS0ZNv9HBi/U17kKmGlsuOQ7VMDQ
 O++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791790800; x=1792395600;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9o+UI71Fufpadx+8Ere4q7SEF6HwD4TGoTdoxZf8oeQ=;
 b=wqtTn3UBc5Yq5O+MD+MvTBFCOyqLDMyEChYtwptlPc5BBSIhx0Yrrgir/WQ8cN3rbJ
 0qzdbhYF3/OT6tiwaFUPC110bsM/mTT/Y8WbTGfdm77/E1YkS8BLleWWHRiva/TT4XFH
 1tc3OFg631xCj7VdAn5xfX+yDhxJeBI20k21dxf9Jy96Y4nQv837ZT9R08LgJwBfv/lu
 OOGDspUcZSYtyUKkEbcUuMuw5aPU3iW7pvpIm/ccL64qXVhnAfU1S26woh9iiuuzkEnu
 JUGJg8eEWtsLn8aXY1BZhkcRollRywFlcprt5Ri39aUgLO0rtqidcWiUpTqQIzudjF9u
 /jXQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzx5Cv0wVMFc/Ofj9CF0h+IKwFR93EEYFYp/VJFhBzyMDyiqMXCZPujfJjrYf6BuLWHfsH0XaGVHgM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKMJu+YgWMeiXYq+e1XWqqn4vlXfXYGs1GnJVRgPfYZNjxNgpQ5
 TlTDill626svcgJKcbArUDXNdGQspV4TiQB/xrWLCNiIvdiD/A+8AN9FgkrpTPNS1gxKVBCm5k9
 WeO73cU5OriLA5R/y/fsVzxXdyzNtdXg4WnrMzUIb3wM9mcZa9dwoo+0vGjYZF1a2daAFEkI=
X-Gm-Gg: AYBFou3bZsIu8bsXfX4Lnglx4OD6L2lyjwX7ngtA0b7oSG9Q/m/RuY270VbhFjfhvrz
 cRnBoXXBmjdVQFLUnPOv12zorCIk5SIglFwGmh2fucuYEw9QqTTwNGGvid+PiM95ZVP11n2CTJX
 FwBSC4CfIiSloxT2MUY1yxLVU7CKxWegMnzwN9NWZqjvCj7naQZ2QdKBYEXbA2MP5yyOg+bKPAv
 rn1LggD4iA7mzvNyxfaOfnb9JkkezWdU718Jh73x77GQx10Gv7wiLTlKTb05IBGx+WVr3FpsZQX
 wT5lEUH1DLUFEN0mSQVfoIg56fToL5z2bpkfzYDBvIDx4yV3Ry91a32BFOS1cFLup6dvw0mD41n
 J08/Qn+dLhhX94BmMa0uohg==
X-Received: by 2002:a05:620a:6f95:20b0:93e:ca50:d712 with SMTP id
 af79cd13be357-93eca50d86cmr791780285a.1.1791790800157; 
 Mon, 12 Oct 2026 00:40:00 -0700 (PDT)
X-Received: by 2002:a05:620a:6f95:20b0:93e:ca50:d712 with SMTP id
 af79cd13be357-93eca50d86cmr791778885a.1.1791790799634; 
 Mon, 12 Oct 2026 00:39:59 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c31a9ac969dsm426842466b.73.2026.10.12.00.39.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2026 00:39:56 -0700 (PDT)
Message-ID: <0d9d12d6-8bcb-433c-b487-7ed847ac4ea3@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 09:39:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] drm/msm/dp: Add DisplayPort controller for Kaanapali
To: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261005-kaanapali_dp-v1-0-6faeac3a6d59@oss.qualcomm.com>
 <20261005-kaanapali_dp-v1-2-6faeac3a6d59@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261005-kaanapali_dp-v1-2-6faeac3a6d59@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: gEkNyUpNFjeBrPjovL0MJJYVdKDfIiwm
X-Proofpoint-GUID: gEkNyUpNFjeBrPjovL0MJJYVdKDfIiwm
X-Authority-Analysis: v=2.4 cv=E6hYNqdl c=1 sm=1 tr=0 ts=6acc8ed1 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=rUnJACkxGFui_EhALuMA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAzMCBTYWx0ZWRfX9M4KrdwZv5RI
 MbNtsDdvLzBiyWv058NGPusoXqv3iT1zMn6Py1AlGRDtZg+XcJNvAkphA5LD1pJQKqVJXnafmLF
 z077Ykr+6jUfqEnE1cMeZK5eTmZ7XhhxpcEAkyvUMWaK1poVLxBqiR+FYUzq73CLOfz4YVTX90G
 RDwKFmt+IigpkQVCH6MGBxGq+40GfaqE66HOnc6Phvyvor9Gb3CSuGw3UJOzqW4er1s1qMBgt+A
 23eKpUeoSaLAbAuEw2WLFFUwSiXP6nQQSppMD4X6NnJOG2w3WXLoohrPw7CLoXMOHxYUhqUvCHF
 qGzBSUdCQyuYqpyT17qEXLONe07YbPK4PRsQLQdmWOYxtkMjOZWhgLBplMLRtw/t4eMWRHA8W7i
 G4sJ2Uk7VKkDdMlGBedjKyIyfmqIxOQIfmpZTplBsO8bL1IOG3Mqh8q3AfyhwSWZR6+e1bINHT6
 IYdDTT1VZStkW/w0i+Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAzMCBTYWx0ZWRfXwZ5cTSgLoJ9/
 12afbK3DoyZoCapOSI40UJb/Jbz4oBxSJZpl+R28o/V6veWBRrgplyTxcy/AxESqsLFtw8ahIh+
 7vqIgajP0TlPgTwN8gv0K7DyFEY4DBM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120030
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

On 10/5/26 9:24 AM, Balaji Kalkonda wrote:
> The Qualcomm Kaanapali platform comes with a DisplayPort controller
> with a different base offset than the previous SM8650 SoC, add support
> for this in the DisplayPort driver.
> 
> Signed-off-by: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
