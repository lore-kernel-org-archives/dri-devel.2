Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB41CA5FD4
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 16:23:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E98B10F730;
	Thu,  1 Oct 2026 16:23:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bAQs3WKP";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013069.outbound.protection.outlook.com
 [40.93.201.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F0CC10E32D
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 16:23:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GXLxdGUEkR9EUz0p+p2qkt3iMYBc7U0VzuZr39KBqgjn6mCwcIo11jpx6aCbaNuf5D/zMBb6hRZ1IqaxXzJ1qoI0pbC6SCbxGYjRDsr7Hcbr0K+FxaGssiRRV0lVqR0PmslBYxZxz5cwZa8W/rV8KIiZNTfCk8IDVoUqBlk2A4+xv7tp2X4mW6/Si5+o+TxP/JOuW6GgTwOJMW9/Di0TXxVFZ8FhrVXlHK943p2APilVH9eOGIhQoYI6Cp3EGji9Tmn9YQzeIsDZRXP4iWvnjPS4Fxey+zLlp68jaQqywNO98rExend9Atr08x7xzXZSWZqJ6VUdkXlGDoVEZAAqQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9AZ5noQRP56gQtmnYnBS2kCAFb7kZUvnCjCQhvLP5Ys=;
 b=uWAGC2WSbcN78lpHIAXDttKWUMlladoDIKD3CXLG+F4twDfTsfGWGQIaWAcKJo7uPffnPzzrX0T0hq4ixoJU0ENI5llkvzP0CtmXiBNUzpc/vAXiaWklImXbztoj3J0xbkMzpPUOKo9XRjYMs6pwrXwX0agtfW/+FgGIFQ4POL/SgkjoQVvPKIm4FDXBINcPFkSQbamv7y7Td3VB8SA75RGu6TSa24dVxtWsHlmP8w/sNSsUKJx+DMcobme5YZulP0/hHV+ZqFKL6ADYkXwouNyF584WSZMIHZHqov77zbXNzaalvPv4dSKKCXbNzf0Q+8BIvWqhaqaCtmMvDMbf8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AZ5noQRP56gQtmnYnBS2kCAFb7kZUvnCjCQhvLP5Ys=;
 b=bAQs3WKP+qcb8raTM7IGrgTdDJi4b+etXvZiR1Vg5d7gCwHpmBpki8PHLTpFlD1ZZuxeauM3psNFzuGu9xd/kcW9OfMRE5HKOhNqbiJiFH+qvRp2kMc/t+ujtEQkUnWlEKj0O7WqbTozGx7m6Gp4i4j7VEnDYCEimbcuzPX8TWk=
Received: from CH0PR04CA0019.namprd04.prod.outlook.com (2603:10b6:610:76::24)
 by BL3PR12MB6452.namprd12.prod.outlook.com (2603:10b6:208:3bb::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Thu, 1 Oct
 2026 16:23:44 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::30) by CH0PR04CA0019.outlook.office365.com
 (2603:10b6:610:76::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Thu, 1
 Oct 2026 16:23:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 16:23:43 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 11:23:43 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 11:23:43 -0500
Received: from [172.19.70.89] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 1 Oct 2026 11:23:42 -0500
Message-ID: <0274009c-3d7e-414d-8298-2e4184fa087d@amd.com>
Date: Thu, 1 Oct 2026 09:23:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: eliminate GFP_KERNEL allocation from
 mailbox send path
To: Eva Crystal <0xiviel@gmail.com>
CC: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>, <lizhi.hou@amd.com>,
 <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>, Min Ma
 <mamin506@gmail.com>
References: <20260930164704.1049735-1-max.zhen@amd.com>
 <CA+pz=kLERMEUwN5OQf7=aDDqkH93CHXHUuD+aA0tuYN2xCk3tQ@mail.gmail.com>
Content-Language: en-US
From: Max Zhen <max.zhen@amd.com>
In-Reply-To: <CA+pz=kLERMEUwN5OQf7=aDDqkH93CHXHUuD+aA0tuYN2xCk3tQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|BL3PR12MB6452:EE_
X-MS-Office365-Filtering-Correlation-Id: 10f39524-7457-4938-6cce-08df1fd85cc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|22082099003|10067099003|13003099007|18002099003|56012099006|4143699003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: ng7iJxoWfUHssgTp+JCj3i/vwlAACxBZxNZHnfmBDyTnASdGIgu+yGXWlNgN1Aeo4fwZf/E/KaO7umOk/Za9l5lQlxrtAe49aEQamIWtxkWGP92tcuWodzsZ3OQ/NVbeR4xOzBHZUyAO5Sa3DzvgnO363Uu6dM4vx1Y3AxrMltxD4QhAEteJgfsbAB/x+XxRySGLm9J7969046KKKQtEhT6GlBQLESnOI54CVcnCDkZuyNBM15KJpCALAY2xyPgs+C4NkeUm1x1SBozkW+k3C4+ZSLYgsV9+aCFe01fqaO9I99mGwUbiUN3NWaPgRoeN8cnkO0Qa9cM55S4o5OrjrC+UyUcjJv4X7yy3u/0xSBKPUpQMFudBpcEvw1ZEKw5n7sTBIzMmPX2LNS9OWQTPTG1C/Js55s7mahsUS1JKEazcjQDQ3H/b808PLEB9NuA4mr6CdwpEOJlxOspMx0iDuCdKsb5Fb501Q3uWNpytNDDqHE49agtyJKUouU+QEB6cQH+/Q6QR00Bn9ihr+T3vffwQSgqiIIbHQFrF6WVVKmidLWfhgxc8vf7JKVqmYv79hWjCL1oVv7CneunS53993e5eO+K0AOAS2OX+K67tRXERPI/GjH7+RNfjR+Jmq7ZA58zHZV4H94nxk6McupJUaw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(22082099003)(10067099003)(13003099007)(18002099003)(56012099006)(4143699003)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fBqi3mxnEJntUIdDKwNsnyzclgBGP9pyOkrc+2OZKxrXIulI0VyJ4UuVNMZa9b6+NCcTNwVCdXZ8BXFdTDtlwx8ejbuTjEZ2T/WZwRV2xYMP3TX81C90nDe2dKluhSKvy7A/RSsQ12EAHh0ZLzYf4hWx3on1o4fklP7R6fXrmeuikAsO2AM/tG8awhMLSyFZautMBjZjwGXpc6I9nsFLYJu70dsMS95OxWxX1uuwGEf5KYUWVFr5uq17ePHSKlTsjFD7GvoTds1z3CUPm34B/+ls+rxjdb8cSo5X4uhzWT7+BZIKhdqqlPFdfUohUy74QO57KwaOxtUY6p+JBZpspbq5r7crveeC1K2O1Bmrap8O0nbIW4eHyuAOyVIKzdAiRoxAkX8fQm+qM+NTnp63bPvArzDyRrH1Ch6s0xfoNJfFpOQKOxfjvGfuqGNhh1tf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 16:23:43.9183 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f39524-7457-4938-6cce-08df1fd85cc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6452
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



On 9/30/2026 Wed 14:37, Eva Crystal wrote:
> Hi Max,
> 
>> +#define MSG_BUF_SZ(chann)                                    \
>> +     (mailbox_get_ringbuf_size(chann, CHAN_RES_X2I) +        \
>> +      sizeof(struct mailbox_msg))
> 
>> +     mb_chann->msg_buf = kcalloc(n_msg, MSG_BUF_SZ(mb_chann), GFP_KERNEL);
> 
> rb_size comes from the firmware-provided channel info, and with this
> change it now sizes a host allocation as well as the ring itself.
> Nothing bounds it before the kcalloc(), so a bad or compromised
> firmware value turns directly into an arbitrarily large kernel
> allocation. Could rb_size be checked against the ring window it
> describes before the pool is allocated?

The firmware is authenticated and signed by AMD. By design, driver 
should trust this data returned from firmware. There is no need to 
perform this check.
> 
>> +     if (!mb_chann->msg_buf)
>> +             return -ENOMEM;
> 
> This adds another failure path out of xdna_mailbox_start_channel()
> before request_irq(). On failure the caller still holds the freed
> channel pointer, which "accel/amdxdna: clear the mailbox channel
> pointer when starting it fails" (Reviewed-by: Lizhi Hou) fixes, so the
> two patches should be fine in either order.

The patch (accel/amdxdna: clear the mailbox channel
 > pointer when starting it fails) has already been applied to 
drm-misc-next (see 
https://lore.kernel.org/dri-devel/81bcf2ab-cfcd-3e2a-ca91-671e72d93bb8@amd.com/). 
My patch is based on the applied patch, so there should be no order issue.

Thanks,
Max

> 
> Thanks,
> 
> Eva Crystal (0xiviel)
> XSource Security
> https://xsourcesec.com

