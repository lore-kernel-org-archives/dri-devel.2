Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6EAECC6B12
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 18:38:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4957410E962;
	Tue, 13 Oct 2026 18:38:43 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010001.outbound.protection.outlook.com [52.101.201.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4097D10F978
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 18:38:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h9ELwDa4Gv8PFMJXscUVs6PU0l2PjEDEYKCyD/xQJccBtWR11Tc41k4K1UWFvGoQg0tr29Q1481AIw3VIjJDbXLkgW67Grr5u8rj8ymzqAs+OgQWNoiXrM4tmUmahKrJhOyu/7dSZD5jLDUYiuWa0liIxGOc7tdFsSwX4xjH/9b0GuGdWxydNR2g+wCV+CuvdruLKcWMT2j3+PCpYVyMEYpyjxK/X/XtK5bp6s+E0RjX3zX24cYDZ0efY6sjjaS9EjGBL6OO6PwR2nw7f9y2+UuGudHbBaecCC65qnRP+sWyiJs7adzqFMAriqG0sALXdPfoW79n25mlLk1fzm8u/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgSRZQW/MqySc2W3fW2AMc+pmW6DtLwijVZjx2RigMQ=;
 b=hB7KCjs9D2RTq865sulXFuZgAmEjnF9chYyFmMW2eKaYako/UdvjjCb1U4kCXqpZCQS8YCe7OHGMtAxU2FMLsjfXJJ8JBg8ulbOgYB1oMux8ebB0NJCqxkOStnR5MmL1R+883TWKaRzJV7rTcwHAJRm5KZD33mFQlQE+yvljKcG2+qM5ull7pf3BvHdGCXw31TU0j02gwEqmGRhSi27A/LsJaz+k24ewdfNnaxDZ776v4rdQxX2yEj09v/ZaLF5F6hzFSxL107uuULlH0CKbFPVjCbL0hUC532cG917g04K+KWePdSGUDojlg9Zo8hPCVFNasPALirvSGv9p+tChgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgSRZQW/MqySc2W3fW2AMc+pmW6DtLwijVZjx2RigMQ=;
 b=xlM42toOBtNI2N723fk8xr0KmaDdQCYuboGEZ5u1DG9i5BN/g3eD5kNj7qlk9wGKMCBIrsifuhYHFl2DSQGUtdztLSxNtXtiJXNaadPQxmOZY0N2eA0wcdOIVsF0i0aY2seHV/zSD3ZLo74Y3Er/ZDp3oIy47cxnSrRNYvkfRD0=
Received: from BL1PR13CA0246.namprd13.prod.outlook.com (2603:10b6:208:2ba::11)
 by SA1PR12MB6994.namprd12.prod.outlook.com (2603:10b6:806:24d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Tue, 13 Oct
 2026 18:38:30 +0000
Received: from BN3PEPF0000B36E.namprd21.prod.outlook.com
 (2603:10b6:208:2ba:cafe::1a) by BL1PR13CA0246.outlook.office365.com
 (2603:10b6:208:2ba::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Tue, 13
 Oct 2026 18:38:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B36E.mail.protection.outlook.com (10.167.243.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.0 via Frontend Transport; Tue, 13 Oct 2026 18:38:29 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 13:38:24 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 13:38:23 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 13 Oct 2026 13:38:23 -0500
Message-ID: <380059c1-de81-5b0d-7a63-1ce455edc956@amd.com>
Date: Tue, 13 Oct 2026 11:38:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V4 11/19] accel/amdxdna: Decouple AIE4 doorbell and MSI-X
 notify transport hooks
Content-Language: en-US
To: David Zhang <yidong.zhang@amd.com>, <quic_jhugo@quicinc.com>,
 <karol.wachowski@linux.intel.com>, <max.zhen@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <sonal.santan@amd.com>, <mario.limonciello@amd.com>, Wendy Liang
 <wendy.liang@amd.com>
References: <yidong.zhang@amd.com>
 <20261009225343.3079074-1-yidong.zhang@amd.com>
 <20261009225343.3079074-12-yidong.zhang@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20261009225343.3079074-12-yidong.zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36E:EE_|SA1PR12MB6994:EE_
X-MS-Office365-Filtering-Correlation-Id: b9fddbdb-202a-4b88-2a17-08df29592d61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|6133799003|10067099003|18002099003|22082099003|261009223027099003|4143699003|11063799006|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info: xaJrGIEle9zj0GydulekyoKZlqKx42IgpetfhjdYV5aMS2+JxzihbnGaKVMsX2pJ6SMwhovPvSGPZG3ayE9vbpmjrk/SkYbI8Ugfk9K1W8JjfRqTNmuJbubr0Yky7Xb6JF3izysaKqm8HpzzoW3V2+woLW/J8tBy+tW+M2ehLjRPYnaG7tbyAL6TcyO9XPa57/Lmtbz1qrMjDwajAL3FWsvrP+IsK/9Mu3zTo6AymZ1a2r4VIxEU7qEt224+lNaRTJKME42UTiu3OQtA3/wJA51jCqTJBcnTcLbSVM439obaNYsVRoikcBrBFslOzfHbvuVaTNEIDrm8FbWkPwXrrnY7ijsvYuyYwCrC/xo2yBsBYQWskjDzrTI6IasEYiNVUk6kkv1DhFFvxY8PnPO58ianhtWU9AADXBLNZqSn55/2Xh+QeYObNLhgNKq4flLovBXqxZyCPq8GJHqk5m6qFTpFZquIKIkwfLBYdawYV0x9VtkrdKMA6MM8g6QJGvymhIxdqx06+VQi4/XP7KRmUXboB3l86vBjms4zSYZRMIYKAO03od0LGiSuaEZt+h+bKxZc7hmH1Z8gCDF50jbzQ8orKT67ch1Z02rCxCZUlGVJaXyxd7Vnr30+EQteS44A7fnxGVqj/vbW1CjbfEmItQjt+aQ+/ab5MnUPDOfiC2Pk3w/E7H/6jGvEtytGu5VMSearE4ClCvSgdUTZmMZc3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(6133799003)(10067099003)(18002099003)(22082099003)(261009223027099003)(4143699003)(11063799006)(56012099006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HXt3hzwJCulcJGz0GbXbsba96lt6L+B8Sr6AumyD0ipO5iCBlRcEn1svx52O8RNN1fFXFwKquQZ/F+ikZoXMtYRXlJUj8ab3rm0ateACcC+OJqfoxxVymRf99spRiUmPm9nfqAteL1bmdHhLjW7bNzdqGHMJFtCXdavRnEjLvA7emmuKgxG4BU9KN7SB8+TcT3vp8M9wmeNhVW/P4gtm6cUBbhx/42yA+tA9XgVON25/qVByFRI5hZeJWa3jDQVO8kQYdKDYF76u6WvZEqP299q4h6dOFmNUsKAozj7kWi59Ol29HRoQSIbqQwvBo1jJOWLfCJwrNbrxMxeaCJEMGaHtTEBPBPQ9VqboFvarWiLJZllWxu3+AlwhyB9fkHN+7rDlMx/aq4RYHIAWbGRYpnqhXe8KLhoxHcQuU25kprW2xCxJzRgHxJMwpDRas09/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 18:38:29.9638 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9fddbdb-202a-4b88-2a17-08df29592d61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6994
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


On 10/9/26 15:53, David Zhang wrote:
> Separate PCI-specific doorbell and interrupt notification handling from
> the transport-neutral context code.
>
> The new transport functions are wired in later patches in this series.
> Doorbell ringing is not invoked until full context setup and BAR
> validation are done, so no NULL dereference or BAR boundary bypass can
> occur.
>
> Co-developed-by: Wendy Liang <wendy.liang@amd.com>
> Signed-off-by: Wendy Liang <wendy.liang@amd.com>
> Signed-off-by: David Zhang <yidong.zhang@amd.com>
> ---
>   drivers/accel/amdxdna/aie4_ctx.c    | 38 ++++++-----------
>   drivers/accel/amdxdna/aie4_pci.c    | 66 +++++++++++++++++++++++++++++
>   drivers/accel/amdxdna/aie4_pci.h    | 14 ++++++
>   drivers/accel/amdxdna/amdxdna_ctx.h |  2 +
>   4 files changed, 96 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/accel/amdxdna/aie4_ctx.c b/drivers/accel/amdxdna/aie4_ctx.c
> index 5eb918e1d58c..20b725de6ab7 100644
> --- a/drivers/accel/amdxdna/aie4_ctx.c
> +++ b/drivers/accel/amdxdna/aie4_ctx.c
> @@ -22,63 +22,52 @@
>   #include "amdxdna_mailbox_helper.h"
>   #include "amdxdna_pci_drv.h"
>   
> -static irqreturn_t cert_comp_isr(int irq, void *p)
> -{
> -	struct cert_comp *cert_comp = p;
> -
> -	wake_up_all(&cert_comp->waitq);
> -	return IRQ_HANDLED;
> -}
> -
>   static struct cert_comp *aie4_lookup_cert_comp(struct amdxdna_dev_hdl *ndev, u32 msix_idx)
>   {
>   	struct amdxdna_dev *xdna = ndev->aie.xdna;
> -	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
>   	struct cert_comp *cert_comp;
>   	int ret;
>   
> -	guard(mutex)(&ndev->cert_comp_lock);
> -
> +	mutex_lock(&ndev->cert_comp_lock);
>   	cert_comp = xa_load(&ndev->cert_comp_xa, msix_idx);
>   	if (cert_comp) {
>   		kref_get(&cert_comp->kref);
> +		mutex_unlock(&ndev->cert_comp_lock);
>   		return cert_comp;
>   	}
>   
>   	cert_comp = kzalloc_obj(*cert_comp);
>   	if (!cert_comp)
> -		return NULL;
> +		goto unlock;
>   
>   	cert_comp->ndev = ndev;
>   	cert_comp->msix_idx = msix_idx;
> +	cert_comp->irq = -ENOENT;
>   	init_waitqueue_head(&cert_comp->waitq);
>   	kref_init(&cert_comp->kref);
>   
> -	ret = pci_irq_vector(pdev, cert_comp->msix_idx);
> -	if (ret < 0) {
> -		XDNA_ERR(xdna, "MSI-X idx %u is invalid, ret:%d", msix_idx, ret);
> -		goto free_cert_comp;
> -	}
> -	cert_comp->irq = ret;
> -
> -	ret = request_irq(cert_comp->irq, cert_comp_isr, 0, "xdna_hsa", cert_comp);
> +	/* Transport-specific: PCI wires an MSI-X irq, platform an IPI callback. */
> +	ret = aie4_request_notification(cert_comp);
>   	if (ret) {
> -		XDNA_ERR(xdna, "request irq %d failed %d", cert_comp->irq, ret);
> +		XDNA_ERR(xdna, "request notification for msix idx %u failed %d", msix_idx, ret);
>   		goto free_cert_comp;
>   	}
>   
>   	ret = xa_err(xa_store(&ndev->cert_comp_xa, msix_idx, cert_comp, GFP_KERNEL));
>   	if (ret) {
> -		XDNA_ERR(xdna, "store cert_comp for msix idx %d failed %d", msix_idx, ret);
> +		XDNA_ERR(xdna, "store cert_comp for msix idx %u failed %d", msix_idx, ret);
>   		goto free_irq;
>   	}
> +	mutex_unlock(&ndev->cert_comp_lock);
>   
>   	return cert_comp;
>   
>   free_irq:
> -	free_irq(cert_comp->irq, cert_comp);
> +	aie4_free_notification(cert_comp);
>   free_cert_comp:
>   	kfree(cert_comp);
> +unlock:
> +	mutex_unlock(&ndev->cert_comp_lock);
>   	return NULL;
>   }
>   
> @@ -90,7 +79,7 @@ static void cert_comp_release(struct kref *kref)
>   	drm_WARN_ON(&ndev->aie.xdna->ddev, !mutex_is_locked(&ndev->cert_comp_lock));
>   
>   	xa_erase(&ndev->cert_comp_xa, cert_comp->msix_idx);
> -	free_irq(cert_comp->irq, cert_comp);
> +	aie4_free_notification(cert_comp);
>   	kfree(cert_comp);
>   }
>   
> @@ -100,6 +89,7 @@ static void aie4_put_cert_comp(struct cert_comp *cert_comp)
>   
>   	ndev = cert_comp->ndev;
>   	guard(mutex)(&ndev->cert_comp_lock);
> +
>   	kref_put(&cert_comp->kref, cert_comp_release);
>   }
>   
> diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
> index ffe78c0c4e8b..93594211c169 100644
> --- a/drivers/accel/amdxdna/aie4_pci.c
> +++ b/drivers/accel/amdxdna/aie4_pci.c
> @@ -14,6 +14,7 @@
>   
>   #include "aie.h"
>   #include "aie4_msg_priv.h"
> +#include "amdxdna_ctx.h"

Dictionary order please.

Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>

>   #include "aie4_pci.h"
>   #include "amdxdna_error.h"
>   #include "amdxdna_mailbox.h"
> @@ -112,6 +113,69 @@ static void aie4_mailbox_fini(struct amdxdna_dev_hdl *ndev)
>   	ndev->mbox = NULL;
>   }
>   
> +static irqreturn_t cert_comp_isr(int irq, void *p)
> +{
> +	struct cert_comp *cert_comp = p;
> +
> +	wake_up_all(&cert_comp->waitq);
> +	return IRQ_HANDLED;
> +}
> +
> +/* Wire per-cert completion notification interrupt. */
> +int aie4_request_notification(struct cert_comp *comp)
> +{
> +	struct pci_dev *pdev = to_pci_dev(comp->ndev->aie.xdna->ddev.dev);
> +	int ret;
> +
> +	ret = pci_irq_vector(pdev, comp->msix_idx);
> +	if (ret < 0)
> +		return ret;
> +	comp->irq = ret;
> +
> +	ret = request_irq(comp->irq, cert_comp_isr, 0, "xdna_hsa", comp);
> +	if (ret) {
> +		comp->irq = -ENOENT;
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +/* Tear down per-cert completion notification interrupt. */
> +void aie4_free_notification(struct cert_comp *comp)
> +{
> +	if (comp->irq >= 0)
> +		free_irq(comp->irq, comp);
> +}
> +
> +/* Validate and configure hardware context doorbell target. */
> +int aie4_doorbell_setup(struct amdxdna_hwctx *hwctx,
> +			const struct aie4_msg_create_hw_context_resp *resp)
> +{
> +	struct amdxdna_dev *xdna = hwctx->client->xdna;
> +	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
> +	struct amdxdna_hwctx_priv *priv = hwctx->priv;
> +	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
> +	u64 db_off = (u64)ndev->priv->doorbell_off + resp->doorbell_offset;
> +
> +	/* Validate doorbell offset against mapped BAR bounds. */
> +	if (db_off + sizeof(u32) >
> +	    pci_resource_len(pdev, xdna->dev_info->doorbell_bar)) {
> +		XDNA_ERR(xdna, "doorbell offset 0x%llx out of BAR", db_off);
> +		return -EINVAL;
> +	}
> +
> +	priv->doorbell_addr = ndev->doorbell_base + ndev->priv->doorbell_off +
> +			      resp->doorbell_offset;
> +	return 0;
> +}
> +
> +/* Ring context doorbell to notify CERT. */
> +void aie4_doorbell_ring(struct amdxdna_hwctx *hwctx)
> +{
> +	writel(0, hwctx->priv->doorbell_addr);
> +}
> +
>   static int aie4_irq_init(struct amdxdna_dev *xdna)
>   {
>   	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
> @@ -630,6 +694,7 @@ static int aie4m_pcidev_init(struct amdxdna_dev *xdna)
>   		set_bit(SMU_REG_BAR(ndev, i), &bars);
>   	set_bit(xdna->dev_info->mbox_bar, &bars);
>   	set_bit(xdna->dev_info->sram_bar, &bars);
> +	set_bit(xdna->dev_info->doorbell_bar, &bars);
>   
>   	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
>   		if (!test_bit(i, &bars))
> @@ -643,6 +708,7 @@ static int aie4m_pcidev_init(struct amdxdna_dev *xdna)
>   
>   	ndev->mbox_base = tbl[xdna->dev_info->mbox_bar];
>   	ndev->rbuf_base = tbl[xdna->dev_info->sram_bar];
> +	ndev->doorbell_base = tbl[xdna->dev_info->doorbell_bar];
>   
>   	pci_set_master(pdev);
>   
> diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
> index 959ef3695813..9fcdfcc5a15f 100644
> --- a/drivers/accel/amdxdna/aie4_pci.h
> +++ b/drivers/accel/amdxdna/aie4_pci.h
> @@ -32,6 +32,8 @@ struct amdxdna_hwctx_priv {
>   
>   	struct cert_comp                *cert_comp;
>   	u32                             hw_ctx_id;
> +
> +	void                    __iomem *doorbell_addr;
>   };
>   
>   struct amdxdna_dev_priv {
> @@ -54,6 +56,7 @@ struct amdxdna_dev_hdl {
>   	const struct amdxdna_dev_priv	*priv;
>   	void			__iomem *mbox_base;
>   	void			__iomem *rbuf_base;
> +	void			__iomem *doorbell_base;
>   
>   	struct mailbox			*mbox;
>   	u32				partition_id;
> @@ -111,6 +114,17 @@ int aie4_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq, u32 timeout);
>   /* aie4_pci.c */
>   int aie4_restore_power_mode(struct amdxdna_dev_hdl *ndev);
>   
> +/*
> + * Transport hooks implemented by PCI backend. Doorbell hooks are wired during
> + * kernel queue creation and command submission in later patches in the series.
> + */
> +struct aie4_msg_create_hw_context_resp;
> +int aie4_doorbell_setup(struct amdxdna_hwctx *hwctx,
> +			const struct aie4_msg_create_hw_context_resp *resp);
> +void aie4_doorbell_ring(struct amdxdna_hwctx *hwctx);
> +int aie4_request_notification(struct cert_comp *comp);
> +void aie4_free_notification(struct cert_comp *comp);
> +
>   /* aie4_sriov.c */
>   #if IS_ENABLED(CONFIG_PCI_IOV)
>   int aie4_sriov_configure(struct amdxdna_dev *xdna, int num_vfs);
> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.h b/drivers/accel/amdxdna/amdxdna_ctx.h
> index 6e78bab8a02c..9bbc3db4ebde 100644
> --- a/drivers/accel/amdxdna/amdxdna_ctx.h
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.h
> @@ -6,6 +6,8 @@
>   #ifndef _AMDXDNA_CTX_H_
>   #define _AMDXDNA_CTX_H_
>   
> +#include <drm/amdxdna_accel.h>
> +#include <drm/gpu_scheduler.h>
>   #include <linux/bitfield.h>
>   
>   #include "amdxdna_gem.h"
