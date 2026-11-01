Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF51606A325
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 15:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=furiosa.ai header.i=@furiosa.ai header.a=rsa-sha256 header.s=google header.b=FoXEW/d5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2A6610E41C;
	Sun,  1 Nov 2026 15:15:41 +0000 (UTC)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4655B10E41C
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 15:15:36 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-353804b591eso3878561eec.0
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 07:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=furiosa.ai; s=google; t=1793546135; x=1794150935; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=utqb4frQ+ZA9/jToYadcpGuhd2odxNlrVG2GVdoU/3k=;
 b=FoXEW/d5TV1XituDNgrGxJsiUX8dq6nV7xv3G5sX+u3ZIV0i5FOCv0eeeqx9i25xxi
 EbImW2KJ8kk+Ng4F9AZbwaXi6TAqtPxDGbJ75op8psNjupGbeF6KOKuuhjQ2a2RFRMT7
 P52Gh0jxA1WmfJ3a1EBzs6Y7Cmota0JHdE/2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793546135; x=1794150935;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=utqb4frQ+ZA9/jToYadcpGuhd2odxNlrVG2GVdoU/3k=;
 b=RA7bkfWeSuLUJcWDCxej9Mh5JRpC9afXep/AhPdtLzbuNOyLMY01LIAPdKFzZ8QvPl
 ZCzuGNK0Eme9BdyP1FOrx9NYYGNzmyuWExOMvrpzCgtzzmAe/vfAbYw7YLWKRSM+fRTS
 sNRh1lrTG/3liQ3rwwL6TDyjt6WdjXDYlsjg/R2rfkWVBTRTFVS1UrlTM/pxT7h8Wc6H
 Dwvi2mktIvLcuUGKG/t/klfrosiBfKPrOZBDwG8OIQpCLwZ8l6+scxqhlwT0eH4/dRlf
 wUzCTXYqTfdXBqhoH7o7lumJL5UiVQ415AxxIjnQchEyAtY3CaT7iBvZt9TPYOe2CqZP
 jowg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxgR5mWM1MqtqL+PKJ6syCZc2HaSyW2pOZiI1vFxTpRFLU70/f0NI8UWvjxt/kWl6ysC2Voiss5fPA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8c6EVydrW1LQ0yPMGLB6qiThsJxGxK0GD0uBKgrlwlqRmuvEMx
 y4XK2KOJc78zkpttutm+TzkzP0JxdtSPBpoddjiqWBDzSh+PO7WWpyCt6xTpD8hEerk=
X-Gm-Gg: AYBFou3B1q+QorLIR7o4hL2yK8zCpWqtADH67g7UQeg82l9g9BhpzW208ZwWlwSlqWy
 WK6xOvBNT1hjpjdbrNLd2oEwFm3LxjoL9dNWbztHP87ZaP+LqHkBQfDg3DnGqLQEZYs9fMBrTqW
 df46EQgNWSafCVynAKkVEgjTqQC7fv3qpY1pv5snUc5Wzm6XJww0z6KU8y2yPQe54J4CichejbL
 Sk434LKpKdCqFRqXs8STYo83ZixyHgM5zYVtRsRD1PWxgEvzszhkG2EC5VWAuM2Z7NfY99KDWJS
 HY9zENbiEG9M6RQailtk0VlKAVAkT4gS6lSN/ZkHgdWYvcT5tF7X7vMgLQ+fqg1mzQIEO6ecgMk
 cud3+oNeoe0M9yO2HTEhWl0QjjBtwM26odwOB4MRPnM4bdcz7r0dB8Bxzy56EaVxwYGk2fvcAng
 3yaAaCaan1fsX9l1P0/k05cpz+8wYSXg8VOwU6NvmQXnSEMaZOkGpoe1LPdeNq2zB/70tYygaQs
 ZlZxIpr6ZIVU89qjrpbXSjJf25MRomxsHBWMz/3DGqVW6R5X6VklKez4t5ci3leITfKe+ndd/iz
 ZGWKvw3yhJRweUBiG24GprxKijoWaA==
X-Received: by 2002:a05:7301:d594:b0:36a:16b1:3f25 with SMTP id
 5a478bee46e88-36a42225ab2mr11543085eec.5.1793546135084; 
 Sun, 01 Nov 2026 07:15:35 -0800 (PST)
