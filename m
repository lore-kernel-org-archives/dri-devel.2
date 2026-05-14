Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F31CD4851
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 10:32:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D8CC10E398;
	Thu, 14 May 2026 10:32:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="YnMcoatW";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011061.outbound.protection.outlook.com [40.107.208.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 981B810E37F
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 10:32:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RKD9AFg+MJZIv2UFZX3IjxiNqiO4e7QXxUbODyzreMD5AtfIyzRzdlVkJH8R5IxRajKk7kamvxN5ebsJFWHAGBrxfswT+IXM5e0D71pawYdl69+zq7QoNdUpDwQ+uqZMrGxYcePCjzk0e8nNhKtqzpoUiX202MLbWtHiaEY8o0aIQO1QYyZU3J2YfKzzZC6VRKL3Ynfp0EIN7OwD3o4XXu6yevEY12Z9jVXHARg1XrPZZQAFfCme2L4/hXABJ0LyfSvDmPb8Gfo/CRcT+hXwVhi7F/WnebmNIalBKRWqEmatk5BqWwGB8ps5NiaFSVWUFa214e2aYH5OVuzUwlT/Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQSxHuwOTQN25StwPrHq33r9KV9LVPqZh64jwh2Axzc=;
 b=lpW3knWZVE02NjNsLR33Qj6Z87CIBthB7VpwY+bFHFRzdUD/83RP0MtI7pKdU1pvLIV8gfd3frvNRkkeNVSNil/GdSPE1JbDilJgO9HvPNtQiA/IAI4KFwnpqHH7bELBewGm/0OftUSOpijHzTaQ1qAilPz69jooSuJ5CLJUacWVT9+tNXtKl9Tw6X31RChMeAwNaj/oDPLEZKuipN10FKtLtD/nbLx2tDx3src42wgzGbVUNpD++aAh9bulTKaWNQDlTaNV3+lFqHVL/M0VlmPV0Z0DrLtmPDMIoil6S3SsgBmGWAEIQ7zRk06hQBTBd7tszCEekum14/A3AYWyVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQSxHuwOTQN25StwPrHq33r9KV9LVPqZh64jwh2Axzc=;
 b=YnMcoatWCKBm7c7j9A4uck1vYUAiMW7dEqPAoWJsDBFYkDhGU5BzKoUvBBw/tX0VBM2rYmLzwpz7XpaVS9sVKK9O2h//KzMaPH1t7YORpL1oIu0P64zontJuk6Rpv/6XG/DlzA/yADhXGoZccenmbFIGaLHY9bioJh3R3C1Lc7kzOFcqEj1k1r1yvmo04PWOCUd4z453o9TqZS16NVc7z2tcNDeg4WKH0H/hvHYrgN0dS2pzRUXE/ppqcViHNgtVFJzqAJPy6NxkMUVBGxmuO6Cxmv505Irag9s3e++XqoAjBeyV1WBNmJ4bsM9UtWGkhRnkSSVQs7ItevNzvBumEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7000.namprd12.prod.outlook.com (2603:10b6:303:208::15)
 by SN7PR12MB7179.namprd12.prod.outlook.com (2603:10b6:806:2a7::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 10:32:32 +0000
Received: from MW4PR12MB7000.namprd12.prod.outlook.com
 ([fe80::43ba:fd2f:56b9:7387]) by MW4PR12MB7000.namprd12.prod.outlook.com
 ([fe80::43ba:fd2f:56b9:7387%6]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 10:32:32 +0000
From: Tanmay Patil <tanmayp@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tanmay Patil <tanmayp@nvidia.com>
Subject: [PATCH 1/2] gpu: host1x: skip redundant syncpoint loads in
 host1x_syncpt_wait()
Date: Thu, 14 May 2026 10:31:52 +0000
Message-ID: <20260514103153.766343-2-tanmayp@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260514103153.766343-1-tanmayp@nvidia.com>
References: <20260514103153.766343-1-tanmayp@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0207.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::32) To MW4PR12MB7000.namprd12.prod.outlook.com
 (2603:10b6:303:208::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7000:EE_|SN7PR12MB7179:EE_
X-MS-Office365-Filtering-Correlation-Id: 76bfc34d-0286-42ee-7b2c-08deb1a41b7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: zwx1KOp4oU+mVZkRfYXIJKZD9Zl9qso6NDOZvIu6A+RTY6kanh0Firc98utbJ45mKtunxwC12K5aXuHejFtrY63gfnA4me3VX5sgwZy0P67hNeO1HBXb5mUkfTSa5QuZcS+X1kMAMfhHeCEVycYMcYbASsMChnjvSw4DIO4cVlK1lHIZ31JhQ1LrMsiyc4S78+CGNFUul6VhRNSMwbXUL9AUxV/eoTFq2By6zITpP2Fdv96DR1QfDYktUW0yvv+sEAGmnPMHkiCDUjTNuT5ilRKgZnWl4Fw6lfGzPVuWc/ljU3QEljEABdqS+XVvwp9k9u2u28g6fhPSTxmBM0ee+Qf5HBMKSG1TJJ87hNsyuWMvZMs/ODQ1crQn9iQ7kU78sL5Eb3xMEAwsEp3z/gwSiCBktQFhVzgYzeHPR/vTssqn97NGj78G3m+JKiJd4qOB/pJl2khYdhffG3CHjIelCmMv+48pqpSGZ8g1HSuKv1L/rrZH6BKhrXr+nyoF+Scaxcacfrk8Cb/gt0I7xrngweg4DE/nLq5vJAXA8v8HA7G8s/j1R5GlRTEQDIOVjTHaGdolQkP2Meqp29abyhAwpqEHY/s6BHtuBMe+YgwNyFBrjfZSY+ApKkWhjYHzW8tE5OmyglgNJMCN+vRNYMeT6NFhzB7NI06/LzTq6GoC1bZ4nw5Wi0T1/x0SsV/uIKKt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB7000.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(11063799003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?13nsekcKcCQo953mJE41R5uh1E4oXIMpQy6jekfptxjbUxHMeAQJ5O8Mhfca?=
 =?us-ascii?Q?Cc25eYVJUOJKWWZbidqfcb/JPd06VTTXDWl8qtgyp6XWbidxmSkDFk17IxsO?=
 =?us-ascii?Q?+JlxQWgkeU1X28W/ErKMoKg+jcEG47f9SuMFXkRADt0+HPefG4ieHM9QzaBh?=
 =?us-ascii?Q?IByaP9VYIj0f9CcNDm20Yn7YDMBDyd7SsZKnKmlQOUkTgUWB0CcaDO1h9PtZ?=
 =?us-ascii?Q?xTSOAk4qAwq8epthsBOsjg8Ar31llSD+Pfpudw4dgUgFxnM/1tdFgzP7pojf?=
 =?us-ascii?Q?j3jCet7SvjjftXwo+f+Ws4jS0Q7wcCoGh4KN1w6MKHwMInQiLeN+zuAgX2px?=
 =?us-ascii?Q?XKcgUeI5ONAgkBzO5QRQXZxFf7nZvQKXM/2SN2CRgAHArscCMWvbGmrLfkbu?=
 =?us-ascii?Q?Z1nihIc1fQXMw7lRTdzcgGlqo0Igtj8Wn2q5zPGtFnb3U+OR51nRLF6BbxdJ?=
 =?us-ascii?Q?f41PTqzOnl8Yy8ToUdugOCl6VdhfLBPJxdop1jyC4yqCLHvQDD1cTrJhgM/F?=
 =?us-ascii?Q?P5WOGNX3gSmUrWddSPK+cHY983k/I7By2FuZxeIBXK+ssrplZcdvrWwMPism?=
 =?us-ascii?Q?FUEDOB9sCcz4Db5sklkYDEYiTTK0wlzSWD67dhIHvvswBIyTkBMcYa2jC33T?=
 =?us-ascii?Q?VhdrOvHDxOUYgrGA4LwcjcTEU9RW/nRDO4jNFhHrv999fzISJROoUEG+dPb5?=
 =?us-ascii?Q?E8TD1k61rRBZrw7T3UzgeyvZ+jlW1AWrT1PSwVYH9/Zrekhw+CF+5a14fuQM?=
 =?us-ascii?Q?m6VeqKsZ2M1CPw0ulwCVCCxX1FWlTSA7Y6LgANDUu4NtJKx4xK7plFUOC4Q/?=
 =?us-ascii?Q?i0qjCEtm7SWrHGrbZvbvSKC3tpFiBmCupDIykg3RaT1AqyiPzrzY4LMLIxm2?=
 =?us-ascii?Q?6bU1weJj+thkzg8hDyq2njdkOBKRVymhjrbbyvxA/WU16ItiTXlhLRlq9c0R?=
 =?us-ascii?Q?DiD72cQ6AwYyZIS5HHgQtfPeEXJ4yPedFwK3PNPJFJsKZYFDrGOE3aUtlX8n?=
 =?us-ascii?Q?Za2AX9XruT+EFpVHXkwVm+gS0kqeomUXbzY/un9yDu4CjawzQ5GEcF5+oMjf?=
 =?us-ascii?Q?TrSZHMFc/tuX0gsFTf2Mmw0iJ4TESRfrziqqgBoGd4uZ7ZqlTspSIJzm7Oif?=
 =?us-ascii?Q?AlWumjmI3NgC9zbMQHx7mqirR9IVacvDI9nCs+HeLi8OCiZo60iUJnUOy7ci?=
 =?us-ascii?Q?ymWslwwa/scEd1wio5F6WtsevV3HSqnQnSGyamVOkOgTiVth+pPQiCc2XBGR?=
 =?us-ascii?Q?Nr2Gas+abI5FwQuOuJl0RmLWpd5LwC+zpD7zFpeoDhFa9ZlT/BNKoa5qdMt9?=
 =?us-ascii?Q?jUwlk2EqTmKczS7z7RgeUo5jO5WywgPEBu//CkkNP867Q8EGl03rYNaYxVQ8?=
 =?us-ascii?Q?8M/kWp+9mj+L8ncCRs6EkV5fMDYx7O0IOo1eHofTUYjUUPUE4zlAjUmn9zdO?=
 =?us-ascii?Q?zz27PLyNm1kbsYmsYzhsZ+XfC685sk9MdWln7KA+D6tXk9Hh9CKxEGLxv41u?=
 =?us-ascii?Q?7qEROe/QbK6Qoo7P2LH/gOO74flea7cMjvBbRQBgc3RTSfMDxzhXgEeh8ay7?=
 =?us-ascii?Q?tSlJAdcIHR1tDF7dnEgyUlubhY0UJbAUH7EYMHyFbUdyqK9+LLTpOG3RPRYi?=
 =?us-ascii?Q?/qbJ/+Xfy8+DhJLXmc3+f/Q9jBmZmZ8tJzkt2ABO2mkKHDUb9Yl63gY4NAHO?=
 =?us-ascii?Q?V6Yybq/9OBlGYmARLT6L8w+ycps+aPvnvfFbwftIG2Znxun9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76bfc34d-0286-42ee-7b2c-08deb1a41b7e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 10:32:32.8256 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ErnP1HouqIUOI34EoPy8zUAac4+8TzhPQM7K9uvXArwpFhLuDqnmdeGHmZKhwhzTCyglB4A+TLgxmw4ORlPHCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7179
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

In host1x_syncpt_wait(), the hardware syncpoint value was loaded
initially for expiry check, and then loaded a second time to
populate the caller's value pointer. Reuse a single load for
both purposes.

After dma_fence_wait_timeout(), the previous code reloaded the syncpoint
value for the expiry check, which is only required in the timeout case.
On success (i.e., return value > 0, or return value == 0 with zero
jiffies remaining), the ISR has already cached the value before
signaling the fence. The value pointer can therefore be populated using
the cached value using host1x_syncpt_read_min() without MMIO access.
Only the timeout path requires a fresh load, move host1x_syncpt_load()
under that path.

Measured Syncpoint wait latency (50000 samples):
  Average latency:   12.2 us  -> 10.6 us
  99.99 pct latency: 62.96 us -> 51.90 us

Signed-off-by: Tanmay Patil <tanmayp@nvidia.com>
---
 drivers/gpu/host1x/syncpt.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/host1x/syncpt.c b/drivers/gpu/host1x/syncpt.c
index acc7d82e0585..807c74fc6a0a 100644
--- a/drivers/gpu/host1x/syncpt.c
+++ b/drivers/gpu/host1x/syncpt.c
@@ -222,11 +222,12 @@ int host1x_syncpt_wait(struct host1x_syncpt *sp, u32 thresh, long timeout,
 {
 	struct dma_fence *fence;
 	long wait_err;
+	u32 curr;
 
-	host1x_hw_syncpt_load(sp->host, sp);
+	curr = host1x_syncpt_load(sp);
 
 	if (value)
-		*value = host1x_syncpt_load(sp);
+		*value = curr;
 
 	if (host1x_syncpt_is_expired(sp, thresh))
 		return 0;
@@ -245,21 +246,25 @@ int host1x_syncpt_wait(struct host1x_syncpt *sp, u32 thresh, long timeout,
 		host1x_fence_cancel(fence);
 	dma_fence_put(fence);
 
-	if (value)
-		*value = host1x_syncpt_load(sp);
-
 	/*
 	 * Don't rely on dma_fence_wait_timeout return value,
 	 * since it returns zero both on timeout and if the
 	 * wait completed with 0 jiffies left.
 	 */
-	host1x_hw_syncpt_load(sp->host, sp);
-	if (wait_err == 0 && !host1x_syncpt_is_expired(sp, thresh))
+	if (wait_err == 0 && !host1x_syncpt_is_expired(sp, thresh)) {
+		if (value)
+			*value = host1x_syncpt_load(sp);
+
 		return -EAGAIN;
-	else if (wait_err < 0)
+	} else if (wait_err < 0) {
 		return wait_err;
-	else
+	} else {
+		/* Success, read the value cached by ISR */
+		if (value)
+			*value = host1x_syncpt_read_min(sp);
+
 		return 0;
+	}
 }
 EXPORT_SYMBOL(host1x_syncpt_wait);
 
-- 
2.54.0

