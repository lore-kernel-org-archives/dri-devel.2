Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA43CD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 17:23:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E155910E3C7;
	Tue, 19 May 2026 17:23:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="sDT56KRN";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D55B10E3C7
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 17:23:14 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5ABC540055;
 Tue, 19 May 2026 17:23:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347C6C2BCB3;
 Tue, 19 May 2026 17:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779211394;
 bh=4KWjZtWi5QWKT9x+Q+usG1SRhIzTYH6QGJOGse+O6c8=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
 b=sDT56KRNtEdXJk9FSMTUdKrZFWxTEGkiEE9DbCyL0Ideya3WopsxmqvIw5N69/jMh
 S0uczmZhCjalS2HgRjS8oH3yeHg2FzXqE6Whnv8OwvS5vxKtXPGzrUHVUawlW5wl4x
 He2xP+0K6ejnq/Kny8h8FHIlPjvieEqDBucD/1Co831Bq8roFrKbnorB5i9E+GkjDP
 ug8HhWomIYkYOrCc2FgLslGu5eJdWSIU4bvB8OAeCQU/mCce55tZeR7575GMiSKDru
 SMGOvqzSnIqo1Q8IOZE9ZHYOrwjeuHECOrdNx7ZLepNZw2q9IcqDjs2wQ21W0hh9B0
 ws3f/U1RFm1FQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 19:23:05 +0200
Message-Id: <DIMTSQS1HZM9.326ZOXFP6PV5J@kernel.org>
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <acourbot@nvidia.com>, <aliceryhl@google.com>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <viresh.kumar@linaro.org>,
 <m.wilczynski@samsung.com>, <ukleinek@kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <abdiel.janulgue@gmail.com>,
 <robin.murphy@arm.com>, <markus.probst@posteo.de>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <igor.korotin@linux.dev>,
 <daniel.almeida@collabora.com>, <pcolberg@redhat.com>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 22/27] rust: driver-core: rename 'a lifetime to 'bound
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-23-dakr@kernel.org>
 <DIMT8FK3A307.11FI5MGH9K1OX@garyguo.net>
In-Reply-To: <DIMT8FK3A307.11FI5MGH9K1OX@garyguo.net>
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

On Tue May 19, 2026 at 6:56 PM CEST, Gary Guo wrote:
> On Sun May 17, 2026 at 1:01 AM BST, Danilo Krummrich wrote:
>> -    pub fn access<'a>(&'a self, dev: &'a Device<Bound>) -> Result<&'a T=
> {
>> +    pub fn access<'bound>(&'bound self, dev: &'bound Device<Bound>) -> =
Result<&'bound T> {
>>          if self.dev.as_raw() !=3D dev.as_raw() {
>>              return Err(EINVAL);
>>          }
>
> For the same reason that I outlined in the other email, I think this shou=
ld keep
> the generic `'a` name as this is not the actual lifetime of `'bound`, jus=
t a
> shortened one.

I think it depends on how you want to read it, i.e. do we consider 'bound t=
o be:

  - the lifetime for the full duration of a device bound to a driver, or
  - some lifetime that guarantees that the device remains bound for (which =
can
    also be shorter).

For this and the other cases you commented on I obviously applied the secon=
d
interpretation.

That said, I think for consistency and ambiguity reasons it does make sense=
 to
reserve the term 'bound for the first one exclusively, and also clearly doc=
ument
that.
