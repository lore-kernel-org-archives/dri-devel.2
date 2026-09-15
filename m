Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64286C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:48:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EAA810F9FA;
	Tue, 15 Sep 2026 15:48:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n8wB17Rf";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011032.outbound.protection.outlook.com [40.107.208.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38C0C10F739;
 Tue, 15 Sep 2026 15:48:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y985C9XPtdPTlTydtJWsdlXLSiZ2iPnGPBAVIkJf1XVhY+Yhj8iBm4pFo7IdJUmbglJYrad/3cu4pgJrd6MWNMlkcUoJjwIy6COWDXrV1PgJ5Rj+a9RYr82BsRlEvcSANJKtzP1k8E3PyZZCRgJ7FOh0I4jUwWklCTxjYhfx1CqavKTglstZqT5Y9hyEpDIhMFvrdXw2RlIaznxwjyejihj9N65rfvzwDxuvpjq1nsShKIj3EVM6qkcG4Z/yBhZaqCuOBchkQ7TV42ryv8jUU4rsgcyM3IDcX4sbfNqvQRb7QxVfRUk236WS6bKrVGyoQBBkEk1QXxo82ITX/KFJrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKLE6nMyJPKT3ilAmMgoGsVzoZuvUnX/s/U/hNvWUZE=;
 b=jQ++cOCV+Bq00UaJHw5b4skxXeqQXBkBHpocvsm6Ns+Ji5bld4s/HHD1RaIbPn/GlJtmUvMISA98QWYi0eFpfisZh2gtipc/V3rzHwai/JObMmKlc7UXLelxXgUScciXsz7svRzggX3XjLqiorCk8TeFb/jTiODj+FlJBqP7XfSzcYEcW5D9C/HLv/PoOvrHUC6mssbXlZcn0Wj+mYwiyO33bWsS6iZpKl1f6XoI3LZ63wgj/q0lE7F1zxZ/fsWKUtZovW6HH1v5cI+/CdkXkKOPDXV44CzgZvqQS+CXdRBbgz2V1R31AXM1qhrBpF+8CejdU7t/oVNimBgGczG0Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKLE6nMyJPKT3ilAmMgoGsVzoZuvUnX/s/U/hNvWUZE=;
 b=n8wB17Rft7G2FGwtHPJ3f37nrUWDcV8yOE2IV5lswq1JlCKKS2/AMZM2QOFPPYXzmVfhZ4pznIH8Istg43cJUi6PU0TAp4NSsKVRgYKdV3ezEfF0zFNP57dNsOHjU4bmBDyb4BSo8t0m5JnLB78ZSoVnQL6EbVi1y+bno4Bcej4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by CY5PR12MB6105.namprd12.prod.outlook.com (2603:10b6:930:2a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 15:46:51 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 15:46:51 +0000
Message-ID: <ac0efba8-3c39-4b18-9fee-da2b0e09480d@amd.com>
Date: Tue, 15 Sep 2026 10:46:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/display: invalidate DP CEC state on s3 suspend
Content-Language: en-US
To: Dan Himebauch <danielhimebauch@gmail.com>, Alex Hung <alex.hung@amd.com>
Cc: amd-gfx@lists.freedesktop.org, harry.wentland@amd.com,
 sunpeng.li@amd.com, siqueira@igalia.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 bhawanpreet.lakha@amd.com, wayne.lin@amd.com, george.zhang@amd.com,
 jerry.zuo@amd.com, chen-yu.chen@amd.com, ivan.lipski@amd.com,
 evg28bur@yandex.ru, Kun.Liu2@amd.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <CAJxfpZ+AzJnBCw-jP5_E8FH_+cpCE68FCtf_tsi9pt7q=P2Dsw@mail.gmail.com>
 <20195022-cf18-45cd-829e-b2866e7a3080@amd.com>
 <CAJxfpZJDvFuz40a-euL0jRkPBR82M8Y5NxBrpABeP+EZScFxGw@mail.gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJxfpZJDvFuz40a-euL0jRkPBR82M8Y5NxBrpABeP+EZScFxGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR05CA0055.namprd05.prod.outlook.com
 (2603:10b6:208:236::24) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|CY5PR12MB6105:EE_
X-MS-Office365-Filtering-Correlation-Id: 65d977e6-6f3b-4eec-9ea2-08df13408eec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|18002099003|22082099003|4143699003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: jzcfkSsCwvGHLUfYS2UD+zVC7/+BV0zA+kJXl2zjPnBFsqkVBXPwE/vHoWNFr0rjD2BR4koYHZCXtbg+cfN3LJTRQYRKvLmkLgmB7Cb5jTJdDlikg69rnuM/AdGJZ2BY/ozG5EQGyKJS4tXdKtpK4NKQEtq1E9F87yFp3a4b6tvPgraG/yC01HFmUq3YxhpbY/DCA6J49BqvtGOMC4qZ7KcJqipUkFzZftIfSsQD2NY/2c87Yt5JS1wsNohGK3R5ixuvN91VgTXkFq2cnJ0UjYsUiYDkSox4VxaV0lb2xeEM8DsMprGejFdWc2PUqH2A0dk8eU5iyJHTbhSNjKavOCex2b7qTjZElyFCpvbawx62HtsGnynFQDEFfoeyA4nX1G+kELwco8LEPlZwM87hIrsX7h8nn/69k+kTqfbQDAh5OrPlPW/j/Qcfz8rehDfhXihGXaSmrBtwOBxZDDfGWrmsh2fIcMvVwh+OD36lNuOCnRf6tmXjc56FLsqkrxmX/lVZVDUd5C7rJxHkwWl3Sxvw3H3vvc8pd8Il7h6SfX6AHfaX0YYONInzeadQrivVSV4kou1ECfBT6Kyo3nWvviwiFw2ObLX7f5U2JGXhsWo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(18002099003)(22082099003)(4143699003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEZ4YnNXWFcwdkVMQzVJTC9qZEdOcnpOQUIxQUlnTk9UbnVwNU9DVzFzbjlh?=
 =?utf-8?B?QTYvYXMwKzUzaTN5WkpsWm1KZ2VPcWRUOEZRNy9aMjdWVGxIdmZoSXp4R0FY?=
 =?utf-8?B?SzdTVHdsenE1TXo4am9TK2xLbjNqa0RWSUhUK1RMdzNTWUNGTVc5eEVYRVJz?=
 =?utf-8?B?VDU1MFdCRUpacHloWlI0cTA2N0cxREo3L2NYdlExL3BtMkVJNVhyQ3dyeUU5?=
 =?utf-8?B?K3FLTDdLTTQzSUlicTRObnFwZzdLUUZ5c3dTNmVIZ1Q4dkNjTExkV1dBT2JX?=
 =?utf-8?B?by9wd2hJNEtEWHo1SU1YNmw3Snc1WFJrbCtZM245azRncDFrS1dDendLdE90?=
 =?utf-8?B?cmMraW9obXBMWGYzVFJXZGZUVDBlUXp1M1V3RDYyMFRBQSs3Ymk4L3AvTGhs?=
 =?utf-8?B?d21oN0ZPWlhaZGg2RVVsOGxMUUJ1UWFYRSttbTMwbm55dXl2RGptOXMzUFlv?=
 =?utf-8?B?WVNOOStvb0FReUtvdkthVHFFR3ZXYldsMVRnNmIrRzJIN01YYmZUUnA3U2ll?=
 =?utf-8?B?b1F6T290UVpRUE00WXB6Yjd4V2FMLy9UelkvS3JTY2kvU2p3TERBek9lekdW?=
 =?utf-8?B?bUJiNXRyN2hLQ2RTaUhsNEFZcmR6cEhWZmppek1KajcrY3BhNTdIeU1PTlVG?=
 =?utf-8?B?QzJzU3NZYlN1SWZWcmdtNU1INms5dFROS1RBODUvTW9vaUFkYTdRamVkVW9D?=
 =?utf-8?B?Y2doN1kzUHUvN244VjV0bGV1OFIwVDM5SG1vK1UydStCMC9tNWZkdUJBMEk5?=
 =?utf-8?B?V3hMS2xKSi9KUUdRZ1IwNEwrT2Z4cXRDRU9PRzlQbVQzSVZPdE9TWStScGMy?=
 =?utf-8?B?Y1FVVnZSekJTaUpyMm9sMVBvVCtndDBGaUlta3lHYi94UStVRmFuL09HeGlO?=
 =?utf-8?B?NlplSjUwZ0Q3eTBIMGlCTEpoR1ZVQ3o3Q3Y5OGoxMlIzSDB3UDBUWUthNkow?=
 =?utf-8?B?b2srbFlvY3VOdDVNWE9KVzh4eWNEaEQxbUNHc3R3MmZaM3hadDdBbC9RQ0Jz?=
 =?utf-8?B?bUl5U2x2TmhOK1VQcUJRdEo2NGhNK0xTTGN6UUo2RVYxcUNqZUltWlRndWxt?=
 =?utf-8?B?Njh5MXZjTlZOVlY3Mk9UbUxobi9Ic3d0c255MVZiUVpqbVRqS3BPMlloSFd4?=
 =?utf-8?B?aW5XNk1wVFUxVklVUlN2Y044Z3VJM1RzcDBNZ3MvZXVUS1VORkNpZG9LMXJv?=
 =?utf-8?B?MUhuRHlzT2VoQ3RCSS9vTHY3UnY1RDFUY09COWNGZnlOMmc2UzVoQTdsT0NL?=
 =?utf-8?B?TWx5dC9vTHJxZ0x5UTFyMTZBRk9IL1FVWE5jaS8zdFRPSzduaXJ1QTlzYlJ0?=
 =?utf-8?B?MFhDNndxRkRkZVlVS0xtMGFtTWJnRlhxMzhmamtPQWtaYnJLZ2E4bitHQk9i?=
 =?utf-8?B?MXMzbEJYWElCOE1ycUJ2K2FBQ2R4S1BMUVg0NkdWNTFNdGsrQ3FtNkRCcFpy?=
 =?utf-8?B?UkFPL1lXSVExV1Z3UWZUMHlQbFJhV0UwaVo2dEI0dVJXSXJnRDR2cnRqWk1G?=
 =?utf-8?B?bEZjd3pzR2pNRHJOdTFwejRpNXVBVy9FdjIxV3dtclc4UXgxeUx2UmpPRU9M?=
 =?utf-8?B?UHZCYUNzWUh5N1BUcjRDUHpVTkNRa2xlREtxVnNtWHA2NG5WNkJIYUZ6ZmFE?=
 =?utf-8?B?ZEF2ZjVJMkVZWWNzTjcvM3ZOT091ekoyb08xTndSL1pHdWZSN1QrWG5lNmJ1?=
 =?utf-8?B?S2l4QW9BU2RYa1Z5STNrZ0pENVpzUGZpMERRdGxNV1ZXYkpjR25zZ3BmWGN3?=
 =?utf-8?B?c0RDb05FWUNEcGVWNXZCVUtwb1orQ3lyMml5MDFSRmRVQ2srbWl6blJBTGxl?=
 =?utf-8?B?SkN0WnYrQmhFMnhVcGxhUWltcE9JaGs5SG9EVWM1a2tXZitFdC9HYTdvL3lK?=
 =?utf-8?B?clZTeFJtVnVRcFcyVklrb0lxWit6QmtRWkd5K2tyMDNoWFl6S0JyWjkvZjZ4?=
 =?utf-8?B?SzcwKzdWY0lrUVJJQUhGN3pXcy9zaWhPdzhaTDZmcUpPbzdPNlllaTVOOVRh?=
 =?utf-8?B?aXp6WS8rdXQyNGZYT3JnYnBYc3hhQ1VmdzdOL25GSmJWVXRQSmthQVIwTmk2?=
 =?utf-8?B?UzhhazhobXIrbVhBaXNsWVp2ZDl1bXRZWU56VnkvUnpLTklVeWJEbWErVm5T?=
 =?utf-8?B?eG5mbUZhVjNLUEViRjRtMHA4MG92aDNUYnYra1oxNnNrZ1NacjZoOTB6bkJF?=
 =?utf-8?B?c1FhS0VGNWpoSzl1Uld3MnJGTnR1dzRJL0JKNklaemc2VVF5WDJFaFNZNWVE?=
 =?utf-8?B?bGV3WWE5TTNFSEdMTCtQVWsyN053eHlyaytlUEM5VEhTMFVMUTA1UW5CMkpn?=
 =?utf-8?B?d2RrWFVad2wvWXdpNmZ6MCs2UUZJRm9RZXV5dXhVMHpZbWIvQmt6QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d977e6-6f3b-4eec-9ea2-08df13408eec
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 15:46:50.8826 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2GdGhYMumnPS8mLdU7wy7++jZr1+AQWHOwPCT8sykvIcJcHqdaQMHq+aHqvvtcPJPF1bbOon5oP+dEyEjTyD3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6105
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



On 9/14/26 21:27, Dan Himebauch wrote:
> Amended and added issue link, thanks!
> 
>  From 2916fc883b80cf106ba2b06d8dadbdae45eff7db Mon Sep 17 00:00:00 2001
> From: Daniel Kurt Himebauch <danielhimebauch@gmail.com>
> Date: Fri, 11 Sep 2026 21:11:10 -0400
> Subject: [PATCH v2] drm/amd/display: invalidate DP CEC state on s3 suspend
> 
> Some Linux HTPCs with discrete GPUs use active DisplayPort-to-HDMI
> adapters to carry CEC over DP AUX. This provides a CEC path on systems
> where the GPU does not expose native HDMI CEC.
> 
> During S3 suspend, amdgpu invalidates native HDMI CEC state but leaves
> the DP AUX CEC physical address valid. The adapter can retain stale CEC
> state across suspend, causing transmissions during resume to fail before
> the adapter is reconfigured.
> 
> For AUX-mode connectors, invalidate the DP AUX CEC physical address
> during suspend. Normal connector detection on resume then reattaches the
> adapter using the EDID-derived physical address.
> 
> Tested on a Radeon RX 9070 XT HTPC running SteamOS with a UGREEN
> DP-to-HDMI adapter on amd-staging-drm-next at commit d8ab7636160e
> ("drm/amd/amdgpu: remove duplicated code in gfx_v11 and gfx_v12").
> The unmodified tree reproduced resume NACKs. With this change, multiple
> cycles showed Image View On and Active Source transmissions.
> 
> Link: https://gitlab.steamos.cloud/holo/linux-cec/-/issues/5
> Assisted-by: Codex:GPT-5.6-Luna
> Signed-off-by: Daniel Kurt Himebauch <danielhimebauch@gmail.com>
> 
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c    | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> index 0b446133edd8..919394778a25 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> @@ -372,10 +372,13 @@ void amdgpu_dm_s3_handle_hdmi_cec(struct
> drm_device *ddev, bool suspend)
>    continue;
> 
>    aconnector = to_amdgpu_dm_connector(connector);
> - if (suspend)
> + if (suspend) {
>    hdmi_cec_unset_edid(aconnector);
> - else
> + if (aconnector->dc_link && aconnector->dc_link->aux_mode)
> + drm_dp_cec_unset_edid(&aconnector->dm_dp_aux.aux);
> + } else {
>    amdgpu_dm_hdmi_cec_set_edid(aconnector);
> + }
>    }
>    drm_connector_list_iter_end(&conn_iter);
>   }

