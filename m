Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC9ECD3427
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 11:21:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFA6110E1ED;
	Thu,  7 May 2026 11:21:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ONVH7j4k";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XOZWYBdk";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DB2510E1ED
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 11:21:33 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6475wv1l1927314
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 11:21:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=u/mKZsfu+vzPsOkujCLiqglD
 wWI00N7ItfTwCnxyziY=; b=ONVH7j4kqYQLVl2VDhduBWcGX2I7Y1tUe6W7YhGY
 ASv6tAYNq4oGoFyxWH2Cb+yTb0AyGugFFAGynBl5+yP/uNgOEUIQ2LRdjmc0SXWG
 MNGJO/EtQ2jyAMQS3N2UzopFYwk6VfT7N3d2u1IThslCGAMszSWbjeXxxf3SUlsr
 7XbwjEzjD9a/joZbgPCbll9swdBe0WEv9M8HqGVHhhZGVczg9zBV6k22nzn6Famq
 fHklI+54Ji/zfMPl2aG9U06jJu5MxRbIfOu/7bjIi7T1uOpmLs5MdsL928MHNumq
 PQGbYb/Do9J5L5tGWCbhQb6DqE03zud+T3A4H4/6tzmTVA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0n2g976n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 11:21:32 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5147078691fso16898471cf.3
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 04:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778152892; x=1778757692;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=u/mKZsfu+vzPsOkujCLiqglDwWI00N7ItfTwCnxyziY=;
 b=XOZWYBdkMQpGZLMj/Dv1NTEpn5ZGTH5zeDfgybNQsKQJ/7ec7Kx8whwu4fdtCy7ZDO
 pF7M/fDM1kXr9lfHwbqyh5TsStthDPsCjEHp7Pm8HVUksVrs5VYFIyAWdpyRukCT/Q9u
 IU/SbLo4qAcj72gp8fRfesfgG4FzMzXOPQw7JVuGfJmT3LbAuRDLiITiXf80Cs5OBP+c
 bJkc7gOOaEca/r7MDEBGKN4SaGDYTXDq6/GSMUbPGauQswNrO+IHn/0F8QpKMDMyAwPm
 lGuj7+zWJi40/rkcAS96nGvoCwCipLb3IVFcZmZh8u+EhTY+DM/4/wfMtKb/InrGj2hP
 fFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778152892; x=1778757692;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u/mKZsfu+vzPsOkujCLiqglDwWI00N7ItfTwCnxyziY=;
 b=iStA1GeIuWUsAOaPUOz7lkpA2tfAwXNt01qbWslXFKh+TbmRSfrcVM8ZIFwi5Vb4M2
 mRIvwbxNiSCTu51ZPmJX7G0xqxWbwQNEGzGLCpdH68ogGLiIqlJdUXlJN9LB60Gp+4dX
 jvp6raETpAFIVfP41/B7U+z3Eon3UIdbdb+yZW1WmqpFOHa2prGzkJwv/LvdKLO8BiuE
 uC/HwzEoueYxwpWM+KpifbUy96zAKgJ9gVxHMsfqiZRsyW9od2kXUp5l2aGk2iH1Yjfa
 DQJX3g7Vr9cG4dA9nyN4UjPqvFTbVA7Uyb0pfFSklnoe3PV9FtsYhwruvfhJ/qx0uCpL
 xKbQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8NUfXEOPBzkv+lx9yw0HcVoAQc8RCfrSgRL8P4eCtwLGVkHvVjs4qYcYhaiUAWVyrj/6Bcmy9w90o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzLjvmvLg1w0QIe1wQ7VL2t8em/SYfE5up/rg+ZC5QdsNEve1WU
 g2VxNu7bcUUkqcVMNz8NO0gjloBsBDZA1SR5tscWao6hhpUcbGfVsmh2p/PJBRFF2OSgj2zi908
 QulWp8eLB5JaKdHumhOy7uaAAFe8WXeYxOL7DZHdAHUO6iJc+XenKmoOZw/q+jjrR7ZmDNuI=
X-Gm-Gg: AeBDieswuchNV2Dr5uVbIcaZoK2AkzyukqH2YYJHX4W14dtURS0DlIf/5T8xluNf3VR
 xiPsr/w2Jm0nksgriJvjoakGXqCPlmq0+tPb0hEyVr3il2jpeafwTlaG1kJW7nqjh1IYEu790bQ
 b6uhZdtdA6AAxtl8jIhteMPXMe+xyOinYwggVUOSYr4rilRfpy+nUkSCAv1kmPOaP5d5JpLQKmb
 X1dKjiYEYJAptrOLzDMiMemO314ICSZEQLPN0y9VQFfEwW56b47cosfcI9UWsDJng3mjf0e9UXp
 /YRtWc6oId7se/ftgwo28l7HDOy+8A0XXvrNaGe7UhsinQ8TmARZvX00p/ApzBrn4xvtIdp70ID
 3p1G6bzHTe9nX8qHF+2BvkqH5FAFVP7bz7/3CeW0AYXr4fmRuVcr4fKIK0vgTWp+IzllaHM+YyA
 BAtoIebwD0OvpxA5HESEweY8WnaAdcQfCwq3jRztcIqH4NHg==
