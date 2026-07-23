Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A103C531CA
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 13:31:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A03310F126;
	Thu, 23 Jul 2026 13:31:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FKXu39jJ";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011015.outbound.protection.outlook.com [52.101.62.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1535410E586;
 Thu, 23 Jul 2026 13:31:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NTf1vZUyOfx+eVyHNFEvoDSgnkxEfDw+Z3Nx4vi37WEhXkqiF7Tf14P7bVIr7r1RA+qrgQPYgh2RQZdC5KGj89AeTxZTKr3VX/T+PfgiALt2MO2dyw3CPlCtgBQZp5zaxWHWYvyE19nEDKGP8k0ofClAO/6/4CmoTjUrHPXTs9KaFMC3JYs4mf0FqBk3eauva+xr+GCAF4vYvRs14bxTrL+3X9u6sQx6Fdx5Fua+RR1FMZqO27K0uJtKyNKosBsYCNVizJ3Z8ReLqjwgRq9E63GXzRyz+uv/y2LWlOGY+PYRU3hw3qkwi8LvyzNTA7m12Cx6Ejc0ACKwnyTXW+cY3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjCzxmhCtDzajbEePQ3YuD+ww/CDhf/iofujqvXCPnM=;
 b=MJio4OuoU9foOQwiEaH9oSzZ+XBfkb/L2DC0f2xv+/tB0lIWiMtO7BIMJWjK+XI6DgHmzGQ3p+wzhnMyh8ZW45SRlp2asMKEwRZ2JBaSOOZPCydEmDgU9L472u/KdsXdPghTsK7G/A7I4I8jBBpzQG0WZ7TDYMZykcJZYTZiarJjek70XUL2dwgxV4ZebnXxaRzvcoS79U4OYkzD47r0A/5saKzHAiPrHkg8Flaezg2qepm2gMVfOoDbUnj0Jq/9H5uzUkPbcT7L8U67JGMn5vIpMwSH3dOUJRbC6MpQ/d5Oc11eL8tE9IP2Qnn9IguSUgjFOeWqeuFgUwG1h51O5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kylinos.cn smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjCzxmhCtDzajbEePQ3YuD+ww/CDhf/iofujqvXCPnM=;
 b=FKXu39jJ1NxvOijTUW2xbtvdW9uiQ9xKm/duDKR58va5A5fqJdSzQmnROE3Hut77AhY5Lk8236ryG8xAVeRgZDwptVbaojJdUEhntaKehQr2pBt9JxbpPvl8z6+Etqlt/Ey8mjbzMDIjZG5hx9bpKG/1WO0HX7Xfps4e5jY3An0=
