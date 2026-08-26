Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4173C61DBE
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 23:04:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0C0D10EE25;
	Wed, 26 Aug 2026 23:04:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uPiqRHk5";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011050.outbound.protection.outlook.com
 [40.93.194.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ADE710EE25
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 23:04:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s1rUOVEvi9rZKFYfkmSMqZhjJOkUQg44gxGue57AsuAexEOduTT9aMczP6hq5VCSZSGMLe3SBsznaanwn7ny/gGgpM8GV7Z2vAryWmGuKOWJ7q0lDU71sEC5xnadh4b1wjR4IRHXs5/lH2wRb6GVEKammDk+8TJnloQ+OO4vimXripYTRFI8Bw5hWZ3mpWX40aB2G/GxN/D/vL0ZqjwykvGXKeATaY+84nGsZp48O4a0B08kvfyFHSf6gOODz2Dv1PVqNibfNkGE5Ng/iMUEd8I2hnzJWEFgDA6Wy6mkumj/fCr/BIEjL3ktP6Fx2STi7Ij2sk3rQ4SULAveJAAfGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OAdjP0IsZHTGMNaMZ8PxwJXFTBsfZS/40Yhw1a8OW+o=;
 b=k2XmekfBe7S5yEW283iDqwe3oZl3oyyxIa09f+FV6byBrQyXv4/zCGJyhjM5SBGZcWdfO6XqjlDrg/98aM/16AupFALySRZEVe8kyhfHbt5/YLOQTp2rrXmhHzKsC8pHx0+Aj6dlZNULgoMib/xhHHebhIqDKyNOXrLC7imMQ57yuGenlne920o1ZmTbaeASs8Un5PJ47ITuozmmaV+6pK4+N5PvO0NQWuvx/1MvwCIwk1yOyM9XAoMOc3q9T2nR6QBJkTzOKPQpT9E8Ka01NEEIi7SpkWjriZlddJakJDI9AWFxVeCz7t7vldd5F9WNKZ3J/W46XzQUDXJOjy7uMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=kaitmazov.com smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAdjP0IsZHTGMNaMZ8PxwJXFTBsfZS/40Yhw1a8OW+o=;
 b=uPiqRHk5vHCljiEcasUgyn8vYxCYujjNFX87bYGJ4BV/nVwB+qL3P2JndkKl91DRuW2zLrCKr/BCRwd3H45cSaTSBFPmsfs9nPX9A1wQgBk9/VPsq8h57tq/i3RtLEkImaodPfduBTqan3nur7HOdV3Sjz/LIFmIVHa4EYKTbzE=
Received: from BY1P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::7)
 by MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Wed, 26 Aug
 2026 23:04:28 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:59d:cafe::29) by BY1P220CA0009.outlook.office365.com
 (2603:10b6:a03:59d::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Wed,
 26 Aug 2026 23:04:28 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb08.amd.com (149.199.90.133) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:04:28 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:04:28 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Wed, 26 Aug 2026 18:04:27 -0500
Message-ID: <4f6b5cc2-1edb-b978-2939-15aa8d09bfb1@amd.com>
Date: Wed, 26 Aug 2026 16:04:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] accel/amdxdna: Bound the page count of a user supplied
 buffer
Content-Language: en-US
To: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>, Min Ma <mamin506@gmail.com>, 
 Oded Gabbay <ogabbay@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <f1cbc1bf-2904-e0cf-8fc6-07ce41dad2a2@amd.com>
 <20260826212825.408846-1-taimuraz@kaitmazov.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20260826212825.408846-1-taimuraz@kaitmazov.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|MW4PR12MB6873:EE_
