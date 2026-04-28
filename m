Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE200FF886D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 20:33:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19D8810E396;
	Tue, 28 Apr 2026 20:33:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="A3QSSofs";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SwXsBqpB";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F81810E38A
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 20:33:11 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63SFsXAm863030
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 20:33:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=4QafK/wXpaIXO2Yjg0RdqOd6
 ehqsozV2z1rnfWUzn6I=; b=A3QSSofsWdYsNCtA3W+qfRON6F95gsriFK+EGDti
 riDeqKKNvqDtEKI1U2W3hfjGtf1Dv5Iz9olLl+BB3mDG/3RFh+WhO+/cNXiCy8DS
 cHuyeotfWIviQIFNBZ/AgFWHbdMGVouUefP7XBb8hEz1JI7SbAzqbJEYhsKhbd3I
 pLuyaX0QhcYpD5qSZNm6Efm4r3M60Prgi18uwJzEJh1VhlKH6LO0J8Lw/9oW4ctJ
 b66Szful8x+n3fRwKpbOBS1UIfyyTvm1Syw30WvCyZ8OXPC+vPYoFTyC0poQt8nc
 Wv/IyYHjpTpDNRxW+zCq6Q/14dr9ZThmYfGJrlsTndNWqg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtry0jxfp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 20:33:10 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50fba8d8c40so1265751cf.3
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 13:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777408390; x=1778013190;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4QafK/wXpaIXO2Yjg0RdqOd6ehqsozV2z1rnfWUzn6I=;
 b=SwXsBqpBVdwI7DXHudMsQq41PlLbJekj3hUrCBPfBn9d3j28eaKI/EOs2sHD3C3JPU
 muP9jwQBSCiRjVV9e2NjzIFdrsVuiTXInfpLjk2I9DCLDxIkucfSdr95CgYpsKqUPpkv
 r3bGwc/xzaawIfQ8At8Wi+dKjyNbrPONhTH2TB1Pa74Q7C1aFkev0er+TJC/fuKaAaY/
 G0266lqtEV+gk5RUQUqZp1UYi1At1yXcELGnb7olJrLvoMe/ATxza5TbRBHPI8EJpWBo
 k6Jfx+DcTMrrGlzYWnzKUXszK2AkXnylg5B1xnFs29UVRhPKgaBn81SoZIhUhhYY/+pd
 t1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777408390; x=1778013190;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4QafK/wXpaIXO2Yjg0RdqOd6ehqsozV2z1rnfWUzn6I=;
 b=lKFgl9HDiYCdW0uqVOEo51sV+HlkdQw7DiBbV83+7JlSWo4oTQFEvSIZtRJqnYviT3
 oEB1iPuGNimV7E0jFkB+9gzNqQSM9hP6HC2RBUG9XNUMfulyeJgueM6wGbsRZZFe9iwE
 Ki0Md8BUQaaNU6nCPYr5/Psil+CBWmHiILsXP6zWcNJmcb8tOfygMrQh0R8FEXxhdl60
 iOO6T8eqLQH5xC1URiESYiuLnzz+B2Xr4oZ6DBROsnIDhFM5s2OxJbeQEeSdjP0Qc5ug
 IvlxrWjYvfi4V7YAjie8DO6tXm0eGC6A5AtDm3aeKY/aB6/6Q7lsL6oNmG2Kte4Kg+8K
 rTvQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/DqZ1TSG8C2rnyCasxA70i/uH06/z+ljGRhm+0LJIw74VU7/sLjhFWZS1WiZGOkk5EJNQCtLUPyRw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw+/xtMwkXCJH/JAwr5c3hYxlWRenM3XLNT8bLbrqKgZ7E1j3Y8
 4TnGxXTeB4PLLEOBpQmYef4A0GRrpMIMCCg8bJD9/ld2grElmzwYFdZx+OjJ2uGWSiqrNt1PyOn
 XAtH5RWBl8qVwjzzX3b+PAUO0w1j2hv53i8fNbbmkQ5pLSXAZCU4AeTJvqxvutP+vvMRYELk=
X-Gm-Gg: AeBDies/1QG11FEuDPFzfqKRSCZ5nQwerPHoaoCzEka8qAuGOy5m5CRZYkcTK81a4is
 ie2+GXVbGpl3/OIR+tgkBSF3UDhm9NAMIe1lOd/UpJQ4uP9lPbdM2SQlr12gxbhhRH1HFN8xWVG
 j0+jhxPBzHh0AwUjqcOxMaYLndtKC5AxYtSDi8i3zjHmhNUkkEwyM7myF1amR4jgak/z3Ny3SJ7
 9cZU1EtKY5uxAKnFuje8+68qr4qmt+3o9DEpphRINpQpaaXsmkLON+4KsnfYTHA6q+gd77fZIof
 GBoqhBnH+uNAV3PCW5rX0qSSm6xKb2dN8BDvBCUGjNjb1G+Q/qP9kaeYHslpZjkpiy/ITwx4gXG
 2GQa2maWalV0aYr2iP+qLN7Qpe8fnEnFvNhb7ocW5wVBwIG56HCqRH+QeZkebFiNVrIekUJGHOG
 Y0IcyLEPAN8KiyAgKyGkFCLKuaOjOQw3J2hAUKx/xcTHrujA==
