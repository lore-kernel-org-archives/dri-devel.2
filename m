Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF90ACC6B1A
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 18:34:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C07010E21B;
	Tue, 13 Oct 2026 18:33:58 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012052.outbound.protection.outlook.com [52.101.53.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E695410E21B
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 18:33:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wxT5R3gOvY82wByZqo1g7Ry0+YgEL4c/0484XvKHOeIXUmiTo05iioAdIlS0coYYl2LGu10urmR0VBk4i2nhu2k0zozjB1lFyvshLJx1iCIKTTsTQ9mH5xGVYRsHR9EZdQNZ8LseXPDMcP9v3R2T8MgIpJJEEcYHR8uN/usPwJ0VsOc3R6QXbtc87tGozOh+KKNKvXOc1+/beI5vrSRqv5VtUtiFG4yE73J76i3+vRG1kEaXm042E/U6dtbHnMXtHpbb/xZZ2rBDQkvT50plrpjk5D2z5YfX28npZOtZECuEj6uGnKaEv7asfttlTkZRYJeVdTTr1ovq1JNBF50nLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tYMm5v2i4OhTuSKMen60DCpiQTUh5esRClFvmiD7BCA=;
 b=rZPGCwcfGkzWGvJpN/2ZafdqzuR9d+JC1kPJitR1M+mZ9wq8pwnZ9k514JvuSwX/mmnR0MllLjIAegfibL5DsGPQv+fdFFP/L2b2itMnhNRQ2aM/K8D1MuEtjCDMTOJA8v2pXeRohuJIk1jQADguAl2G+ZM0qy64/QNGVhyOhdrq87PnCW4yLfQMnE54hiuVU+UPYkn5PuNDffUiqo7hgMTaAGW2fj3R7lRDjHcBMDC6A75HE+qpI4lzAG3RX9caTK864BvTH7o1SE3GgzN0doMJt8m4a7LHMwJhHx2hbn/Yycoomj51GoIreXeTnFFE2aCr9cKZbnQ5MeG2e4t0QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYMm5v2i4OhTuSKMen60DCpiQTUh5esRClFvmiD7BCA=;
 b=alCig2Vn+HrDxwR8zrtZ2WTInOIEFrkXNUHnxY5JQZiCtAuLE7U//QShKe0gNOCQH608VIvXdUbhGl6A0+qGW0NUFJo5lpPVLqKtaCwMOVcjnnqWg4szgTec2yNShhHi+RiMK4ERhWtKYbz5z9gMQeOu6KvrLm3sf4c7WDht4/o=
Received: from SJ0PR05CA0156.namprd05.prod.outlook.com (2603:10b6:a03:339::11)
 by LV3PR12MB9187.namprd12.prod.outlook.com (2603:10b6:408:194::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 18:33:43 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::80) by SJ0PR05CA0156.outlook.office365.com
 (2603:10b6:a03:339::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Tue, 13
 Oct 2026 18:33:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 18:33:42 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 13:33:36 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 13:33:36 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 13 Oct 2026 13:33:35 -0500
Message-ID: <77c7e02e-9cf8-efa1-0734-b702ec36c85c@amd.com>
Date: Tue, 13 Oct 2026 11:33:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V4 10/19] accel/amdxdna: Refactor AIE4 hardware
 initialization sequence
Content-Language: en-US
To: David Zhang <yidong.zhang@amd.com>, <quic_jhugo@quicinc.com>,
 <karol.wachowski@linux.intel.com>, <max.zhen@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <sonal.santan@amd.com>, <mario.limonciello@amd.com>
References: <yidong.zhang@amd.com>
 <20261009225343.3079074-1-yidong.zhang@amd.com>
 <20261009225343.3079074-11-yidong.zhang@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20261009225343.3079074-11-yidong.zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|LV3PR12MB9187:EE_
X-MS-Office365-Filtering-Correlation-Id: 331437bb-e950-4856-dbc2-08df2958822d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|6133799003|22082099003|18002099003|10067099003|3023799007|4143699003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 7fODIN9OeNaer0C142wngPVSqOAqZXBRKdeTszGpmAz+Ac8F3rBHkkiw17AnfGFwQzpX3bSJ+0VCjc8Kq5yDd9Iirh2xhDaM3bvv8Pddpiw4ub8fOqv89NO/YxC+wvS/V5qU1/Fz98HiKv+55GD/5IcQSF/s0c3091cjXwsefxCxOO0pjRf0M4K17ySJTxI1shrruELFxgM1RHHbhu+N5/X8MhkJ8TOWSyW4x1WOhRZtzTvZ91LqP2JgkisL4RCAlPx0xiawusVXykDPqlL7yzd6aJofsYNfKg7MxeuW1vxFGQKdOafwdKqiDzWBf/pOMZWUs5nlffJn21P5/qAvCTfYzHLOQlIai02U+oIZeuqh3iaZdTFHzmhIZTOs+27PKOS/5DnOYNEv00ZD+eZBsJy/NDaTbco0udL0f4ue+Nl39uSu+PyZeJ09cdvh0Nz8+c8kVK7QPlFMiD4Jlr8lOlVlG/D0ghPtp8SDLxk6wraagpISlYS9d0SBdPJVxpv52GLJU+XnTm7olpOsTUOx0Cf++RnUeJpfpEPVvdOIeD82blJDwDqhClIFORaCqk0fRaql59WTR40OXERwyQi6JUcmWHgwscmm3r4ZgBEiqZga+NATI2r0+fbLfTm+o4x4w1qnw5kVobZ1unVBFNmgl/bcknNvZllkkPGbJgnmPo7VM+KxbHxVGQBac6uuQyfrpEElcXNrypulmN+TgFq4EA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(6133799003)(22082099003)(18002099003)(10067099003)(3023799007)(4143699003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5X1pxSzckuKLhn86rwATsaCQA2UL9NMgpnOFimra4aFhJtSfCw16bNrlBHvLHS9houQWWxhR9IMmJTqMaYmiK+eBa4OEUcjZfdMbp6QSk9BeRbjRSmJIbwgxCDE/FcwHWwzjrAFNGS/7f137+sDTxFx5tJaYUsihV4DrJG6CUSHp0fOuPp79TahWNV/rmV/Ej1NCvAdZvMNS5rwYzNFxHGweWz/ur3uUDeovCnp2QZhfvQEP1udvxfEZEpd+OP4yvHXIwo79lfIhfm/d/8Wq5OVg5Exegoa5XldQ3a3KXaO/9Biqv5HyCtB3/nSQ7ZtYA63Gd5hQUtqpL3GrCDwP9lFr/wPN2fQiux9AREse6lWOIV6CuAjtq5xTj6oUF4Ye9HHx9G4ARNhTj/0xzOTk3H+2qBEoqDgA4VBRxvTf50JDScgpb+LwWzBTTjUmebUc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 18:33:42.6543 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 331437bb-e950-4856-dbc2-08df2958822d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9187
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
> Reorganize AIE4 hardware initialization into distinct phases, next to
> the existing aie4_config_fw():
> - aie4_query_fw(): Query NPU and CERT firmware versions.
> - aie4_setup_aie(): Query AIE version, metadata, initialize DPM frequency
>    table, and initialize partitions.
>
> Update aie4_pf_hw_start(), aie4_vf_hw_start(), and aie4_classic_hw_start()
> to use these phases and unify error unwinding labels. As part of this,
> aie4_pf_hw_start() now also calls aie4_query_fw(), which it previously
> did not do.
>
> Signed-off-by: David Zhang <yidong.zhang@amd.com>
> ---
>   drivers/accel/amdxdna/aie4_pci.c | 79 +++++++++++++++++++-------------
>   1 file changed, 46 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
> index 446ab2f47c7d..ffe78c0c4e8b 100644
> --- a/drivers/accel/amdxdna/aie4_pci.c
> +++ b/drivers/accel/amdxdna/aie4_pci.c
> @@ -50,7 +50,7 @@ static int aie4_fw_is_alive(struct amdxdna_dev *xdna)
>   {
>   	const struct amdxdna_dev_priv *npriv = xdna->dev_info->dev_priv;
>   	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
> -	u32 __iomem *src;
> +	void __iomem *src;
>   	u32 fw_is_valid;
>   	int ret;
>   
> @@ -280,7 +280,8 @@ static void aie4_partition_fini(struct amdxdna_dev_hdl *ndev)
>   		XDNA_ERR(xdna, "partition fini failed: %d", ret);
>   }
>   
> -static int aie4_query(struct amdxdna_dev_hdl *ndev)
> +/* Verify CERT protocol compatibility before starting hardware. */
> +static int aie4_query_fw(struct amdxdna_dev_hdl *ndev)
>   {
>   	struct amdxdna_dev *xdna = ndev->aie.xdna;
>   	int ret;
> @@ -293,25 +294,6 @@ static int aie4_query(struct amdxdna_dev_hdl *ndev)
>   	if (ret)
>   		return ret;
>   
> -	ret = aie4_query_aie_version(ndev, &ndev->aie.version);
> -	if (ret)
> -		return ret;
> -
> -	ret = aie4_query_aie_metadata(ndev, &ndev->aie.metadata);
> -	if (ret)
> -		return ret;
> -
> -	ndev->total_col = min_t(u32, AIE4_TOTAL_COLUMN, ndev->aie.metadata.cols);
> -
> -	ret = aie4_init_dpm_freq_table(ndev);
> -	if (ret) {
> -		if (ret == -ETIME)
> -			return ret;
> -		/* if query dpm from fw failed, using default value */
> -		if (ndev->priv->hw_ops && ndev->priv->hw_ops->set_dpm)
> -			(void)ndev->priv->hw_ops->set_dpm(&ndev->aie, 0);
> -	}
> -
>   	return 0;
>   }
>   
> @@ -340,6 +322,32 @@ static int aie4_config_fw(struct amdxdna_dev_hdl *ndev)
>   	return 0;
>   }
>   
> +static int aie4_setup_aie(struct amdxdna_dev_hdl *ndev)
> +{
> +	int ret;
> +
> +	ret = aie4_query_aie_version(ndev, &ndev->aie.version);
> +	if (ret)
> +		return ret;
> +
> +	ret = aie4_query_aie_metadata(ndev, &ndev->aie.metadata);
> +	if (ret)
> +		return ret;
> +
> +	ndev->total_col = min_t(u32, AIE4_TOTAL_COLUMN, ndev->aie.metadata.cols);
> +
> +	ret = aie4_init_dpm_freq_table(ndev);
> +	if (ret) {
> +		if (ret == -ETIME)
> +			return ret;
> +		/* if query dpm from fw failed, using default value */
> +		if (ndev->priv->hw_ops && ndev->priv->hw_ops->set_dpm)
> +			(void)ndev->priv->hw_ops->set_dpm(&ndev->aie, 0);
> +	}
> +
> +	return aie4_partition_init(ndev);
> +}
> +
>   static int aie4_pf_hw_start(struct amdxdna_dev_hdl *ndev)
>   {
>   	int ret;
> @@ -352,6 +360,10 @@ static int aie4_pf_hw_start(struct amdxdna_dev_hdl *ndev)
>   	if (ret)
>   		goto stop_fw;
>   
> +	ret = aie4_query_fw(ndev);
> +	if (ret)
> +		goto mbox_fini;
> +
>   	ret = aie4_config_fw(ndev);
>   	if (ret)
>   		goto mbox_fini;
> @@ -389,13 +401,13 @@ static int aie4_vf_hw_start(struct amdxdna_dev_hdl *ndev)
>   	if (ret)
>   		return ret;
>   
> -	ret = aie4_query(ndev);
> +	ret = aie4_query_fw(ndev);
>   	if (ret)
> -		goto mailbox_fini;
> +		goto mbox_fini;
>   
> -	ret = aie4_partition_init(ndev);
> +	ret = aie4_setup_aie(ndev);
>   	if (ret)
> -		goto mailbox_fini;
> +		goto mbox_fini;
>   
>   	ret = aie4_restore_power_mode(ndev);
>   	if (ret)
> @@ -405,7 +417,7 @@ static int aie4_vf_hw_start(struct amdxdna_dev_hdl *ndev)
>   
>   partition_fini:
>   	aie4_partition_fini(ndev);
> -mailbox_fini:
> +mbox_fini:
>   	aie4_mailbox_fini(ndev);
>   	return ret;
>   }
> @@ -432,17 +444,17 @@ static int aie4_classic_hw_start(struct amdxdna_dev_hdl *ndev)
>   	if (ret)
>   		goto stop_fw;
>   
> -	ret = aie4_query(ndev);
> +	ret = aie4_query_fw(ndev);
>   	if (ret)
> -		goto mailbox_fini;
> +		goto mbox_fini;
>   
>   	ret = aie4_config_fw(ndev);
>   	if (ret)
> -		goto mailbox_fini;
> +		goto mbox_fini;
>   
> -	ret = aie4_partition_init(ndev);
> +	ret = aie4_setup_aie(ndev);
>   	if (ret)
> -		goto mailbox_fini;
> +		goto mbox_fini;
>   
>   	ret = aie4_restore_power_mode(ndev);
>   	if (ret)
> @@ -452,10 +464,11 @@ static int aie4_classic_hw_start(struct amdxdna_dev_hdl *ndev)
>   
>   partition_fini:
>   	aie4_partition_fini(ndev);
> -mailbox_fini:
> +mbox_fini:
>   	aie4_mailbox_fini(ndev);
>   stop_fw:
>   	aie4_fw_stop(ndev);
> +
>   	return ret;
>   }
>   
> @@ -529,8 +542,8 @@ static int aie4_prepare_firmware(struct amdxdna_dev_hdl *ndev,
>   				 void __iomem *tbl[PCI_NUM_RESOURCES])
>   {
>   	struct amdxdna_dev *xdna = ndev->aie.xdna;
> +	struct smu_config smu_conf = {};
>   	struct psp_config psp_conf;
> -	struct smu_config smu_conf;
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
>   	int i;
>   
>   	psp_conf.fw_size = npufw->size;
