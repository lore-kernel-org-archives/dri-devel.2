Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF2CDCD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 06:49:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AD4410EDAE;
	Mon,  8 Jun 2026 06:49:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DSX3RkzZ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YBupVj4e";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E49E10EDAE
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 06:49:44 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6586OsSX2274553
 for <dri-devel@lists.freedesktop.org>; Mon, 8 Jun 2026 06:49:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0MEc4PivE/f1d8CwdIG75AR8/sE8o9JUrlKA9t720X4=; b=DSX3RkzZV8/M84HB
 XHisqteeIDjQ2ooUJQWgHdfcHh18T7ksQM31jKDPi5Yp5V0b44E9gnFeZe6wtX+g
 VPFiIYa+apoJkRCsDR/Ngp3Eobx3JJHOETciHaIVYF2Udz7LhXk9kj1jw7sFNR8A
 7e2fuO4Cx24l7yqjvrOf9UyVR97qJ0rJK1kWYdy+wALpRcpQBzGC6ReVzBRZM35B
 U6kdjJ0FAHQG54Pm9up/j3+m2kiT5/U74iXw9INYvmii1E4X1oCW51Rnkn9DSvp3
 fgS6BO+0oGOVm2zE5XOqZrzHDImO48K/DVAdPTujN+wU0nyBD86xU7qTJ7o2cgNH
 wsh5fQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emcqgx2yg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 06:49:43 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-6cfd2a26ab0so1620190137.2
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 23:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780901382; x=1781506182;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0MEc4PivE/f1d8CwdIG75AR8/sE8o9JUrlKA9t720X4=;
 b=YBupVj4ejzdQ0ois6nGzfeXkOcpLzlVZXJwj3PBMvgTb5CrI2Kind+5Rkix8MsfmA/
 UPQDEZ32ELzKnol67cquNOA2Yq7Mfdv3D5rSWqWiM1UIYiFRy401sRDrZ3RpZ/AaW5Cr
 lkCRkB132Qiwg8cswwIDOc32tTpgHQ4BWyZuj04tMX0AtFCeaTUhsk1/83bu7fwEWnCT
 fE2nSiFSLqgIu14+jYHKqTADcRx258G1YsXYmcjrqtxxUfO2w4rL/atZfeLtPLuxwznp
 jn67FRuHN2kNpgys5133B76/FAhQM5RJLAEc+eaiDlbJPsCmV8xkGVwlI5me9xooCSsE
 Dysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780901382; x=1781506182;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0MEc4PivE/f1d8CwdIG75AR8/sE8o9JUrlKA9t720X4=;
 b=eUsJp4otnyiV4MEJUwHYkAaLhXxizjlbCurQcgodpxUSpdUnPrMTaDePdS87srjkEl
 dQitzVp4e4XwYpdHYqWxRtWOqS2sWyxbdh0VT6GDWhJztAMkP2zt6Nh6FYdAuwbObT+I
 yNpt7d6amKpfeqmYazAlK8pJECjYu79cp/BGQ2dv4sQPYFD2X7VcPuHUGAO3xoRBaELP
 j9KS4pGvqe89qlYjS/a3EbuORoC7R0qwKWQ9zcVvz7LGn3PVJtbntn4QkPz3Erg4fjDJ
 fdjCbiS++U4t6uLvOAVHqNLUuMqu+yXvZFijOmu3TWraO+0mud8slfl8fvh3pFCP1mBh
 hPwQ==
X-Gm-Message-State: AOJu0YxVlP+cXQDi0Af7+JGpG1/YIG0gbWLyBBuRVNIvRyk5QGFWFad6
 i3p5xxxErnGk12L+g0vSjTc9nDfX7q+M4Oxo+jKbY/kroJbwOe13xrGOa+zMwduTEPD1p4mrk/5
 +4UiWMlIyp1R6heGjn4ZXFYfUirulzA6MtRPFOnechC4GLGQaG22V8IXc4SdTtyq7OjYhoaw=
