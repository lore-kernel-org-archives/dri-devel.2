Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE79606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 11:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=QoEJ9Io8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B42A10F669;
	Tue, 17 Nov 2026 11:46:46 +0000 (UTC)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AD5B10E51C
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 08:06:04 +0000 (UTC)
Received: by mail-qt1-f169.google.com with SMTP id
 d75a77b69052e-53639b8903bso8473191cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 00:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1794902764; x=1795507564; darn=lists.freedesktop.org;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=phkLAVe2PWOa6jK368c9XEugs4HUA+7j+Ko3Mk6IPVk=;
 b=QoEJ9Io8bLXap+t4spAFzyhRBTH2su4UYf5wPX2QVEtPaFTAzFFMJscYEeQiZ00079
 ZgnA0CnIULrHJXtsxa4mkhN1+A/OnwKBq9ynNNLcDy8muMfcCg2aKzcM6I3+qw7URmAk
 pxJkSUJJ/CWrl0EzD1ZDkTYern8IMqgjtWsVXzEkr0fnVg6RJwQzvuycS+vwUfUcu2Dn
 MZoXCRbacWKSr+5namc8pU63gGtG7EhYNscZ/EJqnlriUaubrFjtWjntbf/8fkM/w5/w
 Ug7Pk5YR+/IpIf8zm+m15y4WrXnP6YqTOEQe+5lcS5bPZcAXLB5c0JSdLwsjGw/HKfWi
 +3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794902764; x=1795507564;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=phkLAVe2PWOa6jK368c9XEugs4HUA+7j+Ko3Mk6IPVk=;
 b=CT4k+VmzyxUQXZAdBiH3UZy/X+xT16BpQBX+i7vlm4Psp2Unu2jj9u+dKSxlclyopn
 08VRL4q/z6NG5DlhulVtmruXVos/ao1rlsC9JjoCatFq6TKgCOinmhVJXNEVVBrE2r7/
 voSL1cG0ichnBNHTgrfuqRiuwhDLexx7pqFHFyGH/RkB75MFzbn+lvqKHf63gxNPWId2
 c/KKE0hiASaycCcFIzVFRknh3196kEJCGsJqlJPgANjvFDImfml1Tz8fTwTgy5DnnJf1
 8G1tP6WW63loqyhu+DV2e50ciou589mA0gujLxevjI/l0lQ3KffQcj8tjT8VjOWe2ut8
 NFEQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHmIH44JN/xb/tO6j2S3uDQO406Moc8bgSkbFaQnUYeAxw32o753Gg+uc9jZ1aRYYZ3JTW7GYEZNQQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/jvtemWaJDfq+a331lNhlnMJreJ9b/7rnzvCLNqdOVFwVwkknw
 vJGa3L6D9q8pIVjFSf7mhL24cO2X8SpZM9kW+3tmuvNJPrIewQjW72V5qaa00/UZrQw=
X-Gm-Gg: AYBFou3DM6Vvk6I3xd8IltZhagzTkL8goLr/NZ4P1RoNbB4a9fv48SWreduatJnUjLB
 EbdY2PJvdRJTZqGoUJwl94Fqy/ddntExn5ZmfnP0ysdfL2/N4aKDTBQFwnX/G+HPxZhGH5Ixmkh
 UfBC+r2xGV6nFC1L7mdNoICiZc3dmLoYu0Zgs8MXXJgqC8Ucwy3F09bQwciXspYmDtgrKeu+oha
 wS3bEZkp0HsTrdbUa6xccb0g4CdnOc+B0pO0YcFKjvV28T5gsn52snmo2byznRIGooTmTrhQntt
 S8S64kUsLMUWyiBF9tl+7f1uI+yIGvZTx49XGbv2ZL7GW3oUK6PTbMEaT0YaqQZQfP7AxYquHy5
 m7fLRV39OaJtDZ9xrtmv3OWcAc6vwcVpFmrXc3rRQHXGPXbA/8sF7aEJ/9DsxV3XnF7FUipneiM
 xcOk1cM3khPy6uXJxv0faSxn9d4CkXEm0I/51FyZsUn+AreT+QhViTyC04/aA6TEJeT30GEAfPH
 c91hoEqRq1GE1G48eRZdfQd4TXcDKMwtdoQO//9/NVKigwiSuDWlrqb/r+0iULI/5NPxB8sUQqh
 O/FZDnC2SobcKc0BRC3veLd7xJjmUghfyVDnazbDjryg3rfSef9oOL3L4zpA/yUSO31QMJWy/RJ
 Ee2RPPqOcLDxAjVLdcpR3KoyK2ZUs
X-Received: by 2002:a05:622a:5a17:b0:55d:31ac:d86f with SMTP id
 d75a77b69052e-55d494553e7mr26563541cf.13.1794902763822; 
 Tue, 17 Nov 2026 00:06:03 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net.
 [71.191.145.202]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91f23d7fad3sm105812516d6.29.2026.11.17.00.06.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 00:06:03 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] mm/hmm: skip NUMA balancing on protnone faults
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: Alistair Popple <apopple@nvidia.com>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Matthew Auld <matthew.auld@intel.com>, linux-mm@kvack.org, 
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?utf-8?q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>, 
 Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
 John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <avvJZtN88gLXA6Uz@nvdebian.thelocal>
