Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 019DFEA71B9
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 03:06:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2662D10E147;
	Mon, 20 Apr 2026 03:06:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EeAm3O+x";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kB9OFjWD";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9565910E147
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 03:06:41 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63JKx3ei2080827
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 03:06:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=rtl+6BW8W96h2knkFuBlb08o
 nlTQOueBJrF/qpTFCGo=; b=EeAm3O+xDAnsqjBWSwWHXLk5w3dFL5VST11xec3M
 cJUYoLpE/IFBcdaW2/WljOzUUeBxyoKuGjdMM6G8j1dRsN4CFMGXyZvBdwnTr/rE
 7GOwa4sBPnBAmAFG29EyLqaSwdYlzw8WZAaAc5VeW8H6UVf5kvs4Cc81H8JvE0Xv
 oRiUSzF9UPLUhbGVZ52mWGcXfFBY7c6krllIcr5bJr1J+R5Z0W6N2n6RvMeydSN3
 A50LJttDcwowVNGL+wS95T2fADXR0GOyCkaOWhNvGXzFXx+iwI+2XE/56qmLNa3y
 LxivIIS/zArdFaR5TDf/ANpnmhHnSHoBzFhVFsZ+8rR8yg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm21ukrkp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 03:06:40 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50ea1a7a5d0so1251831cf.3
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 20:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776654400; x=1777259200;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rtl+6BW8W96h2knkFuBlb08onlTQOueBJrF/qpTFCGo=;
 b=kB9OFjWD1ait6TA+eDHzWsvit3eA1/wJpOT6cuT/qrUczG1WP/nWA3fJg8dRlgcQQM
 nNVux66wxIBuXXXzmE+C+o7D3VNssj/NGllw2U+OVPDF2PEmgDb6POXq/dQKKTWNcrM4
 cdkMiPM7r60sjBzCSCU+jNIIQBDpt82KBEbIZ0Sd4pEi8t3arM7NLOQO+IB2IeoTF5Wp
 fbBUlYM1zkAcXbAkP4mToHsMIw2nIPp1nuy6XNXlxNm0zssaq70LN2WDxX4k5PlWarXZ
 0ysuE9YopnedVwzbr+IOWwpbQNdFWF4QmeiWhmSFOjNdphHBdwMZJ+kaOt110NuGywHH
 fS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776654400; x=1777259200;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rtl+6BW8W96h2knkFuBlb08onlTQOueBJrF/qpTFCGo=;
 b=XI3GoZQ7OcfzEcm55+UE1cDRJm1CbVXx9T8mLIh2y7VTmC1SOfh0YekfoXhSmgn7O6
 5QTxDuJG4t1tAqs91hgB2dnaDMT5nNydWPMQh5/YCHImj5ngv/u7Km215yGH8BQ0ObSl
 fbYvGkTilZ4MiknrWk9lKt0UWH6KQ3cwF95hmudJ4lV1tPbQ+ZbQa3IePFuAfcimupCm
 7kGv0hR1zJ5N9tHxTx2wa4uMhPCxCZF2er8K7umoXr7Al0utGdEbFh7YmvB8UBnHDSSz
 Jhp2RPWoV02FZwBrLW2S1wxe2PpAQ8jqjRWOwO2Bso2Ryqr9MOMVVP/7+vNJS3q/4c0H
 P5OA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+OMSOxEh7HBt4FsIRlEz2Yk9R91dBKF2hsziHa+diNoDr3mDxqRCo7sLi61cEbuxAIe/xN6Qsj60M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzN8187PNhMJDw8tgJvr0LxS4c3pspn3eN7COShTtWvgiKMz+PG
 ZPAgpyYvXM5PqL1UAvfn/KBaGjThSrfdCevG6eTkXL795tsl6tDf33DSQdSVy7VkWaakmOuHU4U
 UJ6LzjOC+2RUStVMKTQdDMBZl/B/qMVr2i9CZ+Dmg6hu7gYenZMb3J+YfYYn6ONPflZ1z3E0=
