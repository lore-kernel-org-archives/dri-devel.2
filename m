Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7455CC44500
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 07:55:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D394310E7EC;
	Mon,  6 Jul 2026 07:55:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j1vqs1gI";
	dkim-atps=neutral
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com
 [209.85.128.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 949BD10E7EC
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 07:55:26 +0000 (UTC)
Received: by mail-yw1-f182.google.com with SMTP id
 00721157ae682-804e46366d7so40776057b3.2
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 00:55:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783324525; cv=none;
 d=google.com; s=arc-20260327;
 b=GBdJ0S9NyZa4yoa01kJAYcohC/mVAmj3PwccFDeoS7eNfrlDIW0OBStysOLc8s4NuW
 MCkQZom7OLNvtP5urmfqA09QRndhwHHqo76P43EW2D9aUQuLyJp7iavDHzttO2MFexbO
 H4GxkIsCN3cDfLZdU4ZtvdXNeJO0rbo93pHC6TC7IVMINTlCVoJad5kh1Io2BzKdN7ch
 DyUpp7fwbRVmaF0jS8OUl8G74OH8UTCl6wLthvHIMOqeFauYWMUmuEXW/aKLZ5moxZZa
 buF2mu+2bHXTDn4tOMe2lgLKrj/rjkV1GYVmGHZhF/5+epZ9+eCgoo2BqwxTX2DwP7FQ
 34gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/XEVNZfbYRL67+UpgbRqTZBqZTbyV1Rm07jDf3o30m0=;
 fh=c9ShkdkLKioP5T2W9jvF4vgwBe3KaThCeJByGLkSIRs=;
 b=RsNMLDbs2b4/ZlwptO6N0aDbjT7O6t8HtuZlgpwiA18KL3uO/AE+jKWa0kAIKSGpoy
 yfZTGw/C2AM6JlFQTOdbsOmwDo4vAn5Kt5QFXT3f3cBWfHTjWt3K9G6pI7I39Lmv5LTL
 ztDltcrf1aOrrcD0WVaoNz9jY+GKY+7GYXY1tDU0MqbZyIs6LNmTNpKeMnxgwUj8cO6G
 t3VzyxBO9nWwAGtreqyynIwtooJpnY730cg09QYu6da2ifMyoN7gevLdn1ie/begj71i
 xTR8bF5dSSt4L2+WTBG0E9XhcFXpBwn5LaM+LDqFi6+Je3s9+922PndDPcxbWPP8vfZD
 JwWQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783324525; x=1783929325; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/XEVNZfbYRL67+UpgbRqTZBqZTbyV1Rm07jDf3o30m0=;
 b=j1vqs1gIQYuThKtTB+LJ7ifzucJmCeKs36GgsCtJM+CtWTvrfbqMcDrGuA/chf4xH6
 QO96uRhX82kO4D8kYt/STsC7AIB2WEbpC0Ujme0GJPVjWfNqbaULYAqjnpQjEJciDEop
 BF17JuFzMwBzVogy0UbQtVJrUoqbJ9k2bWRFIlItU3lrWyI3T6WSvwmN4YhqTN7naGFv
 lFUammDlWOVPvyF7mxMQEsPSCNSbj3GhRqIxVK9lbmsuk+GZLpFG7O3ieXJ+dzHhZftI
 RJVKnXkTilZoKAgzHZQQUwErE/tA3giVMkFmUgMHduDIOY6isWqBbQ/bgygAp7PaXsUo
 T3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783324525; x=1783929325;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/XEVNZfbYRL67+UpgbRqTZBqZTbyV1Rm07jDf3o30m0=;
 b=TQj+QlHK6I4c29o7CJKhY+seXBzmk9zcOptOtGhKp/sUxkvK1UtcsYy3aZDnz0DV/4
 ZgtUDuVIZSdwpTA6mvZfe/iR5npuHcGc0S4PCYcc0z7+9QhOei0LjRK1ubzK0D+Rx+N6
 Cm7AWX4jlEgNa+40gTsaJoObPg/HQ9PR5yaqaXpqNuJDPV0Q7XYNrI2p/TIFLJ8vqS50
 TIYWpBUFEdOgBV4Zw/DGmSJsKAZz0EADDS1wX4AgfPRiuimh7leph2K9MslfS4uN8WUV
 dgLnc5rAiGb64rQpy3p/J/28s+aEKbrils+XZKXEMZQ43PfrZuntWWViegaOJNZmtzA0
 3LEg==
X-Gm-Message-State: AOJu0YwtrQIAvBP0w1b821HLlTTeMTiGI2gfdlSPsMIhbgeo7fiT7/3I
 u4VeOIyT/rhJKl3U3NEHRrLjX1dqMnaUMUAYSpZ8YR+0iI4Ube18TcVTPY4Rjzy5o/7oGM4LwtX
 qY68NXw4ZgUUqq65/slVC0ZUKnP04sjK510X61ts=
X-Gm-Gg: AfdE7cmR5i8balvytQyNlWC+ZAsxIG+bq2ZRdvtOQGXu4JPmnnFrP2Zr43ujkjtH5hv
 iN49JssYchj56eoAuq69rxZML7DVVtNubhfIJbpYoAxKpfEuK8W8FHJeNKoBdt12NVbjXrULrl/
 NTcFOE8AMJbz37M2fbj99J/0+/fpBIy9ziS2ys+I4TqmUX0SU0FdpXaXfAl8BkE7jvZ/eAQK8Hj
 NGZGM896zTqVCk5EBhPUta3wKSSXKxDAP/dJlEbY+vYEbJCHZ/WcmWK2uLle4ZPKCbxarri7erh
 ZHervxAcp1gCeseKpF/1suvWmjJ/TOAMEW0vS30dg8HZ3PkKyggG+uZg8w==
X-Received: by 2002:a05:690c:b19:b0:80c:85b6:7654 with SMTP id
 00721157ae682-817398ee8acmr90492207b3.57.1783324525215; Mon, 06 Jul 2026
 00:55:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260706052330.1110909-1-airlied@gmail.com>
In-Reply-To: <20260706052330.1110909-1-airlied@gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Mon, 6 Jul 2026 17:55:04 +1000
X-Gm-Features: AVVi8Cfx-dDIbhjl6PnXaEFhBzsvAKm5asFdkh4qpLxeTgixFJOzjr0UZq9aong
Message-ID: <CAPM=9txKzx6qji23YpY=d6Wrd-se-abZoOmDUW32HCx5YsL0tA@mail.gmail.com>
Subject: Re: drm/ttm/memcg/lru: enable memcg tracking for ttm, xe and amdgpu
 driver (part 2) (v2).
To: dri-devel@lists.freedesktop.org, tj@kernel.org, christian.koenig@amd.com, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>
Cc: cgroups@vger.kernel.org, 
 Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
 Waiman Long <longman@redhat.com>, simona@ffwll.ch, 
 intel-xe@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 6 Jul 2026 at 15:23, Dave Airlie <airlied@gmail.com> wrote:
>
> This is just a repost with a number of sashiko identified problems that I fixed.
>
> I committed the vmstat counters and list lru changes, and they are now in tree.
>
> This is the remainder of this series. Intel have expressed interest in getting
> this landed for xe, we can drop the amdgpu changes for now if they can't get
> across the line.

I've put the latest code at
https://github.com/airlied/linux/tree/ttm-memcg-objcg

I've been fixing more sashiko found issues in there before I repost in
a few days.

I've reordered things a little in the branch but mostly the same code.

Dave.

>
> I've dropped all previous acks/reviews.
>
> This series adds the memcg counters for GPU active and GPU reclaim to align
> with the two global vmstats. It adds an accounting flag to TTM alloc/populate,
> and enables memcg tracking and shrinker support in TTM.
>
> Then it adds amdgpu and xe support.
>
> I think for this to land, Christian holds the main objection which I still fail
> to fully understand beyond it doesn't solve all the problems we ever have had
> with cgroups and drm, so we shouldn't even bother, and maybe we could do it at
> the object level, and integrated with dmem, and android cross process accounting,
> but I still feel this is a good baseline.
>
> I think this is the right layer to hook this into TTM, where we allocate memory
> and I think accounting for this memory in a proper way should be done.
>
> Intel folks (Thomas/Maarten) please review and express concerns as well.
>
> Regards,
> Dave.
>
