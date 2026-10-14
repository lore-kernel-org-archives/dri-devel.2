Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE02CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 18:28:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC41410EAB8;
	Wed, 14 Oct 2026 18:28:23 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012041.outbound.protection.outlook.com [40.107.209.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA68210EAB5
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 18:28:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bbjTasRqbOocEuUp5M79++F3HiI9EAym+WjeK5O/coBv+5OlkfJ3Atmfw1iHb98MNsBFcUOvAhMNGFD8JYyXGue86gh6nQsAJRazn2EGwRuueibVC/OgnZe41aMte93sCJA2/xgRwLG10zPLs32oxCciQfdLLcWWRH8Fslv1WUYFkgEPoncgjzZg158oZMRg26v6OVLVpdLgHrpIjpVKyphHcr1j0lQUKqQHOIC4ZQFAESX69uLy3ZOAPD9A/MgJa8e8AKbomRgXOceMs1Qw7nb5kD7DZTfkParXrP9wvJhwwCRpT8j2LJS7SZaWoCNHGH4KV9umMFVCarFn2l33Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDBeMzghIWg622jpOC7Lwc8NhyfBk+o+kAA+xMJ1j6I=;
 b=kf3qALkqnbaO2XpEqw9FkTsj6QMxxcm4clGzjoa4djlp7EknKXAjGzu8CKY6ExCIsJipyiAaxR1iTJMWq3ED0u8YK3uEjsWeR2ZmbIFPR0gfLPrDNGlZZauvPFx36zT/4KVi9eIkonR2OupJaskDyAOl8nbUf2azfjvNfOeoyufYVIKWQeUWhRia7n7x9DICCbRoB9sFrmBB6499rT/yjmkpjW0pbiLMFm5xNTi75jRy37BFsQe2Ak2W6KOmwIgD36oo33eERmUZ64CPHVTagd1fWik/1k+IjZxz6KORZa7O1n4Qe40okYaWLZmXLje0YN5QX6AzDOCcgChxZoXL4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDBeMzghIWg622jpOC7Lwc8NhyfBk+o+kAA+xMJ1j6I=;
 b=a//5+TnUGdy3iuZvGgacYu5ZRvAGkTgkEufBAx2okuBV6Lmk1moi4+g/ZKu8i7FW5RqlRUFplmc4Xqe4A46DUQFqF9ufJlnd0NAHNHfLipBDbv3fudqA+T0aWu14m9ZqovmK5fxcS6BZ9DDBo8BvOJgx72RTX8+kRVdloFrqGuw=
Received: from PH8PR07CA0017.namprd07.prod.outlook.com (2603:10b6:510:2cd::28)
 by CH4PR12MB027447.namprd12.prod.outlook.com (2603:10b6:610:508::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 18:28:11 +0000
Received: from PH1PEPF00062F24.namprd02.prod.outlook.com
 (2603:10b6:510:2cd:cafe::3d) by PH8PR07CA0017.outlook.office365.com
 (2603:10b6:510:2cd::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Wed, 14
 Oct 2026 18:28:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 PH1PEPF00062F24.mail.protection.outlook.com (10.167.243.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 18:28:10 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 13:28:04 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 14 Oct 2026 13:28:03 -0500
Message-ID: <4054232d-41aa-8e7b-b55f-c550a072c66f@amd.com>
Date: Wed, 14 Oct 2026 11:28:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V4 18/19] accel/amdxdna: Implement AIE4 suspend and resume
Content-Language: en-US
To: David Zhang <yidong.zhang@amd.com>, <quic_jhugo@quicinc.com>,
 <karol.wachowski@linux.intel.com>, <max.zhen@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <sonal.santan@amd.com>, <mario.limonciello@amd.com>
References: <yidong.zhang@amd.com>
 <20261009225343.3079074-1-yidong.zhang@amd.com>
 <20261009225343.3079074-19-yidong.zhang@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20261009225343.3079074-19-yidong.zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH1PEPF00062F24:EE_|CH4PR12MB027447:EE_
X-MS-Office365-Filtering-Correlation-Id: d177d8f0-93a8-4f57-0386-08df2a20e6b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|56012099006|11063799006|4143699003|261009223027099003|18002099003|10067099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: WUEHAtYqRn/JxHKTnAM7XnkPVed/tXcB3E9Ta/5tm0Nqwh2RcTKCGoAF6EsCMYQObjCxxZW/B0GYBystV4obdjCnxybaQ+Ga78dWvuCrtvqavxnoP0VyFIjR5cEL4Pn5fEAzw+/E2ym0Lb7FZ2LD9SduhCn/FGGd3GADx/SR7TpwUSKCryfELA0AN1f35ZI+42VnWb9+loD5ovOTCs54vPiBZqFPw4S8BlXuNU4k0zjpryuuJAUtp0ejQpAyxNbzKSHAGXMOvFzZBJPjOhysUf0z5vSY2vBUA/B+YgKYaENSbNmZchssunjNpFCc8E5gmsNJ92Na45JGhN99nGeK2kaOr+4OGxVGPRptwTiLyFV0PhaLjZgjMImnPNZXaOaCgUYYwxJhAtYD0bb53Hks1ACkl8LC7rZOne1yihMl3Ow28FLn7gfLZD+5Stoi2onlCeILhRsUAbI+bMxuO2v2T6SRmv2BmBacCt0jMsKIWgVCHnrLuZtcEsN0xgMQYYaWOj5v74fDDsN/xgCwC/PNliALHqubKKLCakb+6sZbdD5WM8ASnrYmcQKXpKF8CUET2HDxpLNtCd152ELGKNuvqjY7pxAtuaOj+L/KKnUsLm0ptDIYAVnf7G9DngJhFhrBOA5gWHJ+e99FUreXkpV4krsEeIbP0+liyYC/0r6Fl2LUavfmC4wuhJxvFZCxkVuI0rVS8+pjdCt3FJa+p5+wFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(56012099006)(11063799006)(4143699003)(261009223027099003)(18002099003)(10067099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MB/oyuLNQZA4RB0Utz2FyEfXmFHWtjgoNw5Y9PMpW2kwo/lRlGkXrhLIsvFS2nVW/V1vVZ5wyZsfiyFMa14Ps7V9010+6pdOu3/Xi5fUQlkSXFAwjffrFqh63vwv3EIIMQLOvhWNC8clDCjXkxZM7ZRxHdAwYkrry7Sp4CtGgOfkAG2wxCQ5RrxlIP7TCr+tLHT//mHe4rwn/Ami+QVF13ZWtm1fvTQ8Ao6VMxvbYwpxe8RrddSEwh7jx8PsQbRkoe1mCmI33b3vgNdWVsg1P3Q9/akAeizq/1U78gDDphDksjMMx3IABT1Lg5xOuUtEJ+wz8cpc0Eyc6AuxTBjlefnT/bvS3zfHyW9Bcy3TMetSv8TOr1zrGgaIsFMIlUNjlWc5pvL+dGQ/Ijdjes4Bib0YGSWZ7Q2fNKSOZjbK8XSJoDfe8E3cjfsCpxlPGv15
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 18:28:10.6591 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d177d8f0-93a8-4f57-0386-08df2a20e6b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH1PEPF00062F24.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR12MB027447
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
> Implement suspend and resume callbacks for AIE4 Physical Function (PF),
> Virtual Function (VF), and Classic device types:
> - Implement aie4_hwctx_suspend_all() to destroy or drain contexts across
>    all registered clients and wait for in-flight jobs.
> - Implement aie4_hwctx_resume_all() to recreate firmware contexts and
>    kick doorbells via aie4_hwctx_resume_jobs() to resume hardware queue
>    consumption.
> - Guard firmware destroy message in aie4_hwctx_destroy() when context
>    ID is invalid.
> - Restore SR-IOV virtual functions on PF resume via aie4_restore_sriov().
> - Link each VF to the PF with a stateless device link when SR-IOV is
>    enabled, so system suspend handles VFs before the PF and resume
>    handles the PF before VFs. The link survives VF driver rebind and is
>    removed before SR-IOV is disabled.
>
> Signed-off-by: David Zhang <yidong.zhang@amd.com>
> ---
>   drivers/accel/amdxdna/aie4_ctx.c        |  18 +-
>   drivers/accel/amdxdna/aie4_pci.c        | 251 ++++++++++++++++++++++++
>   drivers/accel/amdxdna/aie4_pci.h        |  11 ++
>   drivers/accel/amdxdna/aie4_sriov.c      |  66 ++++++-
>   drivers/accel/amdxdna/amdxdna_pci_drv.h |   3 +
>   5 files changed, 347 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/accel/amdxdna/aie4_ctx.c b/drivers/accel/amdxdna/aie4_ctx.c
> index 43d26454be6c..a2b6b0fa2934 100644
> --- a/drivers/accel/amdxdna/aie4_ctx.c
> +++ b/drivers/accel/amdxdna/aie4_ctx.c
> @@ -255,7 +255,7 @@ void aie4_hwctx_destroy(struct amdxdna_hwctx *hwctx, enum aie4_hwctx_flags flags
>   	if (has_error)
>   		wake_up_all(&priv->job_list_wq);
>   
> -	if (flags != AIE4_HWCTX_DISCONNECT)
> +	if (flags != AIE4_HWCTX_DISCONNECT && priv->hw_ctx_id != CTX_INVALID_ID)
>   		aie4_msg_destroy_context(ndev, priv->hw_ctx_id);
>   
>   	if (cert_comp)
> @@ -363,6 +363,7 @@ int aie4_hwctx_init(struct amdxdna_hwctx *hwctx)
>   		return -ENOMEM;
>   	hwctx->priv = priv;
>   	priv->hwctx = hwctx;
> +	priv->hw_ctx_id = CTX_INVALID_ID;
>   
>   	/* Initialize io_lock guarding cert_comp binding. */
>   	mutex_init(&priv->io_lock);
> @@ -951,6 +952,21 @@ int aie4_hwctx_wait_for_running(struct amdxdna_hwctx *hwctx)
>   	return ret;
>   }
>   
> +void aie4_hwctx_resume_jobs(struct amdxdna_hwctx *hwctx)
> +{
> +	struct amdxdna_hwctx_priv *priv = hwctx->priv;
> +
> +	mutex_lock(&priv->io_lock);
> +	if (list_empty(&priv->running_job_list)) {
> +		mutex_unlock(&priv->io_lock);
> +		return;
> +	}
> +	aie4_doorbell_ring(hwctx);
> +	mutex_unlock(&priv->io_lock);
> +
> +	queue_work(priv->job_work_q, &priv->job_work);
> +}
> +
>   static void put_cmd_bos(struct amdxdna_sched_job *job)
>   {
>   	u32 i;
> diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
> index e09d24d85cdf..70a052ab5f77 100644
> --- a/drivers/accel/amdxdna/aie4_pci.c
> +++ b/drivers/accel/amdxdna/aie4_pci.c
> @@ -1126,11 +1126,258 @@ static void aie4_debugfs_init(struct amdxdna_dev *xdna)
>   					   &aie4_ctx_hysteresis_fops);
>   }
>   
> +void aie4_hwctx_suspend_all(struct amdxdna_dev_hdl *ndev, int clean_jobs)
> +{
> +	struct amdxdna_dev *xdna = ndev->aie.xdna;
> +	struct amdxdna_client *client;
> +	struct amdxdna_hwctx *hwctx;
> +	unsigned long hwctx_id;
> +	int idx;
> +
> +	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
> +
> +	amdxdna_for_each_client(xdna, client) {
> +		idx = srcu_read_lock(&client->hwctx_srcu);
> +		amdxdna_for_each_hwctx(client, hwctx_id, hwctx) {
> +			/* clean up workers and drain running jobs */
> +			if (clean_jobs) {
> +				int ret;
> +
> +				aie4_hwctx_destroy(hwctx, AIE4_HWCTX_ERROR);
> +				ret = aie4_hwctx_wait_for_running(hwctx);
> +				if (ret)
> +					XDNA_WARN(xdna, "hwctx %s wait for running failed %d",
> +						  hwctx->name, ret);
> +			} else {
> +				aie4_hwctx_destroy(hwctx, AIE4_HWCTX_NORMAL);
> +			}
> +		}
> +		srcu_read_unlock(&client->hwctx_srcu, idx);
> +	}
> +
> +	XDNA_DBG(xdna, "Finished hwctx suspend");
> +}
> +
> +int aie4_hwctx_resume_all(struct amdxdna_dev_hdl *ndev)
> +{
> +	struct amdxdna_dev *xdna = ndev->aie.xdna;
> +	struct amdxdna_client *client;
> +	struct amdxdna_hwctx *hwctx;
> +	unsigned long hwctx_id;
> +	int ret, idx;
> +
> +	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
> +
> +	amdxdna_for_each_client(xdna, client) {
> +		idx = srcu_read_lock(&client->hwctx_srcu);
> +		amdxdna_for_each_hwctx(client, hwctx_id, hwctx) {
> +			ret = aie4_hwctx_create(hwctx);
> +			if (ret)
> +				goto error;
> +			aie4_hwctx_resume_jobs(hwctx);
> +		}
> +		srcu_read_unlock(&client->hwctx_srcu, idx);
> +	}
> +
> +	XDNA_DBG(xdna, "Finished hwctx resume");
> +	return 0;
> +error:
> +	srcu_read_unlock(&client->hwctx_srcu, idx);
> +	XDNA_DBG(xdna, "Failed hwctx resume");
> +	return ret;
> +}
> +
> +static int aie4_restore_sriov(struct amdxdna_dev_hdl *ndev)
> +{
> +	struct amdxdna_dev *xdna = ndev->aie.xdna;
> +	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
> +	int ret;
> +
> +	if (ndev->num_vfs) {
> +		if (pci_num_vf(pdev) != ndev->num_vfs) {
> +			XDNA_ERR(xdna, "inconsistent vf number");
> +			return -EINVAL;
> +		}
> +		ret = aie4_create_vfs(ndev, ndev->num_vfs);
> +		if (ret) {
> +			XDNA_ERR(xdna, "create vfs failed, %d", ret);
> +			return ret;
> +		}
> +		XDNA_DBG(xdna, "restored num_vfs %d", ndev->num_vfs);
> +	}
> +
> +	return 0;
> +}
> +
> +static int aie4_pf_suspend(struct amdxdna_dev *xdna)
> +{
> +	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
> +	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
> +
> +	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
> +	aie4_pf_hw_stop(ndev);
> +	pci_disable_device(pdev);
> +
> +	XDNA_DBG(xdna, "pf suspend done");
> +	return 0;
> +}
> +
> +static int aie4_pf_resume(struct amdxdna_dev *xdna)
> +{
> +	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
> +	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
> +	int ret;
> +
> +	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
> +
> +	ret = pci_enable_device(pdev);
> +	if (ret) {
> +		XDNA_ERR(xdna, "enable pci device failed %d", ret);
> +		return ret;
> +	}
> +	pci_set_master(pdev);
> +
> +	ret = aie4_pf_hw_start(ndev);
> +	if (ret) {
> +		XDNA_ERR(xdna, "hw_start failed %d", ret);
> +		goto pci_disable;
> +	}
> +
> +	ret = aie4_restore_sriov(ndev);
> +	if (ret)
> +		goto hw_stop;
> +
> +	XDNA_DBG(xdna, "pf resume done");
> +	return 0;
> +hw_stop:
> +	aie4_pf_hw_stop(ndev);
> +pci_disable:
> +	pci_disable_device(pdev);
> +	return ret;
> +}
> +
> +static int aie4_vf_suspend(struct amdxdna_dev *xdna)
> +{
> +	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
> +	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
> +
> +	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
> +	aie4_hwctx_suspend_all(ndev, false);
> +	/*
> +	 * partition_fini and mailbox messages should not be called here
> +	 * because PF suspend will do the cleanup for all VFs.
> +	 */
> +	aie4_mailbox_fini(ndev);
> +	pci_disable_device(pdev);
> +
> +	XDNA_DBG(xdna, "vf suspend done");
> +	return 0;
> +}
> +
> +static int aie4_vf_resume(struct amdxdna_dev *xdna)
> +{
> +	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
> +	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
> +	int ret;
> +
> +	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
> +
> +	ret = pci_enable_device(pdev);
> +	if (ret) {
> +		XDNA_ERR(xdna, "enable pci device failed %d", ret);
> +		/* Contexts cannot reconnect; fail waiters and abort running jobs. */
> +		aie4_hwctx_suspend_all(ndev, true);
> +		return ret;
> +	}
> +	pci_set_master(pdev);
> +
> +	ret = aie4_vf_hw_start(ndev);
> +	if (ret) {
> +		XDNA_ERR(xdna, "hw_start failed %d", ret);
> +		/* Contexts cannot reconnect; fail waiters and abort running jobs. */
> +		aie4_hwctx_suspend_all(ndev, true);
> +		goto pci_disable;
> +	}
> +
> +	ret = aie4_hwctx_resume_all(ndev);
> +	if (ret) {
> +		XDNA_ERR(xdna, "hwctx_resume failed %d", ret);
> +		goto hw_clear;
> +	}
> +
> +	XDNA_DBG(xdna, "vf resume done");
> +	return 0;
> +
> +hw_clear:
> +	aie4_hwctx_suspend_all(ndev, true);
> +	aie4_vf_hw_stop(ndev);
> +pci_disable:
> +	pci_disable_device(pdev);
> +	return ret;
> +}
> +
> +static int aie4_classic_suspend(struct amdxdna_dev *xdna)
> +{
> +	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
> +	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
> +
> +	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
> +	aie4_hwctx_suspend_all(ndev, false);
> +	aie4_classic_hw_stop(ndev);
> +	pci_disable_device(pdev);
> +
> +	XDNA_DBG(xdna, "classic suspend done");
> +	return 0;
> +}
> +
> +static int aie4_classic_resume(struct amdxdna_dev *xdna)
> +{
> +	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
> +	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
> +	int ret;
> +
> +	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
> +
> +	ret = pci_enable_device(pdev);
> +	if (ret) {
> +		XDNA_ERR(xdna, "enable pci device failed %d", ret);
> +		/* Contexts cannot reconnect; fail waiters and abort running jobs. */
> +		aie4_hwctx_suspend_all(ndev, true);
> +		return ret;
> +	}
> +	pci_set_master(pdev);
> +
> +	ret = aie4_classic_hw_start(ndev);
> +	if (ret) {
> +		XDNA_ERR(xdna, "hw_start failed %d", ret);
> +		/* Contexts cannot reconnect; fail waiters and abort running jobs. */
> +		aie4_hwctx_suspend_all(ndev, true);
> +		goto pci_disable;
> +	}
> +
> +	ret = aie4_hwctx_resume_all(ndev);
> +	if (ret) {
> +		XDNA_ERR(xdna, "hwctx_resume failed %d", ret);
> +		goto hw_clear;
> +	}
> +
> +	XDNA_DBG(xdna, "classic resume done");
> +	return 0;
> +hw_clear:
> +	aie4_hwctx_suspend_all(ndev, true);
> +	aie4_classic_hw_stop(ndev);
> +pci_disable:
> +	pci_disable_device(pdev);
> +	return ret;
> +}
> +
>   const struct amdxdna_dev_ops aie4_pf_ops = {
>   	.init			= aie4_pf_init,
>   	.fini			= aie4_pf_fini,
>   	.debugfs_init		= aie4_debugfs_init,
>   	.sriov_configure        = aie4_sriov_configure,
> +	.resume			= pm_ptr(aie4_pf_resume),
> +	.suspend		= pm_ptr(aie4_pf_suspend),
>   };
>   
>   const struct amdxdna_dev_ops aie4_vf_ops = {
> @@ -1144,6 +1391,8 @@ const struct amdxdna_dev_ops aie4_vf_ops = {
>   	.cmd_wait		= aie4_cmd_wait,
>   	.get_aie_info		= aie4_get_info,
>   	.set_aie_state		= aie4_set_state,
> +	.resume			= pm_ptr(aie4_vf_resume),
> +	.suspend		= pm_ptr(aie4_vf_suspend),
>   };
>   
>   const struct amdxdna_dev_ops aie4_classic_ops = {
> @@ -1157,4 +1406,6 @@ const struct amdxdna_dev_ops aie4_classic_ops = {
>   	.cmd_wait		= aie4_cmd_wait,
>   	.get_aie_info		= aie4_get_info,
>   	.set_aie_state		= aie4_set_state,
> +	.resume			= pm_ptr(aie4_classic_resume),
> +	.suspend		= pm_ptr(aie4_classic_suspend),
>   };
> diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
> index 4b7367af7cf1..fdc55e498246 100644
> --- a/drivers/accel/amdxdna/aie4_pci.h
> +++ b/drivers/accel/amdxdna/aie4_pci.h
> @@ -95,6 +95,7 @@ struct amdxdna_dev_hdl {
>   	u32				total_col;
>   	u32				max_aieclk_level;
>   	u32				max_npuhclk_level;
> +	u32				num_vfs;
>   
>   	struct dpm_clk_freq		dpm_clk_tbl[AIE4_MAX_DPM_LEVEL_COUNT];
>   
> @@ -159,8 +160,11 @@ int aie4_cmd_submit(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job,
>   int aie4_hwctx_create(struct amdxdna_hwctx *hwctx);
>   void aie4_hwctx_destroy(struct amdxdna_hwctx *hwctx, enum aie4_hwctx_flags);
>   int aie4_hwctx_wait_for_running(struct amdxdna_hwctx *hwctx);
> +void aie4_hwctx_resume_jobs(struct amdxdna_hwctx *hwctx);
>   
>   /* aie4_pci.c */
> +void aie4_hwctx_suspend_all(struct amdxdna_dev_hdl *ndev, int clean_jobs);
> +int aie4_hwctx_resume_all(struct amdxdna_dev_hdl *ndev);
>   int aie4_restore_power_mode(struct amdxdna_dev_hdl *ndev);
>   
>   /*
> @@ -176,10 +180,17 @@ void aie4_free_notification(struct cert_comp *comp);
>   
>   /* aie4_sriov.c */
>   #if IS_ENABLED(CONFIG_PCI_IOV)
> +int aie4_create_vfs(struct amdxdna_dev_hdl *ndev, int num_vfs);
>   int aie4_sriov_configure(struct amdxdna_dev *xdna, int num_vfs);
>   int aie4_sriov_stop(struct amdxdna_dev_hdl *ndev);
>   #else
> +static inline int aie4_create_vfs(struct amdxdna_dev_hdl *ndev, int num_vfs)
> +{
> +	return 0;
> +}
> +
>   #define aie4_sriov_configure NULL
> +
>   static inline int aie4_sriov_stop(struct amdxdna_dev_hdl *ndev)
>   {
>   	return 0;
> diff --git a/drivers/accel/amdxdna/aie4_sriov.c b/drivers/accel/amdxdna/aie4_sriov.c
> index e1ce633768a5..d3df36644914 100644
> --- a/drivers/accel/amdxdna/aie4_sriov.c
> +++ b/drivers/accel/amdxdna/aie4_sriov.c
> @@ -26,7 +26,7 @@ static int aie4_destroy_vfs(struct amdxdna_dev_hdl *ndev)
>   	return ret;
>   }
>   
> -static int aie4_create_vfs(struct amdxdna_dev_hdl *ndev, int num_vfs)
> +int aie4_create_vfs(struct amdxdna_dev_hdl *ndev, int num_vfs)
>   {
>   	DECLARE_AIE_MSG(aie4_msg_create_vfs, AIE4_MSG_OP_CREATE_VFS);
>   	int ret;
> @@ -39,6 +39,59 @@ static int aie4_create_vfs(struct amdxdna_dev_hdl *ndev, int num_vfs)
>   	return ret;
>   }
>   
> +static int aie4_for_each_vfs(struct amdxdna_dev *xdna,
> +			     int (*cb)(struct amdxdna_dev *, struct pci_dev *))
> +{
> +	struct pci_dev *pdev_pf = to_pci_dev(xdna->ddev.dev);
> +	struct pci_dev *pdev_vf;
> +	int pos, ret;
> +	u16 vf_did;
> +
> +	pos = pci_find_ext_capability(pdev_pf, PCI_EXT_CAP_ID_SRIOV);
> +	if (!pos)
> +		return 0;
> +	ret = pci_read_config_word(pdev_pf, pos + PCI_SRIOV_VF_DID, &vf_did);
> +	if (ret) {
> +		XDNA_ERR(xdna, "read VF Device ID failed %d", ret);
> +		return -ENODEV;
> +	}
> +
> +	for (pdev_vf = pci_get_device(pdev_pf->vendor, vf_did, NULL);
> +	     pdev_vf;
> +	     pdev_vf = pci_get_device(pdev_pf->vendor, vf_did, pdev_vf)) {
> +		if (!pdev_vf->is_virtfn || pdev_vf->physfn != pdev_pf)
> +			continue;
> +
> +		ret = cb(xdna, pdev_vf);
> +		if (ret) {
> +			/* Release reference on early return. */
> +			pci_dev_put(pdev_vf);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int aie4_link_vf(struct amdxdna_dev *xdna, struct pci_dev *pdev_vf)
> +{
> +	struct pci_dev *pdev_pf = to_pci_dev(xdna->ddev.dev);
> +
> +	/* Stateless so the link survives VF driver rebind. */
> +	if (!device_link_add(&pdev_vf->dev, &pdev_pf->dev, DL_FLAG_STATELESS)) {
> +		XDNA_ERR(xdna, "Failed to link VF %s", pci_name(pdev_vf));
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int aie4_unlink_vf(struct amdxdna_dev *xdna, struct pci_dev *pdev_vf)
> +{
> +	device_link_remove(&pdev_vf->dev, xdna->ddev.dev);
> +	return 0;
> +}
> +
>   int aie4_sriov_stop(struct amdxdna_dev_hdl *ndev)
>   {
>   	struct amdxdna_dev *xdna = ndev->aie.xdna;
> @@ -54,7 +107,9 @@ int aie4_sriov_stop(struct amdxdna_dev_hdl *ndev)
>   		return -EPERM;
>   	}
>   
> +	aie4_for_each_vfs(xdna, aie4_unlink_vf);
>   	pci_disable_sriov(pdev);
> +	ndev->num_vfs = 0;
>   	return aie4_destroy_vfs(ndev);
>   }
>   
> @@ -75,6 +130,15 @@ static int aie4_sriov_start(struct amdxdna_dev_hdl *ndev, int num_vfs)
>   		return ret;
>   	}
>   
> +	ret = aie4_for_each_vfs(xdna, aie4_link_vf);
> +	if (ret) {
> +		aie4_for_each_vfs(xdna, aie4_unlink_vf);
> +		pci_disable_sriov(pdev);
> +		aie4_destroy_vfs(ndev);
> +		return ret;
> +	}
> +
> +	ndev->num_vfs = num_vfs;
>   	return num_vfs;
>   }
>   
> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h b/drivers/accel/amdxdna/amdxdna_pci_drv.h
> index eccb461d32bc..505477b4a292 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
> @@ -168,6 +168,9 @@ struct amdxdna_client {
>   #define amdxdna_for_each_hwctx(client, hwctx_id, entry)		\
>   	xa_for_each(&(client)->hwctx_xa, hwctx_id, entry)
>   
> +#define amdxdna_for_each_client(xdna, client)			\
> +	list_for_each_entry(client, &(xdna)->client_list, node)
> +
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
>   /* Add device info below */
>   extern const struct amdxdna_dev_info dev_npu1_info;
>   extern const struct amdxdna_dev_info dev_npu3_classic_info;
