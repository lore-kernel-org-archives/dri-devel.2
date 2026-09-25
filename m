Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 724C9C98321
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 18:42:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A51DB10FBDC;
	Fri, 25 Sep 2026 18:42:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qnlffLAE";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012043.outbound.protection.outlook.com
 [40.107.200.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB73D10FBDC;
 Fri, 25 Sep 2026 18:42:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ye7prbYyACZ7WV/j8xgF4NgDZN/W5KrwcPAfEMlrHGTt8LY+5UKJAsX/4YF0rF2OZLxvCA3c59CTGHJRb0LKKUSK2czP9GHpNn7LPAQEyGn1AGQZQLubw9XYV0+3nLFqrFWbEGYXpXoQJ2NtFNjtrZNdhiI0ViSjswdWhjA4DhakSZ5w9YdsArj5jBqm93MBconTgACYaP0IsN0861rSeNUYN6Sp07J9hqLlE8n27R8UJXfW+EHMLMvBWO02QGfJ9H8n39AJRiWCOFe9+QZcEhr5OYEj94+pmPEFeFNOqgu6aLoaUCje7gMnFySqzCnhk9Ue6nqkFNUOT8g3H7jeNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOfpGmVAQ40dh+pQHepJXK/c9qXJ2THWPTvOZ/CTwew=;
 b=dAEp5RbrpPVPWZ26lDjmhVwk0or1O5/dYjYIse39kqiyoCgZEW5QvdzdIED6KY5I0PB9Q5DYikSIJrCA3yrP86Lyzi354ooprk7kDxcxV3F3Ah8766hkYPFMcm4AsPirbQVuzNLH+ahikf+/A033GvBRbQ0xJnn4r4Etj7LHBMUf/1ZBCn+bnoKb2g4y6o8FUAcVaOHCDzfx/uCU9+AI9iFiv1fN/AA15p4A4C0sV08N9O87tpiQrQMvVZOsuLK7pJjwOKOb6sO7/OzIDIcCaVPD8DeWGrf6wOpNT+6YWDssEpM4iaZYYSkRg2V21Ankt5+ljmYSwdIX1VdJViqUOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=collabora.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOfpGmVAQ40dh+pQHepJXK/c9qXJ2THWPTvOZ/CTwew=;
 b=qnlffLAEep3mw5W5tcEvn1aLIj8wAFF1WPLmcAfA4cTfgXe7TbcC86TuBk+Y7H1wFgqPLUjoxSKwqD2mKO8gdh3nHgIx9hlKwa6Cz4K9+QJPVyemCzR73GHWjB7/wEIIMtkTi9fOFWA5W+Jf+wHY34BGXdQf0s2CmiU54pDjgtM=
Received: from BL1PR13CA0448.namprd13.prod.outlook.com (2603:10b6:208:2c3::33)
 by SA1PR12MB6994.namprd12.prod.outlook.com (2603:10b6:806:24d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 18:42:13 +0000
Received: from BN7PEPF000000A9.namprd05.prod.outlook.com
 (2603:10b6:208:2c3:cafe::3) by BL1PR13CA0448.outlook.office365.com
 (2603:10b6:208:2c3::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.8 via Frontend Transport; Fri, 25
 Sep 2026 18:42:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN7PEPF000000A9.mail.protection.outlook.com (10.167.245.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 18:42:13 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 13:42:13 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 13:42:12 -0500
Received: from [10.254.92.96] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 25 Sep 2026 13:42:11 -0500
Message-ID: <8a3b2902-3255-4dd9-82f0-75a7747b710e@amd.com>
Date: Fri, 25 Sep 2026 14:42:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 13/25] drm: Add VRR target frame rate properties
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, "Borah, Chaitanya
 Kumar" <chaitanya.kumar.borah@intel.com>, Daniel Stone
 <daniels@collabora.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, "Jernej
 Skrabec" <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Andy Yan
 <andy.yan@rock-chips.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-fbdev@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
 <linux-arm-kernel@lists.infradead.org>, <kernel@collabora.com>, Derek Foreman
 <derek.foreman@collabora.com>, <wayland-devel@lists.freedesktop.org>
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
 <20260921-vrr-limiter-uapi-v1-13-2fcd7d011646@collabora.com>
 <0226527e-ee38-40ab-a2a8-1ae62013b950@amd.com>
 <VERVf-aJRRKsBOI_3dpScg@collabora.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <VERVf-aJRRKsBOI_3dpScg@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A9:EE_|SA1PR12MB6994:EE_
X-MS-Office365-Filtering-Correlation-Id: ce00b8b2-9201-49bf-0f0c-08df1b34b715
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|7416014|42112799006|23010399003|10067099003|56012099006|6133799003|22082099003|4143699003|18002099003|11063799006|921020;
X-Microsoft-Antispam-Message-Info: Riz02biUVxIpWgvZ8NZKQ3bHHfi5XDtTnGglixOIZoMOKfZqZnSrKlyLmCbvraGXxP+fDoWmC+ktdi66xqY5IzauVpEsNpBFcHB7fR0XgGC1CPDEB36akuE0u6HK8DRrgtjV9L+bNTJTux6hZYmi13VxNhrnT68rRaQ8xTWGvmKF4Xs27xCzUfq8FUUmx0pKPw+NOUEhTvrKSqGfvCp40ykWxayMuAYfUXonibvH3KHwKtDQ2JPl0+WCxjykYc1T1N9EDe5/oR6Hh2Jbx2xHdBo1Av7NPmCAXQ15a1O8rwnHQcmOfyNtTMAvJ1VbbS4l6eY7i59Nlu0ypnjZYqE0FAJQfkdEsrnl0m6d8D9uVZHf5vIHZepeQwTpKgHWY7qr0zU+QD7CQbMf+Fs9y9gPV7nYbz0NvY5ZGpIklwkyC36AbTXIcdsl6KJrqv5G3tsdcoyvGvVIK0FdJRjSsNxs7TQPNg9rUNknIu3EmlV4KoIEGhdQ/qcqeO05mf5oohDUKdFLoeT+8o8fadf6Q+j5QP2g2l00tIYvsemtVny6nXNv+ikanLB+848lD8psMAyvch5mFIQoee0t30usWoYeXQSeh6SDDV7Lfddgd7eTHmeHIIUZbSW1FSSZP4a36biFaR9qYokkOkI/L+oEXg4Z3BbNZleZ5PNYI8uO6HzeKWOdWaOA9NHzv7W3YC41JURrWFU25fbc/3zkhVGeOUbc4GnaBQ+ACGaUxFdtHT1kCUJvxcQ840nj2bipygyik0AV
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(7416014)(42112799006)(23010399003)(10067099003)(56012099006)(6133799003)(22082099003)(4143699003)(18002099003)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jXDzaoj4FClt0uR3OlLyale2P4nf1gIsETl9qEhpgRxvqtkkmEs/9Cq3w4BcLd+jvePx5wVs9K8OpZuXVhJpoz9eNOUG/vBCtMtYS6EZJLHLP5+pcZJoq3fhyfJbVkIixoWnGUmgR3RvNgHxdq8xVTEvOdNw7XdhJSBqwdyHWb8vJj6CGijlACtLmkRQxuzQaVonN+ycVJVBDeMuT//W57IZT7a4gxCrw7iKKKwjHwCCf9hNn/ZD2RC4WJmOy+d6QIQ8/d41rfwfwBFNf15aL6XzpugDbGcDBYmThbuXOLepDPmTBf8Jo5j6ADCHApoMQjZ27wNcZVtDUuJf35xhpYxUbtHkY7Xh7iqTK14HyGbdHcpkYvuXWFf6eaCh/VFhJgdf9+ClzC5xyijur1N6GTbKFMS0l55W/8Nuwy8W4oX5QuidxNhgCGsjv11rVcx9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 18:42:13.3339 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce00b8b2-9201-49bf-0f0c-08df1b34b715
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF000000A9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6994
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



On 2026-09-22 11:26, Nicolas Frattaroli wrote:
>>> + * VRR Limiter/Target Properties
>>> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> + *
>>> + * The ``VRR_{MIN,MAX}_{NUMERATOR,DENOMINATOR}`` properties expose a mechanism
>>> + * through which userspace can control the desired range of refresh rates in
>>> + * which VRR is allowed to operate. Each rate is expressed as a
>>> + * numerator/denominator fraction of refresh rates in Hz, allowing for rational
>>> + * target rates like 24/1.001 Hz with no loss of precision or ambiguity.
>>> + *
>>> + * If the minimum and maximum rate are set to the same value (and not 0), they
>>> + * are understood as a fixed target rate. This is especially useful for media
>>> + * playback, where the content's frame rate is both constant and known in
>>> + * advance. In such cases, a refresh rate that is not an integer multiple of the
>>> + * content's frame rate will introduce judder, since not every frame is
>>> + * displayed for the same amount of time. A modeset of the display with a
>>> + * compatible rate may in those cases be either undesirable or impossible, but
>>> + * the rate can still effectively be reached through VRR.
>>> + *
>>> + * .. _VRR-MIN-NUMERATOR:
>>> + *
>>> + * "VRR_MIN_NUMERATOR":
>>> + *	Default &drm_crtc integer property forming the numerator of a
>>> + *	numerator/denominator pair of a frame rate to set as the minimum VRR
>>> + *	target rate. Set to 0 to disable.
>>> + *
>>> + * "VRR_MIN_DENOMINATOR":
>>> + *	Default &drm_crtc integer property forming the denominator of a
>>> + *	numerator/denominator pair of a frame rate to set as the minimum VRR
>>> + *	target rate. If :ref:`VRR_MIN_NUMERATOR <VRR-MIN-NUMERATOR>` is not
>>> + *	zero, it must be non-zero.
>>> + *	Otherwise, must also be zero.
>>> + *
>>> + * .. _VRR-MAX-NUMERATOR:
>>> + *
>>> + * "VRR_MAX_NUMERATOR":
>>> + *	Default &drm_crtc integer property forming the numerator of a
>>> + *	numerator/denominator pair of a frame rate to set as the maximum VRR
>>> + *	target rate. Set to 0 to disable.
>>> + *
>>> + * "VRR_MAX_DENOMINATOR":
>>> + *	Default &drm_crtc integer property forming the denominator of a
>>> + *	numerator/denominator pair of a frame rate to set as the maximum VRR
>>> + *	target rate. If :ref:`VRR_MAX_NUMERATOR <VRR-MAX-NUMERATOR>` is not
>>> + *	zero, it must be non-zero. Otherwise, must also be zero.
>>>   */
>> If VRR_MIN_NUMERATOR == 0 && VRR_MAX_NUMERATOR > 0, do we interpret that as
>> vrr limiting is disabled?
> You can picture VRR limiting as always being active, but with a limit rational
> of 0 it uses the display's limit as per the EDID, which is what unlimited game
> mode is. So with how it's implemented right now in hdmi_validate_vrr(), your
> example would set a maximum target, but leave the minimum at whatever the
> display defaults to.
> 
> Now that I'm thinking through this, a possible problem is that
> drm_crtc_helper_vrr_is_fixed_rate() operates on the user supplied limits, but
> if the display supplied lower limit is equal to the user supplied upper limit,
> then we have a fixed rate scenario without recognising it as such. I think I
> need to have a ponder on what the least surprising behaviour for userspace
> is in that instance. The display limit stuff gets a bit complex due to
> CinemaVRR and QMS TFRmin/TFRmax.
> 
> I'll improve the documentation on the next revision to make the meanings more
> explicit.

Perhaps a simple way is to require simultaneous setting MIN and MAX pairs?
IOW, require userspace to set MIN and MAX simultaneously to >0, or =0. For example:

if ((vrr_min_n == 0 || vrr_min_d == 0 ||
     vrr_max_n == 0 || vrr_max_d == 0) &&
    (vrr_min_n > 0 || vrr_max_n > 0))
	return -EINVAL;

That way, it's never ambiguous what userspace has requested for the range. They can copy the EDID supported range if they don't care about limiting one side, rather than leaving it at 0. It's then also clear if they requested a static Hz.

Thanks,
Leo
 


