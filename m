Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D60C624D3
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 13:11:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD03010E02B;
	Wed,  2 Sep 2026 13:11:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="DTLK87aa";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3568410E02B;
 Wed,  2 Sep 2026 13:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=puCIZjnZTjW96I5EmmpKeyexrfJQn/Ok5t95x1TDsnc=; b=DTLK87aaGoLSdoyc4ZkUpZbjYJ
 2BlX8uTf/f45jwIQ0lgvxaFPFX8kf6kIgwxNflznqoJgYATnq4MbGhdaqFvd/kFN+qjTOMTgzRX3y
 T8Gw92Wl1Lx+g6Rx8rOeUHnHIS8PrNrXMlH0R4dMBYU3trakg03vOKTqz7AEVsfKnnydAPs9D8R3P
 uubkGuH3aon0UaTQKn/6Pd7brvkdd6EP2+/hgLus49pVzvgIBqhNPsEFSUCcHv/T+D6qyyU9K//lk
 aXDFi3qNROloOm+nso6pSna4cwNQBhb2MkZyxsW6vHywweyEQq+co8XnWUi5Ho9FffxNC5OFnQdqD
 ShcgjI4g==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1x1kji-00DZsB-MZ; Wed, 02 Sep 2026 15:10:42 +0200
Message-ID: <853d1470-a980-48fb-a7a9-34b01b6be5b0@igalia.com>
Date: Wed, 2 Sep 2026 14:10:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/qxl: fix use-after-free and NULL pointer deref
To: Jiri Slaby <jirislaby@kernel.org>, devel@lists.crash-utility.osci.io
Cc: Gemini <gemini@google.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Dave Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 stable@vger.kernel.org, virtualization@lists.linux.dev,
 spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260828085136.128561-1-jirislaby@kernel.org>
 <3c2a131b-af05-4aef-bf5f-4742ceab2170@igalia.com>
 <cf08d7f1-8853-42a2-9226-17721c4b30f4@kernel.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <cf08d7f1-8853-42a2-9226-17721c4b30f4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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


