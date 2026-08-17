Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A485C5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 17:22:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDB8510E8A9;
	Mon, 17 Aug 2026 17:22:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q1S8sH55";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012063.outbound.protection.outlook.com [52.101.43.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1202810E780
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 17:22:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gpcadomKPIKpGEyJsOdbt63n4lZ9vt4RlKdS4Mg0F45BnIYLjGy5YayCc2amY8KbUj5sbmWGh9enBBB6wH+RKfHrxaIi7vG7VMibK94b+gdsQI4G6xxYF4ep0NdrOszkjYPm5ViJd401D6qmfpdt5DqJ7lryaAFJohQs9RfTnmiFNi5obuqqhEuHPi4tmVzj26ByJ3zBT9p9hptTBGqyFoGcwXTiz9IEBr7lhESZG1DQv/lHtxSC2IDCiSkgKJwgL+lE2p/IvhSlxJvLdCLYL9VmlHjV6aHOEyb+b45O4sVNN8FYhI3cl1JGoIC+GKD8sH7jWRIFrpJrScyV0vZt2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJZgTF9L3ZT5eH81u/7sB5d6XYSj47uTfxQIpXTdX6I=;
 b=Z+CC1EcT1JskLEbX8yAoc3VM4Gynv+BVCAXecZZrJxTes962GECnHNqIJjNGRd8YwMAhP+7eca7qiVllKUZXIadkK81ThAMd2D+J4XV/nrpTJwlDlvqNef95E5yUNlYXGiXS9WwAN4puXptfgO6l5C27kzgOruyM7u1VbzYRCjUAAh7vg/V8/zNHw05/obFdNGe/gDDfPK4y/rXeP3hk+bKBdBW6xhs9dMkIQX58j4eBvLmKrv5Lde5IvQoM1sBJejdyJ3K2zeTih8fh+DGAN9FZYwGAW0zPjCbVRYp8pLQ47hCEZIG5eP8QjKnK81dvjSTkakYWvCYCEDukX3hodQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJZgTF9L3ZT5eH81u/7sB5d6XYSj47uTfxQIpXTdX6I=;
 b=Q1S8sH55KvfzNCQHtCLutbHI1ctGbadmchyvMeTNjgxcwFz8UPAqd/S4txA7d0MlE/V2leCS9aNfmNMHKu1f4+PXvtYjuCuOEXVapLmpoo/rIoFiqJF8iphKxsFxO+6mlkt9z4YC7wPDfwdx3qw6q0fMR+nUMvIhLpzhx9jqNxg=
Received: from DSSP220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:3d3::8) by
 DS7PR12MB8289.namprd12.prod.outlook.com (2603:10b6:8:d8::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.17; Mon, 17 Aug 2026 17:22:24 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:8:3d3:cafe::1d) by DSSP220CA0013.outlook.office365.com
 (2603:10b6:8:3d3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Mon,
 17 Aug 2026 17:22:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Mon, 17 Aug 2026 17:22:24 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 17 Aug
 2026 12:22:23 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 17 Aug
 2026 12:22:23 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 17 Aug 2026 12:22:23 -0500
Message-ID: <2dcb7498-b1fe-44c0-bb42-1716af8d2dc7@amd.com>
Date: Mon, 17 Aug 2026 10:22:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] accel/amdxdna: Keep PCI power state in sync with runtime
 PM
Content-Language: en-US
To: <reza.jelveh@gmail.com>, <dri-devel@lists.freedesktop.org>
CC: Min Ma <mamin506@gmail.com>, Oded Gabbay <ogabbay@kernel.org>,
 <linux-kernel@vger.kernel.org>, Reza Jelveh <reza.jelveh+git@gmail.com>
References: <20260814132744.516105-1-reza.jelveh+git@gmail.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20260814132744.516105-1-reza.jelveh+git@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|DS7PR12MB8289:EE_
X-MS-Office365-Filtering-Correlation-Id: 4767f349-fd1d-4341-0d0b-08defc841a76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|376014|36860700016|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 5eqlqFMyVthpKo7G4LxqwIP74BTYylHNJtDZ5ZiV3IJ9f1ePDsuiUV32JhUczrZSQGPfGZnpngHi4dVQvpwXxPzc+al87Uhs8lBM5AkKOlI82LFmFsnS/MuxCpHJ+4lKCQdmqRMi3o8ZbQZoFo9kifA/+3ndPWUChvAooMUuSLSfl1EZXP73IYi/ilBSBHTaEEcOl96DMCp1K3UpZhJshOpkkUYBRzvyA5EnBJG5xosk/nMTfF9MSLYZ18Tg762Qo3jr87aqucvBEtWDXauMuKbmlST+EXU+1vUSbsPjv/oOzQDg2DOhH/hIZ1a7IJp41kYnH7Y/EDEDorZZvW/XRGObJjwrKs+09l/eRAk9Xx4B7gaBywRO7+PJ2SXkpNX6r6dlKOZHIefXcApweJfJHC975Xrd3wtA2H2M/V/43V3EflQmqR+IpiWxwz+mebfAJeh3xfQhxlm9I8pg96hfbIKyOW7bssVNm3SdjnVqlgZyPl7VDA3DgJAmqqdU2BvkvW8lwwDaR+h/mv22qtckY6fKlbTHKlYTuQYjwGa1c4YopiP7haZFl7DgU72NxjUoO4OraxdDpImWavBYeOu8s2zOqT1GpI1ASVQuSJ2RMBUz1w9qYTodWd9dY9KmTn783ZbN7HhDsM7ZYMCOy1yaigZKLT58/g7zofH6ZeOM1edFxMdZO4hB7t6rWCxd+Jl0zrVeUwa0UjrUv6D9Ykc3Hg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(376014)(36860700016)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rygmlrV+KOlGHMJlyaxs4H/6LPwgUQKCcNCEGTkfDelMJRc2vio3ym0JXqrX2bUgT+6ccy20oZw7STjoRPnQJiN5PWuiTLS8xWTx89rDxxG2hLFSDcOSiRdSMgPbJNZwaoPva/kZYRKOFIBkKIEFFSeID3hv6MyvCNmUQjwC3LA21JNBoYLEfFLGfzo6QwBzPCHplvABtKzvh4ARAmMtH0qN1VyCM1iSpJjXvWyUdCPUgUeO+TwoXZycYsDKg2469yBqGXrw/UISKfmzos7c/LIYObAIJJFeWmCmYtifwe4djg1cFLuTVkm1bgDsz71om2mNqkJV5fXfbZ36aiQ9gInAESyo5ihUHWHXlLMmDjh10ACVncCW1fTg/IeV4yWh1GOueyBp/kROfE5M3QzvL3z1ce/YqML+IMkuHvewU1+O0mACQAVJCjbI0XtTa7P2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 17:22:24.2291 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4767f349-fd1d-4341-0d0b-08defc841a76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8289
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


