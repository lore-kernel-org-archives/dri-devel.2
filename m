Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30539C61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 15:39:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B3DE10F28A;
	Wed,  2 Sep 2026 15:39:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O+IeND1u";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010013.outbound.protection.outlook.com [52.101.56.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46ED810F28A
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 15:39:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EEswN6wPomwkY/NvvkOcYs+PcM0Yq85yQl/odL5pzAWJGAa3C9fuhO25q29IbxZpCt7rJ42sTlvxOLx1qGxDyn+O/rzgYoCSFmcoiLGBFflbJyENaiuUT2TREKfXtkOOJfsqgXHXl0Ksvho9R8xljBWd7iiQ4tCuJJ8mX0GyXbTtzA8T9xQKvgTX2MjOKrob/INB3IawJATf8A8CwDLLUD4tpwPYnyqd7+s1k25+4VnRd/Cz0HTAtTPaly9k1ZiAKmrwF7YA/i0tUcxAPk3DCA1uWlq5es4VuC23X1crkLawVsidRYo5OA+Bo3vmBOZLUi5dQkTYRkVVlGoELbNucA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6wpCA9dX938YZdy8QRB/UQGumJIsYxyjbuRZCtdTEs=;
 b=aSH5H6Mc9MFVCIsaGyQhYcpI9tyukXapux4RnELLSDq4lzlqsx0h6euDn6VdWdgiGbMIZ51KACVdrAsy3YiLrTwjfoJTmZd4hx5kQAj6bKhp+iwSS3W21WnhaviMBZZpYVkXOianbRxT7P/ccJYU97L0wqyz4lcVz1riRIfwZu9CFb65ae0xkoiHNZpYNC8wJ1Du+2rjsPaSkR8gM91KFqTBCd29k9PLVNFo/+1vHcTY/3C89Qz+J6dljJWWITjyaxtSYQ5hXoTfYC4B4pbuBgK8/csWyyAddKP2qQhWUEiKgXmhJqQtHQBzRVHWZ5lOQ6lzPS9IbSTB29JLzDNWmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kaitmazov.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6wpCA9dX938YZdy8QRB/UQGumJIsYxyjbuRZCtdTEs=;
 b=O+IeND1uOxn2cLxsgo4MfQL+niuGahMjVIphJt/fQn16dFMMwmXdJgVh0fQTNXE0/iqH/HOgCU2pzDt9k8q/ZVsJ++/UtxfuFvYXB2xWwzLLgoZIT7FnuGUwivDJ+YlZEPvVenMaPFnTdpTsJrHzWjcD05NCIUCJvqSUt4FJYiE=
Received: from CH0PR03CA0240.namprd03.prod.outlook.com (2603:10b6:610:e7::35)
 by PH0PR12MB7814.namprd12.prod.outlook.com (2603:10b6:510:288::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 15:39:33 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:610:e7:cafe::50) by CH0PR03CA0240.outlook.office365.com
 (2603:10b6:610:e7::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 15:39:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 15:39:32 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 10:39:31 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 10:39:31 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 10:39:30 -0500
Message-ID: <96451784-b482-f029-3a2c-b9108aaec175@amd.com>
Date: Wed, 2 Sep 2026 08:39:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 4/5] accel/amdxdna: refuse to flush an imported BO
Content-Language: en-US
To: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>, Min Ma <mamin506@gmail.com>, 
 Oded Gabbay <ogabbay@kernel.org>
CC: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Sumit Semwal
 <sumit.semwal@linaro.org>, Alex Deucher <alexdeucher@gmail.com>, Max Zhen
 <max.zhen@amd.com>, Sonal Santan <sonal.santan@amd.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-media@vger.kernel.org>, <linaro-mm-sig@lists.linaro.org>
References: <20260819224458.257346-1-taimuraz@kaitmazov.com>
 <20260819224458.257346-5-taimuraz@kaitmazov.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20260819224458.257346-5-taimuraz@kaitmazov.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|PH0PR12MB7814:EE_
