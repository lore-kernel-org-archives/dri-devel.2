Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F03606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 13:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=maEvt2lI;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BjZLeOUw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBDA6112822;
	Fri, 30 Oct 2026 13:45:45 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 080E7112824
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 13:45:35 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UBGJIM1527711
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 13:45:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Z7RefKSkci+uXJgzjfw4jQaFdMnrtYZxZse0l14l6vk=; b=maEvt2lI8k4WY84L
 2oduaH3eiBaN1PC8OirEJ8hnzMjqnOyAuNt+MLUTGW98VT5Z67r1tGFybH85QFO9
 ALwXULMC3HpNpDZ02BRx2IHct13LbBeq/C1526AP7zf1fX+cjmmziAOYZIHxuuwX
 ImJAG0dApv5lzacusWc5COfnRIzX4mh/pllhp87To4Qsib6jBHuTnPX/Kc2h1Wzn
 Lvm1azLIYh4tm3+oG8L5GaaZgT8yCDJvDw4nkAlJfI6PZbKflo+PkUuIH4v01QF5
 H0jp+1zXjSinDYbqQ/z/4Mnzv4jwN1ewQKZ5k8jRAdWvr/gBjUPR0ZBwOiqc/9Vt
 R3oVfA==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6pka0c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 13:45:34 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7c100f6f8ffso22032137.3
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 06:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793367933; x=1793972733;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Z7RefKSkci+uXJgzjfw4jQaFdMnrtYZxZse0l14l6vk=;
 b=BjZLeOUwUtmda+SevT8yaYvoUdTCigLPt8i3S/6rpfphkxJhhOGtmDcsmLEFjBMGqE
 y7YchQH6gkwQg+sQfyulEmZ0thnJ3Fdh0jI4anzoWSDxhpwqsAePjtKNfTgScXV1RS5d
 sGVJZqMEy+dp5Yj3XkJaddP/cscuuP3btfPfZsWwC1HDWxIYSDl9afIc5HilROV0m2Ay
 76myhbR1wgJcIXylSL/DXBkX3C8N8vPRevDIrLCMcu0oFzYPbKp8MzKiLmQjNSziUDhM
 pUovQJhdJOUfNs5xPt2wt2RV/N/g25l5J8/koceD5aBXdbe1yWLb4gnHKwTazIJPFHHb
 c9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793367933; x=1793972733;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z7RefKSkci+uXJgzjfw4jQaFdMnrtYZxZse0l14l6vk=;
 b=0Mc2ksgjFX6Jpb3gchiI/eBYt9xW+R6DgJRaDWJTwlqopcyG9GaLmYuca9yWLFWxdJ
 kBDo/Dl/gAgI6LkoDZEYOJp7GyWt3YjbECjcg2xHe8QMwnzWSQ8Y7utCFjqxi6jBwadf
 Yx6L/N6NQGB6Qs7vFvv8uMS7LXcucUm6t4V+WgXHdoI/QDN2tAWcWvpsvJMdE0oZxpRW
 XWoM9Xu4IcbWqRaigPBgCZ0lrBTWlYFGbjPxHkQ7ifg3xYBtJJqlcyfvOnoMo6GbojTM
 LNJkt5G2tSgWSKc0XczO2AqkD7Q8n3J9IU9/ruTB3VxmfCxUcXUkQdzJ7/RhfsxrOBdJ
 96ag==
X-Forwarded-Encrypted: i=1;
 AKwUvBwLJqSq0amef8mnafuDO9tJT0GtPxwqGq3Fyf5pQFRfb1y6yusfwdft3AXI55ssSUb4v4ImmN+3om8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ6MZEoX9bj57S7o2/S5E4nSATVakS2aW0KSDRKrqDOuw2VgjGq
 BtgcyCIuDZu3NyODoWlmBY46pdpELvc9xjubO4FD+oBnNmjjAWvNT1+OsGoHSoUseRbP+xrcM/Z
 n8seJ1GSrm+5y4OEsbEZHVIVQLpVo/jZAZgH1ceUFllKECdzVUVxgobK9+CemTL+mmfhZO2w=
