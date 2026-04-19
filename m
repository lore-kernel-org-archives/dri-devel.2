Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27AF3F99C98
	for <dri-devel@archiver.kernel.org>; Sun, 19 Apr 2026 00:33:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1E4D10E517;
	Sun, 19 Apr 2026 00:33:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fjRUpmkU";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DqLW31go";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B88F10E517
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 00:33:34 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63I4lbXR2567173
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 00:33:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=FsnVL5yJ0hHq6vJY76lge5va
 oi40wue3H0I0piR4cws=; b=fjRUpmkUIYiqa7tZgrwkprtDzjDoi4PdY41GYifZ
 /WiqdzrAbjPYqb3ZmCHMnLhiZDiqg9TBcK85t6PyjjiBbvVM4OkbpnsFfnJN9arY
 joDoWdaUl+CKBre4w2VPyHFYu0P3G/KatzmRg+oxAJd4A0V5yvcBAqRI7wj1nuZo
 hwba3WPFXGp9GeA3bMTT0bigU3TbDdheVOD5uFJXToYxuKCFEle8TYI2DlyJg3FS
 VwA+FZiGvfA1vO5HlIs7K40WD7dK77C8M+F/zGOmG49VruX9vGi7i6lLkc9i+4aO
 8vpCO5ZyOLTHMhIGZmGzM+77I8n8y0b1QPHC70jJ+51EAg==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm388hkn8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 00:33:33 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-5fae584a130so2563100137.0
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Apr 2026 17:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776558813; x=1777163613;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FsnVL5yJ0hHq6vJY76lge5vaoi40wue3H0I0piR4cws=;
 b=DqLW31goe8ZUlMXSBHk9+Ha6UV5YMaV9t/qzyfIp4gTWTAhYlHEL/GLdcGNMtFMZAl
 jYeaKJmP3EZCtHtAdtuL1IscjEVusxkFtc3bBox7HyzegWDm3G0V9/+EMCfSWpsRiKun
 PcHhVdnGeJzzXcBof6gtaXDK9z+c1AWHWhuii7Q0xDrlMII/L/CEWu5hoFR/aAoQkhmF
 MEpXGrhX8aLQ+YYuPOYaZXWDjdXP2fEFVja2srsS9qOLgKu8I/oOb5POkAY4//P10Igh
 0S0GBPGYEFQfM9fngKnPyVRCYZ/Q6xtkepPF/S3TyeBB32hflq2IBsrZvYrSeX5lk97m
 9keA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776558813; x=1777163613;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FsnVL5yJ0hHq6vJY76lge5vaoi40wue3H0I0piR4cws=;
 b=Ng+r+ntanI45qAbUm8BiwBEx5/jf+HeaBWrJorCKt+zVFhKUi0V2HK5c+z0tcGzj8h
 Ps5lRX5xT3qj3EeP8N3vU0OMNxr5bPlUoLD0ljwpl3kbFcFRgcva0zkx3JFp4jj+RAhN
 3RezvKsxjJSMLTSKN6K2jLt64WeVNZlQi12zVON/L4lbD+CeziC/74AB7YLsl2HxWKLA
 CNHizpjJDCo4fZgxr7/iXfYtwpM99plsbcyh1tsGuxNKcG/MiygHj4i9w0EMMQMPFmLk
 da5lppnvE6R0pboF9HBMwc5fHeKiYWbP96nVkswfSmngHfEA/mRVXT7+biyWWBNXX9Y2
 cIOA==
X-Gm-Message-State: AOJu0Ywey+qdlCQ74D0jcdyIRGJKoC9/UjTpQWlktmkRH3/EveZlnMs1
 i3zHOu73AnhLKsILxT8p4TSFcVvK9KnJyrCFiJy+tvgMo7aq+Vl8wF5UPDq048GKBuBQdgEDYA4
 i1A50zikdC0qG+n6EHlxdKz3sw7H1xFxwkARlMcc/HaZJZtnOArov/BT9UUcLzzR+zXXSJd0=
