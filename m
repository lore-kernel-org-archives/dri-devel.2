Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681C1606A330
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 18:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=owuPPTBd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2EC110E08D;
	Sun, 22 Nov 2026 18:15:46 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4621C10E08D;
 Sun, 22 Nov 2026 18:15:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5551C61864;
 Sun, 22 Nov 2026 18:15:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7793D1F000C4;
 Sun, 22 Nov 2026 18:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795371340;
 bh=Ly0Qb7LtoPAwxIdNSlMhGXbiCyBmYz2wYY8MTMYeang=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=owuPPTBdy3mYxA1P7qyCUk7OH/zCw+ch3NE4bxilYoIrx/hGHfvw8+ACUg8nnTODh
 IgJShCeTIxn/4nF73AorMZrGEo4vU6cs4HAirzO5u1D3sEmIkVCkxXLHjXmZBfxO+V
 y8m7kzqf/g4l/mTcg0zgEh9FddQ6SzB4ovx9aYTdxwfUClhdRabFzrTrsnor9DEWS4
 3NLgE7TM0t2AoC8xHVcth20jul8I/IY+QO0OSo2PMzyzWPSDfSAhXz5EtBnnRlpaVG
 zxXCpDJ9f8eElgaEm6wa0MYOln/bapLKRAlnABnG5sC4SyB7d6xspPJdSTk3p1q6Rf
 q4cwQ6jh1+xKQ==
Message-ID: <1fafa3c2-3f8d-4672-bf84-c474d0e4f7f7@kernel.org>
Date: Sun, 22 Nov 2026 12:15:37 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: handle broken dGPU hotplug GPE on ASUS
 ROG Strix G513QY
Content-Language: en-US
To: Mike Lothian <mike@fireburn.co.uk>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, rafael@kernel.org
References: <8072db9e-0df4-4fc5-b86a-cc50ac7934a9@kernel.org>
 <20261122143557.2412982-1-mike@fireburn.co.uk>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20261122143557.2412982-1-mike@fireburn.co.uk>
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

On 11/22/26 08:35, Mike Lothian wrote:
> Mario,
> 
> Thanks for the CPM _L05 quirk. I've tested it on the G513QY (BIOS G513QY.335) with the dGPU runtime-resume patch on top. The boot log shows `CPM: \_GPE._L05 notifies missing \_SB.PCI0.GPP0.VGA, using \_SB.PCI0.GPP0.SWUS.SWDS.VGA instead`, and the external displays come up after a dock attach with the dGPU in D3cold
> 
> Feel free to add my Tested-by
> 
> Mike

OK I've sent that out for review separately.

https://lore.kernel.org/linux-acpi/20261122-fdo-gitlab-6061-v1-1-8380b1ec4e09@amd.com/
