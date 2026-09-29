Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F11BCA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 18:55:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E22EE10E1E3;
	Tue, 29 Sep 2026 18:55:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="IOQ7MxPB";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010025.outbound.protection.outlook.com [52.101.85.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 341EA10E1E3;
 Tue, 29 Sep 2026 18:55:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CcISuY1t2yqwVynMpusv6Sqszojw01bTo9O+eaxlYIYGFomfvIowtMZYDM12Wr11iyjOFspgBuk+BfUmWxmPHyCr9fX8D4dPtA7B18SECepHSrVPYcPlCOtGyYZvZJoj8aNqMiP6uuc0jvWZr4dgEjODfT+zQOUMqIpYt2X2LhypdQoTFb9dL41po+KCJ/7/DOYXIbekT3qOozed/GQK8Jo9vYmMQxOul6Uinyrgh9P9/Zuqq24lxFukC+GdC4LGyO45tsxk8M28Ku5m+RvPpLRUype3yZ3eWKnvUVwWsgjWornlXcl0Dx49TfC7IfFy6YQeHYYQ2G+IBFQr5QkXPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjKJSuoTM5b4dr07nc4WuyEmLr4CSPQderQexY8bCkE=;
 b=NqhbvEeYW5uO8OKNS1cTWdLzxucE6OaP281W6kDexig+Q4jEYcsn/Ll3BKaQPc5ssRujvhai2FwpPyhPOx4VonZS8PvAJ2uygKKk59WeA8X3JPkK3zD59Bld8dRahbhycCyRuVS859XUpOi/DhGZgzkMFtZhk6Txku0hjd3d+dZdvF0ol0VhzTkn1DX/UWD08LYA6/1nx8++kAJVQ19tDuCD7YQPepe6DhuD+RIC6tJSRhI2ZeeDud0dJ6iIAtRHHXxKBqk5V7OEQ13dXOsng6lHye/yijwN4oNANsePgYwQafdNs0QQguSZyZX/6iPG0tTv5iFn5P6YEWcwDSJZKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjKJSuoTM5b4dr07nc4WuyEmLr4CSPQderQexY8bCkE=;
 b=IOQ7MxPBo7AC6BBmrZZPY11v9J24T/HmaQQuubH4v1rUg0qH5rzpHiA9+zfPE4YWiK1tcrtcT7y6Z1ggt3rtZvOuUbBOeoof99eLaiXqE39AeJ8G/dyZJXBOHW3vYbPc45p3oiuvt1KHeNNSNYqeqHXn4KZVvgvgtVrCuDCHt9aeZmJ9GY72i8PdhGrHuDd1XVCVilZgcR1Kj+u+cFGTYKUr+PGiOT1H5Um+9O4KeifWg0YlC7yNon4KMtC13FiyHC50EP7dGcb7Up+wa4WjqNQVLpk5c200VIlky0EOpTTA9apsk5pjend4o+c9gzckRRaxwIJpBS9IcN9fItzrtQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4925.namprd12.prod.outlook.com (2603:10b6:5:1b7::8) by
 DS6PR12MB765380.namprd12.prod.outlook.com (2603:10b6:8:411::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 29 Sep
 2026 18:55:20 +0000
Received: from DM6PR12MB4925.namprd12.prod.outlook.com
 ([fe80::9ac7:5274:235:5d72]) by DM6PR12MB4925.namprd12.prod.outlook.com
 ([fe80::9ac7:5274:235:5d72%4]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 18:55:20 +0000
Date: Tue, 29 Sep 2026 13:55:18 -0500 (CDT)
From: Vidith Madhu <vmadhu@nvidia.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
cc: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>, 
 Leo Li <sunpeng.li@amd.com>, Daniel Stone <daniels@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?ISO-8859-15?Q?Heiko_St=FCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 kernel@collabora.com, Derek Foreman <derek.foreman@collabora.com>, 
 wayland-devel@lists.freedesktop.org
Subject: Re: [PATCH RFC 06/25] drm/connector: hdmi: Add VTEM EMP generation
In-Reply-To: <FJ8OpdCORV2b1oivG9-G9Q@collabora.com>
Message-ID: <9dccf035-2806-7b92-ce17-00f95bcf773a@nvidia.com>
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
 <20260921-vrr-limiter-uapi-v1-6-2fcd7d011646@collabora.com>
 <a5bc012a-9b9e-eb2b-d67e-a91f2d93d6bf@nvidia.com>
 <FJ8OpdCORV2b1oivG9-G9Q@collabora.com>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: SA1P222CA0005.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::32) To DM6PR12MB4925.namprd12.prod.outlook.com
 (2603:10b6:5:1b7::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4925:EE_|DS6PR12MB765380:EE_
X-MS-Office365-Filtering-Correlation-Id: 24c371db-506e-4a83-a3c8-08df1e5b35cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|1800799024|376014|366016|4143699003|10067099003|5023799004|11063799006|56012099006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: XxKnSOCwfH5viXMu+X0MqnUzd9qWG3w/CaF2oyijhSA53Rc8tBbg72ciwN4VJN7JeaAY4zpVzoEoqF3MDARkJAftJYdG5hzIl4f50Kh20NjkOhZwk3uJQIaeF8j9dO6S4eTcg3jX4r5MRc+NXsqGKpsWvOHnafZHK1F8icuFKOJo0PJg+tTTxjexs/mhDBBORhoKf6TeK9zCDmgOMxGuws+Ru9clr0Qx3d0Q2gedkbBrS2Q2Xsrcnc6YyOqlOH7rIRXwhkNwfw/nZvTM0Wk4Ej7XMKeui0KullQ0myCRFKfVeJU9w/DP1xYsq+FG9tQPWlH3Gjqbvo3WqOfRU5TZL6eECyBqVSXWp+44GEuJM1oweuU7PCNnTNLyaul6pmW2K8+Uei+FEk/1tNI2k0GHe6EGj/WH7Q4HtH+N+IuYOoGzQ+893NRvb7JKpneEBIkEfOSlaO2C01tjmkfrQN4z31kbQDVmU7uYMAmTOK8M//2Ws+kXEvLs9zThUUFsoWwGOdxXHP6aXbyzVK5UJ4uxUJhj7q1axCUQcWnvgzdWLw1+hYEJG3cpVku6WmkrGjik1SQac2c8mIjXyrcFXbcdTbSD0Tjl/OlQQ1h/3gOztnKx9Y++xneMMZ6j83JJwJ9UOtl+K4ohHs+4bDodTW6F7lQLfNO+ZmZW6TSU0uwGS0Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4925.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(1800799024)(376014)(366016)(4143699003)(10067099003)(5023799004)(11063799006)(56012099006)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kBqb/LEXzU/V7EIJXRy9Kq7vhsFhl5i1YBEyJ9Ak8WxT4NzHhW9/ZGwny3ts?=
 =?us-ascii?Q?i+GqG8+vLy16zAmoiHODqMUH+Wj+cKeZmoRMf2/B7PBdyJXElN7CeYrbgJdL?=
 =?us-ascii?Q?PrhdLa6xVW6AzqbpodQvCxKXEJ1j1Sd0JwvWAhj8PnkHeWaVx+2sP78z6MpV?=
 =?us-ascii?Q?s3MuHYf9jAJXQb7ssKrfQQR+9RMcEEeHt84+OFOm8DQb0kwznY9uD5WEygq9?=
 =?us-ascii?Q?0SMECXtjle8LshSMwfEfw+BX+1qy8XAZY/ndOdeakHDxDOUVOuVeJKUbaY41?=
 =?us-ascii?Q?z0MjLyzFVe9iJBMXYnEwFpQT3afxDnTbIlHLM7FNp0Alw21OxekM/0w5yMs4?=
 =?us-ascii?Q?kFHbjlZhM3k/uTte+EDMti4m5mcn3Z09sO3/vYeMn5QJvE7/4lQYxG3DKPuM?=
 =?us-ascii?Q?K9M0T/s1nsgWr3z4q4/oe5/Kq4CY5m0Q585P89VEbOwz+eE7cHbGZjabjP9A?=
 =?us-ascii?Q?Fk2mHNtDwNhMVtV2xZyEQLLzjnlqwcAwfelNFy5/oriCP9M9DU+S61LekvUH?=
 =?us-ascii?Q?SqCnLbQYZW0p9WzU+ULFMuia1CCiQFgB+icgg9LKbCj0tsJXMGaznmwKFN9K?=
 =?us-ascii?Q?4ji0T6Px1fe4V3xMjaRFefIWxNVS9d4HbxbJWI1igYfPn9/N3FEQfsWz/5tE?=
 =?us-ascii?Q?0v6xbs0f2Ye9q8qS895D6qpEuEYrJ7w43njX7G25YR7wdxRqSFFZx7s9mYrv?=
 =?us-ascii?Q?W16+qfAw+dhbj3Ki5TcQCbfkRAQszGRjtzeyZR9aNsyNI3T8raldTc1aQxHk?=
 =?us-ascii?Q?fFLBuwPR6KqN0sdmrAr/97k5r2dX1tiygb+HsHvrEPv/3M4J04fnpjr3kPbO?=
 =?us-ascii?Q?ebyFv0UUKOFGqlz+b5snb1L73m87zpaV6Q0uQ7TaFsCQP9i4P/tt/52dtB0I?=
 =?us-ascii?Q?EPnx8cvLh0dv+cmMqdpOr3ruwFdy5eHSsIWBRrYP+xJtL95vunyLCfQvmV4F?=
 =?us-ascii?Q?Zcb2S++qqJE5EJHK3MM7KoNiTZlUnh6sWz1z7HGfLh8DEJ/F3fmpbE8M23G9?=
 =?us-ascii?Q?AbLmn7/OC51hCyxyQBfcrpHH2Tor36XIZK80NT2eL3xh2LgN4aWHc8WZzAO2?=
 =?us-ascii?Q?+KCucPB84k80lVmTEUpNPl4KGXA90MW4cdUA1/JjExZjJOfur78kEBMZh3K4?=
 =?us-ascii?Q?VXw8RpaVUE4WqRuL5Ozkh/Q166CRDCcX3JdYyVDVQj/Q8AdYTx9ntrztl47L?=
 =?us-ascii?Q?kmAeNkXcJvb3wQqqjRHNrGpXGVEM0JVNCfOJ4R2BGlQiWW8saVYtUpSst5Ly?=
 =?us-ascii?Q?DpMPomoBUUWFgfp+FUTMWZNqz9zark+98DgiK/dw516YDHmucw6Ad/jpbEKq?=
 =?us-ascii?Q?yVKwR/+N5mjbg9u5JeaLko+2VwO7vuxp+iCfrJjXsxWLscuqTnQWLqr81Wnx?=
 =?us-ascii?Q?8T1LCtgtlhRxs1ikUo9GEhnYSEiaDgnvx2dR4G8IEZXDkXlrBBBLwuSHyQsh?=
 =?us-ascii?Q?dfRlgVe3Wq3hlAZrPpK/Rg9gaeh/emVl0r4oi50gP3eGGbMewDUHathjpea0?=
 =?us-ascii?Q?m9bA6J2l+ZYxrjjLhqinQ+ObQpc2Ys/V85swpnA+ex39Cxkk7SyhuA0tGqaw?=
 =?us-ascii?Q?SZ/eMRLo67WdACK8pVgRsGHBDpZ1txhvOXr+P/ZGysw0ufp4ad14Zyg7pKmK?=
 =?us-ascii?Q?UuCbcvOQRwX2njrhrRM5xUiJ8+yEFyYSIDOplEY/0VN1Z2hUJcImjHX3wGZF?=
 =?us-ascii?Q?Em2hlYN8YQmWOfr6LIZba0uZ7TcQ0aFSuolQ04t3G2k2oP9T?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c371db-506e-4a83-a3c8-08df1e5b35cc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4925.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 18:55:20.5092 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ck5mGjGg3gIOiBRu2cbKxqxJnoJISanoZBJr1bADJK4MFj0YPQ+hfKi3FRpdzPg3JRTIg3cOtp2g6Snigrfow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB765380
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



On Sat, 26 Sep 2026, Nicolas Frattaroli wrote:

> On Friday, 25 September 2026 05:48:54 Central European Summer Time Vidith Madhu wrote:
> > 
> > On Mon, 21 Sep 2026, Nicolas Frattaroli wrote:
> > 
> > > From: Derek Foreman <derek.foreman@collabora.com>
> > > 
> > > Add VTEM EMP generation to enable variable refresh rate signalling over
> > > HDMI.
> > > 
> > > These infoframes are only generated if the sink supports VRR.
> > > 
> > > Signed-off-by: Derek Foreman <derek.foreman@collabora.com>
> > > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > > ---
> > >  drivers/gpu/drm/display/drm_hdmi_state_helper.c | 60 +++++++++++++++++++++++++
> > >  include/drm/drm_connector.h                     |  5 +++
> > >  2 files changed, 65 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> > > index d55548399687..33d0c9491643 100644
> > > --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> > > +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> > > @@ -853,6 +853,56 @@ static int hdmi_generate_hdmi_vendor_infoframe(const struct drm_connector *conne
> > >  	return 0;
> > >  }
> > >  
> > > +static int hdmi_generate_emp_infoframe_vtem(const struct drm_connector *connector,
> > > +					    struct drm_connector_state *conn_state)
> > > +{
> > > +	const struct drm_display_info *info = &connector->display_info;
> > > +	const struct drm_crtc_state *crtc_state =
> > > +		drm_atomic_get_crtc_state(conn_state->state, conn_state->crtc);
> > > +	struct drm_connector_hdmi_infoframe *infoframe =
> > > +		&conn_state->hdmi.infoframes.vtem;
> > > +	struct hdmi_emp_infoframe_vtem *vtem =
> > > +		&infoframe->data.vtem;
> > > +	const struct drm_crtc_vrr_state *vrr = &crtc_state->vrr_state;
> > > +	int vfront;
> > > +
> > > +	infoframe->set = false;
> > > +
> > > +	if (!connector->hdmi.funcs->vtem.write_infoframe)
> > > +		return 0;
> > > +
> > > +	if (!info->hdmi.vrr_capable)
> > > +		return 0;
> > > +
> > > +	hdmi_emp_infoframe_vtem_init(vtem);
> > > +	if (!crtc_state->vrr_enabled || vrr->vic) {
> > > +		vtem->base_refresh_rate = 0;
> > > +		vtem->base_vfront = 0;
> > It shouldn't hurt to always populate base_refresh_rate and base_vfront, 
> > might be cleaner to skip this check.
> 
> Hm, I thought they had to be blank when the vic was non-zero. If that's more
> of a "they can be blank" then yeah I'm fine with skipping it. But that makes
> me question the purpose of vrr->vic, which is then no longer needed as it's
> not used anywhere else.
That's how I interpreted what's written in the HDMI spec - populating 
these fields is only required in the VRR_EN=1 case, there is nothing 
stated for VRR_EN=0. And, for VRR_EN=1 + (VIC != 0 or RID != 0), it is 
explicitly stated the source may choose whether to populate them.
> 
> > > +	} else {
> > > +		vtem->base_refresh_rate = drm_mode_vrefresh(&crtc_state->mode);
> > > +		vfront = crtc_state->adjusted_mode.crtc_vsync_start -
> > > +			 crtc_state->adjusted_mode.crtc_vdisplay;
> > > +		if (vfront > U8_MAX || vfront < 0)
> > > +			return -EINVAL;
> > > +
> > > +		vtem->base_vfront = vfront;
> > > +	}
> > > +	vtem->fva_factor_m1 = 0;
> > > +	infoframe->set = true;
> > > +
> > > +	if (!crtc_state->vrr_enabled) {
> > I don't think we should use the vrr_enabled CRTC property to determine 
> > VRR_EN in the VTEM EMP. Transitioning the VRR mode sink-side typically causes
> > blanking, and it was discussed in patch [03/25] that drivers should be 
> > free to handle vrr_enabled changes as a seamless switch since it only 
> > concerns source-side VRR state (this is how the NVIDIA driver handles it).
> 
> I'll be honest, this is the first time I've thought about the VRR state
> communicated from userspace to kernel to be different to the VRR state
> communicated from kernel to display.
> 
> > Maybe it would make sense to extend the qms_enabled connector property 
> > introduced in this patchset to an enum of {Off, Gaming, QMS}? This would allow
> > a standard path to control the VRR state on the sink, separately from
> > vrr_enabled.
> 
> An earlier version of the patch series I was working on internally had a
> VRR limiter property that would either be Off (i.e. Game), Game-Limited,
> QMS-Limited, and it self-inflicted some amount of confusion because of
> the way things were named, so I refactored it to the limiter values being
> what determines whether a limiter is used, and the QMS enable to determine
> whether QMS is used to apply said limit. So my initial reaction is to be
> hesitant about expanding the collection of possible states exposed through
> the uAPI.
> 
> To help my understanding: what does
> 
>  vrr_enabled=true
>  $new_property=Off
> 
> mean for presentation?
In this case, it should be acceptable to disable VRR on both the source 
and sink and effectively ignore vrr_enabled=true. From reading
https://elixir.bootlin.com/linux/v7.2.8/source/drivers/gpu/drm/drm_connector.c#L2370
vrr_enabled is essentially a hint and there is no need to reject commits 
because of its value (at least, that is how we handle it in the NVIDIA 
driver).
> Another state I'm curious about is
> 
>  vrr_enabled=false
>  $new_property=Game
> 
> which I assume is the case you're interested in, where the compositor does
> not want VRR presentation but we're keeping the sink in Game mode to avoid
> having the display go blank.
That's right, in this case VRR is enabled on the sink but deactivated 
source-side. For NVIDIA, there is a distinct HW "deactivated" state of 
VRR, but we could achieve the same result by setting the frame range 
limits to a fixed value as you suggested.
> 
> is that correct, and something that does need an expanded property? I feel
> like userspace could be smart enough to do that by keeping vrr_enabled=true
> and then setting a fixed target, if the goal is to have non-VRR but with the
> display still in VRR mode.
I agree, I am a little concerned though about the transition period for 
compositors to adopt this new model. I know for example KDE is using the 
vrr_enabled property for their "AdaptiveSync" option, and it seems like it 
would be a regression if all of a sudden toggling it caused display 
blanking on newer kernels.
If we're going to move towards this model, it may make sense to deprecate 
the current vrr_enabled property and create a new one for connectors 
rather than CRTCs (e.g. functionally similar to qms_enabled). This new 
vrr_enabled property would then be used for the sink-side VRR mode 
signalling. We could map it as follows:

qms_enabled=true, vrr_enabled={true, false} --> QMS-VRR
qms_enabled=false, vrr_enabled=true         --> Gaming-VRR
qms_enabled=false, vrr_enabled=false        --> Off

The semantics of the old vrr_enabled property would be implied by the 
settings of vrr_{min_n, min_d, max_n, max_d} (e.g. if max=0, no VRR, else 
hint the driver to use VRR).

Thanks,
Vidith
> 
> Kind regards,
> Nicolas Frattaroli
> 
> > > +		vtem->m_const = false;
> > > +		vtem->game_vrr_en = false;
> > > +		return 0;
> > > +	}
> > > +
> > > +	vtem->game_vrr_en = true;
> > > +
> > > +	vtem->m_const = !vrr->dynamic;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  static int
> > >  hdmi_generate_infoframes(const struct drm_connector *connector,
> > >  			 struct drm_connector_state *conn_state)
> > > @@ -884,6 +934,10 @@ hdmi_generate_infoframes(const struct drm_connector *connector,
> > >  	if (ret)
> > >  		return ret;
> > >  
> > > +	ret = hdmi_generate_emp_infoframe_vtem(connector, conn_state);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > >  	return 0;
> > >  }
> > >  
> > > @@ -1494,6 +1548,12 @@ int drm_atomic_helper_connector_hdmi_update_infoframes(struct drm_connector *con
> > >  			goto out;
> > >  	}
> > >  
> > > +	if (info->hdmi.vrr_capable)
> > > +		ret = write_or_clear_infoframe(connector,
> > > +					&funcs->vtem, "VTEM",
> > > +					&old_conn_state->hdmi.infoframes.vtem,
> > > +					&new_conn_state->hdmi.infoframes.vtem);
> > > +
> > >  out:
> > >  	mutex_unlock(&connector->hdmi.infoframes.lock);
> > >  	return ret;
> > > diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> > > index e561a444515f..6e431eb81705 100644
> > > --- a/include/drm/drm_connector.h
> > > +++ b/include/drm/drm_connector.h
> > > @@ -1180,6 +1180,11 @@ struct drm_connector_hdmi_state {
> > >  		 * matching our state.
> > >  		 */
> > >  		struct drm_connector_hdmi_infoframe hdmi;
> > > +
> > > +		/**
> > > +		 * @vtem: VTEM EMP infoframes structure matching our state.
> > > +		 */
> > > +		struct drm_connector_hdmi_infoframe vtem;
> > >  	} infoframes;
> > >  
> > >  	/**
> > > 
> > 
> 
> 
> 
> 
> 
