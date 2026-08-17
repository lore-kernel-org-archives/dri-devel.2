Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E250C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 12:23:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8853010E788;
	Mon, 17 Aug 2026 12:23:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HPCRI5fF";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HXcHMejX";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 602DE10E788
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 12:23:35 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HC9r8H1388498
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 12:23:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 d+OizPuXV21JjPSONb3Hnxw2A9l39gj4FyuXf1WadWI=; b=HPCRI5fFZbp2fS7F
 R9qR+44QkiqBoStXta35yMhjC8EwoXfAJQ6qiTVz6cfvl4xOfWFX6MJOVwPyxLvj
 fezwyQiOUfJTiO1woPK00WlL97EYjFYB88YskCdoPKjRzrOqEhyLULyaa0+ajItG
 x8ne0SU4ci7fzSVI3LsJKn0rVXrOA3kEQl1FWjKsneppWLR34V+Tl1EBcO+MMkG6
 gdN4VbaZZhHBeHpJ8NqXhjmFFHvxQ5Dijc8xIvBSM+xOGn7p6xkbHh3cU76wP1a5
 6cOORnKcJW8xNU2Emj+a8bwn+iu8fzsVeclXPl3GhXfAXjinRetfmv52tfB/Lvft
 6X3rNA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3x30h0rw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 12:23:34 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51bfa45b280so8407381cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 05:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786969414; x=1787574214;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=d+OizPuXV21JjPSONb3Hnxw2A9l39gj4FyuXf1WadWI=;
 b=HXcHMejX6QlCA0V4Z9Z9V1F23us++DctckK7mS906F8++hqLHBIIyCcexUy7tDPwzg
 3LDHUlUJFsInghSWBbNn+NIM+RdSGzf2VIh8Fm0c3Rn7pVrT0R94z5G41b0AYV5F3bBQ
 J9TmQ6tj6JbdsmyrUT0d6/6CFh2BZYpHUqwhA0s3t/tP7GvOs0EfFqfUjjdI5pqXLA4g
 WlXK8fmaerE/WeYf+wE3EeVNCXVs2Ys2koJr+vhcqlWLwBs1QgWjAR8FHRNUra9RgMKw
 rza/Vc55pEpUL72bi88KyfiZScGuxktws2yFYYr3oOaz8GnC9AnNs50xc7j/xuGXSbXH
 LcCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786969414; x=1787574214;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d+OizPuXV21JjPSONb3Hnxw2A9l39gj4FyuXf1WadWI=;
 b=Y5NufOqYNnpO2S6+GE4te0OU19VbeV9KVBbfoxsUCxEwNI9u057wIISsPNnLMyHVGB
 wBUY0QpSWkBmwcKhITuL0W4bngNzc08cDpbqIApCA1/75AVnBBl48NcnlGSlqAhwhNnm
 xa4nUZQ+HayeyZpRI0+gkUxOvydJTU0KoMTFDzN0xoHy1IaD3osZdNVSeJN435urioLL
 5zsAj44x5DN/U2j2pukYbnrNVkAEZmVD+W0FuvMP5nZ2NK9li2VlWosfmTPlHq07vugg
 98fIpb8nwFa1IZ/45z7n2+jV4b4b7VVW6p57zbRaXT1ukxq7UOHheYrFE9H8zyvwd/zG
 VQOw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpkAy2KWiXOpUItmRZa4BnYOIGSxHVy9tW1eVl39ysX8pfp0yoR0paUoyooj30K/uxls4cBNRIGR8Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwYdojTPCTG+IhcvzDLNcRDR+AoquSvhoszTdhMOmuehGtED9Li
 YpAVxxz6Lh33j7bzaiOQotbKE7kxlluoFiA7s9d+d57IQg3btZzWItJZUAZQsGVBb31buMSJ8us
 wiM5OPQZPqj6Z16ENFuDkCMuNAq7Hteo3FyxsqPTV2RJDvq6MlxrW3P2qN/zA3QYT822LRF0=
