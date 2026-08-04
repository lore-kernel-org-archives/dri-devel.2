Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 512DFC55822
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 13:50:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36B0210EA30;
	Tue,  4 Aug 2026 13:50:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="s/3JvcdZ";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1077410E189
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 13:50:18 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-47f96c5b722so2715609f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 06:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785851416; x=1786456216; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EnvjlA4VIB7kb1Sr8VcLedlruGUDjsd/vyAj9uQl35A=;
 b=s/3JvcdZ+ZlDKkIT7aeGOXaBIbVTc1ktV8Txvqiw9XOfdStj0lplBQkyiiu58NvskI
 abrciZqhfowC8U6LMpShMu3qnTnAHPYxAXDbedguF6OFpP6cvHJgM7LK5eLXFy0TCklG
 8PPTUimFrtk+D6L9XEnCm8Psn21qdwEl3E+LkJXnlLvCcq1oiGqQAipwFde8/U84Xx4a
 wolbgnUc6CnY0iHCwTQggRkIaJ/rgl4H3foxHf4Eu9kup6hg0itY1jnnWi/8/B/v+4nB
 Cy0zCayVzosHiZjaOBEgKXoBnwDJGw0Kdn+XywoWA/JdoO58dLSSD7zmjrItqGoQBHuA
 OdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785851416; x=1786456216;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EnvjlA4VIB7kb1Sr8VcLedlruGUDjsd/vyAj9uQl35A=;
 b=cwwGCyrhk2ntZWJ1U4ZXWbUpnjm4Hjp4BMQrJo26Ysx5nrj0f3K1sFRAJhTv0xlthF
 zMLTvM0RcV3epcX6z2lIGvCI9vwSYGytuIR6NVLRAsRcN2fwp0ObVItz1JxB5poFDNnO
 FJ1NPRUdSyd0jQ6mU4YXNXqK7lvYy0HPpNZj5WF3hDjrPAcEkxLSaPHmQcU0+ayYm6Rv
 PeOly7OXz5CHc0YYdC/uScey50BjOMjNcVqNn2oYO2ZTb2lHFXmiyJaxPCNUmwLuxxOm
 8fjPogDOU0+unfcfTQPd4SIwssesoxk3KtYTbAxM68TuxpBiLqa5jSUvPrvSAOabkB6P
 zCUQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp+JvK0L/LJxH5oSts08pN3ba+Bk/yoI8TnGJwUCt+0JTrAQuTCclk/wPMA49vMfkREHAZxRoBHEbM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yze3UfDc7yvn+8iPKOI7DMpC94hQSVzWi2Hvln/C5+KKX6/h9Ac
 xoCpj9BkFXozwRnuzuSLYcmYfW8D+p2cmnswiYA8OQ2wJG+E4+ih78CJ
X-Gm-Gg: AR+sD10kmO70dJ9kEM/a4c12scEmByyihywYBMHqhCwWgiLwPBTwUdvPAfkmJjXNS58
 SrPa3xyLv05+Py1cgNUhDd6CuiYgHDcY4Gativ67FnCD392NDTFWODnk2wNHTyFRl3bQ1oOLo9s
 i/0Wnt5LBeRw7e3PftEVXIPppZtx5GM8yzh/4rvL2lQKdBYBJ6DSyqbc2e2radEstScJV9FvL3Y
 rm9LSuopTWHr+I52WJrptc3pDpK4OTM3GAhEZP0DYQvxLidK3AtBeuUb3lHfwbPBIKh5yAx3XIi
 1ScspfdoQJsy7myaQ3XRg6hk3ZifFv6XcEknSDqU82XMCBE2U4OBEW0nSQse7geg2bebrTGK0KU
 Vq5YzWHxkmQHhb91CeqYVsJDiWrEqr+DHEMb3U4aX6A1wUQybfBdtEQckmz3zYCpVwGVvRH6IlU
 f3wb3QL98r+s8W5L7CINBmJWtiv8OH6gMUX0CZ4EACyJ59OK51esGAbMc9nRPdRueFXlKnJh2bQ
 h2Ph90+sA==
