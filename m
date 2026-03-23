Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D75F483CC
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:53:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B982A10E3ED;
	Mon, 23 Mar 2026 16:53:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sODmz9Jp";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010025.outbound.protection.outlook.com [52.101.46.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6749C10E3ED
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 16:53:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D5I64OEvuZCPhm2ZwjDtXw3DuF6y+BtCh+pp1J9CHfbMld6c/Ex2dlkPbh4lW9sU9zIsoaaV81ejOem/kdlMcz8BfTf6rPyCxpERQmdoaqiEqA3m8T+knNZEiTmnHPVstGpEhQKQ/0e4JPAOni6A1ciUl1kLveo+Z+fs2Rv+gC4xLOyNSQnkCKhvtlxh0A0u+US98muYJtJmXc2AIerF2/RYhC/N1Pohl9XEYBUIjh9crhMg09jXezEgP0XiCHgxgFY9lCpZsamzQtTq9snVCr0jOHgFOGWMsofK5Qci0JB0TOJWAqhPX27WHQWdSmSzklhduI8oSQhAo2B6MRIQMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZavQ9bjB+VliHb2MsIquZ4n4jtqBaKHivDG64YPjkwg=;
 b=gQkLtR6/mRf4h0Io1g/ovZ+xddEQsfgo5a7fCftgViysNtsc+NBIRnFsDb3XZeu2pnMyrvoMeyE/ETNuT7xfxgMh0+qd1T7TWd9c+9ZUenjCj2bn93qDlcP/TfbYFy0WV/SLnGTSv0IQJ0hWJo97hXXILMK93GBYSJIlFzhFcWr8O4Jdo+KFD9KdprQhbFsKZhKPezjJCEjbg2E7dhohKastd6zoWIC3WHVpRpYkexUjNZg9btFEoudcxHjh4B4PIl/vYdVDlCYCtPrELP5ir5fPTNCN0aJ2NVlGs/WA3jKv2a2Z5KExoAXD1JtEogWwLpwifeF9BgAX0R/7M2t9kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZavQ9bjB+VliHb2MsIquZ4n4jtqBaKHivDG64YPjkwg=;
 b=sODmz9JprlMGvOnFnwdAmy2ABbCkbuTzxL4ied8o53mCTff/gl1MypdhZ5tBJ6ZU157fguFUlc3D1r266X4YLYZxGwb9ARh6mmlXAvdBKS+PbmhnyKJz26xpH3+ZCdfEwpqi0H3jbWyjL83ohQU0mhlitPNNK7HfNF/e6BibBDw=
Received: from DS7P220CA0069.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::35) by
 CYYPR12MB8961.namprd12.prod.outlook.com (2603:10b6:930:bf::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.20; Mon, 23 Mar 2026 16:53:34 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:8:224:cafe::d0) by DS7P220CA0069.outlook.office365.com
 (2603:10b6:8:224::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 16:53:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 16:53:34 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 11:53:33 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 09:53:33 -0700
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 23 Mar 2026 11:53:32 -0500
Message-ID: <0317ba0d-6260-6e4f-ad5d-514297da7d73@amd.com>
Date: Mon, 23 Mar 2026 09:53:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] accel/ivpu: Add disable clock relinquish workaround for
 NVL-A0
Content-Language: en-US
To: Karol Wachowski <karol.wachowski@linux.intel.com>,
 <dri-devel@lists.freedesktop.org>
CC: <oded.gabbay@gmail.com>, <jeff.hugo@oss.qualcomm.com>,
 <maciej.falkowski@linux.intel.com>, <andrzej.kacprowski@linux.intel.com>,
 <stable@vger.kernel.org>
