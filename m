Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B12FA1FE7
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 18:58:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F338510EA81;
	Wed, 22 Apr 2026 18:58:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gBsQG7vW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QMbz2pJw";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 721F210EA81
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 18:58:18 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63MFPH8v664114
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 18:58:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 No/pAKG4O6yAZkLFF4a0891lo+wTBz8XyvP4tryeoXo=; b=gBsQG7vW1crE7DYN
 TkSKMJG8SLF347jyBACecmoTQLltJIIrv/zAEAu92/fBFUAg73SN27n6dJ1iHoPw
 DQz0+IOKqH5CGWSjARJFmQyl0OOpJDEiHbND9B+e5d/zefc7q+/97DHPOfL7a41Y
 hAoqiyjxKEI3g0019BUk5yIeDpPjcwZYCujOdejch9VSRgYBiNrq/KqvNIVgtgzm
 R/3GymnZm0YikxHptShMMKAAbDfWnLRZTNjHopc9hp42F/m/qOZrPeRCnls8EEzn
 BKUQ4liV4oRQTTxgdt4XZ67GplWTNYsEcczT+apfzbdF/sa4ga04iSYtytT4K+TT
 Wo1RRw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpudgt58s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 18:58:17 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50faf1ecd1dso65786031cf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 11:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776884297; x=1777489097;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=No/pAKG4O6yAZkLFF4a0891lo+wTBz8XyvP4tryeoXo=;
 b=QMbz2pJwBoUczjWYYOGRxopnwJj5mpmG/0pZNlRIE7XnutS0bQRdkL0ZFqRoSaAeGW
 AA6YDMExDaMfbknI4PWhU/+36OCP/z+kv752asZ4EqhFgKiYZZokwvWzKHEWB8LOcma9
 VMrydcy9ttRfm/aQzgYWKWHpmNlZeEyJuurD8zRUXEBgVACSLwnMnl4XHYcyMiaQF4cK
 f5+wpC/qytfGUxzP916cQj0WNn6h6Pgm2C1K+4z2qbPY9gVqkQSnOTazS093LWYlWU3K
 e6zcT6CQdU5xOTvXMGM02M+sDe42xU+olDAFEa7usUf/LQ270a1DnQBIEeFYCEFgoMiw
 hUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776884297; x=1777489097;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=No/pAKG4O6yAZkLFF4a0891lo+wTBz8XyvP4tryeoXo=;
 b=WFTKoxJRStwCoLWcLFW5yps3A4f8VxhKU4ZEe+8aJ7FmeWhMv89ihwvUI6b23zvWga
 JJZOJoPMjDDfYZskGhnrEntbBdueTh4s1Lq534vZZGYGywQiZeI+/EB7euKZimlKetmW
 yt77gEQNj3w+D4KBjulwMliA2vs4eCoJ1F13Ys5fdwsF2y9S93BWOv2CukPUdgonb9+U
 Ed5Qa+RKjNcb7gYu/8Lgu0bugLMLQFVLmkhfftJmVHPHcCW71COvNKob3ggFbQWqvDDi
 1RV5JTGP16RSsaLDxXXhoFya4gkzLZju/+vWtV+cPCose2ls6tmljaFJZrDl+QR4mebJ
 yWUA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+etZ71U7ZB6+pfqcVogUghjJPhc7dguQGPFA1NeYtTsUjRYuMhdyShDUknqUeDDebZC/GmXibkl1Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzXPuaaIG5WvOuHunYi/qOWLQd+vny05fEsEF4kZphRbYX23NwO
 eBCeSU7aZZvHb4gnBQX+q+NbZve0U0JbpgFwGXmgifni1LqijU3v9dRaY3NdE7EYmMAU1ftjvsE
 uZdjj0zeBCqWY/b8kurleOqrSSrpBNd0ukdmzZzbZFEZdPjez3GqnBLUaoq408J9/aVWSdgo=
X-Gm-Gg: AeBDietBdUgUUEqsfSthwGJrNSXX/Q54IOzeSiTNP3EXAWrOBIFqKv/Z4OjT4N04dhB
 Px18K1UyiEQuM+f60c2a5yPms4BVPgj1W8OdKdvbUznqzzjhiRuU6E86dDiOBdYpEMcmUESdk4L
 G88qIVMEsfATfggmLkfWHFREnghEfqhnbC5fVigrAI2TzjvmRvlCrQYqxKQ7d+bU2zOV4xDt5jN
 gtWvRZz7gFUVLM0P2UYSAJ1D+Qhoj8wOA+Vx40lyJZTOA2x4Z7wHJBqFfLHBPRhvZEgsoM6oS/8
 cf1oHLIPFRY7O7l8Id1+IITuS4pukT3x5Vxq7bE4gpDNqaQnIY/J2Av/0uha88jREHulJHkgGtZ
 MdKx9w98jW+7jkzVd8ISyJcJ9QMRTnxfSZsfHU302pjonDHmg9StJ34vqxwd+en+VV+FHml93k2
 QNlfTxXBduPsu9111bXdWr/ILnDJ2x2ZYSOuwv1uaocX+SQg==
