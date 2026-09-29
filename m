Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E81CCCA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 21:05:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DD8D10F0E7;
	Tue, 29 Sep 2026 21:05:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="b2mhPUbg";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013050.outbound.protection.outlook.com
 [40.93.201.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EDAB10F0E7;
 Tue, 29 Sep 2026 21:05:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xSo5hXkS0uEWytslRZZNXRW7bGVtnW7tAS6zo7buP2c+duVF50N1/Hqp7oGbSokNz5v+dImq8HVhDuTVia1wbaLJMeT5jTgZ7OxIpwV8zQx9w8xbO930fGc5erXevDrRjd/+z+y/wlnQn3a8C0MS/QbnAa+IQAYJBKsB/50EF46ubLEdAzz3qZEBpNwrFcpOnMlBzEOvCmqztQlyqnFUFz0Sv4JpIndx7clXWJ/Nzj6j3fYacb2t/zv/HbxfNJQrvr9TvEF71ztuIgMyb0C1Q5Yn2b3cuxiPUk7pRRqHD71Ql/UO2mZMZkYFTJgTu5FRfMJ2wlI26j2fdiZe+lR54w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vb1TB2PYMFrr7rbptCKSe7zzawYmSC3BO89Ro+MC0c=;
 b=pBsw5yotzHgIro06CROSKK0kvXHliKbKA35FoPlt5VycXV5jiDH1z1rKxNrCvYfyQo5HSYerIVLg/xdFUGPqgDcanzvgSlx/Q+UNDNmulokfd82C8T2Rjv11cQrG+VzT/mCScbjYas3JbVAccn6mLAk+2Kag2LFuoPMExvHj2USAy4H38rrqOeJsxe88TgnYs15VjDpg7UodDidFXVFzdRM4h1MQEQ6KuGLotrdLK7hdTHqA85q0K6OzBnJQdL8OaVmJUTeWDJqqzhpW/BxiCM6F8qh5qE3JDpT0PVw00QaW3mnhqtGSbTWweILncfy1sMAr5cKyZj5CEjXEUxVrGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vb1TB2PYMFrr7rbptCKSe7zzawYmSC3BO89Ro+MC0c=;
 b=b2mhPUbg+37y/LpdPcYkfgnpyMq6071V6OyuwxL0riA3yTVii3sevW2FyyBUY7jXh906iHmeVV9hnCYR7x8kSGrwIdFioc/HXwDZ0LKoEUXTpcgjbXFI/m1WdV9xkgZrmXQoI6cxRTH+rsUqnCSvQr0c6yQqSXMQIYR5Qy9x5NFaku5paMWqFBi/d3mgeJKQYTnBjHHFbEgEF5r6jx7nkwXP2DsEwZNXsfJ955GW7crUebPECXkg7ps4XznDnF4omxnVZZqrZFSIXK4CPfu4fXh6XJ49zjnbqXbrM70mU4t3r2ulAQug+O3F0Kc+WMXf1zBobmKNEeAHkRNdS+ls5g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4925.namprd12.prod.outlook.com (2603:10b6:5:1b7::8) by
 LV2PR12MB5871.namprd12.prod.outlook.com (2603:10b6:408:174::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Tue, 29 Sep
 2026 21:05:39 +0000
Received: from DM6PR12MB4925.namprd12.prod.outlook.com
 ([fe80::9ac7:5274:235:5d72]) by DM6PR12MB4925.namprd12.prod.outlook.com
 ([fe80::9ac7:5274:235:5d72%4]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 21:05:37 +0000
Date: Tue, 29 Sep 2026 16:05:35 -0500 (CDT)
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
Subject: Re: [PATCH RFC 13/25] drm: Add VRR target frame rate properties
In-Reply-To: <mo2g3IAXRpOKy4yZocem9w@collabora.com>
Message-ID: <4380e0bd-d4c4-a247-7f7b-eba0288b390b@nvidia.com>
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
 <20260921-vrr-limiter-uapi-v1-13-2fcd7d011646@collabora.com>
 <1b722d71-93d2-93a4-acdd-bc02b9a36f95@nvidia.com>
 <mo2g3IAXRpOKy4yZocem9w@collabora.com>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: SN7PR04CA0203.namprd04.prod.outlook.com
 (2603:10b6:806:126::28) To DM6PR12MB4925.namprd12.prod.outlook.com
 (2603:10b6:5:1b7::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4925:EE_|LV2PR12MB5871:EE_
X-MS-Office365-Filtering-Correlation-Id: 3873aa89-7d2b-47af-3b04-08df1e6d6926
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|23010399003|1800799024|10067099003|56012099006|11063799006|4143699003|6133799003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: lNkkX7QTlYHK9TDPhDC2Q+yasxxYm8QDjcqwIXnaLOywND1ds8KNf6iG5+AO1SXNGo6UC6g7G+gcPd22RMQi7JARp7EB1Ha4TuqIJaEcdTbZqvdOxyCwLfCq1SShzw7UuEwNp01APL/k8Rks63XDm5cicvFYjxiwxRsWuDB0Xw7ywWvNv8sxYCsHrbHAovB4E3X2JVpV5qAr/IQ+6/p9S82O91M+yAHD9Pi5JH6mur6cYNXm7rSYPhb6Qsl5D/fg9AKCBmgVavFoi83b1OvI0xMkqfGNPC6ncJEow1081Dj8RkN0zkEoK3z2TlS/DO+dVim/ik4KkahW2xV4kQJmxmnXmc6+NFeZc/scf67TZ+/UPLmkFl/hJB8jY3Za5IugnyZ3vO3sbc4WJs/NigvQ7AiN08OzpjBU2OEvW99WzaNxRDcyi80NfLTnxaED2wM3Un03n1q/+8qHXxNxfuolJ/hUDB1QX3XMksvYhRiM8l+z7tuXeqCvHVJnhWmpPgmNN13fTfpTMFv3AirJQSWt+0KyEvqdSUWaB4XM5TiQjSKzuLEGjE2V7qFTJTPrz+IEBLyXMQq02/hgTgyi85YIAJbjcwFrBW1h8QKjECVJppl0Qi5niDMIPGiw/oX5ryciUCTalzi9++NC2021lnedVqO3CG2MpCSgz1ZujLJ8Abs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4925.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(4143699003)(6133799003)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nB2LN1W6tSRU6B9uxr/rQhTj4qBEDOgD0nBWfKIidtdaSbmx9HIPmlsfRuBT?=
 =?us-ascii?Q?O3SMbP+FflMMI9iCb/R5QfKFezavdb34svqGJuJvupFDp4/x1R0wPqUR8De8?=
 =?us-ascii?Q?2pXkJRFlr8jwIDLG5BS1IOmcaqiAkYtMWqs42WLUprghrjT50zbmqO4Fi+kf?=
 =?us-ascii?Q?UWFdFD/cfTQW1FfG2EOWRNasA8ExR5gywbsy7AJBq0+Cap/zE98d27YxZdPU?=
 =?us-ascii?Q?OIoqSE4Rf3WyGnBkzI3DzibVIuIVTNHi8IjiDfFUo1dIIer7mXmvVkmihCNb?=
 =?us-ascii?Q?lbTYe7qSnC49wtYEJz6NISBQqu7Wn3b8Rg/hjRYm2xFHqq6YN04nUoom5Dmi?=
 =?us-ascii?Q?VnaCR1bI47wDee+7MgQsIUGTJtWwjRKGVDHeAsvVCJMgKH1d4uEtikDrMWol?=
 =?us-ascii?Q?OSDSO6SgkH+Fq0ugpOZu+1DeHfUmL8Iy+XDXeCL5Ndn1a1pZU+clNDDXj1ZQ?=
 =?us-ascii?Q?sZmRo2FpFuyrjR/kJEc8b9+wk54DOakhJxXXc83OOxLIkYZaLE99nDk+2F5L?=
 =?us-ascii?Q?baQM+OT+R+eo6Unb/JDtlQvodekAqyqpWQyBGrARL5mgGvfwKXSAlL7EO1wF?=
 =?us-ascii?Q?QzMEYPIsGh5jMJ1th7H4Zsq3L9SqhFjtYmiMKin/HUFBMWJ0wiwtToweKETU?=
 =?us-ascii?Q?gqwO+6gx0WiRgR5Le0jyuTROXMVDNyJM8lVXx//7lb2eAtFkckAmLIszep5J?=
 =?us-ascii?Q?z6uOEMKgTiJ6PYyWnsVN+6UFChN0i3Ks7F7cfw8P9H6twj0xuRrwUDR9h49S?=
 =?us-ascii?Q?RFRzfvxB2Se4iHZFU0GgvnDw40r+c8o5BjOI9f8s/lm4zRFDOGMwDhxsRvKP?=
 =?us-ascii?Q?UegzGoZlXHdXVZ6YcgE0kyKBTppG9/K1aFJPuiud/+kwAMOtdvDhnJTsrwK8?=
 =?us-ascii?Q?wjBmKc5QbnTW0lOu3d1kEruPmQdTYgHh0Jxuz0G+0I3cg7hocl/W8gA5ErLr?=
 =?us-ascii?Q?5SwhGbKEIS0VC/mzdNm+jE5/vs2B58PAmuGD9fubgE7FcQ6BL4j85H8isvCH?=
 =?us-ascii?Q?1itJTkt40RWL9XGGnOhzJZFock7GuG94Zze8briDjjavo1i3rSUVG5QlGSzr?=
 =?us-ascii?Q?/VmRCemmWwALamS6wUEDgGB6jGT3RSBJzK17MykHb8S0Sc+V+d/mU0njbjmK?=
 =?us-ascii?Q?El4AQWnzi+tqIliq6i1Xwx5NQutXqJPXpU1Tc3dqHbXnmHwhnEBEdPQfqxTk?=
 =?us-ascii?Q?dZGFdslQM//Sh/eV6nqqIuyPoSAvVP1iIDfQER1BCS2ASmA5uVx1Om4CuVrH?=
 =?us-ascii?Q?KaROJg7hjLQiPwprt8YUSlOUHOiYOcPFwgRlIGErEhOr07+/VZD3KN5JMX87?=
 =?us-ascii?Q?1pM0UMIDTZdHHKCjDcAUHocXI7YQtuTC+sqX9XFvzjLOCkmIx6P4zUM2sf9q?=
 =?us-ascii?Q?VHOfwm239+kPwe5EIE22O/Xq1YMND/Gog+pBM96tFWgfIIj+ZMu97WCO2HS3?=
 =?us-ascii?Q?dqg2a0g3Z24/PVlsBK4JNRb/SSzaQAGwxDnjNxX4OOlrgLej1ym2Zlm2G6Tq?=
 =?us-ascii?Q?UKCivRGFnEYz0cGEyWtgjLtEqgSzs86DFfPhGqgyWD0LtL2UerfvbGwn566B?=
 =?us-ascii?Q?Y8glbBydZ3wXWsU9uekhMWljXxDNCgBb33QM1nCYa1jf6FldSBvRduBjGYXK?=
 =?us-ascii?Q?Fs0rh5D1CpmFmcMQwcgXIH4dB6a1QxHMcIUQdJiZuBcFCf/CJTCty6hET0i7?=
 =?us-ascii?Q?UWgS6+XjswwoWJ8Xq+ANte7SZc7lvwhS7FYsG4eqKxFjlBub?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3873aa89-7d2b-47af-3b04-08df1e6d6926
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4925.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 21:05:37.5859 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qr8OzOsJBjxClJQms8TJmqv1/65H3AUeo97GKJrxgdRKLV0Oi/jfZqd2cea4fYVM8EeZTyjOg3/UZZpENleh6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5871
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



On Tue, 29 Sep 2026, Nicolas Frattaroli wrote:

> On Tuesday, 29 September 2026 21:16:57 Central European Summer Time Vidith Madhu wrote:
> > 
> > On Mon, 21 Sep 2026, Nicolas Frattaroli wrote:
> > 
> > > Userspace may wish to set a target frame rate for the Variable Refresh
> > > Rate mechanism. There are multiple possible ways such a target could be
> > > communicated.
> > > 
> > > It's desirable for userspace to not only set a fixed target, but a
> > > target range within which VRR may operate. This is because even if a
> > > sink advertises a certain range as supported, said range may not be the
> > > ideal range to use, as numbers on the extreme end of the range may
> > > induce flickering or other glitches.
> > My understanding is that flicker may also happen if the refresh rate 
> > fluctuates significantly within the sinks' range, although I don't know 
> > how common this is in practice. I would imagine these frame range limits
> > would also be useful there to "dampen" the fluctuation.
> 
> Theoretically, the HDMI E-EDID extension does have a field to specify the
> maximum change in VRR per frame that's allowed without visual issues, but
> I'm not sure if any display sets this to a sensible value because such
> issues can range from the mentioned brightness inconsistencies to pictures
> that are positioned/scaled wrong in the vertical axis. In the absence of
> evidence that this flag is used usefully, I've not implemented it in my
> HDMI state helper implementation of VRR so far.
> 
> > In any case, if we expect userspace to use the frame range limits for the 
> > purpose of flicker avoidance, it may make sense to expose a read-only 
> > connector property for whether the display is susceptible to such
> > flickering. For example, NVIDIA G-SYNC monitors are resilient to this and
> > it would hinder the user experience to unnecessarily impose such a limit.
> 
> Short of keeping a whole quirks database, I don't think we can solve this
> generally. The idea I've been working off of is that the compositor has
> settings to explicitly specify such limits, much like e.g. KDE has a
> checkbox in the monitor settings right now to enable/disable VRR for a
> specific monitor, or weston.ini has an output config option. The user can
> then impose a limit if they do notice issues with their particular monitor
> in their particular use-case.
> 
> I can see adding an additional property to communicate a specific flavor
> of VRR implementation, especially if this is non-trivial for userspace
> to figure out otherwise, e.g. because some displays may use several and
> the driver picks the best one.
Right, this is what I had in mind. It would be nice if drivers at least 
had the ability to supply a hint on what the VRR policy should be to 
userspace.

Thanks,
Vidith
> 
> I do encourage additional fleshing out of the problem space we're trying
> to address here though, so if anyone or their loved one is entitled to
> compensation for the hurt caused by flickery VRR, I'd love to hear
> specifics. I have experienced it with dark gaming content on a
> ASUS ROG STRIX XG27AQDMG connected over DisplayPort to an AMD GPU. At the
> same time, I've yet to notice anything on that same monitor when
> displaying VRR content over HDMI from a RK3588 SBC, but that might be
> because SuperTuxKart happens to run too consistently frame-to-frame to
> trigger it.
> 
> Kind regards,
> Nicolas Frattaroli
> 
> > >
> > > There's four choices to how one bracketing value for the target range
> > > could be communicated:
> > > 1. Target frame rate in something like millihertz
> > > 2. Target frame period in something like usecs
> > > 3. Target vtotal value
> > > 4. Target frame rate as a fraction expressed by two integers
> > > 
> > > Choice 1 is unpleasant as it would introduce some amount of rounding to
> > > common broadcast framerates like 24/1.001, which seems minor except that
> > > exact matches to standard framerates would rely on making all userspace
> > > and kernel agree on a specific method of rounding. This is sure to go
> > > wrong, so is disqualified.
> > > 
> > > Choice 2 has the same problem as 1, with the added complication that
> > > the EDID's VRR range is expressed in frames per second, and other HDMI
> > > features express things in frames per second as well, which would
> > > require possibly imprecise computations.
> > > 
> > > Choice 3 is disqualified as mechanisms other than VRR, such as FVA, may
> > > also modify the vtotal value. Additionally, it has the same drawbacks of
> > > choice 2 and 1.
> > > 
> > > Choice 4 is therefore what's implemented. The frame rate 24/1.001Hz, for
> > > example, is expressed as nominator=24000 and denominator=1001. As there
> > > is both a minimum and a maximum, there are 4 properties in total: two
> > > numerators, and two denominators. A fixed rate with no variability is
> > > expressed by setting the minimum fractional and the maximum fractional
> > > properties to the same value.
> > > 
> > > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > > ---
> > >  drivers/gpu/drm/drm_atomic_uapi.c | 24 +++++++++++++++++++++
> > >  drivers/gpu/drm/drm_connector.c   | 45 +++++++++++++++++++++++++++++++++++++++
> > >  drivers/gpu/drm/drm_crtc.c        |  8 +++++++
> > >  drivers/gpu/drm/drm_mode_config.c | 20 +++++++++++++++++
> > >  include/drm/drm_crtc.h            |  4 ++++
> > >  include/drm/drm_mode_config.h     | 45 +++++++++++++++++++++++++++++++++++++++
> > >  6 files changed, 146 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
> > > index 1eebcf6f5e05..c9eb01d740b3 100644
> > > --- a/drivers/gpu/drm/drm_atomic_uapi.c
> > > +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> > > @@ -420,6 +420,22 @@ static int drm_atomic_crtc_set_property(struct drm_crtc *crtc,
> > >  		return ret;
> > >  	} else if (property == config->prop_vrr_enabled) {
> > >  		state->vrr_enabled = val;
> > > +	} else if (property == config->prop_vrr_min_numerator) {
> > > +		if (val > U32_MAX)
> > > +			return -EINVAL;
> > > +		state->vrr_state.vrr_min_n = val;
> > > +	} else if (property == config->prop_vrr_min_denominator) {
> > > +		if (val > U32_MAX)
> > > +			return -EINVAL;
> > > +		state->vrr_state.vrr_min_d = val;
> > > +	} else if (property == config->prop_vrr_max_numerator) {
> > > +		if (val > U32_MAX)
> > > +			return -EINVAL;
> > > +		state->vrr_state.vrr_max_n = val;
> > > +	} else if (property == config->prop_vrr_max_denominator) {
> > > +		if (val > U32_MAX)
> > > +			return -EINVAL;
> > > +		state->vrr_state.vrr_max_d = val;
> > >  	} else if (property == config->degamma_lut_property) {
> > >  		const size_t elem_size = sizeof(struct drm_color_lut);
> > >  		u64 lut_size;
> > > @@ -505,6 +521,14 @@ drm_atomic_crtc_get_property(struct drm_crtc *crtc,
> > >  		*val = (state->mode_blob) ? state->mode_blob->base.id : 0;
> > >  	else if (property == config->prop_vrr_enabled)
> > >  		*val = state->vrr_enabled;
> > > +	else if (property == config->prop_vrr_min_numerator)
> > > +		*val = state->vrr_state.vrr_min_n;
> > > +	else if (property == config->prop_vrr_min_denominator)
> > > +		*val = state->vrr_state.vrr_min_d;
> > > +	else if (property == config->prop_vrr_max_numerator)
> > > +		*val = state->vrr_state.vrr_max_n;
> > > +	else if (property == config->prop_vrr_max_denominator)
> > > +		*val = state->vrr_state.vrr_max_d;
> > >  	else if (property == config->degamma_lut_property)
> > >  		*val = (state->degamma_lut) ? state->degamma_lut->base.id : 0;
> > >  	else if (property == config->ctm_property)
> > > diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> > > index fc7d9fcf9d9f..5c07bd221977 100644
> > > --- a/drivers/gpu/drm/drm_connector.c
> > > +++ b/drivers/gpu/drm/drm_connector.c
> > > @@ -2579,6 +2579,51 @@ EXPORT_SYMBOL(drm_mode_create_scaling_mode_property);
> > >   *
> > >   *	The driver may place further restrictions within these minimum
> > >   *	and maximum bounds.
> > > + *
> > > + * VRR Limiter/Target Properties
> > > + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > + *
> > > + * The ``VRR_{MIN,MAX}_{NUMERATOR,DENOMINATOR}`` properties expose a mechanism
> > > + * through which userspace can control the desired range of refresh rates in
> > > + * which VRR is allowed to operate. Each rate is expressed as a
> > > + * numerator/denominator fraction of refresh rates in Hz, allowing for rational
> > > + * target rates like 24/1.001 Hz with no loss of precision or ambiguity.
> > > + *
> > > + * If the minimum and maximum rate are set to the same value (and not 0), they
> > > + * are understood as a fixed target rate. This is especially useful for media
> > > + * playback, where the content's frame rate is both constant and known in
> > > + * advance. In such cases, a refresh rate that is not an integer multiple of the
> > > + * content's frame rate will introduce judder, since not every frame is
> > > + * displayed for the same amount of time. A modeset of the display with a
> > > + * compatible rate may in those cases be either undesirable or impossible, but
> > > + * the rate can still effectively be reached through VRR.
> > > + *
> > > + * .. _VRR-MIN-NUMERATOR:
> > > + *
> > > + * "VRR_MIN_NUMERATOR":
> > > + *	Default &drm_crtc integer property forming the numerator of a
> > > + *	numerator/denominator pair of a frame rate to set as the minimum VRR
> > > + *	target rate. Set to 0 to disable.
> > > + *
> > > + * "VRR_MIN_DENOMINATOR":
> > > + *	Default &drm_crtc integer property forming the denominator of a
> > > + *	numerator/denominator pair of a frame rate to set as the minimum VRR
> > > + *	target rate. If :ref:`VRR_MIN_NUMERATOR <VRR-MIN-NUMERATOR>` is not
> > > + *	zero, it must be non-zero.
> > > + *	Otherwise, must also be zero.
> > > + *
> > > + * .. _VRR-MAX-NUMERATOR:
> > > + *
> > > + * "VRR_MAX_NUMERATOR":
> > > + *	Default &drm_crtc integer property forming the numerator of a
> > > + *	numerator/denominator pair of a frame rate to set as the maximum VRR
> > > + *	target rate. Set to 0 to disable.
> > > + *
> > > + * "VRR_MAX_DENOMINATOR":
> > > + *	Default &drm_crtc integer property forming the denominator of a
> > > + *	numerator/denominator pair of a frame rate to set as the maximum VRR
> > > + *	target rate. If :ref:`VRR_MAX_NUMERATOR <VRR-MAX-NUMERATOR>` is not
> > > + *	zero, it must be non-zero. Otherwise, must also be zero.
> > >   */
> > >  
> > >  /**
> > > diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
> > > index 63ead8ba6756..9244fbf97029 100644
> > > --- a/drivers/gpu/drm/drm_crtc.c
> > > +++ b/drivers/gpu/drm/drm_crtc.c
> > > @@ -322,6 +322,14 @@ static int __drm_crtc_init_with_planes(struct drm_device *dev, struct drm_crtc *
> > >  					   config->prop_out_fence_ptr, 0);
> > >  		drm_object_attach_property(&crtc->base,
> > >  					   config->prop_vrr_enabled, 0);
> > > +		drm_object_attach_property(&crtc->base,
> > > +					   config->prop_vrr_min_numerator, 0);
> > > +		drm_object_attach_property(&crtc->base,
> > > +					   config->prop_vrr_min_denominator, 0);
> > > +		drm_object_attach_property(&crtc->base,
> > > +					   config->prop_vrr_max_numerator, 0);
> > > +		drm_object_attach_property(&crtc->base,
> > > +					   config->prop_vrr_max_denominator, 0);
> > >  	}
> > >  
> > >  	return 0;
> > > diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
> > > index 48a56f23dadb..da967d60f832 100644
> > > --- a/drivers/gpu/drm/drm_mode_config.c
> > > +++ b/drivers/gpu/drm/drm_mode_config.c
> > > @@ -535,6 +535,26 @@ static int drm_mode_create_standard_properties(struct drm_device *dev)
> > >  		return -ENOMEM;
> > >  	dev->mode_config.prop_vrr_enabled = prop;
> > >  
> > > +	prop = drm_property_create_range(dev, 0, "VRR_MIN_NUMERATOR", 0, U32_MAX);
> > > +	if (!prop)
> > > +		return -ENOMEM;
> > > +	dev->mode_config.prop_vrr_min_numerator = prop;
> > > +
> > > +	prop = drm_property_create_range(dev, 0, "VRR_MIN_DENOMINATOR", 0, U32_MAX);
> > > +	if (!prop)
> > > +		return -ENOMEM;
> > > +	dev->mode_config.prop_vrr_min_denominator = prop;
> > > +
> > > +	prop = drm_property_create_range(dev, 0, "VRR_MAX_NUMERATOR", 0, U32_MAX);
> > > +	if (!prop)
> > > +		return -ENOMEM;
> > > +	dev->mode_config.prop_vrr_max_numerator = prop;
> > > +
> > > +	prop = drm_property_create_range(dev, 0, "VRR_MAX_DENOMINATOR", 0, U32_MAX);
> > > +	if (!prop)
> > > +		return -ENOMEM;
> > > +	dev->mode_config.prop_vrr_max_denominator = prop;
> > > +
> > >  	prop = drm_property_create(dev,
> > >  			DRM_MODE_PROP_BLOB,
> > >  			"DEGAMMA_LUT", 0);
> > > diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
> > > index 9d58158af459..df37f4ebb58e 100644
> > > --- a/include/drm/drm_crtc.h
> > > +++ b/include/drm/drm_crtc.h
> > > @@ -67,6 +67,10 @@ struct drm_crtc_vrr_state {
> > >  	u8 vic;
> > >  	u16 cur_vtotal;
> > >  	u16 max_vtotal;
> > > +	u32 vrr_min_n;
> > > +	u32 vrr_min_d;
> > > +	u32 vrr_max_n;
> > > +	u32 vrr_max_d;
> > >  	u16 base_vtotal;
> > >  	bool dynamic;
> > >  };
> > > diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
> > > index 084517beb924..c8d5286f9267 100644
> > > --- a/include/drm/drm_mode_config.h
> > > +++ b/include/drm/drm_mode_config.h
> > > @@ -702,6 +702,51 @@ struct drm_mode_config {
> > >  	 */
> > >  	struct drm_property *prop_vrr_enabled;
> > >  
> > > +	/**
> > > +	 * @prop_vrr_min_numerator: Default atomic CRTC property to indicate the
> > > +	 * numerator of a numerator/denominator variable refresh rate minimum
> > > +	 * target frame rate.
> > > +	 *
> > > +	 * If not zero, @prop_vrr_min_numerator divided by
> > > +	 * @prop_vrr_min_denominator must result in a frame rate above the
> > > +	 * sink's minimum VRR rate.
> > > +	 */
> > > +	struct drm_property *prop_vrr_min_numerator;
> > > +
> > > +	/**
> > > +	 * @prop_vrr_min_denominator: Default atomic CRTC property to indicate
> > > +	 * the denominator of a numerator/denominator variable refresh rate
> > > +	 * minimum target frame rate.
> > > +	 *
> > > +	 * If @prop_vrr_min_numerator is set, @prop_vrr_min_denominator must not
> > > +	 * be 0, and @prop_vrr_min_numerator divided by @prop_vrr_min_denominator
> > > +	 * must result in a frame rate above the minimum VRR rate.
> > > +	 */
> > > +	struct drm_property *prop_vrr_min_denominator;
> > > +
> > > +	/**
> > > +	 * @prop_vrr_max_numerator: Default atomic CRTC property to indicate the
> > > +	 * numerator of a numerator/denominator variable refresh rate maximum
> > > +	 * target frame rate range.
> > > +	 *
> > > +	 * The fraction expressed by this property divided by its corresponding
> > > +	 * denominator must be equal to or greater than the value of
> > > +	 * @prop_vrr_min_numerator.
> > > +	 */
> > > +	struct drm_property *prop_vrr_max_numerator;
> > > +
> > > +	/**
> > > +	 * @prop_vrr_max_denominator: Default atomic CRTC property to indicate
> > > +	 * the denominator of a numerator/denominator variable refresh rate
> > > +	 * maximum target frame rate range.
> > > +	 *
> > > +	 * If @prop_vrr_max_numerator is set, @prop_vrr_max_denominator must not
> > > +	 * be 0, and @prop_vrr_max_numerator divided by @prop_vrr_max_denominator
> > > +	 * must result in a frame rate equal to or above @prop_vrr_min_numerator
> > > +	 * divided by @prop_vrr_min_denominator.
> > > +	 */
> > > +	struct drm_property *prop_vrr_max_denominator;
> > > +
> > >  	/**
> > >  	 * @dvi_i_subconnector_property: Optional DVI-I property to
> > >  	 * differentiate between analog or digital mode.
> > > 
> > 
> 
> 
> 
> 
> 
