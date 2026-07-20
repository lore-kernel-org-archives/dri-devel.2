Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C13C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 13:55:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58AE710E952;
	Mon, 20 Jul 2026 13:55:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NWkdua8G";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011057.outbound.protection.outlook.com
 [40.93.194.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4DD010E94B;
 Mon, 20 Jul 2026 13:55:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KK+MpT0oT5Kv7OwiUa1VIcnlEWijpuAAi7PBRF4QTEIhk0JZszXdnEsmdJ6prq1tbuPAE1SKS9QQYYZVAWkPEw2jTvOTqr1Pd1LRHZt4FyV+raqMFXbCipxOXSjzEtuoRySl10bS6sjrKR1bBtRt0WK0T/eEAupq68xYHrNKDmcA2/mkz98SkwqZcm1+NekycujUomr2vPu2lkZPf8zv7rds1W1LyZwN297KxziHhsNtQIYP51TwCJSM2cX+tVzsmNG/yykaSrI2iWH0hUC84nw+V61pH4SBpiUPVOl+kqZYT22/cX4T4v1kimWkjaCnxj1sb9YnBefSqxNTJVIBGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JFAlQQV7SKgATOIBXdfwRgsbYisTPHws5XlwsydjLec=;
 b=wrh5TeR7fXN7Y3L4NS4V3NqLbw1X29sOqobt9l9HKrTKXQF7VHaXsUI+scMwXMC/z9Ztc0Ko/coo1SzLx9Wklce7D1km1xy3o5+FTzCB45gchLMTxlIUCyrSE+TDKvzfxy8JkLOx6xnf2R+ws+8idJhPq6FdC4gyve5M4q6EfXyXaQULtzRXhiPGvW+a94ikjQANRfM65MdgE2vJPrBJ5TP7kTHS3FqVT3W1FHZTN0w3gwqQiAynNanHMxSuXbDIIm2kfeUCWCgU1obOXsahrEKwY0CPcbYdIBTkYL6YGi9dwPOLSuE6okJtfbvBZNkGMoeme7uaihjOe2mA/o2yDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=collabora.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFAlQQV7SKgATOIBXdfwRgsbYisTPHws5XlwsydjLec=;
 b=NWkdua8GTNX0XCkkZFLe7AzKB5mFhnsWM4/kh11/fdOt46H0Bz+03UAgprb5r0K4zfTGJLj5m3K2dm6aHcPhiGSK1dbH5rxnXs9ge7wO7L5sS41HsWLtfm0VFiHzHL4OZDGcJArAspWwK6BgQrsWErPzBDEXYYqjA6uQ9q+H7+Y=
Received: from MW4PR02CA0015.namprd02.prod.outlook.com (2603:10b6:303:16d::6)
 by MN6PR12MB8590.namprd12.prod.outlook.com (2603:10b6:208:47c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.14; Mon, 20 Jul
 2026 13:55:50 +0000
Received: from MWH0EPF000C6194.namprd02.prod.outlook.com
 (2603:10b6:303:16d:cafe::48) by MW4PR02CA0015.outlook.office365.com
 (2603:10b6:303:16d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.16 via Frontend Transport; Mon,
 20 Jul 2026 13:55:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C6194.mail.protection.outlook.com (10.167.249.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Mon, 20 Jul 2026 13:55:49 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 20 Jul
 2026 08:55:49 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 20 Jul
 2026 08:55:48 -0500
Received: from [10.254.92.49] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 20 Jul 2026 08:55:47 -0500
Message-ID: <f1d1965c-dbbc-42ad-a6eb-616a172cfb0f@amd.com>
Date: Mon, 20 Jul 2026 09:55:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Remove redundant AUTO color format
 handling in else
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, Harry Wentland
 <harry.wentland@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, Marius Vlad
 <marius.vlad@collabora.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Dan Carpenter <error27@gmail.com>,
 <kernel@collabora.com>
References: <20260720-color-format-amdgpu-fix-v1-1-4ec896bb1531@collabora.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20260720-color-format-amdgpu-fix-v1-1-4ec896bb1531@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6194:EE_|MN6PR12MB8590:EE_
X-MS-Office365-Filtering-Correlation-Id: 99488c4c-5580-4545-9b2a-08dee6669b3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|42112799006|23010399003|36860700016|7416014|376014|13003099007|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 0lUP0BBH6zLeNh9L9d+MPTcvz4is0Ormu/iyGuy79Y/kua/2FyzPbGHIywkNe+EmxtPJYymz3uQUcg4hKY+tyzictOMxWPIXeTQ3le/bzGaTiuLyhQs/gnhrZ9zSRlIxhLqydk/l7uXKpeFtWt8/S7Cxhfc/BaU3C9dDxCNNWiiiTQYrDUEgY2Q/bB5EwZve/Zih7ApmBuCuEkcFixRrqjXLBqmYH5AKNZF7fi04bQvqvENzuM3I4zbDICaSaOMdY8t6de9tpjQhLWYHS8pLj0DO+rAvUgZf5DmhDOrKPOol1rrENMHEwjcAnK/GOHipO1By4PE4/upyt6Q6uweCfvupVpDzgOmxrRI0boRLBivl330aexzr3iPGgwgyai2lP0VlPop/i8d5Yp/KYfrFe0RZXKPHMFgP1l4/6e6xMuqLRW5JDBXH3YD9Ifheliv4SnFHRST9CwG4Up3JfOc0faOqsbcV6OUNMQXcrFR1tK4ts38rocSwJq8slKOA/ko6c4PyFXcO+GW7LAGWkuYhHO23qT1naPSZiYabXo9T7OPbP4ATuiMoZuNptip2+9APuLTeKPDPtqDJRUq4CWIY8pZqd8hZE5t0jtymrDjwCYqX0Zr/kT3WXK8KxIAAh5xEi7SD4Nsqpm6E/vyWlcBkkIEiwx5ntExeQtswJ0YhKN/uhwvAP+eUMw0dqzwcv+1ClqFveRB32+mVcdTOtjEUyg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(42112799006)(23010399003)(36860700016)(7416014)(376014)(13003099007)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vnrpCMwoyBSykYDjyq9CX9lrB1OZ4JGz6prAHxaEjNlYQaRK5j9fuNluFF229vwd6hIcMjD8HdFpcd0AqcXEXU0ULq6OsKz1mX6Jildd2HPwkbNgk2NaEA9d4UWcIqZBz0srIHAWP/pjlT5yH4LwRaO4TsYXD+AueUeD9d6WST/IS/l5ylD0EbSfuUOexXqEfXp9Lz0mGxRkDoVYHnp4ZbjAhenEfhIH8dV4fdJx+LnFDSBEJ89R5Nyx6o4etfJeU+EU/Dx0rVkztZEbc3B50ImIZai3QeAUcAyuehj049K/XldAqimfHA3JhYw3sFRZmjFDHVy9RbIUmHFAoOmPTCvCkUh+nexRV1k+lCm9AQsIVq/E6OAXtKnx4IaW74HFzlOyC3AtYOpGRXt2uQ03M1YoDYTrW4r9+y40LF7+kJut1jt6xC4XjqqvmBXCISzQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 13:55:49.7359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99488c4c-5580-4545-9b2a-08dee6669b3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6194.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8590
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



On 2026-07-20 09:03, Nicolas Frattaroli wrote:
> The AUTO connector color format is handled in the earlier branches for
> both RGB and YUV420. The repeated check in the else branch is therefore
> redundant.
> 
> Remove it to make the code less confusing to read.
> 
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/r/alCcJmDeIYEE94Eh@stanley.mountain/
> Fixes: 8a0343b03b98 ("drm/amdgpu: Implement "color format" DRM property")
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Reviewed-by: Leo Li <sunpeng.li@amd.com>

Thanks!

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> index 88f938a8f24f..ea277c991234 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> @@ -854,12 +854,7 @@ static void fill_stream_properties_from_drm_display_mode(
>  		 * error bubbles up to userspace. This way, userspace knows it
>  		 * needs to make a better choice.
>  		 */
> -		if (connector_state->color_format != DRM_CONNECTOR_COLOR_FORMAT_AUTO)
> -			timing_out->pixel_encoding = PIXEL_ENCODING_UNDEFINED;
> -		else if (drm_mode_is_420_only(info, mode_in))
> -			timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
> -		else
> -			timing_out->pixel_encoding = PIXEL_ENCODING_RGB;
> +		timing_out->pixel_encoding = PIXEL_ENCODING_UNDEFINED;
>  	}
>  
>  	timing_out->timing_3d_format = TIMING_3D_FORMAT_NONE;
> 
> ---
> base-commit: e6a72e9b927165081566252d972ea1cbbee5bf28
> change-id: 20260720-color-format-amdgpu-fix-09a03106c9da
> 
> Best regards,
> --  
> Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> 

