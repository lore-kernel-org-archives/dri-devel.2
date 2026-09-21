Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 961E2C982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 21:59:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB0FC10E406;
	Mon, 21 Sep 2026 21:59:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eOliHVan";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011008.outbound.protection.outlook.com [40.107.208.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6323510E406;
 Mon, 21 Sep 2026 21:59:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BabfJQtNODTahRsQJxAZwaUwKVLzNC64MNtFjWwhTv3+FvDMowJejCZ302KLdY31C34/hBBVAmN6hGHWJJeyZyNXBKWVkgyA2ft/1NHPvVSnSXviYBjH0L+nJtk/LeMzZ+1aZfpeskQqMOOVm9OQYYEGXBgpzzOGyWYEXNLuc+wGhLW0Af8KQhFgJ9ot7Gq2+V8j/xbQ7CSz320I8CsbaipyNX//Do7C54+80yQntbE48rTTfirjAdag92529ni7NKyA8uqwP8WppGkAQmUCKN+V95g0hXde3JR/ByU41xEvOcaV03NpWUOpRqbvJiPTPwjOaTd3xpW0R5HvUCkc+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFMcHKEkW9VJemIkcZBmOy9eKfMpVkSEhH7a5ywHPrw=;
 b=nTGfNG1CQSpmE8l5J15/VqxQdjrk/eAn0Dem46CneH5Vt+IDZm+MisMKY3vGbHt5RVwyWn2n4lOR9mvwt1zjD2ac3kDLcmgKil20m5+S+2ZCXzw4niE6Y/pZworo8Ni9oVeLRyEtMDFX2ua4HyYFTZtqHK+maSo6uYxvMGppXmRnUiPM+Zc+F9FgEb4oeM7lTeePSci431kknKrwoSF1snJ2vGFH8AWr7GepYdkhTS9fxixoQe0Eyxd+q4jQmcwNXT+zNV6BnqnpMqeRxFm7d3Y2G4cFRjxfb1moqbegwlWkIYGWUnlFs2eAjRWASws/ZzuxY8mxA3rS8072bDsfnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=collabora.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFMcHKEkW9VJemIkcZBmOy9eKfMpVkSEhH7a5ywHPrw=;
 b=eOliHVanpE4HTIr4nOH9b4Ic65Lgu2BkVPxUTTsXItcAwnturf4D28hDKgLrGlN4USaSPvdem3xII4d5Bp7ThlbzlbPyrpsV028NbRAWreT/GeTBlkRRX1xgMVRLe+Kf/gmgUIsxypqts0InI10ODpuiKLCGQXEck6MleyiRXtw=
Received: from MW4PR03CA0305.namprd03.prod.outlook.com (2603:10b6:303:dd::10)
 by LV1PR12MB999306.namprd12.prod.outlook.com (2603:10b6:408:3f8::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 21:59:20 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:303:dd:cafe::29) by MW4PR03CA0305.outlook.office365.com
 (2603:10b6:303:dd::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Mon, 21
 Sep 2026 21:59:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.0 via Frontend Transport; Mon, 21 Sep 2026 21:59:19 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 16:59:18 -0500
Received: from [10.254.92.51] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 16:59:16 -0500
Message-ID: <75b82a61-fe82-4597-bfb5-3c717fbb0dda@amd.com>
Date: Mon, 21 Sep 2026 17:59:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 03/25] drm/atomic-helper: Set mode_changed on
 vrr_enabled change
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, "Borah, Chaitanya
 Kumar" <chaitanya.kumar.borah@intel.com>, Daniel Stone
 <daniels@collabora.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, Robert
 Foss <rfoss@kernel.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Andy Yan
 <andy.yan@rock-chips.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-fbdev@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
 <linux-arm-kernel@lists.infradead.org>, <kernel@collabora.com>, Derek Foreman
 <derek.foreman@collabora.com>, <wayland-devel@lists.freedesktop.org>
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
 <20260921-vrr-limiter-uapi-v1-3-2fcd7d011646@collabora.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20260921-vrr-limiter-uapi-v1-3-2fcd7d011646@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|LV1PR12MB999306:EE_
