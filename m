Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 093FFCD8CB2
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 18:17:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D0BA10E5C7;
	Tue,  9 Jun 2026 18:17:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="io15xGMv";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013056.outbound.protection.outlook.com
 [40.93.201.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE4AB10E5BC
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 18:17:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ujUw8GYtJodipDZqb+ZH4XY7YkrBUJzH7oVacSlQbTY9uqnGZTuDv1Qtnc7feTWfMRUBLwCNOHuUhB1nzqiRJW8jnAQx/GlKDqDroCtm7u4KQItpUZXb6kUNPg3WqZZS4iChWn6QeYhwUF8u/d3TzoAPi8lA+Vdlvz+C0TUH41BCYdlpWiIQjzAT0LJ20Z22wY8Bk9OgsSDDoTxAMsDdBqTI3M6gSDr2gmWqFYiXlV2jev+JZ6173Rlj51bI1wTaVj4KrvvbwByPlgB8iVK1Sg6WV3bVrAgmJHPWAVcKlkgkuiOwr/VPDd8XQ+Mi0cdBJam9UWvwrYeTHzFgvgAl6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eOcDi+q02+tlaHFw58fc20xYVztI8b3NdVd0Ctp6jj0=;
 b=fjRwVJ5feYo4wiA3Jmid6r5Q8p1WHTS+G7X3QXdSM4YxBRGp9OJksqMdiDi1+zQJ8AQ+ldsMoNPgIoJ4nDMC7+u8wLaYYpANwRMSsDVlAWho3vgY347Dbrfpjes0UsY84/QhTjPB7OBSkbJ/sSkvXzgVKYTXUkSX3G46n2F3XtLWpVVWWLyJucs2y4HqeQh5qlhxrIDI7bpHoBIQLtS8TFBWsv4fBvnbOpYhkWxbZUBWG2NzztHzdkVXz64bnv0xWgvL+BdDc1zIVsoe8RsRGQZNAEw3KUGc+bZtz4EnwSO2fj58T/36AVM+JiJ9pVCCIiQmOAihEqTjfpedUL4Vfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOcDi+q02+tlaHFw58fc20xYVztI8b3NdVd0Ctp6jj0=;
 b=io15xGMvZ+z11h0YE8rOdOmBlgbtRtW/1Shbgz6+TZjv9JRSO1LryqhTzrtAPw2yIxsO/5pwG+bt2+U/JH3HIiI/iS2Xx1fB8nJGGGPPaxPah5rSG3x4LMLnRguL1+cSu+/vrpRfh+c9y8sVuNFf++Nk5eaTjYxeggQXy5l/zac=
Received: from BN9PR03CA0279.namprd03.prod.outlook.com (2603:10b6:408:f5::14)
 by DS0PR12MB9446.namprd12.prod.outlook.com (2603:10b6:8:192::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 18:17:30 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:f5:cafe::79) by BN9PR03CA0279.outlook.office365.com
 (2603:10b6:408:f5::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Tue, 9
 Jun 2026 18:17:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 18:17:30 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 9 Jun
 2026 13:17:29 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 9 Jun 2026 13:17:29 -0500
Message-ID: <34298735-9a39-c49d-f4c5-a11b8eeafc53@amd.com>
Date: Tue, 9 Jun 2026 11:17:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V2 1/3] accel/amdxdna: Fix amdxdna_client lifetime race
 during device removal
Content-Language: en-US
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <max.zhen@amd.com>, <sonal.santan@amd.com>
References: <20260608161418.2748988-1-lizhi.hou@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20260608161418.2748988-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|DS0PR12MB9446:EE_
X-MS-Office365-Filtering-Correlation-Id: e4167283-bbbd-4a4d-e784-08dec6535e55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|11063799006|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: wGwx4dvtrm9S08IhNvCWDzp2FImBKYrvNqudZ3eVxFGLZb7TvRRHV6Aqa4NsDlCZbKlSJv3LzGD17YA+JsDcc00mNWgl6BOEgdROXCUPqnGkHbHqA9uAp9TIo3gH0WDdy0KB6Iw9fWUTVTaia+sJAP0i8UiaW7IOwfi71oPxAmUJm7LHnAMpy2Geibo4fu7w22wVKcRDVNKcRFUWmRWz85ZVJmsWaBAMxwDULUPHi71Jm+HYA2M5krGXMrBpVWG91vyVQk0SSzwn0w5ZxE22z9gXFyvRfCknXUdeJId4HwuZ8RgFaE6A/iVFMNc2mn9C6TBfOL4IV8oWijbeSSmasWZyTa3ukVL9dZBgm2B/L5iSxCjs0FEEcFqdhvGjBcZfz6SiKATwNC+klhONyR1WyKq82+omZ02e6UyNNqz2NIR1XTHIPebK12DJSX15g4Z0W0GXGdtovoYzYWAdQ+aEWdEvsFMn70SQc2Q9RquEO72LDWndJwHkmwcy6+HnQBBySsVj2Layb9Hj3GVWMJ9u7hM+TqjmmJKcA1qnAM/CMevM19UntzJhwzNOPp2pB2VsNbeRyw3mu3a96tz2sRgiVz4zHE+ZML8wSWabwdhcaM7qoFhq58UM3kXKFfCjFPOUgEabJa1glnGsz2cAxSWNr0CuPaxNLhnfLyBfyj3Bmk1zMJc+F3BXffaLaBIUGAnq66bBJ4h7eX51XYuNmNnjVgKYbElDqi7O1cW/YMMw1yI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uZErLa0aQLrYtg5UqeJUoO9OVZitTODqQ/2WZ9fFX7dZWNaQIETrve0GDDIX9mm9uBmCZ9SCu+mH6T6nBgAQif0qDVhbx3klBX567GCkB9T6f8160lPoetESqzt0Vy/8Vmesb/mV59uvV036j1UiKQ6t+PBhVNIrSODpKTCqnaf3ACn3RMDW8irs2+2oa3b/faKgmGmpbt6wYgqc0Z2IAo/FWZyMYRakSJOpNvSaWfexF2QTalcGfXGM4emwA9TAgRxSEZeFozlM41vWVcHI1Tk6pPSL8/j1ggJdZNqrYzRyriO3rY5OcivGell4XNyO6oA2fwQDPFvBISxfjmfyP3cbllG2W/Iwjb6cSkXzZfixGYGevrJWiQdLupi4iBDwww4pjw5t2MkFpoydTwTTxl2RUCdzQmpWGMFZ3NyHC5cp30UWFVLWzbbKSYthJgkh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 18:17:30.0019 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4167283-bbbd-4a4d-e784-08dec6535e55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9446
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

Please ignore this patch set. I would figure out a complete fix and run 
sashiko scan locally.

Sorry for the noise.

Lizhi

On 6/8/26 09:14, Lizhi Hou wrote:
> In amdxdna_remove(), all amdxdna_client structures are freed after
> calling drm_dev_unplug(). However, drm_dev_unplug() does not force
> existing file descriptors to be closed, so amdxdna_drm_close() may be
> called after amdxdna_remove() has completed.
>
> As a result, accessing client->pid for debug output in
> amdxdna_drm_close() can lead to a use-after-free, since the access is
> not protected by drm_dev_enter().
>
> Fix this by moving the debug output after drm_dev_enter(). Similarly,
> add the drm_dev_enter() protection for amdxdna_drm_open().
>
> Fixes: be462c97b7df ("accel/amdxdna: Add hardware context")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> ---
>   drivers/accel/amdxdna/amdxdna_pci_drv.c | 22 ++++++++++++++++------
>   1 file changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> index 1f066ed8d236..a22c986f1b33 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> @@ -108,10 +108,16 @@ static int amdxdna_drm_open(struct drm_device *ddev, struct drm_file *filp)
>   {
>   	struct amdxdna_dev *xdna = to_xdna_dev(ddev);
>   	struct amdxdna_client *client;
> +	int ret = 0, idx;
> +
> +	if (!drm_dev_enter(ddev, &idx))
> +		return -ENODEV;
>   
>   	client = kzalloc_obj(*client);
> -	if (!client)
> -		return -ENOMEM;
> +	if (!client) {
> +		ret = -ENOMEM;
> +		goto dev_exit;
> +	}
>   
>   	client->pid = pid_nr(rcu_access_pointer(filp->pid));
>   	client->xdna = xdna;
> @@ -125,7 +131,8 @@ static int amdxdna_drm_open(struct drm_device *ddev, struct drm_file *filp)
>   			if (!amdxdna_use_carveout(xdna)) {
>   				XDNA_ERR(xdna, "PASID unavailable and carveout not configured");
>   				kfree(client);
> -				return -EINVAL;
> +				ret = -EINVAL;
> +				goto dev_exit;
>   			}
>   		}
>   	}
> @@ -145,7 +152,11 @@ static int amdxdna_drm_open(struct drm_device *ddev, struct drm_file *filp)
>   	client->filp = filp;
>   
>   	XDNA_DBG(xdna, "pid %d opened", client->pid);
> -	return 0;
> +
> +dev_exit:
> +	drm_dev_exit(idx);
> +
> +	return ret;
>   }
>   
>   static void amdxdna_client_cleanup(struct amdxdna_client *client)
> @@ -175,11 +186,10 @@ static void amdxdna_drm_close(struct drm_device *ddev, struct drm_file *filp)
>   	struct amdxdna_dev *xdna = to_xdna_dev(ddev);
>   	int idx;
>   
> -	XDNA_DBG(xdna, "closing pid %d", client->pid);
> -
>   	if (!drm_dev_enter(&xdna->ddev, &idx))
>   		return;
>   
> +	XDNA_DBG(xdna, "closing pid %d", client->pid);
>   	mutex_lock(&xdna->dev_lock);
>   	amdxdna_client_cleanup(client);
>   	mutex_unlock(&xdna->dev_lock);
