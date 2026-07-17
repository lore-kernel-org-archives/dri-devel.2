Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D55C44507
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 08:16:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E56610F49C;
	Fri, 17 Jul 2026 08:16:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=robert.mader@collabora.com header.b="ZsbQbkqz";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 868CD10E41B
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 08:16:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784276166; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=PIaRY8ubCxSv0iDfIycmt8wjreEJiHgte2I4K52IPJdnz3b/RDGRrM6ZAlI9i7iQlOSGD4wf8dW2ivTabBnFN5/+NCZGvL80lMydaJK6W+MByfa1HEj1h3x9AjOKZt3SUOysmgAh7deHto8ZN2gdHoFuFXTgW87eOcvt87dIdUY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784276166;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=e3oJ3jdm+nlTTG3I/x+1zIRh7bKi5GZTn6Y7tlxzkA8=; 
 b=YxdhiBPMXBC8LXBmuNeFr64azwKIpoekyAdr/HNOvA650G/Q8wJNEX0svjw1awdGTxZyGJ7L1pFY21k5WScHlFLTvnbwYI84i2IQfg5hjsmi/GaPyn1s/PHPBoZzLrJOOLYsdc8f8fIu66784ao8paqJXwT4VofMS7aPD8MUKgg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=robert.mader@collabora.com;
 dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784276166; 
 s=zohomail; d=collabora.com; i=robert.mader@collabora.com;
 h=Content-Type:Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Message-Id:Reply-To;
 bh=e3oJ3jdm+nlTTG3I/x+1zIRh7bKi5GZTn6Y7tlxzkA8=;
 b=ZsbQbkqztwBxMJtnPRZCMf6L1fQjTcrActc8fF5nQNMR1wM22ebSqDAlLB4RM8CY
 D7045huy4clV4z10lvr6KAJu1k5mSe3NEHbn7Ld/ucPOpJA4IsRuls6r5KGVtE8BNBs
 J9FJW6pWNrbssKyD1oHpHwDdRCE+soK2hanSH3oc=
Received: by mx.zohomail.com with SMTPS id 1784276163778920.7412459150789;
 Fri, 17 Jul 2026 01:16:03 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------NNEVTK8Mjn9mKIhZAP2IoQNv"
Message-ID: <6866c0ea-4f3a-4b13-bfdd-90610b7c5530@collabora.com>
Date: Fri, 17 Jul 2026 10:15:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] dma-buf/udmabuf: Introduce
 CONFIG_UDMABUF_SIZE_LIMIT_MBYTES
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260711144814.8205-1-robert.mader@collabora.com>
 <6764ca6f-b4d8-4baa-9d27-2ca867ac2d41@amd.com>
 <8b0d0180-09ef-42c7-b111-db51d5ddacca@collabora.com>
 <IA0PR11MB71855A08C318B962E0FDB1EBF8F92@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Language: en-US, de-DE
From: Robert Mader <robert.mader@collabora.com>
In-Reply-To: <IA0PR11MB71855A08C318B962E0FDB1EBF8F92@IA0PR11MB7185.namprd11.prod.outlook.com>
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

This is a multi-part message in MIME format.
--------------NNEVTK8Mjn9mKIhZAP2IoQNv
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Vivek,

On 14.07.26 08:42, Kasireddy, Vivek wrote:
> Hi Robert,
>
>> Subject: Re: [RFC PATCH 1/2] dma-buf/udmabuf: Introduce
>> CONFIG_UDMABUF_SIZE_LIMIT_MBYTES
>>
>> Hi,
>>
>> On 13.07.26 11:12, Christian König wrote:
>>> On 7/11/26 16:48, Robert Mader wrote:
>>>> As udmabuf increasingly enjoys popularity - being used in projects
>> like
>>>> libcamera, Gstreamer, Mesa and KWin - users more frequently
>> encounter
>>>> cases where the current default size limit of 64MB is too low.
>> Examples
>>>> include allocating video buffers at a 8K resolution - and even 4K is
>>>> affected when using non-subsampled video formats or high bit
>> depths.
>>>> While the limit can already be changed via the kernel command line,
>>>> exposing it as a kernel config makes that easier and more
>> discoverable
>>>> for distros. Thus let's do that.
>>> Well config options are usually only useful if the value can't be
>> changed on runtime through a module parameter, but that is clearly
>> not the case here.
>>> On the other hand I do see your problem. I would just vote to disable
>> the limit by default, there is nothing preventing userspace from
>> allocating multiple uDMA-bufs so it doesn't seem to prevent any
>> security issue or similar.
>>
>> I fully agree and would prefer that as well. If there is no resistance /
>> concerns from anybody I'll send a corresponding patch at the end of the
>> week.
> AFAIU, the main motivation behind the limits was to ensure that there are
> some kind of guardrails. I am not opposed to their removal but I think it
> would now allow users to pin large arbitrary amounts of memory and I
> feel like there needs to be a way to prevent users from doing that.
>
> Early RFC versions of udmabuf had mlock accounting to address this issue
> but not sure why it was dropped eventually. I am wondering if it makes
> sense to bring that back.

