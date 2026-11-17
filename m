Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92316606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 03:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=AtbilPwy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60AD610E2AB;
	Tue, 17 Nov 2026 03:51:43 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011013.outbound.protection.outlook.com [52.101.52.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2613710E2AB;
 Tue, 17 Nov 2026 03:51:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oQEXlwlJ2JPOlvP6rEPFk/fBpFz+1sOeuf3c2kO9Ea6N3N4j5Irk9qhukN/nhK8K+ytU0K7SSMkxSEqutJtdNzHi5mQ7/tGxWOh5s6InLGBMWDN7NKJE3qiwrUG32mScqVVc+zygZPpnK33GaixTXBoJS4DnDLfEQWL+RBEM5aOAXLXzJsBPnrxI2s35ZOWDCRdxW9CN2bBJYCKrVf3nFXdimKbkQtFEK8Fk8p/OHL/CKaFf8FDbI77WPSwSFI8QwzFOp4nbQuucyLbgnaEPkOreA6VguBEnuqUEPfLZ972fPi9DaPU+sgOgm7XcFDDKWPjf+H19GXPpojGB/4q/vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mrwk+4ssAmP8D1VgyVEK2Q49Io6fjXb8k3Ll1ccYCLg=;
 b=eOODcm8vxwNU9Gm1ugJW0RwxpLV4AZlzW2Vq1Giv2se+/L+rkF1Ho9qn1DbB53H3qT+ttc8t6lJPk0V5zRbGaAEvr0qnW+/QEL70rsbBQ1RCwa/ETrYsfKLXK6hnSolNd/tWoO31VjMudNBB/W5ejf/jNKbUg+NcN8bCzNpCS4t6Rxsrj3rjQwPETJfowyf9XWeznuOnmrw6KOhGC/WLnMlPiFKxf/NKXv1deZmo23GZpXU9/lD7CRS2jUNyZNZKtTKPvuSmIL4fuC09RwCo9Y9LXmmnitDwCYSpIvw1MTFclZDlShHa1BsDelyG3r001ns6g2wRt7gpLpEqEtqQ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mrwk+4ssAmP8D1VgyVEK2Q49Io6fjXb8k3Ll1ccYCLg=;
 b=AtbilPwynr9wrXTkzL7j+Sm/AoHZCNCpSetwtu6zJidfwHzKZVmXlKkNX6AKgKU9vVFzxfueK9mUInmMG6cIarugxugG1bfqdgzz4G256SyyjcyEa9N9fld4b8VOpCqFpuykqgE1jftlExwBUhr990Z95JL9fb22DOYKOaGeaVKDnUCPJPgOHq8EgqbTJvufcJrYrhJeST51cgi1c/YWFRYd+kPQv1dXQwevjXi1JVnH5Q/y7AAeExkdlXj+PBM0Qx+3bFnTmotZcjk1RSAaiimv42+CE+txdPbfh4ccG+zCgfHIkQkx7NUF/I41FB5QiQnrcajzPeNXhIhWED2Ywg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB598757.namprd12.prod.outlook.com
 (2603:10b6:806:52d::14) by IA1PR12MB8286.namprd12.prod.outlook.com
 (2603:10b6:208:3f8::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Tue, 17 Nov
 2026 03:51:31 +0000
Received: from SA3PR12MB598757.namprd12.prod.outlook.com
 ([fe80::e206:100:5946:a777]) by SA3PR12MB598757.namprd12.prod.outlook.com
 ([fe80::e206:100:5946:a777%5]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 03:51:31 +0000
Date: Tue, 17 Nov 2026 14:51:25 +1100
From: Alistair Popple <apopple@nvidia.com>
To: "Gregory Price (Meta)" <gourry@gourry.net>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Matthew Auld <matthew.auld@intel.com>, linux-mm@kvack.org, 
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 Matthew Brost <matthew.brost@intel.com>,
 Mika =?utf-8?B?UGVudHRpbMOk?= <mpenttil@redhat.com>, 
 Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
 John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH] mm/hmm: skip NUMA balancing on protnone faults
Message-ID: <avvJZtN88gLXA6Uz@nvdebian.thelocal>
References: <20261112-numa-v1-1-ad9cbca8f49a@intel.com>
 <b32fb02a-68b4-4db9-83dd-254147dbf215@kernel.org>
 <1993e931e6a4b0cda5c04e72b1a8d5fb924f950a.camel@linux.intel.com>
 <9ec3e8b9-064a-47a7-8d00-566ff371b846@kernel.org>
 <179460319801.482102.15329919214055018110.b4-reply@b4>
 <avuN2eIrlqrO0u6O@nvdebian.thelocal>
 <179487347201.482102.6428415219993123805.b4-reply@b4>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179487347201.482102.6428415219993123805.b4-reply@b4>
X-ClientProxiedBy: SYYP282CA0003.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:b4::13) To SA3PR12MB598757.namprd12.prod.outlook.com
 (2603:10b6:806:52d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB598757:EE_|IA1PR12MB8286:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fa6263e-6ac8-4fea-78d5-08df445e1121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|23010399003|261026140227099003|261026121527099003|261022105027099003|261021135927099003|261028144727099003|261022075727099003|261102123227099003|261021121427099003|10067099003|18002099003|11063799006|22082099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: 2ft1/BTqq3EzYaVwaQEFOu12yR88BiZDA3MgnDuV+1jnsu6U1XPekjVaDesdwWu2Br2bX2SqR7Io3NLIPER020zl9i4q/ExuOp0ADG5xBQzo4FOT3XVugL2BPKIPPpM0EskNOD040iAXjv1f/hzoIiklfqjgTmCALP82DZdkgt3T0ow4WJBzUmn86BN0qIzA08X7XaKVQpeyqlLPtXbN/+gbQZI6CvaT3QZlgWCwx5O92Q3cB0Ob/AeKldBRP2jVpYujvrf42x6/Z727lBziLdheiTWHvH6VYToZ641FbroT/xnDwVsyxhRrx+7vfObUVP8lkw/PiF2rFXSKc6yY74vd13HHBJh3EusypMKAtViEBvY2g0NbPXr3sm7izUUHcNnQ55Rm71sqmRpxnVQ4gSjGaCgKr8+j4w+NxTdjONaVWcQ4h9Ugd3z0BEZyxKT+7lNX0ZQYLkX4nmXkaTDNTVoZOxu2pgfnJx90X+iRQG3LnleJyR/Uisi4d7A465m9jJEyOm5oVvsCyGMBG1xL070V+gJGWtnSxEc8OirVjK861nsKmVfl6lN/KbzQvIvgjGN+J6G1OuerTOAjqa0q9DA3kWozmi14a0hDP9NZujY9/KXsyfb0iW1RizV24G6sClY/7OXq7WCJjdcHhcBF8Ae+X+1qdJatv+6j5YFeGcg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR12MB598757.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(261026140227099003)(261026121527099003)(261022105027099003)(261021135927099003)(261028144727099003)(261022075727099003)(261102123227099003)(261021121427099003)(10067099003)(18002099003)(11063799006)(22082099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ys7IGdBxyoippuG0hWUx1PTg8tun/ER+eMsUcTtNf6zVikBXx0ae5gky72?=
 =?iso-8859-1?Q?vYMT7cJYEfIlUgDOBX2eMY0M6ZvbiBOpzebaPA76s6Y6+HLCckTLA7ftj8?=
 =?iso-8859-1?Q?SpUdKApyeLbnic3LZJ2r8yGlWRASwkfPraJpjxL3uD0nPuzmD9WFR3K134?=
 =?iso-8859-1?Q?aW1XjaEUS6luw96i0q8P1LhgzRjtuKaL9L+zMFKrO3laca2UrvE3OEd38R?=
 =?iso-8859-1?Q?m13jhhvN3Wy0iw2gOLa91ZE4CCv4T5Iho8Yu2vi3cfcYKzG+fvDSIyLhif?=
 =?iso-8859-1?Q?Zil5jC1f3WvNMxk525CyJa8g3u5tR021keqq/wyaqWoOz7LHiUVJqtoOWV?=
 =?iso-8859-1?Q?gngD+DdUZ5XzcYqBHycTmk397elr+A/aURRTa20C2LWSpXY/3ENevSm/BJ?=
 =?iso-8859-1?Q?46foRZR72z8oMK11lj67T/jii2UI7AZm2ZxdNxNm1uPKFB5F8z2YWcbh0y?=
 =?iso-8859-1?Q?NS7oT8DgxDKdDpZmcuzvYgndxqDcVNrIGslnMNKSagYktDb/73CCG2JHAw?=
 =?iso-8859-1?Q?NBw+SWoFopIqIoHsWH7XskkdXDPmY+hwJDx1n8gSih6wA82VxwrOunptM/?=
 =?iso-8859-1?Q?9NbKsBs+hUKek/FxxjIAokJdCdD1/lzX6ZDKIiEBMFiApy+AhMg6wvRiG1?=
 =?iso-8859-1?Q?RCFn8HiHCEQPwdvEObO8yYCkKF0UTvlECetvAwIluWidlB9aPWflhK5JTE?=
 =?iso-8859-1?Q?Ot3WMGG/xK0wJZb7WdzbBIKZwOUZ7CWMSdawDPUzhkwKBc2m1rFyB4FXGb?=
 =?iso-8859-1?Q?/huLDl228HTFZnlpIVIkpgzSs/e9wC0CZqkrr9sm5HrPoK3k1+Hhh35swh?=
 =?iso-8859-1?Q?BOIruM7aRaO7TE/xwDlLlzH++gxOpKGF4l71NNN6ToobZyMpvrr4MgrFRG?=
 =?iso-8859-1?Q?N0P0bU6wgzMYMfq57ScXLUd5KugvzCMOB0L2+b7OFJANk4qUb5v6LBJocR?=
 =?iso-8859-1?Q?DvJk0Xf/NZVNHXD5aBuSWS5RfBOH13u/kp2pxveYIdRMfHkN+K842NfqE0?=
 =?iso-8859-1?Q?FIIyQkTS3C6bMZCdcc9OkXIi2PXb8M/lCR8fD5xaL/jR60bRGX4V+G3QkB?=
 =?iso-8859-1?Q?f1bRdTtI1jEmWkrlZ1NFS3O7m3yqiowq4ghLG6tADO2s90r1gtjNrLVI5u?=
 =?iso-8859-1?Q?gE3nUIowBY02FmFpoWsQlyK4MTFXda5reCVWI48XFA0hocQC/nyHn5T8Rb?=
 =?iso-8859-1?Q?RIQ+7LXZhrGSDKSiV9vpCaw+kbAROBrEQmQpteJWXKR6u5dx3g56OGVMxg?=
 =?iso-8859-1?Q?+u6VGvQ727y40PiSD/i9NvBfX4gFjMwfshX3guWlBimRgaNW7A6zSQdj5N?=
 =?iso-8859-1?Q?LsIY4rAcJUoAp9UjUyiyNHdg3teaS7b+LElqGkfSIhxkCJcM0EnGsMLkwg?=
 =?iso-8859-1?Q?6iElwjovUtvVorcPkmDs7CZ9X1TTpZJjS8g1MWYyX0LqHKM7vgfjtN4xzU?=
 =?iso-8859-1?Q?BevrXvG8mhUjyOvHUlVmAaNwxLqhkgP9yzbODrYxpYEsF8hzmAfTxSlTpi?=
 =?iso-8859-1?Q?hA04y+gQ/hqqg0lFH9QqtOomcso13WrC/bWNrpCbNmj35gga0L0CZPpk7g?=
 =?iso-8859-1?Q?uIWOcq8UpCx0Xlwx2hjnH88Q+HFnJahWqvQb99dxdUTiJ6YyiJrIanyYWY?=
 =?iso-8859-1?Q?PqC7xGkzd4pPrl8TYpSHr/OxHisd8AZcruL9TPnmZAiMYpTrddlf9CWvAH?=
 =?iso-8859-1?Q?ewqyzU6rZNtDD4iN/Vq4doBlpiv/SGU5ujQQt7kG1hxHREkHFvDhHJZsYo?=
 =?iso-8859-1?Q?YZDrLAuCkJXlj4FixKJUGmiQxsTjXQTvfutquVRM9hzIeNqQmWCSm+FjGy?=
 =?iso-8859-1?Q?F1mtAKawEQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fa6263e-6ac8-4fea-78d5-08df445e1121
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB598757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 03:51:31.6380 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lV1T40L7Wo9Rp94FFmYKsmYnuG0usMu+/4xXhrX12KJP7UvoSy0gfy1zphLIDbMim7Rd2wkQts36aZSc1idKIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8286
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
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-17 at 10:57 +1100, "Gregory Price (Meta)" <gourry@gourry.net> wrote...
> On 2026-11-17 10:24 +1100, Alistair Popple wrote:
> > On 2026-11-14 at 07:53 +1100, "Gregory Price (Meta)" <gourry@gourry.net> wrote...
> > > On 2026-11-13 21:43 +0100, David Hildenbrand (Arm) wrote:
> > > > On 11/13/26 21:34, Thomas Hellström wrote:
> > > 
> > > > I recall that John (cc) kept saying "GPUs and NUMA balancing is inherently
> > > > incompatible, you have to disable NUMA balancing".
> > > > 
> > > 
> > > If this is a NUMA-hotplugged GPU, then this is resolved by a private
> > > node, because this:
> > > 
> > > @@ -6404,6 +6404,9 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
> > >         if (!folio || folio_is_zone_device(folio))
> > > 
> > > 
> > > changes to
> > > 
> > >         if (!folio || folio_is_common_memory(folio))
> > > 
> > > And all folios on the GPU node are never subject to NUMA Balancing
> > > 
> > > so balancing can stay enabled while the GPU memory is not subject to
> > > PROT_NONE spew.
> > 
> > Hi Gregory, just to hopefully help clarify understanding a bit here this isn't
> > related to folio location and therefore private node won't help much.
> > 
> > This about a driver getting a snapshot of current PTE state to program a
> > secondary MMU (in this case on a GPU, but can equally be a NIC or other device).
> > 
> > Even CPU memory being subject to NUMA balancing can have quite an adverse impact
> > on GPU performance due to increased incidence of GPU faults, hence why John says
> > GPUs (using SVM) are inherently incompatible with NUMA balancing.
> > 
> 
> Ah, I follow.  I'm still working through the performance implications of
> mmu_notifiers in the presence of PROT_NONE faults, but if i'm
> understanding correctly it tracks that you'd say it's incompatible.

Incompatible is probably not the correct term as it still works. It's just that
GPU faults are really expensive, and to be avoided at all costs. So having NUMA
balancing running around randomly unmapping pages the GPU is using (regardless
of whether or not they are on the device) results in more GPU faults and
therefore a huge perf impact for basically no (or in fact sometimes negative)
gain.

> I presume here the driver needs a global view of memory (or at least all
> memory it can potentially DMA), rather than simply just a subset
> (some set of VMAs)?

The basic process is this:

* GPU needs to access some user space virtual address (eg. allocated with mmap/malloc)
* Therefore GPU driver needs to setup GPU page tables to point to the physical
  memory[1] backing the user space virtual address
* To find the physical address the GPU driver uses hmm_range_fault() on the
  range, possibly faulting pages in if required (ie. if CPU PTE permissions
  don't match what's required).
* hmm_range_fault() relies on mmu_notifiers for synchronisation with CPU PTE state.
* An mmu_notifier firing causes a driver to do two things:
  a) Must invalidate any GPU page tables / TLBs mapping the notified virtual address.
  b) Increments a sequence number for any concurrent hmm_range_faults(), which must
     retry as their view of CPU PTEs is now out-dated. This is the problem
     this patch series hits - the migration on fault causes an mmu_notifier to fire
     resulting in a hmm_range_fault() retry and associated overhead.

So the driver doesn't need a global view of memory, just a view of the memory
the GPU needs, or likely needs, to access. Determining that depends on the
driver - some might require pre-registration of the ranges (eg. via an ioctl)
prior to launching work whilst others might wait until the GPU work faults on an
address not in the GPU page tables. Or some combination thereof.

 - Alistair

[1] - Well technically the IOVA / DMA address mapping physical system memory
but that's not relevant for this discussion. We can assume there are no IOMMUs
present.

> ~Gregory
> 
> -- 
> ~Gregory
> 
> 
