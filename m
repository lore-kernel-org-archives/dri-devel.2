Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B0D606A326
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hIV366cj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B26E112874;
	Fri, 30 Oct 2026 14:52:16 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBBE2112872;
 Fri, 30 Oct 2026 14:52:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A5E9F44060;
 Fri, 30 Oct 2026 14:52:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89331F00A02;
 Fri, 30 Oct 2026 14:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793371929;
 bh=IynCA/CXHHxpvBVvDUwuv5p+dERMEHS5aKDO2xZbSGI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=hIV366cjcNsvxIP7LxLTIg+RpNbiujGvx4EXw47fMFYNX+tjxcuEB+Mbt2xNJtb/6
 KuuSzmtIr0mrHfDyrMgLMdua+MtGvkCfI7/OSinyLYXuzV1r52JYt6l7zUGX5p7PXm
 mBpWGEilcuteN47a8ioT4ukPSCrp+sd00HICugXaSlYdjUOeL3lcSiSsk9Ns17vsNx
 SgkqzRD1KI2eeG7wwumI06PYgWF/8fWuXlLCorFRhnGNosYr2sy3Co4OGjaVuVl5Rk
 T/PIVxMiXGgd8PxnVP3O5KRBE+UVon3PdKiGpSR58R5sjmbMdO3OwXGd4H+kJJQChN
 CAgpMR8SPP+zA==
Message-ID: <c018e549-6d31-40fc-9b82-05b53d4dac22@kernel.org>
Date: Fri, 30 Oct 2026 09:52:08 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: runtime resume dGPU on ACPI notify from
 its own node
Content-Language: en-US
To: Mike Lothian <mike@fireburn.co.uk>, Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261030075735.356811-1-mike@fireburn.co.uk>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20261030075735.356811-1-mike@fireburn.co.uk>
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
> On Thu, 29 Oct 2026, Alex Deucher wrote:
>> I'm not sure about BACO.  In the BOCO case the OEM has a mux on the HPD
>> pins that redirects them to the EC when the dGPU is powered off.  For
>> BACO it's usually a PCIe add-in board so there is no way to redirect
>> the HPD pins.
> 
> Agreed, and I can't test BACO anyway, so I'll keep it BOCO only in v2
> Mario, sorry, I'll leave your BACO suggestion out unless someone has a
> board that needs it

No problem.

> 
>> Mike Lothian does your system have ATIF?  This is already code to
>> handle this.  It sounds like it's just registering the wrong ACPI node.
>> You should be able to use the existing handler.
> 
> It does, but only on the iGPU: ATIF is in SSDT7 under \_SB.PCI0.GP17.VGA_,
> and the dGPU node (\_SB.PCI0.GPP0.SWUS.SWDS.VGA_) has none
> 
> What arrives here isn't an ATIF notification either.  _L05 in SSDT9 is
> just Notify (\_SB.PCI0.GPP0.VGA, 0x81), and that path doesn't exist on
> this board, so the interpreter aborts the method with AE_NOT_FOUND and no
> Notify is delivered to anything.  I've put the tables and the errors in
> a bug: https://gitlab.freedesktop.org/drm/amd/-/work_items/6061

Yeah looking at the tables this does look like a BIOS bug.  So quirking 
it somewhere feels appropriate.

> 
> What I haven't checked is whether the firmware would flag a dGPU display
> event in the ATIF SBIOS requests if the Notify did arrive at the right
> node.  If I alias the path so it resolves, I can turn on drm.debug and see
> whether amdgpu_atif_handler() fires and what request flags come back, and
> if ATIF_DGPU_DISPLAY_EVENT is set I'll use the existing handler rather
> than add a new one.  I'll report back
> 
> Mike

