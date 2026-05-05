Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4DB9CD342C
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 00:45:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BAF610E025;
	Tue,  5 May 2026 00:45:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oxhvehG6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EAMEYHMB";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B2D810E025
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 00:45:09 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644It46E635993
 for <dri-devel@lists.freedesktop.org>; Tue, 5 May 2026 00:45:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=eignGx7fjusmcXSJihfEr7oP
 7drwG9sN6dcSfX4AaRM=; b=oxhvehG6tytp3ZNyHh/gRhnPbZw+SQZnQLCMlx/K
 oCNkZ1kd5jHpoqEi2sYGsZBovFKweRs6TabXCamJ3SvMzj+SOI0TrxeYtH+ITokf
 AI3qOhOi2z6kbsg0R+Lj40uIzjCLhVPUKh39UjdAqcId6rRWgotq381p0YiTdlWa
 aYfgABgUxNQM+R3LXCFSXmAiM57LF/iFurQ2ruCW0K+mU9HLjwNPGku2Qij5NELs
 /pPCzz8RKiQ7a1EtB4UWeyVAt50IdY8k5HxaV5uZzPFQ5IpbOkPdYayqoJP3Q11T
 a8X1tlyVnbY8RJJkLKPH47UGlHwObP5wGIuPEPf4VRBT2g==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxsx4aqnp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 00:45:08 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8baa173eacbso2748816d6.0
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 17:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777941908; x=1778546708;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eignGx7fjusmcXSJihfEr7oP7drwG9sN6dcSfX4AaRM=;
 b=EAMEYHMB6umcaZUkW8xdmMbTLaLUDbdQLoDSpxWS2VoP/BcbVvrsbVMmHxWtjwo2BW
 FDJ8bDp7NQPOlP17NMuyn3SdqG4lXlctn4J83zmIhpPbGyK10j8yBdvdFMSBW1Fp5Xv5
 J6YhtPtzcKCddLEnl1bDwqzyUk8BUhedrVmdgOHrsPmOQvqvszeBh6qgCHHzoegPc6mK
 oULz7/u6Wyme39aTrwqE6Ho5A6Ji6dJZ+pNk7IPod+Rwa5hs1BDxbj027cL2BJswH47N
 dgClNW02zLA9cZs/YUfZyNX+/hBywjbHGNF9KpZTUwfbZz7dIbI/qgnwqja8pbKjm96Y
 0Dcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777941908; x=1778546708;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eignGx7fjusmcXSJihfEr7oP7drwG9sN6dcSfX4AaRM=;
 b=fPtrpE/YyO3Oc7HA6HLdYcsXu2UlDbIdS5H3Pl/txw7muiakia9BXnWqf7Tq55mPjX
 wRl+GEnFMRBxvuOdjYnTA5BjL4r/m7Mb7kg1aVua1158TbBl/0TPFS5lPaPpeNl7uleP
 p4oqiEdQShAcY+2yD6PAOuWFlVnCEjzMqKe1PqpgmigMSyeLV/55vfba9dV/hMTtTc1C
 UoRg/wAAtEWM1ehOOxGKUmJo+Hj+hj2eVgzUrb5d+QTqQ1EYdLjEs2HK03QVmXqBC7o6
 +cymQ+SAGC8ZnhFRnUoPIp00xoGt6Nn1LS2tK9RcN9UABCzGQkCR51+6HQB5/zXLphE0
 Im9Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8B+j167TWryXbJtMSlsT4lNyVJN4NeRes241IFbGVsO3Ew2v4apzp3pbIVHV8BZdUiUwtMtx7nY04=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyRTianv2ZA0KyefPJOaLCmuZtX7WwdnVQgtQo3Du/32LWjcHHy
 iBY1Yw2ihvUiIxv0jx9JfZgiJUBG1f3JNRwHCsDfIaMYcfKCC6fTvt4Phkyr/O3XzIab7gDy48L
 GzdiHpcIaKZQUyH9eMMduoJPPXCRztS8wV+nmXOEBqDFOK6FrLEe9HjmULtUVMAzFchN799o=
X-Gm-Gg: AeBDievmXVVEF9+A2l1wqPz0z5bOJ0T+rGLB3LIj0DHG4ubM0JxQ8ytU3tm317o38Yx
 L2KKQLmgBQu4QIFOl31ect7WpQxa3oZoP2L2osxRUMJygfkwVUM7Q3QkZs6djwRnaobwpZXdEb/
 NTlq4XqzVjpD0tF3hTWeZC0n/WuiATuqvx2vcC5jXoxHF3Z1+fPHtuKxhTd13xTxY/whW1Hr5/+
 115wqIbb3F9ZnulSVeZgKNp09sLS0i8A0ICqmh+6Xb9V2GZ1kbTei0h/eQfxyhgmwfFHzrE3n2O
 BvbDxLZ1k30PtGSN+4sdR6cxDlkZDOqJdgjS4nDzgg2wGEQViuCqHQuTU0BYpPb0ub5DFJxIdnr
 NrIe/2bdWYICOuQOgmrBMZL0r/CMImZ6qtSgajiF/Nl2gsb4VinCtmS0UKtsoD3C99epSRMMspi
 j/q72N1zgYi3dupZl6neGs2dSecFVXYupqR37ggCYha2R2EA==
X-Received: by 2002:a05:622a:244e:b0:50d:6baa:9e8c with SMTP id
 d75a77b69052e-5130695b1cemr15249881cf.12.1777941907623; 
 Mon, 04 May 2026 17:45:07 -0700 (PDT)
