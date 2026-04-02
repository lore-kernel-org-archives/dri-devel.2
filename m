Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7915DD6AAEC
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 17:31:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC4FF10F2C3;
	Thu,  2 Apr 2026 17:31:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZJ0lYhDp";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010000.outbound.protection.outlook.com [52.101.46.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9248410F2A3
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 17:31:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=em8QkiuWjoflogbHoKc5gHT0V4rcP85hW9y2AtbaLRTtv+BO7cIyV8Q2U5+m9O73GhKOTp30uJfLqmKbeLH5MH7GEgm7t8M+Xiqh6UcB0VJeB6k3KklMS3gC+T+4zebXKmVXIDaV28scCZboOby0AccXcpWiSwuIeiirwFTva9iaKXrZ4gSeb3RhWKKPD2mCWd0aUZA42hEmIE8doCKaVvjxj68axZaFvCR64qwKG7wjSdTbBEWytIQl/b172HFYT1uckk2KFcspr1RD0W+QxzUrijicB8r3SDpzNId/rMUDpgvhPG6+Z5IkKoVN40+f8o5e9h8JFdSj6q+N28emFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6HV7kPsg65Sb5+a1ezX0EJ0jm6dnOXkh41LdNkkHTE=;
 b=D7IeWL2ci8Boo7Mk59p8tYyyVGoumWR1sZPF9QLBoWsnkb2yK7VXMQPACmGFfpPF9Rec3nq/rDOvMD5DPvLpkIRLAZgjW5QbzaunqpT0Ix+SA5y+X1vssvm9kuGWJfcnulSOkZE7v9r4mJ+RYEYCv3bQA7fD253AvgOZJA5AkkIsGY+2Zc6T3yLaDA7OnZsR7R1I374dueUzCOnuMsVQTGG0gL5IrW2OgXsG5+LBch4tB5sNdR3IEPewrAUQEC3lGyzj6hjDT92DQ55WcUKdZpWkMOrR/utaJERirNc4e42Q41twKLoMU8lEZRZOsTg2Ui6aJ+NCka30pL4U3UmXJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6HV7kPsg65Sb5+a1ezX0EJ0jm6dnOXkh41LdNkkHTE=;
 b=ZJ0lYhDpBqRwqNJaY05f5TBz4LHUfb0Utw0fSORaPELexZGPFKDwAeKkay/GSW8NurZAmoVk1JdJJFqjRJl5erB1rhF/LT1Q3DXtIwJKLNRSuRtgo2tEwXTBuGRkgmgEAYX9uwS8Rsi3JzMK/fQFhwOmoW0zezKrNeNt6WQQxZM=
Received: from SN7PR04CA0221.namprd04.prod.outlook.com (2603:10b6:806:127::16)
 by DM4PR12MB5913.namprd12.prod.outlook.com (2603:10b6:8:66::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 2 Apr
 2026 17:31:31 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:806:127:cafe::d9) by SN7PR04CA0221.outlook.office365.com
 (2603:10b6:806:127::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.18 via Frontend Transport; Thu,
 2 Apr 2026 17:31:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 17:31:30 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 12:31:30 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 2 Apr 2026 12:31:29 -0500
Message-ID: <265a7ef1-8cbe-1300-8bc1-1958b7eafc7f@amd.com>
Date: Thu, 2 Apr 2026 10:31:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] accel/ivpu: Trigger recovery on TDR with OS scheduling
Content-Language: en-US
To: Karol Wachowski <karol.wachowski@linux.intel.com>,
 <dri-devel@lists.freedesktop.org>
CC: <oded.gabbay@gmail.com>, <jeff.hugo@oss.qualcomm.com>,
 <maciej.falkowski@linux.intel.com>, <andrzej.kacprowski@linux.intel.com>
