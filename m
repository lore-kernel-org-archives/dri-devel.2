Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 045D6CD4F3D
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 21:04:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B25710E29D;
	Sun, 17 May 2026 21:04:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YwxSTwoY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SRfnnz12";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6A1E10E29D
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 21:04:10 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64HFVcNE158661
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 21:04:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=fUhozNQOGlW3rfi5mCmwlO7w
 TFcI08MogZPJV4QUGHo=; b=YwxSTwoYowNwHip7sDVf8NWtz9v59DJWRO/4tyU9
 GSDSBDDnmKMhwi6BmbGsN8xI8SZz62faf/5ysqovQrGMrlFIj7t9l/5nwGJO7RsF
 V19ccFn6k0S0a0ejmrAxT0If+p4L+fJGN1ndlUz8m9ix9H+AtPHQgahtPH/0r3+j
 QP++JG9oqCzPY5Pjto7otLXWCEN4QcYvgJuCLsLMOjIvX7QVLB/2tNw0v3dTDFvH
 LW4f1v0Gj8te5pnlArIHhFGz3LzM5mRtUloJqMVKzXYfjLqNHu8pPW4JLrImHVPz
 MBOeX1fN7dOmLmcWkMBvtmjMgE+Ldcjwu09xx5LTw/qYIQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6gy53mf8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 21:04:09 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-514ae0e3ad6so20023141cf.0
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 14:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779051849; x=1779656649;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fUhozNQOGlW3rfi5mCmwlO7wTFcI08MogZPJV4QUGHo=;
 b=SRfnnz12vnvYHRVuu96UlmaQQqJb63MUCkzuQj2ira3bPg4cASCJhkLG+8drtVbxt6
 76Xr+lkGPObY8xa9VAjpvZeU+SdQ0nDBcoWXKXzKlDWJFd2kDkzL7fiT5NKUW09QNRRW
 yFUY/G+qqz5TbE4UzFJKpAD+vnK7HJGpR5FmNTsnBdmznHuLCWN3qkBPOTBbqT/GzPU4
 ofMX67In2L2Vfh8gFNq1s8vTD1ECvzJeIOw2jSmdFZMLP4zjpedFgHhAxAY7XuJHuezL
 KAb/O5ENlJQDkLRVAYQbkhx1SzLwR+uaZpKl+1fiBQEiTM+yhbdmJUFJOomvSnt54ygm
 AT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779051849; x=1779656649;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fUhozNQOGlW3rfi5mCmwlO7wTFcI08MogZPJV4QUGHo=;
 b=BjnkiZ2Geb6omhPaqZUoPDxKti0UDwwyEAOqKjRN/GTOrSMAhstYsUI/tvDh+o/nmP
 bbx8Ne/OOKcAUSRmkf5oHM4wxYFQE66oj0EwTX4NH307Uy5or/UMTVuPLpvJYZMVohd2
 jOfWuAkkZKEXemW0Bx67WJV3vqLtls4F8HM5SdzONRi6zh2nWdnj1EwTnK67zfWtmOU/
 izdzc+7TiTeSqriFJy8SI+u4sS0y6bRVLRgwsFxP/qof7fXNGHxfmZaSaYKxLA+ckSET
 7CdQpfUvyLUu+13U/z3Ppbm3G0jKnj9dJt3s3OI9Hq2sTchMKBQaEmNsd8dFz3ULQBVz
 zfxA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/u0WL8oYvoR6FR8d9eg2ZuanxKcqgj2IVrOfjiJOBWQGSLxJp2rj95koPFvZ82pEh+ilf9pBRiHqI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzdG1dwYpy3r6oFvfGzxp1lq0FsfHanlkSaXtcovzz6yuLWOWFN
 +WJX9ypllteVeVLgC1vQaLvUbPCYP6+jIRuDaJvDqJMnM4ffV+3QLCYuoufYmwqZiNnu/2nvYVQ
 AnoPj01zCFndhy1pnZg219+THp+pxpDfoY/UbQfOioeTAYUdCMHVrhXj5XTVvvX4Rp/R2Y30=