Received: from rock-5b-plus ([61.83.209.48]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a428af1dfsm29688302eec.7.2026.11.01.07.15.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 07:15:34 -0800 (PST)
Date: Mon, 2 Nov 2026 00:15:02 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Gyeyoung Baek <gye976@gmail.com>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] accel/rocket: Report per-core engine usage through fdinfo
Message-ID: <audXArQ4P3Zz48E0@rock-5b-plus>
References: <20261031083642.1076356-1-sidong.yang@furiosa.ai>
 <CAKbEznsRK68w=qimTHifgDhD_Roi4eg2NrBYu+r6foYRZv1ePw@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKbEznsRK68w=qimTHifgDhD_Roi4eg2NrBYu+r6foYRZv1ePw@mail.gmail.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 01, 2026 at 08:55:15PM +0900, Gyeyoung Baek wrote:
> Hi Sidong,
> 
> > If userspace (for example systemd-udevd reacting to the drm_dev_register()
> > uevent, or a client opening the device while remaining cores are still probing
> > or deferred) calls rocket_open() before all cores have finished probing,
> > rocket_priv->engine_usage is allocated with the smaller rdev->num_cores count
> > at that moment. Once the remaining cores finish probing and increment
> > rdev->num_cores, calling rocket_show_fdinfo() will iterate up to the new
> > rdev->num_cores and read past the end of elapsed_ns[].
> >
> > Similarly, if a lower-indexed core is unbound via rocket_remove(),
> > rdev->num_cores is decremented while higher-indexed cores retain their
> > original core->index. If a file is opened afterwards, rocket_job_handle_irq()
> > indexing engine_usage->elapsed_ns[core->index] can also write out of bounds:
> >
> 
> I reproduced the OOB access sashiko reported.
> I used `driver_override` to keep core1 and core2 from
> binding, so only core0 had been probed when the file was opened:
> 
>   BUG: KASAN: slab-out-of-bounds in rocket_show_fdinfo+0xac/0x120 [rocket]
>   Read of size 8 at addr ffff00000242b230 by task grep/461
> 
>   Hardware name: Radxa ROCK 5B (DT)
>   Call trace:
>    rocket_show_fdinfo+0xac/0x120 [rocket]
>    drm_show_fdinfo+0x218/0x2a8 [drm]
>    seq_show+0x340/0x648
>    seq_read_iter+0x318/0x9d8
>    vfs_read+0x220/0x6a8
>    ksys_read+0x108/0x1f8
>    ...
> 
>   Allocated by task 444 on cpu 5 at 79.841431s:
>    __kmalloc_noprof+0x2d0/0x740
>    rocket_open+0xb4/0x468 [rocket]
>    drm_file_alloc+0x37c/0x568 [drm]
>    drm_open_helper+0x110/0x2a8 [drm]
>    accel_open+0xc4/0x1c0 [drm]
>    ...
> 
> > drivers/accel/rocket/rocket_job.c:rocket_job_handle_irq() {
> >         ...
> >         core->in_flight_job->engine_usage->elapsed_ns[core->index] +=
> >                 local_clock() - core->in_flight_job->start_ns;
> >         ...
> > }
> >
> > Would it make sense to record the total core count allocated for rdev->cores
> > in rocket_device_init() (or store the allocated array length in struct
> > rocket_engine_usage) so that the allocation size and bounds stay consistent?
> >
> 
> `num_cores` is used with two different meanings:
> 
>   1. in rocket_device_init(): the number of core nodes in the DT
>          (the size of the cores[] allocation)
>   2. rdev->num_cores: the number of cores currently bound
> 
> This patch uses (2) where (1) is needed. How about storing (1) in a
> new member (e.g. max_cores), as sashiko suggested, and using it instead?

Hi Gyeyoung,

Thanks for reproducing it. You're right.
I'll send v2 with max_cores as you suggested.

Thanks,
Sidong
> 
> > --
> > Sashiko AI review · https://sashiko.dev/#/patchset/20261031083642.1076356-1-sidong.yang@furiosa.ai?part=1
> 
> 
> --
> Thanks,
> Gyeyoung
