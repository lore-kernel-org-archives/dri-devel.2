Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56653C5CFCF
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:37:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A074710EFE0;
	Wed, 12 Aug 2026 13:37:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BHAv2IXR";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012047.outbound.protection.outlook.com [52.101.53.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C5D110EFD0;
 Wed, 12 Aug 2026 13:37:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u09h7th893zeEMoi2EcZF2fNJR+NY1ABsdkn3lIgKk0SRwOKHgVKo4AuG7YdEf4LyEE3R3RScwcTBATyD8/d10KzDm4p67tAz/v105Siu4o4XHqhqx6M/SEZ317e/Olkfli9hRfRpCz6QOnypztT8YEjY/7QWJALD0PDBrgkDbCG0nEzse/8CITOzHKdSAC8cgA7MKv0zK+GPMZife7ongN4Mppk31rcZqitI5mc0u08SK6mTkz5+5h2ek+hCHdIs9BsfMHiDK7pq2K1LQWzeCDVmGNVZdKTjOR4S9wUcTPhQa19O7l/66TjGEzw2TV89ScGq3KcXCa3B67t5STGhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3mqDFESyPt0WVQFGvy3tOzi7HxXeIYPXOid3xhvXeRg=;
 b=JHou8Rz7XM9ntUFAH9GBj+5m7m9E4OvlEvGFJMvmAIuvOZkRcDolwd83gu5okmB+qtPlEg8X1VNFjFRKwa+TsmmzlKqdfNZLeDLzY8onf4s2qQvh84MKuzlJJiarQMD0iOOw9Bo39DnOIO/HtlVVisKGoqNvJzoYryfjA+aTyrDVphklgODH63NTXKkm8CG+KwXobELoj6TbToMMG7LhAICoaxoCSNvV/fPMCNTf9N3FucI4t5JdcKjTKlg9EYzSAzg1pbfxYZqToaksr4qWBbrpUccHC1MaK+XRnCoqLIHchlq3F1PMb2vsNEv9RyjK/GMLIVMnG4wC6y9+p4qSMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mqDFESyPt0WVQFGvy3tOzi7HxXeIYPXOid3xhvXeRg=;
 b=BHAv2IXRq0OY2sJzfNGG3GN+kembcr9kQALgHFoCPvbWn7lD8hETNdHA+606WhBWImzRyc1sJX9HvbOK7Sh+UNtJaxDHHqWOHXWjJKbEpvwbOslB0CokH+tDeqQmmarK3GWKCirALRbWihazDJl2C3q1AiSRT/Jla5uTGvazIMw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA5PPF37951B1C9.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8c6) by SA1PR12MB9001.namprd12.prod.outlook.com
 (2603:10b6:806:387::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Wed, 12 Aug
 2026 13:37:21 +0000
Received: from SA5PPF37951B1C9.namprd12.prod.outlook.com
 ([fe80::2ebe:b9c2:13f5:89fb]) by SA5PPF37951B1C9.namprd12.prod.outlook.com
 ([fe80::2ebe:b9c2:13f5:89fb%8]) with mapi id 15.21.0315.012; Wed, 12 Aug 2026
 13:37:18 +0000
Date: Wed, 12 Aug 2026 21:36:55 +0800
From: Huang Rui <ray.huang@amd.com>
To: Christian KKKnig <christian.koenig@amd.com>
Cc: "Huang, Honglei" <honghuan@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Xiaogang Chen <xiaogang.chen@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Jenny Liu <Jenny-Jing.Liu@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>,
 Junhua Shen <Junhua.Shen@amd.com>, Yiru Ma <yiru.ma@amd.com>,
 Simona Vetter <simona@ffwll.ch>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Thomas Hellstrrrm <thomas.hellstrom@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v9 02/18] drm/amdgpu: add SVM core header and VM
 integration
Message-ID: <anx29y9NdLSrkkBk@amd.com>
References: <20260804094246.1719318-1-ray.huang@amd.com>
 <20260804094246.1719318-3-ray.huang@amd.com>
 <ee51e993-705e-496e-89f4-c5d0196c8951@amd.com>
 <b12d31fb-f9f2-4e09-a0fe-21f2d6bb7999@amd.com>
 <d9439960-3e65-4fc9-921d-02a6052655c2@amd.com>
 <e4e1acc6-c8f6-47af-b3e2-cd4bb396bbde@amd.com>
 <ffda865c-2f2f-4b5c-a21d-6d0ef7c1b10a@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ffda865c-2f2f-4b5c-a21d-6d0ef7c1b10a@amd.com>
