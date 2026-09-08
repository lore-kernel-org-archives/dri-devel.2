Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6A3C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 19:36:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBE0910E188;
	Tue,  8 Sep 2026 19:36:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oO97p0br";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012050.outbound.protection.outlook.com [40.107.209.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3490F10E165;
 Tue,  8 Sep 2026 19:36:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxuLpigCwQEUtGEj/E67AmDUgGXz3WIYXKmHmQaHRt9Iy8fIZTvhnT+7uVSCvUYiSz1sYgWpOniB5Wsj5QFWdUK38KU+TtPFyHGuGekep7SKrAadGO1MEmxhDs2dZERsDltS/0+M8Uzr1yJUgpiG1bUfqE3KKK+OEv5Iu+NBOQCYbBYlzBHMfFlCnOR9ehL1EpnYrtZ/hV+QaBCJQbSnXJMjp5rHbzyc5BuPZ6U5V3wztxD56ErQqRJeb4RiZinvQL0Z9WtegbO9//rZ+64kt/mXldNdwWQc0JK48ndCYeS/ttpjpdJraIocPTZty3/XXyvUzouk+DMus6Tm1YMcgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YwjCRdBldOjnZbX82/bhrZGXEzwCiuwHXAc7mUYGVFM=;
 b=f4iqSh9Ecw/mJdDUMi6jxlgloqSkw+ZwtlhllWoIOojLa4FdDjDXWFi0B6fpIy8vgb7N6MnKDkZ74JSA9neiLG4DtCsaoAt7Gghy60GGvzSgSngeStnkJBo7zm15QPpHzms8hCxStz6nSzr05edBapIEztmBZs6MHaRc0X2S+FRSF70Z1zQFUBydSCQ1MkyyFZh9PKNyJbI2TEDAm8eSNEYsmhGDHl0J2CRw+R5/rAxtimK3A7x96ZansnM0lWJAFOmz/b0srv8iJdR3sSH8iVUxVMEfVEaXk72VQLSfAC0x66Mz/tqkFpFw1ijLrg9CIWcYjq4ZqkRdQRrT+Xff8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwjCRdBldOjnZbX82/bhrZGXEzwCiuwHXAc7mUYGVFM=;
 b=oO97p0brlvHs5DPeteskgWbbbbhdJeDw3uTCBQGFfyKCTHZBLnKY3YJw8NwxcKI76l9e771QHbWwjco/r4ZUlxS5ghm3iJZAuBu9VViZ8hIVZd8qrjhi8a7mRfMq7JRQ6/edSnGa0UYsS9EIfHGa8iG2KFaCeLa4BIbd/W+4Evc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by SA1PR12MB8947.namprd12.prod.outlook.com (2603:10b6:806:386::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 19:36:17 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%3]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 19:36:16 +0000
Message-ID: <0e0dec3b-df41-4e9d-b975-57ff9a3ee856@amd.com>
Date: Tue, 8 Sep 2026 13:36:14 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] drm/amd/display: Fix HDMI RGB quantization updates
To: Satyajit Roy <edu042sjroy@proton.me>, amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, jerry.zuo@amd.com, wayne.lin@amd.com, yan.li@amd.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Satyajit Roy <sroy14@alum.utk.edu>
References: <20260830035120.937992-1-edu042sjroy@proton.me>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260830035120.937992-1-edu042sjroy@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0153.namprd03.prod.outlook.com
 (2603:10b6:303:8d::8) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|SA1PR12MB8947:EE_
