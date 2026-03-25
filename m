Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85613FEA806
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 04:21:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6EBB10E1E1;
	Wed, 25 Mar 2026 04:21:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gWgBC/WY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dO9aJ9pm";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A45610E1E1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 04:21:55 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62P3o2CG1208643
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 04:21:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=D/aJ7qmx0lND45eyidmiAx7I
 2GBrkxtFsVI8mdbQxBI=; b=gWgBC/WYtC5ct/0L9Twud+l8ArZCJLaYvwRswi+F
 gULyF17mpvd7CWGUaiBEx8yw6NharI+b6oa8cMumJbvJhK7xjA2S4Nk9lAtJRx1z
 vj4ILg/nDDArTTiBJ0yiTdrQ+ryGZOxqjquQH46dTflOv38D+emUbwjYOB7JnHaa
 +JXH3P0HdSa3FKiW+2l6o1OsSXtz1/GvV7dfLBzAI2cHDoldtwDlHjHMXKb7KFDh
 OeSBgvwowZ0/I58usORfubkAL/WWbXVRbw84znEpLalNtbOmmK9KfpJyQn5I742V
 w1+EFxrgUxkRMX9tTzX5BjD2nTW5qxdjudO4zI2mlMvCJQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d485982p5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 04:21:54 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b061868724so81663065ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 21:21:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774412513; cv=none;
 d=google.com; s=arc-20240605;
 b=ZTRrQX5gHFq52HrjEqwj0cEHqA8V8JYU1EHUpvTSLxNRAF1J+8QxfdR06NLBfjCAPq
 DwPS8DFE+zkanBgPTFZfpd4VX3Lkig4Ltc8uY9LGs+MDqPyGUf3fjeKEdij0pBz3Bacs
 Fyy94POUfHKyKzS+P+PV2tVzyeGuaMhutLi17eyy6Ixa79hF/8LZL0TxEhlIeVyTyg3i
 idGD0fhbGIw5NgkVSYMAKxQfhcqWArgBm464WKvp8Pxs6ogj2kt128j9ToqFUd2pFQ48
 FaFd6oYkJQSgT9Z/IcYwOEC/axmNEK51PcCyArF8CXApZsftBHIti9An6aq9dFb18hiI
 myXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=D/aJ7qmx0lND45eyidmiAx7I2GBrkxtFsVI8mdbQxBI=;
 fh=xDKfBr+WO6GcAwb3IThvyFXYnFtnZ2JpNRI/FnF79H8=;
 b=JDJ/HV7jOyxSU8pHhtOKlfcWTRQ7x4igYI+FMFMSfRSSDXvSMYMsJ9kbPHOahB0SPk
 tpo2zm00XiVmBVFP9q6LStgX8pMzuGT5c5Y0vzMrJRhwDl0b/a3tY0fPNw5MJLLMJSXE
 HOTkw657rKWPFV0R5XZuDWOUKkWr29Y7NPEgCaUn500zLwnDeRByT4BcFOHCt3/qRB8W
 5wavjvG9550ih8KLXXX3+S9Nv96nHNQEuwnGvX3F52/7qXvaTIrcscXrmQpckodulE+/
 c+oYsTtvtC1fCyYU5BJyn2CrkNm7f09jJf+0GIggXy9/H6F2KqbgWgp4bcJQrrbyw/ds
 WxHg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774412513; x=1775017313;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=D/aJ7qmx0lND45eyidmiAx7I2GBrkxtFsVI8mdbQxBI=;
 b=dO9aJ9pmcp6RQWaRKx/TNdHtrVwv5rHV8CExYCWrh8tICAePaDdrl423+6SPV9lp7r
 Sgl0j5XbLqzWeBUJGucuh6g3x5UW6+91ut+gw1cMQGP5/25erna4pXZmoEwuRD+x2nCc
 qK7NyJAfWIdSbVhr+W5j6zQvr68zZQQj3MGYk8sdpq4xumFELs1et+SWOcajJG1I1evx
 Vx+az1Hr9POxZmM42tdwJXi0EcATvHgbdxzSP1i8t649woCp1ywSU1EOIw9VhHq6m6bq
 JLI0sMYD/X410G2cH92xgAVX+vlCDkD2OCN11nAigcL6SRb7gc0cgA38qamFENAYuv8g
 2J+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774412513; x=1775017313;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D/aJ7qmx0lND45eyidmiAx7I2GBrkxtFsVI8mdbQxBI=;
 b=rql2m6KHOERaE72Dz+jcAOFndhKWtXdQi3Z++kCaQQyRUkCJsxq0aNPVnFF4imwdBw
 SRlYihZzcEo9/UGqcAEPv5eWhUmnNwsDkrNECSy6jxlwfRYQ1IoX3XpERyx51VR1niYX
 v7anBMK48lMjOQ5YSX8Sl12fFmJxyaMAy7+QfJHdJqCiwwyytOpST3Fd/rLWXNvis1Al
 JjXMvrp+08g3IqMFjuTFO4jM4OAB4EwNjFkA/HJjGVYgBG6hMvStZoUkOHHbcZpgOzM0
 3041KllanvMsVTJRw79pXc8lNlxr2mhBu+HzsSzSk04P42NNalg/gLclk3hd7vzyO/jO
 fuCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsBhJymihwPQDUcuq7kagmePeBFmBkF0wBQbfrd1UzY19G9hY5sVZMiOU4Ic+gVOyMd7IUS3GCScU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YydP013wMAqnX15XK0cJeCB7cGeCigb19NmbqUNF1oQeNwoFl65
 Wh6Nc7cH7sUsqOTGWJaz00yjW+bd22pLheSemlwKTD9OHKb886dO0YGl5mBBK2pF4Fr3QNO98Si
 in4CmtDJXxkQCoMPknelouJIerv/AhPsO03e6+AC1DG7lKEL+huMxTifKOeTiOpmBh+Sj050oNl
 SBfa/ywcCp0Xn1m7NOeGKxAywk7mXc8NFaAOJwJtGGLld68iaVzOfGNFs6
