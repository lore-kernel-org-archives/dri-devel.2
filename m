Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C675606A320
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OEDO1U0A
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 711C3112884;
	Fri, 30 Oct 2026 14:56:02 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2793B112884;
 Fri, 30 Oct 2026 14:55:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0FEF141F9E;
 Fri, 30 Oct 2026 14:55:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A541F000C1;
 Fri, 30 Oct 2026 14:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793372155;
 bh=UPDjS3wz2FnEuT+HHl36XN/pNdhynLSDtb+o3kgPntE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=OEDO1U0A9019x18y1u9ZJ2cuYYEETpk74W//i7K8221GcVf2WSzoUg1t8nIOE4w4i
 x6vTbaac+4XzUTlgecLH8JjgDdRhpVry/XWyabbeXOwKh7l1GMffT/bWaNHZsY4xT2
 25nrsrEVMMEjlZ+DgEDboae2tDZvS1edWH9Tnb5NUg279jXWVYJWBjKNFlW8f7yFP5
 k+r6tiJAZVzid1VKKI1b/QxqjVWLu4O+KdQV5vppDpw+6j6D6KNJMEHAe523zY3Rds
 O+uoWMoPPkWdyBGyvkIB6bdyvmf6kIYQgOaznzxb40nPnwffHXKjSWQ2EXJAXuNKCU
 4hRZgu+kQ1sZw==
Message-ID: <320e0bd0-fc6b-4b71-9024-55a6af558fa3@kernel.org>
Date: Fri, 30 Oct 2026 09:55:52 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: handle broken dGPU hotplug GPE on ASUS
 ROG Strix G513QY
Content-Language: en-US
To: Mike Lothian <mike@fireburn.co.uk>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261030075743.356835-1-mike@fireburn.co.uk>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20261030075743.356835-1-mike@fireburn.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/30/26 02:57, Mike Lothian wrote:
> On Thu, 29 Oct 2026, Mario Limonciello wrote:
>> Can you please get an acpidump and put it on a kernel bugzilla or drm
>> bug?  This generally feels like an ACPI interpreter issue to me.
> 
> Done: https://gitlab.freedesktop.org/drm/amd/-/work_items/6061
> 
> It has the errors and the tables from /sys/firmware/acpi/tables, minus my
> local override SSDT.  I haven't got acpidump or iasl installed so it's the
> raw files in a tarball rather than a real acpidump, I can redo it if you
> want the proper format
> 
> On the interpreter question: _L05 is only Notify (\_SB.PCI0.GPP0.VGA,
> 0x81), and \_SB.PCI0.GPP0.VGA doesn't exist on this board, the dGPU is
> under GPP0.SWUS.SWDS.VGA_.  I don't know what the interpreter is meant to
> do with a Notify to a path that doesn't resolve, which is why I put the
> question in the bug.  Rafael, if there's a better place for it I'll move it
> 
> Mike

I posted another approach for patch 2/2 to the bug where it's a quirk 
outside of amdgpu (since this looks like a BIOS bug).

I guess test that and then we can see where a quirk would best live.
