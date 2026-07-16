Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52ED0C44512
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 21:23:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD02610F3EC;
	Thu, 16 Jul 2026 21:23:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="lKUdzZY7";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5AA710F3EC
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 21:23:27 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-38e07ebd263so2749293a91.1
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 14:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1784237007; x=1784841807;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wrUaBLbbTwHv098p1q3JOceP8CDyR8hElSHBW7qR1/4=;
 b=lKUdzZY7TuPshlQlrYEw8nFCCTX/zCVCWH6FixFBwKOA5IdcXUev00NU/ua9n9PK55
 E4PAYaMiD5UX2HHtJqg/A51NmPv8sqbE+PX22qPFIFwYVPeX2D66ggJO8b+M+m01A82k
 qDaUd0lRVFgZJuamZfRGZezquaUqfFSk3h2secVK8iplv1B4Q+tSMJQA7tya4H4R72H7
 PJDQ2UARRhVHg6Z8CChw/Cg3OqZWhfIARysV0Y/KV4fWr2pQ3wLF6MD0eUvgAVLjvdPE
 wSENcSl6qBpuM/ikZpXBR5K3x8Mg7vTfI3iEmXOOh4MEsxvTTwjZ9c6oKG4g7YLV6dMD
 5vJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784237007; x=1784841807;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wrUaBLbbTwHv098p1q3JOceP8CDyR8hElSHBW7qR1/4=;
 b=XBT/QrhzwdLiyWTxBjWWExjw7oSgpEwzwQgb++IAwMrrlxk99yejBOKZ0MjrWFeirT
 oUZzw8Jkzzj17eZhdLP+9BA6wd26cMFcgzUfZ/8NJI6HPpEnlAhI3lTXBW0QSdX3JbN0
 +N/8lcbnFs+keg1GMmeBbi1SOyqUj8JpcowD6k/h/bKwQoCRPKM+EgJsk/+mNAQMqQKh
 7ILpJsBRIqOcvSdSpmrV8bsSLgfUME9a6kULaYry7QaDycdcI0lFIV2YdVYQPnbcDTOK
 nK5Lt0e7xcJBNL6pz+u+DlMyyz9qy3zq4N1wizumzlhuQXzSTzQVxl4+L7Yjv/Ud+RoG
 gg9g==
X-Forwarded-Encrypted: i=1;
 AHgh+RpU39AbtyQaiNkxMOMqJEny0T3GIkwXVj4T7QPAE5R+HBqfD2qDxSegt8exOh6nz84iAZzf1N6OHMs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwNJZ26LV3e2Ig1ikVY4S6N3+2D+w0M4E2wYcCaz5Nr5r0zAn9c
 LxKuv0cqDq5LAQcCF35RyG10zu9N9GwFgeCyvvpvAClIu/aUrzAbRfAbNaW90AzHZQ==
X-Gm-Gg: AfdE7cn9g5TAXNhyc5JFSzfRMj+cvOSQHhThA5nD7h55rALMPNrZJb+cfCr+EeA1vMn
 6GhLjnhklIlXglVEUnMkqydSjYn6dfmxUGQgEUOBDarJrqsG6Ooiso0D2Mg/jSeiOAY9bjpOP1L
 QUhO2dpFGDWF0upJcNsF28c4enwjQ/8HzeNaubHWYd2AGNOCBTNYHminz8WsQPX6Q21FPStQfGI
 k3sgSZ1HKQ10x63GDzSsV3wZKp/7dd2IjTE3XZ1eG+uXLhYsriu/z6DJxBnvEv/m4iQDClbw4Ks
 /7mkiJfeqY0YMoln0CO4CGCqZQAzgk01tYLEzQ3L0+yBMQ5FcfNaRPllpfdvwbFRpjRwWHhKnr1
 ih9yGWmxpzGXBQLBWnlZed3hE8JgQiFFloMBoS4OafwPwq33vRqvqxnCZEYmUmoeQ81NZGOyhY5
 gjOO+Cg6KNYcTfPyzEiAdx66MQ/H0D/4syoAH7PsDr
X-Received: by 2002:a17:90b:3d90:b0:38e:250b:122f with SMTP id
 98e67ed59e1d1-38e467597f3mr1142655a91.16.1784237006752; 
 Thu, 16 Jul 2026 14:23:26 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com.
 [34.168.149.56]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38e39fe37d1sm1841599a91.12.2026.07.16.14.23.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 14:23:25 -0700 (PDT)
Date: Thu, 16 Jul 2026 21:23:22 +0000
From: David Matlack <dmatlack@google.com>
To: Matt Evans <matt@ozlabs.org>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Kevin Tian <kevin.tian@intel.com>, Pranjal Shrivastava <praan@google.com>,
 Longfang Liu <liulongfang@huawei.com>, Mahmoud Adam <mngyadam@amazon.de>,
 =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 0/9] vfio/pci: Add mmap() for DMABUFs
