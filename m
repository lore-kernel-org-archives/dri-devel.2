Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D4DF483C8
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:40:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0720910E00B;
	Mon, 23 Mar 2026 16:40:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p8DYm9M/";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011007.outbound.protection.outlook.com [52.101.52.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22B4710E00B
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 16:40:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZUOA/z2E5wsddt8f6+oUUCc3jE+oyAxxAidQI6ioZR/bg3jkk+jMoWeI5ISAWMMQlS+djPndmaiwtiSzt0ZpSWpbXYhuHjDiI7hE1N8Ua/tgvuYQA3TnlU2W9gv4mAcct5B+NGL15+ebgtIPOm/RdPH+rCBA5FlZdZmKfo8bVJ/5/KBqJadl85CSYCa6t05g4hPlIP6oMGlY2tlX1xYpAWKxlGDJMF8AKjfWLcZoBPKYwfuhE5wNZsYgE7HQHfbk0PTifaYhk9bm/9kPCQ+tPTW3BzNEwSja1MbVfVlg9vzquLOWfDUyE8Oac4LxWXgY5gu5Q5hN7l4POtDl3oDC+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBaJ536AiO1BWINaO0Cgz/82IyyYaf0TAJN3FiUZwh8=;
 b=Ep38aszeNYw6GKbkphBUOkRR5apcqa40UY9a/NBMFqSJ2TQrzscc446apyWUHjNaiQ7nl/H3T4T7e3zf/srsw2UbYVAx0mJafTUvegNiPFLW6AteB/8Jfsdq8iCmOPzVUg5x+2HdMjFQZTooJsm5/LbPZvWmneCzugJVTZz529ANqqNuUetWbhD3wcqI+0ItAu82kJnVH/Uk03ICShm/mTIr+4ee6VS5JvZRMIDsv8IAsu02Pqnr949QEab3rJdcBb1lkDQkucLEhmH7grK8+mW0tLJ6Yo0BraEKNOVtyZ93EvaKo+8KZxSAwV0+t96z6oc5jiEVPtesBsomoZRnKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBaJ536AiO1BWINaO0Cgz/82IyyYaf0TAJN3FiUZwh8=;
 b=p8DYm9M/Lil2ouidtaP6DFwdxkqtKAZYqwr5+QhCj1pFZ/rZeKpNSvylfOYfqwFBwiR8m2RxMWT7OimtipQvhLnrJkhuCHD0+MtKpvPDc9Kr+/I5G91NTHwHYRGYot5mfnpL/Fj+8pnfO6O0m57hgnClZmLxRo0GjcfwGCJazKA=
