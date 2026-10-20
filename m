Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316E4606A32D
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 16:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KyRGU4PB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8831E10F2F8;
	Tue, 20 Oct 2026 16:12:12 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012021.outbound.protection.outlook.com [40.107.209.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2927D10E188;
 Tue, 20 Oct 2026 16:12:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+lf3wJE2PfcyusJepmopR+1S070Kcja26PStFYmLlomI04HDBmWDo3DgwOZeAkPWYmcvoFQNuznA+wnXcvq83ge5vpdYnFwylcVd5Xiu3hTj4SbT4nX7Orl742cyA5Tl9WH6JB8qiGIbmO+UHM419Qnzf43FoDcVTiURjIrXySYdAS0mG7eOSEvokfBXelm6JJ8giz9mfO4sqGoXB5Xb64SdaxBn7AoMeVzFZezSUy1H7qxKExcro9UyPsIWvihaFvOAR35nyVuj43+FMjF2hwKtWuLB/nu0ll60yeX8ycWB304/vCLUkiZg9BuZ28fKzpMCkGj0U9TSn2xy80APA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMa2K7a3x1eg92FuoukE2SSNv8B8ftw7thFUoyxyNsY=;
 b=Qaz4EH5Xuq1QNNdZXNVDUKO8Ll/ojA4CGmVMs7+CKAIjAB3GxoscGbU3pmZlCIugNXOaYTdfDYIm18pUV3AHGmhKK145JbAAXILJqsys1IEfJe4oD8j2hBep5yfjRaijVr0kKwirnFpGyiOxqKSURozwHBsUq0kyyyWGM4YnjDIn9+c3YvsVjP9YQVg6J7OJ4Zw7anlHYjGMXGjJZla1jGv5gb9Qp1nw7j7EqIk5gOc/8SAbLv0PEkp8+hkAQf5xPhUwcfOIstuWQnTq9Ou4BBfByJUeQGKkZ7FcDqAMcZpM2R+fTCFYdhcrA6/nCtoLXO7WCwPI2j8lT66z+W6GSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMa2K7a3x1eg92FuoukE2SSNv8B8ftw7thFUoyxyNsY=;
 b=KyRGU4PBIQLQR5wqECgbTjGzjlWlVeYaBHcyRYcUqK5XUkvtVM9fTEgpzIHH9vf6jg+nIBa8tiFgrjjpATukzzy+La4hJVnHFa6tfdHsAeFwXL/kSXgkEtctAq6w0dZBYBAtPLRU2dY2zMjgV4hLqrTlfZ4y3o9gTJ8LYxBXxLU=
Received: from DS1PR06CA0007.namprd06.prod.outlook.com (2603:10b6:8:458::13)
 by PH7PR12MB6906.namprd12.prod.outlook.com (2603:10b6:510:1b8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 16:11:59 +0000
Received: from LV8PEPF0000005C.namprd02.prod.outlook.com
 (2603:10b6:8:458:cafe::23) by DS1PR06CA0007.outlook.office365.com
 (2603:10b6:8:458::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Tue,
 20 Oct 2026 16:11:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF0000005C.mail.protection.outlook.com (10.167.245.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 20 Oct 2026 16:11:57 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 11:11:57 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 11:11:57 -0500
Received: from [10.254.92.67] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 20 Oct 2026 11:11:56 -0500
Message-ID: <141dad9e-6868-42e7-836e-d14e1ba78fe9@amd.com>
Date: Tue, 20 Oct 2026 12:11:56 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 66/75] drm/amdgpu: dm: Convert to atomic_create_state
To: Maxime Ripard <mripard@kernel.org>
CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, <dri-devel@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Harry Wentland <harry.wentland@amd.com>, Rodrigo
 Siqueira <siqueira@igalia.com>, <amd-gfx@lists.freedesktop.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
 <20261014-drm-no-more-connector-reset-v1-66-586c9c026823@kernel.org>
 <a94849ae-f553-4752-a236-746fa89e23fa@amd.com> <atdbcaZo2YO54YY7@houat>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <atdbcaZo2YO54YY7@houat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005C:EE_|PH7PR12MB6906:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e54856a-77df-433f-96e4-08df2ec4ddd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|42112799006|82310400026|36860700016|1800799024|376014|18002099003|22082099003|10067099003|4143699003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: W/wGUOnyEdKl40IZm20RJryNFuBaUfYlyDKxPUAMsnJXltBpFReSltIqu34C2m+roLP92ntORizcNTrLjkHmjFfaXXDXog2EAjkiK/RqenD4uhqjpssekJUAye4XE5vPgDMtIUXcnkCWUmftqqHf2Z5ZXWx2OzoRW3t1L9xNYrtrW08rR9qoZWAGq1DSvK9lmqqSamICAAMAYlYgIFc7Q/adEIb6v17Gdrv+xWa5AR4a+ngHyJgLuuuQU0hZYH5tDS1mUZXkITk6i5tOUUyGrMGeZB/8CYqMyWsbmqkP4gxeOhYiFIKr5H//9ICdymoaYGbHOqhE8XJAZW54sKkLlmqZgSJrigsU4h9ybk/cFAAmDxaeJSJxvFCaz9lhvNEoGvenz7yXH8az3UtpU/jvmlt+Bq8Isu74IvoR0UsvbdPLIN2MKACNjVWCMgXanH1RD+1SxsiqO1/alRD0paUtzDJGjvoF744SxcUmFbpt7YqZFHxSKz6t5UXiU8gUa8PTwR0etV5vRPsNEru6ql0yHqBH+oUSLsJoU3UDogRYTWR2Ex5rXmBfYq7CxU+dZpV/3nuRZjiB5XufDvdTTX4t17fBR6ZXjsNxBdKtFEYsSF5ThSSsLvaZ6Mg8HlsfuVH2MCwv+ikqCRYsiNfLnTiFthByzzrx5vE1HEU9H0DqheTdnL7Yi0wfc21M8A565OEFmiNghov+dpzEMix1uxuIdg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(42112799006)(82310400026)(36860700016)(1800799024)(376014)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cA/e9VbNFn93mLQ7NeAd42KydGvMnD9G77FDYt1wsRFrih43q+KTToQi8xGe48zGOUt3RAsMEGX79merlHXHSDW1W/EQ8Dq+Nm5eE8dh4/K0WRNkS0Me3UEzF9Tf0ea661lqYYARUh7GlsiuMuS3RpfgkhacODGGL4AlbRkPjhk4Iknb1S2G/G7h8awCO0MokM1OpKg5bkkPHlPefA+U3uOgq0Vaqd3A+gqdPQLGyMPdrvPMiIIpBEcxf18qLUtRBGEYEE4ZE8oXS+HlmRR/3L8Hj2zo7QTmmS5Kv0F9SFfHrBdWmKxA3n9F5UsJO5VAq8DrKQ0oxDwguIa3EEOao3XOOzBtDVbTJP19OaEvssJNB8zSl7nZg1oR1xyj9cZtwS7zChUPQvNz8v+ZTDWY+Xkq9VGRellD+hTXvlKQLZ3Gj/EtlPX6cZy4BCNABNo1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 16:11:57.9476 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e54856a-77df-433f-96e4-08df2ec4ddd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF0000005C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6906
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
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 2026-10-20 09:08, Maxime Ripard wrote:
> Hi Leo,
> 
> Thanks for reviewing this

Hi Maxime,
 
Thanks for cleaning up all the drivers, are these all part of the
DRM_MODE_ATOMIC_RESET effort?

> 
> On Mon, Oct 19, 2026 at 12:38:47PM -0400, Leo Li wrote:
>>> @@ -736,11 +736,11 @@ dm_dp_add_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
>>>  
>>>  	/*
>>>  	 * Initialize connector state before adding the connectror to drm and
>>>  	 * framebuffer lists
>>>  	 */
>>> -	amdgpu_dm_connector_funcs_reset(connector);
>>
>> I'm actually not sure why there was a state reset here.
>> amdgpu_dm_connector_init_helper() is called earlier in this func and
>> that already did a reset.
> 
> Yeah, it's something sashiko flagged too and I removed that call (and
> updated the comment).
> 
>>> +	connector->state = amdgpu_dm_connector_atomic_create_state(connector);
>>
>> That asside, looks like this can overwrite the alloc'd state from
>> init_helper() without freeing. So to keep the previous behavior and
>> avoid regressing, perhaps we can do this:
>>
>> 	conn_state = amdgpu_dm_connector_atomic_create_state(connector);
>> 	if (!IS_ERR(conn_state)) {
>> 		if (connector->state)
>> 			connector->funcs->atomic_destroy_state(connector, connector->state);
>> 		connector->state = conn_state;
>> 	}
> 
> If we are to handle errors properly and remain equivalent, then
> something like the following would be more accurate I guess?
> 
> if (connector->state) {
>     connector->funcs->atomic_destroy_state(connector, connector->state);
>     connector->state = NULL;
> }
> 
> conn_state = amdgpu_dm_connector_atomic_create_state(connector);
> if (IS_ERR(conn_state))
>     return NULL;
> 
> connector->state = conn_state;
> 
> Would you prefer that, or should I remove the call to create_state
> entirely because it's redundant?

My preference would be to copy existing behavior, and keep the scope of this
series to just dropping the reset hook. Dropping the redundant create_state and
handling associated testing/regressions can be a followup.

In my parsing of the old reset behavior, we don't return a NULL connector on
error. Rather, we keep the existing connector->state and return the connector as
is. The rest of reset() only runs if state was alloc'd successfully. My previous
snippet should copy this.

Thanks,
Leo
 
> 
>>>  	/*
>>>  	 * Some of the properties below require access to state, like bpc.
>>>  	 * Allocate some default initial connector state with our reset helper.
>>>  	 */
>>> -	if (wbcon->base.base.funcs->reset)
>>> -		wbcon->base.base.funcs->reset(&wbcon->base.base);
>>> +	if (!wbcon->base.base.state &&
>>> +	    wbcon->base.base.funcs->atomic_create_state) {
>>> +		struct drm_connector_state *conn_state;
>>> +
>>> +		conn_state = amdgpu_dm_connector_atomic_create_state(&wbcon->base.base);
>>
>> Nit: functionally the same, but would
>> `wbcon->base.base.funcs->atomic_create_state(&wbcon->base.base);` be
>> clearer?
> 
> Totally, I'll fix it
> Thanks!
> Maxime

