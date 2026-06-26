Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C160C43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 20:25:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBCFA10E354;
	Fri, 26 Jun 2026 20:25:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="On+uiByr";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DNnc923P";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F25D110E354
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 20:25:07 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QJ8g7v1617204
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 20:25:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=k6aY8gGwSCxXFhLxb804Fy/1
 V/opTI2mRv2ocqywYps=; b=On+uiByry/XR9t7sZ8pcw+HFRw8G6g4AeFcvEld+
 Nn4KzQ2BlYDSWZdLiZn38nk5cS2bVHJ53FJawYGeQJMEPOb40OmtPmFif7dGK741
 KvToG75J0HasxC1AB7DlBycfthYivrGwqD1/IQLlY/zItFfauZ6gwD4dV05/SWeH
 Nkko3Zwif+w8CpY7zYToC3rLMtpNi6EtfrjX9v3Vna5urTHNxq+peegNMxctBR6m
 OPFrtTD5RA1nBzIBP+a6B7jnXEtH2Fqp6eBvUhQtE2NL0PD3qfroZuuesZYxJ8UY
 NdITZRvwI+kDtH3eGr+Ss5zGH+DBmVThKD8FGT0M6U+eYQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1xxvgb1t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 20:25:07 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9158f07f5eeso198547285a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 13:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782505506; x=1783110306;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=k6aY8gGwSCxXFhLxb804Fy/1V/opTI2mRv2ocqywYps=;
 b=DNnc923PajXqEto+8kujZIzYM0n+gNKLMhbZiyJcVNdAApObWADoiGKcsUKRpdPypP
 Bct8jhXkqhSBLJGXJRt0VJ/Hwt83Pw1VMayXi9VL0znd5JTIr8ROvFTBLCf/xbAkUhWK
 H+6Ig1ByAGnucOTSrvQ4lhHrMeQsUfv6UQL/RxU6vK/cnK3gtXC+6uJxOu3BP+24E4L9
 R05As1XMYzOloamZSEVV3SUDaeahAL3WB4EJKlJO/Kg93XR7Ope9RW/e5ZVACDnPL7Q6
 rhvgZbjhRF8OH3A6gOo0gCwlHC5GzBLO3UUkTLjkscQKE7edFSWbDOachjHcAU3ngVtP
 Zn3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782505506; x=1783110306;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k6aY8gGwSCxXFhLxb804Fy/1V/opTI2mRv2ocqywYps=;
 b=WL+fuiI/SZFE6mbNZOhPMu5GKHd91JKIF+BMPBl09o4e/4GDiSJ8oQLQmUf5fU6F4U
 g0azlx2VIQRUC3JMpNQqPMWYaRtbD6gAxTct1pX5yDCu1VjapzJ4gjK2pW1NN2MGwRZq
 AZ3rw7Fkr/wiE7z/Tj/4DDIQiFGagIgOJXb9+4IMGU/elCqgkcSV4SblsNNn1Ppfjkn+
 943Cf0LtnMUeuMqw1ergRlBhln7aFx7myK7MKWeClKywvEe+xidtkYqlcavzEs7tYw+r
 Eo90rxhD3RH5i0zyLavfsmr/uA5zDdJl5swK+L9mbB9+yNacc0BlhPHLM4GWVPWUfZbt
 43jA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8plEcmTGSotnOX+GQEnybo7KL1AguLwTmHmq7PPCjBY+0X7KbaXNPCrCrq5hdKgPvrsBJGwlxtxl4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzraMTldsk5bASFnQCtK5a7G3xEYv47yMvMXxKJnfTTNtleTLfz
 wO/UEo+9NC1CeeAbpvJqc+LcbdMJuoYnFWyDDkPMk99GxZYbxk1sDvYTNW1du7RcOlfRl8u3FAS
 jtuxcV07YqxeUnKsbCPZKCh4yHYgwgwbeLGSX/m5e5yPrzPvHyVdbxUZ3mn8z5bRS1eJnpxo=