On 02/09/2026 11:45, Jiri Slaby wrote:
> On 02. 09. 26, 11:53, Tvrtko Ursulin wrote:
>>
>> On 28/08/2026 09:51, Jiri Slaby (SUSE) wrote:
>>> When allocating a `qxl_release` structure with `kmalloc()`, the 
>>> underlying
>>> memory contained uninitialized garbage. Specifically, `release- 
>>> >base.flags`
>>> (part of the embedded `dma_fence`) was not cleared.
>>>
>>> This garbage in `base.flags` caused helper functions such as
>>> `dma_fence_was_initialized()` to return true even for releases where the
>>> fence was never actually initialized (e.g. via `dma_fence_init()`).
>>>
>>> Consequently, during release cleanup in `qxl_release_free()`, the driver
>>> attempted to put/free an uninitialized `dma_fence`, leading to refcount
>>> underflows (`refcount_t: underflow; use-after-free`) and subsequent NULL
>>> pointer dereferences in `dma_fence_signal_timestamp_locked()`.
>>>
>>> Fix this by switching from `kmalloc()` to `kzalloc_obj()` in
>>> `qxl_release_alloc()`, ensuring all fields (including embedded fence
>>> flags) are properly zero-initialized upon allocation, and remove
>>> redundant explicit zero-initializations.
>>>
>>> The dumps in question:
>>>   refcount_t: underflow; use-after-free.
>>>   WARNING: lib/refcount.c:28 at refcount_warn_saturate+0x59/0x90, 
>>> CPU#0: kworker/0:0/1534
>>>   Modules linked in: af_packet nft_fib_inet ...
>>>   CPU: 0 UID: 0 PID: 1534 Comm: kworker/0:0 Not tainted 7.1.3-1- 
>>> default #1 PREEMPT(full) openSUSE Tumbleweed 
>>> b041a6527f6e58424f4cd3de0fade8d408b378fd
>>>   ...
>>>   RIP: 0010:refcount_warn_saturate+0x59/0x90
>>>   ...
>>>   Call Trace:
>>>    <TASK>
>>>    qxl_release_free+0xee/0xf0 [qxl 
>>> d93e9381353e619799d56790f5f8dda6cce491f6]
>>>    qxl_garbage_collect+0xd1/0x1b0 [qxl 
>>> d93e9381353e619799d56790f5f8dda6cce491f6]
>>>    process_one_work+0x19e/0x3a0
>>>   ...
>>>
>>> And then of course:
>>>   BUG: kernel NULL pointer dereference, address: 0000000000000028
>>>   ...
>>>   RIP: 0010:dma_fence_signal_timestamp_locked+0x32/0x120
>>>
>>> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
>>> Assisted-by: Gemini <gemini@google.com> # only commit log
>>> Fixes: 2bcbc706dfa0 ("dma-buf: add dma_fence_was_initialized function 
>>> v2")
>>> Closes: https://bugzilla.suse.com/show_bug.cgi?id=1271081
>>> Cc: Christian König <christian.koenig@amd.com>
>>> Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>> Cc: Dave Airlie <airlied@redhat.com>
>>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>>> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>>> Cc: Maxime Ripard <mripard@kernel.org>
>>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>>> Cc: David Airlie <airlied@gmail.com>
>>> Cc: Simona Vetter <simona@ffwll.ch>
>>> Cc: stable@vger.kernel.org
>>> ---
>>> Cc: virtualization@lists.linux.dev
>>> Cc: spice-devel@lists.freedesktop.org
>>> Cc: dri-devel@lists.freedesktop.org
>>>
>>> [v2] use kzalloc_obj() instead of bare kzalloc()
>>> ---
>>>   drivers/gpu/drm/qxl/qxl_release.c | 6 +-----
>>>   1 file changed, 1 insertion(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/ 
>>> qxl_release.c
>>> index 06979d0e8a9f..07dc6eafe6f7 100644
>>> --- a/drivers/gpu/drm/qxl/qxl_release.c
>>> +++ b/drivers/gpu/drm/qxl/qxl_release.c
>>> @@ -89,17 +89,13 @@ qxl_release_alloc(struct qxl_device *qdev, int type,
>>>   {
>>>       struct qxl_release *release;
>>>       int handle;
>>> -    size_t size = sizeof(*release);
>>> -    release = kmalloc(size, GFP_KERNEL);
>>> +    release = kzalloc_obj(*release);
>>>       if (!release) {
>>>           DRM_ERROR("Out of memory\n");
>>>           return -ENOMEM;
>>>       }
>>> -    release->base.ops = NULL;
>>>       release->type = type;
>>> -    release->release_offset = 0;
>>> -    release->surface_release_id = 0;
>>>       INIT_LIST_HEAD(&release->bos);
>>>       idr_preload(GFP_KERNEL);
>>
>> Looks plausible on a superficial look, albeit fragile. I am not sure 
>> why qxl_release_alloc wasn't calling dma_fence_init in the first place?
> 
> If you did, you could not test the ops (previously) or 
> dma_fence_was_initialized() now, right?

Right, but on a superficial look what would be lost if that wasn't done, ie:

diff --git a/drivers/gpu/drm/qxl/qxl_release.c 
b/drivers/gpu/drm/qxl/qxl_release.c
index 06979d0e8a9f..ea1e0b4f6e5b 100644
--- a/drivers/gpu/drm/qxl/qxl_release.c
+++ b/drivers/gpu/drm/qxl/qxl_release.c
@@ -147,16 +147,11 @@ qxl_release_free(struct qxl_device *qdev,
         idr_remove(&qdev->release_idr, release->id);
         spin_unlock(&qdev->release_idr_lock);

-       if (dma_fence_was_initialized(&release->base)) {
-               WARN_ON(list_empty(&release->bos));
-               qxl_release_free_list(release);
+       qxl_release_free_list(release);
+
+       dma_fence_signal(&release->base);
+       dma_fence_put(&release->base);

-               dma_fence_signal(&release->base);
-               dma_fence_put(&release->base);
-       } else {
-               qxl_release_free_list(release);
-               kfree(release);
-       }
         atomic_dec(&qdev->release_count);
  }


WARN_ON is lost but on balance how much does that matter? Or could it be 
moved somewhere else?

I don't know this driver to be clear but was just curious to understand 
if there is an alternative. As said, the patch as is looks okay to me 
looking from the outside.

Regards,

Tvrtko

