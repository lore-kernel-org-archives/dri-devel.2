Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0574CA5FF1
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 07:51:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27A6010E332;
	Wed,  7 Oct 2026 07:51:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AMpBXvQe";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011006.outbound.protection.outlook.com
 [40.93.194.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C7D210E332
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 07:51:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hamxG5C27bqNq1Oc+g3dKM2IwOXl2UdyNyV6dHzbrY73NnXEzrtD1jShaMxoIS9O8Wo2aIpR4+Ydm3frvDGGd2l+9170xGWdRKPnzFvdt6DhQ7zlWyIFQ1OLGbYUa8CNhtvqVqMFrbhlcSFe5l9phdwzK4IdslL7NHxZVpBE69lXg9hobGWBGQ+TMXAKBjsewjsp1xGzO+H/+v9pmKbSID9ak/tDbYbXAKAzZDnI853vbzeby/DTrIp7iiBP0wbMPIq3vxMZQT4txnTyU6bGNW27AMLgJusZfgC9oml82sdEgcvlj1C1iU5eG/BCBJ0+HMQbV7M3aynX7HQMTgQwOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1A661XO1EYBVODGzATc1wIGh+JfQVrb9K6+0UNnyxo=;
 b=GzpHatWPqvG21h105wkEnWzuLBdWm2phrXqpFUka+liRXOgLJ3/IV3TGMNlidt7b/ocAcLgd2IpJ8v440dyV5Hw/Ru+AegyeR7i5a+CPH7vEaydqVJXaiiAVx/9Wo8hFSdE7uDdaa5utqSQTt3+3RwkKnne19w3qAZhlCtFLOzY28ruk1n22MB2U+NmODud2JPssCejZ+LxmrnU9l8auok+ZG01h5oCF5gug2/YdawSd1fCMLq0jM4CUOTPWLfA6uHMOOI+L2rvgC7T+/dBoJiS6bhP9Nh2sf/hm7lrglQLt+UduB4HOWZKn9siVp571Y2eWI/KANjM8ZIrloBWliA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1A661XO1EYBVODGzATc1wIGh+JfQVrb9K6+0UNnyxo=;
 b=AMpBXvQe26IkfkpNMKcx6eiqu4/vBkmtxnDVYmlhiHV2UM3WT9l4NoZWALeeh5DhC3hn4nevKKflQ2SAlMJI16PiUb2B+OausqnnFMN4SHEPGo8lUxZ5yt6hmr5HfmQXxR3q/l2m4MsHVbxeQRWKO6b31FvvDuuYDGmGO+7S3AI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB9514.namprd12.prod.outlook.com (2603:10b6:806:458::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 07:51:45 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 07:51:45 +0000
Message-ID: <7e8b332d-04a9-418a-95f4-de3cbd8b8a33@amd.com>
Date: Wed, 7 Oct 2026 09:51:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-buf: Annul dmabuf->file on file release
To: Matt Evans <matt@ozlabs.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas Hellstrom <thellstrom@vmware.com>,
 Zack Rusin <zack.rusin@broadcom.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 Alex Mastro <amastro@fb.com>, Alex Williamson <alex@shazbot.org>
References: <f8efaabd-c06e-4f04-8cfa-489c148e37ba@ozlabs.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <f8efaabd-c06e-4f04-8cfa-489c148e37ba@ozlabs.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0276.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB9514:EE_
X-MS-Office365-Filtering-Correlation-Id: 77516e90-6988-461a-71d0-08df2447d533
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|366016|6133799003|18002099003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 7FEaNN46rP6CFN4SFEt30HRT3QLc1x3QOcSuHayuDeJgPy/CkfmcxhFlDGXuvnLlcnRPE75m8Mf+pTFinTBSkinEXVySzok/xCCeZNsmz8k04IccFmxER6q2MhXnrVjUFTQsaG0RrRGu5Qc78W1Pt+aXop47DO9pcdjgeewzvm5f+js1Lyo9ZQoNX+35lMYJwH8CWynJw+stx0vK7CsFnnvCpNx0jBXrIa9zajx4zwMPgD74VrTeWEppizVPgnA3XmYQS1r1wUltAnWU4FnZAP1qzIXNVK30gOCRcY8aqB5RnRlo+888sDARp0MeWkiJ04H0z3ix3EzMpk52m4G7DEWeROkw/ZnBllJwYN/RSTZYSQdWn77tHlOp+Nn2hvE6WSTnWVmyiROnRbqWziLUjgZe4kXMom9o3sxmNKWVJC93140Fy5cJ1PY35m9A8r5FFMnYkdO7UxkVLW7Y9zaK7g+0608FO1xUITKLDlIHqIQeJcdqMXGMDwS/UEgSKErHn/O0jJVO/lZB+FKlIezRN35DiBrsQbVhWwziXDb1Ah6sH5DZJmZCrxZcw94qF8z89aLdpLd0Buqumo3KUSM/WrN/8e38tuRIjtZ7HjmNfEFSO9tNrjTmOFdEyxmbvdIfRT3LIoEGnhl5pxajoZph/UiYeFHlB6ZR5pDsFBYXYEs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1JXaVFUb1RBL3Q0N3VIdnZDKzBxNW0vZDgwYytKbXpBY2NVc01HVE9lRVBr?=
 =?utf-8?B?eUx6cTVueXNjb3pyNStTSnFCUHdPYmJDM09CWjlDTnZYZCtWRk53NXFBUGc0?=
 =?utf-8?B?Tk9XZGt5TW9XRXIxSjh6WEVUOUxFTzkxZVl2Q3dJMXBOQWN1MFY3bk4yZWhn?=
 =?utf-8?B?NWpkdWhyV1QxMlJBRHVBN21FdEsxWEJQOEgyUzFRdXdSQW1PTUVheHJRWmZy?=
 =?utf-8?B?MGQ0b0lXM00zQVFBNEdQRjdjQVlqMWhEZFZ6ai95V2hoVllrcXNTNnFxN2hU?=
 =?utf-8?B?WTIweGJpRnJRUEVoY0tPbXRsU1c3NHFLajlHWFRsbUJVeFAvdUo0dng5M3Yz?=
 =?utf-8?B?SGdrQzB5SXJhTnZmSS9ydytETTFJMkNUZyt5c3NjMnFuY2M0UjlXWmNNMVBr?=
 =?utf-8?B?R1dXZ2pXQzFZRmFlVkxYZDBSZTJtcGpmclRVaWpIN1NrdW5sY05zM2l3aElh?=
 =?utf-8?B?L0RnRXFsWmNCdmFCT3U5UFp0RnFnbCt6Zm1vU0pnKzd4K0VvSVpWbnRYNVdN?=
 =?utf-8?B?ZVQ3NlgzK2VwTy9WS0FMeDExY1o1cjhZSHluK3Q5TmlXMVBzSjVueUdTSmRq?=
 =?utf-8?B?MzJ2QWJOd21mZnlLL3dXMDM5bFdlbVVzd1FJL3hTMEFEYU9QbWVxMFJ0SUs4?=
 =?utf-8?B?VWVMQ2FBVlFpdFdFVjBYOTlHM3lWUmp5RHJpRlVaYlRTRXY5WHFkaVdNb0Uw?=
 =?utf-8?B?VTYzY2t5T0lXSk9EZW5nWWFXNlhxL2N2eTE0aHI4VjE2c2hYcCt5UXVSeW1k?=
 =?utf-8?B?S1lmL1lPbXczY3d2SlhnZFkydDJ6L2ZDcFRmMldOWFBIT084OExyRS9LcWNF?=
 =?utf-8?B?NjZrNFIvZEhOT2FHS28zMjVNNHRvUUVhaThNSnlWczZ6RFlpeWJZWVlLSWo4?=
 =?utf-8?B?SndvYkt0U0REWGFDQUNUbUZKYmw3SWI2SFY2TUwvaHNhUkpSSkw2MjBRMmEr?=
 =?utf-8?B?OERzVFZkWTM3bGpOTlU5UlBoVmhLL01tdG5CVEhyQmU5MDR6NnhBWWh2ZWpj?=
 =?utf-8?B?YUlyQUdvZTM5SWVsM0hPZm0xandUVUR3aFNWTTNTY0tNRzVqL3JhZnVGYTBw?=
 =?utf-8?B?YjhkbXR0aG0rc1lZSmtrUEtDQS9jd0NSR2dsbHIxWWUvN3U4TGhnemsyaC9h?=
 =?utf-8?B?cTRVeUxEdW5ZaGkvVXVFeVpEbVREZWZHR0N2ZGNqSm9XRDFNcEh1MXlONjlL?=
 =?utf-8?B?SW1PcUJTYzRONVFld3ZZUVdvRUZld2pDYWhRQXROTVZIQVhTMHoyNEN2a2xO?=
 =?utf-8?B?MTgyNVpCYlpPS1p4SnUwUlZKUDdsQTM0YlFjUGlJMXJUWG42b1BPTkVKcGtv?=
 =?utf-8?B?VWZLRXgvVTNrRHFkbDJhVWxkdGdTZVFrRHh4eCszMGpYM01OdmszdUJra0xZ?=
 =?utf-8?B?WGsxbXg0QkNrV2lQNTJaKyt0QWpuNVNMeUZHd0JZQi9neGxRSHA2M1F1Y1Rz?=
 =?utf-8?B?aDBja296VkRjZ1VnQzk4VXNJNGZNRGpzbjRKTHRSdTlBM1RGSkJmZjRveHkv?=
 =?utf-8?B?OU1jUVVvS2FjU1VlWXFLZWZFL01zZ3N5YUs1RVhadnpPeC9qUUF0Q3JPZVMv?=
 =?utf-8?B?dkJscUdDZHFlcmZ1NS9IOXlJYjRCNlhOTVF6TC9tYVFMdnRVKy8vVWQ0Qkoz?=
 =?utf-8?B?OUVKeGtFWHhzakdqNjBTaUpkSVZWUHNjWW1aVjNyU21HaXgyUU5BRk15Qks5?=
 =?utf-8?B?L0UxeG5ZSlBVY0ZXaGxnckJLZGR0T1hFWTlRSG5ERExzSUxXaFBIZERjWnND?=
 =?utf-8?B?NkF6K1Nra01NeFdoRXBMRVJWU2c1dk51T3lPekhmRTJBRUVsc2htTkJtOTVo?=
 =?utf-8?B?Smh3cFVXNHpVSnBRUXpyVTFzWEN5SkV3djlheEN5UzBvc3pGalVUNit2cTNN?=
 =?utf-8?B?NXhkNWxMK1J1bGNubGtEM0ZxRGgrWndpekJQUUF5NjF1eUJMSjBxK2lLVlV5?=
 =?utf-8?B?bmthZ0xJVk53b1lCdEZJMnBjeG94VVc1VzA3dHVGRHlDOXk1RzZFaFVXTjla?=
 =?utf-8?B?emdvR0d1cSs1cm5OWE5NMFZ5VGpNT0IrRFdFcWVITDBzeVhSSGVCQ2o1d0Fo?=
 =?utf-8?B?bHR3RVZVVFJDRzNPcmtzT096VXkyMGl6YU1Ld1NuWmVlZlM1QjNmTHJaRzB2?=
 =?utf-8?B?ai9GTFN4U2E3dklJWHQ3UEUvR0lVUkRZblVXc2RiNkNFRitWZ1QxSnlaTWlY?=
 =?utf-8?B?anB3OVdFS3B3Vko0bHYyL1YxOHkyVk9ZQkxRaE8zaUFoaXNFcU9EYndsbXBr?=
 =?utf-8?B?NWJUUnJYanpyMjZzZ0c1TzlqUWVHUDNGeC9mWlp6QTZaRlF4K2lpK1BtT2I3?=
 =?utf-8?Q?T/j9T8qz1TgBuEWbSj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77516e90-6988-461a-71d0-08df2447d533
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 07:51:45.0632 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HFA8Azy6VEx8eQNP4cBAiAniuMoaWXmeP7Z17twlnQE2LmYzwQeee676SkIPQ32M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9514
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

Hi Matt,

On 10/6/26 21:15, Matt Evans wrote:
> The dmabuf release path is split between file and dentry release:
> dma_buf_file_release() is called shortly before the file is freed, and
> dma_buf_release() calls an exporter's dmabuf->ops->release when the
> dentry is freed.  However, the dentry can outlive the file (for
> example, if opened with O_PATH), meaning .release might be called some
> time after the file is freed.
> 
> This presents a window, when closing a DMABUF file, in which
> dmabuf->file points to freed memory yet .release op has not yet been
> called.
> 
> For VFIO, if a buffer's .release has not been called it's considered
> still active and subject to move/cleanup.  If so, it attempts to
> get_file_active() on dmabuf->file: a file close with dentry held open
> will call this function with a stale pointer, a UAF.
> 
> To make this pattern safe, set dmabuf->file to NULL in
> dma_buf_file_release() to reflect that the associated file is now dead
> even if the DMABUF is not yet gone.  A get_file_active() ... fput()
> sequence concurrent with a file close will only execute as one of:
> 
>  - Gets the file before file_ref_put() (dmabuf->file valid)
>  - Observes dmabuf->file pointing to a file, but it's DEAD (no file)
>  - Observes dmabuf->file = NULL (no file)
> 
> Originally, drivers could assume dmabuf->file was valid until .release
> was called from fops->release.  This assumption was no longer valid
> after 4ab59c3c638c6 ("dma-buf: Move dma_buf_release() from fops to
> dentry_ops"), which moved the callback to the dentry release (by which
> point the file might have been freed).  With this commit, drivers must
> still consider that dmabuf->file could be NULL before .release.

Oh well, really good catch. And that problem is wider than this.
> Fixes: 4ab59c3c638c6 ("dma-buf: Move dma_buf_release() from fops to dentry_ops")
> Signed-off-by: Matt Evans <matt@ozlabs.org>

We seriously need a CC: stable here.

> ---
> 
> Hi,
> 
> This issue was found (by Claude Opus 5.5) in the context of VFIO's
> DMABUF export path.  VFIO iterates live DMABUFs with a
> get_file_active()/fput() block, which now becomes safe if the file is
> closed (and memory freed!) yet DMABUF .release hasn't yet occurred.
> 
> However, there are a couple of other places that directly use
> dmabuf->file and seem able to race a closing file (i.e. without holding
> the file reference)?  If this is so, they'd be a UAF today; with this
> patch that goes away, but instead of a stale pointer dmabuf->file could
> be NULL:
> 
> 1. drivers/gpu/drm/vmwgfx/ttm_object.c:get_dma_buf_unless_doomed()
> 
>  file_ref_get(&dmabuf->file->f_ref); on a non-refcounted DMABUF
> 
> The commit message of 90ee6ed776c0 ("fs: port files to file_ref") hints
> this might be more subtle than replacing it with a get_file() variant
> (so as to accept a NULL file *).
> 
> 2. drivers/gpu/drm/i915/gvt/dmabuf.c:intel_vgpu_get_dmabuf()
> 
>  gvt_dbg_dpy(... file_count(dmabuf->file) ...);
> 
> 
> Respective vmwgfx & i915 maintainers, what is your view?
> Or, indeed, if anyone sees any other questionable uses of dmabuf->file.

*sigh* we had multiple occasions suggesting to add a dma_buf_get_rcu()/active() because exporters wanted to keep their DMA-buf on linked lists or other container structures.

That was always rejected because the DMA-buf framework had never guaranteed that such things work correctly exactly because of those lifetime issues here. In other words nobody thought that through and document what should happen when etc...

So the use cases in vmgfx and i915 are just the tip of the iceberg :)

My suggestion is to get this patch reviewed and backported first and then come up with a dma_buf_get_active() function including documentation and comments and test case to make sure that this feature works *and* keeps working.

One minor comment below, apart from that the patch itself looks good to me.

> 
> Thanks,
> 
> 
> Matt
> 
> 
>  drivers/dma-buf/dma-buf.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 4c9add51f9ef..726639130477 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -193,11 +193,15 @@ static void dma_buf_release(struct dentry *dentry)
>  
>  static int dma_buf_file_release(struct inode *inode, struct file *file)
>  {
> +    struct dma_buf *dmabuf = file->private_data;
> +
>      if (!is_dma_buf_file(file))
>          return -EINVAL;

I would do the casting only after the check.

On the other hand this function is a callback of the file_operations so checking if file->ops is really pointing to the file operations is completely superfluous.

So if you want to remove the check instead I'm perfectly fine with that as well.

Regards,
Christian.

>  
> -    __dma_buf_list_del(file->private_data);
> +    __dma_buf_list_del(dmabuf);
>  
> +    /* Must be observed by __get_file_rcu() before file_free() */
> +    smp_store_mb(dmabuf->file, NULL);
>      return 0;
>  }
>  