X-MS-Office365-Filtering-Correlation-Id: a48b6258-04c1-47ff-8db5-08df0de0732a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|6133799003|18002099003|22082099003|3023799007|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: NeWH2+hj5uwfIqKLtxN5OnSvQjOqBexnesm+p5emU31ZGJkIdb29EmPeHe2iO/iSbTzT6ThTSiBIOK479wChPXigg2OtET5TH0bjjGxMev1MyQWJz+gcC4Q4F4zxAiJ6bymfVVzLDpe0qwhJh+UoPXuGYXctU6yoWIJXfUYboV7gWC/AOnBYxnC1ik4hsujgVAXQWA+Zj1aNQWgwtwwEpU8l8DuaOJJEjU7Arc2sPqTKkQyOvS/mTwqNhKXF7tfvjHSyL9Ml1QPsehXolx+T8j9JoO/rhXUCWkf4IfbMuhWOwLzWsmpfBM3uwNZchUDW6Klfdg56sn842BdumTSxsjQ8Xf6W9cTosaFzX3WxzLxsxmkLhrkx4Fatwc8BTxhsHl2g64j6qO92a1tR3GE/ZHBwEcpBdAyQJgEqdrcVAjA70/pnmr612SKzuCC8kWNZOX0DHMCq4HFF9b+SfFCQ+UmC1WM/MnhPkDMCXPP1SpW1/OZoyBKpC/jWNkf2sMTGKYfpf7FU6gh4Ee96FniVMTNP2E8w+nXPCTaWHbXOgtktySbJxhcCnMwb9XiaCXtISA6T9rEHjF2Xi8E4OJm6uKZTcj+WgQ9jYtDueG8+29JrLN2lZg2etWYSmMXWTFl9dSbhhJvTocPExWOKjbIijSe2F6h788hoTjZdl4vbjvM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkJBWjJiYVJtMzRJeFVpSThYUFNRblV1Y1diL2VVdGFndVBLRmFSaHNwSTFi?=
 =?utf-8?B?cURoVjN6MVJRS2JoRW5ycmlGNW02RjBmUUM3bm5YVGJJOS9NSnlFTEZZc2py?=
 =?utf-8?B?blhhb3NmNjlRczlVMnJhbld2V1JTbmtTYzYxQzFXQ0d3RVBBRWkweld2VXk1?=
 =?utf-8?B?VlR2MVR3ZmRaejV6RjRPVWdIWnZUc25VZzlSNEIxcVRaampGekhlU1hUYXJh?=
 =?utf-8?B?UXlMZm42K25NWkVGdHVuYjVyR09YQTRWTXJwSnVBY0pTQnB5Vi9LMlVBQjFQ?=
 =?utf-8?B?K1k2Z0o4NzgydVRWSFhaOWJyUlowcHlIa2tHQWc5ZGVZZmIvdy9FcUZtVXhi?=
 =?utf-8?B?VDBXQy9ieHRZc2I3bTNCcyt5N2hmSitLYjd2a1FxQ2IzLzNiNjRuVXkva1ZQ?=
 =?utf-8?B?aW1qVEI0SkNhb2VadW01bWlsMzNYdC9RUzhTeWU2ZjBGZzBtanVtdjMvelkx?=
 =?utf-8?B?YlBKWVF5VUtVTjd5bENvTWllR0FadU1kblc5R0Y0QzRiVjRsRkV5Vjc1Z3Mw?=
 =?utf-8?B?TGswSW44WEpJYS9vOTUxaEUrSEhxRlorbndubkZLei9wcFAvb2g4eU1XZG1W?=
 =?utf-8?B?OEtJQk5ObFkxUGJoL3hFWVRqblJ2b2puT3gzVFZ1bnRMNHhnQTNTQXdKeU9t?=
 =?utf-8?B?bmc5RGQ1M2FNNXVOWXpBQXN0Uzh4ZlF4cHRTbzZBSWFDUEhkNGdxTC9Hcks2?=
 =?utf-8?B?cUpLZ1A2TkNHRU43SkRsYXJSVWVtcFdWdEZWNTRiSVF5dXRxYTVPYXdDREsw?=
 =?utf-8?B?UmZROXVpUURPaXlZcGV0OTFiRFFnbDQ3VWlLM3Q2WXBsS3h4MDRlVlVtb2RN?=
 =?utf-8?B?cTh2TXZ0TEpUNHV0Wm1MOC9rR25zWENCSDl2V01kVjJDSEMzbytpNHBsbk92?=
 =?utf-8?B?cEtpK0MrRGEyUlZVUmEwSHBlOXJUWHhweCtubzR3SjJCdnBEa1oyRDJhVGRF?=
 =?utf-8?B?SUxxTkRMNk1PLyt3anRRUTN0N3pJVE8vM21CYkcxdFVKcXZGdGpTSGgvdG9Y?=
 =?utf-8?B?SDBFcXlSdDg0Qzc1TjdpcTFnQ2ZpMDdpV0NFOTRpSXN1S3FFVDZsMlByZGJh?=
 =?utf-8?B?WHI3NDlQcDZBOVFTZ28ydGF3S0dqNjFjTFZQaXo3b3NYMTNNQWFQV25adG5S?=
 =?utf-8?B?MGZzaVYvSnBldVBsb2NhcXdXVW9RK3g0MG9WNVBKTldTSHY4SytFRUFlMGxL?=
 =?utf-8?B?NmJ6R1hRdkJhUnYxWUg2eGZYeDZGRDBwUGZybmRWR3dKeGNQOE00TTkveUhu?=
 =?utf-8?B?QmZqQnJZWHFMaFBhY25kb0U0QmV6OEh2Q2tnc0ZyRFRlWTlTSGR4d2dXWnZo?=
 =?utf-8?B?S3N2QmtvNHNBTjVGckxweDhvaW5Ecnk3ZVF1NTBlazBCR1J6d0I0S1FkZzB0?=
 =?utf-8?B?Vm5lTlJvNnpmZEFnT3NqeFQxb05zT2tCd0FheWc5Zy9OWUo2MGVpbDFlT05v?=
 =?utf-8?B?d2JWZ0NZa2loTFRvemNGL3ZKZlhlUG1OczNDeDdXb1dYRXVBV0xybm5paWtp?=
 =?utf-8?B?WFpTQjdZQ1doU3lYelpkK01ESWhadUVRb1lmUE5XWGQ2Y3MwdnRuSmxKeUpq?=
 =?utf-8?B?Z0djMGthdFpJa1h4b3JJeVl4RFVCeVJhVERDVnlXWGE5eWh2czNFN2VwcHdO?=
 =?utf-8?B?WlExcUw0UjdiZ3Mzc0dxcU5EQ1AyU3kvZ1Q5U1dVZDdUZVBnSldLcHdSU2Yy?=
 =?utf-8?B?eXlhcXk3ZUhla2JNc0NyU0QwSTdVcFk1dWdJUVBFdDUxVTBxSmZ5V1RtMnZs?=
 =?utf-8?B?UXJaYllkb25JV2U0bnZoWVdwWCs0Rm8yZEEyTW9CY2N3T3dqSmsxS2ZYWUph?=
 =?utf-8?B?UGl2UGthRnhSTDBDTVZuR0I0Z1dzRGFKdy81aFVTcVZ4S2h0ck5KTVk1djRU?=
 =?utf-8?B?WGd3M3crN292dDI4aC9BbHZzMzZkSmtoYTBPNDZIT0MzVi9oY3BOTGppS016?=
 =?utf-8?B?QU01OExOUVRRYXR4K3RTdUJhWmtHR2ppb1VDM2tZYUlHOEIzSTBNdVNBbWg5?=
 =?utf-8?B?d3V0Z2pkRG9NM0pjNnFyNzVBUTJkeUh0dXp5SmhLWWpxZ05ZUkkwcmM0MkdN?=
 =?utf-8?B?QXVxbzFLWkxqZm9DdktjbnRGVWpPMXk2b1Zkejc3VWdvU1pJVzAxOWVUKzFt?=
 =?utf-8?B?NmcxQk5MVzdJc2VBTDhvUzlkOXRmcHNiL0J0WlFFOWFHQlk0b2szMUJYaWE1?=
 =?utf-8?B?a2hIc2dBS1BOZzB6UFhXcmpQeWV5Z0FMdDNuekMyeENqRmp3MzRzemVUSnZ4?=
 =?utf-8?B?SnVYSkJrT2swWlkxQVNyeXhIQkJ2VWt5MTVTbGExOTd6L2FtUWQ4bHhUVHZD?=
 =?utf-8?Q?mkZURcCvLIvRdojknz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a48b6258-04c1-47ff-8db5-08df0de0732a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 19:36:16.7902 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RY65mHP2YkEJQ/tXdvF0OdG6hTCjm/H/N/dRIgkHb0L8LQObe4b7s+LnuWAAJcYYggmUzHkxAOagd3OMxSrcAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8947
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

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 8/29/26 21:51, Satyajit Roy wrote:
> [Some people who received this message don't often get email from edu042sjroy@proton.me. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> From: Satyajit Roy <sroy14@alum.utk.edu>
> 
> The Broadcast RGB implementation currently has three gaps in the AMD
> Display path:
> 
>    1. DM does not propagate the sink's RGB quantization-range
>       selectability into DC, so the HDMI AVI InfoFrame Q field remains at
>       its default value.
>    2. BT.2020 RGB output is always selected as full range, so an explicit
>       Limited setting has no effect in HDR modes using BT.2020 RGB.
>    3. A property-only range transition updates the output CSC but does not
>       rebuild and program the InfoFrame, leaving the sink with stale range
>       signaling.
> 
> Together these can make the transmitted pixel range and the range inferred
> by a television's automatic black-level setting disagree.
> 
> Patch 1 propagates the EDID QS capability. Patch 2 honors Limited for
> BT.2020 RGB and adds KUnit coverage for both BT.2020 connector colorspace
> values. Patch 3 rebuilds InfoFrames whenever output_color_space changes.
> 
> Validation performed on amd-staging-drm-next at the base commit below:
> 
>    - scripts/checkpatch.pl --strict: no errors, warnings, or checks
>    - x86_64 AMD Display KUnit configuration built with CONFIG_WERROR=y
>    - new EDID-capability and BT.2020 quantization KUnit cases compiled
> 
> Equivalent changes were also tested on an HDMI 2.1 television with a
> Valve Linux 7.2 kernel. The television's automatic black-level selection
> followed Full-to-Limited and Limited-to-Full transitions in SDR, HDR, and
> HDR with VRR active. No modeset or visible link blank was observed.
> 
> Satyajit Roy (3):
>    drm/amd/display: Propagate HDMI RGB quantization selectability
>    drm/amd/display: Honor Broadcast RGB for BT.2020 RGB output
>    drm/amd/display: Rebuild InfoFrames on output color space changes
> 
>   .../display/amdgpu_dm/amdgpu_dm_connector.c   | 10 +++--
>   .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  1 +
>   .../tests/amdgpu_dm_connector_test.c          | 37 +++++++++++++++++++
>   .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c  |  2 +
>   drivers/gpu/drm/amd/display/dc/core/dc.c      |  3 ++
>   5 files changed, 50 insertions(+), 3 deletions(-)
> 
> 
> base-commit: 75a5e1b6b3661c3f946885d01eebeb6b031035ef
> --
> 2.51.1

