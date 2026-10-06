Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 950EDCA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 17:01:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBCFB10E0AC;
	Tue,  6 Oct 2026 17:01:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xJ714r4h";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013026.outbound.protection.outlook.com
 [40.93.201.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5279F10E0AC
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 17:01:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tKHfsMs+SbcwmhYEtuBSbzdgTRJwsgkkiZE99UELzGNqb5DYKSI5ZKDu6DVgMRRFdNU0t7U3FoNrPeasAqzEvw973Zv7WHbd01wn8U5WVmcuDNdNRcllQv1GyHhrb4qGqtOR5A73tgvKCAVnCOEd5ofw6V4lLVuWggM0jy1R8+PzClGB1P6rcBkIhlYufzQDFJLbHJbk+ronxjnFFG+w2dbX9MBrGeYkV8sq4MOGis712KrIqWQ51jcnQtSYZjQWRddIfzKsa3RwgOQ8QutW82og6UFTA95UEXu9a92bhzTY5O5V4bqrH0lkcTBZ7OUNAwSmV5C10A0IRxz7kXrxkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EN7Hx46Siv23gguu2ZtvuYlYiK5i2XjMf7kTziYHdYA=;
 b=J5zg+bgLzRIx/6sKHotMNeA2J4U235gfhObX/BGlel+KLX6uwrg3fMSk+4MZjthD6cHJ4qjuKhhitl68nUiYGkwZy0m3fysX1t+2W5WVp730rDI4IEKZE1bInYMlBdE5oRdi2HVQEttMjvVIPbC9u5+iSVDJAUJ7YcGFsumvpHZzC3HjuQBfQd9ugLcQ4f/s+tl3zaTlOKJPi85r/wtd79RpSaDK0CnZPVV58uqr4M8iAPiYpNn+rMbHY+ULsD1EokGHqV/jgdhSITui61yCEVkl3mo2dxrkEroihxu5Uy1T3objQ4AhUk7uqkO4OwPqEnro9+rMxYGOI3/kIYTRyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EN7Hx46Siv23gguu2ZtvuYlYiK5i2XjMf7kTziYHdYA=;
 b=xJ714r4hrOe5RYQkTK+s399eoGDKfelOIcdSeGYXXO3xWoM2M8IA3OEj85BCiEyq1XJkhpX7YTsIg7rhqfL1M26CPP7mfXNB3D/x23i27p3LsuAc8RsQFsBvzIxGv+4u9x7XSam9nCqPuuYsz48ndBAQUnpxtMDvdrM9/5eskVA=
Received: from CH0PR04CA0016.namprd04.prod.outlook.com (2603:10b6:610:76::21)
 by CY5PR12MB6035.namprd12.prod.outlook.com (2603:10b6:930:2d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 17:01:11 +0000
Received: from BN7PEPF0000009F.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::1) by CH0PR04CA0016.outlook.office365.com
 (2603:10b6:610:76::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 6
 Oct 2026 17:01:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN7PEPF0000009F.mail.protection.outlook.com (10.167.248.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 17:01:10 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 12:01:09 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 6 Oct 2026 12:01:08 -0500
Message-ID: <8900270a-064a-fc3b-5686-e37ff58c5335@amd.com>
Date: Tue, 6 Oct 2026 10:01:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V2 16/20] accel/amdxdna: Finalize runtime PM before
 acquiring dev_lock on removal
Content-Language: en-US
To: Eva Crystal <0xiviel@gmail.com>, <yidong.zhang@amd.com>,
 <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <ogabbay@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
CC: <sonal.santan@amd.com>, <mario.limonciello@amd.com>
References: <20261006042230.547807-17-yidong.zhang@amd.com>
 <20261006071310.198186-1-0xiviel@gmail.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20261006071310.198186-1-0xiviel@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF0000009F:EE_|CY5PR12MB6035:EE_
X-MS-Office365-Filtering-Correlation-Id: 40f3cc42-5a69-4c5a-31dc-08df23cb6bf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|23010399003|22082099003|18002099003|11063799006|4143699003|6133799003|56012099006|10067099003|5023799004;
X-Microsoft-Antispam-Message-Info: Ze1VbWaTSxD7t92r2HiVkxLY9t3wHsr9jb+1Em6RbmJgbHIR7CSAWjZ+ZGAHXKb7Az/v06nI3G6sZ8Lfx5TTtHdz3IwO/9su5mp9LUOK2C6RoJQdFaTI4wuorfEiuIWxQDMB23GPC5JSMz931OEErPSHAeokHVwE117TrbCO9jAteYDkX0zlzLFuY38Os47u/e/MgzQ70NFpqbZrMDqMxvXd6fk7GJx4AbJOz7CuvbHmMFjM0xRdxqkdxPm1nCr8M2tlXVlIo3VuYTa5tVO8Djz8w2POcCHaVsRGU+S0+3710tHgVY7e0qLJFJediz31UDm7hGspNdx954deJKCxQPAQ7zPVnCcNIorOePhw0hMAg0X3Eh2YQSiAbL8/KTDZwciEXhFrerKz/PV7Pmza2gXxWff+qKdfX3lYskJxKnnbHh4uggXoslX0f/j4ZnrFlY+mr7+p5z4WZEFs+K5X58UVrKBfAa8YnARbHPoNoK4KiVlBOOHt70BbBgqNn4KCMVfHNemJi8XYMzhJXnxZ+eN5EBq8DvAqa1QFSKogDVSzAyczrVwqYGHke6ZGBuhfTz96cVXwctqPmyUNDjcKlR2KltT2mPNkI7qZ2oK/yTFfalX0tXC81tA58Fe2zduTyAxBOwk9nRKtOq2gTvtIUw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(22082099003)(18002099003)(11063799006)(4143699003)(6133799003)(56012099006)(10067099003)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qv0ZyqLaEck5voC9KT7AW9QRQCIt564ki11ulfN11dxbmhnmu+FNhJyYcLmsFmpZ6Dal9Em5annjrdy9SJsDM7QU5BUGT15QFuSmH1rwlANpKAOvGdNjyrFGOxFf1xQyUqfqK6tpQQ2gegoDsodecS9ZiDuzga5cbHqKIrXDbiQiWQCiEDGgmo/QxDmRsCxLb4KKs2Arb80+U38ncLCkckF06U73FryRRN/gCfinkR//Imfrl4i76wmtfhfILXN21jGDsBeorw3rSBNPBKq4paa5qKrNvywtFnzKC5uoUaw/yhySEcANcxgUn6aq5QnHa92HHc6Tyu1qSvKK4TSjikDt4bKd/OwE360c4fv8g7puWx0lXMVt5NZTBAnAp0C6+cx+vUx5VmWGafne+pUHwCbOqcU5C0msEV13exvhL9lZ5ihRTkN64g7BJbOlxp0q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 17:01:10.5766 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f3cc42-5a69-4c5a-31dc-08df23cb6bf1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF0000009F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6035
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


On 10/6/26 00:13, Eva Crystal wrote:
> On Mon, Oct 05, 2026 at 09:22:26PM -0700, David Zhang wrote:
>
>> When the device is runtime-suspended, pm_runtime_forbid() synchronously
>> resumes the device via rpm_resume(), which invokes
>> amdxdna_pm_runtime_resume(). Because amdxdna_pm_runtime_resume()
>> acquires dev_lock, calling amdxdna_pm_fini() inside ops->fini() while
>> holding dev_lock in amdxdna_remove() causes a deadlock.
>> -	amdxdna_pm_fini(xdna);
>>   	aie2_hw_stop(xdna);
>>   	aie2_hwctx_sched_fini(xdna->dev_handle);
> This is worth more than its position in the series suggests: the deadlock is already live on shipping AIE2 parts, not only on the new AIE4 path.
>
> On current drm-misc-next, amdxdna_remove() holds dev_lock across ops->fini(xdna) (drivers/accel/amdxdna/amdxdna_pci_drv.c:457 and drivers/accel/amdxdna/amdxdna_pci_drv.c:463 at 34e9ab018249), and aie2_fini() opens with amdxdna_pm_fini() (drivers/accel/amdxdna/aie2_pci.c:640 at the same commit). pm_runtime_forbid() then calls rpm_resume(dev, 0) synchronously (drivers/base/power/runtime.c:1672), which lands in amdxdna_pm_resume() and its guard(mutex)(&xdna->dev_lock) on the same task. The base wires RUNTIME_PM_OPS(amdxdna_pm_suspend, amdxdna_pm_resume, NULL) and aie2_ops supplies .suspend and .resume, so runtime PM is active on aie2 before this series adds .runtime_suspend. With amdxdna_pm_init() setting a 5000 ms autosuspend delay then pm_runtime_allow(), an unbind or rmmod more than five seconds after the last NPU access hangs holding dev_lock.
On the remove path, pm_runtime_forbid() does not call 
amdxdna_pm_resume(). The PCI core has already resumed the device.

pci_device_remove() calls pm_runtime_get_sync() and pm_runtime_barrier() 
before amdxdna_remove(). That get resumes a runtime-suspended device, 
and the usage count stays elevated through aie2_fini(). 
pm_runtime_forbid() then enters rpm_resume() with status RPM_ACTIVE, 
which returns immediately and does not run ->runtime_resume()


Lizhi

>
> Three things that would help it travel:
>
> * Fixes: 1aa82181a3c2 ("accel/amdxdna: Fix dead lock for suspend and resume") looks right. amdxdna_pm.c had no dev_lock when 063db451832b created it, and 1aa82181a3c2 adds exactly the two guards the base still carries.
> * Cc: stable@vger.kernel.org is warranted, since 1aa82181a3c2 is in v7.0 and later.
> * Could this be split out to drm-misc-fixes on its own? At position 16 of a 20 patch AIE4 series it is unlikely to be picked up as a fix, and splitting it stops the fixes cadence holding up the feature work.
>
> One question: amdxdna_pm_fini() now runs after drm_dev_unplug(), so pm_runtime_forbid() resumes hardware on a device already unregistered with its user mappings torn down. Intended?
>
> Eva Crystal (0xiviel)
> XSource Security
> https://xsourcesec.com
>
>
