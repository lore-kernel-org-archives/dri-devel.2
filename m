Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D851098797
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 15:55:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F17C10EB20;
	Fri, 20 Mar 2026 15:55:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HDZBDgo+";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011065.outbound.protection.outlook.com [52.101.57.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A40110EB20
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 15:55:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=loglwfiU9W1HFT7bhLovEBh0e9YSpMkF+LhvLjq0qcSkDxyWJ5C2Ba7hYEB1kHgVAWqIPtL0bHthA1dk97vHAOlUrxeiQ+dx5b9WU14H++3Pae2PvRgbDfLdh3xMIYLryVOvDHunhgRbvMr5ZckhaQGSDuBeQ7Sr1qzlg6lnPdG0W95y1YkMiLxB/2yfA55G8tTjZkuu4aowSqA03P0eVTXxRjsO4wQu1sbJBxi4jmdcw5BNj0csE5jgD60eIwOv1OM4JBJPAyQeyHNW4gEfTVOA2bgUjnK/+RhJ+U5FSqPjxcm8P5iLbtpH5ETwtTK48A+ZkszWnh6F2xyMVUArxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C5HrYvdkq6jU138uozqWPSY+aFr9dGY72jFGLR/xsQk=;
 b=Jp/TeiVd5IPZiDGC274PQhlDJgZTr2cUNrq4T8QBcWQ3viqInUFJABWb4kpOH4Oe56Lsh8oks1vttTTaN3KXYfWSrMIk4AWhqRKPuLx8WGGmidPNyxluXCEQc0XnJLnkPtKjaQpHG/O2WxEWXxu+37unV9hvU7HvR1qo+RjY2yNU+wLMs4hpvX7VZ3MgLJ/NI3VCHBqOvMjILBBlrfHUTRQDlquACzmXST+oVNMoZqMyz3ssLHZ2s2bz49VAwSTn6I9BTj3ZPHeZryAWebNqwyFnecrOms1HlRxFQY8dKr5V2+gQf/rvb0fIG+ROJjHcUjBXibCRdElwnme+ONHdlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5HrYvdkq6jU138uozqWPSY+aFr9dGY72jFGLR/xsQk=;
 b=HDZBDgo+tL1Ie6zgc/Ot++uDwgPDiWWJn05wY3otM/Ghu6ISz8oNBsv0WrIpdmtHnKXWiLO1Xe50z9EunLsBbQykOtFADgp4mymhBA6nWDjOTY4OyAxIz3dhzD7Q76w6LF6bEHZBRJT0i8MTGB676jYuh6vV6Md/h2gmLz6spZc=
Received: from MN2PR07CA0026.namprd07.prod.outlook.com (2603:10b6:208:1a0::36)
 by IA1PR12MB8466.namprd12.prod.outlook.com (2603:10b6:208:44b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 15:54:58 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:1a0:cafe::58) by MN2PR07CA0026.outlook.office365.com
 (2603:10b6:208:1a0::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.20 via Frontend Transport; Fri,
 20 Mar 2026 15:54:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 15:54:57 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Mar
 2026 10:54:57 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 20 Mar 2026 10:54:54 -0500
Message-ID: <1af543d3-46ff-7a9c-6432-fe3c9050e23d@amd.com>
Date: Fri, 20 Mar 2026 08:54:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] accel/amdxdna: fix missing newline in pr_err message
Content-Language: en-US
To: Haoyu Lu <hechushiguitu666@gmail.com>, Min Ma <mamin506@gmail.com>, Oded
 Gabbay <ogabbay@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20260320112938.305-1-hechushiguitu666@gmail.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20260320112938.305-1-hechushiguitu666@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|IA1PR12MB8466:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c384f75-8107-481d-4cdf-08de86990942
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|13003099007|7053199007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: Yq1RK1lCkBL/e+ChDEf3wtO7tD0nTZTQRL7i2IUFm2ZAbYsZOZlVrNgC5Hl9ERv9UMWUYTUPGocJZmGwIymbE7iQAqJZkIWQKzvi4UlhWVrIu8mN4tufAznSQsQcGc4gVwku9b4czH6G5pkCfcJTffcIc0hpfGKt9Hj3O+C5s1nBFFNGxyhnueS/2GWnn3/D+0/9EiErAjKYQUr4xsytBcMDmzpgXLH/gd/UKtTE69cNkhruLwKyyhZ4jwaflFK7TENccyGQ5sNwUo9XeFqNhMWmX1FFTwAFWJQWADz2JQ3WdNd3ojfc4U5bpDqyF/nVEF1HGSMXQMYF0u41rM3a8R3EKaVAPTYyc4ZLbzraWv8kwvkSMLwoAeHtv0bA9X9p7mgVAVuDmqI/+/gJ7d70/5yKb1VpgTBo9f5/9VWF7J9M4riYKiw+vRoiHWwb8BMfSblAx+oTfrv+wwynVj3gc6iV5B7YxFVcQfGHPkclSLi26Fr/MsodiX9RoFMwsrIkLTaR/ETwY0DHImkf7b9LaxgCN5qLqY8gRePmlEfovYA3893mRRtV1FBhy0KQrSWCQlEoZdGrqNqU9Iop9nctJb5mJrI5RTR0p+qNTanbZ4o4zuD5bZsTG5Ik8KHakE0mdm4bErt5ZGmlSbv1W1/ozn0Wr2XlZSenOHE6vGiERSUsnnv96m86x0U51Uj9Y2dx8F2wMBlvOksXu8ug+QOWuUL3v/V3p4/F1DQ76UGoWKGVTngSFbuM5jVGRqsIN6hc6qnc+9hcdgTe8D4NK8Oqag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(13003099007)(7053199007)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6Q2RXIE+307/aproDoZoPVpf4E76fEqyeymdc14pYa2XF25oTeBD8zfEnm6iJfTKTVWoQG5FYVrnM3wN3Dcmj0FbMO3S7Yk0prLH8lJXyfztYYAttyRQDVNbm6QNDSLYAwhSfcmEzWvnBIcEhjQNKmNKD601RsMmHdfI0ZyG8bUcV1KdN1siQ92TZ8u1Q4H8ow+UAuFq2I1S5KCNmtM/eWHIex+oEAu8Jn+sbE5CwYE1AoszZuKGMAZjvSaotG+ngQy6oojjIVCFb4ipXTKsmn5caZp/Kalj7tmgFvnhTSPr7GPsr7eqZBi/+/ahk2jtazBWWKQJUBtTjybi8AycK2u+0LMBJYUq4BCXrdcGIs9BcQX7GiVjFLohkCfYhW5SkgIvmMlqsHzh6xd5S+wpwSocA2NwWaLx8g+GQTOFh4mW1gxOGSFO92Kxnz4Xcgw2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 15:54:57.6206 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c384f75-8107-481d-4cdf-08de86990942
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8466
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


On 3/20/26 04:29, Haoyu Lu wrote:
> [You don't often get email from hechushiguitu666@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> From: "haoyu.lu" <hechushiguitu666@gmail.com>
>
> Add missing newline to pr_err message in amdxdna_mailbox.c.
>
> Signed-off-by: haoyu.lu <hechushiguitu666@gmail.com>

Please add 'Fixes' tag.

Lizhi

> ---
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
