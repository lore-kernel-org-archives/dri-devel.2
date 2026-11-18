Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3145606A33E
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 16:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Af/oENof
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A49FF10FE74;
	Wed, 18 Nov 2026 16:50:49 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010007.outbound.protection.outlook.com [52.101.85.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7CCE10FE66
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 16:50:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xv1TOrqaC1QAEuY1nw8vSnLkU5o5CllQOkWhLGH/gjywd62SA39xxfGjMb+uNbQQxaNji36pi40GoZb595So7EEQN03FIjDIsWH8T40Uh8eK6nO7I1j+V+2ToyDw6mkSzef6kbVJq70V4NG7rIc9X4ZGpTx+9gfmT0UJ9XhINUB9yIMrRK8OtSSSSgfUSQ+gnSQEueNeZRnnSYlAX0YaPT7I78yYHa96jWR4J64q1HAYrK7uWHJrSh3fu/DSauAKFskd4CZV/+b7foMlCqcQPWNAlG+cvDQf0c1Fmn8wcRTXpJhVz+BkrNyDOgq2JqB5KkFLYj43EsTKs+j9tOctQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbGjI/66nuyqjluYg0nK6K8OJBZ92fRhOqgGd2gGE2I=;
 b=eu6geneDpVT/FFfux8wCSvDq4s6X3pAHCf1uQZOD+aknMBOtmAiAwqWX++LbQHEHUBPKHmbzBJKNhBbeT6NDlLcvovryuHfXs1gthTHESQjkVJCABODmwDJTVA3i+JXGGlmpJTZComMeQfpQRgIakx3CAH4sNC3oJWc2SbEGQOtZFAW8xv2H6eK3pyYyS5FOh1Orv5ICTLWAqo+wc7pQ6CBYdxyWl12m4YEy/+KrFywRMZpWZxGLOTN+y/7O4MbBqsPKLidW77RMEk5DBz8T44Cekn6qePIYJzz9NtA9cDhdRjyXQRbW/RYUQFi1qSkvC+QiJNuEz3nZpKkLZYD4Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbGjI/66nuyqjluYg0nK6K8OJBZ92fRhOqgGd2gGE2I=;
 b=Af/oENof0zPHYjRq0X9ElolSyKQ8fWIN6HFT2OJ/hSNDgAgnqKsAxPCpHwtTol3wXxk55ipRP+WpR6J4gBsI2GzJRnheOzo/3So5QLdHYNLCIyc4a9rDL+F0nooidFiPtWAoIajl4Rx0GIsLdH6DZkKVPpwxEKLUfgjSh7ywhfI=
Received: from PH7P220CA0155.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::8)
 by DS0PR12MB445766.namprd12.prod.outlook.com (2603:10b6:8:3df::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 16:50:36 +0000
Received: from PH2PEPF00048915.namprd05.prod.outlook.com
 (2603:10b6:510:33b:cafe::27) by PH7P220CA0155.outlook.office365.com
 (2603:10b6:510:33b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Wed,
 18 Nov 2026 16:50:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH2PEPF00048915.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 16:50:36 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 10:50:35 -0600
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 18 Nov 2026 10:50:35 -0600
Message-ID: <ea436878-c43c-a38a-01bc-6254ddceac08@amd.com>
Date: Wed, 18 Nov 2026 08:50:29 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1 RESEND] accel/amdxdna: Fix SMU command execution on
 platforms without interrupt trigger
Content-Language: en-US
To: Max Zhen <max.zhen@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
References: <20261117223142.179304-1-max.zhen@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20261117223142.179304-1-max.zhen@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH2PEPF00048915:EE_|DS0PR12MB445766:EE_
X-MS-Office365-Filtering-Correlation-Id: c1d7ad0d-e0d2-460c-2304-08df459411a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|10067099003|56012099006|11063799006|261026140227099003|261021135927099003|261026130827099003|261021121427099003|261022075727099003|261021130227099003|261021133027099003|261022113327099003|261026121527099003|261021123027099003|261026135527099003|261022115727099003|261028144727099003|261022105027099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: zUvyoQ/bfPVqr+JClGOTky6N5G01+cr/RmiyXhJ08S8OmVJRat2wV74vn6bQBE7cxSK3H0SIV+PH8TC+N6mSU0Av5Re6vK4tJMLFNBygLOXz77tgMvHPWOvYOZNs/stiQu1ntYnQHIZ2y7i+flIGy89PpM57oR9prK1yDXo6OxqsulDD0bXGP+DRjH+vvhw7UsPfZWfR/tfeefmLIPMokKu+e+oSu+J6I2X59LumkBTZPWyr7DydFPKH+7MfHfVf50Z5cB0v+mNqwb9L2JIAPik+yYIZYgbL3NQGb1g3Rv5KAZjtgYbVn8Sn/xcSXTVAXB/xpVgLmZa5eMrWrhumlwm94Mn59ob8IcYcw2yxIEUXna02cT0BkHyYCq4usJEPLSrcbYZ283kkCK3LFzjD55aB/zVxSgxHGyab728mAfDvlzi9+0HisSgXdwB23ZNPLZlS8gD75psbJQs4Yjzy6MpIZerzs7LAVqktilt7Wr1sWSKTiBxqRWMZYJusWKpLWPImb4BM7SCYQ1dq6AWaITWtGbF/ve68FHWCX/6CpipfDFiRhWLy+Ul2X3KgfbubPTRH6ha8uLBOOsImApVmmEQxRUWA+wVv0fcCXedwQQBpuoKJU3osSrErlran2cyQjX6FWU9J1qBQoVd3lTi8xEfMrtUs3Ywe44+qINxlPQiK54WePjmgMJ7YAVaCeTEIQ1mHvll9HVCU9ZeBUWsOKg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(10067099003)(56012099006)(11063799006)(261026140227099003)(261021135927099003)(261026130827099003)(261021121427099003)(261022075727099003)(261021130227099003)(261021133027099003)(261022113327099003)(261026121527099003)(261021123027099003)(261026135527099003)(261022115727099003)(261028144727099003)(261022105027099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HTR1e5gURfohzIh1hr+Pq1Lhiu2xn42vtCv+vWgpccT3glSC7m3Hq4V1urv6POjSv7ZTElmK58zVY2hclE4TpVzxqbHgFZLTvQ7zIQwlviJRhd0Cs80aB1Aq+9+0Nf7oQvmckGorV3HTXKe/HtWu1Ej0H06jky6LK+WmE66PTnfPcxlHjuEK1feTiiLG+Qdx0yAov2is5z6EBwYP1d2w03U3f3P5kbdQtvgUeGFUJ/lN31y0Wo9ZV84zc08rBANBYtP1E85DwtTF3Z+VRJHW5TKrEKyM1Qb5g4+xqojMKx0NZ3vPawnjju7Hzv3fHaIl/5HbSu1HgwiPv8ToI9MTK7DNGtIHPUk05t8xVg5UcEXpn3vOHgd1HuHs9Kxc9m8o3X4RWpqgDrI2kezY0q/e7gsMbLJ4obtjFgDg+4154XpjXnrrmHHltrSvPWqKOF5u
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 16:50:36.1871 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d7ad0d-e0d2-460c-2304-08df459411a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH2PEPF00048915.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB445766
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/17/26 14:31, Max Zhen wrote:
> SMU command execution currently unconditionally manipulates
> SMU_INTR_REG when issuing a command. This works on platforms that
> require an interrupt trigger to start command processing, but it
> causes failures on platforms where commands are executed directly
> through the command and argument registers.
>
> Add a per-device SMU configuration flag indicating whether the
> interrupt mechanism is required. When enabled, wait for the interrupt
> register to become idle before submitting a command and trigger
> execution by writing to SMU_INTR_REG. When disabled, skip the
> interrupt handshake and rely on the command register write to start
> execution.
>
> This allows the common SMU implementation to correctly support both
> interrupt-driven and non-interrupt-driven firmware interfaces.
>
> Signed-off-by: Max Zhen <max.zhen@amd.com>
> ---
>   drivers/accel/amdxdna/aie.h       |  1 +
>   drivers/accel/amdxdna/aie2_pci.c  |  1 +
>   drivers/accel/amdxdna/aie2_pci.h  |  1 +
>   drivers/accel/amdxdna/aie_smu.c   | 20 +++++++++++++++-----
>   drivers/accel/amdxdna/npu1_regs.c |  1 +
>   5 files changed, 19 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/accel/amdxdna/aie.h b/drivers/accel/amdxdna/aie.h
> index 13af4b9b2cf2b..991e45ac7f364 100644
> --- a/drivers/accel/amdxdna/aie.h
> +++ b/drivers/accel/amdxdna/aie.h
> @@ -110,6 +110,7 @@ struct aie_bar_off_pair {
>   
>   struct smu_config {
>   	void __iomem    *smu_regs[SMU_MAX_REGS];
> +	bool		intr_enabled;
>   };
>   
>   struct psp_config {
> diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
> index a3866e8933e61..cc53c1fc39443 100644
> --- a/drivers/accel/amdxdna/aie2_pci.c
> +++ b/drivers/accel/amdxdna/aie2_pci.c
> @@ -603,6 +603,7 @@ static int aie2_init(struct amdxdna_dev *xdna)
>   
>   	for (i = 0; i < SMU_MAX_REGS; i++)
>   		smu_conf.smu_regs[i] = tbl[SMU_REG_BAR(ndev, i)] + SMU_REG_OFF(ndev, i);
> +	smu_conf.intr_enabled = ndev->priv->smu_intr_enabled;
>   	ndev->aie.smu_hdl = aiem_smu_create(&xdna->ddev, &smu_conf);
>   	if (!ndev->aie.smu_hdl) {
>   		XDNA_ERR(xdna, "failed to create smu");
> diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/amdxdna/aie2_pci.h
> index 13391275df318..26e3ccdaddd54 100644
> --- a/drivers/accel/amdxdna/aie2_pci.h
> +++ b/drivers/accel/amdxdna/aie2_pci.h
> @@ -190,6 +190,7 @@ struct amdxdna_dev_priv {
>   	struct aie_bar_off_pair		sram_offs[SRAM_MAX_INDEX];
>   	struct aie_bar_off_pair		psp_regs_off[PSP_MAX_REGS];
>   	struct aie_bar_off_pair		smu_regs_off[SMU_MAX_REGS];
> +	bool				smu_intr_enabled;
>   	const struct aie_hw_ops		*hw_ops;
>   };
>   
> diff --git a/drivers/accel/amdxdna/aie_smu.c b/drivers/accel/amdxdna/aie_smu.c
> index 62aea550aabcf..36a5cf88aea75 100644
> --- a/drivers/accel/amdxdna/aie_smu.c
> +++ b/drivers/accel/amdxdna/aie_smu.c
> @@ -26,22 +26,31 @@
>   
>   struct smu_device {
>   	struct drm_device	*ddev;
> -	struct smu_config	conf;
>   	void __iomem		*smu_regs[SMU_MAX_REGS];
> +	bool			intr_enabled;
>   };
>   
>   static int aie_smu_exec(struct smu_device *smu, u32 reg_cmd, u32 reg_arg, u32 *out)
>   {
> -	u32 resp;
> +	u32 resp, intr;
>   	int ret;
>   
> +	if (smu->intr_enabled) {
> +		ret = readx_poll_timeout(readl, SMU_REG(smu, SMU_INTR_REG), intr,
> +					 !(intr & 0x2), AIE_INTERVAL, AIE_TIMEOUT);
> +		if (ret) {
> +			drm_err(smu->ddev, "wait for smu intr idle timed out, 0x%x", intr);
> +			return ret;
> +		}
> +	}
> +
>   	writel(0, SMU_REG(smu, SMU_RESP_REG));
>   	writel(reg_arg, SMU_REG(smu, SMU_ARG_REG));
>   	writel(reg_cmd, SMU_REG(smu, SMU_CMD_REG));
>   
> -	/* Clear and set SMU_INTR_REG to kick off */
> -	writel(0, SMU_REG(smu, SMU_INTR_REG));
> -	writel(1, SMU_REG(smu, SMU_INTR_REG));
> +	/* Set SMU_INTR_REG to kick off */
> +	if (smu->intr_enabled)
> +		writel(1, SMU_REG(smu, SMU_INTR_REG));
>   
>   	ret = readx_poll_timeout(readl, SMU_REG(smu, SMU_RESP_REG), resp,
>   				 resp, AIE_INTERVAL, AIE_TIMEOUT);
> @@ -148,6 +157,7 @@ struct smu_device *aiem_smu_create(struct drm_device *ddev, struct smu_config *c
>   
>   	smu->ddev = ddev;
>   	memcpy(smu->smu_regs, conf->smu_regs, sizeof(smu->smu_regs));
> +	smu->intr_enabled = conf->intr_enabled;
>   
>   	return smu;
>   }
> diff --git a/drivers/accel/amdxdna/npu1_regs.c b/drivers/accel/amdxdna/npu1_regs.c
> index b4a0ede636f0d..0b45375ea1108 100644
> --- a/drivers/accel/amdxdna/npu1_regs.c
> +++ b/drivers/accel/amdxdna/npu1_regs.c
> @@ -124,6 +124,7 @@ static const struct amdxdna_dev_priv npu1_dev_priv = {
>   		DEFINE_BAR_OFFSET(SMU_RESP_REG, NPU1_SMU, MPNPU_PUB_SCRATCH6),
>   		DEFINE_BAR_OFFSET(SMU_OUT_REG,  NPU1_SMU, MPNPU_PUB_SCRATCH7),
>   	},
> +	.smu_intr_enabled = true,
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
>   	.hw_ops		= &(const struct aie_hw_ops) {
>   		.set_dpm = npu1_set_dpm,
>   	},
