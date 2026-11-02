Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073426093D48
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 15:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D5tizpqR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10EB010E65A;
	Mon,  2 Nov 2026 15:51:43 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBC1610F03D;
 Mon,  2 Nov 2026 15:51:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7AACA43AED;
 Mon,  2 Nov 2026 15:51:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F1B11F00A16;
 Mon,  2 Nov 2026 15:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793634696;
 bh=C7aFuzdls6CQ3GEmXGxCiI5GUWUf2f2iJx673Dth3g4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=D5tizpqR4xrHu4YwapRRWNos3EDfp05QjyFOvhcfYBZMDx/eEJa3FN+G1NpWXDX15
 uj1/oK7+m11dI2BLfIw+WmtcSwWr3MldhBDo871T12+FIR9Vq3f/xaH75RjaqgZGWX
 DCipWZSkILvvq1mQhLCJm2CXM0oCPy8XJsyu1cNFhxGNCujxRnYN4e7DseYk2e4D9a
 wJpq2HpFfs5ATTLt28QQeqA9dnbMU1pnGTR3qEQ4G2n0kRKRXXaH037mDMXSwZNYbu
 T67P+OpWf6h9FbNWNHEjsskh0/1yC86HFdXAgz9aAJZDoYacMPB3SrH724Tj19XkOu
 kwVKcwDEwCUnw==
Message-ID: <7970b6c9-03ef-439a-862b-dceb444b42ff@kernel.org>
Date: Mon, 2 Nov 2026 09:51:32 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Clamp the ATIF backlight curve to its 99
 points
Content-Language: en-US
To: Hugo Sales <hugo@hsal.es>, alexander.deucher@amd.com,
 christian.koenig@amd.com, amd-gfx@lists.freedesktop.org
Cc: lijo.lazar@amd.com, harry.wentland@amd.com, alex.hung@amd.com,
 kees@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261031153948.127016-1-hugo@hsal.es>
 <991e63e4-4230-40c0-a18f-6c0103bd225f@kernel.org>
 <1267219663.279946.1793633834409@app.mailbox.org>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <1267219663.279946.1793633834409@app.mailbox.org>
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

On 11/2/26 09:37, Hugo Sales wrote:
> On Mon, Nov 02, 2026, Mario Limonciello wrote:
>> I would like to know though; did you see this in the wild?  If so I'd
>> like to hear more about the system that had it and the system firmware
>> on it.
> 
> No, I haven't seen firmware do this. I found it by reading the code while
> working on a series that does the intermediate calculations for the
> ATIF curve at full precision, which I'll send soon
> 
> Thanks for the review,
> Hugo

Got it thanks.