X-MS-Office365-Filtering-Correlation-Id: f0828547-ca83-4b3a-3d98-08df03c66181
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|376014|82310400026|10067099003|4143699003|11063799006|5023799004|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: lJ4yi4dpJtSIAiCLwpdTt+tk/91LUggH61bE958X6x5XMMHGD6KZXYgEdPREheehhWEKufCgUYIS7okxfabGwa4YA3+wcaZeKXkXdhcrwvSW1Tt6z2Tp5o7mgJN78wIhNKvKVkkeno8S9U5AqA8DU4wVeVwylQgl0kwYbc8gQmB1bgQvrpTg+RtQ/g8MP688pr3D3Cks8lsQHZBNqyyKuPSqh0pj8LOhpHPi1f2dtir85lQ3kbo1VQEwwlO5K6eR/7glTERmdIMqQA0aGXJmkBqeKzFHTma05SRQfOa1W+DSmza36AXpcHszeV38mrx9/NrJ/kYGWQtO2U+qOPqJTQ1J4gadeaEfUtBq5xqCyU69q1/JuExt6L1Vr920L9SKeODR1eZFVCcpxy3e+/GznVYUlVBer5jchq+56jD64M0mYsRQsIr7h/XCuvkx4QVw8AhMoSFN9lhD42nnXQOy9l3Ug6NXkOZsFLnN/IwkiOQ1sm1C5aWpbLbOn9LnyiYcX2HMs3NjzqwOREur/4ysRKHJKu8y9/Zz4Lgd6bUkb5sag4WlAttl+xkjdX+LIoF1czwTAiTqjM52B/n/nl6RmSUS6jI5yXkOP/qUD0WI7MJJLA4zUelQGH9Y0RTvZD4xx01zYjXYg19vpueAU6jbQ90+NfqW/jycrd4/e4dOxdXVs1qHfDQYWW0xBxMzQAexdCGzqzmPJtwOT+XZVnwIuQ==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(376014)(82310400026)(10067099003)(4143699003)(11063799006)(5023799004)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aqnneNQovRDHUGSRCmHa8DPWhkhev93UQjWtFijv7A6k96e5otgneeXp9JhAizjS6w0qFdFJyJ55NEVRftjThuQpwWVc7IotaqiuFO6BwWLlfO87z0Cz8cNq3pRENcyLDhcYYRNTsYxgR2uUMINBLNNZ7HnLPzZDpsTOBzzdyy6951ih4RPR2zK0dwMLrRp7xjma4yJ8ST+kUqL+qnNVAkM9vM3WTdpD1HZttofBG9W+X/B1ZDTdf1RX/Auz4lVnJ3jEPspQVaNSrTe09gyMh4NnhvFl+VWKoey/c0NwAKzANUEhyc3btHAKfTurPLs9qWt+oTwmXr5mNdxqaxz+TAtHlBBef5Oxk7LUSrx36ALIaFxxex+Px/AABjyKHiRaLI0jPJ7znrrP7YQ9AcEsnjGCrohOEaNwHw3myXz3GcE4m5ZutjqtSPywCfuZXIrC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:04:28.3094 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0828547-ca83-4b3a-3d98-08df03c66181
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6873
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


On 8/26/26 14:28, Taimuraz Kaitmazov wrote:
> amdxdna_get_ubuf() puts a per-entry page count derived from a __u64
> va_ent[i].len into a u32, then passes it to pin_user_pages_fast(), whose
> nr_pages is an int. An entry of 2^44 bytes truncates npages to zero, so
> nothing is pinned, the ret != npages test still passes, and ubuf->pages
> keeps whatever kvmalloc_objs() returned while ubuf->nr_pages describes the
> untruncated count. amdxdna_ubuf_release() then walks all of it. Reaching
> that needs CAP_IPC_LOCK and a multi-gigabyte kvmalloc() to succeed.
>
> Reject a total that does not fit in an int. The lengths are page aligned
> and summed with check_add_overflow(), so the total is at least as large as
> any one entry and bounds the pin call, the offset accumulator and
> sg_alloc_table_from_pages().
>
> Reject a zero length entry as well: it contributes nothing to the mapping
> and a table of them leaves nr_pages at zero.
>
> Fixes: bd72d4acda10 ("accel/amdxdna: Support user space allocated buffer")
> Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
> ---
> v2:
> - XDNA_DBG and %llu, per your comment.
> - Reject a zero length entry in the validation loop, and lower that log to
>    XDNA_DBG too, as you suggested.
>
>   drivers/accel/amdxdna/amdxdna_ubuf.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/accel/amdxdna/amdxdna_ubuf.c b/drivers/accel/amdxdna/amdxdna_ubuf.c
> index 0e0cd69cd1fb..bf1e4dd7bbc3 100644
> --- a/drivers/accel/amdxdna/amdxdna_ubuf.c
> +++ b/drivers/accel/amdxdna/amdxdna_ubuf.c
> @@ -111,8 +111,9 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
>   
>   	for (i = 0, exp_info.size = 0; i < num_entries; i++) {
>   		if (!IS_ALIGNED(va_ent[i].vaddr, PAGE_SIZE) ||
> -		    !IS_ALIGNED(va_ent[i].len, PAGE_SIZE)) {
> -			XDNA_ERR(xdna, "Invalid address or len %llx, %llx",
> +		    !IS_ALIGNED(va_ent[i].len, PAGE_SIZE) ||
> +		    !va_ent[i].len) {
> +			XDNA_DBG(xdna, "Invalid address or len %llx, %llx",
>   				 va_ent[i].vaddr, va_ent[i].len);
>   			ret = -EINVAL;
>   			goto free_ent;
> @@ -125,6 +126,12 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
>   	}
>   
>   	ubuf->nr_pages = exp_info.size >> PAGE_SHIFT;
> +	if (ubuf->nr_pages > INT_MAX) {
> +		XDNA_DBG(xdna, "Too many pages %llu", ubuf->nr_pages);
> +		ret = -EINVAL;
> +		goto free_ent;
> +	}
> +
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
>   	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
>   	new_pinned = atomic64_add_return(ubuf->nr_pages, &ubuf->mm->pinned_vm);
>   	if (new_pinned > lock_limit && !capable(CAP_IPC_LOCK)) {
