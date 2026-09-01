Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E47C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 09:07:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EDD510EC15;
	Tue,  1 Sep 2026 09:07:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZLv9z5Oz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA03B10EC15;
 Tue,  1 Sep 2026 09:07:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D6D29601DE;
 Tue,  1 Sep 2026 09:07:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE701F000E9;
 Tue,  1 Sep 2026 09:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788253625;
 bh=m/wEGTF4f7C70SB4/q9aIKOMg+2fN6lt/IMX6OVr2GE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=ZLv9z5OzoD0fx0iYaQYmDawsSdPZZbIEG6BC3Nio+WgHgZj2R8fnHzPnvWo4SiKZY
 /Of7JDUDx8RQZgRNlPu0NMl+oU0rov2ViyfmzazCwUqbQpeZo69AS03Xjy9Nemwvue
 1yd5pahrTxqSacJKWqYwwBEhvHuyLxN4szUq6g1IGkgOBQQ2rRzpZlMNZqSA3pMN7y
 9oKHA4EG0gWAE+gdrMw9AHbwa86VqFfe4W3IbtjZzYeugQGBgYYg7s5d8PTa6YVPqS
 ghMwkdjf4ELQY+uSeA09R38BT4sRW+FX7EN5XYlSdHAo2SkFeBA2pRMj6C8CVEc4vT
 L1yofrhBrittQ==
Message-ID: <2e433e8d-a71e-49e4-8dea-659a94c8143f@kernel.org>
Date: Tue, 1 Sep 2026 11:07:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/nouveau: bound sync and op counts in EXEC and
 VM_BIND
To: Dave Airlie <airlied@gmail.com>, Junrui Luo <moonafterrain@outlook.com>
Cc: David Airlie <airlied@redhat.com>, Lyude Paul <lyude@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Yuhao Jiang <danisjiang@gmail.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20260808-nouveau-fixes-v1-0-c3ebdc17a89c@outlook.com>
 <20260808-nouveau-fixes-v1-1-c3ebdc17a89c@outlook.com>
 <CAMwc25qozGSRw8KKNzVhakH1jCNWsFS_z=mFn9hswxjdNNX0GA@mail.gmail.com>
 <55965C34-9026-4EE7-B2F0-1D5D9807D682@outlook.com>
 <CAPM=9txG6wEwx_L5RsB+3gEuT6dYJQvrPpQnHHF4V1gFZpWNFQ@mail.gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <CAPM=9txG6wEwx_L5RsB+3gEuT6dYJQvrPpQnHHF4V1gFZpWNFQ@mail.gmail.com>
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

On 8/11/26 6:05 AM, Dave Airlie wrote:
> On Tue, 11 Aug 2026 at 14:00, Junrui Luo <moonafterrain@outlook.com> wrote:
>>
>> On Mon, Aug 10, 2026 at 08:43:50AM +1000, David Airlie wrote:
>>> Have you run a complete Vulkan CTS with NVK across this with no regressions?
>>>
>>> I'm weary of those limits being too low, but I think the only app that
>>> might push them beyond CTS would be Forza Horizon 5 or 6.
>>
>> No, I have not. I don't currently have the hardware to run NVK, so I can't
>> offer a CTS run or any other regression test for this.
>>
>> Is there a better guard that avoids a hard limit here, or does this need
>> a test before it can go in?
> 
> Looking at xe it also has 1024 limit on number of syncs, but it
> doesn't have any limit on number of binds,
> 
>                 *bind_ops = kvmalloc_objs(struct drm_xe_vm_bind_op,
>                                           args->num_binds,
>                                           GFP_KERNEL | __GFP_ACCOUNT |
> __GFP_RETRY_MAYFAIL | __GFP_NOWARN);
> 
> Maybe nouveau could do the same.
SGTM, I'd also be hesitant to put a hard limit on VM_BIND.

@Junrui: Can you please resend?