X-ClientProxiedBy: SI3PR03CA0009.apcprd03.prod.outlook.com
 (2603:1096:4:297::17) To SA5PPF37951B1C9.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8c6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA5PPF37951B1C9:EE_|SA1PR12MB9001:EE_
X-MS-Office365-Filtering-Correlation-Id: c3d377f9-e6de-49a5-f906-08def876d413
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|6133799003|10067099003|4143699003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: CZYTCi8XQzMpP+Tg0iYs98gH/OgjH3YqmcJO6j/kCZTjDVCzSY0j8Kp2OO2fILNwa9wwCBSiyzO2FJGWUWtltn9Put0D+xCJldddvOgIwd76wJVmD/ICJPT4bXOgnxeuCQkILY5cYa3KY/6mms0s67Av1PdcjwdqlKylCNbtJhVkcwSK9m55mKfQrLLey8udtg/8qxsTCpQ4TQoMoc3tRGyppOII4BJmfrmyssW53yK+T9qhCnMddldDhsKaMbxbZ33MdaRpxvw4aBRXJbZdukT4u7yurEbTFOsTkxck6aDsbDKql4wWvEjK18YCajBcSZjOyptj78uIitTAdG/9LhQ+2xyNbQie/TcNL+baj4H7/eFfBPd9irT+0s+9hE0l8NQAJyXjgMfHeVjLecWNKFpin8rR7137xRKgQjYgcxgVLsTx5w9WBR6bjuWKaRc3x3XKDX+tgPC+kaz2zPxvgIbqj5+Y47LZpnlAEy0PqjCMZHZgEBCsFkVN2MiPQQkpSHy79zXfT0K/A4Ng7Qi81mp0BFrpmf1/31ikohlQ2zIOi/K0RHZ5b+3YwL9iuJl39PeWUqLa3vyQP20Wy+01geLprn+iztYA6WcIXTr48BF1Ex9xokPBIdXMCTpPY+l2Da9tc16Om+l9ngS41ErER9Mjs07woWVIERbNlzPf0Q0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA5PPF37951B1C9.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?UiaDIrDtpAdBU0jVw1vsmp2mKp0mZnIhHyif7AMDalZZK83U1LKdSZopVR?=
 =?iso-8859-1?Q?JJSfzJMIhr3R4w+dAONgYjVmtWvjPumpm7Uq+uM6zvRiKjUlz9xt0ZsYrp?=
 =?iso-8859-1?Q?9OUlxNmcVP1XN3eQpbucAbhDqeRMu9JI84duHEqmN8/jdzrhSDHX4wdLU5?=
 =?iso-8859-1?Q?mysDM8FqJZoBxHFDx/BlQ4+ulmzwjaEp8BU31Fm7A41XrutxI7c24LHMiR?=
 =?iso-8859-1?Q?HmIhgCbOUC/MUQMOW7SznBQQTKImsfMeavAiTZ3bbnLAQLzilVKxWQSPX8?=
 =?iso-8859-1?Q?iwQBhgXei5tITZkMQoEcJNLuee76bcIeIlnWZQzO1CoDILhjwxZMpi7dab?=
 =?iso-8859-1?Q?EzM2hZmgWFOvzdB9qjqhdzF3v2gzwBxbMi9Z4Jn9BCXcaTkzkxK6QX3VxF?=
 =?iso-8859-1?Q?ki+2atf2SjJAq5h3riT0aJFdMIOtD9EogADa7p4lG36/0uge+S3weWm2zM?=
 =?iso-8859-1?Q?ipdqb/WQiEXJaK8DOn5EWGnrtwytvRPgMIyndPn1WrNuQka9HccYICYOPS?=
 =?iso-8859-1?Q?E2XFqXbcHU0LIooAQVzFPx7y4iHQ2DLQ37Z3U3z5HiLKPTRXatCVzbleMU?=
 =?iso-8859-1?Q?r0MPXGqMHwV7uihYo3/hMJwtTQvKGW8owqhbdCYSKuwpeMnLiEUU0TKh/n?=
 =?iso-8859-1?Q?bNyzn+BPY/wvzhwjKVdFfED+SExufQk2u9ZXrltus5P47IaWRLSXvzQcbF?=
 =?iso-8859-1?Q?0WpDzU0VwcEZCAzBovlGauBT7Pkzwr9eBHokfVn1GJkX6rWEEKIb/qfsMk?=
 =?iso-8859-1?Q?7y91N6ZHVOuDQc768EhTiMNYx4lvgZT1ckZbeNXykbWnvkZUX52VRooMOP?=
 =?iso-8859-1?Q?YCGVoG3gvSzu7hw40KxuHwhrxU9LzFYuoN3GDBGqw+e0RMm0V7QKAiBwAg?=
 =?iso-8859-1?Q?m0GS4CZbIZK14IoJEALQ0E4aVQTzakBGetzHedkIPAc7frhnRu4Jajwp6u?=
 =?iso-8859-1?Q?Y52q0QMsdDM2xC94+luJgNfaCFOfBQrnkzwB5GSzgye7EMiTHGsFMbhw9X?=
 =?iso-8859-1?Q?iRaSoLpvu8/yI6uoU+OdwtriqoBZQAnai93IrbxzZA1fuArmUTo8yElvs8?=
 =?iso-8859-1?Q?yWGWBUP0y8v+31i5Wj1exY2IYxjj3nfcD7gKWRDq6Y+hicUE3xZopSDGui?=
 =?iso-8859-1?Q?BrOLhDgzwCcVP1Uyu8M1gzaDA4R1oynWrpV4sr+oXTUo8/FoG0sBN2W59i?=
 =?iso-8859-1?Q?tqtkD2D6c3N0AVexyzxgPkXKAhINAZruRIvZbsfvL/QZxOvWxsj0iTHWMr?=
 =?iso-8859-1?Q?jxGpbyhuL23im9UJwE2ZgwFfonwJS4hofujn0xUV8OwOoosH3L0jXLcCd7?=
 =?iso-8859-1?Q?x9Zc/n80J37ll/qUPmHLawwz16PlAR3FLhFFipM58GucdoVmdmyAPsk5gq?=
 =?iso-8859-1?Q?qu2I34RXmP7NUK6ivHyHNMyP3VC8vY9gM8anzH5I3ItgHdci95TRARlE1K?=
 =?iso-8859-1?Q?WkzfNGBX3eYVUcK+4/tVaP3KWrGE5/jYRTITjo3FTKtPv7TBH3iyY9DPxK?=
 =?iso-8859-1?Q?qREbdkbe5FLBXdIsMIoAvHPOaa86VGZwtug4W3Zxe+tFgXTY87vHugNW7O?=
 =?iso-8859-1?Q?hQaPWmd5MgvbmIbVDMPgbby9XSbt9Hg1uI3v3kZ/hB9evKTU1zGwytHuaE?=
 =?iso-8859-1?Q?LGk9IJoYV1WPQtBorghD4xGkuNfUcJy5QtxtPZrqVDtEqjoCPyrKEznFEr?=
 =?iso-8859-1?Q?NZz1ioY0eqE3xehrJQapcPyvBGzw5mdL6ev6xypsRTej8/cvJ4erAsVl1p?=
 =?iso-8859-1?Q?IFmbKmwqZC57iRvzRalN6Uw+YZ5ueFDNfle+QSCrBZiZrtX7SgVa6uSk//?=
 =?iso-8859-1?Q?KxiBsLljcQ=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d377f9-e6de-49a5-f906-08def876d413
