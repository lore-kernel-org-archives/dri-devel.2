Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49598CA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 19:05:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E4A510F048;
	Tue, 29 Sep 2026 19:05:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BsvstnUm";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010011.outbound.protection.outlook.com [52.101.61.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0B1B10F048;
 Tue, 29 Sep 2026 19:05:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WBrbgryXZ1g8IVzpqrZPv6vNnWPvyqq2obzYrL8rDdJJYoPggWx56YZNNiZ3zfyhm7joHRwnkyC2wyXEHWgADL908wX8RKP34E6459NM/Y8W7OAFvRu03z24elNthh3j2O8hCh+ZXYlXLXyHiq82/KtrvYZ+GnGGrzHGd6C8wZP5tngR6PilBSWyz77AeNtdDM4k+9qmz2PkP3kJaRJgRrcKT2PPlL5YXqbvomCmFkWY2HO9EyQC62VivavjaffU/CPvUNMRRIOLCH5HzDMZjMACoifnilU2xMrdscZQij+bc7Vw/8AdrZ214kwbSDXTcGO3UZkDEoU0MDbKt9A4hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5Ue03WC0nJ7AT2Fuw0fitWm2CSou6wUVwthPY6sf2I=;
 b=RHaDWWhvv6d1GOu85Y9w7+2io177hzlTjXRuIsCSJkk96HBHXqEk3XwkYuiNwfbRZOVyvXxAL9z6YvNtx0jitIyx+0Cvz4ORxDxeor5mrIIO86VpelGE41AEhHE7cwSkvRHopIuDLyWkCyRiRBl2FX+SJzAz6Mtv1TohVfDmqz9RfkZxc16/fK0xOmdRwFAoD+cjITeWKicco2QqtNaYspx9RQQOsQUGtE1ozUIb6ml9BbYlYANcFiXeX93MzmUYKhLkvPCpQ8CJ5fLdKRN0Ln6vueojWOA7pSHscmqdFs4/XaieTKko42fAoiakH6v3Jq79kQ9iiBoWpXzB+FJfQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5Ue03WC0nJ7AT2Fuw0fitWm2CSou6wUVwthPY6sf2I=;
 b=BsvstnUm9UIB3ZJrJsaT45PdlXFSof72qpqgHrnSifH+beq36UTvczaWJ3Ft1OsiOPOKkVHLHSZXfnHvHXBrcvobqZSBIze34bTCsU86Guxx2AyVnklCFjePR8lFTPejM97PxPxa//+J56kZlSnj88pPajQlgn1Q8nZVTn3E6Ws=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::15) by SN7PR12MB7324.namprd12.prod.outlook.com
 (2603:10b6:806:29b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 29 Sep
 2026 19:05:20 +0000
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4]) by PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4%6]) with mapi id 15.21.0451.024; Tue, 29 Sep 2026
 19:05:19 +0000
Content-Type: multipart/alternative;
 boundary="------------e7L0AC7VOchL46D4Ra2Bs0KC"
Message-ID: <e5b5770f-8ae1-41c3-b5d9-53798dd3fd45@amd.com>
Date: Tue, 29 Sep 2026 15:05:15 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Fix NPA-REVOKE racing an in-flight UALink
 import
