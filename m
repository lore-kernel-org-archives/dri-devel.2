Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71416C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 18:29:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6A6810E027;
	Thu, 13 Aug 2026 18:29:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kaitmazov.com header.i=@kaitmazov.com header.b="bW5Q755v";
	dkim-atps=neutral
Received: from mta0.migadu.com (out-128.mta0.migadu.com [91.218.175.128])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5075F10E027
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 18:29:24 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=HJ8TGsHD56gO0k7scDjxSAT+/HxqnyQ6ZbrnxtMzKOE=; 
 c=simple/simple; d=kaitmazov.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786645762; v=1; x=1787250562;
 b=bW5Q755vXT2sT/nH48z/++TBfXAFF1m92mqQSHDS1nKyIh4fSriCMnkGYI9ugVTNi2NT/xSJ
 iF6ceswWuTRKCUW4+aD6j+J+mpmT/+UQNbI+EFAwJZ/VBgKyDx3bolnK+bgJO0Sip4PcgmKCIC8
 vRi2VePAGFNe6lgyzlJS7kbLR+2GjyzEVxFQl5TrCiigL1cW5nhy0N7IOKQDhx6+4irciPCi6Mw
 juu0mHbTBQLAJV7K7YUjUOt5YwP9xYmZl6IHtwWiq6kAJCOW7hQfPBe5fs4+1J+1kVbtJIZJ7c+
 za6E7GC82+QXy14Cdg67T2aJD4Z1VQ/yGUkH3Tatm6otg==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: from cachyos-26.lan (193.42.111.69)
 by smtp.migadu.com with ESMTPS id 2c05220055d7335f;
 Thu, 13 Aug 2026 18:29:12 +0000
X-Migadu-Flow: FLOW_OUT
From: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
To: Lizhi Hou <lizhi.hou@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Min Ma <mamin506@gmail.com>, Oded Gabbay <ogabbay@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Max Zhen <max.zhen@amd.com>,
 Sonal Santan <sonal.santan@amd.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH v2 0/5] accel/amdxdna: honour the SYNC_BO range
Date: Thu, 13 Aug 2026 21:29:04 +0300
Message-ID: <20260813182905.124248-1-taimuraz@kaitmazov.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <9420bbe5-46a3-84be-eae8-596bc42bddac@amd.com>
References: <20260811231351.1011244-1-taimuraz@kaitmazov.com>
 <ee663474-5de0-4ffe-8ac1-1dcdff5dbc28@amd.com>
 <224dd281-da48-84b3-a048-016b51aa0362@amd.com>
 <a505f9e5-b416-43e9-934d-c5c29b8a70e9@amd.com>
 <9420bbe5-46a3-84be-eae8-596bc42bddac@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Resending: my earlier reply does not appear on the lists, so I assume it
did not reach you either.

On 8/13/26 20:08, Lizhi Hou wrote:
> The legacy NPU device is not cache coherent. And the next generation
> (aie4) devices will be cache coherent.

Confirming that with numbers, since I had measured it before your reply
landed. On npu4, without a flush the CPU reads what the buffer held
before the NPU wrote it, and the NPU reads what DRAM held before the CPU
wrote it. Both reproduce on all 20 runs, and the stale read is most of
the buffer, not a stray line: 3931 of 4096 values on average.

Good to know aie4 is coherent -- that makes anything we do here a
legacy-only concern.

On 8/13/26 09:44, Christian König wrote:
> An alternative would be to use DMA_BUF_IOCTL_SYNC from userspace

Tried it against amdgpu, imported into amdxdna: stale on all 20 runs, no
better than no sync at all. SYNC_BO on the same buffer is clean on all
20.

Which leaves me no legal way to import a buffer the CPU also reads. Is
there one I'm missing, or should a device like this just not import?

On 8/12/26 17:45, Lizhi Hou wrote:
> we need to unconditionally return -EOPNOTSUPP for imported BO

is_import_bo() also covers ubuf and cbuf, so that stops maintaining our
own userptr and carve-out BOs too. They take that arm today: on a 64 MiB
userptr BO a 4 KiB sync and a full sync both cost 659 us, so the range
is already being ignored there.

Keying on dma_buf->ops instead would confine it to foreign buffers.
Either is fine by me, tell me which you want.

Separately: XRT's buffer::sync() clflushes in userspace unless
Debug.force_driver_sync is set, so the stack does this to foreign
dma-bufs whatever the driver does. And when the ioctl is used, a
FROM_DEVICE sync returns -EINVAL after the flush has already run, out of
amdxdna_hwctx_sync_debug_bo() when the BO has no assigned hwctx. Happy
to send that as its own patch; the helper has one caller, so returning 0
there is the obvious shape unless you want it done elsewhere.

v3 is sent: patches 1, 3 and 4 only. Patch 5 is dropped, and 2 with it
since it only serves 5. I have not tested 5 on a matching tree and its
numbers came from the foreign import case.

Taimuraz
