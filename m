Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28CB0CA6007
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 14:46:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81CEF10E5D5;
	Wed,  7 Oct 2026 14:46:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rGBg8dy0";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013052.outbound.protection.outlook.com
 [40.93.201.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3119510E5D5
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 14:46:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j8srN5KoUALb/+4JNsrCKbLeguzflzqAe+XCKyC/NKoZnN9hLBFDBX0DIZkyQH19ix7dxANdw+3Z6bg6jFqaim33CtXoy9c/83c6IIKDAQA23TSGNU+UJKXqKTGw4xc9LucI9SvcUcWA4YhKtZHQ1HaV8+97P3KhBW2i7+YTxqtHQxes4RrOSqLRjt/mpQQGWQC7ehUf7IqS7of8g0MpP0OWttdvIi+PvESf1ycTBt+kS/S4BpGkZBv7M+s5Z9ET+kdzysHD4Yms5DJbf39XehdOpSIzPOSat6gEKhOlS+Icilr+ko1lDg1jKdMGL1QeaM/gDtbrS/Ka11PlpsR+Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCmsi7eNL+BenOgDqs0hDO8ORFndRR+I5TUdwwsOL4o=;
 b=OnxK1SMhb7nHOEFYqrU6EzKJIh2LoOrf5+ALpDic1n8kjBg0VW+xIzV5AxMzuZU3cIimVzQlyDdHP0X7NFkcdIx5qFZxNhxntqK2kCXo5+sXoJW7ZiBgWW0+gyflGFeoTQmJ2GwoIq0Ft+FKZDGv+3YHFjBDRmxmt707lZsdxgDg9i5frmRV1aDwapZJy/psDcpPSF7+KQHrm2TN5N4O8Qxpb4Tnez9d9jxRCCY+w1Mf0z1yM2LzAsaLSn55LhOIL9S0LoCx8VAkiZT+GhKjdAxoVLtWNo6zpkxR1rZrLradSlHr5JylFm+dtbCUm2q70Np0dXBnoonE/bA3WforEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCmsi7eNL+BenOgDqs0hDO8ORFndRR+I5TUdwwsOL4o=;
 b=rGBg8dy0BP1Ui4PbLNnJ6Rid3Wgw4YHHWxejoc8g4/VYOcRmPXuNiPsU/jUJKBNeBIj+DBjYW+CKEBxz+WRW7R/a+1ml3WgnKDXw226/rK/3IlOx0/Hgd3rBQ6ijqnh83O/aCqswocoF6o8nG6+JdfWS2OeTRUCgZJRFjrf6mNA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 14:46:09 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 14:46:09 +0000
Message-ID: <ab9a6547-b523-44ed-9881-0dce22ad1470@amd.com>
Date: Wed, 7 Oct 2026 16:46:04 +0200
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
 <7e8b332d-04a9-418a-95f4-de3cbd8b8a33@amd.com>
 <af2e03ca-718e-40c9-b604-8035eb8f30bd@ozlabs.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <af2e03ca-718e-40c9-b604-8035eb8f30bd@ozlabs.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0242.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4175:EE_
X-MS-Office365-Filtering-Correlation-Id: 44eee676-1b55-4c4a-7577-08df2481b97e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|23010399003|22082099003|18002099003|4143699003|6133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: bVZyPXXXY+ybkJRHJb/OFUiDc7hRLgzVOIve7vKcIvuPlGYHR0nMeK1zNeYjW7M7KhH3GRmV1U1Wd/6W1Vn+MZORt3mvOjz+k4u6per/ZSa8jb+XhsrkAfzneXvFp8SmszgeE2rvKmhsuA+grAa6YoWZ3H/4ZoyM4lMzaEUiB8NnnNBzpDxc92iCzCyLM5zgIuFBviRPkqTcUz84E178eoUxyfXKfbnf4L/6Eq4AM/Y5L9MIWZCTO9uQhTIAiLpecmj2J8yOLXDCKHWbtW+1llQ/D8jAVIoavRnFhuTWP9SkWinw57Ke+WRUcbdc0BE9XRAjL7VRWeNjfpbj+G52fEmiZZeKzCLwPcAsfwKQ8M3uo68A8pRylacFvOoisGOU9paehqHiLSo14TbuYmTWzwY+AEJooAz8GH2Xgi/CY+WyzRd/MFK1+ui/Ew4dFAiSe2S8OVYoVbtZF9ecwViBtBV9DktGv3UBCjADMQtfyzKQXmWxvtlAW8PlTWP/kxF6LjLEwjef6pX60nA8F2Us93o/LLhcioAIK9f39IG2DzWVnPE/1t0KgKG0+kxQDVTOddXyqUm9YZQgDAfXpWCEem0s8E9PRtmyzbGa2mfgob6KBAEEbDu6aEh/A3wb1hUl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(23010399003)(22082099003)(18002099003)(4143699003)(6133799003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0NZaEloU2hnNjlhRGw3cGhTWmpPbVhvY0xoQ3YwY0xvTjNQVXN6K3RCUFBy?=
 =?utf-8?B?ZitMeG9mZ0F6Y1pMV0hZR1Nubm9pR2hUVFRacnI3WG5pRmVLU0llSzU4SUU3?=
 =?utf-8?B?YXU1M2dEU0szNmliamN3blpHck55eXU4V3FXSm1aQ0xBQmc1WEt1NkhqNWZa?=
 =?utf-8?B?WXczQngva1RCeHladC9zN1c1Y2swWi9URGRzeFNyS2ZhaG9QWVIrdjRMNFJV?=
 =?utf-8?B?RWh5U3FQTmcyNGx6VFFSbXpXWEMxTXRmbm9Hekd0MVhWbStTRkU3czQ3NWJr?=
 =?utf-8?B?akVFV0Rob0Z6OVZSaXhmY3gyUVh0dklKMlM0MlJqZkNPNURWSTVZSUE1eEQv?=
 =?utf-8?B?WVA2SmRDZm1QNzNiWkJEd3hheHZjdGJZYUhpa3RiRldIRUlLNVpWT3RWR1VC?=
 =?utf-8?B?cEd6YUxQeHVRMm5xcTJoenJpeTJzTU1MWHRPQnp2RlNtYitsNzFzSGhVeTBK?=
 =?utf-8?B?bHVXS0VzN29VYTBzdWNSUEFuNWxmd0F1TlQ2MkkrT0dwaE1VTXB4TFg4ejAw?=
 =?utf-8?B?ZUtOcHRJT0ZFTnp5QjhJb3hHSDFaSm8zUWplZk1US0RjRVk2czlnU0NUTm9X?=
 =?utf-8?B?UWJyb25heWtaSHZFVmFBK3o0dEc1SndvSXRlSHJpSzFIVmE1SXB4VmFwWWNZ?=
 =?utf-8?B?d01uMUtnd28vYXlORUdzcWl6TGEveXJodGN1bzdldC9pYTB4Z1JucXQyZThB?=
 =?utf-8?B?YzJ2SXdpN2JFZ3RuMGJOR1l6ZmlIeVY4QWdHRFloZzRhUG9mWVBQak12VENl?=
 =?utf-8?B?ajJNc3gxbEN6Tk9MYzgzb0NNUDNER1ZxbkVEVFkwalBCN2NKeUlvVnlCQ1Ro?=
 =?utf-8?B?RjRkYk12MFlZVmJtM1duUVNWekR6YVpERklXVXhhbW4weS9KTWU4dURZWlhq?=
 =?utf-8?B?NGkzTTlHRnBhcDdEaitxRGZPbVBPMlNhK29jd0VKRlMxWWlqeURuY3hyYmt6?=
 =?utf-8?B?WlBPbXJkeHZuZE1FMlVXSmRJODBHdVQrU1pjeVQ2dDZkaUtsZ3FOWEIvUVJ4?=
 =?utf-8?B?M0NFOXJLa0dwT3RXZXRRT1JqNkg5VFdFZ09yZFVrOC9FZDNyVURyR25FaGJr?=
 =?utf-8?B?aGRJY3MwZ243OW5lYzNrc3E2WTlSTVhtc3pDMzQxTEV4ZXc0RFlmUXBMamJ0?=
 =?utf-8?B?ejd5dWsrZGE2dzYvU3lEL2lvTW9RbGRCTXNSdTNMODN0UkFlclBZd2ZXMXZ3?=
 =?utf-8?B?SkJrMFdIUFJTNXA1WkZ1Z0I1VDRwbnk1eVBaNHQ3cFlBM21QTE53TFo1aUJM?=
 =?utf-8?B?d0FlWDVUTm5ob2s3SkQybm9Gdzc3V3VFMlhIM0g0ZmxkN3VMUFZrWmlybU41?=
 =?utf-8?B?Y2JnNjl5cmdQOUttTnltVEwxRW9COFcwcEQ3UFJpTjE5Mm03ZVl5T3FsV1Ri?=
 =?utf-8?B?NlZ0enZpMjViN2Q3OVRJd3UxVWI0Ym1ZSHFLRWxVOEZJVVZtM2hyVWo1OUFU?=
 =?utf-8?B?d09JbmxqRVFPMUNlMTlLT0lmcFpPL0x6d2tuTjRBRFlsVDM3OGk2Y2p2NThT?=
 =?utf-8?B?Vjd6TmJPY0h3QUprZWNyRnZRbHVPTDR2bTZqUUhoUk5LWlZ5YUtkWEhId0sy?=
 =?utf-8?B?RFpzVG54em9SZG1ZZEVoM3libHc0WjhLZ3JmWllMdldMVEVGVm9kZGxSUExu?=
 =?utf-8?B?UGgra1ZDcFY5WGVubUtibjNPWTJRWWZsM3ZrR2hrS2FHeG5RdnRoK3ZKaUlL?=
 =?utf-8?B?R2V2cy8zWXJVWVVGQWY2dlJEN0tlaHJoaUw4MTl4b3IwWElJVTBLQ2xKMjMy?=
 =?utf-8?B?elZVeWJPT29YOTBrVUM5THNabzg3TmtVcjVad0gxRlZWK3psN01XSXl0RHNH?=
 =?utf-8?B?VW9QUzJpWVNLVkdRaEpoM2pobm9aemt1V043bEFWbGZVZjUycldsdnh3blQ5?=
 =?utf-8?B?RU9scTEvZk4rYnZ3dGdWZFlSNFBBRGJISS8rMkNBaVQwVmIrTHRGT2JGazRF?=
 =?utf-8?B?RDZ2eGRtUXMxY1cyZU52WW0yeHY2SGNHWFlLQU5BVjFycU9oVTgrbkl1YUdW?=
 =?utf-8?B?bFpMQVI4TjdKM1NaYlNJRlVNMmpRSEhzcGVSUEpUSlVOV0t5S0hnUEpFcGpL?=
 =?utf-8?B?VlJZaFRqN2MyckZ1NnF3MUhKbjdqUTVVOURFTm5YUDB0Q1IwWXdXOEN0U1ZN?=
 =?utf-8?B?L1Job0NzYlhhcW9FMStLRzUvcnJmQ0x6aS9aZ3MzYjZUd2FtU0hGZ0NFc0hY?=
 =?utf-8?B?bzJWZFdYaXd2bDR0cmtvWTlQQzM0TFpjeU9YME5tRllRQm0xVG9hQVN5emZX?=
 =?utf-8?B?RHZiZlkxMnRGQVpmVjFraXdwRnVVN2Y2R093cmV4S3UrbGc5cjMyWTdqbFl3?=
 =?utf-8?Q?ej+C2WVh0y+4fUVzzW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44eee676-1b55-4c4a-7577-08df2481b97e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 14:46:09.3157 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 49aTTRvaixMXKSSEedBF5Wg+MciKUBzvilp+uVs1bSlGQp/r59Ib25ekvox7ebq/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175
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

On 10/7/26 16:29, Matt Evans wrote:
> Hi Christian,
> 
> On 07/10/2026 08:51, Christian König wrote:
>> Hi Matt,
>>
>> On 10/6/26 21:15, Matt Evans wrote:
>>> The dmabuf release path is split between file and dentry release:
>>> dma_buf_file_release() is called shortly before the file is freed, and
>>> dma_buf_release() calls an exporter's dmabuf->ops->release when the
>>> dentry is freed.  However, the dentry can outlive the file (for
>>> example, if opened with O_PATH), meaning .release might be called some
>>> time after the file is freed.
>>>
>>> This presents a window, when closing a DMABUF file, in which
>>> dmabuf->file points to freed memory yet .release op has not yet been
>>> called.
>>>
>>> For VFIO, if a buffer's .release has not been called it's considered
>>> still active and subject to move/cleanup.  If so, it attempts to
>>> get_file_active() on dmabuf->file: a file close with dentry held open
>>> will call this function with a stale pointer, a UAF.
>>>
>>> To make this pattern safe, set dmabuf->file to NULL in
>>> dma_buf_file_release() to reflect that the associated file is now dead
>>> even if the DMABUF is not yet gone.  A get_file_active() ... fput()
>>> sequence concurrent with a file close will only execute as one of:
>>>
>>>  - Gets the file before file_ref_put() (dmabuf->file valid)
>>>  - Observes dmabuf->file pointing to a file, but it's DEAD (no file)
>>>  - Observes dmabuf->file = NULL (no file)
>>>
>>> Originally, drivers could assume dmabuf->file was valid until .release
>>> was called from fops->release.  This assumption was no longer valid
>>> after 4ab59c3c638c6 ("dma-buf: Move dma_buf_release() from fops to
>>> dentry_ops"), which moved the callback to the dentry release (by which
>>> point the file might have been freed).  With this commit, drivers must
>>> still consider that dmabuf->file could be NULL before .release.
>>
>> Oh well, really good catch. And that problem is wider than this.
>>> Fixes: 4ab59c3c638c6 ("dma-buf: Move dma_buf_release() from fops to dentry_ops")
>>> Signed-off-by: Matt Evans <matt@ozlabs.org>
>>
>> We seriously need a CC: stable here.
> 
> I knew I forgot something :(
>  >> ---
>>>
>>> Hi,
>>>
>>> This issue was found (by Claude Opus 5.5) in the context of VFIO's
>>> DMABUF export path.  VFIO iterates live DMABUFs with a
>>> get_file_active()/fput() block, which now becomes safe if the file is
>>> closed (and memory freed!) yet DMABUF .release hasn't yet occurred.
>>>
>>> However, there are a couple of other places that directly use
>>> dmabuf->file and seem able to race a closing file (i.e. without holding
>>> the file reference)?  If this is so, they'd be a UAF today; with this
>>> patch that goes away, but instead of a stale pointer dmabuf->file could
>>> be NULL:
>>>
>>> 1. drivers/gpu/drm/vmwgfx/ttm_object.c:get_dma_buf_unless_doomed()
>>>
>>>  file_ref_get(&dmabuf->file->f_ref); on a non-refcounted DMABUF
>>>
>>> The commit message of 90ee6ed776c0 ("fs: port files to file_ref") hints
>>> this might be more subtle than replacing it with a get_file() variant
>>> (so as to accept a NULL file *).
>>>
>>> 2. drivers/gpu/drm/i915/gvt/dmabuf.c:intel_vgpu_get_dmabuf()
>>>
>>>  gvt_dbg_dpy(... file_count(dmabuf->file) ...);
>>>
>>>
>>> Respective vmwgfx & i915 maintainers, what is your view?
>>> Or, indeed, if anyone sees any other questionable uses of dmabuf->file.
>>
>> *sigh* we had multiple occasions suggesting to add a dma_buf_get_rcu()/active() because exporters wanted to keep their DMA-buf on linked lists or other container structures.
>>
>> That was always rejected because the DMA-buf framework had never guaranteed that such things work correctly exactly because of those lifetime issues here. In other words nobody thought that through and document what should happen when etc...
>>
>> So the use cases in vmgfx and i915 are just the tip of the iceberg :)
> 
> Yay :)
> 
>> My suggestion is to get this patch reviewed and backported first and then come up with a dma_buf_get_active() function including documentation and comments and test case to make sure that this feature works *and* keeps working.
>>
>> One minor comment below, apart from that the patch itself looks good to me.
> 
> This makes sense to me, thank you for the context also.
> 
> Just to make sure I thoroughly understand, do you envisage a 
> dma_buf_get_active() to take both a reference on a dmabuf and its 
> corresponding dmabuf->file so such users can move to a pattern of get-
> test-use-put on the file portion too?  Sorry if it's a silly question, 
> I'm not sure what to search for.

Yeah that won't really work. The dma_buf object uses the file to handles it's lifetime and doesn't have a separate refcount.

I'm also not even sure if adding a dma_buf_get_active() is a good idea or not.

The problem with dma_buf_get_active() is still that it only works in the exporter *if* there is a common lock hold while calling dma_buf_get_active() and the cleanup inside the ->release callback.

That is totally specific to each exporter and can't be used by importers at all, making stuff like that available to everybody is usually a recipe for trouble.

Maybe it is better to just properly document on the dma_buf->file member that exporters can use get_file_active(&dma_buf->file) but need to keep a bunch of things in mind.

See below for some more thoughts.

>>>  drivers/dma-buf/dma-buf.c | 6 +++++-
>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
>>> index 4c9add51f9ef..726639130477 100644
>>> --- a/drivers/dma-buf/dma-buf.c
>>> +++ b/drivers/dma-buf/dma-buf.c
>>> @@ -193,11 +193,15 @@ static void dma_buf_release(struct dentry *dentry)
>>>  
>>>  static int dma_buf_file_release(struct inode *inode, struct file *file)
>>>  {
>>> +    struct dma_buf *dmabuf = file->private_data;
>>> +
>>>      if (!is_dma_buf_file(file))
>>>          return -EINVAL;
>>
>> I would do the casting only after the check.
>>
>> On the other hand this function is a callback of the file_operations so checking if file->ops is really pointing to the file operations is completely superfluous.
>>
>> So if you want to remove the check instead I'm perfectly fine with that as well.
> 
> I had given the unfamiliar code the benefit of the doubt, but this did 
> look a bit suspect!  Will do, thanks.
> 
> 
> Matt
> 
> PS: I should've mentioned that Alex Mastro has kindly built a reproducer 
> using a VFIO DMABUF export and dentry-held-open scenario.  KASAN will 
> detect the UAF:
> 
>  https://github.com/opsound/vfio-dmabuf-lab/blob/main/tests/vfio_dmabuf_opath_uaf_test.c
> 
>>
>> Regards,
>> Christian.
>>
>>>  
>>> -    __dma_buf_list_del(file->private_data);
>>> +    __dma_buf_list_del(dmabuf);
>>>  
>>> +    /* Must be observed by __get_file_rcu() before file_free() */

This here needs more meat and really explain the "why we need it" part.

Regards,
Christian.

>>> +    smp_store_mb(dmabuf->file, NULL);
>>>      return 0;
>>>  }
>>>  
>>
> 