X-Gm-Gg: Acq92OEvbyOigvpcj7+zHr1e6ivgggWARux33n5WUyg6UvbcOnPYe8H39WOnTxPcglF
 EPNtssxXfi7M65k9eHbet0FZyX2N5xRcykphOVfpYjq48zWWW19Cz1yZyEy8kar7ArA4ki2pjtN
 +RC28AocBVZqglXA2BHxkRQkwf2SwErIs+4GMDZpJGqFN6VrFurQNxdjVB8oI5vzdlTwYS9ZH5g
 IlZsjyKO5PmAOYwXMFaW+W2DC43cr+QG3loFOaqPCjtSs9WlkYOjMksZK1P7oTeJgnhMG+AD7Uz
 4+JABs+orOTdKYEUvZY17fHYdn7CkikASaV9ZB7ZPJn4KY56G+rv19p96HGCkUi5Ezz8WATduYI
 7S/M9FChKMr5i511U4sBXSLpbb9DeLBL423AEvDSpA79n9OvUHiA3k7jtc2qg8Onx9lxB/DDBTR
 HbpHVerGzovEZxXB4Ie9lrqzU8wGoh8/OyhMHVMaAlHPJwSg==
X-Received: by 2002:a05:6102:3e27:b0:65a:fcea:5a8 with SMTP id
 ada2fe7eead31-6fef75ccdf8mr6143705137.3.1780901382486; 
 Sun, 07 Jun 2026 23:49:42 -0700 (PDT)
X-Received: by 2002:a05:6102:3e27:b0:65a:fcea:5a8 with SMTP id
 ada2fe7eead31-6fef75ccdf8mr6143695137.3.1780901382090; 
 Sun, 07 Jun 2026 23:49:42 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa7b8880basm3573760e87.0.2026.06.07.23.49.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 23:49:40 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Sam Ravnborg <sam@ravnborg.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260314-dp-connector-hpd-v1-0-786044cedc17@oss.qualcomm.com>
References: <20260314-dp-connector-hpd-v1-0-786044cedc17@oss.qualcomm.com>
Subject: Re: [PATCH 0/2] drm/bridge: display-connector: detect DP state if
 cable is plugged on boot
Message-Id: <178090138005.36483.18093415635803962846.b4-ty@b4>
Date: Mon, 08 Jun 2026 09:49:40 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=dJGWXuZb c=1 sm=1 tr=0 ts=6a266607 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=U5Edx-QnV-FVL3PtqvEA:9
 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-GUID: jM06DPIZEIkDLcxMU3wfQmI5NXQRe3fx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA2MSBTYWx0ZWRfX77ikACHdiqK4
 xC6b8IXWhRe7gKufl2tX0pqxF2JBvdwkq986ldGT0KlyVkDlU+1ELwj4bul9zgVl/9N1dBSgaHN
 ApyCP9z8yQ6AZ6IcI5aqad1gs0MmpPdPXIJYoqItX49jKHsnu2V4CwHa2zSu62iNtJQUPHQKcpv
 c17xW+RweUJih/l6Es8bhjhIm8+XkSYjwdRpTt6minzgpy79oCEHvW/hSbj9mjBs3GEofVkpje0
 0QEQx4U9QPXD9E491OFNPijkQBuXSlWskD37NzB7s2Rhbk0pJw8Q/aiqzzm2cYTuyKCc8P8INLJ
 ekMjVAYGTRS7U+vz3PxbHdwqr4GMOW+stn/I3Rc7h7jbp8olsFPcwtqc1zUhMQ0ILPpau9CXeNG
 Etgsy3vNMLR7BcoP059xhPg17gP0nmDzrqIKaoFZH7FzZrh8OVboDhL5kgs57La6h7p/qDmw6J8
 tPYVeshWz0Ldzomp4Rw==
X-Proofpoint-ORIG-GUID: jM06DPIZEIkDLcxMU3wfQmI5NXQRe3fx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080061
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

On Sat, 14 Mar 2026 02:43:10 +0200, Dmitry Baryshkov wrote:
> Unlike the USB-C AltMode handling and unlike the DP controller handling
> the HPD on its own, if the display-connector is being used to handle the
> HPD pin, DP controller might not be able to get either the HPD
> notification nor detect the cable state if the cable is plugged in
> before the system has booted.
> 
> Make the display-connector send the HPD notifications during system
> startup for DisplayPort connectors.
> 
> [...]

Applied to drm-misc-next, thanks!

[1/2] drm/bridge: display-connector: don't autoenable HPD IRQ
      commit: 8e9c475060bff87077cfa3bd42011edcb7fb3b0d
[2/2] drm/bridge: display-connector: trigger initial HPD event for DP
      commit: 60dc0946bbad3eef8bc66a5a8b09b98dbc6e09c0

Best regards,
-- 
With best wishes
Dmitry