References: <20261112-numa-v1-1-ad9cbca8f49a@intel.com>
 <b32fb02a-68b4-4db9-83dd-254147dbf215@kernel.org>
 <1993e931e6a4b0cda5c04e72b1a8d5fb924f950a.camel@linux.intel.com>
 <9ec3e8b9-064a-47a7-8d00-566ff371b846@kernel.org>
 <179460319801.482102.15329919214055018110.b4-reply@b4>
 <avuN2eIrlqrO0u6O@nvdebian.thelocal>
 <179487347201.482102.6428415219993123805.b4-reply@b4>
 <avvJZtN88gLXA6Uz@nvdebian.thelocal>
Date: Tue, 17 Nov 2026 03:06:02 -0500
Message-Id: <179490276245.482102.13112734238511841101.b4-reply@b4>
X-Mailer: b4 0.17-dev
X-Mailman-Approved-At: Tue, 17 Nov 2026 11:46:44 +0000
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-17 14:51 +1100, Alistair Popple wrote:
> On 2026-11-17 at 10:57 +1100, "Gregory Price (Meta)" <gourry@gourry.net> wrote...
> > 
> > Ah, I follow.  I'm still working through the performance implications of
> > mmu_notifiers in the presence of PROT_NONE faults, but if i'm
> > understanding correctly it tracks that you'd say it's incompatible.
> 
> Incompatible is probably not the correct term as it still works. It's just that
> GPU faults are really expensive, and to be avoided at all costs. So having NUMA
> balancing running around randomly unmapping pages the GPU is using (regardless
> of whether or not they are on the device) results in more GPU faults and
> therefore a huge perf impact for basically no (or in fact sometimes negative)
> gain.
> 
> > I presume here the driver needs a global view of memory (or at least all
> > memory it can potentially DMA), rather than simply just a subset
> > (some set of VMAs)?
> 
> The basic process is this:
> 
> * GPU needs to access some user space virtual address (eg. allocated with mmap/malloc)
> * Therefore GPU driver needs to setup GPU page tables to point to the physical
>   memory[1] backing the user space virtual address
> * To find the physical address the GPU driver uses hmm_range_fault() on the
>   range, possibly faulting pages in if required (ie. if CPU PTE permissions
>   don't match what's required).
> * hmm_range_fault() relies on mmu_notifiers for synchronisation with CPU PTE state.
> * An mmu_notifier firing causes a driver to do two things:
>   a) Must invalidate any GPU page tables / TLBs mapping the notified virtual address.
>   b) Increments a sequence number for any concurrent hmm_range_faults(), which must
>      retry as their view of CPU PTEs is now out-dated. This is the problem
>      this patch series hits - the migration on fault causes an mmu_notifier to fire
>      resulting in a hmm_range_fault() retry and associated overhead.
> 
> So the driver doesn't need a global view of memory, just a view of the memory
> the GPU needs, or likely needs, to access. Determining that depends on the
> driver - some might require pre-registration of the ranges (eg. via an ioctl)
> prior to launching work whilst others might wait until the GPU work faults on an
> address not in the GPU page tables. Or some combination thereof.
> 

I feel like i'm missing something here.

Why can't this be solved by just setting MPOL_LOCAL (or any bind policy)
without MPOL_F_NUMA_BALANCING on the VMA to prevent the VMA from being
NUMA scanned in the first place?

mpol_misplaced() already checks whether it should migrate with the
MPOL_F_MOF flag:

    pol = get_vma_policy(vma, addr, folio_order(folio), &ilx);
    if (!(pol->flags & MPOL_F_MOF))
        goto out;

and task_numa_work never scans VMA's without MOF:

    for (; vma; vma = vma_next(&vmi)) {
        if (!vma_migratable(vma) || !vma_policy_mof(vma) ... )
                trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_UNSUITABLE);
                continue;
        }
    ...
    }

So any stray (already scanned) pages at least won't migrate, and
NUMA balancing skips re-arming for VMAs that don't set MPOL_F_MOF.

You'd only have to worry about a user setting a mempolicy after
it becomes hmm tracked - and i think we could work around that
by locking a VMA policy in place.

Gets a little tricky for pagecache i suppose, but the plumbing
exists to handle this.

Anyway, MOF gets set is if you inherit the default policy:

void __init numa_policy_init(void)
{
...
    for_each_node(nid) {
        preferred_node_policy[nid] = (struct mempolicy) {
            .refcnt = ATOMIC_INIT(1),
            .mode = MPOL_PREFERRED,
            .flags = MPOL_F_MOF | MPOL_F_MORON,
            .nodes = nodemask_of_node(nid),
        };
    }
...
}

or you set MPOL_F_NUMA_BALANCING on the policy:

static inline int sanitize_mpol_flags(int *mode, unsigned short *flags)
{
...
    if (*flags & MPOL_F_NUMA_BALANCING) {
        if (*mode == MPOL_BIND || *mode == MPOL_PREFERRED_MANY)
            *flags |= (MPOL_F_MOF | MPOL_F_MORON);
        else
            return -EINVAL;
    }
...
}

If the memory is tmpfs/shmem, you can even set a default mempolicy at
mount time that does not set numa balancing.  If we need that for
another filesystem, it can be added trivially.

If there's a need for a driver or hmm to update a VMA mempolicy as part
of the hmm runtime process so userland doesn't have to know about it
under the hood - i think we could do that too.

Am I missing something?  Seems we can just rid hmm-tracked regions of
NUMA Balancing PROT_NONE faults entirely instead of ignoring them.

~Gregory

-- 
~Gregory

