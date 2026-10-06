Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED6D9CA5FFC
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 15:59:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D5C010E457;
	Tue,  6 Oct 2026 15:59:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i2hY+teM";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012034.outbound.protection.outlook.com [52.101.48.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECA7A10E3F2
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 15:59:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LlRBcaoAVppwsaYwLBap2fRLrAQWmZ86h4pP+QWjIh58NJfelarK0Z12bnKPlH9e1WDDOBfMiC7/tS31U1RmfOPDrowgQrmZFJ9BjtdPTYEXtlDx4vIJInlv6Vd+MwO52ygrcXjZZRzEDOuh6omAwBues8HeV+MtX7re/zL+bVHcNaINjkoHrd86QdjaQD+2nf3coPTTAJjihE5Ps/CzQl6fcxkLMgOLsGy3Ff4/Rt1CKfgwZhRS1t4tD+7zRjzhCqep5o7pzeuMI7twZe/x6m4x7fOpkclCFC7xNedHgRw4wMax1GD9PFrAZSMrTWhnjU+8GB5m8oUx+zwLGGBO3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iF2t7vocNBAcDHFrrf8FtuX8DT4isdzxMp5kECbVN+w=;
 b=gngMLQBKcJHDBDzycVl5UKnc3N8WQbwQWxeiP5cZuLuUCFgbVVY878jClE92NthU3VGANHKaDDXyx5hpByBCSxV7KYp1nD9npefPnjOHuZ64j7ellVws79A1tLVgJAtqvOeBjsRUihieP90Kpcf7bypbqq5IKSe2OLqbX25r1WcnLekj4KR9wJj/tGCtjpddssgm6vNkTmilBBA9v+spmuPSeox3qv3lYuotqJ1g0SJlA9DjLw0iIYoIIPmImqBhDi79jS+m138ChS9RlcSC2QfqIbNf7S9enNCr/9UQl9A9BsVrSv1ai5A3YNfu/mW4v28w9ntr9agf5KVftuJSfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iF2t7vocNBAcDHFrrf8FtuX8DT4isdzxMp5kECbVN+w=;
 b=i2hY+teMs3pDOBaFtwBe/9Qbbntnx2dpNeY1jSe41uzuwkyDIcxMRl2J4DROHTNgtCrediv5GUaBngjSm3bASu6huylXCtsVqB2I4QvzddQpS+jFYVem7Wpy9x6qlKeTd5y4sg/5lUy9grFh28Y2r7Xw51LaCiltTXCDnYDrOYM=
