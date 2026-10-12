Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22410CA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 20:40:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 558D610E68F;
	Mon, 12 Oct 2026 20:40:03 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012021.outbound.protection.outlook.com [52.101.48.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39D5710E676
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 20:39:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=daKFHNXrXWXvU6iWYdhtxPLDWxlnaMXFixvy8txU8fJaCOXCMQXgKTAMLaEYTY9HvZ97zJ6ODKpAOeHzzZiJdOzdpZO+5QoL+znWEqMuPkZh41IxT/vzWmR/ewrt+P94ovERhboLcrSCWKTVk1UVSDn881LuRMV+G8rOzx+BYKtzMx4A/XI6unsajS0sW92TTyJqwW8+oIGY3r0y7FLWidYB4wkIrNZaetuB1ecaWQFFq8TAYCUHeLoARlX3xlETTpJ9/FtP7npQG18ZmhhS2mfUqt2bQGFldbrY43wBtjluOOzuE/bz9MyA/5EFT0BUNij4x38xNsHID3W4w9T+OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0A1EL89dLLBVQnEIUNdgqQnIIQjWD4inPjaoXHv3/I=;
 b=YT396wXWlXzX8fzVooEEkHkydCQm9HoE0+yy/CXldh74isDybQNrimKe8kAnbf4hLN6qXwu4QRSG16csTILy21xZps7XusaXCu5MtAfIynrkQUM1oDT/FlxinEbbYRxzAoGBQ2m6IzTzyQCgjmJKA4WV4zrKABb6SppX1eGVGyGjmoMIxo9TYwDgTo4e87FSZszrQ27M8o6kbb6bSkVYp8PRO/YHtviQCu9lPabI080P5BAFJIZ8KrZWjut1u3vzL1NJOa1zGeFla8jYDZJQeYXO33SSLLmTJSuLhZASXRRK2mTP8HTNIt7F4lBqYiAexS4XTAHSMYsYMjTCaIQicQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0A1EL89dLLBVQnEIUNdgqQnIIQjWD4inPjaoXHv3/I=;
 b=ubK1kXqkYXEsegyQOnQRGF6eW//+TxH+lNUaM+zWk1YPuFPGqry/UoRK1WjzDCWe2hxGvR8py7nZvh8fxFPIeTZvfpFfQLtnZuV7pzs341y9dRpZX/hHx6vqbqscfDX5ro9RHrreleK/22amlLeKcFhTezO5UM9Twk0euCgpfWc=
Received: from BN0PR04CA0209.namprd04.prod.outlook.com (2603:10b6:408:e9::34)
 by DS2PR12MB108293.namprd12.prod.outlook.com (2603:10b6:8:404::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 20:39:51 +0000
Received: from BN2PEPF0000A891.namprd04.prod.outlook.com
 (2603:10b6:408:e9:cafe::ac) by BN0PR04CA0209.outlook.office365.com
 (2603:10b6:408:e9::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 12
 Oct 2026 20:39:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000A891.mail.protection.outlook.com (10.167.248.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 12 Oct 2026 20:39:50 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 12 Oct
 2026 15:39:44 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 12 Oct 2026 15:39:43 -0500
Message-ID: <84100019-269d-c1ee-7252-0d0934e2b42f@amd.com>
Date: Mon, 12 Oct 2026 13:39:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V4 03/19] accel/amdxdna: Add CERT firmware version support
Content-Language: en-US
To: David Zhang <yidong.zhang@amd.com>, <quic_jhugo@quicinc.com>,
 <karol.wachowski@linux.intel.com>, <max.zhen@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <sonal.santan@amd.com>, <mario.limonciello@amd.com>
References: <yidong.zhang@amd.com>
 <20261009225343.3079074-1-yidong.zhang@amd.com>
 <20261009225343.3079074-4-yidong.zhang@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20261009225343.3079074-4-yidong.zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A891:EE_|DS2PR12MB108293:EE_
X-MS-Office365-Filtering-Correlation-Id: b0353a0d-749f-4f7d-1053-08df28a0f65e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|56012099006|11063799006|4143699003|261009223027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: uQC69t4xJlztPjFvuAy6xHsWJx3xDp666I4NSH4vYMLiV5ZXA57mIkG9GaRKtXzrKzP8eTKjMQVaDtwkjSg5MM2ZCD6cicRHUa/+RKJv62GxPoXCXTMLiIUz4rJb4jZklam4nc7yxFK7kZv0GE/Znvfa7wKqnFEbFwWAZTFIVS7ljKOrOKZG3Eyl9N97caGBvVPAg9SXou5mSsVM9ix8n4EJcZOitx7xkMnro3Nej7cIF+ZatRxbsp3MGrOr2CPDBfh2NozJ55G77MmyODv520zU7mxcUCZ8yMOQA8kgOLJiwb5ZcIZJsGuhzB+PGdvzof6beGYvsrPj43iZwwhap5gST/s45XMCkjvjx7k14HpXd31ZBkaJ05y11+d6vFLCnP9pe32IY+JWP8xKlsuTafYQOiqHL6H/TL+Ii28rTxzxqUwCw2ZgX6Z3Z9ouPCAW1POyraNi94aCTCjWl7/VVzViNe+dIagcB/5uTxMbKNEc9YffEENtYaRZFnlJfrhU20h8ZIsT9Mg4qQIKQatjokuE9hM3nth4P+mr/cuX0kn6mzx9U/Bsm6jEVCs4s4ATA/6ATNYhvNsZgieHFz7gjSpm/lghPumAcvLmw8muNDhTZGuPhtRXk46lLzNZuNf0tubprnJ3MOOSexgXdvWiQwVNRQXvdN09SNI2uETpwwdkZmcEfpn05Q4M8F8z0Cw0/27BmdpDbcW78ttUbMhxpw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 36dl5YBa7IbMB5ZDMIooJOShz4aD6SeAHHhELh1x+wiUWYyatIslPR3MQe3MpAL24qUNx5oySYPPGifJ1jiaqWp0QWKbA4nTL0UQLJUgSdiqOxqK//5BX4Crd3hB6U/HH4C+pVNZGH9q0tq3mpQS67yhlK9ThDFVO5bnuPEgTdjRsTpUMf92SZ+oIsNPFkLbQoG7xP8xmG3TFs5drNQ+3GqNwer/595u+z1v448NEq5mB0D/OQNUjoWfQhVKbeWl3z/fV/C5SxXYm3p884IBz9LqWC/hohfsN/9UToqSWhjoMsFpwsZ9wNJuj89AR11cvBZORrHNTnzc2vmerWWy3hc+xeP0z58c9x2onkgu7O4ozORU3+7bsV1CNKwNN+2p9DqdF64VQ19D0Q/sqkezUyhfHLK6HwiyuwPVMCe2uUNCepXSy7ffXWRuzjTGZw60
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 20:39:50.2713 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0353a0d-749f-4f7d-1053-08df28a0f65e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A891.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB108293
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
> Add support to query and validate CERT firmware version:
> - Add mailbox opcodes and structs to query NPU firmware version (identify)
>    and CERT firmware version.
> - Unify firmware version storage by using struct
>    amdxdna_drm_query_firmware_version across the driver.
> - Pass the feature table to aie_check_protocol() and add
>    cert_feature_tbl to validate CERT firmware host queue protocol
>    compatibility against driver capabilities.
> - Add helper functions amdxdna_get_firmware_version() and
>    amdxdna_get_aie_version() to share version query handling across
>    generations.
>
> Signed-off-by: David Zhang <yidong.zhang@amd.com>
> ---
>   drivers/accel/amdxdna/aie.c             | 33 ++++++++++++++--
>   drivers/accel/amdxdna/aie.h             | 11 +++++-
>   drivers/accel/amdxdna/aie2_message.c    |  4 +-
>   drivers/accel/amdxdna/aie2_pci.c        | 50 ++++---------------------
>   drivers/accel/amdxdna/aie2_pci.h        |  4 +-
>   drivers/accel/amdxdna/aie4_message.c    | 46 +++++++++++++++++++++++
>   drivers/accel/amdxdna/aie4_msg_priv.h   | 30 +++++++++++++++
>   drivers/accel/amdxdna/aie4_pci.c        | 20 +++++++++-
>   drivers/accel/amdxdna/aie4_pci.h        | 11 ++++++
>   drivers/accel/amdxdna/amdxdna_pci_drv.h | 10 +----
>   drivers/accel/amdxdna/amdxdna_sysfs.c   |  2 +-
>   drivers/accel/amdxdna/npu3_regs.c       |  7 ++++
>   12 files changed, 163 insertions(+), 65 deletions(-)
>
> diff --git a/drivers/accel/amdxdna/aie.c b/drivers/accel/amdxdna/aie.c
> index dd6f36f222c7..c328ce2f19af 100644
> --- a/drivers/accel/amdxdna/aie.c
> +++ b/drivers/accel/amdxdna/aie.c
> @@ -65,13 +65,12 @@ int aie_send_mgmt_msg_wait(struct aie_device *aie, struct xdna_mailbox_msg *msg)
>   	return ret;
>   }
>   
> -int aie_check_protocol(struct aie_device *aie, u32 fw_major, u32 fw_minor)
> +int aie_check_protocol(struct aie_device *aie, u32 fw_major, u32 fw_minor,
> +		       const struct amdxdna_fw_feature_tbl *feature)
>   {
> -	const struct amdxdna_fw_feature_tbl *feature;
>   	bool found = false;
>   
> -	for (feature = aie->xdna->dev_info->fw_feature_tbl;
> -	     feature->major; feature++) {
> +	for (; feature && feature->major; feature++) {
>   		if (feature->major != fw_major)
>   			continue;
>   		if (fw_minor < feature->min_minor)
> @@ -88,6 +87,32 @@ int aie_check_protocol(struct aie_device *aie, u32 fw_major, u32 fw_minor)
>   	return found ? 0 : -EOPNOTSUPP;
>   }
>   
> +int amdxdna_get_aie_version(struct amdxdna_client *client,
> +			    struct amdxdna_drm_get_info *args,
> +			    struct amdxdna_drm_query_aie_version *version)
> +{
> +	u32 buf_sz;
> +
> +	buf_sz = min_t(u32, args->buffer_size, sizeof(*version));
> +	if (copy_to_user(u64_to_user_ptr(args->buffer), version, buf_sz))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +int amdxdna_get_firmware_version(struct amdxdna_client *client,
> +				 struct amdxdna_drm_get_info *args,
> +				 struct amdxdna_drm_query_firmware_version *version)
> +{
> +	u32 buf_sz;
> +
> +	buf_sz = min_t(u32, args->buffer_size, sizeof(*version));
> +	if (copy_to_user(u64_to_user_ptr(args->buffer), version, buf_sz))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
>   static void amdxdna_update_vbnv(struct amdxdna_dev *xdna,
>   				const struct amdxdna_rev_vbnv *tbl,
>   				u32 rev)
> diff --git a/drivers/accel/amdxdna/aie.h b/drivers/accel/amdxdna/aie.h
> index 0483d582b7f8..229b3cfa2361 100644
> --- a/drivers/accel/amdxdna/aie.h
> +++ b/drivers/accel/amdxdna/aie.h
> @@ -28,6 +28,7 @@ struct aie_device {
>   	struct psp_device *psp_hdl;
>   	struct smu_device *smu_hdl;
>   
> +	struct amdxdna_drm_query_aie_version version;
>   	struct amdxdna_drm_query_aie_metadata metadata;
>   };
>   
> @@ -95,7 +96,8 @@ struct amdxdna_rev_vbnv {
>   void aie_dump_mgmt_chann_debug(struct aie_device *aie);
>   void aie_destroy_chann(struct aie_device *aie, struct mailbox_channel **chann);
>   int aie_send_mgmt_msg_wait(struct aie_device *aie, struct xdna_mailbox_msg *msg);
> -int aie_check_protocol(struct aie_device *aie, u32 fw_major, u32 fw_minor);
> +int aie_check_protocol(struct aie_device *aie, u32 fw_major, u32 fw_minor,
> +		       const struct amdxdna_fw_feature_tbl *feature);
>   void amdxdna_vbnv_init(struct amdxdna_dev *xdna);
>   int amdxdna_get_metadata(struct aie_device *aie, struct amdxdna_client *client,
>   			 struct amdxdna_drm_get_info *args);
> @@ -103,7 +105,12 @@ void *amdxdna_alloc_msg_buffer(struct amdxdna_dev *xdna, u32 *size,
>   			       dma_addr_t *dma_addr);
>   void amdxdna_free_msg_buffer(struct amdxdna_dev *xdna, size_t size,
>   			     void *cpu_addr, dma_addr_t dma_addr);
> -
> +int amdxdna_get_aie_version(struct amdxdna_client *client,
> +			    struct amdxdna_drm_get_info *args,
> +			    struct amdxdna_drm_query_aie_version *version);
> +int amdxdna_get_firmware_version(struct amdxdna_client *client,
> +				 struct amdxdna_drm_get_info *args,
> +				 struct amdxdna_drm_query_firmware_version *version);
>   /* aie_psp.c */
>   struct psp_device *aiem_psp_create(struct drm_device *ddev, struct psp_config *conf);
>   int aie_psp_start(struct psp_device *psp);
> diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/amdxdna/aie2_message.c
> index 56b919b350ac..d95a18af9b09 100644
> --- a/drivers/accel/amdxdna/aie2_message.c
> +++ b/drivers/accel/amdxdna/aie2_message.c
> @@ -149,7 +149,7 @@ int aie2_query_aie_metadata(struct amdxdna_dev_hdl *ndev,
>   }
>   
>   int aie2_query_firmware_version(struct amdxdna_dev_hdl *ndev,
> -				struct amdxdna_fw_ver *fw_ver)
> +				struct amdxdna_drm_query_firmware_version *fw_ver)
>   {
>   	DECLARE_AIE_MSG(firmware_version, MSG_OP_GET_FIRMWARE_VERSION);
>   	int ret;
> @@ -160,7 +160,7 @@ int aie2_query_firmware_version(struct amdxdna_dev_hdl *ndev,
>   
>   	fw_ver->major = resp.major;
>   	fw_ver->minor = resp.minor;
> -	fw_ver->sub = resp.sub;
> +	fw_ver->patch = resp.sub;
>   	fw_ver->build = resp.build;
>   
>   	return 0;
> diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
> index d2fa46e4d3a4..6fa79698f9d8 100644
> --- a/drivers/accel/amdxdna/aie2_pci.c
> +++ b/drivers/accel/amdxdna/aie2_pci.c
> @@ -115,7 +115,8 @@ static int aie2_get_mgmt_chann_info(struct amdxdna_dev_hdl *ndev)
>   	ndev->aie.mgmt_prot_minor = info_regs.prot_minor;
>   
>   	ret = aie_check_protocol(&ndev->aie, ndev->aie.mgmt_prot_major,
> -				 ndev->aie.mgmt_prot_minor);
> +				 ndev->aie.mgmt_prot_minor,
> +				 ndev->aie.xdna->dev_info->fw_feature_tbl);
>   
>   done:
>   	aie_dump_mgmt_chann_debug(&ndev->aie);
> @@ -206,15 +207,16 @@ static int aie2_mgmt_fw_init(struct amdxdna_dev_hdl *ndev)
>   
>   static int aie2_mgmt_fw_query(struct amdxdna_dev_hdl *ndev)
>   {
> +	struct amdxdna_dev *xdna = ndev->aie.xdna;
>   	int ret;
>   
> -	ret = aie2_query_firmware_version(ndev, &ndev->aie.xdna->fw_ver);
> +	ret = aie2_query_firmware_version(ndev, &xdna->fw_ver);
>   	if (ret) {
>   		XDNA_ERR(ndev->aie.xdna, "query firmware version failed");
>   		return ret;
>   	}
>   
> -	ret = aie2_query_aie_version(ndev, &ndev->version);
> +	ret = aie2_query_aie_version(ndev, &ndev->aie.version);
>   	if (ret) {
>   		XDNA_ERR(ndev->aie.xdna, "Query AIE version failed");
>   		return ret;
> @@ -684,44 +686,6 @@ static int aie2_get_aie_status(struct amdxdna_client *client,
>   	return 0;
>   }
>   
> -static int aie2_get_aie_version(struct amdxdna_client *client,
> -				struct amdxdna_drm_get_info *args)
> -{
> -	struct amdxdna_drm_query_aie_version version;
> -	struct amdxdna_dev *xdna = client->xdna;
> -	struct amdxdna_dev_hdl *ndev;
> -	u32 buf_sz;
> -
> -	ndev = xdna->dev_handle;
> -	version.major = ndev->version.major;
> -	version.minor = ndev->version.minor;
> -
> -	buf_sz = min(args->buffer_size, sizeof(version));
> -	if (copy_to_user(u64_to_user_ptr(args->buffer), &version, buf_sz))
> -		return -EFAULT;
> -
> -	return 0;
> -}
> -
> -static int aie2_get_firmware_version(struct amdxdna_client *client,
> -				     struct amdxdna_drm_get_info *args)
> -{
> -	struct amdxdna_drm_query_firmware_version version;
> -	struct amdxdna_dev *xdna = client->xdna;
> -	u32 buf_sz;
> -
> -	version.major = xdna->fw_ver.major;
> -	version.minor = xdna->fw_ver.minor;
> -	version.patch = xdna->fw_ver.sub;
> -	version.build = xdna->fw_ver.build;
> -
> -	buf_sz = min(args->buffer_size, sizeof(version));
> -	if (copy_to_user(u64_to_user_ptr(args->buffer), &version, buf_sz))
> -		return -EFAULT;
> -
> -	return 0;
> -}
> -
>   static int aie2_get_power_mode(struct amdxdna_client *client,
>   			       struct amdxdna_drm_get_info *args)
>   {
> @@ -1036,7 +1000,7 @@ static int aie2_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_i
>   		ret = amdxdna_get_metadata(&ndev->aie, client, args);
>   		break;
>   	case DRM_AMDXDNA_QUERY_AIE_VERSION:
> -		ret = aie2_get_aie_version(client, args);
> +		ret = amdxdna_get_aie_version(client, args, &ndev->aie.version);
>   		break;
>   	case DRM_AMDXDNA_QUERY_CLOCK_METADATA:
>   		ret = aie2_get_clock_metadata(client, args);
> @@ -1048,7 +1012,7 @@ static int aie2_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_i
>   		ret = aie2_get_hwctx_status(client, args);
>   		break;
>   	case DRM_AMDXDNA_QUERY_FIRMWARE_VERSION:
> -		ret = aie2_get_firmware_version(client, args);
> +		ret = amdxdna_get_firmware_version(client, args, &xdna->fw_ver);
>   		break;
>   	case DRM_AMDXDNA_GET_POWER_MODE:
>   		ret = aie2_get_power_mode(client, args);
> diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/amdxdna/aie2_pci.h
> index a5fd71329b93..b31f73082c17 100644
> --- a/drivers/accel/amdxdna/aie2_pci.h
> +++ b/drivers/accel/amdxdna/aie2_pci.h
> @@ -74,7 +74,6 @@ enum aie2_sram_reg_idx {
>   };
>   
>   struct amdxdna_client;
> -struct amdxdna_fw_ver;
>   struct amdxdna_hwctx;
>   struct amdxdna_sched_job;
>   
> @@ -150,7 +149,6 @@ struct amdxdna_dev_hdl {
>   	void			__iomem *mbox_base;
>   
>   	u32				total_col;
> -	struct amdxdna_drm_query_aie_version version;
>   	struct aie2_exec_msg_ops	*exec_msg_ops;
>   	struct drm_gpu_scheduler	*hwctx_sched;
>   	struct ida			hwctx_sched_ida;
> @@ -263,7 +261,7 @@ int aie2_query_aie_version(struct amdxdna_dev_hdl *ndev,
>   int aie2_query_aie_metadata(struct amdxdna_dev_hdl *ndev,
>   			    struct amdxdna_drm_query_aie_metadata *metadata);
>   int aie2_query_firmware_version(struct amdxdna_dev_hdl *ndev,
> -				struct amdxdna_fw_ver *fw_ver);
> +				struct amdxdna_drm_query_firmware_version *fw_ver);
>   int aie2_query_app_health(struct amdxdna_dev_hdl *ndev, u32 context_id,
>   			  struct app_health_report *report);
>   int aie2_get_dev_revision(struct amdxdna_dev_hdl *ndev, enum aie2_dev_revision *rev);
> diff --git a/drivers/accel/amdxdna/aie4_message.c b/drivers/accel/amdxdna/aie4_message.c
> index 88037edbb02a..53f8e366b66c 100644
> --- a/drivers/accel/amdxdna/aie4_message.c
> +++ b/drivers/accel/amdxdna/aie4_message.c
> @@ -64,6 +64,52 @@ int aie4_query_aie_metadata(struct amdxdna_dev_hdl *ndev,
>   	return 0;
>   }
>   
> +int aie4_query_npu_firmware_version(struct amdxdna_dev_hdl *ndev,
> +				    struct amdxdna_drm_query_firmware_version *fw_version)
> +{
> +	DECLARE_AIE_MSG(aie4_msg_identify, AIE4_MSG_OP_IDENTIFY);
> +	int ret;
> +
> +	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
> +	if (ret)
> +		return ret;
> +
> +	fw_version->major = resp.fw_major;
> +	fw_version->minor = resp.fw_minor;
> +	fw_version->patch = resp.fw_patch;
> +	fw_version->build = resp.fw_build;
> +
> +	return 0;
> +}
> +
> +int aie4_query_cert_firmware_version(struct amdxdna_dev_hdl *ndev,
> +				     struct amdxdna_drm_query_firmware_version *cert_version)
> +{
> +	DECLARE_AIE_MSG(aie4_msg_query_cert_firmware_version,
> +			AIE4_MSG_OP_QUERY_CERT_FIRMWARE_VERSION);
> +	int ret;
> +
> +	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
> +	if (ret)
> +		return ret;
> +
> +	ret = aie_check_protocol(&ndev->aie,
> +				 resp.host_queue_major, resp.host_queue_minor,
> +				 ndev->aie.xdna->dev_info->cert_feature_tbl);
> +	if (ret) {
> +		XDNA_ERR(ndev->aie.xdna, "host queue %d.%d is not supported",
> +			 resp.host_queue_major, resp.host_queue_minor);
> +		return ret;
> +	}
> +
> +	cert_version->major = resp.major_version;
> +	cert_version->minor = resp.minor_version;
> +	cert_version->patch = resp.hotfix;
> +	cert_version->build = resp.build;
> +
> +	return 0;
> +}
> +
>   int aie4_attach_work_buffer(struct amdxdna_dev_hdl *ndev)
>   {
>   	DECLARE_AIE_MSG(aie4_msg_attach_work_buffer, AIE4_MSG_OP_ATTACH_WORK_BUFFER);
> diff --git a/drivers/accel/amdxdna/aie4_msg_priv.h b/drivers/accel/amdxdna/aie4_msg_priv.h
> index af0866045b91..5b97c8057de0 100644
> --- a/drivers/accel/amdxdna/aie4_msg_priv.h
> +++ b/drivers/accel/amdxdna/aie4_msg_priv.h
> @@ -10,8 +10,10 @@
>   #include <linux/types.h>
>   
>   enum aie4_msg_opcode {
> +	AIE4_MSG_OP_IDENTIFY                         = 0x10002,
>   	AIE4_MSG_OP_SUSPEND                          = 0x10003,
>   	AIE4_MSG_OP_ATTACH_WORK_BUFFER               = 0x1000D,
> +	AIE4_MSG_OP_QUERY_CERT_FIRMWARE_VERSION      = 0x1000F,
>   
>   	AIE4_MSG_OP_CREATE_VFS                       = 0x20001,
>   	AIE4_MSG_OP_DESTROY_VFS                      = 0x20002,
> @@ -30,6 +32,18 @@ enum aie4_msg_status {
>   	MAX_AIE4_MSG_STATUS_CODE = 0x4,
>   };
>   
> +struct aie4_msg_identify_req {
> +	__u32 rsvd;
> +} __packed;
> +
> +struct aie4_msg_identify_resp {
> +	enum aie4_msg_status status;
> +	__u32 fw_major;
> +	__u32 fw_minor;
> +	__u32 fw_patch;
> +	__u32 fw_build;
> +} __packed;
> +
>   struct aie4_msg_suspend_req {
>   	__u32 rsvd;
>   } __packed;
> @@ -132,6 +146,22 @@ struct aie4_msg_aie4_tile_info_resp {
>   	struct aie4_tile_info info;
>   } __packed;
>   
> +struct aie4_msg_query_cert_firmware_version_req {
> +	__u32 resvd;
> +} __packed;
> +
> +struct aie4_msg_query_cert_firmware_version_resp {
> +	enum aie4_msg_status status;
> +	__u8 major_version;
> +	__u8 minor_version;
> +	__u8 git_hash[41];
> +	__u8 date[11];
> +	__u8 hotfix;
> +	__u8 build;
> +	__u16 host_queue_major;
> +	__u16 host_queue_minor;
> +} __packed;
> +
>   #define AIE4_WORK_BUFFER_MIN_SIZE      SZ_4M
>   
>   struct aie4_msg_attach_work_buffer_req {
> diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
> index f81c43a1f884..e9cd2af224d3 100644
> --- a/drivers/accel/amdxdna/aie4_pci.c
> +++ b/drivers/accel/amdxdna/aie4_pci.c
> @@ -90,7 +90,8 @@ static int aie4_mailbox_info(struct amdxdna_dev *xdna,
>   
>   	ret = aie_check_protocol(&xdna->dev_handle->aie,
>   				 mbox_info->protocol_major,
> -				 mbox_info->protocol_minor);
> +				 mbox_info->protocol_minor,
> +				 xdna->dev_info->fw_feature_tbl);
>   	if (ret)
>   		XDNA_ERR(xdna, "mailbox major.minor %d.%d is not supported",
>   			 mbox_info->protocol_major, mbox_info->protocol_minor);
> @@ -277,7 +278,22 @@ static void aie4_partition_fini(struct amdxdna_dev_hdl *ndev)
>   
>   static int aie4_query(struct amdxdna_dev_hdl *ndev)
>   {
> -	return aie4_query_aie_metadata(ndev, &ndev->aie.metadata);
> +	struct amdxdna_dev *xdna = ndev->aie.xdna;
> +	int ret;
> +
> +	ret = aie4_query_npu_firmware_version(ndev, &xdna->fw_ver);
> +	if (ret)
> +		return ret;
> +
> +	ret = aie4_query_cert_firmware_version(ndev, &ndev->cert_version);
> +	if (ret)
> +		return ret;
> +
> +	ret = aie4_query_aie_metadata(ndev, &ndev->aie.metadata);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
>   }
>   
>   static int aie4_pf_hw_start(struct amdxdna_dev_hdl *ndev)
> diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
> index c6219544dc0f..8c62ee6a9b23 100644
> --- a/drivers/accel/amdxdna/aie4_pci.h
> +++ b/drivers/accel/amdxdna/aie4_pci.h
> @@ -57,6 +57,13 @@ struct amdxdna_dev_hdl {
>   	void				*work_buf;
>   	dma_addr_t			work_buf_addr;
>   	u32				work_buf_size;
> +
> +	struct amdxdna_drm_query_firmware_version cert_version;
> +};
> +
> +enum aie4_fw_feature {
> +	AIE4_HSA_COMMAND = 5,
> +	AIE4_FEATURE_MAX
>   };
>   
>   /* aie4_message.c */
> @@ -64,6 +71,10 @@ int aie4_query_aie_metadata(struct amdxdna_dev_hdl *ndev,
>   			    struct amdxdna_drm_query_aie_metadata *metadata);
>   int aie4_suspend_fw(struct amdxdna_dev_hdl *ndev);
>   int aie4_attach_work_buffer(struct amdxdna_dev_hdl *ndev);
> +int aie4_query_npu_firmware_version(struct amdxdna_dev_hdl *ndev,
> +				    struct amdxdna_drm_query_firmware_version *fw_version);
> +int aie4_query_cert_firmware_version(struct amdxdna_dev_hdl *ndev,
> +				     struct amdxdna_drm_query_firmware_version *cert_version);
>   
>   /* aie4_ctx.c */
>   int aie4_hwctx_init(struct amdxdna_hwctx *hwctx);
> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h b/drivers/accel/amdxdna/amdxdna_pci_drv.h
> index 84c8973e9197..0002e6ef32ba 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
> @@ -99,16 +99,10 @@ struct amdxdna_dev_info {
>   	size_t				dev_heap_max_size;
>   	const struct amdxdna_dev_priv	*dev_priv;
>   	const struct amdxdna_fw_feature_tbl *fw_feature_tbl;
> +	const struct amdxdna_fw_feature_tbl *cert_feature_tbl;
>   	const struct amdxdna_dev_ops	*ops;
>   };
>   
> -struct amdxdna_fw_ver {
> -	u32 major;
> -	u32 minor;
> -	u32 sub;
> -	u32 build;
> -};
> -
>   struct amdxdna_carveout;
>   
>   struct amdxdna_dev {
> @@ -120,7 +114,7 @@ struct amdxdna_dev {
>   	struct mutex			dev_lock; /* per device lock */
>   	struct list_head		client_list;
>   	struct mutex			client_lock; /* client_list */
> -	struct amdxdna_fw_ver		fw_ver;
> +	struct amdxdna_drm_query_firmware_version fw_ver;
>   	struct rw_semaphore		notifier_lock; /* for mmu notifier*/
>   	struct workqueue_struct		*notifier_wq;
>   
> diff --git a/drivers/accel/amdxdna/amdxdna_sysfs.c b/drivers/accel/amdxdna/amdxdna_sysfs.c
> index d9e359ee8182..e20b7fb1e5d1 100644
> --- a/drivers/accel/amdxdna/amdxdna_sysfs.c
> +++ b/drivers/accel/amdxdna/amdxdna_sysfs.c
> @@ -37,7 +37,7 @@ static ssize_t fw_version_show(struct device *dev, struct device_attribute *attr
>   	struct amdxdna_dev *xdna = dev_get_drvdata(dev);
>   
>   	return sprintf(buf, "%d.%d.%d.%d\n", xdna->fw_ver.major,
> -		       xdna->fw_ver.minor, xdna->fw_ver.sub,
> +		       xdna->fw_ver.minor, xdna->fw_ver.patch,
>   		       xdna->fw_ver.build);
>   }
>   static DEVICE_ATTR_RO(fw_version);
> diff --git a/drivers/accel/amdxdna/npu3_regs.c b/drivers/accel/amdxdna/npu3_regs.c
> index 8d287ef32fff..e82bc0a4f597 100644
> --- a/drivers/accel/amdxdna/npu3_regs.c
> +++ b/drivers/accel/amdxdna/npu3_regs.c
> @@ -42,6 +42,11 @@ static const struct amdxdna_fw_feature_tbl npu3_fw_feature_table[] = {
>   	{ 0 }
>   };
>   
> +static const struct amdxdna_fw_feature_tbl npu3_cert_feature_table[] = {
> +	{ .features = BIT_U64(AIE4_HSA_COMMAND), .major = 1, .min_minor = 0 },
> +	{ 0 }
> +};
> +
>   static const struct amdxdna_dev_priv npu3_dev_priv = {
>   	.npufw_path             = "npu.sbin",
>   	.certfw_path            = "cert.sbin",
> @@ -85,6 +90,7 @@ const struct amdxdna_dev_info dev_npu3_pf_info = {
>   	.device_type		= AMDXDNA_DEV_TYPE_PF,
>   	.dev_priv		= &npu3_dev_priv,
>   	.fw_feature_tbl		= npu3_fw_feature_table,
> +	.cert_feature_tbl	= npu3_cert_feature_table,
>   	.ops			= &aie4_pf_ops,
>   };
>   
> @@ -96,5 +102,6 @@ const struct amdxdna_dev_info dev_npu3_vf_info = {
>   	.device_type		= AMDXDNA_DEV_TYPE_UMQ,
>   	.dev_priv		= &npu3_dev_vf_priv,
>   	.fw_feature_tbl		= npu3_fw_feature_table,
> +	.cert_feature_tbl	= npu3_cert_feature_table,
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
>   	.ops			= &aie4_vf_ops,
>   };
