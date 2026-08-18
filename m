Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BCA5C5DF74
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 03:18:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C51F610E9CD;
	Tue, 18 Aug 2026 03:18:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WkK5frd7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i8fHHtDJ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3EB710E4AD
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 03:18:22 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HLkoVx3882319
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 03:18:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nulXSaXrAlQIr1GDe4EmANgxiU9rNDcxA688/Kv27N4=; b=WkK5frd7fdbUdVqb
 U3sPn10YKKrMrbK6n3tDunsyDRNy11RfIQla6GuHj53JCjCa2bMY6vioFOBYtinc
 gOlm971q3CgYaqI+kw6/EyXvcs+HXi+QXw8MGx1FeP9E4vjmhV1TsG1aZQTl8c5o
 +6KUQR9EexwshPmj0bycvD3sBwvUrvYnyA7J2iTvtwFaxMHZWl3I7774PZpY6B4P
 hX2gSKf69Eubsh3WllT0MP9Eedb8UiNnfDxaztxWzAzPZ8HKMvoI3uTbb68I6Z1n
 5T7M95LY1yoLM8Dj5fk4AnRykjOYcsikmFCEplvgpPX2i21+8aEwEC8iAAp52SvA
 a8QW9A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3y77c70v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 03:18:21 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e52306621so400688085a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 20:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787023101; x=1787627901;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nulXSaXrAlQIr1GDe4EmANgxiU9rNDcxA688/Kv27N4=;
 b=i8fHHtDJ8BuNW5GgZyfFKo1QTj4IBYbZ3Lymzi0j2CXacc76/TUanSo0NRKf9TGS+x
 vUTiKVApTE82ddh3vdmaNjFA/M0mjSWDasQadjAbz9sGfHIIprXLzqrcIZT2OVRQ/R8R
 6XIUcW9m0q1sMXViak0qwSWj0W6mXWDsv+NfanHGcflxNVXVTkFR4tGZ/wSymBLg530W
 DYsD1I8TKDOiNlyYpTik3ZWtjt1aDJE70sE/2n2vRlKQje6g3JoxK1RiupbWlYYqFqRy
 mvociTFp0FaMvJpHzdnZXRbFfj74KKqhb1YJDmYiNm9RTFqVfqoNCsF2cLQLQVJTYwUl
 L02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787023101; x=1787627901;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nulXSaXrAlQIr1GDe4EmANgxiU9rNDcxA688/Kv27N4=;
 b=sztTjABnrCVAckIDKLuNKEKNjdUIdfj/I4/qBeFkLfK6THnzHijl4pNmlzM/mWgDG6
 njfxM+2XagwcKq/yRQWRfKVCce57atQbYmdulxUGO+Tlzf8zhcVE9ps/rjg/tfbc0eag
 hsUISjKNUIwCB8Tmj1sEIIlFAHlMsNaANq+0JClkMmqBsohGwMLmtbHnkqLtElYs9vDB
 J420AM71KM1jF36cXyG0opC7bqqaeeRgu4mTtPnCjK4pcOpM76sOWr2etSywrFhboy8k
 GmVFiwsIitQlPsLsSeFJxX6oDtDHJkVzRD0WQts+lDzk76wFIoVGc+o00wKmPctEBFz+
 GX7g==
X-Forwarded-Encrypted: i=1;
 AHgh+RqfDG63w334cnCNhnLKk/UiJVSe5mJE4I7JKmLM1jz7oHLVCYdsZc4fH94QgczCEC/XBZ6owXEbYlI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwasoJES0+q6okEuAPGAm62bx6yLbMomXT20jmCslWqmXvCG546
 Pm95XdZRE1FTPWOUnSmj/zfF4ad8pdryCR+3hmyFxxXuI3tOyRD5z3lBTQ4Lo2cvV60zO9xhW2t
 +G5s1K3f0STO1npaylKbr7cXvYVXI/zlVwBcbxNp3pU8p22jG4jR5uf/eK08Sih7OkyyJ6us=
X-Gm-Gg: AR+sD12F1zXDWOiLdwWY2olzxw0VwbHikoTV+SNbw3IMZeq/gurn3WvOODFyFzgswEO
 zXkMJrTD37CvXRp2ClMBphG8BOZZ19qqp2Kwc7NBp/G9YKmXs6dypzof71CH9tFuSqRfYqIx9cA
 2VMp342ULIcAYrSGFAuGwBSinFySeId8/d9UAMDudhjNGWZuvuYwEjapv1jqJ4DjDq0n8AefIWA
 wsiVQRrOkEJ2FLNWONopc4bND27cJqcWJaz2CekhdoCG0C4uyIL8s/IsvifSO5mfwhx443eSTso
 VkbZWtL35J+IVABQXr3r4lqThsFSpayLMwyeQirBlup61xhS3ReNdS3BLiCbusyYk+Q6GO8pqSI
 MLeJsFRSOIbFbmwFmo9ZpeuD7inHtMr/KaX/8j69lsmfJqlK1f5xs8UtWy/CIGR3ZWWZaoCAleg
 8IaBWEzBdSSVJX
