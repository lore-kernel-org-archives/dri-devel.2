Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0919C79FBF
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 10:06:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38F8410F3FD;
	Thu, 10 Sep 2026 10:06:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eJ0mjHb0";
	dkim-atps=neutral
Received: from mail-oa2-f1.google.com (mail-oa2-f1.google.com [74.125.231.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 407A810E08B
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 03:54:01 +0000 (UTC)
Received: by mail-oa2-f1.google.com with SMTP id
 586e51a60fabf-448a12ddfb4so2897996fac.1
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 20:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789012440; x=1789617240; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MphXScIlea9Ch/HqYCopSdk5l+/MgVBRqofI+uB1fjg=;
 b=eJ0mjHb00f7j8XXKdTOofe+S2H1xp42gPmGjEkCktTdRDQdT/E1WpWGvbMTQw7VnqV
 l6DLUl/9Kt3Cqm+fS0cm7wQa9O1S1yO0xVF4GUMzjyZ+NMSW6pZKSBbqY+QxzPAQUHl+
 u3I6W3khjy2qbyd09lBd+LXSnL9EBft6kUxJ9DxtBO07LxH+M1AINK0BtusKjAcAXw4R
 /xtwRXQ+8IVI9Mi4MHD/9F8RKVzFUT/HCI0il/m97cCnHhwZLO/IZNxOYxvDEi3PDiy+
 TsJER3ItJuQSlEu/6odFPSn70mGdsJ3WLwKzMaR/YFNvJ+xLpvnSViuOar7Wji0PmpqI
 pCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789012440; x=1789617240;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MphXScIlea9Ch/HqYCopSdk5l+/MgVBRqofI+uB1fjg=;
 b=jWeFTc67KivFSi6oP6kFoqcE/k09pUlurb3eEKJDucSTCI3g73XWjdvqEA1rSIoLlz
 b350PdvqCJEg5NYKbtaqTnKRS0BBszMccPa048V+Ow27b4m2bxXsTIKhn+z9QBZLrM56
 O6ubVD8ZqTC+B+22nlgOusQf9yWJna1uI3kFDuwLbHkboqfd7wL1psch8suVOruVGWf+
 2pmAFepvtokdkJyQyXswuCevwMi/tTqnWynGspnRGKdgLbfM2o/6p+V4xqUSwXILTxjL
 zT02TciblJQwfqcSO3MBglqOkQElCjc4I77HQiCdNZ+ik9LBQc63Xe7QmOsH7HQAbZxS
 iEzw==
X-Gm-Message-State: AFuF++kr7vNYsa6xOnwvo5lWbR7sAQnp1mInZCd1O1SOSsy/0TkCd3Iv
 yfZTNNZ6cz6mPmHUellWi48cTEbYl+PGVHz3VeKXe+9/r+ItefIP5ChTIYBPN3mX0lQ=
X-Gm-Gg: AYBFou2898bmcRz4iGbWpoRh7tvA20vjcsRFEyscpC+193FBi17zPL0fdDQbhFhmCHU
 wFpja07yMxog1IapoHAheeKX2+ib6ud4vKZmchjLb8S70q9hbcdWQu/oVhMhKlT1ipexq1aeqp6
 pIIJdhhnumXp/oAE8vWlXEJSTkITf9fRJ4zkb2xvPILr0D5lMur29OrAYz+j2VkEA47NGzPx8Ny
 T4HMHR4HpBCn0NQplR7X6OpEgwbibzOqbC4c6bWqVICYDyKE8G4Z8TZBbTKe8/tKTMNcVcLSpX7
 t4S8NkgzrKnb8QwUPViU7J2c2u34Jm6dT752xI+V/Jgzgw8JB6pVqEjS17zaFOHnt+Ao7TyawbB
 u2RQV8nQPnoVz/AkIyE4MYmVrQ/ixMHAePWS4DBmz9VrGgo9DRCqWAxvaTR2M9y4WjmxQCqmVX9
 HQxgY+B42wZyUKWNC7Pma/ymZjXfwgbtULhh5tjXOXtXV1alsAETGHTiCJdrBJqMa1t+I0Oir9Q
 wlbSgMPddTnGRav5kYIinxSj+o=
X-Received: by 2002:a05:6820:81cc:b0:6b1:9f9d:7a00 with SMTP id
 006d021491bc7-6bee25409d4mr5533822eaf.5.1789012439997; 
 Wed, 09 Sep 2026 20:53:59 -0700 (PDT)
Received: from ?IPV6:2600:8804:5716:d800::b712? ([2600:8804:5716:d800::b712])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-475543fcaa9sm15753624fac.7.2026.09.09.20.53.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2026 20:53:59 -0700 (PDT)
Message-ID: <31087903-ac71-4561-aa6c-00abdb309fe0@gmail.com>
Date: Wed, 9 Sep 2026 22:53:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/imagination: suspend the GPU for system sleep, not
 just runtime PM
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
References: <20260909-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-v1-1-f45847bc951b@gmail.com>
 <20260909192653.C24201F000FF@smtp.kernel.org>
Content-Language: en-US
From: Ryan Brue <ryanbrue.dev@gmail.com>
In-Reply-To: <20260909192653.C24201F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 10 Sep 2026 10:06:32 +0000
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

On 9/9/26 2:26 PM, sashiko-bot@kernel.org wrote:

> [Severity: High]
> Does delegating system suspend to pm_runtime_force_suspend() cause the system
> sleep to abort if the device is lost or unplugged?
>
> If the GPU crashes and is marked lost via drm_dev_unplug(), the PM core calls
> the .suspend callback, which delegates to pvr_power_device_suspend():
>
> drivers/gpu/drm/imagination/pvr_power.c:pvr_power_device_suspend()
> 	if (!drm_dev_enter(drm_dev, &idx))
> 		return -EIO;
>
> Since the device is unplugged, drm_dev_enter() fails, and the function returns
> -EIO. Will this permanently break system suspend for the entire system until
> reboot, since the PM core aborts system suspend if any device's .suspend
> callback returns an error?
>
> [ ... ]
Yes, this is a real regression in v1. Thanks for catching it. The chain is:

   pvr_device_lost() sets pvr_dev->lost and calls drm_dev_unplug(), which
   sets dev->unplugged (drm_drv.c);
   drm_dev_enter() then returns false;
   pvr_power_device_suspend() returns -EIO (pvr_power.c);
   pm_runtime_force_suspend() propagates it -- "if (ret) goto err;", and
   the error path is pm_runtime_enable(dev); return ret; (runtime.c);
   the PM core aborts the system suspend.

pm_runtime_force_suspend() only reaches the callback if the device is 
runtime-active, and a lost device cannot runtime-suspend either, for the 
same -EIO. As a result, it stays active and every subsequent system 
suspend fails the same way. All that can fix it at that point is a 
reboot or a rebind.

v2 wraps the force helpers and returns 0 early when the device is 
already unplugged, because at that point there's nothing left to power 
down. I test drm_dev_is_unplugged() rather than pvr_dev->lost so the 
guard matches the exact condition the -EIO comes from, therefore also 
covering an unplug arriving by any other path.

I verified v2 on my Amazon Fire HD 10 (2017) tablet, with no patch as 
the control. The same kernel, same config, same tree, with the only 
different being this patch applied and powervr.ko rebuilt and swapped (I 
have the module as =m, so no reflash was needed; vermagic identical). 
The control failed, and the v2 patch worked.

The test pins the GPU runtime-active -- the condition that fails -- then
system-suspends for 35 s and touches the GPU.

With the patch:

   runtime_status before suspend: active
   state write rc=0, uptime 606.04 -> 642.39
   runtime_status after resume: active
   vulkaninfo --summary: rc=0, deviceName = PowerVR Rogue GX6250

Without it, the same run, GPU working beforehand (rc=0, same deviceName) 
and the suspend itself succeeding (uptime 52.62 -> 87.82):

   VERDICT: FAIL -- GPU op still running after 100s
   pid 2862 state: D

and the kernel's hung-task detector produced two stacks, from two 
different ioctls, both wedged in the same place:

   pvr_power_reset+0x64/0x534 [powervr]
   pvr_mmu_flush_exec+0xec/0x18c [powervr]
   pvr_mmu_op_context_destroy+0x58/0x1ec [powervr]
   pvr_vm_bind_op_fini+0xa4/0xd0 [powervr]
   pvr_vm_unmap_obj_locked+0x1f4/0x260 [powervr]
   pvr_vm_unmap+0x5c/0x90 [powervr]
   pvr_ioctl_vm_unmap+0x50/0x80 [powervr]
   drm_ioctl_kernel+0xec/0x13c [drm]
   drm_ioctl+0x254/0x3c4 [drm]

   pvr_power_reset+0x64/0x534 [powervr]
   pvr_mmu_flush_exec+0xec/0x18c [powervr]
   pvr_submit_jobs+0x838/0xa60 [powervr]
   pvr_ioctl_submit_jobs+0x6c/0x19c [powervr]
   drm_ioctl_kernel+0xec/0x13c [drm]
   drm_ioctl+0x254/0x3c4 [drm]

That's the chain from the commit message, and it also answers your 
question about the deadlock: both stacks are under drm_ioctl, so 
pvr_power_reset() is calling drm_dev_unplug() from inside the very SRCU 
read section the ioctl holds. The box needed a reboot afterwards, and 
the reboot itself was slow because the D-state task cannot be killed.

One note on this: this is a check-then-act, and kernel workqueues are 
not frozen during dpm_suspend, so the watchdog worker could in principle 
lose the device between the test and the callback. The window is small 
and the consequence is one failed suspend rather than a permanent one, 
but it is not zero. The alternative is to stop 
pvr_power_device_suspend() reporting failure for hardware that is gone, 
which removes the race and is arguably more correct for the runtime path 
too -- but it changes existing behaviour, so I didn't fold it into this 
fix. I can do it that way instead if it's preferred, just let me know in 
v2.
> [Severity: High]
> This isn't a bug introduced by this patch, but does failing to suspend leave
> the GPU watchdog permanently disabled?
Confirmed, pvr_power_fw_disable() does 
cancel_delayed_work_sync(&watchdog.work) and then returns early if 
pvr_power_request_idle() fails, without requeueing. The only requeue is 
the queue_delayed_work() in pvr_power_fw_enable(), on the resume path, 
and the PM core doesn't call resume for a device whose suspend failed. 
So the watchdog stays cancelled and a firmware hang later on would go 
undetected.

It's pre-existing, but my patch adds a new way to reach it through 
system sleep, so I mentioned it in the v2 commit message. I can also 
send a separate patch restarting the watchdog on that error path, if 
that's wanted.

---

Everything else seems to be pre-existing and probably not worth 
addressing in my v2.

For the v2, I'm not including sarah.walker@imgtec.com and 
donald.robson@imgtec.com -- the sends to them bounced. b4 --auto-to-cc 
included them, but I'll just remove them for v2.

I'll also Cc Chen-Yu Tsai, Icenowy Zheng, and YoungJoon Lee, who are 
also working on the same GPU and are much more experienced with this 
hardware than I am :) I have an Amazon Fire HD 10 with the same GPU, but 
I believe they are working on Chromebooks.

Thanks again,
Ryan