X-Received: by 2002:adf:e199:0:b0:47f:e729:c588 with SMTP id
 ffacd0b85a97d-47fe729c5bamr16715641f8f.14.1785851416133; 
 Tue, 04 Aug 2026 06:50:16 -0700 (PDT)
Received: from [192.168.178.84] ([134.19.63.247])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd45a0ae0sm45000523f8f.33.2026.08.04.06.50.15
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 04 Aug 2026 06:50:15 -0700 (PDT)
Message-ID: <0c5ceb5e-a9d3-48c9-9ea8-d00966de22de@gmail.com>
Date: Tue, 4 Aug 2026 15:50:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/qxl: avoid hangs on an unresponsive SPICE host
To: Mikhail Novosyolov <m.novosyolov@rosa.ru>, dri-devel@lists.freedesktop.org
Cc: airlied@redhat.com, kraxel@redhat.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, simona@ffwll.ch,
 sumit.semwal@linaro.org, dreaming.about.electric.sheep@gmail.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 spice-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 a.sudakov@rosa.ru, ghadi.rahme@canonical.com, timo.lindfors@iki.fi
References: <20260724122636.213906-1-m.novosyolov@rosa.ru>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20260724122636.213906-1-m.novosyolov@rosa.ru>
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

On 7/24/26 14:26, Mikhail Novosyolov wrote:
> Symptoms:
>   - text/fbcon console (and TTY) of a QEMU VM hangs (does not work)
>   - SSH works OK
>   - system cannot be rebooted or powered off via systemd
> 
> QXL is a paravirtual display device: the guest submits drawing commands
> and the host (QEMU's SPICE server) executes them.  Each
> submitted batch carries a "release" -- a completion record the host
> marks done when the work is finished -- which the guest uses as a
> dma_fence.  Before the guest can reuse or evict a piece of video memory
> it must wait for the release covering it to be marked done: a to-do
> entry that needs its checkbox ticked before the page can be recycled.
> 
> The host drains the command ring only while a display client is
> attached (someone is watching the screen).  With no client -- the
> normal state of an unattended server VM -- the host stops processing,
> the checkboxes are never ticked, and the guest's wait never completes.
> Heavy console output (fbcon redraw) fills video memory and keeps the
> guest waiting on these releases, which surfaces as "[TTM] Buffer
> eviction failed" / "failed to allocate VRAM BO"; and during shutdown,
> where teardown waits on the same releases with no timeout, as an
> uninterruptible hang that leaves systemd and the console callback stuck
> in D state and makes the VM impossible to reboot cleanly.

That is a really good catch, it is actually mandatory for a dma_fence implementation to have a fallback timer to avoid such things.

> This change makes the guest drive the host forward again while it
> waits: periodically notify the host to process and free completed work,
> and run the cleanup that ticks the checkboxes -- restoring the
> behaviour removed by commit 5a838e5d5825 ("drm/qxl: simplify
> qxl_fence_wait").  Two deliberate choices keep the two known upstream
> failure modes from coming back:
> 
>   - the cleanup is queued asynchronously, never flushed inline (flushing
>     here would deadlock -- CVE-2024-36944; details below);
>   - the total wait is bounded (30 s by default), so a completely
>     unresponsive host can no longer hold the console/modeset locks
>     forever; on give-up a ratelimited warning is logged and the caller
>     proceeds or retries.

That sounds extremely questionable to me. From a dma_fence perspective implementing this in the qxl_fence_wait() callback is pretty much a NO-GO to begin with and most likely the reason why Gerd and Thomas reworked the code in the first place.

The usual approach is to have either a timer or delayed work which is started as soon as the fence is created and when times out pings the host periodically to do something.

To summarize the general idea is ok, but don't do that in qxl_fence_wait().

Regards,
Christian.

> 
> The periodic nudge resolves the eviction failures; the bound resolves
> the reboot hang.
> 
> Background -- known discussions of this regression:
> 
>   * Ubuntu/Launchpad bug and reproducer (test.sh):
>       https://bugs.launchpad.net/bugs/2065153
>   * Regression report and analysis:
>       https://lore.kernel.org/regressions/ZTgydqRlK6WX_b29@eldamar.lan/
>   * Debian #1054514 (the report behind the upstream revert):
>       https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1054514
>   * Ubuntu kernel-team reproducer thread:
>       https://lists.ubuntu.com/archives/kernel-team/2025-July/161304.html
> 
> Commit 5a838e5d5825 ("drm/qxl: simplify qxl_fence_wait") reduced the
> wait to a single wait_event_timeout() whose condition calls
> qxl_io_notify_oom() exactly once, when first tested.  The condition is
> never re-evaluated unless release_event fires, and with the host not
> draining no such wakeup arrives; releases never complete and the fence
> is never signalled.
> 
> qxl_queue_garbage_collect() is called with flush=false on purpose:
> flush_work() in this context deadlocks against the console owner and the
> worker pool -- the CVE-2024-36944 regression -- which is why the upstream
> revert of commit 5a838e5d5825 ("drm/qxl: simplify qxl_fence_wait") did
> not stick and was reapplied as commit 3628e0383dd3 ("Reapply "drm/qxl:
> simplify qxl_fence_wait"").  flush=false matches what the IRQ handler
> already does and cannot deadlock.
> 
> Bounding the wait deliberately relaxes the assumption documented in
> dma_fence_wait() (include/linux/dma-fence.h) that a MAX_SCHEDULE_TIMEOUT
> wait can never time out: a give-up is reported to the caller as a
> timeout (0), so the few MAX_SCHEDULE_TIMEOUT callers reachable from qxl
> through TTM (the page-fault idle wait, delayed delete, the OOM ghost
> swapout and evict_all) continue with an unsignaled fence.  This is not a
> new failure class: it only fires after fence_giveup_ms on a host that is
> entirely unresponsive -- on a merely slow host the fence signals long
> before the bound, thanks to the periodic nudge -- and the pre-regression
> implementation, commit 07ed11afb68d ("Revert "drm/qxl: simplify
> qxl_fence_wait""), already returned with an unsignaled fence via its
> 'goto signaled' path once its spin-count limit was reached.
> 
> The reboot/shutdown hang is a lock-contagion effect.  An atomic commit
> holds a DRM modeset ww-mutex and blocks on a release fence that never
> signals, so every later console update then blocks on that same mutex.
> Systemd's own console writes are such an update: they trigger fbcon
> panning (drm_fb_helper_pan_display() -> drm_atomic_get_plane_state() ->
> drm_modeset_lock()), which takes the ww-mutex non-interruptibly
> (TASK_UNINTERRUPTIBLE) and therefore lands in D state.  With pid 1
> stuck in D state the VM can neither be shut down nor rebooted, and only
> a host-side reset clears it.
> 
> Example of this lock:
>   INFO: task systemd:1 blocked for more than 245 seconds.
>   Not tainted 6.12.47-generic-5rosa2021.1-x86_64 #1
>   "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>   task:systemd
>   state:D stack:0 pid:1 tgid:1 ppid:0
>   flags:0x00000000
> Call Trace:
>   <TASK>
>   __schedule+0x408/0x1360
>   schedule+0x27/0xf0
>   schedule_preempt_disabled+0x15/0x30
>   __ww_mutex_lock.constprop.0+0x526/0x980
>   ? __kmalloc_noprof+0x177/0x420
>   drm_modeset_lock+0x37/0xc0
>   drm_atomic_get_plane_state+0x7e/0x180
>   drm_client_modeset_commit_atomic+0xaa/0x230
>   drm_client_modeset_commit_locked+0x5a/0x160
>   drm_fb_helper_pan_display+0xfd/0x240
> 
> 30 seconds seems to be a reasonable default value:
>   - it should not be triggered on a slow, but responsive host,
>     realistic worst-case release completion on a slow host is < 10 sec
>   - it must be less than hung_task_timeout_secs=120s
>   - it should be less than DefaultTimeoutStopSec=90s in systemd
> 
> Fixes: 5a838e5d5825 ("drm/qxl: simplify qxl_fence_wait")
> Assisted-by: Kimi:K3
> Assisted-by: Z.AI:GLM-5.2
> Signed-off-by: Mikhail Novosyolov <m.novosyolov@rosa.ru>
> ---
>  drivers/gpu/drm/qxl/qxl_release.c | 59 ++++++++++++++++++++++++++++---
>  1 file changed, 54 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
> index 06979d0e8a9f..75286e6d5ec5 100644
> --- a/drivers/gpu/drm/qxl/qxl_release.c
> +++ b/drivers/gpu/drm/qxl/qxl_release.c
> @@ -21,6 +21,8 @@
>   */
> 
>  #include <linux/delay.h>
> +#include <linux/jiffies.h>
> +#include <linux/moduleparam.h>
> 
>  #include <drm/drm_print.h>
> 
> @@ -56,20 +58,67 @@ static const char *qxl_get_timeline_name(struct dma_fence *fence)
>         return "release";
>  }
> 
> +/*
> + * Upper bound for a single release fence wait when the host does not
> + * respond at all, in milliseconds.  Prevents uninterruptible sleeps
> + * without a bound when a SPICE host stops draining the QXL rings.
> + */
> +static unsigned int fence_giveup_ms = 30000;
> +module_param(fence_giveup_ms, uint, 0644);
> +MODULE_PARM_DESC(fence_giveup_ms,
> +                "upper bound in ms for a qxl release fence wait with unresponsive host (default 30000)");
> +
>  static long qxl_fence_wait(struct dma_fence *fence, bool intr,
>                            signed long timeout)
>  {
>         struct qxl_device *qdev;
>         unsigned long cur, end = jiffies + timeout;
> +       unsigned long giveup = jiffies + msecs_to_jiffies(fence_giveup_ms);
> +       signed long left = timeout, slice;
> 
>         qdev = container_of(fence->extern_lock, struct qxl_device,
>                             release_lock);
> 
> -       if (!wait_event_timeout(qdev->release_event,
> -                               (dma_fence_is_signaled(fence) ||
> -                                (qxl_io_notify_oom(qdev), 0)),
> -                               timeout))
> -               return 0;
> +       /*
> +        * A SPICE host may stop draining the QXL rings, e.g. when no
> +        * display client is attached to the VM.  In that state releases
> +        * complete only if the device is kicked through the OOM notifier
> +        * and garbage collection gets a chance to run, so poke both
> +        * periodically while waiting.
> +        *
> +        * Garbage collection is queued without flushing on purpose:
> +        * flush_work() here can deadlock against the console owner and
> +        * the worker pool (see CVE-2024-36944).
> +        *
> +        * The wait is bounded by fence_giveup_ms even when the caller
> +        * passed an infinite timeout: a completely unresponsive host
> +        * must not hang tasks holding the console lock forever.  The
> +        * bound is reported to the caller as an ordinary timeout,
> +        * letting TTM retry eviction later.
> +        */
> +       for (;;) {
> +               qxl_io_notify_oom(qdev);
> +               qxl_queue_garbage_collect(qdev, false);
> +
> +               slice = min_t(signed long, left, msecs_to_jiffies(100));
> +               if (wait_event_timeout(qdev->release_event,
> +                                      dma_fence_is_signaled(fence),
> +                                      slice))
> +                       break;
> +
> +               left -= slice;
> +               if (left <= 0)
> +                       return 0;
> +
> +               if (time_after(jiffies, giveup)) {
> +                       dev_warn_ratelimited(qdev->ddev.dev,
> +                                            "fence %llu#%llu not signaled after %u ms, giving up\n",
> +                                            (unsigned long long)fence->context,
> +                                            (unsigned long long)fence->seqno,
> +                                            fence_giveup_ms);
> +                       return 0;
> +               }
> +       }
> 
>         cur = jiffies;
>         if (time_after(cur, end))
> --
> 2.51.0
> 