Message-ID: <allLypOmtbnPrgbw@google.com>
References: <20260715174737.15287-1-matt@ozlabs.org>
 <CALzav=fH7N+ionUnELqw5ZaGrPmgp_w6kxoCtoY8fMmZY_S4zw@mail.gmail.com>
 <65ba06e7-4c54-437d-9fbd-632c0468f66d@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65ba06e7-4c54-437d-9fbd-632c0468f66d@ozlabs.org>
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

On 2026-07-16 03:51 PM, Matt Evans wrote:
> Hi David,
> 
> On 15/07/2026 19:12, David Matlack wrote:
> > On Wed, Jul 15, 2026 at 10:47 AM Matt Evans <matt@ozlabs.org> wrote:
> > 
> >> This is based on v7.2-rc3.
> >>
> >> These commits are on GitHub for easier browsing, along with
> >> "[RFC ONLY] selftests: vfio: Add standalone vfio_dmabuf_mmap_test":
> >>
> >> https://github.com/metamev/linux/compare/v7.2-rc3...dev/mev/vfio-dmabuf-mmap-v5
> > 
> > It'd be great to have this test upstream. I'm happy to review it when
> > you're ready. Looks like it just needs to be redone to use the VFIO
> > selftests library and kselftests harness. AI could probably do the
> > conversion pretty quick :)
> 
> For sure, I'd intended to catch up with you on best approach here. :)
> 
> Aside from the organic structure of the test (the open-coded VFIO
> device/group setup/init needs to go), the main issue is that it relies
> on a hacked/out of tree QEMU "EDU++" device with a second larger BAR
> (containing freely read-writable memory).  A subset of tests run with
> the in-tree EDU device, but coverage is too low.
> 
> The desirable properties are:
> 
>  - Having a BAR that is pure memory (all locations present, writable
> without disruptive side-effects) so that mapping aliases can be
> constructed and detected.  This is good to test things like non-zero
> vm_pgoffs and VA space presentation of physically-discontiguous DMABUFs.
> 
>  - BAR >> hugepage size so we can eyeball huge mappings work (or better,
>  mechanically test for them).  At least 32MB would tick this box for 4K,
> 16K page systems.
> 
>  - Something QEMU supports*, so one can run the test in a VM/TCG system.
> 
> There were some real device models in QEMU that could be used this way,
> but needed a fair bit of setup;  I didn't want to rathole
> vfio_dmabuf_mmap_test on including a ton of device-specific code for
> some video card or similar.
> 
> I'll dig more for a simple target that provides these properties --
> obviously it would be better to point this test at an off-the-shelf
> device (including silicon!).  And, proposing EDU extensions to the QEMU
> folks may be useful (there're uses for a better EDU in other contexts too).
> 
> Since this test uses MMIO for a specific [class of] function, my first
> thought is it should be another VFIO driver-type test sibling of
> vfio_pci_driver_test.  For example, we could extend the driver-type
> tests' backend struct vfio_pci_driver_ops for functions capable of
> providing a Big Memory BAR, like QEMU EDU++.  EDU can also memcpy, so
> could also support vfio_pci_driver_test.
> 
> The spirit of the device backends hiding setup of a complex device is
> handy, and it's plausible that several backends could provide this "big
> memory BAR" service.  What do you think, any concerns with extending
> vfio_pci_driver_ops like that?

I wouldn't recommend leveraging the driver framework unless absolutely
necessary. It makes the test harder to run.

The biggest issue I see with the proposed properties is being able to
treat the BAR as memory. That obviously will depend on the device and
may require device-specific setup. If we decide that treating the BAR as
memory is truly required then using the driver framework is the way to
go. But I'm hoping we can avoid that requirement.

Instead, I think you can get pretty far by inspecting /proc/pid/pagemap
to determine if the mmap() set things up correctly, without actually
accessing the BAR. You can use /proc/pid/pagemap to look up the PFN and
PAGEMAP_SCAN to detect huge pages.

With that requirement gone, then all you really need is a device with a
large enough BAR. And even that it not a hard requirement. I'm sure
there are plenty of test cases that could work with smaller BARs. The
few tests that want to exercise huge mappings can inspect the device BAR
sizes first, and if they're all too small, SKIP() the test.

If you structure the test this way, then it's easy for the test to be
used. It can be run against any device for the basic functional
coverage, and can be run against a device with a larger BAR for full
coverage of huge mappings.

Does QEMU emulate any devices that have 32MB or larger BARs?