Received: from DM6PR05CA0060.namprd05.prod.outlook.com (2603:10b6:5:335::29)
 by IA1PR12MB7493.namprd12.prod.outlook.com (2603:10b6:208:41b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 16:40:04 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:5:335:cafe::f0) by DM6PR05CA0060.outlook.office365.com
 (2603:10b6:5:335::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 16:39:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.0 via Frontend Transport; Mon, 23 Mar 2026 16:40:03 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 11:40:01 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 23 Mar 2026 11:40:00 -0500
Message-ID: <da4a19d4-9525-9fc8-1e9e-8840777317ea@amd.com>
Date: Mon, 23 Mar 2026 09:40:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] accel/amdxdna: fix missing newline in pr_err message
Content-Language: en-US
To: Haoyu Lu <hechushiguitu666@gmail.com>
CC: <mamin506@gmail.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <1af543d3-46ff-7a9c-6432-fe3c9050e23d@amd.com>
 <20260323034933.216-1-hechushiguitu666@gmail.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20260323034933.216-1-hechushiguitu666@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|IA1PR12MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f9018f9-75e8-42a9-6c66-08de88fad590
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|22082099003|56012099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info: FyBfe63/QrLjJ+2FVFQD3tvjg040rTlPVccMNbw/EkA1RPdJb2Yb8NMWqIiLo2GbX877fYd6IES7adyebT4s4aqb+1kCE/DzMUxYz1SyHWM97Mbb6eolul/GYmHo1tfoQ7mpLLigSMEcjyZtdsLptMBRpe6rAu5S88ZcvMW0PVhUFNJ9elvDD26wlqEX7GTKj2QPm6kG3DJLIu4EiaB52mKJbADfxj60ikByZVfV3E/DZhclqRY7GFjomGFyfT0YBskowkTSowPgHtR3Ek6wRTkD7fcGbrClXrCyk0J6kyAtPQd/mHnjU3+zIXTdbiciASRL5cCmckz6h5Z0Iya3b+0HRVbT83noWOkhpfcyRAoYMwYRfi0U/M9EdGtJdG3q7FfHLh3fxcJwdnwWiwZ3mLq3RBiYVRh1U3AjtlE9pYTb7+i2rEYwCr8crOK5KemAZHZoqW1Un0fvzotgefnyKYUXm2XZ4xhMtGGR48r2YQetJCOvTnK2FLwHRbhVy0E7CksiW3k/fzPPY35l7zXIkQfLzcPo2s2o+I5FvPK0Zlek8Kz1burGafjIo4vdGSfPDAuSATQ3bboxOjF+TNjxMb0gRwdoqUghgyqZGQ7aTthu44Qejp00wnbpBV7opWZjqdzkYvqQdShewPKU425bwemQg2WpcqWXq+5tM+9FHbxDNZt5L/RKAvD7HyTTE+StsQ3ArygsCp1ulw3RTKCxSLb/Er3gAWxGVT0dEiDdjC/wA39H/5Hv8ce4MowBsm1r88c0jT6kToBmlhSc3k5Tdg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(22082099003)(56012099003)(18002099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Bfj3+VebFYSKT8xoeqj+AxsHtlCL3U/aOsq3LSWiUpMzhrPUC2YwFxSjgw46wMwSTesVNqGSLNI1Do/NoGdqaAGTnsNCI2osgB3I6tB8bT8IIc9RvgBfuBUQd5n0OuQV6d6a/7aB4GanaScPu7AwJmRkRox0JJoVCtdkjsqXHlKtqL2bRvsDf24/PAlAvtsOfCrzAFtLHjRVO+LSq9aMfBIdMNXM6YySuUEo2yo9XgXmKZW2/iKQd6GDeFY4Aji+iXvM0CnV9DttPYJ7tkDqLa6X5QAuwemwr7Ke4wgnZ+TzkjjZ71/yPzZEtLnRprgUDe1vTv19H8nQTLzo2Zo40+h7A1ueLOA4SUgPfVDx2YM2Enl6wZ+OCYVDGnVxXwP4BbxMISCTvralQezZAFp8Tz051myQ7cJCPYlePrfugb4bt30f/rZz1Z/TUrI3W0hb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 16:40:03.8840 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f9018f9-75e8-42a9-6c66-08de88fad590
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7493
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

Thanks, applied to drm-misc-next.

On 3/22/26 20:49, Haoyu Lu wrote:
> From: "haoyu.lu" <hechushiguitu666@gmail.com>
>
> Add missing newline to pr_err message in amdxdna_mailbox.c.
>
> Fixes: b87f920b9344 ("accel/amdxdna: Support hardware mailbox")
> Signed-off-by: haoyu.lu <hechushiguitu666@gmail.com>
> ---
> Changes in v2:
> - Added Fixes tag as requested
>
>   drivers/accel/amdxdna/amdxdna_mailbox.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/accel/amdxdna/amdxdna_mailbox.c b/drivers/accel/amdxdna/amdxdna_mailbox.c
> index 46d844a73a94..e681a090752d 100644
> --- a/drivers/accel/amdxdna/amdxdna_mailbox.c
> +++ b/drivers/accel/amdxdna/amdxdna_mailbox.c
> @@ -499,7 +499,7 @@ xdna_mailbox_start_channel(struct mailbox_channel *mb_chann,
>          int ret;
>
>          if (!is_power_of_2(x2i->rb_size) || !is_power_of_2(i2x->rb_size)) {
> -               pr_err("Ring buf size must be power of 2");
> +               pr_err("Ring buf size must be power of 2\n");
>                  return -EINVAL;
>          }
>
> --
> 2.53.0.windows.1
>
