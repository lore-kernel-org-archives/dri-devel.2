Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D95AC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 17:26:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E20ED10E4CE;
	Tue,  7 Jul 2026 17:26:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Yq9UAZbV";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012007.outbound.protection.outlook.com [52.101.53.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8F3910E50B
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 17:26:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RjuDkVYixSpnIGLIvEoYgO8Jcq4UtzGau7P04F55g0BlZW9XbtQWF78wxGtHbtWR3Nu00VvRQ+fCXh3Kq9R5sv9DUbU3CMYP3+OwdVmdHYN2+m02BDnLf7IJ8+mXhSplVtgAsEVT4u7ANcO+/J2MI/2RYgSGLOrK1on4X+UZ0TyvUlijvTPM2THDAwwphUQlQaTEY6ucN9ofAToMggBu9aISFyJd5fV5m6B8PsS+lx0M1IC4hiGdT1hqhiY+Ed5m1s4iq1cn61D/QzDbcadafex+wmAYCPQtFI9DAEueHNy7qEoWwGc2DdSB6yDdeZ/CiJn5+tpUvYBh0IGSo009VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AezDl274YPdLVZUZoJZIOzeg9puiF7U/sMoxi6Mojds=;
 b=nf7eQp3Oc3cOSa/y1jN8tmrGYzrI5ZxQHJD4wO99JSGgZofRKtkxL2ul2qJ7tzJy5oSoSf/fapuJgMsrixVRmQBg0ZMJ0NlKtlFmziIWSUh2R1ka9GRqimi3G3ZtIBXLHugkOQyVLY3GCj4Pq99sEFlPXyc6ICvEBWRrP4TgUThSlL7t1a9aHh9Cw0CCWaRhvpEm7d7uHHtF0r4fR/cNMQXnIUcXCv0e7RXDS/pMWmRlKQyVB0oKcSIO8jENn5yAuwVaOT0pRS8amOz/6sV9xRpaHcVNJlyUtxtDV9axPQbuUbHD5PeYzLmRRGEmjDNjvxDUtlwyCB2nuCMumJ604A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AezDl274YPdLVZUZoJZIOzeg9puiF7U/sMoxi6Mojds=;
 b=Yq9UAZbVCcRaxCA135jt45GsdUy0rQC3kJ7F14R/VgKeweUrbc3bLxACIfr2HR2ajs7hQQme5kvTIz5yBjTapUim6zScSUJor2HQGzhvG8pJrNZQ+FScHF7byxL6kPxxXm+WhGjTSk5SfayngCNtHjKslrORZ4SHBtue6w618jk=
Received: from BN9PR03CA0213.namprd03.prod.outlook.com (2603:10b6:408:f8::8)
 by CY5PR12MB6108.namprd12.prod.outlook.com (2603:10b6:930:27::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 17:26:33 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:408:f8:cafe::a1) by BN9PR03CA0213.outlook.office365.com
 (2603:10b6:408:f8::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 7
 Jul 2026 17:26:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.0 via Frontend Transport; Tue, 7 Jul 2026 17:26:32 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 12:26:32 -0500
Received: from [172.19.70.117] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 12:26:32 -0500
Message-ID: <580d53bf-cd7d-499f-b559-17a3a8f0dd2c@amd.com>
Date: Tue, 7 Jul 2026 10:26:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Check drmm_mutex_init() return value
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
References: <20260707172307.539676-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Max Zhen <max.zhen@amd.com>
In-Reply-To: <20260707172307.539676-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|CY5PR12MB6108:EE_
X-MS-Office365-Filtering-Correlation-Id: 10d4c9a5-f40c-458b-c545-08dedc4ce3af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: RQTzloa9FdZEOY1Q01GcuAMY31R+Xsnfn9VjIWY4F9v1UfqyrxBGtMyCjOJ4Jw5yLdKp15YD0oTajxpwTxBhF6x3+U0yGGOpcvmm97WI7ng0nfmjfv5Cm0GaNIEdr7lo1aV1m4/xBrSro66D0eBeIjrok0H7bZH4kLX3n74bvQitGL75PjGh9vgV9M7b99+NfBOYad9r0ezecns7Lr+re8vwt4jEqnTtlwII1SlcAwpA/TKsFrxTBcAsvV4uRG2YsiHnpzyvru1LxcYOfKxOt0mF6aQ9O7pmMSdOd0T81GanzO/uF/RLkRughpIxhvlY6Hosee2i+isuzPNkDH/09sfNDZwe+5/unHJ4MV1hUg/D6xyU89i5+Mj1gwqSia1ZevYgySGO4YDSEj9mYxWjiJDTZRLHH0bGSAbFqazBtBgciLyxAWvfOyhGXNu3YbbZn8Aya5hD4ukTf4pjuNdPwgSZ9NZcLc6zasyNfROil+qsx19Snau/zF9HfVBNx1qS+rxdLvOLRHpVBQSJf7jVNmtcMNEaV8k+RUOO8oio9CzApVTzOlPklO2eisWA9zKK6/RFfgc6+QWVY+1sSAEG5yoPv5ubhm5xbqlFZOS34iyFBN74rNKzpG/NX6FZXBMOv+QI1ga/AciiKU4iSLmYg0usGPhtImicoej9j9bbmvgmEKyUhc8JzYN3288h1DZxiFhJs7I0eMtpVjKbvEPclg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xCMo4Rz4+UmN0sCL5knDmyXD24PNO9RQeNnPEEWAGtNW3pfVxmbY9BAfDSjeDvNfdcQdg6Uw8JNup679h0whr1rWenAcMyDKJZ//ICCEjmbPHogA9+sBF3XF6wL/Idn+4Hy9jBfIo81gJ8FgiC1B8vqm4UjJgCYs7ZbKj48bETqBaK7iEam9cgyuOG1AqkkCMNRg0hb0gp7k0Sfm2PVx1rkHLXxS6CPj/Qb/VZYPvmBl8ji8NVxM4T6KJEc+dw2Nk31hHCGZEf0swF986Y2gqa/RkTWF3Lxf+dS1O3u4q3os2ov0LaTI2WpxLKWOSE4tmla4CED6LSecLHpJa8p+fzgfxGy1z1gLp1y8u3p3epOBaU2I7sXa20WaGh42AqaUCDJk1vgKvicZW9EO02AVmaY0rgoqY6ABoeZ+hKDuKy+jxr2cS906MtjdbgelrU25
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 17:26:32.8339 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d4c9a5-f40c-458b-c545-08dedc4ce3af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6108
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



On 7/7/2026 Tue 10:23, Lizhi Hou wrote:
> drmm_mutex_init() may fail and return an error. Check the return value
> and abort initialization if mutex creation fails.
> 
> Fixes: 8c9ff1b181ba ("accel/amdxdna: Add a new driver for AMD AI Engine")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Max Zhen <max.zhen@amd.com>
> ---
>   drivers/accel/amdxdna/amdxdna_pci_drv.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> index e94d8290a807..86e9c230875a 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> @@ -373,7 +373,10 @@ static int amdxdna_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	if (ret)
>   		return ret;
>   
> -	drmm_mutex_init(ddev, &xdna->dev_lock);
> +	ret = drmm_mutex_init(ddev, &xdna->dev_lock);
> +	if (ret)
> +		return ret;
> +
>   	init_rwsem(&xdna->notifier_lock);
>   	INIT_LIST_HEAD(&xdna->client_list);
>   	pci_set_drvdata(pdev, xdna);