X-Gm-Gg: AYBFou11lrBVZjjgniPysxnZ9cH9MBLg4Qo/lgVOOPCTsPEjoSpaHK2ypAinNHWPXiJ
 vGMEwJ2vW4NCZUkUQpam21jzegJOtkd1tDYTyIGPs1VnEeXPRspWwA/6QD4bDii7sugI+YXUtJB
 NBjZSCzibxGwUeNedc9ecSblrpsxUqe2uZ7uk1Pyuvckq4km/NW45m89HurbHW9Xz2yuu//M0q4
 hqc575nvlyTZhnxkkWTGQqc3g3ycKHI5ekQcsN/YTaX+XifZrG3/nsXN/yj2FffPJbgFxWevb2E
 XMwVwgt2TaelLMekgIjQ8e1DFDskEXo+UO0vTGz3Qlcq/xvO0MWRujTIUA/ldUqHyzuT3vxMWgx
 MigOXvt2hi7Ik97W5FlqOY+hJwC34t7/3CXMof+9th5S9lhrreRLG7GKNBO6cKeHfyIokTLA5
X-Received: by 2002:a05:6102:3570:b0:7c3:83a9:edb2 with SMTP id
 ada2fe7eead31-7d072756011mr1169898137.1.1793367932857; 
 Fri, 30 Oct 2026 06:45:32 -0700 (PDT)
X-Received: by 2002:a05:6102:3570:b0:7c3:83a9:edb2 with SMTP id
 ada2fe7eead31-7d072756011mr1169877137.1.1793367932304; 
 Fri, 30 Oct 2026 06:45:32 -0700 (PDT)
Received: from [192.168.226.248] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4cabe4a9a1sm66267166b.58.2026.10.30.06.45.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 06:45:31 -0700 (PDT)
Message-ID: <842cc3c7-996e-4628-b5ec-736eeaab2e3b@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 14:45:28 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/16] drm/msm/adreno: Fix PROTECT span length
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
 <20261029201730.151754-9-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261029201730.151754-9-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1NCBTYWx0ZWRfXykFjuM9lvTeG
 eCbwP+uC5eLNST1Ezf0QND6Ug3iBacFr56+AVs4ImmA6sfy0BIwnKjqyhiqyihvE3/kz8FlcwK9
 Q2Q5frq83liGIGsRpO259eZzGQ5E6BxDzqBAdfeVeAbhTTr5IMeYU5QwV3C0Uvocts5Kmd5QJwf
 M9iGoXE3Q1Ts5YbL9d5Ort5aOavnC+fzIohXzTiJJ0WAmJWPLAPj6fK6AtgvSS9lYIJmmZTIVxP
 zrm6RGzd7bOoEUWii74Zfdkj6rSXW72aBpA16zxxyta1sS8A0GeBQWhy+dRV0ruaq0IaV4QB9rL
 0+0zKnilgnjn4MpZOYOwDZywa3qx9uJkeXdmsuVX6KGTl6FAE14AmY/tGCoKSbFvs9AWVSVYfh/
 wArZJkkHlL5b1gx/z5X/odPeeFHhgVs6L7BJy+WbITJIPwAiyKD+j3LlXupXCgwi02oUoBIYZFr
 ggF4008n9iec0Bu1K4w==
X-Proofpoint-ORIG-GUID: SzLJnH58xVIgQde9YzJC6ihYYWF940qi
X-Proofpoint-GUID: SzLJnH58xVIgQde9YzJC6ihYYWF940qi
X-Authority-Analysis: v=2.4 cv=AJ83otAg c=1 sm=1 tr=0 ts=6ae49f7e cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=5KacoALlGbuERgKT6uUA:9 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1NCBTYWx0ZWRfX0YbTVEm/VXtI
 r6uaJc+J5Dzzw11sRkk9a2+jRaq9ZrMOYalagvF/JxIwKEBImm3k9t4G7pvDhiI/Metp3g5x11b
 PPZx7uLc2DdQh2y2yfguZrFd4vDjuDU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300054
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
> Don't let the length bleed into b31.
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