On 8/14/26 06:27, reza.jelveh@gmail.com wrote:
> From: Reza Jelveh <reza.jelveh+git@gmail.com>
>
> The platform powers the NPU down as soon as the driver stops its
> firmware, but aie2_hw_stop() never recorded that transition. The PCI
> core kept tracking the device as D0, so on the next system suspend the
> noirq phase attempted a D0-to-D3hot transition on a device whose config
> space returns 0xffffffff:
>
>    Unable to change power state from D0 to D3hot, device inaccessible
>
> The platform's power state was then out of sync with the kernel's, the
> SMU idle condition was never met, and suspend-to-idle did not reach the
> deepest state. On resume, aie2_hw_start() re-enabled the device without
> requesting D0 first and failed reading the SMU mailbox (0xffffffff,
> -EINVAL), leaving the NPU dead until reboot.
>
> Record D3hot at the end of aie2_hw_stop(), while the device is still
> reachable, and request D0 at the beginning of aie2_hw_start(), so the
> kernel's PCI power state always matches the platform state. Skip the
> firmware stop in aie2_hw_suspend() when runtime PM has already stopped
> the device, and demote the "device is already stopped" message to debug
> level.
>
> Signed-off-by: Reza Jelveh <reza.jelveh+git@gmail.com>
Thanks for providing the fix. Could you add a 'Fixes' tag?
> ---
>   drivers/accel/amdxdna/aie2_pci.c | 20 ++++++++++++++++++--
>   1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
> index a7b923005..ad14e4fc6 100644
> --- a/drivers/accel/amdxdna/aie2_pci.c
> +++ b/drivers/accel/amdxdna/aie2_pci.c
> @@ -288,7 +288,7 @@ static void aie2_hw_stop(struct amdxdna_dev *xdna)
>   	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
>   
>   	if (ndev->dev_status <= AIE2_DEV_INIT) {
> -		XDNA_ERR(xdna, "device is already stopped");
> +		XDNA_DBG(xdna, "device is already stopped");
>   		return;
>   	}
>   
> @@ -301,6 +301,12 @@ static void aie2_hw_stop(struct amdxdna_dev *xdna)
>   	aie2_smu_fini(ndev);
>   	aie2_error_async_events_free(ndev);
>   	pci_disable_device(pdev);
> +	/*
> +	 * The platform powers the NPU down once the firmware is stopped.
> +	 * Record D3hot while the device is still reachable, so the noirq
> +	 * suspend path does not attempt a stale D0 transition.
> +	 */
> +	pci_set_power_state(pdev, PCI_D3hot);

Need to add

     pci_save_state(pdev);

before pci_disable_device(pdev) ? (and pci_restore_state after 
recovering to D0)

>   
>   	ndev->dev_status = AIE2_DEV_INIT;
>   }
> @@ -318,6 +324,13 @@ static int aie2_hw_start(struct amdxdna_dev *xdna)
>   		return 0;
>   	}
>   
> +	/* The platform powers the device down when the firmware is stopped. */
> +	ret = pci_set_power_state(pdev, PCI_D0);
> +	if (ret) {
> +		XDNA_ERR(xdna, "failed to power up device, ret %d", ret);
> +		return ret;
> +	}
> +
>   	ret = pci_enable_device(pdev);
>   	if (ret) {
>   		XDNA_ERR(xdna, "failed to enable device, ret %d", ret);
> @@ -427,12 +440,15 @@ static int aie2_hw_start(struct amdxdna_dev *xdna)
>   
>   static int aie2_hw_suspend(struct amdxdna_dev *xdna)
>   {
> +	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
>   	struct amdxdna_client *client;
>   
>   	list_for_each_entry(client, &xdna->client_list, node)
>   		aie2_hwctx_suspend(client);
>   
> -	aie2_hw_stop(xdna);
> +	/* Runtime PM may already have stopped the device. */
> +	if (ndev->dev_status > AIE2_DEV_INIT)
> +		aie2_hw_stop(xdna);

This is redundant check. aie2_hw_stop() already checks it and returns early.

Thanks,

Lizhi

>   
>   	return 0;
>   }