X-Received: by 2002:a05:622a:1e14:b0:50b:6cc1:38c6 with SMTP id
 d75a77b69052e-50e36e9aad0mr364083041cf.55.1776884296744; 
 Wed, 22 Apr 2026 11:58:16 -0700 (PDT)
X-Received: by 2002:a05:622a:1e14:b0:50b:6cc1:38c6 with SMTP id
 d75a77b69052e-50e36e9aad0mr364082421cf.55.1776884296235; 
 Wed, 22 Apr 2026 11:58:16 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4185bc25csm4656274e87.26.2026.04.22.11.58.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 11:58:15 -0700 (PDT)
Date: Wed, 22 Apr 2026 21:58:13 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: =?utf-8?B?5p2o5a2Z6L+Q?= <yangsunyun1993@gmail.com>
Cc: syyang@lontium.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
 rfoss@kernel.org, mripard@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 xmzhu@lontium.corp-partner.google.com, tzimmermann@suse.de,
 xbpeng@lontium.com, rlyu@lontium.com, xmzhu@lontium.com
Subject: Re: [PATCH 2/2] drm/bridge: Add LT7911EXC edp to mipi bridge driver
Message-ID: <3gzudodwvibrlzvzb4csbh5ljmhoxvexs4xef2jag5z7ih5nqw@ral5sgh5diso>
References: <20260420023354.1192642-1-syyang@lontium.com>
 <20260420023354.1192642-3-syyang@lontium.com>
 <CAO9ioeXDfTdETEBQknoLehk2aiabCgse109sDgJoPHuQ_07nKQ@mail.gmail.com>
 <CAFQXuNYV+wt2-+8R4m+mtby9TBwcX+vGdqvUvb_6wXkkBg6b=w@mail.gmail.com>
 <ed5u73a5lpsixqvm35zpmooolstjv22ygusorub2owbgz7cwj5@42uq6kl6run7>
 <CAFQXuNZXe0vXAr+dN4LQfC95pvJ5C+Z+b+AuSGZnG4Ui+Nbjww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFQXuNZXe0vXAr+dN4LQfC95pvJ5C+Z+b+AuSGZnG4Ui+Nbjww@mail.gmail.com>
X-Proofpoint-ORIG-GUID: VJrCPXHovQwQQlIAxroaSVJ7tIwAMio4
X-Authority-Analysis: v=2.4 cv=c5ibhx9l c=1 sm=1 tr=0 ts=69e91a49 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=Kz8-B0t5AAAA:8 a=PhM3xCERffu8aKsZnHAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-GUID: VJrCPXHovQwQQlIAxroaSVJ7tIwAMio4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE4MyBTYWx0ZWRfX7zG189x9UgGO
 PwgOEcaTXT+YWi5eOET8YB+UVwKJF15F7fI2mAQ1b330VEJ80Xyp4UGYfQrRVAaO6uew57nXyMC
 tnjgPWfOuFSXxDK5eaHaOoHZWDeZqYSZoi9q/6hH/N6biA9UtRhFfn7/8JBiwUkhu3dnZwjvBwZ
 SWEyWntvY/zCjm16FEkOscBqB247Wcd8oh4i9c6IFTyQb81SVsWz2jqVl8n+JcJ2xSPLHKHRhR1
 p95DFALlekOocPAJPg/Ex4TwHT3rmrpu8bpBco+lhvX+wzvxL8+BjH9fVCnwRj7q0hsrk4aB8YH
 ONgI8UGCtlpffa3hQxrNocAHQWQ9+afey0oBYF4vH7z0e+WQUVYzw88xknfHIn355cEf8IfJ0EC
 5WXHcTYz3mPhzaX0jnxPoevvgoMGLvltj2S6fTGXymt4movQePOJzHGOTsLZzWQAW4O8vTup2q8
 AXsatZZPjMghJK4tTew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220183
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

On Wed, Apr 22, 2026 at 09:06:22AM +0800, 杨孙运 wrote:
> Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> 于2026年4月21日周二 19:15写道：
> >
> > On Tue, Apr 21, 2026 at 11:13:30AM +0800, 杨孙运 wrote:
> > > Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> 于2026年4月20日周一 11:57写道：
> > > >
> > > > On Mon, 20 Apr 2026 at 05:34, <syyang@lontium.com> wrote:
> > > > >
> > > > > From: Sunyun Yang <syyang@lontium.com>

> > > > > +       int fw_version;
> > > > > +       u32 fw_crc;
> > > > > +
> > > > > +       bool enabled;
> > > >
> > > > What for?
> > > >
> > > (bool enabled;) is used as a flag in the code to reduce the frequency
> > > of power supply switching.
> >
> > How does it help to reduce the rate?
> >
> The enabled flag is used to track the hardware power state. In
> lt7911exc_pre_enable(), we check if (lt7911exc->enabled) return; to
> avoid redundant regulator enabling and reset pulses when the DRM
> framework calls pre_enable multiple times.
> 
> Similarly, lt7911exc_post_disable() uses it to prevent multiple
> power-down sequences. This reduces unnecessary power supply switching
> and potential side effects.

Is there a code path leading to multiple enable or multiple disable calls?

> 
> However, if you consider this optimization unnecessary, I can remove
> the flag and the related checks in the next version. Please let me
> know your preference.
> 

-- 
With best wishes
Dmitry
