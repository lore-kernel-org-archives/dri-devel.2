Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85DB3C5DF74
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 03:01:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF6C510E4B1;
	Tue, 18 Aug 2026 03:01:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CCt8SSDx";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IY+RN6Q/";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDC3710E491
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 03:01:55 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HLkhMb3566540
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 03:01:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=ZBz2J/YR064wcCDlSxnx2LWj
 NaH5A+0wFaq4Q0GwWVY=; b=CCt8SSDxuZAlXZCuVF7FdA4BBarebF0vi6DR6AUJ
 RohD5U3q065fxZ/SPY/Rj9yA0N/spjaxzfI6evKJnGwG9NZwKtYfIZlE+CAZ+VJm
 +jDyQlAqD6yFHtqJ7Y/wBOCet2HFnWUm/P6QKmnOVY0B5rQvXm5xag7Z1AEDvHLy
 0FTqbuMBdjcecjzVJ2w4QjuEt7kFy75e57f3gZXsF5/YLP4xJ8LViC0as/IfBbAB
 EKf/ZpbDUvXuMWFlBjjtUHGs+pPDy9yb2Eh+SYO7vc0nOv8KoOtrO9XMAmdGGJdx
 srrZQGKI+SrtZoXjSwkJsdqp0jzPrqsap/sri0fjwskkAg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g48q0sfsv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 03:01:54 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9349c5af52bso686294785a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 20:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787022114; x=1787626914;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZBz2J/YR064wcCDlSxnx2LWjNaH5A+0wFaq4Q0GwWVY=;
 b=IY+RN6Q/Kj78p1WzCBKBt2gFldt4yJF55lC97mpytjZ9Ai6fEtXFtR7TcIlSgceXDP
 Yipk4bk6k8APLb7TVCh4cxjSH+epT67LA07NAMN2p33i7WYNvFB8xd9jVehn1KhqnZgM
 TJlmXES4pi1r9U26CUNYJ4zdPUisPd/0qMBbneJ/IYSwGs1xHV9W40a2j3CCe5eo1otN
 QbEnYIRd0+bmIB1XFIUk6tGu5rCkfs/fG+HDv7Kkee+9eCk0Y/c01URd6vqRTA+xkfT2
 ulUamRur7IQn2zppbC6KYVOjFYvO10lU059hfgZcY4gAdzkcnakisZShKrKzzcRXZYRL
 OSXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787022114; x=1787626914;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZBz2J/YR064wcCDlSxnx2LWjNaH5A+0wFaq4Q0GwWVY=;
 b=hazfdi/mo2Mnww4/R1nin8+m9Dkk9dQ0Xr+1SrSi2NGL9N8+7b1cxSTtfQOEhiwvyZ
 b5hVpiofENmwXEPPSaoB7XWRsXboc1AXNg1RGHzqHR6hikDSdx6FsYj50TvxgF8ZGgld
 +mUE+e3P33UBW1I/+6/CfzDygvnyQWrHVjMG77KdSRKMrtGurhQ839ra6As2imTLkjf4
 cBjgoVNyTNOSY9LdyrIch8v17aaurv9oOUhYbJolCGXdL9AnNWCd9edi2kArv03ZzQoS
 96z2UH2B2qXeT5SXwmpoJPb9mTmKSXccDu2f8oFFfuxak0TYuoXkOAup8ggQI/qWUsel
 OaNw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoplaY1pkF3C6BLyzcJJYQxzPXPWTHgo5FynFoE5/a5d8QfNfPro9qx9GJ/etScHkOWnymEqhdiSIU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyqlbheppls1I8EB2dWdZNz9aUn7ZbmIe3Ppubg6hhzvOpjTvcn
 OfQiTVgKkYIDLWvfH2PFKE+szI6fGzuGbRtF7ZymRW2IHV+Qsqbdxx2wB6MIz/uRq/lT9JcnMJO
 xlNVnT7r2qDTarEs62cucRct/VXQ7tq3cDzWe1ZOsw92f/73cqjeemtiTKkIEZC7D/buTxTo=