X-Gm-Gg: AR+sD12sJukxcdIJgrmnfmshI1rrClEzQHcID8cq2H9K2i0+7x+BbRPtxkcbw+xb+gq
 +Ery7FM5sS64eJRpqDUjdYWZ0QdYFXVIxAVJzwpZ+KsNX5Jp3ltbdyvCUorG2xouRyHXIl2Etle
 qjrAvgA/Aa/nP1QNE3ME+vFBt8SHCy0bJXET2g25lxqaVNEMgMcp5sq6Ohl96Kje3y7s1f7oxRc
 89AKfJBicnD98cdRVlVl/I+3BcqogVDiDkvbkkh9WsAc+X+AAOExB3vK07tE4P3Unv/4h1XLbiB
 8Zk1jywWclYKeCSiK7SU9J0g5nzNZc7G6TDS15TXz9O6AWm3oeNHf3Xkcvfjqjuz+oUHgZmAoRx
 NKD1g/r6rJOMCgSVTiZ0QAwJj
X-Received: by 2002:a05:622a:190a:b0:51c:2324:666 with SMTP id
 d75a77b69052e-52d85425e6fmr199864831cf.3.1786969413754; 
 Mon, 17 Aug 2026 05:23:33 -0700 (PDT)
X-Received: by 2002:a05:622a:190a:b0:51c:2324:666 with SMTP id
 d75a77b69052e-52d85425e6fmr199864241cf.3.1786969413180; 
 Mon, 17 Aug 2026 05:23:33 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a16b1f23dbsm4083481fa.39.2026.08.17.05.23.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2026 05:23:32 -0700 (PDT)
Message-ID: <22383df4-2394-4374-8e5b-60602bcd566a@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 14:23:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] drm/msm/a8xx: Add support for Adreno 830 GPU
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Jie Zhang <jie.zhang@oss.qualcomm.com>
References: <20260809-pakala-gpu-v1-0-207ad1fac1c7@oss.qualcomm.com>
 <20260809-pakala-gpu-v1-1-207ad1fac1c7@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260809-pakala-gpu-v1-1-207ad1fac1c7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA5NCBTYWx0ZWRfX4wZ+Kt4lCf0h
 jsjr51H+YqnE1s1YCgUSryJwflGKAyTsiw0BDS0JOBqVVO6mO6UNVwAeNcTV+UJEsThQl0TqLZn
 pNhRnEhG7sY8Et6zDMhEUYXkMo6UEvn4D1MKdbT9xnwIWpYmicZJutZyZWfOrQ5ame0+Wz36APb
 Tutkq2FbOv4K+Hs9LGLbjStQ5mz+BqgVVZBdLKIrjIVuDBXJkXDZE62QXFa86jamjluvxKen79a
 dLal9ndgqxlLvQegCRgENnwmSbCcVMDS3gYO0NBp9LzD4CX3TIbRJztiRNlKG1J62svYt7UT1fs
 ujZYl1j308dScq9y2b2PrnJxm1e+aeXdPZwsdcZ8KfNXQ2v6riEIivxtAlhknuSPj4sg0U7z9jO
 SNYCGaEix7/iT3v/HNtKYRYUuoCY2ed8BwqnTnTsp7k45pDl8KpDm7ZGjTB2MNIeyUnU9Xeci2J
 PPQ+jwpR+NlQ6lrj6AA==
X-Proofpoint-GUID: MSbLuSWDlcrD5NA-muWoTpaDV_sqcbvK
X-Proofpoint-ORIG-GUID: MSbLuSWDlcrD5NA-muWoTpaDV_sqcbvK
X-Authority-Analysis: v=2.4 cv=Y9/IdBeN c=1 sm=1 tr=0 ts=6a82fd46 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=qwKaBMzKsjHvBPFrck0A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA5NCBTYWx0ZWRfX9qNFKt94eNhQ
 1ctQIoMHk60dzEl1p1O2k9YP0v94zxEN5zs32NFuLEUASspaOiLlBId+5qMxdMko5TZ75Z9chOu
 dQrj+dPK+soWLqE9/ULpOla9ywq9CJo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170094
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

On 8/8/26 10:23 PM, Akhil P Oommen wrote:
> From: Jie Zhang <jie.zhang@oss.qualcomm.com>
> 
> Add support for the Adreno 830 GPU present in SM8750 SoC. Adreno 830 GPU
> belongs to the A8x Gen 1 family and it is architecturally close Adreno 840.
> Add a new catalog entry along with the register list to enable support
> for this GPU.
> 
> Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

All matches kgsl, thanks!

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