X-MS-Office365-Filtering-Correlation-Id: 048c65eb-5e43-43d1-7cb0-08df0908624c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: CxU17BcpOg7+h4qIzW8TgKMEJ0TS4fsOANVmkqKMfbLdibvu8JKVHJiLC6pzDyCzNd/o5PnT6MojBFjXLx6z0wO6A37+lbpO4/y+1oDgFzaz4XRoka3jR/WYF600UhvWRD1Z7ZhDrjJedUIrp4Bkj5svfOHVWCQMSzr3tu43E3b2q0dL8WM7qFiuldPyXVB6QlqRGVUJKYXoAH0LumkK9VrhZpoYVo2/i82Hv5xn8zKF6kHPwyefSnldLGYx0xoqiPNFjiodHcucui2628VsOYr9m+3tjGaT6OoUtkyiGx47YMDKT4gaeZAED+eV15+7Z/9vsAWB40bzBiR7lA4MqQGcHwXeLnV+gtlbxKUT9+27x8bHyqonq6Rsg29JPYdvdVBIew2+PgJcm/7huN825h4K05/F+qyfAJQySwBOJAaV1g3n7SQ61L1B0Q5QjWiYi+zFCpxTckzjiuZ9SV4ouFnjefe5Hg/KnVvJ//exJVGikMpLKjrCYVGzg3TPPMEJxoqGj6bOriDz1vvYggnV0T+RS8bTFMpRp2T4RuNyZ+3dE0NM0swLR6U0zTAagyMwC+xh7f8WAxFqa5dlFI/QaYpVwM4o/0LqOYhkaY5N8YdIZWA8zKuzsvcJEZSwHg76p6mimYqFAgchu2SbxVMSIgx0MigBP03GGWjKOhLS+SQLEqqg3Zrrfkgrs0iU8s/Lqg7fefOTjeVtfvIC2ee9BA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mVyGOSgo8XajDAhpN1RXdFCEZF9DxFCSrSQxKBvMGhQVlHKtDtqdSKia20qO6zgr/wVbxkyRGtBl1uLXULL8n7WKsGuFV2HksmEh5wJCZIlEQATwHurd169JGNJRp5qgQtdXC5AkH5C+ssdVH8Pkn3XVud4u+1Z13usKjjrQpR2YyA8ngoMgKjrHnhVuPIZCgokJPHbCtOJQ2safEOr8lWcXQT+QM6Tq0Ks6bgeUt3p0lX7t9F1sgsl5B9GezIbQJ/ekptcL9GktISGarfVzIjEJvmGR6FtY/Yms4HsOQi6Wk2+DNHFzDGsHQM+GSBdhRq0XVMuz567cFVVEVwaoE1rubtWb4VeqZVYZb20pc8UGX6ww21Os1/FMUmBTzHlfbdlyUWr1ndOhgR+8Jb2UIY9ij5QLsPFmOQqL6be7FxY8ohIBlw8yoB2lmb2xDUfj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 15:39:32.3009 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 048c65eb-5e43-43d1-7cb0-08df0908624c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7814
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

Applied this to drm-misc-fixes.

On 8/19/26 15:44, Taimuraz Kaitmazov wrote:
> SYNC_BO clflushes an imported BO's scatterlist. An importer may not do
> that: the memory belongs to the exporter, and dma-buf gives the importer
> no interface to ask for maintenance on it. Refuse the request instead.
>
> is_import_bo() is (obj)->attach, which covers more than foreign buffers.
> A userptr BO arrives through a ubuf, and on a carveout device every share
> BO and the device heap arrive through a cbuf, so SYNC_BO answers
> -EOPNOTSUPP for those too, including the AMDXDNA_BO_DEV path that flushes
> through its heap.
>
> Only the ubuf case gives up maintenance it was getting: on a 64 MiB
> userptr BO a 4 KiB sync and a full sync both cost 659 us, this arm having
> ignored the range. amdxdna_cbuf_map() fills in only the DMA address and
> length, so drm_clflush_sg() already walks zero pages on carveout memory.
> Userspace maintains these through the mapping it already holds, as XRT's
> buffer::sync() does unless it is told to sync through the driver.
>
> Suggested-by: Lizhi Hou <lizhi.hou@amd.com>
> Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
> Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
> ---
>   drivers/accel/amdxdna/amdxdna_gem.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
> index 0e0f844526ca..4be5298d1062 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -1224,6 +1224,9 @@ static int amdxdna_flush_bo(struct amdxdna_gem_obj *abo, u64 offset, u64 size)
>   {
>   	u64 end;
>   
> +	if (is_import_bo(abo))
> +		return -EOPNOTSUPP;
> +
>   	if (offset >= abo->mem.size)
>   		return -EINVAL;
>   
> @@ -1234,9 +1237,7 @@ static int amdxdna_flush_bo(struct amdxdna_gem_obj *abo, u64 offset, u64 size)
>   	if (!size)
>   		return 0;
>   
> -	if (is_import_bo(abo))
> -		drm_clflush_sg(abo->base.sgt);
> -	else if (amdxdna_gem_vmap(abo))
> +	if (amdxdna_gem_vmap(abo))
>   		drm_clflush_virt_range(amdxdna_gem_vmap(abo) + offset, size);
>   	else if (abo->base.pages)
>   		drm_clflush_pages(abo->base.pages, abo->mem.size >> PAGE_SHIFT);