References: <20260323095029.64613-1-karol.wachowski@linux.intel.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20260323095029.64613-1-karol.wachowski@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|CYYPR12MB8961:EE_
X-MS-Office365-Filtering-Correlation-Id: 689ff95b-dcd7-43ab-a052-08de88fcb884
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|22082099003|7053199007|18002099003;
X-Microsoft-Antispam-Message-Info: SYqo1lhdyNbwW3uKhHS0oFdO/mFmqM+BP4YC9HWGpJhmf7VIM3Ewc6gKDgzVxuSCTu2jMqEPmOCDgxOE/3LaXcpyooFAUaidubZq1igXDTjY0igxS8p2uNGaCIdeblGbEqE3l17N07PB9hX5GLqbYQnPLRwKpgzgh6ZOKf0RTKwV7t135rG3S1/RMS/J1zTSo8Any4rRcDdKdtzxR2V44ao15k6HUxJ+AioxyG4sZoIFalUtptR/witvcb6OpnQg1ky4pWYsq/cWhCtCFFJeJdb7fJW5U0XChj6pDZfxSs7aGcw4itDKDyfAKpUMoztbyfzqbEqi9cXzQqPl6DbF218Ew28NQR8GmeOUfovW8MEgOFWzIDtjLYOINuxPN6SWwfNTfo+zHpiW5T/lzxrEh/BVSh5dkkJKChxeSeVX8N+q+lM7vWpWvA4aEqgmr1tQIQc6eMCRzCGs0Iip81oZhGHqW6W24VjEZ91v9dBO/P+mVVMSbxmJWHKFTz576qBUcmIfj84DTawl+rLSROD5HYtMIm3Q0L7Wqu9hbR6i0lEKBb+A5Kk9ziDo0GYrDY2jKqUFHUgbHdyHw6/HnvSmSTv6x5JjSX1JWwq3N9mzSBt5+fBiGJPSTW7BfVyOLg1T7XdFFbmOZEBHQNMloK3iNSuwDILjfUU5K+WoWhx2Qs3WzYxiaTclM1VjdzX/bfrVenaohCBqDq/hUvi4OuB0mvDrntra4qrSux82EnuvWKYgNSK0+ntCjkgIWVopn4LPtwWogGrw9kYgC4ZMYEUQVg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(22082099003)(7053199007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OwoQy6dtp+3xfToBx6V9qUs0o8AgUtF8WRIPAIYHSC9OWbdradnngYjN+o8BXTwk1xFj45T68WcaOKwQ/NvSAtFCDviV4OqGJRnqsk6pGg5b6A1ttILg6TYxSN5KWnGZR86f9UriHPePFS3ITmPILYE3Qjc5ueLwnXH+So+AsnA6YvZetI1Lk3X0i4uJ5fIRZUFPgdjcFO5f23llehzqsrpBHAHujemLsnuNaHJbyT6xZrOtwJVb5vGIdlrmsWLR8eBpYAKH4rTTOKLTfI8VaLp+VFU3nyrrrv0zPaGfn1Yo8aEdBmlLiIxI4dV1KV1opi1ZHp7jJ9NhqHt1I9HF2Qvudb1rMELMYm+xNOhkGq0uIfPFpKX+YP6otzLdEMiUPfR5c2wGm+UK+eU55sAQD+Y9ZwH4EUIB8a2havtU+h2+LN3B0Jm5I/d3chFvlevO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 16:53:34.1225 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 689ff95b-dcd7-43ab-a052-08de88fcb884
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8961
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


On 3/23/26 02:50, Karol Wachowski wrote:
> Turn on disable clock relinquish workaround for Nova Lake A0.
> Without this workaround NPU may not power off correctly after
> inference, leading to unexpected system behavior.
>
> Fixes: 550f4dd2cedd ("accel/ivpu: Add support for Nova Lake's NPU")
> Cc: <stable@vger.kernel.org> # v6.19+
>
> Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
> ---
>   drivers/accel/ivpu/ivpu_drv.h | 1 +
>   drivers/accel/ivpu/ivpu_hw.c  | 6 ++++--
>   2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/accel/ivpu/ivpu_drv.h b/drivers/accel/ivpu/ivpu_drv.h
> index 5b34b6f50e69..f1b6155065ff 100644
> --- a/drivers/accel/ivpu/ivpu_drv.h
> +++ b/drivers/accel/ivpu/ivpu_drv.h
> @@ -35,6 +35,7 @@
>   #define IVPU_HW_IP_60XX 60
>   
>   #define IVPU_HW_IP_REV_LNL_B0 4
> +#define IVPU_HW_IP_REV_NVL_A0 0
>   
>   #define IVPU_HW_BTRS_MTL 1
>   #define IVPU_HW_BTRS_LNL 2
> diff --git a/drivers/accel/ivpu/ivpu_hw.c b/drivers/accel/ivpu/ivpu_hw.c
> index d69cd0d93569..d4a9bcda4100 100644
> --- a/drivers/accel/ivpu/ivpu_hw.c
> +++ b/drivers/accel/ivpu/ivpu_hw.c
> @@ -70,8 +70,10 @@ static void wa_init(struct ivpu_device *vdev)
>   	if (ivpu_hw_btrs_gen(vdev) == IVPU_HW_BTRS_MTL)
>   		vdev->wa.interrupt_clear_with_0 = ivpu_hw_btrs_irqs_clear_with_0_mtl(vdev);
>   
> -	if (ivpu_device_id(vdev) == PCI_DEVICE_ID_LNL &&
> -	    ivpu_revision(vdev) < IVPU_HW_IP_REV_LNL_B0)
> +	if ((ivpu_device_id(vdev) == PCI_DEVICE_ID_LNL &&
> +	     ivpu_revision(vdev) < IVPU_HW_IP_REV_LNL_B0) ||
> +	    (ivpu_device_id(vdev) == PCI_DEVICE_ID_NVL &&
> +	     ivpu_revision(vdev) == IVPU_HW_IP_REV_NVL_A0))
Reviewed-by: Lizhi.hou <lizhi.hou@amd.com>
>   		vdev->wa.disable_clock_relinquish = true;
>   
>   	if (ivpu_test_mode & IVPU_TEST_MODE_CLK_RELINQ_ENABLE)