Something is wrong with your whitespace.  Can you send using git 
send-email perhaps?

╰─❯ b4 shazam 
https://lore.kernel.org/amd-gfx/CAJxfpZJDvFuz40a-euL0jRkPBR82M8Y5NxBrpABeP+EZScFxGw@mail.gmail.com/
Looking up 
https://lore.kernel.org/all/CAJxfpZJDvFuz40a-euL0jRkPBR82M8Y5NxBrpABeP%2BEZScFxGw@mail.gmail.com/
Grabbing thread from 
lore.kernel.org/all/CAJxfpZJDvFuz40a-euL0jRkPBR82M8Y5NxBrpABeP%2BEZScFxGw@mail.gmail.com/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 3 messages in the thread
Looking for additional code-review trailers on lore.kernel.org
Analyzing 0 code-review messages
Will use the latest revision: v2
You can pick other revisions using the -vN flag
Checking attestation on all messages, may take a moment...
---
   ✓ [PATCH v2] drm/amd/display: invalidate DP CEC state on s3 suspend
   ---
   ✓ Signed: DKIM/gmail.com
---
Total patches: 1
---
Applying: drm/amd/display: invalidate DP CEC state on s3 suspend
Patch failed at 0001 drm/amd/display: invalidate DP CEC state on s3 suspend
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
error: git diff header lacks filename information when removing 1 
leading pathname component (line 6)
hint: Use 'git am --show-current-patch=diff' to see the failed patch

╰─❯ git am --show-current-patch=diff > patch
╰─❯ patch -p1 < patch 
  
  

patching file drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
patch: **** malformed patch at line 11: drm_device *ddev, bool suspend)

