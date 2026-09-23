Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6FC9C982FA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 11:19:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D90E210EFD9;
	Wed, 23 Sep 2026 11:19:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XmKMDuOE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TjMc2b45";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9D9710EFD2
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 11:19:37 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NAmPjB3664349
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 11:19:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 R5RKExqH8rkcjkWpfakw6QznRsAOVeNLpg7vGSvB+OI=; b=XmKMDuOE6bXqez7z
 tbM6dnwVKDwMq5/ZYdxVL3+CLxnqvIdHTtV3FlY2/hq4TTgETuTt+FekgtNmdkXB
 3vcV8sipk+j2AZ10ZAj2Zl/ja7XaR0WALyIZM97cQfXyRbJuLj/IKUgX5eZRnrd7
 va9wEE3SWLXdURejmEPlt0qUh+1cqSxEQAtz/gMJ0yqYWGGZ5Z6vTyQ2oC4x1+wJ
 5O+NHWmiJD22LhpIWePwptLJ3XhGKFUL1vkTfH2Uy1TynoYzOD9wvrRURa2lZh6o
 stlWKhILWwNSnc6VgB/tkDj2Orsf3K+7RW4HYgnHyLThw3b6jHWbz/Kx4f9GhOFE
 TQy94w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvdb604na-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 11:19:36 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92eebb130dcso25531485a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 04:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790162376; x=1790767176;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=R5RKExqH8rkcjkWpfakw6QznRsAOVeNLpg7vGSvB+OI=;
 b=TjMc2b45WQt+1XfE8FhrSXubtNsxQPvAXR/TzSdK/g6aUp6567dFYIUrLL91hYVLJo
 ENRMJKqsHBAQ7EtBxGcQkF0LAC6pmd68oajFTa3///IxOs7uaW4TlRirlP1lI38cjq1D
 i4fna6ZZxw7QqHaBtvlGwp3SoqoTRpgt4Jkh+900+lLvIoIDKylC0BRRGGq11jmF1SWT
 qcIDqmykPd5Jf4XEJPXvSUQ6rmqDCsb2JOnz3zRxLPpcuaJJulHIZ2IotT4Os/dr3ikL
 xJy7E+rvEjmvW0KfIdIgHkGp2V4bFK/L+f9bVrEzTPvNL68Gdnio0/SsocarTnXlaf0y
 6LvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790162376; x=1790767176;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R5RKExqH8rkcjkWpfakw6QznRsAOVeNLpg7vGSvB+OI=;
 b=h0LrGum/a1LZ6xbT1oxVJhjL06PrYtCBJWm9vHAHFHf8fxWZLUxRzEYEB4sKY64ppL
 xGj1+MQClNj+CBlOgHr9vpBwY7ieR6rBKZsw3vDFu1bd9TBVwvzm5kBydTYD2g+TN/bV
 BbKEE3a87j3D0GINP28nMQFz9AEWF0+/vAexi65uyrJHFXcgKAM51JJWX7ElvQZKwE8v
 2J89v0TEisAcO4dU0/4/a3uZVghN0UZJ56Rsu/SjJjVNCz8EvO4RlJuNr+jaEu8rGmIM
 szVfua9lfwBVJ2lCqpinWV9idBmsJ0HNIGq2sVVq92Y4iloyOjclLu5q0ihqL7Q9OARi
 7cfA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxXQ0kiqSy6TWKe2XpJPt+UvFSQBqcI2aetouj1ABf5/CE4K3Dnl73gJehkp1E2Ngkpe7xPkRiB+lw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nVR/BWtGBt+lALYW/1HqwLrQdG3hTfaBG6lbK9d5QkJrF7PeuJ
 F4skBbpSsU05g+K48e0P6pewNTuIMF6yBENgP5CaQ/j1BKx4x0srrEq/CZHo2RhvW60vPsR6AJ2
 cfpKbtLIxrvxkk0fWHt2+r7cql1N+cidgnLI4DmUNJ2oigRSqV/YE77RyAsoY9fp41WBJGWw=
