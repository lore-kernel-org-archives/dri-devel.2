Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 997A5C44501
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 09:13:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4DAC10E317;
	Thu, 16 Jul 2026 09:13:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ay9RStfR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 630AB10E317;
 Thu, 16 Jul 2026 09:13:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C609741404;
 Thu, 16 Jul 2026 09:13:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28231F000E9;
 Thu, 16 Jul 2026 09:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784193194;
 bh=iTgmRt/mOhfeVVtmxm9TcACq90Tyo5vsbd/jxsIv5Z8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ay9RStfRqzjIAkK9qMkR2z+5qf0qqqVKp9e3TmHYXeStbB17RWYaMTy3uBEQg9KdB
 u6SzyAyck8jHQYnZRcDZF2nv4JSlVK4s+Z9AU6vm4Z8hdBsYN/pLtEuoZ1uePJ0ei+
 CgwmpsarAdZLu5fqmEDEh1cyx1Hkj2MzKeUhBMvb3bdhVqCABV+8VgCEe6FDEOjjO5
 qL6/bzX0PVJJW9W9nJfTJrTOKM+osmvCPL9h6+QY3ZBSJrc6TfQFtxhuA1XgcYUKNj
 nNSh+4LtoZwZxaqnJtf/7k1p7/OJu8+sERq6XAOZ6syFQj2Cdz8ihwQ2xEfBx+fsWk
 BBTOOeQ6E91Fw==
Date: Thu, 16 Jul 2026 10:12:56 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Stanislav Kinsburskii <skinsburskii@gmail.com>, airlied@gmail.com,
 akhilesh@ee.iitb.ac.in, corbet@lwn.net, 
 dakr@kernel.org, jgg@ziepe.ca, kees@kernel.org, leon@kernel.org, 
 liam@infradead.org, lizhi.hou@amd.com, lyude@redhat.com, 
 maarten.lankhorst@linux.intel.com, mamin506@gmail.com, mhocko@suse.com,
 mripard@kernel.org, 
 nouveau@lists.freedesktop.org, ogabbay@kernel.org, oleg@redhat.com,
 rppt@kernel.org, 
 shuah@kernel.org, simona@ffwll.ch, skhan@linuxfoundation.org, surenb@google.com,
 tzimmermann@suse.de, vbabka@kernel.org, dri-devel@lists.freedesktop.org, 
 linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 0/4] mm/hmm: Clarify notifier retry state and scope
 HMM timeouts
Message-ID: <aligdOKNwoOtD4io@lucifer>
References: <178406760622.1106335.2379450382728057793.stgit@skinsburskii>
 <4300f09b-8f93-4605-b072-7c09a82cb16e@kernel.org>
 <alecaJ1FUso39D9k@skinsburskii> <alet21wLwM6P_Km2@lucifer>
 <ale3ydkx1xt6ruuP@skinsburskii>
 <20260715101432.99957d2d33203fafe4af2e1c@linux-foundation.org>
 <e9d0ade4-cf87-4e8d-90ec-50ddb5249b24@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9d0ade4-cf87-4e8d-90ec-50ddb5249b24@kernel.org>
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

On Thu, Jul 16, 2026 at 10:59:56AM +0200, David Hildenbrand (Arm) wrote:
> On 7/15/26 19:14, Andrew Morton wrote:
> > On Wed, 15 Jul 2026 09:39:37 -0700 Stanislav Kinsburskii <skinsburskii@gmail.com> wrote:
> >
> >>>
> >>> Please don't do this, this is completely impossible to track for review :)
> >>>
> >>> mm review is currently very difficult based on volumes, it'll become impossible
> >>> to manage if people sound fragments of series.
> >>>
> >>> Please just resend the whole thing at this point.
> >>>
> >>
> >> Well, I followed the guidance provided by Andrew, and I believe he
> >> applied all of the changes, including these, to the `mm` tree.
> >>
> >> Do you still want me to send v9 under these circumstances?
> >
> > Sure, if that's what reviewers prefer.
> >
> > This is a bit unfriendly to people who have already reviewed the code.
> > Which is one of the reasons why I respond to a new version with a
> > single diff showing reviewers (and the author, and myself) what changed
> > since the previous version.
>
> As much as I dislike fixup patches, I tolerate them in reply to the existing series.
>
> But having some random fixup series is just crazy, really.
>
> --
> Cheers,
>
> David

Yes.

Stanislav - also see Jason's suggestion - if you give a base commit then sashiko
seems to work better. Maybe look at using b4 which does all of this for you
automatically?

Thanks, Lorenzo
