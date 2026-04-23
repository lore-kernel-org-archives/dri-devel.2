Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A679FF589AE
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 12:29:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C7CF10E332;
	Thu, 23 Apr 2026 12:29:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bs39pbUw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SP1fOjgO";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55B9010E332
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 12:29:05 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63N94gGu2319302
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 12:29:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=n1L4Hnv+dGpKk4WVQcEjDR0G
 vynuLh6AqQmqZsrCRl0=; b=bs39pbUwHofe2VvRgs7MA/fKO7o1HojJQ37OkE6S
 D8Y/s6N7an/5iWVgcwadUjkqzkqYFuQKgjSceZlOyHcelTMfUKFa1tzMssWDMNNC
 IKq/oNgTzVW5aTNvsVk1r9Up2JngPh+a7OwQQIyN6ifT9v2HoCT6tRT5GZbg6i67
 fY9RU77+aNRdzyC5LxM1kaLqulBxepSTMQC8lJX3KYSnmLy0XwU46KS2mZHve7mg
 R5y7kse/Uq3XzjLzpNC+pGHaKPpFWYF/GoLxNa1MlVF/UYQf0tQpFsG1+K6elaNn
 TolLX3CVedX/Cwf5BghF5k0UQf8kQITD0cWyp8GS0qkWzA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqgfsrtb7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 12:29:04 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-358e95e81aeso6578939a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 05:29:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776947344; cv=none;
 d=google.com; s=arc-20240605;
 b=kccGWqjEeF6Kq+V7I5Srkth8QPYhd8EjRZ2v2y50QqQTp4FxyMrqEmsnXKEPieMp7s
 bH+kEdkx4AnZwkWZFUcCVwLxxRPXFl+CNzIOS6Y6pQMxzNp5UiUQcfPTgeWQBVTxJ7rN
 5q2mz2beFq5myIpRRIip0bsN0vFWfG0vb+e7eh4Vmq5xS3XLlb77byyTNudieu3j4alS
 s1lgoYSQ9kVZth8lgK7DAg7fByYMhO0r0FUpVJpZ/FhT7CUtFBHqaH3DvHSWWMjlo/rz
 eVT009o4m6HPtFJpiORyPU/Ti/CMMtucasdDHA6LY+TGUNMbB3X8vkhFb++o2S/fQzha
 sS9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=n1L4Hnv+dGpKk4WVQcEjDR0GvynuLh6AqQmqZsrCRl0=;
 fh=QYeAGqQe143sTh0Yok3hGOeDldMyHOhAM7Q0eA/iPGQ=;
 b=VLu+hr3Gk292A5j0JFNijLtcvSt4aYDGSswiNv5GMWwD8ClA79zUAdpaQHo84wBFf3
 gzVcwXSo70jBb4+yv4tzIbXEVbzydJ7o5KZ7gAELbAYVhwAX111g8twStbt/4xhYJ/7Z
 ei/ZR7lKAk4JeQjYaqLlXFayRaa5Sq15KoN1PAS5A8Oq7HYt1FIbTnydj0wFy+kMpk6i
 D6aYKcs/Bnua09uRhPwKXlz0T1TlAKB6xHR5iyM6EvPxcSBbRedaIPcFKCddc9LWRKLH
 FqXiAmsZ1CiitsSWlK1G3x1robPXILTE5DU/KSMacR+TVEI3A8Yc3p338dZbuVDUbm2L
 A5rQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776947344; x=1777552144;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=n1L4Hnv+dGpKk4WVQcEjDR0GvynuLh6AqQmqZsrCRl0=;
 b=SP1fOjgOpz3Slh9pStMu8+L0Tm8aUjCjXTTIaAIXY8Fm4cHYjBncZfDFLERotCNxC/
 vDhAKd+MTmo3+zw5dvf/ccnCeCiuZ3kqS8E0yx3CQ9EWYSfdUIunUxvnyEEEhwiT/Nmz
 FvCbl10g5m79RZVVDkgeA0YqYUJ81QC5+yyaMJtnMhiB1gw42Fj7+kizAJFwLn7kNCzK
 VVBsuAHRmhOdxZGta3LLoWRmU6AGvE9Er2Hnen3uDiZOiIcMnpOc8lVZrlu8JASKbAZm
 8qPdWlo0+QXtZtIUenn7wT7kl0WDmDTuEEhOq7cZxtD4OVSXDmihYDLGNbjzcPgojSnL
 FRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776947344; x=1777552144;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n1L4Hnv+dGpKk4WVQcEjDR0GvynuLh6AqQmqZsrCRl0=;
 b=Vu9GN3E4NX8y6TeRixYDvoJ1ghB9SFsCZDaDsu+/juHkDVgLtJUm2OoBNo8JGCqoOQ
 Pz6NBIO+G65W93WQlV+l32X56WfLGM54aIvS5nDU/htKRtJoD23CWEvGXPtAn4UanZnU
 rX20sLSOnRsMbXPANV8XEk/nG0/LWuNG6T97w00t0ZvUqfEshMANPvrAOit/PwZ8RYHG
 5IGfkMBT6VGRqH4WYhBGp3hBGfbKz5TCGcem77yKhoT18urvZD+5MvCCJOVshCWqIIcH
 mQdvhOoyZjS0c3SS9qU+VhB8eb5QHpoRq4RGib3aZ/hpwIZ+tkPaTQ7G6egMRK0a9dRV
 DzQg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8nRtAF92XuA+kRl6NcfTyyWT+o2/1xj0NUjrlHTuDvhRlCZ6oie77aqrSRKjden3O3DsJh+J5/izM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzw6t+sJ9mKCctYgOILsou6yS9RqkgrkETXsbL3KDk3h/G0C+cn
 p87a2UO2cVr1/UXJARL8QFSCIF5diU1YqrWxJ3ye4uUDC39r++FxO+/2T0cuwiGetInB9fnPILU
 2XLsWeoNjKsiXxcfSpMlsKBg/c1GHS1sB2VXmTh9NW6/eM25NaKszRqWXs0NK9vAXCzeQUaTJA1
 puxV97gt7K52pKux6/NakZ+lk1ZQZ4J+HkUCYstOy5JaFAyQ==
