Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAC8606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 11:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KZV3KZQh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B48FE112091;
	Thu, 19 Nov 2026 11:23:26 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C6F61122D9;
 Thu, 19 Nov 2026 11:23:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D2DDA459D9;
 Thu, 19 Nov 2026 11:23:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FEBC1F000C6;
 Thu, 19 Nov 2026 11:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795087399;
 bh=bD2PUByY+VoW0/QeAkFfaWf2SOQFiIj81uMbYeu8J/g=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=KZV3KZQh+Qo1GImrFxKW/fpmBFHUaHnNmPwXrgTv1iXENlGjqE+tvhf1SvqOnIDmx
 LYGTF6taCmxSdlwyJf2Ps+GDSWFROFQPaxViuea70PXtky0zDsUEp0VPXvMU81o8SZ
 eb8MZoHYKMTfCWR/0rK/fuU86f5BJXw9nV+G3wLJPCRqo1T8ZIK+y2oEjsMqvZpz0f
 xZsR68to+8Olq4fJjjtUR3YRUH6yO5ju0ji5qeUE3i/U00ekfNzuiW5CRfqrld4qh4
 gh9RPMPO1PDmpTjk18eH8PIadAMcJgcHNew9B6546aRxyk7HYgTo0Ex06mS/3lIYXA
 kYyKSo6smxMVQ==
Message-ID: <53b5fa1b-9c26-4493-a5fc-7d0393b53abd@kernel.org>
Date: Thu, 19 Nov 2026 05:23:17 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amd/display: Route connector DDC over AUX for
 native DP sinks
Content-Language: en-US
To: =?UTF-8?Q?Eren_=C3=96zen?= <erenozen@protonmail.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Richard Hughes <richard@hughsie.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Wayne Lin <Wayne.Lin@amd.com>,
 simonit.orig@gmail.com
References: <20261118-superm1-amdgpu-ddc-v4-1-539eaeb4edd7@kernel.org>
 <oUnLboT5nQrS84FGA16aamWt5D9VXEosZZdV3BIUQ1cu4drCXXKDR3kPP0vGvglmf0jXGMvoaYLI1jYamvaz4Zdd2D-6BJ-7I9bv3eZylm4=@protonmail.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <oUnLboT5nQrS84FGA16aamWt5D9VXEosZZdV3BIUQ1cu4drCXXKDR3kPP0vGvglmf0jXGMvoaYLI1jYamvaz4Zdd2D-6BJ-7I9bv3eZylm4=@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 11/19/26 02:36, Eren Özen wrote:
> Hi Mario,
> 
> Thanks for folding it in and for the credit. My part was written with
> help from an AI assistant, so per Documentation/process/coding-assistants.rst
> as far as I understand, the commit should also carry:
> 
> Assisted-by: Claude:claude-opus-5-5
> 
> Could you add it when this gets applied?
> 
> Thanks,
> Eren

Actually the kernel dropped the policy for documenting this requirement. 
  So no need to add it.

I still do have feedback from Sashiko about the swapping to a passive 
DP++ dongle.  But I'd like to know from Simon if this even conceptually 
works.

So Simon please test this patch against the original issue.

If you need some help building the kernel, I suggest working with an LLM 
on your specific distro, they're pretty good at helping with this kind 
of thing.