X-Gm-Gg: AeBDievR7egkonNyKZoy9Kspr8eU7Jz6cRkfHZeI1/ks2gu+9C7f58dRe6tSe3k3jjk
 pvVz71ObnZOEGvaGFf9CNM55C7xQ4UUWg2kgMRrOnZKvzVfQ+OZsfmzuIDfEJCjvM68HkPO7enP
 FN/d2ir5UnEpe+wPiIXCb4B6JKH8G0eNb3dq7BdCidmHVIhwoBRZJ7VG1QUeOoAXGaYiC+cRdX6
 2MuYBFxhSI1Q0hs26LnrDvO2cBmR5WIfx477J/tGHLu26N4ku5UcpXTa1MIVkP8een9WWSfDy95
 mqibQyW15wo71V2QAdhTENITXngW4gh7Ef681nIQmUunaHcrP5NoSKDPVJakis/8TUaoctsDIM0
 rcqOPhOWAtxnVQw4kHTp08nWR0SCRzXJFCoI6TZtzo175fSDdIFxaCDioztoBHVHK2LDIhm03Qc
 jBkAYeohcRJ+hDPExvkoE3V4zQLsjNt5r4cuWcZrKiGGmntA==
X-Received: by 2002:a05:6102:2c0c:b0:612:13af:f5e9 with SMTP id
 ada2fe7eead31-616f7945bafmr4284197137.29.1776558812744; 
 Sat, 18 Apr 2026 17:33:32 -0700 (PDT)
X-Received: by 2002:a05:6102:2c0c:b0:612:13af:f5e9 with SMTP id
 ada2fe7eead31-616f7945bafmr4284188137.29.1776558812256; 
 Sat, 18 Apr 2026 17:33:32 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38ecb5f68edsm13913481fa.16.2026.04.18.17.33.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Apr 2026 17:33:29 -0700 (PDT)
Date: Sun, 19 Apr 2026 03:33:27 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Avinal Kumar <avinal.xlvii@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 neil.armstrong@linaro.org, dianders@chromium.org, lumag@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Subject: Re: [PATCH v5 2/2] drm/panel: panasonic-vvx10f034n00: transition to
 mipi_dsi wrapped functions
Message-ID: <cinybkizqu2geud247mffitouh475bztvexog2saap6eimyibk@32ycndvuib2h>
References: <20260417061842.66631-1-avinal.xlvii@gmail.com>
 <20260417061842.66631-3-avinal.xlvii@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417061842.66631-3-avinal.xlvii@gmail.com>
X-Authority-Analysis: v=2.4 cv=GthyPE1C c=1 sm=1 tr=0 ts=69e422dd cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=uy7WlXZ_sX-KWQcqtswA:9 a=CjuIK1q_8ugA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: 70CuzqIEQUIRS2XMBtrQ4M066jN2WjC-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE5MDAwNCBTYWx0ZWRfX7xcv6D1GjD+f
 msSKbxTsnVAboX1xQXjzHKuCET6/Riss6ud/XYXf33l7OdTGdcqN5zcHaFODAQ3lmZg0s3zHzwC
 /U2kr9e43Fumdi77WxHQquwagYphoas88lvCzgYxr9p5KcCMBvcbJfbLHrG4bhzfrRLckXKRlIY
 CI1fhc6pjtTqxGyc09kH+wcpxRF2/VV2zuNg8H67xIbCXvKgb4Lgnw2iQ03I4mv54ayrpCrke2H
 FPzBOJ3WHKauzZYiaYiFnFg+NsA89EIwdTeZ6OqhrfLIgDxIX7KLv7prAoS98kqFiiPi2V4wfKU
 8EN/JOD5mMh2GgG0j7SjfYjIxaobUwqla+PxWItf9y7456uUPEObl0g5a0B3Ika1KOi+mKMTwsQ
 hUh5RwqmtXIfIpuVaDdeUV6jeJYvV0mmrJ8A+A4YEppzMnBBGOOQr9XmwfTyQ/8EBu6Eb4gFuhr
 MQnetkbM9Y+NWeMVRDA==
X-Proofpoint-ORIG-GUID: 70CuzqIEQUIRS2XMBtrQ4M066jN2WjC-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-18_07,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604190004
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

On Fri, Apr 17, 2026 at 11:48:42AM +0530, Avinal Kumar wrote:
> Change the panasonic-vvx10f034n00 panel to multi
> style functions for improved error handling and
> remove redundant error printout.
> 
> Signed-off-by: Avinal Kumar <avinal.xlvii@gmail.com>
> ---
>  .../drm/panel/panel-panasonic-vvx10f034n00.c  | 24 ++++++++++---------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