Received: from MW4PR03CA0027.namprd03.prod.outlook.com (2603:10b6:303:8f::32)
 by SJ2PR12MB8954.namprd12.prod.outlook.com (2603:10b6:a03:541::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 6 Oct
 2026 15:59:45 +0000
Received: from BY1PEPF0001AE18.namprd04.prod.outlook.com
 (2603:10b6:303:8f:cafe::4e) by MW4PR03CA0027.outlook.office365.com
 (2603:10b6:303:8f::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue, 6
 Oct 2026 15:59:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE18.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 15:59:45 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 10:59:39 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 6 Oct 2026 10:59:39 -0500
Message-ID: <981c819e-4a90-541c-143c-c1fb1b8e21ca@amd.com>
Date: Tue, 6 Oct 2026 08:59:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] accel/amdxdna: document trusted mailbox ring geometry and
 drop the power-of-two check
Content-Language: en-US
To: Eva Crystal <0xiviel@gmail.com>, Min Ma <mamin506@gmail.com>, Oded Gabbay
 <ogabbay@kernel.org>
CC: Max Zhen <max.zhen@amd.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <sashiko-reviews@lists.linux.dev>,
 <sashiko-bot@kernel.org>
References: <67698952-6394-44a8-01fe-3e3558b7cb4c@amd.com>
 <20261002205814.178031-1-0xiviel@gmail.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20261002205814.178031-1-0xiviel@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE18:EE_|SJ2PR12MB8954:EE_
X-MS-Office365-Filtering-Correlation-Id: 9706bc54-1951-4b0a-b9d6-08df23c2d743
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|5023799004|56012099006|11063799006|10067099003|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: mFryTOvsIdp2SXKKox7ETBfWP+UCVGLbsumNlyWsIbi5dYZpK6+tiNH4u61MdWbPC+by7ow5Mz4/vwz5ifDJE+g0WVtJRQlmB4hEx/aJm8TJ1T14SDQNiVPkbvJHPjKaJlRGevEIoi/MFjuWteEhkxxNnCJRoQy8Lq8lTH+FmklykwTSS54n3p15xJZgCGZ555xlNtBXW+NwkAyFuEw0buSJzRyDnT/jAepLp9v0KuQyiekWtgk+q1czs6AMaww/xOUc8tBGM+w/mACRf+ITB+hrR2enS1ZWnT5G0Jv+IPCxYxMvNMhx1Gw0bn5Ts571RS2xE+fM0/rR3Ul+xq4f5+q8DxIB5QAPqbydz+U2R/3Z5XculhCfc3zox82E2Escnl8bZEh/TtmlEEbUwvGAk2G55D/k3HQxzo/QB284lFLSbr0vFSh0iLkkGrJWx4iUigKaYXgju7SZGioGf6k6jrL6pp9d58j+UoBWQxDwDgo7Vz8/M8kAJfzToySJ2RmwfN12Ginhz8bJTfEerb1JxS3sflXFaXZgkNy6btg7UmWfUeDDdpgseMpCrao7yJ6K4yOV3QyFShueQ5hXR2/Vf41Rnx6HYxuNO9DTEqL0x0q2IGDPEB7R15JNVpcEDHpS8mjYO2Dvs7b/DKWC8leYCUmHWaCt/FhnKVDK8q9o5wQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(5023799004)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 91KLxY+fbChvddiyZ64DeD/sU51IFRNI85UBSA9EvTSePsg8Wl4aocPlvMrTnY8G4x0WjEDdFTX2bOw8N7hgNenEr+5NvuoM/E0aB0VeV6RKvw0P0C8JL+Z4sCMaQ37vc8vpawmHFFROHJocH+VEXC+frK2zXr1lBAdWitNy9j6g9Bdf2K+V+VGvbjC8nENdCLYd8v+xPiraSsSTGvNa/fYGVYOF83SqEqBqGPxbDt5x+D1JYcVYHYJu7UspmniXjRcetFB3AKZZ2AqZIyjNbjfZBi3Yxxfb9bZBnArGIZOpZp17Z8hglseRcLtwgG+T8aIWLnA6AIrSdhoFfJnjM5Zt0WuODH2X/L6b0htq1BdvnVh1/9HKDH23VP11nPYqOwfWAPri8JqZ71NSlc5P+YHkKNuvOBm8W787enn+2Fz9z8c0uqkxeNvsic5B+RoP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 15:59:45.0809 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9706bc54-1951-4b0a-b9d6-08df23c2d743
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE18.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8954
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

Applied to drm-misc-next

On 10/2/26 13:58, Eva Crystal wrote:
> The mailbox ring buffer geometry comes from AMD signed firmware, through
> the management or mailbox information block, or through the CREATE_CONTEXT
> response, and the driver trusts it by design.
>
> The power-of-two test on rb_size was a firmware debugging aid. Nothing in
> the driver derives a mask, a shift or a modulo from rb_size, so no code
> depends on the property it tested. The ring index wrap is handled by the
> explicit comparisons in mailbox_send_msg() and mailbox_get_msg().
>
> Replace the test with a comment that records the design, so that
> automated review does not flag the absence of a bound here again.
>
> Suggested-by: Lizhi Hou <lizhi.hou@amd.com>
> Link: https://lore.kernel.org/all/67698952-6394-44a8-01fe-3e3558b7cb4c@amd.com/
> Signed-off-by: Eva Crystal <0xiviel@gmail.com>
> ---
> The pkg_size check in xdna_mailbox_send_msg() is left in place on
> purpose: it bounds a driver-supplied size, and with Max Zhen's pool
> patch (20261002161122.1350075-1-max.zhen@amd.com) it is the only bound
> on the write into a pre-allocated message slot.
>
>   drivers/accel/amdxdna/amdxdna_mailbox.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/accel/amdxdna/amdxdna_mailbox.c b/drivers/accel/amdxdna/amdxdna_mailbox.c
> index 05c3786de135..c4a36858668f 100644
> --- a/drivers/accel/amdxdna/amdxdna_mailbox.c
> +++ b/drivers/accel/amdxdna/amdxdna_mailbox.c
> @@ -513,11 +513,13 @@ xdna_mailbox_start_channel(struct mailbox_channel *mb_chann,
>   {
>   	int ret;
>   
> -	if (!is_power_of_2(x2i->rb_size) || !is_power_of_2(i2x->rb_size)) {
> -		pr_err("Ring buf size must be power of 2\n");
> -		return -EINVAL;
> -	}
> -
> +	/*
> +	 * The ring buffer geometry, rb_start_addr and rb_size for both the
> +	 * x2i and the i2x channel, comes from AMD signed firmware, through
> +	 * the management or mailbox information block, or through the
> +	 * CREATE_CONTEXT response. The driver trusts those values by design
> +	 * and does not bound them against the mapped region.
> +	 */
>   	mb_chann->msix_irq = mb_irq;
>   	mb_chann->iohub_int_addr = iohub_int_addr;
>   	memcpy(&mb_chann->res[CHAN_RES_X2I], x2i, sizeof(*x2i));