References: <20260402125526.845210-1-karol.wachowski@linux.intel.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20260402125526.845210-1-karol.wachowski@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|DM4PR12MB5913:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c7d29d2-8c8c-4b20-f373-08de90ddad5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: +2FEKKBwrGuDouJHUtTs3UKbbmPVyJLLCPxDfJ0ZJa592vrjaBkHz/KvP7SrtYmYKgbCuuqVfFOKj2nQgt+Oqmfb42vHi2OeL5BOzpYFGJ3WegXrZ7MjxIfq2o/VHoGmulVexoatpChqaG0p5WEFq6XVfRBZZ7hH62I109XzTl0yQJngGuHv5VsDwPn3Mf92XuJDcyDSKIxZAl7STh1DBTDJMiJkFXlBCjGWvWBDMtsUufpX0td1/Z9av8npRWi2z/tc6fhMDTDmohM42ylwDKZU82Ggmy/c6hkB/YVrJiA6x5BB0MiiZino5oX33QrAXrOIBL6O0wORwBwjs+IKGM7OZvSAowUQL0vBBc7Rk+diONNTNXqf1GQxyK1Qc2fOh2UOE9CkHm80weHNfAaFo5+YSbwQnTKQkROI8dxHVkwlHJyGmttvt8CKWjPfbhZLNYE3xNUH2ZNBDiCGa/Gs44ABCJ7SehM7O6IHSeGsGCsZgPQ7RZ30s8tDRIprnRh0QRtAYcp8fIA8wdAfBL5ScQbIjFZR6ZrzatyDEySiQy4GIidHQ8gwcDKYO2SrS5nwbWHtvMpoEsjPXcMhxf3YU8p/JWFu9meZ5KUTjtZOXRFMuTSTztm/47uRT5RRVdao+yG9+2jChfDugWRgfcrGuScA/uIXBCJobvuXTEZ83LY3G3ViAcYiFaTLmWFbr/GNKEDG6sYK8JTzTlSq3EaJkIUsdn6yLoGR/o5SWFrLk1XIO+jWLO/w2ZofsqsOXjlyxMmIkXb26y40KOT8ldDdvw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: shyZWKVy2TMoKzJVf18PSY5OSbAWQSIHhUHnc9q628bdM+T0Nhfjjl3mXzlSh1G0xAqjM6KZX9H/g8ylYaVjXIiAhYmH4idOsa2R42d3VEqKUg3nmBsWUeCoTk6/52qKOtw08hvcXU39sZIiRMJs5ZQZ5Lnoyz8e4+9ktw/YwMz4EgHbinZZ9HX+44vxizJ45AB+epsy8avORygTLpjzXg8IazfDgrUGva+oqTwyglfJ5+uYqjIc5UyGXhH8aQg67uPCfwozDNvnq+7CgqepArHdyvqUto9K3m+uLqJAA1XjJVaZ7CkrQLduFJ95D/EJJxj41OzlkqBmAQ8kUwR0BFyUVg+TNcXnHsdh0Dg9wHnuUaoN9VfPcMmew3+fGDw/Il7E6QcS58IEaCFSgWjLTqX8Vcvdi0qHFAVXEtF8jAkt7N8muoLEwwBi6VmEFnzW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 17:31:30.3573 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7d29d2-8c8c-4b20-f373-08de90ddad5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5913
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

Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>

On 4/2/26 05:55, Karol Wachowski wrote:
> With OS scheduling mode the driver cannot determine which context
> caused the timeout, so context abort cannot be used. Instead of
> queuing context_abort_work, directly trigger full device recovery
> when a job timeout (TDR) occurs in OS scheduling mode.
>
> Fixes: ade00a6c903f ("accel/ivpu: Perform engine reset instead of device recovery on TDR")
> Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
> ---
>   drivers/accel/ivpu/ivpu_pm.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/accel/ivpu/ivpu_pm.c b/drivers/accel/ivpu/ivpu_pm.c
> index 83da9b297f37..c1ce8329790e 100644
> --- a/drivers/accel/ivpu/ivpu_pm.c
> +++ b/drivers/accel/ivpu/ivpu_pm.c
> @@ -221,6 +221,12 @@ static void ivpu_job_timeout_work(struct work_struct *work)
>   
>   abort:
>   	atomic_set(&vdev->job_timeout_counter, 0);
> +
> +	if (vdev->fw->sched_mode == VPU_SCHEDULING_MODE_OS) {
> +		ivpu_pm_trigger_recovery(vdev, "Job timeout");
> +		return;
> +	}
> +
>   	ivpu_jsm_state_dump(vdev);
>   	ivpu_dev_coredump(vdev);
>   	queue_work(system_percpu_wq, &vdev->context_abort_work);
