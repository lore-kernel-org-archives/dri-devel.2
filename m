Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34FC606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 18:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xSiCMaza
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2195210EE9D;
	Tue, 10 Nov 2026 18:35:56 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013040.outbound.protection.outlook.com
 [40.107.201.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC1A710E957
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 18:35:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BfzP0n/zQrmK+itD/VBFFgOWnWVGf1CIs2eDQ6nyXdTZY0fSrftcAzh2+0fKFivBWugVDx6pg5HVHee5OlnnEzhNuhHE62WGHSiU2lqMIeJGALkp4orUL3sM1A3rV7KsSDYTvkbD7BEDelirpvBvOYSJmcW2T8gtbkTFrATX2Aaj7/EwoSkHGxeEoKcQo4RuTG+qjzk/5/mtYvj5yXLQFgMRdvW6kXI4P2ARyrTuWyAithqZTBIvBboYEObLEtsHv7xMGKGjJs54PCBu/7C73dbwoRxYuKBIoEz5Zl9f2ZjsAN2DCbvoWhS5s0hvc+FPeHYW7JkeWJoESa3qGS98Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6t6YpjmaHwsUAoqgX8nu6+PL4HNPwqUIUfpGNMSA3YU=;
 b=GIKV+7Zq6VyZYVTN2RYwPaG6b+kK4bNXqC9kUhvGGhFxoarnW6kLvJNudiL8zaJr7I7KZ8I6zbbu6dpwnf6YxSTAR1HfmNTGK5sJXoA+6rKAFFsXxEZx4dmsbh6AMOphyXoudfwazgrz/mDwllyIHqEJgevHKQOZr37ehVWskUT1wKUzq8gWh2OmsfJEEKWVzJcqvCZBW4DTOa+pTBgOOYmTORUfP1kYjugnpwkg08wMVxCrmgG8AEvbRzLp31QbBOlDoY/+SV62CE9PF6c7juI7J4wWMAR8+sd1e6msq3US8gcgjRCcYM+SHAoSVPGsh8SkhGNRDCtUwxN+GLS4gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6t6YpjmaHwsUAoqgX8nu6+PL4HNPwqUIUfpGNMSA3YU=;
 b=xSiCMazaHgq10DmByQsmxZYCvnVjPlM302fD+oJ4RBixj7yI3Eh1d2iLZbAXC9ODBfBjT0Mb45VRhKl2IZqKgeGu5yobvxpP+TYL7l+HGrBfRr9U9yHykQ5Icch9m+2pkloZucuAkJzIgnzGX0UPXbb4dRftO6hHzsMc0KBTIMc=
Received: from PH8PR05CA0005.namprd05.prod.outlook.com (2603:10b6:510:2cc::14)
 by PH7PR12MB7795.namprd12.prod.outlook.com (2603:10b6:510:278::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Tue, 10 Nov
 2026 18:35:45 +0000
Received: from MW3PEPF00001658.namprd21.prod.outlook.com
 (2603:10b6:510:2cc:cafe::40) by PH8PR05CA0005.outlook.office365.com
 (2603:10b6:510:2cc::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 18:35:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW3PEPF00001658.mail.protection.outlook.com (10.167.249.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.0 via Frontend Transport; Tue, 10 Nov 2026 18:35:44 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 12:35:44 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 12:35:44 -0600
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 12:35:43 -0600
Message-ID: <19e0180b-5d2a-7af7-cb00-d7d640e64f71@amd.com>
Date: Tue, 10 Nov 2026 10:35:43 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RESEND V1 1/4] accel/amdxdna: Add NPU10 and NPU11 devices
Content-Language: en-US
To: David Zhang <yidong.zhang@amd.com>, <quic_jhugo@quicinc.com>,
 <karol.wachowski@linux.intel.com>, <max.zhen@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <sonal.santan@amd.com>, <mario.limonciello@amd.com>
References: <20261104224302.643329-1-yidong.zhang@amd.com>
 <20261104224302.643329-2-yidong.zhang@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20261104224302.643329-2-yidong.zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PEPF00001658:EE_|PH7PR12MB7795:EE_
X-MS-Office365-Filtering-Correlation-Id: bb12b83c-c76e-447c-4bd4-08df3f596e99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|4143699003|10067099003|11063799006|56012099006|261022105027099003|261022075727099003|261009223027099003|261102123227099003|261026140227099003|261028144727099003|261026121527099003|261021121427099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: pNrRUYieTXmSrnstBwMr2RlShn0fwnFVse5QWSqIVurE+HN8Eyx1YDHht+ORlW9VcaKaPIjDuwt8JewBT1FcjwM2bvqdj+Mv6saYmO3wJ+hncwEv1M+iPH7Pa94y2JHY68U8sO11E90G41xGFa9zdQceDeW+8Hs2eeVHJtP71FMK6yhN2LZoYG3gpNtLgItQu0pvGvTWufDtoM4bdyLheDPTV4t4TktNGolo+p7A50R3xGX0x0K1v3yiP0VdrOTpatEzOOqM0wqNiQPLfG31WoKhsKwZIypUc/gVBWfAeRmDXmYQ7sG/QHmEFMABxGVq0GSagw0XhSaWjBTzeWn6/9BL1qygwY2yGZEgkeNaZMxNembkPbBEnpVRJgrC9wEWEo+wadv4TuJp2uSxFCl0IfCVBdXYydOa30FUrXg6RMlmMLrBHFatUNPxA/GCm2vI28Z38GWcBKBaNCWcnORp0TasiFsojofIldfmjERtN0RE+1v76WKnoSgYUVslKecU+xBPfLENfHi81S/+Ax7+Rznerniunc8c9Ajhtb6diwp0Xt78fXBD34beMAooo904X9+qe5UlaHkBYrJkYM6eCXUSydim0SI89sFAPexrhj/6c+4mRjD9aPn5t4F14AYF11HouhmsXtz1G/+du0+6smGbrn5sSbH43Oe3pH2imlZHhFNQ6ekq87HVABpJVSdenwATdpHnK2SnnP7S6/kr1Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(4143699003)(10067099003)(11063799006)(56012099006)(261022105027099003)(261022075727099003)(261009223027099003)(261102123227099003)(261026140227099003)(261028144727099003)(261026121527099003)(261021121427099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0o+L9LgpMkBMnm+eSe3xFqjsBq0EijMOvXAg8a66sd39YBZp//lwIcbVUP/B1gZuDDfcSjJ05nrH53VVcwm+ooFbLmIR+ZTMb7lqjDdm89A1yg9wydCyDf0JfYzizpgFl3osTYJ7t045j2W0uU414QJQ17/DDvuU566ekH7HwL+2nU+KzGNQBzGJKumBCFGx3pZi/yN5A8aoFAbdW7hiILIgW1HfcOVjOR8XfS2SvYK4/B1jRsmXfy9mLvgnXHC3kO9X464Morz4arAXtqoAP1Fpk0i8yY3poVRIhLD74wNREH7PRS3kLstk+AskDZjVrGp1pfxGKrHV+ZusPoLP3FGU/uLyjexdfGYZ827XXgp1V/zAqEmcRvykFQmmnD+1iXPDe+qrYY5wfod+toj6Z5p66N+zjFqrs4v6EZ19Z5v95b1MMTYq/YVslYu7blXz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 18:35:44.8769 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb12b83c-c76e-447c-4bd4-08df3f596e99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW3PEPF00001658.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7795
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


On 11/4/26 14:42, David Zhang wrote:
> NPU3 revisions 0x14 and 0x15 are NPU10 and NPU11. Add their classic,
> PF and VF devices with their firmware files and report each by its own
> name. They otherwise use the NPU3 settings.
>
> Signed-off-by: David Zhang <yidong.zhang@amd.com>
> ---
>   drivers/accel/amdxdna/amdxdna_pci_drv.c | 14 +++++
>   drivers/accel/amdxdna/amdxdna_pci_drv.h |  6 ++
>   drivers/accel/amdxdna/npu3_regs.c       | 78 +++++++++++++++++++++++++
>   3 files changed, 98 insertions(+)
>
> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> index f233eb70a295..685fe1a7dd56 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> @@ -37,6 +37,14 @@ MODULE_FIRMWARE("amdnpu/17f1_13/npu.sbin");
>   MODULE_FIRMWARE("amdnpu/17f1_13/cert.sbin");
>   MODULE_FIRMWARE("amdnpu/17f2_13/npu.sbin");
>   MODULE_FIRMWARE("amdnpu/17f2_13/cert.sbin");
> +MODULE_FIRMWARE("amdnpu/17f1_14/npu.sbin");
> +MODULE_FIRMWARE("amdnpu/17f1_14/cert.sbin");
> +MODULE_FIRMWARE("amdnpu/17f2_14/npu.sbin");
> +MODULE_FIRMWARE("amdnpu/17f2_14/cert.sbin");
> +MODULE_FIRMWARE("amdnpu/17f1_15/npu.sbin");
> +MODULE_FIRMWARE("amdnpu/17f1_15/cert.sbin");
> +MODULE_FIRMWARE("amdnpu/17f2_15/npu.sbin");
> +MODULE_FIRMWARE("amdnpu/17f2_15/cert.sbin");
>   
>   /*
>    * 0.0: Initial version
> @@ -81,6 +89,12 @@ static const struct amdxdna_device_id amdxdna_ids[] = {
>   	{ 0x17f1, 0x13, &dev_npu3_classic_info },
>   	{ 0x17f2, 0x13, &dev_npu3_pf_info },
>   	{ 0x17f3, 0x13, &dev_npu3_vf_info },
> +	{ 0x17f1, 0x14, &dev_npu10_classic_info },
> +	{ 0x17f2, 0x14, &dev_npu10_pf_info },
> +	{ 0x17f3, 0x14, &dev_npu10_vf_info },
> +	{ 0x17f1, 0x15, &dev_npu11_classic_info },
> +	{ 0x17f2, 0x15, &dev_npu11_pf_info },
> +	{ 0x17f3, 0x15, &dev_npu11_vf_info },
>   	{0}
>   };
>   
> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h b/drivers/accel/amdxdna/amdxdna_pci_drv.h
> index 27593190dcf6..5ca32c5b1de0 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
> @@ -187,6 +187,12 @@ extern const struct amdxdna_dev_info dev_npu1_info;
>   extern const struct amdxdna_dev_info dev_npu3_classic_info;
>   extern const struct amdxdna_dev_info dev_npu3_pf_info;
>   extern const struct amdxdna_dev_info dev_npu3_vf_info;
> +extern const struct amdxdna_dev_info dev_npu10_classic_info;
> +extern const struct amdxdna_dev_info dev_npu10_pf_info;
> +extern const struct amdxdna_dev_info dev_npu10_vf_info;
> +extern const struct amdxdna_dev_info dev_npu11_classic_info;
> +extern const struct amdxdna_dev_info dev_npu11_pf_info;
> +extern const struct amdxdna_dev_info dev_npu11_vf_info;
>   extern const struct amdxdna_dev_info dev_npu4_info;
>   extern const struct amdxdna_dev_info dev_npu5_info;
>   extern const struct amdxdna_dev_info dev_npu6_info;
> diff --git a/drivers/accel/amdxdna/npu3_regs.c b/drivers/accel/amdxdna/npu3_regs.c
> index cff99ddd3a55..4d38aeaea6d0 100644
> --- a/drivers/accel/amdxdna/npu3_regs.c
> +++ b/drivers/accel/amdxdna/npu3_regs.c
> @@ -197,3 +197,81 @@ const struct amdxdna_dev_info dev_npu3_classic_info = {
>   	.cert_feature_tbl	= npu3_cert_feature_table,
>   	.ops			= &aie4_classic_ops,
>   };
> +
> +const struct amdxdna_dev_info dev_npu10_pf_info = {
> +	.mbox_bar		= NPU3_MBOX_BAR,
> +	.sram_bar		= NPU3_MBOX_BUFFER_BAR,
> +	.psp_bar		= NPU3_PSP_BAR_INDEX,
> +	.smu_bar		= NPU3_SMU_BAR_INDEX,
> +	.default_vbnv		= "RyzenAI-npu10-pf",
> +	.device_type		= AMDXDNA_DEV_TYPE_PF,
> +	.dev_priv		= &npu3_dev_priv,
> +	.fw_feature_tbl		= npu3_fw_feature_table,
> +	.cert_feature_tbl	= npu3_cert_feature_table,
> +	.ops			= &aie4_pf_ops,
> +};
> +
> +const struct amdxdna_dev_info dev_npu10_vf_info = {
> +	.mbox_bar		= NPU3_MBOX_BAR,
> +	.sram_bar		= NPU3_MBOX_BUFFER_BAR,
> +	.doorbell_bar		= NPU3_DOORBELL_BAR,
> +	.default_vbnv		= "RyzenAI-npu10-vf",
> +	.device_type		= AMDXDNA_DEV_TYPE_UMQ,
> +	.dev_priv		= &npu3_dev_vf_priv,
> +	.fw_feature_tbl		= npu3_fw_feature_table,
> +	.cert_feature_tbl	= npu3_cert_feature_table,
> +	.ops			= &aie4_vf_ops,
> +};
> +
> +const struct amdxdna_dev_info dev_npu10_classic_info = {
> +	.mbox_bar		= NPU3_MBOX_BAR,
> +	.sram_bar		= NPU3_MBOX_BUFFER_BAR,
> +	.psp_bar		= NPU3_PSP_BAR_INDEX,
> +	.smu_bar		= NPU3_SMU_BAR_INDEX,
> +	.doorbell_bar		= NPU3_DOORBELL_BAR,
> +	.default_vbnv		= "RyzenAI-npu10",
> +	.device_type		= AMDXDNA_DEV_TYPE_UMQ,
> +	.dev_priv		= &npu3_dev_priv,
> +	.fw_feature_tbl		= npu3_fw_feature_table,
> +	.cert_feature_tbl	= npu3_cert_feature_table,
> +	.ops			= &aie4_classic_ops,
> +};
> +
> +const struct amdxdna_dev_info dev_npu11_pf_info = {
> +	.mbox_bar		= NPU3_MBOX_BAR,
> +	.sram_bar		= NPU3_MBOX_BUFFER_BAR,
> +	.psp_bar		= NPU3_PSP_BAR_INDEX,
> +	.smu_bar		= NPU3_SMU_BAR_INDEX,
> +	.default_vbnv		= "RyzenAI-npu11-pf",
> +	.device_type		= AMDXDNA_DEV_TYPE_PF,
> +	.dev_priv		= &npu3_dev_priv,
> +	.fw_feature_tbl		= npu3_fw_feature_table,
> +	.cert_feature_tbl	= npu3_cert_feature_table,
> +	.ops			= &aie4_pf_ops,
> +};
> +
> +const struct amdxdna_dev_info dev_npu11_vf_info = {
> +	.mbox_bar		= NPU3_MBOX_BAR,
> +	.sram_bar		= NPU3_MBOX_BUFFER_BAR,
> +	.doorbell_bar		= NPU3_DOORBELL_BAR,
> +	.default_vbnv		= "RyzenAI-npu11-vf",
> +	.device_type		= AMDXDNA_DEV_TYPE_UMQ,
> +	.dev_priv		= &npu3_dev_vf_priv,
> +	.fw_feature_tbl		= npu3_fw_feature_table,
> +	.cert_feature_tbl	= npu3_cert_feature_table,
> +	.ops			= &aie4_vf_ops,
> +};
> +
> +const struct amdxdna_dev_info dev_npu11_classic_info = {
> +	.mbox_bar		= NPU3_MBOX_BAR,
> +	.sram_bar		= NPU3_MBOX_BUFFER_BAR,
> +	.psp_bar		= NPU3_PSP_BAR_INDEX,
> +	.smu_bar		= NPU3_SMU_BAR_INDEX,
> +	.doorbell_bar		= NPU3_DOORBELL_BAR,
> +	.default_vbnv		= "RyzenAI-npu11",
> +	.device_type		= AMDXDNA_DEV_TYPE_UMQ,
> +	.dev_priv		= &npu3_dev_priv,
> +	.fw_feature_tbl		= npu3_fw_feature_table,
> +	.cert_feature_tbl	= npu3_cert_feature_table,
> +	.ops			= &aie4_classic_ops,
> +};
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