To: David Carlier <devnexen@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260926174406.346253-1-devnexen@gmail.com>
Content-Language: en-CA
From: Mukul Joshi <mukul.joshi@amd.com>
In-Reply-To: <20260926174406.346253-1-devnexen@gmail.com>
X-ClientProxiedBy: YT3PR01CA0018.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::22) To PHXPR12MB999256.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PHXPR12MB999256:EE_|SN7PR12MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: e2e6f177-1c26-4bb2-e72b-08df1e5c9a96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|13003099007|22082099003|18002099003|10067099003|5023799004|56012099006|11063799006|8096899003;
X-Microsoft-Antispam-Message-Info: kTDFsdy6qRwCJw/tdkqyW4nfR28kq/5kos0fdh5zHy/ydqFtmMafoxLoxm3tD9EVqN2u30mWsDXUtocwrhrIT3PtdhHuMBBRr7Y6eYQAh+GiTDJ1W0CdX+Ad1OglMnp6wTTsN4cgK9tJm8TLSAgiJ/yctMymfhAq8rcQ2RXF3QgrdMS/4eoPFORyHwVtW2m+31G71vU3pQZFPdGpb+7mD+GaFumwC/zEKRFJva86B6UQqJ+vGSPIukiOT3zV0p05kfNSJ/OeIZnihg6tG2mXi2vnxR6BzkObM//IM6w4vEIF+CVV8iv5PCh79kdTmQNZpI9+4jhQQDnHIViG2tAAQZWRWqv11AqVhOb4xUJX0miFnSQO1huPgMfXfz5M+K4xGYDSvycIUSIV0ZG5T0IZnaSjxMYQ4rn7Lp4/KPULA22sSERqSLXjxMNSZCLAAuldokiIpHmuamAl0G4T5pbhK5TqFH6/ffEyWWjdlsnv9hCOLMLkT1fGi58Luga5a8Bze/IoUXabpcGK2kfpR0eQh0caRGysbxVt/PYNj23pL4Qc8zoVCmdCoYtFYwKnthz06XeDUI1iGnBnz42/GlJzn6nTWWItP4yM4jixEjgFyICJG9o8SzYyVXK1bg1rqtqmDG+YH5IYYBlS0MN8JqGJEV0bMnFK+wscTuXSXTbKjHM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PHXPR12MB999256.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(13003099007)(22082099003)(18002099003)(10067099003)(5023799004)(56012099006)(11063799006)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlZCR3hYS0UxSDg5bENGbGQyclZRR1hYNHIvQ3BIdFU5VXdqeXJYRlVjbEoz?=
 =?utf-8?B?VndvR242Tm5PVlY4ZEFFSTRFaGFVTTNIbi9pMDgwUTZxTnd5YkJ0UmpJVDVQ?=
 =?utf-8?B?dlNrQ1NGNFJDU1d3WmsxcHNjV3E4T04ySGMxMHM0SkJaWXlaaGFvc0FvRlVi?=
 =?utf-8?B?QVoveHlCY1NmRnlMMGt2ZXRqSVVFWEFCaG5yKzN6UHd0aWs4ZG0zc3crZjVy?=
 =?utf-8?B?RTFYVWFDWGpLYzd2OTM5YXIvUTNvc3ZLc0ViSzNIQ3JncGROck1XRlFYOVc3?=
 =?utf-8?B?UVBDZjBKQkk0NG9tbEZZalh5OTE2WUpxeVE4RHBWQWRPcCtIcW5rTElVMGg2?=
 =?utf-8?B?NmREVU92TENMbmwwWmp4bStDT1VpOUJDNmVhZ1dKb3hjMEQ1bXpTc2RSbzRB?=
 =?utf-8?B?UDRyaGFNL0RTdGF6UUZXTHlBUkc1TitUN3MvOXZzdS9BYlRIbEV2bWd5cjBJ?=
 =?utf-8?B?UjdGQ0VzNWZNNFpaZ3BpOHk2ZzljUFR1OVozOE5nUkpTWnR2ZVNRV29jUzJ2?=
 =?utf-8?B?Q25DanVDWTJST3JncDUyRGYrNW9BSFNQVStvQ3R3Z3ZqWWEvSW13SlUwbWtS?=
 =?utf-8?B?Q0sxNFVTaGk5ajVBb2RxRWVRdW1RekNPd25UYlk0UDB4U2xGNFg1L2crd3JT?=
 =?utf-8?B?V210R0Z4U0VSWlFxRkU5bFkxa21ZREM5Q0FPL2I3d3h3ajhJc1h5Y2ZBbEt5?=
 =?utf-8?B?Y3dicXFwemg1ZWhVanUvdEM3d1dQN3N5alJ1RmRpSzZiRjlzV2FDMkRJZXlt?=
 =?utf-8?B?eWgvaFJNOWtPVjlvQWdyR1hickRyV0VrSXlWTlA1c3ZMNnUwbTJDUG5ydXBI?=
 =?utf-8?B?T21QOW9GbVpJVFFRQ0N4N0FKOHcwelhqaDZHTVpteXgwMDh6Z0FTZ1Zjcm9r?=
 =?utf-8?B?Y3VISDJyOG5rWmZjWnpOMW1KT3BEZzF3RGNJWWEvU05ibHhtdXYvUHJjQ2Q5?=
 =?utf-8?B?N3VLaEMvWnJYSnFqUWp1RXFHdnJjWjFrbUljdTVWVmlOb25jbFNwc2FYN3l3?=
 =?utf-8?B?czUySkpic1RZRThEMzVUV05rellzclRMb1pQdE5JTEJIUFpQOW5vVkJBVU8r?=
 =?utf-8?B?TUpiV3BaQ2tjWjBBTDVBTVFKMVBqQ1Y3ZUM4YWx6THFpVnhRS1JxSDJndlg5?=
 =?utf-8?B?ZWZtdW42YUdzWTVzUW9Zemh3eDJTbXp1Sm9NejBHNExoZ00rTlZTM0JYRStC?=
 =?utf-8?B?Y1h6emJpSEV1dVRFdGFGekwyVWpPdHNiM2l3VVlNemc4cjFLcGV1Vkh4S2FC?=
 =?utf-8?B?SHQxb1A1RXUxbGpKbjJSYmRtWDVwbXJaQkE1aUJma2Q1UllITmFMeWNZYzd3?=
 =?utf-8?B?ODdyZEV6QnoyWUR2MEVZT25VV2JOMUM1cittQWhFS2FBaDZKTzJDSHRRekEx?=
 =?utf-8?B?eS9sdTBVUldGTUltMVp5N1VHTmFjM21UNDl4ZjVLcXNFR21KTUFCOWYxYzll?=
 =?utf-8?B?UTRVVFErZW1rMDRoZkhpT09NdnVaSTR0cWhOUlk3c3pwWHFNL1dsMUZ2Zk9l?=
 =?utf-8?B?My93cXdJNHNyeFptc25tMmRpVERaTmJtVFpLbjBrdkRlN0ZEV1lrQjZpeEUr?=
 =?utf-8?B?ZlRneTJtak1BWXJqS3BrdTVsNnU4WS9hUk1taDlsY2t5SWR1Y0t4SlNGVTNy?=
 =?utf-8?B?V3JvSld2YzFkMVR1M05JakZzMTVieDZ6Q0t4OEVjaTJFWmxvWmozQnlDSW1h?=
 =?utf-8?B?ZUc1eFFYT1J5dW5HZzZTVHc0am9iMFQzK2VFZG9QbDE4NUxlbGdveDNTdGRV?=
 =?utf-8?B?NldBSFBHc3MvdWMyYkxRU2k2QTFmZ054TXNSeHRiMXBzUDdVR0VWS0UyVWJL?=
 =?utf-8?B?L2Z4dUxGb2R3aWtwZnVVYStpclhHZVBTMXBlZmprUXpCQ09CZ3dkelRvMlMz?=
 =?utf-8?B?cDlKRHFpRG85MjErTFFEbzJXYlkxcEhSWCt1RytyMmpLZEJzeDc0TUxTbThU?=
 =?utf-8?B?bkhRMk1PSEFNc2poSmxZdXJLd3dpRXRLbFJyV2poOFE1WEZaQnB1cUg3MWJw?=
 =?utf-8?B?VWhmUFVnU3ZueTk5bk11cWtxRkVxQkQ0elNEVVVSLytoemJkRzdWQnNvQ2FR?=
 =?utf-8?B?RG05dUpyamoyY2xIOEwyN0F2UnhOQmpIb1BXNlVoVWY4cmN4eWs4WHhTTFpl?=
 =?utf-8?B?aGRBRitjSTR6N1VqdDFzVitVY3JoMGpWT2dscTZDLzd6NjhqNlUzQ28xTkZ1?=
 =?utf-8?B?Tk54aHJUeDhiZ1FiSkkxcitrS202WUhnTEF4WjhSZHk0a3RlaTdaRnV6NE5p?=
 =?utf-8?B?OXRCaGRyY2s5WWwzYlZIZ3FpR3hHelpwU29JcXVCTmpScFltNk95bU1WTXh6?=
 =?utf-8?B?NmJWUktnVmRmbEhHQkhrQis3bDNNOW9xbFplVmZkZnZtNmVCbmc1Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e6f177-1c26-4bb2-e72b-08df1e5c9a96
