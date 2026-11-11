Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF908606A886
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 18:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OOWsr2Vn;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SfMD3NqQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 415D910FD2F;
	Wed, 11 Nov 2026 18:16:51 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D032610FD2C
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 18:16:39 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABHtEKm2705656
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 18:16:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=TLvjr13IKJDJEa9JzlYzaF9C
 td9oFkXJXsX5JfawbUo=; b=OOWsr2VnYk++zL7ab+bpCiDSHWgjPYre8odEWsJj
 0D/jrVA8HnVJu6uTeKMEUgoR/SoiiXCzyExVur1XTLBu+S8/HsBzIZ2IZGJxKXjc
 3J1LAummLuql+ejpzrm0Mh3Wfu3CTQi5Cnz4tnAFsMHPrBivdIIgCX5aN4XF/X2F
 Msfgoe/fdaJiJ0VorMmqZkjXxqfZeFF/o40MhKpc+nw/EhMB5aV90OyojMTiS0fA
 wa7lPpLrNidjO/LhqX/pAKrGrcJUs3s8G5VXQn8ml08PpSHniHFhydHvfBAppix9
 nG8y8sS7EKIzgxhiYJpSKRkCjSJ4SWCJ4J9Mh+UBCoV0hQ==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvvw0g66k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 18:16:38 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5ead18311ebso1056152e0c.3
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 10:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794420998; x=1795025798;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TLvjr13IKJDJEa9JzlYzaF9Ctd9oFkXJXsX5JfawbUo=;
 b=SfMD3NqQKbqRZ7Zrn617etJCB6oi3am1pd0kfCVjAfezPMIQ5oVf1/6l9ifZWejGHs
 h3RyzztqznQDy0A2ynPDBQ6/2R8lHvXo5g82KsPTrxeLEgF0H1ugp25tylNsonL0RHAR
 wUH7zHgp+8XO87NFgjB7uXnQUmp4BcrTA9q2tsIcOkeo1QxTs/TCjkR5ANiVPdbzYnHJ
 BfqcKmxYKn3RSR8utvtzSKmyc81tuwg/wQw6VMQi3B9IMvKo387udEUQDL2tEa3SUzf9
 vwxA5UAbWc41JdO1DPMArlvo5iHBUv2OKpK6lkjBSfEG6BambLCMiXlfijPNYVpD3sor
 EG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794420998; x=1795025798;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TLvjr13IKJDJEa9JzlYzaF9Ctd9oFkXJXsX5JfawbUo=;
 b=MrGbwmHYHj/rlZXNzxgX9FQNLYeCfI11M6id6anL25BCjId58b4UH7qf9u+vZLxzJ+
 KDc7tdgNaMR089m8r9B3WM+S/0rZQrqNPMMQuIec8RDOKyCFTrhL8n602b7TCHbohQul
 mipe/Th+P1llY9MMni8nUd5qyMPpEtVHVTcLyzmax80rhooY8kq6VzGHiOQMk3R2JZdU
 W7jjd/SzKU1oA6R61MkI2rCPoCIJGUJs+KtwJ2rWcjUyE25dwkB85z6K/ROa2Clq4pUL
 KXOb8nkYlVwaV38Iv6j123nHUdJUIQMP/GhhGYtKysU2axW07sBVv7c8C6PgYTL11pla
 o1YQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHH1jK76a2YvG45xIfNV9EHUEJnIGjqwxtAw6SWX5Yu4FJ0EvHaNyNByW6+iLKSzye9kKQt2tofZ0o=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+uUjuVYRCWIr8+5xd28Qb7PyfVckj6sYUzo+Z5TmO02Lu2cX20
 NwQfEfNYI7lv6YY2L1oAtHly9PH4jVJmZjeHQ3oEzUBkEvm7IZp7/Qcnwkr5NQHxCECx9+OgzS3
 JVKanBZQHdgQez/ZPw/2eUJScaOSBQlUspwmLmlThXsw8VWcZ5VmyZAqGeiO9/CEwyJ5+sz4=
X-Gm-Gg: AYBFou18M/qiJdm7nOMH+ltmLpGArwUv2C2XZoRy032n/gQSdRIGf9FLADYwjQQ2cLr
 P2OX/yIYmS5shEURZGEp2JuQ1yMiDwCp9WzTSZftPd/da0BfV1blOvvBMAZKgVbqhmuxSmEEnUl
 GORI9EEPM4sO1ObmAvJoyyp9NuzTN5J4BhxNcbijunYohkat5po7CCR24Dfzl6w1WimGAPRGaz1
 dM7zmvn9eH3ZdoonunPVd0igNn4HQbwKynOXGOTwQSLiflFKdHeWOMc3LlPl1rGZbG1U0xRCYyU
 aXcetTLdBYmEAZPqu9FQCxEy4lFoo+BB6j0hIt8RWalkOOsSTUmecco7/wQLsTFltt8va2++/Ph
 34ZgzdF0nYxWJI7KbTMdWDB8sWHUyYD2tCeC2yaII/0yl8rAn2a5bLGYprWakoEYibYB83IVSh+
 KN4jGuBbfVFPhLQBiar1jNXvewy43FEPtgyKKyqhvVLIPAIuGY8MqkOVcy6UjQ4Q==