X-Received: by 2002:a05:622a:a0c:b0:50f:135e:d5d with SMTP id
 d75a77b69052e-51461be0571mr107689591cf.8.1778152891662; 
 Thu, 07 May 2026 04:21:31 -0700 (PDT)
X-Received: by 2002:a05:622a:a0c:b0:50f:135e:d5d with SMTP id
 d75a77b69052e-51461be0571mr107688971cf.8.1778152891217; 
 Thu, 07 May 2026 04:21:31 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-393d114988dsm8231861fa.10.2026.05.07.04.21.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 04:21:29 -0700 (PDT)
Date: Thu, 7 May 2026 14:21:28 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: syyang@lontium.com
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 maarten.lankhorst@linux.intel.com, rfoss@kernel.org,
 mripard@kernel.org, Laurent.pinchart@ideasonboard.com,
 tzimmermann@suse.de, jonas@kwiboo.se, jernej.skrabec@gmail.com,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, yangsunyun1993@gmail.com,
 xmzhu@lontium.corp-partner.google.com, xmzhu@lontium.com,
 rlyu@lontium.com, xbpeng@lontium.com
Subject: Re: [PATCH v5 2/2] drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI
 to HDMI driver
Message-ID: <j55fc3jzquz6napxloqsk5x2c37s4twl2g4bwjll32ha3kmxbt@wsw7hdlkbdf4>
References: <20260507024214.97708-1-syyang@lontium.com>
 <20260507024214.97708-3-syyang@lontium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507024214.97708-3-syyang@lontium.com>
X-Authority-Analysis: v=2.4 cv=Wv4b99fv c=1 sm=1 tr=0 ts=69fc75bc cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=Kz8-B0t5AAAA:8
 a=EUspDBNiAAAA:8 a=m6_i6vA6q9rtELufO00A:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-ORIG-GUID: sUMFNlKqRCt29qKO1WQNZ571-9VMACAR
X-Proofpoint-GUID: sUMFNlKqRCt29qKO1WQNZ571-9VMACAR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDExMyBTYWx0ZWRfXy8XjxTzxpmAD
 BsDDr9UQwCmuuoIkVqOlq5pO3bs/aZLqcz3xH31j1P9yqregYwA9e7synaBA/LZu0rhmee2+wX5
 rPZ5Qv69iZ6SNRmC5Evf1Z9dvchIgjLQ2IJaIJiRIfTrEv95wgYFhekyDO1Mo7q7+vnrhJVu9eg
 jHhGFOfWRB83Hhf8to1ubUUSIb3Xkqf7LmF7i2ervFH0OgGrN9dC3Z8iCnKKmWAmZLJo5nxPn7e
 xuatwsBLSVt9hb2FKXu4aVeoPK7lgl2ch1TtPDIjYzM0u92Rv3zDySW8k6OfLu3NRIy7H3RkB3v
 uij9Gtmy8vq5VEFCoRBSTDverkg4RoE0RFDIjmYffQV4rwn8iimQVEp8gkv8M2qPgbPWDeksj/D
 2V+SEyNbgP3c/5362pCD69Y6WlyueSdLcH8JIaHRpDpgsTj7jgW2APurLBNNUIXiviKhDemkZqs
 Sl1JyHQMguXdqCv0FFg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070113
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

On Thu, May 07, 2026 at 10:42:14AM +0800, syyang@lontium.com wrote:
> From: Sunyun Yang <syyang@lontium.com>
> 
> LT9611C(EX/UXD) is an I2C-controlled chip that Receiver signal/dual port
> mipi dsi and output hdmi, differences in hardware features:
> - LT9611C: supports 1-port mipi dsi to hdmi 1.4
> - LT9611EX: supports 2-port mipi dsi to hdmi 1.4
> - LT9611UXD: supports 2-port mipi dsi to hdmi 1.4/2.0
> 
> Signed-off-by: Sunyun Yang <syyang@lontium.com>
> ---
>  drivers/gpu/drm/bridge/Kconfig           |   18 +
>  drivers/gpu/drm/bridge/Makefile          |    1 +
>  drivers/gpu/drm/bridge/lontium-lt9611c.c | 1240 ++++++++++++++++++++++
>  3 files changed, 1259 insertions(+)
>  create mode 100644 drivers/gpu/drm/bridge/lontium-lt9611c.c
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
