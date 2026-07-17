Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B36BBC4451B
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 20:11:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1337210E4D0;
	Fri, 17 Jul 2026 20:11:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.b="rDl+AgGE";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="ks9ZOEGG";
	dkim-atps=neutral
Received: from fout-b7-smtp.messagingengine.com
 (fout-b7-smtp.messagingengine.com [202.12.124.150])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CB4A10E4D0
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:11:49 +0000 (UTC)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 365231D00095;
 Fri, 17 Jul 2026 16:11:48 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
 by phl-compute-04.internal (MEProxy); Fri, 17 Jul 2026 16:11:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1784319108;
 x=1784405508; bh=ydQkNQkbLghnjQ+CoNENuXsh07pMi97RHJvnyYdLqGw=; b=
 rDl+AgGEJ6BEl+sFJ+RUza/q5rTT3vvIaDNUsrNSpKEAnRqs9VJZe1i1cg7unyo3
 Y9UWRywAainYZqu7n0j+Jppd5xCv9dQDxXrI40LuLfjjac51E62Zqv0tVav6JLs6
 rtQZLxoeW/s8MQNkc2Hd73M1+plteTARVzfJ9E0/avZGge62Gxh9aKwTh+3QRyiu
 m4r1G6zJ1P+/6vPHTqiBfxHJ9QUApK0DsK9ohi0XsS+fibq4VkypkuTt5IvhHvpk
 ty8Ov7A76o/cQd5tGtOEH/NMkXgbwEiOxisFaCQPnUbPU69XxILc77LYZp3W7ASf
 cswfaiPcp6MEIul138qvhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784319108; x=
 1784405508; bh=ydQkNQkbLghnjQ+CoNENuXsh07pMi97RHJvnyYdLqGw=; b=k
 s9ZOEGGZvdTxh3Mwc5+q8cRMcs+Ti3r7oXlBbjzHX0QP+4WlJOoLd7+9t0J2/22+
 pWnmkLuVJjOHsWJMtJ9ZdQDYFbEZNhntrZtPns1zaKqtzSTEGQg5xVpLoYxVoLdZ
 3TLdG/s+QgQBTkf21E5PsuaeI9utu3K+7J0rJ+0bz2KQ9YV/O0733jV2kSPWh/Hu
 KNuZCTxpyDZowaxznfZUfYaWRoA+amEMKxR8z1dSwfKASQSx98RBazjVxw+NafbJ
 jqv143QU+lMtWTaVYHrPoe8c+Rq+dmpivSUfOiGAH/olL6jvyYfzQT6+l5p6tipW
 vOOS8fKG+N6ZSh+gPjQpg==
X-ME-Sender: <xms:goxaalcLSKnPQXp2erAK6Qdhf5T-5X4sX4Xn1hjI6Ju7AUWNIe5Twg>
 <xme:goxaauDRn49aKnXQwjgkDhOn5amO1O4MQ7eO4RHWDodYS_RfQZj0TIiAb2ghlzqch
 ftqdg3ONU4o5hOsHlaBuC6umtKxpVDnUwgEQd0q9fRwZHQlEC7n5J4>
X-ME-Proxy-Cause: dmFkZTEkkRtwDmS2wcRL7jqjr8WYoEYc++28KP+/ApojjVqEPpfh5dNOYFyH6gCi1rBylU
 ol2y10M6UFHU48XhNtuowVb0l1+USBYJyuZq/GonjewqwGFcNUeDj67IjgCrdFdslfAMIz
 Pvz5CJDTEe9qnoKI8lYPm3iuGiJA5bwRjkBzHwRll2HpYL2flauHQvXj5ibELyz9us0S2y
 JwB93S/kYlKHuaVlQDPhuYfpGa9cgaPOnNzk4BL1lqE/GcKFTVWbeF4qoXz119FaT6NOik
 wChm+MJJlA5lR0Fb7vZbbvohgblESeVeAeTVMUK1TjaTLcUbaoI85PVFobpVFDuntXbrQd
 tyV/pB/v9T3W49cS3OguqY8g2FZ+5gm6LZDArnO9j8RwjLw4hVyRiNsXKuFVLVWyb6SDep
 1fT1QzGnTyqnuo9ta6ED5Rf2Va8nXB5BVTbbeKEyl3CDG5OpDnJ5v2nevsrT8NbQfQy3ZU
 M8WXtpePd7Fmhohf9z5ZVC/SmWkpktel2na0jYCBR+AseHKqURg1j1LWEinxHlyHYuWfDy
 17BeXrUNMslvyqoi1cGilBWiMweHiE62V5EEmzJx6AFpgSiv4LdlENhJxOc9/uC47ujZwd
 fW34Jqr44MoN824RLGYB9JOB111Y0N8z2Ts4LRQ0SbOHkeInFnaPvNQsqYPw