X-Received: by 2002:a05:622a:244e:b0:50d:6baa:9e8c with SMTP id
 d75a77b69052e-5130695b1cemr15249611cf.12.1777941907177; 
 Mon, 04 May 2026 17:45:07 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a85c230e16sm3444610e87.30.2026.05.04.17.45.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 17:45:04 -0700 (PDT)
Date: Tue, 5 May 2026 03:45:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sandy Huang <hjc@rock-chips.com>,
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 Diederik de Haas <diederik@cknow-tech.com>,
 Maud Spierings <maud_spierings@hotmail.com>
Subject: Re: [PATCH v5 05/10] drm/bridge: dw-hdmi-qp: Add HDMI 2.0 SCDC
 scrambling and high TMDS clock ratio support
Message-ID: <b25unnbxzzpmi3sr4dwpmq2tofriczjshmq2o67xwqsfuh3elr@gdtornkrplol>
References: <20260426-dw-hdmi-qp-scramb-v5-0-d778e70c317b@collabora.com>
 <20260426-dw-hdmi-qp-scramb-v5-5-d778e70c317b@collabora.com>
 <m5fxlfktxtvki5yaxhkx4h3hsjj5266stwvfdykhqkgcjbz5bk@s5gggcd45abm>
 <539f1bb9-6509-40c7-8692-bb3cdee33f91@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <539f1bb9-6509-40c7-8692-bb3cdee33f91@collabora.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDAwNCBTYWx0ZWRfX24ZWUdJEDLUv
 muh6lwyUW2bCRuH13v1uGTB88fVPV1gj+LCjOS2Shlt8RVyK9aare0SH3ZSdXpXJbOs+eX4VtYk
 WjvRLUh1jnPu4oVKLBygGZt+xDgjuqr8icXGTn+1H2zjIe2gdWPCYdXYjPV9Wz+4NXRiSKubEdt
 tZM0GUu2Q1e1Xde5xEG7QbUpxxcVzicuM1DYkF1hk3OEwWnbrYURwSN1A6ZqsgakTLSNjQlfSwF
 U65jYrq802wm7L08cUMtGUC5q4v7cfcsyzyIsccJBNgGWFJc1f/co0yuwU7H8ntKKzxrh9p97a2
 GvMUK0pjySl8ysc5HTxtHqGMitfhyjQiHzGasjmfOcGOTWcxDERLJ60dPYeDetrzEyQwkCrgx00
 A7PIsG5Syh3Im+57EdUx6doDQJEtTYxpExdapSPDaJYLZkmQppQkav/ATIvFHepRF48VDiuN/a6
 jXWspL5zJ5sxao9hong==
X-Proofpoint-ORIG-GUID: 6qUTQnwefXuxkQxwxyz2MQi1_2GiADck
X-Proofpoint-GUID: 6qUTQnwefXuxkQxwxyz2MQi1_2GiADck
X-Authority-Analysis: v=2.4 cv=LdIMLDfi c=1 sm=1 tr=0 ts=69f93d94 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=MTERcTr8AAAA:8
 a=69EAbJreAAAA:8 a=QX4gbG5DAAAA:8 a=v_zPfFD72SJ5nyloC-oA:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=1w2Y23rLpnaGpkO2nlKf:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605050004
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

On Tue, Apr 28, 2026 at 04:51:46PM +0300, Cristian Ciocaltea wrote:
> Hi Dmitry,
> 
> Thanks for taking the time to review the series!
> 
> On 4/28/26 4:38 AM, Dmitry Baryshkov wrote:
> > On Sun, Apr 26, 2026 at 03:20:17AM +0300, Cristian Ciocaltea wrote:
> >> Enable HDMI 2.0 display modes (e.g. 4K@60Hz) by adding SCDC management
> >> for the high TMDS clock ratio and scrambling, required when the TMDS
> >> character rate exceeds the 340 MHz HDMI 1.4b limit.
> >>
> >> A periodic work item monitors the sink's scrambling status to recover
> >> from sink-side resets.  On hotplug detect, if SCDC scrambling state is
> >> out of sync with the driver, trigger a CRTC reset to re-establish the
> >> link.
> >>
> >> Reject modes requiring TMDS rates above 600 MHz, as those fall in the
> >> HDMI 2.1 FRL domain which is not supported. In no_hpd configurations,
> >> further restrict to 340 MHz since SCDC requires a connected sink.
> >>
> >> Tested-by: Diederik de Haas <diederik@cknow-tech.com>
> >> Tested-by: Maud Spierings <maud_spierings@hotmail.com>
> >> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> >> ---
> >>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 188 ++++++++++++++++++++++++---
> >>  1 file changed, 172 insertions(+), 16 deletions(-)
> > 
> > My main issue with this patch (sorry) is that this adds yet another copy
> > of SCDC-related helpers into the driver which already OP_HDMI and other
> > helpers.
> > 

> 
> >> +
> >> +	drm_atomic_helper_connector_hdmi_hotplug(connector,
> >> +						 connector_status_connected);
> > 
> > I don't see a forced hotplug event in the existing drivers. Why is it
> > necessary? This function is being called from the detect() path.
> 
> For some reason, without it, the connector seems to lose its state after reset:
> 
> [ 2142.982967] dwhdmiqp-rockchip fde80000.hdmi: resetting crtc
> [ 2142.994132] rockchip-drm display-subsystem: [drm] HDMI Sink doesn't support RGB, something's wrong.
> [ 2143.140827] dwhdmiqp-rockchip fde80000.hdmi: dw_hdmi_qp_bridge_atomic_enable mode=DVI
> 
> Will recheck if that's still the case after the HPD handling rework.

I think so. If it doesn't help, please check that
drm_bridge_connector_detect() is called for each hotplug event from the
hardware. It should take care of parsing EDID (and thus updating HDMI
Sink properties).

-- 
With best wishes
Dmitry
