Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA15CCFA13
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 13:33:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBBE610E943;
	Thu, 30 Apr 2026 13:33:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AiOIQGqV";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CD2E10E943
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 13:33:05 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 09F5A4383E;
 Thu, 30 Apr 2026 13:33:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 450C9C2BCC6;
 Thu, 30 Apr 2026 13:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777555984;
 bh=TEEc8oLJYjKcuMMITS7UO74STJHuTdOmDUG2VmTvs6A=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
 b=AiOIQGqVQ4l4oWxTRan90Ike9n4hOgtjcDPziSKOa6+I1AFEnON1/tNBHTaJVufYI
 ceXvPn1UJOnJJ0C33XIFGGlUHqvYZQu0OeFXJeKFh3YCluo3EA0m9nvQQf4xDhYE/h
 B0vW9c5nBoqZ0ioh6zqt/oU+mdEXdrx+gf7YBgGHmsxPibG+WmhxbTtkIpqwFNfLix
 BU9MDEwhIEr2kfuEYKcHNfA7skdu78ivem3qEBVXAeasnot4tIiuoP/5UMoS1PFtPF
 K9I90EUFQoubLRydnMSDtHrkJdvwAa54yhbyQtIG2zHrrL/2vaQj7aTshcti5wIWV7
 4oJqZ/8LHkUWw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Apr 2026 15:32:57 +0200
Message-Id: <DI6J06W5SFMQ.9MUTIC3SBG5Z@kernel.org>
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <acourbot@nvidia.com>, <david.m.ertman@intel.com>, <ira.weiny@intel.com>,
 <leon@kernel.org>, <viresh.kumar@linaro.org>, <m.wilczynski@samsung.com>,
 <ukleinek@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <abdiel.janulgue@gmail.com>, <robin.murphy@arm.com>,
 <markus.probst@posteo.de>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 01/24] rust: driver core: drop drvdata before devres
 release
References: <20260427221155.2144848-1-dakr@kernel.org>
 <20260427221155.2144848-2-dakr@kernel.org> <afMdCU06-Y2d_LXh@google.com>
In-Reply-To: <afMdCU06-Y2d_LXh@google.com>
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

On Thu Apr 30, 2026 at 11:12 AM CEST, Alice Ryhl wrote:
> On Tue, Apr 28, 2026 at 12:10:59AM +0200, Danilo Krummrich wrote:
>> Move the post_unbind_rust callback before devres_release_all() in
>> device_unbind_cleanup().
>>=20
>> With drvdata() removed, the driver's bus device private data is only
>> accessible by the owning driver itself. It is hence safe to drop the
>> driver's bus device private data before devres actions are released.
>>=20
>> This reordering is the key enabler for Higher-Ranked Lifetime Types
>> (HRT) in Rust device drivers -- it allows driver structs to hold direct
>> references to devres-managed resources, because the bus device private
>> data (and with it all such references) is guaranteed to be dropped while
>> the underlying devres resources are still alive.
>>=20
>> Without this change, devres resources would be freed first, leaving the
>> driver's bus device private data with dangling references during its
>> destructor.
>>=20
>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>> ---
>>  drivers/base/dd.c             | 2 +-
>>  include/linux/device/driver.h | 4 ++--
>>  rust/kernel/driver.rs         | 4 ++--
>>  3 files changed, 5 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
>> index 5799a60fd058..be59d2e13a15 100644
>> --- a/drivers/base/dd.c
>> +++ b/drivers/base/dd.c
>> @@ -593,9 +593,9 @@ static DEVICE_ATTR_RW(state_synced);
>> =20
>>  static void device_unbind_cleanup(struct device *dev)
>>  {
>> -	devres_release_all(dev);
>>  	if (dev->driver->p_cb.post_unbind_rust)
>>  		dev->driver->p_cb.post_unbind_rust(dev);
>> +	devres_release_all(dev);
>>  	arch_teardown_dma_ops(dev);
>>  	kfree(dev->dma_range_map);
>>  	dev->dma_range_map =3D NULL;
>
> I seem to recall that we discussed a plan to have two classes of devres
> callbacks where device unbind proceeds as follows:
>
> 1. Run first class of devres callbacks.
> 2. Device is now considered unbound.
> 3. Run second class of devres callbacks.
>
> Is that still the plan?

Yes, it is -- I have most patches for this around and landed some devres
prerequisites last cycle.

Also note that this series already makes the situation better in this regar=
d,
since when drivers use HRT types rather than Devres, only Registration type=
s
remain to be guarded by devres.
