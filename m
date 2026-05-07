Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A62DBCD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 11:22:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B8D510E1FF;
	Thu,  7 May 2026 11:22:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="URR8d2bl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Db64mpTP";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B25D910E1FF
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 11:22:03 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6479nUFQ1671923
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 11:22:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Fo9XydOcHJ80jEDSvGOMPB4sx1vBdCwRS1ijKyB9oUs=; b=URR8d2blSwSfUFYR
 zFb5Xdm0N7Hl1wTlq9BLyiBjT/qbPNL8vDJEPtb39yUtUq4Nyaag27ZxCDS0F7Q7
 ktcycNQBz5WkVbTu/epblDCzMEw1/6pOtn0N7DaAQj68plIVn8IPjUYxRVycFG3I
 x1CzdDPHcKR83DFgBm3mhjdJhJS8tu5KUzUHw07Khy1VTswUJJjljGMWTtd4ZHwg
 +QKuP0yO0TVgGhN9nwlZXLotBS9jSLQ2NHqv/H4Jj8yBMOIbYZOUarvROgIR0NPd
 WogkQx+/vQe3I827NcoXdkzC4pMyYfAvppJrmRGnKtqHddF0/tNxRkyQZQYyPnt+
 zfXtUA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0k1p1kw2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 11:22:02 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50ff051e189so14134121cf.2
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 04:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778152922; x=1778757722;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Fo9XydOcHJ80jEDSvGOMPB4sx1vBdCwRS1ijKyB9oUs=;
 b=Db64mpTPcOkxUOWDhENNqre3uqucyjg1HSDZ6tY5bj9DROqlFZPh4cmsKFplJSK1m+
 KMtFjWEACYpEif0QpuRYHP4Jm5Phe6KbXzPpOOt4dQIY5jMluj3Ycr1ES2fPuqtDS9Uc
 dfaJGxhIkeIBmHbsYZblWYLofqQHTuLQu9ZwBJjlD3aHntgb1avo+WyqXn/Nlld4lyZY
 kgmg4Ni9uRkoB4dA98HBCL3gumYMuj7SGm897iXRZOJGtEOkHnbVuzu1hQkB3C+bYXKS
 PbJYs8NDTLqEUDX9Wb7QJ7FXwNQ2lDQcP0CD2aZZanATdNGGYO5iazeaKdH4pblajE31
 hQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778152922; x=1778757722;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fo9XydOcHJ80jEDSvGOMPB4sx1vBdCwRS1ijKyB9oUs=;
 b=Y+ORm+J9q47qZyz3oCUz1m1pWAITN8ZfHDFp+PyIg1jvVhSsMVNXIVZZ4lsHnd4zcI
 /s+2FMzwBY2EtirBR2dpYM6hw7+XVpRiNNwR43WIBZPAUgaOONy3/Z9suys6lQqYVrIA
 eREG9Gm1aoykBmclbrny2u0iHy+S/QFR2L22mSw6J5pwoLgPtaO+ThdtcRBSfMsf2sT/
 J/nrD3ehu/1OVx6DLSF6t3gHyJyZSIBO1KFPGWSHKcTYdPp0FScxHr0MJFpI+ssGeFOw
 PlCl+EUmPMaR2AoszSXJFFKz1iNlQegTb5g0xVLqJ8U5+EOlEO5SO3rjuSQnE+yEWlcC
 IiKg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9DGkOuaIVqAcTJwQ/FQxpVoq9iWB6HHh7Yy4BYD332trHBTxHoUkH9R978aePx2j97PLW+2dAoE/s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx8WLYZmVkakE1lVVmaj/hD1clYsyB3w7pxqd/79BiK4r4OWGrX
 LFadMQbVqRuE9jhZPI+1OxsFHIIZiNmf6q7gZvoyXoBP+s/Alqjsp6J0BHCYeknY2PDQgBkniZQ
 65kTj/5dKQ7bkYuPtdyEV4vN0cuUDk1lnDWvXNrvKXN9VioyN5e1OgGGJOWoFS/uC5fyabic=
