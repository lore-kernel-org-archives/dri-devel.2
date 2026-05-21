Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D221CD5BAC
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 17:34:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1B1810E4F1;
	Thu, 21 May 2026 17:34:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="baUJIeGD";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011037.outbound.protection.outlook.com [52.101.57.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C58D710E4E8
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 17:34:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TtqERKTnfElyjpDsOQubK0ZsC1OQOrO+Uhty7ktQgrro3vjakyA0vbxDJb5PM9PzeUvMx2iyyWgapQfjSANnyKjWDRk636StT1ZADLBiFLFmjqTs90E0Rsf56GDx4ADplZUeV1JKnnI+wjB+SP59IT+7crBo4KD5xMZLGyAXe23HntUXSb1sazTtgqjqRmykcJt/GjRyd1YLdhyL1qTJYp5+ywQDTUY1rjTTnlv7JyfcKwU5sgWJ5teDEvHkMhCYuveUhQIoTW0go/4wVsPe4G3uzZRRzWg4zRs79sdZqfPUCyFPE/fJHE4G4QWWdZscocWc7OqKJHdS5102BpGN+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zkzvJqx2EmxiE8z3q8qC1XcO1zG5sB+8zpMt67Xv778=;
 b=GPqDFo/cZCZtHKPalNPrnlFtNpIbztzPuFLCaT1IagGf/IS/HGRT9BNTeqAYJL1MhS8TVM3P3nv7BQ9InPkqfk9ajekazWFvw3to1dpdIDS5YIC56Cw4q7KQEarX7emoXtVv/D3voWqcL8SzE+TvQxvmIuK/la+xcDnfoVR/291ru9P5uWsKyiRwCpFNfy5IDSIhADqAKDX3JLq4J+BKcnGj60Dvxq+hc6/2pjPYr98G3AIKr6SEDUVXXM7tCffy4lXVNQEfw2FEO64NBd49JxD058LU50QP1H4jzhWURmYv9Rlou0vS35+y/L4KQuDYl9xdffdlO8ulsrtouW5OnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkzvJqx2EmxiE8z3q8qC1XcO1zG5sB+8zpMt67Xv778=;
 b=baUJIeGD76X5FR3glKJpwy8+DC0fO9MG/nBrOY4fuAq7P8gBw7OLZ5DFKv2uTLAmYfuygQXndOSU/hSYhMxD1ZLMieNemHxUQgJ7vFs7CnNyUB6FAc0iPII7xgu166jTrJwceKlzfbiwMOogiUrt5oBpc7I6NYS6jSdg7CqHtwE=
Received: from BY5PR03CA0004.namprd03.prod.outlook.com (2603:10b6:a03:1e0::14)
 by DS7PR12MB5959.namprd12.prod.outlook.com (2603:10b6:8:7e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Thu, 21 May
 2026 17:34:19 +0000
Received: from BY1PEPF0001AE1D.namprd04.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::6f) by BY5PR03CA0004.outlook.office365.com
 (2603:10b6:a03:1e0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.11 via Frontend Transport; Thu,
 21 May 2026 17:34:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE1D.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 21 May 2026 17:34:16 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 12:34:15 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 10:34:15 -0700
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 21 May 2026 12:34:15 -0500
Message-ID: <3184166e-2f82-3e3e-6350-962ab38cde27@amd.com>
Date: Thu, 21 May 2026 10:34:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/accel/amdxdna: add debugfs support
Content-Language: en-US
To: Md Shofiqul Islam <shofiqtest@gmail.com>, <mamin506@gmail.com>
CC: <dri-devel@lists.freedesktop.org>
References: <20260519203236.252068-1-shofiqtest@gmail.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20260519203236.252068-1-shofiqtest@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1D:EE_|DS7PR12MB5959:EE_
X-MS-Office365-Filtering-Correlation-Id: 53dcee34-1e02-45de-82bc-08deb75f2e63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|13003099007|22082099003|18002099003|56012099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: OrPBfgZ2IuaEyvqp+JOG1UPy7WLiBE0LpG+2EL6qDEs+YrgOTtCaX3E/NOhpUIBguuGpNA6szBtOz+QW9rN/EnpE1wPu6NEi25OntgEZ82nX0mOB0kiw+howvv3Zpo7uD1p1ZSFTE+jOEBYr4tw0Z06QFyfVVTZO60kZxroVqTFUMibAAWqrFYHXyiMVU5FB7/zsjmoXguATVygbe446tZ6qm7GNmkFSGPUOogm68Q6jNsip2QvMnU8mpqZhOE+A9ZoSIuSVoygnvyryRgZ8sxZPsDlemk1Iy4lXjKhm2o2PF4qBJwzGt/+vlpiroY79okKz532MnkZnTUTXYuuUZsOE/FvcfPr43ENWBS/oAUU4YUflfl/WMy5pD6jRPQBAe5HdCPCuA/w/bLOuroK60cgB2JENYAzxAmzCkD0qAXQ5BYBe9frbDbk681xwHasfTWXmccENxZpu02VtlUL0o6VfP61R0GglPxAzcQujn+jN/yfKx1sga3ZD+sH2ijGjOCyhL7U4+NPUs+g+z1yCiwO62Yg8cJSxL4hIPXJWim0TOPxUWof20tGRfczyDkJ6wMlGx0WJe4UCjJnF5IYlyauT0QLWIA8IqpXXnVMrz0ci0K3loYCW0w/tZSoxO3+EmR4F8LbIaxBuBxRlLiuif+xRF2Lor7otvs5Thug7dX8Q6slo9iKUwZdJaPk2f58h
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(13003099007)(22082099003)(18002099003)(56012099003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BJyKkRkpm+pFNuuHqVGGRmy+gVznip6qQjtYRJbuKCHd76CCUXg2jbkTmsJf+7Rdr7QYfawpHzGoO6lACPMhfEBD2bP4tKKVOjLFm9K2ylquxs4LrohNtuImzzKgICkKzCI/acZsAp/jQlAtdmBreYN0FJk/pi1YhCYCKqisR3mzcluTA/W0Iyyu5VX6uaxRPxVU2ctp10jBQ1f2Y4lvIszs5Wcc1dtCSZdpG6qzTbPZq1xqHvWrlfErn4kFO61iiCgXLVUKc8hVy5Kp9//t4GUfssjd1v9kqfMDzM1yYdLaB1fVwBdhhYuPAm8ek0FYzno7B/NQJmoYT7oA9QqKQGEL/diCAEvQfc97KR++dCBXHwsP8MWN7Td3a/N8FptCqN6t7fMwWWLfZ4jqDMwJTcd9ndbY+NI6g/RD4iMEi0jqPBRZ/AVdlgUhCDyfSF8f
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 17:34:16.0413 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53dcee34-1e02-45de-82bc-08deb75f2e63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5959
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


On 5/19/26 13:32, Md Shofiqul Islam wrote:
> Expose driver state through debugfs to aid debugging and development.
> Three read-only entries are created under /sys/kernel/debug/accel/<N>/:
>
>   - fw_version:  firmware version as major.minor.sub.build
>   - device_info: device VBNV string and device type identifier
These are provided by sysfs already. (amdxdna_sysfs.c)
>   - clients:     per-fd info (pid, heap usage, total BO usage)

This is also supported by 
https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/e0169d0c690f03f379bf71d9332bb2065a5c6a05


Thanks,

Lizhi

>
> Resolves the TODO item in drivers/accel/amdxdna/TODO.
>
> Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
> ---
>   drivers/accel/amdxdna/Makefile          |  1 +
>   drivers/accel/amdxdna/amdxdna_debugfs.c | 63 +++++++++++++++++++++++++
>   drivers/accel/amdxdna/amdxdna_debugfs.h | 17 +++++++
>   drivers/accel/amdxdna/amdxdna_pci_drv.c |  3 ++
>   4 files changed, 84 insertions(+)
>   create mode 100644 drivers/accel/amdxdna/amdxdna_debugfs.c
>   create mode 100644 drivers/accel/amdxdna/amdxdna_debugfs.h
>
> diff --git a/drivers/accel/amdxdna/Makefile b/drivers/accel/amdxdna/Makefile
> index cf9bf19de..01a809d88 100644
> --- a/drivers/accel/amdxdna/Makefile
> +++ b/drivers/accel/amdxdna/Makefile
> @@ -10,6 +10,7 @@ amdxdna-y := \
>   	aie2_smu.o \
>   	aie2_solver.o \
>   	amdxdna_ctx.o \
> +	amdxdna_debugfs.o \
>   	amdxdna_gem.o \
>   	amdxdna_iommu.o \
>   	amdxdna_mailbox.o \
> diff --git a/drivers/accel/amdxdna/amdxdna_debugfs.c b/drivers/accel/amdxdna/amdxdna_debugfs.c
> new file mode 100644
> index 000000000..6806698c3
> --- /dev/null
> +++ b/drivers/accel/amdxdna/amdxdna_debugfs.c
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024, Advanced Micro Devices, Inc.
> + */
> +
> +#include <drm/drm_debugfs.h>
> +#include <drm/drm_device.h>
> +
> +#include "amdxdna_debugfs.h"
> +#include "amdxdna_pci_drv.h"
> +
> +static inline struct amdxdna_dev *seq_to_xdna(struct seq_file *s)
> +{
> +	struct drm_debugfs_entry *entry = s->private;
> +
> +	return to_xdna_dev(entry->dev);
> +}
> +
> +static int fw_version_show(struct seq_file *s, void *v)
> +{
> +	struct amdxdna_dev *xdna = seq_to_xdna(s);
> +
> +	seq_printf(s, "%d.%d.%d.%d\n",
> +		   xdna->fw_ver.major, xdna->fw_ver.minor,
> +		   xdna->fw_ver.sub, xdna->fw_ver.build);
> +	return 0;
> +}
> +
> +static int device_info_show(struct seq_file *s, void *v)
> +{
> +	struct amdxdna_dev *xdna = seq_to_xdna(s);
> +
> +	seq_printf(s, "vbnv:        %s\n", xdna->dev_info->vbnv);
> +	seq_printf(s, "device_type: %d\n", xdna->dev_info->device_type);
> +	return 0;
> +}
> +
> +static int clients_show(struct seq_file *s, void *v)
> +{
> +	struct amdxdna_dev *xdna = seq_to_xdna(s);
> +	struct amdxdna_client *client;
> +
> +	mutex_lock(&xdna->dev_lock);
> +	list_for_each_entry(client, &xdna->client_list, node)
> +		seq_printf(s, "pid %d heap_usage %zu total_bo_usage %zu\n",
> +			   client->pid, client->heap_usage,
> +			   client->total_bo_usage);
> +	mutex_unlock(&xdna->dev_lock);
> +
> +	return 0;
> +}
> +
> +static const struct drm_debugfs_info amdxdna_debugfs_list[] = {
> +	{ "fw_version",  fw_version_show,  0 },
> +	{ "device_info", device_info_show, 0 },
> +	{ "clients",     clients_show,     0 },
> +};
> +
> +void amdxdna_debugfs_init(struct amdxdna_dev *xdna)
> +{
> +	drm_debugfs_add_files(&xdna->ddev, amdxdna_debugfs_list,
> +			      ARRAY_SIZE(amdxdna_debugfs_list));
> +}
> diff --git a/drivers/accel/amdxdna/amdxdna_debugfs.h b/drivers/accel/amdxdna/amdxdna_debugfs.h
> new file mode 100644
> index 000000000..e742a81fe
> --- /dev/null
> +++ b/drivers/accel/amdxdna/amdxdna_debugfs.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2024, Advanced Micro Devices, Inc.
> + */
> +
> +#ifndef _AMDXDNA_DEBUGFS_H_
> +#define _AMDXDNA_DEBUGFS_H_
> +
> +struct amdxdna_dev;
> +
> +#ifdef CONFIG_DEBUG_FS
> +void amdxdna_debugfs_init(struct amdxdna_dev *xdna);
> +#else
> +static inline void amdxdna_debugfs_init(struct amdxdna_dev *xdna) {}
> +#endif
> +
> +#endif /* _AMDXDNA_DEBUGFS_H_ */
> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> index b50a7d1f8..19866dbed 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> @@ -15,6 +15,7 @@
>   #include <linux/pci.h>
>   
>   #include "amdxdna_ctx.h"
> +#include "amdxdna_debugfs.h"
>   #include "amdxdna_gem.h"
>   #include "amdxdna_pci_drv.h"
>   #include "amdxdna_pm.h"
> @@ -319,6 +320,8 @@ static int amdxdna_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   		goto failed_sysfs_fini;
>   	}
>   
> +	amdxdna_debugfs_init(xdna);
> +
>   	return 0;
>   
>   failed_sysfs_fini:
