Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2D1C9832A
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 14:35:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DC6610E0F4;
	Tue, 29 Sep 2026 14:35:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NV/6KskU";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011008.outbound.protection.outlook.com
 [40.93.194.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B615810E0F4;
 Tue, 29 Sep 2026 14:35:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dy+ICAngjBRs2dIcl4Qk6fqROZTzux9GxJgspRf/At5AGooszQflklcXG92B0xksXx7+pXNpnKWPv02AqD5fcJaBccPsfc85OdcPngOModkx/p7psed/ugOewQBUN6rfSBI5J1LXLYvzaU+llZSBZDNYAqQlSd3IP3R6EWIhCsEeJHN79jl+gI1cdplcuAB+S8Tj9YtYc4/2hKYSrk6Y5W7um5gmbOAT6StcAOqdao8EDnJOJ/kuU0mFw0SLDlFTzNNoMCtaRpE8asAnhUJxi0RvswuSeVrzMeavNwHZZRsqy7nLDQ8f4cYp+pvntZKjKY68Eyrchl5NoH8oxyXGCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJ3zBmAAYumqBWtZ5z5TrPexjuJJueU1AW0zWeQGirI=;
 b=sIkgsO1M9JvSxABSUWNVSJakcaFvmdSsI6OuPTFj3+a3mWOxIy1vfKnlKbmxcKnqISctqnRHah6womD2IHVt06t+LSZiHS2IilhX6tElKjM/g9pBxFr/M6kCl/FoxiVma4XyRJeGj1oljTmCC6kn1tApvPNSV6ubmPkFUwd8s0AysFs1tNcOzlFhHOrE05dVcNaq7Z7kZrxzXu+4SMU4m6MQEk++Fq6fdz3+vYJBYmV9a7dX98Xrdef8ADzliuXDA5XqzOUfoDs0qa5NRzKXLQ6uTTJNfyeFOKVU2DevTyVwkFM3owk3otOyr0Ig4Xif5A+kmrUBM3dilurklgFiOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=mailbox.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJ3zBmAAYumqBWtZ5z5TrPexjuJJueU1AW0zWeQGirI=;
 b=NV/6KskUG0/yuojxcIRr61uTnSbBW1g4W+hIqw3qu6jWSrRibt0MOWO2Fi4x97LmRTlTanYOaYyGc3RzgW8BpAJfUDM6BmhpxcQUhBwJ86S1FDNhuCP58ZebnQr5llXQCb1zZmYVHll09VUrrejwpPCL943JRKbTaHF90g/EJqU=
Received: from BYAPR21CA0004.namprd21.prod.outlook.com (2603:10b6:a03:114::14)
 by BN7PPFEE0F400A9.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6e9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 14:35:14 +0000
Received: from SJ1PEPF00002323.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::3) by BYAPR21CA0004.outlook.office365.com
 (2603:10b6:a03:114::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 29
 Sep 2026 14:35:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002323.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 14:35:12 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 09:35:01 -0500
Received: from [10.254.92.188] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 29 Sep 2026 09:34:58 -0500
Message-ID: <164d00c2-e4cb-4962-8e4e-389ae77af943@amd.com>
Date: Tue, 29 Sep 2026 10:34:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 13/25] drm: Add VRR target frame rate properties
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>, Nicolas
 Frattaroli <nicolas.frattaroli@collabora.com>, "Borah, Chaitanya Kumar"
 <chaitanya.kumar.borah@intel.com>, Daniel Stone <daniels@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Helge Deller
 <deller@gmx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Andy Yan
 <andy.yan@rock-chips.com>, Xaver Hugl <xaver.hugl@gmail.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-fbdev@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
 <linux-arm-kernel@lists.infradead.org>, <kernel@collabora.com>, Derek Foreman
 <derek.foreman@collabora.com>, <wayland-devel@lists.freedesktop.org>
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
 <20260921-vrr-limiter-uapi-v1-13-2fcd7d011646@collabora.com>
 <0226527e-ee38-40ab-a2a8-1ae62013b950@amd.com>
 <VERVf-aJRRKsBOI_3dpScg@collabora.com>
 <8a3b2902-3255-4dd9-82f0-75a7747b710e@amd.com>
 <3cf7143d-7013-4a3b-a831-96c3f125c2f6@mailbox.org>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <3cf7143d-7013-4a3b-a831-96c3f125c2f6@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002323:EE_|BN7PPFEE0F400A9:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a219bd1-c51e-4d58-85b2-08df1e36df0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|1800799024|7416014|376014|42112799006|11063799006|10067099003|921020|6133799003|56012099006|18002099003|22082099003|4143699003|13003099007;