X-Gm-Gg: AeBDieuUmHbcUHON9tMGMtqOkCocpjr1JKSCW9Scx4qSBrW0PBiCMYrOasbv/XKTvTg
 4l4A1yAgx7nMT5RNheM6WDw5xEJnEHJJeGQ1w5He//21Nr8fx6cA+SfZKn0mvlzMg8Lc0mfK2u2
 UPyd0fbGbtvK+Qr3U3eKtxxbRZkG36Bl340MB1GOIs7TUnAigqapio1EuKuSYRWVxc7ju4bJYUb
 lU9jS0UE5mEupjqrsYnipC3DFC3KdCDdRNPzU4og9ebOy3JKP2tAVTVhrnl+arTnRaj5U+6ajDC
 Jik4wkY8qv8luMgAQGsg3Lx06+i6AO0B2X7pKrOW4qLY8LdPWxGiSaAuNu7HdwUH9eehGycrZOm
 9Lty2+Y22JqNRee6rx++xgQziW5n6GQwlPVg0oTGKPJDIxr2Xklrrb8hhgnu96X/xaokNV1vDoF
 1MmRPVt+8Ztgv/IV6NWYpohAnl55+QlBPqPUwNa6ajM8mhDg==
X-Received: by 2002:a05:622a:4189:b0:509:35d1:ca37 with SMTP id
 d75a77b69052e-50e3693d07amr181294511cf.16.1776654400026; 
 Sun, 19 Apr 2026 20:06:40 -0700 (PDT)
X-Received: by 2002:a05:622a:4189:b0:509:35d1:ca37 with SMTP id
 d75a77b69052e-50e3693d07amr181294201cf.16.1776654399547; 
 Sun, 19 Apr 2026 20:06:39 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4187e1116sm2667146e87.54.2026.04.19.20.06.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 20:06:38 -0700 (PDT)
Date: Mon, 20 Apr 2026 06:06:35 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Dennis Gilmore <dennis@ausil.us>
Cc: Alexey Charkov <alchark@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 FUKAUMI Naoki <naoki@radxa.com>, Heiko Stuebner <heiko@sntech.de>,
 Hsun Lai <i@chainsx.cn>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jimmy Hon <honyuenkwun@gmail.com>, John Clark <inindev@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Michael Opdenacker <michael.opdenacker@rootcommit.com>,
 Michael Riesch <michael.riesch@collabora.com>,
 Mykola Kvach <xakep.amatop@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Robert Foss <rfoss@kernel.org>, Rob Herring <robh@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v7 3/6] drm/bridge: simple: Add the Lontium LT8711UXD
 DP-to-HDMI bridge
Message-ID: <ilprfltw6ju2jpo4hrrypscljrlw3xqi7h2mf5sv2k2iy3xeu5@4d76innmpoav>
References: <20260414214104.1363987-1-dennis@ausil.us>
 <20260414214104.1363987-4-dennis@ausil.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414214104.1363987-4-dennis@ausil.us>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDAyNyBTYWx0ZWRfX9+VCfc94DMpH
 bhN0KVl3P1keCEtmmS0DeVAFzCQ83/hCidb2ZiuGYeY+rN2znyXzztfiW+PMFAFG52ApzhMZkqy
 +/JEs/Qk9gNQv1NC3oq0yoRAhPJRhfzfi6MzLmkhYtOElU20Az9/VPkFJl1H9iA2Gy/7ECxL8Oz
 w4MFkA2JKJpypE0X9CXXPpDc/olFIdk3cx4XGEE5TdChAC13pn82pu19tRYVNGkwPCMTVuaPaCx
 3sRaYR4nkVFwWAK32gc03TIwDG1jMrffq4GV/bcD2cFjVk1Rzdf4ymldfxAwoKvnqojkIAXl2f9
 nrlDmBEtGbHQDmYn+OgAtgU4KWMjAIKhwq7JDJvGcYW9DzyZ/5vPXuIIF4hZ9R8HmBEcKuKBUhT
 TmuOnzzOzVI4iDdExVNdAi9MTws5WaQuNHh3xolc4iE7KuNio6p4Nbut2XvfAFR7wQ+znIei7S0
 uBsdil3IcwIQaMQmxFg==
X-Proofpoint-GUID: VLrKfXpEm8yIVVtUJkedTXbPpe-NGuUb
X-Proofpoint-ORIG-GUID: VLrKfXpEm8yIVVtUJkedTXbPpe-NGuUb
X-Authority-Analysis: v=2.4 cv=WK1PmHsR c=1 sm=1 tr=0 ts=69e59840 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=R0GiLmRpmYWNx10LZcEA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-19_07,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200027
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

On Tue, Apr 14, 2026 at 04:40:54PM -0500, Dennis Gilmore wrote:
> The Lontium LT8711UXD is a high performance two lane Type-C/DP1.4
> to HDMI2.0 converter, designed to connect a USB Type-C source or
> a DP1.4 source to an HDMI2.0 sink.
> 
> Signed-off-by: Dennis Gilmore <dennis@ausil.us>
> ---
>  drivers/gpu/drm/bridge/simple-bridge.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