X-Gm-Gg: AR+sD10lcHPVsFxCWc16AsXUZ9eXXEocujSyNwqT04kRKcAKbPKRsD3k3xzgjZRYS/f
 dD+2jNHGWxjIztavFbde5op8i4Z0ygTkgvqJZQ0VckcgvnJMYdujpIzNZj2b/0Y2bTt8Ie/vTld
 sP55ogSHRc4HaPHRmXECpfqThXQFxAXp5NfTubUC0+l4c2k8llHajWPoQDBrIg6OhgtN/6lLlFE
 6Di8GYjQL+SYx2LD5/++dWxQOEDcVhEgoSV3z/GUmnWYkgGZsUsbxb7eRX/dxik15MoJzzHKxiq
 x9D0rJZqhH3YFBaPo9hqLVZL/Q+6fP6QUVXrbPHiPAB1MqJvu4DdyVXgEAQhYxGzbWuU3DoF8vG
 umZXj6qzNnK7aIoVMg+D+MCk0gIY3bBrzXeN8FIoeWwu8NiyeKcL9x05IdJixbu6wcr+4frO7Gn
 sm4Cw3okeLx2T4
X-Received: by 2002:a05:620a:28d1:b0:932:df7e:b31d with SMTP id
 af79cd13be357-936d227ee03mr2727444385a.12.1787022113818; 
 Mon, 17 Aug 2026 20:01:53 -0700 (PDT)
X-Received: by 2002:a05:620a:28d1:b0:932:df7e:b31d with SMTP id
 af79cd13be357-936d227ee03mr2727440185a.12.1787022113404; 
 Mon, 17 Aug 2026 20:01:53 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a16b1bcc39sm8342611fa.29.2026.08.17.20.01.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 20:01:51 -0700 (PDT)
Date: Tue, 18 Aug 2026 06:01:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org
Subject: Re: [PATCH 1/5] drm/bridge: allow hpd_notify() to suppress connector
 hotplug events
Message-ID: <pyqpajtjcnslk6g5ysn3ce2csrb76fhd5bif4vdb6wezomlmsg@fsl55exyufx2>
References: <20260629-msm-dp-msttypec-v1-0-646a10256233@oss.qualcomm.com>
 <20260629-msm-dp-msttypec-v1-1-646a10256233@oss.qualcomm.com>
 <cgk2httvebzm2jnjnb437mutez66tfozzdk77mjwukfzngdioh@mu46u3pwlf2u>
 <af5f2e4f-42a2-49f3-9c6c-0f910c5f9208@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af5f2e4f-42a2-49f3-9c6c-0f910c5f9208@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAyMSBTYWx0ZWRfX2OjMbMp2WRDP
 FcJcZ0h38DPIwe4VhWsfVnCkIOIxS8IgWzwMPlsn87Yk68tsdXvRvZYY95Y0SxgLUF2T/RKJ1BE
 DTR59Qj4qfL78lwbvZqav1ZVWYgjvB8=
X-Authority-Analysis: v=2.4 cv=VuITxe2n c=1 sm=1 tr=0 ts=6a83cb22 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=WMPlNdQLU-vNwlj8jccA:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: 7BFjUtN8ViaVXcFDFA3CBAe_aM3yUaiq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAyMSBTYWx0ZWRfX7R0qxsNELCZr
 HMpfUDzemzKQlixWOGobCHvnOHkJLefk4bq49T3dbadZV08ayYjWTP9+hRJLk2y+y80G6na/XFJ
 Qb+8aih81U5NpSQd8ONM4YmxukNDYZC+E0qcgK9YEA+N8CLPUtt/23Zp67Mo8KryIvCKTG9pE0Q
 rCUqllTLCkjgE8Q9KI+Vf1AgCVcjpyJNs1aD4Azn+KqYuZsIWmbE2Zj9QCm9OFUEkgZHeEaqPzR
 RbWuuwXSO0zFLXXaw/Mob9jmC8mdBE3J/LDLtEcjwSIVYFkWedFbn3ElTr90TQ0xg7gPGy8iEGY
 BbytOODS+qBPLsLoLeATfuB7akmkgJXkoRqeyo32ihHp2GY/b1AN/VTrhdTdRuap4j3rF1In4TX
 5rrIILaSM30MBeuN3cC3mwHQ8V09413O0g3KVl5y0XR2zXPSUORTLB/+NrUsPZ2ZujASblVMGS2
 tiVs1+04iUcXwwSa8yg==