X-Received: by 2002:a05:6122:1d12:b0:5ea:bfba:f540 with SMTP id
 71dfb90a1353d-5ee1c2a6763mr1196117e0c.1.1794420997900; 
 Wed, 11 Nov 2026 10:16:37 -0800 (PST)
X-Received: by 2002:a05:6122:1d12:b0:5ea:bfba:f540 with SMTP id
 71dfb90a1353d-5ee1c2a6763mr1196076e0c.1.1794420997470; 
 Wed, 11 Nov 2026 10:16:37 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae092053cfsm12797171fa.8.2026.11.11.10.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 10:16:36 -0800 (PST)
Date: Wed, 11 Nov 2026 20:16:34 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Del Regno <angelogioacchino.delregno@somainline.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Mahadevan <quic_mahap@quicinc.com>,
 Richard Acayan <mailingradian@gmail.com>,
 Danila Tikhonov <danila@mainlining.org>, Robert Foss <rfoss@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH v2 3/3] dt-bindings: display/msm: Require DSI graph
 endpoint
Message-ID: <bxmfcl2naw645t643b5c5lomlruhpv73reawmxzgmzn7jvazkv@fkodaq2ga4hx>
References: <20261111-display-msm-of-graph-v2-0-fdf8fd97f49d@oss.qualcomm.com>
 <20261111-display-msm-of-graph-v2-3-fdf8fd97f49d@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111-display-msm-of-graph-v2-3-fdf8fd97f49d@oss.qualcomm.com>
X-Proofpoint-GUID: 4egsREohA3hPWMWaca5GH_kQR1KVxXfe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA3MiBTYWx0ZWRfX77lbEvyxAPab
 OD8s9zrgAVpuW/cX/rDiC7Xh2Mf1VG2g+EmN5iL49AaUanM9ZKDs7PVOm/B3NhV55+U6bYCtpX1
 xoyjUCVnuw1u7U9fA1fRMWv5tdUpEmkvQpdQwtTFZL6RVjcrdwkjheV/b90EeaGAQRhrC6cIOHe
 KkBksnEJFbkULcJc4rcshqiBKw7LqBTZciyd9vp8rQJM1QKYhxoqq0pJfQJN6+/Gh/o8HiNjQnv
 pJGxEeWA6+wLoTl+GQ0VYoSrswBTU/TcHMNd5fnbpJB7zSOHnQr1eINV9bnQdsFEuO0WAjs0E2K
 RZ4Q3DWVCAZ89BWkVzNx+89y/48BVnIKPw57c5cNWaB+jlSv2WHc8rMnMlwKSjWOtoMUSECtSpT
 Xrypbvk5hgz+d03Lp/5TxCFpY+oUHBTY1l4YMrQuvacFqFlWMgkoj0p/SrkvQiJ7+AhX9L5uhyx
 rZB4iLMgkVxi0osIrRA==
X-Proofpoint-ORIG-GUID: 4egsREohA3hPWMWaca5GH_kQR1KVxXfe
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA3MiBTYWx0ZWRfX5u26fgXf8LqY
 IPl1Yklo89oO5bNcJ+caydLhjEpo9U2Cid4Z8TNBb+j1PqcPIceV9rHath8QJpeQM3CdFsJHENF
 UKBpKsIXNltRNcyj8kxXR95t1DZP7oM=
X-Authority-Analysis: v=2.4 cv=ct8OAF4i c=1 sm=1 tr=0 ts=6af4b106 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=lYOVpaM7r1jpJQzodxMA:9 a=CjuIK1q_8ugA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110072
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 06:45:02PM +0100, Krzysztof Kozlowski wrote:
> Technically, DSI controllers do not need OF graphs with endpoint to the
> panel and could rely directly on their child node (when panel is the
> child of DSI).
> 
> However Linux Qualcomm MSM DRM DSI driver never implemented such
> approach and it requires a valid graph endpoint pointing to the panel.
> If it is missing, the drivers will silently accept such DTS in
> dsi_host_parse_dt(), but later fail on dsi_host_attach() because number
> of lanes is not initialized.  The number of lanes is initialized to safe
> default only when there is a valid endpoint which is missing data-lanes.
> 
> Extend the bindings to validate existing DTS to match expected ABI.
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> ---
> 
> Please apply after Qualcomm Soc takes DTS changes to next.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
