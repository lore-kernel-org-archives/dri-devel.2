Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859D3C5CFDB
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 21:27:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90F1E10E45A;
	Wed, 12 Aug 2026 21:27:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0s9UJRaX";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010018.outbound.protection.outlook.com
 [52.101.193.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EF8410E45A
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 21:26:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xTzhuW9Oeyhx9i31Pa3usLa5WjKV04JYbJEKBE6q6/rS1BByNYh6UQq1qotoGdd/kQd6Kco2FDvdd36xaQox71V0I9C+pYfk4BcOUUV1kRFRdzwO93XZfmUA7zOPYFUNmiitM7JqojG29Oiho97Qhdx9vqiXDzgOv4dYtzQZdH8XQkDS5f48+VcA3ZvMZj3QI/P5fR1ufTEeppFS89TlKfU+vtlWffDdFwUSFIPDGPqhtQ3iDj+TLEyyIP2KsSnr0nrSPXi5NETGQ+U24k8YYgfgWfvnMZML8tJR8o/5r9NC8rCX5G1wI//lti3YustoTKnyhbkOeKQ9TpEw/jaJvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H43nrar5YyIINjyA3b1epLLYcFmnqHVmSdHEF3WEyas=;
 b=n7Q8NVRmCryOViKbEx/iJY8xX65j027Z9xZ0C4D1IJja3Crw1EvOHoGU+tIupMLFHFrMdkoE8C1UUP4aMnMdkQw6Eu+ivkP+nFORwXH4YJbdPsp2P0T/hy3e6kdXjnKZ07l7UC1FqqtYebGOVNOF1yJNB/WAOmGbgXBylzxpTi6KJPod3xSx3oTA7nVq0GDei3cEvShQOHf57SOO82l5uj7zEZWVK1W6livBOq8Zrrn2F1f2NSSPzk9k/5oS7y5MfaysQ0r7XTFuDTcWBJ0xw2iLBXExMRFKL3jWm4lXnuQ3bFnOZf22QR2UYmfIrjrPsYO6BsR8dy89h86NY+tawA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H43nrar5YyIINjyA3b1epLLYcFmnqHVmSdHEF3WEyas=;
 b=0s9UJRaXfNspv+HyjB2UDh9RPFnkZgPXZLHlzoFmUA12N9QnUBe/cysdXP0vo+hnbaAvD2HhZv52UyhssWD9RdEAQXFeaHW8OOn4AgEXA8ry8mJhNehDt+5y5oVDM5ns0ayERrZiIjJ3RB5j3EOvPvqhDnnQQkK5bEfzT382R8E=
Received: from MW4PR04CA0118.namprd04.prod.outlook.com (2603:10b6:303:83::33)
 by SJ2PR12MB8720.namprd12.prod.outlook.com (2603:10b6:a03:539::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 21:26:53 +0000
Received: from MWH0EPF000C6188.namprd02.prod.outlook.com
 (2603:10b6:303:83:cafe::96) by MW4PR04CA0118.outlook.office365.com
 (2603:10b6:303:83::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.13 via Frontend Transport; Wed,
 12 Aug 2026 21:26:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C6188.mail.protection.outlook.com (10.167.249.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Wed, 12 Aug 2026 21:26:52 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 16:26:52 -0500
Received: from [172.19.68.47] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Wed, 12 Aug 2026 16:26:51 -0500
Message-ID: <8f4457fd-ef92-4783-b8d5-b4bb1f61de04@amd.com>
Date: Wed, 12 Aug 2026 14:26:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Skip unmapped range in
 aie2_populate_range()
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
References: <20260812205628.810816-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Max Zhen <max.zhen@amd.com>
In-Reply-To: <20260812205628.810816-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6188:EE_|SJ2PR12MB8720:EE_
X-MS-Office365-Filtering-Correlation-Id: c7d4a18d-c632-4587-b4c8-08def8b86da6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: Bu20TD5oL8ftroF7sSYRXxTZfHx9E0uSGLqqFz3D3Nnat/7r+tdAJLxSjFfKAxNAzuxqIScbnmdAZbMM87qrxRxjiEDYJ5p+51xLTf+xiKQC7JgTs7qPQWUTczNO0Ne91QmlIssGoYn+ptfYwFT/Ox+zBBJZiUTqyiL7XL8hOftfJ/qYEHnW0Nk8BWcdo0PCN9fK1tgRQvN0l9Wy+P+kcRAedPNQpBgoLtsRxHfkbpcrSE79akdI8TWcA/6m/cQd2DjRcCKOZ4Tuyu6/fy3FfpnQvv/iAgeUxq3MFJNBWxZ2RC+0Yee4jVJxBrvQscUHQhYpkiPa7CGyq2Od1JEUdk04zkPmwUmYACVSQxFomOY+DefRKWboQcGbKPVoXAHQuel7ADAsw5qS/8oDMcS0OBVmruRB7dmRt5qukX7v0oaqSs4sjpLJ3I5yrskX6BQ9C8GxI3MLBQw01ly00iXklpRm/cqhKYHzQItb7SUJOzvQVmeFi3C8pwnx/4UJVdT3+X46VrF+WMp3VSWMRrS6ARipdHKdASiJ+O/zbmjdvqXgROn4erlV0yvsAInKrWuxEhcbA2Py/3Mt9GtzIYZ2iNIG1peXnn6MXHeCqM9vLzpHUgRj7A6XG4sovRnwEZHXlfJRp7SC+xQIlS6HrBSW4ZtdGpzt7o5Ufe+of9vfOiQQGPVxehaNNRT4RW8kBXVPX7QzUZgoViwW83Y1O7YIWw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /x6JXBEoBGrYVt7728XN4LQi+i6qjhkC6PXFDBIzgaB9uiFvd40dJEX2M92FWwVAJwT6G7GVuQT3HF90Vx4O10h9ov4HyudufI/496Pda3L0N0w8Fq7fxEUGMy1/+8bPY+f9kA3qxh1AieYgOzOS6KzOVMJK0t72KYdf6Emva+wL1Au1AP/BjdmqR81np+2Q+zynX8vTE+rvbXpn3kHtCXZCw/e4nWrwYFjjoLTeiXxkxFQX8LWhtkHSlLopgITG4CTO7SOSHceuoLaD4wNGyaR4VTrdfh6zpdx9Tp8Uor60u6sYBP+xrLu3SzpxcfGiVD7mv4XaJew5ImcCtuMHB/AXWngArHwDODY6Dm8OEJ7nX355DClDJ6bLODeWSAsjHZ092BSPtnP/ifSJ0k8ZFoLQe8vpS23ySzS9lkvM3wtC2s4nVx1vaHc5qcEwkN2u
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 21:26:52.9164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d4a18d-c632-4587-b4c8-08def8b86da6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6188.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8720
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



On 8/12/2026 Wed 13:56, Lizhi Hou wrote:
> aie2_populate_range() incorrectly failed jobs for BOs with multiple
> mmaps: if the unmapped entry appeared first in umap_list, the loop would
> pick it up, call hmm_range_fault() on a gone VMA, and return -EFAULT
> without ever trying the remaining valid mapps.
> 
> Fix it by skipping unmapped entries. After the loop, if the map list is
> empty or all maps are valid, map_invalid can be cleared normally.
> 
> Fixes: e486147c912f ("accel/amdxdna: Add BO import and export")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Max Zhen <max.zhen@amd.com>
> ---
>   drivers/accel/amdxdna/aie2_ctx.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
> index 4b3a62aa8798..8d9c283f606a 100644
> --- a/drivers/accel/amdxdna/aie2_ctx.c
> +++ b/drivers/accel/amdxdna/aie2_ctx.c
> @@ -1052,6 +1052,16 @@ static int aie2_populate_range(struct amdxdna_gem_obj *abo)
>   	found = false;
>   	down_write(&xdna->notifier_lock);
>   	list_for_each_entry(mapp, &abo->mem.umap_list, node) {
> +		/*
> +		 * Skip entries that have already been unmapped.
> +		 *
> +		 * If userspace unmaps the address and later submits I/O using
> +		 * it, the IOMMU will reject the access and report a fault.
> +		 * Ignore such entries here.
> +		 */
> +		if (mapp->unmapped)
> +			continue;
> +
>   		if (mapp->invalid && kref_get_unless_zero(&mapp->refcnt)) {
>   			found = true;
>   			break;
> @@ -1059,6 +1069,12 @@ static int aie2_populate_range(struct amdxdna_gem_obj *abo)
>   	}
>   
>   	if (!found) {
> +		/*
> +		 * This also covers the case where all mappings have been
> +		 * removed. There are no invalid mappings left to process.
> +		 * Any subsequent I/O using the unmapped address will be
> +		 * rejected by the IOMMU.
> +		 */
>   		abo->mem.map_invalid = false;
>   		up_write(&xdna->notifier_lock);
>   		return 0;

