Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A92BDCC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:52:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0365810F540;
	Tue, 13 Oct 2026 07:51:55 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC0EE10F540
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 07:51:43 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D21JY24072150
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 07:51:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=2e0hEvdU8b8VrnJnCx9DHHAI
 iFUZiYK3o3ou5ROhbTI=; b=IMSdstEk9C7fgUIBCRRMTC8AKGYIHkhw1+ksTJOv
 1xAVpTwk8ypXQCinfCkzKpAWKSf2Hl/CJM6Traomk+keHHaEymGGukXeBEJbQd1b
 Zj+i9Bgdhnly5F4cpvXsc+3lJSne7PHNgdGkQNjyeycWf/hCWnyb0jP3gxTCR2aC
 EOqmQhiEkUxSGZjN4f4M1aNughBK96tzuaI9CUPTv27jIKwZdA/O9E8lHdnmJFS5
 OAbyYsyPSNwX2O2e6nl5/Zdcgr/CiZ7EuMEmRNBDV4ptXRliXFz1OmAe+ewtvRyJ
 J6wm7P9/Ytx/lVWRt7NuGNguRBJh7b/+5iK64S2v7N7Vig==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h92jjucxs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 07:51:42 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cc359d9easo454572985a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 00:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791877902; x=1792482702;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2e0hEvdU8b8VrnJnCx9DHHAIiFUZiYK3o3ou5ROhbTI=;
 b=Ma78FsygZ5lxIJKaGheIeZ5w9XftZhV0uZHvqabUcGrDD9TpPDElPMbooG/iRQxVM0
 gla1fBsHPhE2vDOI3eLQevrk8q1xArutZlRqEFtTrrUG5Q4EtBBC6JVWINMw52xMHyYk
 nQczy5HecVXmAFQc7MLQmqSWeNb25NS6gFK7BcTD+yc1NVlFxI1UCwqyfFPLlycETVsn
 5lw/UCGKNL/Ioq/ZB0mCWKJQ4J4+LW0ISG3JOK3o2qg+TdcLnYd0OyJix2eJimJC3DcF
 +AauVCa8hXnUrMqvXxNlzRB/S4/k2I4IPbJrZ/ZQK66gBvdjtSLawHJ4HLUzwSCxXqI0
 nQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791877902; x=1792482702;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2e0hEvdU8b8VrnJnCx9DHHAIiFUZiYK3o3ou5ROhbTI=;
 b=XZ+TmhUQJBpXdolSQZrZldq47+VhvNI5D5KlLult5YARzMiFhCF2q/DKDkd0bVJhfI
 Mmr/xzoMn6G1510kpGmcqTaxLkpXe4cL/l5fNMivsK6TfH4NiSYo+hV4gAvddGsnOaQZ
 6520vIbhXB059OAtwdnOWks00vPnsMq0KW+Seuo3SJqMzgWqdJkBWPkFrpkaLXpQ433D
 Ik5fVQU4rIQC7lpH4ckoKasdQiKA6rY8PDT50xOe/YpXSxdC/FiVsB6XNWiyAWflhUKs
 fUuZe6SN0oPpBPGEaqMkpgrBbUYzdZOPREDAnOE+MTk5KHb+sYQx0vF29md0e2ZO5WxJ
 AKrw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx7LKKba0DVyy9RA+pSKQ201s94qwLBrb0SXmFsxy6mLOBkK0A16FfWU9nRtbLGD5JgI1ERw7w3+Gk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLt8MJfk1KFRbC/MHMVHrVGLErQG6w3XiAz9F8W14aVSyoPEzqx
 aj/0HlyzaM0eh2jiFU4OvLfmp+A6NoRgUmfmD1i5IP7BD0t2n1xgr2c1I8BIKGJFV/bvoGxtDGa
 PG2CBkC6lYNpxSmckYuwMI3b3M+vj9K5JWpmu6xjyJqZpMd1sKxjYEc+X7L05s+9gs8E4cx0=
X-Gm-Gg: AYBFou1uhUWj9t/sjkJcyW2Y1rRjGYXB4sKTFErY5OjmiGYDs51HuTob+ue4xf+Yrzk
 uvbg12C92gcd4OakdDlxUGETKS0V07ukv0Ux56D2tFd5EWfqTUN5psx1xbtr8IJCzOGOPikGRuW
 sCxu2z2nrt7RNNa7Gb+cXe+qXTxTc10Ocsctesp5j08SnFjUYjdEU6/+ArgMfECGtN4Gb7oeY6D
 vC7xOS1Opza6OiyfFYOiK/kZeipnDMws3OgJZn+Ywi+I7pmr/Ydydyd+Lq2S2o88K+SeRdhN6XN
 6M7KReBfcPwpGxkITiiNRPIRZnHkxcnSMO6u/y5YdRZq3E8hRG0qCrEKIAZ9aKtOTmawGwsxQDA
 WzVsVFoDARUAfBvoxmJPA2kBNivWNGURIqy9zQ3VReSyU2uYmJH1LPoFAOXSbqDawUYEFYclNVS
 UabPFeO/B6dj5s
X-Received: by 2002:a05:620a:271a:b0:93e:48fc:aa85 with SMTP id
 af79cd13be357-93ebd2598c1mr1901244385a.43.1791877901711; 
 Tue, 13 Oct 2026 00:51:41 -0700 (PDT)
X-Received: by 2002:a05:620a:271a:b0:93e:48fc:aa85 with SMTP id
 af79cd13be357-93ebd2598c1mr1901240985a.43.1791877901188; 
 Tue, 13 Oct 2026 00:51:41 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bcdde91281sm3367573e87.19.2026.10.13.00.51.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 00:51:39 -0700 (PDT)
Date: Tue, 13 Oct 2026 10:51:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Konrad Dybcio <konradybcio@kernel.org>, Val Packett <val@packett.cool>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC 0/9] drm/panel: add atomic state
Message-ID: <7pptulwzceqg7xozps5boncgcpd5fpw2pdabcslp4den34ixjn@rzgkoe36itwm>
References: <20261008-panel-atomic-state-v1-0-b157fddb8de1@oss.qualcomm.com>
 <asyAObcpbFy3OeE2@houat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asyAObcpbFy3OeE2@houat>
X-Proofpoint-GUID: hNpdmH1OPAi0Q0SlTk2Z5LErI9dsXeqp
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAzMSBTYWx0ZWRfXyjUQ9VS9wY1v
 Ae+hz6QRlhtM0TqBVykd3uGGYjKAiZVi8191bRuYaQ+3yiNhKpKvWC++yrb2f6jtrL+KmtFX0Mx
 FRqHT1Id+jPFEdTg1rfHsJGvHVJxxBM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAzMSBTYWx0ZWRfX5xSOe5DHjtfv
 C3dzGZ3dUlxb0UMktMDLqAyjTKLW/Lwj5mDbGPISF0zw4Ha6nNeVFLUwDsPQFEO3SccedZbz63P
 v7TdIFIdtVA7u4WJQ5YyLqLNb9iAKalypIxmMhpad0Mzk2rTWngyLy0zCEQ20cTD7pWMYWBCBZ/
 Pt3Lwn9IvjBWOoLsA7YqggWs5s7TdHJhyPeE+kPPERqo7TaW0x3gSnj++fqVVmucFrbe8rm/ISx
 rLUgKimNTRuiHCUQDPMC9Vd0h0wcCLpRa8cjWS9jEVJL0odyDpim61y2TC44iG9xYz4RlPcNy/h
 opIzWM3xhGK0KeHZ6FaoGzMM3rwir4nGfaqBa1GscwOf04XCN2w1usOcrqy94x/q4JMJM8r5iFd
 Z2kHMb9H9jzPasVcysNLLWyfAMzw3SdeOW5egNQIDKEeuUYFP6/F83GyrPIpNSS5iQ3AbSzcFlf
 jVyslSOiL1HHRJ4dr5A==