X-Gm-Gg: AfdE7cmDx99UcW32H0B/wJEM9nEvqcalBsP9pdYSECTX4eJ7ENcopleZg3tMk0R7euV
 CYEwxpjDn94n5TDhx0in8tufJgJsSy3eBOnEVtG4B0tldON4RMlEKJMk3W4FCx1m9YcDqMSA90h
 dYMlC1FvATMm0nDJyKkkcbD4FuXbhgrH1/U6lEL9M+eCm12JXe2/hPeqqEEfYx4m8RUJBfNw07W
 berZwqG3Gq7QSyqnLDwWGKFviooIOi+o5KHCCoasvIa7whRHrDpyuAluisilQpY/tmnFg79J82v
 5swFVEERsuVChuf1HrnYKP4pYlsiu7x01BZn3YWcROYb1265Y+6M4BvcbCQxWEN0E4Ks1i0kle/
 kZmfGoFAEuCRf3UCyoiKkWhLcKmTmEMrGAG/wwsMbInjG3eQjdFRD4jSM9IKv6pazGKnWLr+BU8
 1cWu+NuElsvBvwz36GXjrh57Hu
X-Received: by 2002:a05:620a:1998:b0:915:cf88:1e3e with SMTP id
 af79cd13be357-9293c5fcac3mr1226302885a.41.1782505506349; 
 Fri, 26 Jun 2026 13:25:06 -0700 (PDT)
X-Received: by 2002:a05:620a:1998:b0:915:cf88:1e3e with SMTP id
 af79cd13be357-9293c5fcac3mr1226299285a.41.1782505505853; 
 Fri, 26 Jun 2026 13:25:05 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ad69555accsm3711019e87.33.2026.06.26.13.25.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 13:25:04 -0700 (PDT)
Date: Fri, 26 Jun 2026 23:25:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, boss@oss.qualcomm.com,
 qc-display-maintainer@oss.qualcomm.com
Subject: Re: [PATCH 2/4] drm/bridge: lontium-lt9611c: Increase MCU poll
 timeout to 200ms
Message-ID: <jtzitxsoqhuohc7ztpo4rzirpt6gxo3dcarztw3smn6pnr2vet@vmli6nyrhucm>
References: <20260611-lt9611-b4-send-v1-0-42abbcd3bb1e@oss.qualcomm.com>
 <20260611-lt9611-b4-send-v1-2-42abbcd3bb1e@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611-lt9611-b4-send-v1-2-42abbcd3bb1e@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: r0XIwNPBeiIsH6d61GdKZz-qGntQI0Q_
X-Proofpoint-GUID: r0XIwNPBeiIsH6d61GdKZz-qGntQI0Q_
X-Authority-Analysis: v=2.4 cv=BLyDalQG c=1 sm=1 tr=0 ts=6a3ee023 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=JIHZsLvRdsfVHJ5f7ggA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE2OSBTYWx0ZWRfX52wSIwlD/iM4
 bpimfxE0cYBz5vu0Yifvs8gUWcpHWxbv+p2HA2jLhQbMDOtB52p7GKifquJe9DCnvD+PVvxs/y5
 F97I/65/59oboJpt059/TDzX+l6vbWXFTl1KusT58+cr1+FmYpz2PVCbTRyIROf1rr/8kbn02Qa
 Ye4LpnckW9rqOdJzoeKSEBIxqJi0HVizV/9SeuXmpDu8tW84mYcJo1is+tSc21noSZ07U5kne11
 h66qMCE3/vs+rJkagukIVMzh47zjcM6pdLGjdk07yPVtflR7b3P79La0LJ+A35/tizQco6K558Y
 Xl4vWyfSt9Ss2Wcm6MxXVrFSwBAxZ4IN8yEqoDq492jhKF9ruJYwj/9EKR0rv9Se5YGlGwtvfHL
 tSXAQtAtk7d2BG59w2k3Dar4S78LW7QntNfDME9sjgmQBvbrSNyYQHkEA0qHaZsuHNzdoR4CpYT
 H2XNofjZOTEGQPe1LzA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE2OSBTYWx0ZWRfX5wqqmt8CVxwj
 BO+3ElEBZDRTaVbuGIEzB7806pCULh/hgTuf+8+NpIcOMU1tT/l/DJ3oJ+s+bfi0AXtdTnGBcwO
 3st1UQHSVUeK8xyiNa1vjEDP2e00Zs8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260169
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

On Thu, Jun 11, 2026 at 02:44:57AM +0530, Mohit Dsor wrote:
> The on-chip MCU may take longer than 100ms to respond on some hardware
> variants or slower I2C buses, causing spurious -ETIMEDOUT errors during
> normal operation. Double the poll timeout from 100ms to 200ms to improve
> reliability without changing the poll interval.
> 
> Signed-off-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>

Fixes, cc:stable.

> ---
>  drivers/gpu/drm/bridge/lontium-lt9611c.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

-- 
With best wishes
Dmitry