X-Gm-Gg: AeBDieu1BJUWMlKvgEnUcXS2R3Bak3kT0VoRF5iV3+ImihVKM/bshGdMaqpk82O6KYT
 delZspdiQ1X7E2mxQRL1dqFoFOhzE7gC9H3zbPLzts9/Idsx3jHPZhzRr6AO+44WY4al4sgTYSS
 CW3V6DaQxARCrRVmYWdivhV0RPd4sYIlO/pbYP0gsYNBzgpuXoTRQ5RcYbxJvdcQZibWp1E368y
 uqSLaBdFaMqz1B5L6Z0SVuDL2p/9H8sJJsz8d0uKP1/ZBNP5Xbnd2iDpMv7nFk603RN+CoCw3vM
 1a0pThzO9vLBiWSRiGr8TIC5EAjDpB6JfvIp506Ky9igCs65giVa1uAKnlVCuK1qnCbeLAVJYdK
 drpK3YvLOzUU/Eyw6nuhKe+G4uuzKmZbt1H2VsnKJ7LTV6asNwdYMdwxHb4j3QrRARn4yZu+Z44
 99KIT6/qHNdnZ9xy4DlzuoPdYuUWTXgLO3pVy+GjxhqRPNvg==
X-Received: by 2002:a05:622a:1105:b0:50f:c625:4dc2 with SMTP id
 d75a77b69052e-51461f9ee04mr99576301cf.35.1778152921998; 
 Thu, 07 May 2026 04:22:01 -0700 (PDT)
X-Received: by 2002:a05:622a:1105:b0:50f:c625:4dc2 with SMTP id
 d75a77b69052e-51461f9ee04mr99575831cf.35.1778152921478; 
 Thu, 07 May 2026 04:22:01 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39380eca9aesm44533811fa.30.2026.05.07.04.22.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 04:22:00 -0700 (PDT)
Date: Thu, 7 May 2026 14:21:58 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: =?utf-8?B?5p2o5a2Z6L+Q?= <yangsunyun1993@gmail.com>
Cc: syyang@lontium.com, linux-firmware@kernel.org,
 xmzhu@lontium.corp-partner.google.com, xmzhu@lontium.com,
 rlyu@lontium.com, xbpeng@lontium.com, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2] linux-firmware: Add firmware for Lontium LT9611C
Message-ID: <sgxdjvn45w32mz3hmbpgahvz472zmqrvd3souzu5yl2n3q3tsa@l6qbuxdsqxz3>
References: <20260506104934.82275-1-syyang@lontium.com>
 <CAO9ioeVBF2O9sRT+KzMETvYuV5Jw0okj6MiM1sxVdc5j8Pdk3w@mail.gmail.com>
 <CAFQXuNbA-wW-ZyqZKjRagA+qpPMP7AAtaX67Y4=AHOx23s2SEg@mail.gmail.com>
 <CAFQXuNbWQQN0U+s0K2XV7hy6ow3x7RAB8Q=nxOvsWENDAE=2VQ@mail.gmail.com>
 <uprzduq4ct2dpkwvlbwxw43b77yzubjwkzvjhadlkoajmbbybe@3cygq6vamfy4>
 <CAFQXuNZpBnA=kCCKEhXtN4wDOdU48D94PpbYrR_cEu+YUt8aBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFQXuNZpBnA=kCCKEhXtN4wDOdU48D94PpbYrR_cEu+YUt8aBw@mail.gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDExMyBTYWx0ZWRfX7d5TlzEzycV6
 6JrJCyJ/4r3yph5Mqlh42jE7TtNo8p0g7q6EP3wqdAcUiJlnH2flQxLCSlFwjjbsSbyhaijI/Ne
 HmnwQWyMZ4OqhM3t6z3J6zcfLn9iKNvHRspmFpFzycwV+EArNDs8lDDxEJ/tmJ2VcyrhjHQw/0u
 228M05QX4t2FCY+XjY9FtigD/rHHAVMWcdd2Rc6T4JSYPBfkKCMjitDPKbAsI9ILcESuVnnPuY2
 03XlCbDnqMlwNW/0g8eIiEprNEWOdNoZhXzcvWUoLygDl393xW8Eau3Y97LGdFBqmLG4UuvjIvZ
 pD7mMuAWTczPFeDTD+TczGDMc7BWs5TZO2APaUyy8CbF0FsGfe5eCyCmLznQD5ISfz2iXrIEVnh
 k5mO2hXUG9bNVIxMP0NbzVUukWHYg2or9G9WgzVLCExxbk0PmLEp32XX2a2hluTyYxYEVi//R8U
 LS2zo3Mdh+K7v1UgKlA==