Received: from BN9PR03CA0445.namprd03.prod.outlook.com (2603:10b6:408:113::30)
 by SA3PR12MB7807.namprd12.prod.outlook.com (2603:10b6:806:304::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 13:31:22 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:408:113:cafe::c) by BN9PR03CA0445.outlook.office365.com
 (2603:10b6:408:113::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 13:31:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 13:31:21 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 08:31:09 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 08:31:08 -0500
Received: from [10.254.92.116] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 23 Jul 2026 08:31:08 -0500
Message-ID: <7cb99c08-03af-40d6-9e64-21824457e80d@amd.com>
Date: Thu, 23 Jul 2026 09:31:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: fix wrong plane_count check in
 dm_gpureset_toggle_interrupts()
To: <yaolu@kylinos.cn>, <harry.wentland@amd.com>, <alexander.deucher@amd.com>, 
 <christian.koenig@amd.com>
CC: <siqueira@igalia.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20260723015503.32122-1-yaolu@kylinos.cn>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20260723015503.32122-1-yaolu@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|SA3PR12MB7807:EE_
X-MS-Office365-Filtering-Correlation-Id: 99c17a47-8514-470d-d50e-08dee8beaf7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|82310400026|376014|36860700016|23010399003|1800799024|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: aM8t+QbM1hIGbaX3BYmDJR62orIGLAAoCQPiV+JEWUJVk8cpQ6qUX/udmjFZ0BAQ6na3VxwzCwhsMkPlj7wlzOkyNZ6nAWB8DVYeYnhxhOnqE/CLNKgwBntCYsyZrb9M21v22VLTetA3pYGwWQymzjaTJfmxENBXS+sr0QvnlQ6/wAdMow+juIm+OpLZPpfESMWMh0P2VT7+1ydf6u2YhG4AGHuK/8iX6mO8IwmM6/g4fUcEoYqMrPTR1sNjMLtkptm7tGLso31DLAnU4KmcjNU5FWWvm75+XqRtDl8JHfZj4Af2US81xhI3xbrvrsVToaQHecWbXuCTjLw7FeL883EarfmHwh7pk/5m/Wlu6gWnlEGJfQ9cvZInSoQOMfWA4d+kWJZ5F0d7Vot0s8JhJauMeBE7QboQZZJdu4Y71gwQX/IhyUpZKW6zKYgkZc68hUbrjqDFGgoTiqFIBPj35Q5P/dmZJGxDuWFyzSDvES1wWQFi2Ugs1uHcTDBtnowOrckZWWXqgxSsCaOeDxZ+Atu7s+4QBW+1/nC5LtcItr/BhMoWnZmsbLGZqjgTrNEJDo7b4M6fUnff3vQCLlxw2w/w4dQS+DTdOZuFZ93zCzq2ABLQ5VUAOvB5PbjhxwoQWfs9xJS0SF3OMlxP1oNlIQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(42112799006)(82310400026)(376014)(36860700016)(23010399003)(1800799024)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: m4h8fltHNrJExrZHY9DFGJ9mDAp97A6pvjMQH4PWqj84N2i1dM8AFgbLJ1YyNxJ+0PIxAYgRtXc2HFjLI37oIBcuqhwy/LxI9EYz1EtBJ4wV1y1Sxdi55kUqdK8ODHBGOvM5WaBuUaKYlIV2ltlqqFC6TSTGHcW29CMpyQVqLsP9+kQy3uey6c6deJDs6d2iLtiTgMX0+THrk0Y8L7HFIhzygOtv+GeLtdRtUxQNFTamJN2GIuc5ejDP00hKbsQxkf0KHva7UGus+Hsl+96sK8AJX9T2xqsDqOeYdMP4nwk5t5H2rL0i6w1eI18yf253VCRrKT/gBA1+4iWVcD2q/EubrAVHXUHmCkFOTkSIw1QwHC5wOeARVs5nWkiyBb7MrLCnxLlmMUuFDqYzOBMa4CwlhRlyChyLjamCmw4nZGPrTwxp0ilvnv5WoiZ4HdKi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 13:31:21.8376 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c17a47-8514-470d-d50e-08dee8beaf7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7807
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



On 2026-07-22 21:55, yaolu@kylinos.cn wrote:
> From: Lu Yao <yaolu@kylinos.cn>
> 
> The else-if branch in dm_gpureset_toggle_interrupts() condition was
> incorrectly checking plane_count != 0, which is the same as the
> preceding if-branch and can never be true in the else path.
> 
> Fixes: 8382cd234981 ("drm/amd/display: consolidate DCN vblank/flip handling onto vupdate_no_lock")
> Signed-off-by: Lu Yao <yaolu@kylinos.cn>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 9c564cd5edee..a11c64277d1d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3353,7 +3353,7 @@ static void dm_gpureset_toggle_interrupts(struct amdgpu_device *adev,
>  			if (!dc_interrupt_set(adev->dm.dc, irq_source, enable))
>  				drm_warn(adev_to_drm(adev), "Failed to %sable vblank interrupt\n", enable ? "en" : "dis");
>  
> -		} else if (acrtc && state->stream_status[i].plane_count != 0) {
> +		} else if (acrtc && state->stream_status[i].plane_count == 0) {

It looks like the `amdgpu_ip_version(adev, DCE_HWIP, 0) == 0) {` condition was lost when I rebased
the tagged "Fixes" change on 7.2...
https://gitlab.freedesktop.org/agd5f/linux/-/commit/991d045abfe30cbef19b92edfb304d209fcdf7e3?file_path=drivers%2Fgpu%2Fdrm%2Famd%2Fdisplay%2Famdgpu_dm%2Famdgpu_dm.c#line_298241cee_A1561

Fix incoming.
- Leo

>  			/* DCN only needs to toggle VUPDATE_NO_LOCK */
>  			rc = amdgpu_dm_crtc_set_vupdate_irq(&acrtc->base, enable);
>  			if (rc)

