Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591C2606A31C
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 02:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1be07Oks
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D8DF10E913;
	Sat, 31 Oct 2026 02:05:16 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010018.outbound.protection.outlook.com [52.101.56.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B98C210E912;
 Sat, 31 Oct 2026 02:05:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=deWcCfQ4Eo5wW/9KjGituej6OArk4AV57LXPHVk/YaWjiUZ3Ll7TEUoBIblcsELP8Z8P3x09tK7P7qLsBrOE5fyYNyv3VFmDo5l9w4YuLFi4tf3vs+mu+tQ8ZXV5ku5d/xIWInhoFguzLtFld6kbgiCGHKdXoRq1lJRDBo+jrvumNExCVJR97R7G4fRLEfpsnevXObMbd6gVpp1jCv/g5cpD0MJWLWE1UTw7KqTh+f1hRKSOVU+Ts8CHjQ3g41p/3TBPJD72PRnTGQtnl24LfR6BmSKKCLmqgpwpPzvjLWUMhU+49Hja9I7flbZ7ghjqOui+t9dnhC6suWLVOWxkAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAbETY7WwUydOq3W8oCkCrG8WtR7cxZ9ghCAtcoTR+Y=;
 b=gLHbV2zv6/8NRqkZqUKkUSGVBtkQUI7WvPDNf/+EuIuwb4DOuW6KNTOvNd+5aT772Kia8HKgnaTcuprz9nvpMpSwhOc4X1rb6FaPvwbiNJJD9U0Mt7BhZwy9kZX2tIo0E0dRJMjsvA+SNeGZikdwSC+DBxV/F3kw4QDqyspTt3MlqqtGippt6ITgWnAs1ZyYzYkO4/BkpEeuFMwB5T2cMGAsBlRM97E9eyYgECR99MAIAiVh094f9wGvDXwJNp49Rnf3TP934mxBzrW4OlgRye5MBR6CWyLZprTE7TJPp7E35swUXjSx1gSaQhv4Rn82uSLyoQoVvSsLTRa3I+FahA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAbETY7WwUydOq3W8oCkCrG8WtR7cxZ9ghCAtcoTR+Y=;
 b=1be07Oks9xkSqYV79PnsuLAyYaiXwhyi6d63aRlQNxMJ3TPfT2N3rcKdP+HwdmCc7qLKesVc1ktQAU6jq3lLlBTixX6FnkS7sNOm/yCt0jhl/2jW1cFromVHOYoBWvIYCytCZH1s3Jxyfn09t8hc9+HAiXRZoF95ev+tmi3w3u0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY0PR12MB226969.namprd12.prod.outlook.com
 (2603:10b6:930:130::18) by DS7PR12MB8323.namprd12.prod.outlook.com
 (2603:10b6:8:da::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Sat, 31 Oct
 2026 02:03:03 +0000
Received: from CY0PR12MB226969.namprd12.prod.outlook.com
 ([fe80::f47a:5d4e:f3d5:5b26]) by CY0PR12MB226969.namprd12.prod.outlook.com
 ([fe80::f47a:5d4e:f3d5:5b26%4]) with mapi id 15.21.0569.009; Sat, 31 Oct 2026
 02:03:02 +0000
Message-ID: <779d9314-7aaa-46c8-b4a3-8c7771a5e6d0@amd.com>
Date: Fri, 30 Oct 2026 20:03:01 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] drm/amd/display: Fix assorted test failures
To: John Harrison <John.Harrison@Igalia.com>, amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com
References: <20261023001139.2374085-1-John.Harrison@Igalia.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20261023001139.2374085-1-John.Harrison@Igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0175.namprd04.prod.outlook.com
 (2603:10b6:303:85::30) To CY0PR12MB226969.namprd12.prod.outlook.com
 (2603:10b6:930:130::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY0PR12MB226969:EE_|DS7PR12MB8323:EE_
X-MS-Office365-Filtering-Correlation-Id: 61691d2e-5b5e-4e2f-d4d2-08df36f3187e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|10067099003|22082099003|18002099003|56012099006|11063799006|261021123027099003|261021121427099003|261026121527099003|261028144727099003|261022105027099003|261009223027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: eIBhFuoT40haRXMrhT+wyv3L9Va76eARQEb9cef1+EpSQe/wHQTraFDB1hclVEQTvp/k6M6JTQw+Ki+Xyz+QgPjpFjqNIJM0agsnAd06nj+caAxMXO9SMrWdJqg5JOFoAzo0Yx/biotFQ89ssNUZyb/SXivavptc7UY0Yy7P3Afbvq80KUYPr2OktG3AhYVkUu7agBmxbdRMGfk04+/Pci8/eWtAP/xjLREUPAuFcfAa9A6lyNVfCv/KXNLLI40iZ9hHQoPA6NdX2UyiPUe3csaVxVElm/tpOdSn3ZCq3e1V1iGbXLTwZtfkotjfEoGo5LhEBjN/lXlm9d+tPZdMtSBPcgESvr4wXXxJcrS2MiYGicAXdVlBypsU0e83s8E0ltz+/3MaPCvkjV54kimwAbdv76bbe5bH5TePgaF+eMrMkVjpzMeGhhsgpPSoWkD+eXlDt311rhlDywmlmhkVHFjBZfTxCVqHYa2elhOecif7+QNZ8VDk0ldcSgSZjgM4WmVgf36YF3n7BnUd9L1ClwU4bK1lz9NlXNHDXoAC7l1z0lJBPrargzL7dFbWLLoIwKk5yN5Um/aoC7/3UHG1v5ymbSXqXHzn9BDQIANMX0hkQ8M6hzGTqG1yuGNd5Wv/qxBDUB7fXQxUVdB1WmlOSbP/vCYuyNfSB7CHlmOMpTA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY0PR12MB226969.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(261021123027099003)(261021121427099003)(261026121527099003)(261028144727099003)(261022105027099003)(261009223027099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?andBRXZhdjQvVEFJUjJLN1BKcm5wNXRWK3VHbEhxN0RwUXhSUjluSGEva055?=
 =?utf-8?B?TVdMTVlzelZ5S3FRL2Q3TXhweUFudjZYL2N3VkRaOGtuQjlUTWZPZzZEYk5x?=
 =?utf-8?B?a3o4RWNHcVhKTHZFRWpSR05sOXBwNE9CZ3Y4R2lIb3NOeHRabXZTUUNEU3Mw?=
 =?utf-8?B?UkcwT2czS043aHYvNS9wTDZlMnh2cmdFd01ySFlkbktyYStNKzhtREFXNTIz?=
 =?utf-8?B?bW1QTVY0M2lDaTBkczB4NS9ORUs0RDFqa2p2aU1wMWhZendpQ3BmRVdHYWNn?=
 =?utf-8?B?cnpkbVFNRHpydm9BQXQ3aDlMNEhvTUdTSjZVaTlBUlpMeHFScVluaWZUb0JV?=
 =?utf-8?B?TWhuVElSaEVON3RMSlBEb3RCS3hWenBaV0pFRlYxUWJrVGsyUFR3MlBxRFp2?=
 =?utf-8?B?SDJ0Rmo4b0pabUtIczgvOTVRTndwK3R4eWV1blovNythRGJuZVZ3WENQT0h2?=
 =?utf-8?B?L21iSVh6TnRLcEdpSGJQZURoQ2g4Q2RiQlFCMXE0VFZESXFJVVdVTitlcHJa?=
 =?utf-8?B?N2E3VzY3cUpHaitHTGxRa2JvTUNUVUtnV1ZSY1EwK2ZXMkR5TUFqUk42bFZy?=
 =?utf-8?B?ajYvZE13VHNBUXR5QTVoRU83S1Z4VVNqQUcvOGtwRUprUElRVWZkZmw1aWp2?=
 =?utf-8?B?TUI5MHkzQUdsaXVNeUpLWGk1SzQvMkZyZXlxVmJKSEh0NXJjOVMwcDUwMFJC?=
 =?utf-8?B?alRaR3AxWTRJMVlkTWJycG03dklVNjNpemIxcC9BR3pjdHdtNjRhODN1NG54?=
 =?utf-8?B?bktST3NHMytxek5ERjhaSjVtZTR3aVptNmJvclBPSmw0ZWlUWGsrUzZOTGpU?=
 =?utf-8?B?MEpybGZ4dG0xZnFBT0JET29YU3BBeGFIYTltc1Z5MEF1T3NmbEJnNjRiTktD?=
 =?utf-8?B?d094eXJEVUs3UUJTeEUzRld3ODVmU3JOSDdtZGlROFduT1JGYkJsNXRIVjlr?=
 =?utf-8?B?TEV6T2FqUXZYakF1TnJWRmVOS01kdjc3d2JrcmFGaXB3NGMyV29tc0dGR2RD?=
 =?utf-8?B?OGVxNldHdnAvQk5sd1BEY1lDeS90T0ZaM2NXNm00ejlHOGprMW5LWVJjYmEw?=
 =?utf-8?B?V3M0VHEwcUxLYTdCWDZkbmI2R2RxZm9KbWZRYjJxYlg1cEhqM3lZSXdaU2pC?=
 =?utf-8?B?dG1EalBOQTRPeEJ5QURvTnRmcGpRZHVxRXkxK1pGYkhWS0dRa2tJMmExNktt?=
 =?utf-8?B?Z2VYNzhZdVI0dnFHdkhWS3dBbjhpbmlsOXZaRXdWL3poQStyNlV4Z0lYckRO?=
 =?utf-8?B?YVNVaS9FVlN5cHlMZFU5NHBsb1YzWmc0WG55MFJzcEJLZEUrbENVYTRhaEkw?=
 =?utf-8?B?SzRaTGkxUXdaU09ta2U4TGZvbjRybkhTVVQ4ZEx4cURKU2tKdElYQ0gxTmhG?=
 =?utf-8?B?alhuSmJRckRnUXQyVkR0c2krdExkL1ovcXZaVCszY3lOUVdYcmR3WldNTFVB?=
 =?utf-8?B?OUtGY1NhQXhpOTY0RWU5K2tlL21jTjZnOFRMSzkxR0xwbGFYQ0VyelUza0Ev?=
 =?utf-8?B?cjc0U1l2UURiaFpBUjB4N0ZJamJBcUVLemJiNGJOdUw3Vlpnako2cTM1YmZF?=
 =?utf-8?B?d29DeFRhZ2NRZVhpV1NPZlBGUC9WNEVoQlA2d3FIeFdkenNsVU85YnZUbnd5?=
 =?utf-8?B?UVVPM0JrNjhwOXRwVkFkU3BSbFVwZE9DUjRFSDBmS1F3WXRBaDFxSUtQZTcx?=
 =?utf-8?B?bWdXeWN2U1RDazc5bklnK2pRYnE0UHNKV1hGSCtwaEV0RTV5dkMveDlKeVB4?=
 =?utf-8?B?SXJrNW9EMzRCWUlPbHJReU5QYVlRVW9mOXdtMk1YUjRiejRLa29QcVhwdjRn?=
 =?utf-8?B?UzJhdzF3UUpNNWNNbHdVamZNaHlXMnV6UG9HT0pqYVFSTTdZaDdMS3dhaFk3?=
 =?utf-8?B?VmFRNUx2QnFRd0R3WkQ1UFozMWNTSFdPMTZLVHNNZTBrYTJ2ODhrK2RXTklY?=
 =?utf-8?B?VjVDT29lZkQyUHQyL2dQYUN1ejVvQWp6bDBjbjBtMWlIVWVEbzhmYTA0aUVG?=
 =?utf-8?B?by8yblE0cFdkd3J3czk4bDIvYUVRNUdRSFQrY0JERGdwemJ2QSs3UWs0SFpV?=
 =?utf-8?B?KzhXSGVKK2E4V2cwTk9jTWRxYmVxRDA0Uk9IeVJiK2NON0NtWkxrczVYYzRH?=
 =?utf-8?B?akQyemQzSmxRSXBxbVRkemo1WG5TTVllUVZJN3VtODc0NTBFR1BSU2VRTTk3?=
 =?utf-8?B?VmJrbSt0aHE4OGkzZy9UWVlOSGhUdDFldUdCd0NPS1FJb21nYktkWU1Pa0Fk?=
 =?utf-8?B?SWZMZlY2SmNCSXJGQXFYS3lUNUV4QzZjbUNYZXcyZW9vQW1XMlBIQUtvTXRy?=
 =?utf-8?Q?Dq2IUApNOG/iipEB0C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61691d2e-5b5e-4e2f-d4d2-08df36f3187e
X-MS-Exchange-CrossTenant-AuthSource: CY0PR12MB226969.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2026 02:03:02.6433 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jQuiSsR40H9fOwjQXCAeHjRYp6+cQfMWNP0cg6IdcHj0kuxJcJpM8ww4/B1PWIVQPzanFGchDAl7CUYonynhrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8323
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

The series is

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 10/22/26 18:11, John Harrison wrote:
> Running the KUNIT tests with KASAN enabled hits a bunch of
> use-after-free errors.
> 
> Note that the following tests are still failing for me. They are
> EXPECTATION failures though, rather than memory splats. So, the test
> run does at least complete now.
>    dm_test_crtc_reset_state_replaces_existing
>    dm_test_detect_hides_secondary_tile
>    dm_test_fs_caps_dp_msa_not_allowed
>    dm_test_update_plane_color_mgmt_colorop_shaper
>    dm_test_update_plane_color_mgmt_colorop_3dlut
>    dm_test_update_plane_color_mgmt_colorop_blend
> 
> v2: Drop FIXED_MATRIX fixes for now because Sashiko is checking
> against a tree that does not contain the base patches. Rework some
> use-after-free fixes to not leak memory (despite kmemleak claiming no
> leaks).
> 
> Signed-off-by: John Harrison <John.Harrison@Igalia.com>
> 
> John Harrison (2):
>    drm/amd/display: Fix some memory lifetime issues in KUnit tests
>    drm/amd/display: Fix use-after-free in
>      dm_test_hpd_rx_offload_work_msg_rdy
> 
>   .../display/amdgpu_dm/tests/amdgpu_dm_connector_test.c    | 2 +-
>   .../drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c  | 8 +++++++-
>   .../display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c    | 7 +++++--
>   .../drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c   | 7 ++++---
>   4 files changed, 17 insertions(+), 7 deletions(-)
> 