X-Gm-Gg: ATEYQzyl79FEshPH+IzTN3yGfX0sRegZOludGvapkXH8Mgf27rRNpRf4Wx5XLFKRp1O
 9QkUWd7ErbN/AVz/99JOiUrwB1rj4t+GjFl2rDQ1+sd8RRWd1b1rtoXvMrkPJM8u1k02O+W/AZX
 EXaSCoA4T8qhTXub7m+xrQZkvIlGm/NGyECobwVuzJ7O6pQNgETt5yZXtcWZ2JRqDIxKAIpn7mg
 aqw0Ao=
X-Received: by 2002:a17:903:910:b0:2ae:ced7:4650 with SMTP id
 d9443c01a7336-2b0b0a7f74bmr22620825ad.24.1774412513399; 
 Tue, 24 Mar 2026 21:21:53 -0700 (PDT)
X-Received: by 2002:a17:903:910:b0:2ae:ced7:4650 with SMTP id
 d9443c01a7336-2b0b0a7f74bmr22620335ad.24.1774412512717; Tue, 24 Mar 2026
 21:21:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260314-dp-connector-hpd-v1-0-786044cedc17@oss.qualcomm.com>
 <20260314-dp-connector-hpd-v1-2-786044cedc17@oss.qualcomm.com>
 <20260318174000.GK633439@killaraus.ideasonboard.com>
In-Reply-To: <20260318174000.GK633439@killaraus.ideasonboard.com>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 25 Mar 2026 06:21:40 +0200
X-Gm-Features: AaiRm536djLXP7MN5Nm6e9xQKmaKLozPoJuN46DeXHIu6HD0mmKI5CD3EYTj1tw
Message-ID: <CAO9ioeVyAgcki2N=9uN4w=1D20385H4aXgra7_MF9yXnwxoVpA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/bridge: display-connector: trigger initial HPD
 event for DP
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Sam Ravnborg <sam@ravnborg.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDAyNyBTYWx0ZWRfXyNPGv7HhOVIe
 reuSejwGU4XsCq/94/eP1jGdZoKPAHyGHsQSzgifKkFRpeHvfojYn76/jq+9QlxUS8f0orbs6VV
 Yafry1AX9JI2RCn5QktwlnNBLvV8HNO9QoxwEfkE2dTW04XPcHnV64rvG3ZClaPxXf3Xfn2GaBK
 HSH+Bb52LA+8XtKxqGJuaDK3/ROEPsg4jsGO+v2H8eY7+VFb9rbaP8RmiUjDAeYMLIw3MmCShXM
 B82q33F0JMybopAvX7BzfIeDgq5QX2spzuvmYNRT2pZ/O21fxoxK3Cko8oksyjupKugCFXWTz9u
 tg4rtcwYlzlFaUIHmcfTOTbGj0Ej15UUvBThwdqmyFLmKfdi9dksPzwhXUEwwhkAd+0uRfXXzEQ
 xCOq2dfmT12TramOlnVI8OX15r3TlowEhzJNswhGYhKUobHyHwvCWDV6AfMwUmiAlKN/ikgQjgC
 7KPWT4eroliGuaIQ1nw==
X-Authority-Analysis: v=2.4 cv=VODQXtPX c=1 sm=1 tr=0 ts=69c362e2 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=P1BnusSwAAAA:8 a=EUspDBNiAAAA:8
 a=WyTQnvZ4-TvxbGU1kG0A:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=D0XLA9XvdZm18NrgonBM:22
X-Proofpoint-GUID: z0ipUJoiapdrkBYM5m2tYRa0z1vbUp3Q
X-Proofpoint-ORIG-GUID: z0ipUJoiapdrkBYM5m2tYRa0z1vbUp3Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_01,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603250027
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

Hi,

On Wed, 18 Mar 2026 at 19:40, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>

Sorry, I missed your email.

>
> On Sat, Mar 14, 2026 at 02:43:12AM +0200, Dmitry Baryshkov wrote:
> > If the DisplayPort drivers use display-connector for the HPD detection,
> > the internal HPD state machine might be not active and thus the hardware
> > might be not able to handle cable detection correctly. Instead it will
> > depend on the externall HPD notifications to set the cable state,
> > bypassing the internal HPD state machine (for example this is the case
> > for the msm DP driver).
> >
> > However if the cable has been plugged before the HPD IRQ has been
> > enabled, there will be no HPD event coming. The drivers might fail
> > detection in such a case. Trigger the HPD notification after enabling
> > the HPD IRQ, propagating the cable insertion state.
>
> The explanation makes sense, but it sounds like to could apply the same
> way to HDMI. What am I missing ?

Well... First of all, since HDMI doesn't have all DP magic, there is
no difference between HPD pin state and the display being plugged in
(so, e.g. dp-connector can't implement OP_DETECT, while hdmi-connector
does). For HDMI we usually don't have a complicated state machine in
the hardware. Nor do we have a an AUX bus with timeouts, etc.

>
> Also, wouldn't it be better if the DRM core interrogated the state of
> the HPD signal when enabling HPD, instead of relying on all drivers to
> implement something similar as this patch ?

Most of the drivers don't require this. It is only limited to the
OP_HPD bridges which don't implement OP_DETECT.

>
> > Fixes: 2e2bf3a5584d ("drm/bridge: display-connector: add DP support")
> > Reported-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/bridge/display-connector.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)



--
With best wishes
Dmitry