X-ME-Proxy: <xmx:goxaakMefkJW3F5b8XrtexWQ5SZDoZmkvAH40ASyaMqy-x7mus2Vrg>
 <xmx:goxaahe0FASVLa8REND-pFtMfzYyyZZg9nMlF7_QCY7MOp1H0fxmbQ>
 <xmx:goxaapRiu-Y77xLOE1QQfisvPkVYY55YdOQP6H-TNi-7tp6_0ASrXQ>
 <xmx:goxaavc8dN7xYPn73winWFLr-Wr4i7UXAjvNflZum3cpLulWN8pgbA>
 <xmx:hIxaaphjNDgldvzSGiNHh7Hm0A7QkjPclCExPhkJ_AhG2xodkXMyCfmF>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id B0A54182007E; Fri, 17 Jul 2026 16:11:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AVTSZ6OHPQ6F
Date: Fri, 17 Jul 2026 22:11:26 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ryan Roberts" <ryan.roberts@arm.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>, 
 "Mark Rutland" <mark.rutland@arm.com>,
 "Jean-Philippe Brucker" <jpb@kernel.org>, "Oded Gabbay" <ogabbay@kernel.org>, 
 "Jonathan Corbet" <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
Message-Id: <ec998612-c527-4294-837b-5aa375b81cc1@app.fastmail.com>
In-Reply-To: <2a69d96e-d37e-4e3d-8eaa-3ea31caf3893@arm.com>
References: <20260717104759.123203-1-ryan.roberts@arm.com>
 <20260717104759.123203-9-ryan.roberts@arm.com>
 <404d2c6d-4a18-40c2-9da9-fb030c39536f@app.fastmail.com>
 <5012970d-a0f0-461c-b0b6-61823e0aab2d@arm.com>
 <59d0c4d5-af53-410d-9bf8-8dd2ba17f697@app.fastmail.com>
 <2a69d96e-d37e-4e3d-8eaa-3ea31caf3893@arm.com>
Subject: Re: [RFC PATCH v1 8/8] misc/arm-cla: Add userspace interface
Content-Type: text/plain
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

On Fri, Jul 17, 2026, at 18:21, Ryan Roberts wrote:
> On 17/07/2026 16:31, Arnd Bergmann wrote:
>> 
>> Without concrete implementation examples, I find it hard to imagine
>> how granular the CLA and accelerator blocks are. What I'm interested
>> in is separating things into special character devices when they
>> refer to units that you want to manage separately in userspace.
>> 
>> If you have e.g. one accelerator for tensor operations and one for
>> handling gzip, I would very much want to see those have a separate
>> chardev nodes so a local administrator can give permissions to each
>> one separately, and have device names that are sensible to the
>> functionality underneath.
>
> Unfortunately this doesn't map well to the HW: the MMIO is for the
> CLA interface (each CPU has 1 CLA).

I'm sure you mentioned it in the documentation, but I missed that
there are never multiple CLA instances.

If the CLA is defined only in terms of its MMIO/DMA interface
and listening to TLB broadcast operations, is having a single
instance actually required by the design, or just an implementation
choice?

> Once you have access to that interface, you can
> communicate with all of the accelerators that are connected to the CLA. We could
> potentially use the availability masking control to only expose a single
> accelerator for a given context (which would be chosen based on which file you
> opened), but it wouldn't be possible for (e.g.) 2 different processes to access
> the different accelerators concurrently - they would have to be subject to the
> time slice model.

Right, that sounds a bit awkward. It sounds like this would also get
simpler with a model that ensures the current CLA ttbr0 matches the
CPU ttbr0 and the iotlb_mm setting, since you would never have concurrent
uses of a single CLA from multipel tasks. On the other hand, that
model would make it harder to use multiple accelerators from a
single task, if they have to go through multiple file descriptors
but could be accessed on a single mapping.

>> If you have separate accelerators for AES encryption and decryption,
>> or a large set of identical accelerators that can run concurrently,
>> those would of course get managed as a single device file.
>> 
>> Most importantly, I don't think a global /dev/cla device node
>> is a sensible interface from a management perspective as that
>> would give unprivileged userspace direct control to something
>> that is essentially arbitrary (or buggy) vendor firmware
>> with DMA permissions.
>
> OK I see your point.
>
> While the interface supports up to 8 connected accelerators, we anticpate there
> only being a single compute accelerator in practice. We decided to keep the
> driver interface generic given the CLA spec, but perhaps it would be more
> straightforward to limit the driver implementation to only permitting a single
> accelerator?

Probably, yes. From a kernel perspective, I think we're a bit better
off with an abstraction like

- One CLA MMIO range per /type/ of accelerator on a given CPU
- One firmware node per CLA, possibly spanning multiple CPUs
  if the accelerators behind them are shared.
- One character device per firmware node, named according to the
  type of CLA
- Possibly multiple CLA nodes on a given CPU if multiple
  unrelated accelerators are present
- optionally multiple related accelerators on the eight ports of
  a CLA, if that makes sense for that device type

Not sure how far that is off from what you currently have in
the hardware design.

       Arnd