X-Proofpoint-GUID: Ol2gvzS47VLVb7CD4Y8OzCzSB6IG6kgr
X-Proofpoint-ORIG-GUID: Ol2gvzS47VLVb7CD4Y8OzCzSB6IG6kgr
X-Authority-Analysis: v=2.4 cv=K4IS2SWI c=1 sm=1 tr=0 ts=69fc75db cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=Kz8-B0t5AAAA:8 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=CUJi3jauEGqHWIC8MBIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
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

On Thu, May 07, 2026 at 08:56:35AM +0800, 杨孙运 wrote:
> Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> 于2026年5月7日周四 04:08写道：
> >
> > On Wed, May 06, 2026 at 08:01:46PM +0800, 杨孙运 wrote:
> > > 杨孙运 <yangsunyun1993@gmail.com> 于2026年5月6日周三 19:55写道：
> > > >
> > > > Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> 于2026年5月6日周三 19:46写道：
> > > > >
> > > > > On Wed, 6 May 2026 at 13:49, <syyang@lontium.com> wrote:
> > > > > >
> > > > > > From: Sunyun Yang <syyang@lontium.com>
> > > > > >
> > > > > > This is the firmware for the Lontium LT9611C,
> > > > > > which implements the function of converting MIPI DSI to HDMI.
> > > > > >
> > > > > > Signed-off-by: Sunyun Yang <syyang@lontium.com>
> > > > > > ---
> > > > > > Change in v2:
> > > > > > - WHENCE
> > > > > >  1. Modify lt9611c_fw.bin to Lontium/lt9611c_fw.bin in the WHENCE file.
> > > > > > - Link to v1: https://lore.kernel.org/all/20260506100242.79276-1-syyang@lontium.com/
> > > > >
> > > > > Why? The rest of the Lontium firmware is in the root directory. The
> > > > > driver also (IIRC) expects the firmware in the root firmware
> > > > > directory.
> > > > >
> > > >
> > > > Our intention is to place all Lontium firmware in the Lontium/
> > > > directory for the following reasons:
> > > >
> > > > 1. To distinguish them from other companies' firmware files，such as
> > > > rockchip, qcom.
> > > >
> > > > 2. To keep the root directory cleaner and more organized.
> > > >
> > > 3. Clear organizational structure
> > > 4. Avoid root directory bloat
> > > 5. Improve readability
> > >
> > > That's what I think.
> >
> > It's all fine... If it was consistent with the driver that is being sent
> > to dri-devel@. I'm fine either way (and yes, having Lontium subdir makes
> > sense as this is the 3rd one already). But then at least drop a note to
> > the dri-devel mailing list that you'll send the next iteration of the
> > driver.
> >
> thanks Dmitry, your reply is very useful to me.
> 
> In the next version of the driver (v5), I will use  #define FW_FILE
> "Lontium/lt9611c_fw.bin".

Thanks, the firmware is merged and pushed out:

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/1034

> 
> > --
> > With best wishes
> > Dmitry

-- 
With best wishes
Dmitry