X-MS-Exchange-CrossTenant-AuthSource: SA5PPF37951B1C9.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 13:37:18.3894 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T/6RaKBWVZrLvqqfwxUon021TMuMl+nLP1/ERm0UeEmFtfyoLcMzrU/XDFcpPFgMD2X5iENXICydJmZnv/Xq0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9001
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

On Wed, Aug 12, 2026 at 02:16:03PM +0200, Christian KKKnig wrote:
> On 8/12/26 11:55, Huang, Honglei wrote:
> > On 8/12/2026 4:36 PM, Christian König wrote:
> >> On 8/11/26 16:06, Huang, Honglei wrote:
> >> ...
> >>>>> +/*
> >>>>> + * Helpers for amdgpu_svm.svm_lock, the driver_svm_lock registered with GPU SVM.
> >>>>> + * Hold it in write mode around structural GPU SVM updates, including
> >>>>> + * drm_gpusvm_range_find_or_insert() and drm_gpusvm_range_remove().
> >>>>> + */
> >>>>> +static inline void amdgpu_svm_lock(struct amdgpu_svm *svm)
> >>>>> +{
> >>>>> +    down_write(&svm->svm_lock);
> >>>>> +}
> >>>>> +
> >>>>> +static inline void amdgpu_svm_unlock(struct amdgpu_svm *svm)
> >>>>> +{
> >>>>> +    up_write(&svm->svm_lock);
> >>>>> +}
> >>>>> +
> >>>>> +static inline void amdgpu_svm_assert_locked(struct amdgpu_svm *svm)
> >>>>> +{
> >>>>> +    lockdep_assert_held_write(&svm->svm_lock);
> >>>>> +}
> >>>>
> >>>> I'm starting to repeat myself, so once more: This stuff doesn't work like that!
> >>>>
> >>>> The lock the SVM subsystem uses to serialize updates *must* be the amdgpu_vm->eviction_lock and *not* a separate one.
> >>>>
> >>>> So clear NAK to having this functions here.
> >>>
> >>>
> >>> I have explained why eviction lock can not be used as svm lock in V8, previous version. And it seems like we have a big gap about it.
> >>>
> >>> The eviction lock can not be used for svm lcok.
> >>>
> >>> And the design of svm lock is the core locking design of drmsvm frame work, without this desgin, this framework lost its soul. So I have to explain how to use this lock.
> >>>
> >>> I believe we are talking about two different locks.
> >>
> >> Yeah, that stuff is more than a bit complicated. The key point is that I still don't see any of the mandatory changes to amdgpu_vm.c in this patch set.
> >>
> >>> You may treat svm lock as notifier lock. drm_gpusvm has two of them, and the "no allocation while held in the MMU notifier" rule applies
> >>> to the other one, not to driver_svm_lock.
> >>>
> >>> 1) drm_gpusvm has two distinct locks: drivers/gpu/drm/drm_gpusvm.c
> >>>
> >>>    - notifier_lock: safeguards the notifier's range RB tree and list, as
> >>>      well as the range's DMA mappings and sequence number. ... This lock
> >>>      corresponds to the driver->update lock mentioned in
> >>>      Documentation/mm/hmm.rst."
> >> And that one here *MUST* be identical to the eviction lock in amdgpu_vm.c
> > 
> > Actually I have a question about this,
> > 
> > The notifier lock protects the CPU pages tables, it prevents the migration/swap ... from MM logic.
> > 
> > And the eviction lock protects the GPU VM page table, it prevents gpu page table changes from TTM logic.
> > 
> > They have different jobs,
> 
> No, exactly that is what we have gotten wrong in the existing KFD SVM implementation.
> 
> > 
> > when doing a GPU mapping in SVM, cpu page table can not change, casue it
> > may change the cpu dma addr -> gpu mapping. So must hold it, it is done in current code, and it is must required by drm gpu svm frame work.
> > 
> > And at the same time the eviciton lock must hold also, casue the GPU page tables may change by TTM logic.
> > 
> > Those two locks are all need be hold, no conflict, this is just my thought.
> 
> Originally the notifier_lock only made sure that the CPU page table updates where done in order and originally the eviction lock made sure that the GPU page table updates where done in order, but essentially we need the order for both.
> 
> The point is that the updates need to be serialized. In other words when one CPU is doing a mapping operation and another CPU is doing an unmap through an MMU notifier we somehow need to make sure that the coresponding GPU page table updates execute in the correct order.
> 
> So essentially those two locks need to be the same one, and we need to drop the lock to allocate page tables and when we re-acquire it we need to double check the sequence number to make sure that no unmap operation happened concurrently.
> 
> And yeah I know that this makes things much much more complicated, but it is definately necessary.
> 