X-MS-Office365-Filtering-Correlation-Id: 734b0074-17ff-45f6-0b6c-08df182b9686
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|42112799006|7416014|376014|23010399003|1800799024|10067099003|56012099006|18002099003|22082099003|4143699003|11063799006|921020;
X-Microsoft-Antispam-Message-Info: A2VlOXDdR+oPxukfB0Hqba9c+9GWqbnl0DZmjvyady7BHuulT10igfaTNbYAKBIDkpZZnqBGDl6wa7uzrvodf/0Nl22QTyV5AnZBbZP4HX0WJ5nCr+GNfTciA+xZX8rzvbuOKPB0fsH/tsniEjDeK48fhbIo6ofDoHLXkI30x8tfAEb2thYTOTgMoGvM4Wgao12f72IskulUkRaS503ymqQr191c/APW7mJV4zTuxPvsZsZ4d2xSnMEYtW9Qi3V2EE5rryjHQnWKfykaQV67MBddiFwD5MDyzhHlztMrBYZem50IYzHWgHOleq/z7eWeOozzS/NC88UWFibUlAs1E/JvWlSaBgBXxf140a5Vk6D1JpH7G3UxtDwyukP8WvOsl2kYTFJrnUUPni9M3aTSQp4bSGwFXbq7D9T6Atg5iIQ7sYfxA9N2G3Lv1KiOMVI94+RBfwBA8eiQMXzwvIncJmeN5fl+YoUwPNjuNZud4Jt3Car9ksTrnSYhi/4bM3z5YuEU3CXS2iBzI+hKSd+T2TXix7rxDsNLM/iyz8x8kBAyIwkS370JvUS0Qbcbq5RsWNrCJHeY0a/SBvHoKKgXumiIdl87SmEhh81mJszw1zeR3oVAgQlfQ1eeyaQ/aDUNV/ScgbZLjk8sVZfdKhSQ8AFsgqaMk/8SNvtTHkqTs8wiakWaPqmuLdp4v0LcUQq4yYJdktjnLNIO+3IuDUt1eZR7i0YMrZLwEr042QKb/1+nB6RaWL86wQHwGfTGnafq
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(42112799006)(7416014)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003)(4143699003)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DkDOYVCz2k68aiT/v07088fgbH3ftLGYeOf2JdLn97YLgcaWEuqr21RPwyHktr4hW2hFYjMm5RewL2cAmzKOUBbbFBl/2Ud7ZG7ZoO1UWwzHBjx5W825UhXW7YdanGbgS/DlcckqsM9BARfP+JpwC3gnJUAIR7PEpHr5uL9QTD5XKDsCCS4L0DnWBF/eSZAIK8V0IN8oUCVHA3Dfmrkq3PomDG1SdTFvDX55k/WhKrU0FgBS1cll3lB+G4QcqYY238O73WRXT3zDmoxo7zk7uXM1Z9gpEpRrN2/ex/25eluzTRIOzeNekvGW9DZteByiHPTdx50VJ3c72XduOwPCEiLpwagj2TrIbh74VxbzZC82ySqeN8qJplKoKHqfWe1NVqO/fZUL2Aty4ACDE5xHQB3QlJubtT+UaGZMOg61ryKbMR34Vfti33akTwlfBmsN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 21:59:19.6890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 734b0074-17ff-45f6-0b6c-08df182b9686
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB999306
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

Hi Nicholas,

Thanks for sending this out. I'm looking into an amdgpu implementation
and had some comments along the way. Will reply inline on respective
patches.

On 2026-09-21 11:51, Nicolas Frattaroli wrote:
> A change in whether VRR is enabled or not on a CRTC will be of interest
> to any VRR implementation, as they may need to recalculate certain
> internal state in response. So far, this was handled ad-hoc in the
> drivers that implement VRR.
> 
> Handle this in the common DRM atomic core by setting the mode_changed
> flag when this occurs. The rationale for using mode_changed is that VRR
> is deeply intertwined with the current mode with regards to its timing.
> Consequently, any component that cares about a mode change is likely
> also going to care about VRR being enabled/disabled.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  drivers/gpu/drm/drm_atomic_helper.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 9d006f98413a..0664d5779282 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -694,6 +694,12 @@ drm_atomic_helper_check_modeset(struct drm_device *dev,
>  			new_crtc_state->active_changed = true;
>  		}
>  
> +		if (old_crtc_state->vrr_enabled != new_crtc_state->vrr_enabled) {
> +			drm_dbg_atomic(dev, "[CRTC:%d:%s] VRR changed\n",
> +				       crtc->base.id, crtc->name);
> +			new_crtc_state->mode_changed = true;
> +		}
> +

I don't think this is the case for all hardware, at least not for amdgpu.
The parts in HW that adjust vtotal can be programmed without requiring
bandwidth recalculations or reprogramming of pipes. 

- Leo

>  		if (new_crtc_state->enable != has_connectors) {
>  			drm_dbg_atomic(dev, "[CRTC:%d:%s] enabled/connectors mismatch (%d/%d)\n",
>  				       crtc->base.id, crtc->name,
> 