X-Gm-Gg: AYBFou1KWszAgdhcSR91zxiP3n7/OloIKR7F4jUMAdTNPDufN0daONGfMZKn0l5OxEz
 J/BN1X6M1kDbxuRRCf9KcMtaeBzWejj2QxOKF0YF4x//E0TRmRglX9Gpmnjg1JCTO85kRolKedn
 9VcpqbjFi2VOtpcrATWj84JPMkB0Eqzo85hh7IXKljoCx+jlnmWLn9kQf7iUVAdj25MfIYJ1fqn
 gpZurUWJH5yieMgASUT292aVuu+/BNtGQ7fMCxcVQsK2hHiRpP5sMElKMfy18IUx5Luq6r/2PuX
 6ZlwnueBIcSGV0A1/hxUo8OLPheq9dF6gYAwmZmArLJjtAxyBuMZytHAnI+Fs1m+9WInP17Rl9F
 kVSF3wvsAkg+7c+TohL174Q==
X-Received: by 2002:a05:620a:4547:b0:93c:203b:3e8d with SMTP id
 af79cd13be357-93c252f9ba7mr335755485a.6.1790162376256; 
 Wed, 23 Sep 2026 04:19:36 -0700 (PDT)
X-Received: by 2002:a05:620a:4547:b0:93c:203b:3e8d with SMTP id
 af79cd13be357-93c252f9ba7mr335750985a.6.1790162375775; 
 Wed, 23 Sep 2026 04:19:35 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aab386e7bcsm1458942a12.10.2026.09.23.04.19.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 04:19:34 -0700 (PDT)
Message-ID: <cfbee1b9-4b13-4a7a-b1ba-0fc666b149a5@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 13:19:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/15] drm/msm/a6xx: Clamp MX dependency vote
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jordan Crouse <jordan@cosmicpenguin.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20260923-hawi-gpu-v1-0-0c3c79a1a470@oss.qualcomm.com>
 <20260923-hawi-gpu-v1-6-0c3c79a1a470@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260923-hawi-gpu-v1-6-0c3c79a1a470@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: MCuHPfhAWxEpKLgjU1nZqkxyhvOzqgLP
X-Proofpoint-ORIG-GUID: MCuHPfhAWxEpKLgjU1nZqkxyhvOzqgLP
X-Authority-Analysis: v=2.4 cv=QeXzLcbv c=1 sm=1 tr=0 ts=6ab3b5c8 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=2GDL5SuO4PwTqS1bYXoA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA0NSBTYWx0ZWRfXwPQifrrqhMe0
 A/h+az6/Sx3i5JSinZUUyBpOSwAYIbuClfNMI2RLC3oKjGmg8yzCS4GkbG+lkyotV3X1VCTUCKM
 ZsQGt2tJ1My3t12dRAwzSQSsiBJMP3U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA0NSBTYWx0ZWRfX6oN0KPgfH9SK
 UW9gEtEm6R1QcUS37+oanA7Zs43AAr86uCAmV57KQ27cK9z+bTYG00QIIPJualdax9dPns4NAYU
 lj4Sep+8BTTUzylBcVyUvSBy/Q6/JkueV2K3m411yK1AIwbmC5VmtdQW6SeZkZY0NVC/1aKWYE6
 +FC+4owehleQPcZQJ6M6DLmkGy5urfUjNWT5m13FLwOmWKEVCeG8AQHA+JA+LrgqOFPLAoNhIwl
 N6696AyYi74VTP2PL8/A2prZxX2prCdyNVlWNb5yBjAhw4PfZbt9C3p49vEB/kuhrPA1wwnqOhx
 CclPDtHB0ERm+DOygDTgzmFsjpB+ipSWmU3LW/ha2gISpYtF50o+pSm2bBDDSrqo+gelS6jIqKG
 P7WPsvQyV2WCeaxJg4VDf4Y1gkqLoOka+sR6+ROOLaxTF9jAJ4D4m9M0efcHkMvuDENDZTcojCR
 0ev+b63w2DtbXwSTCzA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230045
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

On 9/23/26 12:25 PM, Akhil P Oommen wrote:
> In some chipsets like Hawi, the GPU arc level can exceed the highest
> available MX corner. In that case, use the highest non-zero MX vote instead
> of failing GMU initialization.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