X-Authority-Analysis: v=2.4 cv=GfKCDgXL c=1 sm=1 tr=0 ts=6acde30e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=1JtaHRqB5YIky_o9nyUA:9
 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: hNpdmH1OPAi0Q0SlTk2Z5LErI9dsXeqp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 spamscore=0 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130031
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

On Mon, Oct 12, 2026 at 08:40:33AM +0200, Maxime Ripard wrote:
> On Thu, Oct 08, 2026 at 04:14:22PM +0300, Dmitry Baryshkov wrote:
> > Panel drivers don't have an atomic state and so they can't handle
> > additional data to be stored at the atomic_check time or to be retrieved
> > at the enable/disable time. For example, it prevents panel drivers from
> > supporting multiple display modes or making DSC being optional in a
> > clean way. Drivers like panel-novatek-nt35950, save the connector
> > pointer in get_modes() and later dereference
> > connector->state->crtc->state from prepare() without holding any locks.
> > The panels also have no way to reject the configuration they cann't
> > handle, as it doesn't take part in the atomic check.
> > 
> > The panel already embeds a drm_bridge, and the bridge has an atomic
> > state which is property handled. Subclass it to provide atomic state for
> > the panels. The callbacks can find the state of the other related
> > objects (e.g. CRTC state to get the display mode).
> > 
> > The atomic state is opt-in. A panel that doesn't implement the state
> > callbacks keeps working exactly as before, with the plain bridge state,
> > so there is no need to touch the existing drivers. The panels which do
> > implement them can only be driven through the embedded bridge, since
> > there is no commit to hand over when the host calls drm_panel_prepare()
> > and friends directly. Those entry points warn and refuse to handle such
> > panels. There are still a dozen of display drivers calling these
> > functions, and the panels used with them can not be converted until the
> > hosts are switched to the panel bridge.
> 
> I really don't think we should extend the panel API. All panels are
> bridges now, consumers only care about bridges as well, and the bridges
> API provides what you want already.
> 
> Why not simply turn the panel drivers we want into bridges, possibly
> with a bunch of specialized helpers to manage a panel state, and call it
> a day?

I think that panels provide good abstraction on top of the drm_bridge.
For example, bridges don't have orientation, panels do. Also panels have
followers, while bridges do not. I don't think that either of those APIs
make sense for bridge. Last, but not least, we have drivers that were
not converted to the bridged approach (*). As such I think we should
evolve the drm_panel, extending it to support atomic state.

(*) git grep points out the following direct users of drm_panel API:

drivers/gpu/drm/bridge/analogix/analogix-anx6345.c:		drm_panel_enable(anx6345->panel);
drivers/gpu/drm/bridge/ssd2825.c:		drm_panel_enable(priv->output.panel);
drivers/gpu/drm/exynos/exynos_drm_dpi.c:		drm_panel_enable(ctx->panel);
drivers/gpu/drm/logicvc/logicvc_interface.c:		drm_panel_enable(interface->drm_panel);
drivers/gpu/drm/panel/panel-sitronix-st7703.c:	drm_panel_enable(&ctx->panel);
drivers/gpu/drm/rockchip/rockchip_lvds.c:	drm_panel_enable(lvds->panel);
drivers/gpu/drm/rockchip/rockchip_lvds.c:	drm_panel_enable(lvds->panel);
drivers/gpu/drm/sti/sti_dvo.c:	drm_panel_enable(dvo->panel);
drivers/gpu/drm/stm/lvds.c:		drm_panel_enable(lvds->panel);
drivers/gpu/drm/sun4i/sun4i_lvds.c:		drm_panel_enable(lvds->panel);
drivers/gpu/drm/sun4i/sun4i_rgb.c:		drm_panel_enable(rgb->panel);
drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c:		drm_panel_enable(dsi->panel);
drivers/gpu/drm/tegra/dsi.c:		drm_panel_enable(output->panel);
drivers/gpu/drm/tegra/sor.c:		drm_panel_enable(output->panel);

-- 
With best wishes
Dmitry