So, if I understand your point correctly, the best way to solve the
serialization issue between these two locks is to turn them into a single
lock. Given that a full re-design of amdgpu_vm could take a significant
amount of time, it seems that using drm_gpusvm's notifier_lock as a
replacement for eviction_lock in amdgpu_vm would be the more practical
short-term solution.

Please correct me if I've misunderstood your position.

Thanks,
Ray

> Regards,
> Christian.
> 
> > 
> > Regards,
> > Honglei
> > 
> >>
> >> The background is that XE uses a different page table allocation approach than amdgpu and we need to drop this lock in amdgpu to be able to allocate page tables. See function amdgpu_vm_pt_alloc().
> >>
> >> With that design here that currently doesn't work at all.
> >>
> >> We have two options, either use the drm_gpusvm notifier_lock as eviction_lock in amdgpu_vm.c or re-design amdgpu_vm.c to use the same approach for allocating page tables as XE.
> >>
> >> Some engineer from Valve is working on re-designing amdgpu_vm.c, but that will potentially take month if not years.
> >>
> >> So my take is that the new SVM code needs to modify amdgpu_vm.c so that the drm_gpusvm notifier_lock is used as eviction lock by the VM code.
> >>
> > 
> >> Regards,
> >> Christian.
> >>
> >>
> >>>
> >>>    - driver_svm_lock: In addition to the locking mentioned above, the
> >>>      driver should implement a lock to safeguard core GPU SVM function
> >>>      calls that modify state, such as drm_gpusvm_range_find_or_insert and
> >>>      drm_gpusvm_range_remove.
> >>>
> >>>    Two locks, two jobs.
> >>>
> >>> 2) The lock held in the MMU notifier is notifier_lock, never driver_svm_lock
> >>>
> >>>    drm_gpusvm_notifier_invalidate():
> >>>          down_write(&gpusvm->notifier_lock);
> >>>          ...
> >>>          gpusvm->ops->invalidate(gpusvm, notifier, mmu_range);
> >>>
> >>>    The driver invalidate callback runs under notifier_lock only. Per the
> >>>    framework's own notifier example it just unmaps pages
> >>>    and queues the range to the garbage collector no allocation, and it
> >>>    does not take driver_svm_lock:
> >>>
> >>>          drm_gpusvm_range_unmap_pages(...);
> >>>          drm_gpusvm_range_set_unmapped(...);
> >>>          driver_garbage_collector_add(...);
> >>>
> >>> 3) driver_svm_lock is by design an allocating, process context lock
> >>>
> >>>    drm_gpusvm_range_find_or_insert() asserts it and then allocates under it:
> >>>
> >>>          drm_gpusvm_range_find_or_insert():
> >>>                  drm_gpusvm_driver_lock_held(gpusvm);
> >>>                  ...
> >>>                  range = drm_gpusvm_range_alloc(...);
> >>>                  ... mmu_interval_notifier_insert(), kzalloc
> >>>
> >>>    drm_gpusvm_range_remove() asserts it and frees. This is only safe
> >>>    because driver_svm_lock is a sleepable, reclaim friendly lock that is
> >>>    never taken from the MMU notifier. Reference counting
> >>>     handles range *lifetime*, but it does not
> >>>    serialize tree insert/remove, which is exactly why the framework still
> >>>    asserts driver_svm_lock on those two entry points regardless of refcount.
> >>>
> >>> Now the three concrete points:
> >>>
> >>> A) Why the primary driver_svm_lock is required
> >>>
> >>>    It is a framework requirement, not an amdgpu invention:
> >>>     - DOC: Locking says the driver "should implement" it.
> >>>     - drm_gpusvm lockdep-asserts it on every structural entry:
> >>>       drm_gpusvm_range_find_or_insert() and drm_gpusvm_range_remove() both
> >>>       call drm_gpusvm_driver_lock_held().
> >>>     - The reference fault handler holds it across the whole fault:
> >>>       GC -> find_or_insert -> migrate -> get_pages -> bind.
> >>>
> >>>    Xe does exactly this:
> >>>     - xe_svm.c:      drm_gpusvm_driver_set_lock(&vm->svm.gpusvm, &vm->lock);
> >>>     - xe_pagefault.c: down_write(&vm->lock); before dispatching the fault
> >>>     - __xe_svm_handle_pagefault(): lockdep_assert_held_write(&vm->lock);
> >>>       held across GC / find_or_insert / alloc_vram / get_pages / rebind
> >>>     - xe_svm_garbage_collector(): lockdep_assert_held_write(&vm->lock);
> >>>
> >>>    amdgpu's svm_lock is the same driver_svm_lock, used the same way.
> >>>
> >>> B) Why eviction_lock cannot be that lock
> >>>
> >>>> This lock eviction_lock can only be grabbed while updating the mapping range.
> >>>
> >>>    and that is precisely why it cannot be driver_svm_lock.
> >>>    driver_svm_lock must wrap find_or_insert, migration, and
> >>>    drm_gpusvm_range_get_pages
> >>>    eviction_lock is the opposite by contract:
> >>>
> >>>     - It is taken with memalloc_noreclaim_save() in
> >>>       amdgpu_vm_begin_critical(), specifically so no reclaim happens while
> >>>       held (to avoid the reclaim -> MMU-notifier deadlock). Holding it
> >>>       across get_pages/migration breaks that.
> >>>     - TTM eviction try-locks it: amdgpu_vm_evictable() does
> >>>       scoped_cond_guard(mutex_try, return false, &vm->eviction_lock) and
> >>>       sets vm->evicting. Long holds starve eviction.
> >>>     - It is a plain mutex that the SVM map path re-enters:
> >>>       amdgpu_svm_range_update_mapping() -> amdgpu_vm_map_range() ->
> >>>       amdgpu_vm_begin_critical() -> mutex_lock(&vm->eviction_lock). If
> >>>       eviction_lock were also the outer SVM lock, this is a self-deadlock.
> >>>
> >>>    In short, eviction_lock has the contract of notifier_lock , not of
> >>>    driver_svm_lock. This is also why the current split is correct:
> >>>    svm_lock (outer) != eviction_lock (inner). Your own rule - "you can't
> >>>    call the VM code with the lock held, the VM code must take it itself" -
> >>>    is satisfied today only because they are separate: svm_lock is held
> >>>    while calling amdgpu_vm_map_range(), and amdgpu_vm_map_range() takes
> >>>    eviction_lock itself. Merging them is what would violate that rule.
> >>>
> >>>> No, they Xe vm->lock and eviction_lock are actually identical in the handling.
> >>>
> >>>    They are not. Xe's vm->lock is a rw_semaphore, the "outer most lock" of
> >>>    the VM , held down_write across the whole fault. amdgpu's
> >>>    eviction_lock is a mutex taken only inside amdgpu_vm_begin_critical()
> >>>    during a PT update, under memalloc_noreclaim. Xe's eviction/reclaim
> >>>    handling is separate from vm->lock. The amdgpu analogue of Xe's vm->lock
> >>>    is svm_lock, not eviction_lock.
> >>>
> >>> C) Reusing an existing amdgpu_vm lock as the primary lock needs refactor amdgpu VM
> >>>
> >>>    Xe can register vm->lock because Xe's VM was designed with an outer
> >>>    rw_semaphore held across faults. amdgpu_vm has no such lock: only
> >>>    eviction_lock , the root PD dma_resv , and a few spinlocks.
> >>>
> >>>    So do it like Xe means introducing a dedicated, outer, sleepable VM
> >>>    lock held across the fault. That lock is exactly svm_lock. Folding it
> >>>    into struct amdgpu_vm as a general vm->lock is a core amdgpu VM refactor.
> >>>
> >>> Regards,
> >>> Honglei
> >>>
> >>>
> >>>>
> >>>> Regards,
> >>>> Christian.
> >>>>
> >>>>> +
> >>>>> +#if IS_ENABLED(CONFIG_DRM_AMDGPU_SVM)
> >>>>> +void amdgpu_svm_flush_tlb(struct amdgpu_svm *svm);
> >>>>> +
> >>>>> +int amdgpu_svm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm);
> >>>>> +void amdgpu_svm_close(struct amdgpu_vm *vm);
> >>>>> +void amdgpu_svm_fini(struct amdgpu_vm *vm);
> >>>>> +
> >>>>> +void amdgpu_svm_put(struct amdgpu_svm *svm);
> >>>>> +struct amdgpu_svm *amdgpu_svm_lookup_by_pasid(struct amdgpu_device *adev,
> >>>>> +                           uint32_t pasid);
> >>>>> +int amdgpu_svm_handle_fault(struct amdgpu_device *adev, uint32_t pasid,
> >>>>> +                uint64_t fault_page, uint64_t ts,
> >>>>> +                bool write_fault);
> >>>>> +bool amdgpu_svm_is_enabled(struct amdgpu_vm *vm);
> >>>>> +
> >>>>> +int amdgpu_gem_svm_ioctl(struct drm_device *dev, void *data,
> >>>>> +             struct drm_file *filp);
> >>>>> +void amdgpu_svm_clean_queue(struct amdgpu_svm *svm,
> >>>>> +                struct list_head *work_list);
> >>>>> +void amdgpu_svm_sync_work(struct amdgpu_svm *svm);
> >>>>> +int amdgpu_svm_garbage_collector(struct amdgpu_svm *svm);
> >>>>> +int amdgpu_svm_apply_attr_change(struct amdgpu_svm *svm,
> >>>>> +                 const struct amdgpu_svm_attrs *old_attrs,
> >>>>> +                 const struct amdgpu_svm_attrs *new_attrs,
> >>>>> +                 unsigned long start_page,
> >>>>> +                 unsigned long last_page);
> >>>>> +bool amdgpu_svm_devmem_possible(struct amdgpu_svm *svm);
> >>>>> +#else
> >>>>> +static inline int amdgpu_svm_init(struct amdgpu_device *adev,
> >>>>> +                  struct amdgpu_vm *vm)
> >>>>> +{
> >>>>> +    return 0;
> >>>>> +}
> >>>>> +
> >>>>> +static inline void amdgpu_svm_close(struct amdgpu_vm *vm)
> >>>>> +{
> >>>>> +}
> >>>>> +
> >>>>> +static inline void amdgpu_svm_fini(struct amdgpu_vm *vm)
> >>>>> +{
> >>>>> +}
> >>>>> +
> >>>>> +static inline int amdgpu_svm_handle_fault(struct amdgpu_device *adev,
> >>>>> +                      uint32_t pasid,
> >>>>> +                      uint64_t fault_page,
> >>>>> +                      uint64_t ts,
> >>>>> +                      bool write_fault)
> >>>>> +{
> >>>>> +    return -EOPNOTSUPP;
> >>>>> +}
> >>>>> +
> >>>>> +static inline bool amdgpu_svm_is_enabled(struct amdgpu_vm *vm)
> >>>>> +{
> >>>>> +    return false;
> >>>>> +}
> >>>>> +
> >>>>> +static inline int amdgpu_gem_svm_ioctl(struct drm_device *dev, void *data,
> >>>>> +                       struct drm_file *filp)
> >>>>> +{
> >>>>> +    return -EOPNOTSUPP;
> >>>>> +}
> >>>>> +#endif /* CONFIG_DRM_AMDGPU_SVM */
> >>>>> +
> >>>>> +#endif /* __AMDGPU_SVM_H__ */
> >>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> >>>>> index ec1196d390bb7..30463a83e2e60 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> >>>>> @@ -43,6 +43,7 @@ struct amdgpu_bo_va;
> >>>>>    struct amdgpu_job;
> >>>>>    struct amdgpu_bo_list_entry;
> >>>>>    struct amdgpu_bo_vm;
> >>>>> +struct amdgpu_svm;
> >>>>>      /*
> >>>>>     * GPUVM handling
> >>>>> @@ -373,6 +374,9 @@ struct amdgpu_vm {
> >>>>>          /* cached fault info */
> >>>>>        struct amdgpu_vm_fault_info fault_info;
> >>>>> +
> >>>>> +    /* SVM experimental implementation */
> >>>>> +    struct amdgpu_svm *svm;
> >>>>>    };
> >>>>>      struct amdgpu_vm_manager {
> >>>>
> >>>
> > 
> 
