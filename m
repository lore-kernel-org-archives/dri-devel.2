Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7A3606A32C
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 14:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ed1AArhV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DFE010F60A;
	Tue, 27 Oct 2026 14:51:59 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5523310F608
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 14:51:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A75646021C;
 Tue, 27 Oct 2026 14:51:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D94C61F031E4;
 Tue, 27 Oct 2026 14:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793112712;
 bh=JoOqvyAj0+Jgjt+c2q64ZVpxp84DiEqBDr/qWbcE/6Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Ed1AArhVbeUlRbieRogEq16Tc9QCqIZSVTH064+m36Q4VT261rTmozO5K8nEvCkmq
 dWGW2Ewc91FnxFgZrQlGO7DsJTPWUBuuKpMFYk5PB5SnqrtyzdYta/rrt9N5S8VZm6
 Y44/La2njGFGVC4t9zam3WRChOsRM1fFS1bhbX6m6sGSsuH+9Itltw/nDpANPUw0Jk
 S2b0DTmKpYCUKLtLZ/6Fq8Dn3gscIF/3s1I7H+h9Ov9H/jNbnMg3Qg3ve55KzxabTv
 PDjNZpnaSYLkKtuFscIy3vPPHHBxXwUperQxUc65bVpo2SUO2TFpmMR8MkE6VdNXdO
 dI711cyyUdnOw==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfauth.ams.internal (Postfix) with ESMTP id 5D75A198004A;
 Tue, 27 Oct 2026 10:51:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Tue, 27 Oct 2026 10:51:49 -0400
X-ME-Sender: <xms:gLrgavLAlgkrAhj-6GVk5yLjUj1kyaDiq3PHRAuB8g5hZtL3adnBMA>
 <xme:gLrgahq9Ns9x_c8FHLAL2iQ29lp-hr92Bw2cw2gpp6xFzPUbsAt_MgBkpxcEL9Qso
 VTCqJC2qCdFPNYFJk1IFe7oQ3ugipZgsgosd87cO1r_YL9q7BICvRYm>
X-ME-Received: <xmr:gLrgaigHnEu2DOyJCpY49eTeuHuI1p8TjWFQcr3g-i1UMc-y-AQAr1B7orc>
X-ME-Proxy-Cause: dmFkZTGhb5CCIEhi8YRVlZWXxywwjLDCiGKJTqYq3TGxohkiie2e7b08prnm6qm3Mgq/Xv
 f8mSL32tsLRpmgHaz6MZN+ZLdDrreydc6PdATZZoDlZZ4l4PoJjiJdhSudk3RV1jcJLsWl
 oGA9pKowkapDelRVuYlxCWlLeI7Z9/5iCynDokopMlVbGp8TOM3/RjSN/h13nNEROePlRY
 T35FzV8bgHo+mgJ1f+5oYNw35uJOWghFaZlb9xVnbDVCacqulVDS82UMGOBzg1yx5ECtZJ
 FuUQ2k/l29twYFlZP1ht6lfqh9RlJqn8qcxxQSBg1/mtGcYkOI8JiYt70URezpQ7kmjRmV
 J0aWJh/2p99Q5+2naRg9TcLhY7jPBYo2JWuKgkFL8E4JXBF2S0D8yAS+GGxhVRrDOgc9BC
 sMOKD8Wl7RYrMPEiZQOpn9PekBFgU7capm2o7nIlInu72F6Xp1aDS5bdkZpG9R5GaJJCR3
 56gL0cSDcpTgU9GBjEaKbu1mje0wR7SzmSZEBZumtk18Yekozk9oGPdB9y5v/ze1OYIaSX
 tF8S/frgaX2ZSwZSJSxf4Jsr8L8G6idJw06leYWdZ26CGTfqBOijN+PT0bh+d3bnyy3g2n
 92jz6sAl2//Fv0Kppx7hFvHhS12BccSJOh2PGA7gOFwihsIfKg8mLHvpsSFg
X-ME-Proxy: <xmx:gLrgaumHM46mCUBbbnYEqXur4opZmpmG4YXo5V15tjjpYM-Mc85uPg>
 <xmx:gLrgah49HVzBmPghZOLcaa4hCoPYdU3q6YoMMqHVA-Q7u2TyKQg52A>
 <xmx:gLrgaim0om9HQc7lD6Tc-7i8r87HAvGK3UN41DOa8xgFZ_UxpPTy2Q>
 <xmx:gLrgajiZQVCrpJT1ZH2Qks2KtrpGxe2s57jSA7H7IlInRy3VksMJAQ>
 <xmx:gLrganlsr6aI5eIKIEcQYttuzXZA1Q_Yq5sz8KY9RTMvBvSmQ70WtJOR>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 10:51:44 -0400 (EDT)
Date: Tue, 27 Oct 2026 14:51:43 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Konstantin Khorenko <khorenko@virtuozzo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Peter Xu <peterx@redhat.com>,
 Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
 =?utf-8?B?TG/Dr2M=?= Molinari <loic.molinari@collabora.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v4 4/4] selftests/mm: test fork of PMD-mapped shmem THPs
Message-ID: <auC4eUEN52PJF1bM@thinkstation>
References: <20261021-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v4-0-66f00b7a564c@virtuozzo.com>
 <20261021-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v4-4-66f00b7a564c@virtuozzo.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v4-4-66f00b7a564c@virtuozzo.com>
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
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 10:36:03PM +0200, Konstantin Khorenko wrote:
> +	/* The child's exit took the parent's share off the counter. */
> +	if (*after < own || *before - *after >= own)
> +		return FAIL_COUNTER;
> +	if (*after != *before)
> +		return CHANGED;
> +	if (mem[pmdsize] != (shared ? 'c' : 2) || !data_ok(mem, size, pmdsize) ||
> +	    !check_huge_shmem(mem, size - pmdsize, NR_PMDS - 1, pmdsize))
> +		return FAIL_PARENT;

ShmemPmdMapped is system-wide. A drop of 'own' or more from another
process between the two reads fails the test instead of being retried
as CHANGED.

The parent's THPs can also lose their PMDs during the test: reclaim can
swap one out, and NUMA balancing can migrate one, which leaves the
counter low while the migration entry is in place. That gives
FAIL_COUNTER, or FAIL_PARENT from the exact count in check_huge_shmem().

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
