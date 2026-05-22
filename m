Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A73CD5BAC
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 18:55:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E65B410E2AC;
	Fri, 22 May 2026 18:55:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="gE/nsoIC";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F40B10E2AC;
 Fri, 22 May 2026 18:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1779476152;
 bh=T3X0qyXrDkda0w7uSasjHxeNcjgg7yJJUiqlmBkuCa0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=gE/nsoIC/s9AY4W7tXMuu3wWLflKjzrazBPR9IB+03yyMI0vNdUXrIya7K/avlkXB
 sC+6n7+Oxeq6EdwW8p0sbnFDRpsPiVqJjNrXNYXB2R5u3WoIz4SPsVZagp9Mkb7r6v
 Q91emHHU7VmCnBl9YbMgGjQrxK0/+4nrDnMfAP2olETyBexaPEeAgAcpwsgP7diPOG
 tez8FiiDZT+wKDdc/dCjDRCrEPPEbPodW0p9QUAI1tPV1NLJ84y8/yAjC6fXnRU4o2
 /2fdbDZZNyw8ZAR7/jwtbkzQt6N7cEB58MMZe1laeM34/RfrB0tpOqinF6WBTa0+bC
 OPH0r6KJjd0+A==
Message-ID: <6874536d-ab1a-4dd7-a23f-2a071bda145e@lankhorst.se>
Date: Fri, 22 May 2026 20:55:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drm: xe: Kernel-submitted job timed out
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 intel-xe@lists.freedesktop.org, dri-devel <dri-devel@lists.freedesktop.org>
References: <CAHk-=whiv=b+dAvjaZDsZkfUEzjZMSSLExDOWVcbJ0exsCj6_Q@mail.gmail.com>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <CAHk-=whiv=b+dAvjaZDsZkfUEzjZMSSLExDOWVcbJ0exsCj6_Q@mail.gmail.com>
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

Hey,

Den 2026-05-22 kl. 20:52, skrev Linus Torvalds:
> Actually, this doesn't seem to have actually timed out, it seems to
> have never been started, and then subsequent operations were confused.
> 
> Because I had to reboot my desktop as non-responsive (the cursor was
> moving, but no screen updates) after two lines of
> 
>   xe 0000:4b:00.0: [drm] Tile0: GT0: Check job timeout: seqno=4485322,
> lrc_seqno=4485322, guc_id=0, not started
> 
> followed a few seconds later by some Xe fault and then an endless
> stream of "Kernel-submitted job timed out" reports.
> 
> Presumably that job was the thing that was never started in the first place.
> 
> Cut-down dmesg with the endless repeats deleted (after rebooting to
> get a working system) attached.
> 
>              Linus

There's a 
May 22 11:09:19 3970x kernel: xe 0000:4b:00.0: [drm] Tile0: GT0: Timedout job: seqno=4485322, lrc_seqno=4485322, guc_id=0, flags=0x73 in no process [-1]
May 22 11:09:19 3970x kernel: xe 0000:4b:00.0: [drm] Xe device coredump has been created
May 22 11:09:19 3970x kernel: xe 0000:4b:00.0: [drm] Check your /sys/class/drm/card0/device/devcoredump/data

Do you have this coredump too?

Kind regards,
~Maarten Lankhorst