X-Microsoft-Antispam-Message-Info: GAVbmH6O41RdShvxcuU7nOi8PlOlaYcuEbMIGfgqibxYalFVe3A2FP+aZqa+TmtOgMPj8JD3RK9ME+9RSSGsHB6ZHfMrD2t+JySBf27oadSQPJSohBWeDP5WCG7sTqihXtyY72nPDj7BLWKFLt4I9ITldIsgHK+vzmHM6QQSc9KXIC0rqLayCbE2+sDyjU7o8SxIIKti0j0b1UA+HcYF+2OvG3bHU+k9EgudG9KEOMla46YVH40IUY/vrPOIAYzoX8kYYAq+rVvNjQOuYRT6JtICp2ZTCcU1cw+mDDl1BP43ncC44Sbmv9LhK6iuMsm1/z01CPjmSdnskg/1mTbKcMIuUjEgiic2oHJl6o9iqD/Tcq046y4Y1/v3NAPM9ZlD2BkWOAig+X9r37FbHM+nUF8chinMG/D7hcZhVcyJyLr73m1o9FLofjX2WIwHoRIDQcI03CFI194XpVZD5FBR7mMPvMuQUqAAqXtVnkHkaQcb+XXVUoq4ZoleLhe1UtmAyLraz3jbKZUHz0IUm3VnnFryXKmEYwAft8XKr33H1XsPfBVVTHXTPMQo6mKC98PW2M10mUCmeHoQrsG2ou8Gnm+am/9LGWzOBPVbRVXbb3QlEc1MMk+Yg/rvBce0R7qVeduH0pwGp2CBYfIedAjoRN6dyGoxra7CSV3IInAIUTAPlQma0GYVGZS84ysEsNn3
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(7416014)(376014)(42112799006)(11063799006)(10067099003)(921020)(6133799003)(56012099006)(18002099003)(22082099003)(4143699003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rh5edO2ljQR3ttOp5ZQ5/OiRc2u5UXvuTM4WHZ8YDIrkmIXWUU5E5BArxxJ4r35Mj/HaK4N3a9pYjaVZKOE1tBdROfJBfJwm0l8J8UN66mtkm9qTrzkhHS8mvu3O0Oa3zGsez3rhX7oizmcfEebSp7xvkoWEt9+7fsRaDyUoSut66jK6GLMVji8NGK+6z9YwLT7iDl61Q8vFjGnXLgFmFlwO5ZOHSrumfGJSsqjD429BizlLr+hFBuHY01rDveGKgAfVKiA17dEZT1VpDZgeaVA8Qx9gd89skOHK1Nrsl/AT8l80Cv5Z8FbCeKLggIZ5qBJSO6mK7hgsMkN5Y8tEZikLc0ESdERl5BIxkhCU14uR+HvxhIn/AFC31r4jmD/58+n4rt0mo37xtnaXNbVXHaR6tqIxit5ZJuWMAvM1W9j1UFpjOxZBQwoKOtCKcQHJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 14:35:12.8005 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a219bd1-c51e-4d58-85b2-08df1e36df0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002323.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFEE0F400A9
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



On 2026-09-28 04:10, Michel Dänzer wrote:
>>> You can picture VRR limiting as always being active, but with a limit rational
>>> of 0 it uses the display's limit as per the EDID, which is what unlimited game
>>> mode is. So with how it's implemented right now in hdmi_validate_vrr(), your
>>> example would set a maximum target, but leave the minimum at whatever the
>>> display defaults to.
>>>
>>> Now that I'm thinking through this, a possible problem is that
>>> drm_crtc_helper_vrr_is_fixed_rate() operates on the user supplied limits, but
>>> if the display supplied lower limit is equal to the user supplied upper limit,
>>> then we have a fixed rate scenario without recognising it as such. I think I
>>> need to have a ponder on what the least surprising behaviour for userspace
>>> is in that instance. The display limit stuff gets a bit complex due to
>>> CinemaVRR and QMS TFRmin/TFRmax.
>>>
>>> I'll improve the documentation on the next revision to make the meanings more
>>> explicit.
>> Perhaps a simple way is to require simultaneous setting MIN and MAX pairs?
>> IOW, require userspace to set MIN and MAX simultaneously to >0, or =0. For example:
>>
>> if ((vrr_min_n == 0 || vrr_min_d == 0 ||
>>      vrr_max_n == 0 || vrr_max_d == 0) &&
>>     (vrr_min_n > 0 || vrr_max_n > 0))
>> 	return -EINVAL;
>> That way, it's never ambiguous what userspace has requested for the range.
>> They can copy the EDID supported range if they don't care about limiting one side, rather than leaving it at 0.
> Determining the actual limits can be non-trivial (though I guess that might be fine as long as libdisplay-info can work them out), if user space gets them wrong, it might accidentally apply a narrower limit than intended.
> 
> 
>> It's then also clear if they requested a static Hz.
> I do see the benefit of your suggestion for this though.

Xaver and I were chatting about this at XDC, and yeah it'll be difficult to match KMD's monitor range, especially if KMD decides to patch it with quirks and whatnot.

Since we are handing compositors control over vrr range, does it sound sensible to expose KMD's monitor range as a read-only property pair on the drm connector? We probably don't need a num/den pair for it, it's not like panels advertise fractional VRR ranges (right?).

Fun fact: vrr_range is exposed today over debugfs for IGT testing
https://elixir.bootlin.com/linux/v7.3-rc5/source/drivers/gpu/drm/drm_debugfs.c#L586

Thanks,
Leo

> 
> 
> -- Earthling Michel Dänzer \ GNOME / Xwayland / Mesa developer https://redhat.com \ Libre software enthusiast