X-MS-Exchange-CrossTenant-AuthSource: PHXPR12MB999256.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 19:05:19.0749 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cI0sobiiTzmaGgz42QdBp2h36xrbaWfU5Gdx32fQyyA4izm33aAME64ZnG4OgroMGSnDtcu2IPYs7FbiO8LJmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7324
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

--------------e7L0AC7VOchL46D4Ra2Bs0KC
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi David,

Thanks for the patch. Yes the race is real, however, the patch needs 
some updations.

More below.


On 9/26/2026 1:44 PM, David Carlier wrote:
> [You don't often get email fromdevnexen@gmail.com. Learn why this is important athttps://aka.ms/LearnAboutSenderIdentification ]
>
> The exporter records an importer when it answers NPA-REQ, so it can send
> NPA-REVOKE as soon as the BO is freed, before the importer has finished
> building the dma-buf for that handle. The revoke handler assumes a fully
> imported node: it dereferences imp_xa_node->dmabuf, which is still NULL
> until the import completes, and drops the xarray reference the importing
> thread still relies on. The importer then links the node and marks it
> READY regardless, so the node can be freed while still on the per-remote
> list.
>
> Only tear down a node that is READY. Otherwise mark it for teardown and
> send NPA-RELEASE, as nothing has been handed to user-space yet, and wake
> the importer if it is still waiting for NPA-RSP so that it fails right
> away. A node already in teardown belongs to whoever moved it there, so a
> duplicate NPA-REVOKE no longer touches it either. The importer checks for
> teardown under the xarray lock before linking the node and marking it
> READY, and unwinds otherwise.
I think NPA-REVOKE cannot land before a NPA-RSP so we will not hit the 
condition where
we have to wake up the importer.
NPA-REVOKE is sent only when the exporter's XA entry's ref count goes 
down to 0.
That will happen at the end of process_npa_req(), by that time, the 
NPA-RSP is already sent.
>
> Fixes: 7cc82cd90d35 ("drm/amdgpu: Implement mechanism to revoke exported memory")
> Assisted-by: LLM
> Signed-off-by: David Carlier<devnexen@gmail.com>
> ---
> Changes in v2:
> - Tear down only READY nodes, so a duplicate NPA-REVOKE for a node already
>    in teardown neither dereferences a NULL dmabuf nor drops the node
>    reference twice (Sashiko).
> - Complete npa_done when a revoke arrives before NPA-RSP, so the importer
>    fails right away instead of timing out into a connection reset (Sashiko).
> - Use the current Assisted-by format.
>
> Found by code analysis and compile-tested with W=1. Not tested on hardware,
> as it needs two UALink-connected accelerators in a vPod.
>
> v1:https://lore.kernel.org/all/20260926171625.288519-1-devnexen@gmail.com/
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 34 +++++++++++++++++++---
>   1 file changed, 30 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> index 8411ea17172f..cb35026e6eba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -3265,6 +3265,7 @@ static void amdgpu_ualink_process_npa_revoke_msg(struct amdgpu_device *adev,
>   {
>          struct amdgpu_ualink_imp_xa_node *imp_xa_node;
>          struct amdgpu_bo *bo;
> +       u32 node_state;
>          int r = 0;
>
>          /* Remove the entry from the Xarray. */
> @@ -3288,7 +3289,23 @@ static void amdgpu_ualink_process_npa_revoke_msg(struct amdgpu_device *adev,
>                  return;
>          }
>
> +       node_state = READ_ONCE(imp_xa_node->node_state);
>          WRITE_ONCE(imp_xa_node->node_state, AMDGPU_UALINK_NODE_TEARDOWN);
> +
> +       /* Only a READY node is torn down here. If the import is still in
> +        * flight, the dmabuf may not exist yet and nothing has been handed
> +        * to user-space: leave the node to the importing thread, which sees
> +        * the teardown state and unwinds, and wake it up if it is still
> +        * waiting for NPA-RSP. A node already in teardown is owned by
> +        * whoever moved it there, e.g. an earlier NPA-REVOKE.
> +        */
> +       if (node_state != AMDGPU_UALINK_NODE_READY) {
> +               if (node_state == AMDGPU_UALINK_NODE_NOT_READY)
> +                       complete(&imp_xa_node->npa_done);
> +               xa_unlock(&adev->ualink.imp_xa);
> +               goto send_release;
> +       }
As mentioned above, NPA-REVOKE cannot land before the NPA-RSP is sent by 
the exporter.
So, if the node_state is NOT_READY that means its a stale NPA_REVOKE and 
we should just ignore
that NPA-REVOKE. Having said that, we should definitely do the teardown 
when the node_state is READY.
We should also handle NPA-REVOKE while node_state is in PENDING state.
So, maybe we can refactor this code to something like this:

switch (READ_ONCE(imp_xa_node->node_state)) {
     case AMDGPU_UALINK_NODE_READY:
         /* existing teardown */
         break;
     case AMDGPU_UALINK_NODE_PENDING:
         WRITE_ONCE(imp_xa_node->node_state, AMDGPU_UALINK_NODE_TEARDOWN);
         xa_unlock(&adev->ualink.imp_xa);
         break;
     default:
         xa_unlock(&adev->ualink.imp_xa);
         return;
     }

> +
>          list_del_init(&imp_xa_node->list);
>          xa_unlock(&adev->ualink.imp_xa);
>
> @@ -3299,6 +3316,7 @@ static void amdgpu_ualink_process_npa_revoke_msg(struct amdgpu_device *adev,
>          /* Drop the refcount for the node */
>          amdgpu_ualink_imp_xa_entry_put(imp_xa_node);
>
> +send_release:
>          r = amdgpu_ualink_send_npa_release_msg(adev, remote_acc_id, handle);
>          if (r)
>                  dev_err(adev->dev,
> @@ -3760,9 +3778,20 @@ static int amdgpu_ualink_do_import_handle(struct amdgpu_device *adev,
>                  return r;
>          }
>
> -       /* Add this node to the imported handles list for the remote GPU */
> +       /* Add this node to the imported handles list for the remote GPU,
> +        * unless the exporter revoked the handle while the import was in
> +        * flight. The dmabuf is released with the last node reference.
> +        */
>          xa_lock(&adev->ualink.imp_xa);
> +       if (READ_ONCE(imp_xa_node->node_state) == AMDGPU_UALINK_NODE_TEARDOWN) {
> +               xa_unlock(&adev->ualink.imp_xa);
> +               dev_warn(adev->dev,
> +                        "IMPORT: handle:%llx:%llx revoked during import\n",
> +                        handle.handle_hi, handle.handle_lo);
> +               return -EINVAL;
> +       }
>          list_add(&imp_xa_node->list, &adev->ualink.imp_handles_list[remote_acc_id]);
> +       WRITE_ONCE(imp_xa_node->node_state, AMDGPU_UALINK_NODE_READY);
>          xa_unlock(&adev->ualink.imp_xa);
The changes here makes sense. One nit-pick is to change from dev_warn to 
dev_dbg().
>
>          return 0;
> @@ -3938,9 +3967,6 @@ int amdgpu_ualink_import_handle(struct drm_device *dev,
>                                          "IMPORT: XA import failed for handle:%llx:%llx\n",
>                                          handle.handle_hi, handle.handle_lo);
>                          goto cleanup;
> -               } else {
> -                       WRITE_ONCE(imp_xa_node->node_state,
> -                                  AMDGPU_UALINK_NODE_READY);
>                  }

ACK.


Regards,

Mukul

>          }
>
> --
> 2.55.0
--------------e7L0AC7VOchL46D4Ra2Bs0KC
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><font face="monospace">Hi David,</font></p>
    <p><font face="monospace">Thanks for the patch. Yes the race is
        real, however, the patch needs some updations.</font></p>
    <p><font face="monospace">More below.</font></p>
    <p><font face="monospace"><br>
      </font></p>
    <div class="moz-cite-prefix">On 9/26/2026 1:44 PM, David Carlier
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260926174406.346253-1-devnexen@gmail.com">
      <pre wrap="" class="moz-quote-pre">[You don't often get email from <a class="moz-txt-link-abbreviated" href="mailto:devnexen@gmail.com">devnexen@gmail.com</a>. Learn why this is important at <a class="moz-txt-link-freetext" href="https://aka.ms/LearnAboutSenderIdentification">https://aka.ms/LearnAboutSenderIdentification</a> ]

The exporter records an importer when it answers NPA-REQ, so it can send
NPA-REVOKE as soon as the BO is freed, before the importer has finished
building the dma-buf for that handle. The revoke handler assumes a fully
imported node: it dereferences imp_xa_node-&gt;dmabuf, which is still NULL
until the import completes, and drops the xarray reference the importing
thread still relies on. The importer then links the node and marks it
READY regardless, so the node can be freed while still on the per-remote
list.

Only tear down a node that is READY. Otherwise mark it for teardown and
send NPA-RELEASE, as nothing has been handed to user-space yet, and wake
the importer if it is still waiting for NPA-RSP so that it fails right
away. A node already in teardown belongs to whoever moved it there, so a
duplicate NPA-REVOKE no longer touches it either. The importer checks for
teardown under the xarray lock before linking the node and marking it
READY, and unwinds otherwise.</pre>
    </blockquote>
    I think NPA-REVOKE cannot land before a NPA-RSP so we will not hit
    the condition where<br>
    we have to wake up the importer.&nbsp;<br>
    NPA-REVOKE is sent only when the exporter's XA entry's ref count
    goes down to 0.<br>
    That will happen at the end of process_npa_req(), by that time, the
    NPA-RSP is already sent.
    <blockquote type="cite" cite="mid:20260926174406.346253-1-devnexen@gmail.com">
      <pre wrap="" class="moz-quote-pre">

Fixes: 7cc82cd90d35 (&quot;drm/amdgpu: Implement mechanism to revoke exported memory&quot;)
Assisted-by: LLM
Signed-off-by: David Carlier <a class="moz-txt-link-rfc2396E" href="mailto:devnexen@gmail.com">&lt;devnexen@gmail.com&gt;</a>
---
Changes in v2:
- Tear down only READY nodes, so a duplicate NPA-REVOKE for a node already
  in teardown neither dereferences a NULL dmabuf nor drops the node
  reference twice (Sashiko).
- Complete npa_done when a revoke arrives before NPA-RSP, so the importer
  fails right away instead of timing out into a connection reset (Sashiko).
- Use the current Assisted-by format.

Found by code analysis and compile-tested with W=1. Not tested on hardware,
as it needs two UALink-connected accelerators in a vPod.

v1: <a class="moz-txt-link-freetext" href="https://lore.kernel.org/all/20260926171625.288519-1-devnexen@gmail.com/">https://lore.kernel.org/all/20260926171625.288519-1-devnexen@gmail.com/</a>

 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 34 +++++++++++++++++++---
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 8411ea17172f..cb35026e6eba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -3265,6 +3265,7 @@ static void amdgpu_ualink_process_npa_revoke_msg(struct amdgpu_device *adev,
 {
        struct amdgpu_ualink_imp_xa_node *imp_xa_node;
        struct amdgpu_bo *bo;
+       u32 node_state;
        int r = 0;

        /* Remove the entry from the Xarray. */
@@ -3288,7 +3289,23 @@ static void amdgpu_ualink_process_npa_revoke_msg(struct amdgpu_device *adev,
                return;
        }

+       node_state = READ_ONCE(imp_xa_node-&gt;node_state);
        WRITE_ONCE(imp_xa_node-&gt;node_state, AMDGPU_UALINK_NODE_TEARDOWN);
+
+       /* Only a READY node is torn down here. If the import is still in
+        * flight, the dmabuf may not exist yet and nothing has been handed
+        * to user-space: leave the node to the importing thread, which sees
+        * the teardown state and unwinds, and wake it up if it is still
+        * waiting for NPA-RSP. A node already in teardown is owned by
+        * whoever moved it there, e.g. an earlier NPA-REVOKE.
+        */
+       if (node_state != AMDGPU_UALINK_NODE_READY) {
+               if (node_state == AMDGPU_UALINK_NODE_NOT_READY)
+                       complete(&amp;imp_xa_node-&gt;npa_done);
+               xa_unlock(&amp;adev-&gt;ualink.imp_xa);
+               goto send_release;
+       }</pre>
    </blockquote>
    As mentioned above, NPA-REVOKE cannot land before the NPA-RSP is
    sent by the exporter.<br>
    So, if the node_state is NOT_READY that means its a stale NPA_REVOKE
    and we should just ignore<br>
    that NPA-REVOKE. Having said that, we should definitely do the
    teardown when the node_state is READY.<br>
    We should also handle NPA-REVOKE while node_state is in PENDING
    state.<br>
    So, maybe we can refactor this code to something like this:
    <p>switch (READ_ONCE(imp_xa_node-&gt;node_state)) {<br>
      &nbsp; &nbsp; case AMDGPU_UALINK_NODE_READY:<br>
      &nbsp; &nbsp; &nbsp; &nbsp; /* existing teardown */<br>
      &nbsp; &nbsp; &nbsp; &nbsp; break;<br>
      &nbsp; &nbsp; case AMDGPU_UALINK_NODE_PENDING:<br>
      &nbsp; &nbsp; &nbsp; &nbsp; WRITE_ONCE(imp_xa_node-&gt;node_state,
      AMDGPU_UALINK_NODE_TEARDOWN);<br>
      &nbsp; &nbsp; &nbsp; &nbsp; xa_unlock(&amp;adev-&gt;ualink.imp_xa);<br>
      &nbsp; &nbsp; &nbsp; &nbsp; break;<br>
      &nbsp; &nbsp; default:<br>
      &nbsp; &nbsp; &nbsp; &nbsp; xa_unlock(&amp;adev-&gt;ualink.imp_xa);<br>
      &nbsp; &nbsp; &nbsp; &nbsp; return;<br>
      &nbsp; &nbsp; }</p>
    <blockquote type="cite" cite="mid:20260926174406.346253-1-devnexen@gmail.com">
      <pre wrap="" class="moz-quote-pre">
+
        list_del_init(&amp;imp_xa_node-&gt;list);
        xa_unlock(&amp;adev-&gt;ualink.imp_xa);

@@ -3299,6 +3316,7 @@ static void amdgpu_ualink_process_npa_revoke_msg(struct amdgpu_device *adev,
        /* Drop the refcount for the node */
        amdgpu_ualink_imp_xa_entry_put(imp_xa_node);

+send_release:
        r = amdgpu_ualink_send_npa_release_msg(adev, remote_acc_id, handle);
        if (r)
                dev_err(adev-&gt;dev,
@@ -3760,9 +3778,20 @@ static int amdgpu_ualink_do_import_handle(struct amdgpu_device *adev,
                return r;
        }

-       /* Add this node to the imported handles list for the remote GPU */
+       /* Add this node to the imported handles list for the remote GPU,
+        * unless the exporter revoked the handle while the import was in
+        * flight. The dmabuf is released with the last node reference.
+        */
        xa_lock(&amp;adev-&gt;ualink.imp_xa);
+       if (READ_ONCE(imp_xa_node-&gt;node_state) == AMDGPU_UALINK_NODE_TEARDOWN) {
+               xa_unlock(&amp;adev-&gt;ualink.imp_xa);
+               dev_warn(adev-&gt;dev,
+                        &quot;IMPORT: handle:%llx:%llx revoked during import\n&quot;,
+                        handle.handle_hi, handle.handle_lo);
+               return -EINVAL;
+       }
        list_add(&amp;imp_xa_node-&gt;list, &amp;adev-&gt;ualink.imp_handles_list[remote_acc_id]);
+       WRITE_ONCE(imp_xa_node-&gt;node_state, AMDGPU_UALINK_NODE_READY);
        xa_unlock(&amp;adev-&gt;ualink.imp_xa);</pre>
    </blockquote>
    The changes here makes sense. One nit-pick is to change from
    dev_warn to dev_dbg().
    <blockquote type="cite" cite="mid:20260926174406.346253-1-devnexen@gmail.com">
      <pre wrap="" class="moz-quote-pre">

        return 0;
@@ -3938,9 +3967,6 @@ int amdgpu_ualink_import_handle(struct drm_device *dev,
                                        &quot;IMPORT: XA import failed for handle:%llx:%llx\n&quot;,
                                        handle.handle_hi, handle.handle_lo);
                        goto cleanup;
-               } else {
-                       WRITE_ONCE(imp_xa_node-&gt;node_state,
-                                  AMDGPU_UALINK_NODE_READY);
                }</pre>
    </blockquote>
    <p>ACK.</p>
    <p><br>
    </p>
    <p>Regards,</p>
    <p>Mukul</p>
    <blockquote type="cite" cite="mid:20260926174406.346253-1-devnexen@gmail.com">
      <pre wrap="" class="moz-quote-pre">
        }

--
2.55.0
</pre>
    </blockquote>
  </body>
</html>

--------------e7L0AC7VOchL46D4Ra2Bs0KC--