X-Received: by 2002:a05:620a:261c:b0:936:dbf1:f4bd with SMTP id
 af79cd13be357-93704beb3c5mr569257285a.47.1787023100501; 
 Mon, 17 Aug 2026 20:18:20 -0700 (PDT)
X-Received: by 2002:a05:620a:261c:b0:936:dbf1:f4bd with SMTP id
 af79cd13be357-93704beb3c5mr569251885a.47.1787023100020; 
 Mon, 17 Aug 2026 20:18:20 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b46cffeacfsm830534e87.54.2026.08.17.20.18.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 20:18:18 -0700 (PDT)
Date: Tue, 18 Aug 2026 06:18:16 +0300
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
Subject: Re: [PATCH 2/5] drm/bridge_connector: preserve connector status for
 IRQ-only HPD events
Message-ID: <vr7pqox5gusdyqd5jvmiu3gy7bbjm4znr3pcsivbe2loa46mff@t7atknofandt>
References: <20260629-msm-dp-msttypec-v1-0-646a10256233@oss.qualcomm.com>
 <20260629-msm-dp-msttypec-v1-2-646a10256233@oss.qualcomm.com>
 <famoeog5snpvj24b6izwox2gy74ywnwmybflfv2tvr4hjuix5q@cbtce5s7k7sv>
 <c36875c1-2d22-4c16-ac2f-4f4a947ed69c@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c36875c1-2d22-4c16-ac2f-4f4a947ed69c@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAyMyBTYWx0ZWRfX3Ht+jGsN0sEN
 xJIu77dgSx0RqF/iKfKgQ0OAxJhOCDe7f1HKY26xv+G7V5zpcFs7nMEjfgLw8MbAkaYK8/0rtJo
 JgYi8UH5K0DfcDMET+bkl4Ns1DG/eHQXBP7RIK3rcBVw4MJVyyJtMCjCsCuLItOW7Cv6Gz+OQUA
 WrI5Te0isC/FGym14WHA1VC6DKoEIlH+/GYdYFIJCNtzp4vhzic6JJdScrQ5juBlTb8EOz8/rBc
 XPTOjRxJ969peg9MVPXi+FqWQu9dHCdi0yK6lxXfwLKmoSy1mt+3oar7OitBZq+Lg8jh34lDwwY
 rP0zhb4o5p0QfHgp+tAU4fs3maUCFbnCj/gl6HxSlug4a9U6w+Z02sjwgyTvgF2GWh4DnslDBGk
 wPfzJU7aP9QQxplntUHgrbCUHVPWdWepE4qd+m2FyuwKtAVlvv0yWE5VSovvdEi8Uv8uB1zunee
 K4oPifT7vGbg23PZfkA==
X-Proofpoint-ORIG-GUID: PGcDEchjBBPjsUxb7k3AJUrtxK2WXg_w
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAyMyBTYWx0ZWRfX8wxHD2wHnKcG
 +cFSnBWj6hDY5yNnDA6KK7SGNJjcKuOBlTx05NpHxcmS9nrhDyzBvxnPE1np0L0IcNI2eouZsnc
 1oE58ghFzB38uJAlYKqdSuN/FGocyZE=
X-Proofpoint-GUID: PGcDEchjBBPjsUxb7k3AJUrtxK2WXg_w
X-Authority-Analysis: v=2.4 cv=WNhPmHsR c=1 sm=1 tr=0 ts=6a83cefd cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=JfrnYn6hAAAA:8
 a=EUspDBNiAAAA:8 a=TwwRWlU4pX-Acn9O6hYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 impostorscore=0 adultscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180023
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