X-Received: by 2002:a05:622a:550f:b0:50d:8b23:4948 with SMTP id
 d75a77b69052e-5100e1dc544mr62480441cf.46.1777408390154; 
 Tue, 28 Apr 2026 13:33:10 -0700 (PDT)
X-Received: by 2002:a05:622a:550f:b0:50d:8b23:4948 with SMTP id
 d75a77b69052e-5100e1dc544mr62479741cf.46.1777408389609; 
 Tue, 28 Apr 2026 13:33:09 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a74a756c9fsm12644e87.50.2026.04.28.13.33.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 13:33:08 -0700 (PDT)
Date: Tue, 28 Apr 2026 23:33:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Xinliang Liu <xinliang.liu@linaro.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Yongqin Liu <yongqin.liu@linaro.org>, John Stultz <jstultz@google.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Michal Simek <michal.simek@amd.com>, Hui Pu <Hui.Pu@gehealthcare.com>,
 Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 08/11] drm/bridge: adv7511: switch to
 of_drm_get_bridge_by_endpoint()
Message-ID: <67pqw7jpoydsbql245afcblpc2jbfn7llmhc2qbhrkf2epflp2@27x7qttw4lxh>
References: <20260428-drm-bridge-alloc-getput-panel_or_bridge-v3-0-a537b5567add@bootlin.com>
 <20260428-drm-bridge-alloc-getput-panel_or_bridge-v3-8-a537b5567add@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428-drm-bridge-alloc-getput-panel_or_bridge-v3-8-a537b5567add@bootlin.com>
X-Authority-Analysis: v=2.4 cv=KuJ9H2WN c=1 sm=1 tr=0 ts=69f11986 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=P-IC7800AAAA:8
 a=EUspDBNiAAAA:8 a=sqxsbOWVCbAVHG9YZwUA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: Cm6Jhj2siqXISFooL3w5l2JgzeI5ZH5B
X-Proofpoint-ORIG-GUID: Cm6Jhj2siqXISFooL3w5l2JgzeI5ZH5B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE5OSBTYWx0ZWRfX4FWjjt+N9zvb
 KUJ08BVLiap614Zun5/YRunalumJ4Qnywlc1HjP6Az4u3C63LdPKabDnCzYT/gQn/IqVBJ/VAJ+
 ib2Z61xDlZULisNa5r68Wk8g/A2AxCFdJd2CVJ87lmEzixZQSAQ3J6jtEID9QSery/P2FoCyCnk
 KIB0CBBkCRFTEuwmwGM76HW/9LdlBqgvaCbSbxvX9Xngrv3xrHxWzjGcXpYoeaMKEH5kvHYslBr
 vcwK6ZHOqNO7NBwIVzBovSJbNpJ6cUEpnLE68Ry3FyF10MZ1xZp2qgALkXZGxTdu+FcaSZ1X3WC
 1i79FgZKCsM+IZD96++6n6R78FcpVreRNSDaDhMZ+9AbuFeu1RAqVzQNIvhDSZYqPh/kPOIjO4C
 BP7pi5SGCfs6P3eUhIVBZCrnx6xGfbaObSHxP3iP3lU4BSk2soRYU8a2vz5HwaqHkHY5A4E+GWV
 302OiE9ZlrnWQ7ucZVw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280199
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

On Tue, Apr 28, 2026 at 05:30:57PM +0200, Luca Ceresoli wrote:
> This driver calls drm_of_find_panel_or_bridge() with a NULL pointer in the
> @panel parameter, thus using a reduced feature set of that function.
> Replace this call with the simpler of_drm_get_bridge_by_endpoint().
> 
> Since of_drm_get_bridge_by_endpoint() increases the refcount of the
> returned bridge, ensure it is put on removal. To achieve this, instead of
> adding an explicit drm_bridge_put(), migrate to the bridge::next_bridge
> pointer which is automatically put when the bridge is eventually freed.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> 
> ---
> 
> Changes in v3:
> - fix ERR_PTR deref when -ENODEV is returned

Biju, thanks for pointing this out!


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



-- 
With best wishes
Dmitry
