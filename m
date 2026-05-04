Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B06B7CD3427
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 16:05:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF7CF10E239;
	Mon,  4 May 2026 16:05:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B72GELOo";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010019.outbound.protection.outlook.com
 [40.93.198.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2A6E10E239
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 16:05:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P30kNrM2zk6RCWX5ZNUKT0As+KKho8SXHIkX8h9umlFJxNM9l8+6TV9+4jhPoUL/skXnDum6k7ctKPvNjq1Ome++MU7ETPikUFIVrrxawJsGvHULQfrNsRaQYHFCKJL7huYfWrkiYrCq3iHFSsEZVR1w+hAfy3O1PSVZ30sZh8RsrFNrIJ+ray31RnZ3g3Xnb8yGhdDNM/QzaFADK+45LafKUjMim2e9W0RqeJr9WWW4vNL49WVayCVJotVOWiX4dbMqtrrfcObwed7MA300m5kbNulaqpDrRKHSDA+Xb8F+JSKp5tTM3eyPMZ1vMSYH+1hBOwoqgCwb+Z7o693kDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9eVh1lTUMaN6ZBzsJ0DzXdm46JzsMMPUO2vYDEYUb/o=;
 b=IjTU0BYqXfdTIVIllBltJpPxWTrbFn/V5UYX5pt1CYq4uHcDXCbn7i8S0pzWP3QVVW9h6KNHTUNb/U7/Se/QKdt8nu4bnEY5nQ2FEoh9eHgQ1neG9NFiACV8KjHfJe6lrWnuD47/cY9Y1BcWgD1nMyBbvOXw4XBrdeySmfnFE9cQY8pVkarrp9AI6D6WTLaRePRBj163JRemV4dTq5RPpYtCexSi9v0+6ktGLw5pm8AlJ9iTxIc+tORJR0vLzn6nzvObaJYzQjeQiKavxaSxWuLKPX4mqSoE4vmfo180MKdWTEhElC6w1V+M/1Wd20QrVGl49NKD58sYnekl5viV6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eVh1lTUMaN6ZBzsJ0DzXdm46JzsMMPUO2vYDEYUb/o=;
 b=B72GELOo3xA/7EROSWW33l51gd33WjSiky/B61strC7COB7PzYaC6Zakb0MUntBfH2RX9bF5mDHh3q06een4B6bELyqPr/C3TomO7FEU+GMjyEpi2FyVm5vRPWafLvMwDg4rQnHRH2wixLtTBuX8OSqr/SXdW521Ap7SFM7GCUA=
Received: from SJ0PR13CA0106.namprd13.prod.outlook.com (2603:10b6:a03:2c5::21)
 by SJ0PR12MB5609.namprd12.prod.outlook.com (2603:10b6:a03:42c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 16:05:09 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::f8) by SJ0PR13CA0106.outlook.office365.com
 (2603:10b6:a03:2c5::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.14 via Frontend Transport; Mon,
 4 May 2026 16:05:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 16:05:07 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 4 May
 2026 11:05:06 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 May
 2026 11:05:06 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 4 May 2026 11:05:06 -0500
Message-ID: <5a669bab-bceb-529c-351b-20fbb53c9ddd@amd.com>
Date: Mon, 4 May 2026 09:05:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] drm/amdxdna: fix pinned_vm accounting and error
 handling in user buffer pinning
Content-Language: en-US
To: Vineet Agarwal <agarwal.vineet2006@gmail.com>, <mamin506@gmail.com>,
 <ogabbay@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20260502031746.621606-1-agarwal.vineet2006@gmail.com>
 <20260503055258.643546-1-agarwal.vineet2006@gmail.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20260503055258.643546-1-agarwal.vineet2006@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|SJ0PR12MB5609:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dc13be9-bb30-498e-a3b7-08dea9f6e99e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|13003099007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: f3Y+YZkfq7VtiQwIiGTYKUO6ejRwH9lYYX6qZPx4mREuXHxm0EniUAzhY5chCE+HbBJ/YWbutOQ1GlC+Az7nwr0Yg0UqWksYiWN11xYznauRwlEk6B3+bdizDk2I5+BCv0WJbCmwYBda5gOcdZE4ZLeCORl1Gl0eqbvX+Sh8Lso6TeKH/EszVtH1Vzc3beHgfgLRDwjrDwuaDXw0kpUoeMVXri/YAgUmaa9baCwwqIhNB1EW1z2we8mSD4aSqbKde1BbldwMKJgl8CeFxbIx4moUD1s7847/GFG2us6nhL+ZihF2GMYiFa1JkODh5oryQmiyLElofHmsaMwW5F+VkFL2+fHKRnR+O62pZnYYxX7B+CHtyXUHEgpcRCd9G5vCU3xH/ewG+O8IQSHXgltxdbcqd0io41Wfs+FqMh86oWU+2qe1Jd3k1DtBAJR9HsmY3sNZFznpyA8u4s42Zd1PbsSe6ST7MSPPD8fDf3uoiZ3cw0i4m5h2x7S+WZCzLPpWSkLXiA7AKV2kcNzric0zlqVVkZBNMkX5lIeDWhYaUNw3ZxNukYfIbTthkSzgO8Kc5+69t5v8Y3cWLkwy9BMfWzAoCbpJhzuu1an1V9em1z89uGhmWbAA7Jbnh+HvH4Y8sH2RSKgiT7jloXjTxt7hXrRjOgjxQpaSx3xitAxRzFTRJwajg3584pUL+7HVeuFtFtgWVbIe5tS7cDBZ3CVXjdkR2g3xDUunSoutVU4i+RE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(13003099007)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Fk/yMsWGPqnk3EzN2S6zpZlgkVo5LHfmytvb7i9CxLl4pXFJUGM07enXzi/1icOhP2n0L05LjYcWKKkTS1atmvaWEB0Ml/wvPL9t6Ji3/vDoUB8t4WYH0VmfYOed3UUGJfsgzifNOG1+61av6PB4l7DwS3kNZWbLO0L4e05TzIuHmcT7NuVCC3Zukl+BV+dSL1c5F2qHNi5Jwk7szO+CscyJSShMqL6uSCJIsM43mfb+xMreiEVrXSI1RZ622IAeENnxT9GiS9VRKpbERZf1TBVeshkescuq3KnSvG+jXzHOaJerHWpChc+8J/+TTdE/YsYmoYeE4Y8Jk1p08u6DovU6S3L2qOGgJE6EEkLtEhsTbT1R7SKWt5dbBkmWKeDLdJfJGeAlVAx1tXbieCh9/jdT7rYApGCKxkawhi63KqXZQlgiHboO7maucTWIC8Gf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 16:05:07.8353 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc13be9-bb30-498e-a3b7-08dea9f6e99e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5609
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


On 5/2/26 22:50, Vineet Agarwal wrote:
> [You don't often get email from agarwal.vineet2006@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> amdxdna_get_ubuf() incorrectly accounted mm->pinned_vm using the
> requested number of pages before pin_user_pages_fast() completed.
>
> Since pin_user_pages_fast() can return partial success, this could
> lead to incorrect accounting and inconsistent cleanup on failure.

If pin_user_pages_fast() returns partial success, amdxdna_get_ubuf 
returns and pinned_vm will be restored. I do not think it is an issue here.

>
> Additionally, the RLIMIT_MEMLOCK check was performed after pinning,
> allowing excessive pin attempts before validation.

RLIMIT_MEMLOCK check is on line

    if (new_pinned > lock_limit && !capable(CAP_IPC_LOCK))

which is before pin_user_pages_fast. I do not see anything to fix.

>
> Fix this by:
>    - checking RLIMIT_MEMLOCK before attempting to pin pages
>    - handling partial pinning correctly and ensuring proper cleanup
>    - updating mm->pinned_vm only after all pages are successfully pinned
>    - removing incorrect error-path accounting and double-subtraction
>
> Also fix missing rollback when dma_buf_export() fails, which could
> leave mm->pinned_vm incremented without a corresponding release.

when dma_buf_export() fails, it jumps to destroy_pages which cleanup 
everything including restore pinned_vm.


Lizhi

>
> This ensures correct pinned memory accounting and consistent error
> handling aligned with other subsystems using GUP.
>
> Signed-off-by: Vineet Agarwal <agarwal.vineet2006@gmail.com>
>
> Changes in v3:
> - Fix missing pinned_vm rollback when dma_buf_export() fails
> ---
>   drivers/accel/amdxdna/amdxdna_ubuf.c | 26 +++++++++++++-------------
>   1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/accel/amdxdna/amdxdna_ubuf.c b/drivers/accel/amdxdna/amdxdna_ubuf.c
> index fb999aa25318..efce6b94fb0c 100644
> --- a/drivers/accel/amdxdna/amdxdna_ubuf.c
> +++ b/drivers/accel/amdxdna/amdxdna_ubuf.c
> @@ -129,7 +129,7 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
>                                   u32 num_entries, void __user *va_entries)
>   {
>          struct amdxdna_dev *xdna = to_xdna_dev(dev);
> -       unsigned long lock_limit, new_pinned;
> +       unsigned long lock_limit;
>          struct amdxdna_drm_va_entry *va_ent;
>          struct amdxdna_ubuf_priv *ubuf;
>          u32 npages, start = 0;
> @@ -176,18 +176,17 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
>
>          ubuf->nr_pages = exp_info.size >> PAGE_SHIFT;
>          lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> -       new_pinned = atomic64_add_return(ubuf->nr_pages, &ubuf->mm->pinned_vm);
> -       if (new_pinned > lock_limit && !capable(CAP_IPC_LOCK)) {
> -               XDNA_DBG(xdna, "New pin %ld, limit %ld, cap %d",
> -                        new_pinned, lock_limit, capable(CAP_IPC_LOCK));
> +
> +       if (ubuf->nr_pages + atomic64_read(&ubuf->mm->pinned_vm) > lock_limit &&
> +               !capable(CAP_IPC_LOCK)) {
>                  ret = -ENOMEM;
> -               goto sub_pin_cnt;
> +               goto free_ent;
>          }
>
>          ubuf->pages = kvmalloc_objs(*ubuf->pages, ubuf->nr_pages);
>          if (!ubuf->pages) {
>                  ret = -ENOMEM;
> -               goto sub_pin_cnt;
> +               goto free_ent;
>          }
>
>          for (i = 0; i < num_entries; i++) {
> @@ -196,15 +195,17 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
>                  ret = pin_user_pages_fast(va_ent[i].vaddr, npages,
>                                            FOLL_WRITE | FOLL_LONGTERM,
>                                            &ubuf->pages[start]);
> -               if (ret < 0 || ret != npages) {
> +               if (ret < 0)
> +                       goto destroy_pages;
> +               start += ret;
> +               if (ret != npages) {
>                          ret = -ENOMEM;
> -                       XDNA_ERR(xdna, "Failed to pin pages ret %d", ret);
>                          goto destroy_pages;
>                  }
> -
> -               start += ret;
>          }
>
> +       atomic64_add(ubuf->nr_pages, &ubuf->mm->pinned_vm);
> +
>          exp_info.ops = &amdxdna_ubuf_dmabuf_ops;
>          exp_info.priv = ubuf;
>          exp_info.flags = O_RDWR | O_CLOEXEC;
> @@ -212,6 +213,7 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
>          dbuf = dma_buf_export(&exp_info);
>          if (IS_ERR(dbuf)) {
>                  ret = PTR_ERR(dbuf);
> +               atomic64_sub(ubuf->nr_pages, &ubuf->mm->pinned_vm);
>                  goto destroy_pages;
>          }
>          kvfree(va_ent);
> @@ -222,8 +224,6 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
>          if (start)
>                  unpin_user_pages(ubuf->pages, start);
>          kvfree(ubuf->pages);
> -sub_pin_cnt:
> -       atomic64_sub(ubuf->nr_pages, &ubuf->mm->pinned_vm);
>   free_ent:
>          kvfree(va_ent);
>   free_ubuf:
> --
> 2.54.0
>
