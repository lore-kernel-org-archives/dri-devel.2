Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 563B5E9A779
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 12:52:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 697C610E69D;
	Tue, 24 Mar 2026 12:52:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J0m0ok8m";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A562B10E48E;
 Tue, 24 Mar 2026 12:51:58 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 6F14843C47;
 Tue, 24 Mar 2026 12:51:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C77AC19424;
 Tue, 24 Mar 2026 12:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774356718;
 bh=xvicNmew9YGVE06h8feoW2WxPglCVqW6Ob1aqjokys0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=J0m0ok8mYABf6NtwFb0fQ+bgKBJ3sRCDZwG55FzC8VdLXM7hmtw4ep11W9+APxQrx
 K+TjLbau9TJtVul6lXk2YJtFlWB8WozTRPB09jQiJOYMg8Yk9BR7DK7m1lbZPc+LJN
 OXWDEeCwzXSwwRacJFBHEB4HDSJqtPx6uP7V6C0HKMThlLM8rqprL/OHjWdTPXQbNJ
 x8TF56E26tOSH5SHyGdqXT0XDu76YDL/8lDyEqkQao0JGydrksoMGet8iepwO759EG
 iI/MISunGCc/IAinK3cZvEYEkPTOLJpi9lJQkRS4A7xUxqgBVNX615iyz0JfZvuqMj
 Rz0cM/PaXdU1w==
Message-ID: <5ea753b2-a702-4d13-973a-9eaffa9562fe@kernel.org>
Date: Tue, 24 Mar 2026 13:51:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] dma::Coherent & dma::CoherentInit API
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: aliceryhl@google.com, acourbot@nvidia.com, ojeda@kernel.org,
 boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, tmgross@umich.edu, abdiel.janulgue@gmail.com,
 daniel.almeida@collabora.com, robin.murphy@arm.com,
 driver-core@lists.linux.dev, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <9A1gWen63AbJmi06Y_vu_qF1S86nj3fcQEil9RzLAn8QkIYpCOrLMNO7JcgIP0BccPHhzaYaQ_te1S_gKuHRgg==@protonmail.internalid>
 <20260303162314.94363-1-dakr@kernel.org> <87cy0tqueu.fsf@kernel.org>
 <NNO45MYwzudmCWH1mWf1k0Icy8Q0eKR4ANI6fg9-zxq3_dHLfhyRsHaq2l77l-RBwmek7tHzQIv2vNhOFg1Ysw==@protonmail.internalid>
 <314ab89f-3aee-49f5-804b-f33dc8ef5ba4@kernel.org> <87a4vxqtsj.fsf@kernel.org>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <87a4vxqtsj.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 3/24/26 1:46 PM, Andreas Hindborg wrote:
> "Danilo Krummrich" <dakr@kernel.org> writes:
> 
>> On 3/24/26 1:33 PM, Andreas Hindborg wrote:
>>> What did you base this on?
>>
>> drm-rust-next
> 
> I don't think 1195fcbda62f12108dc9be56fa4173897905b90c is in
> drm-rust-next - or any of the other branches in of
> https://gitlab.freedesktop.org/drm/rust/kernel.git .

Oh, I did not notice that you replied to v1, there's already a v2.

[1] https://lore.kernel.org/driver-core/20260320194626.36263-1-dakr@kernel.org/