On Mon, Aug 17, 2026 at 04:02:31PM +0800, Yongxing Mou wrote:
> 
> 
> On 7/12/2026 6:33 PM, Dmitry Baryshkov wrote:
> > On Mon, Jun 29, 2026 at 10:48:04PM +0800, Yongxing Mou wrote:
> > > The bridge connector HPD handling path currently updates
> > > connector->status for every hpd_notify() invocation.
> > > 
> > > This does not work well for IRQ-only notifications where the event being
> > > reported is carried by extra_status and no connector status transition is
> > > associated with it.
> > > 
> > > One example is DP MST. HPD IRQs are propagated through
> > > drm_bridge_hpd_notify_*() so that bridge drivers can process the
> > > notification. During MST operation, however, the SST connector attached
> > > to the bridge connector is intentionally kept disconnected while the MST
> > > topology manager handles all connector creation, removal and hotplug
> > > processing.
> > > 
> > > Updating connector->status for an IRQ-only MST notification may cause
> > > the SST connector state to oscillate between connected and disconnected
> > > depending on the notification path. These artificial state transitions
> > > can later be detected by the polling logic and result in unnecessary
> > > hotplug events being generated. Userspace then re-probes connector
> > > status, potentially triggering the same sequence again.
> > 
> > Then the API might need to be adjusted.
> > 
> > Remember, we have two usecases, which we must be able to interpret
> > correctly:
> > - The driver gets separate HPD and IRQ_HPD events.
> > - The driver gets HPD and IRQ_HPD at the same time.
> > 
> Ohh yes, here need to rework.
> > > 
> > > Treat notifications with status == connector_status_unknown and a valid
> > > extra_status as IRQ-only events. Forward the notification to bridge
> > > drivers without modifying connector->status.
> > > 
> > > This keeps IRQ delivery working while leaving connector state management
> > > to the component that actually owns it, such as the DP MST topology
> > > framework.
> > 
> > How is it handled by other drivers (i915, amd, nouveau)?
> > 
> i915, amdgpu, and nouveau don't go through the drm_bridge_hpd_notify()
> bridge chain -- their DP controllers are integrated into the SoC, and
> HPD interrupts are handled directly in their own encoder code.
> 
> MSM DP is different in that HPD comes from Type-C / pmic_glink altmode
> via aux-hpd-bridge, so it has to go through the bridge chain, which
> means this semantic needs to be extended to the bridge API.

Still, when do those drivers send the HPD event in case of IRQ_HPD? Or
is it that in their case IRQ_HPD just triggers inner logic to reread the
status registers and then the driver sends the HPD if there is any
actual change?

> > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > ---
> > >   drivers/gpu/drm/display/drm_bridge_connector.c | 12 ++++++++++++
> > >   1 file changed, 12 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
> > > index 5edca47a025f..7334d6677604 100644
> > > --- a/drivers/gpu/drm/display/drm_bridge_connector.c
> > > +++ b/drivers/gpu/drm/display/drm_bridge_connector.c
> > > @@ -163,6 +163,18 @@ static void drm_bridge_connector_handle_hpd(struct drm_bridge_connector *drm_bri
> > >   	struct drm_connector *connector = &drm_bridge_connector->base;
> > >   	struct drm_device *dev = connector->dev;
> > > +	/*
> > > +	 * IRQ-only notification: extra_status carries the event but
> > > +	 * status is unknown — do not overwrite connector->status.
> > 
> > But it's not unknown at this point. The connector status is reported
> > following the HPD status.
> > 
> You are right, in the SST case the bridge_connector status does follow
> HPD / link status -- because the bridge_connector itself represents
> that SST connector, so its status naturally is the link status.
> 
> The MST case has a key difference though: the SST connector must be
> explicitly marked disconnected (to prevent the DRM framework from
> enabling it), consistent with what i915, amdgpu and nouveau do. In
> other words, once MST is enabled, the SST connector that the
> bridge_connector represents no longer equates to the link status --
> the real link is managed by the MST topology, and the SST connector
> is just a placeholder at that point.

This is fine.

> 
> The issue is that IRQ_HPD still travels through the bridge_connector
> chain and takes the old "update the SST connector's status -> emit
> hotplug" path. Under MST that runs into two constraints -- and this
> is exactly what this series is trying to address:
> 
> 1. The SST connector represented by bridge_connector no longer stands
>    for the link, so its status must not be overwritten by IRQ_HPD
>    events.
> 2. IRQ_HPD needs a clean path that does not trigger a hotplug on the
>    bridge_connector -- the MST framework already manages hotplugs
>    independently.
> 
> Using connector_status_unknown as a sentinel here does feel a bit odd;
> let me think about whether there is a cleaner approach.

The status here must represent the status reported by the corresponding
layer: be it DP ALtMode, the dp-connector driver handling the HPD GPIO
or the DP driver itself handling the HPD pin via the state machine.

Is it still an issue if the bridge's hpd_notify() callback determines
that we should not be reporting the event and drops connector->status to
'disconnected' again? Why is it an issue? Should we instead filter the
HPD events in the drm_sysfs_connector_hotplug_event(), making sure that
we don't send duplicate disconnected events?

What is the expected behaviour of drm_client's?

> > > +	 */
> > > +	if (status == connector_status_unknown &&
> > > +	    extra_status != DRM_CONNECTOR_NO_EXTRA_STATUS) {
> > > +		drm_bridge_connector_hpd_notify(connector,
> > > +						connector->status,
> > > +						extra_status, NULL);
> > > +		return;
> > > +	}
> > > +
> > >   	mutex_lock(&dev->mode_config.mutex);
> > >   	connector->status = status;
> > >   	mutex_unlock(&dev->mode_config.mutex);
> > > 
> > > -- 
> > > 2.43.0
> > > 
> > 
> 
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

-- 
With best wishes
Dmitry