X-Gm-Gg: Acq92OHYk3WWT2zirpADvTh228HlWSh9ZzwIiHk7IqIv6lhMp1KlMxsaJaC1IO3lU+C
 2ndCSkicfgJa8nQKWHVcH5QDKl6Q+0srFaV7xOvpYJ/jFvoGh6qhE2NX8gpa+sxu0VzRD/qGE8g
 /CPcGPnHqPxMdYTsRBlpNbgAG4Jrf9Wq1busB5R3dW4VnlFERH7xKDmb/cGZIgeBynsti0ZCHbr
 rdnjqwLrwNME173Kekzitgxet9SZFOZ0THAnKaV5OdJ6yWngbMW8T0BmAybN9u86S7THn3gBiCN
 Ez4AhLmG8pxsEbVthtWVwaEbvgPdZC3t6Ei8Mv/rkDrgITyvi+IEsmrC8N28BlFs2x0k8YiaoP2
 gIdKS5cycax61GugcWA2ga/gDN1xxRaoeIf8bw+UJI21Di64cVoHZSWGh+kSTpHJR61yB2qXBb+
 EyuDEalzwXb40kNbK4rAEq62YCGPrEM/tBkKg=
X-Received: by 2002:ac8:5e4e:0:b0:50f:ba60:2dd4 with SMTP id
 d75a77b69052e-516419629f0mr207324191cf.40.1779051849266; 
 Sun, 17 May 2026 14:04:09 -0700 (PDT)
X-Received: by 2002:ac8:5e4e:0:b0:50f:ba60:2dd4 with SMTP id
 d75a77b69052e-516419629f0mr207323781cf.40.1779051848845; 
 Sun, 17 May 2026 14:04:08 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3958874ec17sm7370821fa.19.2026.05.17.14.04.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 14:04:06 -0700 (PDT)
Date: Mon, 18 May 2026 00:04:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org,
 Michael Trimarchi <michael@amarulasolutions.com>,
 David Airlie <airlied@gmail.com>, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 2/2] drm/panel: simple: Add AM-1280800W8TZQW-T00H
Message-ID: <r6khl2i7bnslvwxnkgkt56fwvvx56mz6pyp5ilbtvhi6er3saw@ajvzqor2eg7t>
References: <20260515082232.1766586-1-dario.binacchi@amarulasolutions.com>
 <20260515082232.1766586-2-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515082232.1766586-2-dario.binacchi@amarulasolutions.com>
X-Authority-Analysis: v=2.4 cv=Wusb99fv c=1 sm=1 tr=0 ts=6a0a2d49 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=iP-xVBlJAAAA:8
 a=EUspDBNiAAAA:8 a=RiJYyaqoZXnZFq063mgA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=lHLH-nfn2y1bM_0xSXwp:22
X-Proofpoint-GUID: aHDeefcjLxCDti02i7MfkCiOmlB8fvam
X-Proofpoint-ORIG-GUID: aHDeefcjLxCDti02i7MfkCiOmlB8fvam
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE3MDIyNiBTYWx0ZWRfXzjVaUHZEnAca
 zP60OfaUP3UvCTFwWOvKDWd2jzhHWTMH1YJZJucCIafjRjbkf0QpPUg5AWV+yYmq7p2Yd3XnozM
 KCuUG+fltLHTan71Nap+BTbrZOav8xig70Dm+aen07m+P6+jGjJHO5UrsbqCMiifjEuTpYoZqJv
 STzarUqeEpksRFNu7L/z7C+cuXq+KB6JkiW+aq7agHunNPZ/uHy/2arennVRnuGjcJMk1ZT76LQ
 VanvGpG0wlroa30vHiWMUDKDybAEwEnG/SGNOCRiMuMFi+YMSehWoETIBsuQpmgGT1+O3YFGl1y
 12oQWpWje32e7ItZZEtFImd4azJz1d1owIvDvXSgOBFFYwQSIy2ikhoaLgsqRIQM+4p7Awz3CX6
 aLy/BEkwJuVvpzFHW4Hc9Qu+IH0DcT+8yZIzf6D2c+NvWpfSnRkETgvK80hLaFw6fALtokMGbFC
 hVQt834+SQ9NTCPbE6Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-17_05,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605170226
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

On Fri, May 15, 2026 at 10:22:01AM +0200, Dario Binacchi wrote:
> Add Ampire, AM-1280800W8TZQW-T00H 10.1" TFT LCD panel timings.
> 
> Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> 
> ---
> 
> Changes in v2:
> - Insert the new data in alphabetical order in
>   drivers/gpu/drm/panel/panel-simple.c.
> 
>  drivers/gpu/drm/panel/panel-simple.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