while the point about pinned memory accounting sounds reasonable to me, 
I don't think that removing the limit for individual uDMA-bufs would 
change anything about the current situation. As Christian already 
pointed out there's nothing preventing clients to allocate multiple 
uDMA-bufs atm. In fact I believe that the scenario you describe 
currently is more likely to be caused by clients allocating (and e.g. 
leaking) many small uDMA-bufs.

There are, however, some other existing guardrails that may somewhat 
help already:

 1. systemd limits udmabuf access to uaccess - i.e. local seats /
    graphical users (https://github.com/systemd/systemd/pull/33738)
 2. at least the Flatpak sandbox binds udmabuf access to DRI device
    access as the later is considered "more powerful"
    (https://github.com/flatpak/flatpak/pull/6158)

I'll therefor go forward and a propose a patch to remove the individual 
limit, assuming the discussion about mlock (or some kind of more global) 
accounting can be continued independently.

Thanks,

Robert

>
> Thanks,
> Vivek
>
>> Thanks,
>>
>> Robert
>>
>>> Regards,
>>> Christian.
>>>
>>>
>>>> Signed-off-by: Robert Mader<robert.mader@collabora.com>
>>>> ---
>>>>    drivers/dma-buf/Kconfig   | 6 ++++++
>>>>    drivers/dma-buf/udmabuf.c | 4 ++++
>>>>    2 files changed, 10 insertions(+)
>>>>
>>>> diff --git a/drivers/dma-buf/Kconfig b/drivers/dma-buf/Kconfig
>>>> index 7efc0f0d0712..35f0779cdc80 100644
>>>> --- a/drivers/dma-buf/Kconfig
>>>> +++ b/drivers/dma-buf/Kconfig
>>>> @@ -40,6 +40,12 @@ config UDMABUF
>>>>             A driver to let userspace turn memfd regions into dma-bufs.
>>>>             Qemu can use this to create host dmabufs for guest
>> framebuffers.
>>>> +config UDMABUF_SIZE_LIMIT_MBYTES
>>>> +       int "Size limit in Mega Bytes"
>>>> +       default 64
>>>> +       help
>>>> +         Maximum size of a udmabuf, in megabytes. Default is 64.
>>>> +
>>>>    config DMABUF_DEBUG
>>>>           bool "DMA-BUF debug checks"
>>>>           depends on DMA_SHARED_BUFFER
>>>> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
>>>> index bced421c0d65..a83153326362 100644
>>>> --- a/drivers/dma-buf/udmabuf.c
>>>> +++ b/drivers/dma-buf/udmabuf.c
>>>> @@ -20,7 +20,11 @@ static int list_limit = 1024;
>>>>    module_param(list_limit, int, 0644);
>>>>    MODULE_PARM_DESC(list_limit, "udmabuf_create_list->count limit.
>> Default is 1024.");
>>>> +#ifdef CONFIG_UDMABUF_SIZE_LIMIT_MBYTES
>>>> +static int size_limit_mb = CONFIG_UDMABUF_SIZE_LIMIT_MBYTES;
>>>> +#else
>>>>    static int size_limit_mb = 64;
>>>> +#endif
>>>>    module_param(size_limit_mb, int, 0644);
>>>>    MODULE_PARM_DESC(size_limit_mb, "Max size of a dmabuf, in
>> megabytes. Default is 64.");
>>>> --
>>>> 2.55.0
>>>>
-- 
Robert Mader
Consultant Software Developer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

--------------NNEVTK8Mjn9mKIhZAP2IoQNv
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi Vivek,</p>
    <div class="moz-cite-prefix">On 14.07.26 08:42, Kasireddy, Vivek
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:IA0PR11MB71855A08C318B962E0FDB1EBF8F92@IA0PR11MB7185.namprd11.prod.outlook.com">
      <pre wrap="" class="moz-quote-pre">Hi Robert,

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Subject: Re: [RFC PATCH 1/2] dma-buf/udmabuf: Introduce
CONFIG_UDMABUF_SIZE_LIMIT_MBYTES

Hi,

On 13.07.26 11:12, Christian König wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">On 7/11/26 16:48, Robert Mader wrote:
</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">As udmabuf increasingly enjoys popularity - being used in projects
</pre>
          </blockquote>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">like
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">libcamera, Gstreamer, Mesa and KWin - users more frequently
</pre>
          </blockquote>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">encounter
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">cases where the current default size limit of 64MB is too low.
</pre>
          </blockquote>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">Examples
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">include allocating video buffers at a 8K resolution - and even 4K is
affected when using non-subsampled video formats or high bit
</pre>
          </blockquote>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">depths.
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">
While the limit can already be changed via the kernel command line,
exposing it as a kernel config makes that easier and more
</pre>
          </blockquote>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">discoverable
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">for distros. Thus let's do that.
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">Well config options are usually only useful if the value can't be
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">changed on runtime through a module parameter, but that is clearly
not the case here.
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">
On the other hand I do see your problem. I would just vote to disable
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">the limit by default, there is nothing preventing userspace from
allocating multiple uDMA-bufs so it doesn't seem to prevent any
security issue or similar.

I fully agree and would prefer that as well. If there is no resistance /
concerns from anybody I'll send a corresponding patch at the end of the
week.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">AFAIU, the main motivation behind the limits was to ensure that there are
some kind of guardrails. I am not opposed to their removal but I think it
would now allow users to pin large arbitrary amounts of memory and I
feel like there needs to be a way to prevent users from doing that.

Early RFC versions of udmabuf had mlock accounting to address this issue
but not sure why it was dropped eventually. I am wondering if it makes
sense to bring that back.</pre>
    </blockquote>
    <p>while the point about pinned memory accounting sounds reasonable
      to me, I don't think that removing the limit for individual
      uDMA-bufs would change anything about the current situation. As
      Christian already pointed out there's nothing preventing clients
      to allocate multiple uDMA-bufs atm. In fact I believe that the
      scenario you describe currently is more likely to be caused by
      clients allocating (and e.g. leaking) many small uDMA-bufs.</p>
    <p>There are, however, some other existing guardrails that may
      somewhat help already:</p>
    <ol>
      <li>systemd limits udmabuf access to uaccess - i.e. local seats /
        graphical users (<a class="moz-txt-link-freetext" href="https://github.com/systemd/systemd/pull/33738">https://github.com/systemd/systemd/pull/33738</a>)</li>
      <li>at least the Flatpak sandbox binds udmabuf access to DRI
        device access as the later is considered "more powerful"
        (<a class="moz-txt-link-freetext" href="https://github.com/flatpak/flatpak/pull/6158">https://github.com/flatpak/flatpak/pull/6158</a>)</li>
    </ol>
    <p>I'll therefor go forward and a propose a patch to remove the
      individual limit, assuming the discussion about mlock (or some
      kind of more global) accounting can be continued independently.</p>
    <p>Thanks,</p>
    <p>Robert</p>
    <blockquote type="cite"
cite="mid:IA0PR11MB71855A08C318B962E0FDB1EBF8F92@IA0PR11MB7185.namprd11.prod.outlook.com">
      <pre wrap="" class="moz-quote-pre">

Thanks,
Vivek

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Thanks,

Robert

</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">
Regards,
Christian.


</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">Signed-off-by: Robert Mader <a class="moz-txt-link-rfc2396E" href="mailto:robert.mader@collabora.com">&lt;robert.mader@collabora.com&gt;</a>
---
  drivers/dma-buf/Kconfig   | 6 ++++++
  drivers/dma-buf/udmabuf.c | 4 ++++
  2 files changed, 10 insertions(+)

diff --git a/drivers/dma-buf/Kconfig b/drivers/dma-buf/Kconfig
index 7efc0f0d0712..35f0779cdc80 100644
--- a/drivers/dma-buf/Kconfig
+++ b/drivers/dma-buf/Kconfig
@@ -40,6 +40,12 @@ config UDMABUF
           A driver to let userspace turn memfd regions into dma-bufs.
           Qemu can use this to create host dmabufs for guest
</pre>
          </blockquote>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">framebuffers.
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">
+config UDMABUF_SIZE_LIMIT_MBYTES
+       int "Size limit in Mega Bytes"
+       default 64
+       help
+         Maximum size of a udmabuf, in megabytes. Default is 64.
+
  config DMABUF_DEBUG
         bool "DMA-BUF debug checks"
         depends on DMA_SHARED_BUFFER
diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index bced421c0d65..a83153326362 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -20,7 +20,11 @@ static int list_limit = 1024;
  module_param(list_limit, int, 0644);
  MODULE_PARM_DESC(list_limit, "udmabuf_create_list-&gt;count limit.
</pre>
          </blockquote>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">Default is 1024.");
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">
+#ifdef CONFIG_UDMABUF_SIZE_LIMIT_MBYTES
+static int size_limit_mb = CONFIG_UDMABUF_SIZE_LIMIT_MBYTES;
+#else
  static int size_limit_mb = 64;
+#endif
  module_param(size_limit_mb, int, 0644);
  MODULE_PARM_DESC(size_limit_mb, "Max size of a dmabuf, in
</pre>
          </blockquote>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">megabytes. Default is 64.");
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">
--
2.55.0

</pre>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
    <pre class="moz-signature" cols="72">-- 
Robert Mader
Consultant Software Developer 

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England &amp; Wales, no. 5513718</pre>
  </body>
</html>

--------------NNEVTK8Mjn9mKIhZAP2IoQNv--