X-Gm-Gg: AeBDietHplquPrWcKsNI9mtL+3bjYTjtOI/Ws68weW/zf9On/9srGGJ5g87P9/uDNMb
 3eImbpbK/FON0z+n/uFFqqQm10w53ycVaAe0dSWvN/Z1p1X1InRLqzi6JHkcpPROJ4Ea2xGSMxd
 OKDN6LV4G5QXN78l9sAwPTCvkC10SCmLvETRXQgG43zOwxOGvIvbG/MKo9I/RZ+fOL5nrUx9+RL
 XTTuB0taahhNJEJsQ==
X-Received: by 2002:a05:6a20:3c90:b0:3a0:200e:64b0 with SMTP id
 adf61e73a8af0-3a09d099bd8mr28761031637.9.1776947343856; 
 Thu, 23 Apr 2026 05:29:03 -0700 (PDT)
X-Received: by 2002:a05:6a20:3c90:b0:3a0:200e:64b0 with SMTP id
 adf61e73a8af0-3a09d099bd8mr28760989637.9.1776947343366; Thu, 23 Apr 2026
 05:29:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260416-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v3-0-143886aebc6b@bootlin.com>
 <7igh3ptyadpztgxgl2pjbikeossz2trr3rowdjv3lbf6gatyb6@5bm3hon5b6mi>
 <DI0D1NGQHB48.2G6BECF52MA54@bootlin.com>
In-Reply-To: <DI0D1NGQHB48.2G6BECF52MA54@bootlin.com>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 23 Apr 2026 15:28:52 +0300
X-Gm-Features: AQROBzDS31Dlg-ke1wQJnj-27exOu6LsSp3FRB8ZwI0pHXlsL5jTnpzOEsDb_Bs
Message-ID: <CAO9ioeVqoLksMNs5-osAWETjRW+Sa3DF_OmymmG10bJM6XpH+A@mail.gmail.com>
Subject: Re: [PATCH v3] drm/bridge: ti-sn65dsi83: two fixes + add test pattern
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Marek Vasut <marex@denx.de>, Linus Walleij <linusw@kernel.org>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-ORIG-GUID: 1EY6uNVGcBOvgOizQKvzWPlSqFOW3Asq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDEyMyBTYWx0ZWRfX7WgO4DcNtCtQ
 cNCh7kHf5JWA4gCx6dwdcIQN+lUkjGtFkJ7s16/9C7B2WXk7aXHneYNh7XDbNTWGvYUHTidlbKf
 4MLb2QdiP9JaVsBpCRO38iScrHR/SZeXLM/Jru3gCHotOn0mSWkRU1b4RWdivfkSSx0+9oTjB5A
 1NRwoYxA1cWQ2GpBoRTZOfZdUO8AP38dC4E98144AXVj+SniMadX2yKaTW1fUvyi73aXudBj4Pv
 66Gy+rt4/1BXKT6MfMAfsdcrjnBqQCywwQSENVlPXyzVNISwGt9l7amwDCULEntltG1eToWKs4Z
 rr0MxWBs9xSqiJWxOzkb+UJ6LYIFB1ImCKNMcE07CCxxCMU+Jd9ARKw0u1Gj+DRQMkXa+EUypAs
 9Ky9zB89FsndtLkrJNRayImZ7+4LUWsq6DE1kpT+YK87L4jdjxwN+eprFOyDWxDpJI4USy48Os+
 wFuJBE+fXH+yKnzol2A==
X-Authority-Analysis: v=2.4 cv=AvbeGu9P c=1 sm=1 tr=0 ts=69ea1090 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=P-IC7800AAAA:8 a=VySTTlw0iXe7Z9y5i40A:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: 1EY6uNVGcBOvgOizQKvzWPlSqFOW3Asq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604230123
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

On Thu, 23 Apr 2026 at 10:36, Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:
>
> Hi Dmitry,
>
> On Wed Apr 22, 2026 at 9:40 PM CEST, Dmitry Baryshkov wrote:
> > On Thu, Apr 16, 2026 at 03:59:54PM +0200, Luca Ceresoli wrote:
> >> This series used to have two bug fixes, now applied to drm-misc-fixes, and
> >> a patch adding support for enabling the test pattern output from userspace,
> >> which is now at v3.
> >
> > We really need a generic interface for TPGs...
>
> I agree on the general principle, but where could this interface be placed?
> Bridges are not exposed to user space. They are somewhat visible in debugfs
> but even there there's no per-bridge file or directory.

I'd say it should be a part of the encoder. They are exported to
userspace via debugfs. Probably we can have a "tpg" file listing all
possible "test" sources and then accepting the one to generate the
pattern (there can be many TPG sources in the bridge chain + one in
the encoder itself). But it's more of a generic rant, don't let it
stop this series.

-- 
With best wishes
Dmitry