X-Proofpoint-ORIG-GUID: 7BFjUtN8ViaVXcFDFA3CBAe_aM3yUaiq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180021
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

On Mon, Aug 17, 2026 at 04:01:41PM +0800, Yongxing Mou wrote:
> 
> 
> On 7/12/2026 6:21 PM, Dmitry Baryshkov wrote:
> > On Mon, Jun 29, 2026 at 10:48:03PM +0800, Yongxing Mou wrote:
> > > The bridge connector framework currently invokes all bridge
> > > hpd_notify() callbacks and unconditionally emits a connector hotplug
> > > event afterwards.
> > > 
> > > However, not every HPD notification requires a userspace hotplug event.
> > > 
> > > In particular, DP MST bridges may use hpd_notify() to propagate HPD and
> > > IRQ notifications through the bridge chain while the actual hotplug
> > > handling is performed by the DRM DP MST core. Connector creation,
> > > removal and userspace hotplug events are already managed by the MST
> > > topology framework.
> > > 
> > > Allow hpd_notify() implementations to suppress the bridge connector
> > > hotplug event by introducing a bool *send_hotplug parameter. Drivers
> > > can clear this flag when HPD processing should not result in a
> > > connector hotplug notification.
> > 
> > Why? Worst case the kernel receives another hotplug notification which
> > gets ignored by the driver.
> > 
> Hi, thanks for reviwing those patches.
> Let me try to explain the motivation.
> 
> Semantically, IRQ_HPD is just an IRQ notification, not a connection state
> transition, and shouldn't be turned into a userspace hotplug in the first
> place. However, drm_bridge_connector_handle_hpd() currently calls
> drm_kms_helper_connector_hotplug_event() unconditionally after processing
> the event, so every IRQ_HPD ends up reported as a hotplug.

What if the IRQ_HPD is delivered together with the first HPD event (for
example because of the TCPM processing those events)? See the mechanism
in the displayport.c AltMode driver.

> Second, MST IRQ_HPD is level-sticky -- as long as the ACK has not been
> cleared, the IRQ keeps firing repeatedly, and MST bring-up (link training
> / MST enable handshake) itself generates a burst of IRQ_HPDs. So this is
> not about "one extra hotplug", but about a burst of them within a short
> window.

Ok, if it is level-sticky, it should be handled as such.

> 
> Every one of those hotplugs is delivered to userspace via udev and
> prompts the compositor to re-probe the connector. In the window before
> mst_active is set, that re-probe walks back into msm_dp_bridge_detect()
> and performs aux/DPCD accesses, racing with the MST enable flow.

If there is a race, the path needs to have a lock, preventing concurrent
access. Otherwise, you are just shortening the window instead of solving
the problem.

> 
> The amplification also isn't limited to a single connector: on Hamoa
> there are 4 connectors (3x DP + eDP), and we observe that a hotplug on
> any one connector causes the compositor to re-query all 4. So this burst

Please fix the compositor, it should not need to query all 4 connectors
if the HPD event came from the single one.

> of spurious IRQ_HPDs during MST enable ends up amplified across the
> whole card.

How do i915, amdgpu and nouveau respond to IRQ_HPD? When do they send
the HPD event to the userspace?

> > > A NULL pointer indicates that hotplug suppression is not supported by
> > > the caller, such as the connector detect polling path.
> > 
> > And nothing in this patch makes any use of it. I'd say, it's
> > questionable addition. Let me check other patches...
> > 
> You are right, I will reorganize the patches in next patchset.
> > > 
> > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > ---
> > >   drivers/gpu/drm/bridge/lontium-lt9611uxc.c     |  3 ++-
> > >   drivers/gpu/drm/display/drm_bridge_connector.c | 15 +++++++++------
> > >   drivers/gpu/drm/meson/meson_encoder_hdmi.c     |  3 ++-
> > >   drivers/gpu/drm/msm/dp/dp_display.c            |  3 ++-
> > >   drivers/gpu/drm/msm/dp/dp_drm.h                |  3 ++-
> > >   drivers/gpu/drm/omapdrm/dss/hdmi4.c            |  3 ++-
> > >   include/drm/drm_bridge.h                       |  3 ++-
> > >   7 files changed, 21 insertions(+), 12 deletions(-)
> > 
> 

-- 
With best wishes
Dmitry
