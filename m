Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F21B606A32F
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 20:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=27rZd/CO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 703EE10E473;
	Fri,  6 Nov 2026 20:46:08 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012032.outbound.protection.outlook.com [52.101.48.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A65E310E473
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 20:46:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MaqnODZvvOno0P+e4Os59A33elIyoVBg9PLA/iv+e+fBUnltBgL/dICmcIUj0gcuxYTgZsYfLrCObKAHG0tm58zGD6tvw8Qp3cmot0TZENKysDkF484cxxTpxKk2L693l9qQZBhoB8jlTN5MIcDvAxkC2hwTWRHwmZy2YwZz/JZvGRc7x7OsBx3H2UvFU9TW+G6X2qPdHD/YkI4dQZnWZdBfYVl3pkI/nrM84j+zVm6UfMzsxhazn3xwXn/SE33BKeF9vfbIK1syGbM1VBtGC6iVtxCOcOh+//lHpGaRJcPG2EWCuc7akE3h/6yw8WTIeXqNsTDJDkawBWVwR2rGCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cRpWlI+onPFsN5X1uDhg6aMvyPfBkVJCBRJd8YjDViU=;
 b=TtLhWEOg+87M7f+qRvx82S2G9at3o+nFllbWczC45HaKR4BRsH829f/1Wk2RVTqNMid2EqD046gABN86v936aNtZbx/2e2gwy2h9tX2wIsRYnt0LY0QTJsRFN5L8yINlR7dUZg7bkkcO9xco5Mzjjnj6EMf0KNHyCJuLTvwi5CSTUj6xOmooxX3/MYe6vYZiKxIvqqk48LmZs+HEOz0fYBtlBJIltfxdf2xMULgBW0L56nzeutZDsSG2NJO6eWnIfT0wD9vz+NbDR+QYHccjpJAJvSMuWOf6YVIe5elu9jqst9JFxu+Mnqos1p2vH4f8yQ9naZHSlWff7UXrkvntdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRpWlI+onPFsN5X1uDhg6aMvyPfBkVJCBRJd8YjDViU=;
 b=27rZd/COpxcuBM15zvoDxXWubPJQbtdQnoe8Gfxb1sbPEwngPU5cKoiDcrQFSaN8SJEFX7Nkbc9WxGdMq6chzLrJQpCdlJTI5bw4VcjqAiuWtAkEVuvzpTJbcbxES6bcsuZpXzXL5p2UJbr3Nk+qGzbx6L0CZzeCE2pUkDYBUPA=
Received: from PH7PR17CA0039.namprd17.prod.outlook.com (2603:10b6:510:323::18)
 by BL3PR12MB6571.namprd12.prod.outlook.com (2603:10b6:208:38e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 20:45:58 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:510:323:cafe::4) by PH7PR17CA0039.outlook.office365.com
 (2603:10b6:510:323::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 20:45:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 20:45:58 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 14:45:57 -0600
Received: from [172.19.68.247] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 6 Nov 2026 14:45:56 -0600
Message-ID: <eecbf66e-d2f8-4872-bd97-672ffaa2c7b4@amd.com>
Date: Fri, 6 Nov 2026 12:45:56 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Use vma->vm_mm consistently in
 amdxdna_hmm_register()
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
References: <20261106203516.2734090-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Max Zhen <max.zhen@amd.com>
In-Reply-To: <20261106203516.2734090-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|BL3PR12MB6571:EE_
X-MS-Office365-Filtering-Correlation-Id: 04a125d5-04ce-4912-773d-08df3c46f5fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|261026140227099003|261026121527099003|11063799006|56012099006|261009223027099003|261021123027099003|261021121427099003|261022105027099003|261102123227099003|261028144727099003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: J+WCNzVp1nANd/GL5ZpMuqN8PHF5bX4IiK8y0+Ws8/uklTTN66cM+enWCRtpc7cUKiDfkDAzl2+7qYce0HJGj8LNCdmREQ0UKVzgB2WpDPPL+FWRUJNOkGYLpKRwOFM5UJ++Q7tdDD/zIIHVahpcK47yR7DXf6XV1mDnreTNEvjh6GuQQ8HcVfipyt4ZGme2IwXJ9pzvzLdWudoGO7QiHpsz2CQs5aH850cHgbpJTdmt08622gvN6cOIEx1SOsqe2lfXtekZWsH/x7ge3xPY1CXGjKOsimHSo+Dd+yElQ85m6sMBwkB+zDkfeLKWD91kPrGvoe2Mt5cUy9y/J7BO3rTvIeUCpqxSQ1iQGkyEW5ROPI8z00ODRES+aA6zjUXjJu/Y2KJ7ohSOcomQ5gRO0xD42NxyTlPl3RP4vWlWTJQq/BBY1MTtVGs2+5psiKkSCwq2P3xxXUatWQd+Eo+TnrOdjpAjuUscgnPw25c8zcYNFszH1wBeb4ZWWdTxqaxvFExCxjPwO/dZtQhU56KMo9xy+5MHrdrCzsp1lg57YQYeW0VqTurmOfYHJvOTnVir6TpphC86it1C61MdMveLdiOXszk5ruudj/QyDkfLf9cC5f7Sw4OZQxQgfzqw08ede8DmPXDQPMi1El46+BN21EKz6nC/LQbN0dHwAIbfPFsP2En9bRoXS/wjmhdR6hrNJoSiWFe+eeCUXtWXZCqKGA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(261026140227099003)(261026121527099003)(11063799006)(56012099006)(261009223027099003)(261021123027099003)(261021121427099003)(261022105027099003)(261102123227099003)(261028144727099003)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: q73IykKYqW/6MRebArb0W0tb5GSl6s6vzCdj31dCZjRQ9RyJv0S4zJOCBEWqYtjH7tIGz5HzjsCcXg5UF5uVv+1e/FmHYnXP/Lw8IOB5EJM9D7gnLs7JmB/iGViBIqdO5lXHkuKrl2I4tzj3/IpdJrafGp+fsSfFK9KUa6MD2bFDcnPaZmbnS+oTykcnGAV0nU7MGgGIR8bbaLUeHAv+YtmF+NtI9BRA3NFrQj+VyuYHql/W+1yhSV6CbfOYCp1CNJZ9JZ3N5+7M3l5iXS4zoO94qrbqO3hgc8nvAQeubKvLkbzZqPwi7WkHq+by/wvw3xnPzFTL5suWFU3u3tft+MYODykdA+zSxn1AtrcwvWGHE3aP+DTCpdHiW5w6rvtlcmJRmeAeYKh4qqf1J8IaFQy6zBHiJZF3Jd+9IU5KM2bo+EpZuabooedWidHduOWM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 20:45:58.1631 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a125d5-04ce-4912-773d-08df3c46f5fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6571
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/6/2026 Fri 12:35, Lizhi Hou wrote:
> amdxdna_hmm_register() keys the umap list lookup and the interval
> notifier insertion on current->mm, while amdxdna_hmm_unregister() and
> amdxdna_mark_mapp_invalid() match the same list entries against
> vma->vm_mm. The two are identical for the ->mmap() callback, so this is
> not a functional change, but the inconsistency makes the code harder to
> follow.
> 
> Use vma->vm_mm in both places. It is the mm whose mmap_lock is held
> across ->mmap(), which is what mmu_interval_notifier_insert_locked()
> asserts on, and it is the mm the teardown paths look the mapping up by.
> 
> Assisted-by: LLM
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Max Zhen <max.zhen@amd.com>
> ---
>   drivers/accel/amdxdna/amdxdna_gem.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
> index 09e48c794e1b..92125bc753c7 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -443,7 +443,7 @@ static int amdxdna_hmm_register(struct amdxdna_gem_obj *abo,
>   
>   	down_read(&xdna->notifier_lock);
>   	list_for_each_entry(mapp, &abo->mem.umap_list, node) {
> -		if (compare_range(mapp, current->mm, addr, addr + len)) {
> +		if (compare_range(mapp, vma->vm_mm, addr, addr + len)) {
>   			up_read(&xdna->notifier_lock);
>   			return 0;
>   		}
> @@ -477,7 +477,7 @@ static int amdxdna_hmm_register(struct amdxdna_gem_obj *abo,
>   	kref_init(&mapp->refcnt);
>   
>   	ret = mmu_interval_notifier_insert_locked(&mapp->notifier,
> -						  current->mm,
> +						  vma->vm_mm,
>   						  addr,
>   						  len,
>   						  &amdxdna_hmm_ops);
> 
> base-commit: d2a8cee91bfa8616f713c7c8f539a81e8e3554ea

